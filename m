Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D984791B9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbhLQQno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239253AbhLQQnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:43:39 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D68C06173E;
        Fri, 17 Dec 2021 08:43:38 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y22so10129032edq.2;
        Fri, 17 Dec 2021 08:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ytXs+tjsOQIVzwgdEv3Dia185hW2en+OLpnkYRjyU0M=;
        b=ou3+y3aMEhFeF6aGARhleFB3qGDZHLczLPHI+FAg8bmMgVzSrMOXbTP9T6vgBhIMIt
         O1iObjxLcinoq/j+MjZBnkzNgJHL0yc3eBEDA9cRxpeKbOxLQic7SJ8jLlJt3gNbo4Xf
         k5xtz4GmlLUZDzn+fBv3vZQ37WGXUJZ/wVHke6Qk0/kz0eWThz+PGMhC+lVd/baD/3Wl
         JXgeUD9I6qgBWc2csD4EQmu08YJu/iz2oWh1cOfjti2dFXj7zvcSoUMkgC5ZfINLTQCh
         zdN7nh/ukU/nwe/aJsvVPhTlaoQo5QDE8QGsUxGo7ddv9E0nxDQO+WKV8tFFsisa4y/i
         JFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ytXs+tjsOQIVzwgdEv3Dia185hW2en+OLpnkYRjyU0M=;
        b=OnsrV4srSzbdEZ6eiJBZSsGipbidQLNN+1BBWvp1L3wcuAnrxFP9PmzbElzK8SZ2Mg
         COlT5b9YOo0lClGxMtAah45VPfVkJK7hD+1m/uIfmZ+aOYstsrHETkLnXPDolcUZpNqH
         eGVFhaQpvLhAGUmXeuZ9X92aHtTnX5/ikEA9IEH9JqzngI4s/rtvMRRhNyNWt13j5SD1
         TeCQptHVsK9cN7il9j8iJscvsxGn4GzCKlOVW/V7D4SAASaXnER7YI+IAWhtweDkXai2
         P4F7nskF66tFoTt2j3+a6cmy4EyJxL2Wv7MdcHej8+F+qyrZgzNqrs7LdB2ZPpPrvxAB
         iOyA==
X-Gm-Message-State: AOAM533AijnulRM6bdD7sc93Z8NN804lji1JdjUYt1Uu+fQJC9/qdEfh
        Pu7hj9Nr7NmVzI8HouhU2Cs=
X-Google-Smtp-Source: ABdhPJzd3/ulyVk8lgQOK08PVFmXkgIK00c90zKHfRGYkG6UNmpJ0yLhtbbj2oJy7K0t9ke9N5yiSg==
X-Received: by 2002:aa7:cb81:: with SMTP id r1mr3621469edt.352.1639759417341;
        Fri, 17 Dec 2021 08:43:37 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f34ba00f711d38e28b691af.dip0.t-ipconnect.de. [2003:cf:9f34:ba00:f711:d38e:28b6:91af])
        by smtp.googlemail.com with ESMTPSA id f22sm3955906edf.93.2021.12.17.08.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 08:43:36 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hwmon: (asus-ec-sensors) update documentation
Date:   Fri, 17 Dec 2021 17:43:05 +0100
Message-Id: <20211217164307.1514192-3-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217164307.1514192-1-eugene.shalygin@gmail.com>
References: <20211217164307.1514192-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst     | 51 +++++++++++++++++++++
 Documentation/hwmon/asus_wmi_ec_sensors.rst | 38 ---------------
 2 files changed, 51 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/hwmon/asus_ec_sensors.rst
 delete mode 100644 Documentation/hwmon/asus_wmi_ec_sensors.rst

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
new file mode 100644
index 000000000000..b8820cd1bd62
--- /dev/null
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -0,0 +1,51 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver asus_ec_sensors
+=================================
+
+Supported boards:
+ * PRIME X570-PRO,
+ * Pro WS X570-ACE,
+ * ROG CROSSHAIR VIII DARK HERO,
+ * ROG CROSSHAIR VIII FORMULA,
+ * ROG CROSSHAIR VIII HERO,
+ * ROG CROSSHAIR VIII IMPACT,
+ * ROG STRIX B550-E GAMING,
+ * ROG STRIX B550-I GAMING,
+ * ROG STRIX X570-E GAMING,
+ * ROG STRIX X570-I GAMING
+
+Authors:
+    - Eugene Shalygin <eugene.shalygin@gmail.com>
+
+Description:
+------------
+ASUS mainboards publish hardware monitoring information via Super I/O
+chip and the ACPI embedded controller (EC) registers. Some of the sensors
+are only available via the EC.
+
+The driver is aware of and reads the following sensors:
+
+1. Chipset (PCH) temperature
+2. CPU package temperature
+3. Motherboard temperature
+4. Readings from the T_Sensor header
+5. VRM temperature
+6. CPU_Opt fan RPM
+7. VRM heatsink fan RPM
+8. Chipset fan RPM
+9. Readings from the "Water flow meter" header (RPM)
+10. Readings from the "Water In" and "Water Out" temperature headers
+11. CPU current
+
+Sensor values are read from EC registers, and to avoid race with the board
+firmware the driver acquires ACPI mutex, the one used by the WMI when its
+methods access the EC.
+
+Module Parameters
+-----------------
+ * mutex_path: string
+		The driver holds path to the ACPI mutex for each board (actually,
+		the path is mostly identical for them). If ASUS changes this path
+		in a future BIOS update, this parameter can be used to override
+		the stored in the driver value until it gets updated.
diff --git a/Documentation/hwmon/asus_wmi_ec_sensors.rst b/Documentation/hwmon/asus_wmi_ec_sensors.rst
deleted file mode 100644
index 1b287f229e86..000000000000
--- a/Documentation/hwmon/asus_wmi_ec_sensors.rst
+++ /dev/null
@@ -1,38 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0-or-later
-
-Kernel driver asus_wmi_ec_sensors
-=================================
-
-Supported boards:
- * PRIME X570-PRO,
- * Pro WS X570-ACE,
- * ROG CROSSHAIR VIII DARK HERO,
- * ROG CROSSHAIR VIII FORMULA,
- * ROG CROSSHAIR VIII HERO,
- * ROG STRIX B550-E GAMING,
- * ROG STRIX B550-I GAMING,
- * ROG STRIX X570-E GAMING.
-
-Authors:
-    - Eugene Shalygin <eugene.shalygin@gmail.com>
-
-Description:
-------------
-ASUS mainboards publish hardware monitoring information via Super I/O
-chip and the ACPI embedded controller (EC) registers. Some of the sensors
-are only available via the EC.
-
-ASUS WMI interface provides a method (BREC) to read data from EC registers,
-which is utilized by this driver to publish those sensor readings to the
-HWMON system. The driver is aware of and reads the following sensors:
-
-1. Chipset (PCH) temperature
-2. CPU package temperature
-3. Motherboard temperature
-4. Readings from the T_Sensor header
-5. VRM temperature
-6. CPU_Opt fan RPM
-7. Chipset fan RPM
-8. Readings from the "Water flow meter" header (RPM)
-9. Readings from the "Water In" and "Water Out" temperature headers
-10. CPU current
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9316A48B2B3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243483AbiAKQ5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241757AbiAKQ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:56:52 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB9AC06173F;
        Tue, 11 Jan 2022 08:56:51 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b13so16408112edn.0;
        Tue, 11 Jan 2022 08:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ytXs+tjsOQIVzwgdEv3Dia185hW2en+OLpnkYRjyU0M=;
        b=CUY8VWUhGwTf2JxMxuhYU9q2TEn1/2OalimB7ff1m1Nmr7rt3KPepEiLz2w2NpcNA2
         xqwdXWYY++n3A9JLS0c9rMrwgPQoVw/FfyYBDfBQdyKYLA2R7ZZ2+lIwfDwKjTTpZmTN
         SANgOVfvOOIPLgVGYc2LX/yUJIYEtIhHaMaWA972aAHYvTSQMvZfaZfR5panwLT97EDS
         +XP/UnHJ8JvuNPfmo+9G797KWix1Uy2r3wIly5McL3xJddOXrbQUeBUqUCT6FS8Nfhye
         N72MgA0nW5m3kFYvMyts3vTSZPMT5ZQYMJ23CpQseadaTUWm16K7o3VdpuYp3kuoJJ9q
         tN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ytXs+tjsOQIVzwgdEv3Dia185hW2en+OLpnkYRjyU0M=;
        b=SEdAisV6QF6NKEbp3rh7qrewP71XmBUoE/zpzl2JNTiGlYwSodqIOQVGR3s1h4SUJV
         RHD++aAyLwCjbgiBUQpMqOMYpZI2Zm8Bj+bU56oG7xFdyTkEvEajEHnKE3PkNNFzhMsy
         CG3CsxeVRgQXpsqCtY5tkvjfZj8HPcNp3DOIqj2aMJLet85wILTnXW5TSRJY0ULybGVg
         S4kXncVPV27QkVkcvVwt5p2qfV28uEzf/nKRWgMZ42+oWTcYvcGMd44HVJVAwopPm3ax
         Huj27A40E3gbmNDPk2VUn/PbyoFY08uXjLzIehAYdbUIOCrB6/EawQroCB2n12tMtuDR
         wAjA==
X-Gm-Message-State: AOAM5336rUYGWZq/0TV9Wu8p5UV7eOjlBnDHkKP/74ZVUmvDvaAlb+3G
        DnzWdQ6KPeCjx6pdviP8Duw=
X-Google-Smtp-Source: ABdhPJxJ/qOdzMx1JJz9rtCvit10BWygNTYoqTNmCfjf7Cgb/MYclGhfBZnf6dZgYh+PF/z8agIQyw==
X-Received: by 2002:a05:6402:2696:: with SMTP id w22mr5030679edd.253.1641920210340;
        Tue, 11 Jan 2022 08:56:50 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f0b7c00c3a5ee4155775dd9.dip0.t-ipconnect.de. [2003:cf:9f0b:7c00:c3a5:ee41:5577:5dd9])
        by smtp.googlemail.com with ESMTPSA id d14sm5220986edu.57.2022.01.11.08.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 08:56:50 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] hwmon: (asus-ec-sensors) update documentation
Date:   Tue, 11 Jan 2022 17:56:26 +0100
Message-Id: <20220111165630.1155135-3-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111165630.1155135-1-eugene.shalygin@gmail.com>
References: <20220111165630.1155135-1-eugene.shalygin@gmail.com>
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


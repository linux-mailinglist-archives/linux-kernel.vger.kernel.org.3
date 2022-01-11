Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E2948B508
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344969AbiAKSEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345397AbiAKSEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:04:00 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCECC0611FD;
        Tue, 11 Jan 2022 10:03:57 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o7-20020a05600c510700b00347e10f66d1so1058332wms.0;
        Tue, 11 Jan 2022 10:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ytXs+tjsOQIVzwgdEv3Dia185hW2en+OLpnkYRjyU0M=;
        b=gaO7UqpNsVj11XUe01fmlt5zhUwxgciZknHgUCNASfjA/R5l0Zb4FjbJV7AfIkcxpD
         MH6K7h6BNSKjb3KRpNxV13GqhdLIvFJh1QX8IlAc7iJSa4FU7l1yPdriSzLRS8t9WXfP
         SxND1oCgqWj9r58s/IqytYQ4QAmpYgGVU/p1JWd8LgNrJ5/zRvvOJgUQAPgeMBly6Zq6
         DlMv37I0tG6Y71maFUm23RxILYvV/OWZfgV+HNnrdPFCrV4amuXS7SGbPSuHc3xV4bhv
         P0yxQe9f3AmpA8ijePgNj183IN/OCgfGMdoOy9uSUCq8+3X3OeFy3HpmpVcCo3f+CWV6
         deWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ytXs+tjsOQIVzwgdEv3Dia185hW2en+OLpnkYRjyU0M=;
        b=ikNKAjJFvTpuRsV0Nut4NoXQA2lp6Sb3qrUt0/4UUd6vIqWl9TEUeBoho7MereGVHA
         OxZJLHX/ifp6pGubOB964+Q/+9W6IF6wlr1hRaqM29JVAqSzAmMlhWT7XBJf6/Z+L+rk
         zgti11ok4wT7wHmuI9QCXAJpWFvMUeJVdRHNblI8xmr3loXBDm+yOdTsH7M4wFACeQ2K
         r30YPrt0ImstPi+g0s9pCsQAE2wBqde4fFGkpyG9zesHperAixT3kKmXrVnC2ZQtu/5H
         Zf2gFQUVg5Gio40/TjAWcHGGfCEJSXhU6tPxALlV+q7mYdd3lRvUwPm5JBHM71dgWpRs
         Q6BA==
X-Gm-Message-State: AOAM533GuZnGqBSmWT8i+OpMdrCEECe5uiHCSFy93EnFyx67ECESOpHe
        YHOuEnTDJOuurogHPfHRLqw3YQz5CvbUBXR1
X-Google-Smtp-Source: ABdhPJxJxZ4W6zB8u1wdfnCmAjpsrCiBsx7Faz1/Qd1FtQ3VIEgzCkGDRdDOUltTfvUvwqaKLxp1Sg==
X-Received: by 2002:a05:600c:3508:: with SMTP id h8mr3438178wmq.143.1641924236188;
        Tue, 11 Jan 2022 10:03:56 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f0b7c00c3a5ee4155775dd9.dip0.t-ipconnect.de. [2003:cf:9f0b:7c00:c3a5:ee41:5577:5dd9])
        by smtp.googlemail.com with ESMTPSA id l6sm2255429wmq.22.2022.01.11.10.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 10:03:55 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] hwmon: (asus-ec-sensors) update documentation
Date:   Tue, 11 Jan 2022 19:03:45 +0100
Message-Id: <20220111180347.1245774-3-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111180347.1245774-1-eugene.shalygin@gmail.com>
References: <20220111180347.1245774-1-eugene.shalygin@gmail.com>
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


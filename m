Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58127492BA1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 17:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346788AbiARQxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 11:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346515AbiARQxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:53:38 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5211DC06161C;
        Tue, 18 Jan 2022 08:53:37 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c2so23544373wml.1;
        Tue, 18 Jan 2022 08:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nn7E+xJeR5ilUnsYFGL6Lm5NVc/T4m/9M7mSORyUNAE=;
        b=I9Y+mZSWvmD8sDM3qG8vwiXe9OoFhRKQut9yfEo2gS+qguoV/mXIdPQmVHbiO8Ql0m
         sGftFqmf6aE1EhcUq4Ws3xqE463Bh9g70zqkMqWLXsIfU22wgh/tB16fywczd4HG55h+
         lTn8vMM74LxNr8ucQ3W//rwbLk1hnLHcgGlkzcV8/hsO2lMkz1y57eRAC45u7cJskyQz
         WiC3oevewUAYn+xGM0Zr6arRoih+I7BJUpX61v+5A20LAhML63+JFn5DO/taD1JqJ5Wf
         MuP9GlIW7AgCUjrM87ZKQ5tb5aCfyY20kceGXR3Q096wZjmRWccOQiSMJvnNytMEenlv
         f6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nn7E+xJeR5ilUnsYFGL6Lm5NVc/T4m/9M7mSORyUNAE=;
        b=CZ99fifSYU9VCye6exDjrE6gNIS7UpspRVthV3rXqAaO4cKF6AjP1X3GfG1sn7KYhx
         h7KV/DUTd8jfEobWv0slFs4nwe1hRy5QzQucnR2OLXHpBLOHO13R6f7qLryRFllZsls5
         o9BPDoeTHajhxe25SQTNCGvKW2TWt18vnTyHekaZ2vdyQveF2UcyUyJREEe2ipi9wIW0
         nUReZ8NlI1gjCIm1TavKgF+OJKzL8b1P3MjpmIGUMb8z8MdQ8mc86YWkYpcSHXhoZgOk
         2DTsQ2FXXOHQDuCRH/OvaHgp+hIzW4EyKyMQ4uGbM87IJ5oszph2gsR2tzbhuYSoS25O
         Ol5g==
X-Gm-Message-State: AOAM5327+uyZZeyyFbOBReSw1x0TfDET4bS4MxzgFgPOtEuLdkTHe1GM
        lYEX6ACe/sGbzkPH3XZJvcR76sTSqz2bJw==
X-Google-Smtp-Source: ABdhPJxRNNdmM0xRRugA+CSzazc2Lwxlq1cNqtxXo5F6aDJ/VTfplVa8CaqbLDU9DPRURZvixmyWMA==
X-Received: by 2002:a05:600c:3d18:: with SMTP id bh24mr8710757wmb.49.1642524815829;
        Tue, 18 Jan 2022 08:53:35 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f235800e668694710673d4b.dip0.t-ipconnect.de. [2003:cf:9f23:5800:e668:6947:1067:3d4b])
        by smtp.googlemail.com with ESMTPSA id o12sm10634141wrc.51.2022.01.18.08.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 08:53:35 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [ASUS EC Sensors v7 2/3] hwmon: (asus-ec-sensors) update documentation
Date:   Tue, 18 Jan 2022 17:53:08 +0100
Message-Id: <20220118165316.412735-3-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118165316.412735-1-eugene.shalygin@gmail.com>
References: <20220118165316.412735-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst     | 52 +++++++++++++++++++++
 Documentation/hwmon/asus_wmi_ec_sensors.rst | 38 ---------------
 2 files changed, 52 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/hwmon/asus_ec_sensors.rst
 delete mode 100644 Documentation/hwmon/asus_wmi_ec_sensors.rst

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
new file mode 100644
index 000000000000..b12ac7ebeb1a
--- /dev/null
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -0,0 +1,52 @@
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
+ * ROG STRIX X570-F GAMING,
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


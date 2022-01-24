Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C278849771E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 02:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbiAXB50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 20:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbiAXB5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 20:57:22 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50302C061401;
        Sun, 23 Jan 2022 17:57:22 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u15so10744126wrt.3;
        Sun, 23 Jan 2022 17:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nn7E+xJeR5ilUnsYFGL6Lm5NVc/T4m/9M7mSORyUNAE=;
        b=mRg5hNKLiKrnFCRqkluNOLaAWBRQjXvOCnDkVuzfuAbJC2m3Yq7fvt+P+SrTvLm16i
         ahYHIMTG3bYtmUZHnytJUvs1hIq8fKCAA+g5IE4tDAZ4bNK39P/UTKUwsOPYXQv0VWs+
         OCHOXfP7mhbwY6uFVBXOC00c6ztwGn3Xt0NUcdBYUKEoCrFEBWOtCP+PjWgv2tpSFVPn
         juCZFCTtRJy8RX3kLtd4cy/BDzz1rY+PRWSguXqn3umXsX90GnHw26nxDWdBn2Pw4Rwl
         BkCBhj19IBayFk3J+l0c4MeMdNxqK2IsU82w7va/R1JGPIpSUQGAzrm6gQR1+W/cWPvK
         0QMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nn7E+xJeR5ilUnsYFGL6Lm5NVc/T4m/9M7mSORyUNAE=;
        b=YPtDJaRkEoYzOsR2ogR2HIpTjSPhAalw3PdbcGudbni4B6yx+UCPzbRDI3kHN4BnS4
         N6RUBNlHFMvdEXhimQxkBk5ADNFT1xxEY3mgraYJQSyhkwMX3qkSdC0797Iu1fJEOD0f
         ELLBxp1f5CK7dxiMrYw7ftGSKtgslPsRpth0TiyFJTqd7E5ZyN8YIJHy7VaY1saeyJod
         YSwav8LjaYUvPIeWRmjnPu4rHPV+caW+nvgJI8zMGCNWy3g04mrkHlZnbIxewtfKFWRN
         gZFkbGDalVwp4uFMmeBqg0JwbddNsGhtfAHcOYFIypoYH4+838T1lTkY42bzQfJM+pSX
         xIOg==
X-Gm-Message-State: AOAM532D2u2ob2xYrgEnroUej3XQB3YgajXsfdtrsRAnWHDrauZJvLoa
        m58dl5+fHGuqkoqpIex27vh2JKnlbNw=
X-Google-Smtp-Source: ABdhPJxvWfPJMjQbbx+7DwrG7LNRgGEOp+BgjfXUQwK3Vs5INU8xQFk869YqZ0lSzVHTmdmEMLWksg==
X-Received: by 2002:adf:b64f:: with SMTP id i15mr7636478wre.228.1642989439802;
        Sun, 23 Jan 2022 17:57:19 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f235800e668694710673d4b.dip0.t-ipconnect.de. [2003:cf:9f23:5800:e668:6947:1067:3d4b])
        by smtp.googlemail.com with ESMTPSA id i2sm3224968wmq.23.2022.01.23.17.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 17:57:19 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        oleksandr@natalenko.name, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [ASUS EC Sensors v8 2/3] hwmon: (asus-ec-sensors) update documentation
Date:   Mon, 24 Jan 2022 02:56:44 +0100
Message-Id: <20220124015658.687309-3-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124015658.687309-1-eugene.shalygin@gmail.com>
References: <20220124015658.687309-1-eugene.shalygin@gmail.com>
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


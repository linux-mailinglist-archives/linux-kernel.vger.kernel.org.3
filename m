Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34CA48FECC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 21:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbiAPUTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 15:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236138AbiAPUTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 15:19:04 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACD2C061574;
        Sun, 16 Jan 2022 12:19:04 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id w16so56902038edc.11;
        Sun, 16 Jan 2022 12:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ytXs+tjsOQIVzwgdEv3Dia185hW2en+OLpnkYRjyU0M=;
        b=f1jP+h+11ucBSDdzQ7G1vw72x0PMZncsFsuunsZCQFnPbg0RxfalgYe+6am79+pO32
         57iFSGZ7OrWZVdWeTvIQG0yizer1cfC0M+coHR2dMDMWVH5DVcHE9/6n8OzTXECCQlc+
         kcr9otJ5FLElCBSqvDIKBUy1X9AILBl/R+GBfKjye9wpPp1/ebK63cvYYcYK9Sxw9Lrm
         Ry+LPzkZG1cSHhFP/TtgV2vVGNRBZOGEFmkKIOiAEqMsB1YakQadidZ4vj0VH4ydfG0r
         fMEVJwpsNwkT3tyf4U39AxlRg10DQF02XPxV+4wYIrhh/XfLKEFlWtgJZMT02ysaELm1
         M7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ytXs+tjsOQIVzwgdEv3Dia185hW2en+OLpnkYRjyU0M=;
        b=HCIKu34ie4Cs7dxvdLJzUumvCC9imE/16FqXLqVm2qh0f21+7xvP71DqStpbcGn55n
         vrE5gIFrmJ2ios8h605w+BQQ7tCWOTtcHar71UZY5oHoDYmS7MjHR6pU6bUstZ2PcII3
         bwAaWChiiPL6z0w9AdHCsIJQU8mZJUQUkjYxXxA+qvjeaddgfDHrj0f0W06d8AXntvZp
         58ZsmvupDDyMnAgaThnLP2Zbz+NerA99Nq7J3NhcOXStkO3bMcWSfgPfo4ECobiwjG+x
         cNS0Y72ZIuhnofdnxlMq531FNrh6uLsrENOayc0vhAc3UyYDuF4hQN3jld+i0ABfb7Sg
         iQ+w==
X-Gm-Message-State: AOAM532F1JXhCS/GzTVzBKySpwdsH/FEFSkW2D8oVEYA3FYZMU6HUq1r
        hh8thk/nGqkN5QGJUF0Gvb4=
X-Google-Smtp-Source: ABdhPJzcLLyC48Yh5bXkJHxZfEu7RDTXaB+tF+SVBZKpz7O9lvjOScvlLKpCiSDkSfhrFm3qumOOuw==
X-Received: by 2002:a05:6402:4387:: with SMTP id o7mr18181206edc.266.1642364343177;
        Sun, 16 Jan 2022 12:19:03 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f4053004b601b67b388bdb4.dip0.t-ipconnect.de. [2003:cf:9f40:5300:4b60:1b67:b388:bdb4])
        by smtp.googlemail.com with ESMTPSA id eg30sm2529452edb.85.2022.01.16.12.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 12:19:02 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [ASUS EC Sensors V6 v6 2/3] hwmon: (asus-ec-sensors) update documentation
Date:   Sun, 16 Jan 2022 21:18:40 +0100
Message-Id: <20220116201843.2301438-3-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220116201843.2301438-1-eugene.shalygin@gmail.com>
References: <20220116201843.2301438-1-eugene.shalygin@gmail.com>
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


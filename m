Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE49F4A8DAC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354471AbiBCUcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354319AbiBCUbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:31:32 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43608C061757;
        Thu,  3 Feb 2022 12:31:10 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id p12so8509980edq.9;
        Thu, 03 Feb 2022 12:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ulW6uLO42kV5kik2BobfHbP7xAW9OLDANUtAn1JYzs=;
        b=SK8QsZBnLVkBomK7z0ApY6hGnsrAxtcidnIG7no8x2umrDfnKYiFfQ4+n2/ig1Cx5r
         lbN4n/bkZQHhNDH1nQ2LiA3bK/3Ni8n7gm/AORFz4Cw13bgeRRe0BauCUGRQzaksFnKZ
         CV/ZrKHSvx4vpnpU6+kQRXE5adTxyyYaOxXpngx8t0+P1I/Gav1ZsJx62HiV7CZHc6V0
         EARbMWJTrFh+J+5s6dpS/WwOuoum35xsljhxM2JvT4IVGWh3e2WUoeUedYvCbd7CPOi0
         I12WLTNJPyNJnTBellnOa3+n9S3VYGYttrZ+AKNhxuWOLlJ12kQ7hdo8X0yTybY1G3s9
         s+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ulW6uLO42kV5kik2BobfHbP7xAW9OLDANUtAn1JYzs=;
        b=Szf3qyaPqMnAzVlq3Yy/JJ7B4OPeHwGghd+EnHx6OUugh3cg3MwMbhOGCuRdj+4N60
         sz+/50j+EUuVkqZK11VpBeCZWG8jVrYkpGM/vkF9X7Ima6SBU4cwwI+kWca7QE02W3oq
         db0PxUAjFkwzvIF1picO+zWy2gcvKKHkowMMIjyw2CXTzyuijg49QTG4s5QWFbWMxQ7T
         1pFzQHgoR+6elilp3WX1vfwBUDiF6QYksxkyms3UNBJ2/y3ZDvxV1MQ1T4SxS4eke3xq
         r4yOflyZe/fwwlDahssbwXiH1jrPY5SyP+QIfPgKIltgpOM36rWRrgei6PVBoQKvlC6J
         uOKg==
X-Gm-Message-State: AOAM530zhh3UoWlhaSiEZ2LOI8R0QLWxcRZAC3pBJLfIRKtj51nBHonO
        IBhPTeSZcwxcGjABUJJmsUrUAgQ3MStpsA==
X-Google-Smtp-Source: ABdhPJzrbjk4HOawDZkNhXaqZyUHm7t5dUA814bTJ08+jO3HwbGoPPIqIn3o98goz+AoB1LsIK7tCA==
X-Received: by 2002:a50:aadd:: with SMTP id r29mr36849028edc.236.1643920268669;
        Thu, 03 Feb 2022 12:31:08 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f235800e668694710673d4b.dip0.t-ipconnect.de. [2003:cf:9f23:5800:e668:6947:1067:3d4b])
        by smtp.googlemail.com with ESMTPSA id i14sm4688462edr.100.2022.02.03.12.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 12:31:08 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: hwmon: (asus-ec-sensors) Add Crosshair VIII Hero WiFi
Date:   Thu,  3 Feb 2022 21:30:52 +0100
Message-Id: <20220203203052.441712-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Wi-Fi variant of Crosshair VIII Hero provides the same sensors,
which was tested by a Libre Hardware Monitor user [1].

[1] https://github.com/LibreHardwareMonitor/LibreHardwareMonitor/pull/453#issuecomment-1028398487

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst | 1 +
 drivers/hwmon/asus-ec-sensors.c         | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index b12ac7ebeb1a..22de1b037cfb 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -7,6 +7,7 @@ Supported boards:
  * PRIME X570-PRO,
  * Pro WS X570-ACE,
  * ROG CROSSHAIR VIII DARK HERO,
+ * ROG CROSSHAIR VIII HERO (WI-FI)
  * ROG CROSSHAIR VIII FORMULA,
  * ROG CROSSHAIR VIII HERO,
  * ROG CROSSHAIR VIII IMPACT,
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 7285334c7d80..05244209c0c6 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -188,6 +188,12 @@ static const struct dmi_system_id asus_ec_dmi_table[] __initconst = {
 		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
 		SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
 		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU),
+	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
+			      "ROG CROSSHAIR VIII HERO (WI-FI)",
+		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
+		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
+		SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
+		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU),
 	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
 			      "ROG CROSSHAIR VIII IMPACT",
 		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
-- 
2.35.1


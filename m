Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575AD56D309
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 04:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiGKClA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 22:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGKCk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 22:40:59 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D64E165A4;
        Sun, 10 Jul 2022 19:40:58 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 23so3595951pgc.8;
        Sun, 10 Jul 2022 19:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DfCO5zmfhrBaTk23zn4ccYw0dQ3KMpSBZZxLYLSoRwg=;
        b=EF15GHFBUpc0BX76lY93TmzV7T62PUI7OIa8aDEgGXsY1pL8mby+JSPVRIT82rxNvh
         2bBFtozRFKHJ++5OD2JhVGBjvbyPBIgopM0OSjHzc4j801JLNANUNsEvJa1VetmuWxD+
         /6+EMxDaszCU4QBWabDq/U8TKWe0+u+VZiQbs8AMr0dwnCJPK/XJgIds3RgNQdZGJbgO
         1hgr0rYbY9ijMfOC9nWbNqfQ545RVEYxUrpYoahw615zGUbrOkd1nyhKf8Sh3GI1Zf4k
         cOLVCvAdOnoLc1Nr9pdn1SzM3tSmzxw1KErOB5Js8r3frql9LktCP3BfqW2FTqq1IU56
         /Abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DfCO5zmfhrBaTk23zn4ccYw0dQ3KMpSBZZxLYLSoRwg=;
        b=Fbt19mnoVD0Xms50gcBh9AOFH9hnNvHkicQBdJSa+aFlT79cbmcf/eh/XcuIjk5Ik4
         A33IsSMkoVsTQv6x7mCXujeNyAVmTnTKutUTeDci6LgibUGG/30vJDcHQaYjve96Dk0Z
         fTPLy4co8txPOLxsF5ZzFr88WZLLsv68l8fPqTo13Q/zPkxXL9n5YtMdPq291zPZSmAc
         lFt5LhzTO/CN1AmFNnnIVPkn3qis/8k/rC+V97pMR9fYK2/iBrpdyG6ZrEKa2NaOjXSr
         JJKNGSN2NMiD7aspJvVVZ9P52z7rIImn8CSUtqXRWBNQkPNTVDdXi2A6iWQwRKWi69/J
         75qg==
X-Gm-Message-State: AJIora/meQVpRISaNOpRshBMRnflxCnO9ew521omOLNBscVFEi02Lckp
        JFYJsz9hPnM2bMyKG4KX9KVXVeMPSLHC/r0f
X-Google-Smtp-Source: AGRyM1vvc+LTI6mFK2Z7ecaSIoDAqBpTYQRccCbJ7lIdJpXpRxhMQ8W7bLw5Fl/FMLFRw6oTDpeIjw==
X-Received: by 2002:a63:df41:0:b0:415:c079:81d8 with SMTP id h1-20020a63df41000000b00415c07981d8mr11769985pgj.287.1657507257813;
        Sun, 10 Jul 2022 19:40:57 -0700 (PDT)
Received: from localhost.localdomain (61-216-65-192.hinet-ip.hinet.net. [61.216.65.192])
        by smtp.gmail.com with ESMTPSA id e16-20020a631e10000000b00412a3c1efddsm3080353pge.42.2022.07.10.19.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 19:40:57 -0700 (PDT)
From:   PaddyKP_Yao <ispaddy@gmail.com>
X-Google-Original-From: PaddyKP_Yao <PaddyKP_Yao@asus.com>
To:     andy.shevchenko@gmail.com, hdegoede@redhat.com
Cc:     paddykp_yao@asus.com, acpi4asus-user@lists.sourceforge.net,
        corentin.chary@gmail.com, ispaddy@gmail.com,
        linux-kernel@vger.kernel.org, luke@ljones.dev,
        mgross@linux.intel.com, platform-driver-x86@vger.kernel.org,
        PaddyKP_Yao <PaddyKP_Yao@asus.com>
Subject: [PATCH v2 1/1] platform/x86: asus-wmi: Add mic-mute LED classdev support
Date:   Mon, 11 Jul 2022 10:40:30 +0800
Message-Id: <20220711024030.1694502-1-PaddyKP_Yao@asus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <HK0PR04MB33636680A6DC47211560BB43FA879@HK0PR04MB3363.apcprd04.prod.outlook.com>
References: <HK0PR04MB33636680A6DC47211560BB43FA879@HK0PR04MB3363.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some new ASUS devices, hotkey Fn+F13 is used for mic mute. If mic-mute
LED is present by checking WMI ASUS_WMI_DEVID_MICMUTE_LED, we will add a
mic-mute LED classdev, asus::micmute, in the asus-wmi driver to control
it. The binding of mic-mute LED controls will be swithched with LED
trigger.

Signed-off-by: PaddyKP_Yao <PaddyKP_Yao@asus.com>
---
V1 -> V2: fix typo for 'present' and remove unnecessary pr_info() log

 drivers/platform/x86/Kconfig               |  2 ++
 drivers/platform/x86/asus-wmi.c            | 25 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 3 files changed, 28 insertions(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index f915cf67aa26..74769050b770 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -274,6 +274,8 @@ config ASUS_WMI
 	select INPUT_SPARSEKMAP
 	select LEDS_CLASS
 	select NEW_LEDS
+	select LEDS_TRIGGERS
+	select LEDS_TRIGGER_AUDIO
 	select ACPI_PLATFORM_PROFILE
 	help
 	  Say Y here if you have a WMI aware Asus laptop (like Eee PCs or new
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index e14fb5fa7324..40c0e00a4b71 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -191,6 +191,7 @@ struct asus_wmi {
 	int kbd_led_wk;
 	struct led_classdev lightbar_led;
 	int lightbar_led_wk;
+	struct led_classdev micmute_led;
 	struct workqueue_struct *led_workqueue;
 	struct work_struct tpd_led_work;
 	struct work_struct wlan_led_work;
@@ -906,12 +907,23 @@ static enum led_brightness lightbar_led_get(struct led_classdev *led_cdev)
 	return result & ASUS_WMI_DSTS_LIGHTBAR_MASK;
 }
 
+static int micmute_led_set(struct led_classdev *led_cdev,
+			   enum led_brightness brightness)
+{
+	int state = brightness != LED_OFF;
+	int err;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MICMUTE_LED, state, NULL);
+	return err < 0 ? err : 0;
+}
+
 static void asus_wmi_led_exit(struct asus_wmi *asus)
 {
 	led_classdev_unregister(&asus->kbd_led);
 	led_classdev_unregister(&asus->tpd_led);
 	led_classdev_unregister(&asus->wlan_led);
 	led_classdev_unregister(&asus->lightbar_led);
+	led_classdev_unregister(&asus->micmute_led);
 
 	if (asus->led_workqueue)
 		destroy_workqueue(asus->led_workqueue);
@@ -983,6 +995,19 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 					   &asus->lightbar_led);
 	}
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MICMUTE_LED)) {
+		asus->micmute_led.name = "asus::micmute";
+		asus->micmute_led.max_brightness = 1;
+		asus->micmute_led.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
+		asus->micmute_led.brightness_set_blocking = micmute_led_set;
+		asus->micmute_led.default_trigger = "audio-micmute";
+
+		rv = led_classdev_register(&asus->platform_device->dev,
+						&asus->micmute_led);
+		if (rv)
+			goto error;
+	}
+
 error:
 	if (rv)
 		asus_wmi_led_exit(asus);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 17dc5cb6f3f2..38ee75874d11 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -49,6 +49,7 @@
 #define ASUS_WMI_DEVID_LED4		0x00020014
 #define ASUS_WMI_DEVID_LED5		0x00020015
 #define ASUS_WMI_DEVID_LED6		0x00020016
+#define ASUS_WMI_DEVID_MICMUTE_LED		0x00040017
 
 /* Backlight and Brightness */
 #define ASUS_WMI_DEVID_ALS_ENABLE	0x00050001 /* Ambient Light Sensor */
-- 
2.34.1


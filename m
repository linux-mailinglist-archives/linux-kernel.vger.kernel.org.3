Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6E358C1EF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 05:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbiHHDE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 23:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbiHHDEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 23:04:52 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5D7BE02;
        Sun,  7 Aug 2022 20:04:51 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2E3B45C00DA;
        Sun,  7 Aug 2022 23:04:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 07 Aug 2022 23:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659927891; x=1660014291; bh=b8
        zBqnbjGfkGFv4egHJI0533lSwO5A03klYpq+LVrGI=; b=dbxXsl4WCFuQnSu4BL
        lqzgHTw6+utL+NPN3q5voJHNAlLO32h7GyVvdk2E4qLR5k2PUg9EHeeYS0K39ByU
        htPlDjjNezwIQD9YDgxSlRYsvuyEy4zgPHYnHAqQOaFr9p8BwOymSbMg46op/8A4
        lNb8EpcJs/n6mi1IBm6HYxK2l7cW7KEsU/f8GqTpHY7AEke0ARzgXetf2IP2SuhL
        sXQJntftDgAchpJgYltEbH3Rb6W9RKDRxaOazn9//iT7e5zf6U9TIpDve+4IK6rW
        BfDciHHlvvv/twv42SQtLCN7CXaKBspoFVMNGuPMIbUOpdmzxHnU4yqxBla8oRQy
        b7eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1659927891; x=1660014291; bh=b8zBqnbjGfkGF
        v4egHJI0533lSwO5A03klYpq+LVrGI=; b=owk211u0JCE1gSsKB+I36FLMwSBAv
        coI1r0f1QGKTE7RQuA8+5lxn4DSRBjUxrOSK9EOm9r/wYWM8Zi4lBVHHTz1LKz7k
        wTa6DyIsHNhVwwxZfb+cfjIoY5lV2CNS3/aBq0gSViBjSXNstHv+ecrJ27Ac5IHj
        ETtwYxXX5XynfgX5vlpuAAqZ63/FHSc1TcSmTFCq+ibr/J6838dsee5ZoM1IXMJ2
        Kp3V25kyk60+AoiU+ZD8Qm3/YOh+Jw5sY+TBnpEdRydDjXZJi9SkHnkE+U9NqpGA
        LgM5CVGk1OlxYQ9Ya/3KUoMS+q01AcRCOQ88EwAPqUGcimM/N6olys8Yw==
X-ME-Sender: <xms:Un3wYpBPah52unz8pM-ClXzUvNjopyQx4xNPcgbybYahOGNwhIlYqA>
    <xme:Un3wYnhcdfeGzPSb6_0-rvLqBuV89Wkq5iFC0C8GMaHL2isOGSAXKDCmwZ0UHrJTL
    y_w-v7RxlNVu_Dagbc>
X-ME-Received: <xmr:Un3wYkmHDBRpy778Ei-O38-7b7-UGfUsDDjHdP07tBXoSZ55Mrj0Ox1UFwbv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefjedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:Un3wYjycEBVDL-6ooiWjj6yvi4RWoJvcK45UrrOrZyqlInfTu1_f-Q>
    <xmx:Un3wYuQxBDCn_sfPKFbcGeZoQZUXBEbmsggZukreh0nWAkx5lbu0Rw>
    <xmx:Un3wYmaysm04fVn5rSbpsAVq9P_4xsKDwynxTVB3qm-aNYCW2ctFPQ>
    <xmx:U33wYpcXRlpPhZ4TdgTJNI4MkzNzOI6aSobuk5p_nJ_0Rqk9QOl-4Q>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Aug 2022 23:04:48 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 1/6] asus-wmi: Implement TUF laptop keyboard RGB control
Date:   Mon,  8 Aug 2022 15:04:15 +1200
Message-Id: <20220808030420.8633-2-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808030420.8633-1-luke@ljones.dev>
References: <20220808030420.8633-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for TUF laptop RGB control via the multicolor LED API.

As this is the bas for adjusting only the RGB values, it sets the
default mode of the keyboard to static since there is no way to read
any existing settings from the device. These defaults overwrite the
booted state of the keyboard when the module is loaded.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 80 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  3 +
 2 files changed, 83 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 0e7fbed8a50d..233e73f4313d 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -25,6 +25,7 @@
 #include <linux/input/sparse-keymap.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
+#include <linux/led-class-multicolor.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
@@ -117,6 +118,9 @@ static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
 static int throttle_thermal_policy_write(struct asus_wmi *);
 
+static int tuf_rgb_brightness_set(struct led_classdev *cdev,
+							enum led_brightness brightness);
+
 static bool ashs_present(void)
 {
 	int i = 0;
@@ -190,6 +194,14 @@ struct fan_curve_data {
 	u8 percents[FAN_CURVE_POINTS];
 };
 
+struct keyboard_rgb_led {
+	struct mc_subled subled_info[3]; /* r g b */
+	struct led_classdev_mc dev;
+	u8 save;
+	u8 mode;
+	u8 speed;
+};
+
 struct asus_wmi {
 	int dsts_id;
 	int spec;
@@ -234,6 +246,8 @@ struct asus_wmi {
 	bool dgpu_disable_available;
 	bool dgpu_disable;
 
+	struct keyboard_rgb_led keyboard_rgb_mode;
+
 	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
 
@@ -1028,12 +1042,40 @@ static enum led_brightness lightbar_led_get(struct led_classdev *led_cdev)
 	return result & ASUS_WMI_DSTS_LIGHTBAR_MASK;
 }
 
+static int tuf_rgb_brightness_set(struct led_classdev *cdev,
+	enum led_brightness brightness)
+{
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
+	struct keyboard_rgb_led *rgb = container_of(mc_cdev, struct keyboard_rgb_led, dev);
+	struct asus_wmi *asus = container_of(rgb, struct asus_wmi, keyboard_rgb_mode);
+	struct device *dev = &asus->platform_device->dev;
+	u8 r, g, b;
+	int err;
+	u32 ret;
+
+	led_mc_calc_color_components(mc_cdev, brightness);
+	r = mc_cdev->subled_info[0].brightness;
+	g = mc_cdev->subled_info[1].brightness;
+	b = mc_cdev->subled_info[2].brightness;
+
+	/* Writing out requires some defaults. This will overwrite boot mode */
+	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, ASUS_WMI_DEVID_TUF_RGB_MODE,
+				rgb->save | (rgb->mode << 8) | (r << 16) | (g << 24),
+				(b) | (rgb->speed << 8),
+				&ret);
+	if (err)
+		dev_err(dev, "Unable to set TUF RGB data?\n");
+
+	return err;
+}
+
 static void asus_wmi_led_exit(struct asus_wmi *asus)
 {
 	led_classdev_unregister(&asus->kbd_led);
 	led_classdev_unregister(&asus->tpd_led);
 	led_classdev_unregister(&asus->wlan_led);
 	led_classdev_unregister(&asus->lightbar_led);
+	led_classdev_multicolor_unregister(&asus->keyboard_rgb_mode.dev);
 
 	if (asus->led_workqueue)
 		destroy_workqueue(asus->led_workqueue);
@@ -1105,6 +1147,44 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 					   &asus->lightbar_led);
 	}
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE)) {
+		struct mc_subled *mc_led_info = asus->keyboard_rgb_mode.subled_info;
+		struct led_classdev_mc *mc_cdev = &asus->keyboard_rgb_mode.dev;
+		struct device *dev = &asus->platform_device->dev;
+		u8 led_brightness = 255;
+
+		/*
+		 * asus::kbd_backlight still controls a base 3-level backlight and when
+		 * it is on 0, the RGB is not visible at all. RGB should be treated as
+		 * an additional step.
+		 */
+		mc_cdev->led_cdev.name = "asus::multicolour::kbd_backlight";
+		mc_cdev->led_cdev.flags = LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
+		mc_cdev->led_cdev.brightness_set_blocking = tuf_rgb_brightness_set;
+		mc_cdev->led_cdev.brightness_get = NULL;
+
+		mc_cdev->subled_info = mc_led_info;
+		mc_led_info[0].intensity = 127;
+		mc_led_info[0].color_index = LED_COLOR_ID_RED;
+		mc_led_info[1].color_index = LED_COLOR_ID_GREEN;
+		mc_led_info[2].color_index = LED_COLOR_ID_BLUE;
+		mc_cdev->num_colors = 3;
+
+		/*
+		 * It's not possible to get last set data from device so set defaults
+		 * to make it safe for a user to change either RGB or modes.
+		 */
+		asus->keyboard_rgb_mode.save = 1;
+		asus->keyboard_rgb_mode.mode = 0;
+		asus->keyboard_rgb_mode.speed = 0xeb;
+
+		mc_cdev->led_cdev.brightness = led_brightness;
+		mc_cdev->led_cdev.max_brightness = led_brightness;
+		led_mc_calc_color_components(mc_cdev, led_brightness);
+
+		rv = led_classdev_multicolor_register(dev, mc_cdev);
+	}
+
 error:
 	if (rv)
 		asus_wmi_led_exit(asus);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index a571b47ff362..d63c9945a17d 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -98,6 +98,9 @@
 /* dgpu on/off */
 #define ASUS_WMI_DEVID_DGPU		0x00090020
 
+/* TUF laptop RGB control */
+#define ASUS_WMI_DEVID_TUF_RGB_MODE	0x00100056
+
 /* DSTS masks */
 #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
 #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002
-- 
2.37.1


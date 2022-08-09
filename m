Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A84C58D218
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 04:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiHICvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 22:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiHICvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 22:51:12 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758D9192BF;
        Mon,  8 Aug 2022 19:51:11 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D85965C00AE;
        Mon,  8 Aug 2022 22:51:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 08 Aug 2022 22:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660013470; x=1660099870; bh=b8
        zBqnbjGfkGFv4egHJI0533lSwO5A03klYpq+LVrGI=; b=kyJMAg7BhnEYXKf5J1
        qJWQnsF4bOfgAtRiuhwmZFdVUyww6d1dr/3wP/OkF6gH5kV1otg1ak3phk+ITTPO
        BvIh1FXgEbH9+WwMQ//C6yhWPkv/d2t3urwkwbrl0wUW9/1o1+jN2JBMMG43eqTK
        cxYIGkVVMZCapU+C1XDLpyovivsaOZa5Rk2SHfptaZ4jE7IDZ1Ik1u6CWk4aZMgW
        XZLMsCkHJJKPqHIlV7ioItwB0yVJNV9QDsrfngKn1yNqzwhJzl2aQJ6fEJad3s6A
        1RE+kvanN/DpB0bm0Y5Y5BcBe0hbv4kJHmwUjzlbAtpkLAo1Ss9n1l2ZoHc/pD+a
        hUoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660013470; x=1660099870; bh=b8zBqnbjGfkGF
        v4egHJI0533lSwO5A03klYpq+LVrGI=; b=CaMyhMmMf46yNc3FODZkVz5JMQtdM
        Vf0WXkeo/ESyhch3KqFGFEr6OnUncQBRfc/CT4nCLbE6Vrb3WDc39CL2Hcr7Z7eI
        V2Oo4xlg2vgqYRx0CCJSLpDTxtJLGsZuMpu+t9ZN4+8X43L7xIDHSFhEl/XinzeA
        n52nl7JPBxlsQQqVjxwKoEGqmr6FP55B21D7SuZnpYDygQL+YFYum18wdFtU7ehA
        zXXQ1hNig5JVWzxqdNMK9ZdBLkFteUJFjEJ9kj2kskfWMAqiSARHDeMBNKW2wUjh
        VxUw/FC0LJ0ce/fP763lcFhbxNTwpFz27EIQS1+j4gRvrSAJTTtUEw92g==
X-ME-Sender: <xms:nsvxYqeij7dbdd6-oFgURbfUk_CM_USY6bwT63ZFRf1A2goYl-sbDw>
    <xme:nsvxYkNnNEB0fNyh6ugtcgh6NYGqwZysxOcy-pPtrLJr8FZ8NPQMPgAfDbhzxRMUX
    gFIBtRDYq_ySijiAvs>
X-ME-Received: <xmr:nsvxYriBOq5foBkqGcmvhsBMgNfUDnAkRku_3fY9vVkR04d2JHOVccZtiYyv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefledgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:nsvxYn_39ynDI6f0d1Msa3xwGrkqvaDXIxLgjrVd8zQSxFbK9oud2w>
    <xmx:nsvxYms_SC7sS-2WBHSwz-o_uUgJLQ7TBK2AiGdkt_Um40PaWcWTyQ>
    <xmx:nsvxYuG-R1-7QJjLLPtcFuLt7DE0A8E0uc98x1nlMR8lV3Q50IXNDQ>
    <xmx:nsvxYoLD2lqCqrU8BLuC75G9Ec07TB_9ZbPhUEDI3wB2wC_tePSSRQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 22:51:08 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     andy.shevchenko@gmail.com, pobrn@protonmail.com, pavel@ucw.cz,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 1/6] asus-wmi: Implement TUF laptop keyboard RGB control
Date:   Tue,  9 Aug 2022 14:50:49 +1200
Message-Id: <20220809025054.1626339-2-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809025054.1626339-1-luke@ljones.dev>
References: <20220809025054.1626339-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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


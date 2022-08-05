Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49C658A7EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240462AbiHEIT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240398AbiHEITZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:19:25 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD877645B;
        Fri,  5 Aug 2022 01:19:24 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 561453200946;
        Fri,  5 Aug 2022 04:19:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 05 Aug 2022 04:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659687562; x=1659773962; bh=Ue
        OogY8J+EEaESeClmAGFq2YEc3XMO6ZYcJpagBSPcc=; b=SFrINQDvo0ixaOfGhn
        L6KioHCD8zEEwSrBsIrIzudVOfxXe1dXdXCNIDzpF/c8LTw8Ffzzd5i+ACAv+X3I
        AUngS4EPyfCO5JwYa2+lQB9sOlcQOHWfeU01nZZ58jec9TzfBJKKuPreTOaWhfOt
        aYk/Hh2r/i4234z3GcsRQhksecEDp+hU/csV6Zy39DZSZu3qt/cRIoyTCdlYot2o
        44nn3JsWk+UnScTfRkqG1AajnuzZ6ukQzz2h4vMAZsC0JCvD04lAnkzXd2Am+bj9
        kDMGyeXDUzMXgFH0RsIIvXr+kUYmC9+znob2uEqU+QSla/2AGaLwGBmZAe5CMWaR
        233A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659687562; x=1659773962; bh=UeOogY8J+EEaE
        SeClmAGFq2YEc3XMO6ZYcJpagBSPcc=; b=uwVJz8AgNPTnHuhQ9AUHyB4u/QKVr
        GoRfjk+ZNVuw1vSNGoFidkxraRW9T0MH0mAkuIhLki65ieU7v628COBcCG9Nl15/
        JF2A9eQ5l/ObChopc2WdMqUrnN872ULw6nnh1Ib2yJ+YpshGAfI8/Sn2cP+8BqVt
        wZ3sTGqvIfIJT+g8luslmT/JVki14cyxv0qpzLMYvMk3c3Ra/wGYLUyciivmYD9H
        Rzsqtk8CVdOl5oJx9sCpqTan9X+0U64tfSsbAID7/+MnGEOBXyi6hvMZHNlpidYv
        LOiN69nXq87sMvwDHneknhFq6aTDv0EHB0Y3jrTvEzKehRhUxDR73rEAg==
X-ME-Sender: <xms:itLsYpVQM7zGSqDqHHn0ldQqR7e14I1UaJYWYSUgHq26KkjbCsERcA>
    <xme:itLsYplJkQO7lU0SAZkSPFLeBj7c7LFlGiVgfBPR7w1ZBKTTX7EZ-qRNdAJhC_OP5
    SVVhb_deTcG_XjBSiE>
X-ME-Received: <xmr:itLsYlYkaItmTaSg4F_8XIOkLtm06LpDUeQmJfAeNH7YUtfWLiLDHYQVAA57>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefuddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:itLsYsUoKEQQb84YE3XC1gB_N1qpyeWGLnh45SdJWJV1gL0wk2nUYg>
    <xmx:itLsYjkemsHsPZf-TM8Fc4mZAIR2XD9mXMpFC3y12wEarrMz1X7kIA>
    <xmx:itLsYpewOLENe2LoLDOwRlvqbwdQJEdc81h7JHi6FVLbL_HN5r6LoQ>
    <xmx:itLsYoxZqy_OdJ1sTECWuNUu0BepdVGNYtEukXC0zeZLmMvRG_WZGQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Aug 2022 04:19:19 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 1/5] asus-wmi: Add basic support for TUF laptop keyboard RGB
Date:   Fri,  5 Aug 2022 20:19:05 +1200
Message-Id: <20220805081909.10962-2-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805081909.10962-1-luke@ljones.dev>
References: <20220805081909.10962-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for TUF laptop RGB control via the multicolor LED API.

As this is the base essentials for adjusting the RGB, it sets the
default mode of the keyboard to static. This overwrites the booted
state of the keyboard.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 89 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  3 +
 2 files changed, 92 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 0e7fbed8a50d..33384e3321bb 100644
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
@@ -190,6 +191,11 @@ struct fan_curve_data {
 	u8 percents[FAN_CURVE_POINTS];
 };
 
+struct keyboard_rgb_led {
+	struct led_classdev_mc dev;
+	struct mc_subled subled_info[3]; /* r g b */
+};
+
 struct asus_wmi {
 	int dsts_id;
 	int spec;
@@ -234,6 +240,9 @@ struct asus_wmi {
 	bool dgpu_disable_available;
 	bool dgpu_disable;
 
+	bool keyboard_rgb_mode_available;
+	struct keyboard_rgb_led keyboard_rgb_mode;
+
 	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
 
@@ -1028,6 +1037,35 @@ static enum led_brightness lightbar_led_get(struct led_classdev *led_cdev)
 	return result & ASUS_WMI_DSTS_LIGHTBAR_MASK;
 }
 
+static int tuf_rgb_brightness_set(struct led_classdev *cdev,
+	enum led_brightness brightness)
+{
+	u8 r, g, b;
+	int err;
+	u32 ret;
+
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
+
+	led_mc_calc_color_components(mc_cdev, brightness);
+	r = mc_cdev->subled_info[0].brightness;
+	g = mc_cdev->subled_info[1].brightness;
+	b = mc_cdev->subled_info[2].brightness;
+
+	/* Writing out requires some defaults. This will overwrite boot mode */
+	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, ASUS_WMI_DEVID_TUF_RGB_MODE,
+			1 | 0 | (r << 16) | (g << 24), (b) | 0, &ret);
+	if (err) {
+		pr_err("Unable to set TUF RGB data?\n");
+		return err;
+	}
+	return 0;
+}
+
+static enum led_brightness tuf_rgb_brightness_get(struct led_classdev *cdev)
+{
+	return cdev->brightness;
+}
+
 static void asus_wmi_led_exit(struct asus_wmi *asus)
 {
 	led_classdev_unregister(&asus->kbd_led);
@@ -1105,6 +1143,57 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 					   &asus->lightbar_led);
 	}
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE)) {
+		struct led_classdev_mc *mc_cdev;
+		struct mc_subled *mc_led_info;
+		u8 brightness = 127;
+
+		mc_cdev = &asus->keyboard_rgb_mode.dev;
+
+		/*
+		 * asus::kbd_backlight still controls a base 3-level backlight and when
+		 * it is on 0, the RGB is not visible at all. RGB should be treated as
+		 * an additional step.
+		 */
+		mc_cdev->led_cdev.name = "asus::multicolour::kbd_backlight";
+		mc_cdev->led_cdev.flags = LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
+		mc_cdev->led_cdev.brightness_set_blocking = tuf_rgb_brightness_set;
+		mc_cdev->led_cdev.brightness_get = tuf_rgb_brightness_get;
+
+		/* Let the multicolour LED own the info */
+		mc_led_info = devm_kmalloc_array(
+			&asus->platform_device->dev,
+			3,
+			sizeof(*mc_led_info),
+			GFP_KERNEL | __GFP_ZERO);
+
+		if (!mc_led_info)
+			return -ENOMEM;
+
+		mc_led_info[0].color_index = LED_COLOR_ID_RED;
+		mc_led_info[1].color_index = LED_COLOR_ID_GREEN;
+		mc_led_info[2].color_index = LED_COLOR_ID_BLUE;
+
+		/*
+		 * It's not possible to get last set data from device so set defaults
+		 * to make it safe for a user to change either RGB or modes. We don't
+		 * write these defaults to the device because they will overwrite a
+		 * users last saved boot setting (in NVRAM).
+		 */
+		mc_cdev->led_cdev.brightness = brightness;
+		mc_cdev->led_cdev.max_brightness = brightness;
+		mc_led_info[0].intensity = brightness;
+		mc_led_info[0].brightness = mc_cdev->led_cdev.brightness;
+		mc_led_info[1].brightness = mc_cdev->led_cdev.brightness;
+		mc_led_info[2].brightness = mc_cdev->led_cdev.brightness;
+		led_mc_calc_color_components(mc_cdev, brightness);
+
+		mc_cdev->subled_info = mc_led_info;
+		mc_cdev->num_colors = 3;
+
+		rv = led_classdev_multicolor_register(&asus->platform_device->dev, mc_cdev);
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B2D58A7F1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbiHEITm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240452AbiHEITi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:19:38 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52D376475;
        Fri,  5 Aug 2022 01:19:28 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id AAF1E3200932;
        Fri,  5 Aug 2022 04:19:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 05 Aug 2022 04:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659687567; x=1659773967; bh=6F
        Ir+3fPqsQlJ20uPc+zMBgCGn6g7Z4u7vl/yRAlbVk=; b=WZBYKXppy+Egjfd/vv
        tJvd7oZl+hZku5/8fjofasv/b/aWNdJyBoicW3LOaxSpO5Kn4XVlqRdfx4kjR9CL
        nE7p+Ggy5T4R3YZ1lssBjzy6RCtsIIeEZ/9kS7tQTMCeMpVvdE69m+B3xR+4zpYA
        9MF4sOekolse6aseq77SFHKwUzWHQaG7UIkfIYsTe/Rs/RX2SFl5Zx313bMveKxy
        Mlrt3gpBeRCDw6MuKSdhpBhwQmCe4aY4qXcbfPqSArnos/L8v9kWkGkdtT9PSOOm
        lWvHjlW+DOIeso6nfBhvtoeSKwG8HMoUUvqjGX34Hr77hZPH/iQ6GY27XBH456/m
        nANw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659687567; x=1659773967; bh=6FIr+3fPqsQlJ
        20uPc+zMBgCGn6g7Z4u7vl/yRAlbVk=; b=bB7dgVVILbHkWRZvR4229YXm8ZcWN
        yKRbe7v2qkcF+QbM2x6LSySZINLauBw0+rEQUOtCuww+6NO7GaWi2S0h1Ajzf+qd
        LnQ26uVUQClQ44/KEZ4b68rGl3C9KbgRwsM30Y8Lx5idX5EPFDLkBXaUf0LPHHjW
        /89lEp72fhc8tbeBumrarhytHtg4XkCC7wFdLCzo4FP/6GV9xX4f/OKWkMRDCc7A
        cJy5OaUX9v19CAu5P5tB4Mp/ilYH34sK0+vK0GcWjY8UvTrMWgXLW3CEow2CaueG
        QDDqLDuB40U7fkLAOeXXu6pKJpCO+atxGosmMjbkTaF3ucHgK/UDFeQqQ==
X-ME-Sender: <xms:jtLsYjoy1sLgsLBia2oAsX4YG2Ye8smvDXph_7N2vs5X-Q-6R6BZDQ>
    <xme:jtLsYtqawUcyGfir1-QYC7k9QdrKCw3OnbW5bIbsx1XLF_dJD_BQgzpXrAYLN1Zrx
    _bquJ8GgUsuVkSfzvg>
X-ME-Received: <xmr:jtLsYgMj50K1CEqYrVIGfPWGiXonxf_IFQbuz73nen1Bj2V0mOUTIBpREmke>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefuddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:j9LsYm4Ghku_4zagA7_CyODzkTADPFY4JTLgsXIRWSpYdM9oSsioUg>
    <xmx:j9LsYi5Vgx_0FlF6xvT5TkXwhUPikBgxtJg_Fna1j0esWxjfLWmlCQ>
    <xmx:j9LsYug0wVQkYpphWI11u9G9OIZY8Qa6tNb0mEEFQlZ8qG5LKMESZw>
    <xmx:j9LsYiGaRkCigB1hCk1aLyzogpNsnYI5Eqo_3FtHWtwEGUJyH8MxXg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Aug 2022 04:19:24 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 2/5] asus-wmi: Add support for TUF laptop keyboard RGB mode control
Date:   Fri,  5 Aug 2022 20:19:06 +1200
Message-Id: <20220805081909.10962-3-luke@ljones.dev>
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

Adds support for TUF laptop RGB mode control.

Two paths are added:
- /sys/devices/platform/asus-nb-wmi/kernel_rgb_mode
- /sys/devices/platform/asus-nb-wmi/kernel_rgb_mode_index

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 86 +++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 33384e3321bb..9e6b83d8dd75 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -118,6 +118,9 @@ static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
 static int throttle_thermal_policy_write(struct asus_wmi *);
 
+static int tuf_rgb_brightness_set(struct led_classdev *cdev,
+							enum led_brightness brightness);
+
 static bool ashs_present(void)
 {
 	int i = 0;
@@ -194,6 +197,9 @@ struct fan_curve_data {
 struct keyboard_rgb_led {
 	struct led_classdev_mc dev;
 	struct mc_subled subled_info[3]; /* r g b */
+	u8 save;
+	u8 mode;
+	u8 speed;
 };
 
 struct asus_wmi {
@@ -743,6 +749,72 @@ static ssize_t egpu_enable_store(struct device *dev,
 
 static DEVICE_ATTR_RW(egpu_enable);
 
+/* TUF Laptop Keyboard RGB Modes **********************************************/
+static int keyboard_rgb_mode_check_present(struct asus_wmi *asus)
+{
+	u32 result;
+	int err;
+
+	asus->keyboard_rgb_mode_available = false;
+
+	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_TUF_RGB_MODE, &result);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		return err;
+	}
+
+	if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
+		asus->keyboard_rgb_mode_available = true;
+	}
+
+	return 0;
+}
+
+static ssize_t keyboard_rgb_mode_store(struct device *device,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	u8 save, mode, speed;
+	int err;
+
+	struct asus_wmi *asus = dev_get_drvdata(device);
+	struct led_classdev *cdev = &asus->keyboard_rgb_mode.dev.led_cdev;
+
+	if (sscanf(buf, "%hhd %hhd %hhd", &save, &mode, &speed) != 3)
+		return -EINVAL;
+
+	asus->keyboard_rgb_mode.save = save > 0 ? 1 : 0;
+
+	/* These are the known usable modes across all TUF/ROG */
+	asus->keyboard_rgb_mode.mode = mode < 12 && mode != 9 ? mode : 0x0a;
+
+	if (speed == 0)
+		asus->keyboard_rgb_mode.speed = 0xe1;
+	else if (speed == 1)
+		asus->keyboard_rgb_mode.speed = 0xeb;
+	else if (speed == 2)
+		asus->keyboard_rgb_mode.speed = 0xf5;
+	else
+		asus->keyboard_rgb_mode.speed = 0xeb;
+
+	err = tuf_rgb_brightness_set(cdev, cdev->brightness);
+	if (err)
+		return err;
+	return 0;
+}
+
+static DEVICE_ATTR_WO(keyboard_rgb_mode);
+
+static ssize_t keyboard_rgb_mode_index_show(struct device *device,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	return sysfs_emit(buf, "%s\n", "save mode speed\n");
+}
+
+static DEVICE_ATTR_RO(keyboard_rgb_mode_index);
+
 /* Battery ********************************************************************/
 
 /* The battery maximum charging percentage */
@@ -1180,6 +1252,9 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 		 * write these defaults to the device because they will overwrite a
 		 * users last saved boot setting (in NVRAM).
 		 */
+		asus->keyboard_rgb_mode.save = 1;
+		asus->keyboard_rgb_mode.mode = 0;
+		asus->keyboard_rgb_mode.speed = 1;
 		mc_cdev->led_cdev.brightness = brightness;
 		mc_cdev->led_cdev.max_brightness = brightness;
 		mc_led_info[0].intensity = brightness;
@@ -3347,6 +3422,8 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_touchpad.attr,
 	&dev_attr_egpu_enable.attr,
 	&dev_attr_dgpu_disable.attr,
+	&dev_attr_keyboard_rgb_mode.attr,
+	&dev_attr_keyboard_rgb_mode_index.attr,
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
@@ -3377,6 +3454,10 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->egpu_enable_available;
 	else if (attr == &dev_attr_dgpu_disable.attr)
 		ok = asus->dgpu_disable_available;
+	else if (attr == &dev_attr_keyboard_rgb_mode.attr)
+		ok = asus->keyboard_rgb_mode_available;
+	else if (attr == &dev_attr_keyboard_rgb_mode_index.attr)
+		ok = asus->keyboard_rgb_mode_available;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
@@ -3646,6 +3727,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_dgpu_disable;
 
+	err = keyboard_rgb_mode_check_present(asus);
+	if (err)
+		goto fail_keyboard_rgb_mode;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
@@ -3760,6 +3845,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_fan_boost_mode:
 fail_egpu_enable:
 fail_dgpu_disable:
+fail_keyboard_rgb_mode:
 fail_platform:
 fail_panel_od:
 	kfree(asus);
-- 
2.37.1


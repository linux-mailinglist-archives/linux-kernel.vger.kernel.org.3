Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B0058D21A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 04:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiHICv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 22:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiHICvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 22:51:15 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7407A1E3DE;
        Mon,  8 Aug 2022 19:51:14 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D00A75C0046;
        Mon,  8 Aug 2022 22:51:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 08 Aug 2022 22:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660013473; x=1660099873; bh=gE
        pD7e0phpvDHfZqNwT6fJk1Mqt4jaxDnSrfoJgQ/BY=; b=hwTnS4yC7MPu5vjEUr
        9BxGBZcbCL4ouUWdy9ENW4zvTWPzmF76IH4nUkq5kTRwYaliCj/txvpVQlTRWgbF
        Oqf/xMoWGNr9Nt5B9XUgZiiS9cItAz86Cto8TaMpKDRXSSPyS0xpo2GR+alfjAFr
        8NKbYVSJEzK+Ma9QQQoxlWqQfnG1AoveX2W5cBb/Z6hbS0AsHI8ucHFirWDu999v
        OCd5j1J+5q2GMOpnKUpkYXcTlenkd6oLGc/GLp4X6PyETrr0MP1GSxBP0mEMtNG/
        PxvzPH/YVEbK2l4SQyuMhva8znJII6Cjp9P+HMlCwKMpPTM9nIlcmV2E37dJnbQK
        YfCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660013473; x=1660099873; bh=gEpD7e0phpvDH
        fZqNwT6fJk1Mqt4jaxDnSrfoJgQ/BY=; b=tYOGkjo+929VmnRVZtExjsc9C/v05
        M4osAgSfBw2tup/Dqv9U61nFCXYkYdI2f9GJHHxRcdMVO6/o2PYjJiL+9LpQnY1w
        akIV+8gyGrLqfj2jCYTO7pH8kQVjXKts9gKQKidRrGzS/+i5srZCaATV4n6hBXuT
        KIyv7+QxeiEYWsDvrWjONEQiidJjYLrOJyHEC2pRfDXqeTNSFSppfRHSeKmfm1W0
        bnFLU3txhrcKMmMpxPnKKrTPZ+OBDwGGrih+9/OJd3JwnD9JcB0g66N74KQj9z4z
        j7hk+scVj/xIIaEyUXe3SPmobRqZjry8NJrXtmlb0cvaRJjI8ZnTCDYVw==
X-ME-Sender: <xms:ocvxYtI8hLbePYM1La_zWLaQLYlLxBWhrFL3I0TAFDeuP6B7FCHxMw>
    <xme:ocvxYpKtgPqGzVyy41zGi8jduHLL4hnWtOg-QB3AONVyd2U94OLJaIf9-D-uQdVba
    gwI851qk2cx80v7rdU>
X-ME-Received: <xmr:ocvxYltrs9q4mGfbLDKR6jjvbI_DGKxY3AAG6e1oNowdx4IHwcgxnnJRGHnW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefledgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:ocvxYubjn3cZbr6NYIgY_Pw4QbuVftas7SppXOfGfXrg4kODMQQSOQ>
    <xmx:ocvxYkZxIF5l1J9XxYtmWKtKEZeGSrcpMsveHfR51wVu0WqLXBh7KQ>
    <xmx:ocvxYiC7A9vYnW2KGofQsKWpmIJYl1iLH_aaUiQtVws66mEjXPAB1w>
    <xmx:ocvxYrXre995scIYInGDkWcJR3zP_JcmKsQuIVOG_BLYuApzPD0S6w>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 22:51:11 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     andy.shevchenko@gmail.com, pobrn@protonmail.com, pavel@ucw.cz,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 2/6] asus-wmi: Implement TUF laptop keyboard LED modes
Date:   Tue,  9 Aug 2022 14:50:50 +1200
Message-Id: <20220809025054.1626339-3-luke@ljones.dev>
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

Adds support for changing the laptop keyboard LED modes. These
are visible effects such as static, rainbow, pulsing, colour cycles.

These sysfs attributes are added to asus-nb-wmi:
- keyboard_rgb_save
- keyboard_rgb_mode
- keyboard_rgb_speed

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       |  30 +++++
 drivers/platform/x86/asus-wmi.c               | 127 ++++++++++++++++--
 2 files changed, 149 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 04885738cf15..a9128fa5cc65 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -57,3 +57,33 @@ Description:
 			* 0 - default,
 			* 1 - overboost,
 			* 2 - silent
+
+What:		/sys/devices/platform/<platform>/keyboard_rgb_save
+Date:		Aug 2022
+KernelVersion:	6.1
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set or save the RGB mode details (write-only):
+			* 0 - set, the settings will be lost on boot
+			* 1 - save, the settings will be retained on boot
+
+What:		/sys/devices/platform/<platform>/keyboard_rgb_mode
+Date:		Aug 2022
+KernelVersion:	6.1
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set the mode of the RGB keyboard, the mode will not apply until the
+		keyboard_rgb_save attribute is set (write-only):
+			* 0 to 12, each is an RGB such as static, rainbow, pulse.
+				Not all keyboards accept every mode.
+
+What:		/sys/devices/platform/<platform>/keyboard_rgb_speed
+Date:		Aug 2022
+KernelVersion:	6.1
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set the speed of the selected RGB effect, the speed will not apply
+		until the keyboard_rgb_save attribute is set (write-only):
+			* 0 - slow
+			* 1 - medium
+			* 2 - fast
\ No newline at end of file
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 233e73f4313d..fa0cc2895a66 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -246,7 +246,8 @@ struct asus_wmi {
 	bool dgpu_disable_available;
 	bool dgpu_disable;
 
-	struct keyboard_rgb_led keyboard_rgb_mode;
+	bool keyboard_rgb_mode_available;
+	struct keyboard_rgb_led keyboard_rgb_led;
 
 	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
@@ -748,6 +749,102 @@ static ssize_t egpu_enable_store(struct device *dev,
 
 static DEVICE_ATTR_RW(egpu_enable);
 
+/* TUF Laptop Keyboard RGB Modes **********************************************/
+static int keyboard_rgb_check_present(struct asus_wmi *asus)
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
+	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
+		asus->keyboard_rgb_mode_available = true;
+
+	return 0;
+}
+
+static ssize_t keyboard_rgb_save_store(struct device *device,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	u8 save;
+	int err;
+
+	struct asus_wmi *asus = dev_get_drvdata(device);
+	struct led_classdev *cdev = &asus->keyboard_rgb_led.dev.led_cdev;
+
+	if (sscanf(buf, "%hhd", &save) != 1)
+		return -EINVAL;
+
+	asus->keyboard_rgb_led.save = !!save;
+
+	err = tuf_rgb_brightness_set(cdev, cdev->brightness);
+	if (err)
+		return err;
+
+	return count;
+}
+static DEVICE_ATTR_WO(keyboard_rgb_save);
+
+static ssize_t keyboard_rgb_mode_store(struct device *device,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	u8 mode;
+
+	struct asus_wmi *asus = dev_get_drvdata(device);
+
+	if (sscanf(buf, "%hhd", &mode) != 1)
+		return -EINVAL;
+
+	/* These are the known usable modes across all TUF/ROG */
+	if (mode >= 12 || mode == 10)
+	  asus->keyboard_rgb_led.mode = 10;
+	else
+	  asus->keyboard_rgb_led.mode = mode;
+
+	return count;
+}
+static DEVICE_ATTR_WO(keyboard_rgb_mode);
+
+
+static ssize_t keyboard_rgb_speed_store(struct device *device,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	u8 speed;
+
+	struct asus_wmi *asus = dev_get_drvdata(device);
+
+	if (sscanf(buf, "%hhd", &speed) != 1)
+		return -EINVAL;
+
+	switch (speed) {
+	case 0:
+		asus->keyboard_rgb_led.speed = 0xe1;
+		break;
+	case 1:
+		asus->keyboard_rgb_led.speed = 0xeb;
+		break;
+	case 2:
+		asus->keyboard_rgb_led.speed = 0xf5;
+		break;
+	default:
+		asus->keyboard_rgb_led.speed = 0xeb;
+		break;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_WO(keyboard_rgb_speed);
+
 /* Battery ********************************************************************/
 
 /* The battery maximum charging percentage */
@@ -1047,7 +1144,7 @@ static int tuf_rgb_brightness_set(struct led_classdev *cdev,
 {
 	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
 	struct keyboard_rgb_led *rgb = container_of(mc_cdev, struct keyboard_rgb_led, dev);
-	struct asus_wmi *asus = container_of(rgb, struct asus_wmi, keyboard_rgb_mode);
+	struct asus_wmi *asus = container_of(rgb, struct asus_wmi, keyboard_rgb_led);
 	struct device *dev = &asus->platform_device->dev;
 	u8 r, g, b;
 	int err;
@@ -1075,7 +1172,7 @@ static void asus_wmi_led_exit(struct asus_wmi *asus)
 	led_classdev_unregister(&asus->tpd_led);
 	led_classdev_unregister(&asus->wlan_led);
 	led_classdev_unregister(&asus->lightbar_led);
-	led_classdev_multicolor_unregister(&asus->keyboard_rgb_mode.dev);
+	led_classdev_multicolor_unregister(&asus->keyboard_rgb_led.dev);
 
 	if (asus->led_workqueue)
 		destroy_workqueue(asus->led_workqueue);
@@ -1148,8 +1245,8 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 	}
 
 	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE)) {
-		struct mc_subled *mc_led_info = asus->keyboard_rgb_mode.subled_info;
-		struct led_classdev_mc *mc_cdev = &asus->keyboard_rgb_mode.dev;
+		struct mc_subled *mc_led_info = asus->keyboard_rgb_led.subled_info;
+		struct led_classdev_mc *mc_cdev = &asus->keyboard_rgb_led.dev;
 		struct device *dev = &asus->platform_device->dev;
 		u8 led_brightness = 255;
 
@@ -1174,9 +1271,9 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 		 * It's not possible to get last set data from device so set defaults
 		 * to make it safe for a user to change either RGB or modes.
 		 */
-		asus->keyboard_rgb_mode.save = 1;
-		asus->keyboard_rgb_mode.mode = 0;
-		asus->keyboard_rgb_mode.speed = 0xeb;
+		asus->keyboard_rgb_led.save = 1;
+		asus->keyboard_rgb_led.mode = 0;
+		asus->keyboard_rgb_led.speed = 0xeb;
 
 		mc_cdev->led_cdev.brightness = led_brightness;
 		mc_cdev->led_cdev.max_brightness = led_brightness;
@@ -3338,6 +3435,9 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_touchpad.attr,
 	&dev_attr_egpu_enable.attr,
 	&dev_attr_dgpu_disable.attr,
+	&dev_attr_keyboard_rgb_save.attr,
+	&dev_attr_keyboard_rgb_mode.attr,
+	&dev_attr_keyboard_rgb_speed.attr,
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
@@ -3368,6 +3468,12 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->egpu_enable_available;
 	else if (attr == &dev_attr_dgpu_disable.attr)
 		ok = asus->dgpu_disable_available;
+	else if (attr == &dev_attr_keyboard_rgb_save.attr)
+		ok = asus->keyboard_rgb_mode_available;
+	else if (attr == &dev_attr_keyboard_rgb_mode.attr)
+		ok = asus->keyboard_rgb_mode_available;
+	else if (attr == &dev_attr_keyboard_rgb_speed.attr)
+		ok = asus->keyboard_rgb_mode_available;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
@@ -3637,6 +3743,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_dgpu_disable;
 
+	err = keyboard_rgb_check_present(asus);
+	if (err)
+		goto fail_keyboard_rgb_mode;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
@@ -3751,6 +3861,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_fan_boost_mode:
 fail_egpu_enable:
 fail_dgpu_disable:
+fail_keyboard_rgb_mode:
 fail_platform:
 fail_panel_od:
 	kfree(asus);
-- 
2.37.1


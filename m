Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F915894B5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 01:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbiHCXQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 19:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiHCXQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 19:16:41 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A659B20BD8;
        Wed,  3 Aug 2022 16:16:40 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id ED22D5C0113;
        Wed,  3 Aug 2022 19:16:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 03 Aug 2022 19:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1659568599; x=1659654999; bh=0KtZUGT/r4jUPqmRHu58LHELi
        VItptS4djdXgrpCwQw=; b=OY6UITahY0KWbYFarWwek+WA3EwaKg3JMFdXSV09i
        1oLcmWd+JhThAW5Vq8avKFBZ1HBI5aYI/wWr1okAaBvlHZp+csrCTisYbVkHMkkr
        +PnUXHFe/AOnAMFS2qjKmSQvdvu7c0MdNEwc9VQ3OUFYcdI2UmbFvcMdavvrZnDB
        DAwwP+YYBdo6PVxs11kdMh3L8Ha83rmatyFxTPWpabnOoDAeg1GhnQL56zpRr4WD
        ERWYGUOmsvw05Z84r3+0URMrgZlH9XSSPVnh7bZsbxq3jTZ6a/z/FQccdbX0T5wK
        f8lSfFpqpr1gyvqlp8dvkmO5hy6IJmZV0OeUItHtXx/+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1659568599; x=1659654999; bh=0KtZUGT/r4jUPqmRHu58LHELiVItptS4djd
        XgrpCwQw=; b=xZxgyPzBSx9hTRJJhB83QA5iT4JItQ0TpvDOPPXnHPdCakK3dGL
        YQcWxv6OPlTOg/VX6wv0lj9EU/gX8faKN7jlIdrUTXW/GNzmzCrWh9Ym8mCDkiqD
        Aagb43OaQUbvrCAIcN5xNGKUbmlZ0P4/65ZQ77tOGzoxdO9Vi/LzAlIZU31hK+Hw
        raak85sb7pXqPyNGQyvF2Q21uajSRZiIY9W4HkbNbMm1cRSgCZTiTxQLA5a0u0sZ
        12Roce8CfFtSsbMqk65BKrfxQ3H09QDebAFoTxL1/ByM8+fwgIIEKlxZhEdBDp1a
        5NYZTW58JmBAK4UjHmnWQHvj/6oR+drHZDQ==
X-ME-Sender: <xms:1wHrYjTANVhnF5JrVGVdtRTWjM0FLoSd6dfOX2fUMRlZ8F0__Idy9w>
    <xme:1wHrYkyqd2kx4jU5l4If5XJZFuwJrjc2SIxwkW8SnDEG-jvkwsaWgceWeJ8SvWrCU
    bRpeln0CVKuJOSDA50>
X-ME-Received: <xmr:1wHrYo0iZEjXf57oDqDmZ27lFLJ67s5fXdHBRJMUHI6WdC8XaxENqNSEQpZf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvkedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:1wHrYjDQjC5MRK-b2rtYp7MecUG7Op46aorlkpvEk5iUX_0FBuxQFQ>
    <xmx:1wHrYsiIgx0peF6VTU4iPbskis2Vo__HfFlAFiVJOXm_v3WKJmpYZQ>
    <xmx:1wHrYnqJK8ccqMMdj7nxjzI5fPUnwidStrXIS29kBEkgLfONwBB6oA>
    <xmx:1wHrYvvmmzl_sLIgj5gX1AMf1xRHtT_xJh3AzU-psWR-jLBfiOPe-A>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Aug 2022 19:16:36 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] asus-wmi: Add support for TUF laptop keyboard RGB
Date:   Thu,  4 Aug 2022 11:16:31 +1200
Message-Id: <20220803231631.49924-1-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
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

Adds support for TUF laptop RGB control. This adds a multicolor LED
device, and two sysfs paths for extra feature control.

/sys/devices/platform/asus-nb-wmi/tuf_krgb_mode_index provides
labels for the index fields as "save mode speed"

/sys/devices/platform/asus-nb-wmi/tuf_krgb_mode has the following
as input options via U8 "n n n":
- Save or set, if set, then settings revert on cold boot
- Mode, 0 = Static, 1 = Breathe, 2 = Colour cycle, 3 = Pulse
- Speed, 0 = Slow, 1 = Medium, 2 = Fast

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 213 +++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |   3 +
 2 files changed, 216 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 0e7fbed8a50d..2959f17047a8 100644
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
 
+struct tuf_rgb_led {
+	struct led_classdev_mc dev;
+	struct mc_subled subled_info[3]; /* r g b */
+	u8 save;
+	u8 mode;
+	u8 speed;
+};
+
 struct asus_wmi {
 	int dsts_id;
 	int spec;
@@ -234,6 +246,9 @@ struct asus_wmi {
 	bool dgpu_disable_available;
 	bool dgpu_disable;
 
+	bool tuf_krgb_mode_available;
+	struct tuf_rgb_led tuf_krgb_mode;
+
 	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
 
@@ -734,6 +749,116 @@ static ssize_t egpu_enable_store(struct device *dev,
 
 static DEVICE_ATTR_RW(egpu_enable);
 
+/* TUF Laptop Keyboard RGB Modes **********************************************/
+static int tuf_krgb_mode_check_present(struct asus_wmi *asus)
+{
+	u32 result;
+	int err;
+
+	asus->tuf_krgb_mode_available = false;
+
+	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_TUF_RGB_MODE, &result);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		return err;
+	}
+
+	if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
+		asus->tuf_krgb_mode_available = true;
+		/* set some sane defaults since we can't read this from WMI */
+		asus->tuf_krgb_mode.save = 1;
+		asus->tuf_krgb_mode.mode = 0;
+		asus->tuf_krgb_mode.speed = 1;
+	}
+
+	return 0;
+}
+
+static ssize_t tuf_krgb_mode_store(struct device *device,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	char *data, *part, *end;
+	u8 res, tmp, arg_num;
+	int err;
+
+	struct asus_wmi *asus = dev_get_drvdata(device);
+	struct led_classdev *cdev = &asus->tuf_krgb_mode.dev.led_cdev;
+
+	data = end = kstrdup(buf, GFP_KERNEL);
+	arg_num = 0;
+
+	while ((part = strsep(&end, " ")) != NULL) {
+		if (part == NULL)
+			return -1;
+
+		res = kstrtou8(part, 10, &tmp);
+		if (res)
+			return -1;
+
+		if (arg_num == 0)
+			asus->tuf_krgb_mode.save = tmp;
+		else if (arg_num == 1)
+			/* These are the known usable modes across all TUF/ROG */
+			asus->tuf_krgb_mode.mode = tmp < 12 && tmp != 9 ? tmp : 0x0a;
+		else if (arg_num == 2) {
+			if (tmp == 0)
+				asus->tuf_krgb_mode.speed = 0xe1;
+			else if (tmp == 1)
+				asus->tuf_krgb_mode.speed = 0xeb;
+			else if (tmp == 2)
+				asus->tuf_krgb_mode.speed = 0xf5;
+			else
+				asus->tuf_krgb_mode.speed = 0xeb;
+		}
+
+		arg_num += 1;
+	}
+
+	err = tuf_rgb_brightness_set(cdev, cdev->brightness);
+	if (err)
+		return err;
+	return 0;
+}
+
+static ssize_t tuf_krgb_mode_show(struct device *device,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(device);
+	u8 speed = asus->tuf_krgb_mode.speed;
+	int len;
+
+	if (speed == 0xe1)
+		speed = 0;
+	else if (speed == 0xeb)
+		speed = 1;
+	else if (speed == 0xf5)
+		speed = 2;
+	else
+		speed = 1;
+
+	len = sprintf(buf, "%d %d %d",
+						asus->tuf_krgb_mode.save,
+						asus->tuf_krgb_mode.mode,
+						speed);
+
+	return len;
+}
+
+static DEVICE_ATTR_RW(tuf_krgb_mode);
+
+static ssize_t tuf_krgb_mode_index_show(struct device *device,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	int len = sprintf(buf, "%s", "save mode speed\n");
+	return len;
+}
+
+static DEVICE_ATTR_RO(tuf_krgb_mode_index);
+
 /* Battery ********************************************************************/
 
 /* The battery maximum charging percentage */
@@ -1028,6 +1153,38 @@ static enum led_brightness lightbar_led_get(struct led_classdev *led_cdev)
 	return result & ASUS_WMI_DSTS_LIGHTBAR_MASK;
 }
 
+static int tuf_rgb_brightness_set(struct led_classdev *cdev,
+	enum led_brightness brightness)
+{
+	u8 r, g, b, mode, speed, save;
+	int err;
+	u32 ret;
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
+	struct asus_wmi *asus = container_of(mc_cdev, struct asus_wmi, tuf_krgb_mode.dev);
+
+	led_mc_calc_color_components(mc_cdev, brightness);
+	r = mc_cdev->subled_info[0].brightness;
+	g = mc_cdev->subled_info[1].brightness;
+	b = mc_cdev->subled_info[2].brightness;
+	/* 0 still sets the mode/rgb, but does not stick on reboot */
+	save = asus->tuf_krgb_mode.save == 1 ? 0xb5 : 0xb4;
+	mode = asus->tuf_krgb_mode.mode;
+	speed = asus->tuf_krgb_mode.speed;
+
+	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, ASUS_WMI_DEVID_TUF_RGB_MODE,
+			save | (mode << 8) | (r << 16) | (g << 24), (b) | (speed << 8), &ret);
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
@@ -1105,6 +1262,51 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 					   &asus->lightbar_led);
 	}
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE)) {
+		struct led_classdev_mc *mc_cdev;
+		struct mc_subled *mc_led_info;
+		u8 brightness = 127;
+
+		mc_cdev = &asus->tuf_krgb_mode.dev;
+
+		mc_cdev->led_cdev.name = "asus::multicolour";
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
+		/* It's not possible to get last set data from device so set defaults */
+		asus->tuf_krgb_mode.save = 1;
+		asus->tuf_krgb_mode.mode = 0;
+		asus->tuf_krgb_mode.speed = 1;
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
+		tuf_rgb_brightness_set(&mc_cdev->led_cdev, brightness);
+		rv = led_classdev_multicolor_register(&asus->platform_device->dev, mc_cdev);
+	}
+
 error:
 	if (rv)
 		asus_wmi_led_exit(asus);
@@ -3258,6 +3460,8 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_touchpad.attr,
 	&dev_attr_egpu_enable.attr,
 	&dev_attr_dgpu_disable.attr,
+	&dev_attr_tuf_krgb_mode.attr,
+	&dev_attr_tuf_krgb_mode_index.attr,
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
@@ -3288,6 +3492,10 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->egpu_enable_available;
 	else if (attr == &dev_attr_dgpu_disable.attr)
 		ok = asus->dgpu_disable_available;
+	else if (attr == &dev_attr_tuf_krgb_mode.attr)
+		ok = asus->tuf_krgb_mode_available;
+	else if (attr == &dev_attr_tuf_krgb_mode_index.attr)
+		ok = asus->tuf_krgb_mode_available;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
@@ -3557,6 +3765,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_dgpu_disable;
 
+	err = tuf_krgb_mode_check_present(asus);
+	if (err)
+		goto fail_tuf_krgb_mode;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
@@ -3671,6 +3883,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_fan_boost_mode:
 fail_egpu_enable:
 fail_dgpu_disable:
+fail_tuf_krgb_mode:
 fail_platform:
 fail_panel_od:
 	kfree(asus);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index a571b47ff362..5049c153a3fe 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -98,6 +98,9 @@
 /* dgpu on/off */
 #define ASUS_WMI_DEVID_DGPU		0x00090020
 
+/* TUF laptop RGB modes */
+#define ASUS_WMI_DEVID_TUF_RGB_MODE	0x00100056
+
 /* DSTS masks */
 #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
 #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002
-- 
2.37.1


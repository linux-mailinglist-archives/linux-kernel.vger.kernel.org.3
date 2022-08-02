Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16555587682
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 06:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiHBE6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 00:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiHBE6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 00:58:08 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8CA20F70;
        Mon,  1 Aug 2022 21:58:05 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D00145C0181;
        Tue,  2 Aug 2022 00:58:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 02 Aug 2022 00:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1659416282; x=1659502682; bh=UB5gR/FmsQ0i1wLcmF1rXIiEP
        SZnZsAQiAxjp8uWbrw=; b=EZnvDLi6MF5gvqKTs79nNvKicjgeX4kCFH0rFkQEY
        pl35H+ygXKRWkjBHRsKDmGGAZlgCuWUUDgA42jonIWMYfeHthlv7xuUyPXZmRC6v
        S+3kwe08szgylbMJVIebcehUkoypECTdD5uS/4eX8kGbPwLigifKXlIT7gmWp6Tc
        1zjdl/Hvl3McWZqf+ITD+Pe4aPVp+Ewk2wdWhB4ucq5PDSE/e1dta3tN5mnedPWF
        2jURpId2XGUblHbEx9Sq+nHLPf4k78FIH5o0SRbFHHhsV1EOfEVas2kbdJdItsV9
        8TJ4aptISu9IBA/mUlMvpF8Jxk5Pmwu2hO016Vc7CRXYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1659416282; x=1659502682; bh=UB5gR/FmsQ0i1wLcmF1rXIiEPSZnZsAQiAx
        jp8uWbrw=; b=bBu0GA/eJzsDr7iNt0xINkSEcYo7J4s0bHf4dYfLa4jjXiJSohS
        xWHzcclTjmp4JMLGowyUWbmCo8bkssgKJMVBAdO85rMSnrgkz0AYRtM+Ixm6grjB
        SuBWbzPcQc4BlGtlmzGia/kEdzFgJMV9gSrtCiBRF6pZqFQcRXF3gunlrBLm87ry
        eVbT6QgIHdiLfTBV9KO0c0VEQ60nMP5ffXcEszV6VSyzYU+Ev1yTBIjUhNZltN8D
        n8ralE1BWd+w4d+3KTIkfpOxQLtl4AHcGwUBoak0TqfBteKEstvXdn0RZzGBsIu2
        jbK6BdAY/eaqDqGo1YE1OiJ3MkbWUd6CrmQ==
X-ME-Sender: <xms:2q7oYgB7gwux_aOcHCfXMDmBgb75jzSXePzJ_bdXqqvj66NbocFEqA>
    <xme:2q7oYih7c7PvqG4F1tEDDjHCcgMscOHU4A55m5kvqteIV33AFir9cYuRKWbBUh1TC
    9aRBt3xaCdD4UpFKks>
X-ME-Received: <xmr:2q7oYjm4EVmNKxCxlx_jpfhS0_Qvd5ze3vIZny30Uk_srmshMFrd9txWBw7G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvgedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:2q7oYmwSfl_INEY7upOhXdNcA7GhROBRl7JD5wcLylCnrSrjKBqGxA>
    <xmx:2q7oYlSkDs3TNlMDRSTxRMzae8YQcob3ADLN00PXzrmzuRGNI4SaTw>
    <xmx:2q7oYhYMNk0FWMV4gtahePJpObK4rx2_MJzxYu3lpunjMREef0mrwQ>
    <xmx:2q7oYneeT9Q-jG4BHPZCK5zwiEtEDAKCuR3qK0deQlcGgeQfUbkwKg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Aug 2022 00:57:58 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] asus-wmi: Add support for TUF laptop keyboard RGB
Date:   Tue,  2 Aug 2022 16:57:35 +1200
Message-Id: <20220802045735.1565260-1-luke@ljones.dev>
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

Adds support for TUF laptop RGB control. This creates two sysfs
paths to add control of basic keyboard LEDs, and power states.

/sys/devices/platform/asus-nb-wmi/tuf_krgb_mode has the following
as input options via U8 "n, n, n, n, n":
- Save or set, if set, then settings revert on cold boot
- Mode, 0-8 for regular modes (if supported), 10-12 for "warning" styles
- Red, 0-255
- Green, 0-255
- Blue, 0-255
- Speed, 0 = Slow, 1 = Medium, 2 = Fast

/sys/devices/platform/asus-nb-wmi/tuf_krgb_state has the following
as input options via boolean "b b b b b":
- Save or set, if set, then settings revert on cold boot
- Boot, if true, the keyboard displays animation on boot
- Awake, if true, the keyboard LED's are on while device is awake
- Sleep, if true, the keyboard shows animation while device is suspended
- Keybaord, appears to have no effect

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 168 +++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |   6 +
 2 files changed, 174 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 62ce198a3463..09277bd98249 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -234,6 +234,9 @@ struct asus_wmi {
 	bool dgpu_disable_available;
 	bool dgpu_disable;
 
+	bool tuf_kb_rgb_mode_available;
+	bool tuf_kb_rgb_state_available;
+
 	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
 
@@ -734,6 +737,153 @@ static ssize_t egpu_enable_store(struct device *dev,
 
 static DEVICE_ATTR_RW(egpu_enable);
 
+/* TUF Laptop Keyboard RGB Modes **********************************************/
+static int tuf_kb_rgb_mode_check_present(struct asus_wmi *asus)
+{
+	u32 result;
+	int err;
+
+	asus->tuf_kb_rgb_mode_available = false;
+
+	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_TUF_RGB_MODE, &result);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		return err;
+	}
+
+	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
+		asus->tuf_kb_rgb_mode_available = true;
+
+	return 0;
+}
+
+static ssize_t tuf_kb_rgb_mode_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	int err;
+	u32 ret;
+	u8 res, tmp, arg_num;
+	char *data, *part, *end;
+	u8 cmd, mode, r, g,  b,  speed;
+
+	data = end = kstrdup(buf, GFP_KERNEL);
+	cmd = mode = r = g = b = speed = arg_num = 0;
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
+			// apply : set
+			cmd = tmp == 1 ? 0xb5 : 0xb4;
+		else if (arg_num == 1)
+			// From 0-8 are valid modes with 10-12 being "warning"
+			// style modes. All models have "pulse" mode 10.
+			mode = (tmp <= 12 && tmp != 9) ? tmp : 10;
+		else if (arg_num == 2)
+			r = tmp;
+		else if (arg_num == 3)
+			g = tmp;
+		else if (arg_num == 4)
+			b = tmp;
+		else if (arg_num == 5) {
+			if (tmp == 0)
+				speed = 0xe1;
+			else if (tmp == 1)
+				speed = 0xeb;
+			else if (tmp == 2)
+				speed = 0xf5;
+		}
+
+		arg_num += 1;
+	}
+
+	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, ASUS_WMI_DEVID_TUF_RGB_MODE,
+			cmd | (mode << 8) | (r << 16) | (g << 24), (b) | (speed << 8), &ret);
+	if (err)
+		return err;
+
+	kfree(data);
+	return count;
+}
+
+static DEVICE_ATTR_WO(tuf_kb_rgb_mode);
+
+/* TUF Laptop Keyboard RGB States *********************************************/
+static int tuf_kb_rgb_state_check_present(struct asus_wmi *asus)
+{
+	u32 result;
+	int err;
+
+	asus->tuf_kb_rgb_state_available = false;
+
+	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_TUF_RGB_STATE, &result);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		return err;
+	}
+
+	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
+		asus->tuf_kb_rgb_state_available = true;
+
+	return 0;
+}
+
+static ssize_t tuf_kb_rgb_state_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	int err;
+	u32 ret;
+	bool tmp;
+	char *data, *part, *end;
+	u8 save, flags, res, arg_num;
+
+	save = flags = arg_num = 0;
+	data = end = kstrdup(buf, GFP_KERNEL);
+
+	while ((part = strsep(&end, " ")) != NULL) {
+		if (part == NULL)
+			return -1;
+
+		res = kstrtobool(part, &tmp);
+		if (res)
+			return -1;
+
+		if (tmp) {
+			if (arg_num == 0) // save  :  set
+				save = tmp == 0 ? 0x0100 : 0x0000;
+			else if (arg_num == 1)
+				flags |= 0x02; // boot
+			else if (arg_num == 2)
+				flags |= 0x08; // awake
+			else if (arg_num == 3)
+				flags |= 0x20; // sleep
+			else if (arg_num == 4)
+				flags |= 0x80; // keyboard
+		}
+
+		arg_num += 1;
+	}
+
+	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS,
+			ASUS_WMI_DEVID_TUF_RGB_STATE, 0xBD | save | (flags << 16), 0, &ret);
+	if (err)
+		return err;
+
+	kfree(data);
+	return count;
+}
+
+static DEVICE_ATTR_WO(tuf_kb_rgb_state);
+
 /* Battery ********************************************************************/
 
 /* The battery maximum charging percentage */
@@ -3258,6 +3408,8 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_touchpad.attr,
 	&dev_attr_egpu_enable.attr,
 	&dev_attr_dgpu_disable.attr,
+	&dev_attr_tuf_kb_rgb_mode.attr,
+	&dev_attr_tuf_kb_rgb_state.attr,
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
@@ -3286,6 +3438,12 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		devid = ASUS_WMI_DEVID_ALS_ENABLE;
 	else if (attr == &dev_attr_egpu_enable.attr)
 		ok = asus->egpu_enable_available;
+	else if (attr == &dev_attr_tuf_kb_rgb_mode.attr)
+		ok = asus->tuf_kb_rgb_mode_available;
+	else if (attr == &dev_attr_tuf_kb_rgb_state.attr)
+		ok = asus->tuf_kb_rgb_state_available;
+	else if (attr == &dev_attr_dgpu_disable.attr)
+		ok = asus->dgpu_disable_available;
 	else if (attr == &dev_attr_dgpu_disable.attr)
 		ok = asus->dgpu_disable_available;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
@@ -3557,6 +3715,14 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_dgpu_disable;
 
+	err = tuf_kb_rgb_mode_check_present(asus);
+	if (err)
+		goto fail_tuf_kb_rgb_mode;
+
+	err = tuf_kb_rgb_state_check_present(asus);
+	if (err)
+		goto fail_tuf_kb_rgb_state;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
@@ -3671,6 +3837,8 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_fan_boost_mode:
 fail_egpu_enable:
 fail_dgpu_disable:
+fail_tuf_kb_rgb_mode:
+fail_tuf_kb_rgb_state:
 fail_platform:
 fail_panel_od:
 	kfree(asus);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index a571b47ff362..af4191fb0508 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -98,6 +98,12 @@
 /* dgpu on/off */
 #define ASUS_WMI_DEVID_DGPU		0x00090020
 
+/* TUF laptop RGB modes/colours */
+#define ASUS_WMI_DEVID_TUF_RGB_MODE	0x00100056
+
+/* TUF laptop RGB power/state */
+#define ASUS_WMI_DEVID_TUF_RGB_STATE	0x00100057
+
 /* DSTS masks */
 #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
 #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002
-- 
2.37.1


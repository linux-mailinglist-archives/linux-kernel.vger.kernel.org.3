Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DB358A7F3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbiHEITq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbiHEITj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:19:39 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8BF7694D;
        Fri,  5 Aug 2022 01:19:32 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 83E72320016F;
        Fri,  5 Aug 2022 04:19:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 05 Aug 2022 04:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659687571; x=1659773971; bh=qF
        dzaaxsfmZwByE4EHCv32coL86ZL1WSvSSI3UBpBls=; b=gs9EVLQ6IT4vkqy8B8
        o9Um6g02gDErxqIHsARE+0KxtKl7sspywXxu9cYgqPwlJha7UNsbUxSEDtL96ceg
        7MqsSBsbkgSq0z0roH0vlAlynBwjsmDfEYEn63TVYk2FAoTvtUGRr79lJ3F2DNV5
        QbomjlGkzPZlaEPXBiZxjLEA8+uKWhTF4Uzrw9sseTxfsbUh9QH0EtDwAYr6s2W2
        GcDCGLdadM/+tntk3tzkMrwxoMLtX7cJg21BwDeXW8v7uDDSxRni9v/CRDDBvyhj
        qL32XDoS+ozxWjJtze8IF7ynM0Qbhx3RJzWWWmzhKoAeHuzCn/i6GJo5FUFeK6iw
        Tcfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659687571; x=1659773971; bh=qFdzaaxsfmZwB
        yE4EHCv32coL86ZL1WSvSSI3UBpBls=; b=lIg7D8FMeOMpTLeydvYhCuD63WqmJ
        Zp0Eetgn32SR875xgZX+XPPve/P8tYsX4gjeXBDN1AivuCqBfjrs7Hu/ehDP6389
        PRBHt8xg/B8BUvu6wyyvV1QvpVL7TrtuPKJZILgoltgUIRe75jbkQMRBCk8DJkCB
        weX2ePdD3gzdArL4UlveLKGK3eFIlML9PNaPavjOjIxBJSt63UJxHr6mIKItQ6KU
        6So0altS5cClHIIjBLfVUS4gyF523V1B7KmINsBoDEpEeyRmZqp0s3WUAUaX2DcT
        hSTw4AHdfn45l7BinVb4Ui53bW697v0HXubtdu82yq/a9H06JGnDnmEyA==
X-ME-Sender: <xms:ktLsYqOgw2SO_Wy1n2JfZcsflfKLMf1DxcKYWF6jKiaDfpWRhP5KqA>
    <xme:ktLsYo_z12EZM7CChAS0jwePb-WnebyLVliAPNCSILDqP8Rup4r7w0VkjNdTPPjHZ
    _-UqKpTe5-swnrXKpg>
X-ME-Received: <xmr:ktLsYhSG-S55S_aD5YUPu5e-Z7S3ZhCY7HpaGnYFlPWDFn5TU47MiWflmISg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefuddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:ktLsYqt6B2YiQXtdIlYNFQtAxO-cJPmX7O1LDp9Yd4OekWH5rB6Ahg>
    <xmx:ktLsYiehTMWn-VYWCtuFqr0qA7q9MvTE_49wbMX2sN4WCFWP0I6Gyw>
    <xmx:ktLsYu1DRL1AQdxne24goNn19MbbvTighTgV6-2oSyyXO9ndVE3iNg>
    <xmx:k9LsYjoMZkdS2otLw5GGL761w-MTT8JvYUUcRmFKSztcq2NR0F-mKg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Aug 2022 04:19:28 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 3/5] asus-wmi: Add support for TUF laptop keyboard states
Date:   Fri,  5 Aug 2022 20:19:07 +1200
Message-Id: <20220805081909.10962-4-luke@ljones.dev>
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

Adds support for the TUF series laptop power states.

Adds two paths:
- /sys/devices/platform/asus-nb-wmi/keyboard_rgb_state
- /sys/devices/platform/asus-nb-wmi/keyboard_rgb_state_index

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 74 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  2 +
 2 files changed, 76 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 9e6b83d8dd75..ad758845edc0 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -246,6 +246,7 @@ struct asus_wmi {
 	bool dgpu_disable_available;
 	bool dgpu_disable;
 
+	bool keyboard_rgb_state_available;
 	bool keyboard_rgb_mode_available;
 	struct keyboard_rgb_led keyboard_rgb_mode;
 
@@ -815,6 +816,68 @@ static ssize_t keyboard_rgb_mode_index_show(struct device *device,
 
 static DEVICE_ATTR_RO(keyboard_rgb_mode_index);
 
+/* TUF Laptop Keyboard RGB States *********************************************/
+static int keyboard_rgb_state_check_present(struct asus_wmi *asus)
+{
+	u32 result;
+	int err;
+
+	asus->keyboard_rgb_state_available = false;
+
+	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_TUF_RGB_STATE, &result);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		return err;
+	}
+
+	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
+		asus->keyboard_rgb_state_available = true;
+
+	return 0;
+}
+
+static ssize_t keyboard_rgb_state_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	u8 flags, save, boot, awake, sleep, keyboard;
+	int err;
+	u32 ret;
+
+	flags = 0;
+	if (sscanf(buf, "%hhd %hhd %hhd %hhd %hhd", &save, &boot, &awake, &sleep, &keyboard) != 5)
+		return -EINVAL;
+
+	save = save == 0 ? 0x0100 : 0x0000;
+	if (boot)
+		flags |= 0x02;
+	if (awake)
+		flags |= 0x08;
+	if (sleep)
+		flags |= 0x20;
+	if (keyboard)
+		flags |= 0x80;
+
+	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS,
+			ASUS_WMI_DEVID_TUF_RGB_STATE, 0xBD | save | (flags << 16), 0, &ret);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static DEVICE_ATTR_WO(keyboard_rgb_state);
+
+static ssize_t keyboard_rgb_state_index_show(struct device *device,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	return sysfs_emit(buf, "%s\n", "save boot awake sleep keyboard\n");
+}
+
+static DEVICE_ATTR_RO(keyboard_rgb_state_index);
+
 /* Battery ********************************************************************/
 
 /* The battery maximum charging percentage */
@@ -3424,6 +3487,8 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_dgpu_disable.attr,
 	&dev_attr_keyboard_rgb_mode.attr,
 	&dev_attr_keyboard_rgb_mode_index.attr,
+	&dev_attr_keyboard_rgb_state.attr,
+	&dev_attr_keyboard_rgb_state_index.attr,
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
@@ -3458,6 +3523,10 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->keyboard_rgb_mode_available;
 	else if (attr == &dev_attr_keyboard_rgb_mode_index.attr)
 		ok = asus->keyboard_rgb_mode_available;
+	else if (attr == &dev_attr_keyboard_rgb_state.attr)
+		ok = asus->keyboard_rgb_state_available;
+	else if (attr == &dev_attr_keyboard_rgb_state_index.attr)
+		ok = asus->keyboard_rgb_state_available;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
@@ -3731,6 +3800,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_keyboard_rgb_mode;
 
+	err = keyboard_rgb_state_check_present(asus);
+	if (err)
+		goto fail_keyboard_rgb_state;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
@@ -3846,6 +3919,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_egpu_enable:
 fail_dgpu_disable:
 fail_keyboard_rgb_mode:
+fail_keyboard_rgb_state:
 fail_platform:
 fail_panel_od:
 	kfree(asus);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index d63c9945a17d..b5c966798ef8 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -100,6 +100,8 @@
 
 /* TUF laptop RGB control */
 #define ASUS_WMI_DEVID_TUF_RGB_MODE	0x00100056
+/* TUF laptop RGB state control */
+#define ASUS_WMI_DEVID_TUF_RGB_STATE	0x00100057
 
 /* DSTS masks */
 #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
-- 
2.37.1


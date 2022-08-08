Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC6D58C1F3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 05:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbiHHDFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 23:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiHHDEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 23:04:54 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D35BE00;
        Sun,  7 Aug 2022 20:04:54 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8BED45C00BB;
        Sun,  7 Aug 2022 23:04:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 07 Aug 2022 23:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659927893; x=1660014293; bh=9y
        mhlw5OBd0R31OGDXUQIgCyBNoT/mCLY7kSsYdQ0no=; b=T2x+ytYlV7rpiZxIQP
        7A6PN4taxbO7UGwxQOTYHc+IcW+4yjtjSHl953e4Txmtxjn9459/6+1D2A8MJ3tp
        QwvZTfKq+ViFnMU7IPAnkY7QUGs3ZCT1HIDf50MRYxZ2Kg9TJdbCPhzcJfKVmLhv
        VS7/7B1JbCXUz8V75zle0YfAafBOQ2AOdDLQcVo1DefCrFJBcY7ERI+oqAijV5Ka
        JbTFjNDIEZ+/N1XBzUkvfWJkPcDlymfOUFrrH7+1dxtaMERgwEnzneeaeBz15tNo
        oRPKjNGgEtt2fU7iZS8RXXhrLl1H2MJ/4Gdcg6rJvP16qdyrZ7OHsNZY6gbL0ts7
        72Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1659927893; x=1660014293; bh=9ymhlw5OBd0R3
        1OGDXUQIgCyBNoT/mCLY7kSsYdQ0no=; b=tzjv+GKld0GzoeS7Z/5Gqn8RQrgni
        IrhVgfdnWdiwAORTq3b2vEuZ0VLjrC6MzSnEp0m9e4v6wxH+pkSxYVNDJzXAAIa4
        MmEzoPn3A/EyGC97S4moV/n1Gos9s0ZxShI3mJSRdgpbafp0N6eSJFjdyEs8XunQ
        kdN3fN7TTMh8mq8aXUPdcOdIKzPGt30EhxUZNQ/QzNIxvR6zNU3ynna+g7E6vlrL
        Oh9Eg0FLWF4J4Gn6JwYI9zyBGEEtLQv+D9SON49sK8KGMqHLXc5usx3G4k8CKoPy
        wJSwUnTCUHmXaxvB83gs1JkiyP/QWdKgnFh3J7s8L6GFJnWmvNBtD0zkQ==
X-ME-Sender: <xms:VX3wYmRriWX_P1jkCZDayjHRx-dcaTwJ3bp57lnY4DbQMnHiskb1mw>
    <xme:VX3wYrytJLIQNiOULEs4c5C_eeolwFgOGhTDHeDXlFmLcse9EPUUR-rrZFfQJSe4q
    zRdAGZFQQBtJf7G_kk>
X-ME-Received: <xmr:VX3wYj05ZfZzG91f3Eht9FMqLSPWtFFe7pRKJQ0FuEVtTibKuEupqGx_zpYk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefjedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:VX3wYiCZpcnXah7v2iIJpPyLJDASBeoegFcab1Bvb2SucU1CsQMikg>
    <xmx:VX3wYvi22MjqyQ03DbmzMS8xVKl_Bm73woFHM_Ay-J2JWOSpJ6D43A>
    <xmx:VX3wYupTL3bTh78XfvnsRnFauxlWq7UwORqoBtg8ZQ-2vNsK4te12g>
    <xmx:VX3wYiurNrRstd2m7z8L1aamW72QFr-UyyiQHrOJzkdIRHNzX_5-MA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Aug 2022 23:04:51 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 2/6] asus-wmi: Implement TUF laptop keyboard LED modes
Date:   Mon,  8 Aug 2022 15:04:16 +1200
Message-Id: <20220808030420.8633-3-luke@ljones.dev>
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

Adds support for changing the laptop keyboard LED modes. These
are visible effects such as static, rainbow, pulsing, colour cycles.

Two sysfs attributes are added to asus-nb-wmi:
- keyboard_rgb_mode
- keyboard_rgb_mode_index

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 83 +++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 233e73f4313d..4c2bdd9dac30 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -246,6 +246,7 @@ struct asus_wmi {
 	bool dgpu_disable_available;
 	bool dgpu_disable;
 
+	bool keyboard_rgb_mode_available;
 	struct keyboard_rgb_led keyboard_rgb_mode;
 
 	bool throttle_thermal_policy_available;
@@ -748,6 +749,77 @@ static ssize_t egpu_enable_store(struct device *dev,
 
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
+	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
+		asus->keyboard_rgb_mode_available = true;
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
+	asus->keyboard_rgb_mode.save = !!save;
+
+	/* These are the known usable modes across all TUF/ROG */
+	asus->keyboard_rgb_mode.mode = mode < 12 && mode != 9 ? mode : 0x0a;
+
+	switch (speed) {
+	case 0:
+		asus->keyboard_rgb_mode.speed = 0xe1;
+		break;
+	case 1:
+		asus->keyboard_rgb_mode.speed = 0xeb;
+		break;
+	case 2:
+		asus->keyboard_rgb_mode.speed = 0xf5;
+		break;
+	default:
+		asus->keyboard_rgb_mode.speed = 0xeb;
+	}
+
+	err = tuf_rgb_brightness_set(cdev, cdev->brightness);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static DEVICE_ATTR_WO(keyboard_rgb_mode);
+
+static ssize_t keyboard_rgb_mode_index_show(struct device *device,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	return sysfs_emit(buf, "%s\n", "save mode speed");
+}
+
+static DEVICE_ATTR_RO(keyboard_rgb_mode_index);
+
 /* Battery ********************************************************************/
 
 /* The battery maximum charging percentage */
@@ -3338,6 +3410,8 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_touchpad.attr,
 	&dev_attr_egpu_enable.attr,
 	&dev_attr_dgpu_disable.attr,
+	&dev_attr_keyboard_rgb_mode.attr,
+	&dev_attr_keyboard_rgb_mode_index.attr,
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
@@ -3368,6 +3442,10 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
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
@@ -3637,6 +3715,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_dgpu_disable;
 
+	err = keyboard_rgb_mode_check_present(asus);
+	if (err)
+		goto fail_keyboard_rgb_mode;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
@@ -3751,6 +3833,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_fan_boost_mode:
 fail_egpu_enable:
 fail_dgpu_disable:
+fail_keyboard_rgb_mode:
 fail_platform:
 fail_panel_od:
 	kfree(asus);
-- 
2.37.1


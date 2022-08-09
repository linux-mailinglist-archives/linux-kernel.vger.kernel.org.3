Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E6758D21C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 04:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiHICvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 22:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiHICvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 22:51:19 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E8D192BF;
        Mon,  8 Aug 2022 19:51:17 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B9E615C01AC;
        Mon,  8 Aug 2022 22:51:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 08 Aug 2022 22:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660013476; x=1660099876; bh=tA
        FVuLEiq4n15PVSxtti2rN3Q28tmHpru0E3XtX5Hts=; b=lHB3Rx1VzDqmzo8cXD
        QrOOajjk4cY5kcKQjbc+GMRtMq6Z+oRTHqV3UPNCkfvTllj5ciEhKf1A6pvPVShY
        B/VqDj48wYjQEBKN8MWUL6lErvKgoIKOknbcMwlzT8KAsAb9UTvSl2HmBqoCGp99
        6tvl9z1i/bbl6f+rVLStZnsBN1x+b1uhYRez6awyNYR50G0bmCO8UwqyHV3SqTYc
        abqB3VoCnEXm4113RnL56nNblhIs5Fb/DXpP2XlObGIUTlLnKEvAH9vshfREy25f
        F7+HmE+g9mMm+fd4gddHI98o2G3T7BZtaBzaLjkSaDS7WW7JpBF6g3GghQRsx/le
        I41Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660013476; x=1660099876; bh=tAFVuLEiq4n15
        PVSxtti2rN3Q28tmHpru0E3XtX5Hts=; b=Fib8bFy7gvSGxyIl0RssTbLX6b+gF
        dL8dpcXKMhIX4cJ+vWwAly/fNkWvvzNnpjIlAJcl9+ry5Egw7pLfZexz0Xn5OZMW
        KmEUPVnu3YVUGAIAhPr8Qx5um5KkV0KBuSUzxMurn9Yng9tNt8pe/50otwuiQn7F
        p7mm9m71Hd4G9YXVy1U0nR6l5ba7dbTKYHonCDe3HiG35B0I7P4d0gP0JMv+b06e
        uSu3Y9b8XZWzJEkseZQ539J27eU9CzqMUGW8ag7FL5addYpZxZdGGRRGXoBkt8dM
        5AyyXDt/SCcWxGaADq30j3X41UfV8bIzFAdo9FTRSAFVJJljTOAm6XP6A==
X-ME-Sender: <xms:pMvxYvqdbuKRpuwhSyUMTEuBiA1tEfdAUoqfEhn8RqB-byHhUNHd-w>
    <xme:pMvxYpr7dYF-6OGRYz6UIfJV93p4kepcsU5FAzL6eY-MgWxmk6cQpZaBn9DvkIwFS
    G9LoISacxkUD2terJ0>
X-ME-Received: <xmr:pMvxYsPUoJSQ0TbSUajL3-BqNL8ybGbyXyDfahfilUOvxQPGpLFjW-KsWVeV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefledgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:pMvxYi41SUpiBomZpadgAo8PseIkdSP1rDncBc64RVY5IOWJSV4UAA>
    <xmx:pMvxYu68no0JIVwB2zzn20W9Hl-qQAKUTFW0BoUvu5r337NbT6UR6w>
    <xmx:pMvxYqjhovpjrAw3e3Fx3hd8wdVhuywlqdwuo-vgttXLqohiXWdfdw>
    <xmx:pMvxYp2YUSoDZutViWDFLVwR4ZAhuoCbXkZKruBkLHFv3K6N_tl6mg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 22:51:14 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     andy.shevchenko@gmail.com, pobrn@protonmail.com, pavel@ucw.cz,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 3/6] asus-wmi: Implement TUF laptop keyboard power states
Date:   Tue,  9 Aug 2022 14:50:51 +1200
Message-Id: <20220809025054.1626339-4-luke@ljones.dev>
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

Adds support for setting various power states of TUF keyboards.
These states are combinations of:
- boot, set if a boot animation is shown on keyboard
- awake, set if the keyboard LEDs are visible while laptop is on
- sleep, set if an animation is displayed while the laptop is suspended
- keyboard (unknown effect)

Adds two sysfs attributes to asus-nb-wmi:
- keyboard_rgb_state
- keyboard_rgb_state_index

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       | 18 ++++-
 drivers/platform/x86/asus-wmi.c               | 72 +++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h    |  2 +
 3 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index a9128fa5cc65..3e3f2dcf9bfa 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -86,4 +86,20 @@ Description:
 		until the keyboard_rgb_save attribute is set (write-only):
 			* 0 - slow
 			* 1 - medium
-			* 2 - fast
\ No newline at end of file
+			* 2 - fast
+
+What:		/sys/devices/platform/<platform>/keyboard_rgb_state
+Date:		Aug 2022
+KernelVersion:	6.1
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set some RGB keyboard power states (write-only).
+
+		The accepted input is "boot awake sleep keyboard", where "n n n n n"
+		options	are:
+			* save - 0 or 1, if 0 then settings are not retained on boot
+			* boot - 0 or 1, controls if a boot animation is shown
+			* awake - 0 or 1, controls if the keyboard LED are on during awake
+			* sleep - 0 or 1, controls if a suspended animation is shown.
+						This is only active if the AC is connected.
+			* keyboard - 0 or 1, unknown what effect this really has
\ No newline at end of file
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index fa0cc2895a66..719223804c0e 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -246,6 +246,7 @@ struct asus_wmi {
 	bool dgpu_disable_available;
 	bool dgpu_disable;
 
+	bool keyboard_rgb_state_available;
 	bool keyboard_rgb_mode_available;
 	struct keyboard_rgb_led keyboard_rgb_led;
 
@@ -845,6 +846,66 @@ static ssize_t keyboard_rgb_speed_store(struct device *device,
 }
 static DEVICE_ATTR_WO(keyboard_rgb_speed);
 
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
+static DEVICE_ATTR_WO(keyboard_rgb_state);
+
+static ssize_t keyboard_rgb_state_index_show(struct device *device,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	return sysfs_emit(buf, "%s\n", "save boot awake sleep keyboard");
+}
+static DEVICE_ATTR_RO(keyboard_rgb_state_index);
+
 /* Battery ********************************************************************/
 
 /* The battery maximum charging percentage */
@@ -3438,6 +3499,8 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_keyboard_rgb_save.attr,
 	&dev_attr_keyboard_rgb_mode.attr,
 	&dev_attr_keyboard_rgb_speed.attr,
+	&dev_attr_keyboard_rgb_state.attr,
+	&dev_attr_keyboard_rgb_state_index.attr,
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
@@ -3474,6 +3537,10 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->keyboard_rgb_mode_available;
 	else if (attr == &dev_attr_keyboard_rgb_speed.attr)
 		ok = asus->keyboard_rgb_mode_available;
+	else if (attr == &dev_attr_keyboard_rgb_state.attr)
+		ok = asus->keyboard_rgb_state_available;
+	else if (attr == &dev_attr_keyboard_rgb_state_index.attr)
+		ok = asus->keyboard_rgb_state_available;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
@@ -3747,6 +3814,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_keyboard_rgb_mode;
 
+	err = keyboard_rgb_state_check_present(asus);
+	if (err)
+		goto fail_keyboard_rgb_state;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
@@ -3862,6 +3933,7 @@ static int asus_wmi_add(struct platform_device *pdev)
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


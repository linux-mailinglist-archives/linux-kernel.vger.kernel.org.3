Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FAE58C1F1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 05:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbiHHDFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 23:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbiHHDE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 23:04:57 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D993BE00;
        Sun,  7 Aug 2022 20:04:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0CAD35C00E6;
        Sun,  7 Aug 2022 23:04:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 07 Aug 2022 23:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659927896; x=1660014296; bh=oO
        8D9D8rHRPyOxrPkAEHf4nClIeVCnqow+HgTegQJyY=; b=C7bqK3bsgKGCu70jlB
        VD8m6a9H37vhMf5iA4VQ/9DwLWvKOlTOBqMXhAxDnABgFYSebbtcZphmZN2znTpn
        zqt2UaqdNZznmD6UkJD+VUJ22VFDLJGX4P9BDU9wEkxrervlx93UCYZ4y6Cx/3OW
        D8UatXIKazs6IEAi1Bh8wSwY2hG3e9eEV53PfQQTq44QIIfGZw54XAbwLAfSHcDv
        ycF0tnf6Xwnr24EQB51BelhcvGt5PIuH0Hf/PBBrtMldv6lNOP/6nSfx9xiv64zq
        USqYevkoLt3FwfH7lRsaPXSF/jheLTSnUundzSSI1niyxFWoyKqFDIu3dYXq6Bqt
        BV9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1659927896; x=1660014296; bh=oO8D9D8rHRPyO
        xrPkAEHf4nClIeVCnqow+HgTegQJyY=; b=pwbJh9i8zcfVITeEFADbY82IF90NZ
        Nj8XAgRdei1Qnn9NTBzkdew1HvRm5gW+PMVClSNgvMiZGsTZlXERJyMev4aXuTWF
        vxxTUjwUg4rAqlc0SHllAF+SVW4hSOCjuI2nExSQ9SX9QzLU/B0TMof+dH+Wg7Xm
        cTV0sEOl5e//U78fhCvVM5knBQyak1P18FDdxKr2FY9+/IO+asgIT5xefbXrfusR
        Sowbmb2kGi38lN8h53IpIyLTMZBRgkyAo5ah9C/rZFpskpmF/ybi7KdkGpnWE0+8
        OO9RQjTs2ax4NN8zWbj7e4Enjx2GVPq0baSe7MqGw7HL9fXBbQ2KsheHw==
X-ME-Sender: <xms:V33wYjKSPl4Tv3ZrCqe0B0KcDDnMcaPWJInCrfI7v3wiFje__PEflA>
    <xme:V33wYnJHC8Ins1aTa9CPJ57pGSp2QT_-JUfiueC-zoDSZRUuekJTfleqhxnEQCmSb
    0jIZLoSpjEN51hVrRo>
X-ME-Received: <xmr:V33wYrsvdnEnpnIuc0tN7M15XkGukXx91UKs0jmYRb2D23hnG0JxTYgEpbCb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefjedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:V33wYsbAe-0RojQfhebLr_cWOCzTkmz86-9AgR9Ymtx6Ap2mTh2pBQ>
    <xmx:V33wYqa8rvMRrxLF5wI0Q9FHmv4lpnoE6NYmG1gBDEa5eBN13UTlXQ>
    <xmx:V33wYgAT0hwjvwYuqF5qT2Pqptsu1Tt-Sl7mpvR6KdPvepmGP1jo8Q>
    <xmx:WH3wYpl4eguX2g16faQPs-EWhajb3BIfpKQkI_j5K2O92Hh-qpRdtw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Aug 2022 23:04:53 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 3/6] asus-wmi: Implement TUF laptop keyboard power states
Date:   Mon,  8 Aug 2022 15:04:17 +1200
Message-Id: <20220808030420.8633-4-luke@ljones.dev>
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
 drivers/platform/x86/asus-wmi.c            | 74 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  2 +
 2 files changed, 76 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 4c2bdd9dac30..9b2c54726955 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -246,6 +246,7 @@ struct asus_wmi {
 	bool dgpu_disable_available;
 	bool dgpu_disable;
 
+	bool keyboard_rgb_state_available;
 	bool keyboard_rgb_mode_available;
 	struct keyboard_rgb_led keyboard_rgb_mode;
 
@@ -820,6 +821,68 @@ static ssize_t keyboard_rgb_mode_index_show(struct device *device,
 
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
+	return sysfs_emit(buf, "%s\n", "save boot awake sleep keyboard");
+}
+
+static DEVICE_ATTR_RO(keyboard_rgb_state_index);
+
 /* Battery ********************************************************************/
 
 /* The battery maximum charging percentage */
@@ -3412,6 +3475,8 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_dgpu_disable.attr,
 	&dev_attr_keyboard_rgb_mode.attr,
 	&dev_attr_keyboard_rgb_mode_index.attr,
+	&dev_attr_keyboard_rgb_state.attr,
+	&dev_attr_keyboard_rgb_state_index.attr,
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
@@ -3446,6 +3511,10 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
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
@@ -3719,6 +3788,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_keyboard_rgb_mode;
 
+	err = keyboard_rgb_state_check_present(asus);
+	if (err)
+		goto fail_keyboard_rgb_state;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
@@ -3834,6 +3907,7 @@ static int asus_wmi_add(struct platform_device *pdev)
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


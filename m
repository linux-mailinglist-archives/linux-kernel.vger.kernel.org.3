Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4985887A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbiHCHAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbiHCHAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:00:25 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301D81176;
        Wed,  3 Aug 2022 00:00:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 780465C0185;
        Wed,  3 Aug 2022 03:00:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 03 Aug 2022 03:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659510022; x=1659596422; bh=nS
        wP6MVaiDSi4+Goj3/xJnjvYKOD3d7RuvC91JzJnNk=; b=ULvtCiXwNgDuJcPk4O
        Tst4OaY11dV5xttFty3MYPNEldENn7TtQTQibE10zzL9Q5se5T0PMpDiInIM0/wB
        qmYbDbRzEJ/4brotB1VmGEvgDCeGs1RM9Xcaxnw19hmUS0Hed65OADAye3nJT4lm
        QyTByDGZcskaKZqgdzBK0v5KfprPoY09hapVlE24uz72kequPAgbeoUux3HnzLXH
        mj8d5MA0bZx5em9+XkUkowaBr5kD6MQxTGThbvy5G7s8rfTouhzplZPCEiAypqOi
        A4oZzbmH5ijWqeedMU3k8N8m0PQkxD1THLH2ACmLjghKswv2AMSKkX9kkrxlgkOd
        RnYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659510022; x=1659596422; bh=nSwP6MVaiDSi4
        +Goj3/xJnjvYKOD3d7RuvC91JzJnNk=; b=cWPTdkaqYShvRwTi3qbasGJA7kD11
        JFvFbBpuljvWSvGNgNCCVmiATyLl7hHbgQk1NIKvXyV4+NRZnVuks5hlf/OhYWph
        S7tj3nxN1jm8ldUSV/WI9ve3opqDwSzjLLhLRc2+jkoryD0pRIG+PA1wWOd3BSWr
        wRL/5Ti4OUC2ZRkKG8v4ZUTvzabXtJYuvpxRCS6erH75ocxw8G9V5fUKMXc+nNIe
        EwdYVSq+/LsDeIf0U/c4I5Ggwphn378ho/duxqnyGBfHnmVZX9APsM09BVOInXrT
        +bc0oeDTdilQLwQj/9VDAMizfIzhDH63vG/dKWDcZA3dHndFlTk2FOXyA==
X-ME-Sender: <xms:Bh3qYpmbxEWuwUKN2f-bJZkMceJNtZeyWNCTIx-7dUH5pXO17EPymw>
    <xme:Bh3qYk3Sg78usKPr6UmMGfSlkcSDG1KOiDjMemjp0dWtD-9wB3e2tVK7asa46ZOA7
    FUzngB6AzwGf3Cu1ek>
X-ME-Received: <xmr:Bh3qYvoQbpYhPM6Dn900qVauIt5HKKXdCFOOPEpkIB4Y9RhM3riT52aijuYu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddviedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvges
    lhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhf
    eugffgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:Bh3qYplCeaclkUEjKTH5_HTJI7BuE2E3mXK9PQyoN5i_1ZnD45J5JQ>
    <xmx:Bh3qYn2Vxo8cxnvCRn6DJqvaiWtJXb0oRgFkqfzTIwX3V-xgOO9RQA>
    <xmx:Bh3qYouQ_lfo3StMwaVXKmAPjOLV8g-oc898jXEPIlCzUfNW6ka2Rg>
    <xmx:Bh3qYlD1TdoRI6UYAnaNB1izJjuuw0kKQ57uz5C0iIgDgXnjRUbPbA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Aug 2022 03:00:20 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 1/1] asus-wmi: Add support for TUF laptop keyboard states
Date:   Wed,  3 Aug 2022 19:00:08 +1200
Message-Id: <20220803070008.770147-2-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220803070008.770147-1-luke@ljones.dev>
References: <20220803070008.770147-1-luke@ljones.dev>
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

Adds support for the TUF series laptop power states. This means
control of if the LED's are on while awake, or an animation is
shown while booting or suspended.

/sys/devices/platform/asus-nb-wmi/tuf_krgb_state has the following
as input options via boolean "b b b b b":
- Save or set, if set, then settings revert on cold boot
- Boot, if true, the keyboard displays animation on boot
- Awake, if true, the keyboard LED's are on while device is awake
- Sleep, if true, the keyboard shows animation while device is suspended
- Keybaord, appears to have no effect

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 82 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  3 +
 2 files changed, 85 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 0e7fbed8a50d..dffc29dbcf64 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -234,6 +234,8 @@ struct asus_wmi {
 	bool dgpu_disable_available;
 	bool dgpu_disable;
 
+	bool tuf_krgb_state_available;
+
 	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
 
@@ -734,6 +736,76 @@ static ssize_t egpu_enable_store(struct device *dev,
 
 static DEVICE_ATTR_RW(egpu_enable);
 
+/* TUF Laptop Keyboard RGB States *********************************************/
+static int tuf_krgb_state_check_present(struct asus_wmi *asus)
+{
+	u32 result;
+	int err;
+
+	asus->tuf_krgb_state_available = false;
+
+	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_TUF_RGB_STATE, &result);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		return err;
+	}
+
+	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
+		asus->tuf_krgb_state_available = true;
+
+	return 0;
+}
+
+static ssize_t tuf_krgb_state_store(struct device *dev,
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
+	if (err) {
+			return err;
+	}
+
+	kfree(data);
+	return count;
+}
+
+static DEVICE_ATTR_WO(tuf_krgb_state);
+
 /* Battery ********************************************************************/
 
 /* The battery maximum charging percentage */
@@ -3258,6 +3330,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_touchpad.attr,
 	&dev_attr_egpu_enable.attr,
 	&dev_attr_dgpu_disable.attr,
+	&dev_attr_tuf_krgb_state.attr,
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
@@ -3286,6 +3359,10 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		devid = ASUS_WMI_DEVID_ALS_ENABLE;
 	else if (attr == &dev_attr_egpu_enable.attr)
 		ok = asus->egpu_enable_available;
+	else if (attr == &dev_attr_tuf_krgb_state.attr)
+		ok = asus->tuf_krgb_state_available;
+	else if (attr == &dev_attr_dgpu_disable.attr)
+		ok = asus->dgpu_disable_available;
 	else if (attr == &dev_attr_dgpu_disable.attr)
 		ok = asus->dgpu_disable_available;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
@@ -3557,6 +3634,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_dgpu_disable;
 
+	err = tuf_krgb_state_check_present(asus);
+	if (err)
+		goto fail_tuf_krgb_state;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
@@ -3671,6 +3752,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_fan_boost_mode:
 fail_egpu_enable:
 fail_dgpu_disable:
+fail_tuf_krgb_state:
 fail_platform:
 fail_panel_od:
 	kfree(asus);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index a571b47ff362..a95b37385e66 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -98,6 +98,9 @@
 /* dgpu on/off */
 #define ASUS_WMI_DEVID_DGPU		0x00090020
 
+/* TUF laptop RGB power/state */
+#define ASUS_WMI_DEVID_TUF_RGB_STATE	0x00100057
+
 /* DSTS masks */
 #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
 #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002
-- 
2.37.1


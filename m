Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCB15886D6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 07:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbiHCFkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 01:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiHCFkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 01:40:16 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70501208A;
        Tue,  2 Aug 2022 22:40:14 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id CDD1132002E2;
        Wed,  3 Aug 2022 01:40:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 03 Aug 2022 01:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1659505211; x=1659591611; bh=3d0B77o3eBWwaP2xZ673IRtdc
        bfHIjwQwGGQLrMukF4=; b=XvQwn4Y8pQ7Y0rh7xfPXwhXLdfgAHL8DCJOkKxg0p
        A4Xl7KLjtCQTHulE9PNNFAphpIR0rhVr84nO3cKzoCiQAXexWFnbytDaBB25HYzr
        H0q3NOiolKNsrKm0N+bXbbPWF6hIgQF0upMw+SjWBJfK/p6IAY1go651deY6e/xQ
        EN9Ew35fxAyuU1nvER9jiRgd71L5AJz+aQcESUHpPSyr9IHcScqJuMcC8mwu/1rK
        uVmMzIUxfBRU8v283OPgIYQx0K4mwzUjcLp1sPyIbMSMr/bNsCLX4U1l2nSJAs1d
        dEH0+A81RIcRjmZQ/nRMLU5Ktw28ZvjlW/OlpOm48AY3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1659505211; x=1659591611; bh=3d0B77o3eBWwaP2xZ673IRtdcbfHIjwQwGG
        QLrMukF4=; b=A2t2nZx9BKatDfHtzPAKwYZOggqf13RdjMgUC9qI2PLXyErr6S+
        6pm3+tpDtNliIA60nNr6/FaeG93xvvip2ZcH3ASGyjpxDvS8UIBUbxsnB/vwX5K/
        jb63rd93PzN+vIWVclbLQSu5Fs0k1fbrIZHhX0IUFYr/scoaffDpdDd28PL0JhdM
        yJKsxRqsqN1XZzlPFur4CTWIr6QKjGDOvXucd2H4EQ+Lwr1up84/pMNzJx2Sh+7c
        8wGFTYXHOpkkINAm7r3mDQCJES1FEDBgxPW9U2iikdUDr1fxgf7qpv1tRTER+0z/
        rPi7x5mXYqFvTu2oDQfmKm5SDg5mqFBgshg==
X-ME-Sender: <xms:OwrqYuxZJwKlgh_gHKyyJWcDhESN8Dnf3QkIqBljBEjnL-NjkaJzaQ>
    <xme:OwrqYqRtERsKPg0GdUQFgt793im2Wz6Yo7jMivZVYCc56Wr4bLDv-AGrMS9-6OhHK
    ODLiM5sG_KygChZ-E4>
X-ME-Received: <xmr:OwrqYgVffXGA7M07qu3UZyLxRqfFNVGoYv0PWs6Iu8VdWzB0Ixo2HhNSVXOH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddviedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:OwrqYkhfPynhutdtQoBW4_6LvbK7WiaVe4SXFWwsaTFeQNqNvaKlFQ>
    <xmx:OwrqYgAGOgLTU89KxSU7P3RBHxrqL3bseIthHnepz-GgkmXcjik3PQ>
    <xmx:OwrqYlIq_xyQcptndZD3AtqRQ-ZeVT18M53BpIiBbnAHC6ZbzZFrrg>
    <xmx:OwrqYjPT_-3lgXm0KGwb6xy2S5r1UdfLoooyzRoliJgpVm_7ILcjnA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Aug 2022 01:40:08 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] asus-wmi: Add support for dGPU-only mode
Date:   Wed,  3 Aug 2022 17:39:56 +1200
Message-Id: <20220803053956.760356-1-luke@ljones.dev>
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

Adds support for a dGPU-only mode on some laptops where when enabled
the boot GPU is the dGPU, and the iGPU is not visible.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 92 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  3 +
 2 files changed, 95 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 0e7fbed8a50d..25be8b422041 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -234,6 +234,9 @@ struct asus_wmi {
 	bool dgpu_disable_available;
 	bool dgpu_disable;
 
+	bool dgpu_only_available;
+	bool dgpu_only;
+
 	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
 
@@ -559,6 +562,87 @@ static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
 	}
 }
 
+/* dedicated GPU only *********************************************************/
+static int dgpu_only_check_present(struct asus_wmi *asus)
+{
+	u32 result;
+	int err;
+
+	asus->dgpu_only_available = false;
+
+	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_DGPU, &result);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		return err;
+	}
+
+	if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
+		asus->dgpu_only_available = true;
+		asus->dgpu_only = result & ASUS_WMI_DSTS_STATUS_BIT;
+	}
+
+	return 0;
+}
+
+static int dgpu_only_write(struct asus_wmi *asus)
+{
+	u32 retval;
+	u8 value;
+	int err;
+
+	/* Don't rely on type conversion */
+	value = asus->dgpu_only ? 1 : 0;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, value, &retval);
+	if (err) {
+		pr_warn("Failed to set dGPU-only mode: %d\n", err);
+		return err;
+	}
+
+	if (retval > 1) {
+		pr_warn("Failed to set dGPU-only mode (retval): 0x%x\n", retval);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "dgpu_only");
+
+	return 0;
+}
+
+static ssize_t dgpu_only_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	u8 mode = asus->dgpu_only;
+
+	return sysfs_emit(buf, "%d\n", mode);
+}
+
+static ssize_t dgpu_only_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	bool enable;
+	int result;
+
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtobool(buf, &enable);
+	if (result)
+		return result;
+
+	asus->dgpu_only = enable;
+
+	result = dgpu_only_write(asus);
+	if (result)
+		return result;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(dgpu_only);
+
 /* dGPU ********************************************************************/
 static int dgpu_disable_check_present(struct asus_wmi *asus)
 {
@@ -3258,6 +3342,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_touchpad.attr,
 	&dev_attr_egpu_enable.attr,
 	&dev_attr_dgpu_disable.attr,
+	&dev_attr_dgpu_only.attr,
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
@@ -3288,6 +3373,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->egpu_enable_available;
 	else if (attr == &dev_attr_dgpu_disable.attr)
 		ok = asus->dgpu_disable_available;
+	else if (attr == &dev_attr_dgpu_only.attr)
+		ok = asus->dgpu_only_available;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
@@ -3557,6 +3644,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_dgpu_disable;
 
+	err = dgpu_only_check_present(asus);
+	if (err)
+		goto fail_dgpu_only;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
@@ -3671,6 +3762,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_fan_boost_mode:
 fail_egpu_enable:
 fail_dgpu_disable:
+fail_dgpu_only:
 fail_platform:
 fail_panel_od:
 	kfree(asus);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index a571b47ff362..f54d0e307d87 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -92,6 +92,9 @@
 /* Keyboard dock */
 #define ASUS_WMI_DEVID_KBD_DOCK		0x00120063
 
+/* Dedicated GPU only. When active the dGPU will be the only visible GPU */
+#define ASUS_WMI_DEVID_DEDICATED	0x00090016
+
 /* dgpu on/off */
 #define ASUS_WMI_DEVID_EGPU		0x00090019
 
-- 
2.37.1


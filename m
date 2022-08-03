Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1291B5894B1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 01:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbiHCXNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 19:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbiHCXNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 19:13:46 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531C85C366;
        Wed,  3 Aug 2022 16:13:45 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B63915C00B9;
        Wed,  3 Aug 2022 19:13:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 03 Aug 2022 19:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659568424; x=1659654824; bh=0A
        fPPh/hBpKX+xB9wnqcqOZHrFgar/FBFOci3wl1g0w=; b=WZH1N++SVy4cYfUA/k
        cQlGN400jJxK+TO/bmYJ2Nwpy+MwU9g7Ku4duie1YLjyzUP/u5UC3sL+SXRvIs0f
        CCIQgxujtqs6nvMMENEmcd4Za3TcIIIBIeYWv98E32/bJB2QchGqhjV0Fwd3BlLc
        yjdPJqZ8kVc3ogXdZ9Y0v51dFhozZmd09r6IptsC3z9dss4dG+0gHd94F8tMZm8R
        WY1knoROPde/Gl8FkKX3icIEb+LDFvsXAWbVJmS3/jYlxuVTO5pZon424DIkAJNF
        SQPTP8m87Plz31W2I7CzsdeMAjaklx0aKNeF/F8gV2krM/VNzQizsHcrLriIjPUQ
        6rDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659568424; x=1659654824; bh=0AfPPh/hBpKX+
        xB9wnqcqOZHrFgar/FBFOci3wl1g0w=; b=v8dS9E06GsLt36L3TH82IaanqvFI/
        /+AwGwIpjHI6rRtOqPOTA7fBnv8T7+Qv8C4kzEhYUlIIAOHClsoePavYptGvMzXt
        MGZMbHgxjks57oxVWLCSx4sB0ljeVYYLIlv8c0N+1Ikg29DPEcrGsXrqlciQDH1L
        CElJbSjIOPnrfiRFNM2CakbzLEBrc+GVsAA/A6VDyn3NsENOYPYJ5/NkypcHnrUe
        kDaPYVV9ZTdpc+6SXN0SOLjn4iMJsNNjFxwwaQ5pX+4AJfLUcOmgLVOyAZGSS0mE
        v3ZSJ7H+OhxmNdkohkq4ioujiLnw81ol3o+GftJyY9sGi/6aGJQ26sqIQ==
X-ME-Sender: <xms:KAHrYmk5uADV_MQ2V4jmE6ngRzHA-xWTZU_nZF9e69y6VhmL9MUvGQ>
    <xme:KAHrYt3jxhToERk4kgWSDips8dlgWpWyvfy8J7dOYVPaTF13WQNmresx1KcZF1bZo
    44CkH3w-Hy9nlQ968A>
X-ME-Received: <xmr:KAHrYkrrgzY9J9fEFlMS06cPKIzFP6pybRmvS1qeLFrCiGFZO5OZVPVkoiQi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvkedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:KAHrYqkWqxSP5-ozE4BCtdz93CqV74wFpOb1macbGPuYmL2aCO_gBQ>
    <xmx:KAHrYk1ARDEdb9RbPupy1p3LOOfFs-4C11z5DTR7OEzun-WOHPFNuA>
    <xmx:KAHrYhsrt9lNxZRp3Ju4AIUggPr6EgU2jLoHRq9j3WZeNUihr2psHw>
    <xmx:KAHrYiAqqJiKVlPqqzIE5-emF2hjw2q6Qa8KLja1JhOiSfr4uRlBiw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Aug 2022 19:13:41 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 1/1] asus-wmi: Add support for TUF laptop keyboard states
Date:   Thu,  4 Aug 2022 11:13:31 +1200
Message-Id: <20220803231331.48788-2-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220803231331.48788-1-luke@ljones.dev>
References: <20220803231331.48788-1-luke@ljones.dev>
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

/sys/devices/platform/asus-nb-wmi/tuf_krgb_state_index provides
labels for the index fields as "save boot awake sleep keyboard"

/sys/devices/platform/asus-nb-wmi/tuf_krgb_state has the following
as input options via boolean "b b b b b":
- Save or set, if set, then settings revert on cold boot
- Boot, if true, the keyboard displays animation on boot
- Awake, if true, the keyboard LED's are on while device is awake
- Sleep, if true, the keyboard shows animation while device is suspended
- Keybaord, appears to have no effect

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 95 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  3 +
 2 files changed, 98 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 0e7fbed8a50d..bbfb054ff3b2 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -234,6 +234,8 @@ struct asus_wmi {
 	bool dgpu_disable_available;
 	bool dgpu_disable;
 
+	bool tuf_krgb_state_available;
+
 	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
 
@@ -734,6 +736,86 @@ static ssize_t egpu_enable_store(struct device *dev,
 
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
+static ssize_t tuf_krgb_state_index_show(struct device *device,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	int len = sprintf(buf, "%s", "save boot awake sleep keyboard\n");
+	return len;
+}
+
+static DEVICE_ATTR_RO(tuf_krgb_state_index);
+
 /* Battery ********************************************************************/
 
 /* The battery maximum charging percentage */
@@ -3258,6 +3340,8 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_touchpad.attr,
 	&dev_attr_egpu_enable.attr,
 	&dev_attr_dgpu_disable.attr,
+	&dev_attr_tuf_krgb_state.attr,
+	&dev_attr_tuf_krgb_state_index.attr,
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
@@ -3286,6 +3370,12 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		devid = ASUS_WMI_DEVID_ALS_ENABLE;
 	else if (attr == &dev_attr_egpu_enable.attr)
 		ok = asus->egpu_enable_available;
+	else if (attr == &dev_attr_tuf_krgb_state.attr)
+		ok = asus->tuf_krgb_state_available;
+	else if (attr == &dev_attr_tuf_krgb_state_index.attr)
+		ok = asus->tuf_krgb_state_available;
+	else if (attr == &dev_attr_dgpu_disable.attr)
+		ok = asus->dgpu_disable_available;
 	else if (attr == &dev_attr_dgpu_disable.attr)
 		ok = asus->dgpu_disable_available;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
@@ -3557,6 +3647,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_dgpu_disable;
 
+	err = tuf_krgb_state_check_present(asus);
+	if (err)
+		goto fail_tuf_krgb_state;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
@@ -3671,6 +3765,7 @@ static int asus_wmi_add(struct platform_device *pdev)
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


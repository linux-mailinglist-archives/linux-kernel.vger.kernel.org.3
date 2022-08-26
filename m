Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF1F5A1DC5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 02:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243070AbiHZAmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 20:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbiHZAm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 20:42:28 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CED11B7B8;
        Thu, 25 Aug 2022 17:42:28 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6F89D5C009C;
        Thu, 25 Aug 2022 20:42:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 25 Aug 2022 20:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1661474547; x=1661560947; bh=8y
        +/T3N0SqWF6NxVxIldRMBVIEBEY0pHYfeqFdDVrBc=; b=UOgFY3LerbKgwZ2lqa
        U/sdnptlZxbObnT1caomdpjkM35N14N6WI4qgsUUih+eTqldZN5ErE/Tx3tspecx
        //WYQxTgBCRxlozUmbp4ECFIx2zNuroAEPJVFJpm4a2prYvbzKCj004aNxjnjNKj
        +Lu2yGeRNsL/KwehBrBjTaTGTuYKbMugagtRkp725djiBAphEZU66Oq7a3wkbbkZ
        hnRo8g88ZUT0fK4hdE+ZqVMku9magv2Wj266kKjhCOvFCakeHRxWL5ZepNbdKWCJ
        0l43+XOean3NQ6mVlfwTbqWv7PGGe7ZvqHu/VDVRErk2eA9w+7v0U0+4P9iR3Bf6
        dhIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1661474547; x=1661560947; bh=8y+/T3N0SqWF6
        NxVxIldRMBVIEBEY0pHYfeqFdDVrBc=; b=iu4l+VsjM76o4EaZfRTXiKo/1kKiG
        XUIhqOu3zFk9wsaynYSPABqZ4PlLEx3lx4smH9SY9ON/ekKjmS61VvKKFb/Ds5J2
        sD6XPUzpHaqHZwyA2J21gIDRxCPbdhgNajdEMj7F2LIyuzn8w/mO+DEiobXFm0u7
        GY4FS8k8zNbfYfid5I25t/6e1tRHZVPjfoCOwytiJwo0StFeZ2LD6Ty1cA9zdZ74
        qR3lchAL9pl77tEFwYJ0Lx8ZtjxbjRmzh/NaPPOuwZjjbeb6z58wRDPnQculjIfv
        pgTA+33Vxudull76N1EOLiMa8kVENjiUqfVnoHz+/18PwAs9SmHYxkhgw==
X-ME-Sender: <xms:8xYIY_m-_TJpqogzz1jCkDUIocuQhDtNHAOsaQ0tPcfWGz7iMsvrsQ>
    <xme:8xYIYy0iIPNahLUodqH3-AIRyXl2S4oapa916zdBQDEAEeFmXtl8hxt5QG8JKfS0S
    pgIg2BL_v_2sK6_Gb4>
X-ME-Received: <xmr:8xYIY1pTP-JkOUaM61jBFRgTOCTtT9ElfAH40WVxDba-MB-hihjRRcGiDWlf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejgedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:8xYIY3nFtGG9tP1HNprdQLpp1j21stobadg5IfHPuKhy2NyLKVsrQA>
    <xmx:8xYIY92OMjmBd1rCkr4qLE9l09hk5p1QomuX5HZlciJPiaaiS_aUYw>
    <xmx:8xYIY2v-g6EpHzE2srVAXEhK8yEhgzOq5bYF-JxIYOGFNwalDmMsYg>
    <xmx:8xYIY7C6-2t4xVsLtzXg-G2CNSQ56C1UvwnWeUKwkog_PiKiv0xLFg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Aug 2022 20:42:25 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 2/2] asus-wmi: Support the GPU fan on TUF laptops
Date:   Fri, 26 Aug 2022 12:42:10 +1200
Message-Id: <20220826004210.356534-3-luke@ljones.dev>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220826004210.356534-1-luke@ljones.dev>
References: <20220826004210.356534-1-luke@ljones.dev>
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

Add support for TUF laptops which have the ability to control
the GPU fan. This will show as a second fan in hwmon, and has
the ability to run as boost (fullspeed), or auto.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 71 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 72 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index ea45e10302f7..d05684194f2d 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -226,7 +226,9 @@ struct asus_wmi {
 	u32 tablet_switch_dev_id;
 
 	enum fan_type fan_type;
+	enum fan_type gpu_fan_type;
 	int fan_pwm_mode;
+	int gpu_fan_pwm_mode;
 	int agfn_pwm;
 
 	bool fan_boost_mode_available;
@@ -1861,6 +1863,18 @@ static int asus_fan_set_auto(struct asus_wmi *asus)
 		return -ENXIO;
 	}
 
+	/*
+	 * Modern models like the G713 also have GPU fan control (this is not AGFN)
+	 */
+	if (asus->gpu_fan_type == FAN_TYPE_SPEC83) {
+		status = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_FAN_CTRL,
+					       0, &retval);
+		if (status)
+			return status;
+
+		if (retval != 1)
+			return -EIO;
+	}
 
 	return 0;
 }
@@ -2063,9 +2077,57 @@ static ssize_t asus_hwmon_temp1(struct device *dev,
 		       deci_kelvin_to_millicelsius(value & 0xFFFF));
 }
 
+/* GPU fan on modern ROG laptops */
+static ssize_t pwm2_enable_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", asus->gpu_fan_pwm_mode);
+}
+
+static ssize_t pwm2_enable_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	int state;
+	int value;
+	int ret;
+	u32 retval;
+
+	ret = kstrtouint(buf, 10, &state);
+	if (ret)
+		return ret;
+
+	switch (state) { /* standard documented hwmon values */
+	case ASUS_FAN_CTRL_FULLSPEED:
+		value = 1;
+		break;
+	case ASUS_FAN_CTRL_AUTO:
+		value = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_FAN_CTRL,
+				    value, &retval);
+	if (ret)
+		return ret;
+
+	if (retval != 1)
+		return -EIO;
+
+	asus->gpu_fan_pwm_mode = state;
+	return count;
+}
+
 /* Fan1 */
 static DEVICE_ATTR_RW(pwm1);
 static DEVICE_ATTR_RW(pwm1_enable);
+static DEVICE_ATTR_RW(pwm2_enable);
 static DEVICE_ATTR_RO(fan1_input);
 static DEVICE_ATTR_RO(fan1_label);
 
@@ -2075,6 +2137,7 @@ static DEVICE_ATTR(temp1_input, S_IRUGO, asus_hwmon_temp1, NULL);
 static struct attribute *hwmon_attributes[] = {
 	&dev_attr_pwm1.attr,
 	&dev_attr_pwm1_enable.attr,
+	&dev_attr_pwm2_enable.attr,
 	&dev_attr_fan1_input.attr,
 	&dev_attr_fan1_label.attr,
 
@@ -2097,6 +2160,9 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
 	    || attr == &dev_attr_pwm1_enable.attr) {
 		if (asus->fan_type == FAN_TYPE_NONE)
 			return 0;
+	} else if (attr == &dev_attr_pwm2_enable.attr) {
+		if (asus->gpu_fan_type == FAN_TYPE_NONE)
+			return 0;
 	} else if (attr == &dev_attr_temp1_input.attr) {
 		int err = asus_wmi_get_devstate(asus,
 						ASUS_WMI_DEVID_THERMAL_CTRL,
@@ -2139,6 +2205,7 @@ static int asus_wmi_hwmon_init(struct asus_wmi *asus)
 
 static int asus_wmi_fan_init(struct asus_wmi *asus)
 {
+	asus->gpu_fan_type = FAN_TYPE_NONE;
 	asus->fan_type = FAN_TYPE_NONE;
 	asus->agfn_pwm = -1;
 
@@ -2147,6 +2214,10 @@ static int asus_wmi_fan_init(struct asus_wmi *asus)
 	else if (asus_wmi_has_agfn_fan(asus))
 		asus->fan_type = FAN_TYPE_AGFN;
 
+	/*  Modern models like G713 also have GPU fan control */
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_FAN_CTRL))
+		asus->gpu_fan_type = FAN_TYPE_SPEC83;
+
 	if (asus->fan_type == FAN_TYPE_NONE)
 		return -ENODEV;
 
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 7dd580fdc61c..28234dc9fa6a 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -79,6 +79,7 @@
 #define ASUS_WMI_DEVID_THERMAL_CTRL	0x00110011
 #define ASUS_WMI_DEVID_FAN_CTRL		0x00110012 /* deprecated */
 #define ASUS_WMI_DEVID_CPU_FAN_CTRL	0x00110013
+#define ASUS_WMI_DEVID_GPU_FAN_CTRL	0x00110014
 #define ASUS_WMI_DEVID_CPU_FAN_CURVE	0x00110024
 #define ASUS_WMI_DEVID_GPU_FAN_CURVE	0x00110025
 
-- 
2.37.2


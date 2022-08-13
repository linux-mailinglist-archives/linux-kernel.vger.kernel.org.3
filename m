Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E875919A8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 11:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbiHMJhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 05:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239019AbiHMJhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 05:37:06 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC05746DBE;
        Sat, 13 Aug 2022 02:37:04 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BCE4532008FF;
        Sat, 13 Aug 2022 05:37:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 13 Aug 2022 05:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660383423; x=1660469823; bh=U+
        PjTgt180MNnROx+XicSml347QIeNEXU/vdPDGf6bY=; b=ZlWeDMts4orFH6hn7/
        RQJ6QEW+Sq6+Hs4s0nam3myYbzZh5QF5CeYnQPxcuooun9K56mlna9e1hcxQIO/C
        01BSqul1y2DcRBBy3yFeaAcEcn1gem5byH22z50JOERDYhOM/j0v/4zZ2g/QdH5e
        xvjtr9G/WgqIqzZTm1l2SofXgTag9SJdG8kkkC2I1XxMXfxy5eUOleKvPmdqkQPv
        sE9rhRLHNp6+6p4IwfQbiNuyP0yjJgFB17LZkab70Mtj9bPgnZ8bfVp6sHh0EmXw
        0yPHIIYYiW5/xWt4ndOe4r6XhiSCx/qtdsgu8bZNCHxVSKtzasqt+A5w0YlImPdz
        zRMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660383423; x=1660469823; bh=U+PjTgt180MNn
        ROx+XicSml347QIeNEXU/vdPDGf6bY=; b=az8bWzas4YMBu+6tdLtSRxoVbQK5t
        grBUiFjKcqs1B66rziYfXm/jHQsLJ7QIE7Tgpi8pLolTUuji1eZ5cimzaG53CdHR
        XRKU574NqbZNsbJjlbxGMDUFk2diJ2qfBvlGGGR6TP/P7FWngA1xGIED+5bViwpr
        eKXSTNCrVZ15ZR8uwRpp3zvi4AVxlw229dT3WHMqkRl/3ssOezoHkSloVVXEmxR0
        HeiJkYXXmAvphVOCSHz7cht+2bH7zrGV5wihvaRxFuAKEgWv54MhJr1oxbKk4Kdn
        utS1FMCFsgBkZecZZ89Aet/LkJo01rUcBbiB8oc3QgFM7IgCW33oB6bQA==
X-ME-Sender: <xms:v3D3YpJoguQXBbeGlTW7WRH0YHbLC75EqWny2LdNL23OYbe73STxXA>
    <xme:v3D3YlLOB8C7CIyIZ42lnvrm-sCWY56MxCr2qt2LZnycIHj6flvDipOnAWf1P1WsK
    nAtFCu1NRbqystQugY>
X-ME-Received: <xmr:v3D3YhvdqA2HdhtyMepWrvq7pQedhb-J4z0d0mWFTqoyerm2yY13XAkevsno>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegkedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:v3D3YqbSUwvxLqqam4X3gEjMKZ8SisjFQg6nQZieCsntFzTWwrVQBQ>
    <xmx:v3D3YgaZPYNn_JwIj7eyjrJD4XJpgtMS4PrcwIW7t0z0wPdFtl5wEQ>
    <xmx:v3D3YuAnJP_WPPU2UeR5BcC-_w_Si6jq3DPqiO5AMOaG-8_pRhWO6w>
    <xmx:v3D3YvmApMEKyQtpR31iin3j5m9kjhaOFRt4PpGKEJe-z0J0PE1B0A>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Aug 2022 05:36:59 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 2/2] asus-wmi: Support the GPU fan on TUF laptops
Date:   Sat, 13 Aug 2022 21:36:42 +1200
Message-Id: <20220813093642.7440-3-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220813093642.7440-1-luke@ljones.dev>
References: <20220813093642.7440-1-luke@ljones.dev>
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
index 04699dd72f1b..d5d8bf07a3cd 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -222,7 +222,9 @@ struct asus_wmi {
 	struct asus_rfkill uwb;
 
 	enum fan_type fan_type;
+	enum fan_type gpu_fan_type;
 	int fan_pwm_mode;
+	int gpu_fan_pwm_mode;
 	int agfn_pwm;
 
 	bool fan_boost_mode_available;
@@ -1750,6 +1752,18 @@ static int asus_fan_set_auto(struct asus_wmi *asus)
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
@@ -1952,9 +1966,57 @@ static ssize_t asus_hwmon_temp1(struct device *dev,
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
 
@@ -1964,6 +2026,7 @@ static DEVICE_ATTR(temp1_input, S_IRUGO, asus_hwmon_temp1, NULL);
 static struct attribute *hwmon_attributes[] = {
 	&dev_attr_pwm1.attr,
 	&dev_attr_pwm1_enable.attr,
+	&dev_attr_pwm2_enable.attr,
 	&dev_attr_fan1_input.attr,
 	&dev_attr_fan1_label.attr,
 
@@ -1986,6 +2049,9 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
 	    || attr == &dev_attr_pwm1_enable.attr) {
 		if (asus->fan_type == FAN_TYPE_NONE)
 			return 0;
+	} else if (attr == &dev_attr_pwm2_enable.attr) {
+		if (asus->gpu_fan_type == FAN_TYPE_NONE)
+			return 0;
 	} else if (attr == &dev_attr_temp1_input.attr) {
 		int err = asus_wmi_get_devstate(asus,
 						ASUS_WMI_DEVID_THERMAL_CTRL,
@@ -2028,6 +2094,7 @@ static int asus_wmi_hwmon_init(struct asus_wmi *asus)
 
 static int asus_wmi_fan_init(struct asus_wmi *asus)
 {
+	asus->gpu_fan_type = FAN_TYPE_NONE;
 	asus->fan_type = FAN_TYPE_NONE;
 	asus->agfn_pwm = -1;
 
@@ -2036,6 +2103,10 @@ static int asus_wmi_fan_init(struct asus_wmi *asus)
 	else if (asus_wmi_has_agfn_fan(asus))
 		asus->fan_type = FAN_TYPE_AGFN;
 
+	/*  Modern models like G713 also have GPU fan control */
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_FAN_CTRL))
+		asus->gpu_fan_type = FAN_TYPE_SPEC83;
+
 	if (asus->fan_type == FAN_TYPE_NONE)
 		return -ENODEV;
 
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 9132b43c2666..56ebe9f97e08 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -78,6 +78,7 @@
 #define ASUS_WMI_DEVID_THERMAL_CTRL	0x00110011
 #define ASUS_WMI_DEVID_FAN_CTRL		0x00110012 /* deprecated */
 #define ASUS_WMI_DEVID_CPU_FAN_CTRL	0x00110013
+#define ASUS_WMI_DEVID_GPU_FAN_CTRL	0x00110014
 #define ASUS_WMI_DEVID_CPU_FAN_CURVE	0x00110024
 #define ASUS_WMI_DEVID_GPU_FAN_CURVE	0x00110025
 
-- 
2.37.1


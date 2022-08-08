Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F4758C292
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 06:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiHHEhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 00:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiHHEg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 00:36:58 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABE6E080;
        Sun,  7 Aug 2022 21:36:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9556F5C0050;
        Mon,  8 Aug 2022 00:36:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 08 Aug 2022 00:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659933415; x=1660019815; bh=Mg
        PBlGd5BtUlpGQ2YqBK168ygkBuCDq43MlfqUaLHhM=; b=BzWrAgtmHqouBGl6f+
        Eww44+9BibmdMp5f4XznYF3vF7VEUgZh3xADQ+ogqPuzHaWJAGJsuawqSH7ENq+a
        CWUM5FfEfKsK/6i+luqNRNZpRxVaRFcyb6oLDBgHvPbBdkhWMZahil2/ItKc52Pu
        X1ZvUfxQoQoJItXQhHgq7aQkJZXTibzcD5IQtF/VRFLApxZ2+o4EA22j6FjAX785
        XUA7lAvolF2NiLQw4N6ekWnO59qWKSlz2xVL63fUboh7hWBhtQKZSP3US9aqWsPH
        GoHNW3/inZGUQIdGFSRg6PvqVGZYxS1Sw6xAacNzNE403axgbefo1FdHRkE5YFa2
        KC6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1659933415; x=1660019815; bh=MgPBlGd5BtUlp
        GQ2YqBK168ygkBuCDq43MlfqUaLHhM=; b=GHcVcSVm5VT1y2v/V1qZbCfQpMr2c
        umc38fcWXOKg5eDWs9AdcipxWSEhqu/KjQwU2PO5fqD0OmDl+YS+uiN/UzMP+Y5x
        7qeIHngsIBz82JTGU+SNx0hGvcFBLr1tNSy1Vr35JzqTm5WvSCZ/+r78aiuKalmk
        7+pGSxIX5Rymj4C6h1VJDtH/HxWjVknB77ePYDpSe/6jl0LgWWOlJ/BL8iJ1XeMs
        /g9AOjrzaAmq3d0A8X6azcPvMp23OKuv/M9Gfs4inKN3/mKcAhjZUvrb60xHdKPh
        xTsOQNm0yEvZzIOQb3r8dPkNHG4/3+IdTWPDe1E3uaJVX282wPAIiIRHw==
X-ME-Sender: <xms:55LwYsW01FDCvKl9mBYJoNwvn9QezB8hOZvi_v_99kl5fkjbsQpdlw>
    <xme:55LwYgkSjEhdd4h_R_iIy0OPwrDA86s4w2VCwmperWpbqTHgaXCpY0gbeLO7mT3WX
    _yEZMqhQkmSZpDuNkQ>
X-ME-Received: <xmr:55LwYgYchCF2ykNJH34nf6kr_V4ZQpLEzsHAU4m0pjws-hx1xspW3BBtSkmZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:55LwYrW-2ETTdqE4tQNqK45plalUsXN6iWVoZMN5pl1_Ap1OPPsACg>
    <xmx:55LwYmmVvwxeR95CXr69l95Ok2xkOEfbVdBQ0g9aYoFiyookrgzqIQ>
    <xmx:55LwYgeQgdncxJtjmKtw-S2K2BfiLgcyF7M7Zo1C3ImTQTaCFZ818Q>
    <xmx:55LwYryGdi4JdtCsmViACLvRqFzqGV0hVg0RQmsdSH3se-LnT90uyg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 00:36:53 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 2/2] asus-wmi: Support the GPU fan on TUF laptops
Date:   Mon,  8 Aug 2022 16:36:43 +1200
Message-Id: <20220808043643.1571932-2-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808043643.1571932-1-luke@ljones.dev>
References: <20220808043643.1571932-1-luke@ljones.dev>
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

Add support for TUF laptops which have the ability to control
the GPU fan. This will show as a second fan in hwmon, and has
the ability to run run as boost (fullspeed), or auto.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 71 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 72 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index ac06fec0565c..2a74e468591a 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -221,7 +221,9 @@ struct asus_wmi {
 	struct asus_rfkill uwb;
 
 	enum fan_type fan_type;
+	enum fan_type gpu_fan_type;
 	int fan_pwm_mode;
+	int gpu_fan_pwm_mode;
 	int agfn_pwm;
 
 	bool fan_boost_mode_available;
@@ -1757,6 +1759,18 @@ static int asus_fan_set_auto(struct asus_wmi *asus)
 		return -ENXIO;
 	}
 
+	/*
+	 * Modern models like G713 also have GPU fan control. This is not AGFN.
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
@@ -1959,9 +1973,57 @@ static ssize_t asus_hwmon_temp1(struct device *dev,
 		       deci_kelvin_to_millicelsius(value & 0xFFFF));
 }
 
+/* GPU fan on modern ROG laptops */
+static ssize_t pwm2_enable_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", asus->gpu_fan_pwm_mode);
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
 
@@ -1971,6 +2033,7 @@ static DEVICE_ATTR(temp1_input, S_IRUGO, asus_hwmon_temp1, NULL);
 static struct attribute *hwmon_attributes[] = {
 	&dev_attr_pwm1.attr,
 	&dev_attr_pwm1_enable.attr,
+	&dev_attr_pwm2_enable.attr,
 	&dev_attr_fan1_input.attr,
 	&dev_attr_fan1_label.attr,
 
@@ -1993,6 +2056,9 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
 	    || attr == &dev_attr_pwm1_enable.attr) {
 		if (asus->fan_type == FAN_TYPE_NONE)
 			return 0;
+	} else if (attr == &dev_attr_pwm2_enable.attr) {
+		if (asus->gpu_fan_type == FAN_TYPE_NONE)
+			return 0;
 	} else if (attr == &dev_attr_temp1_input.attr) {
 		int err = asus_wmi_get_devstate(asus,
 						ASUS_WMI_DEVID_THERMAL_CTRL,
@@ -2035,6 +2101,7 @@ static int asus_wmi_hwmon_init(struct asus_wmi *asus)
 
 static int asus_wmi_fan_init(struct asus_wmi *asus)
 {
+	asus->gpu_fan_type = FAN_TYPE_NONE;
 	asus->fan_type = FAN_TYPE_NONE;
 	asus->agfn_pwm = -1;
 
@@ -2043,6 +2110,10 @@ static int asus_wmi_fan_init(struct asus_wmi *asus)
 	else if (asus_wmi_has_agfn_fan(asus))
 		asus->fan_type = FAN_TYPE_AGFN;
 
+	/*  Modern models like G713 also have GPU fan control */
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_FAN_CTRL))
+		asus->gpu_fan_type = FAN_TYPE_SPEC83;
+
 	if (asus->fan_type == FAN_TYPE_NONE)
 		return -ENODEV;
 
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index a571b47ff362..bcffb77371be 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -77,6 +77,7 @@
 #define ASUS_WMI_DEVID_THERMAL_CTRL	0x00110011
 #define ASUS_WMI_DEVID_FAN_CTRL		0x00110012 /* deprecated */
 #define ASUS_WMI_DEVID_CPU_FAN_CTRL	0x00110013
+#define ASUS_WMI_DEVID_GPU_FAN_CTRL	0x00110014
 #define ASUS_WMI_DEVID_CPU_FAN_CURVE	0x00110024
 #define ASUS_WMI_DEVID_GPU_FAN_CURVE	0x00110025
 
-- 
2.37.1


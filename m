Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6703258D220
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 04:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiHICvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 22:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiHICvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 22:51:36 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC141EAE0;
        Mon,  8 Aug 2022 19:51:22 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1CE745C0130;
        Mon,  8 Aug 2022 22:51:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 08 Aug 2022 22:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660013482; x=1660099882; bh=p6
        022WMN/oVY4nyX42sR1Bs+V2EDgtJ2eDDOx0oRuX0=; b=IzNGScerdfPuztAoj/
        rTuUmSY/bxa3qGS599PEx4vqnr8/CCAYreOe5pVMZLIQ5S73eI0F7wnfRx6evP8r
        1y/MlLIZoK4JatpVvBI54Lj2rI7ZmjC8dbD1MlzJWESTRuMdGkb+RQlqQ9glD4Ip
        NgPJOdeTDRATNQHN4lB+NVW8ndti814JROLzV3oPb965O0M9sKJT8MA4XpB3TM7N
        I1Zx3CtSDJ3z/tk310OQkBBh2pE26ZRnAZdn5oUtKV8q9xE/1Ji2POUoTOzFKsSc
        OPDT3XwQw1LbtE92nivxQxEPzRgd4FvFLTpbXva0u7d3/uxtAiYjB64gw8cEbgoj
        xEww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660013482; x=1660099882; bh=p6022WMN/oVY4
        nyX42sR1Bs+V2EDgtJ2eDDOx0oRuX0=; b=Go2mbV9o08pjJEeBL4GZUk36KEi1r
        ckae8nenacQtfEWiz59Dogg4HUDh0qpJQvQNVUpD6Oo+yGe5IJPW1Ao5vXyu3Ouj
        S5A9Y7i2Tw9CxYzsM5BOe6WktCecpb3lCxVEdXomT9Wy17RZdIWi6xqYkHJo29X1
        83pFB3eSrfq+62qh184UIQAAc76ExeJFyZkfoiThv6nLpye0VPN4jPNU/fJruzSm
        gp/26upefYgZj5ohYG62AnJSQVtMIRTeOy7Pe4B+0faAIq9RfaYSnE5exBomPWTP
        D8MoMXfBFD9YBN9a7f0/8SiumivDITS3C4elnOLiNJeIMIQR5xYY7nN3g==
X-ME-Sender: <xms:qcvxYpOVqC-ASHH-6Xhg-aP57wzPmE1E3-jNggdQ03hadNbCcD89lQ>
    <xme:qcvxYr_do2Zm0xAG-ZySZUQU4mlnuxjObVbOeu1nqBk39Kc_xRQv5vElZuO1vbE6D
    ohxDrXlGFOM-WtBgVw>
X-ME-Received: <xmr:qcvxYoRcc_IvHPcen0uHI-HC0aWAnMbPzvw3i2yVP05doCpOiyb_G6IUBSw_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefledgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:qcvxYlto0OatyAjxbWJq13O9wzQbErhS_hpuR4G2iDJb63VhG2IXyg>
    <xmx:qcvxYhf1pd70SFCo68cCpYwOEgPD168L6AsHRpPmkJP-RG6rsPbpuQ>
    <xmx:qcvxYh2h9kqncAqRn0UbSHANb0YoNyKkf20Z2wzND6AXakCGTSx-uA>
    <xmx:qsvxYo5kIhhOMt3zyPVNiVIaAWSWsiM35N3FxVaH9oVHdAY8Mn8KbA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 22:51:19 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     andy.shevchenko@gmail.com, pobrn@protonmail.com, pavel@ucw.cz,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 5/6] asus-wmi: Convert all attr-show to use sysfs_emit
Date:   Tue,  9 Aug 2022 14:50:53 +1200
Message-Id: <20220809025054.1626339-6-luke@ljones.dev>
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

This changes all *_show attributes in asus-wmi.c to use sysfs_emit()
instead of the older method of writing to the output buffer manually.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 719223804c0e..78f1f3af1b12 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -942,7 +942,7 @@ static ssize_t charge_control_end_threshold_show(struct device *device,
 						 struct device_attribute *attr,
 						 char *buf)
 {
-	return sprintf(buf, "%d\n", charge_end_threshold);
+	return sysfs_emit(buf, "%d\n", charge_end_threshold);
 }
 
 static DEVICE_ATTR_RW(charge_control_end_threshold);
@@ -2032,7 +2032,7 @@ static ssize_t pwm1_show(struct device *dev,
 		value = -1;
 	}
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t pwm1_store(struct device *dev,
@@ -2092,7 +2092,7 @@ static ssize_t fan1_input_show(struct device *dev,
 		return -ENXIO;
 	}
 
-	return sprintf(buf, "%d\n", value < 0 ? -1 : value*100);
+	return sysfs_emit(buf, "%d\n", value < 0 ? -1 : value * 100);
 }
 
 static ssize_t pwm1_enable_show(struct device *dev,
@@ -2110,7 +2110,7 @@ static ssize_t pwm1_enable_show(struct device *dev,
 	 * in practice on X532FL at least (the bit is always 0) and there's
 	 * also nothing in the DSDT to indicate that this behaviour exists.
 	 */
-	return sprintf(buf, "%d\n", asus->fan_pwm_mode);
+	return sysfs_emit(buf, "%d\n", asus->fan_pwm_mode);
 }
 
 static ssize_t pwm1_enable_store(struct device *dev,
@@ -2178,7 +2178,7 @@ static ssize_t fan1_label_show(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
 {
-	return sprintf(buf, "%s\n", ASUS_FAN_DESC);
+	return sysfs_emit(buf, "%s\n", ASUS_FAN_DESC);
 }
 
 static ssize_t asus_hwmon_temp1(struct device *dev,
@@ -2371,7 +2371,7 @@ static ssize_t fan_boost_mode_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", asus->fan_boost_mode);
+	return sysfs_emit(buf, "%d\n", asus->fan_boost_mode);
 }
 
 static ssize_t fan_boost_mode_store(struct device *dev,
@@ -2924,7 +2924,7 @@ static ssize_t throttle_thermal_policy_show(struct device *dev,
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 	u8 mode = asus->throttle_thermal_policy_mode;
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", mode);
+	return sysfs_emit(buf, "%d\n", mode);
 }
 
 static ssize_t throttle_thermal_policy_store(struct device *dev,
-- 
2.37.1


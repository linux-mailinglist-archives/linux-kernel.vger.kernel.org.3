Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115EA58A7F7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240577AbiHEIT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240481AbiHEITo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:19:44 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB5576475;
        Fri,  5 Aug 2022 01:19:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 36E11320094A;
        Fri,  5 Aug 2022 04:19:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 05 Aug 2022 04:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659687578; x=1659773978; bh=OQ
        hNQIozvZ77I0GYktwRr7T2SqZvLGHg5DmWy8+lW0s=; b=lWvdquzZvVduxt4Dg7
        0/P19TrRC9c/fiFXJvtH0hOBuwSKDqwdbErbnARkhlnhLV3AcmwMBhIgi2hOdm3E
        3+8iVTxxLHv58tfEHdQSlKgLHm3qNhvmxIZED+fqPcaw7/1fPSCLeoqrMRPeb3Gd
        XWmGBsjzm2lQVi0Ha7iEG48GcSFjoCrOjsaqEVHDNzbItqh8yowuugPZ9bbatp9Z
        h3hgzp2og6lhi+/Hf+4dF/rMSDM658c93CmMg0cDncKD6Qx0+g8wcWcYFc2Pw4WI
        V+qKuKeF/F6x6dZovkdvkOmDpq2tm9jvSvWVlJZf9EZn7sgl92Is/WF3lSllRmu3
        Q28w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659687578; x=1659773978; bh=OQhNQIozvZ77I
        0GYktwRr7T2SqZvLGHg5DmWy8+lW0s=; b=nT+cSgDjI959jQHv3Sjbn9ab59y1y
        /jxpRto/5mxVCVTuqA/+l+mRdi4+PMn5sjj/YJM18O22JhtXKjZlEFTfqwVv+IGU
        fF1NxNejyxeZbvQ35is5ztCCiBjuoX2OqF2F4NQxqvz1+Lt/t9hrrdMo9J1nsqIe
        DqsXenNxUPB6zHnQiNtAR6RLfkILuwAhQTEOTz4L8GGU7kwthN6wWXUmhavK451H
        J2shmVY5HyIf5drMISKIYMKLMdKzDn78KjGTp2vh8oE9QkwR/CZfC7cuW5XnX21H
        sxTMGMCAYHDUjECPqc+Uns/1pnj4W36TUBMzOfimhoRS1GSa0UA/RlsEQ==
X-ME-Sender: <xms:mtLsYnxinjntagKrJWoxgTSAXU-IzZaMOXuH1DjR745_uPxxjrdvuw>
    <xme:mtLsYvRyMW-5o2AfEIkRKa5ZICvZCynLk8vi-CF0MP0ZUB4JbzEy3SzbQlNiWIHLl
    pxQaShUYpIC6aZjV5M>
X-ME-Received: <xmr:mtLsYhWCpU3shxguvezAz7zpVIO2ZwNUygRz2LQvm-0tJ023h6gvNn_Dqg6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefuddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:mtLsYhitliiCvZRZrpA5-YwIwoC0G2y2GAkAYjZb2Y7QvJn-ScW5kg>
    <xmx:mtLsYpAHD0ZpqKZZdsqxBasc6hQ2qxtJVeWEwQBGHWf8sQaTw7NWUQ>
    <xmx:mtLsYqI02K4kmNxhkpsmVqmhWTH0AKP6Q1g8viZ53-RfqYYFYv-hDQ>
    <xmx:mtLsYsN2PaJ4BTmk-Oi8i5_qdBs81xwXOKdv1Rt1Zofu9sQKF9yLWQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Aug 2022 04:19:36 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 5/5] asus-wmi: Convert all attr _show to use sysfs_emit
Date:   Fri,  5 Aug 2022 20:19:09 +1200
Message-Id: <20220805081909.10962-6-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805081909.10962-1-luke@ljones.dev>
References: <20220805081909.10962-1-luke@ljones.dev>
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

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index ad758845edc0..1e1b5226e0b3 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -914,7 +914,7 @@ static ssize_t charge_control_end_threshold_show(struct device *device,
 						 struct device_attribute *attr,
 						 char *buf)
 {
-	return sprintf(buf, "%d\n", charge_end_threshold);
+	return sysfs_emit(buf, "%d\n", charge_end_threshold);
 }
 
 static DEVICE_ATTR_RW(charge_control_end_threshold);
@@ -2021,7 +2021,7 @@ static ssize_t pwm1_show(struct device *dev,
 		value = -1;
 	}
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t pwm1_store(struct device *dev,
@@ -2081,7 +2081,7 @@ static ssize_t fan1_input_show(struct device *dev,
 		return -ENXIO;
 	}
 
-	return sprintf(buf, "%d\n", value < 0 ? -1 : value*100);
+	return sysfs_emit(buf, "%d\n", value < 0 ? -1 : value*100);
 }
 
 static ssize_t pwm1_enable_show(struct device *dev,
@@ -2099,7 +2099,7 @@ static ssize_t pwm1_enable_show(struct device *dev,
 	 * in practice on X532FL at least (the bit is always 0) and there's
 	 * also nothing in the DSDT to indicate that this behaviour exists.
 	 */
-	return sprintf(buf, "%d\n", asus->fan_pwm_mode);
+	return sysfs_emit(buf, "%d\n", asus->fan_pwm_mode);
 }
 
 static ssize_t pwm1_enable_store(struct device *dev,
@@ -2167,7 +2167,7 @@ static ssize_t fan1_label_show(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
 {
-	return sprintf(buf, "%s\n", ASUS_FAN_DESC);
+	return sysfs_emit(buf, "%s\n", ASUS_FAN_DESC);
 }
 
 static ssize_t asus_hwmon_temp1(struct device *dev,
@@ -2360,7 +2360,7 @@ static ssize_t fan_boost_mode_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", asus->fan_boost_mode);
+	return sysfs_emit(buf, "%d\n", asus->fan_boost_mode);
 }
 
 static ssize_t fan_boost_mode_store(struct device *dev,
@@ -2913,7 +2913,7 @@ static ssize_t throttle_thermal_policy_show(struct device *dev,
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 	u8 mode = asus->throttle_thermal_policy_mode;
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", mode);
+	return sysfs_emit(buf, "%d\n", mode);
 }
 
 static ssize_t throttle_thermal_policy_store(struct device *dev,
-- 
2.37.1


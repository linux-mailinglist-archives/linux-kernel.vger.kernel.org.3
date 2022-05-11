Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7B2523DD8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347163AbiEKTrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346094AbiEKTrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:47:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99C139175;
        Wed, 11 May 2022 12:47:00 -0700 (PDT)
Date:   Wed, 11 May 2022 19:46:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652298419;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oWjakq/illQMU6mUjolEq2Ah4DoleXLzYIwdYWOO0fU=;
        b=wVeNQv4oPDoZEZoqQgGIP9gD7aCUVCR6fzsW/18PGQyQgfaqCPvhWQG4Yy41XjvlzjZD8n
        iPw2h+f6Ns6zMuepl8mVo946oQDkMGt1Fre6uX8A72Vtc5Yue2apY3SyGYJD0CyJmGnScQ
        zAr3YE9nvlr1vQNCXMxrfN6huQw0kKokEAc29FjczDBecY00IdNVGSFjgINZg4jj2pnPpg
        BmUHeLwlvCHmkAF0xrzpX41lOC16YVfsSprkA2JpmQXUV++p47FHLjORtSlEC1R0U5PGWq
        GZMwG0Gz10NKju9U67eJdzBEXTZAEEFczeg5Lp65ZcQUCribTsptD41QG0HFxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652298419;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oWjakq/illQMU6mUjolEq2Ah4DoleXLzYIwdYWOO0fU=;
        b=/bq4l2GoVK2HcXr+feW9CwazIScxmBkPcAKad9bgVreLTexbVoStf8oIiY4ViorRLjRo3z
        c02mbTfjd7jCXHDw==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/ibs: Advertise zen4_ibs_extensions as pmu
 capability attribute
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220509044914.1473-5-ravi.bangoria@amd.com>
References: <20220509044914.1473-5-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <165229841825.4207.4646918223828683533.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     838de1d843fc9b6161e0e1c6308a8c027d08606d
Gitweb:        https://git.kernel.org/tip/838de1d843fc9b6161e0e1c6308a8c027d08606d
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Mon, 09 May 2022 10:19:10 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 May 2022 16:27:10 +02:00

perf/amd/ibs: Advertise zen4_ibs_extensions as pmu capability attribute

PMU driver can advertise certain feature via capability attribute('caps'
sysfs directory) which can be consumed by userspace tools like perf. Add
zen4_ibs_extensions capability attribute for IBS pmus. This attribute
will be enabled when CPUID_Fn8000001B_EAX[11] is set.

With patch on Zen4:

  $ ls /sys/bus/event_source/devices/ibs_op/caps
  zen4_ibs_extensions

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220509044914.1473-5-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 2dc8b7e..c251bc4 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -537,8 +537,14 @@ static struct attribute_group empty_format_group = {
 	.attrs = attrs_empty,
 };
 
+static struct attribute_group empty_caps_group = {
+	.name = "caps",
+	.attrs = attrs_empty,
+};
+
 static const struct attribute_group *empty_attr_groups[] = {
 	&empty_format_group,
+	&empty_caps_group,
 	NULL,
 };
 
@@ -546,6 +552,7 @@ PMU_FORMAT_ATTR(rand_en,	"config:57");
 PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
 PMU_EVENT_ATTR_STRING(l3missonly, fetch_l3missonly, "config:59");
 PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
+PMU_EVENT_ATTR_STRING(zen4_ibs_extensions, zen4_ibs_extensions, "1");
 
 static umode_t
 zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int i)
@@ -563,6 +570,11 @@ static struct attribute *fetch_l3missonly_attrs[] = {
 	NULL,
 };
 
+static struct attribute *zen4_ibs_extensions_attrs[] = {
+	&zen4_ibs_extensions.attr.attr,
+	NULL,
+};
+
 static struct attribute_group group_rand_en = {
 	.name = "format",
 	.attrs = rand_en_attrs,
@@ -574,13 +586,21 @@ static struct attribute_group group_fetch_l3missonly = {
 	.is_visible = zen4_ibs_extensions_is_visible,
 };
 
+static struct attribute_group group_zen4_ibs_extensions = {
+	.name = "caps",
+	.attrs = zen4_ibs_extensions_attrs,
+	.is_visible = zen4_ibs_extensions_is_visible,
+};
+
 static const struct attribute_group *fetch_attr_groups[] = {
 	&group_rand_en,
+	&empty_caps_group,
 	NULL,
 };
 
 static const struct attribute_group *fetch_attr_update[] = {
 	&group_fetch_l3missonly,
+	&group_zen4_ibs_extensions,
 	NULL,
 };
 
@@ -615,6 +635,7 @@ static struct attribute_group group_op_l3missonly = {
 static const struct attribute_group *op_attr_update[] = {
 	&group_cnt_ctl,
 	&group_op_l3missonly,
+	&group_zen4_ibs_extensions,
 	NULL,
 };
 

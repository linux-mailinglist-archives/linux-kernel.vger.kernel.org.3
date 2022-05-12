Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0768952500D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355315AbiELOdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355309AbiELOdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:33:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B35D62120;
        Thu, 12 May 2022 07:33:05 -0700 (PDT)
Date:   Thu, 12 May 2022 14:33:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652365983;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/sMjHKaheJZJe0Qp/Rqj5FBaeAFOPJg3Cpk2FLh5NxE=;
        b=PBMp50OGBXo6sYS6UK/XjKzbN7VU68SGBOdwmkkp3EyRxICDP/jNrHfwHZivOfSlMXZ/C9
        H6cPEaqh2thU8MOMyGAqn+E3J4oCzKyvmeKUEe+nhR2jizIMzX82pCaDY8vWuOsdW/LjbD
        aTtdPL5YhIRzIIxdG4YTNk/Uw9i523nE0tNkajBsD5MxFf2Tt71b1/dyjEZNIKXiJJInqQ
        dLbpiMs6VLPtHOtOgXYhjvmd97Nhuy5Pjnplkux1tKiq9YDDHI7IwUYDFkg4EJWOGNLUDV
        sDBWp/l54U0J0zBH/3F+v6n/b1FnA+6EKBuW/IQ12UecgBOEmNvzfLaSvhoo3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652365983;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/sMjHKaheJZJe0Qp/Rqj5FBaeAFOPJg3Cpk2FLh5NxE=;
        b=tWKW9kF0zYH29jGkzdhjrgLZ+jaISzNVIQF7Y0gB3wWo2/5iypMY0Az3ZjiiKLpDlXkOU2
        viuf6iV1ZB1ve9Ag==
From:   "tip-bot2 for Zucheng Zheng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Remove unused variable 'hwc'
Cc:     Zucheng Zheng <zhengzucheng@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220421111031.174698-1-zhengzucheng@huawei.com>
References: <20220421111031.174698-1-zhengzucheng@huawei.com>
MIME-Version: 1.0
Message-ID: <165236598210.4207.2040091786873679045.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     bc469ddf67154a4840267132e87ce0d8b72d4952
Gitweb:        https://git.kernel.org/tip/bc469ddf67154a4840267132e87ce0d8b72d4952
Author:        Zucheng Zheng <zhengzucheng@huawei.com>
AuthorDate:    Thu, 21 Apr 2022 19:10:31 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 12 May 2022 16:28:46 +02:00

perf/x86/amd: Remove unused variable 'hwc'

'hwc' is never used in amd_pmu_enable_all(), so remove it.

Signed-off-by: Zucheng Zheng <zhengzucheng@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220421111031.174698-1-zhengzucheng@huawei.com
---
 arch/x86/events/amd/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 262e39a..d81eac2 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -771,14 +771,11 @@ static void amd_pmu_enable_event(struct perf_event *event)
 static void amd_pmu_enable_all(int added)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct hw_perf_event *hwc;
 	int idx;
 
 	amd_brs_enable_all();
 
 	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
-		hwc = &cpuc->events[idx]->hw;
-
 		/* only activate events which are marked as active */
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99852523DD6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347140AbiEKTrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347116AbiEKTrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:47:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671273702A;
        Wed, 11 May 2022 12:46:59 -0700 (PDT)
Date:   Wed, 11 May 2022 19:46:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652298417;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dOcs69Yu66kDZ9np1SfaNPgGsXdX4UAOF8Ra4sV6eLQ=;
        b=iEXsQCTVevmDQph7qA2eOjHDP3MXmRyxdi92noB+JgjX8tnJpuA5bqqVDkHv/Dq6V7W7n8
        kOgC6fMGWQrIiy9zRDInaR/OaRRLUbpYpKfZlTQy6q7SU9ujK5UAyxmmtOlB+sNzZqS+Hn
        p1diYabL+131+uQdrPE1LX8fyXs9DhNI/hxDk5LpuHNkB5EUvFqKrucqZJaAGnhXzjW9Uk
        4CycP/Y6BLVb61NiEOtgLcPNASqgxEzRKiZ/X+2hzLGMOl8yZWUfhmDl8r9R6u4y9GK12K
        GyqgHSncJYMwE612PEdKTNyG9CRLnj+z49gixH03i23rWZkX2994S0jNmtEZSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652298417;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dOcs69Yu66kDZ9np1SfaNPgGsXdX4UAOF8Ra4sV6eLQ=;
        b=E2QyIC7n6lgGO8cxt1dNZqXBbUy/eO8JQMhG0xZ8WBxHMyqD5TcGhF3XdGZSE9KHdfmXeo
        bTXrwsqrPgvdhBDA==
From:   "tip-bot2 for Zucheng Zheng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Remove unused variable 'hwc'
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220421111031.174698-1-zhengzucheng@huawei.com>
References: <20220421111031.174698-1-zhengzucheng@huawei.com>
MIME-Version: 1.0
Message-ID: <165229841634.4207.1052240336880939148.tip-bot2@tip-bot2>
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

Commit-ID:     2cc6edea3673e38fa96df5cf8a62ddc8b27c7217
Gitweb:        https://git.kernel.org/tip/2cc6edea3673e38fa96df5cf8a62ddc8b27c7217
Author:        Zucheng Zheng <zhengzucheng@huawei.com>
AuthorDate:    Thu, 21 Apr 2022 19:10:31 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 May 2022 16:27:11 +02:00

perf/x86/amd: Remove unused variable 'hwc'

'hwc' is never used in amd_pmu_enable_all(), so remove it.

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

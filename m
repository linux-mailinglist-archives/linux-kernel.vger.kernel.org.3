Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3EA55C94A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbiF1HQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbiF1HQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:16:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90422C677;
        Tue, 28 Jun 2022 00:16:45 -0700 (PDT)
Date:   Tue, 28 Jun 2022 07:16:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656400604;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ed7eeRf+nAyohjC35X6oOmgfi9tuJ489WoRBnaIpRLo=;
        b=wrjwOtJ8ZJqdu08iO9lMTSO08T3d57U/5iIOVk5Wm3gONxJpktBIHzUiJxVox/zP5PvCJA
        eVsGRL+VcsOID1TuMpiR6MZDTgGlSMXL2YaVWAgm8BkfgdCcoMqsanOHV3pqakimxT86Hr
        X3Z1jCat4rv4OYDLSOjlYj+1RfSPdEqwmu9RrOugXKlWadIKfm03tN7WqVGf502xKcvoP2
        DwFMgm4/YgPTmQaEK/5glo04i4orhKH7cQ1S7b8E78053yMV3wPLAFCBKuE3wH/cV4etlO
        9u00TYI3g50h8mD6bfKgQZ7mNORjGhc71o4UInm3Kts3SgGFV+6minpQX+WnPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656400604;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ed7eeRf+nAyohjC35X6oOmgfi9tuJ489WoRBnaIpRLo=;
        b=FxVLY+by8Yf9xz2LDEZEElqmoQLuR2dplIdGaG0FlvunYMIa+9WGrgbjeweT2igquKbGH+
        Wpg4dOxbB31aBVCw==
From:   "tip-bot2 for Zhang Qiao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Remove unused function group_first_cpu()
Cc:     Zhang Qiao <zhangqiao22@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220617181151.29980-3-zhangqiao22@huawei.com>
References: <20220617181151.29980-3-zhangqiao22@huawei.com>
MIME-Version: 1.0
Message-ID: <165640060323.4207.11211758578509584978.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c64b551f6a338eb9724a2f9ef3dddf80ccef2894
Gitweb:        https://git.kernel.org/tip/c64b551f6a338eb9724a2f9ef3dddf80ccef2894
Author:        Zhang Qiao <zhangqiao22@huawei.com>
AuthorDate:    Sat, 18 Jun 2022 02:11:51 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 28 Jun 2022 09:08:29 +02:00

sched: Remove unused function group_first_cpu()

As of commit afe06efdf07c ("sched: Extend scheduler's asym packing")
group_first_cpu() became an unused function, remove it.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20220617181151.29980-3-zhangqiao22@huawei.com
---
 kernel/sched/sched.h |  9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1e34bb4..02c9705 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1810,15 +1810,6 @@ static inline struct cpumask *group_balance_mask(struct sched_group *sg)
 	return to_cpumask(sg->sgc->cpumask);
 }
 
-/**
- * group_first_cpu - Returns the first CPU in the cpumask of a sched_group.
- * @group: The group whose first CPU is to be returned.
- */
-static inline unsigned int group_first_cpu(struct sched_group *group)
-{
-	return cpumask_first(sched_group_span(group));
-}
-
 extern int group_balance_cpu(struct sched_group *sg);
 
 #ifdef CONFIG_SCHED_DEBUG

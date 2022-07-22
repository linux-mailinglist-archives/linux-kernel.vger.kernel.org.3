Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB43757D83B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbiGVCGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGVCGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:06:44 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9763B951FD
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 19:06:37 -0700 (PDT)
X-QQ-mid: bizesmtp64t1658455548t22j4mub
Received: from harry-jrlc.. ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 22 Jul 2022 10:05:40 +0800 (CST)
X-QQ-SSF: 0100000000000030C000000A0000020
X-QQ-FEAT: 7L1V3dHhUFM9DG3DWfqxxrBLAGcNYhja76O6mjikYtmzuD2j0+RMZ8ER2LIIy
        iof30pibbsUlHmkAgLWImVm4AGMhzDfXJ4TSVB1hLeeuw/oCpCGc1lcjnUn4mEqN+cNde5M
        nxYcbw1tsQkFfscVFhcXGbR1aG0GVH3XXN4IkHbGWnPkbgxamcq0IVd7Jfx5DhV7wxVQZol
        FV8npIvnlsC4Sguk1dCki1dxWryIm3hEuAZMZqBBhnUhTxAS0OVJkU0rbQQ4PIJRqPaYLEt
        giqK0VDuUzlRTDwGmbv6N7IWnjQbnzyh4cZEpMk0iceks/64jH5hZq612fKP/u0ThGfO/Xc
        B7jS1/2tgb3LoU9RSA+qwxpYnqIL1XP/ndRvJ0m+jVTuHEPBKGjsyZ2MG9XGw==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] sched: Fix comment typo
Date:   Fri, 22 Jul 2022 10:05:38 +0800
Message-Id: <20220722020538.15228-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `into' is duplicated in line 2515, remove one.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1f97f357aacd..9f9d0cf92263 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2506,7 +2506,7 @@ static inline bool rq_order_less(struct rq *rq1, struct rq *rq2)
 {
 #ifdef CONFIG_SCHED_CORE
 	/*
-	 * In order to not have {0,2},{1,3} turn into into an AB-BA,
+	 * In order to not have {0,2},{1,3} turn into an AB-BA,
 	 * order by core-id first and cpu-id second.
 	 *
 	 * Notably:
-- 
2.30.2


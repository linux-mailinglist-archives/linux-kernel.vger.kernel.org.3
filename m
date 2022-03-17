Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C020E4DBD36
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 03:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355253AbiCQCs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 22:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358532AbiCQCr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 22:47:57 -0400
Received: from ha.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7206C201BC;
        Wed, 16 Mar 2022 19:46:42 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha.nfschina.com (Postfix) with ESMTP id 39F661E80D0B;
        Thu, 17 Mar 2022 10:45:41 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha.nfschina.com ([127.0.0.1])
        by localhost (ha.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tbt6CxorIXvB; Thu, 17 Mar 2022 10:45:38 +0800 (CST)
Received: from localhost.localdomain (unknown [101.228.249.16])
        (Authenticated sender: yuzhe@nfschina.com)
        by ha.nfschina.com (Postfix) with ESMTPA id D55EE1E80CD2;
        Thu, 17 Mar 2022 10:45:37 +0800 (CST)
From:   yuzhe <yuzhe@nfschina.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-janitors@vger.kernel.org,
        yuzhe <yuzhe@nfschina.com>
Subject: [PATCH] sched: Fix spelling mistake "then" -> "than"
Date:   Wed, 16 Mar 2022 19:46:17 -0700
Message-Id: <20220317024617.5587-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in comment.Fix it.

Signed-off-by: yuzhe <yuzhe@nfschina.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8bcc1dbc544c..e6b3d62389c9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5944,7 +5944,7 @@ static unsigned long capacity_of(int cpu)
 static void record_wakee(struct task_struct *p)
 {
 	/*
-	 * Only decay a single time; tasks that have less then 1 wakeup per
+	 * Only decay a single time; tasks that have less than 1 wakeup per
 	 * jiffy will not have built up many flips.
 	 */
 	if (time_after(jiffies, current->wakee_flip_decay_ts + HZ)) {
-- 
2.25.1


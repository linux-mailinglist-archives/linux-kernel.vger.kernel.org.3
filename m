Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD77D4B44C5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242350AbiBNIr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:47:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiBNIrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:47:55 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDAD4F472
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:47:48 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V4OcNLn_1644828461;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V4OcNLn_1644828461)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 14 Feb 2022 16:47:46 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     fweisbec@gmail.com
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] tick/rcu: Fix non-kernel-doc comment
Date:   Mon, 14 Feb 2022 16:47:39 +0800
Message-Id: <20220214084739.63228-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning:

kernel/time/tick-sched.c:1563: warning: This comment starts with '/**',
but isn't a kernel-doc comment. Refer
Documentation/doc-guide/kernel-doc.rst

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/time/tick-sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 2d76c91b85de..337afd34183b 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1538,7 +1538,7 @@ void tick_cancel_sched_timer(int cpu)
 }
 #endif
 
-/**
+/*
  * Async notification about clocksource changes
  */
 void tick_clock_notify(void)
@@ -1559,7 +1559,7 @@ void tick_oneshot_notify(void)
 	set_bit(0, &ts->check_clocks);
 }
 
-/**
+/*
  * Check, if a change happened, which makes oneshot possible.
  *
  * Called cyclic from the hrtimer softirq (driven by the timer
-- 
2.20.1.7.g153144c


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAF24DBC97
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358296AbiCQBqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiCQBqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:46:14 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF812DEF9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:44:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0V7OwE4T_1647481491;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V7OwE4T_1647481491)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Mar 2022 09:44:55 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, brauner@kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] sched/core: Remove duplicated include
Date:   Thu, 17 Mar 2022 09:44:49 +0800
Message-Id: <20220317014449.130374-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the following includecheck warning:

./kernel/sched/core.c: stats.h is included more than once.
./kernel/sched/core.c: linux/sched/rseq_api.h is included more than
once.
./kernel/sched/core.c: autogroup.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/sched/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ef31751c5799..22d5cf4c4ab5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -74,15 +74,12 @@
 #include <asm/tlb.h>
 
 #define CREATE_TRACE_POINTS
-#include <linux/sched/rseq_api.h>
 #include <trace/events/sched.h>
 #undef CREATE_TRACE_POINTS
 
 #include "sched.h"
-#include "stats.h"
 #include "autogroup.h"
 
-#include "autogroup.h"
 #include "pelt.h"
 #include "smp.h"
 #include "stats.h"
-- 
2.20.1.7.g153144c


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7474A54F006
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 06:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379904AbiFQEOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 00:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379911AbiFQEOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 00:14:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D7565D21
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 21:14:02 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LPQZ873BBzSgpN;
        Fri, 17 Jun 2022 12:10:40 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 12:14:00 +0800
Received: from huawei.com (10.67.174.191) by dggpeml500018.china.huawei.com
 (7.185.36.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 17 Jun
 2022 12:14:00 +0800
From:   Zhang Qiao <zhangqiao22@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <zhangqiao22@huawei.com>
Subject: [PATCH 1/2] sched/fair: Remove redundant word " *"
Date:   Sat, 18 Jun 2022 02:11:50 +0800
Message-ID: <20220617181151.29980-2-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20220617181151.29980-1-zhangqiao22@huawei.com>
References: <20220617181151.29980-1-zhangqiao22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.191]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

" *" is redundant. so remove it.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 77b2048a9326..0598679a7f2a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8500,7 +8500,7 @@ static inline int sg_imbalanced(struct sched_group *group)
 /*
  * group_has_capacity returns true if the group has spare capacity that could
  * be used by some tasks.
- * We consider that a group has spare capacity if the  * number of task is
+ * We consider that a group has spare capacity if the number of task is
  * smaller than the number of CPUs or if the utilization is lower than the
  * available capacity for CFS tasks.
  * For the latter, we use a threshold to stabilize the state, to take into
-- 
2.18.0


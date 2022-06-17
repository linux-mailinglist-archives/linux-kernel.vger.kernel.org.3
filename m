Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD70754F007
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 06:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbiFQEON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 00:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiFQEOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 00:14:03 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7158465D1D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 21:14:02 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LPQbh5D3Jz1K9RG;
        Fri, 17 Jun 2022 12:12:00 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
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
Subject: [PATCH 2/2] sched: Remove unused function group_first_cpu()
Date:   Sat, 18 Jun 2022 02:11:51 +0800
Message-ID: <20220617181151.29980-3-zhangqiao22@huawei.com>
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

group_first_cpu() is an unused function, remove it.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/sched.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 01259611beb9..8f57e9391e82 100644
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
-- 
2.18.0


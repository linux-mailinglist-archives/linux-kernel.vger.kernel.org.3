Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9428E47B885
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 03:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbhLUCun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 21:50:43 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:30154 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbhLUCum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 21:50:42 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JJ19K4KQwz8w0n;
        Tue, 21 Dec 2021 10:48:21 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 10:50:40 +0800
Received: from huawei.com (10.175.100.227) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 21 Dec
 2021 10:50:40 +0800
From:   Tang Yizhou <tangyizhou@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <corbet@lwn.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <zhengbin13@huawei.com>, <tangyeechou@gmail.com>,
        Tang Yizhou <tangyizhou@huawei.com>
Subject: [PATCH] docs: scheduler: Fix outdated parameter of rebalance_domains
Date:   Tue, 21 Dec 2021 11:18:18 +0800
Message-ID: <20211221031818.23186-1-tangyizhou@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the function prototype of rebalance_domains(), its first
parameter is *rq* and the document need to be updated.

Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
---
 Documentation/scheduler/sched-domains.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/scheduler/sched-domains.rst
index 84dcdcd2911c..e57ad28301bd 100644
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -37,10 +37,10 @@ rebalancing event for the current runqueue has arrived. The actual load
 balancing workhorse, run_rebalance_domains()->rebalance_domains(), is then run
 in softirq context (SCHED_SOFTIRQ).
 
-The latter function takes two arguments: the current CPU and whether it was idle
-at the time the scheduler_tick() happened and iterates over all sched domains
-our CPU is on, starting from its base domain and going up the ->parent chain.
-While doing that, it checks to see if the current domain has exhausted its
+The latter function takes two arguments: the runqueue of current CPU and whether
+the CPU was idle at the time the scheduler_tick() happened and iterates over all
+sched domains our CPU is on, starting from its base domain and going up the ->parent
+chain. While doing that, it checks to see if the current domain has exhausted its
 rebalance interval. If so, it runs load_balance() on that domain. It then checks
 the parent sched_domain (if it exists), and the parent of the parent and so
 forth.
-- 
2.17.1


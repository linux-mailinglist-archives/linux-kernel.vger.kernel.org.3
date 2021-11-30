Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB8D463726
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242574AbhK3Ovx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:51:53 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:28198 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242456AbhK3OvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:51:14 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J3Q4y4jYFz8vhf;
        Tue, 30 Nov 2021 22:45:54 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 22:47:52 +0800
Received: from huawei.com (10.175.100.227) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 30 Nov
 2021 22:47:45 +0800
From:   Tang Yizhou <tangyizhou@huawei.com>
To:     <viresh.kumar@linaro.org>, <rafael.j.wysocki@intel.com>,
        <rafael@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tang Yizhou <tangyizhou@huawei.com>
Subject: [PATCH 1/2] cpufreq: Fix a comment in cpufreq_policy_free
Date:   Tue, 30 Nov 2021 23:15:25 +0800
Message-ID: <20211130151526.949-2-tangyizhou@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211130151526.949-1-tangyizhou@huawei.com>
References: <20211130151526.949-1-tangyizhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment is inconsistent with the block_notifier_call_chain() call,
so fix it.

Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e338d2f010fe..8f753675e4a2 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1296,7 +1296,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 
 	if (policy->max_freq_req) {
 		/*
-		 * CPUFREQ_CREATE_POLICY notification is sent only after
+		 * CPUFREQ_REMOVE_POLICY notification is sent only after
 		 * successfully adding max_freq_req request.
 		 */
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
-- 
2.17.1


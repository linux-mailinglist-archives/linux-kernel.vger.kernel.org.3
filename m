Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC9D464762
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 07:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347019AbhLAGuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 01:50:46 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:28202 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346996AbhLAGuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 01:50:44 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J3qN43yQtz8vjp;
        Wed,  1 Dec 2021 14:45:24 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 14:47:21 +0800
Received: from huawei.com (10.175.100.227) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 1 Dec
 2021 14:47:21 +0800
From:   Tang Yizhou <tangyizhou@huawei.com>
To:     <viresh.kumar@linaro.org>, <rafael.j.wysocki@intel.com>,
        <rafael@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tang Yizhou <tangyizhou@huawei.com>
Subject: [PATCH v2 2/2] doc/cpufreq: Update core.rst
Date:   Wed, 1 Dec 2021 15:15:00 +0800
Message-ID: <20211201071500.28648-3-tangyizhou@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201071500.28648-1-tangyizhou@huawei.com>
References: <20211201071500.28648-1-tangyizhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the definition of struct cpufreq_freqs has changed, update core.rst
with the new first member of struct cpufreq_freqs.

Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/cpu-freq/core.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/cpu-freq/core.rst b/Documentation/cpu-freq/core.rst
index 33cb90bd1d8f..4ceef8e7217c 100644
--- a/Documentation/cpu-freq/core.rst
+++ b/Documentation/cpu-freq/core.rst
@@ -73,12 +73,12 @@ CPUFREQ_POSTCHANGE.
 The third argument is a struct cpufreq_freqs with the following
 values:
 
-=====	===========================
-cpu	number of the affected CPU
+======	======================================
+policy	a pointer to the struct cpufreq_policy
 old	old frequency
 new	new frequency
 flags	flags of the cpufreq driver
-=====	===========================
+======	======================================
 
 3. CPUFreq Table Generation with Operating Performance Point (OPP)
 ==================================================================
-- 
2.17.1


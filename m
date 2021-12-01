Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CD446475F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 07:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346994AbhLAGun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 01:50:43 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:28136 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhLAGum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 01:50:42 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J3qMC3NRKz1DJqt;
        Wed,  1 Dec 2021 14:44:39 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 14:47:20 +0800
Received: from huawei.com (10.175.100.227) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 1 Dec
 2021 14:47:20 +0800
From:   Tang Yizhou <tangyizhou@huawei.com>
To:     <viresh.kumar@linaro.org>, <rafael.j.wysocki@intel.com>,
        <rafael@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tang Yizhou <tangyizhou@huawei.com>
Subject: [PATCH v2 0/2] cpufreq: Update function comment and document
Date:   Wed, 1 Dec 2021 15:14:58 +0800
Message-ID: <20211201071500.28648-1-tangyizhou@huawei.com>
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

v2:
1. Take viresh's advice and update the comments in cpufreq.c
2. Add an Acked-by tag in Patch 2.

Tang Yizhou (2):
  cpufreq: Fix a comment in cpufreq_policy_free
  doc/cpufreq: Update core.rst

 Documentation/cpu-freq/core.rst | 6 +++---
 drivers/cpufreq/cpufreq.c       | 9 +++++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCC64898B6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245562AbiAJMiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:38:09 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30267 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245525AbiAJMiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:38:07 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JXYHq1w3HzbjqB;
        Mon, 10 Jan 2022 20:37:27 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 20:38:05 +0800
Received: from [10.174.177.232] (10.174.177.232) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 20:38:04 +0800
Subject: Re: [PATCH] docs: scheduler: Fix outdated parameter of
 rebalance_domains
To:     <peterz@infradead.org>, <mingo@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <corbet@lwn.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <zhengbin13@huawei.com>, <tangyeechou@gmail.com>
References: <20211221031818.23186-1-tangyizhou@huawei.com>
From:   Tang Yizhou <tangyizhou@huawei.com>
Message-ID: <d48506d2-91bb-7d40-12c1-5c16ad89916a@huawei.com>
Date:   Mon, 10 Jan 2022 20:38:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20211221031818.23186-1-tangyizhou@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.232]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping.
Any feedback?

On 2021/12/21 11:18, Tang Yizhou wrote:
> According to the function prototype of rebalance_domains(), its first
> parameter is *rq* and the document need to be updated.
> 
> Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
> ---
>  Documentation/scheduler/sched-domains.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/scheduler/sched-domains.rst
> index 84dcdcd2911c..e57ad28301bd 100644
> --- a/Documentation/scheduler/sched-domains.rst
> +++ b/Documentation/scheduler/sched-domains.rst
> @@ -37,10 +37,10 @@ rebalancing event for the current runqueue has arrived. The actual load
>  balancing workhorse, run_rebalance_domains()->rebalance_domains(), is then run
>  in softirq context (SCHED_SOFTIRQ).
>  
> -The latter function takes two arguments: the current CPU and whether it was idle
> -at the time the scheduler_tick() happened and iterates over all sched domains
> -our CPU is on, starting from its base domain and going up the ->parent chain.
> -While doing that, it checks to see if the current domain has exhausted its
> +The latter function takes two arguments: the runqueue of current CPU and whether
> +the CPU was idle at the time the scheduler_tick() happened and iterates over all
> +sched domains our CPU is on, starting from its base domain and going up the ->parent
> +chain. While doing that, it checks to see if the current domain has exhausted its
>  rebalance interval. If so, it runs load_balance() on that domain. It then checks
>  the parent sched_domain (if it exists), and the parent of the parent and so
>  forth.
> 

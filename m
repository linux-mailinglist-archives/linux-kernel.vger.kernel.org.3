Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3F84781DC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 02:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhLQBCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 20:02:02 -0500
Received: from mga06.intel.com ([134.134.136.31]:30340 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229988AbhLQBCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 20:02:01 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="300424400"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="300424400"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 17:02:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="756311035"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga005.fm.intel.com with ESMTP; 16 Dec 2021 17:02:00 -0800
Date:   Thu, 16 Dec 2021 17:00:41 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/fair: fix all kernel-doc warnings
Message-ID: <20211217010041.GA13109@ranerica-svr.sc.intel.com>
References: <20211214000859.24427-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214000859.24427-1-rdunlap@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 04:08:59PM -0800, Randy Dunlap wrote:
> Quieten all kernel-doc warnings in kernel/sched/fair.c:
> 
> kernel/sched/fair.c:3663: warning: No description found for return value of 'update_cfs_rq_load_avg'
> kernel/sched/fair.c:8601: warning: No description found for return value of 'asym_smt_can_pull_tasks'
> kernel/sched/fair.c:8673: warning: Function parameter or member 'sds' not described in 'update_sg_lb_stats'
> kernel/sched/fair.c:9483: warning: contents before sections
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> --- next-2021-1210.orig/kernel/sched/fair.c
> +++ next-2021-1210/kernel/sched/fair.c
> @@ -3653,7 +3653,7 @@ static inline void add_tg_cfs_propagate(
>   *
>   * cfs_rq->avg is used for task_h_load() and update_cfs_share() for example.
>   *
> - * Returns true if the load decayed or we removed load.
> + * Return: true if the load decayed or we removed load.
>   *
>   * Since both these conditions indicate a changed cfs_rq->avg.load we should
>   * call update_tg_load_avg() when this function returns true.
> @@ -8594,6 +8594,8 @@ group_type group_classify(unsigned int i
>   *
>   * If @sg does not have SMT siblings, only pull tasks if all of the SMT siblings
>   * of @dst_cpu are idle and @sg has lower priority.
> + *
> + * Return: true if the load-balancing CPU can pull tasks, false otherwise.

Can we say "Return: true if @dst_cpu can pull tasks, false otherwise"?
The load-balancing CPU is not always the same as dst_cpu.

Thanks and BR,
Ricardo

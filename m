Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AFA47E67F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 17:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349290AbhLWQkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 11:40:37 -0500
Received: from mga07.intel.com ([134.134.136.100]:40686 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240012AbhLWQkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 11:40:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640277636; x=1671813636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dfSiGzoHn4jhgzXe9/dQYD8rIt36YpcL4EadkkrmPkw=;
  b=LaRMGA8tlSF5bK3spVDth5OtXHgslFFLXjLYJQWjJS24sNtTQCUv2J60
   dvryzZ4O93fshFzpa2DjvRSZH9+/vCb5mhXQcsbiIn5R12UddvwWBmnCK
   tG2fQynEI4kSAR9H2T898VZmpw6jtpfISJtr1FjbYVur0TphSnQSTzZPd
   tANEn+uHOkl5UPebxLelHBqfCghuvOO01CKlL0X5xabGD/cHaxiW76XKM
   ZlfJCa5WBbvTTGhWs0EOjKjVoq/HN6WQtaLYaO5bF06i/zHTDsmGnwLHE
   H31CkZTcFI0C32hC/KXF527PwVflOV+Jq/NZMRfMi3kNLI3u4IzFemmOa
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="304222205"
X-IronPort-AV: E=Sophos;i="5.88,230,1635231600"; 
   d="scan'208";a="304222205"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 08:40:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,230,1635231600"; 
   d="scan'208";a="522147370"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 23 Dec 2021 08:40:35 -0800
Date:   Thu, 23 Dec 2021 08:39:11 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2] sched/fair: fix all kernel-doc warnings
Message-ID: <20211223163911.GA633@ranerica-svr.sc.intel.com>
References: <20211218055900.2704-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218055900.2704-1-rdunlap@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 09:59:00PM -0800, Randy Dunlap wrote:
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
> v2: Tweak the Return: text of asym_smt_can_pull_tasks() [per Ricardo]

Thank you very much considering the proposed tweak, and also taking care
of this issue.

FWIW, Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

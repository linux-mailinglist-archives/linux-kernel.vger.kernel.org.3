Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D64479905
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 06:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhLRFwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 00:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbhLRFwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 00:52:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98120C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 21:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=r2cPolnJMtn1KOUKK74IyKZjSIHAcFPC13gYJVgzIGw=; b=pRPSf5EGTUk45wZhhwrBA7zPrE
        S/MMGkYWLuhYHM6diyoq2oCZgFXoIM1Gu/E1O6IdFjci9nreDJiXEQVdZJBCajhs7gpK/iDCOrPj9
        2wZkBRTP2nMM3Zf06t5m21K6gAwACXyjVi1MJ2g6JbXIlPFZmgFdg/t6TfW/aga1lR9PhdjZNPWpg
        o1kKg2BmPITQzs7vwto8Ls84Gi7/0fj0CgoTfrCFp1G+HHz+VuFpBliQKKvExO83JvIdiyLXIngmk
        qbsLDINz5KTNFkJNZnuizR3p9dcaQQPkZjYFeHUc93OXZcGbWQ3w53fgNEXcnMv6byA7IDTh4Zqm4
        0KglzxNw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mySdz-00HLY3-TG; Sat, 18 Dec 2021 05:52:33 +0000
Message-ID: <2bd4c519-1f96-583b-0b05-4091a171db4a@infradead.org>
Date:   Fri, 17 Dec 2021 21:52:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 2/2] smp: Fix kernel-doc related mistakes
Content-Language: en-US
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20211216144053.229-1-thunder.leizhen@huawei.com>
 <20211216144053.229-3-thunder.leizhen@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20211216144053.229-3-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/21 06:40, Zhen Lei wrote:
> 1. Change "function-name:" to "function-name -".
> 2. The kernel-doc comments should start with "/**".
> 3. Add descriptions for the missing parameters.
> 4. Fix a mismatched function name in the comment.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.


> ---
>  kernel/smp.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 1e5221fe200296a..d00cc8e0e5d8b16 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -698,8 +698,9 @@ void flush_smp_call_function_from_idle(void)
>  	local_irq_restore(flags);
>  }
>  
> -/*
> +/**
>   * smp_call_function_single - Run a function on a specific CPU
> + * @cpu:  The CPU to run on.
>   * @func: The function to run. This must be fast and non-blocking.
>   * @info: An arbitrary pointer to pass to the function.
>   * @wait: If true, wait until function has completed on other CPUs.
> @@ -809,7 +810,7 @@ int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
>  }
>  EXPORT_SYMBOL_GPL(smp_call_function_single_async);
>  
> -/*
> +/**
>   * smp_call_function_any - Run a function on any of the given cpus
>   * @mask: The mask of cpus it can run on.
>   * @func: The function to run. This must be fast and non-blocking.
> @@ -1005,7 +1006,7 @@ void smp_call_function_many(const struct cpumask *mask,
>  EXPORT_SYMBOL(smp_call_function_many);
>  
>  /**
> - * smp_call_function(): Run a function on all other CPUs.
> + * smp_call_function() - Run a function on all other CPUs.
>   * @func: The function to run. This must be fast and non-blocking.
>   * @info: An arbitrary pointer to pass to the function.
>   * @wait: If true, wait (atomically) until function has completed
> @@ -1111,8 +1112,8 @@ void __init smp_init(void)
>  	smp_cpus_done(setup_max_cpus);
>  }
>  
> -/*
> - * on_each_cpu_cond(): Call a function on each processor for which
> +/**
> + * on_each_cpu_cond_mask() - Call a function on each processor for which
>   * the supplied function cond_func returns true, optionally waiting
>   * for all the required CPUs to finish. This may include the local
>   * processor.
> @@ -1126,6 +1127,7 @@ void __init smp_init(void)
>   * @info:	An arbitrary pointer to pass to both functions.
>   * @wait:	If true, wait (atomically) until function has
>   *		completed on other CPUs.
> + * @mask:	The set of cpus to run on (only runs on online subset).
>   *
>   * Preemption is disabled to protect against CPUs going offline but not online.
>   * CPUs going online during the call will not be seen or sent an IPI.

-- 
~Randy

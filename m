Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F524A9087
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 23:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355730AbiBCWOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 17:14:54 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51816 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbiBCWOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 17:14:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28107B835A3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 22:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA14C340E8;
        Thu,  3 Feb 2022 22:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643926490;
        bh=a08cA2+MvMzPCszfm3boTtzcuffOYv1km28NtJz8sG8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dYCi/VhBr0fVuCdQkd4nwCNOvOQfWLN+1bXH3NPgXAFIv4+p7Z4Bgpp+uEoT1zHar
         Zv3nS+kTO1oxFQyZtDQmPLBzoIP8sNvOkLc2yRji2M6jRKjxANXPhL7P08IpLgaEoD
         XqGKC4lg7rUQgtZWus7+QIQWApl0RQkpKmJHmYgFvzKUd0Spk/3qlDrGuTi7B8PhUh
         e7yNu9ABV1FdnI34Dtslg5JlfXnDWkF84yeWAzY2izrAF6klpnis0irs7a3quVwF/k
         upI221r2qSfUExeQ1GaDRladup/0n8fEwSiqmUdOpRmQjMbxjQOJzfGZNAcs5wtMIe
         rAG3HQjtPc5dw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 96E7A5C08B7; Thu,  3 Feb 2022 14:14:50 -0800 (PST)
Date:   Thu, 3 Feb 2022 14:14:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ammarfaizi2-block:paulmck/linux-rcu/dev.2022.02.01a 77/103]
 kernel/rcu/srcutree.c:424:5: error: 'struct srcu_struct' has no member named
 'srcu_size_state'
Message-ID: <20220203221450.GS4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202202031012.PzmEcyQ4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202031012.PzmEcyQ4-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 11:00:18AM +0800, kernel test robot wrote:
> tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev.2022.02.01a
> head:   5721fe42e5e76b24e5a37c4fb5a4807cd4eb925d
> commit: efbdb910e14b15835266c55ad4d891dde0792aed [77/103] srcu: Dynamically allocate srcu_node array
> config: i386-randconfig-a004-20211220 (https://download.01.org/0day-ci/archive/20220203/202202031012.PzmEcyQ4-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/ammarfaizi2/linux-block/commit/efbdb910e14b15835266c55ad4d891dde0792aed
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev.2022.02.01a
>         git checkout efbdb910e14b15835266c55ad4d891dde0792aed
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> Note: the ammarfaizi2-block/paulmck/linux-rcu/dev.2022.02.01a HEAD 5721fe42e5e76b24e5a37c4fb5a4807cd4eb925d builds fine.
>       It only hurts bisectability.
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/rcu/srcutree.c: In function 'cleanup_srcu_struct':
> >> kernel/rcu/srcutree.c:424:5: error: 'struct srcu_struct' has no member named 'srcu_size_state'
>      424 |  ssp->srcu_size_state = SRCU_SIZE_SMALL;
>          |     ^~
> >> kernel/rcu/srcutree.c:424:25: error: 'SRCU_SIZE_SMALL' undeclared (first use in this function)
>      424 |  ssp->srcu_size_state = SRCU_SIZE_SMALL;
>          |                         ^~~~~~~~~~~~~~~
>    kernel/rcu/srcutree.c:424:25: note: each undeclared identifier is reported only once for each function it appears in

Good catch!

Folded the fix into the commit with attribution, thank you!

							Thanx, Paul

> vim +424 kernel/rcu/srcutree.c
> 
>    387	
>    388	/**
>    389	 * cleanup_srcu_struct - deconstruct a sleep-RCU structure
>    390	 * @ssp: structure to clean up.
>    391	 *
>    392	 * Must invoke this after you are finished using a given srcu_struct that
>    393	 * was initialized via init_srcu_struct(), else you leak memory.
>    394	 */
>    395	void cleanup_srcu_struct(struct srcu_struct *ssp)
>    396	{
>    397		int cpu;
>    398	
>    399		if (WARN_ON(!srcu_get_delay(ssp)))
>    400			return; /* Just leak it! */
>    401		if (WARN_ON(srcu_readers_active(ssp)))
>    402			return; /* Just leak it! */
>    403		flush_delayed_work(&ssp->work);
>    404		for_each_possible_cpu(cpu) {
>    405			struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
>    406	
>    407			del_timer_sync(&sdp->delay_work);
>    408			flush_work(&sdp->work);
>    409			if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
>    410				return; /* Forgot srcu_barrier(), so just leak it! */
>    411		}
>    412		if (WARN_ON(rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
>    413		    WARN_ON(rcu_seq_current(&ssp->srcu_gp_seq) != ssp->srcu_gp_seq_needed) ||
>    414		    WARN_ON(srcu_readers_active(ssp))) {
>    415			pr_info("%s: Active srcu_struct %p read state: %d gp state: %lu/%lu\n",
>    416				__func__, ssp, rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)),
>    417				rcu_seq_current(&ssp->srcu_gp_seq), ssp->srcu_gp_seq_needed);
>    418			return; /* Caller forgot to stop doing call_srcu()? */
>    419		}
>    420		free_percpu(ssp->sda);
>    421		ssp->sda = NULL;
>    422		kfree(ssp->node);
>    423		ssp->node = NULL;
>  > 424		ssp->srcu_size_state = SRCU_SIZE_SMALL;
>    425	}
>    426	EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
>    427	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

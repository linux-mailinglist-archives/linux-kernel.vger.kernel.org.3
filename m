Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10C9488450
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 16:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbiAHPtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 10:49:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38880 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiAHPtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 10:49:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C00FEB802C8
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 15:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891E7C36AE3;
        Sat,  8 Jan 2022 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641656988;
        bh=SMi38AdDstcomFSVT757zCAwyW9k+sUBUCia3EQrNNk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=frwMKd/6esGGt03LblIQetf06JUn6qtZVVFmSv0d8Ew+gKfrb3OiM/nvj+BPrluOk
         p8iezd0Mc8waeWPUdrcgPCQX+AioW6hHfh1+b66mmPTVsBhgOw1RbfWMsLKtvlElEr
         NP97ueBw0u3y5xVNtO+hlndEALHquvDevDJRliHYLfpvrKz3hk5qVb9vqY6Bx4ekFW
         /alwHlvNfZOlj0+xV6kNpvSk8YOGtpRlF0MAQfD2kUU07BPUNcSZ6RB6jxfO6ujnRy
         DF/HLOiGvRvR3SmIrlN3A2uyenR01M784bLadQVS/2KZ0Gc5uQsDBcDH4pc4y+EIO6
         QPHg3muXjQsFQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3E6AF5C08B7; Sat,  8 Jan 2022 07:49:48 -0800 (PST)
Date:   Sat, 8 Jan 2022 07:49:48 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2022.01.04a 52/55] kernel/stop_machine.c:207:6:
 warning: variable 't' set but not used
Message-ID: <20220108154948.GT4202@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202201082041.wv0NluSe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201082041.wv0NluSe-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 08:25:34PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.01.04a
> head:   64595d0dff992756e8c6d53c0e9f1e3e50c451f7
> commit: 5cd99ef59351bcdd73ce5412934fda67d0ca2a1c [52/55] EXP timers: NMI stacktraces for last-resort jiffies update
> config: s390-randconfig-r026-20220107 (https://download.01.org/0day-ci/archive/20220108/202201082041.wv0NluSe-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 32167bfe64a4c5dd4eb3f7a58e24f4cba76f5ac2)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install s390 cross compiling tool for clang build
>         # apt-get install binutils-s390x-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=5cd99ef59351bcdd73ce5412934fda67d0ca2a1c
>         git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags paulmck-rcu dev.2022.01.04a
>         git checkout 5cd99ef59351bcdd73ce5412934fda67d0ca2a1c
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

This is a debug-only commit, since dropped.  But thank you for your
ongoing testing efforts!

							Thanx, Paul

> All warnings (new ones prefixed by >>):
> 
> >> kernel/stop_machine.c:207:6: warning: variable 't' set but not used [-Wunused-but-set-variable]
>            u64 t;
>                ^
>    1 warning generated.
> 
> 
> vim +/t +207 kernel/stop_machine.c
> 
>    201	
>    202	static void dump_multi_cpu_stop_state(struct multi_stop_data *msdata, bool *firsttime)
>    203	{
>    204		struct cpu_stopper *stopper;
>    205		unsigned long flags;
>    206		int cpu;
>  > 207		u64 t;
>    208	
>    209		tick_setup_sched_timer_dump();
>    210		pr_info("%s threads %d/%d state %d\n", __func__, atomic_read(&msdata->thread_ack), msdata->num_threads, msdata->state);
>    211		for_each_online_cpu(cpu) {
>    212			if (cpu_is_offline(cpu))
>    213				continue;
>    214			stopper = &per_cpu(cpu_stopper, cpu);
>    215			raw_spin_lock_irqsave(&stopper->lock, flags);
>    216			t = ktime_get();
>    217	//		tlast = stopper->lasttime;
>    218			pr_info("%s: %s%s ->state=%#x%s\n", __func__, stopper->thread->comm, stopper->thread == current ? " (me)" : "", stopper->thread->__state, task_curr(stopper->thread) ? "" : " Not running!");
>    219			raw_spin_unlock_irqrestore(&stopper->lock, flags);
>    220			if (firsttime && *firsttime && !task_curr(stopper->thread)) {
>    221				trigger_single_cpu_backtrace(cpu);
>    222				*firsttime = false;
>    223			}
>    224	//		if (time_after64(t, tlast + NSEC_PER_SEC) &&
>    225	//		    smp_load_acquire(&multi_stop_cpu_ipi_handled)) {
>    226	//			pr_info("%s: sending IPI from CPU %d to CPU %d\n", __func__, raw_smp_processor_id(), cpu);
>    227	//			WRITE_ONCE(multi_stop_cpu_ipi_handled, false);
>    228	//			smp_mb();
>    229	//			smp_call_function_single(cpu, multi_stop_cpu_ipi, NULL, 0);
>    230	//		}
>    231		}
>    232	}
>    233	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

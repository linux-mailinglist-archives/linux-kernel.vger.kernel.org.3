Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726C552DF0A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245086AbiESVPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiESVPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:15:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F039C6B095
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652994937; x=1684530937;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a8ltGqH3LVPBX3/MiBqKwFuLq+CMpJvRg03U11DStU8=;
  b=ix81lebMDA8DIyg/nuvqeaoPut2ASfwUXiU/jf5EyWtZC7O3yH4bgcMC
   mGtI31w2EfQh8Ah9AB8GgGeXksWmNocyZivdFIK8DMTshoQ6ErjHGole0
   XHMQPqRwewjmn/Rzb6AbZaURrlGdcjKiqE8ystVMJg6ujBWf5U+kn+Imk
   xK7vaKKQR+CGQkxjdwx9SWv26y4x8lGfT36LhOxiDpdcC7Id6FFeSiAD8
   tAJz6vB/JtSzcXA5TS6A4GdBDugEekVZl4HeIUg/ziQF08eNmR9cTBCxe
   99Z18GyE6U2Dq/ASaRn4W0WmA28NdHhNq9Q9G/5IuGmzSyIcTXjgiiArq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="259959043"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="259959043"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 14:15:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="661911635"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 19 May 2022 14:15:36 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrnUd-0003xB-OT;
        Thu, 19 May 2022 21:15:35 +0000
Date:   Fri, 20 May 2022 05:15:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:context-tracking.2022.05.19a 20/21]
 kernel/context_tracking.c:500:25: error: implicit declaration of function
 'ct_kernel_exit'; did you mean 'is_kernel_text'?
Message-ID: <202205200530.nX4ZzOAH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git context-tracking.2022.05.19a
head:   6153dca9e37b244684bf472728f5c3688c5b0aca
commit: 02be5e537043004b7c133565ae473daf19a99e5d [20/21] rcu/context_tracking: Merge dynticks counter and context tracking states
config: arm-randconfig-r012-20220519 (https://download.01.org/0day-ci/archive/20220520/202205200530.nX4ZzOAH-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=02be5e537043004b7c133565ae473daf19a99e5d
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu context-tracking.2022.05.19a
        git checkout 02be5e537043004b7c133565ae473daf19a99e5d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/context_tracking.c: In function '__ct_user_enter':
>> kernel/context_tracking.c:500:25: error: implicit declaration of function 'ct_kernel_exit'; did you mean 'is_kernel_text'? [-Werror=implicit-function-declaration]
     500 |                         ct_kernel_exit(true, RCU_DYNTICKS_IDX + state);
         |                         ^~~~~~~~~~~~~~
         |                         is_kernel_text
   kernel/context_tracking.c: In function '__ct_user_exit':
>> kernel/context_tracking.c:607:25: error: implicit declaration of function 'ct_kernel_enter'; did you mean 'ct_idle_enter'? [-Werror=implicit-function-declaration]
     607 |                         ct_kernel_enter(true, RCU_DYNTICKS_IDX - state);
         |                         ^~~~~~~~~~~~~~~
         |                         ct_idle_enter
   cc1: some warnings being treated as errors


vim +500 kernel/context_tracking.c

   451	
   452	/**
   453	 * __ct_user_enter - Inform the context tracking that the CPU is going
   454	 *		     to enter user or guest space mode.
   455	 *
   456	 * This function must be called right before we switch from the kernel
   457	 * to user or guest space, when it's guaranteed the remaining kernel
   458	 * instructions to execute won't use any RCU read side critical section
   459	 * because this function sets RCU in extended quiescent state.
   460	 */
   461	void noinstr __ct_user_enter(enum ctx_state state)
   462	{
   463		struct context_tracking *ct = this_cpu_ptr(&context_tracking);
   464		lockdep_assert_irqs_disabled();
   465	
   466		/* Kernel threads aren't supposed to go to userspace */
   467		WARN_ON_ONCE(!current->mm);
   468	
   469		if (!context_tracking_recursion_enter())
   470			return;
   471	
   472		if (__ct_state() != state) {
   473			if (ct->active) {
   474				/*
   475				 * At this stage, only low level arch entry code remains and
   476				 * then we'll run in userspace. We can assume there won't be
   477				 * any RCU read-side critical section until the next call to
   478				 * user_exit() or ct_irq_enter(). Let's remove RCU's dependency
   479				 * on the tick.
   480				 */
   481				if (state == CONTEXT_USER) {
   482					instrumentation_begin();
   483					trace_user_enter(0);
   484					vtime_user_enter(current);
   485					instrumentation_end();
   486				}
   487				/*
   488				 * Other than generic entry implementation, we may be past the last
   489				 * rescheduling opportunity in the entry code. Trigger a self IPI
   490				 * that will fire and reschedule once we resume in user/guest mode.
   491				 */
   492				rcu_irq_work_resched();
   493	
   494				/*
   495				 * Enter RCU idle mode right before resuming userspace.  No use of RCU
   496				 * is permitted between this call and rcu_eqs_exit(). This way the
   497				 * CPU doesn't need to maintain the tick for RCU maintenance purposes
   498				 * when the CPU runs in userspace.
   499				 */
 > 500				ct_kernel_exit(true, RCU_DYNTICKS_IDX + state);
   501	
   502				/*
   503				 * Special case if we only track user <-> kernel transitions for tickless
   504				 * cputime accounting but we don't support RCU extended quiescent state.
   505				 * In this we case we don't care about any concurrency/ordering.
   506				 */
   507				if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE))
   508					atomic_set(&ct->state, state);
   509			} else {
   510				/*
   511				 * Even if context tracking is disabled on this CPU, because it's outside
   512				 * the full dynticks mask for example, we still have to keep track of the
   513				 * context transitions and states to prevent inconsistency on those of
   514				 * other CPUs.
   515				 * If a task triggers an exception in userspace, sleep on the exception
   516				 * handler and then migrate to another CPU, that new CPU must know where
   517				 * the exception returns by the time we call exception_exit().
   518				 * This information can only be provided by the previous CPU when it called
   519				 * exception_enter().
   520				 * OTOH we can spare the calls to vtime and RCU when context_tracking.active
   521				 * is false because we know that CPU is not tickless.
   522				 */
   523				if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE)) {
   524					/* Tracking for vtime only, no concurrent RCU EQS accounting */
   525					atomic_set(&ct->state, state);
   526				} else {
   527					/*
   528					 * Tracking for vtime and RCU EQS. Make sure we don't race
   529					 * with NMIs. OTOH we don't care about ordering here since
   530					 * RCU only requires RCU_DYNTICKS_IDX increments to be fully
   531					 * ordered.
   532					 */
   533					atomic_add(state, &ct->state);
   534				}
   535			}
   536		}
   537		context_tracking_recursion_exit();
   538	}
   539	EXPORT_SYMBOL_GPL(__ct_user_enter);
   540	
   541	/*
   542	 * FIXME: This function should be noinstr but the below local_irq_restore() is
   543	 * unsafe because it involves illegal RCU uses through tracing and lockdep. This
   544	 * must be fixed first.
   545	 */
   546	void ct_user_enter(enum ctx_state state)
   547	{
   548		unsigned long flags;
   549	
   550		/*
   551		 * Some contexts may involve an exception occuring in an irq,
   552		 * leading to that nesting:
   553		 * ct_irq_enter() rcu_eqs_exit(true) rcu_eqs_enter(true) ct_irq_exit()
   554		 * This would mess up the dyntick_nesting count though. And rcu_irq_*()
   555		 * helpers are enough to protect RCU uses inside the exception. So
   556		 * just return immediately if we detect we are in an IRQ.
   557		 */
   558		if (in_interrupt())
   559			return;
   560	
   561		local_irq_save(flags);
   562		__ct_user_enter(state);
   563		local_irq_restore(flags);
   564	}
   565	NOKPROBE_SYMBOL(ct_user_enter);
   566	EXPORT_SYMBOL_GPL(ct_user_enter);
   567	
   568	/**
   569	 * user_enter_callable() - Unfortunate ASM callable version of user_enter() for
   570	 * 			   archs that didn't manage to check the context tracking
   571	 * 			   static key from low level code.
   572	 *
   573	 * FIXME: This function should be noinstr but it unsafely calls local_irq_restore(),
   574	 * involving illegal RCU uses through tracing and lockdep. This must be fixed first.
   575	 */
   576	void user_enter_callable(void)
   577	{
   578		user_enter();
   579	}
   580	NOKPROBE_SYMBOL(user_enter_callable);
   581	
   582	/**
   583	 * __ct_user_exit - Inform the context tracking that the CPU is
   584	 * 		    exiting user or guest mode and entering the kernel.
   585	 *
   586	 * This function must be called after we entered the kernel from user or
   587	 * guest space before any use of RCU read side critical section. This
   588	 * potentially include any high level kernel code like syscalls, exceptions,
   589	 * signal handling, etc...
   590	 *
   591	 * This call supports re-entrancy. This way it can be called from any exception
   592	 * handler without needing to know if we came from userspace or not.
   593	 */
   594	void noinstr __ct_user_exit(enum ctx_state state)
   595	{
   596		struct context_tracking *ct = this_cpu_ptr(&context_tracking);
   597	
   598		if (!context_tracking_recursion_enter())
   599			return;
   600	
   601		if (__ct_state() == state) {
   602			if (ct->active) {
   603				/*
   604				 * Exit RCU idle mode while entering the kernel because it can
   605				 * run a RCU read side critical section anytime.
   606				 */
 > 607				ct_kernel_enter(true, RCU_DYNTICKS_IDX - state);
   608				if (state == CONTEXT_USER) {
   609					instrumentation_begin();
   610					vtime_user_exit(current);
   611					trace_user_exit(0);
   612					instrumentation_end();
   613				}
   614	
   615				/*
   616				 * Special case if we only track user <-> kernel transitions for tickless
   617				 * cputime accounting but we don't support RCU extended quiescent state.
   618				 * In this we case we don't care about any concurrency/ordering.
   619				 */
   620				if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE))
   621					atomic_set(&ct->state, CONTEXT_KERNEL);
   622	
   623			} else {
   624				if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE)) {
   625					/* Tracking for vtime only, no concurrent RCU EQS accounting */
   626					atomic_set(&ct->state, CONTEXT_KERNEL);
   627				} else {
   628					/*
   629					 * Tracking for vtime and RCU EQS. Make sure we don't race
   630					 * with NMIs. OTOH we don't care about ordering here since
   631					 * RCU only requires RCU_DYNTICKS_IDX increments to be fully
   632					 * ordered.
   633					 */
   634					atomic_sub(state, &ct->state);
   635				}
   636			}
   637		}
   638		context_tracking_recursion_exit();
   639	}
   640	EXPORT_SYMBOL_GPL(__ct_user_exit);
   641	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

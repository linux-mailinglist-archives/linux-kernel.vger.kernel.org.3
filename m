Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037344CB30F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 00:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiCBXsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 18:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiCBXsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 18:48:17 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A844108BCF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 15:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646264789; x=1677800789;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rZgD0e7StjysBcKfEnwI4/9mWixjUGri4p/xVp8Ksq0=;
  b=EnO7yoFh/7wtA7Vhc/G8PYChlpq0xw3Dbd34sd448hYcOrpZ3Yz9VKv2
   QG7fz0S7snlflR8sb94a9XcDlHwAgtIiYNWooL5MmofECloAmACiEe3lX
   m7o7sPx/gGZcCoSdva85Wl53wRQnd16+HJLG4HyQWZ8R1aJ0ZaAT9T1pB
   Dh0gPncTxcTKqpB17BSL6AQCmJLBvJwTx1JF6O1II2A6/u2J7BHtXuHUQ
   nQtCN0SC0ilAN9Woa5K1KlICOE39BBMv+h6hl0XD/7EALTjhc+S6M6oHT
   Ipnn9p7dRHE2I/YsUOsDOqkVTa4se0f4OSy1QupSntu8BfkM3gK4G2oup
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="316745004"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="316745004"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 15:33:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="686295716"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 02 Mar 2022 15:33:00 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPYSp-00024x-M5; Wed, 02 Mar 2022 23:32:59 +0000
Date:   Thu, 3 Mar 2022 07:32:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [frederic-dynticks:rcu/context-tracking 14/19]
 kernel/rcu/tree.c:634:6: error: redefinition of '__rcu_irq_enter_check_tick'
Message-ID: <202203030727.5aqUHWC6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git rcu/context-tracking
head:   e4eaff86ec91c1cbde9a113cf5232dac9f897337
commit: 5a91f02835a27bd066154ab87408505806710e19 [14/19] rcu/context-tracking: Move RCU-dynticks internal functions to context_tracking
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220303/202203030727.5aqUHWC6-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git/commit/?id=5a91f02835a27bd066154ab87408505806710e19
        git remote add frederic-dynticks https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
        git fetch --no-tags frederic-dynticks rcu/context-tracking
        git checkout 5a91f02835a27bd066154ab87408505806710e19
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/rcu/tree.c:634:6: error: redefinition of '__rcu_irq_enter_check_tick'
     634 | void __rcu_irq_enter_check_tick(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/interrupt.h:11,
                    from kernel/rcu/tree.c:26:
   include/linux/hardirq.h:19:20: note: previous definition of '__rcu_irq_enter_check_tick' was here
      19 | static inline void __rcu_irq_enter_check_tick(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/rcu/tree.c:4457:
   kernel/rcu/tree_plugin.h:932:13: error: static declaration of 'rcu_preempt_deferred_qs' follows non-static declaration
     932 | static void rcu_preempt_deferred_qs(struct task_struct *t)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/rcupdate.h:227,
                    from include/linux/rcupdate_wait.h:9,
                    from kernel/rcu/tree.c:25:
   include/linux/rcutree.h:63:6: note: previous declaration of 'rcu_preempt_deferred_qs' was here
      63 | void rcu_preempt_deferred_qs(struct task_struct *t);
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/rcu/tree.c:4457:
   kernel/rcu/tree_plugin.h:932:13: warning: 'rcu_preempt_deferred_qs' defined but not used [-Wunused-function]
     932 | static void rcu_preempt_deferred_qs(struct task_struct *t)
         |             ^~~~~~~~~~~~~~~~~~~~~~~


vim +/__rcu_irq_enter_check_tick +634 kernel/rcu/tree.c

07325d4a90d2d84 kernel/rcu/tree.c Thomas Gleixner  2020-05-21  607  
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  608  /**
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  609   * __rcu_irq_enter_check_tick - Enable scheduler tick on CPU if RCU needs it.
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  610   *
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  611   * The scheduler tick is not normally enabled when CPUs enter the kernel
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  612   * from nohz_full userspace execution.  After all, nohz_full userspace
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  613   * execution is an RCU quiescent state and the time executing in the kernel
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  614   * is quite short.  Except of course when it isn't.  And it is not hard to
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  615   * cause a large system to spend tens of seconds or even minutes looping
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  616   * in the kernel, which can cause a number of problems, include RCU CPU
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  617   * stall warnings.
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  618   *
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  619   * Therefore, if a nohz_full CPU fails to report a quiescent state
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  620   * in a timely manner, the RCU grace-period kthread sets that CPU's
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  621   * ->rcu_urgent_qs flag with the expectation that the next interrupt or
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  622   * exception will invoke this function, which will turn on the scheduler
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  623   * tick, which will enable RCU to detect that CPU's quiescent states,
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  624   * for example, due to cond_resched() calls in CONFIG_PREEMPT=n kernels.
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  625   * The tick will be disabled once a quiescent state is reported for
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  626   * this CPU.
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  627   *
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  628   * Of course, in carefully tuned systems, there might never be an
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  629   * interrupt or exception.  In that case, the RCU grace-period kthread
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  630   * will eventually cause one to happen.  However, in less carefully
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  631   * controlled environments, this function allows RCU to get what it
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  632   * needs without creating otherwise useless interruptions.
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  633   */
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21 @634  void __rcu_irq_enter_check_tick(void)
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  635  {
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  636  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  637  
6dbce04d8417ae7 kernel/rcu/tree.c Peter Zijlstra   2020-11-16  638  	// If we're here from NMI there's nothing to do.
6dbce04d8417ae7 kernel/rcu/tree.c Peter Zijlstra   2020-11-16  639  	if (in_nmi())
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  640  		return;
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  641  
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  642  	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  643  			 "Illegal rcu_irq_enter_check_tick() from extended quiescent state");
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  644  
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  645  	if (!tick_nohz_full_cpu(rdp->cpu) ||
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  646  	    !READ_ONCE(rdp->rcu_urgent_qs) ||
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  647  	    READ_ONCE(rdp->rcu_forced_tick)) {
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  648  		// RCU doesn't need nohz_full help from this CPU, or it is
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  649  		// already getting that help.
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  650  		return;
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  651  	}
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  652  
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  653  	// We get here only when not in an extended quiescent state and
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  654  	// from interrupts (as opposed to NMIs).  Therefore, (1) RCU is
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  655  	// already watching and (2) The fact that we are in an interrupt
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  656  	// handler and that the rcu_node lock is an irq-disabled lock
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  657  	// prevents self-deadlock.  So we can safely recheck under the lock.
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  658  	// Note that the nohz_full state currently cannot change.
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  659  	raw_spin_lock_rcu_node(rdp->mynode);
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  660  	if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  661  		// A nohz_full CPU is in the kernel and RCU needs a
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  662  		// quiescent state.  Turn on the tick!
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  663  		WRITE_ONCE(rdp->rcu_forced_tick, true);
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  664  		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  665  	}
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  666  	raw_spin_unlock_rcu_node(rdp->mynode);
aaf2bc50df1f4bf kernel/rcu/tree.c Paul E. McKenney 2020-05-21  667  }
64db4cfff99c04c kernel/rcutree.c  Paul E. McKenney 2008-12-18  668  

:::::: The code at line 634 was first introduced by commit
:::::: aaf2bc50df1f4bfc6857fc601fc7b21d5a18c6a1 rcu: Abstract out rcu_irq_enter_check_tick() from rcu_nmi_enter()

:::::: TO: Paul E. McKenney <paulmck@kernel.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

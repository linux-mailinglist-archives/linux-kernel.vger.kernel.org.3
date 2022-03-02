Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552414CB268
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiCBWls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiCBWlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:41:46 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FA11081A4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 14:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646260858; x=1677796858;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9FIYzNkONGxijq/XPlpQ6HzZY+AIuiBe0UaM+u8WmAU=;
  b=fr84AEbOLkvyD/KOmyKDfDkjCf8dOK09JVcRLw+nU6gHEQj7D9/K8oxH
   2cngaAtgZrK9kJYYyc16OaM34TqpnJa8p193cP9blxg9C7NbSD+a+a7c8
   xuf7hzGoeamVhD+xbVc5EPk9VZegwvGdWQ6oXzQ7aJHoBlVzE1CB+5jWh
   SmGqJDbTg8VC/zqXC0Kbo6bRyFKXprgtDXzABOHEZAZzdsdJ3vULLH7bH
   bTRWegp7HYjfQ90FWKXInsvnLe1wyLjkO1yzui/zGeFLNeyhearejVFkI
   k0WJwl9CPdvd8JORz7h6TuJRQyu9j5/NoYXpRAMqmgelMQijx91iG7Hia
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253451034"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="253451034"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 14:40:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="641870535"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 02 Mar 2022 14:40:56 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPXeR-00021A-Rh; Wed, 02 Mar 2022 22:40:55 +0000
Date:   Thu, 3 Mar 2022 06:40:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [frederic-dynticks:rcu/context-tracking 14/19]
 kernel/rcu/tree.c:634:6: error: redefinition of '__rcu_irq_enter_check_tick'
Message-ID: <202203030604.SXPvt45B-lkp@intel.com>
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
config: hexagon-randconfig-r001-20220302 (https://download.01.org/0day-ci/archive/20220303/202203030604.SXPvt45B-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git/commit/?id=5a91f02835a27bd066154ab87408505806710e19
        git remote add frederic-dynticks https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
        git fetch --no-tags frederic-dynticks rcu/context-tracking
        git checkout 5a91f02835a27bd066154ab87408505806710e19
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/rcu/tree.c:65:
   include/linux/context_tracking.h:106:30: error: incomplete result type 'enum ctx_state' in function definition
   static inline enum ctx_state exception_enter(void) { return 0; }
                                ^
   include/linux/context_tracking.h:106:20: note: forward declaration of 'enum ctx_state'
   static inline enum ctx_state exception_enter(void) { return 0; }
                      ^
   include/linux/context_tracking.h:106:61: error: returning 'int' from a function with incompatible result type 'enum ctx_state'
   static inline enum ctx_state exception_enter(void) { return 0; }
                                                               ^
   include/linux/context_tracking.h:107:50: error: variable has incomplete type 'enum ctx_state'
   static inline void exception_exit(enum ctx_state prev_ctx) { }
                                                    ^
   include/linux/context_tracking.h:106:20: note: forward declaration of 'enum ctx_state'
   static inline enum ctx_state exception_enter(void) { return 0; }
                      ^
   include/linux/context_tracking.h:108:30: error: incomplete result type 'enum ctx_state' in function definition
   static inline enum ctx_state ct_state(void) { return CONTEXT_DISABLED; }
                                ^
   include/linux/context_tracking.h:106:20: note: forward declaration of 'enum ctx_state'
   static inline enum ctx_state exception_enter(void) { return 0; }
                      ^
   include/linux/context_tracking.h:108:54: error: use of undeclared identifier 'CONTEXT_DISABLED'; did you mean 'CPU_SMT_DISABLED'?
   static inline enum ctx_state ct_state(void) { return CONTEXT_DISABLED; }
                                                        ^~~~~~~~~~~~~~~~
                                                        CPU_SMT_DISABLED
   include/linux/cpu.h:205:2: note: 'CPU_SMT_DISABLED' declared here
           CPU_SMT_DISABLED,
           ^
   In file included from kernel/rcu/tree.c:65:
   include/linux/context_tracking.h:108:54: error: returning 'int' from a function with incompatible result type 'enum ctx_state'
   static inline enum ctx_state ct_state(void) { return CONTEXT_DISABLED; }
                                                        ^~~~~~~~~~~~~~~~
>> kernel/rcu/tree.c:634:6: error: redefinition of '__rcu_irq_enter_check_tick'
   void __rcu_irq_enter_check_tick(void)
        ^
   include/linux/hardirq.h:19:20: note: previous definition is here
   static inline void __rcu_irq_enter_check_tick(void) { }
                      ^
   In file included from kernel/rcu/tree.c:4457:
>> kernel/rcu/tree_plugin.h:932:13: error: static declaration of 'rcu_preempt_deferred_qs' follows non-static declaration
   static void rcu_preempt_deferred_qs(struct task_struct *t)
               ^
   include/linux/rcutree.h:63:6: note: previous declaration is here
   void rcu_preempt_deferred_qs(struct task_struct *t);
        ^
   8 errors generated.


vim +/__rcu_irq_enter_check_tick +634 kernel/rcu/tree.c

07325d4a90d2d8 kernel/rcu/tree.c Thomas Gleixner  2020-05-21  607  
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  608  /**
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  609   * __rcu_irq_enter_check_tick - Enable scheduler tick on CPU if RCU needs it.
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  610   *
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  611   * The scheduler tick is not normally enabled when CPUs enter the kernel
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  612   * from nohz_full userspace execution.  After all, nohz_full userspace
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  613   * execution is an RCU quiescent state and the time executing in the kernel
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  614   * is quite short.  Except of course when it isn't.  And it is not hard to
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  615   * cause a large system to spend tens of seconds or even minutes looping
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  616   * in the kernel, which can cause a number of problems, include RCU CPU
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  617   * stall warnings.
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  618   *
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  619   * Therefore, if a nohz_full CPU fails to report a quiescent state
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  620   * in a timely manner, the RCU grace-period kthread sets that CPU's
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  621   * ->rcu_urgent_qs flag with the expectation that the next interrupt or
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  622   * exception will invoke this function, which will turn on the scheduler
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  623   * tick, which will enable RCU to detect that CPU's quiescent states,
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  624   * for example, due to cond_resched() calls in CONFIG_PREEMPT=n kernels.
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  625   * The tick will be disabled once a quiescent state is reported for
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  626   * this CPU.
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  627   *
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  628   * Of course, in carefully tuned systems, there might never be an
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  629   * interrupt or exception.  In that case, the RCU grace-period kthread
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  630   * will eventually cause one to happen.  However, in less carefully
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  631   * controlled environments, this function allows RCU to get what it
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  632   * needs without creating otherwise useless interruptions.
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  633   */
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21 @634  void __rcu_irq_enter_check_tick(void)
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  635  {
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  636  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  637  
6dbce04d8417ae kernel/rcu/tree.c Peter Zijlstra   2020-11-16  638  	// If we're here from NMI there's nothing to do.
6dbce04d8417ae kernel/rcu/tree.c Peter Zijlstra   2020-11-16  639  	if (in_nmi())
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  640  		return;
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  641  
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  642  	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  643  			 "Illegal rcu_irq_enter_check_tick() from extended quiescent state");
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  644  
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  645  	if (!tick_nohz_full_cpu(rdp->cpu) ||
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  646  	    !READ_ONCE(rdp->rcu_urgent_qs) ||
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  647  	    READ_ONCE(rdp->rcu_forced_tick)) {
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  648  		// RCU doesn't need nohz_full help from this CPU, or it is
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  649  		// already getting that help.
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  650  		return;
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  651  	}
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  652  
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  653  	// We get here only when not in an extended quiescent state and
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  654  	// from interrupts (as opposed to NMIs).  Therefore, (1) RCU is
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  655  	// already watching and (2) The fact that we are in an interrupt
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  656  	// handler and that the rcu_node lock is an irq-disabled lock
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  657  	// prevents self-deadlock.  So we can safely recheck under the lock.
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  658  	// Note that the nohz_full state currently cannot change.
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  659  	raw_spin_lock_rcu_node(rdp->mynode);
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  660  	if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  661  		// A nohz_full CPU is in the kernel and RCU needs a
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  662  		// quiescent state.  Turn on the tick!
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  663  		WRITE_ONCE(rdp->rcu_forced_tick, true);
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  664  		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  665  	}
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  666  	raw_spin_unlock_rcu_node(rdp->mynode);
aaf2bc50df1f4b kernel/rcu/tree.c Paul E. McKenney 2020-05-21  667  }
64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney 2008-12-18  668  

:::::: The code at line 634 was first introduced by commit
:::::: aaf2bc50df1f4bfc6857fc601fc7b21d5a18c6a1 rcu: Abstract out rcu_irq_enter_check_tick() from rcu_nmi_enter()

:::::: TO: Paul E. McKenney <paulmck@kernel.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

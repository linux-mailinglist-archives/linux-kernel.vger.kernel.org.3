Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5412F4D18E9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347008AbiCHNR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239880AbiCHNRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:17:22 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B25329A6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 05:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646745386; x=1678281386;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qBMbKYX4x3bHuKY7+zqJkWKYElF7F6le/6VQvb8A96U=;
  b=bEMt/QFo076jxXU7bxraZF1PpgWUjkFxvf7JrBgTSEDMphhV7RWGsb/D
   675vmhMdYlOKJao1tCDfE8XnXzZCxwwX4IJCQ4lm0Pb3EFdL3Ps96kmQd
   EoN+G1q5L0VxllV/P1l7GIhy0rn5iAlqgFi+Gz0ImQoPKRvhgwouSFuGY
   yY4dC226mBCuHktnMr0iTfds+ZwUcWGlPm3llym1iZc7036Cfvv/QhdmL
   Nnz/8M2QO7kUHTgj33F+K1JazzsYbQT043NTreTPgF+f2B0ugwWGv90LO
   sq5ZQzHp/MQGEqoNeYSdHDg0IQtxoVdYvvjZv/8RzU2/f8JRwbuHzSsYv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="252250733"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="252250733"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 05:16:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="537562707"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 08 Mar 2022 05:16:24 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRZhP-0001R4-NB; Tue, 08 Mar 2022 13:16:23 +0000
Date:   Tue, 8 Mar 2022 21:15:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev 82/84]
 kernel/rcu/tree.c:2678:17: error: implicit declaration of function
 'rcu_tasks_classic_qs'
Message-ID: <202203082147.h7DGjo3z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev
head:   fb8d1afe45bd6fcb50dff8bac4636725358fde94
commit: c8c42c80febd4e6d346f7f62958300eb8205aa31 [82/84] rcu-tasks: Make Tasks RCU account for userspace execution
config: arm-oxnas_v6_defconfig (https://download.01.org/0day-ci/archive/20220308/202203082147.h7DGjo3z-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/c8c42c80febd4e6d346f7f62958300eb8205aa31
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
        git checkout c8c42c80febd4e6d346f7f62958300eb8205aa31
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/rcu/tree.c: In function 'rcu_sched_clock_irq':
>> kernel/rcu/tree.c:2678:17: error: implicit declaration of function 'rcu_tasks_classic_qs' [-Werror=implicit-function-declaration]
    2678 |                 rcu_tasks_classic_qs(current, false);
         |                 ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/rcu_tasks_classic_qs +2678 kernel/rcu/tree.c

  2644	
  2645	/*
  2646	 * This function is invoked from each scheduling-clock interrupt,
  2647	 * and checks to see if this CPU is in a non-context-switch quiescent
  2648	 * state, for example, user mode or idle loop.  It also schedules RCU
  2649	 * core processing.  If the current grace period has gone on too long,
  2650	 * it will ask the scheduler to manufacture a context switch for the sole
  2651	 * purpose of providing the needed quiescent state.
  2652	 */
  2653	void rcu_sched_clock_irq(int user)
  2654	{
  2655		unsigned long j;
  2656	
  2657		if (IS_ENABLED(CONFIG_PROVE_RCU)) {
  2658			j = jiffies;
  2659			WARN_ON_ONCE(time_before(j, __this_cpu_read(rcu_data.last_sched_clock)));
  2660			__this_cpu_write(rcu_data.last_sched_clock, j);
  2661		}
  2662		trace_rcu_utilization(TPS("Start scheduler-tick"));
  2663		lockdep_assert_irqs_disabled();
  2664		raw_cpu_inc(rcu_data.ticks_this_gp);
  2665		/* The load-acquire pairs with the store-release setting to true. */
  2666		if (smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs))) {
  2667			/* Idle and userspace execution already are quiescent states. */
  2668			if (!rcu_is_cpu_rrupt_from_idle() && !user) {
  2669				set_tsk_need_resched(current);
  2670				set_preempt_need_resched();
  2671			}
  2672			__this_cpu_write(rcu_data.rcu_urgent_qs, false);
  2673		}
  2674		rcu_flavor_sched_clock_irq(user);
  2675		if (rcu_pending(user))
  2676			invoke_rcu_core();
  2677		if (user)
> 2678			rcu_tasks_classic_qs(current, false);
  2679		lockdep_assert_irqs_disabled();
  2680	
  2681		trace_rcu_utilization(TPS("End scheduler-tick"));
  2682	}
  2683	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

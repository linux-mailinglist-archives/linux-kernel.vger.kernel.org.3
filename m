Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828E94D1CA3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbiCHQCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348256AbiCHQB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:01:56 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5443750055
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646755249; x=1678291249;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aFTJDJ6yKoaxFI6g8sPE9CQvYWqYMdAKSLo3OBtYCBs=;
  b=Q2q2h4KYtLqxcNffUenWZlZEdti3HmRvpuJ/fKMTBeUENO69Xi/RAEGM
   yyFpJmWKawTjH883oQxfULlcoiQyrE95XOx2OQYJF0ztPmhGJ26YBhfsk
   SV0tkGb+PP1QVMqwBJL0LeN7tQKUo/p/ptn4+ppV18gDnjSVga2ee6mHQ
   Co91YzvHJU/aOLoRK5hMknV7nzIwIOxhZ1ZrnC3jch5KZJqSs2uGR9uHR
   tCtRqwOk2w7CGt/qDcHwuV2GVvNVUqdQfSniXjgt3CuS/YIWQBnGlDClQ
   vDtf/8o7SSnfOFfVZS+z8aHEBApQGuh7AtHa7Alg156zzrZUhiZVppF2u
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="234673925"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="234673925"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 08:00:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="632273708"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Mar 2022 08:00:30 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRcGD-0001eD-9O; Tue, 08 Mar 2022 16:00:29 +0000
Date:   Wed, 9 Mar 2022 00:00:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev 82/84]
 kernel/rcu/tree.c:2678:3: error: implicit declaration of function
 'rcu_tasks_classic_qs'
Message-ID: <202203082348.j9qeWzns-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev
head:   fb8d1afe45bd6fcb50dff8bac4636725358fde94
commit: c8c42c80febd4e6d346f7f62958300eb8205aa31 [82/84] rcu-tasks: Make Tasks RCU account for userspace execution
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220308/202203082348.j9qeWzns-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/ammarfaizi2/linux-block/commit/c8c42c80febd4e6d346f7f62958300eb8205aa31
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
        git checkout c8c42c80febd4e6d346f7f62958300eb8205aa31
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/rcu/tree.c:2678:3: error: implicit declaration of function 'rcu_tasks_classic_qs' [-Werror,-Wimplicit-function-declaration]
                   rcu_tasks_classic_qs(current, false);
                   ^
   1 error generated.


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

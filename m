Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7194885A5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 20:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiAHTqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 14:46:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:2714 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232465AbiAHTqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 14:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641671169; x=1673207169;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=35nZ20U422RN/BRD0jZpYcPohzo2aifD6MGyPte3vMg=;
  b=GWdY8X++N0ZfYYucrq2bPrFL57DFdwo3VrC8RPJWOlvtIXW00/Q4SDqL
   3woFwxFtxPR3k32Jl15z6DBVHXDDWs12g2AYO+DYT4IJ7ZUPVnvtnhCa+
   D2owyC2YGiJE0TFqUZTx8V0t/t6TtcYL6CVWhCfs0r2+1274OsP7e8P2D
   dsaQ4Gc1gtwOrVfjcHy7zbmtmvhl5hvwYXHNcZLpNmQldwMPUe+Sc9hQP
   G62xUBGKmz9BM+GAFFbYiolkkLGZ/cWAa1QyeDCXgfk2vEhkvgbmXdwvd
   7LPUmjTaK24Pak2gPO4ZbQb0vPOTbVsFKyde91nZopIi/OZksMKJ2B8n4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="303778590"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="303778590"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 11:46:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="690146780"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Jan 2022 11:46:07 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6HfD-0000zH-9m; Sat, 08 Jan 2022 19:46:07 +0000
Date:   Sun, 9 Jan 2022 03:46:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 195/2375] init/main.c:950:34: error: no
 member named 'scoped_addresses' in 'struct kcsan_ctx'; did you mean
 'scoped_accesses'?
Message-ID: <202201090354.nbf3mWlN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   351ceeab2ef96ab2fc306934ddb201b44636181b
commit: 0116b9ccb23abb8af60eaf1cef4557ef993a5dc9 [195/2375] headers/deps: kcsan: Move task_struct::kcsan_ctx to per_task()
config: x86_64-randconfig-r002-20220108 (https://download.01.org/0day-ci/archive/20220109/202201090354.nbf3mWlN-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f3a344d2125fa37e59bae1b0874442c650a19607)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=0116b9ccb23abb8af60eaf1cef4557ef993a5dc9
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 0116b9ccb23abb8af60eaf1cef4557ef993a5dc9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   init/main.c:790:20: warning: no previous prototype for function 'mem_encrypt_init' [-Wmissing-prototypes]
   void __init __weak mem_encrypt_init(void) { }
                      ^
   init/main.c:790:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak mem_encrypt_init(void) { }
   ^
   static 
>> init/main.c:950:34: error: no member named 'scoped_addresses' in 'struct kcsan_ctx'; did you mean 'scoped_accesses'?
           per_task(&init_task, kcsan_ctx).scoped_addresses.next = LIST_POISON1;
                                           ^~~~~~~~~~~~~~~~
                                           scoped_accesses
   include/linux/kcsan.h:55:19: note: 'scoped_accesses' declared here
           struct list_head scoped_accesses;
                            ^
   init/main.c:891:13: warning: no previous prototype for function 'init_per_task_early' [-Wmissing-prototypes]
   void __init init_per_task_early(void)
               ^
   init/main.c:891:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init init_per_task_early(void)
   ^
   static 
   2 warnings and 1 error generated.


vim +950 init/main.c

   890	
   891	void __init init_per_task_early(void)
   892	{
   893	#ifdef CONFIG_THREAD_INFO_IN_TASK
   894		per_task(&init_task, ti) = (struct thread_info) INIT_THREAD_INFO(init_task);
   895	#endif
   896	#ifdef CONFIG_POSIX_TIMERS
   897		per_task(&init_task, posix_cputimers) = (struct posix_cputimers) __INIT_CPU_TIMERS(init_task);
   898	#endif
   899		task_thread(&init_task) = (struct thread_struct) INIT_THREAD;
   900	
   901		INIT_LIST_HEAD(&per_task(&init_task, rt).run_list);
   902		per_task(&init_task, rt).time_slice = RR_TIMESLICE;
   903	
   904		INIT_LIST_HEAD(&per_task(&init_task, se).group_node);
   905	
   906		per_task(&init_task, stack) = init_stack;
   907	
   908		refcount_set(&per_task(&init_task, usage), 2);
   909	#ifdef CONFIG_THREAD_INFO_IN_TASK
   910		refcount_set(&per_task(&init_task, stack_refcount), 1);
   911	#endif
   912	#ifdef CONFIG_CGROUP_SCHED
   913		per_task(&init_task, sched_task_group) = &root_task_group;
   914	#endif
   915	#ifdef CONFIG_TASKS_RCU
   916		per_task(&init_task, rcu_tasks_idle_cpu) = -1;
   917		INIT_LIST_HEAD(&per_task(&init_task, rcu_tasks_holdout_list));
   918	#endif
   919	#ifdef CONFIG_CPUSETS
   920		per_task(&init_task, mems_allowed_seq) = (seqcount_spinlock_t) SEQCNT_SPINLOCK_ZERO(init_task.mems_allowed_seq,
   921							 &per_task(&init_task, alloc_lock));
   922	#endif
   923		per_task(&init_task, restart_block).fn = do_no_restart_syscall;
   924	#ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
   925		seqcount_init(&per_task(&init_task, vtime).seqcount);
   926		per_task(&init_task, vtime).state = VTIME_SYS;
   927	#endif
   928	#ifdef CONFIG_PERF_EVENTS
   929		mutex_init(&per_task(&init_task, perf_event_mutex));
   930		INIT_LIST_HEAD(&per_task(&init_task, perf_event_list));
   931	#endif
   932	#ifdef CONFIG_SMP
   933		plist_node_init(&per_task(&init_task, pushable_tasks), MAX_PRIO);
   934	#endif
   935	#ifdef CONFIG_AUDIT
   936		per_task(&init_task, loginuid) = INVALID_UID;
   937	#endif
   938		per_task(&init_task, cpus_mask) = CPU_MASK_ALL;
   939		per_task(&init_task, cpus_ptr) = &per_task(&init_task, cpus_mask);
   940		INIT_LIST_HEAD(&per_task(&init_task, pending).list);
   941	#ifdef CONFIG_RT_MUTEXES
   942		per_task(&init_task, pi_waiters) = RB_ROOT_CACHED;
   943	#endif
   944	#ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
   945		raw_spin_lock_init(&per_task(&init_task, prev_cputime).lock);
   946	#endif
   947		spin_lock_init(&per_task(&init_task, alloc_lock));
   948		raw_spin_lock_init(&per_task(&init_task, pi_lock));
   949	#ifdef CONFIG_KCSAN
 > 950		per_task(&init_task, kcsan_ctx).scoped_addresses.next = LIST_POISON1;
   951	#endif
   952	}
   953	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

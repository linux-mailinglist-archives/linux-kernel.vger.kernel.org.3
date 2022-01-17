Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1517948FFB4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 01:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbiAQAHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 19:07:21 -0500
Received: from mga04.intel.com ([192.55.52.120]:57103 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233951AbiAQAHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 19:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642378039; x=1673914039;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v0ox1EzZUEN6ZRNiCjKVYNl6s/iSfQwQBzcZXTTsmUM=;
  b=KV47oXkCPw7IipgwbBIuHhW8fYiFvsJuR0SEstuWhRCBX3TCaxhoRjDk
   B5cnhw5cmvVInsHxObdzauLEaRNBpxL97wyY7aKQBCYtGcDh8nO91EGSB
   St5DzUxQMHB71RBlUrThnN0LPKe4Qi4QEuSpgFAsjRJTCbPOllx2MGqkS
   mZjKIdg8OcxU9Jlo2HbxpSVdU8hyKxhzEcqk5AtlMpY4c8DuhDGcUUwBj
   0/79yZ1dwYjvz0gQI53BViQKItaFle+5dKAzIvxOMQ8aO0aMlK1ZTay77
   uG7uSGTD15vldTJWioOiBunFYWvZ6tmTxLQZ8JGZd21g7EUF4Pg/cYrf3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="243348164"
X-IronPort-AV: E=Sophos;i="5.88,294,1635231600"; 
   d="scan'208";a="243348164"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 16:07:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,294,1635231600"; 
   d="scan'208";a="692885672"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Jan 2022 16:07:17 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9FYL-000B4k-5t; Mon, 17 Jan 2022 00:07:17 +0000
Date:   Mon, 17 Jan 2022 08:06:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 195/2384] init/main.c:947:34: error: no
 member named 'scoped_addresses' in 'struct kcsan_ctx'; did you mean
 'scoped_accesses'?
Message-ID: <202201170819.f8ENBRJK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: 358c0016c619cb96065fc10b25be736053481392 [195/2384] headers/deps: kcsan: Move task_struct::kcsan_ctx to per_task()
config: x86_64-randconfig-c007 (https://download.01.org/0day-ci/archive/20220117/202201170819.f8ENBRJK-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c63a3175c2947e8c1a2d3bbe16a8586600705c54)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=358c0016c619cb96065fc10b25be736053481392
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 358c0016c619cb96065fc10b25be736053481392
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
>> init/main.c:947:34: error: no member named 'scoped_addresses' in 'struct kcsan_ctx'; did you mean 'scoped_accesses'?
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


vim +947 init/main.c

   890	
   891	void __init init_per_task_early(void)
   892	{
   893	#ifdef CONFIG_POSIX_TIMERS
   894		per_task(&init_task, posix_cputimers) = (struct posix_cputimers) __INIT_CPU_TIMERS(init_task);
   895	#endif
   896		task_thread(&init_task) = (struct thread_struct) INIT_THREAD;
   897	
   898		INIT_LIST_HEAD(&per_task(&init_task, rt).run_list);
   899		per_task(&init_task, rt).time_slice = RR_TIMESLICE;
   900	
   901		INIT_LIST_HEAD(&per_task(&init_task, se).group_node);
   902	
   903		per_task(&init_task, stack) = init_stack;
   904	
   905		refcount_set(&per_task(&init_task, usage), 2);
   906	#ifdef CONFIG_THREAD_INFO_IN_TASK
   907		refcount_set(&per_task(&init_task, stack_refcount), 1);
   908	#endif
   909	#ifdef CONFIG_CGROUP_SCHED
   910		per_task(&init_task, sched_task_group) = &root_task_group;
   911	#endif
   912	#ifdef CONFIG_TASKS_RCU
   913		per_task(&init_task, rcu_tasks_idle_cpu) = -1;
   914		INIT_LIST_HEAD(&per_task(&init_task, rcu_tasks_holdout_list));
   915	#endif
   916	#ifdef CONFIG_CPUSETS
   917		per_task(&init_task, mems_allowed_seq) = (seqcount_spinlock_t) SEQCNT_SPINLOCK_ZERO(init_task.mems_allowed_seq,
   918							 &per_task(&init_task, alloc_lock));
   919	#endif
   920		per_task(&init_task, restart_block).fn = do_no_restart_syscall;
   921	#ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
   922		seqcount_init(&per_task(&init_task, vtime).seqcount);
   923		per_task(&init_task, vtime).state = VTIME_SYS;
   924	#endif
   925	#ifdef CONFIG_PERF_EVENTS
   926		mutex_init(&per_task(&init_task, perf_event_mutex));
   927		INIT_LIST_HEAD(&per_task(&init_task, perf_event_list));
   928	#endif
   929	#ifdef CONFIG_SMP
   930		plist_node_init(&per_task(&init_task, pushable_tasks), MAX_PRIO);
   931	#endif
   932	#ifdef CONFIG_AUDIT
   933		per_task(&init_task, loginuid) = INVALID_UID;
   934	#endif
   935		per_task(&init_task, cpus_mask) = CPU_MASK_ALL;
   936		per_task(&init_task, cpus_ptr) = &per_task(&init_task, cpus_mask);
   937		INIT_LIST_HEAD(&per_task(&init_task, pending).list);
   938	#ifdef CONFIG_RT_MUTEXES
   939		per_task(&init_task, pi_waiters) = RB_ROOT_CACHED;
   940	#endif
   941	#ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
   942		raw_spin_lock_init(&per_task(&init_task, prev_cputime).lock);
   943	#endif
   944		spin_lock_init(&per_task(&init_task, alloc_lock));
   945		raw_spin_lock_init(&per_task(&init_task, pi_lock));
   946	#ifdef CONFIG_KCSAN
 > 947		per_task(&init_task, kcsan_ctx).scoped_addresses.next = LIST_POISON1;
   948	#endif
   949	}
   950	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

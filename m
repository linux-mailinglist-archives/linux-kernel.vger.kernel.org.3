Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3299F4F8A44
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiDGVNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiDGVNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:13:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947BA1834D0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649365910; x=1680901910;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CksLgshdJmUJfRNpGuxbwWtxfQexSszT5ilvZSV7Nuc=;
  b=hZdjwZgRpRh2hLRrlRdH6hABMLAtF8YHcjgYPCz32ECYJuhLGoxKB7H7
   9do8Ra6NgHj45UgIVsaX409l/GqqrbCkjVlOUDNJgPXtZjJPcS/tS8ljQ
   q/Uy/5dUun7Izp8wElPxy8bmArKEyVXHn5/HSxnKg9D2gPaoOx9jcXGFT
   V8qHhsV7y24VLF7CoO6BTp+xcnzYgQY42kT781YZEHCidFCSJI0l6ooqL
   m+73qZIhwSeuWFrMv5LKlRaJReopoK9GDaMwyBi0B3qkfEvtMsjexbgUI
   i5xgZKlnuTzQQq+GiWEGqE7j0KafMWBzM9+ReipCHRCaztJQLPVLf7JTm
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="243556713"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="243556713"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 12:31:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="609456988"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 07 Apr 2022 12:31:49 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncXrA-0005hv-SR;
        Thu, 07 Apr 2022 19:31:48 +0000
Date:   Fri, 8 Apr 2022 03:30:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [peterz-queue:sched/wip.freezer 1/5]
 include/linux/sched/signal.h:442:2: error: member reference type
 'spinlock_t' (aka 'struct spinlock') is not a pointer; did you mean to use
 '.'?
Message-ID: <202204080358.7U15ZTli-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/wip.freezer
head:   ed5b8f90d21512ee2392f35dbb0ab867c66d243d
commit: 422f0905663b42f6f9ad8a7ec6c5962c7c6ff9f3 [1/5] sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220408/202204080358.7U15ZTli-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b306233f78876a1d197ed6e1f05785505de7c63)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=422f0905663b42f6f9ad8a7ec6c5962c7c6ff9f3
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/wip.freezer
        git checkout 422f0905663b42f6f9ad8a7ec6c5962c7c6ff9f3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
>> include/linux/sched/signal.h:442:2: error: member reference type 'spinlock_t' (aka 'struct spinlock') is not a pointer; did you mean to use '.'?
           lockdep_assert_held(t->sighand->siglock);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:316:17: note: expanded from macro 'lockdep_assert_held'
           lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
           ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:286:52: note: expanded from macro 'lockdep_is_held'
   #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
                                                               ^
   include/linux/lockdep.h:310:32: note: expanded from macro 'lockdep_assert'
           do { WARN_ON(debug_locks && !(cond)); } while (0)
                ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   include/asm-generic/bug.h:121:25: note: expanded from macro 'WARN_ON'
           int __ret_warn_on = !!(condition);                              \
                                  ^~~~~~~~~
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
>> include/linux/sched/signal.h:442:2: error: cannot take the address of an rvalue of type 'struct lockdep_map'
           lockdep_assert_held(t->sighand->siglock);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:316:17: note: expanded from macro 'lockdep_assert_held'
           lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
           ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:286:45: note: expanded from macro 'lockdep_is_held'
   #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
                                                        ^
   include/linux/lockdep.h:310:32: note: expanded from macro 'lockdep_assert'
           do { WARN_ON(debug_locks && !(cond)); } while (0)
                ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   include/asm-generic/bug.h:121:25: note: expanded from macro 'WARN_ON'
           int __ret_warn_on = !!(condition);                              \
                                  ^~~~~~~~~
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   include/linux/sched/signal.h:452:2: error: member reference type 'spinlock_t' (aka 'struct spinlock') is not a pointer; did you mean to use '.'?
           lockdep_assert_held(t->sighand->siglock);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:316:17: note: expanded from macro 'lockdep_assert_held'
           lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
           ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:286:52: note: expanded from macro 'lockdep_is_held'
   #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
                                                               ^
   include/linux/lockdep.h:310:32: note: expanded from macro 'lockdep_assert'
           do { WARN_ON(debug_locks && !(cond)); } while (0)
                ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   include/asm-generic/bug.h:121:25: note: expanded from macro 'WARN_ON'
           int __ret_warn_on = !!(condition);                              \
                                  ^~~~~~~~~
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   include/linux/sched/signal.h:452:2: error: cannot take the address of an rvalue of type 'struct lockdep_map'
           lockdep_assert_held(t->sighand->siglock);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:316:17: note: expanded from macro 'lockdep_assert_held'
           lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
           ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:286:45: note: expanded from macro 'lockdep_is_held'
   #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
                                                        ^
   include/linux/lockdep.h:310:32: note: expanded from macro 'lockdep_assert'
           do { WARN_ON(debug_locks && !(cond)); } while (0)
                ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   include/asm-generic/bug.h:121:25: note: expanded from macro 'WARN_ON'
           int __ret_warn_on = !!(condition);                              \
                                  ^~~~~~~~~
   4 errors generated.
   make[2]: *** [scripts/Makefile.build:120: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +442 include/linux/sched/signal.h

   439	
   440	static inline void signal_wake_up(struct task_struct *t, bool resume)
   441	{
 > 442		lockdep_assert_held(t->sighand->siglock);
   443	
   444		if (resume && !(t->jobctl & JOBCTL_TRACED_FROZEN))
   445			t->jobctl &= ~(JOBCTL_STOPPED | JOBCTL_TRACED);
   446	
   447		signal_wake_up_state(t, resume ? TASK_WAKEKILL : 0);
   448	}
   449	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

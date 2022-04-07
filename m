Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D514F8A2E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiDGUue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiDGUuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:50:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911103988BE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649364161; x=1680900161;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oC6fuHK9F6NYJsF+kVLNp7o1JKibw/eWNeX86rZRFJk=;
  b=P770ilvcQ4n1vua4hqN9Rv76QpxD20c1PBlcF5eup4CP7AFIpyRxHw/W
   3bd91ECRC1hraIDFBSicEqSJ5IwvIZd6+kJHcWdm618Mh0MmZqSWHP4X2
   nADi2YKgGCngU36FKvFQtO1GqmLb3bgxx74xWUHzY4jigwb5LMbN9jDG8
   9MIzRJn/xq3w72r3Ol6kljHQ3ohagOveugXpNERWmHNj+QD1LRU4gQTo3
   W6vGrFcYr8YjosGdiS3R2+ChF2OdC/5QdhDynoL1IRWKul/DysdpPtrjT
   thJYTHbxn3IWH1HTzpDfxLCdmSm4Bjpw/dyxtZJawM3inKuCqt9ayV8an
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261417526"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="261417526"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 12:30:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="659195549"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 07 Apr 2022 12:30:49 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncXqC-0005hr-RV;
        Thu, 07 Apr 2022 19:30:48 +0000
Date:   Fri, 8 Apr 2022 03:30:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:sched/wip.freezer 1/5] include/linux/lockdep.h:286:61:
 error: invalid type argument of '->' (have 'spinlock_t' {aka 'struct
 spinlock'})
Message-ID: <202204080315.hci59d2B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220408/202204080315.hci59d2B-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=422f0905663b42f6f9ad8a7ec6c5962c7c6ff9f3
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/wip.freezer
        git checkout 422f0905663b42f6f9ad8a7ec6c5962c7c6ff9f3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/sched/signal.h: In function 'signal_wake_up':
>> include/linux/lockdep.h:286:61: error: invalid type argument of '->' (have 'spinlock_t' {aka 'struct spinlock'})
     286 | #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
         |                                                             ^~
   include/asm-generic/bug.h:121:32: note: in definition of macro 'WARN_ON'
     121 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/lockdep.h:316:9: note: in expansion of macro 'lockdep_assert'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |         ^~~~~~~~~~~~~~
   include/linux/lockdep.h:316:24: note: in expansion of macro 'lockdep_is_held'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |                        ^~~~~~~~~~~~~~~
   include/linux/sched/signal.h:442:9: note: in expansion of macro 'lockdep_assert_held'
     442 |         lockdep_assert_held(t->sighand->siglock);
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/sched/signal.h: In function 'ptrace_signal_wake_up':
>> include/linux/lockdep.h:286:61: error: invalid type argument of '->' (have 'spinlock_t' {aka 'struct spinlock'})
     286 | #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
         |                                                             ^~
   include/asm-generic/bug.h:121:32: note: in definition of macro 'WARN_ON'
     121 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/lockdep.h:316:9: note: in expansion of macro 'lockdep_assert'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |         ^~~~~~~~~~~~~~
   include/linux/lockdep.h:316:24: note: in expansion of macro 'lockdep_is_held'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |                        ^~~~~~~~~~~~~~~
   include/linux/sched/signal.h:452:9: note: in expansion of macro 'lockdep_assert_held'
     452 |         lockdep_assert_held(t->sighand->siglock);
         |         ^~~~~~~~~~~~~~~~~~~
   make[2]: *** [scripts/Makefile.build:120: arch/riscv/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +286 include/linux/lockdep.h

f607c668577481 Peter Zijlstra 2009-07-20  285  
f8319483f57f1c Peter Zijlstra 2016-11-30 @286  #define lockdep_is_held(lock)		lock_is_held(&(lock)->dep_map)
f8319483f57f1c Peter Zijlstra 2016-11-30  287  #define lockdep_is_held_type(lock, r)	lock_is_held_type(&(lock)->dep_map, (r))
f607c668577481 Peter Zijlstra 2009-07-20  288  

:::::: The code at line 286 was first introduced by commit
:::::: f8319483f57f1ca22370f4150bb990aca7728a67 locking/lockdep: Provide a type check for lock_is_held

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Dave Chinner <david@fromorbit.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

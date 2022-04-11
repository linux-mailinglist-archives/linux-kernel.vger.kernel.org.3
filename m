Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C2B4FBB08
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345697AbiDKLgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239683AbiDKLgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:36:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20CA45790
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649676839; x=1681212839;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J1XCCQjXWWBMXQx9aa0OrRkdSAFyyrUhzS+F6bhYYIE=;
  b=ZcPUXtUVQHTY4j2fJyXree/sXF0KTvjLCuGYF9qR08khQawc5A5u1Ksh
   qSQtksAdohhvXoVTy46i7yXhpQa2XfNoYZ5YLUJoM64yCGcrB8BgLzTFk
   TXonukp2Le2jKm5cPSjftwjNYQyeMeMforXMcYwYJK2Grc+VtpTJPFU5B
   7gW6+TM2TCC209b79ou0gpuhjmZzFABQDtkCkbfXynpJf9drMAfr7DQDA
   ZvufNvuc7vB0VxNojUBM6zsvHl2rg0ydhuQwXyTr9yhopHbG/eg1rLTsE
   BU3mxXMToxDrbkT66vADG2zan4vDQPpzMglnSy9XecPXHxEo7Mt65Mzw0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="243977993"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="243977993"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 04:33:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="723932644"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 11 Apr 2022 04:33:58 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndsIv-0001ol-GK;
        Mon, 11 Apr 2022 11:33:57 +0000
Date:   Mon, 11 Apr 2022 19:33:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:sched/wip.freezer 1/5] include/linux/lockdep.h:286:61:
 error: invalid type argument of '->' (have 'spinlock_t' {aka 'struct
 spinlock'})
Message-ID: <202204111927.K61a3tKs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/wip.freezer
head:   d97bfb5c8b833363ad581ccd1c242d1f3641ff2f
commit: dbceed14e5bb2aa3bac7ff65fe6441479240f50f [1/5] sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED
config: i386-randconfig-s001-20220411 (https://download.01.org/0day-ci/archive/20220411/202204111927.K61a3tKs-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=dbceed14e5bb2aa3bac7ff65fe6441479240f50f
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/wip.freezer
        git checkout dbceed14e5bb2aa3bac7ff65fe6441479240f50f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/bug.h:87,
                    from include/linux/bug.h:5,
                    from include/linux/crypto.h:18,
                    from arch/x86/kernel/asm-offsets.c:9:
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
   make[2]: *** [scripts/Makefile.build:120: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +286 include/linux/lockdep.h

f607c6685774811 Peter Zijlstra 2009-07-20  285  
f8319483f57f1ca Peter Zijlstra 2016-11-30 @286  #define lockdep_is_held(lock)		lock_is_held(&(lock)->dep_map)
f8319483f57f1ca Peter Zijlstra 2016-11-30  287  #define lockdep_is_held_type(lock, r)	lock_is_held_type(&(lock)->dep_map, (r))
f607c6685774811 Peter Zijlstra 2009-07-20  288  

:::::: The code at line 286 was first introduced by commit
:::::: f8319483f57f1ca22370f4150bb990aca7728a67 locking/lockdep: Provide a type check for lock_is_held

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Dave Chinner <david@fromorbit.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

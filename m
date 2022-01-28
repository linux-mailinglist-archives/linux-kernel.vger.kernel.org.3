Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39F549F25F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 05:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346016AbiA1EUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 23:20:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:38022 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345968AbiA1ET4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 23:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643343596; x=1674879596;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FjoGarZzuqSjMpwHHQsNsciwmBhli4BwtOz9VjpJDOE=;
  b=OGchKycvJyKuhtPRXX+ACF3BRGRUt6VCNVJzrjrUdT/y9YuufXGuwi7T
   n7mCEqmyVAsBAjsvJCxvPTrvO/PJds1HrmvBjL485NsP1r2wYswGZdeUE
   1NLgF1CyvkEyDVRql558Z09HuW+HY1vO7P4/fqFPkGYaJ5/qeFjor9doj
   159gGhTOdoalVRNN9Ttw/a2BO0lxAj9zzOIjsf+tAh4seqnvp3Ja0+TZw
   WORZ4dI+XGsQvqif1nLjjaE8S5Uxk3Iq0ap5GF5tGFvVb5n/pUhCxqB1T
   MhcSJbOCob9ccOp5+tr8i0UgTD5VmFFwftaDyz1RxMs+p8+UMxGCbvB9U
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="246989337"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="246989337"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 20:19:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="696941467"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Jan 2022 20:19:53 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDIjp-000NSF-0o; Fri, 28 Jan 2022 04:19:53 +0000
Date:   Fri, 28 Jan 2022 12:19:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [clangbuiltlinux:reachability 2/6] include/linux/rcupdate.h:1001:2:
 error: expected ')'
Message-ID: <202201281234.J3kmDPwj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ClangBuiltLinux/linux reachability
head:   1ebaf6b87ee4d103be3d3f6e00fa4fcb18e7865e
commit: 473c4f04fa49864f6955062435d8bab02ff87862 [2/6] x86: bug.h: merge asm in __WARN_FLAGS
config: i386-randconfig-a011-20220124 (https://download.01.org/0day-ci/archive/20220128/202201281234.J3kmDPwj-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 33b45ee44b1f32ffdbc995e6fec806271b4b3ba4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ClangBuiltLinux/linux/commit/473c4f04fa49864f6955062435d8bab02ff87862
        git remote add clangbuiltlinux https://github.com/ClangBuiltLinux/linux
        git fetch --no-tags clangbuiltlinux reachability
        git checkout 473c4f04fa49864f6955062435d8bab02ff87862
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   include/linux/lockdep.h:316:2: note: expanded from macro 'lockdep_assert_held'
           lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
           ^
   include/linux/lockdep.h:310:7: note: expanded from macro 'lockdep_assert'
           do { WARN_ON(debug_locks && !(cond)); } while (0)
                ^
   include/asm-generic/bug.h:123:3: note: expanded from macro 'WARN_ON'
                   __WARN();                                               \
                   ^
   include/asm-generic/bug.h:96:19: note: expanded from macro '__WARN'
   #define __WARN()                __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
                                   ^
   arch/x86/include/asm/bug.h:82:25: note: expanded from macro '__WARN_FLAGS'
           _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);                  \
                                  ^
   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:20:
   In file included from include/linux/slab.h:15:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:16:
   include/linux/seqlock.h:278:1: error: expected ')'
   SEQCOUNT_LOCKNAME(rwlock,       rwlock_t,        __SEQ_RT, s->lock,        read,     read_lock(s->lock))
   ^
   include/linux/seqlock.h:247:13: note: expanded from macro 'SEQCOUNT_LOCKNAME'
           __SEQ_LOCK(lockdep_assert_held(lockmember));                    \
                      ^
   include/linux/lockdep.h:316:2: note: expanded from macro 'lockdep_assert_held'
           lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
           ^
   include/linux/lockdep.h:310:7: note: expanded from macro 'lockdep_assert'
           do { WARN_ON(debug_locks && !(cond)); } while (0)
                ^
   include/asm-generic/bug.h:123:3: note: expanded from macro 'WARN_ON'
                   __WARN();                                               \
                   ^
   include/asm-generic/bug.h:96:19: note: expanded from macro '__WARN'
   #define __WARN()                __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
                                   ^
   arch/x86/include/asm/bug.h:82:25: note: expanded from macro '__WARN_FLAGS'
           _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);                  \
                                  ^
   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:20:
   In file included from include/linux/slab.h:15:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:16:
   include/linux/seqlock.h:279:1: error: expected ')'
   SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
   ^
   include/linux/seqlock.h:247:13: note: expanded from macro 'SEQCOUNT_LOCKNAME'
           __SEQ_LOCK(lockdep_assert_held(lockmember));                    \
                      ^
   include/linux/lockdep.h:316:2: note: expanded from macro 'lockdep_assert_held'
           lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
           ^
   include/linux/lockdep.h:310:7: note: expanded from macro 'lockdep_assert'
           do { WARN_ON(debug_locks && !(cond)); } while (0)
                ^
   include/asm-generic/bug.h:123:3: note: expanded from macro 'WARN_ON'
                   __WARN();                                               \
                   ^
   include/asm-generic/bug.h:96:19: note: expanded from macro '__WARN'
   #define __WARN()                __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
                                   ^
   arch/x86/include/asm/bug.h:82:25: note: expanded from macro '__WARN_FLAGS'
           _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);                  \
                                  ^
   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:20:
   In file included from include/linux/slab.h:15:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:16:
   include/linux/seqlock.h:280:1: error: expected ')'
   SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
   ^
   include/linux/seqlock.h:247:13: note: expanded from macro 'SEQCOUNT_LOCKNAME'
           __SEQ_LOCK(lockdep_assert_held(lockmember));                    \
                      ^
   include/linux/lockdep.h:316:2: note: expanded from macro 'lockdep_assert_held'
           lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
           ^
   include/linux/lockdep.h:310:7: note: expanded from macro 'lockdep_assert'
           do { WARN_ON(debug_locks && !(cond)); } while (0)
                ^
   include/asm-generic/bug.h:123:3: note: expanded from macro 'WARN_ON'
                   __WARN();                                               \
                   ^
   include/asm-generic/bug.h:96:19: note: expanded from macro '__WARN'
   #define __WARN()                __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
                                   ^
   arch/x86/include/asm/bug.h:82:25: note: expanded from macro '__WARN_FLAGS'
           _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);                  \
                                  ^
   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:20:
   In file included from include/linux/slab.h:15:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:21:
   In file included from include/linux/mm_types.h:10:
   In file included from include/linux/rbtree.h:24:
>> include/linux/rcupdate.h:1001:2: error: expected ')'
           WARN_ON_ONCE(func != (rcu_callback_t)~0L);
           ^
   include/asm-generic/bug.h:106:3: note: expanded from macro 'WARN_ON_ONCE'
                   __WARN_FLAGS(BUGFLAG_ONCE |                     \
                   ^
   arch/x86/include/asm/bug.h:82:25: note: expanded from macro '__WARN_FLAGS'
           _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);                  \
                                  ^
   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:20:
   In file included from include/linux/slab.h:15:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:23:
   In file included from include/linux/local_lock.h:5:
>> include/linux/local_lock_internal.h:30:2: error: expected ')'
           DEBUG_LOCKS_WARN_ON(l->owner);
           ^
   include/linux/debug_locks.h:31:4: note: expanded from macro 'DEBUG_LOCKS_WARN_ON'
                           WARN(1, "DEBUG_LOCKS_WARN_ON(%s)", #c);         \
                           ^
   include/asm-generic/bug.h:132:3: note: expanded from macro 'WARN'
                   __WARN_printf(TAINT_WARN, format);                      \
                   ^
   include/asm-generic/bug.h:100:3: note: expanded from macro '__WARN_printf'
                   __WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
                   ^
   arch/x86/include/asm/bug.h:82:25: note: expanded from macro '__WARN_FLAGS'
           _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);                  \
                                  ^
   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:20:
   In file included from include/linux/slab.h:15:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:23:
   In file included from include/linux/local_lock.h:5:
   include/linux/local_lock_internal.h:36:2: error: expected ')'
           DEBUG_LOCKS_WARN_ON(l->owner != current);
           ^
   include/linux/debug_locks.h:31:4: note: expanded from macro 'DEBUG_LOCKS_WARN_ON'
                           WARN(1, "DEBUG_LOCKS_WARN_ON(%s)", #c);         \
                           ^
   include/asm-generic/bug.h:132:3: note: expanded from macro 'WARN'
                   __WARN_printf(TAINT_WARN, format);                      \
                   ^
   include/asm-generic/bug.h:100:3: note: expanded from macro '__WARN_printf'
                   __WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
                   ^
   arch/x86/include/asm/bug.h:82:25: note: expanded from macro '__WARN_FLAGS'
           _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);                  \
                                  ^
   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:20:
   In file included from include/linux/slab.h:15:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:942:
   In file included from include/linux/memory_hotplug.h:7:
   In file included from include/linux/notifier.h:16:
>> include/linux/srcu.h:188:2: error: expected ')'
           WARN_ON_ONCE(idx & ~0x1);
           ^
   include/asm-generic/bug.h:106:3: note: expanded from macro 'WARN_ON_ONCE'
                   __WARN_FLAGS(BUGFLAG_ONCE |                     \
                   ^
   arch/x86/include/asm/bug.h:82:25: note: expanded from macro '__WARN_FLAGS'
           _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);                  \
                                  ^
   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:20:
   In file included from include/linux/slab.h:19:
>> include/linux/percpu-refcount.h:280:2: error: expected ')'
           WARN_ON_ONCE(!rcu_read_lock_held());
           ^
   include/asm-generic/bug.h:106:3: note: expanded from macro 'WARN_ON_ONCE'
                   __WARN_FLAGS(BUGFLAG_ONCE |                     \
                   ^
   arch/x86/include/asm/bug.h:82:25: note: expanded from macro '__WARN_FLAGS'
           _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);                  \
                                  ^
   In file included from arch/x86/kernel/asm-offsets.c:10:
>> include/linux/sched.h:1816:2: error: expected ')'
           WARN_ON(p->user_cpus_ptr);
           ^
   include/asm-generic/bug.h:123:3: note: expanded from macro 'WARN_ON'
                   __WARN();                                               \
                   ^
   include/asm-generic/bug.h:96:19: note: expanded from macro '__WARN'
   #define __WARN()                __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
                                   ^
   arch/x86/include/asm/bug.h:82:25: note: expanded from macro '__WARN_FLAGS'
           _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);                  \
                                  ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.
   make[2]: *** [scripts/Makefile.build:121: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1197: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +1001 include/linux/rcupdate.h

74de6960c99d8d Paul E. McKenney 2018-07-24   980  
2aa5503026ceaa Paul E. McKenney 2018-11-20   981  /**
000601bb62330f Tobias Klauser   2020-07-09   982   * rcu_head_after_call_rcu() - Has this rcu_head been passed to call_rcu()?
74de6960c99d8d Paul E. McKenney 2018-07-24   983   * @rhp: The rcu_head structure to test.
2aa5503026ceaa Paul E. McKenney 2018-11-20   984   * @f: The function passed to call_rcu() along with @rhp.
74de6960c99d8d Paul E. McKenney 2018-07-24   985   *
74de6960c99d8d Paul E. McKenney 2018-07-24   986   * Returns @true if the @rhp has been passed to call_rcu() with @func,
74de6960c99d8d Paul E. McKenney 2018-07-24   987   * and @false otherwise.  Emits a warning in any other case, including
74de6960c99d8d Paul E. McKenney 2018-07-24   988   * the case where @rhp has already been invoked after a grace period.
74de6960c99d8d Paul E. McKenney 2018-07-24   989   * Calls to this function must not race with callback invocation.  One way
74de6960c99d8d Paul E. McKenney 2018-07-24   990   * to avoid such races is to enclose the call to rcu_head_after_call_rcu()
74de6960c99d8d Paul E. McKenney 2018-07-24   991   * in an RCU read-side critical section that includes a read-side fetch
74de6960c99d8d Paul E. McKenney 2018-07-24   992   * of the pointer to the structure containing @rhp.
74de6960c99d8d Paul E. McKenney 2018-07-24   993   */
74de6960c99d8d Paul E. McKenney 2018-07-24   994  static inline bool
74de6960c99d8d Paul E. McKenney 2018-07-24   995  rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
74de6960c99d8d Paul E. McKenney 2018-07-24   996  {
b699cce1604e82 Neeraj Upadhyay  2019-03-11   997  	rcu_callback_t func = READ_ONCE(rhp->func);
b699cce1604e82 Neeraj Upadhyay  2019-03-11   998  
b699cce1604e82 Neeraj Upadhyay  2019-03-11   999  	if (func == f)
74de6960c99d8d Paul E. McKenney 2018-07-24  1000  		return true;
b699cce1604e82 Neeraj Upadhyay  2019-03-11 @1001  	WARN_ON_ONCE(func != (rcu_callback_t)~0L);
74de6960c99d8d Paul E. McKenney 2018-07-24  1002  	return false;
74de6960c99d8d Paul E. McKenney 2018-07-24  1003  }
74de6960c99d8d Paul E. McKenney 2018-07-24  1004  

:::::: The code at line 1001 was first introduced by commit
:::::: b699cce1604e828f19c39845252626eb78cdf38a rcu: Do a single rhp->func read in rcu_head_after_call_rcu()

:::::: TO: Neeraj Upadhyay <neeraju@codeaurora.org>
:::::: CC: Paul E. McKenney <paulmck@linux.ibm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

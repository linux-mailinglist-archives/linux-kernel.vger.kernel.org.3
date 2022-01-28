Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A76B49F1FA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 04:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345854AbiA1Dsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 22:48:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:12427 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231289AbiA1Dsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 22:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643341735; x=1674877735;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QpzsgJvsuH4/EfVKO4TO/f8sJ/uls0iElYf05uyeIBY=;
  b=gksOBiwhC5p7Fh2aUJVE5ahMs1rKJLbMxO/0BjGDoAidYHs0UfuZ8MzP
   mkRFcxUGUHboOCUs4CpdG5c2MxBhrlijyikI2VJw6xpHgi7gH3O6w0ZOu
   XHF1hFLp/QKAO/vdOJGuNqPKlAksamw1DRjA51VBwT4n/RvIfYDGB71gU
   aShybgKezxGUJccoYI0BjDAaz+1dSIg8xyQdlAJ2w/8cKzDVFySX8QG8B
   GCXrCxQFZadnrPB4K4qlGZOsCdz+TkFbxhZ+QpgWPFb3d6Mw8CpIovit9
   WA361rJVPD02jBhuc9mlPE79qt58hAqo+nHPfhGSEuWa9hJgF5uiIA2pm
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="310353206"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="310353206"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 19:48:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="564055309"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Jan 2022 19:48:52 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDIFn-000NOu-Fm; Fri, 28 Jan 2022 03:48:51 +0000
Date:   Fri, 28 Jan 2022 11:48:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [clangbuiltlinux:reachability 2/6] arch/x86/include/asm/bug.h:82:25:
 error: expected ':' or ')' before 'ASM_REACHABLE'
Message-ID: <202201281145.rcxovdeL-lkp@intel.com>
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
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220128/202201281145.rcxovdeL-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ClangBuiltLinux/linux/commit/473c4f04fa49864f6955062435d8bab02ff87862
        git remote add clangbuiltlinux https://github.com/ClangBuiltLinux/linux
        git fetch --no-tags clangbuiltlinux reachability
        git checkout 473c4f04fa49864f6955062435d8bab02ff87862
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/bug.h:5,
                    from include/linux/crypto.h:18,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/thread_info.h: In function 'copy_overflow':
>> arch/x86/include/asm/bug.h:82:25: error: expected ':' or ')' before 'ASM_REACHABLE'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |                         ^~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:35:8: note: in definition of macro '_BUG_FLAGS'
      35 |        extra \
         |        ^~~~~
   include/asm-generic/bug.h:100:3: note: in expansion of macro '__WARN_FLAGS'
     100 |   __WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
         |   ^~~~~~~~~~~~
   include/asm-generic/bug.h:132:3: note: in expansion of macro '__WARN_printf'
     132 |   __WARN_printf(TAINT_WARN, format);   \
         |   ^~~~~~~~~~~~~
   include/linux/thread_info.h:200:2: note: in expansion of macro 'WARN'
     200 |  WARN(1, "Buffer overflow detected (%d < %lu)!\n", size, count);
         |  ^~~~
   arch/x86/include/asm/bug.h:80:14: warning: unused variable 'f' [-Wunused-variable]
      80 |  __auto_type f = BUGFLAG_WARNING|(flags);  \
         |              ^
   include/asm-generic/bug.h:100:3: note: in expansion of macro '__WARN_FLAGS'
     100 |   __WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
         |   ^~~~~~~~~~~~
   include/asm-generic/bug.h:132:3: note: in expansion of macro '__WARN_printf'
     132 |   __WARN_printf(TAINT_WARN, format);   \
         |   ^~~~~~~~~~~~~
   include/linux/thread_info.h:200:2: note: in expansion of macro 'WARN'
     200 |  WARN(1, "Buffer overflow detected (%d < %lu)!\n", size, count);
         |  ^~~~
   include/linux/thread_info.h: In function 'check_copy_size':
>> arch/x86/include/asm/bug.h:82:25: error: expected ':' or ')' before 'ASM_REACHABLE'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |                         ^~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:35:8: note: in definition of macro '_BUG_FLAGS'
      35 |        extra \
         |        ^~~~~
   include/asm-generic/bug.h:106:3: note: in expansion of macro '__WARN_FLAGS'
     106 |   __WARN_FLAGS(BUGFLAG_ONCE |   \
         |   ^~~~~~~~~~~~
   include/linux/thread_info.h:216:6: note: in expansion of macro 'WARN_ON_ONCE'
     216 |  if (WARN_ON_ONCE(bytes > INT_MAX))
         |      ^~~~~~~~~~~~
   arch/x86/include/asm/bug.h:80:14: warning: unused variable 'f' [-Wunused-variable]
      80 |  __auto_type f = BUGFLAG_WARNING|(flags);  \
         |              ^
   include/asm-generic/bug.h:106:3: note: in expansion of macro '__WARN_FLAGS'
     106 |   __WARN_FLAGS(BUGFLAG_ONCE |   \
         |   ^~~~~~~~~~~~
   include/linux/thread_info.h:216:6: note: in expansion of macro 'WARN_ON_ONCE'
     216 |  if (WARN_ON_ONCE(bytes > INT_MAX))
         |      ^~~~~~~~~~~~
   include/linux/ww_mutex.h: In function 'ww_acquire_done':
>> arch/x86/include/asm/bug.h:82:25: error: expected ':' or ')' before 'ASM_REACHABLE'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |                         ^~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:35:8: note: in definition of macro '_BUG_FLAGS'
      35 |        extra \
         |        ^~~~~
   include/asm-generic/bug.h:96:19: note: in expansion of macro '__WARN_FLAGS'
      96 | #define __WARN()  __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
         |                   ^~~~~~~~~~~~
   include/asm-generic/bug.h:123:3: note: in expansion of macro '__WARN'
     123 |   __WARN();      \
         |   ^~~~~~
   include/linux/lockdep.h:310:7: note: in expansion of macro 'WARN_ON'
     310 |  do { WARN_ON(debug_locks && !(cond)); } while (0)
         |       ^~~~~~~
   include/linux/lockdep.h:316:2: note: in expansion of macro 'lockdep_assert'
     316 |  lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |  ^~~~~~~~~~~~~~
   include/linux/ww_mutex.h:171:2: note: in expansion of macro 'lockdep_assert_held'
     171 |  lockdep_assert_held(ctx);
         |  ^~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:80:14: warning: unused variable 'f' [-Wunused-variable]
      80 |  __auto_type f = BUGFLAG_WARNING|(flags);  \
         |              ^
   include/asm-generic/bug.h:96:19: note: in expansion of macro '__WARN_FLAGS'
      96 | #define __WARN()  __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
         |                   ^~~~~~~~~~~~
   include/asm-generic/bug.h:123:3: note: in expansion of macro '__WARN'
     123 |   __WARN();      \
         |   ^~~~~~
   include/linux/lockdep.h:310:7: note: in expansion of macro 'WARN_ON'
     310 |  do { WARN_ON(debug_locks && !(cond)); } while (0)
         |       ^~~~~~~
   include/linux/lockdep.h:316:2: note: in expansion of macro 'lockdep_assert'
     316 |  lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |  ^~~~~~~~~~~~~~
   include/linux/ww_mutex.h:171:2: note: in expansion of macro 'lockdep_assert_held'
     171 |  lockdep_assert_held(ctx);
         |  ^~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/bug.h:82:25: error: expected ':' or ')' before 'ASM_REACHABLE'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |                         ^~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:35:8: note: in definition of macro '_BUG_FLAGS'
      35 |        extra \
         |        ^~~~~
   include/asm-generic/bug.h:100:3: note: in expansion of macro '__WARN_FLAGS'
     100 |   __WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
         |   ^~~~~~~~~~~~
   include/asm-generic/bug.h:132:3: note: in expansion of macro '__WARN_printf'
     132 |   __WARN_printf(TAINT_WARN, format);   \
         |   ^~~~~~~~~~~~~
   include/linux/debug_locks.h:31:4: note: in expansion of macro 'WARN'
      31 |    WARN(1, "DEBUG_LOCKS_WARN_ON(%s)", #c);  \
         |    ^~~~
   include/linux/ww_mutex.h:173:2: note: in expansion of macro 'DEBUG_LOCKS_WARN_ON'
     173 |  DEBUG_LOCKS_WARN_ON(ctx->done_acquire);
         |  ^~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:80:14: warning: unused variable 'f' [-Wunused-variable]
      80 |  __auto_type f = BUGFLAG_WARNING|(flags);  \
         |              ^
   include/asm-generic/bug.h:100:3: note: in expansion of macro '__WARN_FLAGS'
     100 |   __WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
         |   ^~~~~~~~~~~~
   include/asm-generic/bug.h:132:3: note: in expansion of macro '__WARN_printf'
     132 |   __WARN_printf(TAINT_WARN, format);   \
         |   ^~~~~~~~~~~~~
   include/linux/debug_locks.h:31:4: note: in expansion of macro 'WARN'
      31 |    WARN(1, "DEBUG_LOCKS_WARN_ON(%s)", #c);  \
         |    ^~~~
   include/linux/ww_mutex.h:173:2: note: in expansion of macro 'DEBUG_LOCKS_WARN_ON'
     173 |  DEBUG_LOCKS_WARN_ON(ctx->done_acquire);
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/ww_mutex.h: In function 'ww_acquire_fini':
>> arch/x86/include/asm/bug.h:82:25: error: expected ':' or ')' before 'ASM_REACHABLE'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |                         ^~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:35:8: note: in definition of macro '_BUG_FLAGS'
      35 |        extra \
         |        ^~~~~
   include/asm-generic/bug.h:100:3: note: in expansion of macro '__WARN_FLAGS'
     100 |   __WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
         |   ^~~~~~~~~~~~
   include/asm-generic/bug.h:132:3: note: in expansion of macro '__WARN_printf'
     132 |   __WARN_printf(TAINT_WARN, format);   \
         |   ^~~~~~~~~~~~~
   include/linux/debug_locks.h:31:4: note: in expansion of macro 'WARN'
      31 |    WARN(1, "DEBUG_LOCKS_WARN_ON(%s)", #c);  \
         |    ^~~~
   include/linux/ww_mutex.h:191:2: note: in expansion of macro 'DEBUG_LOCKS_WARN_ON'
     191 |  DEBUG_LOCKS_WARN_ON(ctx->acquired);
         |  ^~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:80:14: warning: unused variable 'f' [-Wunused-variable]
      80 |  __auto_type f = BUGFLAG_WARNING|(flags);  \
         |              ^
   include/asm-generic/bug.h:100:3: note: in expansion of macro '__WARN_FLAGS'
     100 |   __WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
         |   ^~~~~~~~~~~~
   include/asm-generic/bug.h:132:3: note: in expansion of macro '__WARN_printf'
     132 |   __WARN_printf(TAINT_WARN, format);   \
         |   ^~~~~~~~~~~~~
   include/linux/debug_locks.h:31:4: note: in expansion of macro 'WARN'
      31 |    WARN(1, "DEBUG_LOCKS_WARN_ON(%s)", #c);  \
         |    ^~~~
   include/linux/ww_mutex.h:191:2: note: in expansion of macro 'DEBUG_LOCKS_WARN_ON'
     191 |  DEBUG_LOCKS_WARN_ON(ctx->acquired);
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/ww_mutex.h: In function 'ww_mutex_lock_slow':
>> arch/x86/include/asm/bug.h:82:25: error: expected ':' or ')' before 'ASM_REACHABLE'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |                         ^~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:35:8: note: in definition of macro '_BUG_FLAGS'
      35 |        extra \
         |        ^~~~~
   include/asm-generic/bug.h:100:3: note: in expansion of macro '__WARN_FLAGS'
     100 |   __WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
         |   ^~~~~~~~~~~~
   include/asm-generic/bug.h:132:3: note: in expansion of macro '__WARN_printf'
     132 |   __WARN_printf(TAINT_WARN, format);   \
         |   ^~~~~~~~~~~~~
   include/linux/debug_locks.h:31:4: note: in expansion of macro 'WARN'
      31 |    WARN(1, "DEBUG_LOCKS_WARN_ON(%s)", #c);  \
         |    ^~~~
   include/linux/ww_mutex.h:297:2: note: in expansion of macro 'DEBUG_LOCKS_WARN_ON'
     297 |  DEBUG_LOCKS_WARN_ON(!ctx->contending_lock);
         |  ^~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:80:14: warning: unused variable 'f' [-Wunused-variable]
      80 |  __auto_type f = BUGFLAG_WARNING|(flags);  \
         |              ^
   include/asm-generic/bug.h:100:3: note: in expansion of macro '__WARN_FLAGS'
     100 |   __WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
         |   ^~~~~~~~~~~~
   include/asm-generic/bug.h:132:3: note: in expansion of macro '__WARN_printf'
     132 |   __WARN_printf(TAINT_WARN, format);   \
         |   ^~~~~~~~~~~~~
   include/linux/debug_locks.h:31:4: note: in expansion of macro 'WARN'
      31 |    WARN(1, "DEBUG_LOCKS_WARN_ON(%s)", #c);  \
         |    ^~~~
   include/linux/ww_mutex.h:297:2: note: in expansion of macro 'DEBUG_LOCKS_WARN_ON'
     297 |  DEBUG_LOCKS_WARN_ON(!ctx->contending_lock);
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/ww_mutex.h: In function 'ww_mutex_lock_slow_interruptible':
>> arch/x86/include/asm/bug.h:82:25: error: expected ':' or ')' before 'ASM_REACHABLE'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |                         ^~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:35:8: note: in definition of macro '_BUG_FLAGS'
      35 |        extra \
         |        ^~~~~
   include/asm-generic/bug.h:100:3: note: in expansion of macro '__WARN_FLAGS'
     100 |   __WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
         |   ^~~~~~~~~~~~
   include/asm-generic/bug.h:132:3: note: in expansion of macro '__WARN_printf'
     132 |   __WARN_printf(TAINT_WARN, format);   \
         |   ^~~~~~~~~~~~~
   include/linux/debug_locks.h:31:4: note: in expansion of macro 'WARN'
      31 |    WARN(1, "DEBUG_LOCKS_WARN_ON(%s)", #c);  \
         |    ^~~~
   include/linux/ww_mutex.h:333:2: note: in expansion of macro 'DEBUG_LOCKS_WARN_ON'
     333 |  DEBUG_LOCKS_WARN_ON(!ctx->contending_lock);
         |  ^~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:80:14: warning: unused variable 'f' [-Wunused-variable]
      80 |  __auto_type f = BUGFLAG_WARNING|(flags);  \
         |              ^
   include/asm-generic/bug.h:100:3: note: in expansion of macro '__WARN_FLAGS'
     100 |   __WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
         |   ^~~~~~~~~~~~
   include/asm-generic/bug.h:132:3: note: in expansion of macro '__WARN_printf'
     132 |   __WARN_printf(TAINT_WARN, format);   \
         |   ^~~~~~~~~~~~~
   include/linux/debug_locks.h:31:4: note: in expansion of macro 'WARN'
      31 |    WARN(1, "DEBUG_LOCKS_WARN_ON(%s)", #c);  \
         |    ^~~~
   include/linux/ww_mutex.h:333:2: note: in expansion of macro 'DEBUG_LOCKS_WARN_ON'
     333 |  DEBUG_LOCKS_WARN_ON(!ctx->contending_lock);
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h: In function '__seqprop_assert':
>> arch/x86/include/asm/bug.h:82:25: error: expected ':' or ')' before 'ASM_REACHABLE'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |                         ^~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:35:8: note: in definition of macro '_BUG_FLAGS'
      35 |        extra \
         |        ^~~~~
   include/asm-generic/bug.h:106:3: note: in expansion of macro '__WARN_FLAGS'
     106 |   __WARN_FLAGS(BUGFLAG_ONCE |   \
         |   ^~~~~~~~~~~~
   include/linux/lockdep.h:607:2: note: in expansion of macro 'WARN_ON_ONCE'
     607 |  WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT) &&  \
         |  ^~~~~~~~~~~~
   include/linux/seqlock.h:271:2: note: in expansion of macro 'lockdep_assert_preemption_disabled'
     271 |  lockdep_assert_preemption_disabled();
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:80:14: warning: unused variable 'f' [-Wunused-variable]
      80 |  __auto_type f = BUGFLAG_WARNING|(flags);  \
         |              ^
   include/asm-generic/bug.h:106:3: note: in expansion of macro '__WARN_FLAGS'
     106 |   __WARN_FLAGS(BUGFLAG_ONCE |   \
         |   ^~~~~~~~~~~~
   include/linux/lockdep.h:607:2: note: in expansion of macro 'WARN_ON_ONCE'
     607 |  WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT) &&  \
         |  ^~~~~~~~~~~~
   include/linux/seqlock.h:271:2: note: in expansion of macro 'lockdep_assert_preemption_disabled'
     271 |  lockdep_assert_preemption_disabled();
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/mmzone.h:16,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/seqlock.h: In function '__seqprop_raw_spinlock_assert':
>> arch/x86/include/asm/bug.h:82:25: error: expected ':' or ')' before 'ASM_REACHABLE'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |                         ^~~~~~~~~~~~~
   include/linux/seqlock.h:152:26: note: in definition of macro '__SEQ_LOCK'
     152 | #define __SEQ_LOCK(expr) expr
         |                          ^~~~
   arch/x86/include/asm/bug.h:82:2: note: in expansion of macro '_BUG_FLAGS'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |  ^~~~~~~~~~
   include/asm-generic/bug.h:96:19: note: in expansion of macro '__WARN_FLAGS'
      96 | #define __WARN()  __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
         |                   ^~~~~~~~~~~~
   include/asm-generic/bug.h:123:3: note: in expansion of macro '__WARN'
     123 |   __WARN();      \
         |   ^~~~~~
   include/linux/lockdep.h:310:7: note: in expansion of macro 'WARN_ON'
     310 |  do { WARN_ON(debug_locks && !(cond)); } while (0)
         |       ^~~~~~~
   include/linux/lockdep.h:316:2: note: in expansion of macro 'lockdep_assert'
     316 |  lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |  ^~~~~~~~~~~~~~
   include/linux/seqlock.h:247:13: note: in expansion of macro 'lockdep_assert_held'
     247 |  __SEQ_LOCK(lockdep_assert_held(lockmember));   \
         |             ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:276:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     276 | SEQCOUNT_LOCKNAME(raw_spinlock, raw_spinlock_t,  false,    s->lock,        raw_spin, raw_spin_lock(s->lock))
         | ^~~~~~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:80:14: warning: unused variable 'f' [-Wunused-variable]
      80 |  __auto_type f = BUGFLAG_WARNING|(flags);  \
         |              ^
   include/linux/seqlock.h:152:26: note: in definition of macro '__SEQ_LOCK'
     152 | #define __SEQ_LOCK(expr) expr
         |                          ^~~~
   include/asm-generic/bug.h:96:19: note: in expansion of macro '__WARN_FLAGS'
      96 | #define __WARN()  __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
         |                   ^~~~~~~~~~~~
   include/asm-generic/bug.h:123:3: note: in expansion of macro '__WARN'
     123 |   __WARN();      \
         |   ^~~~~~
   include/linux/lockdep.h:310:7: note: in expansion of macro 'WARN_ON'
     310 |  do { WARN_ON(debug_locks && !(cond)); } while (0)
         |       ^~~~~~~
   include/linux/lockdep.h:316:2: note: in expansion of macro 'lockdep_assert'
     316 |  lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |  ^~~~~~~~~~~~~~
   include/linux/seqlock.h:247:13: note: in expansion of macro 'lockdep_assert_held'
     247 |  __SEQ_LOCK(lockdep_assert_held(lockmember));   \
         |             ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:276:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     276 | SEQCOUNT_LOCKNAME(raw_spinlock, raw_spinlock_t,  false,    s->lock,        raw_spin, raw_spin_lock(s->lock))
         | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h: In function '__seqprop_spinlock_assert':
>> arch/x86/include/asm/bug.h:82:25: error: expected ':' or ')' before 'ASM_REACHABLE'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |                         ^~~~~~~~~~~~~
   include/linux/seqlock.h:152:26: note: in definition of macro '__SEQ_LOCK'
     152 | #define __SEQ_LOCK(expr) expr
         |                          ^~~~
   arch/x86/include/asm/bug.h:82:2: note: in expansion of macro '_BUG_FLAGS'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |  ^~~~~~~~~~
   include/asm-generic/bug.h:96:19: note: in expansion of macro '__WARN_FLAGS'
      96 | #define __WARN()  __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
         |                   ^~~~~~~~~~~~
   include/asm-generic/bug.h:123:3: note: in expansion of macro '__WARN'
     123 |   __WARN();      \
         |   ^~~~~~
   include/linux/lockdep.h:310:7: note: in expansion of macro 'WARN_ON'
     310 |  do { WARN_ON(debug_locks && !(cond)); } while (0)
         |       ^~~~~~~
   include/linux/lockdep.h:316:2: note: in expansion of macro 'lockdep_assert'
     316 |  lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |  ^~~~~~~~~~~~~~
   include/linux/seqlock.h:247:13: note: in expansion of macro 'lockdep_assert_held'
     247 |  __SEQ_LOCK(lockdep_assert_held(lockmember));   \
         |             ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:277:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     277 | SEQCOUNT_LOCKNAME(spinlock,     spinlock_t,      __SEQ_RT, s->lock,        spin,     spin_lock(s->lock))
         | ^~~~~~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:80:14: warning: unused variable 'f' [-Wunused-variable]
      80 |  __auto_type f = BUGFLAG_WARNING|(flags);  \
         |              ^
   include/linux/seqlock.h:152:26: note: in definition of macro '__SEQ_LOCK'
     152 | #define __SEQ_LOCK(expr) expr
         |                          ^~~~
   include/asm-generic/bug.h:96:19: note: in expansion of macro '__WARN_FLAGS'
      96 | #define __WARN()  __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
         |                   ^~~~~~~~~~~~
   include/asm-generic/bug.h:123:3: note: in expansion of macro '__WARN'
     123 |   __WARN();      \
         |   ^~~~~~
   include/linux/lockdep.h:310:7: note: in expansion of macro 'WARN_ON'
     310 |  do { WARN_ON(debug_locks && !(cond)); } while (0)
         |       ^~~~~~~
   include/linux/lockdep.h:316:2: note: in expansion of macro 'lockdep_assert'
     316 |  lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |  ^~~~~~~~~~~~~~
   include/linux/seqlock.h:247:13: note: in expansion of macro 'lockdep_assert_held'
     247 |  __SEQ_LOCK(lockdep_assert_held(lockmember));   \
         |             ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:277:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     277 | SEQCOUNT_LOCKNAME(spinlock,     spinlock_t,      __SEQ_RT, s->lock,        spin,     spin_lock(s->lock))
         | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h: In function '__seqprop_rwlock_assert':
>> arch/x86/include/asm/bug.h:82:25: error: expected ':' or ')' before 'ASM_REACHABLE'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |                         ^~~~~~~~~~~~~
   include/linux/seqlock.h:152:26: note: in definition of macro '__SEQ_LOCK'
     152 | #define __SEQ_LOCK(expr) expr
         |                          ^~~~
   arch/x86/include/asm/bug.h:82:2: note: in expansion of macro '_BUG_FLAGS'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |  ^~~~~~~~~~
   include/asm-generic/bug.h:96:19: note: in expansion of macro '__WARN_FLAGS'
      96 | #define __WARN()  __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
         |                   ^~~~~~~~~~~~
   include/asm-generic/bug.h:123:3: note: in expansion of macro '__WARN'
     123 |   __WARN();      \
         |   ^~~~~~
   include/linux/lockdep.h:310:7: note: in expansion of macro 'WARN_ON'
     310 |  do { WARN_ON(debug_locks && !(cond)); } while (0)
         |       ^~~~~~~
   include/linux/lockdep.h:316:2: note: in expansion of macro 'lockdep_assert'
     316 |  lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |  ^~~~~~~~~~~~~~
   include/linux/seqlock.h:247:13: note: in expansion of macro 'lockdep_assert_held'
     247 |  __SEQ_LOCK(lockdep_assert_held(lockmember));   \
         |             ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:278:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     278 | SEQCOUNT_LOCKNAME(rwlock,       rwlock_t,        __SEQ_RT, s->lock,        read,     read_lock(s->lock))
         | ^~~~~~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:80:14: warning: unused variable 'f' [-Wunused-variable]
      80 |  __auto_type f = BUGFLAG_WARNING|(flags);  \
         |              ^
   include/linux/seqlock.h:152:26: note: in definition of macro '__SEQ_LOCK'
     152 | #define __SEQ_LOCK(expr) expr
         |                          ^~~~
   include/asm-generic/bug.h:96:19: note: in expansion of macro '__WARN_FLAGS'
      96 | #define __WARN()  __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
         |                   ^~~~~~~~~~~~
   include/asm-generic/bug.h:123:3: note: in expansion of macro '__WARN'
     123 |   __WARN();      \
         |   ^~~~~~
   include/linux/lockdep.h:310:7: note: in expansion of macro 'WARN_ON'
     310 |  do { WARN_ON(debug_locks && !(cond)); } while (0)
         |       ^~~~~~~
   include/linux/lockdep.h:316:2: note: in expansion of macro 'lockdep_assert'
     316 |  lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |  ^~~~~~~~~~~~~~
   include/linux/seqlock.h:247:13: note: in expansion of macro 'lockdep_assert_held'
     247 |  __SEQ_LOCK(lockdep_assert_held(lockmember));   \
         |             ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:278:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     278 | SEQCOUNT_LOCKNAME(rwlock,       rwlock_t,        __SEQ_RT, s->lock,        read,     read_lock(s->lock))
         | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h: In function '__seqprop_mutex_assert':
>> arch/x86/include/asm/bug.h:82:25: error: expected ':' or ')' before 'ASM_REACHABLE'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |                         ^~~~~~~~~~~~~
   include/linux/seqlock.h:152:26: note: in definition of macro '__SEQ_LOCK'
     152 | #define __SEQ_LOCK(expr) expr
         |                          ^~~~
   arch/x86/include/asm/bug.h:82:2: note: in expansion of macro '_BUG_FLAGS'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |  ^~~~~~~~~~
   include/asm-generic/bug.h:96:19: note: in expansion of macro '__WARN_FLAGS'
      96 | #define __WARN()  __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
         |                   ^~~~~~~~~~~~
   include/asm-generic/bug.h:123:3: note: in expansion of macro '__WARN'
     123 |   __WARN();      \
         |   ^~~~~~
   include/linux/lockdep.h:310:7: note: in expansion of macro 'WARN_ON'
     310 |  do { WARN_ON(debug_locks && !(cond)); } while (0)
         |       ^~~~~~~
   include/linux/lockdep.h:316:2: note: in expansion of macro 'lockdep_assert'
     316 |  lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |  ^~~~~~~~~~~~~~
   include/linux/seqlock.h:247:13: note: in expansion of macro 'lockdep_assert_held'
     247 |  __SEQ_LOCK(lockdep_assert_held(lockmember));   \
         |             ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:279:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     279 | SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
         | ^~~~~~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:80:14: warning: unused variable 'f' [-Wunused-variable]
      80 |  __auto_type f = BUGFLAG_WARNING|(flags);  \
         |              ^
   include/linux/seqlock.h:152:26: note: in definition of macro '__SEQ_LOCK'
     152 | #define __SEQ_LOCK(expr) expr
         |                          ^~~~
   include/asm-generic/bug.h:96:19: note: in expansion of macro '__WARN_FLAGS'
      96 | #define __WARN()  __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
         |                   ^~~~~~~~~~~~
   include/asm-generic/bug.h:123:3: note: in expansion of macro '__WARN'
     123 |   __WARN();      \
         |   ^~~~~~
   include/linux/lockdep.h:310:7: note: in expansion of macro 'WARN_ON'
     310 |  do { WARN_ON(debug_locks && !(cond)); } while (0)
         |       ^~~~~~~
   include/linux/lockdep.h:316:2: note: in expansion of macro 'lockdep_assert'
     316 |  lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |  ^~~~~~~~~~~~~~
   include/linux/seqlock.h:247:13: note: in expansion of macro 'lockdep_assert_held'
     247 |  __SEQ_LOCK(lockdep_assert_held(lockmember));   \
         |             ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:279:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     279 | SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
         | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h: In function '__seqprop_ww_mutex_assert':
>> arch/x86/include/asm/bug.h:82:25: error: expected ':' or ')' before 'ASM_REACHABLE'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |                         ^~~~~~~~~~~~~
   include/linux/seqlock.h:152:26: note: in definition of macro '__SEQ_LOCK'
     152 | #define __SEQ_LOCK(expr) expr
         |                          ^~~~
   arch/x86/include/asm/bug.h:82:2: note: in expansion of macro '_BUG_FLAGS'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |  ^~~~~~~~~~
   include/asm-generic/bug.h:96:19: note: in expansion of macro '__WARN_FLAGS'
      96 | #define __WARN()  __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
         |                   ^~~~~~~~~~~~
   include/asm-generic/bug.h:123:3: note: in expansion of macro '__WARN'
     123 |   __WARN();      \
         |   ^~~~~~
   include/linux/lockdep.h:310:7: note: in expansion of macro 'WARN_ON'
     310 |  do { WARN_ON(debug_locks && !(cond)); } while (0)
         |       ^~~~~~~
   include/linux/lockdep.h:316:2: note: in expansion of macro 'lockdep_assert'
     316 |  lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |  ^~~~~~~~~~~~~~
   include/linux/seqlock.h:247:13: note: in expansion of macro 'lockdep_assert_held'
     247 |  __SEQ_LOCK(lockdep_assert_held(lockmember));   \
         |             ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:280:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     280 | SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
         | ^~~~~~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:80:14: warning: unused variable 'f' [-Wunused-variable]
      80 |  __auto_type f = BUGFLAG_WARNING|(flags);  \
         |              ^
   include/linux/seqlock.h:152:26: note: in definition of macro '__SEQ_LOCK'
     152 | #define __SEQ_LOCK(expr) expr
         |                          ^~~~
   include/asm-generic/bug.h:96:19: note: in expansion of macro '__WARN_FLAGS'
      96 | #define __WARN()  __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
         |                   ^~~~~~~~~~~~
   include/asm-generic/bug.h:123:3: note: in expansion of macro '__WARN'
     123 |   __WARN();      \
         |   ^~~~~~
   include/linux/lockdep.h:310:7: note: in expansion of macro 'WARN_ON'
     310 |  do { WARN_ON(debug_locks && !(cond)); } while (0)
         |       ^~~~~~~
   include/linux/lockdep.h:316:2: note: in expansion of macro 'lockdep_assert'
     316 |  lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |  ^~~~~~~~~~~~~~
   include/linux/seqlock.h:247:13: note: in expansion of macro 'lockdep_assert_held'
     247 |  __SEQ_LOCK(lockdep_assert_held(lockmember));   \
         |             ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:280:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     280 | SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
         | ^~~~~~~~~~~~~~~~~
   In file included from include/linux/bug.h:5,
                    from include/linux/crypto.h:18,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/rcupdate.h: In function 'rcu_head_after_call_rcu':
>> arch/x86/include/asm/bug.h:82:25: error: expected ':' or ')' before 'ASM_REACHABLE'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |                         ^~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:35:8: note: in definition of macro '_BUG_FLAGS'
      35 |        extra \
         |        ^~~~~
   include/asm-generic/bug.h:106:3: note: in expansion of macro '__WARN_FLAGS'
     106 |   __WARN_FLAGS(BUGFLAG_ONCE |   \
         |   ^~~~~~~~~~~~
   include/linux/rcupdate.h:1001:2: note: in expansion of macro 'WARN_ON_ONCE'
    1001 |  WARN_ON_ONCE(func != (rcu_callback_t)~0L);
         |  ^~~~~~~~~~~~
   arch/x86/include/asm/bug.h:80:14: warning: unused variable 'f' [-Wunused-variable]
      80 |  __auto_type f = BUGFLAG_WARNING|(flags);  \
         |              ^
   include/asm-generic/bug.h:106:3: note: in expansion of macro '__WARN_FLAGS'
     106 |   __WARN_FLAGS(BUGFLAG_ONCE |   \
         |   ^~~~~~~~~~~~
   include/linux/rcupdate.h:1001:2: note: in expansion of macro 'WARN_ON_ONCE'
    1001 |  WARN_ON_ONCE(func != (rcu_callback_t)~0L);
         |  ^~~~~~~~~~~~
   include/linux/local_lock_internal.h: In function 'local_lock_acquire':
>> arch/x86/include/asm/bug.h:82:25: error: expected ':' or ')' before 'ASM_REACHABLE'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |                         ^~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:35:8: note: in definition of macro '_BUG_FLAGS'
      35 |        extra \
         |        ^~~~~
   include/asm-generic/bug.h:100:3: note: in expansion of macro '__WARN_FLAGS'
     100 |   __WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
         |   ^~~~~~~~~~~~
   include/asm-generic/bug.h:132:3: note: in expansion of macro '__WARN_printf'
     132 |   __WARN_printf(TAINT_WARN, format);   \
         |   ^~~~~~~~~~~~~
   include/linux/debug_locks.h:31:4: note: in expansion of macro 'WARN'
      31 |    WARN(1, "DEBUG_LOCKS_WARN_ON(%s)", #c);  \
         |    ^~~~
   include/linux/local_lock_internal.h:30:2: note: in expansion of macro 'DEBUG_LOCKS_WARN_ON'
      30 |  DEBUG_LOCKS_WARN_ON(l->owner);
         |  ^~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:80:14: warning: unused variable 'f' [-Wunused-variable]
      80 |  __auto_type f = BUGFLAG_WARNING|(flags);  \
         |              ^
   include/asm-generic/bug.h:100:3: note: in expansion of macro '__WARN_FLAGS'
     100 |   __WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
         |   ^~~~~~~~~~~~
   include/asm-generic/bug.h:132:3: note: in expansion of macro '__WARN_printf'
     132 |   __WARN_printf(TAINT_WARN, format);   \
         |   ^~~~~~~~~~~~~
   include/linux/debug_locks.h:31:4: note: in expansion of macro 'WARN'
      31 |    WARN(1, "DEBUG_LOCKS_WARN_ON(%s)", #c);  \
         |    ^~~~
   include/linux/local_lock_internal.h:30:2: note: in expansion of macro 'DEBUG_LOCKS_WARN_ON'
      30 |  DEBUG_LOCKS_WARN_ON(l->owner);
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/local_lock_internal.h: In function 'local_lock_release':
>> arch/x86/include/asm/bug.h:82:25: error: expected ':' or ')' before 'ASM_REACHABLE'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |                         ^~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:35:8: note: in definition of macro '_BUG_FLAGS'
      35 |        extra \
         |        ^~~~~
   include/asm-generic/bug.h:100:3: note: in expansion of macro '__WARN_FLAGS'
     100 |   __WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
         |   ^~~~~~~~~~~~
   include/asm-generic/bug.h:132:3: note: in expansion of macro '__WARN_printf'
     132 |   __WARN_printf(TAINT_WARN, format);   \
         |   ^~~~~~~~~~~~~
   include/linux/debug_locks.h:31:4: note: in expansion of macro 'WARN'
      31 |    WARN(1, "DEBUG_LOCKS_WARN_ON(%s)", #c);  \
         |    ^~~~
   include/linux/local_lock_internal.h:36:2: note: in expansion of macro 'DEBUG_LOCKS_WARN_ON'
      36 |  DEBUG_LOCKS_WARN_ON(l->owner != current);
         |  ^~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:80:14: warning: unused variable 'f' [-Wunused-variable]
      80 |  __auto_type f = BUGFLAG_WARNING|(flags);  \
         |              ^
   include/asm-generic/bug.h:100:3: note: in expansion of macro '__WARN_FLAGS'
     100 |   __WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
         |   ^~~~~~~~~~~~
   include/asm-generic/bug.h:132:3: note: in expansion of macro '__WARN_printf'
     132 |   __WARN_printf(TAINT_WARN, format);   \
         |   ^~~~~~~~~~~~~
   include/linux/debug_locks.h:31:4: note: in expansion of macro 'WARN'
      31 |    WARN(1, "DEBUG_LOCKS_WARN_ON(%s)", #c);  \
         |    ^~~~
   include/linux/local_lock_internal.h:36:2: note: in expansion of macro 'DEBUG_LOCKS_WARN_ON'
      36 |  DEBUG_LOCKS_WARN_ON(l->owner != current);
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/srcu.h: In function 'srcu_read_unlock':
>> arch/x86/include/asm/bug.h:82:25: error: expected ':' or ')' before 'ASM_REACHABLE'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |                         ^~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:35:8: note: in definition of macro '_BUG_FLAGS'
      35 |        extra \
         |        ^~~~~
   include/asm-generic/bug.h:106:3: note: in expansion of macro '__WARN_FLAGS'
     106 |   __WARN_FLAGS(BUGFLAG_ONCE |   \
         |   ^~~~~~~~~~~~
   include/linux/srcu.h:188:2: note: in expansion of macro 'WARN_ON_ONCE'
     188 |  WARN_ON_ONCE(idx & ~0x1);
         |  ^~~~~~~~~~~~
   arch/x86/include/asm/bug.h:80:14: warning: unused variable 'f' [-Wunused-variable]
      80 |  __auto_type f = BUGFLAG_WARNING|(flags);  \
         |              ^
   include/asm-generic/bug.h:106:3: note: in expansion of macro '__WARN_FLAGS'
     106 |   __WARN_FLAGS(BUGFLAG_ONCE |   \
         |   ^~~~~~~~~~~~
   include/linux/srcu.h:188:2: note: in expansion of macro 'WARN_ON_ONCE'
     188 |  WARN_ON_ONCE(idx & ~0x1);
         |  ^~~~~~~~~~~~
   include/linux/percpu-refcount.h: In function 'percpu_ref_tryget_live_rcu':
>> arch/x86/include/asm/bug.h:82:25: error: expected ':' or ')' before 'ASM_REACHABLE'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |                         ^~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:35:8: note: in definition of macro '_BUG_FLAGS'
      35 |        extra \
         |        ^~~~~
   include/asm-generic/bug.h:106:3: note: in expansion of macro '__WARN_FLAGS'
     106 |   __WARN_FLAGS(BUGFLAG_ONCE |   \
         |   ^~~~~~~~~~~~
   include/linux/percpu-refcount.h:280:2: note: in expansion of macro 'WARN_ON_ONCE'
     280 |  WARN_ON_ONCE(!rcu_read_lock_held());
         |  ^~~~~~~~~~~~
   arch/x86/include/asm/bug.h:80:14: warning: unused variable 'f' [-Wunused-variable]
      80 |  __auto_type f = BUGFLAG_WARNING|(flags);  \
         |              ^
   include/asm-generic/bug.h:106:3: note: in expansion of macro '__WARN_FLAGS'
     106 |   __WARN_FLAGS(BUGFLAG_ONCE |   \
         |   ^~~~~~~~~~~~
   include/linux/percpu-refcount.h:280:2: note: in expansion of macro 'WARN_ON_ONCE'
     280 |  WARN_ON_ONCE(!rcu_read_lock_held());
         |  ^~~~~~~~~~~~
   In file included from include/linux/bug.h:5,
                    from include/linux/crypto.h:18,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/xarray.h: In function 'xa_mk_value':
>> arch/x86/include/asm/bug.h:82:25: error: expected ':' or ')' before 'ASM_REACHABLE'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |                         ^~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:35:8: note: in definition of macro '_BUG_FLAGS'
      35 |        extra \
         |        ^~~~~
   include/asm-generic/bug.h:96:19: note: in expansion of macro '__WARN_FLAGS'
      96 | #define __WARN()  __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
         |                   ^~~~~~~~~~~~
   include/asm-generic/bug.h:123:3: note: in expansion of macro '__WARN'
     123 |   __WARN();      \
         |   ^~~~~~
   include/linux/xarray.h:54:2: note: in expansion of macro 'WARN_ON'
      54 |  WARN_ON((long)v < 0);
         |  ^~~~~~~
   arch/x86/include/asm/bug.h:80:14: warning: unused variable 'f' [-Wunused-variable]
      80 |  __auto_type f = BUGFLAG_WARNING|(flags);  \
         |              ^
   include/asm-generic/bug.h:96:19: note: in expansion of macro '__WARN_FLAGS'
      96 | #define __WARN()  __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
         |                   ^~~~~~~~~~~~
   include/asm-generic/bug.h:123:3: note: in expansion of macro '__WARN'
     123 |   __WARN();      \
         |   ^~~~~~
   include/linux/xarray.h:54:2: note: in expansion of macro 'WARN_ON'
      54 |  WARN_ON((long)v < 0);
         |  ^~~~~~~
   In file included from arch/x86/include/asm/atomic.h:5,
                    from include/linux/atomic.h:7,
                    from include/linux/crypto.h:15,
                    from arch/x86/kernel/asm-offsets.c:9:
   arch/x86/include/asm/uaccess.h: In function 'user_access_begin':
>> arch/x86/include/asm/bug.h:82:25: error: expected ':' or ')' before 'ASM_REACHABLE'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |                         ^~~~~~~~~~~~~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   arch/x86/include/asm/bug.h:82:2: note: in expansion of macro '_BUG_FLAGS'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |  ^~~~~~~~~~
   include/asm-generic/bug.h:106:3: note: in expansion of macro '__WARN_FLAGS'
     106 |   __WARN_FLAGS(BUGFLAG_ONCE |   \
         |   ^~~~~~~~~~~~
   arch/x86/include/asm/uaccess.h:47:2: note: in expansion of macro 'WARN_ON_ONCE'
      47 |  WARN_ON_ONCE(!in_task() && !pagefault_disabled())
         |  ^~~~~~~~~~~~
   arch/x86/include/asm/uaccess.h:71:2: note: in expansion of macro 'WARN_ON_IN_IRQ'
      71 |  WARN_ON_IN_IRQ();      \
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/uaccess.h:476:16: note: in expansion of macro 'access_ok'
     476 |  if (unlikely(!access_ok(ptr,len)))
         |                ^~~~~~~~~
   arch/x86/include/asm/bug.h:80:14: warning: unused variable 'f' [-Wunused-variable]
      80 |  __auto_type f = BUGFLAG_WARNING|(flags);  \
         |              ^
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/asm-generic/bug.h:106:3: note: in expansion of macro '__WARN_FLAGS'
     106 |   __WARN_FLAGS(BUGFLAG_ONCE |   \
         |   ^~~~~~~~~~~~
   arch/x86/include/asm/uaccess.h:47:2: note: in expansion of macro 'WARN_ON_ONCE'
      47 |  WARN_ON_ONCE(!in_task() && !pagefault_disabled())
         |  ^~~~~~~~~~~~
   arch/x86/include/asm/uaccess.h:71:2: note: in expansion of macro 'WARN_ON_IN_IRQ'
      71 |  WARN_ON_IN_IRQ();      \
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/uaccess.h:476:16: note: in expansion of macro 'access_ok'
     476 |  if (unlikely(!access_ok(ptr,len)))
         |                ^~~~~~~~~
   In file included from include/linux/bug.h:5,
                    from include/linux/crypto.h:18,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/sched/signal.h: In function 'signal_set_stop_flags':
   arch/x86/include/asm/bug.h:82:25: error: expected ':' or ')' before 'ASM_REACHABLE'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |                         ^~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:35:8: note: in definition of macro '_BUG_FLAGS'
      35 |        extra \
         |        ^~~~~
   include/asm-generic/bug.h:96:19: note: in expansion of macro '__WARN_FLAGS'
      96 | #define __WARN()  __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
         |                   ^~~~~~~~~~~~
   include/asm-generic/bug.h:123:3: note: in expansion of macro '__WARN'
     123 |   __WARN();      \
         |   ^~~~~~
   include/linux/sched/signal.h:275:2: note: in expansion of macro 'WARN_ON'
     275 |  WARN_ON(sig->flags & (SIGNAL_GROUP_EXIT|SIGNAL_GROUP_COREDUMP));
         |  ^~~~~~~
   arch/x86/include/asm/bug.h:80:14: warning: unused variable 'f' [-Wunused-variable]
      80 |  __auto_type f = BUGFLAG_WARNING|(flags);  \
         |              ^
   include/asm-generic/bug.h:96:19: note: in expansion of macro '__WARN_FLAGS'
      96 | #define __WARN()  __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
         |                   ^~~~~~~~~~~~
   include/asm-generic/bug.h:123:3: note: in expansion of macro '__WARN'
     123 |   __WARN();      \
         |   ^~~~~~
   include/linux/sched/signal.h:275:2: note: in expansion of macro 'WARN_ON'
     275 |  WARN_ON(sig->flags & (SIGNAL_GROUP_EXIT|SIGNAL_GROUP_COREDUMP));
         |  ^~~~~~~
   include/linux/sched/signal.h: In function 'kernel_signal_stop':
   arch/x86/include/asm/bug.h:82:25: error: expected ':' or ')' before 'ASM_REACHABLE'
      82 |  _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);   \
         |                         ^~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:35:8: note: in definition of macro '_BUG_FLAGS'
      35 |        extra \
         |        ^~~~~
   include/asm-generic/bug.h:106:3: note: in expansion of macro '__WARN_FLAGS'
     106 |   __WARN_FLAGS(BUGFLAG_ONCE |   \
         |   ^~~~~~~~~~~~
   include/linux/sched.h:143:3: note: in expansion of macro 'WARN_ON_ONCE'
     143 |   WARN_ON_ONCE(!is_special_task_state(state_value)); \
         |   ^~~~~~~~~~~~
   include/linux/sched.h:225:3: note: in expansion of macro 'debug_special_state_change'
     225 |   debug_special_state_change((state_value));  \
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched/signal.h:309:3: note: in expansion of macro 'set_special_state'
     309 |   set_special_state(TASK_STOPPED);
         |   ^~~~~~~~~~~~~~~~~
   arch/x86/include/asm/bug.h:80:14: warning: unused variable 'f' [-Wunused-variable]
      80 |  __auto_type f = BUGFLAG_WARNING|(flags);  \
         |              ^
   include/asm-generic/bug.h:106:3: note: in expansion of macro '__WARN_FLAGS'
     106 |   __WARN_FLAGS(BUGFLAG_ONCE |   \
         |   ^~~~~~~~~~~~
   include/linux/sched.h:143:3: note: in expansion of macro 'WARN_ON_ONCE'
     143 |   WARN_ON_ONCE(!is_special_task_state(state_value)); \
         |   ^~~~~~~~~~~~
   include/linux/sched.h:225:3: note: in expansion of macro 'debug_special_state_change'
     225 |   debug_special_state_change((state_value));  \
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +82 arch/x86/include/asm/bug.h

    71	
    72	/*
    73	 * This instrumentation_begin() is strictly speaking incorrect; but it
    74	 * suppresses the complaints from WARN()s in noinstr code. If such a WARN()
    75	 * were to trigger, we'd rather wreck the machine in an attempt to get the
    76	 * message out than not know about it.
    77	 */
    78	#define __WARN_FLAGS(flags)					\
    79	do {								\
    80		__auto_type f = BUGFLAG_WARNING|(flags);		\
    81		instrumentation_begin();				\
  > 82		_BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);			\
    83		instrumentation_end();					\
    84	} while (0)
    85	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

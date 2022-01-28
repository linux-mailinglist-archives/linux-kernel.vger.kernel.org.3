Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E4C49F1FB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 04:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345863AbiA1DtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 22:49:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:42647 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231289AbiA1DtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 22:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643341749; x=1674877749;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JcbnVJiPxgxumRCpUucisGEAl7RYYAzm4NDjItXEN7g=;
  b=EfSfMgCp5qqCLf7m/xFBKFyGDk8FaKb+txWhdDY1RTM5AJ09jfeAsbth
   Ip6ZH2BQOPJy1wfDrJvNY7VS3bSUjAKGcXJ8NF3WfgXCx9Gd+DBBfoX8A
   DqUCeHg+ho3BVyJ+yaLQ7xMlLdGg1zXn+gK2VHofGkQuQgw4f6t807x5/
   R/2GyboM2NJ/v9f8blT18PsRWz07+NiaBkYmBipxrx1wDLWE5uawAouNb
   pbTjK0sY6Ez8bvaQxXp15TSUgEt0rTbx/HXQsIf/gEdSycrt1viLqaScr
   Z5Kpfs7X6ENXG/+8jRTetCU210wy2F7tezZ5hY2HqIutDnnvPei3lGPuH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227709823"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="227709823"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 19:48:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="625492889"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jan 2022 19:48:52 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDIFn-000NP8-It; Fri, 28 Jan 2022 03:48:51 +0000
Date:   Fri, 28 Jan 2022 11:48:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [clangbuiltlinux:reachability 2/6] include/linux/jump_label.h:290:2:
 error: expected ')'
Message-ID: <202201281152.oKuDwq7A-lkp@intel.com>
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
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220128/202201281152.oKuDwq7A-lkp@intel.com/config)
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

   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:20:
   In file included from include/linux/slab.h:15:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from arch/x86/include/asm/preempt.h:7:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/x86/include/asm/thread_info.h:53:
   In file included from arch/x86/include/asm/cpufeature.h:5:
   In file included from arch/x86/include/asm/processor.h:13:
   In file included from arch/x86/include/asm/math_emu.h:5:
   In file included from arch/x86/include/asm/ptrace.h:97:
   In file included from arch/x86/include/asm/paravirt_types.h:40:
   In file included from arch/x86/include/asm/nospec-branch.h:6:
   In file included from include/linux/static_key.h:1:
>> include/linux/jump_label.h:290:2: error: expected ')'
           STATIC_KEY_CHECK_USE(key);
           ^
   include/linux/jump_label.h:81:35: note: expanded from macro 'STATIC_KEY_CHECK_USE'
   #define STATIC_KEY_CHECK_USE(key) WARN(!static_key_initialized,               \
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
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from arch/x86/include/asm/preempt.h:7:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/x86/include/asm/thread_info.h:53:
   In file included from arch/x86/include/asm/cpufeature.h:5:
   In file included from arch/x86/include/asm/processor.h:13:
   In file included from arch/x86/include/asm/math_emu.h:5:
   In file included from arch/x86/include/asm/ptrace.h:97:
   In file included from arch/x86/include/asm/paravirt_types.h:40:
   In file included from arch/x86/include/asm/nospec-branch.h:6:
   In file included from include/linux/static_key.h:1:
   include/linux/jump_label.h:296:2: error: expected ')'
           STATIC_KEY_CHECK_USE(key);
           ^
   include/linux/jump_label.h:81:35: note: expanded from macro 'STATIC_KEY_CHECK_USE'
   #define STATIC_KEY_CHECK_USE(key) WARN(!static_key_initialized,               \
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
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from arch/x86/include/asm/preempt.h:7:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/x86/include/asm/thread_info.h:53:
   In file included from arch/x86/include/asm/cpufeature.h:5:
   In file included from arch/x86/include/asm/processor.h:13:
   In file included from arch/x86/include/asm/math_emu.h:5:
   In file included from arch/x86/include/asm/ptrace.h:97:
   In file included from arch/x86/include/asm/paravirt_types.h:40:
   In file included from arch/x86/include/asm/nospec-branch.h:6:
   In file included from include/linux/static_key.h:1:
   include/linux/jump_label.h:318:2: error: expected ')'
           STATIC_KEY_CHECK_USE(key);
           ^
   include/linux/jump_label.h:81:35: note: expanded from macro 'STATIC_KEY_CHECK_USE'
   #define STATIC_KEY_CHECK_USE(key) WARN(!static_key_initialized,               \
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
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from arch/x86/include/asm/preempt.h:7:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/x86/include/asm/thread_info.h:53:
   In file included from arch/x86/include/asm/cpufeature.h:5:
   In file included from arch/x86/include/asm/processor.h:13:
   In file included from arch/x86/include/asm/math_emu.h:5:
   In file included from arch/x86/include/asm/ptrace.h:97:
   In file included from arch/x86/include/asm/paravirt_types.h:40:
   In file included from arch/x86/include/asm/nospec-branch.h:6:
   In file included from include/linux/static_key.h:1:
   include/linux/jump_label.h:321:3: error: expected ')'
                   WARN_ON_ONCE(atomic_read(&key->enabled) != 1);
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
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from arch/x86/include/asm/preempt.h:7:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/x86/include/asm/thread_info.h:53:
   In file included from arch/x86/include/asm/cpufeature.h:5:
   In file included from arch/x86/include/asm/processor.h:13:
   In file included from arch/x86/include/asm/math_emu.h:5:
   In file included from arch/x86/include/asm/ptrace.h:97:
   In file included from arch/x86/include/asm/paravirt_types.h:40:
   In file included from arch/x86/include/asm/nospec-branch.h:6:
   In file included from include/linux/static_key.h:1:
   include/linux/jump_label.h:329:2: error: expected ')'
           STATIC_KEY_CHECK_USE(key);
           ^
   include/linux/jump_label.h:81:35: note: expanded from macro 'STATIC_KEY_CHECK_USE'
   #define STATIC_KEY_CHECK_USE(key) WARN(!static_key_initialized,               \
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
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from arch/x86/include/asm/preempt.h:7:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/x86/include/asm/thread_info.h:53:
   In file included from arch/x86/include/asm/cpufeature.h:5:
   In file included from arch/x86/include/asm/processor.h:13:
   In file included from arch/x86/include/asm/math_emu.h:5:
   In file included from arch/x86/include/asm/ptrace.h:97:
   In file included from arch/x86/include/asm/paravirt_types.h:40:
   In file included from arch/x86/include/asm/nospec-branch.h:6:
   In file included from include/linux/static_key.h:1:
   include/linux/jump_label.h:332:3: error: expected ')'
                   WARN_ON_ONCE(atomic_read(&key->enabled) != 0);
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
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from arch/x86/include/asm/preempt.h:7:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/x86/include/asm/thread_info.h:53:
   In file included from arch/x86/include/asm/cpufeature.h:5:
   In file included from arch/x86/include/asm/processor.h:22:
   In file included from arch/x86/include/asm/msr.h:11:
   In file included from arch/x86/include/asm/cpumask.h:5:
>> include/linux/cpumask.h:108:2: error: expected ')'
           WARN_ON_ONCE(cpu >= bits);
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
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from arch/x86/include/asm/preempt.h:7:
>> include/linux/thread_info.h:200:2: error: expected ')'
           WARN(1, "Buffer overflow detected (%d < %lu)!\n", size, count);
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
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from arch/x86/include/asm/preempt.h:7:
   include/linux/thread_info.h:216:6: error: expected ')'
           if (WARN_ON_ONCE(bytes > INT_MAX))
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
   In file included from include/linux/mmzone.h:16:
   In file included from include/linux/seqlock.h:20:
>> include/linux/ww_mutex.h:171:2: error: expected ')'
           lockdep_assert_held(ctx);
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
   In file included from include/linux/seqlock.h:20:
   include/linux/ww_mutex.h:173:2: error: expected ')'
           DEBUG_LOCKS_WARN_ON(ctx->done_acquire);
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
   In file included from include/linux/mmzone.h:16:
   In file included from include/linux/seqlock.h:20:
   include/linux/ww_mutex.h:191:2: error: expected ')'
           DEBUG_LOCKS_WARN_ON(ctx->acquired);
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
   In file included from include/linux/mmzone.h:16:
   In file included from include/linux/seqlock.h:20:
   include/linux/ww_mutex.h:297:2: error: expected ')'
           DEBUG_LOCKS_WARN_ON(!ctx->contending_lock);
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
   In file included from include/linux/mmzone.h:16:
   In file included from include/linux/seqlock.h:20:
   include/linux/ww_mutex.h:333:2: error: expected ')'
           DEBUG_LOCKS_WARN_ON(!ctx->contending_lock);
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
   In file included from include/linux/mmzone.h:16:
>> include/linux/seqlock.h:271:2: error: expected ')'
           lockdep_assert_preemption_disabled();
           ^
   include/linux/lockdep.h:607:2: note: expanded from macro 'lockdep_assert_preemption_disabled'
           WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)   &&              \
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
   In file included from include/linux/mmzone.h:16:
   include/linux/seqlock.h:276:1: error: expected ')'
   SEQCOUNT_LOCKNAME(raw_spinlock, raw_spinlock_t,  false,    s->lock,        raw_spin, raw_spin_lock(s->lock))
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
   include/linux/seqlock.h:277:1: error: expected ')'
   SEQCOUNT_LOCKNAME(spinlock,     spinlock_t,      __SEQ_RT, s->lock,        spin,     spin_lock(s->lock))
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


vim +290 include/linux/jump_label.h

bf5438fca2950b Jason Baron     2010-09-17  287  
c5905afb0ee655 Ingo Molnar     2012-02-24  288  static inline void static_key_slow_inc(struct static_key *key)
d430d3d7e646eb Jason Baron     2011-03-16  289  {
5cdda5117e125e Borislav Petkov 2017-10-18 @290  	STATIC_KEY_CHECK_USE(key);
d430d3d7e646eb Jason Baron     2011-03-16  291  	atomic_inc(&key->enabled);
d430d3d7e646eb Jason Baron     2011-03-16  292  }
bf5438fca2950b Jason Baron     2010-09-17  293  

:::::: The code at line 290 was first introduced by commit
:::::: 5cdda5117e125e0dbb020425cc55a4c143c6febc locking/static_keys: Improve uninitialized key warning

:::::: TO: Borislav Petkov <bp@suse.de>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

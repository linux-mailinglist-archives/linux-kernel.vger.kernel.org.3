Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C350249009C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 04:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbiAQDlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 22:41:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:24959 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231537AbiAQDlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 22:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642390885; x=1673926885;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BTnjIY3zcb179ObENt7eweJVpmgKCsSQpmjGZJTzHXU=;
  b=KIK/4gZ9gvKQTzpXpP1DzWsTaohrs7eH8kdRkZD+Y7SYXY6EcP2vIMkk
   KMPUDCfIhUt4ND/MVTxgdSkUu/JEzqchO4My0evdoEAGrTrtpd5Pdf8Hx
   K0v/h+KTq70NnTg1/IYjP26ZMFhhS9mWgnb9zrkNqpoaAsht6Vg10um8W
   xS6VC1alFYvpSxxsSEClEUQlvxbbWudJCTs9REUXFNoBGApS2BQKXYrG/
   J/og0x8Rz/PcW6pdy4e8VvbP6lzrZrrpCBzvF1eNM+KhXqDabaWe1kln0
   TlpxocikZpmEEQ1IQqgRoZDMqWj/UfFqMAXYvVumM+GJOCVVZyHAnaRHC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="224525365"
X-IronPort-AV: E=Sophos;i="5.88,294,1635231600"; 
   d="scan'208";a="224525365"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 19:41:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,294,1635231600"; 
   d="scan'208";a="614926282"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jan 2022 19:41:23 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9ItW-000BE5-V8; Mon, 17 Jan 2022 03:41:22 +0000
Date:   Mon, 17 Jan 2022 11:40:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 168/2384]
 include/linux/sched/affinity.h:32:9: error: incomplete definition of type
 'struct task_struct'
Message-ID: <202201171113.5k8tKBGY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: 92675dd8b872d91539f60f7dc7ddf7e2a1c70361 [168/2384] headers/deps: Move CPU affinity APIs from <linux/sched.h> to <linux/sched/affinity.h>
config: i386-randconfig-a014-20220109 (https://download.01.org/0day-ci/archive/20220117/202201171113.5k8tKBGY-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f782d25a742302d25ef3c8b84b54f7483c2deb9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=92675dd8b872d91539f60f7dc7ddf7e2a1c70361
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 92675dd8b872d91539f60f7dc7ddf7e2a1c70361
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the mingo-tip/sched/headers HEAD 4c707c1c0de83967079b4e385012fa5b00e2cd11 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from lib/syscall.c:2:
>> include/linux/sched/affinity.h:32:9: error: incomplete definition of type 'struct task_struct'
           if (src->user_cpus_ptr)
               ~~~^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
   include/linux/sched/affinity.h:8:8: note: forward declaration of 'struct task_struct'
   struct task_struct;
          ^
>> include/linux/sched/affinity.h:32:9: error: incomplete definition of type 'struct task_struct'
           if (src->user_cpus_ptr)
               ~~~^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:61: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                               ^~~~
   include/linux/sched/affinity.h:8:8: note: forward declaration of 'struct task_struct'
   struct task_struct;
          ^
>> include/linux/sched/affinity.h:32:9: error: incomplete definition of type 'struct task_struct'
           if (src->user_cpus_ptr)
               ~~~^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:86: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                                        ^~~~
   include/linux/compiler.h:69:3: note: expanded from macro '__trace_if_value'
           (cond) ?                                        \
            ^~~~
   include/linux/sched/affinity.h:8:8: note: forward declaration of 'struct task_struct'
   struct task_struct;
          ^
   include/linux/sched/affinity.h:38:11: error: incomplete definition of type 'struct task_struct'
           WARN_ON(p->user_cpus_ptr);
                   ~^
   include/asm-generic/bug.h:121:25: note: expanded from macro 'WARN_ON'
           int __ret_warn_on = !!(condition);                              \
                                  ^~~~~~~~~
   include/linux/sched/affinity.h:8:8: note: forward declaration of 'struct task_struct'
   struct task_struct;
          ^
   4 errors generated.
--
>> kernel/sched/core.c:3571:9: error: implicit declaration of function 'set_cpus_allowed_ptr' [-Werror,-Wimplicit-function-declaration]
           return set_cpus_allowed_ptr(p, new_mask);
                  ^
   kernel/sched/core.c:3571:9: note: did you mean '__set_cpus_allowed_ptr'?
   kernel/sched/core.c:3567:19: note: '__set_cpus_allowed_ptr' declared here
   static inline int __set_cpus_allowed_ptr(struct task_struct *p,
                     ^
>> kernel/sched/core.c:8017:11: error: implicit declaration of function 'dl_task_check_affinity' [-Werror,-Wimplicit-function-declaration]
           retval = dl_task_check_affinity(p, new_mask);
                    ^
   kernel/sched/core.c:9369:13: warning: no previous prototype for function 'per_task_init' [-Wmissing-prototypes]
   void __init per_task_init(void)
               ^
   kernel/sched/core.c:9369:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init per_task_init(void)
   ^
   static 
   1 warning and 2 errors generated.
--
   In file included from arch/x86/kernel/cpu/resctrl/pseudo_lock.c:14:
>> include/linux/sched/affinity.h:32:9: error: incomplete definition of type 'struct task_struct'
           if (src->user_cpus_ptr)
               ~~~^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
   include/linux/sched/affinity.h:8:8: note: forward declaration of 'struct task_struct'
   struct task_struct;
          ^
>> include/linux/sched/affinity.h:32:9: error: incomplete definition of type 'struct task_struct'
           if (src->user_cpus_ptr)
               ~~~^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:61: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                               ^~~~
   include/linux/sched/affinity.h:8:8: note: forward declaration of 'struct task_struct'
   struct task_struct;
          ^
>> include/linux/sched/affinity.h:32:9: error: incomplete definition of type 'struct task_struct'
           if (src->user_cpus_ptr)
               ~~~^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:86: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                                        ^~~~
   include/linux/compiler.h:69:3: note: expanded from macro '__trace_if_value'
           (cond) ?                                        \
            ^~~~
   include/linux/sched/affinity.h:8:8: note: forward declaration of 'struct task_struct'
   struct task_struct;
          ^
   include/linux/sched/affinity.h:38:11: error: incomplete definition of type 'struct task_struct'
           WARN_ON(p->user_cpus_ptr);
                   ~^
   include/asm-generic/bug.h:121:25: note: expanded from macro 'WARN_ON'
           int __ret_warn_on = !!(condition);                              \
                                  ^~~~~~~~~
   include/linux/sched/affinity.h:8:8: note: forward declaration of 'struct task_struct'
   struct task_struct;
          ^
   In file included from arch/x86/kernel/cpu/resctrl/pseudo_lock.c:20:
   include/linux/mman.h:158:9: warning: division by zero is undefined [-Wdivision-by-zero]
                  _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mman.h:136:21: note: expanded from macro '_calc_vm_trans'
      : ((x) & (bit1)) / ((bit1) / (bit2))))
                       ^ ~~~~~~~~~~~~~~~~~
   1 warning and 4 errors generated.


vim +32 include/linux/sched/affinity.h

     9	
    10	extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
    11	extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allowed);
    12	#ifdef CONFIG_SMP
    13	extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
    14	extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
    15	extern int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src, int node);
    16	extern void release_user_cpus_ptr(struct task_struct *p);
    17	extern int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask);
    18	extern void force_compatible_cpus_allowed_ptr(struct task_struct *p);
    19	extern void relax_compatible_cpus_allowed_ptr(struct task_struct *p);
    20	#else
    21	static inline void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
    22	{
    23	}
    24	static inline int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
    25	{
    26		if (!cpumask_test_cpu(0, new_mask))
    27			return -EINVAL;
    28		return 0;
    29	}
    30	static inline int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src, int node)
    31	{
  > 32		if (src->user_cpus_ptr)
    33			return -EINVAL;
    34		return 0;
    35	}
    36	static inline void release_user_cpus_ptr(struct task_struct *p)
    37	{
    38		WARN_ON(p->user_cpus_ptr);
    39	}
    40	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

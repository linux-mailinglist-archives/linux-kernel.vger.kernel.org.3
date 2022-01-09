Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9D1488D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 00:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiAIXeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 18:34:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:18936 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229932AbiAIXeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 18:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641771241; x=1673307241;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8CwaDDdrTcWDLHapnsLwqqi2uOmtiqvgsa5hmnzrs1M=;
  b=YqeWeVcc8v1aaeMWGyA0HcTbifcnqGtSTOUoUaXeTkAwonUroRveBayE
   t67rUf/J9zZgLD01nXgDHXqSehklToOW5EaeQ66fhGiGh3bf3IUwcmvtO
   d0DHgq69TwTdFBXkxpE1/9yvTZRN2vUG6v4hPOGv6NHfUuINLNk2vAzwM
   DOX37XVs4rO2wMTwu9+ziBaf6OM+mpOTfVlPe+fO8YF/s6iuK8Vtcczgz
   w8oyga+Y9+4a3Y11F0ZF5yAjPDThECJKUqsn/CPyjfqJHGI8ijLgJmhn4
   7nC24HxDtAEPlOkeYp5h+yLYSqmOlGB2lo5CwjAxfLI2OdrguUcNMioyK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="240673482"
X-IronPort-AV: E=Sophos;i="5.88,275,1635231600"; 
   d="scan'208";a="240673482"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 15:34:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,275,1635231600"; 
   d="scan'208";a="514483878"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Jan 2022 15:33:59 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6hhH-0001xd-7K; Sun, 09 Jan 2022 23:33:59 +0000
Date:   Mon, 10 Jan 2022 07:33:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 562/2380]
 include/linux/sched/thread_info_api.h:11:28: error: field 'task' has
 incomplete type
Message-ID: <202201100729.ZMzCwe0F-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   351bfbf7f1e8dce84b605c8007c98dd603c4ca4d
commit: 3c27370c77da679d6be2c53c933877befbe10eb4 [562/2380] headers/deps: Move task->thread_info to per_task()
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20220110/202201100729.ZMzCwe0F-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=3c27370c77da679d6be2c53c933877befbe10eb4
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 3c27370c77da679d6be2c53c933877befbe10eb4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the mingo-tip/sched/headers HEAD 351bfbf7f1e8dce84b605c8007c98dd603c4ca4d builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/preempt.h:5,
                    from ./arch/sparc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/smp.h:110,
                    from include/linux/lockdep.h:23,
                    from include/linux/sched.h:32,
                    from arch/sparc/kernel/../../../kernel/sched/per_task_area_struct.h:7,
                    from arch/sparc/kernel/asm-offsets.c:14:
>> include/linux/sched/thread_info_api.h:11:28: error: field 'task' has incomplete type
      11 |         struct task_struct task;
         |                            ^~~~
   In file included from include/linux/sched.h:12,
                    from arch/sparc/kernel/../../../kernel/sched/per_task_area_struct.h:7,
                    from arch/sparc/kernel/asm-offsets.c:14:
   include/linux/sched/thread_info_api.h: In function 'set_tsk_thread_flag':
>> include/linux/sched/per_task.h:60:91: error: invalid use of undefined type 'struct task_struct'
      60 | #define per_task(task, name)                    (*((__typeof__(per_task__##name) *)((task)->per_task_area + per_task_offset(name))))
         |                                                                                           ^~
   include/linux/sched/thread_info_api.h:31:56: note: in expansion of macro 'per_task'
      31 | # define task_thread_info(task) ((struct thread_info *)per_task(task, stack))
         |                                                        ^~~~~~~~
   include/linux/sched/thread_info_api.h:49:28: note: in expansion of macro 'task_thread_info'
      49 |         set_ti_thread_flag(task_thread_info(tsk), flag);
         |                            ^~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h: In function 'clear_tsk_thread_flag':
>> include/linux/sched/per_task.h:60:91: error: invalid use of undefined type 'struct task_struct'
      60 | #define per_task(task, name)                    (*((__typeof__(per_task__##name) *)((task)->per_task_area + per_task_offset(name))))
         |                                                                                           ^~
   include/linux/sched/thread_info_api.h:31:56: note: in expansion of macro 'per_task'
      31 | # define task_thread_info(task) ((struct thread_info *)per_task(task, stack))
         |                                                        ^~~~~~~~
   include/linux/sched/thread_info_api.h:54:30: note: in expansion of macro 'task_thread_info'
      54 |         clear_ti_thread_flag(task_thread_info(tsk), flag);
         |                              ^~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h: In function 'update_tsk_thread_flag':
>> include/linux/sched/per_task.h:60:91: error: invalid use of undefined type 'struct task_struct'
      60 | #define per_task(task, name)                    (*((__typeof__(per_task__##name) *)((task)->per_task_area + per_task_offset(name))))
         |                                                                                           ^~
   include/linux/sched/thread_info_api.h:31:56: note: in expansion of macro 'per_task'
      31 | # define task_thread_info(task) ((struct thread_info *)per_task(task, stack))
         |                                                        ^~~~~~~~
   include/linux/sched/thread_info_api.h:60:31: note: in expansion of macro 'task_thread_info'
      60 |         update_ti_thread_flag(task_thread_info(tsk), flag, value);
         |                               ^~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h: In function 'test_and_set_tsk_thread_flag':
>> include/linux/sched/per_task.h:60:91: error: invalid use of undefined type 'struct task_struct'
      60 | #define per_task(task, name)                    (*((__typeof__(per_task__##name) *)((task)->per_task_area + per_task_offset(name))))
         |                                                                                           ^~
   include/linux/sched/thread_info_api.h:31:56: note: in expansion of macro 'per_task'
      31 | # define task_thread_info(task) ((struct thread_info *)per_task(task, stack))
         |                                                        ^~~~~~~~
   include/linux/sched/thread_info_api.h:65:44: note: in expansion of macro 'task_thread_info'
      65 |         return test_and_set_ti_thread_flag(task_thread_info(tsk), flag);
         |                                            ^~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h: In function 'test_and_clear_tsk_thread_flag':
>> include/linux/sched/per_task.h:60:91: error: invalid use of undefined type 'struct task_struct'
      60 | #define per_task(task, name)                    (*((__typeof__(per_task__##name) *)((task)->per_task_area + per_task_offset(name))))
         |                                                                                           ^~
   include/linux/sched/thread_info_api.h:31:56: note: in expansion of macro 'per_task'
      31 | # define task_thread_info(task) ((struct thread_info *)per_task(task, stack))
         |                                                        ^~~~~~~~
   include/linux/sched/thread_info_api.h:70:46: note: in expansion of macro 'task_thread_info'
      70 |         return test_and_clear_ti_thread_flag(task_thread_info(tsk), flag);
         |                                              ^~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h: In function 'test_tsk_thread_flag':
>> include/linux/sched/per_task.h:60:91: error: invalid use of undefined type 'struct task_struct'
      60 | #define per_task(task, name)                    (*((__typeof__(per_task__##name) *)((task)->per_task_area + per_task_offset(name))))
         |                                                                                           ^~
   include/linux/sched/thread_info_api.h:31:56: note: in expansion of macro 'per_task'
      31 | # define task_thread_info(task) ((struct thread_info *)per_task(task, stack))
         |                                                        ^~~~~~~~
   include/linux/sched/thread_info_api.h:75:36: note: in expansion of macro 'task_thread_info'
      75 |         return test_ti_thread_flag(task_thread_info(tsk), flag);
         |                                    ^~~~~~~~~~~~~~~~
   In file included from <command-line>:
   include/linux/sched/thread_info_api.h: In function 'task_cpu':
>> include/linux/sched/per_task.h:60:91: error: invalid use of undefined type 'const struct task_struct'
      60 | #define per_task(task, name)                    (*((__typeof__(per_task__##name) *)((task)->per_task_area + per_task_offset(name))))
         |                                                                                           ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:100:16: note: in expansion of macro 'READ_ONCE'
     100 |         return READ_ONCE(task_thread_info(p)->cpu);
         |                ^~~~~~~~~
   include/linux/sched/thread_info_api.h:31:56: note: in expansion of macro 'per_task'
      31 | # define task_thread_info(task) ((struct thread_info *)per_task(task, stack))
         |                                                        ^~~~~~~~
   include/linux/sched/thread_info_api.h:100:26: note: in expansion of macro 'task_thread_info'
     100 |         return READ_ONCE(task_thread_info(p)->cpu);
         |                          ^~~~~~~~~~~~~~~~
>> include/linux/sched/per_task.h:60:91: error: invalid use of undefined type 'const struct task_struct'
      60 | #define per_task(task, name)                    (*((__typeof__(per_task__##name) *)((task)->per_task_area + per_task_offset(name))))
         |                                                                                           ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:100:16: note: in expansion of macro 'READ_ONCE'
     100 |         return READ_ONCE(task_thread_info(p)->cpu);
         |                ^~~~~~~~~
   include/linux/sched/thread_info_api.h:31:56: note: in expansion of macro 'per_task'
      31 | # define task_thread_info(task) ((struct thread_info *)per_task(task, stack))
         |                                                        ^~~~~~~~
   include/linux/sched/thread_info_api.h:100:26: note: in expansion of macro 'task_thread_info'
     100 |         return READ_ONCE(task_thread_info(p)->cpu);
         |                          ^~~~~~~~~~~~~~~~
>> include/linux/sched/per_task.h:60:91: error: invalid use of undefined type 'const struct task_struct'
      60 | #define per_task(task, name)                    (*((__typeof__(per_task__##name) *)((task)->per_task_area + per_task_offset(name))))
         |                                                                                           ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:100:16: note: in expansion of macro 'READ_ONCE'
     100 |         return READ_ONCE(task_thread_info(p)->cpu);
         |                ^~~~~~~~~
   include/linux/sched/thread_info_api.h:31:56: note: in expansion of macro 'per_task'
      31 | # define task_thread_info(task) ((struct thread_info *)per_task(task, stack))
         |                                                        ^~~~~~~~
   include/linux/sched/thread_info_api.h:100:26: note: in expansion of macro 'task_thread_info'
     100 |         return READ_ONCE(task_thread_info(p)->cpu);
         |                          ^~~~~~~~~~~~~~~~
>> include/linux/sched/per_task.h:60:91: error: invalid use of undefined type 'const struct task_struct'
      60 | #define per_task(task, name)                    (*((__typeof__(per_task__##name) *)((task)->per_task_area + per_task_offset(name))))
         |                                                                                           ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:100:16: note: in expansion of macro 'READ_ONCE'
     100 |         return READ_ONCE(task_thread_info(p)->cpu);
         |                ^~~~~~~~~
   include/linux/sched/thread_info_api.h:31:56: note: in expansion of macro 'per_task'
      31 | # define task_thread_info(task) ((struct thread_info *)per_task(task, stack))
         |                                                        ^~~~~~~~
   include/linux/sched/thread_info_api.h:100:26: note: in expansion of macro 'task_thread_info'
     100 |         return READ_ONCE(task_thread_info(p)->cpu);
         |                          ^~~~~~~~~~~~~~~~
>> include/linux/sched/per_task.h:60:91: error: invalid use of undefined type 'const struct task_struct'
      60 | #define per_task(task, name)                    (*((__typeof__(per_task__##name) *)((task)->per_task_area + per_task_offset(name))))
         |                                                                                           ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:100:16: note: in expansion of macro 'READ_ONCE'
     100 |         return READ_ONCE(task_thread_info(p)->cpu);
         |                ^~~~~~~~~
   include/linux/sched/thread_info_api.h:31:56: note: in expansion of macro 'per_task'
      31 | # define task_thread_info(task) ((struct thread_info *)per_task(task, stack))
         |                                                        ^~~~~~~~
   include/linux/sched/thread_info_api.h:100:26: note: in expansion of macro 'task_thread_info'
     100 |         return READ_ONCE(task_thread_info(p)->cpu);
         |                          ^~~~~~~~~~~~~~~~
>> include/linux/sched/per_task.h:60:91: error: invalid use of undefined type 'const struct task_struct'
      60 | #define per_task(task, name)                    (*((__typeof__(per_task__##name) *)((task)->per_task_area + per_task_offset(name))))
         |                                                                                           ^~
   include/linux/compiler_types.h:291:27: note: in definition of macro '__unqual_scalar_typeof'
     291 |                 _Generic((x),                                           \
         |                           ^
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   include/linux/sched/thread_info_api.h:100:16: note: in expansion of macro 'READ_ONCE'
     100 |         return READ_ONCE(task_thread_info(p)->cpu);
         |                ^~~~~~~~~
   include/linux/sched/thread_info_api.h:31:56: note: in expansion of macro 'per_task'
      31 | # define task_thread_info(task) ((struct thread_info *)per_task(task, stack))
         |                                                        ^~~~~~~~
   include/linux/sched/thread_info_api.h:100:26: note: in expansion of macro 'task_thread_info'
     100 |         return READ_ONCE(task_thread_info(p)->cpu);
         |                          ^~~~~~~~~~~~~~~~
   In file included from ./arch/sparc/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:266,
                    from include/linux/sched/per_task.h:41,
                    from include/linux/sched.h:12,
                    from arch/sparc/kernel/../../../kernel/sched/per_task_area_struct.h:7,
                    from arch/sparc/kernel/asm-offsets.c:14:
>> include/linux/sched/per_task.h:60:91: error: invalid use of undefined type 'const struct task_struct'
      60 | #define per_task(task, name)                    (*((__typeof__(per_task__##name) *)((task)->per_task_area + per_task_offset(name))))
         |                                                                                           ^~
   include/asm-generic/rwonce.h:44:73: note: in definition of macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
   include/linux/sched/thread_info_api.h:100:16: note: in expansion of macro 'READ_ONCE'
     100 |         return READ_ONCE(task_thread_info(p)->cpu);
         |                ^~~~~~~~~
   include/linux/sched/thread_info_api.h:31:56: note: in expansion of macro 'per_task'
      31 | # define task_thread_info(task) ((struct thread_info *)per_task(task, stack))
         |                                                        ^~~~~~~~
   include/linux/sched/thread_info_api.h:100:26: note: in expansion of macro 'task_thread_info'
     100 |         return READ_ONCE(task_thread_info(p)->cpu);
         |                          ^~~~~~~~~~~~~~~~
   In file included from arch/sparc/kernel/asm-offsets.c:23:
   arch/sparc/kernel/../../../kernel/sched/per_task_area_struct_defs.h: At top level:
   arch/sparc/kernel/../../../kernel/sched/per_task_area_struct_defs.h:13:13: warning: no previous prototype for 'per_task_common' [-Wmissing-prototypes]
      13 | void __used per_task_common(void)
         |             ^~~~~~~~~~~~~~~
   arch/sparc/kernel/asm-offsets.c:36:5: warning: no previous prototype for 'sparc64_foo' [-Wmissing-prototypes]
      36 | int sparc64_foo(void)
         |     ^~~~~~~~~~~
   arch/sparc/kernel/asm-offsets.c:55:5: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
      55 | int foo(void)
         |     ^~~
   make[2]: *** [scripts/Makefile.build:121: arch/sparc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1197: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/task +11 include/linux/sched/thread_info_api.h

     8	
     9	union thread_union {
    10	#ifndef CONFIG_ARCH_TASK_STRUCT_ON_STACK
  > 11		struct task_struct task;
    12	#endif
    13	#ifndef CONFIG_THREAD_INFO_IN_TASK
    14		struct thread_info thread_info;
    15	#endif
    16		unsigned long stack[THREAD_SIZE/sizeof(long)];
    17	};
    18	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

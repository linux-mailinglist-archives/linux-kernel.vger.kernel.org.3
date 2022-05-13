Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019435259DB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 04:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349194AbiEMC6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 22:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376599AbiEMC6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 22:58:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9A92927A2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 19:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652410711; x=1683946711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SzQgBpjRtY7+OjO4z70O/XdgIcbGLvWzeSJ5axqI1Zc=;
  b=WSfY2Ebs+zGI24P83SfZmJJoG1F+hP+aZ4dbzm45XC/DyryAaor7Yywo
   0EI7fmFzYeUxGHOHDxOCNN42jcRtEWAOtCwv722pU8YrhV5/RZnCjjWq4
   ZfqyLVOhw9r7gR9ynLZ/M4rrbYbIUnspZ4jOr0h1KEtD7bqdGcxfaDEB+
   rAm50xHWFQ2toIoC/Fo4n3hhJWKK4Cyq/QKtlEpT87fYRvniqVjpwaqcV
   xk8UnPA97UljTp0RV1+RiFMTH1v5Pmd34TP84MikszeXFZEZziQ9VevSz
   NKuxDIuLX53KwFMou8/See2rIETXnEIPl4eZyQMjYOk1iBzJtaUVoesR1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="269869008"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="269869008"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 19:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="698316119"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 12 May 2022 19:58:27 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npLVa-000LEO-Op;
        Fri, 13 May 2022 02:58:26 +0000
Date:   Fri, 13 May 2022 10:57:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, broonie@kernel.org, pcc@google.com,
        mark.rutland@arm.com, keescook@chromium.org, daniel.kiss@arm.com
Cc:     kbuild-all@lists.01.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, wangweiyang2@huawei.com,
        gongruiqi1@huawei.com
Subject: Re: [PATCH -next] arm64: add missing header dependencies
Message-ID: <202205131035.qIYEFTpo-lkp@intel.com>
References: <20220509061751.3434059-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509061751.3434059-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gaosheng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220506]

url:    https://github.com/intel-lab-lkp/linux/commits/Gaosheng-Cui/arm64-add-missing-header-dependencies/20220509-142946
base:    38a288f5941ef03752887ad86f2d85442358c99a
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220513/202205131035.qIYEFTpo-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/05d29bfe89ad4e7205d77fcdd8199dd6544ff784
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gaosheng-Cui/arm64-add-missing-header-dependencies/20220509-142946
        git checkout 05d29bfe89ad4e7205d77fcdd8199dd6544ff784
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
   In file included from include/linux/ipc.h:7,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/sched.h:15,
                    from include/linux/sched/task_stack.h:9,
                    from arch/arm64/include/asm/processor.h:31,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/acpi/apei.h:9,
                    from include/acpi/ghes.h:5,
                    from include/linux/arm_sdei.h:8,
                    from arch/arm64/kernel/asm-offsets.c:10:
>> include/linux/rhashtable-types.h:88:41: error: field 'mutex' has incomplete type
      88 |         struct mutex                    mutex;
         |                                         ^~~~~
   In file included from include/linux/hrtimer.h:20,
                    from include/linux/sched.h:19,
                    from include/linux/sched/task_stack.h:9,
                    from arch/arm64/include/asm/processor.h:31,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/acpi/apei.h:9,
                    from include/acpi/ghes.h:5,
                    from include/linux/arm_sdei.h:8,
                    from arch/arm64/kernel/asm-offsets.c:10:
   include/linux/seqlock.h: In function '__seqprop_mutex_sequence':
>> include/linux/seqlock.h:277:86: error: implicit declaration of function 'mutex_lock' [-Werror=implicit-function-declaration]
     277 | SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
         |                                                                                      ^~~~~~~~~~
   include/linux/seqlock.h:151:33: note: in definition of macro '__SEQ_LOCK'
     151 | #define __SEQ_LOCK(expr)        expr
         |                                 ^~~~
   include/linux/seqlock.h:277:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     277 | SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
         | ^~~~~~~~~~~~~~~~~
>> include/linux/seqlock.h:277:76: error: implicit declaration of function 'mutex_unlock'; did you mean 'write_unlock'? [-Werror=implicit-function-declaration]
     277 | SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
         |                                                                            ^~~~~
   include/linux/seqlock.h:151:33: note: in definition of macro '__SEQ_LOCK'
     151 | #define __SEQ_LOCK(expr)        expr
         |                                 ^~~~
   include/linux/seqlock.h:277:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     277 | SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
         | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h: In function '__seqprop_mutex_assert':
>> include/linux/lockdep.h:282:61: error: invalid use of undefined type 'struct mutex'
     282 | #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
         |                                                             ^~
   include/linux/seqlock.h:151:33: note: in definition of macro '__SEQ_LOCK'
     151 | #define __SEQ_LOCK(expr)        expr
         |                                 ^~~~
   include/linux/lockdep.h:306:14: note: in expansion of macro 'WARN_ON'
     306 |         do { WARN_ON(debug_locks && !(cond)); } while (0)
         |              ^~~~~~~
   include/linux/lockdep.h:312:9: note: in expansion of macro 'lockdep_assert'
     312 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |         ^~~~~~~~~~~~~~
   include/linux/lockdep.h:312:24: note: in expansion of macro 'lockdep_is_held'
     312 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |                        ^~~~~~~~~~~~~~~
   include/linux/seqlock.h:245:20: note: in expansion of macro 'lockdep_assert_held'
     245 |         __SEQ_LOCK(lockdep_assert_held(lockmember));                    \
         |                    ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:277:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     277 | SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
         | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h: In function 'read_seqbegin':
>> include/linux/seqlock.h:330:17: error: implicit declaration of function 'cpu_relax' [-Werror=implicit-function-declaration]
     330 |                 cpu_relax();                                            \
         |                 ^~~~~~~~~
   include/linux/seqlock.h:344:25: note: in expansion of macro '__read_seqcount_begin'
     344 |         unsigned _seq = __read_seqcount_begin(s);                       \
         |                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:359:9: note: in expansion of macro 'raw_read_seqcount_begin'
     359 |         raw_read_seqcount_begin(s);                                     \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:836:24: note: in expansion of macro 'read_seqcount_begin'
     836 |         unsigned ret = read_seqcount_begin(&sl->seqcount);
         |                        ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/sched/task_stack.h:9,
                    from arch/arm64/include/asm/processor.h:31,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/acpi/apei.h:9,
                    from include/acpi/ghes.h:5,
                    from include/linux/arm_sdei.h:8,
                    from arch/arm64/kernel/asm-offsets.c:10:
   include/linux/sched.h: At top level:
>> include/linux/sched.h:1227:41: error: field 'futex_exit_mutex' has incomplete type
    1227 |         struct mutex                    futex_exit_mutex;
         |                                         ^~~~~~~~~~~~~~~~
>> include/linux/sched.h:1232:41: error: field 'perf_event_mutex' has incomplete type
    1232 |         struct mutex                    perf_event_mutex;
         |                                         ^~~~~~~~~~~~~~~~
>> include/linux/sched.h:1512:41: error: field 'thread' has incomplete type
    1512 |         struct thread_struct            thread;
         |                                         ^~~~~~
   In file included from include/vdso/processor.h:10,
                    from arch/arm64/include/asm/processor.h:36,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/acpi/apei.h:9,
                    from include/acpi/ghes.h:5,
                    from include/linux/arm_sdei.h:8,
                    from arch/arm64/kernel/asm-offsets.c:10:
>> arch/arm64/include/asm/vdso/processor.h:10:20: warning: conflicting types for 'cpu_relax'; have 'void(void)'
      10 | static inline void cpu_relax(void)
         |                    ^~~~~~~~~
>> arch/arm64/include/asm/vdso/processor.h:10:20: error: static declaration of 'cpu_relax' follows non-static declaration
   In file included from include/linux/hrtimer.h:20,
                    from include/linux/sched.h:19,
                    from include/linux/sched/task_stack.h:9,
                    from arch/arm64/include/asm/processor.h:31,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/acpi/apei.h:9,
                    from include/acpi/ghes.h:5,
                    from include/linux/arm_sdei.h:8,
                    from arch/arm64/kernel/asm-offsets.c:10:
   include/linux/seqlock.h:330:17: note: previous implicit declaration of 'cpu_relax' with type 'void(void)'
     330 |                 cpu_relax();                                            \
         |                 ^~~~~~~~~
   include/linux/seqlock.h:344:25: note: in expansion of macro '__read_seqcount_begin'
     344 |         unsigned _seq = __read_seqcount_begin(s);                       \
         |                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:359:9: note: in expansion of macro 'raw_read_seqcount_begin'
     359 |         raw_read_seqcount_begin(s);                                     \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:836:24: note: in expansion of macro 'read_seqcount_begin'
     836 |         unsigned ret = read_seqcount_begin(&sl->seqcount);
         |                        ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/acpi/apei.h:9,
                    from include/acpi/ghes.h:5,
                    from include/linux/arm_sdei.h:8,
                    from arch/arm64/kernel/asm-offsets.c:10:
>> arch/arm64/include/asm/processor.h:70: warning: "TASK_SIZE_OF" redefined
      70 | #define TASK_SIZE_OF(tsk)       (test_tsk_thread_flag(tsk, TIF_32BIT) ? \
         | 
   In file included from include/linux/sched/task_stack.h:9,
                    from arch/arm64/include/asm/processor.h:31,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/acpi/apei.h:9,
                    from include/acpi/ghes.h:5,
                    from include/linux/arm_sdei.h:8,
                    from arch/arm64/kernel/asm-offsets.c:10:
   include/linux/sched.h:2248: note: this is the location of the previous definition
    2248 | #define TASK_SIZE_OF(tsk)       TASK_SIZE
         | 
   In file included from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/acpi/apei.h:9,
                    from include/acpi/ghes.h:5,
                    from include/linux/arm_sdei.h:8,
                    from arch/arm64/kernel/asm-offsets.c:10:
>> include/linux/mutex.h:218:13: warning: conflicting types for 'mutex_unlock'; have 'void(struct mutex *)'
     218 | extern void mutex_unlock(struct mutex *lock);
         |             ^~~~~~~~~~~~
   In file included from include/linux/hrtimer.h:20,
                    from include/linux/sched.h:19,
                    from include/linux/sched/task_stack.h:9,
                    from arch/arm64/include/asm/processor.h:31,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/acpi/apei.h:9,
                    from include/acpi/ghes.h:5,
                    from include/linux/arm_sdei.h:8,
                    from arch/arm64/kernel/asm-offsets.c:10:
   include/linux/seqlock.h:277:76: note: previous implicit declaration of 'mutex_unlock' with type 'void(struct mutex *)'
     277 | SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
         |                                                                            ^~~~~
   include/linux/seqlock.h:151:33: note: in definition of macro '__SEQ_LOCK'
     151 | #define __SEQ_LOCK(expr)        expr
         |                                 ^~~~
   include/linux/seqlock.h:277:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     277 | SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
         | ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:122: arch/arm64/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1284: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:226: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/cpu_relax +10 arch/arm64/include/asm/vdso/processor.h

f511e079177a9b Vincenzo Frascino 2020-03-20   9  
f511e079177a9b Vincenzo Frascino 2020-03-20 @10  static inline void cpu_relax(void)
f511e079177a9b Vincenzo Frascino 2020-03-20  11  {
f511e079177a9b Vincenzo Frascino 2020-03-20  12  	asm volatile("yield" ::: "memory");
f511e079177a9b Vincenzo Frascino 2020-03-20  13  }
f511e079177a9b Vincenzo Frascino 2020-03-20  14  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CB352C072
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbiERQ1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbiERQ1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:27:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8526A417
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652891237; x=1684427237;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lHfq2tpHvPA+3GLAp9TeHYhY5L2guooDUmfyt0Ba3og=;
  b=XbLcX8EnYnZNNLAUSP09vKMskWpFaB/drfgC2qnHpCmiLNQ0GLJCDB4+
   A3+zfpK/RwIMOH90Q8XahNBnVZQfZwq2qVUuCJXpq2h/2REneSA641Kd7
   8Q2A33liqoHc6Mv7j7MEnOFjHI0x4I/cLedSRILnS3ChhldhKWAzGhKPi
   5ITXF1fvAV84ITH7ti2SUFBigi9IyNGUews4j8xO8NwoahsQ/On1Xp5Ek
   8XH6EWZPKOrs/OTcoeqswBT9fCTqgI52n4wiUYG21zYJAjnvLByF0k/5K
   7BMczFjmm4WBygLr5IXsWZCEIqX5SmuWF04ws26cfpgKbtqcd+cOI8Ns7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="297052764"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="297052764"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 09:23:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="700681608"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 18 May 2022 09:23:40 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrMSZ-0002O9-Ld;
        Wed, 18 May 2022 16:23:39 +0000
Date:   Thu, 19 May 2022 00:23:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [frederic-dynticks:rcu/context-tracking-v3 14/21]
 include/linux/context_tracking_state.h:38:42: error: 'context_tracking'
 undeclared
Message-ID: <202205190029.DxLHyh95-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git rcu/context-tracking-v3
head:   339c667118c84314e759bb67eb0ebd8eb292eafb
commit: 7d7866ee3fc460499ec37f49666ada28e24d4cb4 [14/21] rcu/context_tracking: Move dynticks counter to context tracking
config: ia64-buildonly-randconfig-r003-20220518 (https://download.01.org/0day-ci/archive/20220519/202205190029.DxLHyh95-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git/commit/?id=7d7866ee3fc460499ec37f49666ada28e24d4cb4
        git remote add frederic-dynticks https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
        git fetch --no-tags frederic-dynticks rcu/context-tracking-v3
        git checkout 7d7866ee3fc460499ec37f49666ada28e24d4cb4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/acpi/ drivers/message/fusion/ kernel/rcu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/percpu.h:7,
                    from arch/ia64/include/asm/percpu.h:46,
                    from arch/ia64/include/asm/processor.h:76,
                    from arch/ia64/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/ia64/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from kernel/rcu/update.c:23:
   include/linux/context_tracking_state.h: In function 'ct_dynticks':
>> include/linux/context_tracking_state.h:38:42: error: 'context_tracking' undeclared (first use in this function)
      38 |         return atomic_read(this_cpu_ptr(&context_tracking.dynticks));
         |                                          ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
     252 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/context_tracking_state.h:38:28: note: in expansion of macro 'this_cpu_ptr'
      38 |         return atomic_read(this_cpu_ptr(&context_tracking.dynticks));
         |                            ^~~~~~~~~~~~
   include/linux/context_tracking_state.h:38:42: note: each undeclared identifier is reported only once for each function it appears in
      38 |         return atomic_read(this_cpu_ptr(&context_tracking.dynticks));
         |                                          ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
     252 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/context_tracking_state.h:38:28: note: in expansion of macro 'this_cpu_ptr'
      38 |         return atomic_read(this_cpu_ptr(&context_tracking.dynticks));
         |                            ^~~~~~~~~~~~
   include/linux/context_tracking_state.h: In function 'ct_dynticks_cpu':
   include/linux/context_tracking_state.h:43:52: error: 'context_tracking' undeclared (first use in this function)
      43 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                                    ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/context_tracking_state.h:43:39: note: in expansion of macro 'per_cpu_ptr'
      43 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                       ^~~~~~~~~~~
   include/linux/context_tracking_state.h: In function 'ct_dynticks_cpu_acquire':
   include/linux/context_tracking_state.h:49:52: error: 'context_tracking' undeclared (first use in this function)
      49 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                                    ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/context_tracking_state.h:49:39: note: in expansion of macro 'per_cpu_ptr'
      49 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                       ^~~~~~~~~~~
   In file included from arch/ia64/include/asm/pgtable.h:153,
                    from include/linux/pgtable.h:6,
                    from arch/ia64/include/asm/uaccess.h:40,
                    from include/linux/uaccess.h:11,
                    from arch/ia64/include/asm/sections.h:11,
                    from include/linux/interrupt.h:21,
                    from kernel/rcu/update.c:25:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                                ^~~~~~~
--
   In file included from include/asm-generic/percpu.h:7,
                    from arch/ia64/include/asm/percpu.h:46,
                    from arch/ia64/include/asm/processor.h:76,
                    from arch/ia64/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/ia64/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from kernel/rcu/tree.c:23:
   include/linux/context_tracking_state.h: In function 'ct_dynticks':
>> include/linux/context_tracking_state.h:38:42: error: 'context_tracking' undeclared (first use in this function)
      38 |         return atomic_read(this_cpu_ptr(&context_tracking.dynticks));
         |                                          ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
     252 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/context_tracking_state.h:38:28: note: in expansion of macro 'this_cpu_ptr'
      38 |         return atomic_read(this_cpu_ptr(&context_tracking.dynticks));
         |                            ^~~~~~~~~~~~
   include/linux/context_tracking_state.h:38:42: note: each undeclared identifier is reported only once for each function it appears in
      38 |         return atomic_read(this_cpu_ptr(&context_tracking.dynticks));
         |                                          ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
     252 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/context_tracking_state.h:38:28: note: in expansion of macro 'this_cpu_ptr'
      38 |         return atomic_read(this_cpu_ptr(&context_tracking.dynticks));
         |                            ^~~~~~~~~~~~
   include/linux/context_tracking_state.h: In function 'ct_dynticks_cpu':
   include/linux/context_tracking_state.h:43:52: error: 'context_tracking' undeclared (first use in this function)
      43 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                                    ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/context_tracking_state.h:43:39: note: in expansion of macro 'per_cpu_ptr'
      43 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                       ^~~~~~~~~~~
   include/linux/context_tracking_state.h: In function 'ct_dynticks_cpu_acquire':
   include/linux/context_tracking_state.h:49:52: error: 'context_tracking' undeclared (first use in this function)
      49 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                                    ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/context_tracking_state.h:49:39: note: in expansion of macro 'per_cpu_ptr'
      49 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                       ^~~~~~~~~~~
   In file included from arch/ia64/include/asm/pgtable.h:153,
                    from include/linux/pgtable.h:6,
                    from arch/ia64/include/asm/uaccess.h:40,
                    from include/linux/uaccess.h:11,
                    from arch/ia64/include/asm/sections.h:11,
                    from include/linux/interrupt.h:21,
                    from kernel/rcu/tree.c:26:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                                ^~~~~~~
   In file included from arch/ia64/include/asm/intrinsics.h:11,
                    from arch/ia64/include/asm/bitops.h:19,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from kernel/rcu/tree.c:21:
   kernel/rcu/tree.c: In function 'rcu_dynticks_inc':
>> kernel/rcu/tree.c:270:60: error: 'context_tracking' undeclared (first use in this function)
     270 |         return arch_atomic_add_return(incby, this_cpu_ptr(&context_tracking.dynticks));
         |                                                            ^~~~~~~~~~~~~~~~
   arch/ia64/include/uapi/asm/intrinsics.h:59:31: note: in definition of macro 'ia64_fetchadd'
      59 |         volatile __typeof__(*(v)) *_v = (v);                                            \
         |                               ^
   arch/ia64/include/asm/atomic.h:81:19: note: in expansion of macro 'ia64_fetch_and_add'
      81 |                 ? ia64_fetch_and_add(__ia64_aar_i, &(v)->counter)       \
         |                   ^~~~~~~~~~~~~~~~~~
   kernel/rcu/tree.c:270:16: note: in expansion of macro 'arch_atomic_add_return'
     270 |         return arch_atomic_add_return(incby, this_cpu_ptr(&context_tracking.dynticks));
         |                ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:241:9: note: in expansion of macro '__verify_pcpu_ptr'
     241 |         __verify_pcpu_ptr(ptr);                                         \
         |         ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
     252 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   kernel/rcu/tree.c:270:46: note: in expansion of macro 'this_cpu_ptr'
     270 |         return arch_atomic_add_return(incby, this_cpu_ptr(&context_tracking.dynticks));
         |                                              ^~~~~~~~~~~~
   In file included from <command-line>:
   kernel/rcu/tree.c: In function 'rcu_dynticks_curr_cpu_in_eqs':
   kernel/rcu/tree.c:338:49: error: 'context_tracking' undeclared (first use in this function)
     338 |         return !(arch_atomic_read(this_cpu_ptr(&context_tracking.dynticks)) & 0x1);
         |                                                 ^~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
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
   arch/ia64/include/asm/atomic.h:24:33: note: in expansion of macro 'READ_ONCE'
      24 | #define arch_atomic_read(v)     READ_ONCE((v)->counter)
         |                                 ^~~~~~~~~
   kernel/rcu/tree.c:338:18: note: in expansion of macro 'arch_atomic_read'
     338 |         return !(arch_atomic_read(this_cpu_ptr(&context_tracking.dynticks)) & 0x1);
         |                  ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:241:9: note: in expansion of macro '__verify_pcpu_ptr'
     241 |         __verify_pcpu_ptr(ptr);                                         \
         |         ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
     252 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   kernel/rcu/tree.c:338:35: note: in expansion of macro 'this_cpu_ptr'
     338 |         return !(arch_atomic_read(this_cpu_ptr(&context_tracking.dynticks)) & 0x1);
         |                                   ^~~~~~~~~~~~
   In file included from include/asm-generic/percpu.h:7,
                    from arch/ia64/include/asm/percpu.h:46,
                    from arch/ia64/include/asm/processor.h:76,
                    from arch/ia64/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/ia64/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from kernel/rcu/tree.c:23:
   kernel/rcu/tree.c: In function 'rcu_eqs_enter':
   kernel/rcu/tree.c:617:53: error: 'context_tracking' undeclared (first use in this function)
     617 |         struct context_tracking *ct = this_cpu_ptr(&context_tracking);
         |                                                     ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
     252 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   kernel/rcu/tree.c:617:39: note: in expansion of macro 'this_cpu_ptr'
     617 |         struct context_tracking *ct = this_cpu_ptr(&context_tracking);
         |                                       ^~~~~~~~~~~~
   kernel/rcu/tree.c: In function 'rcu_nmi_exit':
   kernel/rcu/tree.c:747:53: error: 'context_tracking' undeclared (first use in this function)
     747 |         struct context_tracking *ct = this_cpu_ptr(&context_tracking);
         |                                                     ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
     252 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   kernel/rcu/tree.c:747:39: note: in expansion of macro 'this_cpu_ptr'
     747 |         struct context_tracking *ct = this_cpu_ptr(&context_tracking);
         |                                       ^~~~~~~~~~~~
   kernel/rcu/tree.c: In function 'rcu_eqs_exit':
   kernel/rcu/tree.c:816:53: error: 'context_tracking' undeclared (first use in this function)
     816 |         struct context_tracking *ct = this_cpu_ptr(&context_tracking);
         |                                                     ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
     252 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
--
   In file included from arch/ia64/include/asm/pgtable.h:153,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:29,
                    from drivers/acpi/osl.c:17:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                                ^~~~~~~
   In file included from include/asm-generic/percpu.h:7,
                    from arch/ia64/include/asm/percpu.h:46,
                    from arch/ia64/include/asm/processor.h:76,
                    from arch/ia64/include/asm/timex.h:15,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/acpi/osl.c:14:
   include/linux/context_tracking_state.h: In function 'ct_dynticks':
>> include/linux/context_tracking_state.h:38:42: error: 'context_tracking' undeclared (first use in this function)
      38 |         return atomic_read(this_cpu_ptr(&context_tracking.dynticks));
         |                                          ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
     252 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/context_tracking_state.h:38:28: note: in expansion of macro 'this_cpu_ptr'
      38 |         return atomic_read(this_cpu_ptr(&context_tracking.dynticks));
         |                            ^~~~~~~~~~~~
   include/linux/context_tracking_state.h:38:42: note: each undeclared identifier is reported only once for each function it appears in
      38 |         return atomic_read(this_cpu_ptr(&context_tracking.dynticks));
         |                                          ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
     252 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/context_tracking_state.h:38:28: note: in expansion of macro 'this_cpu_ptr'
      38 |         return atomic_read(this_cpu_ptr(&context_tracking.dynticks));
         |                            ^~~~~~~~~~~~
   include/linux/context_tracking_state.h: In function 'ct_dynticks_cpu':
   include/linux/context_tracking_state.h:43:52: error: 'context_tracking' undeclared (first use in this function)
      43 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                                    ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/context_tracking_state.h:43:39: note: in expansion of macro 'per_cpu_ptr'
      43 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                       ^~~~~~~~~~~
   include/linux/context_tracking_state.h: In function 'ct_dynticks_cpu_acquire':
   include/linux/context_tracking_state.h:49:52: error: 'context_tracking' undeclared (first use in this function)
      49 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                                    ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/context_tracking_state.h:49:39: note: in expansion of macro 'per_cpu_ptr'
      49 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                       ^~~~~~~~~~~
   drivers/acpi/osl.c: In function 'acpi_os_vprintf':
   drivers/acpi/osl.c:157:9: warning: function 'acpi_os_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     157 |         vsprintf(buffer, fmt, args);
         |         ^~~~~~~~
..

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for CONTEXT_TRACKING_IDLE
   Depends on GENERIC_CLOCKEVENTS
   Selected by
   - TREE_RCU


vim +/context_tracking +38 include/linux/context_tracking_state.h

    34	
    35	#ifdef CONFIG_CONTEXT_TRACKING_IDLE
    36	static __always_inline int ct_dynticks(void)
    37	{
  > 38		return atomic_read(this_cpu_ptr(&context_tracking.dynticks));
    39	}
    40	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C10D52C217
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241364AbiERSST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241340AbiERSRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:17:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A091B1874
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652897870; x=1684433870;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2r7y7Fu1Xp9jtBioqmTmfuHEZQTbt4Ov+rYZjL774iM=;
  b=Q2noi/yZpbk9tX3L44IH0ukBXPVcY4qamP2ChqlP4KQp2yhGUOR6Ykhd
   iEjF9JLU6rZQh82DRviAZTMO5oomeU7raMfD7WqMCJoeMYyie5Liuhv85
   +qrUZMlp48gdmsfRNzQyUwAvXrdtXqzPkYDF8c/cna+zbcMYMr0k45IxT
   EbSzIw6rO3C9Mt7qWxAlLWxUR4aaiSz2CISg2XFbKjQJm8xkwEhOt7MCe
   Gr18PSY8A1kgGa2Ufcm1rvr4VKpuzMYPrg9JoCMNpK1SIllUyIZa/GLpm
   mbjxyiKK8F8UBUrs9VQBthW4wBHeoOmwGiC3iqTT4mV3x8N/YfCOjT1FA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="271953581"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="271953581"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 11:17:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="627184805"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 18 May 2022 11:17:44 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrOEx-0002Up-ES;
        Wed, 18 May 2022 18:17:43 +0000
Date:   Thu, 19 May 2022 02:17:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [frederic-dynticks:rcu/context-tracking-v3 21/21]
 include/linux/context_tracking_state.h:65:31: error: 'struct
 context_tracking' has no member named 'state'
Message-ID: <202205190245.6RG0y59i-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git rcu/context-tracking-v3
head:   339c667118c84314e759bb67eb0ebd8eb292eafb
commit: 339c667118c84314e759bb67eb0ebd8eb292eafb [21/21] rcu/context_tracking: Merge dynticks counter and context tracking states
config: ia64-buildonly-randconfig-r003-20220518 (https://download.01.org/0day-ci/archive/20220519/202205190245.6RG0y59i-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git/commit/?id=339c667118c84314e759bb67eb0ebd8eb292eafb
        git remote add frederic-dynticks https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
        git fetch --no-tags frederic-dynticks rcu/context-tracking-v3
        git checkout 339c667118c84314e759bb67eb0ebd8eb292eafb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/acpi/

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
                    from include/linux/smp.h:110,
                    from drivers/acpi/tables.c:14:
   include/linux/context_tracking_state.h: In function 'ct_dynticks':
   include/linux/context_tracking_state.h:59:42: error: 'context_tracking' undeclared (first use in this function)
      59 |         return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_DYNTICKS_MASK;
         |                                          ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
     252 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/context_tracking_state.h:59:28: note: in expansion of macro 'this_cpu_ptr'
      59 |         return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_DYNTICKS_MASK;
         |                            ^~~~~~~~~~~~
   include/linux/context_tracking_state.h:59:42: note: each undeclared identifier is reported only once for each function it appears in
      59 |         return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_DYNTICKS_MASK;
         |                                          ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
     252 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/context_tracking_state.h:59:28: note: in expansion of macro 'this_cpu_ptr'
      59 |         return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_DYNTICKS_MASK;
         |                            ^~~~~~~~~~~~
   include/linux/context_tracking_state.h: In function 'ct_dynticks_cpu':
   include/linux/context_tracking_state.h:64:52: error: 'context_tracking' undeclared (first use in this function)
      64 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                                    ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/context_tracking_state.h:64:39: note: in expansion of macro 'per_cpu_ptr'
      64 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                       ^~~~~~~~~~~
   In file included from include/linux/hardirq.h:5,
                    from include/linux/interrupt.h:11,
                    from arch/ia64/include/asm/hw_irq.h:10,
                    from include/linux/irq.h:592,
                    from drivers/acpi/tables.c:17:
>> include/linux/context_tracking_state.h:65:31: error: 'struct context_tracking' has no member named 'state'
      65 |         return atomic_read(&ct->state) & CT_DYNTICKS_MASK;
         |                               ^~
   In file included from include/asm-generic/percpu.h:7,
                    from arch/ia64/include/asm/percpu.h:46,
                    from arch/ia64/include/asm/processor.h:76,
                    from arch/ia64/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/ia64/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/smp.h:110,
                    from drivers/acpi/tables.c:14:
   include/linux/context_tracking_state.h: In function 'ct_dynticks_cpu_acquire':
   include/linux/context_tracking_state.h:70:52: error: 'context_tracking' undeclared (first use in this function)
      70 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                                    ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/context_tracking_state.h:70:39: note: in expansion of macro 'per_cpu_ptr'
      70 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                       ^~~~~~~~~~~
   In file included from include/linux/hardirq.h:5,
                    from include/linux/interrupt.h:11,
                    from arch/ia64/include/asm/hw_irq.h:10,
                    from include/linux/irq.h:592,
                    from drivers/acpi/tables.c:17:
   include/linux/context_tracking_state.h:71:39: error: 'struct context_tracking' has no member named 'state'
      71 |         return atomic_read_acquire(&ct->state) & CT_DYNTICKS_MASK;
         |                                       ^~
   In file included from include/asm-generic/percpu.h:7,
                    from arch/ia64/include/asm/percpu.h:46,
                    from arch/ia64/include/asm/processor.h:76,
                    from arch/ia64/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/ia64/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/smp.h:110,
                    from drivers/acpi/tables.c:14:
   include/linux/context_tracking_state.h: In function 'ct_dynticks_nesting':
   include/linux/context_tracking_state.h:76:32: error: 'context_tracking' undeclared (first use in this function)
      76 |         return __this_cpu_read(context_tracking.dynticks_nesting);
         |                                ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   include/linux/context_tracking_state.h:76:16: note: in expansion of macro '__this_cpu_read'
      76 |         return __this_cpu_read(context_tracking.dynticks_nesting);
         |                ^~~~~~~~~~~~~~~
   include/linux/context_tracking_state.h: In function 'ct_dynticks_nesting_cpu':
   include/linux/context_tracking_state.h:81:52: error: 'context_tracking' undeclared (first use in this function)
      81 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                                    ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/context_tracking_state.h:81:39: note: in expansion of macro 'per_cpu_ptr'
      81 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                       ^~~~~~~~~~~
   include/linux/context_tracking_state.h: In function 'ct_dynticks_nmi_nesting':
   include/linux/context_tracking_state.h:87:32: error: 'context_tracking' undeclared (first use in this function)
      87 |         return __this_cpu_read(context_tracking.dynticks_nmi_nesting);
         |                                ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   include/linux/context_tracking_state.h:87:16: note: in expansion of macro '__this_cpu_read'
      87 |         return __this_cpu_read(context_tracking.dynticks_nmi_nesting);
         |                ^~~~~~~~~~~~~~~
   include/linux/context_tracking_state.h: In function 'ct_dynticks_nmi_nesting_cpu':
   include/linux/context_tracking_state.h:92:52: error: 'context_tracking' undeclared (first use in this function)
      92 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                                    ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/context_tracking_state.h:92:39: note: in expansion of macro 'per_cpu_ptr'
      92 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                       ^~~~~~~~~~~
   In file included from arch/ia64/include/asm/pgtable.h:153,
                    from include/linux/pgtable.h:6,
                    from arch/ia64/include/asm/uaccess.h:40,
                    from include/linux/uaccess.h:11,
                    from arch/ia64/include/asm/sections.h:11,
                    from include/linux/interrupt.h:21,
                    from arch/ia64/include/asm/hw_irq.h:10,
                    from include/linux/irq.h:592,
                    from drivers/acpi/tables.c:17:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                                ^~~~~~~
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
   include/linux/context_tracking_state.h:59:42: error: 'context_tracking' undeclared (first use in this function)
      59 |         return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_DYNTICKS_MASK;
         |                                          ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
     252 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/context_tracking_state.h:59:28: note: in expansion of macro 'this_cpu_ptr'
      59 |         return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_DYNTICKS_MASK;
         |                            ^~~~~~~~~~~~
   include/linux/context_tracking_state.h:59:42: note: each undeclared identifier is reported only once for each function it appears in
      59 |         return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_DYNTICKS_MASK;
         |                                          ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
     252 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/context_tracking_state.h:59:28: note: in expansion of macro 'this_cpu_ptr'
      59 |         return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_DYNTICKS_MASK;
         |                            ^~~~~~~~~~~~
   include/linux/context_tracking_state.h: In function 'ct_dynticks_cpu':
   include/linux/context_tracking_state.h:64:52: error: 'context_tracking' undeclared (first use in this function)
      64 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                                    ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/context_tracking_state.h:64:39: note: in expansion of macro 'per_cpu_ptr'
      64 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                       ^~~~~~~~~~~
   In file included from include/linux/hardirq.h:5,
                    from include/linux/highmem.h:11,
                    from drivers/acpi/osl.c:18:
>> include/linux/context_tracking_state.h:65:31: error: 'struct context_tracking' has no member named 'state'
      65 |         return atomic_read(&ct->state) & CT_DYNTICKS_MASK;
         |                               ^~
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
   include/linux/context_tracking_state.h: In function 'ct_dynticks_cpu_acquire':
   include/linux/context_tracking_state.h:70:52: error: 'context_tracking' undeclared (first use in this function)
      70 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                                    ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/context_tracking_state.h:70:39: note: in expansion of macro 'per_cpu_ptr'
      70 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                       ^~~~~~~~~~~
   In file included from include/linux/hardirq.h:5,
                    from include/linux/highmem.h:11,
                    from drivers/acpi/osl.c:18:
   include/linux/context_tracking_state.h:71:39: error: 'struct context_tracking' has no member named 'state'
      71 |         return atomic_read_acquire(&ct->state) & CT_DYNTICKS_MASK;
         |                                       ^~
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
   include/linux/context_tracking_state.h: In function 'ct_dynticks_nesting':
   include/linux/context_tracking_state.h:76:32: error: 'context_tracking' undeclared (first use in this function)
      76 |         return __this_cpu_read(context_tracking.dynticks_nesting);
         |                                ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   include/linux/context_tracking_state.h:76:16: note: in expansion of macro '__this_cpu_read'
      76 |         return __this_cpu_read(context_tracking.dynticks_nesting);
         |                ^~~~~~~~~~~~~~~
   include/linux/context_tracking_state.h: In function 'ct_dynticks_nesting_cpu':
   include/linux/context_tracking_state.h:81:52: error: 'context_tracking' undeclared (first use in this function)
      81 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                                    ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/context_tracking_state.h:81:39: note: in expansion of macro 'per_cpu_ptr'
      81 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                       ^~~~~~~~~~~
   include/linux/context_tracking_state.h: In function 'ct_dynticks_nmi_nesting':
   include/linux/context_tracking_state.h:87:32: error: 'context_tracking' undeclared (first use in this function)
      87 |         return __this_cpu_read(context_tracking.dynticks_nmi_nesting);
         |                                ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   include/linux/context_tracking_state.h:87:16: note: in expansion of macro '__this_cpu_read'
      87 |         return __this_cpu_read(context_tracking.dynticks_nmi_nesting);
         |                ^~~~~~~~~~~~~~~
   include/linux/context_tracking_state.h: In function 'ct_dynticks_nmi_nesting_cpu':
   include/linux/context_tracking_state.h:92:52: error: 'context_tracking' undeclared (first use in this function)
      92 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                                    ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/context_tracking_state.h:92:39: note: in expansion of macro 'per_cpu_ptr'
      92 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                       ^~~~~~~~~~~
   drivers/acpi/osl.c: In function 'acpi_os_vprintf':
   drivers/acpi/osl.c:157:9: warning: function 'acpi_os_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     157 |         vsprintf(buffer, fmt, args);
         |         ^~~~~~~~
--
   In file included from arch/ia64/include/asm/pgtable.h:153,
                    from include/linux/pgtable.h:6,
                    from arch/ia64/include/asm/uaccess.h:40,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/cgroup.h:17,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from drivers/acpi/device_pm.c:21:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                                ^~~~~~~
   In file included from include/asm-generic/percpu.h:7,
                    from arch/ia64/include/asm/percpu.h:46,
                    from arch/ia64/include/asm/processor.h:76,
                    from arch/ia64/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/ia64/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/smp.h:110,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/acpi/device_pm.c:15:
   include/linux/context_tracking_state.h: In function 'ct_dynticks':
   include/linux/context_tracking_state.h:59:42: error: 'context_tracking' undeclared (first use in this function)
      59 |         return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_DYNTICKS_MASK;
         |                                          ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
     252 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/context_tracking_state.h:59:28: note: in expansion of macro 'this_cpu_ptr'
      59 |         return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_DYNTICKS_MASK;
         |                            ^~~~~~~~~~~~
   include/linux/context_tracking_state.h:59:42: note: each undeclared identifier is reported only once for each function it appears in
      59 |         return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_DYNTICKS_MASK;
         |                                          ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/percpu-defs.h:252:27: note: in expansion of macro 'raw_cpu_ptr'
     252 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
         |                           ^~~~~~~~~~~
   include/linux/context_tracking_state.h:59:28: note: in expansion of macro 'this_cpu_ptr'
      59 |         return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_DYNTICKS_MASK;
         |                            ^~~~~~~~~~~~
   include/linux/context_tracking_state.h: In function 'ct_dynticks_cpu':
   include/linux/context_tracking_state.h:64:52: error: 'context_tracking' undeclared (first use in this function)
      64 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                                    ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/context_tracking_state.h:64:39: note: in expansion of macro 'per_cpu_ptr'
      64 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                       ^~~~~~~~~~~
   In file included from include/linux/hardirq.h:5,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from drivers/acpi/device_pm.c:21:
>> include/linux/context_tracking_state.h:65:31: error: 'struct context_tracking' has no member named 'state'
      65 |         return atomic_read(&ct->state) & CT_DYNTICKS_MASK;
         |                               ^~
   In file included from include/asm-generic/percpu.h:7,
                    from arch/ia64/include/asm/percpu.h:46,
                    from arch/ia64/include/asm/processor.h:76,
                    from arch/ia64/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/ia64/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/smp.h:110,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/acpi/device_pm.c:15:
   include/linux/context_tracking_state.h: In function 'ct_dynticks_cpu_acquire':
   include/linux/context_tracking_state.h:70:52: error: 'context_tracking' undeclared (first use in this function)
      70 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                                    ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/context_tracking_state.h:70:39: note: in expansion of macro 'per_cpu_ptr'
      70 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                       ^~~~~~~~~~~
   In file included from include/linux/hardirq.h:5,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from drivers/acpi/device_pm.c:21:
   include/linux/context_tracking_state.h:71:39: error: 'struct context_tracking' has no member named 'state'
      71 |         return atomic_read_acquire(&ct->state) & CT_DYNTICKS_MASK;
         |                                       ^~
   In file included from include/asm-generic/percpu.h:7,
                    from arch/ia64/include/asm/percpu.h:46,
                    from arch/ia64/include/asm/processor.h:76,
                    from arch/ia64/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/ia64/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/smp.h:110,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/acpi/device_pm.c:15:
   include/linux/context_tracking_state.h: In function 'ct_dynticks_nesting':
   include/linux/context_tracking_state.h:76:32: error: 'context_tracking' undeclared (first use in this function)
      76 |         return __this_cpu_read(context_tracking.dynticks_nesting);
         |                                ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   include/linux/context_tracking_state.h:76:16: note: in expansion of macro '__this_cpu_read'
      76 |         return __this_cpu_read(context_tracking.dynticks_nesting);
         |                ^~~~~~~~~~~~~~~
   include/linux/context_tracking_state.h: In function 'ct_dynticks_nesting_cpu':
   include/linux/context_tracking_state.h:81:52: error: 'context_tracking' undeclared (first use in this function)
      81 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                                    ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/context_tracking_state.h:81:39: note: in expansion of macro 'per_cpu_ptr'
      81 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                       ^~~~~~~~~~~
   include/linux/context_tracking_state.h: In function 'ct_dynticks_nmi_nesting':
   include/linux/context_tracking_state.h:87:32: error: 'context_tracking' undeclared (first use in this function)
      87 |         return __this_cpu_read(context_tracking.dynticks_nmi_nesting);
         |                                ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   include/linux/context_tracking_state.h:87:16: note: in expansion of macro '__this_cpu_read'
      87 |         return __this_cpu_read(context_tracking.dynticks_nmi_nesting);
         |                ^~~~~~~~~~~~~~~
   include/linux/context_tracking_state.h: In function 'ct_dynticks_nmi_nesting_cpu':
   include/linux/context_tracking_state.h:92:52: error: 'context_tracking' undeclared (first use in this function)
      92 |         struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
         |                                                    ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
..

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for CONTEXT_TRACKING_IDLE
   Depends on GENERIC_CLOCKEVENTS
   Selected by
   - TREE_RCU


vim +65 include/linux/context_tracking_state.h

    61	
    62	static __always_inline int ct_dynticks_cpu(int cpu)
    63	{
    64		struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
  > 65		return atomic_read(&ct->state) & CT_DYNTICKS_MASK;
    66	}
    67	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

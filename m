Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27354883F7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 15:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbiAHO27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 09:28:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:45306 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbiAHO26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 09:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641652138; x=1673188138;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=z2dy1qLzxOD3uuker7FSPcMBNnSn8/cnfAFzTkY5vXw=;
  b=ltPNw5U2IeCyACiekwISGb/A1eRkjM2uKO8RonbGAY9Pi/wZPJQWx/mL
   dsgVioaRaZjrYf0C0fQ1tNh7yqgSKh80Z9rmwu8mfxsVIcybNGQYPoJK1
   sqFQ4Y5rSZgouGLL8Vun9l386846r+hB6Hl1x8ue27AWBxr4x8s3WmrDy
   FmBgdHg7UL7cih0OYBKWyAQgg+mwWk2fGVJe/yTBvXSUFViWrf1K1QKQq
   2nVoPNFtTamaXUMNVs2odfNoFtEPvJi7vY+UdC9ESYiI89FjTcwTd10ia
   IkINcuGUnSp7c0EKFgG5vANxx6qouvO6IfBFh5Jhe7potT2wb4K8EYWjQ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="240567511"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="240567511"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 06:28:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="514153584"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2022 06:28:56 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6CiF-0000gk-Fh; Sat, 08 Jan 2022 14:28:55 +0000
Date:   Sat, 8 Jan 2022 22:28:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 631/2375]
 arch/powerpc/include/asm/page_32.h:48:9: error: implicit declaration of
 function 'WARN_ON'
Message-ID: <202201082245.1MS3SHJh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   351ceeab2ef96ab2fc306934ddb201b44636181b
commit: a657aeec64a85023d6fe6be475a83661c6abb5b8 [631/2375] headers/deps: Add header dependencies to .h files: <linux/atomic_api.h>
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220108/202201082245.1MS3SHJh-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=a657aeec64a85023d6fe6be475a83661c6abb5b8
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout a657aeec64a85023d6fe6be475a83661c6abb5b8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the mingo-tip/sched/headers HEAD 351ceeab2ef96ab2fc306934ddb201b44636181b builds fine.
      It only hurts bisectability.

All error/warnings (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/page.h:249,
                    from arch/powerpc/include/asm/thread_info.h:13,
                    from include/linux/thread_info.h:61,
                    from arch/powerpc/include/asm/ptrace.h:323,
                    from arch/powerpc/include/asm/hw_irq.h:12,
                    from arch/powerpc/include/asm/irqflags.h:12,
                    from include/linux/irqflags.h:16,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/powerpc/include/asm/cmpxchg.h:526,
                    from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:7,
                    from include/linux/atomic_api.h:1,
                    from include/linux/jump_label.h:76,
                    from include/linux/dynamic_debug.h:6,
                    from include/linux/printk.h:559,
                    from include/asm-generic/bug.h:22,
                    from arch/powerpc/include/asm/bug.h:149,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   arch/powerpc/include/asm/page_32.h: In function 'clear_page':
>> arch/powerpc/include/asm/page_32.h:48:9: error: implicit declaration of function 'WARN_ON' [-Werror=implicit-function-declaration]
      48 |         WARN_ON((unsigned long)addr & (L1_CACHE_BYTES - 1));
         |         ^~~~~~~
   In file included from arch/powerpc/include/asm/hw_breakpoint.h:12,
                    from arch/powerpc/include/asm/processor.h:43,
                    from arch/powerpc/include/asm/thread_info.h:40,
                    from include/linux/thread_info.h:61,
                    from arch/powerpc/include/asm/ptrace.h:323,
                    from arch/powerpc/include/asm/hw_irq.h:12,
                    from arch/powerpc/include/asm/irqflags.h:12,
                    from include/linux/irqflags.h:16,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/powerpc/include/asm/cmpxchg.h:526,
                    from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:7,
                    from include/linux/atomic_api.h:1,
                    from include/linux/jump_label.h:76,
                    from include/linux/dynamic_debug.h:6,
                    from include/linux/printk.h:559,
                    from include/asm-generic/bug.h:22,
                    from arch/powerpc/include/asm/bug.h:149,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   arch/powerpc/include/asm/cpu_has_feature.h: At top level:
>> arch/powerpc/include/asm/cpu_has_feature.h:21:31: error: array type has incomplete element type 'struct static_key_true'
      21 | extern struct static_key_true cpu_feature_keys[NUM_CPU_FTR_KEYS];
         |                               ^~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/cpu_has_feature.h: In function 'cpu_has_feature':
>> arch/powerpc/include/asm/cpu_has_feature.h:32:14: error: 'static_key_initialized' undeclared (first use in this function)
      32 |         if (!static_key_initialized) {
         |              ^~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/cpu_has_feature.h:32:14: note: each undeclared identifier is reported only once for each function it appears in
>> arch/powerpc/include/asm/cpu_has_feature.h:46:16: error: implicit declaration of function 'static_branch_likely' [-Werror=implicit-function-declaration]
      46 |         return static_branch_likely(&cpu_feature_keys[i]);
         |                ^~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/include/asm/cpu_has_feature.h:25:13: warning: variable 'i' set but not used [-Wunused-but-set-variable]
      25 |         int i;
         |             ^
   In file included from arch/powerpc/include/asm/ptrace.h:323,
                    from arch/powerpc/include/asm/hw_irq.h:12,
                    from arch/powerpc/include/asm/irqflags.h:12,
                    from include/linux/irqflags.h:16,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/powerpc/include/asm/cmpxchg.h:526,
                    from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:7,
                    from include/linux/atomic_api.h:1,
                    from include/linux/jump_label.h:76,
                    from include/linux/dynamic_debug.h:6,
                    from include/linux/printk.h:559,
                    from include/asm-generic/bug.h:22,
                    from arch/powerpc/include/asm/bug.h:149,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   arch/powerpc/include/asm/thread_info.h: In function 'clear_thread_local_flags':
>> include/linux/thread_info.h:26:32: error: implicit declaration of function 'task_thread_info'; did you mean 'current_thread_info'? [-Werror=implicit-function-declaration]
      26 | # define current_thread_info() task_thread_info(current)
         |                                ^~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/thread_info.h:159:34: note: in expansion of macro 'current_thread_info'
     159 |         struct thread_info *ti = current_thread_info();
         |                                  ^~~~~~~~~~~~~~~~~~~
>> include/linux/thread_info.h:26:32: warning: initialization of 'struct thread_info *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      26 | # define current_thread_info() task_thread_info(current)
         |                                ^~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/thread_info.h:159:34: note: in expansion of macro 'current_thread_info'
     159 |         struct thread_info *ti = current_thread_info();
         |                                  ^~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/thread_info.h: In function 'test_thread_local_flags':
>> include/linux/thread_info.h:26:32: warning: initialization of 'struct thread_info *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      26 | # define current_thread_info() task_thread_info(current)
         |                                ^~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/thread_info.h:165:34: note: in expansion of macro 'current_thread_info'
     165 |         struct thread_info *ti = current_thread_info();
         |                                  ^~~~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/ptrace.h:323,
                    from arch/powerpc/include/asm/hw_irq.h:12,
                    from arch/powerpc/include/asm/irqflags.h:12,
                    from include/linux/irqflags.h:16,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/powerpc/include/asm/cmpxchg.h:526,
                    from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:7,
                    from include/linux/atomic_api.h:1,
                    from include/linux/jump_label.h:76,
                    from include/linux/dynamic_debug.h:6,
                    from include/linux/printk.h:559,
                    from include/asm-generic/bug.h:22,
                    from arch/powerpc/include/asm/bug.h:149,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/thread_info.h: In function 'copy_overflow':
   include/linux/thread_info.h:105:9: error: implicit declaration of function 'WARN' [-Werror=implicit-function-declaration]
     105 |         WARN(1, "Buffer overflow detected (%d < %lu)!\n", size, count);
         |         ^~~~
   include/linux/thread_info.h: In function 'check_copy_size':
   include/linux/thread_info.h:121:13: error: implicit declaration of function 'WARN_ON_ONCE' [-Werror=implicit-function-declaration]
     121 |         if (WARN_ON_ONCE(bytes > INT_MAX))
         |             ^~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:121: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1197: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/WARN_ON +48 arch/powerpc/include/asm/page_32.h

7ab0b7cb8951d4 arch/powerpc/include/asm/page_32.h Christophe Leroy 2019-08-16  38  
5736f96d12dd42 arch/powerpc/include/asm/page_32.h Christophe Leroy 2016-02-09  39  /*
5736f96d12dd42 arch/powerpc/include/asm/page_32.h Christophe Leroy 2016-02-09  40   * Clear page using the dcbz instruction, which doesn't cause any
5736f96d12dd42 arch/powerpc/include/asm/page_32.h Christophe Leroy 2016-02-09  41   * memory traffic (except to write out any cache lines which get
5736f96d12dd42 arch/powerpc/include/asm/page_32.h Christophe Leroy 2016-02-09  42   * displaced).  This only works on cacheable memory.
5736f96d12dd42 arch/powerpc/include/asm/page_32.h Christophe Leroy 2016-02-09  43   */
5736f96d12dd42 arch/powerpc/include/asm/page_32.h Christophe Leroy 2016-02-09  44  static inline void clear_page(void *addr)
5736f96d12dd42 arch/powerpc/include/asm/page_32.h Christophe Leroy 2016-02-09  45  {
5736f96d12dd42 arch/powerpc/include/asm/page_32.h Christophe Leroy 2016-02-09  46  	unsigned int i;
5736f96d12dd42 arch/powerpc/include/asm/page_32.h Christophe Leroy 2016-02-09  47  
7ab0b7cb8951d4 arch/powerpc/include/asm/page_32.h Christophe Leroy 2019-08-16 @48  	WARN_ON((unsigned long)addr & (L1_CACHE_BYTES - 1));
7ab0b7cb8951d4 arch/powerpc/include/asm/page_32.h Christophe Leroy 2019-08-16  49  
5736f96d12dd42 arch/powerpc/include/asm/page_32.h Christophe Leroy 2016-02-09  50  	for (i = 0; i < PAGE_SIZE / L1_CACHE_BYTES; i++, addr += L1_CACHE_BYTES)
5736f96d12dd42 arch/powerpc/include/asm/page_32.h Christophe Leroy 2016-02-09  51  		dcbz(addr);
5736f96d12dd42 arch/powerpc/include/asm/page_32.h Christophe Leroy 2016-02-09  52  }
5cd16ee934eafc include/asm-powerpc/page_32.h      Michael Ellerman 2005-11-11  53  extern void copy_page(void *to, void *from);
5cd16ee934eafc include/asm-powerpc/page_32.h      Michael Ellerman 2005-11-11  54  

:::::: The code at line 48 was first introduced by commit
:::::: 7ab0b7cb8951d4095d73e203759b74d41916e455 powerpc/32: Add warning on misaligned copy_page() or clear_page()

:::::: TO: Christophe Leroy <christophe.leroy@c-s.fr>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

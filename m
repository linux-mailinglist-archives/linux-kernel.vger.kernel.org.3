Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006BA53BD65
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 19:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbiFBRis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 13:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbiFBRiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 13:38:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7351DA67
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 10:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654191523; x=1685727523;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Sx7pJKJK+8ZvX4NUbjoGOV/rFy4fRP5nYx6Sj2GY2Ks=;
  b=DYvEWMWkfuZwl9zZnHNO8FaHE74nbRM7uxrCfOIiGETMjHznSfGhDNZE
   HEDE7mw3rR3bIQafSkgZRv9pBvskanEEXVjVqtFkqyUlSYCyjuWjyY3XQ
   Wtc22kzk47GomYEVOmoEbZH70dzqiYbe3qTFcmvMK9wMq9O+rlFlWMPya
   iunK+mqSmjTuAw129ujfvxNPQz5oo2PnZcJad33F8Ux7Mh4TULNxk8Rbm
   /EZnId7LIl/HonS4QB4V+AEpEphPMip5wqKD2S1z8c6rTC5kl5BBLs90w
   KcxWDqWExNAMishk+swYXsFENygNyDLvmjwROP5E4KMP6Xjp54SPPXvOr
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="362396173"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="362396173"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 10:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="530669279"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Jun 2022 10:38:38 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwomL-0005JX-MR;
        Thu, 02 Jun 2022 17:38:37 +0000
Date:   Fri, 3 Jun 2022 01:37:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 25/31]
 arch/powerpc/include/asm/page.h:133:9: error: call to undeclared function
 '__pa'; ISO C99 and later do not support implicit function declarations
Message-ID: <202206030117.4GtJSfhU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   8e0ac1b6b44d1c62420ad92b2a1cbc106a00f3de
commit: 6da25c8665cdbd78da52911a850f1619b42bc82c [25/31] powerpc: Make virt_to_pfn() a static inline
config: powerpc64-randconfig-r005-20220602 (https://download.01.org/0day-ci/archive/20220603/202206030117.4GtJSfhU-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b364c76683f8ef241025a9556300778c07b590c2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc64 cross compiling tool for clang build
        # apt-get install binutils-powerpc64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=6da25c8665cdbd78da52911a850f1619b42bc82c
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout 6da25c8665cdbd78da52911a850f1619b42bc82c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:14:
   In file included from include/linux/sem.h:5:
   In file included from include/uapi/linux/sem.h:5:
   In file included from include/linux/ipc.h:5:
   In file included from include/linux/spinlock.h:55:
   In file included from include/linux/preempt.h:78:
   In file included from ./arch/powerpc/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:23:
   In file included from arch/powerpc/include/asm/current.h:13:
   In file included from arch/powerpc/include/asm/paca.h:17:
   In file included from arch/powerpc/include/asm/lppaca.h:46:
   In file included from arch/powerpc/include/asm/mmu.h:149:
>> arch/powerpc/include/asm/page.h:133:9: error: call to undeclared function '__pa'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return __pa(kaddr) >> PAGE_SHIFT;
                  ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:97:11: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                           ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:97:25: warning: array index 2 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                                         ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:4: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
                           set->sig[1] | set->sig[0]) == 0;
                           ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:100:11: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return (set->sig[1] | set->sig[0]) == 0;
                           ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:113:11: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                            ^         ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:113:27: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                                            ^         ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:5: warning: array index 2 is past the end of the array (which contains 1 element) [-Warray-bounds]
                           (set1->sig[2] == set2->sig[2]) &&
                            ^         ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:21: warning: array index 2 is past the end of the array (which contains 1 element) [-Warray-bounds]
                           (set1->sig[2] == set2->sig[2]) &&
                                            ^         ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
--
           case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
                               ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   include/linux/compat.h:424:10: warning: array index 7 is past the end of the array (which contains 2 elements) [-Warray-bounds]
           case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
                   ^     ~
   include/linux/compat.h:131:2: note: array 'sig' declared here
           compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
           ^
   include/linux/compat.h:424:42: warning: array index 6 is past the end of the array (which contains 2 elements) [-Warray-bounds]
           case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
                                                   ^     ~
   include/linux/compat.h:131:2: note: array 'sig' declared here
           compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
           ^
   include/linux/compat.h:424:53: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
           case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
                                                              ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   include/linux/compat.h:426:22: warning: array index 2 is past the end of the array (which contains 1 element) [-Warray-bounds]
           case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
                               ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   include/linux/compat.h:426:10: warning: array index 5 is past the end of the array (which contains 2 elements) [-Warray-bounds]
           case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
                   ^     ~
   include/linux/compat.h:131:2: note: array 'sig' declared here
           compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
           ^
   include/linux/compat.h:426:42: warning: array index 4 is past the end of the array (which contains 2 elements) [-Warray-bounds]
           case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
                                                   ^     ~
   include/linux/compat.h:131:2: note: array 'sig' declared here
           compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
           ^
   include/linux/compat.h:426:53: warning: array index 2 is past the end of the array (which contains 1 element) [-Warray-bounds]
           case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
                                                              ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   include/linux/compat.h:428:22: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
           case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
                               ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   include/linux/compat.h:428:10: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
           case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
                   ^     ~
   include/linux/compat.h:131:2: note: array 'sig' declared here
           compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
           ^
   include/linux/compat.h:428:42: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
           case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
                                                   ^     ~
   include/linux/compat.h:131:2: note: array 'sig' declared here
           compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
           ^
   include/linux/compat.h:428:53: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
           case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
                                                              ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:19:
   include/linux/mman.h:157:9: warning: division by zero is undefined [-Wdivision-by-zero]
                  _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mman.h:136:21: note: expanded from macro '_calc_vm_trans'
      : ((x) & (bit1)) / ((bit1) / (bit2))))
                       ^ ~~~~~~~~~~~~~~~~~
   include/linux/mman.h:158:9: warning: division by zero is undefined [-Wdivision-by-zero]
                  _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mman.h:136:21: note: expanded from macro '_calc_vm_trans'
      : ((x) & (bit1)) / ((bit1) / (bit2))))
                       ^ ~~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
>> arch/powerpc/include/asm/io.h:930:63: error: passing 'volatile void *' to parameter of type 'const void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           WARN_ON(IS_ENABLED(CONFIG_DEBUG_VIRTUAL) && !virt_addr_valid(address));
                                                                        ^~~~~~~
   arch/powerpc/include/asm/page.h:138:54: note: expanded from macro 'virt_addr_valid'
   #define virt_addr_valid(kaddr)  pfn_valid(virt_to_pfn(kaddr))
                                                         ^~~~~
   include/asm-generic/bug.h:166:25: note: expanded from macro 'WARN_ON'
           int __ret_warn_on = !!(condition);                              \
                                  ^~~~~~~~~
   arch/powerpc/include/asm/page.h:131:53: note: passing argument to parameter 'kaddr' here
   static inline unsigned long virt_to_pfn(const void *kaddr)
                                                       ^
   63 warnings and 2 errors generated.
   make[2]: *** [scripts/Makefile.build:120: arch/powerpc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/__pa +133 arch/powerpc/include/asm/page.h

   130	
   131	static inline unsigned long virt_to_pfn(const void *kaddr)
   132	{
 > 133		return __pa(kaddr) >> PAGE_SHIFT;
   134	}
   135	#define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
   136	#define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
   137	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

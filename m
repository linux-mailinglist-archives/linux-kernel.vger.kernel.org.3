Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3410F480DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 23:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbhL1W3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 17:29:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:42199 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237500AbhL1W33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 17:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640730569; x=1672266569;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DRuhd65hyW+WPKRnPyeJK3oIE08As/+pnjnoGGE9/cU=;
  b=Djf9hYPcp+lQlIFBEdK3dn/ffwWZS67GS6TYti4WNyPRG1XmD3p4fjVr
   Ql1zfmyg+SpdF2q06oBSDmzBuxrH97aaFM/faciX5RGcoPg0lwyJlHlLC
   rP8tgiCxHlIu5fifLjg0LCysSfJTtUDb5BGfJ7jBzenH8z8DT/VmsIUPc
   e1lZTPNCZ1Zh/D45w2j5Ut6eR4lzVvlTWy1K8JFSLdt2DI4eAQ+EFnHd6
   CsdWd1Ao1YqyX48hMgUY/d9NOGIT08nB4IjD21tSvQNCZ7UmjxF8jcLw/
   /+89o/y61NFLoimWP6TwofuuVeZFjLEhCEMq8MuVwKD588tp1sqLjFU2u
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="327755929"
X-IronPort-AV: E=Sophos;i="5.88,243,1635231600"; 
   d="scan'208";a="327755929"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 14:29:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,243,1635231600"; 
   d="scan'208";a="523779452"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 28 Dec 2021 14:29:27 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2KyE-00085b-Lz; Tue, 28 Dec 2021 22:29:26 +0000
Date:   Wed, 29 Dec 2021 06:28:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [csky-linux:riscv_compat_v2 17/17] arch/riscv/mm/kasan_init.c:20:2:
 error: call to __compiletime_assert_313 declared with 'error' attribute:
 BUILD_BUG_ON failed: KASAN_SHADOW_OFFSET != KASAN_SHADOW_END - (1UL << (64 -
 KASAN_SHADOW_SCALE_SHIFT))
Message-ID: <202112290641.BEJik8MB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v2
head:   750f87086bdd630f80b9bc3581bc3f329ef20f53
commit: 750f87086bdd630f80b9bc3581bc3f329ef20f53 [17/17] riscv: compat: Add COMPAT Kbuild skeletal support
config: riscv-buildonly-randconfig-r005-20211228 (https://download.01.org/0day-ci/archive/20211229/202112290641.BEJik8MB-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7171af744543433ac75b232eb7dfdaef7efd4d7a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/c-sky/csky-linux/commit/750f87086bdd630f80b9bc3581bc3f329ef20f53
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v2
        git checkout 750f87086bdd630f80b9bc3581bc3f329ef20f53
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/riscv/mm/kasan_init.c:20:2: error: call to __compiletime_assert_313 declared with 'error' attribute: BUILD_BUG_ON failed: KASAN_SHADOW_OFFSET != KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT))
           BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=
           ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
           BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
           ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:335:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:323:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:316:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:7:1: note: expanded from here
   __compiletime_assert_313
   ^
   1 error generated.


vim +/error +20 arch/riscv/mm/kasan_init.c

e178d670f251b6 Nylon Chen      2021-01-16  13  
8ad8b72721d0f0 Nick Hu         2020-01-06  14  extern pgd_t early_pg_dir[PTRS_PER_PGD];
8ad8b72721d0f0 Nick Hu         2020-01-06  15  asmlinkage void __init kasan_early_init(void)
8ad8b72721d0f0 Nick Hu         2020-01-06  16  {
8ad8b72721d0f0 Nick Hu         2020-01-06  17  	uintptr_t i;
8ad8b72721d0f0 Nick Hu         2020-01-06  18  	pgd_t *pgd = early_pg_dir + pgd_index(KASAN_SHADOW_START);
8ad8b72721d0f0 Nick Hu         2020-01-06  19  
54c5639d8f507e Alexandre Ghiti 2021-10-29 @20  	BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=
54c5639d8f507e Alexandre Ghiti 2021-10-29  21  		KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
54c5639d8f507e Alexandre Ghiti 2021-10-29  22  
8ad8b72721d0f0 Nick Hu         2020-01-06  23  	for (i = 0; i < PTRS_PER_PTE; ++i)
8ad8b72721d0f0 Nick Hu         2020-01-06  24  		set_pte(kasan_early_shadow_pte + i,
8ad8b72721d0f0 Nick Hu         2020-01-06  25  			mk_pte(virt_to_page(kasan_early_shadow_page),
8ad8b72721d0f0 Nick Hu         2020-01-06  26  			       PAGE_KERNEL));
8ad8b72721d0f0 Nick Hu         2020-01-06  27  
8ad8b72721d0f0 Nick Hu         2020-01-06  28  	for (i = 0; i < PTRS_PER_PMD; ++i)
8ad8b72721d0f0 Nick Hu         2020-01-06  29  		set_pmd(kasan_early_shadow_pmd + i,
8458ca147c204e Zong Li         2020-02-07  30  			pfn_pmd(PFN_DOWN
8458ca147c204e Zong Li         2020-02-07  31  				(__pa((uintptr_t) kasan_early_shadow_pte)),
8ad8b72721d0f0 Nick Hu         2020-01-06  32  				__pgprot(_PAGE_TABLE)));
8ad8b72721d0f0 Nick Hu         2020-01-06  33  
8ad8b72721d0f0 Nick Hu         2020-01-06  34  	for (i = KASAN_SHADOW_START; i < KASAN_SHADOW_END;
8ad8b72721d0f0 Nick Hu         2020-01-06  35  	     i += PGDIR_SIZE, ++pgd)
8ad8b72721d0f0 Nick Hu         2020-01-06  36  		set_pgd(pgd,
8458ca147c204e Zong Li         2020-02-07  37  			pfn_pgd(PFN_DOWN
8458ca147c204e Zong Li         2020-02-07  38  				(__pa(((uintptr_t) kasan_early_shadow_pmd))),
8ad8b72721d0f0 Nick Hu         2020-01-06  39  				__pgprot(_PAGE_TABLE)));
8ad8b72721d0f0 Nick Hu         2020-01-06  40  
8ad8b72721d0f0 Nick Hu         2020-01-06  41  	/* init for swapper_pg_dir */
8ad8b72721d0f0 Nick Hu         2020-01-06  42  	pgd = pgd_offset_k(KASAN_SHADOW_START);
8ad8b72721d0f0 Nick Hu         2020-01-06  43  
8ad8b72721d0f0 Nick Hu         2020-01-06  44  	for (i = KASAN_SHADOW_START; i < KASAN_SHADOW_END;
8ad8b72721d0f0 Nick Hu         2020-01-06  45  	     i += PGDIR_SIZE, ++pgd)
8ad8b72721d0f0 Nick Hu         2020-01-06  46  		set_pgd(pgd,
8458ca147c204e Zong Li         2020-02-07  47  			pfn_pgd(PFN_DOWN
8458ca147c204e Zong Li         2020-02-07  48  				(__pa(((uintptr_t) kasan_early_shadow_pmd))),
8ad8b72721d0f0 Nick Hu         2020-01-06  49  				__pgprot(_PAGE_TABLE)));
8ad8b72721d0f0 Nick Hu         2020-01-06  50  
4cb699d0447be8 Vincent Chen    2020-07-10  51  	local_flush_tlb_all();
8ad8b72721d0f0 Nick Hu         2020-01-06  52  }
8ad8b72721d0f0 Nick Hu         2020-01-06  53  

:::::: The code at line 20 was first introduced by commit
:::::: 54c5639d8f507ebefa814f574cb6f763033a72a5 riscv: Fix asan-stack clang build

:::::: TO: Alexandre Ghiti <alexandre.ghiti@canonical.com>
:::::: CC: Palmer Dabbelt <palmerdabbelt@google.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

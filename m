Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6DC4810D6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 09:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbhL2II7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 03:08:59 -0500
Received: from mga12.intel.com ([192.55.52.136]:17615 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239205AbhL2II6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 03:08:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640765338; x=1672301338;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xGmYqA/f4tDgPN8N9XZ2BWj0sPKSg6mpQzE9WWHvPGg=;
  b=FS8rzSSQ7j5c98t28/LyLk85vgN6XYCwQh54WAZoACF9cgCTTRy4ZHO2
   CwluOT1rHC2eXbBuYhXymYRm/9uO5G3+ciE+4++cdTzr31Rqoo3Xyw9w0
   VtvJsrnLTiUKl36o/1FWkP2RVeSzziOcRtm9RTru8A48b3JX8oMN8HXMp
   NwiGmscUCDDSP5tI7xkLgzWa6QEJYZjQInyXJqhCTR91qfU4z1F4Lqas+
   XhoZmli4FaAFHRSQGj1uYtcILmJOHhhfNLiJFP0RKCYmYEUFVKOd8Djtu
   TjBG/nZuaTpFJZHMS+jnHuiiShdNjybKO69WsmLB7+RYM6BNXomNNqTTp
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="221479726"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="221479726"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 00:08:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="618971234"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Dec 2021 00:08:56 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2U11-0008jK-Cd; Wed, 29 Dec 2021 08:08:55 +0000
Date:   Wed, 29 Dec 2021 16:08:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [csky-linux:riscv_compat_v2_sv48_v3_xtpbmt 18/32]
 arch/riscv/include/asm/page.h:40:35: error: 'PTRS_PER_PGD' undeclared; did
 you mean 'PTRS_PER_PMD'?
Message-ID: <202112291625.LuMtmcux-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v2_sv48_v3_xtpbmt
head:   29a08e898f4e552bc0d5117b437ac3073e6ebb81
commit: 0ede6d3975bb0435d097cdfb2b45ee74e778ab4b [18/32] riscv: Move KASAN mapping next to the kernel mapping
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20211229/202112291625.LuMtmcux-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/c-sky/csky-linux/commit/0ede6d3975bb0435d097cdfb2b45ee74e778ab4b
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v2_sv48_v3_xtpbmt
        git checkout 0ede6d3975bb0435d097cdfb2b45ee74e778ab4b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   error: include/uapi/asm-generic/fcntl.h: leak CONFIG_COMPAT to user-space
   make[2]: *** [scripts/Makefile.headersinst:63: usr/include/asm-generic/fcntl.h] Error 1
   make[2]: Target '__headers' not remade because of errors.
   make[1]: *** [Makefile:1283: headers] Error 2
   In file included from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from arch/riscv/kernel/asm-offsets.c:10:
   arch/riscv/include/asm/pgtable-64.h: In function 'pud_page':
>> arch/riscv/include/asm/page.h:40:35: error: 'PTRS_PER_PGD' undeclared (first use in this function); did you mean 'PTRS_PER_PMD'?
      40 | #define KERN_VIRT_SIZE          ((PTRS_PER_PGD / 2 * PGDIR_SIZE) / 2)
         |                                   ^~~~~~~~~~~~
   arch/riscv/include/asm/pgtable.h:27:27: note: in expansion of macro 'KERN_VIRT_SIZE'
      27 | #define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
         |                           ^~~~~~~~~~~~~~
   arch/riscv/include/asm/pgtable.h:29:41: note: in expansion of macro 'VMALLOC_SIZE'
      29 | #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
         |                                         ^~~~~~~~~~~~
   arch/riscv/include/asm/pgtable.h:57:26: note: in expansion of macro 'VMALLOC_START'
      57 | #define VMEMMAP_START   (VMALLOC_START - VMEMMAP_SIZE)
         |                          ^~~~~~~~~~~~~
   arch/riscv/include/asm/pgtable.h:63:41: note: in expansion of macro 'VMEMMAP_START'
      63 | #define vmemmap         ((struct page *)VMEMMAP_START)
         |                                         ^~~~~~~~~~~~~
   include/asm-generic/memory_model.h:25:34: note: in expansion of macro 'vmemmap'
      25 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
         |                                  ^~~~~~~
   include/asm-generic/memory_model.h:53:21: note: in expansion of macro '__pfn_to_page'
      53 | #define pfn_to_page __pfn_to_page
         |                     ^~~~~~~~~~~~~
   arch/riscv/include/asm/pgtable-64.h:69:16: note: in expansion of macro 'pfn_to_page'
      69 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
         |                ^~~~~~~~~~~
   arch/riscv/include/asm/page.h:40:35: note: each undeclared identifier is reported only once for each function it appears in
      40 | #define KERN_VIRT_SIZE          ((PTRS_PER_PGD / 2 * PGDIR_SIZE) / 2)
         |                                   ^~~~~~~~~~~~
   arch/riscv/include/asm/pgtable.h:27:27: note: in expansion of macro 'KERN_VIRT_SIZE'
      27 | #define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
         |                           ^~~~~~~~~~~~~~
   arch/riscv/include/asm/pgtable.h:29:41: note: in expansion of macro 'VMALLOC_SIZE'
      29 | #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
         |                                         ^~~~~~~~~~~~
   arch/riscv/include/asm/pgtable.h:57:26: note: in expansion of macro 'VMALLOC_START'
      57 | #define VMEMMAP_START   (VMALLOC_START - VMEMMAP_SIZE)
         |                          ^~~~~~~~~~~~~
   arch/riscv/include/asm/pgtable.h:63:41: note: in expansion of macro 'VMEMMAP_START'
      63 | #define vmemmap         ((struct page *)VMEMMAP_START)
         |                                         ^~~~~~~~~~~~~
   include/asm-generic/memory_model.h:25:34: note: in expansion of macro 'vmemmap'
      25 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
         |                                  ^~~~~~~
   include/asm-generic/memory_model.h:53:21: note: in expansion of macro '__pfn_to_page'
      53 | #define pfn_to_page __pfn_to_page
         |                     ^~~~~~~~~~~~~
   arch/riscv/include/asm/pgtable-64.h:69:16: note: in expansion of macro 'pfn_to_page'
      69 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
         |                ^~~~~~~~~~~
   make[2]: *** [scripts/Makefile.build:121: arch/riscv/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1197: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +40 arch/riscv/include/asm/page.h

    35	
    36	/*
    37	 * Half of the kernel address space (half of the entries of the page global
    38	 * directory) is for the direct mapping.
    39	 */
  > 40	#define KERN_VIRT_SIZE		((PTRS_PER_PGD / 2 * PGDIR_SIZE) / 2)
    41	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

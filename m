Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA429481151
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 10:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbhL2JkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 04:40:00 -0500
Received: from mga03.intel.com ([134.134.136.65]:58849 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239536AbhL2Jj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 04:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640770799; x=1672306799;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Qm22J3Upo6fRP4D48RyUpz3ALAjlc8DlamN/KcsTqKE=;
  b=TMMIoyrSWu2WLgpcSLQ1kJ2c0pw8/ytvS/JHJq62sDF1/PwmvUmRPuoc
   qrPRYRujwdDd8Ij8Aargzil5gR27oJyRt3Q9sTBCA5Z7VCkm2IMFmWVP6
   SUVb3Yp5glCmz6aX4Qe8J8PXCGCC9APoKHT5TZVqpjaic7JYnQwK1cDQU
   scR0G8teKSOpkTYsrdhdRFtT+afUAyrwBBLsxFg8L4YDn0bb1h6q0Q40V
   6w4DoSiwboizLTtHxFbq4LqEy0bQZd9Wc8ANZFNh6G8yavOdia+r3yOHA
   6T6IZbEIBaaaJ9T4GpIrb1k1D/Dtlh3KisBfhIv+T4+ENVcviAliGcfYS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="241449116"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="241449116"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 01:39:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="554476330"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Dec 2021 01:39:57 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2VR7-0008nr-4i; Wed, 29 Dec 2021 09:39:57 +0000
Date:   Wed, 29 Dec 2021 17:39:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [csky-linux:riscv_compat_v2_sv48_v3_xtpbmt 18/32]
 arch/riscv/include/asm/pgtable-64.h:69:9: error: use of undeclared
 identifier 'PTRS_PER_PGD'
Message-ID: <202112291726.c3778TlR-lkp@intel.com>
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
config: riscv-randconfig-r032-20211229 (https://download.01.org/0day-ci/archive/20211229/202112291726.c3778TlR-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project cd284b7ac0615afc6e0f1a30da2777e361de27a3)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/c-sky/csky-linux/commit/0ede6d3975bb0435d097cdfb2b45ee74e778ab4b
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v2_sv48_v3_xtpbmt
        git checkout 0ede6d3975bb0435d097cdfb2b45ee74e778ab4b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   error: include/uapi/asm-generic/fcntl.h: leak CONFIG_COMPAT to user-space
   make[2]: *** [scripts/Makefile.headersinst:63: usr/include/asm-generic/fcntl.h] Error 1
   make[2]: Target '__headers' not remade because of errors.
   make[1]: *** [Makefile:1283: headers] Error 2
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:95:
>> arch/riscv/include/asm/pgtable-64.h:69:9: error: use of undeclared identifier 'PTRS_PER_PGD'
           return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
                  ^
   include/asm-generic/memory_model.h:53:21: note: expanded from macro 'pfn_to_page'
   #define pfn_to_page __pfn_to_page
                       ^
   include/asm-generic/memory_model.h:25:29: note: expanded from macro '__pfn_to_page'
   #define __pfn_to_page(pfn)      (vmemmap + (pfn))
                                    ^
   arch/riscv/include/asm/pgtable.h:63:34: note: expanded from macro 'vmemmap'
   #define vmemmap         ((struct page *)VMEMMAP_START)
                                           ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/riscv/include/asm/pgtable.h:29:41: note: expanded from macro 'VMALLOC_START'
   #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
                                           ^
   arch/riscv/include/asm/pgtable.h:27:27: note: expanded from macro 'VMALLOC_SIZE'
   #define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
                             ^
   arch/riscv/include/asm/page.h:40:27: note: expanded from macro 'KERN_VIRT_SIZE'
   #define KERN_VIRT_SIZE          ((PTRS_PER_PGD / 2 * PGDIR_SIZE) / 2)
                                     ^
   1 error generated.
   make[2]: *** [scripts/Makefile.build:121: arch/riscv/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1197: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/PTRS_PER_PGD +69 arch/riscv/include/asm/pgtable-64.h

07037db5d479f9 Palmer Dabbelt 2017-07-10  66  
8ad8b72721d0f0 Nick Hu        2020-01-06  67  static inline struct page *pud_page(pud_t pud)
8ad8b72721d0f0 Nick Hu        2020-01-06  68  {
8ad8b72721d0f0 Nick Hu        2020-01-06 @69  	return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
8ad8b72721d0f0 Nick Hu        2020-01-06  70  }
8ad8b72721d0f0 Nick Hu        2020-01-06  71  

:::::: The code at line 69 was first introduced by commit
:::::: 8ad8b72721d0f07fa02dbe71f901743f9c71c8e6 riscv: Add KASAN support

:::::: TO: Nick Hu <nickhu@andestech.com>
:::::: CC: Palmer Dabbelt <palmerdabbelt@google.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

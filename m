Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A4453B891
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiFBMCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbiFBMC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:02:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C630CE9B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654171346; x=1685707346;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cin2IcV48kN9xXFyrRmzGpTTb9CRw1TAh/9xCn7/jLM=;
  b=BLmfJ17maIlG2bRMUbpTvQHzNqJHx9CzS4jV1g2Kf6VBFUqA5eeHsajM
   kIUETXIxLeoD/WpuHV54A9wXOmbcR07OWvqclk54Z3Ggd/y5gDAY4N6P4
   t8b3HeTssVtX2/IWPf7u8cwxeDMmys4wCU1/8mhISfZ/ALw3ZtBGa/TUv
   iybbP228nLRqn0j1zDcvyApiQg/0pf15SEz2mCNbP7Zj/K6p2PMySc0GX
   bD34EQApBSkl5oJzrVlYDIlVtXh2F9DIVV/vPH5Pp9dTnM5BBPV6rmA/C
   zAQNQeaTX0iRUr1lFHp1XB9VxoFH8S0EBwHWOhkU2YZcwmmXuP2HQHITN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="301290752"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="301290752"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 05:02:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="824225509"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jun 2022 05:02:24 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwjWy-00052j-7Y;
        Thu, 02 Jun 2022 12:02:24 +0000
Date:   Thu, 2 Jun 2022 20:02:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 18/31]
 ./include/generated/autoconf.h:126:31: warning: passing argument 1 of
 'virt_to_pfn' makes pointer from integer without a cast
Message-ID: <202206021937.go6cI17x-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   9083f89a58302e92fad7f144986e307db2350aad
commit: 41026b6c37af5a9cf176a9c4cea5b350005f720a [18/31] ARC: mm: Make virt_to_pfn() a static inline
config: arc-defconfig (https://download.01.org/0day-ci/archive/20220602/202206021937.go6cI17x-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=41026b6c37af5a9cf176a9c4cea5b350005f720a
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout 41026b6c37af5a9cf176a9c4cea5b350005f720a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/arc/include/asm/thread_info.h:16,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/arc/kernel/asm-offsets.c:6:
   arch/arc/include/asm/page.h: In function 'virt_to_pfn':
   arch/arc/include/asm/page.h:96:16: error: implicit declaration of function '__pa' [-Werror=implicit-function-declaration]
      96 |         return __pa(kaddr) >> PAGE_SHIFT;
         |                ^~~~
   In file included from include/linux/kconfig.h:5,
                    from <command-line>:
   include/linux/mm.h: In function 'virt_to_head_page':
>> ./include/generated/autoconf.h:126:31: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
     126 | #define CONFIG_LINUX_RAM_BASE 0x80000000
         |                               ^~~~~~~~~~
         |                               |
         |                               unsigned int
   arch/arc/include/asm/page.h:114:45: note: in expansion of macro 'CONFIG_LINUX_RAM_BASE'
     114 | #define ARCH_PFN_OFFSET         virt_to_pfn(CONFIG_LINUX_RAM_BASE)
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/memory_model.h:18:53: note: in expansion of macro 'ARCH_PFN_OFFSET'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                                     ^~~~~~~~~~~~~~~
   include/asm-generic/memory_model.h:53:21: note: in expansion of macro '__pfn_to_page'
      53 | #define pfn_to_page __pfn_to_page
         |                     ^~~~~~~~~~~~~
   arch/arc/include/asm/page.h:129:33: note: in expansion of macro 'pfn_to_page'
     129 | #define virt_to_page(kaddr)     pfn_to_page(virt_to_pfn(kaddr))
         |                                 ^~~~~~~~~~~
   include/linux/mm.h:846:29: note: in expansion of macro 'virt_to_page'
     846 |         struct page *page = virt_to_page(x);
         |                             ^~~~~~~~~~~~
   In file included from arch/arc/include/asm/thread_info.h:16,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/arc/kernel/asm-offsets.c:6:
   arch/arc/include/asm/page.h:94:53: note: expected 'const void *' but argument is of type 'unsigned int'
      94 | static inline unsigned long virt_to_pfn(const void *kaddr)
         |                                         ~~~~~~~~~~~~^~~~~
   In file included from include/linux/kconfig.h:5,
                    from <command-line>:
   include/linux/mm.h: In function 'virt_to_folio':
>> ./include/generated/autoconf.h:126:31: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
     126 | #define CONFIG_LINUX_RAM_BASE 0x80000000
         |                               ^~~~~~~~~~
         |                               |
         |                               unsigned int
   arch/arc/include/asm/page.h:114:45: note: in expansion of macro 'CONFIG_LINUX_RAM_BASE'
     114 | #define ARCH_PFN_OFFSET         virt_to_pfn(CONFIG_LINUX_RAM_BASE)
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/memory_model.h:18:53: note: in expansion of macro 'ARCH_PFN_OFFSET'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                                     ^~~~~~~~~~~~~~~
   include/asm-generic/memory_model.h:53:21: note: in expansion of macro '__pfn_to_page'
      53 | #define pfn_to_page __pfn_to_page
         |                     ^~~~~~~~~~~~~
   arch/arc/include/asm/page.h:129:33: note: in expansion of macro 'pfn_to_page'
     129 | #define virt_to_page(kaddr)     pfn_to_page(virt_to_pfn(kaddr))
         |                                 ^~~~~~~~~~~
   include/linux/mm.h:853:29: note: in expansion of macro 'virt_to_page'
     853 |         struct page *page = virt_to_page(x);
         |                             ^~~~~~~~~~~~
   In file included from arch/arc/include/asm/thread_info.h:16,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/arc/kernel/asm-offsets.c:6:
   arch/arc/include/asm/page.h:94:53: note: expected 'const void *' but argument is of type 'unsigned int'
      94 | static inline unsigned long virt_to_pfn(const void *kaddr)
         |                                         ~~~~~~~~~~~~^~~~~
   In file included from include/linux/kconfig.h:5,
                    from <command-line>:
   include/linux/mm.h: In function 'folio_pfn':
>> ./include/generated/autoconf.h:126:31: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
     126 | #define CONFIG_LINUX_RAM_BASE 0x80000000
         |                               ^~~~~~~~~~
         |                               |
         |                               unsigned int
   arch/arc/include/asm/page.h:114:45: note: in expansion of macro 'CONFIG_LINUX_RAM_BASE'
     114 | #define ARCH_PFN_OFFSET         virt_to_pfn(CONFIG_LINUX_RAM_BASE)
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/memory_model.h:20:34: note: in expansion of macro 'ARCH_PFN_OFFSET'
      20 |                                  ARCH_PFN_OFFSET)
         |                                  ^~~~~~~~~~~~~~~
   include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__page_to_pfn'
      52 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   include/linux/mm.h:1521:16: note: in expansion of macro 'page_to_pfn'
    1521 |         return page_to_pfn(&folio->page);
         |                ^~~~~~~~~~~
   In file included from arch/arc/include/asm/thread_info.h:16,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/arc/kernel/asm-offsets.c:6:
   arch/arc/include/asm/page.h:94:53: note: expected 'const void *' but argument is of type 'unsigned int'
      94 | static inline unsigned long virt_to_pfn(const void *kaddr)
         |                                         ~~~~~~~~~~~~^~~~~
   include/linux/mm.h: In function 'lowmem_page_address':
>> ./include/generated/autoconf.h:126:31: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
     126 | #define CONFIG_LINUX_RAM_BASE 0x80000000
         |                               ^~~~~~~~~~
         |                               |
         |                               unsigned int
   arch/arc/include/asm/page.h:127:59: note: in definition of macro '__va'
     127 | #define __va(paddr)             ((void *)((unsigned long)(paddr)))
         |                                                           ^~~~~
   include/linux/mm.h:113:30: note: in expansion of macro 'PFN_PHYS'
     113 | #define page_to_virt(x) __va(PFN_PHYS(page_to_pfn(x)))
         |                              ^~~~~~~~
   arch/arc/include/asm/page.h:114:45: note: in expansion of macro 'CONFIG_LINUX_RAM_BASE'
     114 | #define ARCH_PFN_OFFSET         virt_to_pfn(CONFIG_LINUX_RAM_BASE)
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/memory_model.h:20:34: note: in expansion of macro 'ARCH_PFN_OFFSET'
      20 |                                  ARCH_PFN_OFFSET)
         |                                  ^~~~~~~~~~~~~~~
   include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__page_to_pfn'
      52 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   include/linux/mm.h:113:39: note: in expansion of macro 'page_to_pfn'
     113 | #define page_to_virt(x) __va(PFN_PHYS(page_to_pfn(x)))
         |                                       ^~~~~~~~~~~
   include/linux/mm.h:1723:16: note: in expansion of macro 'page_to_virt'
    1723 |         return page_to_virt(page);
         |                ^~~~~~~~~~~~
   arch/arc/include/asm/page.h:94:53: note: expected 'const void *' but argument is of type 'unsigned int'
      94 | static inline unsigned long virt_to_pfn(const void *kaddr)
         |                                         ~~~~~~~~~~~~^~~~~
   In file included from arch/arc/include/asm/page.h:137,
                    from arch/arc/include/asm/thread_info.h:16,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/arc/kernel/asm-offsets.c:6:
   include/linux/mm.h: In function 'pte_lockptr':
   arch/arc/include/asm/pgtable-levels.h:163:47: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
     163 | #define pmd_page_vaddr(pmd)     (pmd_val(pmd) & PAGE_MASK)
         |                                 ~~~~~~~~~~~~~~^~~~~~~~~~~~
         |                                               |
         |                                               long unsigned int
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   arch/arc/include/asm/pgtable-levels.h:165:33: note: in expansion of macro 'virt_to_page'
     165 | #define pmd_page(pmd)           virt_to_page(pmd_page_vaddr(pmd))
         |                                 ^~~~~~~~~~~~
   arch/arc/include/asm/pgtable-levels.h:165:46: note: in expansion of macro 'pmd_page_vaddr'
     165 | #define pmd_page(pmd)           virt_to_page(pmd_page_vaddr(pmd))
         |                                              ^~~~~~~~~~~~~~
   include/linux/mm.h:2287:27: note: in expansion of macro 'pmd_page'
    2287 |         return ptlock_ptr(pmd_page(*pmd));
         |                           ^~~~~~~~
   In file included from arch/arc/include/asm/thread_info.h:16,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/arc/kernel/asm-offsets.c:6:
   arch/arc/include/asm/page.h:94:53: note: expected 'const void *' but argument is of type 'long unsigned int'
      94 | static inline unsigned long virt_to_pfn(const void *kaddr)
         |                                         ~~~~~~~~~~~~^~~~~
   In file included from include/linux/kconfig.h:5,
                    from <command-line>:
>> ./include/generated/autoconf.h:126:31: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
     126 | #define CONFIG_LINUX_RAM_BASE 0x80000000
         |                               ^~~~~~~~~~
         |                               |
         |                               unsigned int
   arch/arc/include/asm/page.h:114:45: note: in expansion of macro 'CONFIG_LINUX_RAM_BASE'
     114 | #define ARCH_PFN_OFFSET         virt_to_pfn(CONFIG_LINUX_RAM_BASE)
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/memory_model.h:18:53: note: in expansion of macro 'ARCH_PFN_OFFSET'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                                     ^~~~~~~~~~~~~~~
   include/asm-generic/memory_model.h:53:21: note: in expansion of macro '__pfn_to_page'
      53 | #define pfn_to_page __pfn_to_page
         |                     ^~~~~~~~~~~~~
   arch/arc/include/asm/page.h:129:33: note: in expansion of macro 'pfn_to_page'
     129 | #define virt_to_page(kaddr)     pfn_to_page(virt_to_pfn(kaddr))
         |                                 ^~~~~~~~~~~
   arch/arc/include/asm/pgtable-levels.h:165:33: note: in expansion of macro 'virt_to_page'
     165 | #define pmd_page(pmd)           virt_to_page(pmd_page_vaddr(pmd))
         |                                 ^~~~~~~~~~~~
   include/linux/mm.h:2287:27: note: in expansion of macro 'pmd_page'
    2287 |         return ptlock_ptr(pmd_page(*pmd));
         |                           ^~~~~~~~
   In file included from arch/arc/include/asm/thread_info.h:16,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/arc/kernel/asm-offsets.c:6:
   arch/arc/include/asm/page.h:94:53: note: expected 'const void *' but argument is of type 'unsigned int'
      94 | static inline unsigned long virt_to_pfn(const void *kaddr)
         |                                         ~~~~~~~~~~~~^~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:120: arch/arc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

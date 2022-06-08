Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C4A543EEE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiFHV70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbiFHV7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:59:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EB148E56
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654725555; x=1686261555;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NFXLJU5oUHEVoESVi0nU16rvdS7oh7Dob2gFKPqfSJk=;
  b=MCqFgXGw3NS0jv1wh2Io5yf6bHCkmVj1YXn7ZBeYYLW6t/uEY/Kvc9OT
   H6eWtqjeq59+tkfuWAmLWeSEAtV7hVffMeOky6jy4gEiuBBHCF7zh1GY1
   SkQoRxhb+An9itpJDNmxYcIBS1NSAzlWk1x2BtPjDSNbR73Y9NhJLesx4
   wMbVIdOUbJbChDfmMaxuAoHGnvGp95VgMNJm3+LSwdkUqjjc3C/Z7eHM7
   nux64HWrDOXFul2HtcQbKTuYWRAg/Mj+dmLXB/OPsf5GafNbBf9r0AAzu
   MB1ZPnGQdP+jvQk3RaYUZijZwt1SbImYVUR2T9YLYx16tg5deG9mkXoxD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="277886257"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="277886257"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 14:59:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="580276982"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Jun 2022 14:59:04 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nz3hf-000F9p-Jb;
        Wed, 08 Jun 2022 21:59:03 +0000
Date:   Thu, 9 Jun 2022 05:58:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.19-rc1 22/33]
 arch/m68k/sun3/dvma.c:32:36: warning: passing argument 1 of 'virt_to_pfn'
 makes pointer from integer without a cast
Message-ID: <202206090541.Uj6hkxDK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.19-rc1
head:   512fc95a58c7b2e91e267db91a4ec5a54afedd01
commit: 899dbc86e3b146b471687f42b4e3b53e3e878bd2 [22/33] m68k/mm: Make virt_to_pfn() a static inline
config: m68k-sun3_defconfig (https://download.01.org/0day-ci/archive/20220609/202206090541.Uj6hkxDK-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=899dbc86e3b146b471687f42b4e3b53e3e878bd2
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.19-rc1
        git checkout 899dbc86e3b146b471687f42b4e3b53e3e878bd2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash arch/m68k/sun3/ mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/m68k/include/asm/pgtable_mm.h:153,
                    from arch/m68k/include/asm/pgtable.h:5,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:29,
                    from arch/m68k/sun3/dvma.c:13:
   arch/m68k/sun3/dvma.c: In function 'dvma_page':
>> arch/m68k/sun3/dvma.c:32:36: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
      32 |         ptep = pfn_pte(virt_to_pfn(kaddr), PAGE_KERNEL);
         |                                    ^~~~~
         |                                    |
         |                                    long unsigned int
   arch/m68k/include/asm/sun3_pgtable.h:130:34: note: in definition of macro 'pfn_pte'
     130 | ({ pte_t __pte; pte_val(__pte) = pfn | pgprot_val(pgprot); __pte; })
         |                                  ^~~
   In file included from arch/m68k/include/asm/page.h:60,
                    from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/m68k/sun3/dvma.c:13:
   arch/m68k/include/asm/page_mm.h:124:53: note: expected 'const void *' but argument is of type 'long unsigned int'
     124 | static inline unsigned long virt_to_pfn(const void *kaddr)
         |                                         ~~~~~~~~~~~~^~~~~
   arch/m68k/sun3/dvma.c: At top level:
   arch/m68k/sun3/dvma.c:65:13: warning: no previous prototype for 'sun3_dvma_init' [-Wmissing-prototypes]
      65 | void __init sun3_dvma_init(void)
         |             ^~~~~~~~~~~~~~
--
   In file included from mm/gup.c:23:
   arch/m68k/include/asm/tlbflush.h: In function 'flush_tlb_range':
   arch/m68k/include/asm/tlbflush.h:191:28: warning: variable 'oldctx' set but not used [-Wunused-but-set-variable]
     191 |         unsigned char seg, oldctx;
         |                            ^~~~~~
   In file included from arch/m68k/include/asm/page_mm.h:140,
                    from arch/m68k/include/asm/page.h:60,
                    from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from mm/gup.c:5:
   mm/gup.c: In function 'follow_page_pte':
>> arch/m68k/include/asm/sun3_pgtable.h:114:2: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
     114 | ((unsigned long) __va ((pte_val (pte) & SUN3_PAGE_PGNUM_MASK) << PAGE_SHIFT))
         | ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |  |
         |  long unsigned int
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   arch/m68k/include/asm/sun3_pgtable.h:132:33: note: in expansion of macro 'virt_to_page'
     132 | #define pte_page(pte)           virt_to_page(__pte_page(pte))
         |                                 ^~~~~~~~~~~~
   arch/m68k/include/asm/sun3_pgtable.h:132:46: note: in expansion of macro '__pte_page'
     132 | #define pte_page(pte)           virt_to_page(__pte_page(pte))
         |                                              ^~~~~~~~~~
   mm/gup.c:543:32: note: in expansion of macro 'pte_page'
     543 |                         page = pte_page(pte);
         |                                ^~~~~~~~
   In file included from arch/m68k/include/asm/page.h:60,
                    from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from mm/gup.c:5:
   arch/m68k/include/asm/page_mm.h:124:53: note: expected 'const void *' but argument is of type 'long unsigned int'
     124 | static inline unsigned long virt_to_pfn(const void *kaddr)
         |                                         ~~~~~~~~~~~~^~~~~
   In file included from arch/m68k/include/asm/page_mm.h:140,
                    from arch/m68k/include/asm/page.h:60,
                    from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from mm/gup.c:5:
>> arch/m68k/include/asm/sun3_pgtable.h:114:2: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
     114 | ((unsigned long) __va ((pte_val (pte) & SUN3_PAGE_PGNUM_MASK) << PAGE_SHIFT))
         | ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |  |
         |  long unsigned int
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   arch/m68k/include/asm/sun3_pgtable.h:132:33: note: in expansion of macro 'virt_to_page'
     132 | #define pte_page(pte)           virt_to_page(__pte_page(pte))
         |                                 ^~~~~~~~~~~~
   arch/m68k/include/asm/sun3_pgtable.h:132:46: note: in expansion of macro '__pte_page'
     132 | #define pte_page(pte)           virt_to_page(__pte_page(pte))
         |                                              ^~~~~~~~~~
   mm/gup.c:554:32: note: in expansion of macro 'pte_page'
     554 |                         page = pte_page(pte);
         |                                ^~~~~~~~
   In file included from arch/m68k/include/asm/page.h:60,
                    from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from mm/gup.c:5:
   arch/m68k/include/asm/page_mm.h:124:53: note: expected 'const void *' but argument is of type 'long unsigned int'
     124 | static inline unsigned long virt_to_pfn(const void *kaddr)
         |                                         ~~~~~~~~~~~~^~~~~
   In file included from arch/m68k/include/asm/page_mm.h:140,
                    from arch/m68k/include/asm/page.h:60,
                    from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from mm/gup.c:5:
   mm/gup.c: In function 'follow_pmd_mask':
   arch/m68k/include/asm/sun3_pgtable.h:134:46: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
     134 | #define pmd_page(pmd)           virt_to_page(pmd_page_vaddr(pmd))
         |                                              ^~~~~~~~~~~~~~~~~~~
         |                                              |
         |                                              long unsigned int
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   arch/m68k/include/asm/sun3_pgtable.h:134:33: note: in expansion of macro 'virt_to_page'
     134 | #define pmd_page(pmd)           virt_to_page(pmd_page_vaddr(pmd))
         |                                 ^~~~~~~~~~~~
   mm/gup.c:695:24: note: in expansion of macro 'pmd_page'
     695 |                 page = pmd_page(*pmd);
         |                        ^~~~~~~~
   In file included from arch/m68k/include/asm/page.h:60,
                    from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from mm/gup.c:5:
   arch/m68k/include/asm/page_mm.h:124:53: note: expected 'const void *' but argument is of type 'long unsigned int'
     124 | static inline unsigned long virt_to_pfn(const void *kaddr)
         |                                         ~~~~~~~~~~~~^~~~~
   In file included from arch/m68k/include/asm/page_mm.h:140,
                    from arch/m68k/include/asm/page.h:60,
                    from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from mm/gup.c:5:
   mm/gup.c: In function 'get_gate_page':
>> arch/m68k/include/asm/sun3_pgtable.h:114:2: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
     114 | ((unsigned long) __va ((pte_val (pte) & SUN3_PAGE_PGNUM_MASK) << PAGE_SHIFT))
         | ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |  |
         |  long unsigned int
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   arch/m68k/include/asm/sun3_pgtable.h:132:33: note: in expansion of macro 'virt_to_page'
     132 | #define pte_page(pte)           virt_to_page(__pte_page(pte))
         |                                 ^~~~~~~~~~~~
   arch/m68k/include/asm/sun3_pgtable.h:132:46: note: in expansion of macro '__pte_page'
     132 | #define pte_page(pte)           virt_to_page(__pte_page(pte))
         |                                              ^~~~~~~~~~
   mm/gup.c:905:25: note: in expansion of macro 'pte_page'
     905 |                 *page = pte_page(*pte);
         |                         ^~~~~~~~
   In file included from arch/m68k/include/asm/page.h:60,
                    from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from mm/gup.c:5:
   arch/m68k/include/asm/page_mm.h:124:53: note: expected 'const void *' but argument is of type 'long unsigned int'
     124 | static inline unsigned long virt_to_pfn(const void *kaddr)
         |                                         ~~~~~~~~~~~~^~~~~
--
   mm/vmalloc.c:673:24: note: in expansion of macro 'p4d_page'
     673 |                 return p4d_page(*p4d) + ((addr & ~P4D_MASK) >> PAGE_SHIFT);
         |                        ^~~~~~~~
   In file included from arch/m68k/include/asm/page.h:60,
                    from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/vmalloc.h:5,
                    from mm/vmalloc.c:11:
   arch/m68k/include/asm/page_mm.h:124:53: note: expected 'const void *' but argument is of type 'long unsigned int'
     124 | static inline unsigned long virt_to_pfn(const void *kaddr)
         |                                         ~~~~~~~~~~~~^~~~~
   In file included from arch/m68k/include/asm/page_mm.h:140,
                    from arch/m68k/include/asm/page.h:60,
                    from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/vmalloc.h:5,
                    from mm/vmalloc.c:11:
   arch/m68k/include/asm/sun3_pgtable.h:134:46: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
     134 | #define pmd_page(pmd)           virt_to_page(pmd_page_vaddr(pmd))
         |                                              ^~~~~~~~~~~~~~~~~~~
         |                                              |
         |                                              long unsigned int
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   arch/m68k/include/asm/sun3_pgtable.h:134:33: note: in expansion of macro 'virt_to_page'
     134 | #define pmd_page(pmd)           virt_to_page(pmd_page_vaddr(pmd))
         |                                 ^~~~~~~~~~~~
   include/asm-generic/pgtable-nopmd.h:55:50: note: in expansion of macro 'pmd_page'
      55 | #define pud_page(pud)                           (pmd_page((pmd_t){ pud }))
         |                                                  ^~~~~~~~
   mm/vmalloc.c:681:24: note: in expansion of macro 'pud_page'
     681 |                 return pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
         |                        ^~~~~~~~
   In file included from arch/m68k/include/asm/page.h:60,
                    from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/vmalloc.h:5,
                    from mm/vmalloc.c:11:
   arch/m68k/include/asm/page_mm.h:124:53: note: expected 'const void *' but argument is of type 'long unsigned int'
     124 | static inline unsigned long virt_to_pfn(const void *kaddr)
         |                                         ~~~~~~~~~~~~^~~~~
   In file included from arch/m68k/include/asm/page_mm.h:140,
                    from arch/m68k/include/asm/page.h:60,
                    from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/vmalloc.h:5,
                    from mm/vmalloc.c:11:
   arch/m68k/include/asm/sun3_pgtable.h:134:46: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
     134 | #define pmd_page(pmd)           virt_to_page(pmd_page_vaddr(pmd))
         |                                              ^~~~~~~~~~~~~~~~~~~
         |                                              |
         |                                              long unsigned int
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   arch/m68k/include/asm/sun3_pgtable.h:134:33: note: in expansion of macro 'virt_to_page'
     134 | #define pmd_page(pmd)           virt_to_page(pmd_page_vaddr(pmd))
         |                                 ^~~~~~~~~~~~
   mm/vmalloc.c:689:24: note: in expansion of macro 'pmd_page'
     689 |                 return pmd_page(*pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
         |                        ^~~~~~~~
   In file included from arch/m68k/include/asm/page.h:60,
                    from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/vmalloc.h:5,
                    from mm/vmalloc.c:11:
   arch/m68k/include/asm/page_mm.h:124:53: note: expected 'const void *' but argument is of type 'long unsigned int'
     124 | static inline unsigned long virt_to_pfn(const void *kaddr)
         |                                         ~~~~~~~~~~~~^~~~~
   In file included from arch/m68k/include/asm/page_mm.h:140,
                    from arch/m68k/include/asm/page.h:60,
                    from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/vmalloc.h:5,
                    from mm/vmalloc.c:11:
>> arch/m68k/include/asm/sun3_pgtable.h:114:2: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
     114 | ((unsigned long) __va ((pte_val (pte) & SUN3_PAGE_PGNUM_MASK) << PAGE_SHIFT))
         | ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |  |
         |  long unsigned int
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   arch/m68k/include/asm/sun3_pgtable.h:132:33: note: in expansion of macro 'virt_to_page'
     132 | #define pte_page(pte)           virt_to_page(__pte_page(pte))
         |                                 ^~~~~~~~~~~~
   arch/m68k/include/asm/sun3_pgtable.h:132:46: note: in expansion of macro '__pte_page'
     132 | #define pte_page(pte)           virt_to_page(__pte_page(pte))
         |                                              ^~~~~~~~~~
   mm/vmalloc.c:696:24: note: in expansion of macro 'pte_page'
     696 |                 page = pte_page(pte);
         |                        ^~~~~~~~
   In file included from arch/m68k/include/asm/page.h:60,
                    from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/vmalloc.h:5,
                    from mm/vmalloc.c:11:
   arch/m68k/include/asm/page_mm.h:124:53: note: expected 'const void *' but argument is of type 'long unsigned int'
     124 | static inline unsigned long virt_to_pfn(const void *kaddr)
         |                                         ~~~~~~~~~~~~^~~~~


vim +/virt_to_pfn +32 arch/m68k/sun3/dvma.c

^1da177e4c3f41 Linus Torvalds     2005-04-16 @13  #include <linux/mm.h>
57c8a661d95dff Mike Rapoport      2018-10-30  14  #include <linux/memblock.h>
^1da177e4c3f41 Linus Torvalds     2005-04-16  15  #include <linux/list.h>
^1da177e4c3f41 Linus Torvalds     2005-04-16  16  #include <asm/page.h>
^1da177e4c3f41 Linus Torvalds     2005-04-16  17  #include <asm/sun3mmu.h>
^1da177e4c3f41 Linus Torvalds     2005-04-16  18  #include <asm/dvma.h>
^1da177e4c3f41 Linus Torvalds     2005-04-16  19  
^1da177e4c3f41 Linus Torvalds     2005-04-16  20  
^1da177e4c3f41 Linus Torvalds     2005-04-16  21  static unsigned long ptelist[120];
^1da177e4c3f41 Linus Torvalds     2005-04-16  22  
07b8125949de66 Adrian Bunk        2008-07-17  23  static unsigned long dvma_page(unsigned long kaddr, unsigned long vaddr)
^1da177e4c3f41 Linus Torvalds     2005-04-16  24  {
^1da177e4c3f41 Linus Torvalds     2005-04-16  25  	unsigned long pte;
^1da177e4c3f41 Linus Torvalds     2005-04-16  26  	unsigned long j;
^1da177e4c3f41 Linus Torvalds     2005-04-16  27  	pte_t ptep;
^1da177e4c3f41 Linus Torvalds     2005-04-16  28  
^1da177e4c3f41 Linus Torvalds     2005-04-16  29  	j = *(volatile unsigned long *)kaddr;
^1da177e4c3f41 Linus Torvalds     2005-04-16  30  	*(volatile unsigned long *)kaddr = j;
^1da177e4c3f41 Linus Torvalds     2005-04-16  31  
^1da177e4c3f41 Linus Torvalds     2005-04-16 @32  	ptep = pfn_pte(virt_to_pfn(kaddr), PAGE_KERNEL);
^1da177e4c3f41 Linus Torvalds     2005-04-16  33  	pte = pte_val(ptep);
56bbd86257f899 Geert Uytterhoeven 2016-11-09  34  //	pr_info("dvma_remap: addr %lx -> %lx pte %08lx\n", kaddr, vaddr, pte);
^1da177e4c3f41 Linus Torvalds     2005-04-16  35  	if(ptelist[(vaddr & 0xff000) >> PAGE_SHIFT] != pte) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  36  		sun3_put_pte(vaddr, pte);
^1da177e4c3f41 Linus Torvalds     2005-04-16  37  		ptelist[(vaddr & 0xff000) >> PAGE_SHIFT] = pte;
^1da177e4c3f41 Linus Torvalds     2005-04-16  38  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  39  
^1da177e4c3f41 Linus Torvalds     2005-04-16  40  	return (vaddr + (kaddr & ~PAGE_MASK));
^1da177e4c3f41 Linus Torvalds     2005-04-16  41  

:::::: The code at line 32 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

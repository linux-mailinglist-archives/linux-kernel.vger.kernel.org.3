Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6024C04F7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbiBVXAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiBVXAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:00:36 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F31312602
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645570809; x=1677106809;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3e/5Xg20UVBivHUtVPoU8Q0aTSY5BPJUQZRGPoGiSaw=;
  b=Zp8V/TruXWXJVymyJSk4Ueoy7jVw50b+OdK1eJioMgfw2pSBxQ/mPolt
   l4nzHq05Um+Q3Bz+gO0cRtPE4oHPvnvZuuDg1Dx+EZNl5rcYohjZXhQb2
   jf01rotg+2jnZOeepHu0KapfPWLAfwlkNI4ITwL5eVgKXh2k9Lh7vREu1
   SwRIbEuThHFN1/PkCDdLhkHil/9ekEpa7Jn2/l1680YG6eUH/vLA08Bit
   1UAQEe6wZ/swDpdKb+R3C7vlSs9PcGAKUrmbK8YvLoNxxGWwF5vq+VCVs
   3r+5hl5vpCcEtZWJXRn7w6XpogcJfRFMtPr/mj5ua4TISFJnT5TwY/Pee
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="338269432"
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="338269432"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 15:00:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="683690223"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2022 15:00:06 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMe8c-0000hx-8Y; Tue, 22 Feb 2022 23:00:06 +0000
Date:   Wed, 23 Feb 2022 06:59:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2209/2324] include/linux/huge_mm.h:208:10:
 warning: implicit declaration of function 'pmd_none'; did you mean
 'p4d_none'?
Message-ID: <202202230629.8W8SrXyB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   7d9efc989eceed6a8fa475a186880ec4a1ad54a3
commit: a1e4ecc8c4751b5f8a83c7afcbc7ca526ab6a2e1 [2209/2324] headers/deps: mm: Optimize <linux/mm_api.h> dependencies, remove <linux/mmzone_api.h> dependency
config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/20220223/202202230629.8W8SrXyB-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=a1e4ecc8c4751b5f8a83c7afcbc7ca526ab6a2e1
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout a1e4ecc8c4751b5f8a83c7afcbc7ca526ab6a2e1
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/firmware/efi/libstub/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/mm_api.h:388,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from include/linux/mmu_notifier.h:5,
                    from include/asm-generic/tlb.h:15,
                    from arch/x86/include/asm/tlb.h:13,
                    from arch/x86/include/asm/efi.h:7,
                    from drivers/firmware/efi/libstub/gop.c:13:
   include/linux/huge_mm.h: In function 'is_swap_pmd':
>> include/linux/huge_mm.h:208:10: warning: implicit declaration of function 'pmd_none'; did you mean 'p4d_none'? [-Wimplicit-function-declaration]
     208 |  return !pmd_none(pmd) && !pmd_present(pmd);
         |          ^~~~~~~~
         |          p4d_none
>> include/linux/huge_mm.h:208:28: warning: implicit declaration of function 'pmd_present'; did you mean 'p4d_present'? [-Wimplicit-function-declaration]
     208 |  return !pmd_none(pmd) && !pmd_present(pmd);
         |                            ^~~~~~~~~~~
         |                            p4d_present
   include/linux/huge_mm.h: In function 'pmd_trans_huge_lock':
>> include/linux/huge_mm.h:215:27: warning: implicit declaration of function 'pmd_trans_huge'; did you mean 'pmd_trans_huge_lock'? [-Wimplicit-function-declaration]
     215 |  if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
         |                           ^~~~~~~~~~~~~~
         |                           pmd_trans_huge_lock
>> include/linux/huge_mm.h:215:51: warning: implicit declaration of function 'pmd_devmap' [-Wimplicit-function-declaration]
     215 |  if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
         |                                                   ^~~~~~~~~~
   include/linux/huge_mm.h: In function 'pud_trans_huge_lock':
>> include/linux/huge_mm.h:223:6: warning: implicit declaration of function 'pud_trans_huge'; did you mean 'pud_trans_huge_lock'? [-Wimplicit-function-declaration]
     223 |  if (pud_trans_huge(*pud) || pud_devmap(*pud))
         |      ^~~~~~~~~~~~~~
         |      pud_trans_huge_lock
>> include/linux/huge_mm.h:223:30: warning: implicit declaration of function 'pud_devmap'; did you mean 'pud_val'? [-Wimplicit-function-declaration]
     223 |  if (pud_trans_huge(*pud) || pud_devmap(*pud))
         |                              ^~~~~~~~~~
         |                              pud_val
   include/linux/huge_mm.h: In function 'is_huge_zero_pmd':
>> include/linux/huge_mm.h:279:37: warning: implicit declaration of function 'pmd_pfn' [-Wimplicit-function-declaration]
     279 |  return READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd) && pmd_present(pmd);
         |                                     ^~~~~~~
   In file included from include/linux/pgtable_api.h:19,
                    from include/linux/mmu_notifier.h:5,
                    from include/asm-generic/tlb.h:15,
                    from arch/x86/include/asm/tlb.h:13,
                    from arch/x86/include/asm/efi.h:7,
                    from drivers/firmware/efi/libstub/gop.c:13:
   arch/x86/include/asm/pgtable.h: At top level:
   arch/x86/include/asm/pgtable.h:208:29: error: conflicting types for 'pmd_pfn'
     208 | static inline unsigned long pmd_pfn(pmd_t pmd)
         |                             ^~~~~~~
   In file included from include/linux/mm_api.h:388,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from include/linux/mmu_notifier.h:5,
                    from include/asm-generic/tlb.h:15,
                    from arch/x86/include/asm/tlb.h:13,
                    from arch/x86/include/asm/efi.h:7,
                    from drivers/firmware/efi/libstub/gop.c:13:
   include/linux/huge_mm.h:279:37: note: previous implicit declaration of 'pmd_pfn' was here
     279 |  return READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd) && pmd_present(pmd);
         |                                     ^~~~~~~
   In file included from include/linux/pgtable_api.h:19,
                    from include/linux/mmu_notifier.h:5,
                    from include/asm-generic/tlb.h:15,
                    from arch/x86/include/asm/tlb.h:13,
                    from arch/x86/include/asm/efi.h:7,
                    from drivers/firmware/efi/libstub/gop.c:13:
   arch/x86/include/asm/pgtable.h:249:19: error: static declaration of 'pmd_trans_huge' follows non-static declaration
     249 | static inline int pmd_trans_huge(pmd_t pmd)
         |                   ^~~~~~~~~~~~~~
   In file included from include/linux/mm_api.h:388,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from include/linux/mmu_notifier.h:5,
                    from include/asm-generic/tlb.h:15,
                    from arch/x86/include/asm/tlb.h:13,
                    from arch/x86/include/asm/efi.h:7,
                    from drivers/firmware/efi/libstub/gop.c:13:
   include/linux/huge_mm.h:215:27: note: previous implicit declaration of 'pmd_trans_huge' was here
     215 |  if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
         |                           ^~~~~~~~~~~~~~
   In file included from include/linux/pgtable_api.h:19,
                    from include/linux/mmu_notifier.h:5,
                    from include/asm-generic/tlb.h:15,
                    from arch/x86/include/asm/tlb.h:13,
                    from arch/x86/include/asm/efi.h:7,
                    from drivers/firmware/efi/libstub/gop.c:13:
   arch/x86/include/asm/pgtable.h:743:19: error: static declaration of 'pmd_present' follows non-static declaration
     743 | static inline int pmd_present(pmd_t pmd)
         |                   ^~~~~~~~~~~
   In file included from include/linux/mm_api.h:388,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from include/linux/mmu_notifier.h:5,
                    from include/asm-generic/tlb.h:15,
                    from arch/x86/include/asm/tlb.h:13,
                    from arch/x86/include/asm/efi.h:7,
                    from drivers/firmware/efi/libstub/gop.c:13:
   include/linux/huge_mm.h:208:28: note: previous implicit declaration of 'pmd_present' was here
     208 |  return !pmd_none(pmd) && !pmd_present(pmd);
         |                            ^~~~~~~~~~~
   In file included from include/linux/pgtable_api.h:19,
                    from include/linux/mmu_notifier.h:5,
                    from include/asm-generic/tlb.h:15,
                    from arch/x86/include/asm/tlb.h:13,
                    from arch/x86/include/asm/efi.h:7,
                    from drivers/firmware/efi/libstub/gop.c:13:
   arch/x86/include/asm/pgtable.h:772:19: error: static declaration of 'pmd_none' follows non-static declaration
     772 | static inline int pmd_none(pmd_t pmd)
         |                   ^~~~~~~~
   In file included from include/linux/mm_api.h:388,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from include/linux/mmu_notifier.h:5,
                    from include/asm-generic/tlb.h:15,
                    from arch/x86/include/asm/tlb.h:13,
                    from arch/x86/include/asm/efi.h:7,
                    from drivers/firmware/efi/libstub/gop.c:13:
   include/linux/huge_mm.h:208:10: note: previous implicit declaration of 'pmd_none' was here
     208 |  return !pmd_none(pmd) && !pmd_present(pmd);
         |          ^~~~~~~~
   In file included from include/linux/mmu_notifier.h:5,
                    from include/asm-generic/tlb.h:15,
                    from arch/x86/include/asm/tlb.h:13,
                    from arch/x86/include/asm/efi.h:7,
                    from drivers/firmware/efi/libstub/gop.c:13:
   include/linux/pgtable_api.h:1200:19: error: static declaration of 'pmd_devmap' follows non-static declaration
    1200 | static inline int pmd_devmap(pmd_t pmd)
         |                   ^~~~~~~~~~
   In file included from include/linux/mm_api.h:388,


vim +208 include/linux/huge_mm.h

84c3fc4e9c563d Zi Yan                  2017-09-08  205  
84c3fc4e9c563d Zi Yan                  2017-09-08  206  static inline int is_swap_pmd(pmd_t pmd)
84c3fc4e9c563d Zi Yan                  2017-09-08  207  {
84c3fc4e9c563d Zi Yan                  2017-09-08 @208  	return !pmd_none(pmd) && !pmd_present(pmd);
84c3fc4e9c563d Zi Yan                  2017-09-08  209  }
84c3fc4e9c563d Zi Yan                  2017-09-08  210  
c1e8d7c6a7a682 Michel Lespinasse       2020-06-08  211  /* mmap_lock must be held on entry */
b6ec57f4b92e9b Kirill A. Shutemov      2016-01-21  212  static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
b6ec57f4b92e9b Kirill A. Shutemov      2016-01-21  213  		struct vm_area_struct *vma)
025c5b2451e42c Naoya Horiguchi         2012-03-21  214  {
84c3fc4e9c563d Zi Yan                  2017-09-08 @215  	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
b6ec57f4b92e9b Kirill A. Shutemov      2016-01-21  216  		return __pmd_trans_huge_lock(pmd, vma);
025c5b2451e42c Naoya Horiguchi         2012-03-21  217  	else
969e8d7e47f93e Chen Gang               2016-04-01  218  		return NULL;
025c5b2451e42c Naoya Horiguchi         2012-03-21  219  }
a00cc7d9dd93d6 Matthew Wilcox          2017-02-24  220  static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
a00cc7d9dd93d6 Matthew Wilcox          2017-02-24  221  		struct vm_area_struct *vma)
a00cc7d9dd93d6 Matthew Wilcox          2017-02-24  222  {
a00cc7d9dd93d6 Matthew Wilcox          2017-02-24 @223  	if (pud_trans_huge(*pud) || pud_devmap(*pud))
a00cc7d9dd93d6 Matthew Wilcox          2017-02-24  224  		return __pud_trans_huge_lock(pud, vma);
a00cc7d9dd93d6 Matthew Wilcox          2017-02-24  225  	else
a00cc7d9dd93d6 Matthew Wilcox          2017-02-24  226  		return NULL;
a00cc7d9dd93d6 Matthew Wilcox          2017-02-24  227  }
6ffbb45826f5d9 Matthew Wilcox (Oracle  2020-08-14  228) 
6ffbb45826f5d9 Matthew Wilcox (Oracle  2020-08-14  229) /**
6ffbb45826f5d9 Matthew Wilcox (Oracle  2020-08-14  230)  * thp_order - Order of a transparent huge page.
6ffbb45826f5d9 Matthew Wilcox (Oracle  2020-08-14  231)  * @page: Head page of a transparent huge page.
6ffbb45826f5d9 Matthew Wilcox (Oracle  2020-08-14  232)  */
6ffbb45826f5d9 Matthew Wilcox (Oracle  2020-08-14  233) static inline unsigned int thp_order(struct page *page)
6ffbb45826f5d9 Matthew Wilcox (Oracle  2020-08-14  234) {
6ffbb45826f5d9 Matthew Wilcox (Oracle  2020-08-14  235) 	VM_BUG_ON_PGFLAGS(PageTail(page), page);
6ffbb45826f5d9 Matthew Wilcox (Oracle  2020-08-14  236) 	if (PageHead(page))
6ffbb45826f5d9 Matthew Wilcox (Oracle  2020-08-14  237) 		return HPAGE_PMD_ORDER;
6ffbb45826f5d9 Matthew Wilcox (Oracle  2020-08-14  238) 	return 0;
6ffbb45826f5d9 Matthew Wilcox (Oracle  2020-08-14  239) }
6ffbb45826f5d9 Matthew Wilcox (Oracle  2020-08-14  240) 
6c357848b44b40 Matthew Wilcox (Oracle  2020-08-14  241) /**
6c357848b44b40 Matthew Wilcox (Oracle  2020-08-14  242)  * thp_nr_pages - The number of regular pages in this huge page.
6c357848b44b40 Matthew Wilcox (Oracle  2020-08-14  243)  * @page: The head page of a huge page.
6c357848b44b40 Matthew Wilcox (Oracle  2020-08-14  244)  */
6c357848b44b40 Matthew Wilcox (Oracle  2020-08-14  245) static inline int thp_nr_pages(struct page *page)
2c888cfbc1b455 Rik van Riel            2011-01-13  246  {
6c357848b44b40 Matthew Wilcox (Oracle  2020-08-14  247) 	VM_BUG_ON_PGFLAGS(PageTail(page), page);
6c357848b44b40 Matthew Wilcox (Oracle  2020-08-14  248) 	if (PageHead(page))
2c888cfbc1b455 Rik van Riel            2011-01-13  249  		return HPAGE_PMD_NR;
2c888cfbc1b455 Rik van Riel            2011-01-13  250  	return 1;
2c888cfbc1b455 Rik van Riel            2011-01-13  251  }
d10e63f29488b0 Mel Gorman              2012-10-25  252  
5bf34d7c7ffe77 Matthew Wilcox (Oracle  2021-11-28  253) /**
5bf34d7c7ffe77 Matthew Wilcox (Oracle  2021-11-28  254)  * folio_test_pmd_mappable - Can we map this folio with a PMD?
5bf34d7c7ffe77 Matthew Wilcox (Oracle  2021-11-28  255)  * @folio: The folio to test
5bf34d7c7ffe77 Matthew Wilcox (Oracle  2021-11-28  256)  */
5bf34d7c7ffe77 Matthew Wilcox (Oracle  2021-11-28  257) static inline bool folio_test_pmd_mappable(struct folio *folio)
5bf34d7c7ffe77 Matthew Wilcox (Oracle  2021-11-28  258) {
5bf34d7c7ffe77 Matthew Wilcox (Oracle  2021-11-28  259) 	return folio_order(folio) >= HPAGE_PMD_ORDER;
5bf34d7c7ffe77 Matthew Wilcox (Oracle  2021-11-28  260) }
5bf34d7c7ffe77 Matthew Wilcox (Oracle  2021-11-28  261) 
a00cc7d9dd93d6 Matthew Wilcox          2017-02-24  262  struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
df06b37ffe5a44 Keith Busch             2018-10-26  263  		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
a00cc7d9dd93d6 Matthew Wilcox          2017-02-24  264  struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
df06b37ffe5a44 Keith Busch             2018-10-26  265  		pud_t *pud, int flags, struct dev_pagemap **pgmap);
a00cc7d9dd93d6 Matthew Wilcox          2017-02-24  266  
5db4f15c4fd7ae Yang Shi                2021-06-30  267  vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
d10e63f29488b0 Mel Gorman              2012-10-25  268  
56873f43abdcd5 Wang, Yalin             2015-02-11  269  extern struct page *huge_zero_page;
3b77e8c8cde581 Hugh Dickins            2021-06-15  270  extern unsigned long huge_zero_pfn;
56873f43abdcd5 Wang, Yalin             2015-02-11  271  
56873f43abdcd5 Wang, Yalin             2015-02-11  272  static inline bool is_huge_zero_page(struct page *page)
56873f43abdcd5 Wang, Yalin             2015-02-11  273  {
6aa7de059173a9 Mark Rutland            2017-10-23  274  	return READ_ONCE(huge_zero_page) == page;
56873f43abdcd5 Wang, Yalin             2015-02-11  275  }
56873f43abdcd5 Wang, Yalin             2015-02-11  276  
fc43704437ebe4 Matthew Wilcox          2015-09-08  277  static inline bool is_huge_zero_pmd(pmd_t pmd)
fc43704437ebe4 Matthew Wilcox          2015-09-08  278  {
3b77e8c8cde581 Hugh Dickins            2021-06-15 @279  	return READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd) && pmd_present(pmd);
fc43704437ebe4 Matthew Wilcox          2015-09-08  280  }
fc43704437ebe4 Matthew Wilcox          2015-09-08  281  

:::::: The code at line 208 was first introduced by commit
:::::: 84c3fc4e9c563d8fb91cfdf5948da48fe1af34d3 mm: thp: check pmd migration entry in common path

:::::: TO: Zi Yan <zi.yan@cs.rutgers.edu>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

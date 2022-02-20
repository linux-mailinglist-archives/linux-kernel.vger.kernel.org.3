Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802184BD176
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244968AbiBTUbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:31:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244945AbiBTUbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:31:14 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFE5522D6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645389053; x=1676925053;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mJdETe3HuifbUzpCE4jNhCZGyWmxlPNBROdi3hiGCfc=;
  b=f6pIvDU6qqWX2Pnzh804N88mESDVTjkUY1re0Cr40ofohJKBRL33eEN+
   lYVEh9scra1KfzetkmeQ1nWYQGBS34SQZSZ4Fu5NonwMkRhpbt3vJF+8j
   s3hv7khoMc4GtmYpYngB43NaQin9gdDdvmh16GKiQxzlDAxxdF8D7scej
   w1Q2MwsF7ox8rSz2zxC9QLihSt337bTTWidESf/WuLTMNzFaeY/FQ+59h
   i/V1fPRO0upIFcLmkdl7Plwm4sQ3LqbJKfdGt6LBUo9IFqPAJRACbkDRl
   +nXsI2sw+ZvtN6+8FWcHgonCCVPKZgdm+4f68FdTrwh8OaIHTL+dyHux1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="314664153"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="314664153"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 12:30:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="606192235"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Feb 2022 12:30:51 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLsr4-0000j2-Ar; Sun, 20 Feb 2022 20:30:50 +0000
Date:   Mon, 21 Feb 2022 04:30:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:arm64-ro-page-tables-pkvm-v5.17 27/28]
 mm/huge_memory.c:1956:66: error: 'PMD_TYPE_TABLE' undeclared
Message-ID: <202202210453.o8dzNYdm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git arm64-ro-page-tables-pkvm-v5.17
head:   1faeabde0ba3c81ad666ab924ab79ef64843d40d
commit: 5a6759851a4881d8ed981f899cea14c680c4fede [27/28] mm: HACK provide target address when migrating a PMD entry
config: sparc64-randconfig-s031-20220220 (https://download.01.org/0day-ci/archive/20220221/202202210453.o8dzNYdm-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=5a6759851a4881d8ed981f899cea14c680c4fede
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb arm64-ro-page-tables-pkvm-v5.17
        git checkout 5a6759851a4881d8ed981f899cea14c680c4fede
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/sparc/include/asm/page.h:8,
                    from arch/sparc/include/asm/thread_info_64.h:27,
                    from arch/sparc/include/asm/thread_info.h:5,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/sparc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from mm/huge_memory.c:8:
   mm/huge_memory.c: In function '__split_huge_zero_page_pmd':
>> include/asm-generic/memory_model.h:34:35: error: initialization of 'const struct page *' from incompatible pointer type 'pgtable_t' {aka 'pte_t *'} [-Werror=incompatible-pointer-types]
      34 | ({      const struct page *__pg = (pg);                         \
         |                                   ^
   arch/sparc/include/asm/page_64.h:85:37: note: in definition of macro '__pmd'
      85 | #define __pmd(x)        ((pmd_t) { (x) } )
         |                                     ^
   include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__page_to_pfn'
      52 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   arch/sparc/include/asm/page.h:5:34: note: in expansion of macro 'page_to_pfn'
       5 | #define page_to_phys(page)      (page_to_pfn(page) << PAGE_SHIFT)
         |                                  ^~~~~~~~~~~
   mm/huge_memory.c:1956:42: note: in expansion of macro 'page_to_phys'
    1956 |         set_pmd_at(mm, haddr, pmd, __pmd(page_to_phys(pgtable) | PMD_TYPE_TABLE));
         |                                          ^~~~~~~~~~~~
   include/asm-generic/memory_model.h:34:35: note: (near initialization for '(anonymous)')
      34 | ({      const struct page *__pg = (pg);                         \
         |                                   ^
   arch/sparc/include/asm/page_64.h:85:37: note: in definition of macro '__pmd'
      85 | #define __pmd(x)        ((pmd_t) { (x) } )
         |                                     ^
   include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__page_to_pfn'
      52 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   arch/sparc/include/asm/page.h:5:34: note: in expansion of macro 'page_to_pfn'
       5 | #define page_to_phys(page)      (page_to_pfn(page) << PAGE_SHIFT)
         |                                  ^~~~~~~~~~~
   mm/huge_memory.c:1956:42: note: in expansion of macro 'page_to_phys'
    1956 |         set_pmd_at(mm, haddr, pmd, __pmd(page_to_phys(pgtable) | PMD_TYPE_TABLE));
         |                                          ^~~~~~~~~~~~
>> mm/huge_memory.c:1956:66: error: 'PMD_TYPE_TABLE' undeclared (first use in this function)
    1956 |         set_pmd_at(mm, haddr, pmd, __pmd(page_to_phys(pgtable) | PMD_TYPE_TABLE));
         |                                                                  ^~~~~~~~~~~~~~
   arch/sparc/include/asm/page_64.h:85:37: note: in definition of macro '__pmd'
      85 | #define __pmd(x)        ((pmd_t) { (x) } )
         |                                     ^
   mm/huge_memory.c:1956:66: note: each undeclared identifier is reported only once for each function it appears in
    1956 |         set_pmd_at(mm, haddr, pmd, __pmd(page_to_phys(pgtable) | PMD_TYPE_TABLE));
         |                                                                  ^~~~~~~~~~~~~~
   arch/sparc/include/asm/page_64.h:85:37: note: in definition of macro '__pmd'
      85 | #define __pmd(x)        ((pmd_t) { (x) } )
         |                                     ^
   mm/huge_memory.c: In function '__split_huge_pmd_locked':
>> include/asm-generic/memory_model.h:34:35: error: initialization of 'const struct page *' from incompatible pointer type 'pgtable_t' {aka 'pte_t *'} [-Werror=incompatible-pointer-types]
      34 | ({      const struct page *__pg = (pg);                         \
         |                                   ^
   arch/sparc/include/asm/page_64.h:85:37: note: in definition of macro '__pmd'
      85 | #define __pmd(x)        ((pmd_t) { (x) } )
         |                                     ^
   include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__page_to_pfn'
      52 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   arch/sparc/include/asm/page.h:5:34: note: in expansion of macro 'page_to_pfn'
       5 | #define page_to_phys(page)      (page_to_pfn(page) << PAGE_SHIFT)
         |                                  ^~~~~~~~~~~
   mm/huge_memory.c:2137:42: note: in expansion of macro 'page_to_phys'
    2137 |         set_pmd_at(mm, haddr, pmd, __pmd(page_to_phys(pgtable) | PMD_TYPE_TABLE));
         |                                          ^~~~~~~~~~~~
   include/asm-generic/memory_model.h:34:35: note: (near initialization for '(anonymous)')
      34 | ({      const struct page *__pg = (pg);                         \
         |                                   ^
   arch/sparc/include/asm/page_64.h:85:37: note: in definition of macro '__pmd'
      85 | #define __pmd(x)        ((pmd_t) { (x) } )
         |                                     ^
   include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__page_to_pfn'
      52 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   arch/sparc/include/asm/page.h:5:34: note: in expansion of macro 'page_to_pfn'
       5 | #define page_to_phys(page)      (page_to_pfn(page) << PAGE_SHIFT)
         |                                  ^~~~~~~~~~~
   mm/huge_memory.c:2137:42: note: in expansion of macro 'page_to_phys'
    2137 |         set_pmd_at(mm, haddr, pmd, __pmd(page_to_phys(pgtable) | PMD_TYPE_TABLE));
         |                                          ^~~~~~~~~~~~
   mm/huge_memory.c:2137:66: error: 'PMD_TYPE_TABLE' undeclared (first use in this function)
    2137 |         set_pmd_at(mm, haddr, pmd, __pmd(page_to_phys(pgtable) | PMD_TYPE_TABLE));
         |                                                                  ^~~~~~~~~~~~~~
   arch/sparc/include/asm/page_64.h:85:37: note: in definition of macro '__pmd'
      85 | #define __pmd(x)        ((pmd_t) { (x) } )
         |                                     ^
   cc1: some warnings being treated as errors
--
   In file included from arch/sparc/include/asm/page.h:8,
                    from arch/sparc/include/asm/thread_info_64.h:27,
                    from arch/sparc/include/asm/thread_info.h:5,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/sparc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from mm/khugepaged.c:4:
   mm/khugepaged.c: In function 'collapse_huge_page':
>> mm/khugepaged.c:1167:68: error: 'PMD_TYPE_TABLE' undeclared (first use in this function)
    1167 |                 set_pmd_at(mm, address, pmd, __pmd(pmd_val(_pmd) | PMD_TYPE_TABLE));
         |                                                                    ^~~~~~~~~~~~~~
   arch/sparc/include/asm/page_64.h:85:37: note: in definition of macro '__pmd'
      85 | #define __pmd(x)        ((pmd_t) { (x) } )
         |                                     ^
   mm/khugepaged.c:1167:68: note: each undeclared identifier is reported only once for each function it appears in
    1167 |                 set_pmd_at(mm, address, pmd, __pmd(pmd_val(_pmd) | PMD_TYPE_TABLE));
         |                                                                    ^~~~~~~~~~~~~~
   arch/sparc/include/asm/page_64.h:85:37: note: in definition of macro '__pmd'
      85 | #define __pmd(x)        ((pmd_t) { (x) } )
         |                                     ^


vim +/PMD_TYPE_TABLE +1956 mm/huge_memory.c

  1923	
  1924	static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
  1925			unsigned long haddr, pmd_t *pmd)
  1926	{
  1927		struct mm_struct *mm = vma->vm_mm;
  1928		pgtable_t pgtable;
  1929		pmd_t _pmd;
  1930		int i;
  1931	
  1932		/*
  1933		 * Leave pmd empty until pte is filled note that it is fine to delay
  1934		 * notification until mmu_notifier_invalidate_range_end() as we are
  1935		 * replacing a zero pmd write protected page with a zero pte write
  1936		 * protected page.
  1937		 *
  1938		 * See Documentation/vm/mmu_notifier.rst
  1939		 */
  1940		pmdp_huge_clear_flush(vma, haddr, pmd);
  1941	
  1942		pgtable = pgtable_trans_huge_withdraw(mm, pmd);
  1943		pmd_populate(mm, &_pmd, pgtable);
  1944	
  1945		for (i = 0; i < HPAGE_PMD_NR; i++, haddr += PAGE_SIZE) {
  1946			pte_t *pte, entry;
  1947			entry = pfn_pte(my_zero_pfn(haddr), vma->vm_page_prot);
  1948			entry = pte_mkspecial(entry);
  1949			pte = pte_offset_map(&_pmd, haddr);
  1950			VM_BUG_ON(!pte_none(*pte));
  1951			set_pte_at(mm, haddr, pte, entry);
  1952			pte_unmap(pte);
  1953		}
  1954		smp_wmb(); /* make pte visible before pmd */
  1955		//pmd_populate(mm, pmd, pgtable);
> 1956		set_pmd_at(mm, haddr, pmd, __pmd(page_to_phys(pgtable) | PMD_TYPE_TABLE));
  1957	}
  1958	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

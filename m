Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25E54A2C30
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 07:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243014AbiA2Gwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 01:52:49 -0500
Received: from mga09.intel.com ([134.134.136.24]:28236 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242239AbiA2Gwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 01:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643439165; x=1674975165;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a4scwx3pnuUHvUkzJJylpqNgUA2pXfEe+E0/+adCLLE=;
  b=SqhNwIiRjNjkS2a1KhC6BjsDhxFD6skbNuBpimM/xGXQOarIM5RO3usI
   G8012mY6kM2dZHiQeMtUD3aZb318E5O7wZsC/4bElwBert8/QOz2NNhl8
   dA5CmFbhNkOssXVsKo9Gez2QGLbuxPVX0+pTf8VV/C0oBkF2M1ozdHAKJ
   gHWJS0zbtNd3FtEMwePiLjEuXVr6B5CoAWemWWk0THlQLgsAds6tJqP8t
   FOVuEXJ0T0LkD/jofh03n1ADn4BXKjFS/AMCbctvNIfYSsv5oJDTqBmDD
   CSH9DCvSoz4omCR3i62yDeukgF1VjDskL1m/mAkQoQnP2je+TUWWZ1JvD
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="247020906"
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="247020906"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 22:52:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="625854351"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jan 2022 22:52:43 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDhbH-000OtE-2b; Sat, 29 Jan 2022 06:52:43 +0000
Date:   Sat, 29 Jan 2022 14:52:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:arm64-ro-page-tables-pkvm-v5.17 26/26]
 mm/huge_memory.c:1956:66: error: 'PMD_TYPE_TABLE' undeclared
Message-ID: <202201291432.X54lXKXd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git arm64-ro-page-tables-pkvm-v5.17
head:   b38f2df95cbf61e70bc32017da5318d1cb03e3e3
commit: b38f2df95cbf61e70bc32017da5318d1cb03e3e3 [26/26] mm: HACK provide target address when migrating a PMD entry
config: riscv-buildonly-randconfig-r006-20220127 (https://download.01.org/0day-ci/archive/20220129/202201291432.X54lXKXd-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=b38f2df95cbf61e70bc32017da5318d1cb03e3e3
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb arm64-ro-page-tables-pkvm-v5.17
        git checkout b38f2df95cbf61e70bc32017da5318d1cb03e3e3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/pgtable.h:111,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:33,
                    from mm/huge_memory.c:8:
   mm/huge_memory.c: In function '__split_huge_zero_page_pmd':
>> mm/huge_memory.c:1956:66: error: 'PMD_TYPE_TABLE' undeclared (first use in this function)
    1956 |         set_pmd_at(mm, haddr, pmd, __pmd(page_to_phys(pgtable) | PMD_TYPE_TABLE));
         |                                                                  ^~~~~~~~~~~~~~
   arch/riscv/include/asm/pgtable-64.h:47:37: note: in definition of macro '__pmd'
      47 | #define __pmd(x)        ((pmd_t) { (x) })
         |                                     ^
   mm/huge_memory.c:1956:66: note: each undeclared identifier is reported only once for each function it appears in
    1956 |         set_pmd_at(mm, haddr, pmd, __pmd(page_to_phys(pgtable) | PMD_TYPE_TABLE));
         |                                                                  ^~~~~~~~~~~~~~
   arch/riscv/include/asm/pgtable-64.h:47:37: note: in definition of macro '__pmd'
      47 | #define __pmd(x)        ((pmd_t) { (x) })
         |                                     ^
   mm/huge_memory.c: In function '__split_huge_pmd_locked':
   mm/huge_memory.c:2137:66: error: 'PMD_TYPE_TABLE' undeclared (first use in this function)
    2137 |         set_pmd_at(mm, haddr, pmd, __pmd(page_to_phys(pgtable) | PMD_TYPE_TABLE));
         |                                                                  ^~~~~~~~~~~~~~
   arch/riscv/include/asm/pgtable-64.h:47:37: note: in definition of macro '__pmd'
      47 | #define __pmd(x)        ((pmd_t) { (x) })
         |                                     ^
--
   In file included from arch/riscv/include/asm/pgtable.h:111,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:33,
                    from mm/khugepaged.c:4:
   mm/khugepaged.c: In function 'collapse_huge_page':
>> mm/khugepaged.c:1166:68: error: 'PMD_TYPE_TABLE' undeclared (first use in this function)
    1166 |                 set_pmd_at(mm, address, pmd, __pmd(pmd_val(_pmd) | PMD_TYPE_TABLE));
         |                                                                    ^~~~~~~~~~~~~~
   arch/riscv/include/asm/pgtable-64.h:47:37: note: in definition of macro '__pmd'
      47 | #define __pmd(x)        ((pmd_t) { (x) })
         |                                     ^
   mm/khugepaged.c:1166:68: note: each undeclared identifier is reported only once for each function it appears in
    1166 |                 set_pmd_at(mm, address, pmd, __pmd(pmd_val(_pmd) | PMD_TYPE_TABLE));
         |                                                                    ^~~~~~~~~~~~~~
   arch/riscv/include/asm/pgtable-64.h:47:37: note: in definition of macro '__pmd'
      47 | #define __pmd(x)        ((pmd_t) { (x) })
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

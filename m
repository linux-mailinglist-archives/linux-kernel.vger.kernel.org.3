Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C416F4A2B55
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 03:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352241AbiA2CvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 21:51:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:20076 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352232AbiA2CvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 21:51:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643424682; x=1674960682;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BVprcHjKtAxN9lBdRAAUz5kag8aWL7F99wX0KjRi0mc=;
  b=P+cBQamZXQbdo0iG5XGvYrymocDdmZ4c4ZVmU++9AFz1WTOpZxsf6gc9
   1O03b/TBoq48oONwGadSUwKBgX+AiekR/XnVaPI8znUo9VX0dePg9Dls5
   4+z/aobmYESdwghK6EMwIW8sed8iebq2cF4U+e0bIF+ePtMkw1T7D94fi
   7EYyEls0rYT0buG99ZsuVef2O1gRz5FhXy3Srue5FU2YJ7eKgJgRXaZm3
   FEjq8BebPc9lyTP+pLmtrdFetSg23gR6BPm7BT5fTGpwkuPDtQRfTwVzn
   1NYJu33MlI1yqO2whTNUKohmq9y6bNgaHbqtEl58rmOHmOhxmmkdYVZE9
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="247184106"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="247184106"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 18:51:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="521931437"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Jan 2022 18:51:20 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDdpf-000Ofo-Sa; Sat, 29 Jan 2022 02:51:19 +0000
Date:   Sat, 29 Jan 2022 10:50:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:arm64-ro-page-tables-pkvm-v5.17 26/26]
 include/asm-generic/memory_model.h:34:35: error: initialization of 'const
 struct page *' from incompatible pointer type 'pgtable_t' {aka 'pte_t *'}
Message-ID: <202201291020.m7uI10Dk-lkp@intel.com>
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
config: sparc64-randconfig-r022-20220127 (https://download.01.org/0day-ci/archive/20220129/202201291020.m7uI10Dk-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=b38f2df95cbf61e70bc32017da5318d1cb03e3e3
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb arm64-ro-page-tables-pkvm-v5.17
        git checkout b38f2df95cbf61e70bc32017da5318d1cb03e3e3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc64 SHELL=/bin/bash

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
   mm/huge_memory.c:1956:66: error: 'PMD_TYPE_TABLE' undeclared (first use in this function)
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


vim +34 include/asm-generic/memory_model.h

8f6aac419bd590 Christoph Lameter 2007-10-16  27  
a117e66ed45ac0 KAMEZAWA Hiroyuki 2006-03-27  28  #elif defined(CONFIG_SPARSEMEM)
a117e66ed45ac0 KAMEZAWA Hiroyuki 2006-03-27  29  /*
1a49123b343461 Zhang Yanfei      2013-10-03  30   * Note: section's mem_map is encoded to reflect its start_pfn.
a117e66ed45ac0 KAMEZAWA Hiroyuki 2006-03-27  31   * section[i].section_mem_map == mem_map's address - start_pfn;
a117e66ed45ac0 KAMEZAWA Hiroyuki 2006-03-27  32   */
67de648211fa04 Andy Whitcroft    2006-06-23  33  #define __page_to_pfn(pg)					\
aa462abe8aaf21 Ian Campbell      2011-08-17 @34  ({	const struct page *__pg = (pg);				\
a117e66ed45ac0 KAMEZAWA Hiroyuki 2006-03-27  35  	int __sec = page_to_section(__pg);			\
f05b6284ee5d3b Randy Dunlap      2007-02-10  36  	(unsigned long)(__pg - __section_mem_map_addr(__nr_to_section(__sec)));	\
a117e66ed45ac0 KAMEZAWA Hiroyuki 2006-03-27  37  })
a117e66ed45ac0 KAMEZAWA Hiroyuki 2006-03-27  38  

:::::: The code at line 34 was first introduced by commit
:::::: aa462abe8aaf2198d6aef97da20c874ac694a39f mm: fix __page_to_pfn for a const struct page argument

:::::: TO: Ian Campbell <ian.campbell@citrix.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

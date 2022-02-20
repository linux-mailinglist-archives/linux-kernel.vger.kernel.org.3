Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4754BD18A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244924AbiBTUlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:41:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243846AbiBTUlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:41:14 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68894504B
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645389652; x=1676925652;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RMnD4wOL7OnLZUXpJW3NUpR+DX6XnJhawhtfZ6t3ZUw=;
  b=BGW0cVHvnOR/8xbOZiCfIZEh3Q+aCED1ygL2PX5ZLDWr+7U0G+B0ZHyo
   tpVv7xAoMWQygYCAj1OI5Vg5iQNSyacZFyBJU1lEAsn4F9jPJQdwWSmz4
   +YRotFV31sFbabYassiQjjcKBPIDnhlafOYtr9URc8CifN8WAo+HlSXzm
   I5DApB+g+ciZfFdSvQOW5uqFt+kKa5+u/Vx304uZpuCuYPVbujQYrChop
   5UIGYY6VjE00nNNe1SRr2s9BkDLpL1BpmsS4HM+kAamPQ/Tozr0hHq9lp
   IiB0Pp7OCkEtbttZjFHzxzIKvd1Gs0gk6a637F5kIdtcmz2IDlGKu1mbR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="314664743"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="314664743"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 12:40:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="490239414"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Feb 2022 12:40:51 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLt0k-0000jO-CU; Sun, 20 Feb 2022 20:40:50 +0000
Date:   Mon, 21 Feb 2022 04:40:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:arm64-ro-page-tables-pkvm-v5.17 27/28]
 include/asm-generic/memory_model.h:26:56: error: invalid operands to binary
 - (have 'pgtable_t' {aka 'pte_t *'} and 'struct page *')
Message-ID: <202202210430.5h3lgiMQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
config: s390-randconfig-r044-20220220 (https://download.01.org/0day-ci/archive/20220221/202202210430.5h3lgiMQ-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=5a6759851a4881d8ed981f899cea14c680c4fede
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb arm64-ro-page-tables-pkvm-v5.17
        git checkout 5a6759851a4881d8ed981f899cea14c680c4fede
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/s390/include/asm/thread_info.h:26,
                    from include/linux/thread_info.h:60,
                    from arch/s390/include/asm/preempt.h:6,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from mm/huge_memory.c:8:
   mm/huge_memory.c: In function '__split_huge_zero_page_pmd':
>> include/asm-generic/memory_model.h:26:56: error: invalid operands to binary - (have 'pgtable_t' {aka 'pte_t *'} and 'struct page *')
      26 | #define __page_to_pfn(page)     (unsigned long)((page) - vmemmap)
         |                                                        ^
   arch/s390/include/asm/page.h:101:37: note: in definition of macro '__pmd'
     101 | #define __pmd(x)        ((pmd_t) { (x) } )
         |                                     ^
   arch/s390/include/asm/page.h:173:33: note: in expansion of macro 'pfn_to_phys'
     173 | #define page_to_phys(page)      pfn_to_phys(page_to_pfn(page))
         |                                 ^~~~~~~~~~~
   include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__page_to_pfn'
      52 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   arch/s390/include/asm/page.h:173:45: note: in expansion of macro 'page_to_pfn'
     173 | #define page_to_phys(page)      pfn_to_phys(page_to_pfn(page))
         |                                             ^~~~~~~~~~~
   mm/huge_memory.c:1956:42: note: in expansion of macro 'page_to_phys'
    1956 |         set_pmd_at(mm, haddr, pmd, __pmd(page_to_phys(pgtable) | PMD_TYPE_TABLE));
         |                                          ^~~~~~~~~~~~
   mm/huge_memory.c:1956:66: error: 'PMD_TYPE_TABLE' undeclared (first use in this function)
    1956 |         set_pmd_at(mm, haddr, pmd, __pmd(page_to_phys(pgtable) | PMD_TYPE_TABLE));
         |                                                                  ^~~~~~~~~~~~~~
   arch/s390/include/asm/page.h:101:37: note: in definition of macro '__pmd'
     101 | #define __pmd(x)        ((pmd_t) { (x) } )
         |                                     ^
   mm/huge_memory.c:1956:66: note: each undeclared identifier is reported only once for each function it appears in
    1956 |         set_pmd_at(mm, haddr, pmd, __pmd(page_to_phys(pgtable) | PMD_TYPE_TABLE));
         |                                                                  ^~~~~~~~~~~~~~
   arch/s390/include/asm/page.h:101:37: note: in definition of macro '__pmd'
     101 | #define __pmd(x)        ((pmd_t) { (x) } )
         |                                     ^
   mm/huge_memory.c: In function '__split_huge_pmd_locked':
>> include/asm-generic/memory_model.h:26:56: error: invalid operands to binary - (have 'pgtable_t' {aka 'pte_t *'} and 'struct page *')
      26 | #define __page_to_pfn(page)     (unsigned long)((page) - vmemmap)
         |                                                        ^
   arch/s390/include/asm/page.h:101:37: note: in definition of macro '__pmd'
     101 | #define __pmd(x)        ((pmd_t) { (x) } )
         |                                     ^
   arch/s390/include/asm/page.h:173:33: note: in expansion of macro 'pfn_to_phys'
     173 | #define page_to_phys(page)      pfn_to_phys(page_to_pfn(page))
         |                                 ^~~~~~~~~~~
   include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__page_to_pfn'
      52 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   arch/s390/include/asm/page.h:173:45: note: in expansion of macro 'page_to_pfn'
     173 | #define page_to_phys(page)      pfn_to_phys(page_to_pfn(page))
         |                                             ^~~~~~~~~~~
   mm/huge_memory.c:2137:42: note: in expansion of macro 'page_to_phys'
    2137 |         set_pmd_at(mm, haddr, pmd, __pmd(page_to_phys(pgtable) | PMD_TYPE_TABLE));
         |                                          ^~~~~~~~~~~~
   mm/huge_memory.c:2137:66: error: 'PMD_TYPE_TABLE' undeclared (first use in this function)
    2137 |         set_pmd_at(mm, haddr, pmd, __pmd(page_to_phys(pgtable) | PMD_TYPE_TABLE));
         |                                                                  ^~~~~~~~~~~~~~
   arch/s390/include/asm/page.h:101:37: note: in definition of macro '__pmd'
     101 | #define __pmd(x)        ((pmd_t) { (x) } )
         |                                     ^


vim +26 include/asm-generic/memory_model.h

8f6aac419bd590 Christoph Lameter  2007-10-16  23  
af901ca181d92a André Goddard Rosa 2009-11-14  24  /* memmap is virtually contiguous.  */
8f6aac419bd590 Christoph Lameter  2007-10-16  25  #define __pfn_to_page(pfn)	(vmemmap + (pfn))
32272a26974d20 Martin Schwidefsky 2008-12-25 @26  #define __page_to_pfn(page)	(unsigned long)((page) - vmemmap)
8f6aac419bd590 Christoph Lameter  2007-10-16  27  

:::::: The code at line 26 was first introduced by commit
:::::: 32272a26974d2027384fd4010cd1780fca425d94 [S390] __page_to_pfn warnings

:::::: TO: Martin Schwidefsky <schwidefsky@de.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

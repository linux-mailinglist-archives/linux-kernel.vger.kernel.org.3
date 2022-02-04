Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C424AA39B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355081AbiBDWzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:55:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:5950 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354998AbiBDWy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644015298; x=1675551298;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/ZnVRo1MnM6WUI12OHdcHSgHqE1hxyO0Ujfb1AaBa6s=;
  b=GgxU80XTWoJ1v38OGnsn8DxFNISGUJPrOqH54Ew9pA37C5BodyRnZHgn
   hn1IyfYaFxlNh5bBENBmIy0qHod8dFhvSxTIi2PBXKb4Pcp34zRa+U2rn
   ThiJkQ/8ADx/DhiGky6JkYkfWdhmq/O9ZeZqX+YsSViIik8hONoCh/oqh
   nrGSMcMo8gHLeNQj/2iDhmzRY6CgxDCTh4lsWVZqV1ujxFeckYI0ovuIa
   8mZ7FERn2kunRAdpkAL+kJxtzsOFKsE91QN7cRiXDmK5hvZP6Sbq0VOeO
   +hEbXxdW3FN+j95Ah0cDVIvjWuCSW+06zZEC06ARdKl59fLnryiYhghj+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="272961860"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="272961860"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 14:54:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="498618947"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 04 Feb 2022 14:54:55 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nG7Tj-000YGu-9S; Fri, 04 Feb 2022 22:54:55 +0000
Date:   Sat, 5 Feb 2022 06:54:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [willy-pagecache:for-next 13/75] include/linux/mm.h:1570:29: error:
 conflicting types for 'page_to_section'; have 'long unsigned int(const
 struct page *)'
Message-ID: <202202050617.Ew48ldTc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.infradead.org/users/willy/pagecache for-next
head:   0416a53bea174a256c555e1662abb917077a528c
commit: 8788d4b404865697ebe822cff65a1380728ba251 [13/75] mm: Add folio_pincount_ptr()
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20220205/202202050617.Ew48ldTc-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add willy-pagecache git://git.infradead.org/users/willy/pagecache
        git fetch --no-tags willy-pagecache for-next
        git checkout 8788d4b404865697ebe822cff65a1380728ba251
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/alpha/include/asm/page.h:94,
                    from include/linux/shm.h:6,
                    from include/linux/sched.h:16,
                    from arch/alpha/kernel/asm-offsets.c:10:
   include/linux/mm.h: In function 'folio_pincount_ptr':
   include/asm-generic/memory_model.h:35:21: error: implicit declaration of function 'page_to_section'; did you mean 'present_section'? [-Werror=implicit-function-declaration]
      35 |         int __sec = page_to_section(__pg);                      \
         |                     ^~~~~~~~~~~~~~~
   include/asm-generic/memory_model.h:40:32: note: in definition of macro '__pfn_to_page'
      40 | ({      unsigned long __pfn = (pfn);                    \
         |                                ^~~
   include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__page_to_pfn'
      52 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   include/linux/mm.h:218:38: note: in expansion of macro 'page_to_pfn'
     218 | #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
         |                                      ^~~~~~~~~~~
   include/linux/page-flags.h:230:33: note: in expansion of macro 'nth_page'
     230 | #define folio_page(folio, n)    nth_page(&(folio)->page, n)
         |                                 ^~~~~~~~
   include/linux/mm.h:896:17: note: in expansion of macro 'folio_page'
     896 |         return &folio_page(folio, 1)->compound_pincount;
         |                 ^~~~~~~~~~
   In file included from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/alpha/kernel/asm-offsets.c:11:
   include/linux/mm.h: At top level:
>> include/linux/mm.h:1570:29: error: conflicting types for 'page_to_section'; have 'long unsigned int(const struct page *)'
    1570 | static inline unsigned long page_to_section(const struct page *page)
         |                             ^~~~~~~~~~~~~~~
   In file included from arch/alpha/include/asm/page.h:94,
                    from include/linux/shm.h:6,
                    from include/linux/sched.h:16,
                    from arch/alpha/kernel/asm-offsets.c:10:
   include/asm-generic/memory_model.h:35:21: note: previous implicit declaration of 'page_to_section' with type 'int()'
      35 |         int __sec = page_to_section(__pg);                      \
         |                     ^~~~~~~~~~~~~~~
   include/asm-generic/memory_model.h:40:32: note: in definition of macro '__pfn_to_page'
      40 | ({      unsigned long __pfn = (pfn);                    \
         |                                ^~~
   include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__page_to_pfn'
      52 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   include/linux/mm.h:218:38: note: in expansion of macro 'page_to_pfn'
     218 | #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
         |                                      ^~~~~~~~~~~
   include/linux/page-flags.h:230:33: note: in expansion of macro 'nth_page'
     230 | #define folio_page(folio, n)    nth_page(&(folio)->page, n)
         |                                 ^~~~~~~~
   include/linux/mm.h:896:17: note: in expansion of macro 'folio_page'
     896 |         return &folio_page(folio, 1)->compound_pincount;
         |                 ^~~~~~~~~~
   arch/alpha/kernel/asm-offsets.c:15:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
      15 | void foo(void)
         |      ^~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:121: arch/alpha/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +1570 include/linux/mm.h

bf4e8902ee5080 Daniel Kiper      2011-05-24  1569  
aa462abe8aaf21 Ian Campbell      2011-08-17 @1570  static inline unsigned long page_to_section(const struct page *page)
d41dee369bff3b Andy Whitcroft    2005-06-23  1571  {
d41dee369bff3b Andy Whitcroft    2005-06-23  1572  	return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
d41dee369bff3b Andy Whitcroft    2005-06-23  1573  }
308c05e35e3517 Christoph Lameter 2008-04-28  1574  #endif
d41dee369bff3b Andy Whitcroft    2005-06-23  1575  

:::::: The code at line 1570 was first introduced by commit
:::::: aa462abe8aaf2198d6aef97da20c874ac694a39f mm: fix __page_to_pfn for a const struct page argument

:::::: TO: Ian Campbell <ian.campbell@citrix.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660CF55034D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 09:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiFRHBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 03:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiFRHBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 03:01:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB45249FA6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 00:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655535669; x=1687071669;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a5KWv3E6CKzwzMbDpwTVKKaSpCmfaOdt+jeW0HaBjB4=;
  b=d4K0OsUD6KkqxWRxbEC5fS0SEa5yyZJx3YLvnd99bdUQkRDH+0MrEfpz
   en4gQxmPMd/MGXaQ1P80EOC0u62UFVkLoffsRHP4AZj0K83t9yFA8cPUF
   3quHRQzMKlX0hB9RCfAVJvMXmxXi3OEvM6epwQcP6Z6okKKjsjteggeG5
   KDRy4Yh6wsUC4dQ9fJdKZ5n84CTS5wPWDFb+WZfjTT9EwnP6PcQx1ZD1X
   GvZ7UlCwyMJCLvcRVc8yB5496pmOd13gKRen9NYGY/aDNTpde2MoAtpSC
   WzNUu8orJjtPrWgkm+O7eytk0qhEjENn9vkcJAL9xVvZ0EwIohaz+2Ttb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="259458274"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="259458274"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2022 00:01:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="714014498"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Jun 2022 00:01:08 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2SSB-000Q6p-C5;
        Sat, 18 Jun 2022 07:01:07 +0000
Date:   Sat, 18 Jun 2022 15:00:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [akpm-mm:mm-unstable 255/261] include/linux/mm.h:1556:29: error:
 conflicting types for 'page_to_section'; have 'long unsigned int(const
 struct page *)'
Message-ID: <202206181437.AwvGIkuq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
head:   882be1ed6b1b5073fc88552181b99bd2b9c0031f
commit: d3b90b76e1013bb7e201bcccf5f5433f322f2123 [255/261] mm: convert destroy_compound_page() to destroy_large_folio()
config: parisc64-defconfig (https://download.01.org/0day-ci/archive/20220618/202206181437.AwvGIkuq-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=d3b90b76e1013bb7e201bcccf5f5433f322f2123
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch --no-tags akpm-mm mm-unstable
        git checkout d3b90b76e1013bb7e201bcccf5f5433f322f2123
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc64 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/parisc/include/asm/page.h:185,
                    from include/linux/shm.h:6,
                    from include/linux/sched.h:16,
                    from arch/parisc/kernel/asm-offsets.c:18:
   include/linux/mm.h: In function 'destroy_large_folio':
>> include/asm-generic/memory_model.h:35:21: error: implicit declaration of function 'page_to_section'; did you mean 'present_section'? [-Werror=implicit-function-declaration]
      35 |         int __sec = page_to_section(__pg);                      \
         |                     ^~~~~~~~~~~~~~~
   include/asm-generic/memory_model.h:40:32: note: in definition of macro '__pfn_to_page'
      40 | ({      unsigned long __pfn = (pfn);                    \
         |                                ^~~
   include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__page_to_pfn'
      52 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   include/linux/mm.h:214:38: note: in expansion of macro 'page_to_pfn'
     214 | #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
         |                                      ^~~~~~~~~~~
   include/linux/page-flags.h:307:33: note: in expansion of macro 'nth_page'
     307 | #define folio_page(folio, n)    nth_page(&(folio)->page, n)
         |                                 ^~~~~~~~
   include/linux/mm.h:928:38: note: in expansion of macro 'folio_page'
     928 |         enum compound_dtor_id dtor = folio_page(folio, 1)->compound_dtor;
         |                                      ^~~~~~~~~~
   In file included from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/parisc/kernel/asm-offsets.c:20:
   include/linux/mm.h: At top level:
>> include/linux/mm.h:1556:29: error: conflicting types for 'page_to_section'; have 'long unsigned int(const struct page *)'
    1556 | static inline unsigned long page_to_section(const struct page *page)
         |                             ^~~~~~~~~~~~~~~
   In file included from arch/parisc/include/asm/page.h:185,
                    from include/linux/shm.h:6,
                    from include/linux/sched.h:16,
                    from arch/parisc/kernel/asm-offsets.c:18:
   include/asm-generic/memory_model.h:35:21: note: previous implicit declaration of 'page_to_section' with type 'int()'
      35 |         int __sec = page_to_section(__pg);                      \
         |                     ^~~~~~~~~~~~~~~
   include/asm-generic/memory_model.h:40:32: note: in definition of macro '__pfn_to_page'
      40 | ({      unsigned long __pfn = (pfn);                    \
         |                                ^~~
   include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__page_to_pfn'
      52 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   include/linux/mm.h:214:38: note: in expansion of macro 'page_to_pfn'
     214 | #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
         |                                      ^~~~~~~~~~~
   include/linux/page-flags.h:307:33: note: in expansion of macro 'nth_page'
     307 | #define folio_page(folio, n)    nth_page(&(folio)->page, n)
         |                                 ^~~~~~~~
   include/linux/mm.h:928:38: note: in expansion of macro 'folio_page'
     928 |         enum compound_dtor_id dtor = folio_page(folio, 1)->compound_dtor;
         |                                      ^~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:117: arch/parisc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1200: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +1556 include/linux/mm.h

bf4e8902ee5080 Daniel Kiper      2011-05-24  1555  
aa462abe8aaf21 Ian Campbell      2011-08-17 @1556  static inline unsigned long page_to_section(const struct page *page)
d41dee369bff3b Andy Whitcroft    2005-06-23  1557  {
d41dee369bff3b Andy Whitcroft    2005-06-23  1558  	return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
d41dee369bff3b Andy Whitcroft    2005-06-23  1559  }
308c05e35e3517 Christoph Lameter 2008-04-28  1560  #endif
d41dee369bff3b Andy Whitcroft    2005-06-23  1561  

:::::: The code at line 1556 was first introduced by commit
:::::: aa462abe8aaf2198d6aef97da20c874ac694a39f mm: fix __page_to_pfn for a const struct page argument

:::::: TO: Ian Campbell <ian.campbell@citrix.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644D752A407
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243508AbiEQN6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242695AbiEQN5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:57:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5363C4A1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652795864; x=1684331864;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aWy8bNPEpHjAHXLrQDnZZEbIzZhyAqm2BwDjDzXiW1U=;
  b=giRDkdzXs2m06IkxsD4zaAPE6RFAdCnQR2V1KGhR4sfQNY1fRBeO/bXW
   s64+74pSVRfDaBrh+ydRWEbOfQX++DpNDnvrDbqmXl8KmDildEJpNHXRI
   k15pbZZnkTtP6J7t2fGU6YGPhocXM4J51/OE4TynFfgH4SN3Kbp94ovlx
   Skc3l1Hc6qjDuYjZrRevcxKc8hmttnmdRFWXkxOsb/gpKczw4kiAL4RFH
   7k9lVd7f9Wm6MYNj2kLWzivXkyPLoiCAGbOG9HJUP2EY+1zvPswLvOkHp
   uSsi79302UeZdpjXN+O0TIKCN+2nCXSz6IujeViwDqZyLqxZA9lLhb6MH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="357600931"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="357600931"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 06:57:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="605368886"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 May 2022 06:57:42 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqxhl-00010T-Jj;
        Tue, 17 May 2022 13:57:41 +0000
Date:   Tue, 17 May 2022 21:56:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 8/9]
 lib/test_free_pages.c:20:36: warning: incompatible integer to pointer
 conversion passing 'unsigned long' to parameter of type 'const void *'
Message-ID: <202205172107.C9n2wfmb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   67a8d6eb3d015908f35d6091c02f17d7c3b55bf3
commit: 52cbc963c5c9daba74109e9782e3487cdf48fe5c [8/9] ARM: Compile the kernel into VMALLOC
config: arm-randconfig-r021-20220516 (https://download.01.org/0day-ci/archive/20220517/202205172107.C9n2wfmb-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 853fa8ee225edf2d0de94b0dcbd31bea916e825e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=52cbc963c5c9daba74109e9782e3487cdf48fe5c
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout 52cbc963c5c9daba74109e9782e3487cdf48fe5c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash lib/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/test_free_pages.c:20:36: warning: incompatible integer to pointer conversion passing 'unsigned long' to parameter of type 'const void *' [-Wint-conversion]
                   struct page *page = virt_to_page(addr);
                                                    ^~~~
   arch/arm/include/asm/memory.h:442:53: note: expanded from macro 'virt_to_page'
   #define virt_to_page(kaddr)     pfn_to_page(virt_to_pfn(kaddr))
                                                           ^~~~~
   include/asm-generic/memory_model.h:40:27: note: expanded from macro '__pfn_to_page'
   ({      unsigned long __pfn = (pfn);                    \
                                  ^~~
   arch/arm/include/asm/memory.h:323:53: note: passing argument to parameter 'p' here
   static inline unsigned long virt_to_pfn(const void *p)
                                                       ^
   1 warning generated.


vim +20 lib/test_free_pages.c

e320d3012d25b1 Matthew Wilcox (Oracle  2020-10-13  13) 
e320d3012d25b1 Matthew Wilcox (Oracle  2020-10-13  14) static void test_free_pages(gfp_t gfp)
e320d3012d25b1 Matthew Wilcox (Oracle  2020-10-13  15) {
e320d3012d25b1 Matthew Wilcox (Oracle  2020-10-13  16) 	unsigned int i;
e320d3012d25b1 Matthew Wilcox (Oracle  2020-10-13  17) 
e320d3012d25b1 Matthew Wilcox (Oracle  2020-10-13  18) 	for (i = 0; i < 1000 * 1000; i++) {
e320d3012d25b1 Matthew Wilcox (Oracle  2020-10-13  19) 		unsigned long addr = __get_free_pages(gfp, 3);
e320d3012d25b1 Matthew Wilcox (Oracle  2020-10-13 @20) 		struct page *page = virt_to_page(addr);
e320d3012d25b1 Matthew Wilcox (Oracle  2020-10-13  21) 
e320d3012d25b1 Matthew Wilcox (Oracle  2020-10-13  22) 		/* Simulate page cache getting a speculative reference */
e320d3012d25b1 Matthew Wilcox (Oracle  2020-10-13  23) 		get_page(page);
e320d3012d25b1 Matthew Wilcox (Oracle  2020-10-13  24) 		free_pages(addr, 3);
e320d3012d25b1 Matthew Wilcox (Oracle  2020-10-13  25) 		put_page(page);
e320d3012d25b1 Matthew Wilcox (Oracle  2020-10-13  26) 	}
e320d3012d25b1 Matthew Wilcox (Oracle  2020-10-13  27) }
e320d3012d25b1 Matthew Wilcox (Oracle  2020-10-13  28) 

:::::: The code at line 20 was first introduced by commit
:::::: e320d3012d25b1fb5f3df4edb7bd44a1c362ec10 mm/page_alloc.c: fix freeing non-compound pages

:::::: TO: Matthew Wilcox (Oracle) <willy@infradead.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

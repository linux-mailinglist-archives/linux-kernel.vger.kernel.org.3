Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92905564ED7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiGDHiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiGDHiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:38:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986F6C23
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656920279; x=1688456279;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sBkoQtlKXPh3TSHiYDeLDi0AKqHX5D1X8cgBYlrxDkc=;
  b=Dq5zd/pWGXa3fCpcSx2qSbbsxoCvj5cSjpGI01aJ02fObPp0I6+xs6A5
   xApiRVlZkS/vS9yiSX6DRPVs0ePzyTvtvhulKutiQr2touXIIAyT6cTFz
   lKbXQQbvsnx/JB8b6P6bSzQwGNyIF7STNXw/Wr6lAToKzuDEmRN9BxFuq
   gBnHkOfrguDbFLZk3VOCtp+f3q1TftCsoJYQYCUGO15TUkX0qBHLubNy9
   QDm2jFpQAD8NnCEpR/PtbMk4GHCnJR9iKATn/odzAFWuTzDoFM9UQwpYw
   bBMzO/Um4YM6SEI2ADgqkhdi81LhfMkM4VlzHFdBR7MsgeUvB2JTs0i3O
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="283089999"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="283089999"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 00:37:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="567077227"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Jul 2022 00:37:57 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8Gea-000Hfj-FX;
        Mon, 04 Jul 2022 07:37:56 +0000
Date:   Mon, 4 Jul 2022 15:37:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [akpm-mm:mm-unstable 245/249] mm/memory-failure.c:1896:20: error:
 conflicting types for 'free_raw_hwp_pages'; have 'void(struct page *, bool)'
 {aka 'void(struct page *, _Bool)'}
Message-ID: <202207041521.EwJv2nMT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
head:   ce4dc6b0378ef1bd305c37c94fb8aabee4c5be04
commit: 06df85861209bbda16524e813ed959c09dee999b [245/249] mm, hwpoison: make unpoison aware of raw error info in hwpoisoned hugepage
config: parisc-randconfig-r014-20220703 (https://download.01.org/0day-ci/archive/20220704/202207041521.EwJv2nMT-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=06df85861209bbda16524e813ed959c09dee999b
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch --no-tags akpm-mm mm-unstable
        git checkout 06df85861209bbda16524e813ed959c09dee999b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/mmzone.h:21,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from mm/memory-failure.c:37:
   mm/memory-failure.c: In function 'raw_hwp_list_head':
   mm/memory-failure.c:1679:59: error: 'SUBPAGE_INDEX_HWPOISON' undeclared (first use in this function)
    1679 |         return (struct llist_head *)&page_private(hpage + SUBPAGE_INDEX_HWPOISON);
         |                                                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/mm_types.h:334:43: note: in definition of macro 'page_private'
     334 | #define page_private(page)              ((page)->private)
         |                                           ^~~~
   mm/memory-failure.c:1679:59: note: each undeclared identifier is reported only once for each function it appears in
    1679 |         return (struct llist_head *)&page_private(hpage + SUBPAGE_INDEX_HWPOISON);
         |                                                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/mm_types.h:334:43: note: in definition of macro 'page_private'
     334 | #define page_private(page)              ((page)->private)
         |                                           ^~~~
   mm/memory-failure.c: At top level:
>> mm/memory-failure.c:1896:20: error: conflicting types for 'free_raw_hwp_pages'; have 'void(struct page *, bool)' {aka 'void(struct page *, _Bool)'}
    1896 | static inline void free_raw_hwp_pages(struct page *hpage, bool move_flag)
         |                    ^~~~~~~~~~~~~~~~~~
   mm/memory-failure.c:1725:20: note: previous definition of 'free_raw_hwp_pages' with type 'long int(struct page *, bool)' {aka 'long int(struct page *, _Bool)'}
    1725 | static inline long free_raw_hwp_pages(struct page *hpage, bool move_flag)
         |                    ^~~~~~~~~~~~~~~~~~
   mm/memory-failure.c: In function 'unpoison_memory':
>> mm/memory-failure.c:2353:31: error: void value not ignored as it ought to be
    2353 |                         count = free_raw_hwp_pages(page, false);
         |                               ^
   mm/memory-failure.c:2363:31: error: void value not ignored as it ought to be
    2363 |                         count = free_raw_hwp_pages(page, false);
         |                               ^
   mm/memory-failure.c: In function 'raw_hwp_list_head':
   mm/memory-failure.c:1680:1: error: control reaches end of non-void function [-Werror=return-type]
    1680 | }
         | ^
   cc1: some warnings being treated as errors


vim +1896 mm/memory-failure.c

  1895	
> 1896	static inline void free_raw_hwp_pages(struct page *hpage, bool move_flag)
  1897	{
  1898	}
  1899	#endif	/* CONFIG_HUGETLB_PAGE */
  1900	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

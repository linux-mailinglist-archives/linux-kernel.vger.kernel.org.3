Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0FD4B585E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356591AbiBNRUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:20:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbiBNRUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:20:40 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70774652D4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644859232; x=1676395232;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KbM5Fe5c3mdB4yDzDaP/4hUQUtRmyMGrS8a/5fb9PBo=;
  b=AZB9ZbdKahUzLBONe+/TvmGldr1vIVgR2zxt9i3ZUFSG59bHirmaRLDe
   BRzOpfwxb8ENz2Mb2dISV3VRnmshJj0Ufwxlyz1v5JslDnX19CW8jVUnG
   GsbzGsWBopI2yMAo4aZf7NYi805puJ+MLhs8Vk80vwYR4YTgeCpM7VOrK
   LFVLO9MghatymxKrx6iPGRM+8c1GLSxGonbEp8XMfkKpO5y/1Bk6D4w+f
   y1gl2CLSP67n0NU7ShAezOKwm7HnOytuPS3oKuFuROiR+ZpPgWUb5+7Hp
   P5XI2OWt8E+xLKHA8WDcSEk1G9+UXxsPrqqGqvpkGsA2kI0eg4UWqlmGN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="249887908"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="249887908"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 09:20:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="680606165"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2022 09:20:14 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJf1J-0008ms-WD; Mon, 14 Feb 2022 17:20:13 +0000
Date:   Tue, 15 Feb 2022 01:19:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [willy-pagecache:for-next 58/85] mm/folio-compat.c:181:9: error:
 implicit declaration of function 'folio_mlock'; did you mean 'folio_lock'?
Message-ID: <202202142352.7A4VgqBz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.infradead.org/users/willy/pagecache for-next
head:   c267b33d0001488f1d9dad12d6a87655e174d914
commit: 2cefeaf011db4a95ecb515cc2ca61d091a792ac1 [58/85] mm/rmap: Turn page_mlock() into folio_mlock()
config: h8300-alldefconfig (https://download.01.org/0day-ci/archive/20220214/202202142352.7A4VgqBz-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add willy-pagecache git://git.infradead.org/users/willy/pagecache
        git fetch --no-tags willy-pagecache for-next
        git checkout 2cefeaf011db4a95ecb515cc2ca61d091a792ac1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=h8300 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/folio-compat.c:169:6: warning: no previous prototype for 'clear_page_mlock' [-Wmissing-prototypes]
     169 | void clear_page_mlock(struct page *page)
         |      ^~~~~~~~~~~~~~~~
   mm/folio-compat.c:174:6: error: redefinition of 'mlock_vma_page'
     174 | void mlock_vma_page(struct page *page)
         |      ^~~~~~~~~~~~~~
   In file included from mm/folio-compat.c:11:
   mm/internal.h:503:20: note: previous definition of 'mlock_vma_page' with type 'void(struct page *)'
     503 | static inline void mlock_vma_page(struct page *page) { }
         |                    ^~~~~~~~~~~~~~
   mm/folio-compat.c: In function 'mlock_vma_page':
   mm/folio-compat.c:176:9: error: implicit declaration of function 'mlock_vma_folio'; did you mean 'mlock_vma_page'? [-Werror=implicit-function-declaration]
     176 |         mlock_vma_folio(page_folio(page));
         |         ^~~~~~~~~~~~~~~
         |         mlock_vma_page
   mm/folio-compat.c: At top level:
   mm/folio-compat.c:179:6: warning: no previous prototype for 'page_mlock' [-Wmissing-prototypes]
     179 | void page_mlock(struct page *page)
         |      ^~~~~~~~~~
   mm/folio-compat.c: In function 'page_mlock':
>> mm/folio-compat.c:181:9: error: implicit declaration of function 'folio_mlock'; did you mean 'folio_lock'? [-Werror=implicit-function-declaration]
     181 |         folio_mlock(page_folio(page));
         |         ^~~~~~~~~~~
         |         folio_lock
   cc1: some warnings being treated as errors


vim +181 mm/folio-compat.c

   178	
   179	void page_mlock(struct page *page)
   180	{
 > 181		folio_mlock(page_folio(page));

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D064D9782
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346534AbiCOJUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238771AbiCOJUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:20:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E6D12746
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647335960; x=1678871960;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mOFcMha9lGU6SAQcFxJpsmFvzoA1gfVUel4ZN309wsE=;
  b=haIR6CXdIwKSeLSgncRBRoVolt4kQxEuhgh4vKrMmp4uKHj40oIDXsbn
   MxLRIbKiDza15YCLDQ7Ky1nvMVjRd891qucgTgSvCSlGq6SkOn7EDDRYz
   r9XVzFCjSYQO+PAMLCoGo5hPtc+CTAau52cTJXmJkb+RX4DZkPACmCe9a
   eAwuYb9sI4uH3LTKxOT5AVgpHiayao424wXALf5oAw6gPwZDG0VN17Mqt
   SLxGbRzDRW4M78A8BGyQubspnI50OyuBI0ZP5+a3N5Wr6lJA+ge0VWaAe
   QPLVZVijVxTf057Rp1QzYfLaiNAXG/zg8LYG5g3RetHBPycyxLUXxvUWw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281022871"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="281022871"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 02:19:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="646153947"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Mar 2022 02:19:19 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nU3Ko-000An0-OH; Tue, 15 Mar 2022 09:19:18 +0000
Date:   Tue, 15 Mar 2022 17:18:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [willy-pagecache:for-next 131/179] mm/readahead.c:54:3: error:
 implicit declaration of function 'do_invalidatepage'
Message-ID: <202203151757.XY2I8yuS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.infradead.org/users/willy/pagecache for-next
head:   af564d7369d44fbbe697a5f631fe3bba5ebecd59
commit: f1fdabbaae8eb5c9a95a3747065a40297e7d2736 [131/179] fs: Turn do_invalidatepage() into folio_invalidate()
config: arm-cns3420vb_defconfig (https://download.01.org/0day-ci/archive/20220315/202203151757.XY2I8yuS-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6b2f50fb47da3baeee10b1906da6e30ac5d26ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git remote add willy-pagecache git://git.infradead.org/users/willy/pagecache
        git fetch --no-tags willy-pagecache for-next
        git checkout f1fdabbaae8eb5c9a95a3747065a40297e7d2736
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/readahead.c:54:3: error: implicit declaration of function 'do_invalidatepage' [-Werror,-Wimplicit-function-declaration]
                   do_invalidatepage(page, 0, PAGE_SIZE);
                   ^
   mm/readahead.c:54:3: note: did you mean 'noop_invalidatepage'?
   include/linux/fs.h:3325:13: note: 'noop_invalidatepage' declared here
   extern void noop_invalidatepage(struct page *page, unsigned int offset,
               ^
   1 error generated.


vim +/do_invalidatepage +54 mm/readahead.c

^1da177e4c3f41 Linus Torvalds     2005-04-16  39  
03fb3d2af96c27 David Howells      2009-04-03  40  /*
03fb3d2af96c27 David Howells      2009-04-03  41   * see if a page needs releasing upon read_cache_pages() failure
266cf658efcf6a David Howells      2009-04-03  42   * - the caller of read_cache_pages() may have set PG_private or PG_fscache
266cf658efcf6a David Howells      2009-04-03  43   *   before calling, such as the NFS fs marking pages that are cached locally
266cf658efcf6a David Howells      2009-04-03  44   *   on disk, thus we need to give the fs a chance to clean up in the event of
266cf658efcf6a David Howells      2009-04-03  45   *   an error
03fb3d2af96c27 David Howells      2009-04-03  46   */
03fb3d2af96c27 David Howells      2009-04-03  47  static void read_cache_pages_invalidate_page(struct address_space *mapping,
03fb3d2af96c27 David Howells      2009-04-03  48  					     struct page *page)
03fb3d2af96c27 David Howells      2009-04-03  49  {
266cf658efcf6a David Howells      2009-04-03  50  	if (page_has_private(page)) {
03fb3d2af96c27 David Howells      2009-04-03  51  		if (!trylock_page(page))
03fb3d2af96c27 David Howells      2009-04-03  52  			BUG();
03fb3d2af96c27 David Howells      2009-04-03  53  		page->mapping = mapping;
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01 @54  		do_invalidatepage(page, 0, PAGE_SIZE);
03fb3d2af96c27 David Howells      2009-04-03  55  		page->mapping = NULL;
03fb3d2af96c27 David Howells      2009-04-03  56  		unlock_page(page);
03fb3d2af96c27 David Howells      2009-04-03  57  	}
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  58  	put_page(page);
03fb3d2af96c27 David Howells      2009-04-03  59  }
03fb3d2af96c27 David Howells      2009-04-03  60  

:::::: The code at line 54 was first introduced by commit
:::::: 09cbfeaf1a5a67bfb3201e0c83c810cecb2efa5a mm, fs: get rid of PAGE_CACHE_* and page_cache_{get,release} macros

:::::: TO: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

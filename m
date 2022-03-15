Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087124D94FC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343546AbiCOHGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238411AbiCOHGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:06:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412C634642
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647327906; x=1678863906;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aCLvxFHzMVflejNSYWs6bl3tgEDd+bP4jqHmtxth9zA=;
  b=UBaI0e7hs+rfgxnOKHo7+4p96q9n477MHXHmU2k+cX8NeoTG/c7v5jK4
   U42CPcUZvF9J3ikWXzxzh/9Jv0LgiFlShhJXcVJZ3ZeiqpBm3PehbAWDt
   RqV17pactaUEcU2H1QV9Ny//iWqM78YKY4BL6pJOklSrNtuLHIgpdnoOU
   tUDzfWgQEtY/RGLmsHXqHsc6QRJgQcfvJiDGyFX+OEXTWYsmNE+ix8yCl
   vnNjaQq9tztwpGz8X2C2mJzzTcE1y/bv4iHi+1qox7EY7I+42h+VdRYQp
   MIFiNznQ0Xc9Cxs6O64Codi8KbY3r/xLvdMWdHSDzJwZrty4Bj1XtcmdX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256420761"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="256420761"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 00:05:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="556795067"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 15 Mar 2022 00:04:59 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nU1Ep-000Afo-2K; Tue, 15 Mar 2022 07:04:59 +0000
Date:   Tue, 15 Mar 2022 15:04:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [willy-pagecache:for-next 131/179] mm/readahead.c:54:3: error:
 implicit declaration of function 'do_invalidatepage'; did you mean
 'noop_invalidatepage'?
Message-ID: <202203151544.J2Qcx5YQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.infradead.org/users/willy/pagecache for-next
head:   af564d7369d44fbbe697a5f631fe3bba5ebecd59
commit: f1fdabbaae8eb5c9a95a3747065a40297e7d2736 [131/179] fs: Turn do_invalidatepage() into folio_invalidate()
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20220315/202203151544.J2Qcx5YQ-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        git remote add willy-pagecache git://git.infradead.org/users/willy/pagecache
        git fetch --no-tags willy-pagecache for-next
        git checkout f1fdabbaae8eb5c9a95a3747065a40297e7d2736
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/readahead.c: In function 'read_cache_pages_invalidate_page':
>> mm/readahead.c:54:3: error: implicit declaration of function 'do_invalidatepage'; did you mean 'noop_invalidatepage'? [-Werror=implicit-function-declaration]
      54 |   do_invalidatepage(page, 0, PAGE_SIZE);
         |   ^~~~~~~~~~~~~~~~~
         |   noop_invalidatepage
   cc1: some warnings being treated as errors


vim +54 mm/readahead.c

^1da177e4c3f415 Linus Torvalds     2005-04-16  39  
03fb3d2af96c278 David Howells      2009-04-03  40  /*
03fb3d2af96c278 David Howells      2009-04-03  41   * see if a page needs releasing upon read_cache_pages() failure
266cf658efcf6ac David Howells      2009-04-03  42   * - the caller of read_cache_pages() may have set PG_private or PG_fscache
266cf658efcf6ac David Howells      2009-04-03  43   *   before calling, such as the NFS fs marking pages that are cached locally
266cf658efcf6ac David Howells      2009-04-03  44   *   on disk, thus we need to give the fs a chance to clean up in the event of
266cf658efcf6ac David Howells      2009-04-03  45   *   an error
03fb3d2af96c278 David Howells      2009-04-03  46   */
03fb3d2af96c278 David Howells      2009-04-03  47  static void read_cache_pages_invalidate_page(struct address_space *mapping,
03fb3d2af96c278 David Howells      2009-04-03  48  					     struct page *page)
03fb3d2af96c278 David Howells      2009-04-03  49  {
266cf658efcf6ac David Howells      2009-04-03  50  	if (page_has_private(page)) {
03fb3d2af96c278 David Howells      2009-04-03  51  		if (!trylock_page(page))
03fb3d2af96c278 David Howells      2009-04-03  52  			BUG();
03fb3d2af96c278 David Howells      2009-04-03  53  		page->mapping = mapping;
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01 @54  		do_invalidatepage(page, 0, PAGE_SIZE);
03fb3d2af96c278 David Howells      2009-04-03  55  		page->mapping = NULL;
03fb3d2af96c278 David Howells      2009-04-03  56  		unlock_page(page);
03fb3d2af96c278 David Howells      2009-04-03  57  	}
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01  58  	put_page(page);
03fb3d2af96c278 David Howells      2009-04-03  59  }
03fb3d2af96c278 David Howells      2009-04-03  60  

:::::: The code at line 54 was first introduced by commit
:::::: 09cbfeaf1a5a67bfb3201e0c83c810cecb2efa5a mm, fs: get rid of PAGE_CACHE_* and page_cache_{get,release} macros

:::::: TO: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

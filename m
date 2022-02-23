Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5344C0CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbiBWGxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbiBWGxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:53:49 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D2B6E4D7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 22:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645599202; x=1677135202;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hz66yamgSPcK6ReMvpFGXRaca4CTfCu9WiXkPmGGFW4=;
  b=cqgosRc4/hJbV/rEHuTSMyPSGTWbix+rLmJIGNlr8tGM1kMZRC3itI2R
   wU9vE1PFdzgxLRdKiTBJLwRV9mEeH0HRYICAK1ljAWMtJd2MdCch/2pzJ
   G9g9vErgvdd9LiE5Cj0YEc4Qa1bKr+QuEsQcriCZC1CAzh9GART3Kcqd5
   n9h28ex78UOPbYyug5PHr+xSn3TLeDe0f6gL1ZGBd9FMDTCfOz5srs4HO
   Vq6l1/FviuEzFRTr8qVqun8MtPwA1JhOyzuT5XnHq87vILdKC7TdDFHlk
   mCmKg0b+XQj4stQJEw/Y4F0sBYVxy5vsCfuvFfeTW7JxO8AHiwaiKTaBQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="239287292"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="239287292"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 22:53:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="637308579"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 22 Feb 2022 22:53:19 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMlWY-000169-Cq; Wed, 23 Feb 2022 06:53:18 +0000
Date:   Wed, 23 Feb 2022 14:52:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [davidhildenbrand:cow_fixes_part_2 11/25]
 mm/memory-failure.c:1465:19: warning: parameter 'page_flags' set but not
 used
Message-ID: <202202231420.BvLSwH9N-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/davidhildenbrand/linux cow_fixes_part_2
head:   f818ce6b393017761287bf06620a25d322639053
commit: 6a6823bd941bee73b1a65936f6d2c70d2c3bc086 [11/25] mm/page-flags: reuse PG_slab as PG_anon_exclusive for PageAnon() pages
config: i386-randconfig-a012-20220221 (https://download.01.org/0day-ci/archive/20220223/202202231420.BvLSwH9N-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/davidhildenbrand/linux/commit/6a6823bd941bee73b1a65936f6d2c70d2c3bc086
        git remote add davidhildenbrand git://github.com/davidhildenbrand/linux
        git fetch --no-tags davidhildenbrand cow_fixes_part_2
        git checkout 6a6823bd941bee73b1a65936f6d2c70d2c3bc086
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/memory-failure.c:1465:19: warning: parameter 'page_flags' set but not used [-Wunused-but-set-parameter]
                                   unsigned long page_flags)
                                                 ^
   1 warning generated.


vim +/page_flags +1465 mm/memory-failure.c

6a46079cf57a7f7 Andi Kleen        2009-09-16  1463  
0348d2ebec9b00e Naoya Horiguchi   2017-07-10  1464  static int identify_page_state(unsigned long pfn, struct page *p,
0348d2ebec9b00e Naoya Horiguchi   2017-07-10 @1465  				unsigned long page_flags)
761ad8d7c7b5485 Naoya Horiguchi   2017-07-10  1466  {
761ad8d7c7b5485 Naoya Horiguchi   2017-07-10  1467  	struct page_state *ps;
0348d2ebec9b00e Naoya Horiguchi   2017-07-10  1468  
0348d2ebec9b00e Naoya Horiguchi   2017-07-10  1469  	/*
0348d2ebec9b00e Naoya Horiguchi   2017-07-10  1470  	 * The first check uses the current page flags which may not have any
0348d2ebec9b00e Naoya Horiguchi   2017-07-10  1471  	 * relevant information. The second check with the saved page flags is
0348d2ebec9b00e Naoya Horiguchi   2017-07-10  1472  	 * carried out only if the first check can't determine the page status.
6a6823bd941bee7 David Hildenbrand 2021-12-20  1473  	 *
6a6823bd941bee7 David Hildenbrand 2021-12-20  1474  	 * Note that PG_slab is also used as PG_anon_exclusive for PageAnon()
6a6823bd941bee7 David Hildenbrand 2021-12-20  1475  	 * pages. Most of these pages should have been handled previously,
6a6823bd941bee7 David Hildenbrand 2021-12-20  1476  	 * however, let's play safe and verify via PageAnon().
0348d2ebec9b00e Naoya Horiguchi   2017-07-10  1477  	 */
6a6823bd941bee7 David Hildenbrand 2021-12-20  1478  	for (ps = error_states;; ps++) {
6a6823bd941bee7 David Hildenbrand 2021-12-20  1479  		if ((p->flags & ps->mask) != ps->res)
6a6823bd941bee7 David Hildenbrand 2021-12-20  1480  			continue;
6a6823bd941bee7 David Hildenbrand 2021-12-20  1481  		if ((ps->type == MF_MSG_SLAB) && PageAnon(p))
6a6823bd941bee7 David Hildenbrand 2021-12-20  1482  			continue;
0348d2ebec9b00e Naoya Horiguchi   2017-07-10  1483  		break;
6a6823bd941bee7 David Hildenbrand 2021-12-20  1484  	}
0348d2ebec9b00e Naoya Horiguchi   2017-07-10  1485  
0348d2ebec9b00e Naoya Horiguchi   2017-07-10  1486  	page_flags |= (p->flags & (1UL << PG_dirty));
0348d2ebec9b00e Naoya Horiguchi   2017-07-10  1487  
0348d2ebec9b00e Naoya Horiguchi   2017-07-10  1488  	if (!ps->mask)
6a6823bd941bee7 David Hildenbrand 2021-12-20  1489  		for (ps = error_states;; ps++) {
6a6823bd941bee7 David Hildenbrand 2021-12-20  1490  			if ((p->flags & ps->mask) != ps->res)
6a6823bd941bee7 David Hildenbrand 2021-12-20  1491  				continue;
6a6823bd941bee7 David Hildenbrand 2021-12-20  1492  			if ((ps->type == MF_MSG_SLAB) && PageAnon(p))
6a6823bd941bee7 David Hildenbrand 2021-12-20  1493  				continue;
0348d2ebec9b00e Naoya Horiguchi   2017-07-10  1494  			break;
6a6823bd941bee7 David Hildenbrand 2021-12-20  1495  		}
0348d2ebec9b00e Naoya Horiguchi   2017-07-10  1496  	return page_action(ps, p, pfn);
0348d2ebec9b00e Naoya Horiguchi   2017-07-10  1497  }
0348d2ebec9b00e Naoya Horiguchi   2017-07-10  1498  

:::::: The code at line 1465 was first introduced by commit
:::::: 0348d2ebec9b00ea87b42dffdb3f393007303b82 mm: hwpoison: introduce idenfity_page_state

:::::: TO: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21BC550C87
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 20:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbiFSSVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 14:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiFSSVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 14:21:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90273765C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 11:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655662869; x=1687198869;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ISdsMX8AZREPhr5s0k5z11ipC8khu3xTR28v4N7gXc0=;
  b=P1zD8EB74jRHlxvTJBRmd+HoBZ4QWG0C8SfwhHC96zcDLJDVmsLAz/8z
   W80NlbUQwi/qfyUIpm4n0SKRpGsN5NUcuZrspPCxb48zhW4BDqlpBD9hn
   P/LtbwFlRyVVocOKZU/YG+kDeLVXkpvhVUlAmqiVs3U7cbuqM9v3VeVsp
   Fb1c+jBqFyJO4jAyzlNPThitewG1+deHzZxWR9eEhye3EN7Gth6hFrNTC
   YB20YWaV3kTXu8grzq5TNZ+6+r/sWwouMs8umC6CbHzi8WZ5ipgeWslxm
   WWxHRUIyD4mAngsraqzQ55u+Sf2ZbigeNxpsaGlZHpQ8pl3bhAix2WIu6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="259572520"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="259572520"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 11:21:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="561676782"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Jun 2022 11:21:07 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2zXm-000RSG-Op;
        Sun, 19 Jun 2022 18:21:06 +0000
Date:   Mon, 20 Jun 2022 02:21:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [willy-pagecache:for-next 3/81] mm/huge_memory.c:2380:21: warning:
 incompatible pointer to integer conversion assigning to 'unsigned long' from
 'void *'
Message-ID: <202206200151.WMsNVIYY-lkp@intel.com>
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

tree:   git://git.infradead.org/users/willy/pagecache for-next
head:   a4483039b0e88f52c72975b99ea131a111b35a8e
commit: ddf632ba3fd866d92f0ec9343984c6b2c18a788c [3/81] mm: Clear page->private when splitting or migrating a page
config: s390-randconfig-r033-20220619 (https://download.01.org/0day-ci/archive/20220620/202206200151.WMsNVIYY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        git remote add willy-pagecache git://git.infradead.org/users/willy/pagecache
        git fetch --no-tags willy-pagecache for-next
        git checkout ddf632ba3fd866d92f0ec9343984c6b2c18a788c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/huge_memory.c:2380:21: warning: incompatible pointer to integer conversion assigning to 'unsigned long' from 'void *' [-Wint-conversion]
           page_tail->private = NULL;
                              ^ ~~~~
   1 warning generated.


vim +2380 mm/huge_memory.c

  2338	
  2339	static void __split_huge_page_tail(struct page *head, int tail,
  2340			struct lruvec *lruvec, struct list_head *list)
  2341	{
  2342		struct page *page_tail = head + tail;
  2343	
  2344		VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) != -1, page_tail);
  2345	
  2346		/*
  2347		 * Clone page flags before unfreezing refcount.
  2348		 *
  2349		 * After successful get_page_unless_zero() might follow flags change,
  2350		 * for example lock_page() which set PG_waiters.
  2351		 *
  2352		 * Note that for mapped sub-pages of an anonymous THP,
  2353		 * PG_anon_exclusive has been cleared in unmap_page() and is stored in
  2354		 * the migration entry instead from where remap_page() will restore it.
  2355		 * We can still have PG_anon_exclusive set on effectively unmapped and
  2356		 * unreferenced sub-pages of an anonymous THP: we can simply drop
  2357		 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
  2358		 */
  2359		page_tail->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
  2360		page_tail->flags |= (head->flags &
  2361				((1L << PG_referenced) |
  2362				 (1L << PG_swapbacked) |
  2363				 (1L << PG_swapcache) |
  2364				 (1L << PG_mlocked) |
  2365				 (1L << PG_uptodate) |
  2366				 (1L << PG_active) |
  2367				 (1L << PG_workingset) |
  2368				 (1L << PG_locked) |
  2369				 (1L << PG_unevictable) |
  2370	#ifdef CONFIG_64BIT
  2371				 (1L << PG_arch_2) |
  2372	#endif
  2373				 (1L << PG_dirty)));
  2374	
  2375		/* ->mapping in first tail page is compound_mapcount */
  2376		VM_BUG_ON_PAGE(tail > 2 && page_tail->mapping != TAIL_MAPPING,
  2377				page_tail);
  2378		page_tail->mapping = head->mapping;
  2379		page_tail->index = head->index + tail;
> 2380		page_tail->private = NULL;
  2381	
  2382		/* Page flags must be visible before we make the page non-compound. */
  2383		smp_wmb();
  2384	
  2385		/*
  2386		 * Clear PageTail before unfreezing page refcount.
  2387		 *
  2388		 * After successful get_page_unless_zero() might follow put_page()
  2389		 * which needs correct compound_head().
  2390		 */
  2391		clear_compound_head(page_tail);
  2392	
  2393		/* Finally unfreeze refcount. Additional reference from page cache. */
  2394		page_ref_unfreeze(page_tail, 1 + (!PageAnon(head) ||
  2395						  PageSwapCache(head)));
  2396	
  2397		if (page_is_young(head))
  2398			set_page_young(page_tail);
  2399		if (page_is_idle(head))
  2400			set_page_idle(page_tail);
  2401	
  2402		page_cpupid_xchg_last(page_tail, page_cpupid_last(head));
  2403	
  2404		/*
  2405		 * always add to the tail because some iterators expect new
  2406		 * pages to show after the currently processed elements - e.g.
  2407		 * migrate_pages
  2408		 */
  2409		lru_add_page_tail(head, page_tail, lruvec, list);
  2410	}
  2411	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

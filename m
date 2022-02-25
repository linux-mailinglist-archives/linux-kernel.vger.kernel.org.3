Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AE54C451B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240834AbiBYM7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbiBYM7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:59:41 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E711EBAB9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645793949; x=1677329949;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zzyMkt+E/b9JWUhce81/inYC/zD/96uFg3dHfMLRRbM=;
  b=mGzhhN237kmTaJQRKm7mhU9nuaK4fzBG5JuIdnHXIiCZrTrjfBZcuFtb
   C554oXxO7nu//djMGSiw6+XdGB/S8RAGmM6/lkKkKOejE4MUbK7I95YBh
   G/bhyqsLytKq8CRbOPWnYdaWs+31WfPWMDxybXiOWokqj7Ax8QHURzrOw
   W+7KVBwz62rAp2teYLvZOO/RvZJseAcaswpiGMLDPShYLwZ0Pf7r051vX
   1ek0jfzAMNdaZzcEgwrzjCFpm6Nynmu1giIWqiFq9aJJ4bURdXGUSGrMH
   nCt3kO8USLBMW6iIJ6JL2F7xiUphLswksOFsTj/aAh8zaQf6RXz14PWxl
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="313207602"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="313207602"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 04:59:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="640106898"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 Feb 2022 04:59:08 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNaBf-0004Jz-Fg; Fri, 25 Feb 2022 12:59:07 +0000
Date:   Fri, 25 Feb 2022 20:58:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [davidhildenbrand:cow_fixes_part_2_v1 14/29] mm/rmap.c:1193:39:
 sparse: sparse: incorrect type in argument 4 (different base types)
Message-ID: <202202252038.ij1YGn0d-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/davidhildenbrand/linux cow_fixes_part_2_v1
head:   92edd2765af5ab60b1b596939ebbcb705f911a34
commit: 1429b19ab48e137cbae1bc629e2afe47aab932c4 [14/29] mm/rmap: convert RMAP flags to proper a distinct rmap_t type
config: sparc-randconfig-s031-20220225 (https://download.01.org/0day-ci/archive/20220225/202202252038.ij1YGn0d-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/davidhildenbrand/linux/commit/1429b19ab48e137cbae1bc629e2afe47aab932c4
        git remote add davidhildenbrand git://github.com/davidhildenbrand/linux
        git fetch --no-tags davidhildenbrand cow_fixes_part_2_v1
        git checkout 1429b19ab48e137cbae1bc629e2afe47aab932c4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> mm/rmap.c:1193:39: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected int exclusive @@     got restricted rmap_t @@
   mm/rmap.c:1193:39: sparse:     expected int exclusive
   mm/rmap.c:1193:39: sparse:     got restricted rmap_t
   mm/rmap.c: note: in included file (through include/linux/ksm.h):
   include/linux/rmap.h:282:28: sparse: sparse: context imbalance in 'page_referenced_one' - unexpected unlock
   include/linux/rmap.h:282:28: sparse: sparse: context imbalance in 'try_to_unmap_one' - unexpected unlock
   include/linux/rmap.h:282:28: sparse: sparse: context imbalance in 'try_to_migrate_one' - unexpected unlock
   include/linux/rmap.h:282:28: sparse: sparse: context imbalance in 'page_mlock_one' - unexpected unlock

vim +1193 mm/rmap.c

ad8c2ee801ad7a Rik van Riel            2010-08-09  1145  
ad8c2ee801ad7a Rik van Riel            2010-08-09  1146  /*
ad8c2ee801ad7a Rik van Riel            2010-08-09  1147   * Special version of the above for do_swap_page, which often runs
ad8c2ee801ad7a Rik van Riel            2010-08-09  1148   * into pages that are exclusively owned by the current process.
ad8c2ee801ad7a Rik van Riel            2010-08-09  1149   * Everybody else should continue to use page_add_anon_rmap above.
ad8c2ee801ad7a Rik van Riel            2010-08-09  1150   */
ad8c2ee801ad7a Rik van Riel            2010-08-09  1151  void do_page_add_anon_rmap(struct page *page,
1429b19ab48e13 David Hildenbrand       2022-02-25  1152  	struct vm_area_struct *vma, unsigned long address, rmap_t flags)
9617d95e6e9ffd Nicholas Piggin         2006-01-06  1153  {
d281ee61451835 Kirill A. Shutemov      2016-01-15  1154  	bool compound = flags & RMAP_COMPOUND;
53f9263baba69f Kirill A. Shutemov      2016-01-15  1155  	bool first;
53f9263baba69f Kirill A. Shutemov      2016-01-15  1156  
be5d0a74c62d8d Johannes Weiner         2020-06-03  1157  	if (unlikely(PageKsm(page)))
be5d0a74c62d8d Johannes Weiner         2020-06-03  1158  		lock_page_memcg(page);
be5d0a74c62d8d Johannes Weiner         2020-06-03  1159  	else
be5d0a74c62d8d Johannes Weiner         2020-06-03  1160  		VM_BUG_ON_PAGE(!PageLocked(page), page);
be5d0a74c62d8d Johannes Weiner         2020-06-03  1161  
53f9263baba69f Kirill A. Shutemov      2016-01-15  1162  	if (compound) {
53f9263baba69f Kirill A. Shutemov      2016-01-15  1163  		atomic_t *mapcount;
e9b61f19858a5d Kirill A. Shutemov      2016-01-15  1164  		VM_BUG_ON_PAGE(!PageLocked(page), page);
53f9263baba69f Kirill A. Shutemov      2016-01-15  1165  		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
53f9263baba69f Kirill A. Shutemov      2016-01-15  1166  		mapcount = compound_mapcount_ptr(page);
53f9263baba69f Kirill A. Shutemov      2016-01-15  1167  		first = atomic_inc_and_test(mapcount);
53f9263baba69f Kirill A. Shutemov      2016-01-15  1168  	} else {
53f9263baba69f Kirill A. Shutemov      2016-01-15  1169  		first = atomic_inc_and_test(&page->_mapcount);
53f9263baba69f Kirill A. Shutemov      2016-01-15  1170  	}
53f9263baba69f Kirill A. Shutemov      2016-01-15  1171  
53f9263baba69f Kirill A. Shutemov      2016-01-15  1172  	if (first) {
6c357848b44b40 Matthew Wilcox (Oracle  2020-08-14  1173) 		int nr = compound ? thp_nr_pages(page) : 1;
bea04b073292b2 Jianyu Zhan             2014-06-04  1174  		/*
bea04b073292b2 Jianyu Zhan             2014-06-04  1175  		 * We use the irq-unsafe __{inc|mod}_zone_page_stat because
bea04b073292b2 Jianyu Zhan             2014-06-04  1176  		 * these counters are not modified in interrupt context, and
bea04b073292b2 Jianyu Zhan             2014-06-04  1177  		 * pte lock(a spinlock) is held, which implies preemption
bea04b073292b2 Jianyu Zhan             2014-06-04  1178  		 * disabled.
bea04b073292b2 Jianyu Zhan             2014-06-04  1179  		 */
65c453778aea37 Kirill A. Shutemov      2016-07-26  1180  		if (compound)
69473e5de87389 Muchun Song             2021-02-24  1181  			__mod_lruvec_page_state(page, NR_ANON_THPS, nr);
be5d0a74c62d8d Johannes Weiner         2020-06-03  1182  		__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
79134171df2381 Andrea Arcangeli        2011-01-13  1183  	}
5ad6468801d28c Hugh Dickins            2009-12-14  1184  
be5d0a74c62d8d Johannes Weiner         2020-06-03  1185  	if (unlikely(PageKsm(page))) {
be5d0a74c62d8d Johannes Weiner         2020-06-03  1186  		unlock_page_memcg(page);
be5d0a74c62d8d Johannes Weiner         2020-06-03  1187  		return;
be5d0a74c62d8d Johannes Weiner         2020-06-03  1188  	}
53f9263baba69f Kirill A. Shutemov      2016-01-15  1189  
5dbe0af47f8a8f Hugh Dickins            2011-05-28  1190  	/* address might be in next vma when migration races vma_adjust */
5ad6468801d28c Hugh Dickins            2009-12-14  1191  	if (first)
d281ee61451835 Kirill A. Shutemov      2016-01-15  1192  		__page_set_anon_rmap(page, vma, address,
d281ee61451835 Kirill A. Shutemov      2016-01-15 @1193  				flags & RMAP_EXCLUSIVE);
69029cd550284e KAMEZAWA Hiroyuki       2008-07-25  1194  	else
c97a9e10eaee32 Nicholas Piggin         2007-05-16  1195  		__page_check_anon_rmap(page, vma, address);
^1da177e4c3f41 Linus Torvalds          2005-04-16  1196  }
^1da177e4c3f41 Linus Torvalds          2005-04-16  1197  

:::::: The code at line 1193 was first introduced by commit
:::::: d281ee6145183594788ab6d5b55f8d144e69eace rmap: add argument to charge compound page

:::::: TO: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

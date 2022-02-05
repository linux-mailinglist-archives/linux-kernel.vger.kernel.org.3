Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED084AA7C0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 09:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377762AbiBEIzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 03:55:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:21426 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232461AbiBEIzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 03:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644051322; x=1675587322;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SyDz2NJUoyxuBxKKckbAGqnNny1+MXQAEdtZ4mbLKaI=;
  b=TeA2JIPuMIcagsV+5BhpVtX3AlcdPWJNQjdI9Q61tc70C27icqWTd4LH
   DN0bu6z4Fu725TI4RS7W6NUwbimxNGl5qD28snVztJtnImt9enB8GjAez
   vU2VjJ1GNfeWb3RnnuGPI9Y84Izgm2v3mT/LCcJCsZlzFyNwnhcedJW8T
   pjuhTeDmqNB2Pkiknxcl5xUHDiSSEZ+cNpww1+zQTm70N+oIwWTjnDkeM
   Tk/9ECwWFxJBXtsOcoD061cs33FgtgPdwD6jJyGnF6Tr2Tu4MYWig+YBU
   9W2ubt7RF934/DALYy8ntgfajoOF9Ox3/BUYA6PVN42bZkEH37H/rusxk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="229149793"
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="229149793"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 00:55:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="483865084"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Feb 2022 00:55:19 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGGql-000Yov-7q; Sat, 05 Feb 2022 08:55:19 +0000
Date:   Sat, 5 Feb 2022 16:54:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [willy-pagecache:for-next 12/75] mm/hugetlb.c:1323:10: error:
 'struct page' has no member named 'compound_nr'; did you mean
 'compound_dtor'?
Message-ID: <202202051611.dqFyOKso-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.infradead.org/users/willy/pagecache for-next
head:   69178cc72889fc46880322c250dfd7546f66cc2c
commit: d47177a50ad8d30bb952949f8a6cc1809d7c74df [12/75] mm: Make compound_pincount always available
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220205/202202051611.dqFyOKso-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        git remote add willy-pagecache git://git.infradead.org/users/willy/pagecache
        git fetch --no-tags willy-pagecache for-next
        git checkout d47177a50ad8d30bb952949f8a6cc1809d7c74df
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/hugetlb.c: In function '__destroy_compound_gigantic_page':
>> mm/hugetlb.c:1323:10: error: 'struct page' has no member named 'compound_nr'; did you mean 'compound_dtor'?
    1323 |  page[1].compound_nr = 0;
         |          ^~~~~~~~~~~
         |          compound_dtor
   mm/hugetlb.c: In function '__prep_compound_gigantic_page':
   mm/hugetlb.c:1815:10: error: 'struct page' has no member named 'compound_nr'; did you mean 'compound_dtor'?
    1815 |  page[1].compound_nr = 0;
         |          ^~~~~~~~~~~
         |          compound_dtor


vim +1323 mm/hugetlb.c

1cac6f2c072abe Luiz Capitulino    2014-06-04  1291  
1cac6f2c072abe Luiz Capitulino    2014-06-04  1292  #define for_each_node_mask_to_alloc(hs, nr_nodes, node, mask)		\
1cac6f2c072abe Luiz Capitulino    2014-06-04  1293  	for (nr_nodes = nodes_weight(*mask);				\
1cac6f2c072abe Luiz Capitulino    2014-06-04  1294  		nr_nodes > 0 &&						\
1cac6f2c072abe Luiz Capitulino    2014-06-04  1295  		((node = hstate_next_node_to_alloc(hs, mask)) || 1);	\
1cac6f2c072abe Luiz Capitulino    2014-06-04  1296  		nr_nodes--)
1cac6f2c072abe Luiz Capitulino    2014-06-04  1297  
1cac6f2c072abe Luiz Capitulino    2014-06-04  1298  #define for_each_node_mask_to_free(hs, nr_nodes, node, mask)		\
1cac6f2c072abe Luiz Capitulino    2014-06-04  1299  	for (nr_nodes = nodes_weight(*mask);				\
1cac6f2c072abe Luiz Capitulino    2014-06-04  1300  		nr_nodes > 0 &&						\
1cac6f2c072abe Luiz Capitulino    2014-06-04  1301  		((node = hstate_next_node_to_free(hs, mask)) || 1);	\
1cac6f2c072abe Luiz Capitulino    2014-06-04  1302  		nr_nodes--)
1cac6f2c072abe Luiz Capitulino    2014-06-04  1303  
8531fc6f52f5fc Mike Kravetz       2021-11-05  1304  /* used to demote non-gigantic_huge pages as well */
34d9e35b13d560 Mike Kravetz       2021-11-05  1305  static void __destroy_compound_gigantic_page(struct page *page,
34d9e35b13d560 Mike Kravetz       2021-11-05  1306  					unsigned int order, bool demote)
944d9fec8d7aee Luiz Capitulino    2014-06-04  1307  {
944d9fec8d7aee Luiz Capitulino    2014-06-04  1308  	int i;
944d9fec8d7aee Luiz Capitulino    2014-06-04  1309  	int nr_pages = 1 << order;
944d9fec8d7aee Luiz Capitulino    2014-06-04  1310  	struct page *p = page + 1;
944d9fec8d7aee Luiz Capitulino    2014-06-04  1311  
c8cc708a340cc7 Gerald Schaefer    2016-06-24  1312  	atomic_set(compound_mapcount_ptr(page), 0);
47e29d32afba11 John Hubbard       2020-04-01  1313  	atomic_set(compound_pincount_ptr(page), 0);
47e29d32afba11 John Hubbard       2020-04-01  1314  
944d9fec8d7aee Luiz Capitulino    2014-06-04  1315  	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
a01f43901cfb93 Mike Kravetz       2021-11-05  1316  		p->mapping = NULL;
1d798ca3f16437 Kirill A. Shutemov 2015-11-06  1317  		clear_compound_head(p);
34d9e35b13d560 Mike Kravetz       2021-11-05  1318  		if (!demote)
944d9fec8d7aee Luiz Capitulino    2014-06-04  1319  			set_page_refcounted(p);
944d9fec8d7aee Luiz Capitulino    2014-06-04  1320  	}
944d9fec8d7aee Luiz Capitulino    2014-06-04  1321  
944d9fec8d7aee Luiz Capitulino    2014-06-04  1322  	set_compound_order(page, 0);
ba9c1201beaa86 Gerald Schaefer    2020-12-11 @1323  	page[1].compound_nr = 0;
944d9fec8d7aee Luiz Capitulino    2014-06-04  1324  	__ClearPageHead(page);
944d9fec8d7aee Luiz Capitulino    2014-06-04  1325  }
944d9fec8d7aee Luiz Capitulino    2014-06-04  1326  

:::::: The code at line 1323 was first introduced by commit
:::::: ba9c1201beaa86a773e83be5654602a0667e4a4d mm/hugetlb: clear compound_nr before freeing gigantic pages

:::::: TO: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1F259B893
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 06:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiHVEzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 00:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiHVEze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 00:55:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72961F2E8
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 21:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661144132; x=1692680132;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QpcVIkN8taNRUeevqlSqFpUJJ3vXa4FGEUlGxfZL0G4=;
  b=WjQ5NlS/xqwLSfZdc/Xz1hZLI4ATJZ+t42K23EAxXrGnQasTpQ8rvo3/
   iH5OjGWNJuuOwXtczY6+X3FyOYI8aTklu3N3iJt7mXlnf0Us5HAE0X02u
   SLBP9MSekL9n7Onm4/5s+93J6GzCPu61ZuJtWvSQqG8UV97Ft/uhuJM80
   lIRZX6D8svHsPeuX/Wfg7ZvipU8xYyNf+lpKJ3ANE3DSejZZCJ74N6mQb
   1VVYKuVT9eRo7g3XFbfcMCFw+c8HuDLtjPHNR1B/kxVLJn8RDF6E0/hZc
   sI77eWATATo2+TXjXQhB4sD/FHWGWQbvKeEvDvoHaooHSBuadMhvF0/+T
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="276349431"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="276349431"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 21:55:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="585357598"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Aug 2022 21:55:30 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPzTF-0004wX-31;
        Mon, 22 Aug 2022 04:55:29 +0000
Date:   Mon, 22 Aug 2022 12:54:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: mm/page_alloc.c:6050:13: warning: unused variable 'cpu'
Message-ID: <202208221202.iADPOzMc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220822-110006/Liu-Shixin/mm-proc-collect-percpu-free-pages-into-the-free-pages/20220822-095948
head:   8190723fa00c3bbaa252ce0f3cbb4dac1a9cb6ff
commit: 8190723fa00c3bbaa252ce0f3cbb4dac1a9cb6ff mm, proc: collect percpu free pages into the free pages
date:   2 hours ago
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220822/202208221202.iADPOzMc-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/8190723fa00c3bbaa252ce0f3cbb4dac1a9cb6ff
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220822-110006/Liu-Shixin/mm-proc-collect-percpu-free-pages-into-the-free-pages/20220822-095948
        git checkout 8190723fa00c3bbaa252ce0f3cbb4dac1a9cb6ff
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/page_alloc.c: In function 'show_free_areas':
>> mm/page_alloc.c:6050:13: warning: unused variable 'cpu' [-Wunused-variable]
    6050 |         int cpu, nid;
         |             ^~~


vim +/cpu +6050 mm/page_alloc.c

377e4f167664d8 Rabin Vincent             2012-12-11  6037  
^1da177e4c3f41 Linus Torvalds            2005-04-16  6038  /*
^1da177e4c3f41 Linus Torvalds            2005-04-16  6039   * Show free area list (used inside shift_scroll-lock stuff)
^1da177e4c3f41 Linus Torvalds            2005-04-16  6040   * We also calculate the percentage fragmentation. We do this by counting the
^1da177e4c3f41 Linus Torvalds            2005-04-16  6041   * memory on each free list with the exception of the first item on the list.
d1bfcdb8ce0ea6 Konstantin Khlebnikov     2015-04-14  6042   *
d1bfcdb8ce0ea6 Konstantin Khlebnikov     2015-04-14  6043   * Bits in @filter:
d1bfcdb8ce0ea6 Konstantin Khlebnikov     2015-04-14  6044   * SHOW_MEM_FILTER_NODES: suppress nodes that are not allowed by current's
d1bfcdb8ce0ea6 Konstantin Khlebnikov     2015-04-14  6045   *   cpuset.
^1da177e4c3f41 Linus Torvalds            2005-04-16  6046   */
9af744d743170b Michal Hocko              2017-02-22  6047  void show_free_areas(unsigned int filter, nodemask_t *nodemask)
^1da177e4c3f41 Linus Torvalds            2005-04-16  6048  {
d1bfcdb8ce0ea6 Konstantin Khlebnikov     2015-04-14  6049  	unsigned long free_pcp = 0;
dcadcf1c30619e Gang Li                   2022-07-06 @6050  	int cpu, nid;
^1da177e4c3f41 Linus Torvalds            2005-04-16  6051  	struct zone *zone;
599d0c954f91d0 Mel Gorman                2016-07-28  6052  	pg_data_t *pgdat;
^1da177e4c3f41 Linus Torvalds            2005-04-16  6053  
ee99c71c59f897 KOSAKI Motohiro           2009-03-31  6054  	for_each_populated_zone(zone) {
9af744d743170b Michal Hocko              2017-02-22  6055  		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
ddd588b5dd55f1 David Rientjes            2011-03-22  6056  			continue;
d1bfcdb8ce0ea6 Konstantin Khlebnikov     2015-04-14  6057  
8190723fa00c3b Liu Shixin                2022-08-22  6058  		free_pcp += nr_free_zone_pcplist_pages(zone);
^1da177e4c3f41 Linus Torvalds            2005-04-16  6059  	}
^1da177e4c3f41 Linus Torvalds            2005-04-16  6060  
a731286de62294 KOSAKI Motohiro           2009-09-21  6061  	printk("active_anon:%lu inactive_anon:%lu isolated_anon:%lu\n"
a731286de62294 KOSAKI Motohiro           2009-09-21  6062  		" active_file:%lu inactive_file:%lu isolated_file:%lu\n"
8d92890bd6b850 NeilBrown                 2020-06-01  6063  		" unevictable:%lu dirty:%lu writeback:%lu\n"
d1bfcdb8ce0ea6 Konstantin Khlebnikov     2015-04-14  6064  		" slab_reclaimable:%lu slab_unreclaimable:%lu\n"
d1ce749a0db122 Bartlomiej Zolnierkiewicz 2012-10-08  6065  		" mapped:%lu shmem:%lu pagetables:%lu bounce:%lu\n"
eb2169cee36fc4 liuhailong                2021-09-02  6066  		" kernel_misc_reclaimable:%lu\n"
d1bfcdb8ce0ea6 Konstantin Khlebnikov     2015-04-14  6067  		" free:%lu free_pcp:%lu free_cma:%lu\n",
599d0c954f91d0 Mel Gorman                2016-07-28  6068  		global_node_page_state(NR_ACTIVE_ANON),
599d0c954f91d0 Mel Gorman                2016-07-28  6069  		global_node_page_state(NR_INACTIVE_ANON),
599d0c954f91d0 Mel Gorman                2016-07-28  6070  		global_node_page_state(NR_ISOLATED_ANON),
599d0c954f91d0 Mel Gorman                2016-07-28  6071  		global_node_page_state(NR_ACTIVE_FILE),
599d0c954f91d0 Mel Gorman                2016-07-28  6072  		global_node_page_state(NR_INACTIVE_FILE),
599d0c954f91d0 Mel Gorman                2016-07-28  6073  		global_node_page_state(NR_ISOLATED_FILE),
599d0c954f91d0 Mel Gorman                2016-07-28  6074  		global_node_page_state(NR_UNEVICTABLE),
11fb998986a72a Mel Gorman                2016-07-28  6075  		global_node_page_state(NR_FILE_DIRTY),
11fb998986a72a Mel Gorman                2016-07-28  6076  		global_node_page_state(NR_WRITEBACK),
d42f3245c7e299 Roman Gushchin            2020-08-06  6077  		global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B),
d42f3245c7e299 Roman Gushchin            2020-08-06  6078  		global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B),
50658e2e04c12d Mel Gorman                2016-07-28  6079  		global_node_page_state(NR_FILE_MAPPED),
11fb998986a72a Mel Gorman                2016-07-28  6080  		global_node_page_state(NR_SHMEM),
f0c0c115fb8194 Shakeel Butt              2020-12-14  6081  		global_node_page_state(NR_PAGETABLE),
c41f012ade0b95 Michal Hocko              2017-09-06  6082  		global_zone_page_state(NR_BOUNCE),
eb2169cee36fc4 liuhailong                2021-09-02  6083  		global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE),
c41f012ade0b95 Michal Hocko              2017-09-06  6084  		global_zone_page_state(NR_FREE_PAGES),
d1bfcdb8ce0ea6 Konstantin Khlebnikov     2015-04-14  6085  		free_pcp,
c41f012ade0b95 Michal Hocko              2017-09-06  6086  		global_zone_page_state(NR_FREE_CMA_PAGES));
^1da177e4c3f41 Linus Torvalds            2005-04-16  6087  
599d0c954f91d0 Mel Gorman                2016-07-28  6088  	for_each_online_pgdat(pgdat) {
9af744d743170b Michal Hocko              2017-02-22  6089  		if (show_mem_node_skip(filter, pgdat->node_id, nodemask))
c02e50bb8a55a7 Michal Hocko              2017-02-22  6090  			continue;
c02e50bb8a55a7 Michal Hocko              2017-02-22  6091  
599d0c954f91d0 Mel Gorman                2016-07-28  6092  		printk("Node %d"
599d0c954f91d0 Mel Gorman                2016-07-28  6093  			" active_anon:%lukB"
599d0c954f91d0 Mel Gorman                2016-07-28  6094  			" inactive_anon:%lukB"
599d0c954f91d0 Mel Gorman                2016-07-28  6095  			" active_file:%lukB"
599d0c954f91d0 Mel Gorman                2016-07-28  6096  			" inactive_file:%lukB"
599d0c954f91d0 Mel Gorman                2016-07-28  6097  			" unevictable:%lukB"
599d0c954f91d0 Mel Gorman                2016-07-28  6098  			" isolated(anon):%lukB"
599d0c954f91d0 Mel Gorman                2016-07-28  6099  			" isolated(file):%lukB"
50658e2e04c12d Mel Gorman                2016-07-28  6100  			" mapped:%lukB"
11fb998986a72a Mel Gorman                2016-07-28  6101  			" dirty:%lukB"
11fb998986a72a Mel Gorman                2016-07-28  6102  			" writeback:%lukB"
11fb998986a72a Mel Gorman                2016-07-28  6103  			" shmem:%lukB"
11fb998986a72a Mel Gorman                2016-07-28  6104  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
11fb998986a72a Mel Gorman                2016-07-28  6105  			" shmem_thp: %lukB"
11fb998986a72a Mel Gorman                2016-07-28  6106  			" shmem_pmdmapped: %lukB"
11fb998986a72a Mel Gorman                2016-07-28  6107  			" anon_thp: %lukB"
11fb998986a72a Mel Gorman                2016-07-28  6108  #endif
11fb998986a72a Mel Gorman                2016-07-28  6109  			" writeback_tmp:%lukB"
991e7673859ed4 Shakeel Butt              2020-08-06  6110  			" kernel_stack:%lukB"
991e7673859ed4 Shakeel Butt              2020-08-06  6111  #ifdef CONFIG_SHADOW_CALL_STACK
991e7673859ed4 Shakeel Butt              2020-08-06  6112  			" shadow_call_stack:%lukB"
991e7673859ed4 Shakeel Butt              2020-08-06  6113  #endif
f0c0c115fb8194 Shakeel Butt              2020-12-14  6114  			" pagetables:%lukB"
599d0c954f91d0 Mel Gorman                2016-07-28  6115  			" all_unreclaimable? %s"
599d0c954f91d0 Mel Gorman                2016-07-28  6116  			"\n",
599d0c954f91d0 Mel Gorman                2016-07-28  6117  			pgdat->node_id,
599d0c954f91d0 Mel Gorman                2016-07-28  6118  			K(node_page_state(pgdat, NR_ACTIVE_ANON)),
599d0c954f91d0 Mel Gorman                2016-07-28  6119  			K(node_page_state(pgdat, NR_INACTIVE_ANON)),
599d0c954f91d0 Mel Gorman                2016-07-28  6120  			K(node_page_state(pgdat, NR_ACTIVE_FILE)),
599d0c954f91d0 Mel Gorman                2016-07-28  6121  			K(node_page_state(pgdat, NR_INACTIVE_FILE)),
599d0c954f91d0 Mel Gorman                2016-07-28  6122  			K(node_page_state(pgdat, NR_UNEVICTABLE)),
599d0c954f91d0 Mel Gorman                2016-07-28  6123  			K(node_page_state(pgdat, NR_ISOLATED_ANON)),
599d0c954f91d0 Mel Gorman                2016-07-28  6124  			K(node_page_state(pgdat, NR_ISOLATED_FILE)),
50658e2e04c12d Mel Gorman                2016-07-28  6125  			K(node_page_state(pgdat, NR_FILE_MAPPED)),
11fb998986a72a Mel Gorman                2016-07-28  6126  			K(node_page_state(pgdat, NR_FILE_DIRTY)),
11fb998986a72a Mel Gorman                2016-07-28  6127  			K(node_page_state(pgdat, NR_WRITEBACK)),
1f06b81aea5ecb Alexander Polakov         2017-04-07  6128  			K(node_page_state(pgdat, NR_SHMEM)),
11fb998986a72a Mel Gorman                2016-07-28  6129  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
57b2847d3c1dc1 Muchun Song               2021-02-24  6130  			K(node_page_state(pgdat, NR_SHMEM_THPS)),
a1528e21f8915e Muchun Song               2021-02-24  6131  			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
69473e5de87389 Muchun Song               2021-02-24  6132  			K(node_page_state(pgdat, NR_ANON_THPS)),
11fb998986a72a Mel Gorman                2016-07-28  6133  #endif
11fb998986a72a Mel Gorman                2016-07-28  6134  			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
991e7673859ed4 Shakeel Butt              2020-08-06  6135  			node_page_state(pgdat, NR_KERNEL_STACK_KB),
991e7673859ed4 Shakeel Butt              2020-08-06  6136  #ifdef CONFIG_SHADOW_CALL_STACK
991e7673859ed4 Shakeel Butt              2020-08-06  6137  			node_page_state(pgdat, NR_KERNEL_SCS_KB),
991e7673859ed4 Shakeel Butt              2020-08-06  6138  #endif
f0c0c115fb8194 Shakeel Butt              2020-12-14  6139  			K(node_page_state(pgdat, NR_PAGETABLE)),
c73322d098e4b6 Johannes Weiner           2017-05-03  6140  			pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ?
c73322d098e4b6 Johannes Weiner           2017-05-03  6141  				"yes" : "no");
599d0c954f91d0 Mel Gorman                2016-07-28  6142  	}
599d0c954f91d0 Mel Gorman                2016-07-28  6143  
ee99c71c59f897 KOSAKI Motohiro           2009-03-31  6144  	for_each_populated_zone(zone) {
^1da177e4c3f41 Linus Torvalds            2005-04-16  6145  		int i;
^1da177e4c3f41 Linus Torvalds            2005-04-16  6146  
9af744d743170b Michal Hocko              2017-02-22  6147  		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
ddd588b5dd55f1 David Rientjes            2011-03-22  6148  			continue;
d1bfcdb8ce0ea6 Konstantin Khlebnikov     2015-04-14  6149  
8190723fa00c3b Liu Shixin                2022-08-22  6150  		free_pcp = nr_free_zone_pcplist_pages(zone);
d1bfcdb8ce0ea6 Konstantin Khlebnikov     2015-04-14  6151  
^1da177e4c3f41 Linus Torvalds            2005-04-16  6152  		show_node(zone);
1f84a18fc010d7 Joe Perches               2016-10-27  6153  		printk(KERN_CONT
1f84a18fc010d7 Joe Perches               2016-10-27  6154  			"%s"
^1da177e4c3f41 Linus Torvalds            2005-04-16  6155  			" free:%lukB"
a6ea8b5b9f1ce3 Liangcai Fan              2021-11-05  6156  			" boost:%lukB"
^1da177e4c3f41 Linus Torvalds            2005-04-16  6157  			" min:%lukB"
^1da177e4c3f41 Linus Torvalds            2005-04-16  6158  			" low:%lukB"
^1da177e4c3f41 Linus Torvalds            2005-04-16  6159  			" high:%lukB"
e47b346aba0873 lijiazi                   2019-11-30  6160  			" reserved_highatomic:%luKB"
71c799f4982d34 Minchan Kim               2016-07-28  6161  			" active_anon:%lukB"
71c799f4982d34 Minchan Kim               2016-07-28  6162  			" inactive_anon:%lukB"
71c799f4982d34 Minchan Kim               2016-07-28  6163  			" active_file:%lukB"
71c799f4982d34 Minchan Kim               2016-07-28  6164  			" inactive_file:%lukB"
71c799f4982d34 Minchan Kim               2016-07-28  6165  			" unevictable:%lukB"
5a1c84b404a717 Mel Gorman                2016-07-28  6166  			" writepending:%lukB"
^1da177e4c3f41 Linus Torvalds            2005-04-16  6167  			" present:%lukB"
9feedc9d831e18 Jiang Liu                 2012-12-12  6168  			" managed:%lukB"
4a0aa73f1d613b KOSAKI Motohiro           2009-09-21  6169  			" mlocked:%lukB"
4a0aa73f1d613b KOSAKI Motohiro           2009-09-21  6170  			" bounce:%lukB"
d1bfcdb8ce0ea6 Konstantin Khlebnikov     2015-04-14  6171  			" free_pcp:%lukB"
d1bfcdb8ce0ea6 Konstantin Khlebnikov     2015-04-14  6172  			" local_pcp:%ukB"
d1ce749a0db122 Bartlomiej Zolnierkiewicz 2012-10-08  6173  			" free_cma:%lukB"
^1da177e4c3f41 Linus Torvalds            2005-04-16  6174  			"\n",
^1da177e4c3f41 Linus Torvalds            2005-04-16  6175  			zone->name,
88f5acf88ae6a9 Mel Gorman                2011-01-13  6176  			K(zone_page_state(zone, NR_FREE_PAGES)),
a6ea8b5b9f1ce3 Liangcai Fan              2021-11-05  6177  			K(zone->watermark_boost),
418589663d6011 Mel Gorman                2009-06-16  6178  			K(min_wmark_pages(zone)),
418589663d6011 Mel Gorman                2009-06-16  6179  			K(low_wmark_pages(zone)),
418589663d6011 Mel Gorman                2009-06-16  6180  			K(high_wmark_pages(zone)),
e47b346aba0873 lijiazi                   2019-11-30  6181  			K(zone->nr_reserved_highatomic),
71c799f4982d34 Minchan Kim               2016-07-28  6182  			K(zone_page_state(zone, NR_ZONE_ACTIVE_ANON)),
71c799f4982d34 Minchan Kim               2016-07-28  6183  			K(zone_page_state(zone, NR_ZONE_INACTIVE_ANON)),
71c799f4982d34 Minchan Kim               2016-07-28  6184  			K(zone_page_state(zone, NR_ZONE_ACTIVE_FILE)),
71c799f4982d34 Minchan Kim               2016-07-28  6185  			K(zone_page_state(zone, NR_ZONE_INACTIVE_FILE)),
71c799f4982d34 Minchan Kim               2016-07-28  6186  			K(zone_page_state(zone, NR_ZONE_UNEVICTABLE)),
5a1c84b404a717 Mel Gorman                2016-07-28  6187  			K(zone_page_state(zone, NR_ZONE_WRITE_PENDING)),
^1da177e4c3f41 Linus Torvalds            2005-04-16  6188  			K(zone->present_pages),
9705bea5f833f4 Arun KS                   2018-12-28  6189  			K(zone_managed_pages(zone)),
4a0aa73f1d613b KOSAKI Motohiro           2009-09-21  6190  			K(zone_page_state(zone, NR_MLOCK)),
4a0aa73f1d613b KOSAKI Motohiro           2009-09-21  6191  			K(zone_page_state(zone, NR_BOUNCE)),
d1bfcdb8ce0ea6 Konstantin Khlebnikov     2015-04-14  6192  			K(free_pcp),
28f836b6777b6f Mel Gorman                2021-06-28  6193  			K(this_cpu_read(zone->per_cpu_pageset->count)),
33e077bd6059a5 Minchan Kim               2016-07-28  6194  			K(zone_page_state(zone, NR_FREE_CMA_PAGES)));
^1da177e4c3f41 Linus Torvalds            2005-04-16  6195  		printk("lowmem_reserve[]:");
^1da177e4c3f41 Linus Torvalds            2005-04-16  6196  		for (i = 0; i < MAX_NR_ZONES; i++)
1f84a18fc010d7 Joe Perches               2016-10-27  6197  			printk(KERN_CONT " %ld", zone->lowmem_reserve[i]);
1f84a18fc010d7 Joe Perches               2016-10-27  6198  		printk(KERN_CONT "\n");
^1da177e4c3f41 Linus Torvalds            2005-04-16  6199  	}
^1da177e4c3f41 Linus Torvalds            2005-04-16  6200  
ee99c71c59f897 KOSAKI Motohiro           2009-03-31  6201  	for_each_populated_zone(zone) {
d00181b96eb86c Kirill A. Shutemov        2015-11-06  6202  		unsigned int order;
d00181b96eb86c Kirill A. Shutemov        2015-11-06  6203  		unsigned long nr[MAX_ORDER], flags, total = 0;
377e4f167664d8 Rabin Vincent             2012-12-11  6204  		unsigned char types[MAX_ORDER];
^1da177e4c3f41 Linus Torvalds            2005-04-16  6205  
9af744d743170b Michal Hocko              2017-02-22  6206  		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
ddd588b5dd55f1 David Rientjes            2011-03-22  6207  			continue;
^1da177e4c3f41 Linus Torvalds            2005-04-16  6208  		show_node(zone);
1f84a18fc010d7 Joe Perches               2016-10-27  6209  		printk(KERN_CONT "%s: ", zone->name);
^1da177e4c3f41 Linus Torvalds            2005-04-16  6210  
^1da177e4c3f41 Linus Torvalds            2005-04-16  6211  		spin_lock_irqsave(&zone->lock, flags);
^1da177e4c3f41 Linus Torvalds            2005-04-16  6212  		for (order = 0; order < MAX_ORDER; order++) {
377e4f167664d8 Rabin Vincent             2012-12-11  6213  			struct free_area *area = &zone->free_area[order];
377e4f167664d8 Rabin Vincent             2012-12-11  6214  			int type;
377e4f167664d8 Rabin Vincent             2012-12-11  6215  
377e4f167664d8 Rabin Vincent             2012-12-11  6216  			nr[order] = area->nr_free;
8f9de51a4a98ba Kirill Korotaev           2006-06-23  6217  			total += nr[order] << order;
377e4f167664d8 Rabin Vincent             2012-12-11  6218  
377e4f167664d8 Rabin Vincent             2012-12-11  6219  			types[order] = 0;
377e4f167664d8 Rabin Vincent             2012-12-11  6220  			for (type = 0; type < MIGRATE_TYPES; type++) {
b03641af680959 Dan Williams              2019-05-14  6221  				if (!free_area_empty(area, type))
377e4f167664d8 Rabin Vincent             2012-12-11  6222  					types[order] |= 1 << type;
377e4f167664d8 Rabin Vincent             2012-12-11  6223  			}
^1da177e4c3f41 Linus Torvalds            2005-04-16  6224  		}
^1da177e4c3f41 Linus Torvalds            2005-04-16  6225  		spin_unlock_irqrestore(&zone->lock, flags);
377e4f167664d8 Rabin Vincent             2012-12-11  6226  		for (order = 0; order < MAX_ORDER; order++) {
1f84a18fc010d7 Joe Perches               2016-10-27  6227  			printk(KERN_CONT "%lu*%lukB ",
1f84a18fc010d7 Joe Perches               2016-10-27  6228  			       nr[order], K(1UL) << order);
377e4f167664d8 Rabin Vincent             2012-12-11  6229  			if (nr[order])
377e4f167664d8 Rabin Vincent             2012-12-11  6230  				show_migration_types(types[order]);
377e4f167664d8 Rabin Vincent             2012-12-11  6231  		}
1f84a18fc010d7 Joe Perches               2016-10-27  6232  		printk(KERN_CONT "= %lukB\n", K(total));
^1da177e4c3f41 Linus Torvalds            2005-04-16  6233  	}
^1da177e4c3f41 Linus Torvalds            2005-04-16  6234  
dcadcf1c30619e Gang Li                   2022-07-06  6235  	for_each_online_node(nid) {
dcadcf1c30619e Gang Li                   2022-07-06  6236  		if (show_mem_node_skip(filter, nid, nodemask))
dcadcf1c30619e Gang Li                   2022-07-06  6237  			continue;
dcadcf1c30619e Gang Li                   2022-07-06  6238  		hugetlb_show_meminfo_node(nid);
dcadcf1c30619e Gang Li                   2022-07-06  6239  	}
949f7ec5760b02 David Rientjes            2013-04-29  6240  
11fb998986a72a Mel Gorman                2016-07-28  6241  	printk("%ld total pagecache pages\n", global_node_page_state(NR_FILE_PAGES));
e6f3602d2c5881 Larry Woodman             2008-02-04  6242  
^1da177e4c3f41 Linus Torvalds            2005-04-16  6243  	show_swap_cache_info();
^1da177e4c3f41 Linus Torvalds            2005-04-16  6244  }
^1da177e4c3f41 Linus Torvalds            2005-04-16  6245  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

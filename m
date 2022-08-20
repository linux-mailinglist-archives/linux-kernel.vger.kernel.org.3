Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650BB59AD40
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 12:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344532AbiHTK2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 06:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiHTK2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 06:28:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460E633E1F
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 03:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660991312; x=1692527312;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KiMO6n7qwHyyfiz5Iyi4WlNhBfm41i/GfNQTqNzgUfg=;
  b=nkiL+F+WLCx3u1xxPkcV6Xug6VtZoGqk8zMdt1jcx6M9vdirWH2ScTHQ
   9XXu79nN5QkF3YXaBdxTcgghJV8yXjSy4WmR5xxa0h2ckCPGh9Y2tlh1P
   27lafMQbZTzbs11+qwK9UsTgksD1qlqET43biFzRBi8EP4/DJtW6CRRIR
   ZaPjcuI6Y2R1ktllvQuSLRAijzADV1CcqBM/xBleRLieX6b08qOdxkFZs
   geZFsrt39tLfYV6lM2MfeQTBDQjGtpZkCXpMCrr/afGJxZpsMIR8W/TWI
   /PhTSMt772R3LCJNrqYyzFxJPqdIVu914eyiuckGyfgT3c99ascRw5zZz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="276197830"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="276197830"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 03:28:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="697804796"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Aug 2022 03:28:27 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPLiM-0002UN-3D;
        Sat, 20 Aug 2022 10:28:26 +0000
Date:   Sat, 20 Aug 2022 18:28:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: [ammarfaizi2-block:akpm/mm/mm-unstable 157/170]
 kernel/sched/fair.c:1571:14: error: implicit declaration of function
 'node_is_toptier'
Message-ID: <202208201813.3qpwXbu9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block akpm/mm/mm-unstable
head:   1b745fa43c32e6a6ffb4d922114d75019830a9e2
commit: f66f3c26148785882c6292f7ef32fd34d13d1a97 [157/170] mm/demotion: update node_is_toptier to work with memory tiers
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220820/202208201813.3qpwXbu9-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/f66f3c26148785882c6292f7ef32fd34d13d1a97
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block akpm/mm/mm-unstable
        git checkout f66f3c26148785882c6292f7ef32fd34d13d1a97
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/sched/fair.c: In function 'should_numa_migrate_memory':
>> kernel/sched/fair.c:1571:14: error: implicit declaration of function 'node_is_toptier' [-Werror=implicit-function-declaration]
    1571 |             !node_is_toptier(src_nid)) {
         |              ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/node_is_toptier +1571 kernel/sched/fair.c

118aa9e6092758 Huang Ying        2022-07-13  1558  
10f39042711ba2 Rik van Riel      2014-01-27  1559  bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
10f39042711ba2 Rik van Riel      2014-01-27  1560  				int src_nid, int dst_cpu)
10f39042711ba2 Rik van Riel      2014-01-27  1561  {
cb361d8cdef699 Jann Horn         2019-07-16  1562  	struct numa_group *ng = deref_curr_numa_group(p);
10f39042711ba2 Rik van Riel      2014-01-27  1563  	int dst_nid = cpu_to_node(dst_cpu);
10f39042711ba2 Rik van Riel      2014-01-27  1564  	int last_cpupid, this_cpupid;
10f39042711ba2 Rik van Riel      2014-01-27  1565  
301a39f0d73fef Huang Ying        2022-07-13  1566  	/*
301a39f0d73fef Huang Ying        2022-07-13  1567  	 * The pages in slow memory node should be migrated according
301a39f0d73fef Huang Ying        2022-07-13  1568  	 * to hot/cold instead of private/shared.
301a39f0d73fef Huang Ying        2022-07-13  1569  	 */
301a39f0d73fef Huang Ying        2022-07-13  1570  	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
301a39f0d73fef Huang Ying        2022-07-13 @1571  	    !node_is_toptier(src_nid)) {
301a39f0d73fef Huang Ying        2022-07-13  1572  		struct pglist_data *pgdat;
118aa9e6092758 Huang Ying        2022-07-13  1573  		unsigned long rate_limit;
118aa9e6092758 Huang Ying        2022-07-13  1574  		unsigned int latency, th, def_th;
301a39f0d73fef Huang Ying        2022-07-13  1575  
301a39f0d73fef Huang Ying        2022-07-13  1576  		pgdat = NODE_DATA(dst_nid);
118aa9e6092758 Huang Ying        2022-07-13  1577  		if (pgdat_free_space_enough(pgdat)) {
118aa9e6092758 Huang Ying        2022-07-13  1578  			/* workload changed, reset hot threshold */
118aa9e6092758 Huang Ying        2022-07-13  1579  			pgdat->nbp_threshold = 0;
301a39f0d73fef Huang Ying        2022-07-13  1580  			return true;
118aa9e6092758 Huang Ying        2022-07-13  1581  		}
301a39f0d73fef Huang Ying        2022-07-13  1582  
118aa9e6092758 Huang Ying        2022-07-13  1583  		def_th = sysctl_numa_balancing_hot_threshold;
118aa9e6092758 Huang Ying        2022-07-13  1584  		rate_limit = sysctl_numa_balancing_promote_rate_limit << \
118aa9e6092758 Huang Ying        2022-07-13  1585  			(20 - PAGE_SHIFT);
118aa9e6092758 Huang Ying        2022-07-13  1586  		numa_promotion_adjust_threshold(pgdat, rate_limit, def_th);
118aa9e6092758 Huang Ying        2022-07-13  1587  
118aa9e6092758 Huang Ying        2022-07-13  1588  		th = pgdat->nbp_threshold ? : def_th;
301a39f0d73fef Huang Ying        2022-07-13  1589  		latency = numa_hint_fault_latency(page);
301a39f0d73fef Huang Ying        2022-07-13  1590  		if (latency >= th)
301a39f0d73fef Huang Ying        2022-07-13  1591  			return false;
301a39f0d73fef Huang Ying        2022-07-13  1592  
23441fcb084b9e Huang Ying        2022-07-13  1593  		return !numa_promotion_rate_limit(pgdat, rate_limit,
23441fcb084b9e Huang Ying        2022-07-13  1594  						  thp_nr_pages(page));
301a39f0d73fef Huang Ying        2022-07-13  1595  	}
301a39f0d73fef Huang Ying        2022-07-13  1596  
10f39042711ba2 Rik van Riel      2014-01-27  1597  	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
37355bdc5a1298 Mel Gorman        2018-10-01  1598  	last_cpupid = page_cpupid_xchg_last(page, this_cpupid);
37355bdc5a1298 Mel Gorman        2018-10-01  1599  
301a39f0d73fef Huang Ying        2022-07-13  1600  	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
301a39f0d73fef Huang Ying        2022-07-13  1601  	    !node_is_toptier(src_nid) && !cpupid_valid(last_cpupid))
301a39f0d73fef Huang Ying        2022-07-13  1602  		return false;
301a39f0d73fef Huang Ying        2022-07-13  1603  
37355bdc5a1298 Mel Gorman        2018-10-01  1604  	/*
37355bdc5a1298 Mel Gorman        2018-10-01  1605  	 * Allow first faults or private faults to migrate immediately early in
37355bdc5a1298 Mel Gorman        2018-10-01  1606  	 * the lifetime of a task. The magic number 4 is based on waiting for
37355bdc5a1298 Mel Gorman        2018-10-01  1607  	 * two full passes of the "multi-stage node selection" test that is
37355bdc5a1298 Mel Gorman        2018-10-01  1608  	 * executed below.
37355bdc5a1298 Mel Gorman        2018-10-01  1609  	 */
98fa15f34cb379 Anshuman Khandual 2019-03-05  1610  	if ((p->numa_preferred_nid == NUMA_NO_NODE || p->numa_scan_seq <= 4) &&
37355bdc5a1298 Mel Gorman        2018-10-01  1611  	    (cpupid_pid_unset(last_cpupid) || cpupid_match_pid(p, last_cpupid)))
37355bdc5a1298 Mel Gorman        2018-10-01  1612  		return true;
10f39042711ba2 Rik van Riel      2014-01-27  1613  
10f39042711ba2 Rik van Riel      2014-01-27  1614  	/*
10f39042711ba2 Rik van Riel      2014-01-27  1615  	 * Multi-stage node selection is used in conjunction with a periodic
10f39042711ba2 Rik van Riel      2014-01-27  1616  	 * migration fault to build a temporal task<->page relation. By using
10f39042711ba2 Rik van Riel      2014-01-27  1617  	 * a two-stage filter we remove short/unlikely relations.
10f39042711ba2 Rik van Riel      2014-01-27  1618  	 *
10f39042711ba2 Rik van Riel      2014-01-27  1619  	 * Using P(p) ~ n_p / n_t as per frequentist probability, we can equate
10f39042711ba2 Rik van Riel      2014-01-27  1620  	 * a task's usage of a particular page (n_p) per total usage of this
10f39042711ba2 Rik van Riel      2014-01-27  1621  	 * page (n_t) (in a given time-span) to a probability.
10f39042711ba2 Rik van Riel      2014-01-27  1622  	 *
10f39042711ba2 Rik van Riel      2014-01-27  1623  	 * Our periodic faults will sample this probability and getting the
10f39042711ba2 Rik van Riel      2014-01-27  1624  	 * same result twice in a row, given these samples are fully
10f39042711ba2 Rik van Riel      2014-01-27  1625  	 * independent, is then given by P(n)^2, provided our sample period
10f39042711ba2 Rik van Riel      2014-01-27  1626  	 * is sufficiently short compared to the usage pattern.
10f39042711ba2 Rik van Riel      2014-01-27  1627  	 *
10f39042711ba2 Rik van Riel      2014-01-27  1628  	 * This quadric squishes small probabilities, making it less likely we
10f39042711ba2 Rik van Riel      2014-01-27  1629  	 * act on an unlikely task<->page relation.
10f39042711ba2 Rik van Riel      2014-01-27  1630  	 */
10f39042711ba2 Rik van Riel      2014-01-27  1631  	if (!cpupid_pid_unset(last_cpupid) &&
10f39042711ba2 Rik van Riel      2014-01-27  1632  				cpupid_to_nid(last_cpupid) != dst_nid)
10f39042711ba2 Rik van Riel      2014-01-27  1633  		return false;
10f39042711ba2 Rik van Riel      2014-01-27  1634  
10f39042711ba2 Rik van Riel      2014-01-27  1635  	/* Always allow migrate on private faults */
10f39042711ba2 Rik van Riel      2014-01-27  1636  	if (cpupid_match_pid(p, last_cpupid))
10f39042711ba2 Rik van Riel      2014-01-27  1637  		return true;
10f39042711ba2 Rik van Riel      2014-01-27  1638  
10f39042711ba2 Rik van Riel      2014-01-27  1639  	/* A shared fault, but p->numa_group has not been set up yet. */
10f39042711ba2 Rik van Riel      2014-01-27  1640  	if (!ng)
10f39042711ba2 Rik van Riel      2014-01-27  1641  		return true;
10f39042711ba2 Rik van Riel      2014-01-27  1642  
10f39042711ba2 Rik van Riel      2014-01-27  1643  	/*
4142c3ebb685bb Rik van Riel      2016-01-25  1644  	 * Destination node is much more heavily used than the source
4142c3ebb685bb Rik van Riel      2016-01-25  1645  	 * node? Allow migration.
10f39042711ba2 Rik van Riel      2014-01-27  1646  	 */
4142c3ebb685bb Rik van Riel      2016-01-25  1647  	if (group_faults_cpu(ng, dst_nid) > group_faults_cpu(ng, src_nid) *
4142c3ebb685bb Rik van Riel      2016-01-25  1648  					ACTIVE_NODE_FRACTION)
10f39042711ba2 Rik van Riel      2014-01-27  1649  		return true;
10f39042711ba2 Rik van Riel      2014-01-27  1650  
10f39042711ba2 Rik van Riel      2014-01-27  1651  	/*
4142c3ebb685bb Rik van Riel      2016-01-25  1652  	 * Distribute memory according to CPU & memory use on each node,
4142c3ebb685bb Rik van Riel      2016-01-25  1653  	 * with 3/4 hysteresis to avoid unnecessary memory migrations:
4142c3ebb685bb Rik van Riel      2016-01-25  1654  	 *
4142c3ebb685bb Rik van Riel      2016-01-25  1655  	 * faults_cpu(dst)   3   faults_cpu(src)
4142c3ebb685bb Rik van Riel      2016-01-25  1656  	 * --------------- * - > ---------------
4142c3ebb685bb Rik van Riel      2016-01-25  1657  	 * faults_mem(dst)   4   faults_mem(src)
10f39042711ba2 Rik van Riel      2014-01-27  1658  	 */
4142c3ebb685bb Rik van Riel      2016-01-25  1659  	return group_faults_cpu(ng, dst_nid) * group_faults(p, src_nid) * 3 >
4142c3ebb685bb Rik van Riel      2016-01-25  1660  	       group_faults_cpu(ng, src_nid) * group_faults(p, dst_nid) * 4;
10f39042711ba2 Rik van Riel      2014-01-27  1661  }
10f39042711ba2 Rik van Riel      2014-01-27  1662  

:::::: The code at line 1571 was first introduced by commit
:::::: 301a39f0d73fef87b631e25726f507f244273fa9 memory tiering: hot page selection with hint page fault latency

:::::: TO: Huang Ying <ying.huang@intel.com>
:::::: CC: Andrew Morton <akpm@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CA04A85C6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350990AbiBCOHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:07:19 -0500
Received: from mga02.intel.com ([134.134.136.20]:52684 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbiBCOHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643897236; x=1675433236;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CaFnNocD4kDpvGet9OezqWdYOhR2mtpLqE8eBbLLu0o=;
  b=cuhXnHF87rTs/v/qGUBSoD1Iur92PYQdBH7e07mPDjX/fr/DcaQArAmi
   SRi85q39vqfdoWxHgo2u/PQEfi2C5OwOoz9RUyWB9wqY08oHXViEbt4wt
   jpF2EC/onvmNxWfa87nly5PTJeacF6IsP/3j1mMVzEn8VZhGYv+EuPqSQ
   xpLqewmIRj40qs3GzQX969QWAy95GKCXoNecev78zdgLbuGGNmT8YQUm+
   Uk96Hgb0vJ/v3IM304yQ4BgWYzdPHL6kcKdtg2v5awklsXNJ/6uemQn1L
   E/xcXNVO0BDy9wi/0JKKDBs/yc9rRA47Ppux4veKckYX2dKeqF+uKIHZD
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="235549893"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="235549893"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 06:07:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="583797749"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 03 Feb 2022 06:07:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFclW-000WCl-TD; Thu, 03 Feb 2022 14:07:14 +0000
Date:   Thu, 3 Feb 2022 22:06:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hying-caritas:mt-20210701 33/56] mm/vmscan.c:2261:46: sparse:
 sparse: mixing different enum types:
Message-ID: <202202031841.nnBVqqFb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/hying-caritas/linux.git mt-20210701
head:   491dd52981b1acfc3638b3780d85ee68113fd51b
commit: 19f3e3d17bb9b4096c84f6f5e7842dbfd3c1132c [33/56] mm: make some global page reclaim related vmstat events per-node
config: m68k-randconfig-s032-20220202 (https://download.01.org/0day-ci/archive/20220203/202202031841.nnBVqqFb-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/hying-caritas/linux/commit/19f3e3d17bb9b4096c84f6f5e7842dbfd3c1132c
        git remote add hying-caritas https://github.com/hying-caritas/linux.git
        git fetch --no-tags hying-caritas mt-20210701
        git checkout 19f3e3d17bb9b4096c84f6f5e7842dbfd3c1132c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> mm/vmscan.c:2261:46: sparse: sparse: mixing different enum types:
>> mm/vmscan.c:2261:46: sparse:    unsigned int enum vm_event_item
>> mm/vmscan.c:2261:46: sparse:    unsigned int enum node_stat_item
   mm/vmscan.c:2278:46: sparse: sparse: mixing different enum types:
   mm/vmscan.c:2278:46: sparse:    unsigned int enum vm_event_item
   mm/vmscan.c:2278:46: sparse:    unsigned int enum node_stat_item
   mm/vmscan.c: note: in included file:
   include/linux/mm_inline.h:66:38: sparse: sparse: context imbalance in 'isolate_lru_page' - unexpected unlock
   mm/vmscan.c: note: in included file (through include/linux/swap.h):
   include/linux/memcontrol.h:1527:39: sparse: sparse: context imbalance in 'check_move_unevictable_pages' - unexpected unlock

vim +2261 mm/vmscan.c

  2219	
  2220	/*
  2221	 * shrink_inactive_list() is a helper for shrink_node().  It returns the number
  2222	 * of reclaimed pages
  2223	 */
  2224	static noinline_for_stack unsigned long
  2225	shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
  2226			     struct scan_control *sc, enum lru_list lru)
  2227	{
  2228		LIST_HEAD(page_list);
  2229		unsigned long nr_scanned;
  2230		unsigned int nr_reclaimed = 0;
  2231		unsigned long nr_taken;
  2232		struct reclaim_stat stat;
  2233		bool file = is_file_lru(lru);
  2234		enum vm_event_item item;
  2235		struct pglist_data *pgdat = lruvec_pgdat(lruvec);
  2236		bool stalled = false;
  2237	
  2238		while (unlikely(too_many_isolated(pgdat, file, sc))) {
  2239			if (stalled)
  2240				return 0;
  2241	
  2242			/* wait a bit for the reclaimer. */
  2243			msleep(100);
  2244			stalled = true;
  2245	
  2246			/* We are about to die and free our memory. Return now. */
  2247			if (fatal_signal_pending(current))
  2248				return SWAP_CLUSTER_MAX;
  2249		}
  2250	
  2251		lru_add_drain();
  2252	
  2253		spin_lock_irq(&lruvec->lru_lock);
  2254	
  2255		nr_taken = isolate_lru_pages(nr_to_scan, lruvec, &page_list,
  2256					     &nr_scanned, sc, lru);
  2257	
  2258		__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, nr_taken);
  2259		item = current_is_kswapd() ? PGSCAN_KSWAPD : PGSCAN_DIRECT;
  2260		if (!cgroup_reclaim(sc))
> 2261			__mod_node_page_state(pgdat, item, nr_scanned);
  2262		__mod_memcg_state(lruvec_memcg(lruvec), item, nr_scanned);
  2263		__count_vm_events(PGSCAN_ANON + file, nr_scanned);
  2264	
  2265		spin_unlock_irq(&lruvec->lru_lock);
  2266	
  2267		if (nr_taken == 0)
  2268			return 0;
  2269	
  2270		nr_reclaimed = shrink_page_list(&page_list, pgdat, sc, &stat, false);
  2271	
  2272		spin_lock_irq(&lruvec->lru_lock);
  2273		move_pages_to_lru(lruvec, &page_list);
  2274	
  2275		__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
  2276		item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
  2277		if (!cgroup_reclaim(sc))
  2278			__mod_node_page_state(pgdat, item, nr_reclaimed);
  2279		__mod_memcg_state(lruvec_memcg(lruvec), item, nr_reclaimed);
  2280		__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
  2281		spin_unlock_irq(&lruvec->lru_lock);
  2282	
  2283		lru_note_cost(lruvec, file, stat.nr_pageout);
  2284		mem_cgroup_uncharge_list(&page_list);
  2285		free_unref_page_list(&page_list);
  2286	
  2287		/*
  2288		 * If dirty pages are scanned that are not queued for IO, it
  2289		 * implies that flushers are not doing their job. This can
  2290		 * happen when memory pressure pushes dirty pages to the end of
  2291		 * the LRU before the dirty limits are breached and the dirty
  2292		 * data has expired. It can also happen when the proportion of
  2293		 * dirty pages grows not through writes but through memory
  2294		 * pressure reclaiming all the clean cache. And in some cases,
  2295		 * the flushers simply cannot keep up with the allocation
  2296		 * rate. Nudge the flusher threads in case they are asleep.
  2297		 */
  2298		if (stat.nr_unqueued_dirty == nr_taken)
  2299			wakeup_flusher_threads(WB_REASON_VMSCAN);
  2300	
  2301		sc->nr.dirty += stat.nr_dirty;
  2302		sc->nr.congested += stat.nr_congested;
  2303		sc->nr.unqueued_dirty += stat.nr_unqueued_dirty;
  2304		sc->nr.writeback += stat.nr_writeback;
  2305		sc->nr.immediate += stat.nr_immediate;
  2306		sc->nr.taken += nr_taken;
  2307		if (file)
  2308			sc->nr.file_taken += nr_taken;
  2309	
  2310		trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
  2311				nr_scanned, nr_reclaimed, &stat, sc->priority, file);
  2312		return nr_reclaimed;
  2313	}
  2314	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

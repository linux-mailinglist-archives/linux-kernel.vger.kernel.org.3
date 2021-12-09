Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1505C46F69A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhLIWTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:19:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:24392 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231475AbhLIWTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:19:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639088143; x=1670624143;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C2yo2e9AFBkANsAq4JMfQRtGleFDjrMfkGFpJjsNOOg=;
  b=mvpwlquFyfDoG6lV5OeWPbMFx6ZFWtD2BFA65l49pZrI5Okfy/YFM8WD
   ZXcN9S0YSOnLvVHgHaGxctYE3Q40+gIniMp3phZuhMLfSEJdbNGYu/qTf
   uiIgsWbZqFT9bdzNESEqZDLsL9R62iZ6vpFPnLbO1xYcElTR3lSMdE6nS
   vzmo7cBqKkOSIns9q9+0/wxvJgZGfPO7Q1wDC1p77MuZ0L0ehAE48yZIZ
   fKGJImmguukoRm4O26PASk7SeA4I/BYN2FRjMUfaIvfluc6jRjIsPTdZJ
   GLXFXEX+gKSOqqdRkdpez8U/NJ1b3Odv0yfFyfWqudWIr+N2iumMpji+O
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="324478025"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="324478025"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 14:15:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="543756698"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 09 Dec 2021 14:15:41 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvRhU-0002Ql-8P; Thu, 09 Dec 2021 22:15:40 +0000
Date:   Fri, 10 Dec 2021 06:15:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: mm/page_alloc.c:8046:12: error: implicit declaration of function
 'arch_alloc_nodedata'
Message-ID: <202112100636.K5fagHTG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20211209-184929/Alexey-Makhalov/mm-fix-panic-in-__alloc_pages/20211102-041405
head:   652e780546c1fdbe1adcbbe04106f4020e3bfb56
commit: 652e780546c1fdbe1adcbbe04106f4020e3bfb56 mm: fix panic in __alloc_pages
date:   11 hours ago
config: arm-randconfig-r004-20211209 (https://download.01.org/0day-ci/archive/20211210/202112100636.K5fagHTG-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/652e780546c1fdbe1adcbbe04106f4020e3bfb56
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20211209-184929/Alexey-Makhalov/mm-fix-panic-in-__alloc_pages/20211102-041405
        git checkout 652e780546c1fdbe1adcbbe04106f4020e3bfb56
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   mm/page_alloc.c:3804:15: warning: no previous prototype for function 'should_fail_alloc_page' [-Wmissing-prototypes]
   noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
                 ^
   mm/page_alloc.c:3804:10: note: declare 'static' if the function is not intended to be used outside of this translation unit
   noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
            ^
            static 
>> mm/page_alloc.c:8046:12: error: implicit declaration of function 'arch_alloc_nodedata' [-Werror,-Wimplicit-function-declaration]
                           pgdat = arch_alloc_nodedata(nid);
                                   ^
>> mm/page_alloc.c:8046:10: warning: incompatible integer to pointer conversion assigning to 'pg_data_t *' (aka 'struct pglist_data *') from 'int' [-Wint-conversion]
                           pgdat = arch_alloc_nodedata(nid);
                                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~
>> mm/page_alloc.c:8052:4: error: implicit declaration of function 'arch_refresh_nodedata' [-Werror,-Wimplicit-function-declaration]
                           arch_refresh_nodedata(nid, pgdat);
                           ^
   mm/page_alloc.c:8052:4: note: did you mean 'arch_alloc_nodedata'?
   mm/page_alloc.c:8046:12: note: 'arch_alloc_nodedata' declared here
                           pgdat = arch_alloc_nodedata(nid);
                                   ^
   2 warnings and 2 errors generated.


vim +/arch_alloc_nodedata +8046 mm/page_alloc.c

  7949	
  7950	/**
  7951	 * free_area_init - Initialise all pg_data_t and zone data
  7952	 * @max_zone_pfn: an array of max PFNs for each zone
  7953	 *
  7954	 * This will call free_area_init_node() for each active node in the system.
  7955	 * Using the page ranges provided by memblock_set_node(), the size of each
  7956	 * zone in each node and their holes is calculated. If the maximum PFN
  7957	 * between two adjacent zones match, it is assumed that the zone is empty.
  7958	 * For example, if arch_max_dma_pfn == arch_max_dma32_pfn, it is assumed
  7959	 * that arch_max_dma32_pfn has no pages. It is also assumed that a zone
  7960	 * starts where the previous one ended. For example, ZONE_DMA32 starts
  7961	 * at arch_max_dma_pfn.
  7962	 */
  7963	void __init free_area_init(unsigned long *max_zone_pfn)
  7964	{
  7965		unsigned long start_pfn, end_pfn;
  7966		int i, nid, zone;
  7967		bool descending;
  7968	
  7969		/* Record where the zone boundaries are */
  7970		memset(arch_zone_lowest_possible_pfn, 0,
  7971					sizeof(arch_zone_lowest_possible_pfn));
  7972		memset(arch_zone_highest_possible_pfn, 0,
  7973					sizeof(arch_zone_highest_possible_pfn));
  7974	
  7975		start_pfn = find_min_pfn_with_active_regions();
  7976		descending = arch_has_descending_max_zone_pfns();
  7977	
  7978		for (i = 0; i < MAX_NR_ZONES; i++) {
  7979			if (descending)
  7980				zone = MAX_NR_ZONES - i - 1;
  7981			else
  7982				zone = i;
  7983	
  7984			if (zone == ZONE_MOVABLE)
  7985				continue;
  7986	
  7987			end_pfn = max(max_zone_pfn[zone], start_pfn);
  7988			arch_zone_lowest_possible_pfn[zone] = start_pfn;
  7989			arch_zone_highest_possible_pfn[zone] = end_pfn;
  7990	
  7991			start_pfn = end_pfn;
  7992		}
  7993	
  7994		/* Find the PFNs that ZONE_MOVABLE begins at in each node */
  7995		memset(zone_movable_pfn, 0, sizeof(zone_movable_pfn));
  7996		find_zone_movable_pfns_for_nodes();
  7997	
  7998		/* Print out the zone ranges */
  7999		pr_info("Zone ranges:\n");
  8000		for (i = 0; i < MAX_NR_ZONES; i++) {
  8001			if (i == ZONE_MOVABLE)
  8002				continue;
  8003			pr_info("  %-8s ", zone_names[i]);
  8004			if (arch_zone_lowest_possible_pfn[i] ==
  8005					arch_zone_highest_possible_pfn[i])
  8006				pr_cont("empty\n");
  8007			else
  8008				pr_cont("[mem %#018Lx-%#018Lx]\n",
  8009					(u64)arch_zone_lowest_possible_pfn[i]
  8010						<< PAGE_SHIFT,
  8011					((u64)arch_zone_highest_possible_pfn[i]
  8012						<< PAGE_SHIFT) - 1);
  8013		}
  8014	
  8015		/* Print out the PFNs ZONE_MOVABLE begins at in each node */
  8016		pr_info("Movable zone start for each node\n");
  8017		for (i = 0; i < MAX_NUMNODES; i++) {
  8018			if (zone_movable_pfn[i])
  8019				pr_info("  Node %d: %#018Lx\n", i,
  8020				       (u64)zone_movable_pfn[i] << PAGE_SHIFT);
  8021		}
  8022	
  8023		/*
  8024		 * Print out the early node map, and initialize the
  8025		 * subsection-map relative to active online memory ranges to
  8026		 * enable future "sub-section" extensions of the memory map.
  8027		 */
  8028		pr_info("Early memory node ranges\n");
  8029		for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
  8030			pr_info("  node %3d: [mem %#018Lx-%#018Lx]\n", nid,
  8031				(u64)start_pfn << PAGE_SHIFT,
  8032				((u64)end_pfn << PAGE_SHIFT) - 1);
  8033			subsection_map_init(start_pfn, end_pfn - start_pfn);
  8034		}
  8035	
  8036		/* Initialise every node */
  8037		mminit_verify_pageflags_layout();
  8038		setup_nr_node_ids();
  8039		for_each_node(nid) {
  8040			pg_data_t *pgdat;
  8041	
  8042			if (!node_online(nid)) {
  8043				pr_warn("Node %d uninitialized by the platform. Please report with boot dmesg.\n", nid);
  8044	
  8045				/* Allocator not initialized yet */
> 8046				pgdat = arch_alloc_nodedata(nid);
  8047				if (!pgdat) {
  8048					pr_err("Cannot allocate %zuB for node %d.\n",
  8049							sizeof(*pgdat), nid);
  8050					continue;
  8051				}
> 8052				arch_refresh_nodedata(nid, pgdat);
  8053				free_area_init_memoryless_node(nid);
  8054				/*
  8055				 * not marking this node online because we do not want to
  8056				 * confuse userspace by sysfs files/directories for node
  8057				 * without any memory attached to it (see topology_init)
  8058				 * The pgdat will get fully initialized when a memory is
  8059				 * hotpluged into it by hotadd_init_pgdat
  8060				 */
  8061				continue;
  8062			}
  8063	
  8064			pgdat = NODE_DATA(nid);
  8065			free_area_init_node(nid);
  8066	
  8067			/* Any memory on that node */
  8068			if (pgdat->node_present_pages)
  8069				node_set_state(nid, N_MEMORY);
  8070			check_for_memory(pgdat, nid);
  8071		}
  8072	
  8073		memmap_init();
  8074	}
  8075	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

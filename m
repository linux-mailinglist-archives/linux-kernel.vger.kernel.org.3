Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFF1550DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbiFTANT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbiFTANR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:13:17 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EA1DF2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655683996; x=1687219996;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2vK1w86ELU1udupnQ2GwMp+TJkzuOBTJsz31heHbA5c=;
  b=FavB0R3xzS8npD65HTgAq7Bnb1F7iUkx1Z+ZUCkzJ/HMyL/y8k7HkF5n
   dqVpNM2fu1ShUKoVLRZ+V7F+8c3JLoeboEVkh/YV/TjUij8rqnfkvSUds
   rc3fq2dzEHqJAwT80DGgo/JhUWVna/piIl3PLocRN3kccU0PPGwRoJ2Vs
   PE9z/0IFG+6+yLLZiXvrbxA1gBZ56gMIoDRCPZJwrZXmJSgve0MVLdymI
   KND1yRhh7tQW/aP1W1ZWq6apsJYKvP/CFgk5uf9RO8f1a7hz92e9hvrEQ
   Iuv4gLJK5GeYBeBIv+YEIbQ7+tfCWZbk4/M+iLUGtX42vUbqo3GI/V/q0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278544458"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="278544458"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 17:13:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="642852509"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jun 2022 17:13:14 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o352Y-000RgN-2R;
        Mon, 20 Jun 2022 00:13:14 +0000
Date:   Mon, 20 Jun 2022 08:12:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: [akpm-mm:mm-unstable 260/261] mm/hugetlb_vmemmap.c:110:17: error:
 call to undeclared function 'sparse_decode_mem_map'; ISO C99 and later do
 not support implicit function declarations
Message-ID: <202206200857.ZpTFxNAY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
head:   882be1ed6b1b5073fc88552181b99bd2b9c0031f
commit: 10a76873547090b69a8c47788065a24696b152c3 [260/261] mm: memory_hotplug: make hugetlb_optimize_vmemmap compatible with memmap_on_memory
config: x86_64-randconfig-a013-20220620 (https://download.01.org/0day-ci/archive/20220620/202206200857.ZpTFxNAY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=10a76873547090b69a8c47788065a24696b152c3
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch --no-tags akpm-mm mm-unstable
        git checkout 10a76873547090b69a8c47788065a24696b152c3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> mm/hugetlb_vmemmap.c:110:17: error: call to undeclared function 'sparse_decode_mem_map'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           vmemmap_page = sparse_decode_mem_map(ms->section_mem_map,
                          ^
>> mm/hugetlb_vmemmap.c:110:15: warning: incompatible integer to pointer conversion assigning to 'struct page *' from 'int' [-Wint-conversion]
           vmemmap_page = sparse_decode_mem_map(ms->section_mem_map,
                        ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +/sparse_decode_mem_map +110 mm/hugetlb_vmemmap.c

    98	
    99	static unsigned int vmemmap_optimizable_pages(struct hstate *h,
   100						      struct page *head)
   101	{
   102		struct mem_section *ms;
   103		struct page *vmemmap_page;
   104		unsigned long pfn = page_to_pfn(head);
   105	
   106		if (READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
   107			return 0;
   108	
   109		ms = __pfn_to_section(pfn);
 > 110		vmemmap_page = sparse_decode_mem_map(ms->section_mem_map,
   111						     pfn_to_section_nr(pfn));
   112		/*
   113		 * Only the vmemmap pages' vmemmap may be marked as VmemmapSelfHosted.
   114		 *
   115		 * Due to HugeTLB alignment requirements, and the vmemmap pages being
   116		 * at the start of the hotplugged memory region. Checking any vmemmap
   117		 * page's vmemmap is fine.
   118		 *
   119		 * [      hotplugged memory     ]
   120		 * [ vmemmap ][  usable memory  ]
   121		 *   ^   |      |            |
   122		 *   +---+      |            |
   123		 *     ^        |            |
   124		 *     +--------+            |
   125		 *         ^                 |
   126		 *         +-----------------+
   127		 */
   128		if (PageVmemmapSelfHosted(vmemmap_page))
   129			return 0;
   130	
   131		return hugetlb_optimize_vmemmap_pages(h);
   132	}
   133	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FCE49A185
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2359787AbiAXXe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:34:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:45821 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1838274AbiAXWqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643064376; x=1674600376;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EQzUOUCbhBCOipT0hgr1+6zGQ5LZqpvbOMP2a69+wyU=;
  b=UWs0bXavYQMfAHQt1q0oN4Z1b3qDjrq2+MxevRLVZRPqwiwNMs8OwL8N
   jrfGKbA3aBQSLEwy+dBtJfRezP3zqvBn+/e4vt/HhXqMc/kb9myU7rinx
   5C/skAqTBwNESlHRIk5+xQOHgK5Yp/+YrIvT6RIR197D04xkXr0SkRZj2
   XI/ZsuQTYqTc9nlJzI1QvlRwfyxKmiQoO3keHcjgmQ1pskTTHiBsICLgq
   7Aig2HgU7riF9dO+p4nllh1ZaAmxb8uXxoXkhaudcvgUY0sjpIPjKsf7c
   j8KM4uJqUdJhxuBmH8RUTC+qpqEz4zjMtMaCHEPoleCFasCWCkUKVZRdC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246110616"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="246110616"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 14:46:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="562823631"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2022 14:46:11 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nC86F-000J2V-7B; Mon, 24 Jan 2022 22:46:11 +0000
Date:   Tue, 25 Jan 2022 06:45:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Salyzyn <salyzyn@google.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Heesub Shin <heesub.shin@samsung.com>,
        Laura Abbott <lauraa@codeaurora.org>,
        Liam Mark <lmark@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Swathi Sridhar <swatsrid@codeaurora.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android11-kiwi-5.4
 2314/9999] mm/page_alloc.c:2741:29: sparse: sparse: Using plain integer as
 NULL pointer
Message-ID: <202201250617.FDCLmCS1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android11-kiwi-5.4
head:   7d1d5848183bd1d9086d0572f9af431d3ded407f
commit: b9d3d8f1e991052edb89b0537b8f2e8b2aa941ac [2314/9999] ANDROID: GKI: cma: redirect page allocation to CMA
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220125/202201250617.FDCLmCS1-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/b9d3d8f1e991052edb89b0537b8f2e8b2aa941ac
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android11-kiwi-5.4
        git checkout b9d3d8f1e991052edb89b0537b8f2e8b2aa941ac
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   mm/page_alloc.c:106:1: sparse: sparse: symbol 'pcpu_drain_mutex' was not declared. Should it be static?
>> mm/page_alloc.c:2741:29: sparse: sparse: Using plain integer as NULL pointer
   mm/page_alloc.c:3252:51: sparse: sparse: incorrect type in argument 7 (different base types) @@     expected int cma @@     got restricted gfp_t @@
   mm/page_alloc.c:3252:51: sparse:     expected int cma
   mm/page_alloc.c:3252:51: sparse:     got restricted gfp_t
   mm/page_alloc.c: note: in included file (through include/linux/mm.h):
   include/linux/gfp.h:325:27: sparse: sparse: restricted gfp_t degrades to integer
   include/linux/gfp.h:325:27: sparse: sparse: restricted gfp_t degrades to integer

vim +2741 mm/page_alloc.c

  2736	
  2737	static struct page *__rmqueue_cma(struct zone *zone, unsigned int order,
  2738						int migratetype,
  2739						unsigned int alloc_flags)
  2740	{
> 2741		struct page *page = 0;
  2742	
  2743	retry:
  2744	#ifdef CONFIG_CMA
  2745		if (migratetype == MIGRATE_MOVABLE && !zone->cma_alloc)
  2746			page = __rmqueue_cma_fallback(zone, order);
  2747		else
  2748	#endif
  2749			page = __rmqueue_smallest(zone, order, migratetype);
  2750	
  2751		if (unlikely(!page) && __rmqueue_fallback(zone, order, migratetype,
  2752							  alloc_flags))
  2753			goto retry;
  2754	
  2755		trace_mm_page_alloc_zone_locked(page, order, migratetype);
  2756		return page;
  2757	}
  2758	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

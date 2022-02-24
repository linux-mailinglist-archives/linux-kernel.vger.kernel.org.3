Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613B34C3749
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiBXU6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiBXU62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:58:28 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E4D192E28
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645736277; x=1677272277;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=n4YIWfU6g7kTrFDHx0D2HIfNv62rTHIxAX7dEhEyOrM=;
  b=oHrANkt9fqPVysq+aN8fvNCB6NqmhQPOamXthflOVBotuAqlk+w+ZH4D
   yXSggUJfsVc1cKxH9NKqFF4JdAw1ZyyacHJZGjvsccBDkAituAkQ5jagA
   jdRyXMjum5PdR7IcaiGB69wnmfHPHnY/IMPFxwL/mbet1RhQXdDVabeW1
   34r5jceZYYAg6lmIc70yLxOBV69vuV150OaDI36mlKnc4o46CgPpBB/8D
   ogn1soxalQOfA7vw1WNA3jQoA6OEfrFGt2fo/23pCntwCgoB1f0xJVBCf
   CjhmSM69K0Qr8vOlI0hbVXV6tja3z/t7FjUOzj3AijdfcJgQkKkgedyqR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="251180293"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="251180293"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 12:52:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="592230420"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 24 Feb 2022 12:52:33 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNL6G-0003Sf-TO; Thu, 24 Feb 2022 20:52:32 +0000
Date:   Fri, 25 Feb 2022 04:51:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mel:mm-pcpllist-v1r1 15/16] mm/page_alloc.c:3079:16: warning:
 variable 'flags' set but not used
Message-ID: <202202250427.rG7MMEJp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git mm-pcpllist-v1r1
head:   b9d96cc9193b170b205c46a39f68b9b35e774a8d
commit: df8f36ca2610d80944adcf40720f6a88aba2b822 [15/16] mm/page_alloc: Demote local_lock_irqsave to local_lock
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220225/202202250427.rG7MMEJp-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git/commit/?id=df8f36ca2610d80944adcf40720f6a88aba2b822
        git remote add mel https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git
        git fetch --no-tags mel mm-pcpllist-v1r1
        git checkout df8f36ca2610d80944adcf40720f6a88aba2b822
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/page_alloc.c: In function 'drain_pages_zone':
>> mm/page_alloc.c:3079:16: warning: variable 'flags' set but not used [-Wunused-but-set-variable]
    3079 |  unsigned long flags;
         |                ^~~~~
   mm/page_alloc.c: In function 'free_unref_page':
   mm/page_alloc.c:3370:16: warning: variable 'flags' set but not used [-Wunused-but-set-variable]
    3370 |  unsigned long flags;
         |                ^~~~~
   mm/page_alloc.c: In function 'free_unref_page_list':
   mm/page_alloc.c:3410:16: warning: variable 'flags' set but not used [-Wunused-but-set-variable]
    3410 |  unsigned long flags;
         |                ^~~~~
   mm/page_alloc.c: In function 'rmqueue_pcplist':
   mm/page_alloc.c:3717:16: warning: variable 'flags' set but not used [-Wunused-but-set-variable]
    3717 |  unsigned long flags;
         |                ^~~~~
   mm/page_alloc.c: At top level:
   mm/page_alloc.c:3854:15: warning: no previous prototype for 'should_fail_alloc_page' [-Wmissing-prototypes]
    3854 | noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
         |               ^~~~~~~~~~~~~~~~~~~~~~
   mm/page_alloc.c: In function '__alloc_pages_bulk':
   mm/page_alloc.c:5245:16: warning: variable 'flags' set but not used [-Wunused-but-set-variable]
    5245 |  unsigned long flags;
         |                ^~~~~


vim +/flags +3079 mm/page_alloc.c

4ae7c03943fca7 Christoph Lameter 2005-06-21  3073  
9f8f2172537de7 Christoph Lameter 2008-02-04  3074  /*
93481ff0e5a0c7 Vlastimil Babka   2014-12-10  3075   * Drain pcplists of the indicated processor and zone.
9f8f2172537de7 Christoph Lameter 2008-02-04  3076   */
93481ff0e5a0c7 Vlastimil Babka   2014-12-10  3077  static void drain_pages_zone(unsigned int cpu, struct zone *zone)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3078  {
c54ad30c784b84 Nicholas Piggin   2006-01-06 @3079  	unsigned long flags;
3dfa5721f12c3d Christoph Lameter 2008-02-04  3080  	struct per_cpu_pages *pcp;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3081  
df8f36ca2610d8 Mel Gorman        2022-02-22  3082  	pcp_local_lock(&pagesets.lock, flags);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3083  
28f836b6777b6f Mel Gorman        2021-06-28  3084  	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
d8d59b4758bcd1 Mel Gorman        2022-02-21  3085  	if (pcp->count) {
d8d59b4758bcd1 Mel Gorman        2022-02-21  3086  		spin_lock(&pcp->lock);
c3d92154d2034c Mel Gorman        2022-02-11  3087  		free_pcppages_bulk(zone, pcp->count, pcp, 0);
d8d59b4758bcd1 Mel Gorman        2022-02-21  3088  		spin_unlock(&pcp->lock);
d8d59b4758bcd1 Mel Gorman        2022-02-21  3089  	}
28f836b6777b6f Mel Gorman        2021-06-28  3090  
df8f36ca2610d8 Mel Gorman        2022-02-22  3091  	pcp_local_unlock(&pagesets.lock, flags);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3092  }
93481ff0e5a0c7 Vlastimil Babka   2014-12-10  3093  

:::::: The code at line 3079 was first introduced by commit
:::::: c54ad30c784b84d0275152d0ca80985b21471811 [PATCH] mm: pagealloc opt

:::::: TO: Nick Piggin <nickpiggin@yahoo.com.au>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A678539998
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 00:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347144AbiEaWkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 18:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238162AbiEaWj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:39:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA9C9E9EB
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 15:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654036798; x=1685572798;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nVgP5vSRgzfo4A3lRtG7QXD2JB7Ijr336pExyeOkV9g=;
  b=Z+9M/z2JyP/f8NWSLvDL6BwsvN0R5raEER4XHz9mDzitGw5KSy96axLC
   foCG2wDSTu6NZyJeusrLxTMVemNvb4eiFgdEZW/SbVJHj+lkPTRJDp3CX
   YAuufxupuhHHFKyV8aWAQeakJfEcgKcyrHH/bMN3e3LKdqWhqvcuUFG7q
   9IKlmgWB4I4N9y2xIlLRIuaEjmes3+CadMu7dfBCX2THOiYCyx2U1lPK7
   LTlUKdzNNrZdNPC7luj7xR7iiMX0mmpTp8X5TUSRbuvCm1mr/iRrLI89K
   hV637HKWdWvGRMgydHUGf+rVYe4T/58l6lJoRZtEQONU1CqP2WDtsFcVn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="275412858"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="275412858"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 15:39:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="755325105"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 31 May 2022 15:39:29 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwAWP-0003AI-06;
        Tue, 31 May 2022 22:39:29 +0000
Date:   Wed, 1 Jun 2022 06:38:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chen Lin <chen45464546@163.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: mm/page_alloc.c:5662:23: error: 'fragz' undeclared; did you mean
 'fragsz'?
Message-ID: <202206010617.PBI0ZWvr-lkp@intel.com>
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

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220531-224555/Chen-Lin/mm-page_frag-Warn_on-when-frag_alloc-size-is-bigger-than-PAGE_SIZE/20220528-234129
head:   21e940b5a66de64088e93248c21bce241c28a556
commit: 21e940b5a66de64088e93248c21bce241c28a556 mm: page_frag: Warn_on when frag_alloc size is bigger than PAGE_SIZE
date:   8 hours ago
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20220601/202206010617.PBI0ZWvr-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/21e940b5a66de64088e93248c21bce241c28a556
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220531-224555/Chen-Lin/mm-page_frag-Warn_on-when-frag_alloc-size-is-bigger-than-PAGE_SIZE/20220528-234129
        git checkout 21e940b5a66de64088e93248c21bce241c28a556
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:7,
                    from arch/x86/include/asm/bug.h:87,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from mm/page_alloc.c:19:
   mm/page_alloc.c: In function 'page_frag_alloc_align':
>> mm/page_alloc.c:5662:23: error: 'fragz' undeclared (first use in this function); did you mean 'fragsz'?
    5662 |         if (WARN_ONCE(fragz > PAGE_SIZE,
         |                       ^~~~~
   include/linux/once_lite.h:15:41: note: in definition of macro 'DO_ONCE_LITE_IF'
      15 |                 bool __ret_do_once = !!(condition);                     \
         |                                         ^~~~~~~~~
   mm/page_alloc.c:5662:13: note: in expansion of macro 'WARN_ONCE'
    5662 |         if (WARN_ONCE(fragz > PAGE_SIZE,
         |             ^~~~~~~~~
   mm/page_alloc.c:5662:23: note: each undeclared identifier is reported only once for each function it appears in
    5662 |         if (WARN_ONCE(fragz > PAGE_SIZE,
         |                       ^~~~~
   include/linux/once_lite.h:15:41: note: in definition of macro 'DO_ONCE_LITE_IF'
      15 |                 bool __ret_do_once = !!(condition);                     \
         |                                         ^~~~~~~~~
   mm/page_alloc.c:5662:13: note: in expansion of macro 'WARN_ONCE'
    5662 |         if (WARN_ONCE(fragz > PAGE_SIZE,
         |             ^~~~~~~~~


vim +5662 mm/page_alloc.c

  5649	
  5650	void *page_frag_alloc_align(struct page_frag_cache *nc,
  5651			      unsigned int fragsz, gfp_t gfp_mask,
  5652			      unsigned int align_mask)
  5653	{
  5654		unsigned int size = PAGE_SIZE;
  5655		struct page *page;
  5656		int offset;
  5657	
  5658		/*
  5659		 * frag_alloc is not suitable for memory alloc which fragsz
  5660		 * is bigger than PAGE_SIZE, use kmalloc or alloc_pages instead.
  5661		 */
> 5662		if (WARN_ONCE(fragz > PAGE_SIZE,
  5663			      "alloc fragsz(%d) > PAGE_SIZE(%ld) not supported, alloc fail\n",
  5664			      fragsz, PAGE_SIZE))
  5665			return NULL;
  5666	
  5667		if (unlikely(!nc->va)) {
  5668	refill:
  5669			page = __page_frag_cache_refill(nc, gfp_mask);
  5670			if (!page)
  5671				return NULL;
  5672	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570C350D692
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 03:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbiDYBe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 21:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiDYBeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 21:34:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E759BE8865
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 18:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650850280; x=1682386280;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I2I7iPrXxPq/LghvQQzC2dsZHC16hh9lCTEfhSrfCxk=;
  b=jhnc1LxGpBbpury7Wv5cE36UHO2buR1mXKwF+WuzJ1DkIraGQqN0uEfk
   EvADXKN2oHcYXPcvmsG9Q0cQxJkQArFg+XmiifnZHPdzv3NmwkTamrkDX
   N6D6TrV2yy5CkCsjVP59KfSNgZb6oZV4uWGnziVCGxn6pUzSD4DfxryO7
   9/OLqceP92t3DIFmHomgsmNMPlqfF6VEGnCmaH7znyFrpwf8iNhNdBrEN
   gwUgNEIVRr4YPz0me5M1GLqNQOckINNr02tKlR2BXRU+2/varT/hEJK/d
   bxF/V7DFCuiDI/xvep9y+ImDFDGtgWYXw0P72wnVhQvgYFZN/BYqgPd8P
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="262708793"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="262708793"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 18:31:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="729486011"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Apr 2022 18:31:19 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ninZO-000227-QA;
        Mon, 25 Apr 2022 01:31:18 +0000
Date:   Mon, 25 Apr 2022 09:30:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1805/2579] include/linux/gfp_api.h:26:27:
 sparse: sparse: restricted gfp_t degrades to integer
Message-ID: <202204250949.KPASl3Sz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: ae3f246b57ee3809edbb8b4bc6f887cc0e9e2f9e [1805/2579] headers/deps: mm: Create <linux/gfp_api.h>
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220425/202204250949.KPASl3Sz-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=ae3f246b57ee3809edbb8b4bc6f887cc0e9e2f9e
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout ae3f246b57ee3809edbb8b4bc6f887cc0e9e2f9e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   mm/page_owner.c: note: in included file (through include/linux/mm.h, include/linux/mm_api.h):
>> include/linux/gfp_api.h:26:27: sparse: sparse: restricted gfp_t degrades to integer
>> include/linux/gfp_api.h:26:27: sparse: sparse: restricted gfp_t degrades to integer
>> include/linux/gfp_api.h:26:27: sparse: sparse: restricted gfp_t degrades to integer
--
   mm/compaction.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/compaction.h):
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast from restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long flags @@     got restricted gfp_t [usertype] gfp_mask @@
   include/trace/events/compaction.h:155:1: sparse:     expected unsigned long flags
   include/trace/events/compaction.h:155:1: sparse:     got restricted gfp_t [usertype] gfp_mask
   mm/compaction.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/compaction.h):
   include/trace/events/compaction.h:155:1: sparse: sparse: cast to restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: cast to restricted gfp_t
   include/trace/events/compaction.h:155:1: sparse: sparse: restricted gfp_t degrades to integer
   include/trace/events/compaction.h:155:1: sparse: sparse: restricted gfp_t degrades to integer
   mm/compaction.c:2619:39: sparse: sparse: incorrect type in initializer (different base types) @@     expected int may_perform_io @@     got restricted gfp_t @@
   mm/compaction.c:2619:39: sparse:     expected int may_perform_io
   mm/compaction.c:2619:39: sparse:     got restricted gfp_t
   mm/compaction.c:555:39: sparse: sparse: context imbalance in 'compact_unlock_should_abort' - unexpected unlock
   mm/compaction.c:675:39: sparse: sparse: context imbalance in 'isolate_freepages_block' - unexpected unlock
   mm/compaction.c: note: in included file (through include/linux/mm.h, include/linux/huge_mm.h):
>> include/linux/gfp_api.h:26:27: sparse: sparse: restricted gfp_t degrades to integer
--
   mm/page_alloc.c: note: in included file (through include/linux/mm.h, include/linux/huge_mm.h):
>> include/linux/gfp_api.h:26:27: sparse: sparse: restricted gfp_t degrades to integer
>> include/linux/gfp_api.h:26:27: sparse: sparse: restricted gfp_t degrades to integer
>> include/linux/gfp_api.h:26:27: sparse: sparse: restricted gfp_t degrades to integer
>> include/linux/gfp_api.h:26:27: sparse: sparse: restricted gfp_t degrades to integer
>> include/linux/gfp_api.h:26:27: sparse: sparse: restricted gfp_t degrades to integer
>> include/linux/gfp_api.h:26:27: sparse: sparse: restricted gfp_t degrades to integer

vim +26 include/linux/gfp_api.h

    15	
    16	static inline int gfp_migratetype(const gfp_t gfp_flags)
    17	{
    18		VM_WARN_ON((gfp_flags & GFP_MOVABLE_MASK) == GFP_MOVABLE_MASK);
    19		BUILD_BUG_ON((1UL << GFP_MOVABLE_SHIFT) != ___GFP_MOVABLE);
    20		BUILD_BUG_ON((___GFP_MOVABLE >> GFP_MOVABLE_SHIFT) != MIGRATE_MOVABLE);
    21	
    22		if (unlikely(page_group_by_mobility_disabled))
    23			return MIGRATE_UNMOVABLE;
    24	
    25		/* Group based on mobility */
  > 26		return (gfp_flags & GFP_MOVABLE_MASK) >> GFP_MOVABLE_SHIFT;
    27	}
    28	#undef GFP_MOVABLE_MASK
    29	#undef GFP_MOVABLE_SHIFT
    30	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

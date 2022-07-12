Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188B3570F2D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiGLBEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiGLBEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:04:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C00424F19
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657587891; x=1689123891;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bacrT//99odhtcJ5/2XauPck3pW4WpX8jwqyVT+j29o=;
  b=LHbL1pqzzApJKBX2kg6PDoid0bwLQXPGr10gDsBKTV2inlFGqt5+3R36
   lwW1Z01nR0TEClzCxk3kyyEIbgamzenwWO4PuQJEGSwt6xPhdrhsvSoyb
   Xpra9YSHo3kWJiFBvx1BGvFuhtowNZTAEla9N8R6Oj0zOPiAnB4hGkm3p
   ue0d1TC3wPbOh5OLMLAdwPlQTYwVZd9pOLf+v7vSothj9UJ5SogvCpJKt
   s7GYZuII6mfxfz143ZRpXhgqbEp1GKusSJxbewbcXPMoGfKl9r6s1pOpn
   4whU1a0U4IxPe5Zcc3/7hfkvWhccQJGJeUphNSXIeKFdvPdO8CLP0iEbC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="348786729"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="348786729"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 18:04:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="662761459"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jul 2022 18:04:49 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oB4KW-0001Sz-Nw;
        Tue, 12 Jul 2022 01:04:48 +0000
Date:   Tue, 12 Jul 2022 09:04:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [chunkuang-hu:pagecaller 1/2] mm/page_alloc.c:193:33: warning:
 conversion from 'long long unsigned int' to 'long unsigned int' changes
 value from '18446744073709551615' to '4294967295'
Message-ID: <202207120805.VMoxhHK2-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git pagecaller
head:   de987a7312cd3e22d7d6985225db9839c3bd9818
commit: c879bb3e3a54d1e18415030a68f327dc4cf17363 [1/2] mm: Add pagecaller base trace point
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220712/202207120805.VMoxhHK2-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/commit/?id=c879bb3e3a54d1e18415030a68f327dc4cf17363
        git remote add chunkuang-hu https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git
        git fetch --no-tags chunkuang-hu pagecaller
        git checkout c879bb3e3a54d1e18415030a68f327dc4cf17363
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/page_alloc.c: In function 'pagecaller_get':
>> mm/page_alloc.c:193:33: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '18446744073709551615' to '4294967295' [-Woverflow]
     193 | #define PAGECALLER_RESERVED     0xffffffffffffffff
         |                                 ^~~~~~~~~~~~~~~~~~
   mm/page_alloc.c:939:24: note: in expansion of macro 'PAGECALLER_RESERVED'
     939 |                 return PAGECALLER_RESERVED;
         |                        ^~~~~~~~~~~~~~~~~~~
>> mm/page_alloc.c:193:33: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '18446744073709551615' to '4294967295' [-Woverflow]
     193 | #define PAGECALLER_RESERVED     0xffffffffffffffff
         |                                 ^~~~~~~~~~~~~~~~~~
   mm/page_alloc.c:944:16: note: in expansion of macro 'PAGECALLER_RESERVED'
     944 |         return PAGECALLER_RESERVED;
         |                ^~~~~~~~~~~~~~~~~~~
   mm/page_alloc.c: In function 'free_area_init_node':
>> mm/page_alloc.c:193:33: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '18446744073709551615' to '4294967295' [-Woverflow]
     193 | #define PAGECALLER_RESERVED     0xffffffffffffffff
         |                                 ^~~~~~~~~~~~~~~~~~
   mm/page_alloc.c:7798:56: note: in expansion of macro 'PAGECALLER_RESERVED'
    7798 |                 pagecaller_set(0, end_pfn - start_pfn, PAGECALLER_RESERVED);
         |                                                        ^~~~~~~~~~~~~~~~~~~


vim +193 mm/page_alloc.c

   190	
   191	#ifdef CONFIG_PAGECALLER
   192	#define PAGECALLER_FREE		0
 > 193	#define PAGECALLER_RESERVED	0xffffffffffffffff
   194	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46414BA1D3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241450AbiBQNrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:47:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241434AbiBQNrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:47:09 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9484F5FA1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645105612; x=1676641612;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IRMYvqtZwSpO6PEeyPJDE8QpQ6MriLpky18kjc5z/04=;
  b=e92mWgU+MRhz/VikDyWy5k5YBmukK10JgzdOPw6vgS2GDDU4R4JC83GQ
   l2gBQeR26Zc3cxEJTbpk/1a+s8LK5uIip5p4inFsjKeg38GmF6EXW3rsw
   r/eoTbwkQcyBv8t8DKjq+Qmsm/rWxdDKZJ4N4wsYYgBFf/3F6KcNEX1wz
   oPD8pKK/uznTG9uyrV4mzSwwopSwzO6LeAqPrrX7V4E4xXPWCRqe9rC6b
   lG8HNVlz4OA05Rn2LXgfK7yrSmcyulEoDuOhXnQvl2o3QyT6gCM6BPV5w
   bnvH4fie4wUJKdVb9VCF1vQ1MVqSSnfhoMf3PyldZrWlSuHC0mHkNPoA9
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="250611551"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="250611551"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 05:46:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="530228258"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 17 Feb 2022 05:46:50 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKh7R-0000Ek-VZ; Thu, 17 Feb 2022 13:46:49 +0000
Date:   Thu, 17 Feb 2022 21:45:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: arch/arm/mach-ep93xx/clock.c:210:35: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202202172100.TE6YfATQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f71077a4d84bbe8c7b91b7db7c4ef815755ac5e3
commit: 9645ccc7bd7a16cd73c3be9dee70cd702b03be37 ep93xx: clock: convert in-place to COMMON_CLK
date:   4 months ago
config: arm-randconfig-s032-20220217 (https://download.01.org/0day-ci/archive/20220217/202202172100.TE6YfATQ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9645ccc7bd7a16cd73c3be9dee70cd702b03be37
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9645ccc7bd7a16cd73c3be9dee70cd702b03be37
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/arm/mach-ep93xx/clock.c:210:35: sparse: sparse: Using plain integer as NULL pointer
   arch/arm/mach-ep93xx/clock.c:99:9: sparse: sparse: context imbalance in 'ep93xx_clk_enable' - different lock contexts for basic block
   arch/arm/mach-ep93xx/clock.c:116:9: sparse: sparse: context imbalance in 'ep93xx_clk_disable' - different lock contexts for basic block
   arch/arm/mach-ep93xx/clock.c:197:9: sparse: sparse: context imbalance in 'ep93xx_mux_set_parent_lock' - different lock contexts for basic block

vim +210 arch/arm/mach-ep93xx/clock.c

   205	
   206	static int ep93xx_mux_determine_rate(struct clk_hw *hw,
   207					struct clk_rate_request *req)
   208	{
   209		unsigned long rate = req->rate;
 > 210		struct clk *best_parent = 0;
   211		unsigned long __parent_rate;
   212		unsigned long best_rate = 0, actual_rate, mclk_rate;
   213		unsigned long best_parent_rate;
   214		int __div = 0, __pdiv = 0;
   215		int i;
   216	
   217		/*
   218		 * Try the two pll's and the external clock
   219		 * Because the valid predividers are 2, 2.5 and 3, we multiply
   220		 * all the clocks by 2 to avoid floating point math.
   221		 *
   222		 * This is based on the algorithm in the ep93xx raster guide:
   223		 * http://be-a-maverick.com/en/pubs/appNote/AN269REV1.pdf
   224		 *
   225		 */
   226		for (i = 0; i < ARRAY_SIZE(mux_parents); i++) {
   227			struct clk *parent = clk_get_sys(mux_parents[i], NULL);
   228	
   229			__parent_rate = clk_get_rate(parent);
   230			mclk_rate = __parent_rate * 2;
   231	
   232			/* Try each predivider value */
   233			for (__pdiv = 4; __pdiv <= 6; __pdiv++) {
   234				__div = mclk_rate / (rate * __pdiv);
   235				if (__div < 2 || __div > 127)
   236					continue;
   237	
   238				actual_rate = mclk_rate / (__pdiv * __div);
   239				if (is_best(rate, actual_rate, best_rate)) {
   240					best_rate = actual_rate;
   241					best_parent_rate = __parent_rate;
   242					best_parent = parent;
   243				}
   244			}
   245		}
   246	
   247		if (!best_parent)
   248			return -EINVAL;
   249	
   250		req->best_parent_rate = best_parent_rate;
   251		req->best_parent_hw = __clk_get_hw(best_parent);
   252		req->rate = best_rate;
   253	
   254		return 0;
   255	}
   256	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

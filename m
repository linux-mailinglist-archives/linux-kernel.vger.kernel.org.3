Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB66148FE3B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 18:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbiAPRvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 12:51:11 -0500
Received: from mga11.intel.com ([192.55.52.93]:59816 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231300AbiAPRvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 12:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642355470; x=1673891470;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L4V4B+IwpyR9wgYyuAvJP6EjO4dTV71ecF6SQLdY6Sk=;
  b=KkEIFmRagUUD/e8AUWm+HooiQHLSkV5AYwt75XAy/DDDD5ZmLtjYx7fP
   xxA9aFrz3vHgUN0C4nxKrhrQghULT42uyw+1HZZ//ypuvaJpLTh5bXedz
   z+fsjzqjOwqgmjR0nIDwQFiV0Ei/sXabmlleJHH17yWIvijk3P97aEe3G
   Qe0k2Q4ep1YHRZ2z1lILwNemEHW1/0oIVHciOu0PS/Fl6YsutxOO3UkOz
   Pm+M2+OlAWwVHe3HwNaTMU4UIGQHIfTFfLzbihEdXHSWDS6FZXNJFNzRg
   42xB3R0Rpto4dDkDulzu6IVbFNmiKqIX/AtS+G6Y9umd/7uGHFBwKaZXH
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="242063695"
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="242063695"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 09:51:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="692828947"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Jan 2022 09:51:08 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n99gJ-000Asu-Fa; Sun, 16 Jan 2022 17:51:07 +0000
Date:   Mon, 17 Jan 2022 01:50:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: arch/arm/mach-ep93xx/clock.c:210:35: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202201170148.vIvPQRko-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4d66020dcef83314092f2c8c89152a8d122627e2
commit: 9645ccc7bd7a16cd73c3be9dee70cd702b03be37 ep93xx: clock: convert in-place to COMMON_CLK
date:   3 months ago
config: arm-randconfig-s031-20220116 (https://download.01.org/0day-ci/archive/20220117/202201170148.vIvPQRko-lkp@intel.com/config)
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

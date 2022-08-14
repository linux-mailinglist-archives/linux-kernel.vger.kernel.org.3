Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D41591EDE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 09:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbiHNHPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 03:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHNHPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 03:15:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F18DEE0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 00:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660461348; x=1691997348;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oRDa5ZLnBnhO4uPN1ZD+3WCz56YVXnwk6iYSKbT57ME=;
  b=klc2ch2jTOMJQyn9lseYP1okAvPnDjVUogR0WqR+JqPx2TW5CBsp9324
   K5pLhrHSbWklK6qkVDV+kANZjhXxeTn5RFuG0cScflrIr0TmF6smdBvgm
   eZrct6Ep9Yf2Avcf2SX+AVHSf4X3/T8u2nlt/PUklH8p0qAYkWCMasxbd
   lWB6N12MFrxJgU4dHmoO4YhGBAusRdqVFBGkzYVuINdf6EzzA0LhKs38l
   9TaqysnZXft6PSIyWnKdopGvkbYr6EOmVraG0ICMjw2X/hUPexoj4A/LE
   licsam/qMN57ZICZolN0jfHSbmrraYzIs2VntPyLomf/t2ElvObY+GjOn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="274858320"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="274858320"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 00:15:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="582535228"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Aug 2022 00:15:46 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN7qb-0002cJ-2t;
        Sun, 14 Aug 2022 07:15:45 +0000
Date:   Sun, 14 Aug 2022 15:15:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-imx/pm-imx5.c:360:36: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202208141502.qg2ciW6Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea23e7c464bfdec04b52cf61edb62030e9e0d0a
commit: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time
date:   6 months ago
config: arm-randconfig-s031-20220810 (https://download.01.org/0day-ci/archive/20220814/202208141502.qg2ciW6Z-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f68f2ff91512c199ec24883001245912afc17873
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f68f2ff91512c199ec24883001245912afc17873
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   arch/arm/mach-imx/pm-imx5.c:244:17: sparse: sparse: restricted suspend_state_t degrades to integer
   arch/arm/mach-imx/pm-imx5.c:244:25: sparse: sparse: restricted suspend_state_t degrades to integer
   arch/arm/mach-imx/pm-imx5.c:244:42: sparse: sparse: restricted suspend_state_t degrades to integer
   arch/arm/mach-imx/pm-imx5.c:244:51: sparse: sparse: restricted suspend_state_t degrades to integer
   arch/arm/mach-imx/pm-imx5.c:342:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct imx5_cpu_suspend_info *suspend_info @@     got void [noderef] __iomem *static [addressable] [toplevel] suspend_ocram_base @@
   arch/arm/mach-imx/pm-imx5.c:342:22: sparse:     expected struct imx5_cpu_suspend_info *suspend_info
   arch/arm/mach-imx/pm-imx5.c:342:22: sparse:     got void [noderef] __iomem *static [addressable] [toplevel] suspend_ocram_base
>> arch/arm/mach-imx/pm-imx5.c:360:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   arch/arm/mach-imx/pm-imx5.c:360:36: sparse:     expected void const *
   arch/arm/mach-imx/pm-imx5.c:360:36: sparse:     got void [noderef] __iomem *
>> arch/arm/mach-imx/pm-imx5.c:360:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   arch/arm/mach-imx/pm-imx5.c:360:36: sparse:     expected void const *
   arch/arm/mach-imx/pm-imx5.c:360:36: sparse:     got void [noderef] __iomem *
   arch/arm/mach-imx/pm-imx5.c:360:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/arm/mach-imx/pm-imx5.c:360:36: sparse:     expected void *
   arch/arm/mach-imx/pm-imx5.c:360:36: sparse:     got void [noderef] __iomem *
--
   arch/arm/mach-imx/pm-imx6.c:373:24: sparse: sparse: cast removes address space '__iomem' of expression
   arch/arm/mach-imx/pm-imx6.c:513:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base @@
   arch/arm/mach-imx/pm-imx6.c:513:16: sparse:     expected void *p
   arch/arm/mach-imx/pm-imx6.c:513:16: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base
   arch/arm/mach-imx/pm-imx6.c:514:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct imx6_cpu_pm_info *pm_info @@     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base @@
   arch/arm/mach-imx/pm-imx6.c:514:17: sparse:     expected struct imx6_cpu_pm_info *pm_info
   arch/arm/mach-imx/pm-imx6.c:514:17: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base
>> arch/arm/mach-imx/pm-imx6.c:570:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse:     expected void const *
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse:     got void [noderef] __iomem *
>> arch/arm/mach-imx/pm-imx6.c:570:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse:     expected void const *
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse:     got void [noderef] __iomem *
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse:     expected void *
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse:     got void [noderef] __iomem *

vim +360 arch/arm/mach-imx/pm-imx5.c

1579c7b9fe0105 Martin Fuzzey 2015-05-12  322  
1579c7b9fe0105 Martin Fuzzey 2015-05-12  323  static int __init imx5_suspend_init(const struct imx5_pm_data *soc_data)
1579c7b9fe0105 Martin Fuzzey 2015-05-12  324  {
1579c7b9fe0105 Martin Fuzzey 2015-05-12  325  	struct imx5_cpu_suspend_info *suspend_info;
1579c7b9fe0105 Martin Fuzzey 2015-05-12  326  	int ret;
1579c7b9fe0105 Martin Fuzzey 2015-05-12  327  	/* Need this to avoid compile error due to const typeof in fncpy.h */
1579c7b9fe0105 Martin Fuzzey 2015-05-12  328  	void (*suspend_asm)(void __iomem *) = soc_data->suspend_asm;
1579c7b9fe0105 Martin Fuzzey 2015-05-12  329  
1579c7b9fe0105 Martin Fuzzey 2015-05-12  330  	if (!suspend_asm)
1579c7b9fe0105 Martin Fuzzey 2015-05-12  331  		return 0;
1579c7b9fe0105 Martin Fuzzey 2015-05-12  332  
1579c7b9fe0105 Martin Fuzzey 2015-05-12  333  	if (!soc_data->suspend_asm_sz || !*soc_data->suspend_asm_sz)
1579c7b9fe0105 Martin Fuzzey 2015-05-12  334  		return -EINVAL;
1579c7b9fe0105 Martin Fuzzey 2015-05-12  335  
1579c7b9fe0105 Martin Fuzzey 2015-05-12  336  	ret = imx_suspend_alloc_ocram(
1579c7b9fe0105 Martin Fuzzey 2015-05-12  337  		*soc_data->suspend_asm_sz + sizeof(*suspend_info),
1579c7b9fe0105 Martin Fuzzey 2015-05-12  338  		&suspend_ocram_base, NULL);
1579c7b9fe0105 Martin Fuzzey 2015-05-12  339  	if (ret)
1579c7b9fe0105 Martin Fuzzey 2015-05-12  340  		return ret;
1579c7b9fe0105 Martin Fuzzey 2015-05-12  341  
1579c7b9fe0105 Martin Fuzzey 2015-05-12  342  	suspend_info = suspend_ocram_base;
1579c7b9fe0105 Martin Fuzzey 2015-05-12  343  
1579c7b9fe0105 Martin Fuzzey 2015-05-12  344  	suspend_info->io_count = soc_data->suspend_io_count;
1579c7b9fe0105 Martin Fuzzey 2015-05-12  345  	memcpy(suspend_info->io_state, soc_data->suspend_io_config,
1579c7b9fe0105 Martin Fuzzey 2015-05-12  346  	       sizeof(*suspend_info->io_state) * soc_data->suspend_io_count);
1579c7b9fe0105 Martin Fuzzey 2015-05-12  347  
1579c7b9fe0105 Martin Fuzzey 2015-05-12  348  	suspend_info->m4if_base = ioremap(soc_data->m4if_addr, SZ_16K);
1579c7b9fe0105 Martin Fuzzey 2015-05-12  349  	if (!suspend_info->m4if_base) {
1579c7b9fe0105 Martin Fuzzey 2015-05-12  350  		ret = -ENOMEM;
1579c7b9fe0105 Martin Fuzzey 2015-05-12  351  		goto failed_map_m4if;
1579c7b9fe0105 Martin Fuzzey 2015-05-12  352  	}
1579c7b9fe0105 Martin Fuzzey 2015-05-12  353  
1579c7b9fe0105 Martin Fuzzey 2015-05-12  354  	suspend_info->iomuxc_base = ioremap(soc_data->iomuxc_addr, SZ_16K);
1579c7b9fe0105 Martin Fuzzey 2015-05-12  355  	if (!suspend_info->iomuxc_base) {
1579c7b9fe0105 Martin Fuzzey 2015-05-12  356  		ret = -ENOMEM;
1579c7b9fe0105 Martin Fuzzey 2015-05-12  357  		goto failed_map_iomuxc;
1579c7b9fe0105 Martin Fuzzey 2015-05-12  358  	}
1579c7b9fe0105 Martin Fuzzey 2015-05-12  359  
1579c7b9fe0105 Martin Fuzzey 2015-05-12 @360  	imx5_suspend_in_ocram_fn = fncpy(
1579c7b9fe0105 Martin Fuzzey 2015-05-12  361  		suspend_ocram_base + sizeof(*suspend_info),
1579c7b9fe0105 Martin Fuzzey 2015-05-12  362  		suspend_asm,
1579c7b9fe0105 Martin Fuzzey 2015-05-12  363  		*soc_data->suspend_asm_sz);
1579c7b9fe0105 Martin Fuzzey 2015-05-12  364  
1579c7b9fe0105 Martin Fuzzey 2015-05-12  365  	return 0;
1579c7b9fe0105 Martin Fuzzey 2015-05-12  366  
1579c7b9fe0105 Martin Fuzzey 2015-05-12  367  failed_map_iomuxc:
1579c7b9fe0105 Martin Fuzzey 2015-05-12  368  	iounmap(suspend_info->m4if_base);
1579c7b9fe0105 Martin Fuzzey 2015-05-12  369  
1579c7b9fe0105 Martin Fuzzey 2015-05-12  370  failed_map_m4if:
1579c7b9fe0105 Martin Fuzzey 2015-05-12  371  	return ret;
1579c7b9fe0105 Martin Fuzzey 2015-05-12  372  }
1579c7b9fe0105 Martin Fuzzey 2015-05-12  373  

:::::: The code at line 360 was first introduced by commit
:::::: 1579c7b9fe0105a523440ec13b0c59da53c880e3 ARM: imx53: Set DDR pins to high impedance when in suspend to RAM.

:::::: TO: Martin Fuzzey <mfuzzey@parkeon.com>
:::::: CC: Shawn Guo <shawn.guo@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFFB591F11
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 10:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbiHNITv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 04:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiHNITt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 04:19:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B8A167E6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 01:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660465188; x=1692001188;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sMGI1PBCXPiwQFpImnOTFtLRtdoRE3/pr0FYHKtHiUU=;
  b=mjnS3FSlHuGzNEZ1nn5AduWuE2uq/wbDk0NtE1oryqjPj5d4H12ShxFj
   ftbKS2Zovjkhv/ZcImVzJz3v9fKrrUmZlzVDoupeCcFOvX1KNY/aPGRUI
   oj9KMd0pT7tC2iaLXEJpjX9YUuCIjtkNaiLCPQwdP7DlXJV5AP+oAbFw6
   7dp4vV30UpAQSqNBl/JkZbwLRv8v1ifzHrYMtwNaQ5VQGYJ5AAW4D6QHo
   w24BuRO6i9M/Qln8n4rvSWnSKntcS0COBnJutWqkRjH5Loid4JgpjBz2b
   6+1xcqRfeY62nQ+/s74d1lQhO78EuRB/S53Nc/dsWxLScDPJL7G8dnLBy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="290560211"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="290560211"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 01:19:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="934168284"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 14 Aug 2022 01:19:47 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN8qY-0002eV-2N;
        Sun, 14 Aug 2022 08:19:46 +0000
Date:   Sun, 14 Aug 2022 16:19:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-rockchip/pm.c:277:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202208141642.ISeeSDiu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea23e7c464bfdec04b52cf61edb62030e9e0d0a
commit: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time
date:   6 months ago
config: arm-randconfig-s031-20220801 (https://download.01.org/0day-ci/archive/20220814/202208141642.ISeeSDiu-lkp@intel.com/config)
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
>> arch/arm/mach-rockchip/pm.c:277:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] rk3288_bootram_base @@
   arch/arm/mach-rockchip/pm.c:277:9: sparse:     expected void const *
   arch/arm/mach-rockchip/pm.c:277:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] rk3288_bootram_base
>> arch/arm/mach-rockchip/pm.c:277:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] rk3288_bootram_base @@
   arch/arm/mach-rockchip/pm.c:277:9: sparse:     expected void const *
   arch/arm/mach-rockchip/pm.c:277:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] rk3288_bootram_base
   arch/arm/mach-rockchip/pm.c:277:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *static [assigned] [toplevel] rk3288_bootram_base @@
   arch/arm/mach-rockchip/pm.c:277:9: sparse:     expected void *
   arch/arm/mach-rockchip/pm.c:277:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] rk3288_bootram_base
--
   arch/arm/mach-tegra/reset.c:64:9: sparse: sparse: subtraction of functions? Share your drugs
   arch/arm/mach-tegra/reset.c:66:9: sparse: sparse: subtraction of functions? Share your drugs
>> arch/arm/mach-tegra/reset.c:66:9: sparse: sparse: cast from unknown type

vim +277 arch/arm/mach-rockchip/pm.c

9c1ec8e18c210092 Chris Zhong      2014-12-01  223  
2dd00d31d488707d Douglas Anderson 2019-04-11  224  static int __init rk3288_suspend_init(struct device_node *np)
9c1ec8e18c210092 Chris Zhong      2014-12-01  225  {
9c1ec8e18c210092 Chris Zhong      2014-12-01  226  	struct device_node *sram_np;
9c1ec8e18c210092 Chris Zhong      2014-12-01  227  	struct resource res;
9c1ec8e18c210092 Chris Zhong      2014-12-01  228  	int ret;
9c1ec8e18c210092 Chris Zhong      2014-12-01  229  
9c1ec8e18c210092 Chris Zhong      2014-12-01  230  	pmu_regmap = syscon_node_to_regmap(np);
9c1ec8e18c210092 Chris Zhong      2014-12-01  231  	if (IS_ERR(pmu_regmap)) {
9c1ec8e18c210092 Chris Zhong      2014-12-01  232  		pr_err("%s: could not find pmu regmap\n", __func__);
9c1ec8e18c210092 Chris Zhong      2014-12-01  233  		return PTR_ERR(pmu_regmap);
9c1ec8e18c210092 Chris Zhong      2014-12-01  234  	}
9c1ec8e18c210092 Chris Zhong      2014-12-01  235  
9c1ec8e18c210092 Chris Zhong      2014-12-01  236  	sgrf_regmap = syscon_regmap_lookup_by_compatible(
9c1ec8e18c210092 Chris Zhong      2014-12-01  237  				"rockchip,rk3288-sgrf");
9c1ec8e18c210092 Chris Zhong      2014-12-01  238  	if (IS_ERR(sgrf_regmap)) {
9c1ec8e18c210092 Chris Zhong      2014-12-01  239  		pr_err("%s: could not find sgrf regmap\n", __func__);
2a03c025fdea25a4 Fabio Estevam    2015-08-13  240  		return PTR_ERR(sgrf_regmap);
9c1ec8e18c210092 Chris Zhong      2014-12-01  241  	}
9c1ec8e18c210092 Chris Zhong      2014-12-01  242  
134f1f609bdf2f67 Chris Zhong      2015-06-23  243  	grf_regmap = syscon_regmap_lookup_by_compatible(
134f1f609bdf2f67 Chris Zhong      2015-06-23  244  				"rockchip,rk3288-grf");
134f1f609bdf2f67 Chris Zhong      2015-06-23  245  	if (IS_ERR(grf_regmap)) {
134f1f609bdf2f67 Chris Zhong      2015-06-23  246  		pr_err("%s: could not find grf regmap\n", __func__);
2a03c025fdea25a4 Fabio Estevam    2015-08-13  247  		return PTR_ERR(grf_regmap);
134f1f609bdf2f67 Chris Zhong      2015-06-23  248  	}
134f1f609bdf2f67 Chris Zhong      2015-06-23  249  
9c1ec8e18c210092 Chris Zhong      2014-12-01  250  	sram_np = of_find_compatible_node(NULL, NULL,
9c1ec8e18c210092 Chris Zhong      2014-12-01  251  					  "rockchip,rk3288-pmu-sram");
9c1ec8e18c210092 Chris Zhong      2014-12-01  252  	if (!sram_np) {
9c1ec8e18c210092 Chris Zhong      2014-12-01  253  		pr_err("%s: could not find bootram dt node\n", __func__);
9c1ec8e18c210092 Chris Zhong      2014-12-01  254  		return -ENODEV;
9c1ec8e18c210092 Chris Zhong      2014-12-01  255  	}
9c1ec8e18c210092 Chris Zhong      2014-12-01  256  
9c1ec8e18c210092 Chris Zhong      2014-12-01  257  	rk3288_bootram_base = of_iomap(sram_np, 0);
9c1ec8e18c210092 Chris Zhong      2014-12-01  258  	if (!rk3288_bootram_base) {
9c1ec8e18c210092 Chris Zhong      2014-12-01  259  		pr_err("%s: could not map bootram base\n", __func__);
c2af88f1a0cdf4cb Wen Yang         2019-04-26  260  		of_node_put(sram_np);
9c1ec8e18c210092 Chris Zhong      2014-12-01  261  		return -ENOMEM;
9c1ec8e18c210092 Chris Zhong      2014-12-01  262  	}
9c1ec8e18c210092 Chris Zhong      2014-12-01  263  
9c1ec8e18c210092 Chris Zhong      2014-12-01  264  	ret = of_address_to_resource(sram_np, 0, &res);
9c1ec8e18c210092 Chris Zhong      2014-12-01  265  	if (ret) {
9c1ec8e18c210092 Chris Zhong      2014-12-01  266  		pr_err("%s: could not get bootram phy addr\n", __func__);
c2af88f1a0cdf4cb Wen Yang         2019-04-26  267  		of_node_put(sram_np);
9c1ec8e18c210092 Chris Zhong      2014-12-01  268  		return ret;
9c1ec8e18c210092 Chris Zhong      2014-12-01  269  	}
9c1ec8e18c210092 Chris Zhong      2014-12-01  270  	rk3288_bootram_phy = res.start;
9c1ec8e18c210092 Chris Zhong      2014-12-01  271  
9c1ec8e18c210092 Chris Zhong      2014-12-01  272  	of_node_put(sram_np);
9c1ec8e18c210092 Chris Zhong      2014-12-01  273  
9c1ec8e18c210092 Chris Zhong      2014-12-01  274  	rk3288_config_bootdata();
9c1ec8e18c210092 Chris Zhong      2014-12-01  275  
9c1ec8e18c210092 Chris Zhong      2014-12-01  276  	/* copy resume code and data to bootsram */
9c1ec8e18c210092 Chris Zhong      2014-12-01 @277  	memcpy(rk3288_bootram_base, rockchip_slp_cpu_resume,
9c1ec8e18c210092 Chris Zhong      2014-12-01  278  	       rk3288_bootram_sz);
9c1ec8e18c210092 Chris Zhong      2014-12-01  279  
9c1ec8e18c210092 Chris Zhong      2014-12-01  280  	return 0;
9c1ec8e18c210092 Chris Zhong      2014-12-01  281  }
9c1ec8e18c210092 Chris Zhong      2014-12-01  282  

:::::: The code at line 277 was first introduced by commit
:::::: 9c1ec8e18c210092418d27278a742a2a98eafffe ARM: rockchip: add suspend and resume for RK3288

:::::: TO: Chris Zhong <zyw@rock-chips.com>
:::::: CC: Heiko Stuebner <heiko@sntech.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

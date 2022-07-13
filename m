Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48875572D03
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbiGMFYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiGMFX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:23:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8479627FD5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657689834; x=1689225834;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VpdSJ7ozkgeJLIExrryNcdccxjNCFGolX3kl1PpCQPU=;
  b=izPs4FHIs+zJudc9Fbp6fpnKHldYBHn6pBBdSbBe7TK2ntviJM1pHdcM
   n18Jw2fe6e+eONHat7Ck3/5JtfhCLAOALGC+wiQjIg9nxeHIFr0VCUjXV
   oIKPBi2d8WrRwv6yGRuzp5lpPyg6h5WsSLjUIHErrLXMIOPirtoX5F+Zp
   lWTH3BNIdbJ5tUWBxUWeULO6dghCq/emLvVpJHqfgYEI2ZJteTB27Rdln
   kbvjlC+Y7lJym2egVgAV1HGSouuuLeQvhGZZ0uOxALEJo+LH5aX1RXGIH
   Bwi67g3OrXusl0hcTldTjtGuBKIIxT82ULvSKMNpBrrLwfQpBUNCvZy2e
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="371425847"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="371425847"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 22:23:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="628163357"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 12 Jul 2022 22:23:48 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBUqi-0003Ab-49;
        Wed, 13 Jul 2022 05:23:48 +0000
Date:   Wed, 13 Jul 2022 13:23:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: arch/arm/mach-spear/spear6xx.c:365:13: warning: no previous
 prototype for function 'spear6xx_map_io'
Message-ID: <202207131331.Me2o8nNL-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b047602d579b4fb028128a525f056bbdc890e7f0
commit: 7036440eab3e2d47a775d4616909f8235488d714 ARM: omap1: enable multiplatform
date:   6 weeks ago
config: arm-randconfig-r032-20220713 (https://download.01.org/0day-ci/archive/20220713/202207131331.Me2o8nNL-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e60b4fb2b777118c0ff664a6347851df14fcf75b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7036440eab3e2d47a775d4616909f8235488d714
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7036440eab3e2d47a775d4616909f8235488d714
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-spear/ drivers/clk/spear/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mach-spear/spear6xx.c:365:13: warning: no previous prototype for function 'spear6xx_map_io' [-Wmissing-prototypes]
   void __init spear6xx_map_io(void)
               ^
   arch/arm/mach-spear/spear6xx.c:365:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init spear6xx_map_io(void)
   ^
   static 
>> arch/arm/mach-spear/spear6xx.c:370:13: warning: no previous prototype for function 'spear6xx_timer_init' [-Wmissing-prototypes]
   void __init spear6xx_timer_init(void)
               ^
   arch/arm/mach-spear/spear6xx.c:370:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init spear6xx_timer_init(void)
   ^
   static 
   2 warnings generated.
--
>> drivers/clk/spear/spear6xx_clock.c:116:13: warning: no previous prototype for function 'spear6xx_clk_init' [-Wmissing-prototypes]
   void __init spear6xx_clk_init(void __iomem *misc_base)
               ^
   drivers/clk/spear/spear6xx_clock.c:116:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init spear6xx_clk_init(void __iomem *misc_base)
   ^
   static 
   1 warning generated.


vim +/spear6xx_map_io +365 arch/arm/mach-spear/spear6xx.c

8f590d4541fb67 arch/arm/mach-spear6xx/spear6xx.c Viresh Kumar      2010-04-01  363  
8f590d4541fb67 arch/arm/mach-spear6xx/spear6xx.c Viresh Kumar      2010-04-01  364  /* This will create static memory mapping for selected devices */
8f590d4541fb67 arch/arm/mach-spear6xx/spear6xx.c Viresh Kumar      2010-04-01 @365  void __init spear6xx_map_io(void)
8f590d4541fb67 arch/arm/mach-spear6xx/spear6xx.c Viresh Kumar      2010-04-01  366  {
8f590d4541fb67 arch/arm/mach-spear6xx/spear6xx.c Viresh Kumar      2010-04-01  367  	iotable_init(spear6xx_io_desc, ARRAY_SIZE(spear6xx_io_desc));
8f590d4541fb67 arch/arm/mach-spear6xx/spear6xx.c Viresh Kumar      2010-04-01  368  }
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  369  
6bb27d7349db51 arch/arm/mach-spear6xx/spear6xx.c Stephen Warren    2012-11-08 @370  void __init spear6xx_timer_init(void)
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  371  {
a8f4bf0eb4ca7a arch/arm/mach-spear6xx/spear6xx.c Vipul Kumar Samar 2012-07-10  372  	char pclk_name[] = "pll3_clk";
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  373  	struct clk *gpt_clk, *pclk;
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  374  
d9909ebe650f02 arch/arm/mach-spear/spear6xx.c    Arnd Bergmann     2012-12-02  375  	spear6xx_clk_init(MISC_BASE);
5df33a62c4a028 arch/arm/mach-spear6xx/spear6xx.c Viresh Kumar      2012-04-10  376  
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  377  	/* get the system timer clock */
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  378  	gpt_clk = clk_get_sys("gpt0", NULL);
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  379  	if (IS_ERR(gpt_clk)) {
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  380  		pr_err("%s:couldn't get clk for gpt\n", __func__);
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  381  		BUG();
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  382  	}
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  383  
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  384  	/* get the suitable parent clock for timer*/
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  385  	pclk = clk_get(NULL, pclk_name);
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  386  	if (IS_ERR(pclk)) {
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  387  		pr_err("%s:couldn't get %s as parent for gpt\n",
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  388  				__func__, pclk_name);
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  389  		BUG();
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  390  	}
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  391  
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  392  	clk_set_parent(gpt_clk, pclk);
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  393  	clk_put(gpt_clk);
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  394  	clk_put(pclk);
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  395  
30551c0108e0d2 arch/arm/mach-spear6xx/spear6xx.c Viresh Kumar      2012-04-21  396  	spear_setup_of_timer();
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  397  }
5c881d9ae94801 arch/arm/mach-spear6xx/spear6xx.c Shiraz Hashim     2011-02-16  398  

:::::: The code at line 365 was first introduced by commit
:::::: 8f590d4541fb678a638777ab987709217cb71365 ARM: 6015/1: ST SPEAr: Added source files for SPEAr6xx machine family

:::::: TO: viresh kumar <viresh.kumar@st.com>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

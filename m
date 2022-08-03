Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95560588AD3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbiHCKyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbiHCKyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:54:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B052250E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 03:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659524044; x=1691060044;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wlGNCVpkBSCnKiDrut29sdbbBmedJczMaQ1oKcgPFM0=;
  b=KCzS1i04NUL5VCor2+DPn/VxTQmVNK5tplJTRpn7n5Xs56JVeqiRKyAX
   i8+Y6cIGhwi1ZBTHU1qCNj27Lq0lTtZjGe9OZeF4hIdJurr9XKjntX1Oo
   XSR90w1k/UOlBap9/gl6vzogrRQT5uXH3h7gg+uNEltO4NCzhzv4W80g7
   /nqkEbieoT1+ORTgjPDvIVVd547f3+qzfrESFz4UqvFFJ0c+BLs+2UqRi
   CoZPgHz0eTKiE+wU4q/+y6HASY7HXa3UXvRZOV3rMRo4/VvlToSEwbSuM
   OZhSg/hl7VvUIWN/P/lYDZqqzgCMry4PrAMKJhOVTYcvoiNPHdKAho1K8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="276556074"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="276556074"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 03:54:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="635641790"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Aug 2022 03:54:02 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJC0n-000HAV-1v;
        Wed, 03 Aug 2022 10:54:01 +0000
Date:   Wed, 3 Aug 2022 18:53:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: arch/arm/mach-spear/spear6xx.c:365:13: warning: no previous
 prototype for function 'spear6xx_map_io'
Message-ID: <202208031821.79T1lZAO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e2b542100719a93f8cdf6d90185410d38a57a4c1
commit: a3102fafdce6f150e5a46e1725bb1732f8953a01 ARM: iop32x: enable multiplatform support
date:   4 months ago
config: arm-randconfig-r014-20220803 (https://download.01.org/0day-ci/archive/20220803/202208031821.79T1lZAO-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a3102fafdce6f150e5a46e1725bb1732f8953a01
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a3102fafdce6f150e5a46e1725bb1732f8953a01
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

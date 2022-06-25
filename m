Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7947E55AA99
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 15:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiFYNpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 09:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiFYNpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 09:45:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587602BF
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 06:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656164711; x=1687700711;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iEqJKAAtzjtT4BX9303ZZYCiuDWW8v2XVYI0lREZy8c=;
  b=AlmtVQLeolQao6lIxcPDUaLJE0ZcVsdcTbfiIzF2KS5LEhLL36cRXPhv
   lbPvPiv1iaF8ChK/KPE3dNX0nI3w/kSl03jk2t2s7tsZFPKTDyAeP1U61
   chq59Oi1gFVb0oTM4NkoyPYG4pdX+xPzwKmX04nIdpIU3NsPKVVw1uXn1
   x/ngao2QDyHgKm7ULCMZLsY75NSwvYytXBQPUHIit+AR4m69pTtJbDXE0
   lYQlShUkDv4ZrIIMK8UJPHd70VYmZ/8/R3a1LjsdeEX5PAn9lEmdxiYlF
   k7cf5uLqpSb6GVk7O5aSG9RjaOOc7juwh+QLRl0hHsjnIBcKuo6oFJAvz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="264233408"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="264233408"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 06:45:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="539586351"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Jun 2022 06:45:09 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5660-0005nl-Od;
        Sat, 25 Jun 2022 13:45:08 +0000
Date:   Sat, 25 Jun 2022 21:44:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: arch/arm/mach-pxa/eseries.c:46:13: warning: no previous prototype
 for function 'eseries_fixup'
Message-ID: <202206252134.dWKA4YaD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8c23f235a6a8ae43abea215812eb9d8cf4dd165e
commit: 8c1fb11b8a77dc489a8ef6d96c38c1297b629d06 ARM: s3c: enable s3c24xx multiplatform support
date:   3 months ago
config: arm-buildonly-randconfig-r006-20220625
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 42a7ddb428c999229491b0effbb1a4059149fba8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8c1fb11b8a77dc489a8ef6d96c38c1297b629d06
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8c1fb11b8a77dc489a8ef6d96c38c1297b629d06
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mach-pxa/eseries.c:46:13: warning: no previous prototype for function 'eseries_fixup' [-Wmissing-prototypes]
   void __init eseries_fixup(struct tag *tags, char **cmdline)
               ^
   arch/arm/mach-pxa/eseries.c:46:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init eseries_fixup(struct tag *tags, char **cmdline)
   ^
   static 
>> arch/arm/mach-pxa/eseries.c:75:5: warning: no previous prototype for function 'eseries_tmio_enable' [-Wmissing-prototypes]
   int eseries_tmio_enable(struct platform_device *dev)
       ^
   arch/arm/mach-pxa/eseries.c:75:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int eseries_tmio_enable(struct platform_device *dev)
   ^
   static 
>> arch/arm/mach-pxa/eseries.c:88:5: warning: no previous prototype for function 'eseries_tmio_disable' [-Wmissing-prototypes]
   int eseries_tmio_disable(struct platform_device *dev)
       ^
   arch/arm/mach-pxa/eseries.c:88:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int eseries_tmio_disable(struct platform_device *dev)
   ^
   static 
>> arch/arm/mach-pxa/eseries.c:95:5: warning: no previous prototype for function 'eseries_tmio_suspend' [-Wmissing-prototypes]
   int eseries_tmio_suspend(struct platform_device *dev)
       ^
   arch/arm/mach-pxa/eseries.c:95:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int eseries_tmio_suspend(struct platform_device *dev)
   ^
   static 
>> arch/arm/mach-pxa/eseries.c:101:5: warning: no previous prototype for function 'eseries_tmio_resume' [-Wmissing-prototypes]
   int eseries_tmio_resume(struct platform_device *dev)
       ^
   arch/arm/mach-pxa/eseries.c:101:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int eseries_tmio_resume(struct platform_device *dev)
   ^
   static 
>> arch/arm/mach-pxa/eseries.c:108:6: warning: no previous prototype for function 'eseries_get_tmio_gpios' [-Wmissing-prototypes]
   void eseries_get_tmio_gpios(void)
        ^
   arch/arm/mach-pxa/eseries.c:108:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void eseries_get_tmio_gpios(void)
   ^
   static 
   6 warnings generated.
--
>> arch/arm/mach-pxa/colibri-pxa270-income.c:224:13: warning: no previous prototype for function 'colibri_pxa270_income_boardinit' [-Wmissing-prototypes]
   void __init colibri_pxa270_income_boardinit(void)
               ^
   arch/arm/mach-pxa/colibri-pxa270-income.c:224:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init colibri_pxa270_income_boardinit(void)
   ^
   static 
   1 warning generated.


vim +/eseries_fixup +46 arch/arm/mach-pxa/eseries.c

3abcd199db312a Ian Molton       2007-11-19   44  
3abcd199db312a Ian Molton       2007-11-19   45  /* Only e800 has 128MB RAM */
1c2f87c22566cd Laura Abbott     2014-04-13  @46  void __init eseries_fixup(struct tag *tags, char **cmdline)
3abcd199db312a Ian Molton       2007-11-19   47  {
3abcd199db312a Ian Molton       2007-11-19   48  	if (machine_is_e800())
1c2f87c22566cd Laura Abbott     2014-04-13   49  		memblock_add(0xa0000000, SZ_128M);
3abcd199db312a Ian Molton       2007-11-19   50  	else
1c2f87c22566cd Laura Abbott     2014-04-13   51  		memblock_add(0xa0000000, SZ_64M);
3abcd199db312a Ian Molton       2007-11-19   52  }
3abcd199db312a Ian Molton       2007-11-19   53  
fdabc466f335bc Linus Walleij    2020-01-23   54  static struct gpiod_lookup_table e7xx_gpio_vbus_gpiod_table __maybe_unused = {
fdabc466f335bc Linus Walleij    2020-01-23   55  	.dev_id = "gpio-vbus",
fdabc466f335bc Linus Walleij    2020-01-23   56  	.table = {
fdabc466f335bc Linus Walleij    2020-01-23   57  		GPIO_LOOKUP("gpio-pxa", GPIO_E7XX_USB_DISC,
fdabc466f335bc Linus Walleij    2020-01-23   58  			    "vbus", GPIO_ACTIVE_HIGH),
fdabc466f335bc Linus Walleij    2020-01-23   59  		GPIO_LOOKUP("gpio-pxa", GPIO_E7XX_USB_PULLUP,
fdabc466f335bc Linus Walleij    2020-01-23   60  			    "pullup", GPIO_ACTIVE_LOW),
fdabc466f335bc Linus Walleij    2020-01-23   61  		{ },
fdabc466f335bc Linus Walleij    2020-01-23   62  	},
ebcce7b13be837 Ian Molton       2008-08-19   63  };
ebcce7b13be837 Ian Molton       2008-08-19   64  
0a137a1a38c64d Arnd Bergmann    2016-01-29   65  static struct platform_device e7xx_gpio_vbus __maybe_unused = {
133dce0687b4c3 Dmitry Baryshkov 2011-02-14   66  	.name	= "gpio-vbus",
133dce0687b4c3 Dmitry Baryshkov 2011-02-14   67  	.id	= -1,
133dce0687b4c3 Dmitry Baryshkov 2011-02-14   68  };
133dce0687b4c3 Dmitry Baryshkov 2011-02-14   69  
36033422639913 Ian Molton       2008-08-24   70  struct pxaficp_platform_data e7xx_ficp_platform_data = {
c4bd01727380ce Marek Vasut      2009-07-17   71  	.gpio_pwdown		= GPIO_E7XX_IR_OFF,
36033422639913 Ian Molton       2008-08-24   72  	.transceiver_cap	= IR_SIRMODE | IR_OFF,
36033422639913 Ian Molton       2008-08-24   73  };
36033422639913 Ian Molton       2008-08-24   74  
b1ae1b7b274f67 Ian Molton       2008-09-26  @75  int eseries_tmio_enable(struct platform_device *dev)
b1ae1b7b274f67 Ian Molton       2008-09-26   76  {
b1ae1b7b274f67 Ian Molton       2008-09-26   77  	/* Reset - bring SUSPEND high before PCLR */
b1ae1b7b274f67 Ian Molton       2008-09-26   78  	gpio_set_value(GPIO_ESERIES_TMIO_SUSPEND, 0);
b1ae1b7b274f67 Ian Molton       2008-09-26   79  	gpio_set_value(GPIO_ESERIES_TMIO_PCLR, 0);
b1ae1b7b274f67 Ian Molton       2008-09-26   80  	msleep(1);
b1ae1b7b274f67 Ian Molton       2008-09-26   81  	gpio_set_value(GPIO_ESERIES_TMIO_SUSPEND, 1);
b1ae1b7b274f67 Ian Molton       2008-09-26   82  	msleep(1);
b1ae1b7b274f67 Ian Molton       2008-09-26   83  	gpio_set_value(GPIO_ESERIES_TMIO_PCLR, 1);
b1ae1b7b274f67 Ian Molton       2008-09-26   84  	msleep(1);
b1ae1b7b274f67 Ian Molton       2008-09-26   85  	return 0;
b1ae1b7b274f67 Ian Molton       2008-09-26   86  }
b1ae1b7b274f67 Ian Molton       2008-09-26   87  
b1ae1b7b274f67 Ian Molton       2008-09-26  @88  int eseries_tmio_disable(struct platform_device *dev)
b1ae1b7b274f67 Ian Molton       2008-09-26   89  {
b1ae1b7b274f67 Ian Molton       2008-09-26   90  	gpio_set_value(GPIO_ESERIES_TMIO_SUSPEND, 0);
b1ae1b7b274f67 Ian Molton       2008-09-26   91  	gpio_set_value(GPIO_ESERIES_TMIO_PCLR, 0);
b1ae1b7b274f67 Ian Molton       2008-09-26   92  	return 0;
b1ae1b7b274f67 Ian Molton       2008-09-26   93  }
b1ae1b7b274f67 Ian Molton       2008-09-26   94  
b1ae1b7b274f67 Ian Molton       2008-09-26  @95  int eseries_tmio_suspend(struct platform_device *dev)
b1ae1b7b274f67 Ian Molton       2008-09-26   96  {
b1ae1b7b274f67 Ian Molton       2008-09-26   97  	gpio_set_value(GPIO_ESERIES_TMIO_SUSPEND, 0);
b1ae1b7b274f67 Ian Molton       2008-09-26   98  	return 0;
b1ae1b7b274f67 Ian Molton       2008-09-26   99  }
b1ae1b7b274f67 Ian Molton       2008-09-26  100  
b1ae1b7b274f67 Ian Molton       2008-09-26 @101  int eseries_tmio_resume(struct platform_device *dev)
b1ae1b7b274f67 Ian Molton       2008-09-26  102  {
b1ae1b7b274f67 Ian Molton       2008-09-26  103  	gpio_set_value(GPIO_ESERIES_TMIO_SUSPEND, 1);
b1ae1b7b274f67 Ian Molton       2008-09-26  104  	msleep(1);
b1ae1b7b274f67 Ian Molton       2008-09-26  105  	return 0;
b1ae1b7b274f67 Ian Molton       2008-09-26  106  }
b1ae1b7b274f67 Ian Molton       2008-09-26  107  
b1ae1b7b274f67 Ian Molton       2008-09-26 @108  void eseries_get_tmio_gpios(void)
b1ae1b7b274f67 Ian Molton       2008-09-26  109  {
b1ae1b7b274f67 Ian Molton       2008-09-26  110  	gpio_request(GPIO_ESERIES_TMIO_SUSPEND, NULL);
b1ae1b7b274f67 Ian Molton       2008-09-26  111  	gpio_request(GPIO_ESERIES_TMIO_PCLR, NULL);
b1ae1b7b274f67 Ian Molton       2008-09-26  112  	gpio_direction_output(GPIO_ESERIES_TMIO_SUSPEND, 0);
b1ae1b7b274f67 Ian Molton       2008-09-26  113  	gpio_direction_output(GPIO_ESERIES_TMIO_PCLR, 0);
b1ae1b7b274f67 Ian Molton       2008-09-26  114  }
b1ae1b7b274f67 Ian Molton       2008-09-26  115  

:::::: The code at line 46 was first introduced by commit
:::::: 1c2f87c22566cd057bc8cde10c37ae9da1a1bb76 ARM: 8025/1: Get rid of meminfo

:::::: TO: Laura Abbott <lauraa@codeaurora.org>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

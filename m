Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A4356453B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 07:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiGCFEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 01:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGCFEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 01:04:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A94AE5F
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 22:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656824674; x=1688360674;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Onz6aQcKpqu/vzMtxWDCyxO0FgSrBfVvmqOy25mAPd4=;
  b=HxgxNwDoaVxKUAnXrNvnbbFbjV7Uj4mlzkO22EcnRdQ6pxYHAaOhl4+0
   sJm3Oa4MWH7xXHPp7EAh8l3thnYP+xjGrCc4Z8a03aUu1KlV5hBZOWn8G
   P9S76upBy6x/BiV8VaufVy/GL2SAMpNcIcmPuUrGrx7SZeM2xPvtJYW4S
   BFFX/wVnuAvv8z3cq47Kb3sl3ZUCHT8UJ+8YhvXZ3ZXvMZD4oeKw5mokG
   /dULb+vlkIzemELUcpO89p3A7Ne3U35rgf7OzU3C9m8QeNn3wKQB5BfF+
   iDu2IHEv1PG2F0mkrz3L55f8O5ItuabgCMBHVzXpZGvOYhw+qyi2MKR6a
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="283633301"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="283633301"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 22:04:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="618855343"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 Jul 2022 22:04:33 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7rma-000G7j-BU;
        Sun, 03 Jul 2022 05:04:32 +0000
Date:   Sun, 3 Jul 2022 13:04:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: arch/arm/mach-omap2/board-n8x0.c:508:13: warning: no previous
 prototype for function 'n8x0_mmc_init'
Message-ID: <202207031300.XYJ1Ogaa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   69cb6c6556ad89620547318439d6be8bb1629a5a
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   3 months ago
config: arm-randconfig-r022-20220703 (https://download.01.org/0day-ci/archive/20220703/202207031300.XYJ1Ogaa-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bcd153485ebf07fe79e2b843ed5f1cb74997df1b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mach-omap2/board-n8x0.c:508:13: warning: no previous prototype for function 'n8x0_mmc_init' [-Wmissing-prototypes]
   void __init n8x0_mmc_init(void)
               ^
   arch/arm/mach-omap2/board-n8x0.c:508:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init n8x0_mmc_init(void)
   ^
   static 
   1 warning generated.


vim +/n8x0_mmc_init +508 arch/arm/mach-omap2/board-n8x0.c

9418c65f9bd861 Tony Lindgren 2010-02-26  471  
bc593f5d787d0a Igor Grinberg 2011-05-03  472  static void __init n8x0_mmc_init(void)
9418c65f9bd861 Tony Lindgren 2010-02-26  473  {
9418c65f9bd861 Tony Lindgren 2010-02-26  474  	int err;
9418c65f9bd861 Tony Lindgren 2010-02-26  475  
c8f27e977310b3 Tony Lindgren 2013-11-25  476  	if (board_is_n810()) {
9418c65f9bd861 Tony Lindgren 2010-02-26  477  		mmc1_data.slots[0].name = "external";
9418c65f9bd861 Tony Lindgren 2010-02-26  478  
9418c65f9bd861 Tony Lindgren 2010-02-26  479  		/*
9418c65f9bd861 Tony Lindgren 2010-02-26  480  		 * Some Samsung Movinand chips do not like open-ended
9418c65f9bd861 Tony Lindgren 2010-02-26  481  		 * multi-block reads and fall to braind-dead state
9418c65f9bd861 Tony Lindgren 2010-02-26  482  		 * while doing so. Reducing the number of blocks in
9418c65f9bd861 Tony Lindgren 2010-02-26  483  		 * the transfer or delays in clock disable do not help
9418c65f9bd861 Tony Lindgren 2010-02-26  484  		 */
9418c65f9bd861 Tony Lindgren 2010-02-26  485  		mmc1_data.slots[1].name = "internal";
9418c65f9bd861 Tony Lindgren 2010-02-26  486  		mmc1_data.slots[1].ban_openended = 1;
9418c65f9bd861 Tony Lindgren 2010-02-26  487  	}
9418c65f9bd861 Tony Lindgren 2010-02-26  488  
bc593f5d787d0a Igor Grinberg 2011-05-03  489  	err = gpio_request_one(N8X0_SLOT_SWITCH_GPIO, GPIOF_OUT_INIT_LOW,
bc593f5d787d0a Igor Grinberg 2011-05-03  490  			       "MMC slot switch");
9418c65f9bd861 Tony Lindgren 2010-02-26  491  	if (err)
1dea5c6b5876ea Tony Lindgren 2010-04-21  492  		return;
9418c65f9bd861 Tony Lindgren 2010-02-26  493  
c8f27e977310b3 Tony Lindgren 2013-11-25  494  	if (board_is_n810()) {
bc593f5d787d0a Igor Grinberg 2011-05-03  495  		err = gpio_request_array(n810_emmc_gpios,
bc593f5d787d0a Igor Grinberg 2011-05-03  496  					 ARRAY_SIZE(n810_emmc_gpios));
9418c65f9bd861 Tony Lindgren 2010-02-26  497  		if (err) {
9418c65f9bd861 Tony Lindgren 2010-02-26  498  			gpio_free(N8X0_SLOT_SWITCH_GPIO);
1dea5c6b5876ea Tony Lindgren 2010-04-21  499  			return;
9418c65f9bd861 Tony Lindgren 2010-02-26  500  		}
9418c65f9bd861 Tony Lindgren 2010-02-26  501  	}
9418c65f9bd861 Tony Lindgren 2010-02-26  502  
fa590c92340136 Tony Lindgren 2013-11-25  503  	mmc1_data.nr_slots = 2;
9418c65f9bd861 Tony Lindgren 2010-02-26  504  	mmc_data[0] = &mmc1_data;
9418c65f9bd861 Tony Lindgren 2010-02-26  505  }
9418c65f9bd861 Tony Lindgren 2010-02-26  506  #else
fa590c92340136 Tony Lindgren 2013-11-25  507  static struct omap_mmc_platform_data mmc1_data;
9418c65f9bd861 Tony Lindgren 2010-02-26 @508  void __init n8x0_mmc_init(void)
9418c65f9bd861 Tony Lindgren 2010-02-26  509  {
9418c65f9bd861 Tony Lindgren 2010-02-26  510  }
9418c65f9bd861 Tony Lindgren 2010-02-26  511  #endif	/* CONFIG_MMC_OMAP */
9418c65f9bd861 Tony Lindgren 2010-02-26  512  

:::::: The code at line 508 was first introduced by commit
:::::: 9418c65f9bd861d0f7e39aab9cfb3aa6f2275d11 omap2: Initialize Menelaus and MMC for N8X0

:::::: TO: Tony Lindgren <tony@atomide.com>
:::::: CC: Tony Lindgren <tony@atomide.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

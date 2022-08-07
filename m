Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E500358BC18
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 19:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbiHGRot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 13:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHGRor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 13:44:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A2D641E
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 10:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659894286; x=1691430286;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Of1H8E/U61jRpqPKdtnfJXl+a7rqeT0VYcmCIGZ+rsY=;
  b=jX2fwWyO81/D8qt24za9SQ4zM45a7h3FQgUiKPzpBfgeST/lZ0aFjTfP
   Sbl5R2M8J8hM7ga6Q7NUe5LXgDMZAIKxlWWZ3A+bsJuTIwYMo3fj6s26r
   7lyp9J1J4YOxvORlNgRbrAr97jL1xtTaMphueLjLmX1Dj0TZNnjTeY/Om
   aljgHujBR5gc80DLhhc6RiRVvguTkIOVbcv6xunvO2waKMNSWBZnwu2U6
   tN7/lGVPgDj4k+jFEXjJREtpL8YwWJStOeLwldz4O3OlP2PxepvveRG7L
   KSqOXtn2vSo5lpOD4H2DyJ/Ex1tKi9bKYwOznAWhHLY/Zw5vkRsd1pSC6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="352178317"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="352178317"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 10:44:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="554653513"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Aug 2022 10:44:44 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKkKS-000LWX-0c;
        Sun, 07 Aug 2022 17:44:44 +0000
Date:   Mon, 8 Aug 2022 01:44:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [rmk-arm:sa1100 15/51] arch/arm/mach-pxa/mainstone.c:576:30: error:
 no member named 'gpio_power' in 'struct pxamci_platform_data'
Message-ID: <202208080158.4UtkKbCT-lkp@intel.com>
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

tree:   git://git.armlinux.org.uk/~rmk/linux-arm sa1100
head:   2e73962c8797ccdf52841ea3065779839ac60e0e
commit: fc2311141ceca0b658cdeb4e8f5eaad322aa54b5 [15/51] ARM: pxa/mainstone: convert mainstone IrDA to use gpiod APIs
config: arm-mainstone_defconfig (https://download.01.org/0day-ci/archive/20220808/202208080158.4UtkKbCT-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 495519e5f8232d144ed26e9c18dbcbac6a5f25eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm sa1100
        git checkout fc2311141ceca0b658cdeb4e8f5eaad322aa54b5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm/mach-pxa/mainstone.c:576:30: error: no member named 'gpio_power' in 'struct pxamci_platform_data'
           mainstone_mci_platform_data.gpio_power = mst_mscwr1->base + 11;
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
   1 error generated.


vim +576 arch/arm/mach-pxa/mainstone.c

   555	
   556	static void __init mainstone_init(void)
   557	{
   558		int SW7 = 0;  /* FIXME: get from SCR (Mst doc section 3.2.1.1) */
   559	
   560		pxa2xx_mfp_config(ARRAY_AND_SIZE(mainstone_pin_config));
   561	
   562		/* Register board control register(s) as GPIOs */
   563		gpio_reg_init(NULL, (void __iomem *)&MST_PCMCIA0, -1, 11,
   564			      "mst-pcmcia0", MST_PCMCIA_INPUTS, 0, NULL,
   565			      NULL, mst_pcmcia0_irqs);
   566		gpio_reg_init(NULL, (void __iomem *)&MST_PCMCIA1, -1, 11,
   567			      "mst-pcmcia1", MST_PCMCIA_INPUTS, 0, NULL,
   568			      NULL, mst_pcmcia1_irqs);
   569		gpiod_add_lookup_table(&mainstone_pcmcia_gpio_table);
   570		gpiod_add_lookup_table(&mainstone_wm97xx_gpio_table);
   571	
   572		mst_mscwr1 = gpio_reg_init(NULL, (void __iomem *)&MST_MSCWR1, -1, 16,
   573					   "mst-mscwr1", 0, 0, NULL, NULL, NULL);
   574		gpiod_add_lookup_table(&mainstone_ficp_gpio_table);
   575		/* MCI power on = MST_MSCWR1_MMC_ON */
 > 576		mainstone_mci_platform_data.gpio_power = mst_mscwr1->base + 11;
   577	
   578		pxa_set_ffuart_info(NULL);
   579		pxa_set_btuart_info(NULL);
   580		pxa_set_stuart_info(NULL);
   581	
   582		mst_flash_data[0].width = (__raw_readl(BOOT_DEF) & 1) ? 2 : 4;
   583		mst_flash_data[1].width = 4;
   584	
   585		/* Compensate for SW7 which swaps the flash banks */
   586		mst_flash_data[SW7].name = "processor-flash";
   587		mst_flash_data[SW7 ^ 1].name = "mainboard-flash";
   588	
   589		printk(KERN_NOTICE "Mainstone configured to boot from %s\n",
   590		       mst_flash_data[0].name);
   591	
   592		/* system bus arbiter setting
   593		 * - Core_Park
   594		 * - LCD_wt:DMA_wt:CORE_Wt = 2:3:4
   595		 */
   596		ARB_CNTRL = ARB_CORE_PARK | 0x234;
   597	
   598		platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
   599	
   600		/* reading Mainstone's "Virtual Configuration Register"
   601		   might be handy to select LCD type here */
   602		if (0)
   603			mainstone_pxafb_info.modes = &toshiba_ltm04c380k_mode;
   604		else
   605			mainstone_pxafb_info.modes = &toshiba_ltm035a776c_mode;
   606	
   607		pxa_set_fb_info(NULL, &mainstone_pxafb_info);
   608		mainstone_backlight_register();
   609	
   610		pxa_set_mci_info(&mainstone_mci_platform_data);
   611		pxa_set_ficp_info(&mainstone_ficp_platform_data);
   612		pxa_set_ohci_info(&mainstone_ohci_platform_data);
   613		pxa_set_i2c_info(NULL);
   614		pxa_set_ac97_info(&mst_audio_ops);
   615	
   616		mainstone_init_keypad();
   617	}
   618	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

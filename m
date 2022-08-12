Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044F859179F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 01:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiHLX0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 19:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHLX0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 19:26:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77CC95AC9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 16:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660346761; x=1691882761;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l/yhGx3WeYS9o9opm7MAKF4+svHia934rmoTbkLOp9I=;
  b=c5XqW7DaEGdGERVjySO9vLZdP2/GsmDov4P4o05qXRyejLGIMHG8syDX
   M7/b/3xaP74e+KktDdzFoKwYvedc1YB3qDZNmFaQqs5DBxYM2sBvjK5zb
   S3oi85/XIS7q9uMo90JLvztYVsAmCPa9dgKjNFj7khMUduFlbM6l5NNdD
   x9ocvrKkpojVp5z1nTbEF4SlrgXFraVZIeUqmrl/ojRM3SOPZsUZNC6zd
   Oxaeqg1zDgfUzzG1Ev9MEfqR5yt+cyTkMIY04ofMSyR2//lrc6hn9bVu6
   Y48WHOXWRh1ARr7RbHe8WFFrfGbVR1UfgmWskkZqBNYANFtqIRBvQpuob
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="289275777"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="289275777"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 16:26:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="609406137"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 12 Aug 2022 16:26:00 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMe2R-000143-1p;
        Fri, 12 Aug 2022 23:25:59 +0000
Date:   Sat, 13 Aug 2022 07:25:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: xillybus_of.c:undefined reference to `devm_platform_ioremap_resource'
Message-ID: <202208130714.vBT1t33p-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4a9350597aff50bbd0f4b80ccf49d2e02d1111f5
commit: a1315dcb7b6a7d3a78df848eed5b331a4b3ec28a hwrng: ks-sa - Add dependency on IOMEM and OF
date:   1 year, 8 months ago
config: s390-randconfig-r044-20220812 (https://download.01.org/0day-ci/archive/20220813/202208130714.vBT1t33p-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a1315dcb7b6a7d3a78df848eed5b331a4b3ec28a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a1315dcb7b6a7d3a78df848eed5b331a4b3ec28a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
   irq-al-fic.c:(.init.text+0x3a): undefined reference to `of_iomap'
   s390-linux-ld: irq-al-fic.c:(.init.text+0x3bc): undefined reference to `iounmap'
   s390-linux-ld: drivers/irqchip/irq-imx-intmux.o: in function `imx_intmux_probe':
   irq-imx-intmux.c:(.text+0x59c): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/phy/marvell/phy-mvebu-a3700-utmi.o: in function `mvebu_a3700_utmi_phy_probe':
   phy-mvebu-a3700-utmi.c:(.text+0x158): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/clk/clk-fixed-mmio.o: in function `fixed_mmio_clk_setup':
   clk-fixed-mmio.c:(.text+0x94): undefined reference to `of_iomap'
   s390-linux-ld: clk-fixed-mmio.c:(.text+0xc2): undefined reference to `iounmap'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_console_close':
   dpaa2-console.c:(.text+0x88): undefined reference to `iounmap'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_console_probe':
   dpaa2-console.c:(.text+0x22a): undefined reference to `of_address_to_resource'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_generic_console_open.constprop.0':
   dpaa2-console.c:(.text+0x33e): undefined reference to `ioremap'
   s390-linux-ld: dpaa2-console.c:(.text+0x39e): undefined reference to `iounmap'
   s390-linux-ld: dpaa2-console.c:(.text+0x3ba): undefined reference to `ioremap'
   s390-linux-ld: dpaa2-console.c:(.text+0x496): undefined reference to `iounmap'
   s390-linux-ld: drivers/char/hw_random/exynos-trng.o: in function `exynos_trng_probe':
   exynos-trng.c:(.text+0x40c): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/meson-rng.o: in function `meson_rng_probe':
   meson-rng.c:(.text+0x104): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/mtk-rng.o: in function `mtk_rng_probe':
   mtk-rng.c:(.text+0x4a6): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/npcm-rng.o: in function `npcm_rng_probe':
   npcm-rng.c:(.text+0x39c): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
>> xillybus_of.c:(.text+0x222): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/mfd/sun6i-prcm.o: in function `sun6i_prcm_probe':
   sun6i-prcm.c:(.text+0xba): undefined reference to `mfd_add_devices'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
   cistpl.c:(.text+0x3fe): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x480): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x4e8): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x518): undefined reference to `ioremap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
   cistpl.c:(.text+0x1c78): undefined reference to `iounmap'
   s390-linux-ld: drivers/media/rc/ir-hix5hd2.o: in function `hix5hd2_ir_probe':
   ir-hix5hd2.c:(.text+0x4e4): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/watchdog/sirfsoc_wdt.o: in function `sirfsoc_wdt_probe':
   sirfsoc_wdt.c:(.text+0x1b0): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_init':
   timer-of.c:(.init.text+0x112): undefined reference to `of_iomap'
   s390-linux-ld: timer-of.c:(.init.text+0x57e): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_cleanup':
   timer-of.c:(.init.text+0x686): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-microchip-pit64b.o: in function `mchp_pit64b_dt_init_timer':
   timer-microchip-pit64b.c:(.init.text+0x1d6): undefined reference to `of_iomap'
   s390-linux-ld: timer-microchip-pit64b.c:(.init.text+0x78c): undefined reference to `iounmap'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
   Depends on [n]: HAS_IOMEM [=n] && (ARCH_SUNXI || COMPILE_TEST [=y])
   Selected by [y]:
   - CLK_SUNXI_PRCM_SUN6I [=y] && COMMON_CLK [=y] && CLK_SUNXI [=y]
   - CLK_SUNXI_PRCM_SUN8I [=y] && COMMON_CLK [=y] && CLK_SUNXI [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

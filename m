Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10524EA627
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 05:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiC2Dkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 23:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiC2Dka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 23:40:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC20BC36
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 20:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648525127; x=1680061127;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WRQSg4qbwD4cPhoXsxHqJZSzOQfwrxLT7gElVrrW7W4=;
  b=cs6YBv8jN2qX4EDYnL6tMSwq8XnbFDKqZoZON9iIXxRWNHJDwWF8LGPP
   Yo0xE3Wvk0bEF739Bnvzct6KmLCxXq30we3IAnwgznxq6ncrxYS+iF0iA
   PJdNOqy02olmh44YnPtRWIrM+iEiw5s6RzQmNeyC3RPImOM+FJwHijxsP
   78cQ9BdFfo20WXPWCrKPO9VTvsaflK4Y8If0shVJJKySCMKAxyViuCcVj
   CwTGSZUwiHAr64kD1g5zjGQA4kWQwQ5+yd62VkZPHmq/GNyV4nHpXnHuH
   shmaYvc8uk2zxCoWav9XXMqIN+1BWqaLskBBp14P/pcobHAiDg+TzIB6c
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="257982225"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="257982225"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 20:38:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="585421978"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 28 Mar 2022 20:38:45 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZ2gu-0002bR-Dh; Tue, 29 Mar 2022 03:38:44 +0000
Date:   Tue, 29 Mar 2022 11:37:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: xillybus_of.c:undefined reference to `devm_platform_ioremap_resource'
Message-ID: <202203291145.R3ZUlhsW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
head:   cffb2b72d3ed47f5093d128bd44d9ce136b6b5af
commit: a1315dcb7b6a7d3a78df848eed5b331a4b3ec28a hwrng: ks-sa - Add dependency on IOMEM and OF
date:   1 year, 4 months ago
config: s390-randconfig-r044-20220327 (https://download.01.org/0day-ci/archive/20220329/202203291145.R3ZUlhsW-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a1315dcb7b6a7d3a78df848eed5b331a4b3ec28a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a1315dcb7b6a7d3a78df848eed5b331a4b3ec28a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
   coherent.c:(.text+0x220): undefined reference to `memremap'
   s390-linux-ld: coherent.c:(.text+0x2d2): undefined reference to `memunmap'
   s390-linux-ld: kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
   coherent.c:(.text+0x410): undefined reference to `memunmap'
   s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
   irq-al-fic.c:(.init.text+0x2e): undefined reference to `of_iomap'
   s390-linux-ld: irq-al-fic.c:(.init.text+0x1e2): undefined reference to `iounmap'
   s390-linux-ld: drivers/irqchip/irq-imx-intmux.o: in function `imx_intmux_probe':
   irq-imx-intmux.c:(.text+0x382): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/phy/marvell/phy-mvebu-a3700-utmi.o: in function `mvebu_a3700_utmi_phy_probe':
   phy-mvebu-a3700-utmi.c:(.text+0xbc): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/clk/clk-fixed-mmio.o: in function `fixed_mmio_clk_setup':
   clk-fixed-mmio.c:(.text+0x32): undefined reference to `of_iomap'
   s390-linux-ld: clk-fixed-mmio.c:(.text+0x50): undefined reference to `iounmap'
   s390-linux-ld: drivers/dma/fsl-edma.o: in function `fsl_edma_probe':
   fsl-edma.c:(.text+0xb24): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: fsl-edma.c:(.text+0xbb2): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/qcom/hidma.o: in function `hidma_probe':
   hidma.c:(.text+0x388): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: hidma.c:(.text+0x3bc): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/edma.o: in function `edma_xbar_event_map':
   edma.c:(.text+0x568): undefined reference to `of_address_to_resource'
   s390-linux-ld: edma.c:(.text+0x590): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/dma/ti/edma.o: in function `edma_probe':
   edma.c:(.text+0x2678): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/omap-dma.o: in function `omap_dma_probe':
   omap-dma.c:(.text+0x540): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/dma-crossbar.o: in function `ti_am335x_xbar_probe':
   dma-crossbar.c:(.text+0x270): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/dma-crossbar.o: in function `ti_dra7_xbar_probe':
   dma-crossbar.c:(.text+0x7a0): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_console_close':
   dpaa2-console.c:(.text+0x72): undefined reference to `iounmap'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_console_probe':
   dpaa2-console.c:(.text+0xbe): undefined reference to `of_address_to_resource'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_generic_console_open.constprop.0':
   dpaa2-console.c:(.text+0x172): undefined reference to `ioremap'
   s390-linux-ld: dpaa2-console.c:(.text+0x19c): undefined reference to `iounmap'
   s390-linux-ld: dpaa2-console.c:(.text+0x1b2): undefined reference to `ioremap'
   s390-linux-ld: dpaa2-console.c:(.text+0x286): undefined reference to `iounmap'
   s390-linux-ld: drivers/char/hw_random/exynos-trng.o: in function `exynos_trng_probe':
   exynos-trng.c:(.text+0x27e): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/meson-rng.o: in function `meson_rng_probe':
   meson-rng.c:(.text+0xa6): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/mtk-rng.o: in function `mtk_rng_probe':
   mtk-rng.c:(.text+0x22e): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/npcm-rng.o: in function `npcm_rng_probe':
   npcm-rng.c:(.text+0x1e8): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
>> xillybus_of.c:(.text+0x144): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/mfd/sun6i-prcm.o: in function `sun6i_prcm_probe':
   sun6i-prcm.c:(.text+0x7c): undefined reference to `mfd_add_devices'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `arc_rimi_exit':
   arc-rimi.c:(.exit.text+0x2e): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `arcrimi_found':
   arc-rimi.c:(.init.text+0xc4): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x142): undefined reference to `iounmap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x2b2): undefined reference to `iounmap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x338): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x3f8): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `check_mirror':
   arc-rimi.c:(.text.unlikely+0x54): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.text.unlikely+0x78): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/altera/altera_tse_main.o: in function `request_and_map':
   altera_tse_main.c:(.text+0x90a): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/net/ethernet/smsc/smc91c92_cs.o: in function `smc91c92_config':
   smc91c92_cs.c:(.text+0x1f7c): undefined reference to `ioremap'
   s390-linux-ld: smc91c92_cs.c:(.text+0x23c4): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/smsc/smc91c92_cs.o: in function `smc91c92_detach':
   smc91c92_cs.c:(.text+0x2868): undefined reference to `iounmap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
   cistpl.c:(.text+0x238): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x24a): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x2a2): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x2b2): undefined reference to `iounmap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
   cistpl.c:(.text+0xda2): undefined reference to `iounmap'
   s390-linux-ld: drivers/watchdog/sirfsoc_wdt.o: in function `sirfsoc_wdt_probe':
   sirfsoc_wdt.c:(.text+0xde): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_init':
   timer-of.c:(.init.text+0x96): undefined reference to `of_iomap'
   s390-linux-ld: timer-of.c:(.init.text+0x2ca): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_cleanup':
   timer-of.c:(.init.text+0x354): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-microchip-pit64b.o: in function `mchp_pit64b_dt_init_timer':
   timer-microchip-pit64b.c:(.init.text+0xda): undefined reference to `of_iomap'
   s390-linux-ld: timer-microchip-pit64b.c:(.init.text+0x456): undefined reference to `iounmap'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
   Depends on HAS_IOMEM && (ARCH_SUNXI || COMPILE_TEST
   Selected by
   - CLK_SUNXI_PRCM_SUN6I && COMMON_CLK && CLK_SUNXI
   - CLK_SUNXI_PRCM_SUN8I && COMMON_CLK && CLK_SUNXI

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

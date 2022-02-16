Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63E24B886B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiBPNGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:06:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiBPNGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:06:51 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDAEDFE4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645016799; x=1676552799;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9SLMoTI2bvG+PGnBZF0HO1ivEATZ349QBV0kujfenOk=;
  b=UIzaOSTmZYBpdm1bV4c5zSZmoLKGnUrv1zXWpmX00w7vetsTohU4WjcU
   u3BfhvyA5y3bFcuwFAFG5CZeR9TIG+TYrMcdYeWLMmP70+PErWIPGjvZ+
   H1irpDGPZvrIr6X9Mervd/kUQrAZGzDDgeZoQQAZ0SfPVoo/QdP4wQ6qD
   Nu3Z2S289zSNc4DAbqSG//DgabuM3W3bQTmxhAe9HTD/k76CDXPmsmdhP
   00345OoXPj5UjYl5TT0zbbcR1toVwi/hAryXB81Ab1jKeB93tBX0xXcIi
   w8YD9EXk3UMtLSl8SbkunrAnHLFaZGYPKaWayNjsbyytW9RiB0/0jLPmD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="337032581"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="337032581"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 05:06:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="625379728"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Feb 2022 05:06:37 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKK0y-000Aob-QT; Wed, 16 Feb 2022 13:06:36 +0000
Date:   Wed, 16 Feb 2022 21:06:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: xillybus_of.c:undefined reference to `devm_platform_ioremap_resource'
Message-ID: <202202162154.UCKoGB2J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
head:   c5d9ae265b105d9a67575fb67bd4650a6fc08e25
commit: a1315dcb7b6a7d3a78df848eed5b331a4b3ec28a hwrng: ks-sa - Add dependency on IOMEM and OF
date:   1 year, 2 months ago
config: s390-randconfig-r023-20220216 (https://download.01.org/0day-ci/archive/20220216/202202162154.UCKoGB2J-lkp@intel.com/config)
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

   s390-linux-ld: drivers/irqchip/irq-imx-intmux.o: in function `imx_intmux_probe':
   irq-imx-intmux.c:(.text+0xbaa): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/phy/marvell/phy-mvebu-a3700-utmi.o: in function `mvebu_a3700_utmi_phy_probe':
   phy-mvebu-a3700-utmi.c:(.text+0x29c): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/clk/clk-fixed-mmio.o: in function `fixed_mmio_clk_setup':
   clk-fixed-mmio.c:(.text+0x96): undefined reference to `of_iomap'
   s390-linux-ld: clk-fixed-mmio.c:(.text+0x118): undefined reference to `iounmap'
   s390-linux-ld: drivers/dma/fsl-edma.o: in function `fsl_edma_probe':
   fsl-edma.c:(.text+0xd48): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: fsl-edma.c:(.text+0x1458): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/idma64.o: in function `idma64_platform_probe':
   idma64.c:(.text+0x374c): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/qcom/hidma.o: in function `hidma_probe':
   hidma.c:(.text+0x289c): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: hidma.c:(.text+0x28e4): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/edma.o: in function `edma_xbar_event_map':
   edma.c:(.text+0x2440): undefined reference to `of_address_to_resource'
   s390-linux-ld: edma.c:(.text+0x246e): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/dma/ti/edma.o: in function `edma_probe':
   edma.c:(.text+0x9cda): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/omap-dma.o: in function `omap_dma_probe':
   omap-dma.c:(.text+0x57c6): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/dma-crossbar.o: in function `ti_am335x_xbar_probe':
   dma-crossbar.c:(.text+0x1264): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/dma-crossbar.o: in function `ti_dra7_xbar_probe':
   dma-crossbar.c:(.text+0x18ae): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_console_close':
   dpaa2-console.c:(.text+0xa8): undefined reference to `iounmap'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_console_probe':
   dpaa2-console.c:(.text+0x250): undefined reference to `of_address_to_resource'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_generic_console_open.constprop.0':
   dpaa2-console.c:(.text+0x386): undefined reference to `ioremap'
   s390-linux-ld: dpaa2-console.c:(.text+0x3d8): undefined reference to `iounmap'
   s390-linux-ld: dpaa2-console.c:(.text+0x412): undefined reference to `ioremap'
   s390-linux-ld: dpaa2-console.c:(.text+0x554): undefined reference to `iounmap'
   s390-linux-ld: drivers/char/hw_random/exynos-trng.o: in function `exynos_trng_probe':
   exynos-trng.c:(.text+0x38c): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/meson-rng.o: in function `meson_rng_probe':
   meson-rng.c:(.text+0x142): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/mtk-rng.o: in function `mtk_rng_probe':
   mtk-rng.c:(.text+0x4f8): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/npcm-rng.o: in function `npcm_rng_probe':
   npcm-rng.c:(.text+0x494): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
>> xillybus_of.c:(.text+0x2c0): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/mfd/sun6i-prcm.o: in function `sun6i_prcm_probe':
   sun6i-prcm.c:(.text+0x130): undefined reference to `mfd_add_devices'
   s390-linux-ld: drivers/net/ethernet/altera/altera_tse_main.o: in function `request_and_map':
   altera_tse_main.c:(.text+0x1bd8): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/ptp/ptp_qoriq.o: in function `ptp_qoriq_probe':
   ptp_qoriq.c:(.text+0x223c): undefined reference to `ioremap'
   s390-linux-ld: ptp_qoriq.c:(.text+0x22c4): undefined reference to `iounmap'
   s390-linux-ld: drivers/ptp/ptp_qoriq.o: in function `ptp_qoriq_free':
   ptp_qoriq.c:(.text+0x2436): undefined reference to `iounmap'
   s390-linux-ld: drivers/watchdog/sirfsoc_wdt.o: in function `sirfsoc_wdt_probe':
   sirfsoc_wdt.c:(.text+0x4f4): undefined reference to `devm_platform_ioremap_resource'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
   Depends on HAS_IOMEM && (ARCH_SUNXI || COMPILE_TEST
   Selected by
   - CLK_SUNXI_PRCM_SUN6I && COMMON_CLK && CLK_SUNXI
   - CLK_SUNXI_PRCM_SUN8I && COMMON_CLK && CLK_SUNXI

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

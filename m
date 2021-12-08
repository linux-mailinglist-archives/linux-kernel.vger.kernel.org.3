Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A283746CC4C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 05:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbhLHEVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 23:21:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:36349 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239874AbhLHEU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:20:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="301134913"
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="301134913"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 20:17:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="515607398"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 07 Dec 2021 20:17:24 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muoOS-000NOS-1v; Wed, 08 Dec 2021 04:17:24 +0000
Date:   Wed, 8 Dec 2021 12:16:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: samsung-keypad.c:undefined reference to `devm_ioremap'
Message-ID: <202112081217.krALIoXt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2a987e65025e2b79c6d453b78cb5985ac6e5eb26
commit: bbd7ffdbef6888459f301c5889f3b14ada38b913 clk: Allow the common clk framework to be selectable
date:   1 year, 7 months ago
config: s390-buildonly-randconfig-r001-20211208 (https://download.01.org/0day-ci/archive/20211208/202112081217.krALIoXt-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bbd7ffdbef6888459f301c5889f3b14ada38b913
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bbd7ffdbef6888459f301c5889f3b14ada38b913
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/irqchip/irq-imx-intmux.o: in function `imx_intmux_probe':
   irq-imx-intmux.c:(.text+0x6c): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/dma/qcom/hidma.o: in function `hidma_probe':
   hidma.c:(.text+0x102a): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: hidma.c:(.text+0x106a): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/edma.o: in function `edma_probe':
   edma.c:(.text+0x29d6): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/omap-dma.o: in function `omap_dma_probe':
   omap-dma.c:(.text+0x6a): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/exynos-trng.o: in function `exynos_trng_probe':
   exynos-trng.c:(.text+0x148): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/meson-rng.o: in function `meson_rng_probe':
   meson-rng.c:(.text+0x72): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/mtk-rng.o: in function `mtk_rng_probe':
   mtk-rng.c:(.text+0x2bc): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/ks-sa-rng.o: in function `ks_sa_rng_probe':
   ks-sa-rng.c:(.text+0x334): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/npcm-rng.o: in function `npcm_rng_probe':
   npcm-rng.c:(.text+0x1f4): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/input/keyboard/samsung-keypad.o: in function `samsung_keypad_probe':
>> samsung-keypad.c:(.text+0x4e2): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/watchdog/sirfsoc_wdt.o: in function `sirfsoc_wdt_probe':
   sirfsoc_wdt.c:(.text+0x1fc): undefined reference to `devm_platform_ioremap_resource'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
   Depends on HAS_IOMEM && (ARCH_SUNXI || COMPILE_TEST
   Selected by
   - CLK_SUNXI_PRCM_SUN6I && COMMON_CLK && CLK_SUNXI
   - CLK_SUNXI_PRCM_SUN8I && COMMON_CLK && CLK_SUNXI

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

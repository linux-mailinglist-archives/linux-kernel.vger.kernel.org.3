Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F40C52F77E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 04:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353571AbiEUCIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 22:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiEUCI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 22:08:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C9E185436
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 19:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653098905; x=1684634905;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b9S9Aqrr0Lj8pYHLyu8e12E8vWzlnWY3ZNeBgajyeXM=;
  b=mmCJbGCSLydsmLQk4lhyxGOb7R3+WkoGxJba+syds6TQjVzlgVnHFbU/
   k+cN+t+VmXjNzKZrWaglkCaFHUBfkvMVSHN8pqcMH4SqS0oQhanLYaHVz
   LiAzJ/lJMCGj2tE7+H5hiYPqgIxRJ/VrualjUr1qH469AlNEwnu+dLFCn
   3Ov3jqLoNh2beMxjFY/uPAIiXpIqvOxrtqZXTTKB5uA2jXCTBAb7L0oou
   NuL08QsIlldxt0g0SMhB5hkeImRKxCtXznK4dWaXT0MnPKCmnlU4nw/II
   /gv2PZpE1nyZlyTCeh6whhfGfv93Xso3GJdglqVezHQJJDdrdnBMtdIRy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="298104098"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="298104098"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 19:08:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="557726970"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 20 May 2022 19:08:23 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsEXX-0005mD-1j;
        Sat, 21 May 2022 02:08:23 +0000
Date:   Sat, 21 May 2022 10:07:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: xillybus_of.c:undefined reference to `devm_platform_ioremap_resource'
Message-ID: <202205211012.u258CWm7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b5e1590a26713a8c76896f0f1b99f52ec24e72f
commit: a1315dcb7b6a7d3a78df848eed5b331a4b3ec28a hwrng: ks-sa - Add dependency on IOMEM and OF
date:   1 year, 6 months ago
config: s390-buildonly-randconfig-r006-20220520 (https://download.01.org/0day-ci/archive/20220521/202205211012.u258CWm7-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a1315dcb7b6a7d3a78df848eed5b331a4b3ec28a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a1315dcb7b6a7d3a78df848eed5b331a4b3ec28a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/irqchip/irq-imx-intmux.o: in function `imx_intmux_probe':
   irq-imx-intmux.c:(.text+0x522): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/phy/marvell/phy-mvebu-a3700-utmi.o: in function `mvebu_a3700_utmi_phy_probe':
   phy-mvebu-a3700-utmi.c:(.text+0x152): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_console_close':
   dpaa2-console.c:(.text+0x8c): undefined reference to `iounmap'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_console_probe':
   dpaa2-console.c:(.text+0xea): undefined reference to `of_address_to_resource'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_generic_console_open.constprop.0':
   dpaa2-console.c:(.text+0x212): undefined reference to `ioremap'
   s390-linux-ld: dpaa2-console.c:(.text+0x254): undefined reference to `iounmap'
   s390-linux-ld: dpaa2-console.c:(.text+0x28a): undefined reference to `ioremap'
   s390-linux-ld: dpaa2-console.c:(.text+0x45a): undefined reference to `iounmap'
   s390-linux-ld: drivers/char/hw_random/exynos-trng.o: in function `exynos_trng_probe':
   exynos-trng.c:(.text+0x318): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/meson-rng.o: in function `meson_rng_probe':
   meson-rng.c:(.text+0xc2): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/mtk-rng.o: in function `mtk_rng_probe':
   mtk-rng.c:(.text+0x380): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/npcm-rng.o: in function `npcm_rng_probe':
   npcm-rng.c:(.text+0x2da): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
>> xillybus_of.c:(.text+0x20c): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/watchdog/sirfsoc_wdt.o:sirfsoc_wdt.c:(.text+0x1d8): more undefined references to `devm_platform_ioremap_resource' follow
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_init':
   timer-of.c:(.init.text+0x66): undefined reference to `of_iomap'
   s390-linux-ld: timer-of.c:(.init.text+0x300): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_cleanup':
   timer-of.c:(.init.text+0x3dc): undefined reference to `iounmap'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

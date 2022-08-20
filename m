Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFA659B0D9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 00:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbiHTWvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 18:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiHTWvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 18:51:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5727225280
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661035880; x=1692571880;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o/8gpyn/TPC49w6CaOtsacLFvWLi4lmatq3xYrqZaNw=;
  b=X0XPEKSpLVCI8GWoA0/shX2wc2Do8W76+CfXvQpWjvBpZG+Zs1ygzIIP
   YoqVd6/mwxMgRZBAyGIh1Q13fYgHjdFmM84uNzoKc0vH9hG9l98DDvHo7
   Z1g/5IowYZLgTvUe+KRMFASBy4CUQYGphl7N5xI+5mqIi/7CpnE/gFfTj
   jUGaRrlVzX6Lh9RIRP9G6koDTmKO8RSNVF9WqcIbvhjuAhQywvwVvVTVG
   zvv6Ed2QeBWkjyOJ8z3nd2c2sNi+Y8rXt+p92KtQDHEQqt+p3rsj7MRso
   xbzqwsJsyfelfhDb9Kt+KpTDLg/AE0olvJOuF1VnRuBlcTvUhe7q9IuBZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="357187302"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="357187302"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 15:51:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="784472090"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Aug 2022 15:51:18 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPXJF-0003JL-2R;
        Sat, 20 Aug 2022 22:51:17 +0000
Date:   Sun, 21 Aug 2022 06:50:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: cc_driver.c:undefined reference to `devm_ioremap_resource'
Message-ID: <202208210659.ZhKgw7tr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cc1807b9158a909ffe829a5e222be756c57c9a90
commit: 0f0a6a285ec0c7b0ac0b532f87a784605322f9ce watchdog: Convert to use devm_platform_ioremap_resource
date:   3 years, 4 months ago
config: s390-randconfig-s043-20220820 (https://download.01.org/0day-ci/archive/20220821/202208210659.ZhKgw7tr-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0f0a6a285ec0c7b0ac0b532f87a784605322f9ce
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0f0a6a285ec0c7b0ac0b532f87a784605322f9ce
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/phy/marvell/phy-mvebu-a3700-utmi.o: in function `mvebu_a3700_utmi_phy_probe':
   phy-mvebu-a3700-utmi.c:(.text+0x3de): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/fsl-edma.o: in function `fsl_edma_probe':
   fsl-edma.c:(.text+0x786): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: fsl-edma.c:(.text+0x7d6): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/idma64.o: in function `idma64_platform_probe':
   idma64.c:(.text+0x1476): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/edma.o: in function `edma_xbar_event_map':
   edma.c:(.text+0x460): undefined reference to `of_address_to_resource'
   s390-linux-ld: edma.c:(.text+0x488): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/dma/ti/edma.o: in function `edma_probe':
   edma.c:(.text+0x19aa): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/omap-dma.o: in function `omap_dma_probe':
   omap-dma.c:(.text+0x58): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/dma-crossbar.o: in function `ti_am335x_xbar_probe':
   dma-crossbar.c:(.text+0x272): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/dma-crossbar.o: in function `ti_dra7_xbar_probe':
   dma-crossbar.c:(.text+0x586): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/exynos-trng.o: in function `exynos_trng_probe':
   exynos-trng.c:(.text+0x228): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/meson-rng.o:meson-rng.c:(.text+0x82): more undefined references to `devm_ioremap_resource' follow
   s390-linux-ld: drivers/watchdog/sirfsoc_wdt.o: in function `sirfsoc_wdt_probe':
   sirfsoc_wdt.c:(.text+0x106): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/crypto/ccree/cc_driver.o: in function `init_cc_resources':
>> cc_driver.c:(.text+0x346): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/crypto/ccree/cc_debugfs.o: in function `cc_debugfs_init':
   cc_debugfs.c:(.text+0xd4): undefined reference to `debugfs_create_regset32'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

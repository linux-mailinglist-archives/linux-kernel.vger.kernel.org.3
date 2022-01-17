Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E30F491159
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 22:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243298AbiAQVix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 16:38:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:45887 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230312AbiAQViv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 16:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642455531; x=1673991531;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lRvcJ3YccmJnwh4LZ5knDv+F74644MGKq1W3e+EB/q0=;
  b=JXk9xYomXfrUgGzSib98i4ZXYdiuu5nBFbEESPWuDeisIgdrf2TrF+D1
   lRsXObt2kYFh5qGMHmtQJ9D3Nl0larjjqlwSur0sst6MUDXWd6mTs29j8
   q7IfubgAMJJI1EB3XB/7vT/drjuBJjukZfIomq4vxCkqgqj176JAv0zFx
   3J1TQBG0o9XQJgmFgbeTW7YKhLEkpOuORuEYDlWXrBpBoWOVSJCA54z+n
   80WF93oxFTIUrk7pSDTeQwTIc2z7Vrh3WXihRRMyVuebuRgPCFdlKo7QM
   OcyrqXpHN6q761HNtcbN/d9nNxOBn6dsH+/t+WtePn54ybJw21OUiyn9i
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="244492825"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="244492825"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 13:38:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="693187899"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 17 Jan 2022 13:38:49 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9ZiD-000BtK-89; Mon, 17 Jan 2022 21:38:49 +0000
Date:   Tue, 18 Jan 2022 05:38:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: samsung-keypad.c:undefined reference to `devm_ioremap'
Message-ID: <202201180526.k3xQvHVO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0c947b893d69231a9add855939da7c66237ab44f
commit: bbd7ffdbef6888459f301c5889f3b14ada38b913 clk: Allow the common clk framework to be selectable
date:   1 year, 8 months ago
config: s390-randconfig-c023-20220117 (https://download.01.org/0day-ci/archive/20220118/202201180526.k3xQvHVO-lkp@intel.com/config)
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
   irq-imx-intmux.c:(.text+0x19c): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/exynos-trng.o: in function `exynos_trng_probe':
   exynos-trng.c:(.text+0x3ae): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/meson-rng.o: in function `meson_rng_probe':
   meson-rng.c:(.text+0x112): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/mtk-rng.o: in function `mtk_rng_probe':
   mtk-rng.c:(.text+0x43e): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/ks-sa-rng.o: in function `ks_sa_rng_probe':
   ks-sa-rng.c:(.text+0x546): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/npcm-rng.o:npcm-rng.c:(.text+0x2e2): more undefined references to `devm_platform_ioremap_resource' follow
   s390-linux-ld: drivers/input/keyboard/samsung-keypad.o: in function `samsung_keypad_probe':
>> samsung-keypad.c:(.text+0x92a): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/watchdog/sirfsoc_wdt.o: in function `sirfsoc_wdt_probe':
   sirfsoc_wdt.c:(.text+0x1ee): undefined reference to `devm_platform_ioremap_resource'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
   Depends on HAS_IOMEM && (ARCH_SUNXI || COMPILE_TEST
   Selected by
   - CLK_SUNXI_PRCM_SUN6I && COMMON_CLK && CLK_SUNXI
   - CLK_SUNXI_PRCM_SUN8I && COMMON_CLK && CLK_SUNXI

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

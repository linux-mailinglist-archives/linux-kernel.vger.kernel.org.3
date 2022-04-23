Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9708150CDC3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 23:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbiDWVk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 17:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiDWVkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 17:40:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF111D5660
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 14:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650749846; x=1682285846;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SPXyh5poUdOcTW+Wor5MxtqohioAs576NOvB1FmQ/CY=;
  b=Q2atSYL4ygv4EiuA8theqXkGuHFQtxSdhusplIXDzdFNRL3O4IlJl38C
   Rh2/GLmcgWotJWCXTZ0mgGA/vmc1VcTU3e521OU/rl98RpDjpAS1qghql
   fykKFZ6aVqqLPYwXQEpRH5o9DDHk+c2kZyUL62qQyx1065miVzWmOnobG
   XCZia5ln5NqRG/p8HoPQfOQ/OwJWoXO8mjhueGS4upOLmb5ZGXMIc9Z31
   qjxEgA1hgfrc8ZyiZc0xVU6Av2RvzEP/g/fYU6u94XT91D03qbsbFVAnh
   nthIY6g+UgLpWwtPU8bV9h3gooI39uEICwqfEA6/S99S1uETm93cY5ubw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="263805485"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="263805485"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 14:37:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="729063334"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Apr 2022 14:37:25 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niNRU-0000V7-CP;
        Sat, 23 Apr 2022 21:37:24 +0000
Date:   Sun, 24 Apr 2022 05:36:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Ott <sebott@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: fmvj18x_cs.c:undefined reference to `ioremap'
Message-ID: <202204240543.dAVwn7O6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   13bc32bad7059d6c5671e9d037e6e3ed001cc0f4
commit: 71ba41c9b1d91042960e9d92a5c8f52dc8531eda s390/pci: provide support for MIO instructions
date:   3 years ago
config: s390-buildonly-randconfig-r005-20220424 (https://download.01.org/0day-ci/archive/20220424/202204240543.dAVwn7O6-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=71ba41c9b1d91042960e9d92a5c8f52dc8531eda
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 71ba41c9b1d91042960e9d92a5c8f52dc8531eda
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/phy/marvell/phy-mvebu-a3700-utmi.o: in function `mvebu_a3700_utmi_phy_probe':
   phy-mvebu-a3700-utmi.c:(.text+0x41e): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_detach':
   main.c:(.text+0x90): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0xd4): undefined reference to `iounmap'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `config_ipwireless':
   main.c:(.text+0x262): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0x2a0): undefined reference to `iounmap'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_probe.part.0':
   main.c:(.text+0x53a): undefined reference to `ioremap'
   s390-linux-ld: main.c:(.text+0x5f6): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0x62c): undefined reference to `ioremap'
   s390-linux-ld: main.c:(.text+0x676): undefined reference to `iounmap'
   s390-linux-ld: drivers/char/hw_random/exynos-trng.o: in function `exynos_trng_probe':
   exynos-trng.c:(.text+0x240): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/meson-rng.o: in function `meson_rng_probe':
   meson-rng.c:(.text+0x82): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/mtk-rng.o: in function `mtk_rng_probe':
   mtk-rng.c:(.text+0x274): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/net/ethernet/fujitsu/fmvj18x_cs.o: in function `fmvj18x_get_hwinfo':
>> fmvj18x_cs.c:(.text+0xd0c): undefined reference to `ioremap'
>> s390-linux-ld: fmvj18x_cs.c:(.text+0xd56): undefined reference to `iounmap'
   s390-linux-ld: fmvj18x_cs.c:(.text+0xde0): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/fujitsu/fmvj18x_cs.o: in function `fmvj18x_config':
   fmvj18x_cs.c:(.text+0xf7e): undefined reference to `ioremap'
   s390-linux-ld: fmvj18x_cs.c:(.text+0x10ae): undefined reference to `iounmap'
   s390-linux-ld: fmvj18x_cs.c:(.text+0x145e): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/fujitsu/fmvj18x_cs.o: in function `fmvj18x_detach':
>> fmvj18x_cs.c:(.text+0x15d8): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/xircom/xirc2ps_cs.o: in function `xirc2ps_detach':
   xirc2ps_cs.c:(.text+0xe48): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/xircom/xirc2ps_cs.o: in function `xirc2ps_config':
   xirc2ps_cs.c:(.text+0x19a8): undefined reference to `ioremap'
>> s390-linux-ld: xirc2ps_cs.c:(.text+0x1b20): undefined reference to `iounmap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
   cistpl.c:(.text+0x222): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x234): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x286): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x29c): undefined reference to `iounmap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
   cistpl.c:(.text+0xd06): undefined reference to `iounmap'
   s390-linux-ld: drivers/crypto/ccree/cc_driver.o: in function `init_cc_resources':
   cc_driver.c:(.text+0x326): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/crypto/ccree/cc_debugfs.o: in function `cc_debugfs_init':
   cc_debugfs.c:(.text+0xcc): undefined reference to `debugfs_create_regset32'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

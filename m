Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E905E59EEF1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiHWWWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiHWWWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:22:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86F586FDC
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661293328; x=1692829328;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RXPM53ki3rzhSiQlbeB6z9Kk6nKneF0+7IsxXSByG68=;
  b=IgI2G2QMeDkvgqnnI2jUDkVV0SE1gKSonKWERWd2Rw68ftzV3lGCb7QG
   HkHNqrb0c3vbbnuUxRpCXsd56P9Y3t6jryllVDj9krF1ZpI6a3bvx2cO5
   ItbScAkZ+PhM5p7JfqDstj+24S8fGGM7VXGm35QMcMJeV4zA8WffYmeKV
   nj+ZApbKOfCwQ1rB12IOY3g60gm1zkN+ecQo3boRwO684j139/ckjYcuG
   vPDIn4QgCqMuklMV6hvy1KoH2fXjTUQ19cF+4LOCCNlEryPIDaW8bHcSv
   LuKCyWkB2nM5ZDyo8txNgrIFbMdinz8t+l7b1/xMONPixyZy7H3eS2lah
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="293807574"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="293807574"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 15:22:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="677791489"
Received: from lkp-server02.sh.intel.com (HELO 9bbcefcddf9f) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 23 Aug 2022 15:22:07 -0700
Received: from kbuild by 9bbcefcddf9f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQcHe-0000dr-2B;
        Tue, 23 Aug 2022 22:22:06 +0000
Date:   Wed, 24 Aug 2022 06:21:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Ott <sebott@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: main.c:undefined reference to `iounmap'
Message-ID: <202208240628.9YgXEqCY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   df0219d11b6f04251d38e345db4f9780cb32e2e2
commit: 71ba41c9b1d91042960e9d92a5c8f52dc8531eda s390/pci: provide support for MIO instructions
date:   3 years, 4 months ago
config: s390-randconfig-r044-20220823 (https://download.01.org/0day-ci/archive/20220824/202208240628.9YgXEqCY-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=71ba41c9b1d91042960e9d92a5c8f52dc8531eda
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 71ba41c9b1d91042960e9d92a5c8f52dc8531eda
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_detach':
>> main.c:(.text+0x94): undefined reference to `iounmap'
>> s390-linux-ld: main.c:(.text+0xd8): undefined reference to `iounmap'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `config_ipwireless':
   main.c:(.text+0x268): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0x2a6): undefined reference to `iounmap'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_probe.part.0':
>> main.c:(.text+0x578): undefined reference to `ioremap'
   s390-linux-ld: main.c:(.text+0x636): undefined reference to `iounmap'
>> s390-linux-ld: main.c:(.text+0x66c): undefined reference to `ioremap'
   s390-linux-ld: main.c:(.text+0x6b8): undefined reference to `iounmap'
   s390-linux-ld: drivers/char/hw_random/exynos-trng.o: in function `exynos_trng_probe':
   exynos-trng.c:(.text+0x200): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/meson-rng.o: in function `meson_rng_probe':
   meson-rng.c:(.text+0x88): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/mtk-rng.o: in function `mtk_rng_probe':
   mtk-rng.c:(.text+0x238): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `com90xx_exit':
   com90xx.c:(.exit.text+0x56): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `check_mirror':
   com90xx.c:(.init.text+0x54): undefined reference to `ioremap'
   s390-linux-ld: com90xx.c:(.init.text+0x78): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `com90xx_found':
   com90xx.c:(.init.text+0x114): undefined reference to `iounmap'
   s390-linux-ld: com90xx.c:(.init.text+0x1e8): undefined reference to `iounmap'
   s390-linux-ld: com90xx.c:(.init.text+0x304): undefined reference to `ioremap'
   s390-linux-ld: com90xx.c:(.init.text+0x3d4): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `com90xx_probe':
   com90xx.c:(.init.text+0x9ec): undefined reference to `ioremap'
   s390-linux-ld: com90xx.c:(.init.text+0xb74): undefined reference to `iounmap'
   s390-linux-ld: com90xx.c:(.init.text+0x10f2): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `arc_rimi_exit':
   arc-rimi.c:(.exit.text+0x2e): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `arcrimi_found':
   arc-rimi.c:(.init.text+0xd4): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x14e): undefined reference to `iounmap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x2be): undefined reference to `iounmap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x344): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x404): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `check_mirror':
   arc-rimi.c:(.text.unlikely+0x54): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.text.unlikely+0x78): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/altera/altera_tse_main.o: in function `request_and_map':
   altera_tse_main.c:(.text+0x14e): undefined reference to `devm_ioremap_nocache'
   s390-linux-ld: drivers/net/ethernet/fujitsu/fmvj18x_cs.o: in function `fmvj18x_get_hwinfo':
   fmvj18x_cs.c:(.text+0xd14): undefined reference to `ioremap'
   s390-linux-ld: fmvj18x_cs.c:(.text+0xd5e): undefined reference to `iounmap'
   s390-linux-ld: fmvj18x_cs.c:(.text+0xdf2): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/fujitsu/fmvj18x_cs.o: in function `fmvj18x_config':
   fmvj18x_cs.c:(.text+0xf88): undefined reference to `ioremap'
   s390-linux-ld: fmvj18x_cs.c:(.text+0x10ac): undefined reference to `iounmap'
   s390-linux-ld: fmvj18x_cs.c:(.text+0x143c): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/fujitsu/fmvj18x_cs.o: in function `fmvj18x_detach':
   fmvj18x_cs.c:(.text+0x15e0): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/xircom/xirc2ps_cs.o: in function `xirc2ps_detach':
>> xirc2ps_cs.c:(.text+0xea0): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/xircom/xirc2ps_cs.o: in function `xirc2ps_config':
>> xirc2ps_cs.c:(.text+0x1b9c): undefined reference to `ioremap'
>> s390-linux-ld: xirc2ps_cs.c:(.text+0x1cbe): undefined reference to `iounmap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
   cistpl.c:(.text+0x224): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x236): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x28a): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x29a): undefined reference to `iounmap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
   cistpl.c:(.text+0xda6): undefined reference to `iounmap'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

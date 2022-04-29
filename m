Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D725E51554B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380627AbiD2UQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380634AbiD2UQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:16:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD81BD5566
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651263203; x=1682799203;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1yJ6dtBUmzSPd3KmuoPqTe8eRBSPNU2G69mjWH9cZx8=;
  b=hRVSjEgkMVQQAZWnvE0JtB+Q/5R33rduQ4VDjCO8i8c8O/JB8jOm7Ta7
   WLnz0ec7fUsJAIafDO9WAk03FppVVymrnXA/6K6UmZMLBfl4DleLVkwkA
   ecQ68TGfAYZYKbNzmUzpSoL5kUuIdkGdaBjJ8Av4yPv6D/VtqxoZQASoB
   8Jhp7Azf/dEuUZVEP6ZvPi3rVOYfCQXUz2J8TgAL9dbcNa5spCkGkml4p
   9jPJKXYnjD2U1WhbC1dc3sSDbRGI1d3M+kCCOMOyvKFQ7gXVm+ihA8vpB
   i1ZZIqvrPT2hu64/nsaYfnKA1k6cdqxWbF1koiTMOJ33b+SLTWAdXcG0q
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="265604811"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="265604811"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 13:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="685307939"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Apr 2022 13:13:21 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkWzR-0006bH-6o;
        Fri, 29 Apr 2022 20:13:21 +0000
Date:   Sat, 30 Apr 2022 04:12:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Ott <sebott@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: smc91c92_cs.c:undefined reference to `iounmap'
Message-ID: <202204300425.kL7G88z7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2d0de93ca2515958e717138e5ee07ec3b6bf0226
commit: 71ba41c9b1d91042960e9d92a5c8f52dc8531eda s390/pci: provide support for MIO instructions
date:   3 years ago
config: s390-randconfig-r012-20220428 (https://download.01.org/0day-ci/archive/20220430/202204300425.kL7G88z7-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=71ba41c9b1d91042960e9d92a5c8f52dc8531eda
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 71ba41c9b1d91042960e9d92a5c8f52dc8531eda
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/phy/marvell/phy-mvebu-a3700-utmi.o: in function `mvebu_a3700_utmi_phy_probe':
   phy-mvebu-a3700-utmi.c:(.text+0x544): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/fsl-edma.o: in function `fsl_edma_probe':
   fsl-edma.c:(.text+0xb72): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: fsl-edma.c:(.text+0xbe0): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/idma64.o: in function `idma64_platform_probe':
   idma64.c:(.text+0x1b7a): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/edma.o: in function `edma_xbar_event_map':
   edma.c:(.text+0x750): undefined reference to `of_address_to_resource'
   s390-linux-ld: edma.c:(.text+0x790): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/dma/ti/edma.o: in function `edma_probe':
   edma.c:(.text+0x2908): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/omap-dma.o: in function `omap_dma_probe':
   omap-dma.c:(.text+0x68): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/dma-crossbar.o: in function `ti_am335x_xbar_probe':
   dma-crossbar.c:(.text+0x3b4): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/dma-crossbar.o: in function `ti_dra7_xbar_probe':
   dma-crossbar.c:(.text+0x868): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_detach':
   main.c:(.text+0xa0): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0xf0): undefined reference to `iounmap'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `config_ipwireless':
   main.c:(.text+0x2f2): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0x33c): undefined reference to `iounmap'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_probe.part.0':
   main.c:(.text+0x6f0): undefined reference to `ioremap'
   s390-linux-ld: main.c:(.text+0x7e8): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0x824): undefined reference to `ioremap'
   s390-linux-ld: main.c:(.text+0x874): undefined reference to `iounmap'
   s390-linux-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
   xillybus_of.c:(.text+0x54e): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `com90xx_exit':
   com90xx.c:(.exit.text+0x72): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `check_mirror':
   com90xx.c:(.init.text+0x5e): undefined reference to `ioremap'
   s390-linux-ld: com90xx.c:(.init.text+0x9c): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `com90xx_found':
   com90xx.c:(.init.text+0x13c): undefined reference to `iounmap'
   s390-linux-ld: com90xx.c:(.init.text+0x2aa): undefined reference to `iounmap'
   s390-linux-ld: com90xx.c:(.init.text+0x3fe): undefined reference to `ioremap'
   s390-linux-ld: com90xx.c:(.init.text+0x526): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `com90xx_probe':
   com90xx.c:(.init.text+0x92e): undefined reference to `ioremap'
   s390-linux-ld: com90xx.c:(.init.text+0xa2e): undefined reference to `iounmap'
   s390-linux-ld: com90xx.c:(.init.text+0xde8): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `arc_rimi_exit':
   arc-rimi.c:(.exit.text+0x34): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `arcrimi_found':
   arc-rimi.c:(.init.text+0x12a): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x1e4): undefined reference to `iounmap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x3f8): undefined reference to `iounmap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x49e): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x5b4): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `check_mirror':
   arc-rimi.c:(.text.unlikely+0x5e): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.text.unlikely+0x9c): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/altera/altera_tse_main.o: in function `request_and_map':
   altera_tse_main.c:(.text+0x19e6): undefined reference to `devm_ioremap_nocache'
   s390-linux-ld: drivers/net/ethernet/smsc/smc91c92_cs.o: in function `smc91c92_detach':
>> smc91c92_cs.c:(.text+0x22d2): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/smsc/smc91c92_cs.o: in function `smc91c92_config':
>> smc91c92_cs.c:(.text+0x2c96): undefined reference to `ioremap'
>> s390-linux-ld: smc91c92_cs.c:(.text+0x3466): undefined reference to `iounmap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
   cistpl.c:(.text+0x3b6): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x3ce): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x460): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x480): undefined reference to `iounmap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
   cistpl.c:(.text+0x1688): undefined reference to `iounmap'
   s390-linux-ld: drivers/watchdog/sirfsoc_wdt.o: in function `sirfsoc_wdt_probe':
   sirfsoc_wdt.c:(.text+0x18e): undefined reference to `devm_ioremap_resource'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012C64686B5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 18:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385247AbhLDRoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 12:44:24 -0500
Received: from mga18.intel.com ([134.134.136.126]:47010 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhLDRoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 12:44:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="224006194"
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="224006194"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 09:40:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="478677014"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 04 Dec 2021 09:40:56 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtZ1r-000JFW-L3; Sat, 04 Dec 2021 17:40:55 +0000
Date:   Sun, 5 Dec 2021 01:40:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/korina.c:391:13: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202112050130.Qp3FgF7i-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   12119cfa1052d512a92524e90ebee85029a918f8
commit: 6ef92063bf94cd8a6fa9fea3a82596955eb25424 net: korina: Make driver COMPILE_TESTable
date:   8 months ago
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20211205/202112050130.Qp3FgF7i-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6ef92063bf94cd8a6fa9fea3a82596955eb25424
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6ef92063bf94cd8a6fa9fea3a82596955eb25424
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash drivers/net/ethernet/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/net/ethernet/korina.c:408:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct dma_reg *ch @@     got struct dma_reg [noderef] __iomem *tx_dma_regs @@
   drivers/net/ethernet/korina.c:408:33: sparse:     expected struct dma_reg *ch
   drivers/net/ethernet/korina.c:408:33: sparse:     got struct dma_reg [noderef] __iomem *tx_dma_regs
   drivers/net/ethernet/korina.c:415:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct dma_reg *ch @@     got struct dma_reg [noderef] __iomem *rx_dma_regs @@
   drivers/net/ethernet/korina.c:415:33: sparse:     expected struct dma_reg *ch
   drivers/net/ethernet/korina.c:415:33: sparse:     got struct dma_reg [noderef] __iomem *rx_dma_regs
>> drivers/net/ethernet/korina.c:391:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:391:13: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:391:13: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:392:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:392:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:392:17: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:394:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:394:26: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:394:26: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:397:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:397:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:397:17: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:400:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:400:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:400:9: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:401:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:401:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:401:9: sparse:     got unsigned int *
>> drivers/net/ethernet/korina.c:391:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:391:13: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:391:13: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:392:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:392:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:392:17: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:394:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:394:26: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:394:26: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:397:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:397:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:397:17: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:400:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:400:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:400:9: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:401:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:401:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:401:9: sparse:     got unsigned int *

vim +391 drivers/net/ethernet/korina.c

0fc96939a97ffd drivers/net/ethernet/korina.c Thomas Bogendoerfer 2021-04-19  387  
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  388  static inline void korina_abort_dma(struct net_device *dev,
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  389  					struct dma_reg *ch)
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  390  {
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19 @391  	if (readl(&ch->dmac) & DMA_CHAN_RUN_BIT) {
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  392  		writel(0x10, &ch->dmac);
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  393  
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  394  		while (!(readl(&ch->dmas) & DMA_STAT_HALT))
860e9538a9482b drivers/net/ethernet/korina.c Florian Westphal    2016-05-03  395  			netif_trans_update(dev);
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  396  
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  397  		writel(0, &ch->dmas);
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  398  	}
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  399  
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  400  	writel(0, &ch->dmadptr);
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  401  	writel(0, &ch->dmandptr);
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  402  }
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  403  

:::::: The code at line 391 was first introduced by commit
:::::: ef11291bcd5f963c72e7ba5952be3e3c97463d2c Add support the Korina (IDT RC32434) Ethernet MAC

:::::: TO: Florian Fainelli <florian.fainelli@telecomint.eu>
:::::: CC: Jeff Garzik <jeff@garzik.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

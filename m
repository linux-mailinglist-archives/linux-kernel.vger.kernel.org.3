Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791644827BD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 15:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiAAO1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 09:27:47 -0500
Received: from mga04.intel.com ([192.55.52.120]:32257 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232171AbiAAO1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 09:27:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641047266; x=1672583266;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+Ypu7aFQqx/mjNT1bZ/niUbUaKnOL+NZzAbLvFtHl4o=;
  b=DSEYEvOOkcgtpp+l4mKI/WEEIMgFqn5wCKXkKBD9P287d7OVh7jCexAT
   OfrWngvBlJpw9H9XYgMhrPdKuGOHlH36BLvVNNEuNkS1ecy4pdpK/iVgu
   mHQNCibOWbvykw8zX++ND9DOPEBAOMjEO65sMTsRiy9zlsoD+Y5Ga17lc
   Uv2uUFCp1acw9NbNqaNeRBMo9IkGjY4yVeUu0Q/5zNEDD0EVqrN0zH8YQ
   loAZ9rmyGc8ZfXazcp8MKaY7RkBh+v5uNCoG453KErhHyKN7kYeRlfQAe
   KcKRU/ZJSPUDoSJT1zJOIyAMSrO03zVj7Hbzt2rOcYgHSEZ6WAt9XpEVO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="240715869"
X-IronPort-AV: E=Sophos;i="5.88,254,1635231600"; 
   d="scan'208";a="240715869"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2022 06:27:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,254,1635231600"; 
   d="scan'208";a="471171557"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 01 Jan 2022 06:27:44 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3fMG-000CWn-6c; Sat, 01 Jan 2022 14:27:44 +0000
Date:   Sat, 1 Jan 2022 22:27:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/dma/sun6i-dma.c:244:45: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202201012238.pq6NU8G1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8008293888188c3923f5bd8a69370dae25ed14e5
commit: 35a3f4ef0ab543daa1725b0c963eb8c05e3376f8 alpha: Declare virt_to_phys and virt_to_bus parameter as pointer to volatile
date:   4 months ago
config: alpha-randconfig-s032-20211117 (https://download.01.org/0day-ci/archive/20220101/202201012238.pq6NU8G1-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=35a3f4ef0ab543daa1725b0c963eb8c05e3376f8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 35a3f4ef0ab543daa1725b0c963eb8c05e3376f8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash drivers/dma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/dma/sun6i-dma.c:244:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile *address @@     got void [noderef] __iomem *base @@
   drivers/dma/sun6i-dma.c:244:45: sparse:     expected void volatile *address
   drivers/dma/sun6i-dma.c:244:45: sparse:     got void [noderef] __iomem *base

vim +244 drivers/dma/sun6i-dma.c

555859308723d8 Maxime Ripard 2014-07-17  240  
555859308723d8 Maxime Ripard 2014-07-17  241  static inline void sun6i_dma_dump_chan_regs(struct sun6i_dma_dev *sdev,
555859308723d8 Maxime Ripard 2014-07-17  242  					    struct sun6i_pchan *pchan)
555859308723d8 Maxime Ripard 2014-07-17  243  {
42c0d54e623695 Vinod Koul    2014-07-28 @244  	phys_addr_t reg = virt_to_phys(pchan->base);
555859308723d8 Maxime Ripard 2014-07-17  245  
555859308723d8 Maxime Ripard 2014-07-17  246  	dev_dbg(sdev->slave.dev, "Chan %d reg: %pa\n"
555859308723d8 Maxime Ripard 2014-07-17  247  		"\t___en(%04x): \t0x%08x\n"
555859308723d8 Maxime Ripard 2014-07-17  248  		"\tpause(%04x): \t0x%08x\n"
555859308723d8 Maxime Ripard 2014-07-17  249  		"\tstart(%04x): \t0x%08x\n"
555859308723d8 Maxime Ripard 2014-07-17  250  		"\t__cfg(%04x): \t0x%08x\n"
555859308723d8 Maxime Ripard 2014-07-17  251  		"\t__src(%04x): \t0x%08x\n"
555859308723d8 Maxime Ripard 2014-07-17  252  		"\t__dst(%04x): \t0x%08x\n"
555859308723d8 Maxime Ripard 2014-07-17  253  		"\tcount(%04x): \t0x%08x\n"
555859308723d8 Maxime Ripard 2014-07-17  254  		"\t_para(%04x): \t0x%08x\n\n",
555859308723d8 Maxime Ripard 2014-07-17  255  		pchan->idx, &reg,
555859308723d8 Maxime Ripard 2014-07-17  256  		DMA_CHAN_ENABLE,
555859308723d8 Maxime Ripard 2014-07-17  257  		readl(pchan->base + DMA_CHAN_ENABLE),
555859308723d8 Maxime Ripard 2014-07-17  258  		DMA_CHAN_PAUSE,
555859308723d8 Maxime Ripard 2014-07-17  259  		readl(pchan->base + DMA_CHAN_PAUSE),
555859308723d8 Maxime Ripard 2014-07-17  260  		DMA_CHAN_LLI_ADDR,
555859308723d8 Maxime Ripard 2014-07-17  261  		readl(pchan->base + DMA_CHAN_LLI_ADDR),
555859308723d8 Maxime Ripard 2014-07-17  262  		DMA_CHAN_CUR_CFG,
555859308723d8 Maxime Ripard 2014-07-17  263  		readl(pchan->base + DMA_CHAN_CUR_CFG),
555859308723d8 Maxime Ripard 2014-07-17  264  		DMA_CHAN_CUR_SRC,
555859308723d8 Maxime Ripard 2014-07-17  265  		readl(pchan->base + DMA_CHAN_CUR_SRC),
555859308723d8 Maxime Ripard 2014-07-17  266  		DMA_CHAN_CUR_DST,
555859308723d8 Maxime Ripard 2014-07-17  267  		readl(pchan->base + DMA_CHAN_CUR_DST),
555859308723d8 Maxime Ripard 2014-07-17  268  		DMA_CHAN_CUR_CNT,
555859308723d8 Maxime Ripard 2014-07-17  269  		readl(pchan->base + DMA_CHAN_CUR_CNT),
555859308723d8 Maxime Ripard 2014-07-17  270  		DMA_CHAN_CUR_PARA,
555859308723d8 Maxime Ripard 2014-07-17  271  		readl(pchan->base + DMA_CHAN_CUR_PARA));
555859308723d8 Maxime Ripard 2014-07-17  272  }
555859308723d8 Maxime Ripard 2014-07-17  273  

:::::: The code at line 244 was first introduced by commit
:::::: 42c0d54e62369584f2491f072f405602ff504e0e dmaengine: sun6i: fix build failure on x86, xilinx targets

:::::: TO: Vinod Koul <vinod.koul@intel.com>
:::::: CC: Vinod Koul <vinod.koul@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DBE498DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 20:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353703AbiAXTfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 14:35:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:3553 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347994AbiAXT1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 14:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643052449; x=1674588449;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=92G7QDVUIZopiXhcTFwl2+WPw+P0JDGWz1LsH6KJXFQ=;
  b=U7xckXFisFQfm9DZAKaHs6FnUwx2ywnuPw9lO2dCQV/jtWsxIHUq1dX2
   oN8q+AacrvWLP/E7NF2dOoSwJ9ixfz0I//EUPsvBU4rbVCnkwDrQk30nz
   08hpT9RJGaEG+dpDwm2lwfz3bWthQGNnpJ/XhtaeaFA/2SI+qqp3Zanz8
   +6iiYP2ptxfOQ4Ik2JtdaaGmsKFkA40NwD/E7VCpQPJY6u/m0YVASt8vj
   LODnVt40WdyB7f7My/WXsc9CuQY/VkODyysgirplA93Gn0er+rFF6wjg7
   bnN40GrnzPtD2n2EROOuew5X21zVIXIa2hBCKaHvhHJlSKbMWV5Gbygah
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246347515"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="246347515"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 11:25:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="695539896"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Jan 2022 11:25:03 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nC4xa-000IoI-Lf; Mon, 24 Jan 2022 19:25:02 +0000
Date:   Tue, 25 Jan 2022 03:24:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1750/2384]
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h:38:27: warning:
 declaration of 'struct net_device' will not be visible outside of this
 function
Message-ID: <202201250317.7RaTIwIn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: 665097d414cd5e34cf1c21585efc611205ab1efa [1750/2384] headers/deps: net: Optimize <linux/if_ether.h>
config: mips-bcm63xx_defconfig (https://download.01.org/0day-ci/archive/20220125/202201250317.7RaTIwIn-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2e58a18910867ba6795066e044293e6daf89edf5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=665097d414cd5e34cf1c21585efc611205ab1efa
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 665097d414cd5e34cf1c21585efc611205ab1efa
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/ kernel//

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/mips/bcm63xx/dev-enet.c:16:
>> arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h:38:27: warning: declaration of 'struct net_device' will not be visible outside of this function [-Wvisibility]
           int (*mii_config)(struct net_device *dev, int probe,
                                    ^
   1 warning generated.


vim +38 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h

3dc6475c0c9e55 Florian Fainelli 2013-06-12   9  
e7300d04bd0809 Maxime Bizon     2009-08-18  10  /*
e7300d04bd0809 Maxime Bizon     2009-08-18  11   * on board ethernet platform data
e7300d04bd0809 Maxime Bizon     2009-08-18  12   */
e7300d04bd0809 Maxime Bizon     2009-08-18  13  struct bcm63xx_enet_platform_data {
e7300d04bd0809 Maxime Bizon     2009-08-18  14  	char mac_addr[ETH_ALEN];
e7300d04bd0809 Maxime Bizon     2009-08-18  15  
e7300d04bd0809 Maxime Bizon     2009-08-18  16  	int has_phy;
e7300d04bd0809 Maxime Bizon     2009-08-18  17  
e7300d04bd0809 Maxime Bizon     2009-08-18  18  	/* if has_phy, then set use_internal_phy */
e7300d04bd0809 Maxime Bizon     2009-08-18  19  	int use_internal_phy;
e7300d04bd0809 Maxime Bizon     2009-08-18  20  
e7300d04bd0809 Maxime Bizon     2009-08-18  21  	/* or fill phy info to use an external one */
e7300d04bd0809 Maxime Bizon     2009-08-18  22  	int phy_id;
e7300d04bd0809 Maxime Bizon     2009-08-18  23  	int has_phy_interrupt;
e7300d04bd0809 Maxime Bizon     2009-08-18  24  	int phy_interrupt;
e7300d04bd0809 Maxime Bizon     2009-08-18  25  
e904b94a06c77a Andrea Gelmini   2016-05-21  26  	/* if has_phy, use autonegotiated pause parameters or force
e7300d04bd0809 Maxime Bizon     2009-08-18  27  	 * them */
e7300d04bd0809 Maxime Bizon     2009-08-18  28  	int pause_auto;
e7300d04bd0809 Maxime Bizon     2009-08-18  29  	int pause_rx;
e7300d04bd0809 Maxime Bizon     2009-08-18  30  	int pause_tx;
e7300d04bd0809 Maxime Bizon     2009-08-18  31  
e7300d04bd0809 Maxime Bizon     2009-08-18  32  	/* if !has_phy, set desired forced speed/duplex */
e7300d04bd0809 Maxime Bizon     2009-08-18  33  	int force_speed_100;
e7300d04bd0809 Maxime Bizon     2009-08-18  34  	int force_duplex_full;
e7300d04bd0809 Maxime Bizon     2009-08-18  35  
e7300d04bd0809 Maxime Bizon     2009-08-18  36  	/* if !has_phy, set callback to perform mii device
e7300d04bd0809 Maxime Bizon     2009-08-18  37  	 * init/remove */
e7300d04bd0809 Maxime Bizon     2009-08-18 @38  	int (*mii_config)(struct net_device *dev, int probe,
e7300d04bd0809 Maxime Bizon     2009-08-18  39  			  int (*mii_read)(struct net_device *dev,
e7300d04bd0809 Maxime Bizon     2009-08-18  40  					  int phy_id, int reg),
e7300d04bd0809 Maxime Bizon     2009-08-18  41  			  void (*mii_write)(struct net_device *dev,
e7300d04bd0809 Maxime Bizon     2009-08-18  42  					    int phy_id, int reg, int val));
3dc6475c0c9e55 Florian Fainelli 2013-06-12  43  
3dc6475c0c9e55 Florian Fainelli 2013-06-12  44  	/* DMA channel enable mask */
3dc6475c0c9e55 Florian Fainelli 2013-06-12  45  	u32 dma_chan_en_mask;
3dc6475c0c9e55 Florian Fainelli 2013-06-12  46  
3dc6475c0c9e55 Florian Fainelli 2013-06-12  47  	/* DMA channel interrupt mask */
3dc6475c0c9e55 Florian Fainelli 2013-06-12  48  	u32 dma_chan_int_mask;
3dc6475c0c9e55 Florian Fainelli 2013-06-12  49  
3dc6475c0c9e55 Florian Fainelli 2013-06-12  50  	/* DMA engine has internal SRAM */
3dc6475c0c9e55 Florian Fainelli 2013-06-12  51  	bool dma_has_sram;
3dc6475c0c9e55 Florian Fainelli 2013-06-12  52  
3dc6475c0c9e55 Florian Fainelli 2013-06-12  53  	/* DMA channel register width */
3dc6475c0c9e55 Florian Fainelli 2013-06-12  54  	unsigned int dma_chan_width;
3dc6475c0c9e55 Florian Fainelli 2013-06-12  55  
3dc6475c0c9e55 Florian Fainelli 2013-06-12  56  	/* DMA descriptor shift */
3dc6475c0c9e55 Florian Fainelli 2013-06-12  57  	unsigned int dma_desc_shift;
1942e482258d8c Jonas Gorski     2017-12-17  58  
1942e482258d8c Jonas Gorski     2017-12-17  59  	/* dma channel ids */
1942e482258d8c Jonas Gorski     2017-12-17  60  	int rx_chan;
1942e482258d8c Jonas Gorski     2017-12-17  61  	int tx_chan;
e7300d04bd0809 Maxime Bizon     2009-08-18  62  };
e7300d04bd0809 Maxime Bizon     2009-08-18  63  

:::::: The code at line 38 was first introduced by commit
:::::: e7300d04bd0809eb7ea10a2ed8c729459f816e36 MIPS: BCM63xx: Add support for the Broadcom BCM63xx family of SOCs.

:::::: TO: Maxime Bizon <mbizon@freebox.fr>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

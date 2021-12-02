Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5F146693A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348134AbhLBRiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:38:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:34533 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235806AbhLBRiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:38:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="223992960"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="223992960"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 09:34:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="677739807"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2021 09:34:39 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mspyg-000GY2-BG; Thu, 02 Dec 2021 17:34:38 +0000
Date:   Fri, 3 Dec 2021 01:34:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     kbuild-all@lists.01.org, john@phrozen.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 07/13] clk: en7523: Add clock driver for Airoha EN7523
 SoC
Message-ID: <202112030121.BuKKR1T4-lkp@intel.com>
References: <20211129153330.37719-8-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129153330.37719-8-nbd@nbd.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felix,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on clk/clk-next v5.16-rc3 next-20211202]
[cannot apply to linusw-gpio/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Felix-Fietkau/dt-bindings-Add-vendor-prefix-for-Airoha/20211130-033938
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: mips-randconfig-s031-20211202 (https://download.01.org/0day-ci/archive/20211203/202112030121.BuKKR1T4-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/f1c5b70976ce5352c8ac2ae85739e1be63f59ec2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Felix-Fietkau/dt-bindings-Add-vendor-prefix-for-Airoha/20211130-033938
        git checkout f1c5b70976ce5352c8ac2ae85739e1be63f59ec2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash drivers/clk/ drivers/gpio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/clk/clk-en7523.c:202:27: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void *np_base @@     got void [noderef] __iomem *base @@
   drivers/clk/clk-en7523.c:202:27: sparse:     expected void *np_base
   drivers/clk/clk-en7523.c:202:27: sparse:     got void [noderef] __iomem *base
>> drivers/clk/clk-en7523.c:206:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/clk/clk-en7523.c:206:29: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/clk/clk-en7523.c:206:29: sparse:     got void *
>> drivers/clk/clk-en7523.c:208:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/clk/clk-en7523.c:208:29: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/clk/clk-en7523.c:208:29: sparse:     got void *
   drivers/clk/clk-en7523.c:213:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/clk/clk-en7523.c:213:29: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/clk/clk-en7523.c:213:29: sparse:     got void *
   drivers/clk/clk-en7523.c:217:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/clk/clk-en7523.c:217:29: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/clk/clk-en7523.c:217:29: sparse:     got void *
   drivers/clk/clk-en7523.c:220:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/clk/clk-en7523.c:220:37: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/clk/clk-en7523.c:220:37: sparse:     got void *
   drivers/clk/clk-en7523.c:222:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/clk/clk-en7523.c:222:36: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/clk/clk-en7523.c:222:36: sparse:     got void *
   drivers/clk/clk-en7523.c:224:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/clk/clk-en7523.c:224:37: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/clk/clk-en7523.c:224:37: sparse:     got void *
   drivers/clk/clk-en7523.c:229:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/clk/clk-en7523.c:229:29: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/clk/clk-en7523.c:229:29: sparse:     got void *
   drivers/clk/clk-en7523.c:230:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/clk/clk-en7523.c:230:37: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/clk/clk-en7523.c:230:37: sparse:     got void *
   drivers/clk/clk-en7523.c:232:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/clk/clk-en7523.c:232:36: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/clk/clk-en7523.c:232:36: sparse:     got void *
   drivers/clk/clk-en7523.c:241:27: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void *np_base @@     got void [noderef] __iomem *base @@
   drivers/clk/clk-en7523.c:241:27: sparse:     expected void *np_base
   drivers/clk/clk-en7523.c:241:27: sparse:     got void [noderef] __iomem *base
   drivers/clk/clk-en7523.c:244:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/clk/clk-en7523.c:244:29: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/clk/clk-en7523.c:244:29: sparse:     got void *
   drivers/clk/clk-en7523.c:246:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/clk/clk-en7523.c:246:29: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/clk/clk-en7523.c:246:29: sparse:     got void *

vim +206 drivers/clk/clk-en7523.c

   198	
   199	static int en7523_pci_enable(struct clk_hw *hw)
   200	{
   201		struct en_clk_gate *cg = container_of(hw, struct en_clk_gate, hw);
   202		void *np_base = cg->base;
   203		u32 val, mask;
   204	
   205		/* Need to pull device low before reset */
 > 206		val = readl(np_base + REG_PCI_CONTROL);
   207		val &= ~(REG_PCI_CONTROL_PERSTOUT1 | REG_PCI_CONTROL_PERSTOUT);
 > 208		writel(val, np_base + REG_PCI_CONTROL);
   209		usleep_range(1000, 2000);
   210	
   211		/* Enable PCIe port 1 */
   212		val |= REG_PCI_CONTROL_REFCLK_EN1;
   213		writel(val, np_base + REG_PCI_CONTROL);
   214		usleep_range(1000, 2000);
   215	
   216		/* Reset to default */
   217		val = readl(np_base + REG_RESET_CONTROL);
   218		mask = REG_RESET_CONTROL_PCIE1 | REG_RESET_CONTROL_PCIE2 |
   219		       REG_RESET_CONTROL_PCIEHB;
   220		writel(val & ~mask, np_base + REG_RESET_CONTROL);
   221		usleep_range(1000, 2000);
   222		writel(val | mask, np_base + REG_RESET_CONTROL);
   223		msleep(100);
   224		writel(val & ~mask, np_base + REG_RESET_CONTROL);
   225		usleep_range(5000, 10000);
   226	
   227		/* Release device */
   228		mask = REG_PCI_CONTROL_PERSTOUT1 | REG_PCI_CONTROL_PERSTOUT;
   229		val = readl(np_base + REG_PCI_CONTROL);
   230		writel(val & ~mask, np_base + REG_PCI_CONTROL);
   231		usleep_range(1000, 2000);
   232		writel(val | mask, np_base + REG_PCI_CONTROL);
   233		msleep(250);
   234	
   235		return 0;
   236	}
   237	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

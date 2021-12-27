Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB4D47FC8A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 13:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbhL0MTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 07:19:21 -0500
Received: from mga03.intel.com ([134.134.136.65]:9481 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233695AbhL0MTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640607561; x=1672143561;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s6xouXcykijpveoTUGFNct2Khmd+c+dHLgqj9WkOB70=;
  b=Kyh3Yc3IZ/pJmba3GNuYyxusFFcDkzlGt0BILgAtjLIvwNsqLhSlsQ9C
   nAtf4OEkp9Mx8HFYsL2dJ7GeG1Oco6Laf35cPIZm6BvJXvnHt26CAZ+WZ
   miXFFUGk8/MSZDPUOYsRSuLZChsfv1ixrS316IUSFp5W39cs9hDieQu++
   rZeSnclZY9T6SiXpCfd7DYyTHVDdOhrVFpi554oo+1tSjFR1AtgigxYhT
   29yme6bqroS9Ayo+xPkVJlHv23Wtcly+UqTIdYcS0QdA2FWaAtCxcxlW5
   g0LZ3dYvx7KsPMIuWLYykWFoKphGT6u/2M3vCH1KUq6u8g2ZzwAhsSxPy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10209"; a="241154588"
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; 
   d="scan'208";a="241154588"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 04:19:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; 
   d="scan'208";a="553775938"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Dec 2021 04:19:19 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1oyE-0006GQ-S3; Mon, 27 Dec 2021 12:19:18 +0000
Date:   Mon, 27 Dec 2021 20:18:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_aia_v1 30/34]
 drivers/irqchip/irq-riscv-imsic.c:142:30: warning: variable 'global' set but
 not used
Message-ID: <202112272015.GBtofHiu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_aia_v1
head:   ab1dc4967c46d77179ef56870a5d556c61aa9b0c
commit: 595f7c41a6420b47ceb2abc4d603237f53711ca5 [30/34] irqchip: Add incoming MSI controller driver
config: riscv-randconfig-r001-20211227 (https://download.01.org/0day-ci/archive/20211227/202112272015.GBtofHiu-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 511726c64d3b6cca66f7c54d457d586aa3129f67)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/avpatel/linux/commit/595f7c41a6420b47ceb2abc4d603237f53711ca5
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_aia_v1
        git checkout 595f7c41a6420b47ceb2abc4d603237f53711ca5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/irqchip/irq-riscv-imsic.c:142:30: warning: variable 'global' set but not used [-Wunused-but-set-variable]
           struct imsic_global_config *global;
                                       ^
   drivers/irqchip/irq-riscv-imsic.c:138:22: warning: unused function 'imsic_cpu_page_virt' [-Wunused-function]
   static void __iomem *imsic_cpu_page_virt(unsigned int cpu,
                        ^
   2 warnings generated.


vim +/global +142 drivers/irqchip/irq-riscv-imsic.c

   137	
   138	static void __iomem *imsic_cpu_page_virt(unsigned int cpu,
   139						 unsigned int guest_index)
   140	{
   141		struct imsic_handler *handler = per_cpu_ptr(&imsic_handlers, cpu);
 > 142		struct imsic_global_config *global;
   143		struct imsic_local_config *local;
   144	
   145		if (!handler || !handler->priv)
   146			return NULL;
   147		local = &handler->local;
   148		global = &handler->priv->global;
   149	
   150		return local->msi_va + (guest_index * IMSIC_MMIO_PAGE_SZ);
   151	}
   152	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

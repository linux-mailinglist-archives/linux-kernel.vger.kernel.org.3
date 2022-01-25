Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC0049B740
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581373AbiAYPGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:06:53 -0500
Received: from mga07.intel.com ([134.134.136.100]:2991 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1390610AbiAYPE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643123067; x=1674659067;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=77+Wi8F45bo8EckcC/VFme4Jnzhhw648YNCPgpKM9dc=;
  b=MuFueC3WOfL2d5XNwMQGfouLLqj3GKtmt6GdQRP+GV49hQEufBsL0JOg
   vLwU8foe6s8lNH2aiTtVh0rA+eJOWl8Wv08wuVqoquRiFQDjw4RMPK0BC
   BxY+0a4JJECgUTNOS09vY8R8478O1N6TmwX2z4q/gIPNfGQwyxiSzBFB8
   mkiTwHyqtNwfHkFhb51+4fMKgptX0H12xQp/ncxHzhUqY93/uMvepQkKF
   fzwLLoy3CmMYKkRgZjWkNiPLp1Q3x9tFqXjktLXwetJZe80q7tfzbFYxE
   X6FkGWy6Fv0MFrkGAjVFPUFyGVXUyXwCKE/QivIKnIlDsf1C0zx1E4EYG
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="309634738"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="309634738"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 07:04:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="479519141"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Jan 2022 07:04:01 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCNMW-000K35-Eq; Tue, 25 Jan 2022 15:04:00 +0000
Date:   Tue, 25 Jan 2022 23:03:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Farzad Farshchi <farzadfr@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        kernel test robot <lkp@intel.com>
Subject: [esmil:visionfive 57/63] undefined reference to `memunmap'
Message-ID: <202201252211.WTa3c0wt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   fdbe623707a8f3f9b9d2cb3c4c240299a12b8302
commit: 1858f8a7f96cbdd6c84d58ef025852d3538c7f3b [57/63] nvdla: add NVDLA driver
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20220125/202201252211.WTa3c0wt-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/1858f8a7f96cbdd6c84d58ef025852d3538c7f3b
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 1858f8a7f96cbdd6c84d58ef025852d3538c7f3b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
   coherent.c:(.text+0x122): undefined reference to `memremap'
   s390-linux-ld: coherent.c:(.text+0x230): undefined reference to `memunmap'
   s390-linux-ld: kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
>> (.text+0x45c): undefined reference to `memunmap'
   s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
   irq-al-fic.c:(.init.text+0x7a): undefined reference to `of_iomap'
   s390-linux-ld: irq-al-fic.c:(.init.text+0x4f4): undefined reference to `iounmap'
   s390-linux-ld: drivers/clk/clk-fixed-mmio.o: in function `fixed_mmio_clk_setup':
   clk-fixed-mmio.c:(.text+0x90): undefined reference to `of_iomap'
   s390-linux-ld: clk-fixed-mmio.c:(.text+0xcc): undefined reference to `iounmap'
   s390-linux-ld: drivers/clk/clk-lan966x.o: in function `lan966x_clk_probe':
   clk-lan966x.c:(.text+0x5d4): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: clk-lan966x.c:(.text+0x748): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_init':
   timer-of.c:(.init.text+0x152): undefined reference to `of_iomap'
   s390-linux-ld: timer-of.c:(.init.text+0x77e): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_cleanup':
   timer-of.c:(.init.text+0x968): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-microchip-pit64b.o: in function `mchp_pit64b_dt_init_timer':
   timer-microchip-pit64b.c:(.init.text+0x6a6): undefined reference to `of_iomap'
   s390-linux-ld: timer-microchip-pit64b.c:(.init.text+0xd04): undefined reference to `iounmap'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

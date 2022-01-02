Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D9E482911
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 05:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiABEN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 23:13:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:1672 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbiABENZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 23:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641096805; x=1672632805;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IFW0CWLe1IN6itjqlDSBi2hPZV2tzKF4nYd2Uf0qm9w=;
  b=Y1ByRpH2LVtHxzZlZlKhqqxmo2zg+oJNyNse5UA/muk8q/1Iu5pCr6dP
   sQPKk8TX55XSm4wfc8xG17pjWhVJeGTn0tI9N5z9fO8KJskscBAhwgE4i
   ZJdoFuBBV08vt/3aCYa/pQL+mNqYtsQR+fUMEdf32UHb6T96jYanzd+NP
   i7EJbwxARyzQj3b6uChSuZzS1wGrbQ+TVGMbZEDR3nWAlnNn3iAblX6GQ
   /COuGQfBlVoAZBEd2fZACBnISNgox90pOjgPVjTwg3y532k/OpqN4anxb
   ak1XRPeJZhjVHFZKjp1Bfm5gOMe06gaUU7kHMlbvXRStqv1rBSnmyIcze
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="240763286"
X-IronPort-AV: E=Sophos;i="5.88,255,1635231600"; 
   d="scan'208";a="240763286"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2022 20:13:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,255,1635231600"; 
   d="scan'208";a="471280245"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 01 Jan 2022 20:13:23 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3sFH-000D40-5m; Sun, 02 Jan 2022 04:13:23 +0000
Date:   Sun, 2 Jan 2022 12:12:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: litex_liteeth.c:undefined reference to
 `devm_platform_ioremap_resource_byname'
Message-ID: <202201021231.crXSVMeM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cai,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   278218f6778bc7d6f8b67199446c56cec7ebb841
commit: 464a57281f29afc202905b456b0cb8bc729b383a net/mlxbf_gige: Make use of devm_platform_ioremap_resourcexxx()
date:   4 months ago
config: s390-randconfig-r005-20220101 (https://download.01.org/0day-ci/archive/20220102/202201021231.crXSVMeM-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=464a57281f29afc202905b456b0cb8bc729b383a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 464a57281f29afc202905b456b0cb8bc729b383a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
   coherent.c:(.text+0xb0): undefined reference to `memremap'
   s390-linux-ld: coherent.c:(.text+0x1d4): undefined reference to `memunmap'
   s390-linux-ld: kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
   coherent.c:(.text+0x68e): undefined reference to `memunmap'
   s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
   irq-al-fic.c:(.init.text+0x72): undefined reference to `of_iomap'
   s390-linux-ld: irq-al-fic.c:(.init.text+0x4b4): undefined reference to `iounmap'
   s390-linux-ld: drivers/dma/fsl-edma.o: in function `fsl_edma_probe':
   fsl-edma.c:(.text+0x119c): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: fsl-edma.c:(.text+0x12fe): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/idma64.o: in function `idma64_platform_probe':
   idma64.c:(.text+0x1c98): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/net/ethernet/altera/altera_tse_main.o: in function `request_and_map':
   altera_tse_main.c:(.text+0xde8): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/net/ethernet/litex/litex_liteeth.o: in function `liteeth_probe':
>> litex_liteeth.c:(.text+0x854): undefined reference to `devm_platform_ioremap_resource_byname'
>> s390-linux-ld: litex_liteeth.c:(.text+0x8ca): undefined reference to `devm_platform_ioremap_resource_byname'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

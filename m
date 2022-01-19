Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF4349357E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351658AbiASHbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:31:25 -0500
Received: from mga07.intel.com ([134.134.136.100]:52922 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242133AbiASHbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642577483; x=1674113483;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=inPQC+Kin2BkkrICkXSotI7BWW00tC+JnxcBKaC+xb8=;
  b=aKLZrbJCl93ehM2s57HIHN5vUGrObTqWAEb9TLVvYefxf+eqsndgT9GG
   VwqR7KZzlnqGwhVQS2g/qTDUtm/MmJenRctXF6pv4uCvrB3/hJzU+9mJW
   +0L8yoJmmxJcRao4KnJncEt8nEASbwoO3HVvx4NkkN2l1ng7Ljed+5TV7
   sCTwFPoR5YluyT3w6U6rN8BvQT3nT6afdT7npsoPBleeVSdue8HqNdV/s
   9gsVO1LhA23k3kfxdZdR910fCLteQQOm5FR0fmXkdxpHvZGG7QhXkI7kq
   yzOiE5NeKydmdvA7AWldvL4SaElKJA2DstvHwO4kUHKDx71ysXT/l298I
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="308347552"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="308347552"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 23:31:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="518072356"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 18 Jan 2022 23:31:21 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA5RB-000DNQ-8g; Wed, 19 Jan 2022 07:31:21 +0000
Date:   Wed, 19 Jan 2022 15:30:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 76/80] ERROR: modpost: "arch_setup_dma_ops"
 [drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.ko] undefined!
Message-ID: <202201191504.JricJykh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   e46c3a7e373e6faa03399f1a41c29cf7546c37cb
commit: 3a5dd7a266966a7d41fcc6335af9329664d901d0 [76/80] RISC-V: Support non-coherent DMA operations
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220119/202201191504.JricJykh-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/3a5dd7a266966a7d41fcc6335af9329664d901d0
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 3a5dd7a266966a7d41fcc6335af9329664d901d0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: missing MODULE_LICENSE() in drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.o
>> ERROR: modpost: "arch_setup_dma_ops" [drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

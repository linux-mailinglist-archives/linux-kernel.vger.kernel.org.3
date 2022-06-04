Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD4553D880
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 22:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240904AbiFDUY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 16:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbiFDUYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 16:24:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91814193D6
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 13:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654374294; x=1685910294;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E6UJoOZvmvrou7v8tYB87qxvd9Av5E0M3e5eb9n1WkI=;
  b=Kdg2QuYzhwU0tiotWEPWi0iCMHdE+tyl7c+BJVJA00BnmcUx5u4cy6OX
   bdatJvHU3I0uGRyW3v4n5oUIw7qtDim0GAGKGLXTz1GVbEtntBLXV4L8X
   0zduwiolTTC0TbTPoZmOQo/OjeTrodTkUaEBp+ko7HdhRqKPAav4sSO7x
   1grjGWltgLjUwQJx9mXpLAJjONBBh/ihXjdv56w2/Po/5hLTSDm+gzWIh
   RsFb4bR13OCijVZAcC8ahFDsgBi1doCMGC44X3wKqTIEFxYCkUq2A03OH
   MY8P/Re2LKx3N7brTpcRMsCaSdLDsGZ0+9+EHoQEH+uOwSmPWszd0E/VT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="256337528"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="256337528"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 13:24:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="708501789"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 Jun 2022 13:24:52 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxaKJ-000BBv-Qo;
        Sat, 04 Jun 2022 20:24:51 +0000
Date:   Sun, 5 Jun 2022 04:24:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 51/57] ERROR: modpost: "arch_setup_dma_ops"
 [drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.ko] undefined!
Message-ID: <202206050413.DJFBanVZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   3fabc8e79a0012b6b04a227e21eef1b9669b3714
commit: b996fedff267cdd89e73c0ed5c8743532e322238 [51/57] RISC-V: Support non-coherent DMA operations
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220605/202206050413.DJFBanVZ-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/b996fedff267cdd89e73c0ed5c8743532e322238
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout b996fedff267cdd89e73c0ed5c8743532e322238
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: missing MODULE_LICENSE() in drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.o
>> ERROR: modpost: "arch_setup_dma_ops" [drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

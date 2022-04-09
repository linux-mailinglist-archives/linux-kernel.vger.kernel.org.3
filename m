Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3474FA0D8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 02:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbiDIA6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 20:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiDIA56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 20:57:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A89E5FE2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 17:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649465753; x=1681001753;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V5cfWvp3WA7HQ89Pce+jIBMuCn8QW+MBcoax8kox/KE=;
  b=HmwdBxQ7/0HJDKF44dW1Df/LHs7HD9jmAJuuNLvh95uccwk9xCWkP+Xd
   WEWmtzMJ7pkYNYz0Mvdm2idKMliPCGANFW3dsqhShforH5g/xgWDi+nKk
   M4kTszIxqXEGiDvgoeb6vMbv75X0YTul3ZXed0efItZcVhWvutb1F5rm+
   MJOC1D1H9Lj0XasV/gO5t4BAjQJO3FgdjtfI2mhvsNGJ0n1m0dcggtz69
   INdbBJZNeq7N1FO8X9OB2nmQ2TVESQ806R0Hz89OhslQyaEdQO4x9cfe8
   tBM60lpTVrTrYyAF3u//iGgNk0NA9+RMuLoNrBvy6CUKfokZGYai0wrY2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="348173631"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="348173631"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 17:55:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="643132543"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Apr 2022 17:55:51 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nczOJ-0000ky-0L;
        Sat, 09 Apr 2022 00:55:51 +0000
Date:   Sat, 9 Apr 2022 08:55:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Zoran <mzoran@crowfest.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Dom Cobley <popcornmix@gmail.com>
Subject: [l1k:smsc95xx_5.17 83/887] drivers/irqchip/irq-bcm2836.c:92:6:
 warning: no previous prototype for function
 'bcm2836_arm_irqchip_spin_gpu_irq'
Message-ID: <202204090803.BYLpU9Vt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   05d68ced287b30f62f18f95b5476135ef669804a
commit: d9c90edc942c69dc18b6818f69ba36024d1446fa [83/887] ARM64: Round-Robin dispatch IRQs between CPUs.
config: arm64-randconfig-r006-20220408 (https://download.01.org/0day-ci/archive/20220409/202204090803.BYLpU9Vt-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c29a51b3a257908aebc01cd7c4655665db317d66)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/l1k/linux/commit/d9c90edc942c69dc18b6818f69ba36024d1446fa
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout d9c90edc942c69dc18b6818f69ba36024d1446fa
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/irqchip/irq-bcm2836.c:92:6: warning: no previous prototype for function 'bcm2836_arm_irqchip_spin_gpu_irq' [-Wmissing-prototypes]
   void bcm2836_arm_irqchip_spin_gpu_irq(void)
        ^
   drivers/irqchip/irq-bcm2836.c:92:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void bcm2836_arm_irqchip_spin_gpu_irq(void)
   ^
   static 
   1 warning generated.


vim +/bcm2836_arm_irqchip_spin_gpu_irq +92 drivers/irqchip/irq-bcm2836.c

    91	
  > 92	void bcm2836_arm_irqchip_spin_gpu_irq(void)
    93	{
    94		u32 i;
    95		void __iomem *gpurouting = (intc.base + LOCAL_GPU_ROUTING);
    96		u32 routing_val = readl(gpurouting);
    97	
    98		for (i = 1; i <= 3; i++) {
    99			u32 new_routing_val = (routing_val + i) & 3;
   100	
   101			if (cpu_active(new_routing_val)) {
   102				writel(new_routing_val, gpurouting);
   103				return;
   104			}
   105		}
   106	}
   107	EXPORT_SYMBOL(bcm2836_arm_irqchip_spin_gpu_irq);
   108	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

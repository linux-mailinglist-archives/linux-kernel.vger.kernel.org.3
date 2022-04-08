Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8612F4F9E8A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbiDHVD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239595AbiDHVD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:03:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BD5659E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 14:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649451711; x=1680987711;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l4NZ4R7wBHfajnCnxrZa1gH4v0k3KRCTBgPhSu39a3s=;
  b=NFEvjhctZDj5cpy7I5KBdsXWVXnsdsegWPG7SSPP4Z2oEKq0jCU1KPJa
   2U1HiBdg3IZzbJngmd54uZiesX3fPn173B56Edu54k09wZPjEcC8p6m5n
   YoRfMb3XRFLRkkDciAzXAuGoiV5WZ1hwnXQoZREC2KCp5H6W9aA2R9eCO
   S+yiWHDS/Uvg4GZyW+D1F4svTQR8wb+JtWybf6LYo1MG6+pZvcfH1Q0TB
   ufgNCQ+szhR7/mLUButjCQ7IRMSC+IFIlLm4GEqUXRIpAP/IkGPtKWvA+
   jPdGZHmzp0CUdXI0OoHKfp9lqMnqMZnhzUkPQY9chu5HMvobgt2fPyKN6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="243816114"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="243816114"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 14:01:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="852210744"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 08 Apr 2022 14:01:48 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncvjn-0000dd-OR;
        Fri, 08 Apr 2022 21:01:47 +0000
Date:   Sat, 9 Apr 2022 05:01:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Zoran <mzoran@crowfest.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dom Cobley <popcornmix@gmail.com>
Subject: [l1k:smsc95xx_5.17 83/888] drivers/irqchip/irq-bcm2836.c:92:6:
 warning: no previous prototype for 'bcm2836_arm_irqchip_spin_gpu_irq'
Message-ID: <202204090415.1tshazr8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   240f56c27361c195cd502d95aba51c6b8e5b808c
commit: d9c90edc942c69dc18b6818f69ba36024d1446fa [83/888] ARM64: Round-Robin dispatch IRQs between CPUs.
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220409/202204090415.1tshazr8-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/d9c90edc942c69dc18b6818f69ba36024d1446fa
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout d9c90edc942c69dc18b6818f69ba36024d1446fa
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/irqchip/irq-bcm2836.c:92:6: warning: no previous prototype for 'bcm2836_arm_irqchip_spin_gpu_irq' [-Wmissing-prototypes]
      92 | void bcm2836_arm_irqchip_spin_gpu_irq(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


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

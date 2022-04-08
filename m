Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2132C4F968A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbiDHNUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiDHNUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:20:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998DDC90E1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649423907; x=1680959907;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OlQ3mNetqWRw1aMb9LjUn6/UrLVxFJEr3k5naF0v43A=;
  b=NivKZjd0OgHl/B/+bRHpQRAff+E6Kk0r3PyNtxulUiN+lm6QUa47bhgc
   c1UXQUi1o5ER+4GNolPt2+OF2QpJw1VhYG5XRO2sKo0kn3OtNqpCFxs8Q
   ievI/f2LmDQxQCLXn96pKO2u3YcUhseRTnbfI1yh5pDqzuKu1cRD8bDZ/
   yuI0xqjEaZQjNNamlFpP3MWrKIxb4Drfla9UBhiH7wDO5DMT7HGDCzJCe
   0vvxGZwyiFq/M41krvUqY7irNk95XGtg38iA9jtn+kPfkBJh2kppy6LNj
   Y99QxGbk4itjni5bC0LR9h3ZX3Ec9arJv8WFesH7PJiIXIH7w7Kf7vJaY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="259188300"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="259188300"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 06:18:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="723384474"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 08 Apr 2022 06:18:25 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncoVM-0000Hf-Vi;
        Fri, 08 Apr 2022 13:18:25 +0000
Date:   Fri, 8 Apr 2022 21:17:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Phil Elwell <phil@raspberrypi.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dom Cobley <popcornmix@gmail.com>
Subject: [l1k:smsc95xx_5.17 209/887] drivers/dma/bcm2835-dma.c:1104:5:
 warning: no previous prototype for 'bcm2711_dma40_memcpy_init'
Message-ID: <202204082125.AHZubaGl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   05d68ced287b30f62f18f95b5476135ef669804a
commit: 92eab2543e8b86cf7660e0cc70d5aee4313cbe58 [209/887] bcm2835-dma: Add proper 40-bit DMA support
config: arm-multi_v7_defconfig (https://download.01.org/0day-ci/archive/20220408/202204082125.AHZubaGl-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/92eab2543e8b86cf7660e0cc70d5aee4313cbe58
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout 92eab2543e8b86cf7660e0cc70d5aee4313cbe58
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/dma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/dma/bcm2835-dma.c:1104:5: warning: no previous prototype for 'bcm2711_dma40_memcpy_init' [-Wmissing-prototypes]
    1104 | int bcm2711_dma40_memcpy_init(void)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/dma/bcm2835-dma.c:1119:6: warning: no previous prototype for 'bcm2711_dma40_memcpy' [-Wmissing-prototypes]
    1119 | void bcm2711_dma40_memcpy(dma_addr_t dst, dma_addr_t src, size_t size)
         |      ^~~~~~~~~~~~~~~~~~~~


vim +/bcm2711_dma40_memcpy_init +1104 drivers/dma/bcm2835-dma.c

  1103	
> 1104	int bcm2711_dma40_memcpy_init(void)
  1105	{
  1106		if (!memcpy_parent)
  1107			return -EPROBE_DEFER;
  1108	
  1109		if (!memcpy_chan)
  1110			return -EINVAL;
  1111	
  1112		if (!memcpy_scb)
  1113			return -ENOMEM;
  1114	
  1115		return 0;
  1116	}
  1117	EXPORT_SYMBOL(bcm2711_dma40_memcpy_init);
  1118	
> 1119	void bcm2711_dma40_memcpy(dma_addr_t dst, dma_addr_t src, size_t size)
  1120	{
  1121		struct bcm2711_dma40_scb *scb = memcpy_scb;
  1122		unsigned long flags;
  1123	
  1124		if (!scb) {
  1125			pr_err("bcm2711_dma40_memcpy not initialised!\n");
  1126			return;
  1127		}
  1128	
  1129		spin_lock_irqsave(&memcpy_lock, flags);
  1130	
  1131		scb->ti = 0;
  1132		scb->src = lower_32_bits(src);
  1133		scb->srci = upper_32_bits(src) | BCM2711_DMA40_MEMCPY_XFER_INFO;
  1134		scb->dst = lower_32_bits(dst);
  1135		scb->dsti = upper_32_bits(dst) | BCM2711_DMA40_MEMCPY_XFER_INFO;
  1136		scb->len = size;
  1137		scb->next_cb = 0;
  1138	
  1139		writel((u32)(memcpy_scb_dma >> 5), memcpy_chan + BCM2711_DMA40_CB);
  1140		writel(BCM2711_DMA40_MEMCPY_FLAGS + BCM2711_DMA40_ACTIVE,
  1141		       memcpy_chan + BCM2711_DMA40_CS);
  1142	
  1143		/* Poll for completion */
  1144		while (!(readl(memcpy_chan + BCM2711_DMA40_CS) & BCM2711_DMA40_END))
  1145			cpu_relax();
  1146	
  1147		writel(BCM2711_DMA40_END, memcpy_chan + BCM2711_DMA40_CS);
  1148	
  1149		spin_unlock_irqrestore(&memcpy_lock, flags);
  1150	}
  1151	EXPORT_SYMBOL(bcm2711_dma40_memcpy);
  1152	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

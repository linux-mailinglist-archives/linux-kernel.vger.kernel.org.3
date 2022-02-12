Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AAE4B3376
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 07:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiBLG3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 01:29:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiBLG3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 01:29:34 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C3A27174
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 22:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644647370; x=1676183370;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=blf8o2KlRVJclDAnFzD0zXYrMOhUW25lGwTnDuOyyUQ=;
  b=HXM/jTc8ikJF/F7uPhYj0zU70cG+RwyYVziCo/fKD5ZQ1zJgnFOCO2rY
   X5oqb43x41r1ZvrxVWyABS93zFD2g8yFYt2DwqOBCuBiUPvYR/KSQsByp
   XJJZuIn4TXYfzc6HS1GvJudogQaRA5ZUjyp2fA5nAG4zORbhMSEZt/pKq
   lzSgxlg+YfLml9uIautLTr1reHQhnIivSRc+g5walEuppGuZZGHxgQ24z
   Zn8T9vcNuJce8wC4HROykQnVYSZdaouTpF2utS+GesSyaVz36sS2dF2NA
   7W8OQrNAjT32xky5bET2vq8BWCDxZ1NcbKQFC5fvJK4qh6XX6D7jHsOo7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="233411285"
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="233411285"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 22:29:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="490057624"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 11 Feb 2022 22:29:28 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIluR-0005k5-CS; Sat, 12 Feb 2022 06:29:27 +0000
Date:   Sat, 12 Feb 2022 14:28:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [nbd168-wireless:mtk-flow-offload 3/9]
 drivers/net/ethernet/mediatek/mtk_wed.h:33:25: error: 'struct
 mtk_wed_device' has no member named 'hw'
Message-ID: <202202121413.Jh9na3TD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/nbd168/wireless mtk-flow-offload
head:   1ba2137278dd5c4747b6e43be7aae4e94fb9c76e
commit: b3eab9db70af66f3ce1415f2e51750b15df268c9 [3/9] net: ethernet: mtk_eth_soc: add support for Wireless Ethernet Dispatch (WED)
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220212/202202121413.Jh9na3TD-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/nbd168/wireless/commit/b3eab9db70af66f3ce1415f2e51750b15df268c9
        git remote add nbd168-wireless https://github.com/nbd168/wireless
        git fetch --no-tags nbd168-wireless mtk-flow-offload
        git checkout b3eab9db70af66f3ce1415f2e51750b15df268c9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/net/ethernet/mediatek/ drivers/net/wireless/mediatek/mt76/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/mediatek/mtk_eth_soc.c:27:
   drivers/net/ethernet/mediatek/mtk_wed.h: In function 'wed_w32':
>> drivers/net/ethernet/mediatek/mtk_wed.h:33:25: error: 'struct mtk_wed_device' has no member named 'hw'
      33 |         regmap_write(dev->hw->regs, reg, val);
         |                         ^~
   drivers/net/ethernet/mediatek/mtk_wed.h: In function 'wed_r32':
   drivers/net/ethernet/mediatek/mtk_wed.h:41:24: error: 'struct mtk_wed_device' has no member named 'hw'
      41 |         regmap_read(dev->hw->regs, reg, &val);
         |                        ^~
   drivers/net/ethernet/mediatek/mtk_wed.h: In function 'wdma_w32':
   drivers/net/ethernet/mediatek/mtk_wed.h:49:24: error: 'struct mtk_wed_device' has no member named 'hw'
      49 |         writel(val, dev->hw->wdma + reg);
         |                        ^~
   drivers/net/ethernet/mediatek/mtk_wed.h: In function 'wdma_r32':
   drivers/net/ethernet/mediatek/mtk_wed.h:55:25: error: 'struct mtk_wed_device' has no member named 'hw'
      55 |         return readl(dev->hw->wdma + reg);
         |                         ^~
   drivers/net/ethernet/mediatek/mtk_wed.h: In function 'wpdma_tx_r32':
>> drivers/net/ethernet/mediatek/mtk_wed.h:61:17: error: 'struct mtk_wed_device' has no member named 'tx_ring'
      61 |         if (!dev->tx_ring[ring].wpdma)
         |                 ^~
   drivers/net/ethernet/mediatek/mtk_wed.h:64:25: error: 'struct mtk_wed_device' has no member named 'tx_ring'
      64 |         return readl(dev->tx_ring[ring].wpdma + reg);
         |                         ^~
>> drivers/net/ethernet/mediatek/mtk_wed.h:59:46: warning: parameter 'ring' set but not used [-Wunused-but-set-parameter]
      59 | wpdma_tx_r32(struct mtk_wed_device *dev, int ring, u32 reg)
         |                                          ~~~~^~~~
   drivers/net/ethernet/mediatek/mtk_wed.h: In function 'wpdma_tx_w32':
   drivers/net/ethernet/mediatek/mtk_wed.h:70:17: error: 'struct mtk_wed_device' has no member named 'tx_ring'
      70 |         if (!dev->tx_ring[ring].wpdma)
         |                 ^~
   drivers/net/ethernet/mediatek/mtk_wed.h:73:24: error: 'struct mtk_wed_device' has no member named 'tx_ring'
      73 |         writel(val, dev->tx_ring[ring].wpdma + reg);
         |                        ^~
   drivers/net/ethernet/mediatek/mtk_wed.h:68:46: warning: parameter 'ring' set but not used [-Wunused-but-set-parameter]
      68 | wpdma_tx_w32(struct mtk_wed_device *dev, int ring, u32 reg, u32 val)
         |                                          ~~~~^~~~
   drivers/net/ethernet/mediatek/mtk_wed.h: In function 'wpdma_txfree_r32':
>> drivers/net/ethernet/mediatek/mtk_wed.h:79:17: error: 'struct mtk_wed_device' has no member named 'txfree_ring'
      79 |         if (!dev->txfree_ring.wpdma)
         |                 ^~
   drivers/net/ethernet/mediatek/mtk_wed.h:82:25: error: 'struct mtk_wed_device' has no member named 'txfree_ring'
      82 |         return readl(dev->txfree_ring.wpdma + reg);
         |                         ^~
   drivers/net/ethernet/mediatek/mtk_wed.h: In function 'wpdma_txfree_w32':
   drivers/net/ethernet/mediatek/mtk_wed.h:88:17: error: 'struct mtk_wed_device' has no member named 'txfree_ring'
      88 |         if (!dev->txfree_ring.wpdma)
         |                 ^~
   drivers/net/ethernet/mediatek/mtk_wed.h:91:24: error: 'struct mtk_wed_device' has no member named 'txfree_ring'
      91 |         writel(val, dev->txfree_ring.wpdma + reg);
         |                        ^~
--
   In file included from drivers/net/ethernet/mediatek/mtk_wed.c:17:
   drivers/net/ethernet/mediatek/mtk_wed.h: In function 'wed_w32':
>> drivers/net/ethernet/mediatek/mtk_wed.h:33:25: error: 'struct mtk_wed_device' has no member named 'hw'
      33 |         regmap_write(dev->hw->regs, reg, val);
         |                         ^~
   drivers/net/ethernet/mediatek/mtk_wed.h: In function 'wed_r32':
   drivers/net/ethernet/mediatek/mtk_wed.h:41:24: error: 'struct mtk_wed_device' has no member named 'hw'
      41 |         regmap_read(dev->hw->regs, reg, &val);
         |                        ^~
   drivers/net/ethernet/mediatek/mtk_wed.h: In function 'wdma_w32':
   drivers/net/ethernet/mediatek/mtk_wed.h:49:24: error: 'struct mtk_wed_device' has no member named 'hw'
      49 |         writel(val, dev->hw->wdma + reg);
         |                        ^~
   drivers/net/ethernet/mediatek/mtk_wed.h: In function 'wdma_r32':
   drivers/net/ethernet/mediatek/mtk_wed.h:55:25: error: 'struct mtk_wed_device' has no member named 'hw'
      55 |         return readl(dev->hw->wdma + reg);
         |                         ^~
   drivers/net/ethernet/mediatek/mtk_wed.h: In function 'wpdma_tx_r32':
>> drivers/net/ethernet/mediatek/mtk_wed.h:61:17: error: 'struct mtk_wed_device' has no member named 'tx_ring'
      61 |         if (!dev->tx_ring[ring].wpdma)
         |                 ^~
   drivers/net/ethernet/mediatek/mtk_wed.h:64:25: error: 'struct mtk_wed_device' has no member named 'tx_ring'
      64 |         return readl(dev->tx_ring[ring].wpdma + reg);
         |                         ^~
>> drivers/net/ethernet/mediatek/mtk_wed.h:59:46: warning: parameter 'ring' set but not used [-Wunused-but-set-parameter]
      59 | wpdma_tx_r32(struct mtk_wed_device *dev, int ring, u32 reg)
         |                                          ~~~~^~~~
   drivers/net/ethernet/mediatek/mtk_wed.h: In function 'wpdma_tx_w32':
   drivers/net/ethernet/mediatek/mtk_wed.h:70:17: error: 'struct mtk_wed_device' has no member named 'tx_ring'
      70 |         if (!dev->tx_ring[ring].wpdma)
         |                 ^~
   drivers/net/ethernet/mediatek/mtk_wed.h:73:24: error: 'struct mtk_wed_device' has no member named 'tx_ring'
      73 |         writel(val, dev->tx_ring[ring].wpdma + reg);
         |                        ^~
   drivers/net/ethernet/mediatek/mtk_wed.h:68:46: warning: parameter 'ring' set but not used [-Wunused-but-set-parameter]
      68 | wpdma_tx_w32(struct mtk_wed_device *dev, int ring, u32 reg, u32 val)
         |                                          ~~~~^~~~
   drivers/net/ethernet/mediatek/mtk_wed.h: In function 'wpdma_txfree_r32':
>> drivers/net/ethernet/mediatek/mtk_wed.h:79:17: error: 'struct mtk_wed_device' has no member named 'txfree_ring'
      79 |         if (!dev->txfree_ring.wpdma)
         |                 ^~
   drivers/net/ethernet/mediatek/mtk_wed.h:82:25: error: 'struct mtk_wed_device' has no member named 'txfree_ring'
      82 |         return readl(dev->txfree_ring.wpdma + reg);
         |                         ^~
   drivers/net/ethernet/mediatek/mtk_wed.h: In function 'wpdma_txfree_w32':
   drivers/net/ethernet/mediatek/mtk_wed.h:88:17: error: 'struct mtk_wed_device' has no member named 'txfree_ring'
      88 |         if (!dev->txfree_ring.wpdma)
         |                 ^~
   drivers/net/ethernet/mediatek/mtk_wed.h:91:24: error: 'struct mtk_wed_device' has no member named 'txfree_ring'
      91 |         writel(val, dev->txfree_ring.wpdma + reg);
         |                        ^~
   drivers/net/ethernet/mediatek/mtk_wed.c: In function 'wed_m32':
>> drivers/net/ethernet/mediatek/mtk_wed.c:35:31: error: 'struct mtk_wed_device' has no member named 'hw'
      35 |         regmap_update_bits(dev->hw->regs, reg, mask | val, val);
         |                               ^~
   drivers/net/ethernet/mediatek/mtk_wed.c: In function 'mtk_wed_assign':
>> drivers/net/ethernet/mediatek/mtk_wed.c:84:39: error: 'struct mtk_wed_device' has no member named 'wlan'
      84 |         hw = hw_list[pci_domain_nr(dev->wlan.pci_dev->bus)];
         |                                       ^~
   drivers/net/ethernet/mediatek/mtk_wed.c: In function 'mtk_wed_buffer_alloc':
   drivers/net/ethernet/mediatek/mtk_wed.c:98:24: error: 'struct mtk_wed_device' has no member named 'wlan'
      98 |         int token = dev->wlan.token_start;
         |                        ^~
   drivers/net/ethernet/mediatek/mtk_wed.c:103:24: error: 'struct mtk_wed_device' has no member named 'wlan'
     103 |         ring_size = dev->wlan.nbuf & ~(MTK_WED_BUF_PER_PAGE - 1);
         |                        ^~
>> drivers/net/ethernet/mediatek/mtk_wed.c:110:12: error: 'struct mtk_wed_device' has no member named 'buf_ring'
     110 |         dev->buf_ring.size = ring_size;
         |            ^~
   drivers/net/ethernet/mediatek/mtk_wed.c:111:12: error: 'struct mtk_wed_device' has no member named 'buf_ring'
     111 |         dev->buf_ring.pages = page_list;
         |            ^~
   drivers/net/ethernet/mediatek/mtk_wed.c:113:38: error: 'struct mtk_wed_device' has no member named 'hw'
     113 |         desc = dma_alloc_coherent(dev->hw->dev, ring_size * sizeof(*desc),
         |                                      ^~
   drivers/net/ethernet/mediatek/mtk_wed.c:118:12: error: 'struct mtk_wed_device' has no member named 'buf_ring'
     118 |         dev->buf_ring.desc = desc;
         |            ^~
   drivers/net/ethernet/mediatek/mtk_wed.c:119:12: error: 'struct mtk_wed_device' has no member named 'buf_ring'
     119 |         dev->buf_ring.desc_phys = desc_phys;
         |            ^~
   In file included from drivers/net/ethernet/mediatek/mtk_wed.c:8:
   drivers/net/ethernet/mediatek/mtk_wed.c:131:45: error: 'struct mtk_wed_device' has no member named 'hw'
     131 |                 page_phys = dma_map_page(dev->hw->dev, page, 0, PAGE_SIZE,
         |                                             ^~
   include/linux/dma-mapping.h:410:56: note: in definition of macro 'dma_map_page'
     410 | #define dma_map_page(d, p, o, s, r) dma_map_page_attrs(d, p, o, s, r, 0)
         |                                                        ^
   drivers/net/ethernet/mediatek/mtk_wed.c:133:42: error: 'struct mtk_wed_device' has no member named 'hw'
     133 |                 if (dma_mapping_error(dev->hw->dev, page_phys)) {
         |                                          ^~
   drivers/net/ethernet/mediatek/mtk_wed.c:139:44: error: 'struct mtk_wed_device' has no member named 'hw'
     139 |                 dma_sync_single_for_cpu(dev->hw->dev, page_phys, PAGE_SIZE,
         |                                            ^~
   drivers/net/ethernet/mediatek/mtk_wed.c:148:39: error: 'struct mtk_wed_device' has no member named 'wlan'
     148 |                         txd_size = dev->wlan.init_buf(buf, buf_phys, token++);
         |                                       ^~
   drivers/net/ethernet/mediatek/mtk_wed.c:164:47: error: 'struct mtk_wed_device' has no member named 'hw'
     164 |                 dma_sync_single_for_device(dev->hw->dev, page_phys, PAGE_SIZE,
         |                                               ^~
   drivers/net/ethernet/mediatek/mtk_wed.c: In function 'mtk_wed_free_buffer':
   drivers/net/ethernet/mediatek/mtk_wed.c:174:41: error: 'struct mtk_wed_device' has no member named 'buf_ring'
     174 |         struct mtk_wdma_desc *desc = dev->buf_ring.desc;
         |                                         ^~
   drivers/net/ethernet/mediatek/mtk_wed.c:175:31: error: 'struct mtk_wed_device' has no member named 'buf_ring'
     175 |         void **page_list = dev->buf_ring.pages;
         |                               ^~
   drivers/net/ethernet/mediatek/mtk_wed.c:185:42: error: 'struct mtk_wed_device' has no member named 'buf_ring'
     185 |         for (i = 0, page_idx = 0; i < dev->buf_ring.size; i += MTK_WED_BUF_PER_PAGE) {
         |                                          ^~
   In file included from drivers/net/ethernet/mediatek/mtk_wed.c:8:
   drivers/net/ethernet/mediatek/mtk_wed.c:191:35: error: 'struct mtk_wed_device' has no member named 'hw'
     191 |                 dma_unmap_page(dev->hw->dev, desc[i].buf0,
         |                                   ^~
   include/linux/dma-mapping.h:411:57: note: in definition of macro 'dma_unmap_page'
     411 | #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
         |                                                         ^
   drivers/net/ethernet/mediatek/mtk_wed.c:196:30: error: 'struct mtk_wed_device' has no member named 'hw'
     196 |         dma_free_coherent(dev->hw->dev, dev->buf_ring.size * sizeof(*desc),
         |                              ^~
   drivers/net/ethernet/mediatek/mtk_wed.c:196:44: error: 'struct mtk_wed_device' has no member named 'buf_ring'
     196 |         dma_free_coherent(dev->hw->dev, dev->buf_ring.size * sizeof(*desc),
         |                                            ^~
   drivers/net/ethernet/mediatek/mtk_wed.c:197:36: error: 'struct mtk_wed_device' has no member named 'buf_ring'
     197 |                           desc, dev->buf_ring.desc_phys);
         |                                    ^~
   drivers/net/ethernet/mediatek/mtk_wed.c: In function 'mtk_wed_free_ring':
   drivers/net/ethernet/mediatek/mtk_wed.c:209:30: error: 'struct mtk_wed_device' has no member named 'hw'
     209 |         dma_free_coherent(dev->hw->dev, ring->size * sizeof(*ring->desc),
         |                              ^~
   In file included from drivers/net/ethernet/mediatek/mtk_wed.c:4:
   drivers/net/ethernet/mediatek/mtk_wed.c: In function 'mtk_wed_free_tx_rings':
>> drivers/net/ethernet/mediatek/mtk_wed.c:218:39: error: 'struct mtk_wed_device' has no member named 'tx_ring'
     218 |         for (i = 0; i < ARRAY_SIZE(dev->tx_ring); i++)
         |                                       ^~
   include/linux/kernel.h:55:33: note: in definition of macro 'ARRAY_SIZE'
      55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                 ^~~
>> drivers/net/ethernet/mediatek/mtk_wed.c:218:39: error: 'struct mtk_wed_device' has no member named 'tx_ring'
     218 |         for (i = 0; i < ARRAY_SIZE(dev->tx_ring); i++)
         |                                       ^~
   include/linux/kernel.h:55:48: note: in definition of macro 'ARRAY_SIZE'
      55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                ^~~
   In file included from include/linux/container_of.h:5,
                    from include/linux/kernel.h:21,
                    from drivers/net/ethernet/mediatek/mtk_wed.c:4:
>> drivers/net/ethernet/mediatek/mtk_wed.c:218:39: error: 'struct mtk_wed_device' has no member named 'tx_ring'
     218 |         for (i = 0; i < ARRAY_SIZE(dev->tx_ring); i++)
         |                                       ^~
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/compiler.h:258:51: note: in expansion of macro '__same_type'
     258 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                                   ^~~~~~~~~~~
   include/linux/kernel.h:55:59: note: in expansion of macro '__must_be_array'
      55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   drivers/net/ethernet/mediatek/mtk_wed.c:218:25: note: in expansion of macro 'ARRAY_SIZE'
     218 |         for (i = 0; i < ARRAY_SIZE(dev->tx_ring); i++)
         |                         ^~~~~~~~~~
>> drivers/net/ethernet/mediatek/mtk_wed.c:218:39: error: 'struct mtk_wed_device' has no member named 'tx_ring'
     218 |         for (i = 0; i < ARRAY_SIZE(dev->tx_ring); i++)
         |                                       ^~
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/compiler.h:258:51: note: in expansion of macro '__same_type'
     258 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                                   ^~~~~~~~~~~
   include/linux/kernel.h:55:59: note: in expansion of macro '__must_be_array'
      55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   drivers/net/ethernet/mediatek/mtk_wed.c:218:25: note: in expansion of macro 'ARRAY_SIZE'
     218 |         for (i = 0; i < ARRAY_SIZE(dev->tx_ring); i++)
         |                         ^~~~~~~~~~
>> include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/compiler.h:258:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     258 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:55:59: note: in expansion of macro '__must_be_array'
      55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   drivers/net/ethernet/mediatek/mtk_wed.c:218:25: note: in expansion of macro 'ARRAY_SIZE'
     218 |         for (i = 0; i < ARRAY_SIZE(dev->tx_ring); i++)
         |                         ^~~~~~~~~~
   drivers/net/ethernet/mediatek/mtk_wed.c:219:44: error: 'struct mtk_wed_device' has no member named 'tx_ring'
     219 |                 mtk_wed_free_ring(dev, &dev->tx_ring[i]);
         |                                            ^~
   In file included from drivers/net/ethernet/mediatek/mtk_wed.c:4:
>> drivers/net/ethernet/mediatek/mtk_wed.c:220:39: error: 'struct mtk_wed_device' has no member named 'tx_wdma'
     220 |         for (i = 0; i < ARRAY_SIZE(dev->tx_wdma); i++)
         |                                       ^~
   include/linux/kernel.h:55:33: note: in definition of macro 'ARRAY_SIZE'
      55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                 ^~~
>> drivers/net/ethernet/mediatek/mtk_wed.c:220:39: error: 'struct mtk_wed_device' has no member named 'tx_wdma'
     220 |         for (i = 0; i < ARRAY_SIZE(dev->tx_wdma); i++)
         |                                       ^~
   include/linux/kernel.h:55:48: note: in definition of macro 'ARRAY_SIZE'
      55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                ^~~
   In file included from include/linux/container_of.h:5,
                    from include/linux/kernel.h:21,
                    from drivers/net/ethernet/mediatek/mtk_wed.c:4:
>> drivers/net/ethernet/mediatek/mtk_wed.c:220:39: error: 'struct mtk_wed_device' has no member named 'tx_wdma'
     220 |         for (i = 0; i < ARRAY_SIZE(dev->tx_wdma); i++)
         |                                       ^~
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/compiler.h:258:51: note: in expansion of macro '__same_type'
     258 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                                   ^~~~~~~~~~~
   include/linux/kernel.h:55:59: note: in expansion of macro '__must_be_array'
      55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   drivers/net/ethernet/mediatek/mtk_wed.c:220:25: note: in expansion of macro 'ARRAY_SIZE'
     220 |         for (i = 0; i < ARRAY_SIZE(dev->tx_wdma); i++)
         |                         ^~~~~~~~~~
>> drivers/net/ethernet/mediatek/mtk_wed.c:220:39: error: 'struct mtk_wed_device' has no member named 'tx_wdma'
     220 |         for (i = 0; i < ARRAY_SIZE(dev->tx_wdma); i++)
         |                                       ^~
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/compiler.h:258:51: note: in expansion of macro '__same_type'
     258 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                                   ^~~~~~~~~~~
   include/linux/kernel.h:55:59: note: in expansion of macro '__must_be_array'
      55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   drivers/net/ethernet/mediatek/mtk_wed.c:220:25: note: in expansion of macro 'ARRAY_SIZE'
     220 |         for (i = 0; i < ARRAY_SIZE(dev->tx_wdma); i++)
         |                         ^~~~~~~~~~
>> include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/compiler.h:258:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     258 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:55:59: note: in expansion of macro '__must_be_array'
      55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   drivers/net/ethernet/mediatek/mtk_wed.c:220:25: note: in expansion of macro 'ARRAY_SIZE'
     220 |         for (i = 0; i < ARRAY_SIZE(dev->tx_wdma); i++)
         |                         ^~~~~~~~~~
   drivers/net/ethernet/mediatek/mtk_wed.c:221:44: error: 'struct mtk_wed_device' has no member named 'tx_wdma'
     221 |                 mtk_wed_free_ring(dev, &dev->tx_wdma[i]);
         |                                            ^~
   drivers/net/ethernet/mediatek/mtk_wed.c: In function 'mtk_wed_stop':
   drivers/net/ethernet/mediatek/mtk_wed.c:235:25: error: 'struct mtk_wed_device' has no member named 'hw'
     235 |         regmap_write(dev->hw->mirror, dev->hw->index * 4, 0);
         |                         ^~
   drivers/net/ethernet/mediatek/mtk_wed.c:235:42: error: 'struct mtk_wed_device' has no member named 'hw'
     235 |         regmap_write(dev->hw->mirror, dev->hw->index * 4, 0);
         |                                          ^~
   drivers/net/ethernet/mediatek/mtk_wed.c: In function 'mtk_wed_detach':
   drivers/net/ethernet/mediatek/mtk_wed.c:262:44: error: 'struct mtk_wed_device' has no member named 'wlan'
     262 |         struct device_node *wlan_node = dev->wlan.pci_dev->dev.of_node;
         |                                            ^~
   drivers/net/ethernet/mediatek/mtk_wed.c:263:36: error: 'struct mtk_wed_device' has no member named 'hw'
     263 |         struct mtk_wed_hw *hw = dev->hw;
         |                                    ^~
   drivers/net/ethernet/mediatek/mtk_wed.c: In function 'mtk_wed_hw_init_early':
   drivers/net/ethernet/mediatek/mtk_wed.c:311:21: error: 'struct mtk_wed_device' has no member named 'hw'
     311 |         offset = dev->hw->index ? 0x04000400 : 0;
         |                     ^~
   drivers/net/ethernet/mediatek/mtk_wed.c:315:62: error: 'struct mtk_wed_device' has no member named 'hw'
     315 |         wed_w32(dev, MTK_WED_PCIE_CFG_BASE, MTK_PCIE_BASE(dev->hw->index));
         |                                                              ^~
   drivers/net/ethernet/mediatek/mtk_wed.c:20:56: note: in definition of macro 'MTK_PCIE_BASE'
      20 | #define MTK_PCIE_BASE(n)                (0x1a143000 + (n) * 0x2000)
         |                                                        ^
   drivers/net/ethernet/mediatek/mtk_wed.c:316:49: error: 'struct mtk_wed_device' has no member named 'wlan'
     316 |         wed_w32(dev, MTK_WED_WPDMA_CFG_BASE, dev->wlan.wpdma_phys);
         |                                                 ^~
   drivers/net/ethernet/mediatek/mtk_wed.c: In function 'mtk_wed_hw_init':
>> drivers/net/ethernet/mediatek/mtk_wed.c:322:16: error: 'struct mtk_wed_device' has no member named 'init_done'
     322 |         if (dev->init_done)
         |                ^~
   drivers/net/ethernet/mediatek/mtk_wed.c:325:12: error: 'struct mtk_wed_device' has no member named 'init_done'
     325 |         dev->init_done = true;
         |            ^~
   In file included from <command-line>:
   drivers/net/ethernet/mediatek/mtk_wed.c:330:31: error: 'struct mtk_wed_device' has no member named 'buf_ring'
     330 |                            dev->buf_ring.size / 128) |
         |                               ^~
   include/linux/compiler_types.h:329:23: note: in definition of macro '__compiletime_assert'
     329 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:349:9: note: in expansion of macro '_compiletime_assert'
     349 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:111:17: note: in expansion of macro '__BF_FIELD_CHECK'
     111 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/mediatek/mtk_wed.c:329:17: note: in expansion of macro 'FIELD_PREP'
     329 |                 FIELD_PREP(MTK_WED_TX_BM_CTRL_VLD_GRP_NUM,
         |                 ^~~~~~~~~~
   drivers/net/ethernet/mediatek/mtk_wed.c:330:31: error: 'struct mtk_wed_device' has no member named 'buf_ring'
     330 |                            dev->buf_ring.size / 128) |
         |                               ^~
   include/linux/compiler_types.h:329:23: note: in definition of macro '__compiletime_assert'
     329 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:349:9: note: in expansion of macro '_compiletime_assert'
     349 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:111:17: note: in expansion of macro '__BF_FIELD_CHECK'
     111 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/mediatek/mtk_wed.c:329:17: note: in expansion of macro 'FIELD_PREP'
     329 |                 FIELD_PREP(MTK_WED_TX_BM_CTRL_VLD_GRP_NUM,
         |                 ^~~~~~~~~~
   In file included from arch/mips/include/asm/mips-cps.h:10,
                    from arch/mips/include/asm/smp-ops.h:16,
                    from arch/mips/include/asm/smp.h:21,
                    from include/linux/smp.h:113,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from drivers/net/ethernet/mediatek/mtk_wed.c:5:
   drivers/net/ethernet/mediatek/mtk_wed.c:330:31: error: 'struct mtk_wed_device' has no member named 'buf_ring'
     330 |                            dev->buf_ring.size / 128) |
         |                               ^~
   include/linux/bitfield.h:112:34: note: in definition of macro 'FIELD_PREP'
     112 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         |                                  ^~~~
   drivers/net/ethernet/mediatek/mtk_wed.c:334:45: error: 'struct mtk_wed_device' has no member named 'buf_ring'
     334 |         wed_w32(dev, MTK_WED_TX_BM_BASE, dev->buf_ring.desc_phys);
         |                                             ^~
   In file included from <command-line>:
   drivers/net/ethernet/mediatek/mtk_wed.c:338:31: error: 'struct mtk_wed_device' has no member named 'wlan'
     338 |                            dev->wlan.token_start) |
         |                               ^~
   include/linux/compiler_types.h:329:23: note: in definition of macro '__compiletime_assert'
     329 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:349:9: note: in expansion of macro '_compiletime_assert'
     349 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:111:17: note: in expansion of macro '__BF_FIELD_CHECK'
     111 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/mediatek/mtk_wed.c:337:17: note: in expansion of macro 'FIELD_PREP'
     337 |                 FIELD_PREP(MTK_WED_TX_BM_TKID_START,
         |                 ^~~~~~~~~~
   drivers/net/ethernet/mediatek/mtk_wed.c:338:31: error: 'struct mtk_wed_device' has no member named 'wlan'
     338 |                            dev->wlan.token_start) |
         |                               ^~
   include/linux/compiler_types.h:329:23: note: in definition of macro '__compiletime_assert'
     329 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:349:9: note: in expansion of macro '_compiletime_assert'
     349 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
..


vim +33 drivers/net/ethernet/mediatek/mtk_wed.h

    29	
    30	static inline void
    31	wed_w32(struct mtk_wed_device *dev, u32 reg, u32 val)
    32	{
  > 33		regmap_write(dev->hw->regs, reg, val);
    34	}
    35	
    36	static inline u32
    37	wed_r32(struct mtk_wed_device *dev, u32 reg)
    38	{
    39		unsigned int val;
    40	
    41		regmap_read(dev->hw->regs, reg, &val);
    42	
    43		return val;
    44	}
    45	
    46	static inline void
    47	wdma_w32(struct mtk_wed_device *dev, u32 reg, u32 val)
    48	{
    49		writel(val, dev->hw->wdma + reg);
    50	}
    51	
    52	static inline u32
    53	wdma_r32(struct mtk_wed_device *dev, u32 reg)
    54	{
    55		return readl(dev->hw->wdma + reg);
    56	}
    57	
    58	static inline u32
  > 59	wpdma_tx_r32(struct mtk_wed_device *dev, int ring, u32 reg)
    60	{
  > 61		if (!dev->tx_ring[ring].wpdma)
    62			return 0;
    63	
    64		return readl(dev->tx_ring[ring].wpdma + reg);
    65	}
    66	
    67	static inline void
    68	wpdma_tx_w32(struct mtk_wed_device *dev, int ring, u32 reg, u32 val)
    69	{
    70		if (!dev->tx_ring[ring].wpdma)
    71			return;
    72	
    73		writel(val, dev->tx_ring[ring].wpdma + reg);
    74	}
    75	
    76	static inline u32
    77	wpdma_txfree_r32(struct mtk_wed_device *dev, u32 reg)
    78	{
  > 79		if (!dev->txfree_ring.wpdma)
    80			return 0;
    81	
    82		return readl(dev->txfree_ring.wpdma + reg);
    83	}
    84	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

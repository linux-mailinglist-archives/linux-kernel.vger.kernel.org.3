Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361434B3442
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 11:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbiBLKkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 05:40:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiBLKjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 05:39:47 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEF626562
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 02:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644662383; x=1676198383;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Dep73Zvpf0f6P/tgt1cFcQLwk/s8R94CSwH/YGNtGAE=;
  b=FtI+Xh/VfPh0FLr/AbDlBl9Vsqjp/B2IcJr30/j5ZLSgt1YW7clyigmU
   TjXADFvApgRwpaZh2roth8Qce+XrJzCjFZO93IS/WNJMTEe4rSWYFaxB8
   bBfDgEkBoUkdKhfZ294Go5wb3b7qzZMs2GyApDaxShDYuD8o+A1hS/ath
   A3J5TUO8gfqP4yMm2EVBCOj7npWtes7ZZzE9rbkeihL01HdtBZmVwzfk/
   zU3xYKOxRDpGYxAba1Fzr4FDDKMaMpO4hTpxXJeQHK0AVAlVRlaFjUfB3
   dowa4du/YHARrImZu8VvTV+v34SmofVsfGz8xnxGzhtVaMkTuHWXaXohX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="336295186"
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="336295186"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 02:39:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="542432135"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 12 Feb 2022 02:39:41 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIpob-00061h-7B; Sat, 12 Feb 2022 10:39:41 +0000
Date:   Sat, 12 Feb 2022 18:38:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [nbd168-wireless:mtk-flow-offload 9/9]
 drivers/net/wireless/mediatek/mt76/dma.c:154:42: error: 'struct
 mtk_wed_device' has no member named 'tx_ring'
Message-ID: <202202121510.24R6oTBV-lkp@intel.com>
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

tree:   https://github.com/nbd168/wireless mtk-flow-offload
head:   1ba2137278dd5c4747b6e43be7aae4e94fb9c76e
commit: 1ba2137278dd5c4747b6e43be7aae4e94fb9c76e [9/9] mt76: mt7915: add Wireless Ethernet Dispatch support
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220212/202202121510.24R6oTBV-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/nbd168/wireless/commit/1ba2137278dd5c4747b6e43be7aae4e94fb9c76e
        git remote add nbd168-wireless https://github.com/nbd168/wireless
        git fetch --no-tags nbd168-wireless mtk-flow-offload
        git checkout 1ba2137278dd5c4747b6e43be7aae4e94fb9c76e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/net/wireless/mediatek/mt76/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/net/wireless/mediatek/mt76/dma.c: In function 'mt76_dma_sync_idx':
   drivers/net/wireless/mediatek/mt76/dma.c:24:13: warning: unused variable '_offset' [-Wunused-variable]
      24 |         u32 _offset = offsetof(struct mt76_queue_regs, _field);         \
         |             ^~~~~~~
   drivers/net/wireless/mediatek/mt76/dma.c:111:9: note: in expansion of macro 'Q_WRITE'
     111 |         Q_WRITE(dev, q, desc_base, q->desc_dma);
         |         ^~~~~~~
   drivers/net/wireless/mediatek/mt76/dma.c:24:13: warning: unused variable '_offset' [-Wunused-variable]
      24 |         u32 _offset = offsetof(struct mt76_queue_regs, _field);         \
         |             ^~~~~~~
   drivers/net/wireless/mediatek/mt76/dma.c:112:9: note: in expansion of macro 'Q_WRITE'
     112 |         Q_WRITE(dev, q, ring_size, q->ndesc);
         |         ^~~~~~~
   drivers/net/wireless/mediatek/mt76/dma.c:11:13: warning: unused variable '_offset' [-Wunused-variable]
      11 |         u32 _offset = offsetof(struct mt76_queue_regs, _field);         \
         |             ^~~~~~~
   drivers/net/wireless/mediatek/mt76/dma.c:113:19: note: in expansion of macro 'Q_READ'
     113 |         q->head = Q_READ(dev, q, dma_idx);
         |                   ^~~~~~
   drivers/net/wireless/mediatek/mt76/dma.c: In function 'mt76_dma_queue_reset':
   drivers/net/wireless/mediatek/mt76/dma.c:24:13: warning: unused variable '_offset' [-Wunused-variable]
      24 |         u32 _offset = offsetof(struct mt76_queue_regs, _field);         \
         |             ^~~~~~~
   drivers/net/wireless/mediatek/mt76/dma.c:129:9: note: in expansion of macro 'Q_WRITE'
     129 |         Q_WRITE(dev, q, cpu_idx, 0);
         |         ^~~~~~~
   drivers/net/wireless/mediatek/mt76/dma.c:24:13: warning: unused variable '_offset' [-Wunused-variable]
      24 |         u32 _offset = offsetof(struct mt76_queue_regs, _field);         \
         |             ^~~~~~~
   drivers/net/wireless/mediatek/mt76/dma.c:130:9: note: in expansion of macro 'Q_WRITE'
     130 |         Q_WRITE(dev, q, dma_idx, 0);
         |         ^~~~~~~
   drivers/net/wireless/mediatek/mt76/dma.c: In function 'mt76_dma_wed_setup':
>> drivers/net/wireless/mediatek/mt76/dma.c:154:42: error: 'struct mtk_wed_device' has no member named 'tx_ring'
     154 |                         q->wed_regs = wed->tx_ring[ring].reg_base;
         |                                          ^~
>> drivers/net/wireless/mediatek/mt76/dma.c:163:68: error: macro "mtk_wed_device_txfree_ring_setup" requires 3 arguments, but only 2 given
     163 |                 ret = mtk_wed_device_txfree_ring_setup(wed, q->regs);
         |                                                                    ^
   In file included from drivers/net/wireless/mediatek/mt76/mt76.h:16,
                    from drivers/net/wireless/mediatek/mt76/dma.c:7:
   include/linux/soc/mediatek/mtk_wed.h:122: note: macro "mtk_wed_device_txfree_ring_setup" defined here
     122 | #define mtk_wed_device_txfree_ring_setup(_dev, _ring, _regs) -ENODEV
         | 
>> drivers/net/wireless/mediatek/mt76/dma.c:163:23: error: 'mtk_wed_device_txfree_ring_setup' undeclared (first use in this function)
     163 |                 ret = mtk_wed_device_txfree_ring_setup(wed, q->regs);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/mediatek/mt76/dma.c:163:23: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net/wireless/mediatek/mt76/dma.c:165:42: error: 'struct mtk_wed_device' has no member named 'txfree_ring'
     165 |                         q->wed_regs = wed->txfree_ring.reg_base;
         |                                          ^~
>> drivers/net/wireless/mediatek/mt76/dma.c:138:24: warning: variable 'ring' set but not used [-Wunused-but-set-variable]
     138 |         int ret, type, ring;
         |                        ^~~~
   drivers/net/wireless/mediatek/mt76/dma.c: In function 'mt76_dma_kick_queue':
   drivers/net/wireless/mediatek/mt76/dma.c:24:13: warning: unused variable '_offset' [-Wunused-variable]
      24 |         u32 _offset = offsetof(struct mt76_queue_regs, _field);         \
         |             ^~~~~~~
   drivers/net/wireless/mediatek/mt76/dma.c:298:9: note: in expansion of macro 'Q_WRITE'
     298 |         Q_WRITE(dev, q, cpu_idx, q->head);
         |         ^~~~~~~
   drivers/net/wireless/mediatek/mt76/dma.c: In function 'mt76_dma_tx_cleanup':
   drivers/net/wireless/mediatek/mt76/dma.c:11:13: warning: unused variable '_offset' [-Wunused-variable]
      11 |         u32 _offset = offsetof(struct mt76_queue_regs, _field);         \
         |             ^~~~~~~
   drivers/net/wireless/mediatek/mt76/dma.c:314:24: note: in expansion of macro 'Q_READ'
     314 |                 last = Q_READ(dev, q, dma_idx);
         |                        ^~~~~~
   drivers/net/wireless/mediatek/mt76/dma.c:11:13: warning: unused variable '_offset' [-Wunused-variable]
      11 |         u32 _offset = offsetof(struct mt76_queue_regs, _field);         \
         |             ^~~~~~~
   drivers/net/wireless/mediatek/mt76/dma.c:326:32: note: in expansion of macro 'Q_READ'
     326 |                         last = Q_READ(dev, q, dma_idx);
         |                                ^~~~~~
   drivers/net/wireless/mediatek/mt76/dma.c: In function 'mt76_dma_rx_process':
   drivers/net/wireless/mediatek/mt76/dma.c:11:13: warning: unused variable '_offset' [-Wunused-variable]
      11 |         u32 _offset = offsetof(struct mt76_queue_regs, _field);         \
         |             ^~~~~~~
   drivers/net/wireless/mediatek/mt76/dma.c:644:27: note: in expansion of macro 'Q_READ'
     644 |                 dma_idx = Q_READ(dev, q, dma_idx);
         |                           ^~~~~~
   drivers/net/wireless/mediatek/mt76/dma.c:11:13: warning: unused variable '_offset' [-Wunused-variable]
      11 |         u32 _offset = offsetof(struct mt76_queue_regs, _field);         \
         |             ^~~~~~~
   drivers/net/wireless/mediatek/mt76/dma.c:653:43: note: in expansion of macro 'Q_READ'
     653 |                                 dma_idx = Q_READ(dev, q, dma_idx);
         |                                           ^~~~~~
--
   drivers/net/wireless/mediatek/mt76/tx.c: In function 'mt76_token_consume':
>> drivers/net/wireless/mediatek/mt76/tx.c:730:25: error: 'struct mtk_wed_device' has no member named 'wlan'
     730 |             token >= wed->wlan.token_start)
         |                         ^~
   drivers/net/wireless/mediatek/mt76/tx.c: In function 'mt76_token_release':
   drivers/net/wireless/mediatek/mt76/tx.c:755:33: error: 'struct mtk_wed_device' has no member named 'wlan'
     755 |                     token >= wed->wlan.token_start &&
         |                                 ^~
--
   drivers/net/wireless/mediatek/mt76/mt7915/pci.c: In function 'mt7915_wed_offload_enable':
>> drivers/net/wireless/mediatek/mt76/mt7915/pci.c:106:35: error: 'struct mtk_wed_device' has no member named 'wlan'
     106 |         dev->mt76.token_size = wed->wlan.token_start;
         |                                   ^~
   drivers/net/wireless/mediatek/mt76/mt7915/pci.c: In function 'mt7915_pci_probe':
   drivers/net/wireless/mediatek/mt76/mt7915/pci.c:164:12: error: 'struct mtk_wed_device' has no member named 'wlan'
     164 |         wed->wlan.pci_dev = pdev;
         |            ^~
   drivers/net/wireless/mediatek/mt76/mt7915/pci.c:165:12: error: 'struct mtk_wed_device' has no member named 'wlan'
     165 |         wed->wlan.wpdma_phys = pci_resource_start(pdev, 0) +
         |            ^~
   drivers/net/wireless/mediatek/mt76/mt7915/pci.c:167:12: error: 'struct mtk_wed_device' has no member named 'wlan'
     167 |         wed->wlan.nbuf = 4096;
         |            ^~
   drivers/net/wireless/mediatek/mt76/mt7915/pci.c:168:12: error: 'struct mtk_wed_device' has no member named 'wlan'
     168 |         wed->wlan.token_start = MT7915_TOKEN_SIZE - wed->wlan.nbuf;
         |            ^~
   drivers/net/wireless/mediatek/mt76/mt7915/pci.c:168:56: error: 'struct mtk_wed_device' has no member named 'wlan'
     168 |         wed->wlan.token_start = MT7915_TOKEN_SIZE - wed->wlan.nbuf;
         |                                                        ^~
   drivers/net/wireless/mediatek/mt76/mt7915/pci.c:169:12: error: 'struct mtk_wed_device' has no member named 'wlan'
     169 |         wed->wlan.init_buf = mt7915_wed_init_buf;
         |            ^~
   drivers/net/wireless/mediatek/mt76/mt7915/pci.c:170:12: error: 'struct mtk_wed_device' has no member named 'wlan'
     170 |         wed->wlan.offload_enable = mt7915_wed_offload_enable;
         |            ^~
   drivers/net/wireless/mediatek/mt76/mt7915/pci.c:171:12: error: 'struct mtk_wed_device' has no member named 'wlan'
     171 |         wed->wlan.offload_disable = mt7915_wed_offload_disable;
         |            ^~
>> drivers/net/wireless/mediatek/mt76/mt7915/pci.c:174:26: error: 'struct mtk_wed_device' has no member named 'irq'
     174 |                 irq = wed->irq;
         |                          ^~
>> drivers/net/wireless/mediatek/mt76/mt7915/pci.c:175:40: error: 'struct mtk_wed_device' has no member named 'dev'
     175 |                 dev->mt76.dma_dev = wed->dev;
         |                                        ^~
   drivers/net/wireless/mediatek/mt76/mt7915/pci.c:177:39: error: 'struct mtk_wed_device' has no member named 'dev'
     177 |                 ret = dma_set_mask(wed->dev, DMA_BIT_MASK(32));
         |                                       ^~
--
   drivers/net/wireless/mediatek/mt76/mt7915/main.c: In function 'mt7915_net_fill_forward_path':
>> drivers/net/wireless/mediatek/mt76/mt7915/main.c:1408:38: error: 'struct mtk_wed_device' has no member named 'wdma_idx'
    1408 |         path->mtk_wdma.wdma_idx = wed->wdma_idx;
         |                                      ^~


vim +154 drivers/net/wireless/mediatek/mt76/dma.c

   133	
   134	static int
   135	mt76_dma_wed_setup(struct mt76_dev *dev, struct mt76_queue *q)
   136	{
   137		struct mtk_wed_device *wed = &dev->mmio.wed;
 > 138		int ret, type, ring;
   139		u8 flags = q->flags;
   140	
   141		if (!mtk_wed_device_active(wed))
   142			q->flags &= ~MT_QFLAG_WED;
   143	
   144		if (!(q->flags & MT_QFLAG_WED))
   145			return 0;
   146	
   147		type = FIELD_GET(MT_QFLAG_WED_TYPE, q->flags);
   148		ring = FIELD_GET(MT_QFLAG_WED_RING, q->flags);
   149	
   150		switch (type) {
   151		case MT76_WED_Q_TX:
   152			ret = mtk_wed_device_tx_ring_setup(wed, ring, q->regs);
   153			if (!ret)
 > 154				q->wed_regs = wed->tx_ring[ring].reg_base;
   155			break;
   156		case MT76_WED_Q_TXFREE:
   157			/* WED txfree queue needs ring to be initialized before setup */
   158			q->flags = 0;
   159			mt76_dma_queue_reset(dev, q);
   160			mt76_dma_rx_fill(dev, q);
   161			q->flags = flags;
   162	
 > 163			ret = mtk_wed_device_txfree_ring_setup(wed, q->regs);
   164			if (!ret)
 > 165				q->wed_regs = wed->txfree_ring.reg_base;
   166			break;
   167		default:
   168			ret = -EINVAL;
   169		}
   170	
   171		return ret;
   172	}
   173	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

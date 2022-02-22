Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD294BF080
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 05:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiBVEI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 23:08:56 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiBVEIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 23:08:49 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A336D861
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 20:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645502894; x=1677038894;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+u07VfPWIZ8IYTKzhmKSDiIYWOhurHWRpQZ0R5hw1o0=;
  b=MsZsTuHUjL0zV2Iqigd+swTOBUFGwaXgvWZjCs/yv7T0t7Wwt9F81jk3
   bdWqvwTg6ludO0kC5KTxi+Ay/oucLVvoELWel0ZhA9Ss8vvPH61uifown
   a4ZfMTtyYJq1Qhw2jY4URNUl+EE9ge7nu/VWYTZ87nrslfM/UsB7Xzk6Y
   mhoXqQfY/jMXxtk1vHLuX4Q5tWi7o8F0YwJJp4sZQ2ZAhCFtC+mMUA+U+
   0gs/n4WpkajZT6p4HLiv73vfTj7PgX+gy0sU2RflvI5rbe4lOgeOhMn4y
   pHLzcdMDCqAVxFDiKlW6Olz9ekrPZ3APp5w6yZIHzPYlYxIyolN9dJO+9
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="276204263"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="276204263"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 20:07:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="606555743"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Feb 2022 20:07:51 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMMSs-0002J7-B7; Tue, 22 Feb 2022 04:07:50 +0000
Date:   Tue, 22 Feb 2022 12:07:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [nbd168-wireless:mtk-flow-offload 3/14]
 drivers/net/ethernet/mediatek/mtk_wed.c:150:36: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202202221129.mkw1pRTe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/nbd168/wireless mtk-flow-offload
head:   c5c9c022de79aa26f88a358954a868d8bbc2af11
commit: 3ca98adede31d2c6cb6e88a1fbd250deeac19d28 [3/14] net: ethernet: mtk_eth_soc: add support for Wireless Ethernet Dispatch (WED)
config: h8300-randconfig-s031-20220221 (https://download.01.org/0day-ci/archive/20220222/202202221129.mkw1pRTe-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/nbd168/wireless/commit/3ca98adede31d2c6cb6e88a1fbd250deeac19d28
        git remote add nbd168-wireless https://github.com/nbd168/wireless
        git fetch --no-tags nbd168-wireless mtk-flow-offload
        git checkout 3ca98adede31d2c6cb6e88a1fbd250deeac19d28
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=h8300 SHELL=/bin/bash drivers/net/ethernet/mediatek/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/mediatek/mtk_wed.c:150:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] buf0 @@     got unsigned int [assigned] [usertype] buf_phys @@
   drivers/net/ethernet/mediatek/mtk_wed.c:150:36: sparse:     expected restricted __le32 [usertype] buf0
   drivers/net/ethernet/mediatek/mtk_wed.c:150:36: sparse:     got unsigned int [assigned] [usertype] buf_phys
>> drivers/net/ethernet/mediatek/mtk_wed.c:151:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] buf1 @@     got unsigned int @@
   drivers/net/ethernet/mediatek/mtk_wed.c:151:36: sparse:     expected restricted __le32 [usertype] buf1
   drivers/net/ethernet/mediatek/mtk_wed.c:151:36: sparse:     got unsigned int
>> drivers/net/ethernet/mediatek/mtk_wed.c:152:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] ctrl @@     got unsigned long @@
   drivers/net/ethernet/mediatek/mtk_wed.c:152:36: sparse:     expected restricted __le32 [usertype] ctrl
   drivers/net/ethernet/mediatek/mtk_wed.c:152:36: sparse:     got unsigned long
>> drivers/net/ethernet/mediatek/mtk_wed.c:191:17: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le32 [usertype] buf0 @@
   drivers/net/ethernet/mediatek/mtk_wed.c:191:17: sparse:     expected unsigned int [usertype] addr
   drivers/net/ethernet/mediatek/mtk_wed.c:191:17: sparse:     got restricted __le32 [usertype] buf0
   drivers/net/ethernet/mediatek/mtk_wed.c: note: in included file (through include/linux/scatterlist.h, include/linux/dma-mapping.h):
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression

vim +150 drivers/net/ethernet/mediatek/mtk_wed.c

    91	
    92	static int
    93	mtk_wed_buffer_alloc(struct mtk_wed_device *dev)
    94	{
    95		struct mtk_wdma_desc *desc;
    96		dma_addr_t desc_phys;
    97		void **page_list;
    98		int token = dev->wlan.token_start;
    99		int ring_size;
   100		int n_pages;
   101		int i, page_idx;
   102	
   103		ring_size = dev->wlan.nbuf & ~(MTK_WED_BUF_PER_PAGE - 1);
   104		n_pages = ring_size / MTK_WED_BUF_PER_PAGE;
   105	
   106		page_list = kcalloc(n_pages, sizeof(*page_list), GFP_KERNEL);
   107		if (!page_list)
   108			return -ENOMEM;
   109	
   110		dev->buf_ring.size = ring_size;
   111		dev->buf_ring.pages = page_list;
   112	
   113		desc = dma_alloc_coherent(dev->hw->dev, ring_size * sizeof(*desc),
   114					  &desc_phys, GFP_KERNEL);
   115		if (!desc)
   116			return -ENOMEM;
   117	
   118		dev->buf_ring.desc = desc;
   119		dev->buf_ring.desc_phys = desc_phys;
   120	
   121		for (i = 0, page_idx = 0; i < ring_size; i += MTK_WED_BUF_PER_PAGE) {
   122			dma_addr_t page_phys, buf_phys;
   123			struct page *page;
   124			void *buf;
   125			int s;
   126	
   127			page = __dev_alloc_pages(GFP_KERNEL, 0);
   128			if (!page)
   129				return -ENOMEM;
   130	
   131			page_phys = dma_map_page(dev->hw->dev, page, 0, PAGE_SIZE,
   132						 DMA_BIDIRECTIONAL);
   133			if (dma_mapping_error(dev->hw->dev, page_phys)) {
   134				__free_page(page);
   135				return -ENOMEM;
   136			}
   137	
   138			page_list[page_idx++] = page;
   139			dma_sync_single_for_cpu(dev->hw->dev, page_phys, PAGE_SIZE,
   140						DMA_BIDIRECTIONAL);
   141	
   142			buf = page_to_virt(page);
   143			buf_phys = page_phys;
   144	
   145			for (s = 0; s < MTK_WED_BUF_PER_PAGE; s++) {
   146				u32 txd_size;
   147	
   148				txd_size = dev->wlan.init_buf(buf, buf_phys, token++);
   149	
 > 150				desc->buf0 = buf_phys;
 > 151				desc->buf1 = buf_phys + txd_size;
 > 152				desc->ctrl = FIELD_PREP(MTK_WDMA_DESC_CTRL_LEN0,
   153							txd_size) |
   154					     FIELD_PREP(MTK_WDMA_DESC_CTRL_LEN1,
   155							MTK_WED_BUF_SIZE - txd_size) |
   156					     MTK_WDMA_DESC_CTRL_LAST_SEG1;
   157				desc->info = 0;
   158				desc++;
   159	
   160				buf += MTK_WED_BUF_SIZE;
   161				buf_phys += MTK_WED_BUF_SIZE;
   162			}
   163	
   164			dma_sync_single_for_device(dev->hw->dev, page_phys, PAGE_SIZE,
   165						   DMA_BIDIRECTIONAL);
   166		}
   167	
   168		return 0;
   169	}
   170	
   171	static void
   172	mtk_wed_free_buffer(struct mtk_wed_device *dev)
   173	{
   174		struct mtk_wdma_desc *desc = dev->buf_ring.desc;
   175		void **page_list = dev->buf_ring.pages;
   176		int page_idx;
   177		int i;
   178	
   179		if (!page_list)
   180			return;
   181	
   182		if (!desc)
   183			goto free_pagelist;
   184	
   185		for (i = 0, page_idx = 0; i < dev->buf_ring.size; i += MTK_WED_BUF_PER_PAGE) {
   186			void *page = page_list[page_idx++];
   187	
   188			if (!page)
   189				break;
   190	
 > 191			dma_unmap_page(dev->hw->dev, desc[i].buf0,
   192				       PAGE_SIZE, DMA_BIDIRECTIONAL);
   193			__free_page(page);
   194		}
   195	
   196		dma_free_coherent(dev->hw->dev, dev->buf_ring.size * sizeof(*desc),
   197				  desc, dev->buf_ring.desc_phys);
   198	
   199	free_pagelist:
   200		kfree(page_list);
   201	}
   202	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

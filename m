Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED83A48113D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 10:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbhL2JUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 04:20:00 -0500
Received: from mga01.intel.com ([192.55.52.88]:38265 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239492AbhL2JT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 04:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640769599; x=1672305599;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xfBpU6Cm32hjsD3C5o5DGAh0+kH3ryrXLawMBBhUqao=;
  b=LumEnJ3OnD5raVTq+xGZz0F9Gi9cNAEMxkGCnSkJjoIFM0425YCXK2Y+
   7AunNa7uPdb8o+PurqLMMM+uX34j9KAudhvo5/Ib9cA2V99wqKIgRktn1
   8O8HAs+GDIFwxzy08xSiqFJ5Fah9J84mhzD0yJ6CWp8R9jHD3ic0wQYLu
   0KB65ROo8dYo0FkSMOqp3sdZgOeRR04yHONEU1NTz6bATp6MnJHskWoI8
   UIwioov8yMny1xCAzDKn+LqofZSS7y0XVbP4nRBwm9yxOfopLZYKWZPbK
   KlZJh25c6XbwZ6pGhmd3zLmR3i8a4WEkWiBDKRwZm1oRFqIafNhWA1qAl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="265726841"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="265726841"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 01:19:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="554472070"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Dec 2021 01:19:57 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2V7k-0008mp-PK; Wed, 29 Dec 2021 09:19:56 +0000
Date:   Wed, 29 Dec 2021 17:18:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Conley Lee <conleylee@foxmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: drivers/net/ethernet/allwinner/sun4i-emac.c:940:60: warning: format
 '%x' expects argument of type 'unsigned int', but argument 3 has type
 'resource_size_t' {aka 'long long unsigned int'}
Message-ID: <202112291759.0LDxIUcf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20211229-095330/conleylee-foxmail-com/sun4i-emac-c-add-dma-support/20211224-225057
head:   c1054aa82226f85551abd3193d686b3e263e75d2
commit: c1054aa82226f85551abd3193d686b3e263e75d2 sun4i-emac.c: add dma support
date:   7 hours ago
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20211229/202112291759.0LDxIUcf-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c1054aa82226f85551abd3193d686b3e263e75d2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20211229-095330/conleylee-foxmail-com/sun4i-emac-c-add-dma-support/20211224-225057
        git checkout c1054aa82226f85551abd3193d686b3e263e75d2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/net/ethernet/allwinner/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/allwinner/sun4i-emac.c: In function 'emac_configure_dma':
>> drivers/net/ethernet/allwinner/sun4i-emac.c:940:60: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
     940 |         netdev_info(ndev, "get io resource from device: 0x%x, size = %u\n",
         |                                                           ~^
         |                                                            |
         |                                                            unsigned int
         |                                                           %llx
     941 |                     regs->start, resource_size(regs));
         |                     ~~~~~~~~~~~                             
         |                         |
         |                         resource_size_t {aka long long unsigned int}
>> drivers/net/ethernet/allwinner/sun4i-emac.c:940:71: warning: format '%u' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
     940 |         netdev_info(ndev, "get io resource from device: 0x%x, size = %u\n",
         |                                                                      ~^
         |                                                                       |
         |                                                                       unsigned int
         |                                                                      %llu
     941 |                     regs->start, resource_size(regs));
         |                                  ~~~~~~~~~~~~~~~~~~~                   
         |                                  |
         |                                  resource_size_t {aka long long unsigned int}


vim +940 drivers/net/ethernet/allwinner/sun4i-emac.c

   924	
   925	static int emac_configure_dma(struct emac_board_info *db)
   926	{
   927		struct platform_device *pdev = db->pdev;
   928		struct net_device *ndev = db->ndev;
   929		struct dma_slave_config conf = {};
   930		struct resource *regs;
   931		int err = 0;
   932	
   933		regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   934		if (!regs) {
   935			netdev_err(ndev, "get io resource from device failed.\n");
   936			err = -ENOMEM;
   937			goto out_clear_chan;
   938		}
   939	
 > 940		netdev_info(ndev, "get io resource from device: 0x%x, size = %u\n",
   941			    regs->start, resource_size(regs));
   942		db->emac_rx_fifo = regs->start + EMAC_RX_IO_DATA_REG;
   943	
   944		db->rx_chan = dma_request_chan(&pdev->dev, "rx");
   945		if (IS_ERR(db->rx_chan)) {
   946			netdev_err(ndev,
   947				   "failed to request dma channel. dma is disabled\n");
   948			err = PTR_ERR(db->rx_chan);
   949			goto out_clear_chan;
   950		}
   951	
   952		conf.direction = DMA_DEV_TO_MEM;
   953		conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
   954		conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
   955		conf.src_addr = db->emac_rx_fifo;
   956		conf.dst_maxburst = 4;
   957		conf.src_maxburst = 4;
   958		conf.device_fc = false;
   959	
   960		err = dmaengine_slave_config(db->rx_chan, &conf);
   961		if (err) {
   962			netdev_err(ndev, "config dma slave failed\n");
   963			err = -EINVAL;
   964			goto out_slave_configure_err;
   965		}
   966	
   967		return err;
   968	
   969	out_slave_configure_err:
   970		dma_release_channel(db->rx_chan);
   971	
   972	out_clear_chan:
   973		db->rx_chan = NULL;
   974		return err;
   975	}
   976	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

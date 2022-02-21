Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C424BD2B0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 00:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245286AbiBTXsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 18:48:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiBTXsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 18:48:22 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1923040A23
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 15:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645400880; x=1676936880;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2m/zYWv5aM0xUFbmePUKcWHfZX+gfrCLuvLJcgX1ZTU=;
  b=LrNYoq0AILp69fgRZ9evBDVNrJZu2B6WG7sdGXRrdz5PHVZvBQSo7U5p
   01EB6WcSe+dbEkQ0ZJ88YVJC8j6iO8EfxdmwyEIZw7tC4sfqI1ku3Lze1
   p2Al9H36rszX9i83mZ64scwe0XuTbIYuqLGjXhBTa9FHAy0VRxPJg6VvH
   CAo97MPLCBHvHibJJOzKafIJdPtaTJfLzcKQZDqfNE8hn4+8IbnDLJvyM
   DavNUGOGCbowEYT2QUhGZ57EWn4Sm6JRo8LqImENOWaHqk4H/Cz5SckQa
   Nap3mhTRNt2mka9xE6i2EsgvRKnxmZIm1VJvl/f29+Y78XGrhCihEkjkW
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="248990623"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="248990623"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 15:47:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="706054075"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Feb 2022 15:47:57 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLvvp-000120-9a; Sun, 20 Feb 2022 23:47:57 +0000
Date:   Mon, 21 Feb 2022 07:47:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robert Hancock <robert.hancock@calian.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>
Subject: [linux-stable-rc:queue/4.19 9796/9999]
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c:283:15: error: implicit
 declaration of function 'read_poll_timeout'
Message-ID: <202202210728.p4g6rNjL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/4.19
head:   3081d3e3d155a0c6a077a19fdf61d4c416b51f80
commit: 8b8ad8a7ac24905937c3975b54c4594b93b66ebb [9796/9999] net: axienet: Wait for PhyRstCmplt after core reset
config: microblaze-allmodconfig (https://download.01.org/0day-ci/archive/20220221/202202210728.p4g6rNjL-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=8b8ad8a7ac24905937c3975b54c4594b93b66ebb
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/4.19
        git checkout 8b8ad8a7ac24905937c3975b54c4594b93b66ebb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/net/ethernet/xilinx/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/xilinx/xilinx_axienet_main.c: In function 'axienet_dma_bd_init':
   drivers/net/ethernet/xilinx/xilinx_axienet_main.c:283:9: error: 'ret' undeclared (first use in this function); did you mean 'net'?
     283 |         ret = read_poll_timeout(axienet_ior, value,
         |         ^~~
         |         net
   drivers/net/ethernet/xilinx/xilinx_axienet_main.c:283:9: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:283:15: error: implicit declaration of function 'read_poll_timeout' [-Werror=implicit-function-declaration]
     283 |         ret = read_poll_timeout(axienet_ior, value,
         |               ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/xilinx/xilinx_axienet_main.c:283:46: error: 'value' undeclared (first use in this function)
     283 |         ret = read_poll_timeout(axienet_ior, value,
         |                                              ^~~~~
   cc1: some warnings being treated as errors


vim +/read_poll_timeout +283 drivers/net/ethernet/xilinx/xilinx_axienet_main.c

   178	
   179	/**
   180	 * axienet_dma_bd_init - Setup buffer descriptor rings for Axi DMA
   181	 * @ndev:	Pointer to the net_device structure
   182	 *
   183	 * Return: 0, on success -ENOMEM, on failure
   184	 *
   185	 * This function is called to initialize the Rx and Tx DMA descriptor
   186	 * rings. This initializes the descriptors with required default values
   187	 * and is called when Axi Ethernet driver reset is called.
   188	 */
   189	static int axienet_dma_bd_init(struct net_device *ndev)
   190	{
   191		u32 cr;
   192		int i;
   193		struct sk_buff *skb;
   194		struct axienet_local *lp = netdev_priv(ndev);
   195	
   196		/* Reset the indexes which are used for accessing the BDs */
   197		lp->tx_bd_ci = 0;
   198		lp->tx_bd_tail = 0;
   199		lp->rx_bd_ci = 0;
   200	
   201		/* Allocate the Tx and Rx buffer descriptors. */
   202		lp->tx_bd_v = dma_zalloc_coherent(ndev->dev.parent,
   203						  sizeof(*lp->tx_bd_v) * TX_BD_NUM,
   204						  &lp->tx_bd_p, GFP_KERNEL);
   205		if (!lp->tx_bd_v)
   206			goto out;
   207	
   208		lp->rx_bd_v = dma_zalloc_coherent(ndev->dev.parent,
   209						  sizeof(*lp->rx_bd_v) * RX_BD_NUM,
   210						  &lp->rx_bd_p, GFP_KERNEL);
   211		if (!lp->rx_bd_v)
   212			goto out;
   213	
   214		for (i = 0; i < TX_BD_NUM; i++) {
   215			lp->tx_bd_v[i].next = lp->tx_bd_p +
   216					      sizeof(*lp->tx_bd_v) *
   217					      ((i + 1) % TX_BD_NUM);
   218		}
   219	
   220		for (i = 0; i < RX_BD_NUM; i++) {
   221			lp->rx_bd_v[i].next = lp->rx_bd_p +
   222					      sizeof(*lp->rx_bd_v) *
   223					      ((i + 1) % RX_BD_NUM);
   224	
   225			skb = netdev_alloc_skb_ip_align(ndev, lp->max_frm_size);
   226			if (!skb)
   227				goto out;
   228	
   229			lp->rx_bd_v[i].sw_id_offset = (u32) skb;
   230			lp->rx_bd_v[i].phys = dma_map_single(ndev->dev.parent,
   231							     skb->data,
   232							     lp->max_frm_size,
   233							     DMA_FROM_DEVICE);
   234			lp->rx_bd_v[i].cntrl = lp->max_frm_size;
   235		}
   236	
   237		/* Start updating the Rx channel control register */
   238		cr = axienet_dma_in32(lp, XAXIDMA_RX_CR_OFFSET);
   239		/* Update the interrupt coalesce count */
   240		cr = ((cr & ~XAXIDMA_COALESCE_MASK) |
   241		      ((lp->coalesce_count_rx) << XAXIDMA_COALESCE_SHIFT));
   242		/* Update the delay timer count */
   243		cr = ((cr & ~XAXIDMA_DELAY_MASK) |
   244		      (XAXIDMA_DFT_RX_WAITBOUND << XAXIDMA_DELAY_SHIFT));
   245		/* Enable coalesce, delay timer and error interrupts */
   246		cr |= XAXIDMA_IRQ_ALL_MASK;
   247		/* Write to the Rx channel control register */
   248		axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, cr);
   249	
   250		/* Start updating the Tx channel control register */
   251		cr = axienet_dma_in32(lp, XAXIDMA_TX_CR_OFFSET);
   252		/* Update the interrupt coalesce count */
   253		cr = (((cr & ~XAXIDMA_COALESCE_MASK)) |
   254		      ((lp->coalesce_count_tx) << XAXIDMA_COALESCE_SHIFT));
   255		/* Update the delay timer count */
   256		cr = (((cr & ~XAXIDMA_DELAY_MASK)) |
   257		      (XAXIDMA_DFT_TX_WAITBOUND << XAXIDMA_DELAY_SHIFT));
   258		/* Enable coalesce, delay timer and error interrupts */
   259		cr |= XAXIDMA_IRQ_ALL_MASK;
   260		/* Write to the Tx channel control register */
   261		axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, cr);
   262	
   263		/* Populate the tail pointer and bring the Rx Axi DMA engine out of
   264		 * halted state. This will make the Rx side ready for reception.
   265		 */
   266		axienet_dma_out32(lp, XAXIDMA_RX_CDESC_OFFSET, lp->rx_bd_p);
   267		cr = axienet_dma_in32(lp, XAXIDMA_RX_CR_OFFSET);
   268		axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET,
   269				  cr | XAXIDMA_CR_RUNSTOP_MASK);
   270		axienet_dma_out32(lp, XAXIDMA_RX_TDESC_OFFSET, lp->rx_bd_p +
   271				  (sizeof(*lp->rx_bd_v) * (RX_BD_NUM - 1)));
   272	
   273		/* Write to the RS (Run-stop) bit in the Tx channel control register.
   274		 * Tx channel is now ready to run. But only after we write to the
   275		 * tail pointer register that the Tx channel will start transmitting.
   276		 */
   277		axienet_dma_out32(lp, XAXIDMA_TX_CDESC_OFFSET, lp->tx_bd_p);
   278		cr = axienet_dma_in32(lp, XAXIDMA_TX_CR_OFFSET);
   279		axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET,
   280				  cr | XAXIDMA_CR_RUNSTOP_MASK);
   281	
   282		/* Wait for PhyRstCmplt bit to be set, indicating the PHY reset has finished */
 > 283		ret = read_poll_timeout(axienet_ior, value,
   284					value & XAE_INT_PHYRSTCMPLT_MASK,
   285					DELAY_OF_ONE_MILLISEC, 50000, false, lp,
   286					XAE_IS_OFFSET);
   287		if (ret) {
   288			dev_err(lp->dev, "%s: timeout waiting for PhyRstCmplt\n", __func__);
   289			return ret;
   290		}
   291	
   292		return 0;
   293	out:
   294		axienet_dma_bd_release(ndev);
   295		return -ENOMEM;
   296	}
   297	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

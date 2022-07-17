Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC305777BA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 20:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiGQSQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 14:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGQSQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 14:16:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DE513F51
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 11:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658081760; x=1689617760;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cDS0D5p9CcfAUeLYU67I+LQ5cqnTnMhGkxsgCElh1WU=;
  b=d9F0DGff4dFJzArBSqcxGAseq+jX6c3bDtm8QnSG6wBGqcEuzvaGYOQZ
   vYpEuEcl+ZQKQRJYuCABcr1yGH261egWO3RTeI86x0t5JoLsa36VXb8Ur
   9+7G6gWjbPvNGg9kzAWjy28XUBJhjnxwXKcjPc+r6rl5Ry+e/LmqcYR7D
   iNiTrwlzUBJjeLwrRN2FV3ihJTSLOwBbD2EmRsQKnvYqDepHdcOvAZLYp
   +4e0yRbjQM5UkqFLEWSu8+b2xdURUGBH43lgt4UX5SflWE7YS0Nvd7Wyh
   K+hkRaPji72rBThYHaK41TKN5pu0DwQgZP6bQ8EXoeUaUoKc/6ZZC0qEY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="266487256"
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="266487256"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 11:16:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="547227796"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 Jul 2022 11:15:59 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oD8oA-0003Yo-Bw;
        Sun, 17 Jul 2022 18:15:58 +0000
Date:   Mon, 18 Jul 2022 02:15:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [kraxel:drm-qemu-next 35/70] drivers/gpu/drm/vc4/vc4_dsi.c:1675:23:
 error: implicit declaration of function 'drmm_of_get_bridge'; did you mean
 'devm_drm_of_get_bridge'?
Message-ID: <202207180223.VAvnHfvU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kraxel.org/linux drm-qemu-next
head:   887ddf3251928dc39bfc58c5c62083d38a633c14
commit: 2a87d48c3342ede66b15649bcbbaf999ccc9a83a [35/70] drm/vc4: dsi: Switch to drmm_of_get_bridge
config: mips-randconfig-r025-20220717 (https://download.01.org/0day-ci/archive/20220718/202207180223.VAvnHfvU-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add kraxel git://git.kraxel.org/linux
        git fetch --no-tags kraxel drm-qemu-next
        git checkout 2a87d48c3342ede66b15649bcbbaf999ccc9a83a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/gpu/drm/vc4/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/gpu/drm/vc4/vc4_dsi.c: In function 'vc4_dsi_bind':
>> drivers/gpu/drm/vc4/vc4_dsi.c:1675:23: error: implicit declaration of function 'drmm_of_get_bridge'; did you mean 'devm_drm_of_get_bridge'? [-Werror=implicit-function-declaration]
    1675 |         dsi->bridge = drmm_of_get_bridge(drm, dev->of_node, 0, 0);
         |                       ^~~~~~~~~~~~~~~~~~
         |                       devm_drm_of_get_bridge
>> drivers/gpu/drm/vc4/vc4_dsi.c:1675:21: warning: assignment to 'struct drm_bridge *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1675 |         dsi->bridge = drmm_of_get_bridge(drm, dev->of_node, 0, 0);
         |                     ^
   cc1: some warnings being treated as errors


vim +1675 drivers/gpu/drm/vc4/vc4_dsi.c

  1558	
  1559	static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
  1560	{
  1561		struct platform_device *pdev = to_platform_device(dev);
  1562		struct drm_device *drm = dev_get_drvdata(master);
  1563		struct vc4_dsi *dsi = dev_get_drvdata(dev);
  1564		struct drm_encoder *encoder = &dsi->encoder.base;
  1565		int ret;
  1566	
  1567		dsi->variant = of_device_get_match_data(dev);
  1568	
  1569		INIT_LIST_HEAD(&dsi->bridge_chain);
  1570		dsi->encoder.type = dsi->variant->port ?
  1571			VC4_ENCODER_TYPE_DSI1 : VC4_ENCODER_TYPE_DSI0;
  1572	
  1573		dsi->regs = vc4_ioremap_regs(pdev, 0);
  1574		if (IS_ERR(dsi->regs))
  1575			return PTR_ERR(dsi->regs);
  1576	
  1577		dsi->regset.base = dsi->regs;
  1578		dsi->regset.regs = dsi->variant->regs;
  1579		dsi->regset.nregs = dsi->variant->nregs;
  1580	
  1581		if (DSI_PORT_READ(ID) != DSI_ID_VALUE) {
  1582			dev_err(dev, "Port returned 0x%08x for ID instead of 0x%08x\n",
  1583				DSI_PORT_READ(ID), DSI_ID_VALUE);
  1584			return -ENODEV;
  1585		}
  1586	
  1587		/* DSI1 on BCM2835/6/7 has a broken AXI slave that doesn't respond to
  1588		 * writes from the ARM.  It does handle writes from the DMA engine,
  1589		 * so set up a channel for talking to it.
  1590		 */
  1591		if (dsi->variant->broken_axi_workaround) {
  1592			dma_cap_mask_t dma_mask;
  1593	
  1594			dsi->reg_dma_mem = dma_alloc_coherent(dev, 4,
  1595							      &dsi->reg_dma_paddr,
  1596							      GFP_KERNEL);
  1597			if (!dsi->reg_dma_mem) {
  1598				DRM_ERROR("Failed to get DMA memory\n");
  1599				return -ENOMEM;
  1600			}
  1601	
  1602			ret = devm_add_action_or_reset(dev, vc4_dsi_dma_mem_release, dsi);
  1603			if (ret)
  1604				return ret;
  1605	
  1606			dma_cap_zero(dma_mask);
  1607			dma_cap_set(DMA_MEMCPY, dma_mask);
  1608	
  1609			dsi->reg_dma_chan = dma_request_chan_by_mask(&dma_mask);
  1610			if (IS_ERR(dsi->reg_dma_chan)) {
  1611				ret = PTR_ERR(dsi->reg_dma_chan);
  1612				if (ret != -EPROBE_DEFER)
  1613					DRM_ERROR("Failed to get DMA channel: %d\n",
  1614						  ret);
  1615				return ret;
  1616			}
  1617	
  1618			ret = devm_add_action_or_reset(dev, vc4_dsi_dma_chan_release, dsi);
  1619			if (ret)
  1620				return ret;
  1621	
  1622			/* Get the physical address of the device's registers.  The
  1623			 * struct resource for the regs gives us the bus address
  1624			 * instead.
  1625			 */
  1626			dsi->reg_paddr = be32_to_cpup(of_get_address(dev->of_node,
  1627								     0, NULL, NULL));
  1628		}
  1629	
  1630		init_completion(&dsi->xfer_completion);
  1631		/* At startup enable error-reporting interrupts and nothing else. */
  1632		DSI_PORT_WRITE(INT_EN, DSI1_INTERRUPTS_ALWAYS_ENABLED);
  1633		/* Clear any existing interrupt state. */
  1634		DSI_PORT_WRITE(INT_STAT, DSI_PORT_READ(INT_STAT));
  1635	
  1636		if (dsi->reg_dma_mem)
  1637			ret = devm_request_threaded_irq(dev, platform_get_irq(pdev, 0),
  1638							vc4_dsi_irq_defer_to_thread_handler,
  1639							vc4_dsi_irq_handler,
  1640							IRQF_ONESHOT,
  1641							"vc4 dsi", dsi);
  1642		else
  1643			ret = devm_request_irq(dev, platform_get_irq(pdev, 0),
  1644					       vc4_dsi_irq_handler, 0, "vc4 dsi", dsi);
  1645		if (ret) {
  1646			if (ret != -EPROBE_DEFER)
  1647				dev_err(dev, "Failed to get interrupt: %d\n", ret);
  1648			return ret;
  1649		}
  1650	
  1651		dsi->escape_clock = devm_clk_get(dev, "escape");
  1652		if (IS_ERR(dsi->escape_clock)) {
  1653			ret = PTR_ERR(dsi->escape_clock);
  1654			if (ret != -EPROBE_DEFER)
  1655				dev_err(dev, "Failed to get escape clock: %d\n", ret);
  1656			return ret;
  1657		}
  1658	
  1659		dsi->pll_phy_clock = devm_clk_get(dev, "phy");
  1660		if (IS_ERR(dsi->pll_phy_clock)) {
  1661			ret = PTR_ERR(dsi->pll_phy_clock);
  1662			if (ret != -EPROBE_DEFER)
  1663				dev_err(dev, "Failed to get phy clock: %d\n", ret);
  1664			return ret;
  1665		}
  1666	
  1667		dsi->pixel_clock = devm_clk_get(dev, "pixel");
  1668		if (IS_ERR(dsi->pixel_clock)) {
  1669			ret = PTR_ERR(dsi->pixel_clock);
  1670			if (ret != -EPROBE_DEFER)
  1671				dev_err(dev, "Failed to get pixel clock: %d\n", ret);
  1672			return ret;
  1673		}
  1674	
> 1675		dsi->bridge = drmm_of_get_bridge(drm, dev->of_node, 0, 0);
  1676		if (IS_ERR(dsi->bridge))
  1677			return PTR_ERR(dsi->bridge);
  1678	
  1679		/* The esc clock rate is supposed to always be 100Mhz. */
  1680		ret = clk_set_rate(dsi->escape_clock, 100 * 1000000);
  1681		if (ret) {
  1682			dev_err(dev, "Failed to set esc clock: %d\n", ret);
  1683			return ret;
  1684		}
  1685	
  1686		ret = vc4_dsi_init_phy_clocks(dsi);
  1687		if (ret)
  1688			return ret;
  1689	
  1690		ret = drmm_encoder_init(drm, encoder,
  1691					NULL,
  1692					DRM_MODE_ENCODER_DSI,
  1693					NULL);
  1694		if (ret)
  1695			return ret;
  1696	
  1697		drm_encoder_helper_add(encoder, &vc4_dsi_encoder_helper_funcs);
  1698	
  1699		ret = drm_bridge_attach(encoder, dsi->bridge, NULL, 0);
  1700		if (ret)
  1701			return ret;
  1702		/* Disable the atomic helper calls into the bridge.  We
  1703		 * manually call the bridge pre_enable / enable / etc. calls
  1704		 * from our driver, since we need to sequence them within the
  1705		 * encoder's enable/disable paths.
  1706		 */
  1707		list_splice_init(&encoder->bridge_chain, &dsi->bridge_chain);
  1708	
  1709		vc4_debugfs_add_regset32(drm, dsi->variant->debugfs_name, &dsi->regset);
  1710	
  1711		pm_runtime_enable(dev);
  1712	
  1713		return 0;
  1714	}
  1715	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

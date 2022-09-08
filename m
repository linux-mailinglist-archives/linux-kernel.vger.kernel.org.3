Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00EA5B1192
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiIHAqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIHAqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:46:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095906B8C6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 17:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662598002; x=1694134002;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q2II+pqlP31UjBbeOhUvkenmAced5uL/l+YMm+71tZ4=;
  b=Gacp/d0Zn5hXFiDJIfzjgCqq5UhblQpgasVVGgqavxTg4BXyLFYhxUh8
   wOl+Uf0/bHWk9gtHLhuvhjAO+hh4WMVaF8hMGseTaGGbGqKrfe77OxML9
   6wZr5Ftlhb0awafUfrxd/iXpMorosdrzjVgXa29YvEpijUcZNmfsVy7Eo
   8pESgw95KQvOiF49CeNHiTh5/WMJMETzxIMQAjfIlA/EV9+FoqzgfYs7O
   kcKhznHKFPKdZpaiOpXdV0SSlb0atg8ugbHCp3sFrphDjH7I0ugHCLFJN
   VXfPW/2nSQlBpOdBDr3vkO+0SEOlzaNriflCV2gHBIbUZuiFxsm/dqAzR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="277422452"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="277422452"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 17:46:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="756990131"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2022 17:46:40 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oW5gm-0007AI-0P;
        Thu, 08 Sep 2022 00:46:40 +0000
Date:   Thu, 8 Sep 2022 08:45:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bluetooth-v2 5/5]
 drivers/bluetooth/hci_bcm4377.c:1603:36: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202209080834.nKZYsCt2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bluetooth-v2
head:   ff2f8e18dcd6c6a316c37431de67c7374fe6ca5f
commit: ff2f8e18dcd6c6a316c37431de67c7374fe6ca5f [5/5] Bluetooth: hci_bcm4377: Add new driver for BCM4377 PCI boards
config: sparc-randconfig-s051-20220907 (https://download.01.org/0day-ci/archive/20220908/202209080834.nKZYsCt2-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/AsahiLinux/linux/commit/ff2f8e18dcd6c6a316c37431de67c7374fe6ca5f
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bluetooth-v2
        git checkout ff2f8e18dcd6c6a316c37431de67c7374fe6ca5f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/bluetooth/hci_bcm4377.c:1603:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] enabled_caps @@     got restricted __le16 [usertype] @@
   drivers/bluetooth/hci_bcm4377.c:1603:36: sparse:     expected restricted __le32 [usertype] enabled_caps
   drivers/bluetooth/hci_bcm4377.c:1603:36: sparse:     got restricted __le16 [usertype]

vim +1603 drivers/bluetooth/hci_bcm4377.c

  1582	
  1583	static int bcm4377_init_context(struct bcm4377_data *bcm4377)
  1584	{
  1585		struct device *dev = &bcm4377->pdev->dev;
  1586		dma_addr_t peripheral_info_dma;
  1587	
  1588		bcm4377->ctx = dmam_alloc_coherent(dev, sizeof(*bcm4377->ctx),
  1589						   &bcm4377->ctx_dma, GFP_KERNEL);
  1590		if (!bcm4377->ctx)
  1591			return -ENOMEM;
  1592		memset(bcm4377->ctx, 0, sizeof(*bcm4377->ctx));
  1593	
  1594		bcm4377->ring_state =
  1595			dmam_alloc_coherent(dev, sizeof(*bcm4377->ring_state),
  1596					    &bcm4377->ring_state_dma, GFP_KERNEL);
  1597		if (!bcm4377->ring_state)
  1598			return -ENOMEM;
  1599		memset(bcm4377->ring_state, 0, sizeof(*bcm4377->ring_state));
  1600	
  1601		bcm4377->ctx->version = cpu_to_le16(1);
  1602		bcm4377->ctx->size = cpu_to_le16(sizeof(*bcm4377->ctx));
> 1603		bcm4377->ctx->enabled_caps = cpu_to_le16(2);
  1604	
  1605		/*
  1606		 * The BT device will write 0x20 bytes of data to this buffer but
  1607		 * the exact contents are unknown. It only needs to exist for BT
  1608		 * to work such that we can just allocate and then ignore it.
  1609		 */
  1610		if (!dmam_alloc_coherent(&bcm4377->pdev->dev, 0x20,
  1611					 &peripheral_info_dma, GFP_KERNEL))
  1612			return -ENOMEM;
  1613		bcm4377->ctx->peripheral_info_addr = cpu_to_le64(peripheral_info_dma);
  1614	
  1615		bcm4377->ctx->xfer_ring_heads_addr = cpu_to_le64(
  1616			bcm4377->ring_state_dma +
  1617			offsetof(struct bcm4377_ring_state, xfer_ring_head));
  1618		bcm4377->ctx->xfer_ring_tails_addr = cpu_to_le64(
  1619			bcm4377->ring_state_dma +
  1620			offsetof(struct bcm4377_ring_state, xfer_ring_tail));
  1621		bcm4377->ctx->completion_ring_heads_addr = cpu_to_le64(
  1622			bcm4377->ring_state_dma +
  1623			offsetof(struct bcm4377_ring_state, completion_ring_head));
  1624		bcm4377->ctx->completion_ring_tails_addr = cpu_to_le64(
  1625			bcm4377->ring_state_dma +
  1626			offsetof(struct bcm4377_ring_state, completion_ring_tail));
  1627	
  1628		bcm4377->ctx->n_completion_rings =
  1629			cpu_to_le16(BCM4377_N_COMPLETION_RINGS);
  1630		bcm4377->ctx->n_xfer_rings = cpu_to_le16(BCM4377_N_TRANSFER_RINGS);
  1631	
  1632		bcm4377->ctx->control_completion_ring_addr =
  1633			cpu_to_le64(bcm4377->control_ack_ring.ring_dma);
  1634		bcm4377->ctx->control_completion_ring_n_entries =
  1635			cpu_to_le16(bcm4377->control_ack_ring.n_entries);
  1636		bcm4377->ctx->control_completion_ring_doorbell = cpu_to_le16(0xffff);
  1637		bcm4377->ctx->control_completion_ring_msi = 0;
  1638		bcm4377->ctx->control_completion_ring_header_size = 0;
  1639		bcm4377->ctx->control_completion_ring_footer_size = 0;
  1640	
  1641		bcm4377->ctx->control_xfer_ring_addr =
  1642			cpu_to_le64(bcm4377->control_h2d_ring.ring_dma);
  1643		bcm4377->ctx->control_xfer_ring_n_entries =
  1644			cpu_to_le16(bcm4377->control_h2d_ring.n_entries);
  1645		bcm4377->ctx->control_xfer_ring_doorbell =
  1646			cpu_to_le16(bcm4377->control_h2d_ring.doorbell);
  1647		bcm4377->ctx->control_xfer_ring_msi = 0;
  1648		bcm4377->ctx->control_xfer_ring_header_size = 0;
  1649		bcm4377->ctx->control_xfer_ring_footer_size =
  1650			bcm4377->control_h2d_ring.payload_size / 4;
  1651	
  1652		dev_dbg(&bcm4377->pdev->dev, "context initialized at IOVA %pad",
  1653			&bcm4377->ctx_dma);
  1654	
  1655		return 0;
  1656	}
  1657	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

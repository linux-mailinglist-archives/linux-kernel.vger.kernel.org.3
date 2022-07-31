Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21EC5861F3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 01:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238444AbiGaXVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 19:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiGaXVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 19:21:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0332FDEB0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 16:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659309660; x=1690845660;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f4IEgGE5h+g2oQnpTjKXUGd1oyOHi3FBvap1UhRVJNc=;
  b=LKzC9TCQjtoPJnYu/vyqA66NN5HQZrTeVvo5FYnRLSTpN3j5GsvXmWvv
   xp8cd58RJO69FT0xEQWjDB5ySvqHRMjvhgTqh7EIJLVtzmAU0f2T2Uz0/
   bjSEKPPlrXbtd22/2q+s8XbzYG6vtgxd3/7Ehw8U4umNRAOOplJnxpXcs
   MQ4hb3fxbNB1bhv2VvD2/Y71bYq98MGuLLYA5VY58S7ceSsa/WQR3ocQM
   RmZF90RGxhVkodcefkOhtoy0BLkgtEv4ibdzD8rEdx8eNa0EO8KmY5KnE
   bTHrkdd+v2j04cenEmFxJ+4yjWwBXl0Xgf8fNhUE2gGUidZrySSjDUfo3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="353038131"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="353038131"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 16:21:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="929352147"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 31 Jul 2022 16:20:58 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIIF0-000EcO-12;
        Sun, 31 Jul 2022 23:20:58 +0000
Date:   Mon, 1 Aug 2022 07:20:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/atheros/ag71xx.c:994:38: warning: passing
 argument 2 of 'ag71xx_hw_set_macaddr' discards 'const' qualifier from
 pointer target type
Message-ID: <202208010713.jcG50gwa-lkp@intel.com>
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

Hi Jakub,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3d7cb6b04c3f3115719235cc6866b10326de34cd
commit: adeef3e32146a8d2a73c399dc6f5d76a449131b1 net: constify netdev->dev_addr
date:   8 months ago
config: mips-randconfig-r033-20220801 (https://download.01.org/0day-ci/archive/20220801/202208010713.jcG50gwa-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=adeef3e32146a8d2a73c399dc6f5d76a449131b1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout adeef3e32146a8d2a73c399dc6f5d76a449131b1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/net/ethernet/atheros/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/atheros/ag71xx.c: In function 'ag71xx_fast_reset':
>> drivers/net/ethernet/atheros/ag71xx.c:994:38: warning: passing argument 2 of 'ag71xx_hw_set_macaddr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     994 |         ag71xx_hw_set_macaddr(ag, dev->dev_addr);
         |                                   ~~~^~~~~~~~~~
   drivers/net/ethernet/atheros/ag71xx.c:949:69: note: expected 'unsigned char *' but argument is of type 'const unsigned char *'
     949 | static void ag71xx_hw_set_macaddr(struct ag71xx *ag, unsigned char *mac)
         |                                                      ~~~~~~~~~~~~~~~^~~
   drivers/net/ethernet/atheros/ag71xx.c: In function 'ag71xx_open':
   drivers/net/ethernet/atheros/ag71xx.c:1452:39: warning: passing argument 2 of 'ag71xx_hw_set_macaddr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    1452 |         ag71xx_hw_set_macaddr(ag, ndev->dev_addr);
         |                                   ~~~~^~~~~~~~~~
   drivers/net/ethernet/atheros/ag71xx.c:949:69: note: expected 'unsigned char *' but argument is of type 'const unsigned char *'
     949 | static void ag71xx_hw_set_macaddr(struct ag71xx *ag, unsigned char *mac)
         |                                                      ~~~~~~~~~~~~~~~^~~


vim +994 drivers/net/ethernet/atheros/ag71xx.c

d51b6ce441d356 Oleksij Rempel 2019-05-24  961  
d51b6ce441d356 Oleksij Rempel 2019-05-24  962  static void ag71xx_fast_reset(struct ag71xx *ag)
d51b6ce441d356 Oleksij Rempel 2019-05-24  963  {
d51b6ce441d356 Oleksij Rempel 2019-05-24  964  	struct net_device *dev = ag->ndev;
d51b6ce441d356 Oleksij Rempel 2019-05-24  965  	u32 rx_ds;
d51b6ce441d356 Oleksij Rempel 2019-05-24  966  	u32 mii_reg;
d51b6ce441d356 Oleksij Rempel 2019-05-24  967  
d51b6ce441d356 Oleksij Rempel 2019-05-24  968  	ag71xx_hw_stop(ag);
d51b6ce441d356 Oleksij Rempel 2019-05-24  969  
d51b6ce441d356 Oleksij Rempel 2019-05-24  970  	mii_reg = ag71xx_rr(ag, AG71XX_REG_MII_CFG);
d51b6ce441d356 Oleksij Rempel 2019-05-24  971  	rx_ds = ag71xx_rr(ag, AG71XX_REG_RX_DESC);
d51b6ce441d356 Oleksij Rempel 2019-05-24  972  
d51b6ce441d356 Oleksij Rempel 2019-05-24  973  	ag71xx_tx_packets(ag, true);
d51b6ce441d356 Oleksij Rempel 2019-05-24  974  
d51b6ce441d356 Oleksij Rempel 2019-05-24  975  	reset_control_assert(ag->mac_reset);
d51b6ce441d356 Oleksij Rempel 2019-05-24  976  	usleep_range(10, 20);
d51b6ce441d356 Oleksij Rempel 2019-05-24  977  	reset_control_deassert(ag->mac_reset);
d51b6ce441d356 Oleksij Rempel 2019-05-24  978  	usleep_range(10, 20);
d51b6ce441d356 Oleksij Rempel 2019-05-24  979  
d51b6ce441d356 Oleksij Rempel 2019-05-24  980  	ag71xx_dma_reset(ag);
d51b6ce441d356 Oleksij Rempel 2019-05-24  981  	ag71xx_hw_setup(ag);
d51b6ce441d356 Oleksij Rempel 2019-05-24  982  	ag->tx_ring.curr = 0;
d51b6ce441d356 Oleksij Rempel 2019-05-24  983  	ag->tx_ring.dirty = 0;
d51b6ce441d356 Oleksij Rempel 2019-05-24  984  	netdev_reset_queue(ag->ndev);
d51b6ce441d356 Oleksij Rempel 2019-05-24  985  
d51b6ce441d356 Oleksij Rempel 2019-05-24  986  	/* setup max frame length */
d51b6ce441d356 Oleksij Rempel 2019-05-24  987  	ag71xx_wr(ag, AG71XX_REG_MAC_MFL,
d51b6ce441d356 Oleksij Rempel 2019-05-24  988  		  ag71xx_max_frame_len(ag->ndev->mtu));
d51b6ce441d356 Oleksij Rempel 2019-05-24  989  
d51b6ce441d356 Oleksij Rempel 2019-05-24  990  	ag71xx_wr(ag, AG71XX_REG_RX_DESC, rx_ds);
d51b6ce441d356 Oleksij Rempel 2019-05-24  991  	ag71xx_wr(ag, AG71XX_REG_TX_DESC, ag->tx_ring.descs_dma);
d51b6ce441d356 Oleksij Rempel 2019-05-24  992  	ag71xx_wr(ag, AG71XX_REG_MII_CFG, mii_reg);
d51b6ce441d356 Oleksij Rempel 2019-05-24  993  
d51b6ce441d356 Oleksij Rempel 2019-05-24 @994  	ag71xx_hw_set_macaddr(ag, dev->dev_addr);
d51b6ce441d356 Oleksij Rempel 2019-05-24  995  }
d51b6ce441d356 Oleksij Rempel 2019-05-24  996  

:::::: The code at line 994 was first introduced by commit
:::::: d51b6ce441d356369387d20bc1de5f2edb0ab71e net: ethernet: add ag71xx driver

:::::: TO: Oleksij Rempel <o.rempel@pengutronix.de>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

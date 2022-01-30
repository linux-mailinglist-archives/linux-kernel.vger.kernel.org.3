Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63014A37CE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 18:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355691AbiA3REE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 12:04:04 -0500
Received: from mga12.intel.com ([192.55.52.136]:4840 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232042AbiA3RED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 12:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643562243; x=1675098243;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jtyIfqdGTJPzw268dJvpfYWED4kW5sY/lhmgescFfYg=;
  b=OYEhFbgyfNE9U0ee9+x9WVZCe3hGRFElF+4i3KLEg/6kz/OF73Rx/DMg
   ixqNH+3dgENX3oztJJoK/7gjUBQNBUUY5YmBwLg2Vm9W8U66JMWdtxe00
   MqrBkw+9kYYDeJiV+mBMHzYj2yJ+KLo/MtEglCr9sa1Eg/iGmBfG66y8b
   M/y9pYb3ra4VVAFQgYGZRvbM8N/VTUeTetnkWb3yFeWNvhEJTEXJEKtGR
   h8Yv/0Zj5Ka2jj3LeCjJkrExhDzl+lTMoZALtuC//wRkVEXYCLnc7OQF8
   bplNM19g8fWkEwvWvybFH/Zwr8x0QOxm6UBNpQyM0p8s5p7a5dvzGjAco
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="227334878"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="227334878"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 09:03:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="564748659"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 30 Jan 2022 09:03:44 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEDc7-000Qlk-IP; Sun, 30 Jan 2022 17:03:43 +0000
Date:   Mon, 31 Jan 2022 01:02:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: drivers/net/ethernet/smsc/smc911x.c:1674 smc911x_ethtool_seteeprom()
 warn: inconsistent indenting
Message-ID: <202201310032.hJJ6daS7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   24f4db1f3a2725a6308105081d822b26889e1018
commit: 7958ba7e6273a02f49432a2506958d0f59b5b8da drivers: net: smsc: Add COMPILE_TEST support
date:   1 year, 3 months ago
config: powerpc-randconfig-m031-20220130 (https://download.01.org/0day-ci/archive/20220131/202201310032.hJJ6daS7-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/net/ethernet/smsc/smc911x.c:1674 smc911x_ethtool_seteeprom() warn: inconsistent indenting

vim +1674 drivers/net/ethernet/smsc/smc911x.c

0a0c72c9118c4e drivers/net/smc911x.c Dustin McIntire 2006-04-19  1655  
0a0c72c9118c4e drivers/net/smc911x.c Dustin McIntire 2006-04-19  1656  static int smc911x_ethtool_seteeprom(struct net_device *dev,
0a0c72c9118c4e drivers/net/smc911x.c Dustin McIntire 2006-04-19  1657  									   struct ethtool_eeprom *eeprom, u8 *data)
0a0c72c9118c4e drivers/net/smc911x.c Dustin McIntire 2006-04-19  1658  {
0a0c72c9118c4e drivers/net/smc911x.c Dustin McIntire 2006-04-19  1659  	int i, ret;
0a0c72c9118c4e drivers/net/smc911x.c Dustin McIntire 2006-04-19  1660  
0a0c72c9118c4e drivers/net/smc911x.c Dustin McIntire 2006-04-19  1661  	/* Enable erase */
0a0c72c9118c4e drivers/net/smc911x.c Dustin McIntire 2006-04-19  1662  	if ((ret=smc911x_ethtool_write_eeprom_cmd(dev, E2P_CMD_EPC_CMD_EWEN_, 0 ))!=0)
0a0c72c9118c4e drivers/net/smc911x.c Dustin McIntire 2006-04-19  1663  		return ret;
0a0c72c9118c4e drivers/net/smc911x.c Dustin McIntire 2006-04-19  1664  	for(i=eeprom->offset;i<(eeprom->offset+eeprom->len);i++) {
0a0c72c9118c4e drivers/net/smc911x.c Dustin McIntire 2006-04-19  1665  		/* erase byte */
0a0c72c9118c4e drivers/net/smc911x.c Dustin McIntire 2006-04-19  1666  		if ((ret=smc911x_ethtool_write_eeprom_cmd(dev, E2P_CMD_EPC_CMD_ERASE_, i ))!=0)
0a0c72c9118c4e drivers/net/smc911x.c Dustin McIntire 2006-04-19  1667  			return ret;
0a0c72c9118c4e drivers/net/smc911x.c Dustin McIntire 2006-04-19  1668  		/* write byte */
0a0c72c9118c4e drivers/net/smc911x.c Dustin McIntire 2006-04-19  1669  		if ((ret=smc911x_ethtool_write_eeprom_byte(dev, *data))!=0)
0a0c72c9118c4e drivers/net/smc911x.c Dustin McIntire 2006-04-19  1670  			 return ret;
0a0c72c9118c4e drivers/net/smc911x.c Dustin McIntire 2006-04-19  1671  		if ((ret=smc911x_ethtool_write_eeprom_cmd(dev, E2P_CMD_EPC_CMD_WRITE_, i ))!=0)
0a0c72c9118c4e drivers/net/smc911x.c Dustin McIntire 2006-04-19  1672  			return ret;
0a0c72c9118c4e drivers/net/smc911x.c Dustin McIntire 2006-04-19  1673  		}
0a0c72c9118c4e drivers/net/smc911x.c Dustin McIntire 2006-04-19 @1674  	 return 0;
0a0c72c9118c4e drivers/net/smc911x.c Dustin McIntire 2006-04-19  1675  }
0a0c72c9118c4e drivers/net/smc911x.c Dustin McIntire 2006-04-19  1676  

:::::: The code at line 1674 was first introduced by commit
:::::: 0a0c72c9118c4e63080eb409f0cfdf15808d23a4 [PATCH] RE: [PATCH 1/1] net driver: Add support for SMSC LAN911x line of ethernet chips

:::::: TO: Dustin McIntire <dustin@sensoria.com>
:::::: CC: Jeff Garzik <jeff@garzik.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

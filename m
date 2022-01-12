Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7529D48CB27
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356407AbiALSkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 13:40:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:50760 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356388AbiALSkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:40:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642012835; x=1673548835;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TZ4aM5IQQom5ar2CExCg74a13ewh2w7ChBIvKknj8NU=;
  b=RssHCoEt/X+mxFxjuQcIN3whE7q1yaR6tACUXBLaCAP8TW29D9NjSz/2
   bfvdz8Wi5yKAl07V5OZ1JjRS1RSmKQoGeM+cLjJy6lHcv5zUhvAXAYQnw
   7wQyPL6UsvCJZKxtdqhKcbZlY44wMACaoIS3uWXMSbnpeqM8CT4hpHWzo
   FHGrnv4tTJdb9yfY/i6d2bl5J+2lLfUKZh7eaKgXNga8TqoqokYhO8hRf
   MXsie6GJ83f/lW7DhHa9o94vv17YmN+9+wLn0zUoykpC3i/jAAcS0qAYo
   m9b6Gz2KdkVhKDSK8+YDtXAPtXSNImxxg/dpTKGBleOlWO9wd2o402IWW
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="243614442"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="243614442"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 10:33:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="475008495"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 12 Jan 2022 10:33:07 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7iQl-0006EF-1r; Wed, 12 Jan 2022 18:33:07 +0000
Date:   Thu, 13 Jan 2022 02:32:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rmk-arm:zii 126/163] drivers/net/dsa/qca8k.c:1479:1: warning:
 conflicting types for 'qca8k_mac_config_setup_internal_delay'; have
 'void(struct qca8k_priv *, int,  u32)' {aka 'void(struct qca8k_priv *, int,
  unsigned int)'}
Message-ID: <202201130213.dT2X0nSH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm zii
head:   75fbe1376b387397df2fa36fefb21919e1810507
commit: 0f97877cdf828e5a96b14fbb2d9d49600d54dd8e [126/163] net: dsa: qca8k: convert to use phylink_pcs
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220113/202201130213.dT2X0nSH-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm zii
        git checkout 0f97877cdf828e5a96b14fbb2d9d49600d54dd8e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash drivers/net/dsa/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/dsa/qca8k.c: In function 'qca8k_pcs_config':
   drivers/net/dsa/qca8k.c:1185:17: error: implicit declaration of function 'qca8k_mac_config_setup_internal_delay' [-Werror=implicit-function-declaration]
    1185 |                 qca8k_mac_config_setup_internal_delay(priv, cpu_port_index, reg);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/qca8k.c: At top level:
>> drivers/net/dsa/qca8k.c:1479:1: warning: conflicting types for 'qca8k_mac_config_setup_internal_delay'; have 'void(struct qca8k_priv *, int,  u32)' {aka 'void(struct qca8k_priv *, int,  unsigned int)'}
    1479 | qca8k_mac_config_setup_internal_delay(struct qca8k_priv *priv, int cpu_port_index,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/qca8k.c:1479:1: error: static declaration of 'qca8k_mac_config_setup_internal_delay' follows non-static declaration
   drivers/net/dsa/qca8k.c:1185:17: note: previous implicit declaration of 'qca8k_mac_config_setup_internal_delay' with type 'void(struct qca8k_priv *, int,  u32)' {aka 'void(struct qca8k_priv *, int,  unsigned int)'}
    1185 |                 qca8k_mac_config_setup_internal_delay(priv, cpu_port_index, reg);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1479 drivers/net/dsa/qca8k.c

0f97877cdf828e Russell King (Oracle  2021-11-23  1477) 
cef08115846e58 Ansuel Smith          2021-10-14  1478  static void
cef08115846e58 Ansuel Smith          2021-10-14 @1479  qca8k_mac_config_setup_internal_delay(struct qca8k_priv *priv, int cpu_port_index,
cef08115846e58 Ansuel Smith          2021-10-14  1480  				      u32 reg)
cef08115846e58 Ansuel Smith          2021-10-14  1481  {
cef08115846e58 Ansuel Smith          2021-10-14  1482  	u32 delay, val = 0;
cef08115846e58 Ansuel Smith          2021-10-14  1483  	int ret;
cef08115846e58 Ansuel Smith          2021-10-14  1484  
cef08115846e58 Ansuel Smith          2021-10-14  1485  	/* Delay can be declared in 3 different way.
cef08115846e58 Ansuel Smith          2021-10-14  1486  	 * Mode to rgmii and internal-delay standard binding defined
cef08115846e58 Ansuel Smith          2021-10-14  1487  	 * rgmii-id or rgmii-tx/rx phy mode set.
cef08115846e58 Ansuel Smith          2021-10-14  1488  	 * The parse logic set a delay different than 0 only when one
cef08115846e58 Ansuel Smith          2021-10-14  1489  	 * of the 3 different way is used. In all other case delay is
cef08115846e58 Ansuel Smith          2021-10-14  1490  	 * not enabled. With ID or TX/RXID delay is enabled and set
cef08115846e58 Ansuel Smith          2021-10-14  1491  	 * to the default and recommended value.
cef08115846e58 Ansuel Smith          2021-10-14  1492  	 */
fd0bb28c547f7c Ansuel Smith          2021-10-14  1493  	if (priv->ports_config.rgmii_tx_delay[cpu_port_index]) {
fd0bb28c547f7c Ansuel Smith          2021-10-14  1494  		delay = priv->ports_config.rgmii_tx_delay[cpu_port_index];
cef08115846e58 Ansuel Smith          2021-10-14  1495  
cef08115846e58 Ansuel Smith          2021-10-14  1496  		val |= QCA8K_PORT_PAD_RGMII_TX_DELAY(delay) |
cef08115846e58 Ansuel Smith          2021-10-14  1497  			QCA8K_PORT_PAD_RGMII_TX_DELAY_EN;
cef08115846e58 Ansuel Smith          2021-10-14  1498  	}
cef08115846e58 Ansuel Smith          2021-10-14  1499  
fd0bb28c547f7c Ansuel Smith          2021-10-14  1500  	if (priv->ports_config.rgmii_rx_delay[cpu_port_index]) {
fd0bb28c547f7c Ansuel Smith          2021-10-14  1501  		delay = priv->ports_config.rgmii_rx_delay[cpu_port_index];
cef08115846e58 Ansuel Smith          2021-10-14  1502  
cef08115846e58 Ansuel Smith          2021-10-14  1503  		val |= QCA8K_PORT_PAD_RGMII_RX_DELAY(delay) |
cef08115846e58 Ansuel Smith          2021-10-14  1504  			QCA8K_PORT_PAD_RGMII_RX_DELAY_EN;
cef08115846e58 Ansuel Smith          2021-10-14  1505  	}
cef08115846e58 Ansuel Smith          2021-10-14  1506  
cef08115846e58 Ansuel Smith          2021-10-14  1507  	/* Set RGMII delay based on the selected values */
cef08115846e58 Ansuel Smith          2021-10-14  1508  	ret = qca8k_rmw(priv, reg,
cef08115846e58 Ansuel Smith          2021-10-14  1509  			QCA8K_PORT_PAD_RGMII_TX_DELAY_MASK |
cef08115846e58 Ansuel Smith          2021-10-14  1510  			QCA8K_PORT_PAD_RGMII_RX_DELAY_MASK |
cef08115846e58 Ansuel Smith          2021-10-14  1511  			QCA8K_PORT_PAD_RGMII_TX_DELAY_EN |
cef08115846e58 Ansuel Smith          2021-10-14  1512  			QCA8K_PORT_PAD_RGMII_RX_DELAY_EN,
cef08115846e58 Ansuel Smith          2021-10-14  1513  			val);
cef08115846e58 Ansuel Smith          2021-10-14  1514  	if (ret)
cef08115846e58 Ansuel Smith          2021-10-14  1515  		dev_err(priv->dev, "Failed to set internal delay for CPU port%d",
cef08115846e58 Ansuel Smith          2021-10-14  1516  			cpu_port_index == QCA8K_CPU_PORT0 ? 0 : 6);
cef08115846e58 Ansuel Smith          2021-10-14  1517  }
cef08115846e58 Ansuel Smith          2021-10-14  1518  

:::::: The code at line 1479 was first introduced by commit
:::::: cef08115846e581f80ff99abf7bf218da1840616 net: dsa: qca8k: set internal delay also for sgmii

:::::: TO: Ansuel Smith <ansuelsmth@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

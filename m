Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A5A475755
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbhLOLHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:07:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:25992 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241895AbhLOLG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639566419; x=1671102419;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+9v6HklrEHaUKQQTxfWKtZY1fc5zCJpba60VCSVAPdo=;
  b=F3yfX+VxmXI1XrglswJkNH999Bnd/mGlkK8X6ttNf9TdirVYCFjBmLfn
   0XIPSE5a+KBo95Z1C5JfPco5ijOPEr6kHFwqihSaeFHrWD41ny8wO5c/2
   rh8apdch2KaOGcrHiUOITlq/vHmmPXUp2MEYG7RF0FL9l2J24i2J8pZG+
   JapB6yJF/yR/RFyzOoPxZzJDJ+s2ZR88xnLqBa7L95+eB5CLrBal09YxV
   0ct3Pj9ySTzdQWZd92lGO7IRaEGgvV7FRc0yjxCfQLQvGN/beaSMJCfkP
   tWEY2xhDVLCtDEP4tX5Rv12yL/tik5HQ2azXAlmwSFE2IhHe7rLNjq/VA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="325482734"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="325482734"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 03:06:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="614664929"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Dec 2021 03:06:57 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxS7c-0001eR-Rq; Wed, 15 Dec 2021 11:06:56 +0000
Date:   Wed, 15 Dec 2021 19:06:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [rmk-arm:zii 147/186]
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1531:49: error:
 incompatible pointer types passing 'struct phylink_config *' to parameter of
 type 'struct phylink_pcs *'
Message-ID: <202112151831.VAQ7h5FH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm zii
head:   d3ebd79d7fb6476e2409c147e4dcc304733f7ae6
commit: dc659b3d109e3e55a76c0ed143119dad7b369ec8 [147/186] net: axienet: convert to phylink_pcs
config: x86_64-randconfig-r016-20211214 (https://download.01.org/0day-ci/archive/20211215/202112151831.VAQ7h5FH-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm zii
        git checkout dc659b3d109e3e55a76c0ed143119dad7b369ec8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/dsa/ drivers/net/ethernet/xilinx/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1531:49: error: incompatible pointer types passing 'struct phylink_config *' to parameter of type 'struct phylink_pcs *' [-Werror,-Wincompatible-pointer-types]
           struct net_device *ndev = pcs_to_axienet_local(pcs)->ndev;
                                                          ^~~
   drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1506:71: note: passing argument to parameter 'pcs' here
   static struct axienet_local *pcs_to_axienet_local(struct phylink_pcs *pcs)
                                                                         ^
   drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1532:53: error: incompatible pointer types passing 'struct phylink_config *' to parameter of type 'struct phylink_pcs *' [-Werror,-Wincompatible-pointer-types]
           struct mdio_device *pcs_phy = pcs_to_axienet_local(pcs)->pcs_phy;
                                                              ^~~
   drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1506:71: note: passing argument to parameter 'pcs' here
   static struct axienet_local *pcs_to_axienet_local(struct phylink_pcs *pcs)
                                                                         ^
>> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1537:8: error: use of undeclared identifier 'iface'
                               iface == PHY_INTERFACE_MODE_SGMII ?
                               ^
>> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1554:16: error: incompatible function pointer types initializing 'int (*)(struct phylink_pcs *, unsigned int, phy_interface_t, const unsigned long *, bool)' (aka 'int (*)(struct phylink_pcs *, unsigned int, phy_interface_t, const unsigned long *, _Bool)') with an expression of type 'int (struct phylink_config *, unsigned int, phy_interface_t, const unsigned long *, bool)' (aka 'int (struct phylink_config *, unsigned int, phy_interface_t, const unsigned long *, _Bool)') [-Werror,-Wincompatible-function-pointer-types]
           .pcs_config = axienet_pcs_config,
                         ^~~~~~~~~~~~~~~~~~
   4 errors generated.


vim +1531 drivers/net/ethernet/xilinx/xilinx_axienet_main.c

  1525	
  1526	static int axienet_pcs_config(struct phylink_config *pcs, unsigned int mode,
  1527				      phy_interface_t interface,
  1528				      const unsigned long *advertising,
  1529				      bool permit_pause_to_mac)
  1530	{
> 1531		struct net_device *ndev = pcs_to_axienet_local(pcs)->ndev;
  1532		struct mdio_device *pcs_phy = pcs_to_axienet_local(pcs)->pcs_phy;
  1533		int ret;
  1534	
  1535		ret = mdiobus_write(pcs_phy->bus, pcs_phy->addr,
  1536				    XLNX_MII_STD_SELECT_REG,
> 1537				    iface == PHY_INTERFACE_MODE_SGMII ?
  1538					XLNX_MII_STD_SELECT_SGMII : 0);
  1539		if (ret < 0) {
  1540			netdev_warn(ndev, "Failed to switch PHY interface: %d\n",
  1541				    ret);
  1542			return ret;
  1543		}
  1544	
  1545		ret = phylink_mii_c22_pcs_config(pcs_phy, mode, interface, advertising);
  1546		if (ret < 0)
  1547			netdev_warn(ndev, "Failed to configure PCS: %d\n", ret);
  1548	
  1549		return ret;
  1550	}
  1551	
  1552	static const struct phylink_pcs_ops axienet_pcs_ops = {
  1553		.pcs_get_state = axienet_pcs_get_state,
> 1554		.pcs_config = axienet_pcs_config,
  1555		.pcs_an_restart = axienet_pcs_an_restart,
  1556	};
  1557	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

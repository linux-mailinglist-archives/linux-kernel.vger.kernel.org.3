Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7AF5897FA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 08:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239003AbiHDG7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 02:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238670AbiHDG7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 02:59:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788AA61D49
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 23:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659596384; x=1691132384;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oo0QydfFgPu9tN5HYc2vBCLZY53oi9FTF6m3VjzzJGs=;
  b=jsVnPy2iZxuZoZmziU934p9Y6LHH0b0rIKkYzP8I+7V+0lqag+Rq7224
   N/Qapd/18hFVrQ+mHWjM2jhs8g35TZNJvCWrpnUfIBgpyeMuLuYmjGC9Q
   ENjvGFrApP4Ry8ICtL0xvqMtjkNAQYTOPPZPusf42XE5yNcpLbe9W/XWp
   mYiSomfB6LCGKn/Mi+jaWhxR6PgCtLdmY/Zdx95tVWN/AqqMlwOdbLUoK
   i7Iq0UdmcVF7+3ETA4IZKd9Pu/C563vtupU/AWtv7i0UITxqGdKpx4ZuO
   91yK/A2n/wqcv3LSySaWDhGfKskmE8fOuO8Xy4GiHUxx1nBxli6Tiq286
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="272902716"
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="272902716"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 23:59:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="671159787"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Aug 2022 23:59:42 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJUpZ-000I6Z-3B;
        Thu, 04 Aug 2022 06:59:41 +0000
Date:   Thu, 4 Aug 2022 14:59:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: [rmk-arm:zii 15/87] drivers/net/dsa/microchip/ksz9477.c:1334:35:
 error: initialization of 'void (*)(struct dsa_switch *, int,  struct
 phylink_config *, phy_interface_t *)' from incompatible pointer type 'void
 (*)(struct dsa_switch *, int,  struct phylink_config *)'
Message-ID: <202208041428.DxKaemL1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm zii
head:   315d00812d1f8ed8bbbce4e4fd8d32fc883900a0
commit: 8ed5becb72c09d9835bedc0bdaf431cc23f8b7de [15/87] net: dsa: add support for retrieving the interface mode
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220804/202208041428.DxKaemL1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm zii
        git checkout 8ed5becb72c09d9835bedc0bdaf431cc23f8b7de
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/dsa/microchip/ksz9477.c:1334:35: error: initialization of 'void (*)(struct dsa_switch *, int,  struct phylink_config *, phy_interface_t *)' from incompatible pointer type 'void (*)(struct dsa_switch *, int,  struct phylink_config *)' [-Werror=incompatible-pointer-types]
    1334 |         .phylink_get_caps       = ksz9477_get_caps,
         |                                   ^~~~~~~~~~~~~~~~
   drivers/net/dsa/microchip/ksz9477.c:1334:35: note: (near initialization for 'ksz9477_switch_ops.phylink_get_caps')
   cc1: some warnings being treated as errors


vim +1334 drivers/net/dsa/microchip/ksz9477.c

c2e866911e25406 Tristram Ha       2018-11-20  1327  
c2e866911e25406 Tristram Ha       2018-11-20  1328  static const struct dsa_switch_ops ksz9477_switch_ops = {
c2e866911e25406 Tristram Ha       2018-11-20  1329  	.get_tag_protocol	= ksz9477_get_tag_protocol,
c2e866911e25406 Tristram Ha       2018-11-20  1330  	.setup			= ksz9477_setup,
c2e866911e25406 Tristram Ha       2018-11-20  1331  	.phy_read		= ksz9477_phy_read16,
c2e866911e25406 Tristram Ha       2018-11-20  1332  	.phy_write		= ksz9477_phy_write16,
143a102e3090532 Codrin Ciubotariu 2020-07-02  1333  	.phylink_mac_link_down	= ksz_mac_link_down,
65ac79e1812016d Arun Ramadoss     2022-05-17 @1334  	.phylink_get_caps	= ksz9477_get_caps,
c2e866911e25406 Tristram Ha       2018-11-20  1335  	.port_enable		= ksz_enable_port,
997d2126ac61128 Arun Ramadoss     2022-05-17  1336  	.get_strings		= ksz_get_strings,
c2e866911e25406 Tristram Ha       2018-11-20  1337  	.get_ethtool_stats	= ksz_get_ethtool_stats,
c2e866911e25406 Tristram Ha       2018-11-20  1338  	.get_sset_count		= ksz_sset_count,
c2e866911e25406 Tristram Ha       2018-11-20  1339  	.port_bridge_join	= ksz_port_bridge_join,
c2e866911e25406 Tristram Ha       2018-11-20  1340  	.port_bridge_leave	= ksz_port_bridge_leave,
c2e866911e25406 Tristram Ha       2018-11-20  1341  	.port_stp_state_set	= ksz9477_port_stp_state_set,
c2e866911e25406 Tristram Ha       2018-11-20  1342  	.port_fast_age		= ksz_port_fast_age,
c2e866911e25406 Tristram Ha       2018-11-20  1343  	.port_vlan_filtering	= ksz9477_port_vlan_filtering,
c2e866911e25406 Tristram Ha       2018-11-20  1344  	.port_vlan_add		= ksz9477_port_vlan_add,
c2e866911e25406 Tristram Ha       2018-11-20  1345  	.port_vlan_del		= ksz9477_port_vlan_del,
c2e866911e25406 Tristram Ha       2018-11-20  1346  	.port_fdb_dump		= ksz9477_port_fdb_dump,
c2e866911e25406 Tristram Ha       2018-11-20  1347  	.port_fdb_add		= ksz9477_port_fdb_add,
c2e866911e25406 Tristram Ha       2018-11-20  1348  	.port_fdb_del		= ksz9477_port_fdb_del,
c2e866911e25406 Tristram Ha       2018-11-20  1349  	.port_mdb_add           = ksz9477_port_mdb_add,
c2e866911e25406 Tristram Ha       2018-11-20  1350  	.port_mdb_del           = ksz9477_port_mdb_del,
c2e866911e25406 Tristram Ha       2018-11-20  1351  	.port_mirror_add	= ksz9477_port_mirror_add,
c2e866911e25406 Tristram Ha       2018-11-20  1352  	.port_mirror_del	= ksz9477_port_mirror_del,
c6101dd7ffb8b7f Arun Ramadoss     2022-04-26  1353  	.get_stats64		= ksz_get_stats64,
e18058ea9986032 Oleksij Rempel    2022-03-08  1354  	.port_change_mtu	= ksz9477_change_mtu,
e18058ea9986032 Oleksij Rempel    2022-03-08  1355  	.port_max_mtu		= ksz9477_max_mtu,
c2e866911e25406 Tristram Ha       2018-11-20  1356  };
c2e866911e25406 Tristram Ha       2018-11-20  1357  

:::::: The code at line 1334 was first introduced by commit
:::::: 65ac79e1812016d7c5760872736802f985ec7455 net: dsa: microchip: add the phylink get_caps

:::::: TO: Arun Ramadoss <arun.ramadoss@microchip.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

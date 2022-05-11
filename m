Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3DF522BDD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiEKFof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240481AbiEKFob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:44:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E95244F1C
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652247870; x=1683783870;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O/LKqF2r6cXVe/FaTSWKC+U4U0uUtqbT/QPMs+Ecj98=;
  b=Pc64qkSZ94IswpUrL9xJ6H8Ug8edWuyvHkMlz9AS8X35bSCRpBq+IlR+
   BiYIUy2LD87lfzrKE1YlGzlyuBztQyPcT/wyXc6MOg1y3GkkRKQpTOkFp
   mhVD+63bpFd7+VsOabPrmVtRabzw+6Hd97iJTzeVDmsmQUt2mullJmLs/
   l771dfZFv+DvkkxgohUEZjLAPfFGtCmpFxjkhwGDHSZhSjI7bRV4EtX4n
   X/nFzFpmM7oDS3b4zlmCkoAk4zIj7o6VLG67eEwyKz9BjwZDcaNE2wvFd
   ns0WDn1A/xFlALbd5ftbL0xCiEEbShrCZIHv5Ho3Uqle461vyz+61pGzd
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269529367"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="269529367"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 22:44:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="520368411"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 10 May 2022 22:44:28 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nof99-000IlQ-Tx;
        Wed, 11 May 2022 05:44:27 +0000
Date:   Wed, 11 May 2022 13:43:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Torsten Duwe <duwe@suse.de>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c:50:17: warning:
 'anx781x_i2c_addresses' defined but not used
Message-ID: <202205111306.DCEG8q0G-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   feb9c5e19e913b53cb536a7aa7c9f20107bb51ec
commit: 5d97408e0d70a7c7c5942ba95260bab7c9e21eb4 drm/bridge: move ANA78xx driver to analogix subdirectory
date:   2 years, 6 months ago
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220511/202205111306.DCEG8q0G-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d97408e0d70a7c7c5942ba95260bab7c9e21eb4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5d97408e0d70a7c7c5942ba95260bab7c9e21eb4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/bridge/analogix/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c:50:17: warning: 'anx781x_i2c_addresses' defined but not used [-Wunused-const-variable=]
      50 | static const u8 anx781x_i2c_addresses[] = {
         |                 ^~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c:42:17: warning: 'anx7808_i2c_addresses' defined but not used [-Wunused-const-variable=]
      42 | static const u8 anx7808_i2c_addresses[] = {
         |                 ^~~~~~~~~~~~~~~~~~~~~


vim +/anx781x_i2c_addresses +50 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c

0647e7dd3f7ab2e drivers/gpu/drm/bridge/analogix-anx78xx.c Enric Balletbo i Serra 2016-05-02  41  
025910db8057f60 drivers/gpu/drm/bridge/analogix-anx78xx.c Brian Masney           2019-09-22 @42  static const u8 anx7808_i2c_addresses[] = {
025910db8057f60 drivers/gpu/drm/bridge/analogix-anx78xx.c Brian Masney           2019-09-22  43  	[I2C_IDX_TX_P0] = 0x78,
025910db8057f60 drivers/gpu/drm/bridge/analogix-anx78xx.c Brian Masney           2019-09-22  44  	[I2C_IDX_TX_P1] = 0x7a,
025910db8057f60 drivers/gpu/drm/bridge/analogix-anx78xx.c Brian Masney           2019-09-22  45  	[I2C_IDX_TX_P2] = 0x72,
025910db8057f60 drivers/gpu/drm/bridge/analogix-anx78xx.c Brian Masney           2019-09-22  46  	[I2C_IDX_RX_P0] = 0x7e,
025910db8057f60 drivers/gpu/drm/bridge/analogix-anx78xx.c Brian Masney           2019-09-22  47  	[I2C_IDX_RX_P1] = 0x80,
025910db8057f60 drivers/gpu/drm/bridge/analogix-anx78xx.c Brian Masney           2019-09-22  48  };
025910db8057f60 drivers/gpu/drm/bridge/analogix-anx78xx.c Brian Masney           2019-09-22  49  
025910db8057f60 drivers/gpu/drm/bridge/analogix-anx78xx.c Brian Masney           2019-09-22 @50  static const u8 anx781x_i2c_addresses[] = {
025910db8057f60 drivers/gpu/drm/bridge/analogix-anx78xx.c Brian Masney           2019-09-22  51  	[I2C_IDX_TX_P0] = 0x70,
025910db8057f60 drivers/gpu/drm/bridge/analogix-anx78xx.c Brian Masney           2019-09-22  52  	[I2C_IDX_TX_P1] = 0x7a,
025910db8057f60 drivers/gpu/drm/bridge/analogix-anx78xx.c Brian Masney           2019-09-22  53  	[I2C_IDX_TX_P2] = 0x72,
025910db8057f60 drivers/gpu/drm/bridge/analogix-anx78xx.c Brian Masney           2019-09-22  54  	[I2C_IDX_RX_P0] = 0x7e,
025910db8057f60 drivers/gpu/drm/bridge/analogix-anx78xx.c Brian Masney           2019-09-22  55  	[I2C_IDX_RX_P1] = 0x80,
0647e7dd3f7ab2e drivers/gpu/drm/bridge/analogix-anx78xx.c Enric Balletbo i Serra 2016-05-02  56  };
0647e7dd3f7ab2e drivers/gpu/drm/bridge/analogix-anx78xx.c Enric Balletbo i Serra 2016-05-02  57  

:::::: The code at line 50 was first introduced by commit
:::::: 025910db8057f60d2d2aa11002f7751e3eb66588 drm/bridge: analogix-anx78xx: add support for 7808 addresses

:::::: TO: Brian Masney <masneyb@onstation.org>
:::::: CC: Andrzej Hajda <a.hajda@samsung.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

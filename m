Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEA155EB62
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiF1Ryb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiF1Rya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:54:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF65B3B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656438869; x=1687974869;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=62UUQtPBrUyjXwSeHOXWTbRsKUZACuje4XlOW4Rn+5o=;
  b=WH7e5dfRyWRKzqPld26vIMzCbOLgC8yNB1mSEKFWPg6Kw4FoRuhJbz+9
   Eq9bRcsFyspJ4O4vrpeMWGNZAponybdxk+2g7RrTpRVTYcwkKREcjR83r
   gjjyJTQIOaUAodyACkz7ZN88Q3Ck3qgQ4Ix9Z0MNNglM29JsGsK4fr4r5
   PQzJe9+rEuhRCPJDvW+wku4GomjkGa+R08OvgIsLQeBv+gdpXZLvXJD1m
   b0ySvaNfzBV5vVEAhWAqv/7arLpsEef8ZCTgKwMAbA+um8hm2aU55uzlw
   fm7VI+/dL4bO1m0c/PC5JJP4OLkoMVHUqSRXi3I4Fwcxq23dYYKFdxFm1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="262219133"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="262219133"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 10:54:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="917272001"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2022 10:54:27 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6FPu-000ATu-O2;
        Tue, 28 Jun 2022 17:54:26 +0000
Date:   Wed, 29 Jun 2022 01:54:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_devlink_locking 21/21]
 drivers/net/ethernet/mellanox/mlxsw/core.c:1500:12: error: too few arguments
 to function call, single argument 'devlink' was not specified
Message-ID: <202206290125.jdxf7M7R-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_devlink_locking
head:   9162f3d685ec59a9811d91e44c3f79c51714d077
commit: 9162f3d685ec59a9811d91e44c3f79c51714d077 [21/21] x
config: x86_64-randconfig-a004-20220627 (https://download.01.org/0day-ci/archive/20220629/202206290125.jdxf7M7R-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project df18167ac56d05f2ab55f9d874aee7ab6d5bc9a2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/9162f3d685ec59a9811d91e44c3f79c51714d077
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_devlink_locking
        git checkout 9162f3d685ec59a9811d91e44c3f79c51714d077
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/ethernet/mellanox/mlxsw/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/mellanox/mlxsw/core.c:1500:12: error: too few arguments to function call, single argument 'devlink' was not specified
           devl_lock();
           ~~~~~~~~~ ^
   include/net/devlink.h:1518:6: note: 'devl_lock' declared here
   void devl_lock(struct devlink *devlink);
        ^
   drivers/net/ethernet/mellanox/mlxsw/core.c:1505:14: error: too few arguments to function call, single argument 'devlink' was not specified
           devl_unlock();
           ~~~~~~~~~~~ ^
   include/net/devlink.h:1519:6: note: 'devl_unlock' declared here
   void devl_unlock(struct devlink *devlink);
        ^
   drivers/net/ethernet/mellanox/mlxsw/core.c:1517:12: error: too few arguments to function call, single argument 'devlink' was not specified
           devl_lock();
           ~~~~~~~~~ ^
   include/net/devlink.h:1518:6: note: 'devl_lock' declared here
   void devl_lock(struct devlink *devlink);
        ^
   drivers/net/ethernet/mellanox/mlxsw/core.c:1524:14: error: too few arguments to function call, single argument 'devlink' was not specified
           devl_unlock();
           ~~~~~~~~~~~ ^
   include/net/devlink.h:1519:6: note: 'devl_unlock' declared here
   void devl_unlock(struct devlink *devlink);
        ^
   4 errors generated.
--
>> drivers/net/ethernet/mellanox/mlxsw/i2c.c:643:12: error: too few arguments to function call, single argument 'devlink' was not specified
           devl_lock();
           ~~~~~~~~~ ^
   include/net/devlink.h:1518:6: note: 'devl_lock' declared here
   void devl_lock(struct devlink *devlink);
        ^
   drivers/net/ethernet/mellanox/mlxsw/i2c.c:647:14: error: too few arguments to function call, single argument 'devlink' was not specified
           devl_unlock();
           ~~~~~~~~~~~ ^
   include/net/devlink.h:1519:6: note: 'devl_unlock' declared here
   void devl_unlock(struct devlink *devlink);
        ^
   drivers/net/ethernet/mellanox/mlxsw/i2c.c:666:12: error: too few arguments to function call, single argument 'devlink' was not specified
           devl_lock();
           ~~~~~~~~~ ^
   include/net/devlink.h:1518:6: note: 'devl_lock' declared here
   void devl_lock(struct devlink *devlink);
        ^
   drivers/net/ethernet/mellanox/mlxsw/i2c.c:668:14: error: too few arguments to function call, single argument 'devlink' was not specified
           devl_unlock();
           ~~~~~~~~~~~ ^
   include/net/devlink.h:1519:6: note: 'devl_unlock' declared here
   void devl_unlock(struct devlink *devlink);
        ^
   4 errors generated.
--
>> drivers/net/ethernet/mellanox/mlxsw/pci.c:1917:12: error: too few arguments to function call, single argument 'devlink' was not specified
           devl_lock();
           ~~~~~~~~~ ^
   include/net/devlink.h:1518:6: note: 'devl_lock' declared here
   void devl_lock(struct devlink *devlink);
        ^
   drivers/net/ethernet/mellanox/mlxsw/pci.c:1921:14: error: too few arguments to function call, single argument 'devlink' was not specified
           devl_unlock();
           ~~~~~~~~~~~ ^
   include/net/devlink.h:1519:6: note: 'devl_unlock' declared here
   void devl_unlock(struct devlink *devlink);
        ^
   drivers/net/ethernet/mellanox/mlxsw/pci.c:1880:46: warning: shift count >= width of type [-Wshift-count-overflow]
           err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
                                                       ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   drivers/net/ethernet/mellanox/mlxsw/pci.c:1948:12: error: too few arguments to function call, single argument 'devlink' was not specified
           devl_lock();
           ~~~~~~~~~ ^
   include/net/devlink.h:1518:6: note: 'devl_lock' declared here
   void devl_lock(struct devlink *devlink);
        ^
   drivers/net/ethernet/mellanox/mlxsw/pci.c:1950:14: error: too few arguments to function call, single argument 'devlink' was not specified
           devl_unlock();
           ~~~~~~~~~~~ ^
   include/net/devlink.h:1519:6: note: 'devl_unlock' declared here
   void devl_unlock(struct devlink *devlink);
        ^
   1 warning and 4 errors generated.


vim +/devlink +1500 drivers/net/ethernet/mellanox/mlxsw/core.c

  1491	
  1492	static int
  1493	mlxsw_devlink_core_bus_device_reload_down(struct devlink *devlink,
  1494						  bool netns_change, enum devlink_reload_action action,
  1495						  enum devlink_reload_limit limit,
  1496						  struct netlink_ext_ack *extack)
  1497	{
  1498		struct mlxsw_core *mlxsw_core = devlink_priv(devlink);
  1499	
> 1500		devl_lock();
  1501		if (!(mlxsw_core->bus->features & MLXSW_BUS_F_RESET))
  1502			return -EOPNOTSUPP;
  1503	
  1504		mlxsw_core_bus_device_unregister(mlxsw_core, true);
  1505		devl_unlock();
  1506		return 0;
  1507	}
  1508	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

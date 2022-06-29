Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A831755F4DD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 06:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiF2EDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 00:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiF2EDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 00:03:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ED6237D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 21:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656475429; x=1688011429;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vOz+of/fGNxdDNwUCpp2s9W4Ymb6dAtMrZ1YDgPIITs=;
  b=h3uJl9v35zXrIM5zqb+2DAKZIBDfDoSw0ormslv1if1xWWex6eyjL9i7
   /w+0ACgztxsdg/mf+wJzl4buJxNnw96FmhNFRecq5HPdca3yiZlwLmbIt
   ur8+4xsWnsoQa4C08+lQIFmnw8ex+sVV46/jgcX3KxpENA87g/iR3+Pr9
   efTDVaOWGWn15JQnoC2ayoKgm2lLU36AgtMeDdJXBfAa5uHKn4yFmeN8z
   05EMnTpiDFdVC3yA6Ozktxttzfms4ZUdF4lq6rkh4Z6Fy6ekS3UFeXuTu
   B5qy0VXrWqrt0pvc6m7ytCvlXjjx6mpkIMqeMyfaqsVHFqUG/xXNaXa18
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="262322477"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="262322477"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 21:03:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="917441016"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2022 21:03:46 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6Ova-000At2-87;
        Wed, 29 Jun 2022 04:03:46 +0000
Date:   Wed, 29 Jun 2022 12:03:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_devlink_locking 21/21]
 drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c:138:15: error: implicit
 declaration of function 'dev_resource_size_get'; did you mean
 'devl_resource_size_get'?
Message-ID: <202206291205.yExYDYyR-lkp@intel.com>
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
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220629/202206291205.yExYDYyR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/jpirko/linux_mlxsw/commit/9162f3d685ec59a9811d91e44c3f79c51714d077
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_devlink_locking
        git checkout 9162f3d685ec59a9811d91e44c3f79c51714d077
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c: In function 'mlxsw_sp_counter_pool_init':
>> drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c:138:15: error: implicit declaration of function 'dev_resource_size_get'; did you mean 'devl_resource_size_get'? [-Werror=implicit-function-declaration]
     138 |         err = dev_resource_size_get(devlink, MLXSW_SP_RESOURCE_COUNTERS,
         |               ^~~~~~~~~~~~~~~~~~~~~
         |               devl_resource_size_get
   cc1: some warnings being treated as errors
--
   drivers/net/ethernet/mellanox/mlxsw/core.c: In function 'mlxsw_devlink_core_bus_device_reload_down':
>> drivers/net/ethernet/mellanox/mlxsw/core.c:1500:9: error: too few arguments to function 'devl_lock'
    1500 |         devl_lock();
         |         ^~~~~~~~~
   In file included from drivers/net/ethernet/mellanox/mlxsw/core.c:25:
   include/net/devlink.h:1518:6: note: declared here
    1518 | void devl_lock(struct devlink *devlink);
         |      ^~~~~~~~~
>> drivers/net/ethernet/mellanox/mlxsw/core.c:1505:9: error: too few arguments to function 'devl_unlock'
    1505 |         devl_unlock();
         |         ^~~~~~~~~~~
   In file included from drivers/net/ethernet/mellanox/mlxsw/core.c:25:
   include/net/devlink.h:1519:6: note: declared here
    1519 | void devl_unlock(struct devlink *devlink);
         |      ^~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/core.c: In function 'mlxsw_devlink_core_bus_device_reload_up':
   drivers/net/ethernet/mellanox/mlxsw/core.c:1517:9: error: too few arguments to function 'devl_lock'
    1517 |         devl_lock();
         |         ^~~~~~~~~
   In file included from drivers/net/ethernet/mellanox/mlxsw/core.c:25:
   include/net/devlink.h:1518:6: note: declared here
    1518 | void devl_lock(struct devlink *devlink);
         |      ^~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/core.c:1524:9: error: too few arguments to function 'devl_unlock'
    1524 |         devl_unlock();
         |         ^~~~~~~~~~~
   In file included from drivers/net/ethernet/mellanox/mlxsw/core.c:25:
   include/net/devlink.h:1519:6: note: declared here
    1519 | void devl_unlock(struct devlink *devlink);
         |      ^~~~~~~~~~~
--
   drivers/net/ethernet/mellanox/mlxsw/pci.c: In function 'mlxsw_pci_probe':
>> drivers/net/ethernet/mellanox/mlxsw/pci.c:1917:9: error: too few arguments to function 'devl_lock'
    1917 |         devl_lock();
         |         ^~~~~~~~~
   In file included from drivers/net/ethernet/mellanox/mlxsw/core.h:16,
                    from drivers/net/ethernet/mellanox/mlxsw/pci.c:20:
   include/net/devlink.h:1518:6: note: declared here
    1518 | void devl_lock(struct devlink *devlink);
         |      ^~~~~~~~~
>> drivers/net/ethernet/mellanox/mlxsw/pci.c:1921:9: error: too few arguments to function 'devl_unlock'
    1921 |         devl_unlock();
         |         ^~~~~~~~~~~
   In file included from drivers/net/ethernet/mellanox/mlxsw/core.h:16,
                    from drivers/net/ethernet/mellanox/mlxsw/pci.c:20:
   include/net/devlink.h:1519:6: note: declared here
    1519 | void devl_unlock(struct devlink *devlink);
         |      ^~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/pci.c: In function 'mlxsw_pci_remove':
   drivers/net/ethernet/mellanox/mlxsw/pci.c:1948:9: error: too few arguments to function 'devl_lock'
    1948 |         devl_lock();
         |         ^~~~~~~~~
   In file included from drivers/net/ethernet/mellanox/mlxsw/core.h:16,
                    from drivers/net/ethernet/mellanox/mlxsw/pci.c:20:
   include/net/devlink.h:1518:6: note: declared here
    1518 | void devl_lock(struct devlink *devlink);
         |      ^~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/pci.c:1950:9: error: too few arguments to function 'devl_unlock'
    1950 |         devl_unlock();
         |         ^~~~~~~~~~~
   In file included from drivers/net/ethernet/mellanox/mlxsw/core.h:16,
                    from drivers/net/ethernet/mellanox/mlxsw/pci.c:20:
   include/net/devlink.h:1519:6: note: declared here
    1519 | void devl_unlock(struct devlink *devlink);
         |      ^~~~~~~~~~~
--
   drivers/net/ethernet/mellanox/mlxsw/i2c.c: In function 'mlxsw_i2c_probe':
>> drivers/net/ethernet/mellanox/mlxsw/i2c.c:643:9: error: too few arguments to function 'devl_lock'
     643 |         devl_lock();
         |         ^~~~~~~~~
   In file included from drivers/net/ethernet/mellanox/mlxsw/i2c.c:13:
   include/net/devlink.h:1518:6: note: declared here
    1518 | void devl_lock(struct devlink *devlink);
         |      ^~~~~~~~~
>> drivers/net/ethernet/mellanox/mlxsw/i2c.c:647:9: error: too few arguments to function 'devl_unlock'
     647 |         devl_unlock();
         |         ^~~~~~~~~~~
   In file included from drivers/net/ethernet/mellanox/mlxsw/i2c.c:13:
   include/net/devlink.h:1519:6: note: declared here
    1519 | void devl_unlock(struct devlink *devlink);
         |      ^~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/i2c.c: In function 'mlxsw_i2c_remove':
   drivers/net/ethernet/mellanox/mlxsw/i2c.c:666:9: error: too few arguments to function 'devl_lock'
     666 |         devl_lock();
         |         ^~~~~~~~~
   In file included from drivers/net/ethernet/mellanox/mlxsw/i2c.c:13:
   include/net/devlink.h:1518:6: note: declared here
    1518 | void devl_lock(struct devlink *devlink);
         |      ^~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/i2c.c:668:9: error: too few arguments to function 'devl_unlock'
     668 |         devl_unlock();
         |         ^~~~~~~~~~~
   In file included from drivers/net/ethernet/mellanox/mlxsw/i2c.c:13:
   include/net/devlink.h:1519:6: note: declared here
    1519 | void devl_unlock(struct devlink *devlink);
         |      ^~~~~~~~~~~


vim +138 drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c

   119	
   120	int mlxsw_sp_counter_pool_init(struct mlxsw_sp *mlxsw_sp)
   121	{
   122		unsigned int sub_pools_count = ARRAY_SIZE(mlxsw_sp_counter_sub_pools);
   123		struct devlink *devlink = priv_to_devlink(mlxsw_sp->core);
   124		struct mlxsw_sp_counter_pool *pool;
   125		int err;
   126	
   127		pool = kzalloc(struct_size(pool, sub_pools, sub_pools_count),
   128			       GFP_KERNEL);
   129		if (!pool)
   130			return -ENOMEM;
   131		mlxsw_sp->counter_pool = pool;
   132		pool->sub_pools_count = sub_pools_count;
   133		memcpy(pool->sub_pools, mlxsw_sp_counter_sub_pools,
   134		       flex_array_size(pool, sub_pools, pool->sub_pools_count));
   135		spin_lock_init(&pool->counter_pool_lock);
   136		atomic_set(&pool->active_entries_count, 0);
   137	
 > 138		err = dev_resource_size_get(devlink, MLXSW_SP_RESOURCE_COUNTERS,
   139					    &pool->pool_size);
   140		if (err)
   141			goto err_pool_resource_size_get;
   142		devl_resource_occ_get_register(devlink, MLXSW_SP_RESOURCE_COUNTERS,
   143					       mlxsw_sp_counter_pool_occ_get, pool);
   144	
   145		pool->usage = bitmap_zalloc(pool->pool_size, GFP_KERNEL);
   146		if (!pool->usage) {
   147			err = -ENOMEM;
   148			goto err_usage_alloc;
   149		}
   150	
   151		err = mlxsw_sp_counter_sub_pools_init(mlxsw_sp);
   152		if (err)
   153			goto err_sub_pools_init;
   154	
   155		return 0;
   156	
   157	err_sub_pools_init:
   158		bitmap_free(pool->usage);
   159	err_usage_alloc:
   160		devl_resource_occ_get_unregister(devlink,
   161						 MLXSW_SP_RESOURCE_COUNTERS);
   162	err_pool_resource_size_get:
   163		kfree(pool);
   164		return err;
   165	}
   166	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9322B5926FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 01:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiHNXu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 19:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiHNXuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 19:50:25 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9DD21B5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 16:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660521024; x=1692057024;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wSOpoiG8DoKFBrE2/K0AsWuxil2rbkfKm8/Mb7E3Y+w=;
  b=JmbEdjpXC+O5NU32gBg8s78Ez6MnaijZUKHMZdDnwtV1Ditn80keLe5A
   LQgkALKYW9omaDct1EUHQcdCIzr849BL2g54UOxb3g/dWgWJHttvzzWXi
   +xT2+hQgyQqjPB6PDgeLUXxo8vNI4kPXPxZpbCqKXQSBou+iqVViz+dE/
   1wQe6p916QEVzdEj3N44VFnFvn2UUeoiKYlMCTNSi8nZSQE02vHIaA/4Y
   Cx7K9hn+a9yg02qqtV4D/csaPU2ovEgDQeXrjEyL8GrS2pHnb80orBgTn
   nn4HsMYnLGTcwaF/kpmvrj63hHe+NgbS0tnrCPubCooV8/gaT2webvM8V
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="272253542"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="272253542"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 16:50:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="582690997"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Aug 2022 16:50:21 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNNN6-0000dZ-2S;
        Sun, 14 Aug 2022 23:50:20 +0000
Date:   Mon, 15 Aug 2022 07:49:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [thermal:thermal/linux-next 83/83]
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c:409:13: warning: variable
 'err' set but not used
Message-ID: <202208150708.fk6sfd8u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git thermal/linux-next
head:   9b5e2c897cd182a5802878a56fb7fbef36b22dfb
commit: 9b5e2c897cd182a5802878a56fb7fbef36b22dfb [83/83] Revert "mlxsw: core: Add the hottest thermal zone detection"
config: alpha-randconfig-r032-20220814 (https://download.01.org/0day-ci/archive/20220815/202208150708.fk6sfd8u-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/commit/?id=9b5e2c897cd182a5802878a56fb7fbef36b22dfb
        git remote add thermal git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
        git fetch --no-tags thermal thermal/linux-next
        git checkout 9b5e2c897cd182a5802878a56fb7fbef36b22dfb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/net/ethernet/mellanox/mlxsw/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/mellanox/mlxsw/core_thermal.c: In function 'mlxsw_thermal_module_temp_get':
>> drivers/net/ethernet/mellanox/mlxsw/core_thermal.c:409:13: warning: variable 'err' set but not used [-Wunused-but-set-variable]
     409 |         int err;
         |             ^~~


vim +/err +409 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c

e57977b34ab5d5 Mykola Kostenok 2021-06-08  400  
6a79507cfe94c7 Vadim Pasternak 2019-02-14  401  static int mlxsw_thermal_module_temp_get(struct thermal_zone_device *tzdev,
6a79507cfe94c7 Vadim Pasternak 2019-02-14  402  					 int *p_temp)
6a79507cfe94c7 Vadim Pasternak 2019-02-14  403  {
6a79507cfe94c7 Vadim Pasternak 2019-02-14  404  	struct mlxsw_thermal_module *tz = tzdev->devdata;
6a79507cfe94c7 Vadim Pasternak 2019-02-14  405  	struct mlxsw_thermal *thermal = tz->parent;
72a64c2fe9d8a0 Mykola Kostenok 2021-06-08  406  	int temp, crit_temp, emerg_temp;
e57977b34ab5d5 Mykola Kostenok 2021-06-08  407  	struct device *dev;
e57977b34ab5d5 Mykola Kostenok 2021-06-08  408  	u16 sensor_index;
6a79507cfe94c7 Vadim Pasternak 2019-02-14 @409  	int err;
6a79507cfe94c7 Vadim Pasternak 2019-02-14  410  
e57977b34ab5d5 Mykola Kostenok 2021-06-08  411  	dev = thermal->bus_info->dev;
e57977b34ab5d5 Mykola Kostenok 2021-06-08  412  	sensor_index = MLXSW_REG_MTMP_MODULE_INDEX_MIN + tz->module;
e57977b34ab5d5 Mykola Kostenok 2021-06-08  413  
e57977b34ab5d5 Mykola Kostenok 2021-06-08  414  	/* Read module temperature and thresholds. */
e57977b34ab5d5 Mykola Kostenok 2021-06-08  415  	mlxsw_thermal_module_temp_and_thresholds_get(thermal->core,
72a64c2fe9d8a0 Mykola Kostenok 2021-06-08  416  						     sensor_index, &temp,
72a64c2fe9d8a0 Mykola Kostenok 2021-06-08  417  						     &crit_temp, &emerg_temp);
f485cc36b0a7d7 Vadim Pasternak 2019-06-24  418  	*p_temp = temp;
e4e93d6d865113 Vadim Pasternak 2019-05-29  419  
e4e93d6d865113 Vadim Pasternak 2019-05-29  420  	if (!temp)
e4e93d6d865113 Vadim Pasternak 2019-05-29  421  		return 0;
e4e93d6d865113 Vadim Pasternak 2019-05-29  422  
e4e93d6d865113 Vadim Pasternak 2019-05-29  423  	/* Update trip points. */
72a64c2fe9d8a0 Mykola Kostenok 2021-06-08  424  	err = mlxsw_thermal_module_trips_update(dev, thermal->core, tz,
72a64c2fe9d8a0 Mykola Kostenok 2021-06-08  425  						crit_temp, emerg_temp);
e4e93d6d865113 Vadim Pasternak 2019-05-29  426  
6a79507cfe94c7 Vadim Pasternak 2019-02-14  427  	return 0;
6a79507cfe94c7 Vadim Pasternak 2019-02-14  428  }
6a79507cfe94c7 Vadim Pasternak 2019-02-14  429  

:::::: The code at line 409 was first introduced by commit
:::::: 6a79507cfe94c7729207659501ff88914b3eb198 mlxsw: core: Extend thermal module with per QSFP module thermal zones

:::::: TO: Vadim Pasternak <vadimp@mellanox.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

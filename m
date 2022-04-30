Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A576515AED
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 09:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382235AbiD3HSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 03:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbiD3HSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 03:18:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404582656B
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 00:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651302881; x=1682838881;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YqFpqQK603DrVJuKMaHPqPvTsgD0qDjuLywjuI7r1u0=;
  b=Tc9OM9ALxlwV0hceKdMXjtL4guFlSdABR6DSfYf1qXg8W0vt9N/yjH4H
   pNOjiaSB64RGN2ZRa1OmMFEKE2Ciu/vizvE776VjnQGYaz4i2iDfkmLKr
   Xsmw0hVMQmIRwNhfwurShTKfg/T/mQDPeB5Lqqc25wqqWJMlXi4Yt8yN2
   Rfejizt964PzMVbKK+/cz0/HuqB0j4vMlVJBSktEb23WadrPxdDiV37BO
   tLDZSHXz3nX28OP+my49ViMdr/VrH2ZA19eK5mjXp5YR19f+tK9ZwBzKO
   W19HmREL9BcCb3MN5Dq2TIenYx1jLQeIbIEErW5LU3JbbWrOjK0r7LX0h
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="264432370"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="264432370"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 00:14:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="534878127"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 Apr 2022 00:14:39 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkhJO-0006zP-SF;
        Sat, 30 Apr 2022 07:14:38 +0000
Date:   Sat, 30 Apr 2022 15:13:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_linecards 17/21]
 drivers/net/netdevsim/dev.c:119:57: error: passing argument 4 of
 'devlink_linecard_device_create' from incompatible pointer type
Message-ID: <202204301550.k93sqJ7b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_linecards
head:   5563b8430bfed9aac087ac84e75b388ba4d13c60
commit: dc336a0bfe84659efe23f454e49808b60aeb5e12 [17/21] TMP: devlink device type
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20220430/202204301550.k93sqJ7b-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/dc336a0bfe84659efe23f454e49808b60aeb5e12
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout dc336a0bfe84659efe23f454e49808b60aeb5e12
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/net/netdevsim/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/netdevsim/dev.c: In function 'nsim_dev_linecard_devices_create':
>> drivers/net/netdevsim/dev.c:119:57: error: passing argument 4 of 'devlink_linecard_device_create' from incompatible pointer type [-Werror=incompatible-pointer-types]
     119 |                                                         nsim_dev_linecard);
         |                                                         ^~~~~~~~~~~~~~~~~
         |                                                         |
         |                                                         struct nsim_dev_linecard *
   In file included from drivers/net/netdevsim/dev.c:29:
   include/net/devlink.h:1610:44: note: expected 'const char *' but argument is of type 'struct nsim_dev_linecard *'
    1610 |                                const char *type, void *priv);
         |                                ~~~~~~~~~~~~^~~~
>> drivers/net/netdevsim/dev.c:117:26: error: too few arguments to function 'devlink_linecard_device_create'
     117 |                 device = devlink_linecard_device_create(nsim_dev_linecard->devlink_linecard,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/netdevsim/dev.c:29:
   include/net/devlink.h:1607:1: note: declared here
    1607 | devlink_linecard_device_create(struct devlink_linecard *linecard,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/devlink_linecard_device_create +119 drivers/net/netdevsim/dev.c

f6a02a27389611 Jiri Pirko 2021-05-05  100  
f6a02a27389611 Jiri Pirko 2021-05-05  101  static int
f6a02a27389611 Jiri Pirko 2021-05-05  102  nsim_dev_linecard_devices_create(struct nsim_dev_linecard *nsim_dev_linecard)
f6a02a27389611 Jiri Pirko 2021-05-05  103  {
f6a02a27389611 Jiri Pirko 2021-05-05  104  	struct devlink_linecard_device *device;
f6a02a27389611 Jiri Pirko 2021-05-05  105  	char *component_name;
f6a02a27389611 Jiri Pirko 2021-05-05  106  	int err;
f6a02a27389611 Jiri Pirko 2021-05-05  107  	int i;
f6a02a27389611 Jiri Pirko 2021-05-05  108  
f6a02a27389611 Jiri Pirko 2021-05-05  109  	snprintf(nsim_dev_linecard->device_component_name,
f6a02a27389611 Jiri Pirko 2021-05-05  110  		 sizeof(nsim_dev_linecard->device_component_name), "lc%u_dev0",
f6a02a27389611 Jiri Pirko 2021-05-05  111  		 nsim_dev_linecard->linecard_index);
f6a02a27389611 Jiri Pirko 2021-05-05  112  	component_name = nsim_dev_linecard->device_component_name;
f6a02a27389611 Jiri Pirko 2021-05-05  113  
f6a02a27389611 Jiri Pirko 2021-05-05  114  	for (i = 0; i < NSIM_DEV_LINECARD_DEVICE_COUNT; i++) {
f6a02a27389611 Jiri Pirko 2021-05-05  115  		if (i > 0)
f6a02a27389611 Jiri Pirko 2021-05-05  116  			component_name = NULL;
f6a02a27389611 Jiri Pirko 2021-05-05 @117  		device = devlink_linecard_device_create(nsim_dev_linecard->devlink_linecard,
f6a02a27389611 Jiri Pirko 2021-05-05  118  							i, component_name,
f6a02a27389611 Jiri Pirko 2021-05-05 @119  							nsim_dev_linecard);
f6a02a27389611 Jiri Pirko 2021-05-05  120  		if (IS_ERR(device)) {
f6a02a27389611 Jiri Pirko 2021-05-05  121  			err = PTR_ERR(device);
f6a02a27389611 Jiri Pirko 2021-05-05  122  			goto rollback;
f6a02a27389611 Jiri Pirko 2021-05-05  123  		}
f6a02a27389611 Jiri Pirko 2021-05-05  124  		nsim_dev_linecard->devlink_device[i] = device;
f6a02a27389611 Jiri Pirko 2021-05-05  125  	}
f6a02a27389611 Jiri Pirko 2021-05-05  126  	return 0;
f6a02a27389611 Jiri Pirko 2021-05-05  127  
f6a02a27389611 Jiri Pirko 2021-05-05  128  rollback:
f6a02a27389611 Jiri Pirko 2021-05-05  129  	for (i--; i >= 0; i--) {
f6a02a27389611 Jiri Pirko 2021-05-05  130  		device = nsim_dev_linecard->devlink_device[i];
f6a02a27389611 Jiri Pirko 2021-05-05  131  		devlink_linecard_device_destroy(nsim_dev_linecard->devlink_linecard,
f6a02a27389611 Jiri Pirko 2021-05-05  132  						device);
f6a02a27389611 Jiri Pirko 2021-05-05  133  	}
f6a02a27389611 Jiri Pirko 2021-05-05  134  	return err;
f6a02a27389611 Jiri Pirko 2021-05-05  135  }
f6a02a27389611 Jiri Pirko 2021-05-05  136  

:::::: The code at line 119 was first introduced by commit
:::::: f6a02a2738961198c12c1eaba8e0384d8b1fa6d3 netdevsim: create couple of devices on each linecard

:::::: TO: Jiri Pirko <jiri@nvidia.com>
:::::: CC: Jiri Pirko <jiri@nvidia.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493604CB552
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiCCDNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbiCCDNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:13:30 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A75DF51
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646277164; x=1677813164;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9zJ6T3inonU/mkYtGVSG0sMG4BQgBKZujHWa/dCPMOI=;
  b=R7XS/L+biddZ6064wRL5noKEv5Tk/xw7uEZX7TUQt40ugnhn0mWSlsdh
   LBkEMIORswEPn5Gub7N/CkHyDyuN25SwlA8r4d4c6DQf17gnQ2BNvugZn
   drQJF+zp27D4exyp6Vg6Tzq8Hmj53zYAaX0dJIV5prWdCWRGXyUUiDnbm
   0UVVkBsrra68Gql1VGwQEVdAcuUPa0vuRgpJCmmJBax18CuVXHFN9wN73
   dlNdbpQuD/EROOkkmXFdly+WXQf++u0g2kzhQ497k7I1Zkh5XpA6sbJtZ
   RS3kjWDyAOqFQ4T9WHlKb7tmK2RRp+ETaEqlP6luUy76Recgg4a1P3oyj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="316782837"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="316782837"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 19:12:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="545715556"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 02 Mar 2022 19:12:42 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPbtS-00004X-6S; Thu, 03 Mar 2022 03:12:42 +0000
Date:   Thu, 3 Mar 2022 11:12:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_linecards 38/39]
 drivers/net/netdevsim/dev.c:119:57: error: passing argument 4 of
 'devlink_linecard_device_create' from incompatible pointer type
Message-ID: <202203030915.ADVbo5ri-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_linecards
head:   5be7dbceaf8fd4fdc9cdeb10d63edb13dc9e89b5
commit: 41245c30197488da988091379946dd2a9f397308 [38/39] TMP: devlink device type
config: csky-randconfig-r003-20220302 (https://download.01.org/0day-ci/archive/20220303/202203030915.ADVbo5ri-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/41245c30197488da988091379946dd2a9f397308
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout 41245c30197488da988091379946dd2a9f397308
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash drivers/net/netdevsim/ fs/notify/fanotify/

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
   include/net/devlink.h:1580:44: note: expected 'const char *' but argument is of type 'struct nsim_dev_linecard *'
    1580 |                                const char *type, void *priv);
         |                                ~~~~~~~~~~~~^~~~
>> drivers/net/netdevsim/dev.c:117:26: error: too few arguments to function 'devlink_linecard_device_create'
     117 |                 device = devlink_linecard_device_create(nsim_dev_linecard->devlink_linecard,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/netdevsim/dev.c:29:
   include/net/devlink.h:1577:1: note: declared here
    1577 | devlink_linecard_device_create(struct devlink_linecard *linecard,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/devlink_linecard_device_create +119 drivers/net/netdevsim/dev.c

15527306aace517 Jiri Pirko 2021-05-05  100  
15527306aace517 Jiri Pirko 2021-05-05  101  static int
15527306aace517 Jiri Pirko 2021-05-05  102  nsim_dev_linecard_devices_create(struct nsim_dev_linecard *nsim_dev_linecard)
15527306aace517 Jiri Pirko 2021-05-05  103  {
15527306aace517 Jiri Pirko 2021-05-05  104  	struct devlink_linecard_device *device;
15527306aace517 Jiri Pirko 2021-05-05  105  	char *component_name;
15527306aace517 Jiri Pirko 2021-05-05  106  	int err;
15527306aace517 Jiri Pirko 2021-05-05  107  	int i;
15527306aace517 Jiri Pirko 2021-05-05  108  
15527306aace517 Jiri Pirko 2021-05-05  109  	snprintf(nsim_dev_linecard->device_component_name,
15527306aace517 Jiri Pirko 2021-05-05  110  		 sizeof(nsim_dev_linecard->device_component_name), "lc%u_dev0",
15527306aace517 Jiri Pirko 2021-05-05  111  		 nsim_dev_linecard->linecard_index);
15527306aace517 Jiri Pirko 2021-05-05  112  	component_name = nsim_dev_linecard->device_component_name;
15527306aace517 Jiri Pirko 2021-05-05  113  
15527306aace517 Jiri Pirko 2021-05-05  114  	for (i = 0; i < NSIM_DEV_LINECARD_DEVICE_COUNT; i++) {
15527306aace517 Jiri Pirko 2021-05-05  115  		if (i > 0)
15527306aace517 Jiri Pirko 2021-05-05  116  			component_name = NULL;
15527306aace517 Jiri Pirko 2021-05-05 @117  		device = devlink_linecard_device_create(nsim_dev_linecard->devlink_linecard,
15527306aace517 Jiri Pirko 2021-05-05  118  							i, component_name,
15527306aace517 Jiri Pirko 2021-05-05 @119  							nsim_dev_linecard);
15527306aace517 Jiri Pirko 2021-05-05  120  		if (IS_ERR(device)) {
15527306aace517 Jiri Pirko 2021-05-05  121  			err = PTR_ERR(device);
15527306aace517 Jiri Pirko 2021-05-05  122  			goto rollback;
15527306aace517 Jiri Pirko 2021-05-05  123  		}
15527306aace517 Jiri Pirko 2021-05-05  124  		nsim_dev_linecard->devlink_device[i] = device;
15527306aace517 Jiri Pirko 2021-05-05  125  	}
15527306aace517 Jiri Pirko 2021-05-05  126  	return 0;
15527306aace517 Jiri Pirko 2021-05-05  127  
15527306aace517 Jiri Pirko 2021-05-05  128  rollback:
15527306aace517 Jiri Pirko 2021-05-05  129  	for (i--; i >= 0; i--) {
15527306aace517 Jiri Pirko 2021-05-05  130  		device = nsim_dev_linecard->devlink_device[i];
15527306aace517 Jiri Pirko 2021-05-05  131  		devlink_linecard_device_destroy(nsim_dev_linecard->devlink_linecard,
15527306aace517 Jiri Pirko 2021-05-05  132  						device);
15527306aace517 Jiri Pirko 2021-05-05  133  	}
15527306aace517 Jiri Pirko 2021-05-05  134  	return err;
15527306aace517 Jiri Pirko 2021-05-05  135  }
15527306aace517 Jiri Pirko 2021-05-05  136  

:::::: The code at line 119 was first introduced by commit
:::::: 15527306aace517a53a34b6e207a3ae087fe8566 netdevsim: create couple of devices on each linecard

:::::: TO: Jiri Pirko <jiri@nvidia.com>
:::::: CC: Jiri Pirko <jiri@nvidia.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

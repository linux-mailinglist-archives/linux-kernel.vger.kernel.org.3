Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0CC4C51F1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 00:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbiBYXLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 18:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiBYXLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 18:11:02 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D415D1FEF87
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 15:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645830628; x=1677366628;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wgVbaDdUFaGJG+7dlF/Bt+sG12/DlkgkncT3xC9FmYE=;
  b=BrW0fihLv/Tj3y4KEKVGbsDANLSCzRSkss8WSJeW0sKzx35lzaMBf3zZ
   O9dlBaIIgeLU6CcbkXtSr5Vx8zZtyOJNQYpfEwsQX0sMfMxCAR2yXkXlc
   ufKcNZM1gk2hfI70pDRbruiM3aTu3lMW0Jz+hVaCKahY+gdzlimXCGqf6
   ETyUtkb98WFpF2ua1hljHHOVKfW2WuD+3HiaGR+jrbQsn9WIQM00WRXyV
   1JK9o/snK7cCjC4r/vtGxB90Ja29gPDbwsoCi9laG/p9t31hXABvvlA2X
   +BXA17r4Ou/KaqgEJAeWJZRdWWaQtuPfxdPQtmpEUSISfUZnnIAdiYXQg
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="240003353"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="240003353"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 15:10:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="574748196"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Feb 2022 15:10:27 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNjjG-0004ny-DM; Fri, 25 Feb 2022 23:10:26 +0000
Date:   Sat, 26 Feb 2022 07:09:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_linecards 38/39]
 drivers/net/netdevsim/dev.c:119:57: error: passing argument 4 of
 'devlink_linecard_device_create' from incompatible pointer type
Message-ID: <202202260711.HoB6xaby-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_linecards
head:   24e52724258ba5d7b58b5a4a86640dadb30b07c4
commit: 36f00f891469372ccec5b7d6442e13e284ceca13 [38/39] TMP: devlink device type
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220226/202202260711.HoB6xaby-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/36f00f891469372ccec5b7d6442e13e284ceca13
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout 36f00f891469372ccec5b7d6442e13e284ceca13
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

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

e8caa751f8b7e3 Jiri Pirko 2021-05-05  100  
e8caa751f8b7e3 Jiri Pirko 2021-05-05  101  static int
e8caa751f8b7e3 Jiri Pirko 2021-05-05  102  nsim_dev_linecard_devices_create(struct nsim_dev_linecard *nsim_dev_linecard)
e8caa751f8b7e3 Jiri Pirko 2021-05-05  103  {
e8caa751f8b7e3 Jiri Pirko 2021-05-05  104  	struct devlink_linecard_device *device;
e8caa751f8b7e3 Jiri Pirko 2021-05-05  105  	char *component_name;
e8caa751f8b7e3 Jiri Pirko 2021-05-05  106  	int err;
e8caa751f8b7e3 Jiri Pirko 2021-05-05  107  	int i;
e8caa751f8b7e3 Jiri Pirko 2021-05-05  108  
e8caa751f8b7e3 Jiri Pirko 2021-05-05  109  	snprintf(nsim_dev_linecard->device_component_name,
e8caa751f8b7e3 Jiri Pirko 2021-05-05  110  		 sizeof(nsim_dev_linecard->device_component_name), "lc%u_dev0",
e8caa751f8b7e3 Jiri Pirko 2021-05-05  111  		 nsim_dev_linecard->linecard_index);
e8caa751f8b7e3 Jiri Pirko 2021-05-05  112  	component_name = nsim_dev_linecard->device_component_name;
e8caa751f8b7e3 Jiri Pirko 2021-05-05  113  
e8caa751f8b7e3 Jiri Pirko 2021-05-05  114  	for (i = 0; i < NSIM_DEV_LINECARD_DEVICE_COUNT; i++) {
e8caa751f8b7e3 Jiri Pirko 2021-05-05  115  		if (i > 0)
e8caa751f8b7e3 Jiri Pirko 2021-05-05  116  			component_name = NULL;
e8caa751f8b7e3 Jiri Pirko 2021-05-05 @117  		device = devlink_linecard_device_create(nsim_dev_linecard->devlink_linecard,
e8caa751f8b7e3 Jiri Pirko 2021-05-05  118  							i, component_name,
e8caa751f8b7e3 Jiri Pirko 2021-05-05 @119  							nsim_dev_linecard);
e8caa751f8b7e3 Jiri Pirko 2021-05-05  120  		if (IS_ERR(device)) {
e8caa751f8b7e3 Jiri Pirko 2021-05-05  121  			err = PTR_ERR(device);
e8caa751f8b7e3 Jiri Pirko 2021-05-05  122  			goto rollback;
e8caa751f8b7e3 Jiri Pirko 2021-05-05  123  		}
e8caa751f8b7e3 Jiri Pirko 2021-05-05  124  		nsim_dev_linecard->devlink_device[i] = device;
e8caa751f8b7e3 Jiri Pirko 2021-05-05  125  	}
e8caa751f8b7e3 Jiri Pirko 2021-05-05  126  	return 0;
e8caa751f8b7e3 Jiri Pirko 2021-05-05  127  
e8caa751f8b7e3 Jiri Pirko 2021-05-05  128  rollback:
e8caa751f8b7e3 Jiri Pirko 2021-05-05  129  	for (i--; i >= 0; i--) {
e8caa751f8b7e3 Jiri Pirko 2021-05-05  130  		device = nsim_dev_linecard->devlink_device[i];
e8caa751f8b7e3 Jiri Pirko 2021-05-05  131  		devlink_linecard_device_destroy(nsim_dev_linecard->devlink_linecard,
e8caa751f8b7e3 Jiri Pirko 2021-05-05  132  						device);
e8caa751f8b7e3 Jiri Pirko 2021-05-05  133  	}
e8caa751f8b7e3 Jiri Pirko 2021-05-05  134  	return err;
e8caa751f8b7e3 Jiri Pirko 2021-05-05  135  }
e8caa751f8b7e3 Jiri Pirko 2021-05-05  136  

:::::: The code at line 119 was first introduced by commit
:::::: e8caa751f8b7e39b8286205755f61701496d4c79 netdevsim: create couple of devices on each linecard

:::::: TO: Jiri Pirko <jiri@nvidia.com>
:::::: CC: Jiri Pirko <jiri@nvidia.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

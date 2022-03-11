Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE0C4D6A6B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiCKXHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiCKXHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:07:01 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCFEF47E9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647039956; x=1678575956;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cHul6oEKLdgd+ddM8aVZnijcB4d/RNNOzdURz3B/z3s=;
  b=lFquFZ6BcSkm7RfBIr3eg0Ap2D25L40NuxAM8+UEswjcCSwVEeN/T+7Y
   TSmhBPjZj0cvo8wHZHKTAfy25n3X6FwzbALWTTdHMTLM7BGIUi1HRuEbC
   uS/teZzM0djK4GhQxX/upD35M9MgptX+33JKvOaeem6LEZ3IaalsU5lNn
   WWMb/JZAgcqzN5o9o3lDV04oyHhqwRWfItlHZ4YOFZiGzCowBUqU4zvz5
   Vv/QVhXLI2PtV495KuoqIWtzxAGH6mrLkQLF8uNF4fpiNqAuRe9eV7m5g
   MUGZGxF08iUKxF6ne0EUfJ2hUCLCbRQYKTE75g9PhDmppVJiOeK7Hbjr8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="255859566"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="255859566"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 15:05:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="712998842"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2022 15:05:55 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSoKY-0007Ec-Hk; Fri, 11 Mar 2022 23:05:54 +0000
Date:   Sat, 12 Mar 2022 07:05:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_linecards 39/40]
 drivers/net/netdevsim/dev.c:117:26: error: too few arguments to function
 'devlink_linecard_device_create'
Message-ID: <202203120723.CQQLnB8w-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_linecards
head:   c234507fcad181742ea04ca881338ee694735a74
commit: 526aaa97a43d0506e5c914890dd9b0c78276d625 [39/40] TMP: devlink device type
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220312/202203120723.CQQLnB8w-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/526aaa97a43d0506e5c914890dd9b0c78276d625
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout 526aaa97a43d0506e5c914890dd9b0c78276d625
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/netdevsim/dev.c: In function 'nsim_dev_linecard_devices_create':
   drivers/net/netdevsim/dev.c:119:57: error: passing argument 4 of 'devlink_linecard_device_create' from incompatible pointer type [-Werror=incompatible-pointer-types]
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


vim +/devlink_linecard_device_create +117 drivers/net/netdevsim/dev.c

de611295f39ec6 Jiri Pirko 2021-05-05  100  
de611295f39ec6 Jiri Pirko 2021-05-05  101  static int
de611295f39ec6 Jiri Pirko 2021-05-05  102  nsim_dev_linecard_devices_create(struct nsim_dev_linecard *nsim_dev_linecard)
de611295f39ec6 Jiri Pirko 2021-05-05  103  {
de611295f39ec6 Jiri Pirko 2021-05-05  104  	struct devlink_linecard_device *device;
de611295f39ec6 Jiri Pirko 2021-05-05  105  	char *component_name;
de611295f39ec6 Jiri Pirko 2021-05-05  106  	int err;
de611295f39ec6 Jiri Pirko 2021-05-05  107  	int i;
de611295f39ec6 Jiri Pirko 2021-05-05  108  
de611295f39ec6 Jiri Pirko 2021-05-05  109  	snprintf(nsim_dev_linecard->device_component_name,
de611295f39ec6 Jiri Pirko 2021-05-05  110  		 sizeof(nsim_dev_linecard->device_component_name), "lc%u_dev0",
de611295f39ec6 Jiri Pirko 2021-05-05  111  		 nsim_dev_linecard->linecard_index);
de611295f39ec6 Jiri Pirko 2021-05-05  112  	component_name = nsim_dev_linecard->device_component_name;
de611295f39ec6 Jiri Pirko 2021-05-05  113  
de611295f39ec6 Jiri Pirko 2021-05-05  114  	for (i = 0; i < NSIM_DEV_LINECARD_DEVICE_COUNT; i++) {
de611295f39ec6 Jiri Pirko 2021-05-05  115  		if (i > 0)
de611295f39ec6 Jiri Pirko 2021-05-05  116  			component_name = NULL;
de611295f39ec6 Jiri Pirko 2021-05-05 @117  		device = devlink_linecard_device_create(nsim_dev_linecard->devlink_linecard,
de611295f39ec6 Jiri Pirko 2021-05-05  118  							i, component_name,
de611295f39ec6 Jiri Pirko 2021-05-05  119  							nsim_dev_linecard);
de611295f39ec6 Jiri Pirko 2021-05-05  120  		if (IS_ERR(device)) {
de611295f39ec6 Jiri Pirko 2021-05-05  121  			err = PTR_ERR(device);
de611295f39ec6 Jiri Pirko 2021-05-05  122  			goto rollback;
de611295f39ec6 Jiri Pirko 2021-05-05  123  		}
de611295f39ec6 Jiri Pirko 2021-05-05  124  		nsim_dev_linecard->devlink_device[i] = device;
de611295f39ec6 Jiri Pirko 2021-05-05  125  	}
de611295f39ec6 Jiri Pirko 2021-05-05  126  	return 0;
de611295f39ec6 Jiri Pirko 2021-05-05  127  
de611295f39ec6 Jiri Pirko 2021-05-05  128  rollback:
de611295f39ec6 Jiri Pirko 2021-05-05  129  	for (i--; i >= 0; i--) {
de611295f39ec6 Jiri Pirko 2021-05-05  130  		device = nsim_dev_linecard->devlink_device[i];
de611295f39ec6 Jiri Pirko 2021-05-05  131  		devlink_linecard_device_destroy(nsim_dev_linecard->devlink_linecard,
de611295f39ec6 Jiri Pirko 2021-05-05  132  						device);
de611295f39ec6 Jiri Pirko 2021-05-05  133  	}
de611295f39ec6 Jiri Pirko 2021-05-05  134  	return err;
de611295f39ec6 Jiri Pirko 2021-05-05  135  }
de611295f39ec6 Jiri Pirko 2021-05-05  136  

:::::: The code at line 117 was first introduced by commit
:::::: de611295f39ec6f57ce11e67db048ffed43f0181 netdevsim: create couple of devices on each linecard

:::::: TO: Jiri Pirko <jiri@nvidia.com>
:::::: CC: Jiri Pirko <jiri@nvidia.com>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

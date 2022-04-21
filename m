Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F005097B6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384946AbiDUGgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242783AbiDUGft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:35:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B271713F36
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650522771; x=1682058771;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sDg8JlXhuBLvr3qealRzh/3gznsd9BkHgfOZj1Rn5T8=;
  b=Jo5C6n9TA+F3oFPH4FMHQkn8S8j/n7dJGkGX+7AZC/Aer4BLeR3W3EM8
   kmrJm9zxqb6yNEgvsq2p3gnfCN4j+ha9nu10p/2Od4QibyZcd4E/zDgOx
   UppNWJV6sn+JKMAxYvVSlkxLsSbnkPNQFIpsZDT7B14es4O9VEZPWvN9y
   jNMeoXLBP/Qwi3DcfrF9ZtvzFRMDCdx9RYIoUchv4dJ7mh4kM/Jk54ahH
   YhOCepGS7WvFOahojCsZWkJkOg5kuZ0EMQtu6s1GxFzj/vQ2+Ami8IR2N
   4nqCVwuZXkzMkmWxicTsNPY5tUmXYAU74BB0R4CD/0rtr8dV0fe8t4RrR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="246149386"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="246149386"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:32:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="593505839"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Apr 2022 23:32:49 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQMy-0007wq-Eh;
        Thu, 21 Apr 2022 06:32:48 +0000
Date:   Thu, 21 Apr 2022 14:32:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_linecards 92/94]
 drivers/net/netdevsim/dev.c:119:25: error: too few arguments to function
 call, expected 5, have 4
Message-ID: <202204202021.UKHPj2M9-lkp@intel.com>
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

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_linecards
head:   653975cafc05a2ffc68d2cbd1c5a328c67ce7142
commit: cb770dca23bd2c2fc957d64caeed00ba78a07e0b [92/94] TMP: devlink device type
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220420/202204202021.UKHPj2M9-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/cb770dca23bd2c2fc957d64caeed00ba78a07e0b
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout cb770dca23bd2c2fc957d64caeed00ba78a07e0b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/netdevsim/dev.c:119:25: error: too few arguments to function call, expected 5, have 4
                                                           nsim_dev_linecard);
                                                                            ^
   include/net/devlink.h:1607:1: note: 'devlink_linecard_device_create' declared here
   devlink_linecard_device_create(struct devlink_linecard *linecard,
   ^
   drivers/net/netdevsim/dev.c:870:14: error: too many arguments to function call, expected 3, have 4
                                             NULL, i);
                                                   ^
   drivers/net/netdevsim/dev.c:844:1: note: '__nsim_dev_port_add' declared here
   __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
   ^
   drivers/net/netdevsim/dev.c:883:39: error: too many arguments to function call, expected single argument 'nsim_dev_port', have 3 arguments
                           __nsim_dev_port_del(nsim_dev_port, NULL, i);
                           ~~~~~~~~~~~~~~~~~~~                ^~~~~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
   #define NULL ((void *)0)
                ^
   drivers/net/netdevsim/dev.c:846:13: note: '__nsim_dev_port_del' declared here
   static void __nsim_dev_port_del(struct nsim_dev_port *nsim_dev_port);
               ^
   drivers/net/netdevsim/dev.c:1625:12: error: conflicting types for '__nsim_dev_port_add'
   static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
              ^
   drivers/net/netdevsim/dev.c:844:1: note: previous declaration is here
   __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
   ^
   drivers/net/netdevsim/dev.c:1738:14: error: too many arguments to function call, expected 3, have 4
                                             NULL, i);
                                                   ^
   drivers/net/netdevsim/dev.c:844:1: note: '__nsim_dev_port_add' declared here
   __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
   ^
   drivers/net/netdevsim/dev.c:2213:27: error: too many arguments to function call, expected 3, have 4
                                             nsim_dev_linecard, port_index);
                                                                ^~~~~~~~~~
   drivers/net/netdevsim/dev.c:844:1: note: '__nsim_dev_port_add' declared here
   __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
   ^
   6 errors generated.


vim +119 drivers/net/netdevsim/dev.c

eae68f21fc5005 Jiri Pirko 2021-05-05  100  
eae68f21fc5005 Jiri Pirko 2021-05-05  101  static int
eae68f21fc5005 Jiri Pirko 2021-05-05  102  nsim_dev_linecard_devices_create(struct nsim_dev_linecard *nsim_dev_linecard)
eae68f21fc5005 Jiri Pirko 2021-05-05  103  {
eae68f21fc5005 Jiri Pirko 2021-05-05  104  	struct devlink_linecard_device *device;
eae68f21fc5005 Jiri Pirko 2021-05-05  105  	char *component_name;
eae68f21fc5005 Jiri Pirko 2021-05-05  106  	int err;
eae68f21fc5005 Jiri Pirko 2021-05-05  107  	int i;
eae68f21fc5005 Jiri Pirko 2021-05-05  108  
eae68f21fc5005 Jiri Pirko 2021-05-05  109  	snprintf(nsim_dev_linecard->device_component_name,
eae68f21fc5005 Jiri Pirko 2021-05-05  110  		 sizeof(nsim_dev_linecard->device_component_name), "lc%u_dev0",
eae68f21fc5005 Jiri Pirko 2021-05-05  111  		 nsim_dev_linecard->linecard_index);
eae68f21fc5005 Jiri Pirko 2021-05-05  112  	component_name = nsim_dev_linecard->device_component_name;
eae68f21fc5005 Jiri Pirko 2021-05-05  113  
eae68f21fc5005 Jiri Pirko 2021-05-05  114  	for (i = 0; i < NSIM_DEV_LINECARD_DEVICE_COUNT; i++) {
eae68f21fc5005 Jiri Pirko 2021-05-05  115  		if (i > 0)
eae68f21fc5005 Jiri Pirko 2021-05-05  116  			component_name = NULL;
eae68f21fc5005 Jiri Pirko 2021-05-05  117  		device = devlink_linecard_device_create(nsim_dev_linecard->devlink_linecard,
eae68f21fc5005 Jiri Pirko 2021-05-05  118  							i, component_name,
eae68f21fc5005 Jiri Pirko 2021-05-05 @119  							nsim_dev_linecard);
eae68f21fc5005 Jiri Pirko 2021-05-05  120  		if (IS_ERR(device)) {
eae68f21fc5005 Jiri Pirko 2021-05-05  121  			err = PTR_ERR(device);
eae68f21fc5005 Jiri Pirko 2021-05-05  122  			goto rollback;
eae68f21fc5005 Jiri Pirko 2021-05-05  123  		}
eae68f21fc5005 Jiri Pirko 2021-05-05  124  		nsim_dev_linecard->devlink_device[i] = device;
eae68f21fc5005 Jiri Pirko 2021-05-05  125  	}
eae68f21fc5005 Jiri Pirko 2021-05-05  126  	return 0;
eae68f21fc5005 Jiri Pirko 2021-05-05  127  
eae68f21fc5005 Jiri Pirko 2021-05-05  128  rollback:
eae68f21fc5005 Jiri Pirko 2021-05-05  129  	for (i--; i >= 0; i--) {
eae68f21fc5005 Jiri Pirko 2021-05-05  130  		device = nsim_dev_linecard->devlink_device[i];
eae68f21fc5005 Jiri Pirko 2021-05-05  131  		devlink_linecard_device_destroy(nsim_dev_linecard->devlink_linecard,
eae68f21fc5005 Jiri Pirko 2021-05-05  132  						device);
eae68f21fc5005 Jiri Pirko 2021-05-05  133  	}
eae68f21fc5005 Jiri Pirko 2021-05-05  134  	return err;
eae68f21fc5005 Jiri Pirko 2021-05-05  135  }
eae68f21fc5005 Jiri Pirko 2021-05-05  136  

:::::: The code at line 119 was first introduced by commit
:::::: eae68f21fc5005048b5b49a4c953ff76b724df98 netdevsim: create couple of devices on each linecard

:::::: TO: Jiri Pirko <jiri@nvidia.com>
:::::: CC: Jiri Pirko <jiri@nvidia.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

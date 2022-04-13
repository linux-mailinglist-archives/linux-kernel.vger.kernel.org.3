Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F2E4FEF35
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbiDMGIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbiDMGHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:07:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EE335879
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649829931; x=1681365931;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7J159Gh9HkMijLSs1cF0rPxuBSczFLJZo1h/cJRFq6E=;
  b=fIgryeKWt5UlXbW2k2blBNARX8ZToe9LoRKBnoWnc8X7j5+ORLUf6Oak
   i55MtmmM3nMdvh75AKvWnOcXZFhCApplonJ89a7SNoe4PUe84pCYkRo+K
   ZIJ6oQWn9F6s/3AgnJ2q9k1GcUEhy3PwxXY5l9B4LIJHhy2/GJ4iylEvB
   M9RkZjJZeGlfSH8KywMuhp7SnyWT87YJuiNY9niUb4AL07uctH1TnnOWZ
   aSnBLO7m67nhJPa+R5iH+XN/YedvLQoy6Apv718p+Y3JiYsS4C7AV6Glh
   TsslDVm8VSVhRkhK3q94FYzl2udM6B2p+VmzWqXEQUsNEV+Q1wWl8b8si
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="262026484"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="262026484"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 23:05:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="724769585"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 Apr 2022 23:05:30 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neW89-00005k-G5;
        Wed, 13 Apr 2022 06:05:29 +0000
Date:   Wed, 13 Apr 2022 14:02:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_linecards 92/94]
 drivers/net/netdevsim/dev.c:119:25: error: too few arguments to function
 call, expected 5, have 4
Message-ID: <202204131305.23NkbTFh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_linecards
head:   ca9bd759ed5f4422d41446de7c31c6a189ac87df
commit: f39238e4c9d54b5f8d9ebe9c333b83509a644803 [92/94] TMP: devlink device type
config: x86_64-randconfig-a001-20220411 (https://download.01.org/0day-ci/archive/20220413/202204131305.23NkbTFh-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fe2478d44e4f7f191c43fef629ac7a23d0251e72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/f39238e4c9d54b5f8d9ebe9c333b83509a644803
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout f39238e4c9d54b5f8d9ebe9c333b83509a644803
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/netdevsim/

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

f516d881f25d5ec Jiri Pirko 2021-05-05  100  
f516d881f25d5ec Jiri Pirko 2021-05-05  101  static int
f516d881f25d5ec Jiri Pirko 2021-05-05  102  nsim_dev_linecard_devices_create(struct nsim_dev_linecard *nsim_dev_linecard)
f516d881f25d5ec Jiri Pirko 2021-05-05  103  {
f516d881f25d5ec Jiri Pirko 2021-05-05  104  	struct devlink_linecard_device *device;
f516d881f25d5ec Jiri Pirko 2021-05-05  105  	char *component_name;
f516d881f25d5ec Jiri Pirko 2021-05-05  106  	int err;
f516d881f25d5ec Jiri Pirko 2021-05-05  107  	int i;
f516d881f25d5ec Jiri Pirko 2021-05-05  108  
f516d881f25d5ec Jiri Pirko 2021-05-05  109  	snprintf(nsim_dev_linecard->device_component_name,
f516d881f25d5ec Jiri Pirko 2021-05-05  110  		 sizeof(nsim_dev_linecard->device_component_name), "lc%u_dev0",
f516d881f25d5ec Jiri Pirko 2021-05-05  111  		 nsim_dev_linecard->linecard_index);
f516d881f25d5ec Jiri Pirko 2021-05-05  112  	component_name = nsim_dev_linecard->device_component_name;
f516d881f25d5ec Jiri Pirko 2021-05-05  113  
f516d881f25d5ec Jiri Pirko 2021-05-05  114  	for (i = 0; i < NSIM_DEV_LINECARD_DEVICE_COUNT; i++) {
f516d881f25d5ec Jiri Pirko 2021-05-05  115  		if (i > 0)
f516d881f25d5ec Jiri Pirko 2021-05-05  116  			component_name = NULL;
f516d881f25d5ec Jiri Pirko 2021-05-05  117  		device = devlink_linecard_device_create(nsim_dev_linecard->devlink_linecard,
f516d881f25d5ec Jiri Pirko 2021-05-05  118  							i, component_name,
f516d881f25d5ec Jiri Pirko 2021-05-05 @119  							nsim_dev_linecard);
f516d881f25d5ec Jiri Pirko 2021-05-05  120  		if (IS_ERR(device)) {
f516d881f25d5ec Jiri Pirko 2021-05-05  121  			err = PTR_ERR(device);
f516d881f25d5ec Jiri Pirko 2021-05-05  122  			goto rollback;
f516d881f25d5ec Jiri Pirko 2021-05-05  123  		}
f516d881f25d5ec Jiri Pirko 2021-05-05  124  		nsim_dev_linecard->devlink_device[i] = device;
f516d881f25d5ec Jiri Pirko 2021-05-05  125  	}
f516d881f25d5ec Jiri Pirko 2021-05-05  126  	return 0;
f516d881f25d5ec Jiri Pirko 2021-05-05  127  
f516d881f25d5ec Jiri Pirko 2021-05-05  128  rollback:
f516d881f25d5ec Jiri Pirko 2021-05-05  129  	for (i--; i >= 0; i--) {
f516d881f25d5ec Jiri Pirko 2021-05-05  130  		device = nsim_dev_linecard->devlink_device[i];
f516d881f25d5ec Jiri Pirko 2021-05-05  131  		devlink_linecard_device_destroy(nsim_dev_linecard->devlink_linecard,
f516d881f25d5ec Jiri Pirko 2021-05-05  132  						device);
f516d881f25d5ec Jiri Pirko 2021-05-05  133  	}
f516d881f25d5ec Jiri Pirko 2021-05-05  134  	return err;
f516d881f25d5ec Jiri Pirko 2021-05-05  135  }
f516d881f25d5ec Jiri Pirko 2021-05-05  136  

:::::: The code at line 119 was first introduced by commit
:::::: f516d881f25d5ec76a01608f6b13e88d91687f6c netdevsim: create couple of devices on each linecard

:::::: TO: Jiri Pirko <jiri@nvidia.com>
:::::: CC: Jiri Pirko <jiri@nvidia.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

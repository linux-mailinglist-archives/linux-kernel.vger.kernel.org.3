Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BD44C495A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242279AbiBYPnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242261AbiBYPmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:42:51 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EA822BD52
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645803738; x=1677339738;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qS1UkjfVck3GZcFx0Xa3E9JeIwrYLsFicio417P3JbE=;
  b=jRQkCg74cllO35UugUVITih8Cms1TOrAvYpzSJKDoeyTWVtjNrp+Iv1e
   b7BrXY5vNr7sgbFBjBdfCt0Ut0WKlR7GD8NhlN+08pzAFZFkVUtZZ5j1a
   oohasQ+3elUUUFwnbZMeK0wtcinddVzeCUEX9NE54mfevjc4pWpg+SU81
   1UEtOYgOYSSO1mpYtHuJqAeVZK/JqnDcsX/hCSBx4EAcCtHZuCFHH6MYY
   AvW3P/mPlrDorytngJ7RWkJ2ifpS6Gnnzg5H6/ic6tc77O8p+BQN3c5G4
   E29e1J+gsFmD+Yno1mXMpXUQOZopPudLRYcIdufjqhzjn9V+hXsFhKEMN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="277153576"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="277153576"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 07:42:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="549305435"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 25 Feb 2022 07:42:16 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNcjX-0004T4-Qa; Fri, 25 Feb 2022 15:42:15 +0000
Date:   Fri, 25 Feb 2022 23:41:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_linecards 38/39]
 drivers/net/netdevsim/dev.c:119:25: error: too few arguments to function
 call, expected 5, have 4
Message-ID: <202202252349.rMN9E62A-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: arm64-randconfig-r011-20220225 (https://download.01.org/0day-ci/archive/20220225/202202252349.rMN9E62A-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/jpirko/linux_mlxsw/commit/36f00f891469372ccec5b7d6442e13e284ceca13
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout 36f00f891469372ccec5b7d6442e13e284ceca13
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/net/netdevsim/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/netdevsim/dev.c:119:25: error: too few arguments to function call, expected 5, have 4
                                                           nsim_dev_linecard);
                                                                            ^
   include/net/devlink.h:1577:1: note: 'devlink_linecard_device_create' declared here
   devlink_linecard_device_create(struct devlink_linecard *linecard,
   ^
   1 error generated.


vim +119 drivers/net/netdevsim/dev.c

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
e8caa751f8b7e3 Jiri Pirko 2021-05-05  117  		device = devlink_linecard_device_create(nsim_dev_linecard->devlink_linecard,
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D92569A0D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 07:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiGGFse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 01:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiGGFsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 01:48:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61BA33B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 22:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657172906; x=1688708906;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CVTdAenqViN5CKy4mkseosvPlqOI4FT220hqm4xY8DM=;
  b=YUGgErUR7CsOve7q96b2CHD1VGxxB05JWS+HSOAMYJPF9gLob26DgIXX
   E9l5ZddfXAUz0+3abK2ubU8ZVOMGCUi28HF0B92uWencd7HzZ2AECMdZv
   oDPIl1ojHZ5Tz782+Xv6pFUogTL2mQBPpYCFo2CQeOPssiJQxpRLh6XgH
   hSS9kb1BjpogFK1DY3WLrOt/oDprsHI9G31y4SMhk8Hd/8QSLo4+uyncI
   mXfj6BRa+9YCTJEVkjoh0JHgIP0K4SpiuRbWSSAh4tr1dyQzXOQsvWgEX
   TNUTnr4Q4I4oi0gayvsXfGmXqluJq6OqIxNOnsjzC1zvMtNBC4XWHib7e
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="370254539"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="370254539"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 22:48:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="543690962"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Jul 2022 22:48:25 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9KNE-000Lbq-Bs;
        Thu, 07 Jul 2022 05:48:24 +0000
Date:   Thu, 7 Jul 2022 13:47:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_devlink_locking 29/31]
 drivers/net/netdevsim/dev.c:946:30: warning: variable 'nsim_bus_dev' set but
 not used
Message-ID: <202207071338.SYuecpQ6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_devlink_locking
head:   34fad48fbf94ea603412cfc9375b958ef38fa3e0
commit: 1b1a655315d99a84b3f065d9f950fab8358114d5 [29/31] netdevsim: convert driver to devlink unlocked API during init/fini
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220707/202207071338.SYuecpQ6-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/1b1a655315d99a84b3f065d9f950fab8358114d5
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_devlink_locking
        git checkout 1b1a655315d99a84b3f065d9f950fab8358114d5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/gpio/ drivers/net/netdevsim/ drivers/tty/serial/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/netdevsim/dev.c: In function 'nsim_dev_reload_down':
>> drivers/net/netdevsim/dev.c:946:30: warning: variable 'nsim_bus_dev' set but not used [-Wunused-but-set-variable]
     946 |         struct nsim_bus_dev *nsim_bus_dev;
         |                              ^~~~~~~~~~~~
   drivers/net/netdevsim/dev.c: In function 'nsim_dev_reload_up':
   drivers/net/netdevsim/dev.c:970:30: warning: variable 'nsim_bus_dev' set but not used [-Wunused-but-set-variable]
     970 |         struct nsim_bus_dev *nsim_bus_dev;
         |                              ^~~~~~~~~~~~


vim +/nsim_bus_dev +946 drivers/net/netdevsim/dev.c

75ba029f3c07f47 Jiri Pirko      2019-10-03  940  
070c63f20f6c739 Jiri Pirko      2019-10-03  941  static int nsim_dev_reload_down(struct devlink *devlink, bool netns_change,
dc64cc7c63102ac Moshe Shemesh   2020-10-07  942  				enum devlink_reload_action action, enum devlink_reload_limit limit,
dc64cc7c63102ac Moshe Shemesh   2020-10-07  943  				struct netlink_ext_ack *extack)
97691069dc5a413 Jiri Pirko      2019-09-12  944  {
75ba029f3c07f47 Jiri Pirko      2019-10-03  945  	struct nsim_dev *nsim_dev = devlink_priv(devlink);
23809a726c0d004 Leon Romanovsky 2021-08-05 @946  	struct nsim_bus_dev *nsim_bus_dev;
23809a726c0d004 Leon Romanovsky 2021-08-05  947  
1b1a655315d99a8 Jiri Pirko      2022-07-01  948  	devl_lock(devlink);
23809a726c0d004 Leon Romanovsky 2021-08-05  949  	nsim_bus_dev = nsim_dev->nsim_bus_dev;
75ba029f3c07f47 Jiri Pirko      2019-10-03  950  
155ddfc5e54a68f Jiri Pirko      2019-10-06  951  	if (nsim_dev->dont_allow_reload) {
155ddfc5e54a68f Jiri Pirko      2019-10-06  952  		/* For testing purposes, user set debugfs dont_allow_reload
155ddfc5e54a68f Jiri Pirko      2019-10-06  953  		 * value to true. So forbid it.
155ddfc5e54a68f Jiri Pirko      2019-10-06  954  		 */
f9867b51d268d6f Colin Ian King  2019-10-08  955  		NL_SET_ERR_MSG_MOD(extack, "User forbid the reload for testing purposes");
1b1a655315d99a8 Jiri Pirko      2022-07-01  956  		devl_unlock(devlink);
155ddfc5e54a68f Jiri Pirko      2019-10-06  957  		return -EOPNOTSUPP;
155ddfc5e54a68f Jiri Pirko      2019-10-06  958  	}
155ddfc5e54a68f Jiri Pirko      2019-10-06  959  
75ba029f3c07f47 Jiri Pirko      2019-10-03  960  	nsim_dev_reload_destroy(nsim_dev);
1b1a655315d99a8 Jiri Pirko      2022-07-01  961  	devl_unlock(devlink);
97691069dc5a413 Jiri Pirko      2019-09-12  962  	return 0;
97691069dc5a413 Jiri Pirko      2019-09-12  963  }
97691069dc5a413 Jiri Pirko      2019-09-12  964  

:::::: The code at line 946 was first introduced by commit
:::::: 23809a726c0d004b9d2474333181f8da07360469 netdevsim: Forbid devlink reload when adding or deleting ports

:::::: TO: Leon Romanovsky <leonro@nvidia.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

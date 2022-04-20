Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23CE5084B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377128AbiDTJUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377120AbiDTJUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:20:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125FC3D481
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650446246; x=1681982246;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d0q+l/Tx4dg0QO5EM4mRwaJzI/XMQiqqEj6W6FuUNCs=;
  b=Vx/ppmJA1UU74kmkXJtU2MTTFsffjQqdNF0ak2VeN7ht3PBe8AokKR4t
   wQjCnVWOpgWpqsf/ZvcqHbw45OHdi4gUk2Ka2Rur76iwoYAkVD4au8jQD
   2xFxzCXDNFQNm3ELxfySVcw3OFTsSau6PTIqaU1onD6RakG6jzuRLLpuC
   kV+EP36X4vy3o8aFHEEc9PdZsy9LvSEQS/48VjWvaHL9e33TsUiiLoULL
   vjLgWC7VeXaSFA6e4lpz4A5P/DL9P7SXp1d/tLD+c9eL7ow1Ce/vz96zR
   0qqjDJH+7vuDAjyaKimB5T5QHs0Ty9Y3KQNAnr/uc5oPA2HEVY7rAHBh0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="289087626"
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="289087626"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 02:17:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="702571566"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Apr 2022 02:17:15 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nh6SY-0006oM-Gn;
        Wed, 20 Apr 2022 09:17:14 +0000
Date:   Wed, 20 Apr 2022 17:16:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_linecards 80/94]
 drivers/net/netdevsim/dev.c:638:14: error: too many arguments to function
 call, expected 3, have 4
Message-ID: <202204201647.Q31yEinv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_linecards
head:   653975cafc05a2ffc68d2cbd1c5a328c67ce7142
commit: 78c43bf2e1044e9eb1a92a976723f2ecb9e60688 [80/94] netdevsim: allow port objects to be linked with line cards
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220420/202204201647.Q31yEinv-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/78c43bf2e1044e9eb1a92a976723f2ecb9e60688
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout 78c43bf2e1044e9eb1a92a976723f2ecb9e60688
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/netdevsim/dev.c:638:14: error: too many arguments to function call, expected 3, have 4
                                             NULL, i);
                                                   ^
   drivers/net/netdevsim/dev.c:612:1: note: '__nsim_dev_port_add' declared here
   __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
   ^
>> drivers/net/netdevsim/dev.c:651:39: error: too many arguments to function call, expected single argument 'nsim_dev_port', have 3 arguments
                           __nsim_dev_port_del(nsim_dev_port, NULL, i);
                           ~~~~~~~~~~~~~~~~~~~                ^~~~~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
   #define NULL ((void *)0)
                ^
   drivers/net/netdevsim/dev.c:614:13: note: '__nsim_dev_port_del' declared here
   static void __nsim_dev_port_del(struct nsim_dev_port *nsim_dev_port);
               ^
   drivers/net/netdevsim/dev.c:1393:12: error: conflicting types for '__nsim_dev_port_add'
   static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
              ^
   drivers/net/netdevsim/dev.c:612:1: note: previous declaration is here
   __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
   ^
   drivers/net/netdevsim/dev.c:1503:14: error: too many arguments to function call, expected 3, have 4
                                             NULL, i);
                                                   ^
   drivers/net/netdevsim/dev.c:612:1: note: '__nsim_dev_port_add' declared here
   __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
   ^
   drivers/net/netdevsim/dev.c:1839:27: error: too many arguments to function call, expected 3, have 4
                                             nsim_dev_linecard, port_index);
                                                                ^~~~~~~~~~
   drivers/net/netdevsim/dev.c:612:1: note: '__nsim_dev_port_add' declared here
   __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
   ^
   5 errors generated.


vim +638 drivers/net/netdevsim/dev.c

   629	
   630	static int nsim_esw_switchdev_enable(struct nsim_dev *nsim_dev,
   631					     struct netlink_ext_ack *extack)
   632	{
   633		struct nsim_dev_port *nsim_dev_port, *tmp;
   634		int i, err;
   635	
   636		for (i = 0; i < nsim_dev_get_vfs(nsim_dev); i++) {
   637			err = __nsim_dev_port_add(nsim_dev, NSIM_DEV_PORT_TYPE_VF,
 > 638						  NULL, i);
   639			if (err) {
   640				NL_SET_ERR_MSG_MOD(extack, "Failed to initialize VFs' netdevsim ports");
   641				pr_err("Failed to initialize VF id=%d. %d.\n", i, err);
   642				goto err_port_add_vfs;
   643			}
   644		}
   645		nsim_dev->esw_mode = DEVLINK_ESWITCH_MODE_SWITCHDEV;
   646		return 0;
   647	
   648	err_port_add_vfs:
   649		list_for_each_entry_safe(nsim_dev_port, tmp, &nsim_dev->port_list, list)
   650			if (nsim_dev_port_is_vf(nsim_dev_port))
 > 651				__nsim_dev_port_del(nsim_dev_port, NULL, i);
   652		return err;
   653	}
   654	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

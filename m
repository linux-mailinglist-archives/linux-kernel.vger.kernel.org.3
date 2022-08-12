Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08655916A7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 23:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiHLVNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 17:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbiHLVNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 17:13:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999C516599
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 14:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660338781; x=1691874781;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7848sidLDarT6j7aY2jOGTPG6hFO16Fh4N33HSPH+Xo=;
  b=OtTOM+g7GiquPSfz1dwYw3PfWKk0dqiIQIMFehUELTTCzRHzP1jr0F9A
   D7lux020n6H2D03l5PZjui5MtwbrWHE8iiPO03TfhwBop11wzdtWlajme
   UBD1N5NvMmqW0NO0adJS2pxLg5/PVEuHZfMwwGmAWpUvlD7oVbtTbVvJ7
   CTzadMNU1r/7H/QZ3/UoPyhwm5QeU5OfBCL8/r6Dgy2Pv7fcgpcHJTCq3
   QML6/7Ph7PKbaobnIbRoPmyDRjhFtI5xtgwXWqc2fNnxnfQeYe5R4p4W/
   EaEleD/azEBXU7gpkoOqfYzNSI5QE3gVU9cdXlHByC1nsE6HnIhLn253m
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292957683"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="292957683"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 14:12:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="609377472"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 12 Aug 2022 14:12:56 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMbxg-0000wp-0m;
        Fri, 12 Aug 2022 21:12:56 +0000
Date:   Sat, 13 Aug 2022 05:12:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_devlink_locking 33/40]
 drivers/net/netdevsim/netdev.c:363:2: error: expected expression
Message-ID: <202208130537.EKYjXYLm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_devlink_locking
head:   3752df45a64c94afd110eeb956cd9adaeec586c1
commit: 95a8f1859e438effd49d5c1ae7828e87b8471180 [33/40] net: make drivers to use SET_NETDEV_DEVLINK_PORT to set devlink_port
config: hexagon-randconfig-r041-20220812 (https://download.01.org/0day-ci/archive/20220813/202208130537.EKYjXYLm-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/95a8f1859e438effd49d5c1ae7828e87b8471180
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_devlink_locking
        git checkout 95a8f1859e438effd49d5c1ae7828e87b8471180
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/net/netdevsim/ net/dsa/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/netdevsim/netdev.c:363:2: error: expected ';' after expression
           SET_NETDEV_DEVLINK_PORT(dev, &nsim_dev_port->devlink_port);
           ^
   include/linux/netdevice.h:2347:44: note: expanded from macro 'SET_NETDEV_DEVLINK_PORT'
           ((dev)->devlink_port = (_devlink_port))                 \
                                                                   ^
>> drivers/net/netdevsim/netdev.c:363:2: error: expected expression
   include/linux/netdevice.h:2347:44: note: expanded from macro 'SET_NETDEV_DEVLINK_PORT'
           ((dev)->devlink_port = (_devlink_port))                 \
                                                                   ^
>> drivers/net/netdevsim/netdev.c:363:60: error: expected ')'
           SET_NETDEV_DEVLINK_PORT(dev, &nsim_dev_port->devlink_port);
                                                                     ^
   drivers/net/netdevsim/netdev.c:363:2: note: to match this '('
           SET_NETDEV_DEVLINK_PORT(dev, &nsim_dev_port->devlink_port);
           ^
   include/linux/netdevice.h:2345:53: note: expanded from macro 'SET_NETDEV_DEVLINK_PORT'
   #define SET_NETDEV_DEVLINK_PORT(dev, _devlink_port) ({          \
                                                       ^
   3 errors generated.
--
   net/dsa/slave.c:2367:2: error: expected ';' after expression
           SET_NETDEV_DEVLINK_PORT(slave_dev, &port->devlink_port);
           ^
   include/linux/netdevice.h:2347:44: note: expanded from macro 'SET_NETDEV_DEVLINK_PORT'
           ((dev)->devlink_port = (_devlink_port))                 \
                                                                   ^
>> net/dsa/slave.c:2367:2: error: expected expression
   include/linux/netdevice.h:2347:44: note: expanded from macro 'SET_NETDEV_DEVLINK_PORT'
           ((dev)->devlink_port = (_devlink_port))                 \
                                                                   ^
>> net/dsa/slave.c:2367:57: error: expected ')'
           SET_NETDEV_DEVLINK_PORT(slave_dev, &port->devlink_port);
                                                                  ^
   net/dsa/slave.c:2367:2: note: to match this '('
           SET_NETDEV_DEVLINK_PORT(slave_dev, &port->devlink_port);
           ^
   include/linux/netdevice.h:2345:53: note: expanded from macro 'SET_NETDEV_DEVLINK_PORT'
   #define SET_NETDEV_DEVLINK_PORT(dev, _devlink_port) ({          \
                                                       ^
   3 errors generated.


vim +363 drivers/net/netdevsim/netdev.c

   342	
   343	struct netdevsim *
   344	nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
   345	{
   346		struct net_device *dev;
   347		struct netdevsim *ns;
   348		int err;
   349	
   350		dev = alloc_netdev_mq(sizeof(*ns), "eth%d", NET_NAME_UNKNOWN, nsim_setup,
   351				      nsim_dev->nsim_bus_dev->num_queues);
   352		if (!dev)
   353			return ERR_PTR(-ENOMEM);
   354	
   355		dev_net_set(dev, nsim_dev_net(nsim_dev));
   356		ns = netdev_priv(dev);
   357		ns->netdev = dev;
   358		u64_stats_init(&ns->syncp);
   359		ns->nsim_dev = nsim_dev;
   360		ns->nsim_dev_port = nsim_dev_port;
   361		ns->nsim_bus_dev = nsim_dev->nsim_bus_dev;
   362		SET_NETDEV_DEV(dev, &ns->nsim_bus_dev->dev);
 > 363		SET_NETDEV_DEVLINK_PORT(dev, &nsim_dev_port->devlink_port);
   364		nsim_ethtool_init(ns);
   365		if (nsim_dev_port_is_pf(nsim_dev_port))
   366			err = nsim_init_netdevsim(ns);
   367		else
   368			err = nsim_init_netdevsim_vf(ns);
   369		if (err)
   370			goto err_free_netdev;
   371		return ns;
   372	
   373	err_free_netdev:
   374		free_netdev(dev);
   375		return ERR_PTR(err);
   376	}
   377	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

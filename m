Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC40494620
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 04:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358353AbiATD16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 22:27:58 -0500
Received: from mga07.intel.com ([134.134.136.100]:41870 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbiATD1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 22:27:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642649270; x=1674185270;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XG8s3XGtECvgqqQFb7ALpfIcn7JjjsxEtKGBkjmJqh4=;
  b=i2nBfa4IKwPDaRY9iZaS5bfB9TjvxfzuaTEWpb1sHO2ctGtJ8J2NtijQ
   sY65wnbT6xccWCeciK6PneaBKwXHGoNIUERzKg8B7OWHnQ10CqmAYlE2B
   quIqKUp2aLlywAGYEjmt/MYn0mgx3mSEWUDMXb++UAAD+PXGmF+3EEC5g
   m9BjwxKpMhee1FeEnVqpVSMZbNxT15HmzVCrex/Pjetc/VdlbFuUz0eeP
   DH9HxcNH7b5SbkwhLL7P70oCGsNrCw9MWZg8W2rcUEMNz1JkF7DcbuLSV
   aYTH+qg6bbzdsKh/UF24Uuy0y8dDvXpEd92dKekWrUhAk6bxg+yy6OF1p
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="308597217"
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; 
   d="scan'208";a="308597217"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 19:27:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; 
   d="scan'208";a="626143978"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 Jan 2022 19:27:48 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAO71-000DxN-FU; Thu, 20 Jan 2022 03:27:47 +0000
Date:   Thu, 20 Jan 2022 11:27:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amit Cohen <amcohen@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>
Subject: [jpirko-mlxsw:ubridge 63/78]
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2652:6: warning:
 variable 'vid' is used uninitialized whenever 'if' condition is true
Message-ID: <202201200839.oo2R9DV2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw ubridge
head:   976afb368c2f7efc2dc2436013895cc96ab06774
commit: 126a17e336358fd81470d0a19b64130234eca122 [63/78] mlxsw: Configure egress VID for unicast FDB entries
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220120/202201200839.oo2R9DV2-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f7b7138a62648f4019c55e4671682af1f851f295)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/126a17e336358fd81470d0a19b64130234eca122
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw ubridge
        git checkout 126a17e336358fd81470d0a19b64130234eca122
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/ethernet/mellanox/mlxsw/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2652:6: warning: variable 'vid' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!bridge_port) {
               ^~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2661:64: note: uninitialized use occurs here
           err = mlxsw_sp_port_fdb_uc_op(mlxsw_sp, local_port, mac, fid, vid,
                                                                         ^~~
   drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2652:2: note: remove the 'if' if its condition is always false
           if (!bridge_port) {
           ^~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2646:6: warning: variable 'vid' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!mlxsw_sp_port_vlan) {
               ^~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2661:64: note: uninitialized use occurs here
           err = mlxsw_sp_port_fdb_uc_op(mlxsw_sp, local_port, mac, fid, vid,
                                                                         ^~~
   drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2646:2: note: remove the 'if' if its condition is always false
           if (!mlxsw_sp_port_vlan) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2642:6: warning: variable 'vid' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (mlxsw_sp_fid_is_dummy(mlxsw_sp, fid))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2661:64: note: uninitialized use occurs here
           err = mlxsw_sp_port_fdb_uc_op(mlxsw_sp, local_port, mac, fid, vid,
                                                                         ^~~
   drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2642:2: note: remove the 'if' if its condition is always false
           if (mlxsw_sp_fid_is_dummy(mlxsw_sp, fid))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2637:6: warning: variable 'vid' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!mlxsw_sp_port) {
               ^~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2661:64: note: uninitialized use occurs here
           err = mlxsw_sp_port_fdb_uc_op(mlxsw_sp, local_port, mac, fid, vid,
                                                                         ^~~
   drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2637:2: note: remove the 'if' if its condition is always false
           if (!mlxsw_sp_port) {
           ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2628:9: note: initialize the variable 'vid' to silence this warning
           u16 vid, fid;
                  ^
                   = 0
   4 warnings generated.


vim +2652 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c

8a1ab5d766396aa Jiri Pirko         2015-12-03  2616  
56ade8fe3fe1e13 Jiri Pirko         2015-10-16  2617  static void mlxsw_sp_fdb_notify_mac_process(struct mlxsw_sp *mlxsw_sp,
56ade8fe3fe1e13 Jiri Pirko         2015-10-16  2618  					    char *sfn_pl, int rec_index,
56ade8fe3fe1e13 Jiri Pirko         2015-10-16  2619  					    bool adding)
56ade8fe3fe1e13 Jiri Pirko         2015-10-16  2620  {
c57529e1d5d882f Ido Schimmel       2017-05-26  2621  	struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan;
c57529e1d5d882f Ido Schimmel       2017-05-26  2622  	struct mlxsw_sp_bridge_device *bridge_device;
c57529e1d5d882f Ido Schimmel       2017-05-26  2623  	struct mlxsw_sp_bridge_port *bridge_port;
56ade8fe3fe1e13 Jiri Pirko         2015-10-16  2624  	struct mlxsw_sp_port *mlxsw_sp_port;
1b40dc3d86724c7 Arkadi Sharshevsky 2017-06-08  2625  	enum switchdev_notifier_type type;
56ade8fe3fe1e13 Jiri Pirko         2015-10-16  2626  	char mac[ETH_ALEN];
c934757d90000a9 Amit Cohen         2021-12-01  2627  	u16 local_port;
9de6a80e061238d Ido Schimmel       2015-12-15  2628  	u16 vid, fid;
12f1501e7511958 Jiri Pirko         2016-01-07  2629  	bool do_notification = true;
56ade8fe3fe1e13 Jiri Pirko         2015-10-16  2630  	int err;
56ade8fe3fe1e13 Jiri Pirko         2015-10-16  2631  
9de6a80e061238d Ido Schimmel       2015-12-15  2632  	mlxsw_reg_sfn_mac_unpack(sfn_pl, rec_index, mac, &fid, &local_port);
837ec05cfea0828 Danielle Ratson    2021-05-17  2633  
c49bf28ae363005 Amit Cohen         2022-01-17  2634  	if (WARN_ON_ONCE(!mlxsw_sp_local_port_is_valid(mlxsw_sp, local_port)))
837ec05cfea0828 Danielle Ratson    2021-05-17  2635  		return;
56ade8fe3fe1e13 Jiri Pirko         2015-10-16  2636  	mlxsw_sp_port = mlxsw_sp->ports[local_port];
56ade8fe3fe1e13 Jiri Pirko         2015-10-16  2637  	if (!mlxsw_sp_port) {
56ade8fe3fe1e13 Jiri Pirko         2015-10-16  2638  		dev_err_ratelimited(mlxsw_sp->bus_info->dev, "Incorrect local port in FDB notification\n");
12f1501e7511958 Jiri Pirko         2016-01-07  2639  		goto just_remove;
56ade8fe3fe1e13 Jiri Pirko         2015-10-16  2640  	}
56ade8fe3fe1e13 Jiri Pirko         2015-10-16  2641  
577fa14d210073b Ido Schimmel       2019-07-17  2642  	if (mlxsw_sp_fid_is_dummy(mlxsw_sp, fid))
577fa14d210073b Ido Schimmel       2019-07-17  2643  		goto just_remove;
577fa14d210073b Ido Schimmel       2019-07-17  2644  
c57529e1d5d882f Ido Schimmel       2017-05-26  2645  	mlxsw_sp_port_vlan = mlxsw_sp_port_vlan_find_by_fid(mlxsw_sp_port, fid);
c57529e1d5d882f Ido Schimmel       2017-05-26  2646  	if (!mlxsw_sp_port_vlan) {
c57529e1d5d882f Ido Schimmel       2017-05-26  2647  		netdev_err(mlxsw_sp_port->dev, "Failed to find a matching {Port, VID} following FDB notification\n");
12f1501e7511958 Jiri Pirko         2016-01-07  2648  		goto just_remove;
aac78a44088728f Ido Schimmel       2015-12-15  2649  	}
c57529e1d5d882f Ido Schimmel       2017-05-26  2650  
c57529e1d5d882f Ido Schimmel       2017-05-26  2651  	bridge_port = mlxsw_sp_port_vlan->bridge_port;
c57529e1d5d882f Ido Schimmel       2017-05-26 @2652  	if (!bridge_port) {
c57529e1d5d882f Ido Schimmel       2017-05-26  2653  		netdev_err(mlxsw_sp_port->dev, "{Port, VID} not associated with a bridge\n");
c57529e1d5d882f Ido Schimmel       2017-05-26  2654  		goto just_remove;
aac78a44088728f Ido Schimmel       2015-12-15  2655  	}
aac78a44088728f Ido Schimmel       2015-12-15  2656  
c57529e1d5d882f Ido Schimmel       2017-05-26  2657  	bridge_device = bridge_port->bridge_device;
c57529e1d5d882f Ido Schimmel       2017-05-26  2658  	vid = bridge_device->vlan_enabled ? mlxsw_sp_port_vlan->vid : 0;
c57529e1d5d882f Ido Schimmel       2017-05-26  2659  
12f1501e7511958 Jiri Pirko         2016-01-07  2660  do_fdb_op:
126a17e336358fd Amit Cohen         2022-01-04  2661  	err = mlxsw_sp_port_fdb_uc_op(mlxsw_sp, local_port, mac, fid, vid,
12f1501e7511958 Jiri Pirko         2016-01-07  2662  				      adding, true);
56ade8fe3fe1e13 Jiri Pirko         2015-10-16  2663  	if (err) {
c0e01eac7ada785 Ido Schimmel       2017-05-18  2664  		dev_err_ratelimited(mlxsw_sp->bus_info->dev, "Failed to set FDB entry\n");
56ade8fe3fe1e13 Jiri Pirko         2015-10-16  2665  		return;
56ade8fe3fe1e13 Jiri Pirko         2015-10-16  2666  	}
56ade8fe3fe1e13 Jiri Pirko         2015-10-16  2667  
12f1501e7511958 Jiri Pirko         2016-01-07  2668  	if (!do_notification)
12f1501e7511958 Jiri Pirko         2016-01-07  2669  		return;
1b40dc3d86724c7 Arkadi Sharshevsky 2017-06-08  2670  	type = adding ? SWITCHDEV_FDB_ADD_TO_BRIDGE : SWITCHDEV_FDB_DEL_TO_BRIDGE;
e9ba0fbc7dd23a7 Ido Schimmel       2018-10-17  2671  	mlxsw_sp_fdb_call_notifiers(type, mac, vid, bridge_port->dev, adding);
a989cdb473c2fd9 Arkadi Sharshevsky 2017-06-08  2672  
12f1501e7511958 Jiri Pirko         2016-01-07  2673  	return;
12f1501e7511958 Jiri Pirko         2016-01-07  2674  
12f1501e7511958 Jiri Pirko         2016-01-07  2675  just_remove:
12f1501e7511958 Jiri Pirko         2016-01-07  2676  	adding = false;
12f1501e7511958 Jiri Pirko         2016-01-07  2677  	do_notification = false;
12f1501e7511958 Jiri Pirko         2016-01-07  2678  	goto do_fdb_op;
8a1ab5d766396aa Jiri Pirko         2015-12-03  2679  }
56ade8fe3fe1e13 Jiri Pirko         2015-10-16  2680  

:::::: The code at line 2652 was first introduced by commit
:::::: c57529e1d5d882fbd6383163e2cb2e4ba3118174 mlxsw: spectrum: Replace vPorts with Port-VLAN

:::::: TO: Ido Schimmel <idosch@mellanox.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

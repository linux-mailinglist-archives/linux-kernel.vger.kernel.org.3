Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275A54BAA43
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245481AbiBQTr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:47:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245443AbiBQTrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:47:37 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D3D2612C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645127241; x=1676663241;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HmK4bOBUyd+zsjEDnj6z6RS5Kc0NkBK896UgrkSEYrk=;
  b=IMmwB1svoULe9wmd0Gj9j/aI6yyVwOZDy1X3LTxItV2psOvGL9TOS43j
   iKNYq/DEBfoCxhqs4/14J1GHrs5kp1HWPjlu/geC6eGX3wiwUY1tgXu54
   Whm/WRLkhvolhyFbnNRjHq4Fij5JdSSvHLi9bO4axPFZxEVKfogK7ekkD
   /QsSfAWGCJdcGFBQiyFzC3LzfmVfRKnnIumO/s6rsv+RQhq6xKgBphlcg
   JBwpoqQoIbnzzeKvC8kUkgBzuIu/IBoM4TfRTEBznP/auaShk+XfeuPOl
   Hpy6YDqKd/tzpOrJPneEWj4S4YuxPilBzBfaOB83QtxjZlR9/OQicLvpU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="250700981"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="250700981"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 11:47:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="503213932"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 Feb 2022 11:47:01 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKmk1-0000Tu-2B; Thu, 17 Feb 2022 19:47:01 +0000
Date:   Fri, 18 Feb 2022 03:46:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amit Cohen <amcohen@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:ubridge 16/50]
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2642:6: warning:
 variable 'mlxsw_sp_port_vlan' is used uninitialized whenever 'if' condition
 is true
Message-ID: <202202180152.NIrrJRYs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw ubridge
head:   a9a4f2bd50dde60a52d9dda03d38875255fe0b9c
commit: d34198d62f8fb3c90b9cfcc11c808bc3977dd9ea [16/50] mlxsw: Configure egress VID for unicast FDB entries
config: s390-randconfig-r044-20220217 (https://download.01.org/0day-ci/archive/20220218/202202180152.NIrrJRYs-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/jpirko/linux_mlxsw/commit/d34198d62f8fb3c90b9cfcc11c808bc3977dd9ea
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw ubridge
        git checkout d34198d62f8fb3c90b9cfcc11c808bc3977dd9ea
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/net/ethernet/mellanox/mlxsw/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:6:
   In file included from include/linux/netdevice.h:37:
   In file included from include/net/net_namespace.h:40:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:6:
   In file included from include/linux/netdevice.h:37:
   In file included from include/net/net_namespace.h:40:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:6:
   In file included from include/linux/netdevice.h:37:
   In file included from include/net/net_namespace.h:40:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2642:6: warning: variable 'mlxsw_sp_port_vlan' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (mlxsw_sp_fid_is_dummy(mlxsw_sp, fid))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2662:11: note: uninitialized use occurs here
                                         mlxsw_sp_port_vlan->vid, adding, true);
                                         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2642:2: note: remove the 'if' if its condition is always false
           if (mlxsw_sp_fid_is_dummy(mlxsw_sp, fid))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2637:6: warning: variable 'mlxsw_sp_port_vlan' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!mlxsw_sp_port) {
               ^~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2662:11: note: uninitialized use occurs here
                                         mlxsw_sp_port_vlan->vid, adding, true);
                                         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2637:2: note: remove the 'if' if its condition is always false
           if (!mlxsw_sp_port) {
           ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2621:47: note: initialize the variable 'mlxsw_sp_port_vlan' to silence this warning
           struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan;
                                                        ^
                                                         = NULL
   14 warnings generated.


vim +2642 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c

8a1ab5d766396a Jiri Pirko         2015-12-03  2616  
56ade8fe3fe1e1 Jiri Pirko         2015-10-16  2617  static void mlxsw_sp_fdb_notify_mac_process(struct mlxsw_sp *mlxsw_sp,
56ade8fe3fe1e1 Jiri Pirko         2015-10-16  2618  					    char *sfn_pl, int rec_index,
56ade8fe3fe1e1 Jiri Pirko         2015-10-16  2619  					    bool adding)
56ade8fe3fe1e1 Jiri Pirko         2015-10-16  2620  {
c57529e1d5d882 Ido Schimmel       2017-05-26  2621  	struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan;
c57529e1d5d882 Ido Schimmel       2017-05-26  2622  	struct mlxsw_sp_bridge_device *bridge_device;
c57529e1d5d882 Ido Schimmel       2017-05-26  2623  	struct mlxsw_sp_bridge_port *bridge_port;
56ade8fe3fe1e1 Jiri Pirko         2015-10-16  2624  	struct mlxsw_sp_port *mlxsw_sp_port;
1b40dc3d86724c Arkadi Sharshevsky 2017-06-08  2625  	enum switchdev_notifier_type type;
56ade8fe3fe1e1 Jiri Pirko         2015-10-16  2626  	char mac[ETH_ALEN];
c934757d90000a Amit Cohen         2021-12-01  2627  	u16 local_port;
9de6a80e061238 Ido Schimmel       2015-12-15  2628  	u16 vid, fid;
12f1501e751195 Jiri Pirko         2016-01-07  2629  	bool do_notification = true;
56ade8fe3fe1e1 Jiri Pirko         2015-10-16  2630  	int err;
56ade8fe3fe1e1 Jiri Pirko         2015-10-16  2631  
9de6a80e061238 Ido Schimmel       2015-12-15  2632  	mlxsw_reg_sfn_mac_unpack(sfn_pl, rec_index, mac, &fid, &local_port);
837ec05cfea082 Danielle Ratson    2021-05-17  2633  
bcdfd615f83b4b Amit Cohen         2022-01-27  2634  	if (WARN_ON_ONCE(!mlxsw_sp_local_port_is_valid(mlxsw_sp, local_port)))
837ec05cfea082 Danielle Ratson    2021-05-17  2635  		return;
56ade8fe3fe1e1 Jiri Pirko         2015-10-16  2636  	mlxsw_sp_port = mlxsw_sp->ports[local_port];
56ade8fe3fe1e1 Jiri Pirko         2015-10-16  2637  	if (!mlxsw_sp_port) {
56ade8fe3fe1e1 Jiri Pirko         2015-10-16  2638  		dev_err_ratelimited(mlxsw_sp->bus_info->dev, "Incorrect local port in FDB notification\n");
12f1501e751195 Jiri Pirko         2016-01-07  2639  		goto just_remove;
56ade8fe3fe1e1 Jiri Pirko         2015-10-16  2640  	}
56ade8fe3fe1e1 Jiri Pirko         2015-10-16  2641  
577fa14d210073 Ido Schimmel       2019-07-17 @2642  	if (mlxsw_sp_fid_is_dummy(mlxsw_sp, fid))
577fa14d210073 Ido Schimmel       2019-07-17  2643  		goto just_remove;
577fa14d210073 Ido Schimmel       2019-07-17  2644  
c57529e1d5d882 Ido Schimmel       2017-05-26  2645  	mlxsw_sp_port_vlan = mlxsw_sp_port_vlan_find_by_fid(mlxsw_sp_port, fid);
c57529e1d5d882 Ido Schimmel       2017-05-26  2646  	if (!mlxsw_sp_port_vlan) {
c57529e1d5d882 Ido Schimmel       2017-05-26  2647  		netdev_err(mlxsw_sp_port->dev, "Failed to find a matching {Port, VID} following FDB notification\n");
12f1501e751195 Jiri Pirko         2016-01-07  2648  		goto just_remove;
aac78a44088728 Ido Schimmel       2015-12-15  2649  	}
c57529e1d5d882 Ido Schimmel       2017-05-26  2650  
c57529e1d5d882 Ido Schimmel       2017-05-26  2651  	bridge_port = mlxsw_sp_port_vlan->bridge_port;
c57529e1d5d882 Ido Schimmel       2017-05-26  2652  	if (!bridge_port) {
c57529e1d5d882 Ido Schimmel       2017-05-26  2653  		netdev_err(mlxsw_sp_port->dev, "{Port, VID} not associated with a bridge\n");
c57529e1d5d882 Ido Schimmel       2017-05-26  2654  		goto just_remove;
aac78a44088728 Ido Schimmel       2015-12-15  2655  	}
aac78a44088728 Ido Schimmel       2015-12-15  2656  
c57529e1d5d882 Ido Schimmel       2017-05-26  2657  	bridge_device = bridge_port->bridge_device;
c57529e1d5d882 Ido Schimmel       2017-05-26  2658  	vid = bridge_device->vlan_enabled ? mlxsw_sp_port_vlan->vid : 0;
c57529e1d5d882 Ido Schimmel       2017-05-26  2659  
12f1501e751195 Jiri Pirko         2016-01-07  2660  do_fdb_op:
2fa9d45e16089b Jiri Pirko         2016-01-07  2661  	err = mlxsw_sp_port_fdb_uc_op(mlxsw_sp, local_port, mac, fid,
d34198d62f8fb3 Amit Cohen         2022-01-04  2662  				      mlxsw_sp_port_vlan->vid, adding, true);
56ade8fe3fe1e1 Jiri Pirko         2015-10-16  2663  	if (err) {
c0e01eac7ada78 Ido Schimmel       2017-05-18  2664  		dev_err_ratelimited(mlxsw_sp->bus_info->dev, "Failed to set FDB entry\n");
56ade8fe3fe1e1 Jiri Pirko         2015-10-16  2665  		return;
56ade8fe3fe1e1 Jiri Pirko         2015-10-16  2666  	}
56ade8fe3fe1e1 Jiri Pirko         2015-10-16  2667  
12f1501e751195 Jiri Pirko         2016-01-07  2668  	if (!do_notification)
12f1501e751195 Jiri Pirko         2016-01-07  2669  		return;
1b40dc3d86724c Arkadi Sharshevsky 2017-06-08  2670  	type = adding ? SWITCHDEV_FDB_ADD_TO_BRIDGE : SWITCHDEV_FDB_DEL_TO_BRIDGE;
e9ba0fbc7dd23a Ido Schimmel       2018-10-17  2671  	mlxsw_sp_fdb_call_notifiers(type, mac, vid, bridge_port->dev, adding);
a989cdb473c2fd Arkadi Sharshevsky 2017-06-08  2672  
12f1501e751195 Jiri Pirko         2016-01-07  2673  	return;
12f1501e751195 Jiri Pirko         2016-01-07  2674  
12f1501e751195 Jiri Pirko         2016-01-07  2675  just_remove:
12f1501e751195 Jiri Pirko         2016-01-07  2676  	adding = false;
12f1501e751195 Jiri Pirko         2016-01-07  2677  	do_notification = false;
12f1501e751195 Jiri Pirko         2016-01-07  2678  	goto do_fdb_op;
8a1ab5d766396a Jiri Pirko         2015-12-03  2679  }
56ade8fe3fe1e1 Jiri Pirko         2015-10-16  2680  

:::::: The code at line 2642 was first introduced by commit
:::::: 577fa14d210073ba1ce6237c659a8820312104ad mlxsw: spectrum: Do not process learned records with a dummy FID

:::::: TO: Ido Schimmel <idosch@mellanox.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

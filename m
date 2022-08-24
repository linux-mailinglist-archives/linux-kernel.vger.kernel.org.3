Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6FF59F1E7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 05:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbiHXDSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 23:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiHXDSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 23:18:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338BD80B52
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661311102; x=1692847102;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Bay2dV4O/gbaUJeMubn7Z9/QIzUE0Ow1SUI8zWNKaaw=;
  b=boGIH0yN36T7QAH073jgxGXJvqPZNUyM3MH+4bwEKu0PVUtRKyfkvUW8
   QK2q+g9T9+PHjlbJBhOQ2J0Rf0KSKSD6PaGX2+MODU3jMy+yxRUeRj/jX
   U11uTJ49eh/tvht3ENFARNr3jjE/1pnr8Mj6TWOjw4Cmrm/4j4f41d05L
   3Z4VOr8bqkLtfRt+hprzPlnSVQY3okUT3HoObN5seB3Hfb4KHndWbZDcu
   +5OgiPlw4swLt22LoeCOCGIKg7p3HUlOnpLPEc0ScOpjxPVfRa3bEVwRI
   SPU/JHgiS/6JxzF71loLPIQQBNdQHoeIU//+dRxBYns0fCyWPnXuW+qd9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="276879140"
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="276879140"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 20:18:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="677871027"
Received: from lkp-server02.sh.intel.com (HELO 9bbcefcddf9f) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 23 Aug 2022 20:18:16 -0700
Received: from kbuild by 9bbcefcddf9f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQguF-0000ur-30;
        Wed, 24 Aug 2022 03:18:15 +0000
Date:   Wed, 24 Aug 2022 11:17:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_for_vladimir4 36/48]
 drivers/net/ethernet/mellanox/mlxsw/minimal.c:241:45: warning: variable
 'mlxsw_m_port' is uninitialized when used here
Message-ID: <202208241159.MBTFc7zj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_for_vladimir4
head:   0748b27ec2fd62b4d095c005d378957972b267ed
commit: ecb7a921e77345662154db3823c1eee8204102a5 [36/48] net: make drivers to use SET_NETDEV_DEVLINK_PORT to set devlink_port
config: s390-randconfig-r014-20220823 (https://download.01.org/0day-ci/archive/20220824/202208241159.MBTFc7zj-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project d00e97df0fe8c67f694c4d027297f4382ce72b38)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/jpirko/linux_mlxsw/commit/ecb7a921e77345662154db3823c1eee8204102a5
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_for_vladimir4
        git checkout ecb7a921e77345662154db3823c1eee8204102a5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/net/ethernet/mellanox/mlxsw/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/mellanox/mlxsw/minimal.c:4:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/net/ethernet/mellanox/mlxsw/minimal.c:4:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/net/ethernet/mellanox/mlxsw/minimal.c:4:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/net/ethernet/mellanox/mlxsw/minimal.c:241:45: warning: variable 'mlxsw_m_port' is uninitialized when used here [-Wuninitialized]
           mlxsw_core_port_netdev_link(mlxsw_m->core, mlxsw_m_port->local_port,
                                                      ^~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/minimal.c:222:35: note: initialize the variable 'mlxsw_m_port' to silence this warning
           struct mlxsw_m_port *mlxsw_m_port;
                                            ^
                                             = NULL
   13 warnings generated.


vim +/mlxsw_m_port +241 drivers/net/ethernet/mellanox/mlxsw/minimal.c

   218	
   219	static int
   220	mlxsw_m_port_create(struct mlxsw_m *mlxsw_m, u16 local_port, u8 module)
   221	{
   222		struct mlxsw_m_port *mlxsw_m_port;
   223		struct net_device *dev;
   224		int err;
   225	
   226		err = mlxsw_core_port_init(mlxsw_m->core, local_port, 0,
   227					   module + 1, false, 0, false,
   228					   0, mlxsw_m->base_mac,
   229					   sizeof(mlxsw_m->base_mac));
   230		if (err) {
   231			dev_err(mlxsw_m->bus_info->dev, "Port %d: Failed to init core port\n",
   232				local_port);
   233			return err;
   234		}
   235	
   236		dev = alloc_etherdev(sizeof(struct mlxsw_m_port));
   237		if (!dev) {
   238			err = -ENOMEM;
   239			goto err_alloc_etherdev;
   240		}
 > 241		mlxsw_core_port_netdev_link(mlxsw_m->core, mlxsw_m_port->local_port,
   242					    mlxsw_m_port, dev);
   243		SET_NETDEV_DEV(dev, mlxsw_m->bus_info->dev);
   244		dev_net_set(dev, mlxsw_core_net(mlxsw_m->core));
   245		mlxsw_m_port = netdev_priv(dev);
   246		mlxsw_m_port->dev = dev;
   247		mlxsw_m_port->mlxsw_m = mlxsw_m;
   248		mlxsw_m_port->local_port = local_port;
   249		mlxsw_m_port->module = module;
   250	
   251		dev->netdev_ops = &mlxsw_m_port_netdev_ops;
   252		dev->ethtool_ops = &mlxsw_m_port_ethtool_ops;
   253	
   254		err = mlxsw_m_port_dev_addr_get(mlxsw_m_port);
   255		if (err) {
   256			dev_err(mlxsw_m->bus_info->dev, "Port %d: Unable to get port mac address\n",
   257				mlxsw_m_port->local_port);
   258			goto err_dev_addr_get;
   259		}
   260	
   261		netif_carrier_off(dev);
   262		mlxsw_m->ports[local_port] = mlxsw_m_port;
   263		err = register_netdev(dev);
   264		if (err) {
   265			dev_err(mlxsw_m->bus_info->dev, "Port %d: Failed to register netdev\n",
   266				mlxsw_m_port->local_port);
   267			goto err_register_netdev;
   268		}
   269	
   270		return 0;
   271	
   272	err_register_netdev:
   273		mlxsw_m->ports[local_port] = NULL;
   274	err_dev_addr_get:
   275		free_netdev(dev);
   276	err_alloc_etherdev:
   277		mlxsw_core_port_fini(mlxsw_m->core, local_port);
   278		return err;
   279	}
   280	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

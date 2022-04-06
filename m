Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857B94F6A46
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiDFTr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiDFTrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:47:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A28B1CABED
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 10:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649267535; x=1680803535;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ox5ATFu+xqgQXkmgla1zDR6lDbcZQAbNxoWh967Te9Q=;
  b=Jvv7urYW3soXFkFh6xgdhcR1n3tyrSZ6RUc6+ujHM6y9GVPa3ypkPDW7
   XkJFskL1xM2VtSWli3eb4kNJrpziDWeYpw/g6YI5I3xSRY+GuDudlRzu7
   4sfGszKyZSerErUfqYEfzbrrge/Vx2FAPOFTt2QLMohGR49PIoaw9nfMC
   noeb872x0jGV8rHrVFJw0fDYqLsiSAwCZiwqjcNEU0q4Y/Vm/rZDkho8X
   iy14l+QsLgQnQ53WZhU4GnOh4D+2Rn8XJTrWDiLDcdqumIr7CiV9pasWk
   VXTKBsWAbxFLI399m8ZJKpcOFjxH7pf4AmyvF+4qhAahcPqpWk46Rb1Lw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="261110337"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="261110337"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 10:52:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="588470254"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 06 Apr 2022 10:52:13 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nc9pE-0004dR-Rb;
        Wed, 06 Apr 2022 17:52:12 +0000
Date:   Thu, 7 Apr 2022 01:51:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_linecards 94/107]
 drivers/net/netdevsim/dev.c:1393:12: error: conflicting types for
 '__nsim_dev_port_add'; have 'int(struct nsim_dev *, enum nsim_dev_port_type,
  struct nsim_dev_linecard *, unsigned int)'
Message-ID: <202204070134.R3rLQYRH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_linecards
head:   902ba56740ea4a18fafa90b3fa057f70baff52ab
commit: dfd22c2838bb1870d2aaf9b911dbe414a475b5f9 [94/107] netdevsim: allow port objects to be linked with line cards
config: openrisc-buildonly-randconfig-r001-20220405 (https://download.01.org/0day-ci/archive/20220407/202204070134.R3rLQYRH-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/dfd22c2838bb1870d2aaf9b911dbe414a475b5f9
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout dfd22c2838bb1870d2aaf9b911dbe414a475b5f9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/net/netdevsim/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/openrisc/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:248,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/debugfs.h:15,
                    from drivers/net/netdevsim/dev.c:18:
   drivers/net/netdevsim/dev.c: In function 'nsim_esw_switchdev_enable':
   include/linux/stddef.h:8:14: warning: passing argument 3 of '__nsim_dev_port_add' makes integer from pointer without a cast [-Wint-conversion]
       8 | #define NULL ((void *)0)
         |              ^~~~~~~~~~~
         |              |
         |              void *
   drivers/net/netdevsim/dev.c:638:43: note: in expansion of macro 'NULL'
     638 |                                           NULL, i);
         |                                           ^~~~
   drivers/net/netdevsim/dev.c:613:34: note: expected 'unsigned int' but argument is of type 'void *'
     613 |                     unsigned int port_index);
         |                     ~~~~~~~~~~~~~^~~~~~~~~~
   drivers/net/netdevsim/dev.c:637:23: error: too many arguments to function '__nsim_dev_port_add'
     637 |                 err = __nsim_dev_port_add(nsim_dev, NSIM_DEV_PORT_TYPE_VF,
         |                       ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/dev.c:612:1: note: declared here
     612 | __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
         | ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/dev.c:651:25: error: too many arguments to function '__nsim_dev_port_del'
     651 |                         __nsim_dev_port_del(nsim_dev_port, NULL, i);
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/dev.c:614:13: note: declared here
     614 | static void __nsim_dev_port_del(struct nsim_dev_port *nsim_dev_port);
         |             ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/dev.c: At top level:
>> drivers/net/netdevsim/dev.c:1393:12: error: conflicting types for '__nsim_dev_port_add'; have 'int(struct nsim_dev *, enum nsim_dev_port_type,  struct nsim_dev_linecard *, unsigned int)'
    1393 | static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
         |            ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/dev.c:612:1: note: previous declaration of '__nsim_dev_port_add' with type 'int(struct nsim_dev *, enum nsim_dev_port_type,  unsigned int)'
     612 | __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
         | ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/dev.c:612:1: warning: '__nsim_dev_port_add' used but never defined


vim +1393 drivers/net/netdevsim/dev.c

150e8f8a1bae1d Jiri Pirko      2019-08-09  1392  
814b9ce65ec3b5 Dmytro Linkin   2021-06-02 @1393  static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
dfd22c2838bb18 Jiri Pirko      2021-01-12  1394  			       struct nsim_dev_linecard *nsim_dev_linecard,
7f36a77ade6eef Jiri Pirko      2019-10-03  1395  			       unsigned int port_index)
7f36a77ade6eef Jiri Pirko      2019-10-03  1396  {
71ad8d55f8e5ea Danielle Ratson 2020-07-09  1397  	struct devlink_port_attrs attrs = {};
7f36a77ade6eef Jiri Pirko      2019-10-03  1398  	struct nsim_dev_port *nsim_dev_port;
7f36a77ade6eef Jiri Pirko      2019-10-03  1399  	struct devlink_port *devlink_port;
7f36a77ade6eef Jiri Pirko      2019-10-03  1400  	int err;
7f36a77ade6eef Jiri Pirko      2019-10-03  1401  
5e388f3dc38c72 Jakub Kicinski  2021-10-30  1402  	if (type == NSIM_DEV_PORT_TYPE_VF && !nsim_dev_get_vfs(nsim_dev))
92ba1f29e6e2f1 Dmytro Linkin   2021-06-02  1403  		return -EINVAL;
92ba1f29e6e2f1 Dmytro Linkin   2021-06-02  1404  
7f36a77ade6eef Jiri Pirko      2019-10-03  1405  	nsim_dev_port = kzalloc(sizeof(*nsim_dev_port), GFP_KERNEL);
7f36a77ade6eef Jiri Pirko      2019-10-03  1406  	if (!nsim_dev_port)
7f36a77ade6eef Jiri Pirko      2019-10-03  1407  		return -ENOMEM;
dfd22c2838bb18 Jiri Pirko      2021-01-12  1408  	nsim_dev_port->port_index = nsim_dev_port_index(type, nsim_dev_linecard,
dfd22c2838bb18 Jiri Pirko      2021-01-12  1409  							port_index);
814b9ce65ec3b5 Dmytro Linkin   2021-06-02  1410  	nsim_dev_port->port_type = type;
dfd22c2838bb18 Jiri Pirko      2021-01-12  1411  	nsim_dev_port->linecard = nsim_dev_linecard;
7f36a77ade6eef Jiri Pirko      2019-10-03  1412  
7f36a77ade6eef Jiri Pirko      2019-10-03  1413  	devlink_port = &nsim_dev_port->devlink_port;
92ba1f29e6e2f1 Dmytro Linkin   2021-06-02  1414  	if (nsim_dev_port_is_pf(nsim_dev_port)) {
71ad8d55f8e5ea Danielle Ratson 2020-07-09  1415  		attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
71ad8d55f8e5ea Danielle Ratson 2020-07-09  1416  		attrs.phys.port_number = port_index + 1;
92ba1f29e6e2f1 Dmytro Linkin   2021-06-02  1417  	} else {
92ba1f29e6e2f1 Dmytro Linkin   2021-06-02  1418  		attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_VF;
92ba1f29e6e2f1 Dmytro Linkin   2021-06-02  1419  		attrs.pci_vf.pf = 0;
92ba1f29e6e2f1 Dmytro Linkin   2021-06-02  1420  		attrs.pci_vf.vf = port_index;
92ba1f29e6e2f1 Dmytro Linkin   2021-06-02  1421  	}
71ad8d55f8e5ea Danielle Ratson 2020-07-09  1422  	memcpy(attrs.switch_id.id, nsim_dev->switch_id.id, nsim_dev->switch_id.id_len);
71ad8d55f8e5ea Danielle Ratson 2020-07-09  1423  	attrs.switch_id.id_len = nsim_dev->switch_id.id_len;
71ad8d55f8e5ea Danielle Ratson 2020-07-09  1424  	devlink_port_attrs_set(devlink_port, &attrs);
76eea6c2e663f7 Jakub Kicinski  2022-03-18  1425  	err = devl_port_register(priv_to_devlink(nsim_dev), devlink_port,
814b9ce65ec3b5 Dmytro Linkin   2021-06-02  1426  				 nsim_dev_port->port_index);
7f36a77ade6eef Jiri Pirko      2019-10-03  1427  	if (err)
7f36a77ade6eef Jiri Pirko      2019-10-03  1428  		goto err_port_free;
7f36a77ade6eef Jiri Pirko      2019-10-03  1429  
7f36a77ade6eef Jiri Pirko      2019-10-03  1430  	err = nsim_dev_port_debugfs_init(nsim_dev, nsim_dev_port);
7f36a77ade6eef Jiri Pirko      2019-10-03  1431  	if (err)
7f36a77ade6eef Jiri Pirko      2019-10-03  1432  		goto err_dl_port_unregister;
7f36a77ade6eef Jiri Pirko      2019-10-03  1433  
7f36a77ade6eef Jiri Pirko      2019-10-03  1434  	nsim_dev_port->ns = nsim_create(nsim_dev, nsim_dev_port);
7f36a77ade6eef Jiri Pirko      2019-10-03  1435  	if (IS_ERR(nsim_dev_port->ns)) {
7f36a77ade6eef Jiri Pirko      2019-10-03  1436  		err = PTR_ERR(nsim_dev_port->ns);
7f36a77ade6eef Jiri Pirko      2019-10-03  1437  		goto err_port_debugfs_exit;
7f36a77ade6eef Jiri Pirko      2019-10-03  1438  	}
7f36a77ade6eef Jiri Pirko      2019-10-03  1439  
885dfe121b3862 Dmytro Linkin   2021-06-02  1440  	if (nsim_dev_port_is_vf(nsim_dev_port)) {
76eea6c2e663f7 Jakub Kicinski  2022-03-18  1441  		err = devl_rate_leaf_create(&nsim_dev_port->devlink_port,
885dfe121b3862 Dmytro Linkin   2021-06-02  1442  					    nsim_dev_port);
885dfe121b3862 Dmytro Linkin   2021-06-02  1443  		if (err)
885dfe121b3862 Dmytro Linkin   2021-06-02  1444  			goto err_nsim_destroy;
885dfe121b3862 Dmytro Linkin   2021-06-02  1445  	}
885dfe121b3862 Dmytro Linkin   2021-06-02  1446  
dfd22c2838bb18 Jiri Pirko      2021-01-12  1447  	if (nsim_dev_linecard)
dfd22c2838bb18 Jiri Pirko      2021-01-12  1448  		list_add(&nsim_dev_port->list_lc, &nsim_dev_linecard->port_list);
dfd22c2838bb18 Jiri Pirko      2021-01-12  1449  	else
dfd22c2838bb18 Jiri Pirko      2021-01-12  1450  		netif_carrier_on(nsim_dev_port->ns->netdev);
dfd22c2838bb18 Jiri Pirko      2021-01-12  1451  
7f36a77ade6eef Jiri Pirko      2019-10-03  1452  	devlink_port_type_eth_set(devlink_port, nsim_dev_port->ns->netdev);
7f36a77ade6eef Jiri Pirko      2019-10-03  1453  	list_add(&nsim_dev_port->list, &nsim_dev->port_list);
7f36a77ade6eef Jiri Pirko      2019-10-03  1454  
7f36a77ade6eef Jiri Pirko      2019-10-03  1455  	return 0;
7f36a77ade6eef Jiri Pirko      2019-10-03  1456  
885dfe121b3862 Dmytro Linkin   2021-06-02  1457  err_nsim_destroy:
885dfe121b3862 Dmytro Linkin   2021-06-02  1458  	nsim_destroy(nsim_dev_port->ns);
7f36a77ade6eef Jiri Pirko      2019-10-03  1459  err_port_debugfs_exit:
7f36a77ade6eef Jiri Pirko      2019-10-03  1460  	nsim_dev_port_debugfs_exit(nsim_dev_port);
7f36a77ade6eef Jiri Pirko      2019-10-03  1461  err_dl_port_unregister:
76eea6c2e663f7 Jakub Kicinski  2022-03-18  1462  	devl_port_unregister(devlink_port);
7f36a77ade6eef Jiri Pirko      2019-10-03  1463  err_port_free:
7f36a77ade6eef Jiri Pirko      2019-10-03  1464  	kfree(nsim_dev_port);
7f36a77ade6eef Jiri Pirko      2019-10-03  1465  	return err;
7f36a77ade6eef Jiri Pirko      2019-10-03  1466  }
7f36a77ade6eef Jiri Pirko      2019-10-03  1467  

:::::: The code at line 1393 was first introduced by commit
:::::: 814b9ce65ec3b53404eeda7a11e1abb4af8d7df3 netdevsim: Implement port types and indexing

:::::: TO: Dmytro Linkin <dlinkin@nvidia.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

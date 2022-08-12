Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206995916CF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 23:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbiHLVoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 17:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiHLVoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 17:44:00 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7A6B089D
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 14:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660340639; x=1691876639;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gOwHqK7dOEIxGodN2bs0Cnwfo/GKFpxWcq3NpIU+O0E=;
  b=kB6+hzFJFBjLwM+gmN631UM6H02vRH2EukZRjnJapaHvn/zPOOB+yn3n
   l46SP7A3DU5/ZWQiAnq1F0hpBpfQVIuz9eKMkuEYR3x4hzPVHgUj+8Jui
   v+4sbkt3RRr9PR7QUPkua7vKaj9KRwi+IwzViEegTE5FXrOl9HvBK5eN6
   ed+XHsmeF+nqJf/GO7EeZUYsWi+ME8g7YYQ/Ri2z84puksgBqlXoF8mxu
   mnqAtgFZ05p3iQWyYizFT2BnZD5iaq16LnQIq/ifendJeVVEWGn1pG/92
   YNSzfpJ4sut04z+12aqh9bAkiqaIxbw2rkoCb4oaIBpnDjk2GoFsqojAJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292489910"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="292489910"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 14:43:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="665984165"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 12 Aug 2022 14:43:57 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMcRh-0000yw-0n;
        Fri, 12 Aug 2022 21:43:57 +0000
Date:   Sat, 13 Aug 2022 05:43:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_devlink_locking 33/40]
 net/dsa/slave.c:2367:64: error: expected ')' before ';' token
Message-ID: <202208130513.fAikri22-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_devlink_locking
head:   3752df45a64c94afd110eeb956cd9adaeec586c1
commit: 95a8f1859e438effd49d5c1ae7828e87b8471180 [33/40] net: make drivers to use SET_NETDEV_DEVLINK_PORT to set devlink_port
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220813/202208130513.fAikri22-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/jpirko/linux_mlxsw/commit/95a8f1859e438effd49d5c1ae7828e87b8471180
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_devlink_locking
        git checkout 95a8f1859e438effd49d5c1ae7828e87b8471180
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/dsa/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/etherdevice.h:21,
                    from net/dsa/slave.c:8:
   net/dsa/slave.c: In function 'dsa_slave_create':
>> include/linux/netdevice.h:2348:1: error: expected ';' before ')' token
    2348 | )}
         | ^
   net/dsa/slave.c:2367:9: note: in expansion of macro 'SET_NETDEV_DEVLINK_PORT'
    2367 |         SET_NETDEV_DEVLINK_PORT(slave_dev, &port->devlink_port);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/netdevice.h:2348:1: error: expected statement before ')' token
    2348 | )}
         | ^
   net/dsa/slave.c:2367:9: note: in expansion of macro 'SET_NETDEV_DEVLINK_PORT'
    2367 |         SET_NETDEV_DEVLINK_PORT(slave_dev, &port->devlink_port);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
>> net/dsa/slave.c:2367:64: error: expected ')' before ';' token
    2367 |         SET_NETDEV_DEVLINK_PORT(slave_dev, &port->devlink_port);
         |                                                                ^
>> net/dsa/slave.c:2445:20: error: expected ';' before '}' token
    2445 |         return ret;
         |                    ^
         |                    ;
    2446 | }
         | ~                   
>> net/dsa/slave.c:2339:13: warning: unused variable 'ret' [-Wunused-variable]
    2339 |         int ret;
         |             ^~~
>> net/dsa/slave.c:2338:32: warning: unused variable 'p' [-Wunused-variable]
    2338 |         struct dsa_slave_priv *p;
         |                                ^
   net/dsa/slave.c:2446:1: error: control reaches end of non-void function [-Werror=return-type]
    2446 | }
         | ^
   At top level:
   net/dsa/slave.c:2228:12: warning: 'dsa_slave_phy_setup' defined but not used [-Wunused-function]
    2228 | static int dsa_slave_phy_setup(struct net_device *slave_dev)
         |            ^~~~~~~~~~~~~~~~~~~
   net/dsa/slave.c:2041:12: warning: 'dsa_slave_dcbnl_init' defined but not used [-Wunused-function]
    2041 | static int dsa_slave_dcbnl_init(struct net_device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +2367 net/dsa/slave.c

  2330	
  2331	int dsa_slave_create(struct dsa_port *port)
  2332	{
  2333		const struct dsa_port *cpu_dp = port->cpu_dp;
  2334		struct net_device *master = cpu_dp->master;
  2335		struct dsa_switch *ds = port->ds;
  2336		const char *name = port->name;
  2337		struct net_device *slave_dev;
> 2338		struct dsa_slave_priv *p;
> 2339		int ret;
  2340	
  2341		if (!ds->num_tx_queues)
  2342			ds->num_tx_queues = 1;
  2343	
  2344		slave_dev = alloc_netdev_mqs(sizeof(struct dsa_slave_priv), name,
  2345					     NET_NAME_UNKNOWN, ether_setup,
  2346					     ds->num_tx_queues, 1);
  2347		if (slave_dev == NULL)
  2348			return -ENOMEM;
  2349	
  2350		slave_dev->ethtool_ops = &dsa_slave_ethtool_ops;
  2351	#if IS_ENABLED(CONFIG_DCB)
  2352		slave_dev->dcbnl_ops = &dsa_slave_dcbnl_ops;
  2353	#endif
  2354		if (!is_zero_ether_addr(port->mac))
  2355			eth_hw_addr_set(slave_dev, port->mac);
  2356		else
  2357			eth_hw_addr_inherit(slave_dev, master);
  2358		slave_dev->priv_flags |= IFF_NO_QUEUE;
  2359		if (dsa_switch_supports_uc_filtering(ds))
  2360			slave_dev->priv_flags |= IFF_UNICAST_FLT;
  2361		slave_dev->netdev_ops = &dsa_slave_netdev_ops;
  2362		if (ds->ops->port_max_mtu)
  2363			slave_dev->max_mtu = ds->ops->port_max_mtu(ds, port->index);
  2364		SET_NETDEV_DEVTYPE(slave_dev, &dsa_type);
  2365	
  2366		SET_NETDEV_DEV(slave_dev, port->ds->dev);
> 2367		SET_NETDEV_DEVLINK_PORT(slave_dev, &port->devlink_port);
  2368		slave_dev->dev.of_node = port->dn;
  2369		slave_dev->vlan_features = master->vlan_features;
  2370	
  2371		p = netdev_priv(slave_dev);
  2372		slave_dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
  2373		if (!slave_dev->tstats) {
  2374			free_netdev(slave_dev);
  2375			return -ENOMEM;
  2376		}
  2377	
  2378		ret = gro_cells_init(&p->gcells, slave_dev);
  2379		if (ret)
  2380			goto out_free;
  2381	
  2382		p->dp = port;
  2383		INIT_LIST_HEAD(&p->mall_tc_list);
  2384		port->slave = slave_dev;
  2385		dsa_slave_setup_tagger(slave_dev);
  2386	
  2387		netif_carrier_off(slave_dev);
  2388	
  2389		ret = dsa_slave_phy_setup(slave_dev);
  2390		if (ret) {
  2391			netdev_err(slave_dev,
  2392				   "error %d setting up PHY for tree %d, switch %d, port %d\n",
  2393				   ret, ds->dst->index, ds->index, port->index);
  2394			goto out_gcells;
  2395		}
  2396	
  2397		rtnl_lock();
  2398	
  2399		ret = dsa_slave_change_mtu(slave_dev, ETH_DATA_LEN);
  2400		if (ret && ret != -EOPNOTSUPP)
  2401			dev_warn(ds->dev, "nonfatal error %d setting MTU to %d on port %d\n",
  2402				 ret, ETH_DATA_LEN, port->index);
  2403	
  2404		ret = register_netdevice(slave_dev);
  2405		if (ret) {
  2406			netdev_err(master, "error %d registering interface %s\n",
  2407				   ret, slave_dev->name);
  2408			rtnl_unlock();
  2409			goto out_phy;
  2410		}
  2411	
  2412		if (IS_ENABLED(CONFIG_DCB)) {
  2413			ret = dsa_slave_dcbnl_init(slave_dev);
  2414			if (ret) {
  2415				netdev_err(slave_dev,
  2416					   "failed to initialize DCB: %pe\n",
  2417					   ERR_PTR(ret));
  2418				rtnl_unlock();
  2419				goto out_unregister;
  2420			}
  2421		}
  2422	
  2423		ret = netdev_upper_dev_link(master, slave_dev, NULL);
  2424	
  2425		rtnl_unlock();
  2426	
  2427		if (ret)
  2428			goto out_unregister;
  2429	
  2430		return 0;
  2431	
  2432	out_unregister:
  2433		unregister_netdev(slave_dev);
  2434	out_phy:
  2435		rtnl_lock();
  2436		phylink_disconnect_phy(p->dp->pl);
  2437		rtnl_unlock();
  2438		phylink_destroy(p->dp->pl);
  2439	out_gcells:
  2440		gro_cells_destroy(&p->gcells);
  2441	out_free:
  2442		free_percpu(slave_dev->tstats);
  2443		free_netdev(slave_dev);
  2444		port->slave = NULL;
> 2445		return ret;
  2446	}
  2447	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

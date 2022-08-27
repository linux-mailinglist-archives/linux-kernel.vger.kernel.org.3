Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE875A35A8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 09:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbiH0HnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 03:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiH0HnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 03:43:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01CFC12E8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 00:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661586178; x=1693122178;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TPeE7O5eSMiUUD8HCLa+uWxVy+EUXvNIFR+Z5jgl9Oc=;
  b=aZ4L6G4xWwVrBB35hD2E+kmNO57Hn9jTJkMx2BN4MF9Odc77MYGBGYkr
   4DwJp85nqAvfq/10VZDZA9VTbfl3FhwLbjT01uEpdTzHJA80vcB2s95bk
   UKHnFfPMtuvmW6HhPx4nR60XeOEe1sOyWX7DHaQdPf4OM1gd3VIAMtvEJ
   p1vS3y6Or0HW+btEFB3EK/4T8caqa4KWSLsE1TZtaT/fwF5lMYshq71Ad
   5tfAj4N5ik6UaL9CkMxXIZA0adn1vNLEhEkQWnMR+5h8aYEtjhdzFnT8s
   eqJicsX2C+urgfwTvRlB6oCXBKQKud+CAIApE2sIKDEk5xpNXFyrDNh5I
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="281612365"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="281612365"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 00:42:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="640332537"
Received: from lkp-server01.sh.intel.com (HELO 71b0d3b5b1bc) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 Aug 2022 00:42:42 -0700
Received: from kbuild by 71b0d3b5b1bc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRqSn-00016R-1S;
        Sat, 27 Aug 2022 07:42:41 +0000
Date:   Sat, 27 Aug 2022 15:42:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_for_vladimir6 33/46]
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c:1651:46: warning: variable
 'mlxsw_sp_port' is uninitialized when used here
Message-ID: <202208271536.DZv8cLOR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_for_vladimir6
head:   f39d6f294ee45799dcd1d8208cc4017f483862fc
commit: 95b77ce1b5edc51f0075f3c0307b72d6ff27ec91 [33/46] net: make drivers to use SET_NETDEV_DEVLINK_PORT to set devlink_port
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220827/202208271536.DZv8cLOR-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/95b77ce1b5edc51f0075f3c0307b72d6ff27ec91
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_for_vladimir6
        git checkout 95b77ce1b5edc51f0075f3c0307b72d6ff27ec91
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/ethernet/mellanox/mlxsw/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/mellanox/mlxsw/spectrum.c:1651:46: warning: variable 'mlxsw_sp_port' is uninitialized when used here [-Wuninitialized]
           mlxsw_core_port_netdev_link(mlxsw_sp->core, mlxsw_sp_port->local_port,
                                                       ^~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/spectrum.c:1604:37: note: initialize the variable 'mlxsw_sp_port' to silence this warning
           struct mlxsw_sp_port *mlxsw_sp_port;
                                              ^
                                               = NULL
   1 warning generated.


vim +/mlxsw_sp_port +1651 drivers/net/ethernet/mellanox/mlxsw/spectrum.c

  1598	
  1599	static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u16 local_port,
  1600					bool split,
  1601					struct mlxsw_sp_port_mapping *port_mapping)
  1602	{
  1603		struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan;
  1604		struct mlxsw_sp_port *mlxsw_sp_port;
  1605		u32 lanes = port_mapping->width;
  1606		u8 split_port_subnumber;
  1607		struct net_device *dev;
  1608		u8 port_number;
  1609		u8 slot_index;
  1610		bool splittable;
  1611		int err;
  1612	
  1613		err = mlxsw_sp_port_module_map(mlxsw_sp, local_port, port_mapping);
  1614		if (err) {
  1615			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to map module\n",
  1616				local_port);
  1617			return err;
  1618		}
  1619	
  1620		err = mlxsw_sp_port_swid_set(mlxsw_sp, local_port, 0);
  1621		if (err) {
  1622			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to set SWID\n",
  1623				local_port);
  1624			goto err_port_swid_set;
  1625		}
  1626	
  1627		err = mlxsw_sp_port_label_info_get(mlxsw_sp, local_port, &port_number,
  1628						   &split_port_subnumber, &slot_index);
  1629		if (err) {
  1630			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to get port label information\n",
  1631				local_port);
  1632			goto err_port_label_info_get;
  1633		}
  1634	
  1635		splittable = lanes > 1 && !split;
  1636		err = mlxsw_core_port_init(mlxsw_sp->core, local_port, slot_index,
  1637					   port_number, split, split_port_subnumber,
  1638					   splittable, lanes, mlxsw_sp->base_mac,
  1639					   sizeof(mlxsw_sp->base_mac));
  1640		if (err) {
  1641			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to init core port\n",
  1642				local_port);
  1643			goto err_core_port_init;
  1644		}
  1645	
  1646		dev = alloc_etherdev(sizeof(struct mlxsw_sp_port));
  1647		if (!dev) {
  1648			err = -ENOMEM;
  1649			goto err_alloc_etherdev;
  1650		}
> 1651		mlxsw_core_port_netdev_link(mlxsw_sp->core, mlxsw_sp_port->local_port,
  1652					    mlxsw_sp_port, dev);
  1653		SET_NETDEV_DEV(dev, mlxsw_sp->bus_info->dev);
  1654		dev_net_set(dev, mlxsw_sp_net(mlxsw_sp));
  1655		mlxsw_sp_port = netdev_priv(dev);
  1656		mlxsw_sp_port->dev = dev;
  1657		mlxsw_sp_port->mlxsw_sp = mlxsw_sp;
  1658		mlxsw_sp_port->local_port = local_port;
  1659		mlxsw_sp_port->pvid = MLXSW_SP_DEFAULT_VID;
  1660		mlxsw_sp_port->split = split;
  1661		mlxsw_sp_port->mapping = *port_mapping;
  1662		mlxsw_sp_port->link.autoneg = 1;
  1663		INIT_LIST_HEAD(&mlxsw_sp_port->vlans_list);
  1664	
  1665		mlxsw_sp_port->pcpu_stats =
  1666			netdev_alloc_pcpu_stats(struct mlxsw_sp_port_pcpu_stats);
  1667		if (!mlxsw_sp_port->pcpu_stats) {
  1668			err = -ENOMEM;
  1669			goto err_alloc_stats;
  1670		}
  1671	
  1672		INIT_DELAYED_WORK(&mlxsw_sp_port->periodic_hw_stats.update_dw,
  1673				  &update_stats_cache);
  1674	
  1675		dev->netdev_ops = &mlxsw_sp_port_netdev_ops;
  1676		dev->ethtool_ops = &mlxsw_sp_port_ethtool_ops;
  1677	
  1678		err = mlxsw_sp_port_dev_addr_init(mlxsw_sp_port);
  1679		if (err) {
  1680			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Unable to init port mac address\n",
  1681				mlxsw_sp_port->local_port);
  1682			goto err_dev_addr_init;
  1683		}
  1684	
  1685		netif_carrier_off(dev);
  1686	
  1687		dev->features |= NETIF_F_NETNS_LOCAL | NETIF_F_LLTX | NETIF_F_SG |
  1688				 NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_TC;
  1689		dev->hw_features |= NETIF_F_HW_TC | NETIF_F_LOOPBACK;
  1690	
  1691		dev->min_mtu = 0;
  1692		dev->max_mtu = ETH_MAX_MTU;
  1693	
  1694		/* Each packet needs to have a Tx header (metadata) on top all other
  1695		 * headers.
  1696		 */
  1697		dev->needed_headroom = MLXSW_TXHDR_LEN;
  1698	
  1699		err = mlxsw_sp_port_system_port_mapping_set(mlxsw_sp_port);
  1700		if (err) {
  1701			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to set system port mapping\n",
  1702				mlxsw_sp_port->local_port);
  1703			goto err_port_system_port_mapping_set;
  1704		}
  1705	
  1706		err = mlxsw_sp_port_speed_by_width_set(mlxsw_sp_port);
  1707		if (err) {
  1708			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to enable speeds\n",
  1709				mlxsw_sp_port->local_port);
  1710			goto err_port_speed_by_width_set;
  1711		}
  1712	
  1713		err = mlxsw_sp->port_type_speed_ops->ptys_max_speed(mlxsw_sp_port,
  1714								    &mlxsw_sp_port->max_speed);
  1715		if (err) {
  1716			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to get maximum speed\n",
  1717				mlxsw_sp_port->local_port);
  1718			goto err_max_speed_get;
  1719		}
  1720	
  1721		err = mlxsw_sp_port_max_mtu_get(mlxsw_sp_port, &mlxsw_sp_port->max_mtu);
  1722		if (err) {
  1723			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to get maximum MTU\n",
  1724				mlxsw_sp_port->local_port);
  1725			goto err_port_max_mtu_get;
  1726		}
  1727	
  1728		err = mlxsw_sp_port_mtu_set(mlxsw_sp_port, ETH_DATA_LEN);
  1729		if (err) {
  1730			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to set MTU\n",
  1731				mlxsw_sp_port->local_port);
  1732			goto err_port_mtu_set;
  1733		}
  1734	
  1735		err = mlxsw_sp_port_admin_status_set(mlxsw_sp_port, false);
  1736		if (err)
  1737			goto err_port_admin_status_set;
  1738	
  1739		err = mlxsw_sp_port_buffers_init(mlxsw_sp_port);
  1740		if (err) {
  1741			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to initialize buffers\n",
  1742				mlxsw_sp_port->local_port);
  1743			goto err_port_buffers_init;
  1744		}
  1745	
  1746		err = mlxsw_sp_port_ets_init(mlxsw_sp_port);
  1747		if (err) {
  1748			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to initialize ETS\n",
  1749				mlxsw_sp_port->local_port);
  1750			goto err_port_ets_init;
  1751		}
  1752	
  1753		err = mlxsw_sp_port_tc_mc_mode_set(mlxsw_sp_port, true);
  1754		if (err) {
  1755			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to initialize TC MC mode\n",
  1756				mlxsw_sp_port->local_port);
  1757			goto err_port_tc_mc_mode;
  1758		}
  1759	
  1760		/* ETS and buffers must be initialized before DCB. */
  1761		err = mlxsw_sp_port_dcb_init(mlxsw_sp_port);
  1762		if (err) {
  1763			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to initialize DCB\n",
  1764				mlxsw_sp_port->local_port);
  1765			goto err_port_dcb_init;
  1766		}
  1767	
  1768		err = mlxsw_sp_port_fids_init(mlxsw_sp_port);
  1769		if (err) {
  1770			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to initialize FIDs\n",
  1771				mlxsw_sp_port->local_port);
  1772			goto err_port_fids_init;
  1773		}
  1774	
  1775		err = mlxsw_sp_tc_qdisc_init(mlxsw_sp_port);
  1776		if (err) {
  1777			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to initialize TC qdiscs\n",
  1778				mlxsw_sp_port->local_port);
  1779			goto err_port_qdiscs_init;
  1780		}
  1781	
  1782		err = mlxsw_sp_port_vlan_set(mlxsw_sp_port, 0, VLAN_N_VID - 1, false,
  1783					     false);
  1784		if (err) {
  1785			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to clear VLAN filter\n",
  1786				mlxsw_sp_port->local_port);
  1787			goto err_port_vlan_clear;
  1788		}
  1789	
  1790		err = mlxsw_sp_port_nve_init(mlxsw_sp_port);
  1791		if (err) {
  1792			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to initialize NVE\n",
  1793				mlxsw_sp_port->local_port);
  1794			goto err_port_nve_init;
  1795		}
  1796	
  1797		err = mlxsw_sp_port_pvid_set(mlxsw_sp_port, MLXSW_SP_DEFAULT_VID,
  1798					     ETH_P_8021Q);
  1799		if (err) {
  1800			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to set PVID\n",
  1801				mlxsw_sp_port->local_port);
  1802			goto err_port_pvid_set;
  1803		}
  1804	
  1805		mlxsw_sp_port_vlan = mlxsw_sp_port_vlan_create(mlxsw_sp_port,
  1806							       MLXSW_SP_DEFAULT_VID);
  1807		if (IS_ERR(mlxsw_sp_port_vlan)) {
  1808			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to create VID 1\n",
  1809				mlxsw_sp_port->local_port);
  1810			err = PTR_ERR(mlxsw_sp_port_vlan);
  1811			goto err_port_vlan_create;
  1812		}
  1813		mlxsw_sp_port->default_vlan = mlxsw_sp_port_vlan;
  1814	
  1815		/* Set SPVC.et0=true and SPVC.et1=false to make the local port to treat
  1816		 * only packets with 802.1q header as tagged packets.
  1817		 */
  1818		err = mlxsw_sp_port_vlan_classification_set(mlxsw_sp_port, false, true);
  1819		if (err) {
  1820			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to set default VLAN classification\n",
  1821				local_port);
  1822			goto err_port_vlan_classification_set;
  1823		}
  1824	
  1825		INIT_DELAYED_WORK(&mlxsw_sp_port->ptp.shaper_dw,
  1826				  mlxsw_sp->ptp_ops->shaper_work);
  1827	
  1828		mlxsw_sp->ports[local_port] = mlxsw_sp_port;
  1829	
  1830		err = mlxsw_sp_port_overheat_init_val_set(mlxsw_sp_port);
  1831		if (err) {
  1832			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to set overheat initial value\n",
  1833				mlxsw_sp_port->local_port);
  1834			goto err_port_overheat_init_val_set;
  1835		}
  1836	
  1837		err = register_netdev(dev);
  1838		if (err) {
  1839			dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to register netdev\n",
  1840				mlxsw_sp_port->local_port);
  1841			goto err_register_netdev;
  1842		}
  1843	
  1844		mlxsw_core_schedule_dw(&mlxsw_sp_port->periodic_hw_stats.update_dw, 0);
  1845		return 0;
  1846	
  1847	err_register_netdev:
  1848	err_port_overheat_init_val_set:
  1849		mlxsw_sp_port_vlan_classification_set(mlxsw_sp_port, true, true);
  1850	err_port_vlan_classification_set:
  1851		mlxsw_sp->ports[local_port] = NULL;
  1852		mlxsw_sp_port_vlan_destroy(mlxsw_sp_port_vlan);
  1853	err_port_vlan_create:
  1854	err_port_pvid_set:
  1855		mlxsw_sp_port_nve_fini(mlxsw_sp_port);
  1856	err_port_nve_init:
  1857	err_port_vlan_clear:
  1858		mlxsw_sp_tc_qdisc_fini(mlxsw_sp_port);
  1859	err_port_qdiscs_init:
  1860		mlxsw_sp_port_fids_fini(mlxsw_sp_port);
  1861	err_port_fids_init:
  1862		mlxsw_sp_port_dcb_fini(mlxsw_sp_port);
  1863	err_port_dcb_init:
  1864		mlxsw_sp_port_tc_mc_mode_set(mlxsw_sp_port, false);
  1865	err_port_tc_mc_mode:
  1866	err_port_ets_init:
  1867		mlxsw_sp_port_buffers_fini(mlxsw_sp_port);
  1868	err_port_buffers_init:
  1869	err_port_admin_status_set:
  1870	err_port_mtu_set:
  1871	err_port_max_mtu_get:
  1872	err_max_speed_get:
  1873	err_port_speed_by_width_set:
  1874	err_port_system_port_mapping_set:
  1875	err_dev_addr_init:
  1876		free_percpu(mlxsw_sp_port->pcpu_stats);
  1877	err_alloc_stats:
  1878		free_netdev(dev);
  1879	err_alloc_etherdev:
  1880		mlxsw_core_port_fini(mlxsw_sp->core, local_port);
  1881	err_core_port_init:
  1882	err_port_label_info_get:
  1883		mlxsw_sp_port_swid_set(mlxsw_sp, local_port,
  1884				       MLXSW_PORT_SWID_DISABLED_PORT);
  1885	err_port_swid_set:
  1886		mlxsw_sp_port_module_unmap(mlxsw_sp, local_port,
  1887					   port_mapping->slot_index,
  1888					   port_mapping->module);
  1889		return err;
  1890	}
  1891	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

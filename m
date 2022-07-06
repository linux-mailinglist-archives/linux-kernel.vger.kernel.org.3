Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6803567C4F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiGFDHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiGFDHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:07:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B4E1AF26
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 20:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657076832; x=1688612832;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jQ7kDgsElqNwBCF/Kpak11C9GOIpSHvFIUVDttNQkEc=;
  b=G1ZB9Y1B8eJyE6dlAmcoZjWCNmZpxhQyHKkqRlchjlDZCuhZvz7LTq4N
   jvbmmNsncUrmLyaicTq0ggy9+TONtgR14J0Y+zg6ym6U1ypCPg47KHbX1
   s2+HOVocNokiZ1ob3CjyxYmJtVAOKsP4GHV41QsT0svbyNbxoW1kUgDuO
   YspwJ+qxmK1yZRa89iuwtAPBRYHkkSI91Vcs5H/Q4KhiJ+mki9KrXQiZw
   aOv8oVsf6aEuXj+9q0MEUxgYtiVMSwp8apT/98r76eHoayoiI8klu4hoE
   QTec1am7uY/QlQKtJsXxJ9guPOMbpFUGk2GZEeRmPANhIz5eNOf6DbSy/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="284362194"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="284362194"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 20:07:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="719958187"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 05 Jul 2022 20:07:10 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8vNe-000Jtr-30;
        Wed, 06 Jul 2022 03:07:10 +0000
Date:   Wed, 6 Jul 2022 11:06:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [lunn:v5.19-rc4-net-next-c45-v2 22/43]
 drivers/net/phy/mdio_bus.c:710:11: warning: variable 'i' is uninitialized
 when used here
Message-ID: <202207061123.MWQcDNB1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/lunn/linux.git v5.19-rc4-net-next-c45-v2
head:   97c9a4f734f12cd4de3191d3c641084fcca64de0
commit: c5204ce82da312e1e7f4ffbc3323ca8666c38e7d [22/43] net: mdiobus: Rework scanning of bus ready for quirks
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20220706/202207061123.MWQcDNB1-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f553287b588916de09c66e3e32bf75e5060f967f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/lunn/linux/commit/c5204ce82da312e1e7f4ffbc3323ca8666c38e7d
        git remote add lunn https://github.com/lunn/linux.git
        git fetch --no-tags lunn v5.19-rc4-net-next-c45-v2
        git checkout c5204ce82da312e1e7f4ffbc3323ca8666c38e7d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/phy/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/phy/mdio_bus.c:710:11: warning: variable 'i' is uninitialized when used here [-Wuninitialized]
           while (--i >= 0) {
                    ^
   drivers/net/phy/mdio_bus.c:621:7: note: initialize the variable 'i' to silence this warning
           int i, err;
                ^
                 = 0
   1 warning generated.


vim +/i +710 drivers/net/phy/mdio_bus.c

a2e2dd8f5c859b Andrew Lunn            2022-04-20  603  
b3df0da886ffdb Randy Dunlap           2007-03-06  604  /**
59f069789c9867 Russell King           2015-09-25  605   * __mdiobus_register - bring up all the PHYs on a given bus and attach them to bus
b3df0da886ffdb Randy Dunlap           2007-03-06  606   * @bus: target mii_bus
59f069789c9867 Russell King           2015-09-25  607   * @owner: module containing bus accessor functions
e13934563db047 Andy Fleming           2005-08-24  608   *
b3df0da886ffdb Randy Dunlap           2007-03-06  609   * Description: Called by a bus driver to bring up all the PHYs
59f069789c9867 Russell King           2015-09-25  610   *   on a given bus, and attach them to the bus. Drivers should use
59f069789c9867 Russell King           2015-09-25  611   *   mdiobus_register() rather than __mdiobus_register() unless they
f89df3f381f1e1 Andrew Lunn            2016-01-06  612   *   need to pass a specific owner module. MDIO devices which are not
fec76125baf739 Peng Li                2021-03-30  613   *   PHYs will not be brought up by this function. They are expected
f89df3f381f1e1 Andrew Lunn            2016-01-06  614   *   to be explicitly listed in DT and instantiated by of_mdiobus_register().
b3df0da886ffdb Randy Dunlap           2007-03-06  615   *
b3df0da886ffdb Randy Dunlap           2007-03-06  616   * Returns 0 on success or < 0 on error.
e13934563db047 Andy Fleming           2005-08-24  617   */
3e3aaf64941698 Russell King           2015-09-24  618  int __mdiobus_register(struct mii_bus *bus, struct module *owner)
e13934563db047 Andy Fleming           2005-08-24  619  {
711fdba37a3dd7 Andrew Lunn            2016-01-06  620  	struct mdio_device *mdiodev;
161c8d2f50109b Krzysztof Halasa       2008-12-25  621  	int i, err;
69226896ad636b Roger Quadros          2017-04-21  622  	struct gpio_desc *gpiod;
e13934563db047 Andy Fleming           2005-08-24  623  
72fccba1b70329 Andrew Lunn            2022-04-02  624  	if (!bus || !bus->name)
72fccba1b70329 Andrew Lunn            2022-04-02  625  		return -EINVAL;
72fccba1b70329 Andrew Lunn            2022-04-02  626  
72fccba1b70329 Andrew Lunn            2022-04-02  627  	if (!bus->read != !bus->write)
72fccba1b70329 Andrew Lunn            2022-04-02  628  		return -EINVAL;
72fccba1b70329 Andrew Lunn            2022-04-02  629  
72fccba1b70329 Andrew Lunn            2022-04-02  630  	if (!bus->read_c45 != !bus->write_c45)
72fccba1b70329 Andrew Lunn            2022-04-02  631  		return -EINVAL;
72fccba1b70329 Andrew Lunn            2022-04-02  632  
72fccba1b70329 Andrew Lunn            2022-04-02  633  	if (!bus->read && !bus->read_c45)
e13934563db047 Andy Fleming           2005-08-24  634  		return -EINVAL;
e13934563db047 Andy Fleming           2005-08-24  635  
04f41c68f18886 Saravana Kannan        2021-09-15  636  	if (bus->parent && bus->parent->of_node)
04f41c68f18886 Saravana Kannan        2021-09-15  637  		bus->parent->of_node->fwnode.flags |=
04f41c68f18886 Saravana Kannan        2021-09-15  638  					FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD;
04f41c68f18886 Saravana Kannan        2021-09-15  639  
867ae8a7993b26 Florian Fainelli       2021-11-17  640  	WARN(bus->state != MDIOBUS_ALLOCATED &&
867ae8a7993b26 Florian Fainelli       2021-11-17  641  	     bus->state != MDIOBUS_UNREGISTERED,
867ae8a7993b26 Florian Fainelli       2021-11-17  642  	     "%s: not in ALLOCATED or UNREGISTERED state\n", bus->id);
46abc02175b3c2 Lennert Buytenhek      2008-10-08  643  
3e3aaf64941698 Russell King           2015-09-24  644  	bus->owner = owner;
46abc02175b3c2 Lennert Buytenhek      2008-10-08  645  	bus->dev.parent = bus->parent;
46abc02175b3c2 Lennert Buytenhek      2008-10-08  646  	bus->dev.class = &mdio_bus_class;
46abc02175b3c2 Lennert Buytenhek      2008-10-08  647  	bus->dev.groups = NULL;
036b66879addb2 Stephen Hemminger      2009-02-26  648  	dev_set_name(&bus->dev, "%s", bus->id);
46abc02175b3c2 Lennert Buytenhek      2008-10-08  649  
ca6e11c337daf7 Pavel Skripkin         2021-09-30  650  	/* We need to set state to MDIOBUS_UNREGISTERED to correctly release
ca6e11c337daf7 Pavel Skripkin         2021-09-30  651  	 * the device in mdiobus_free()
ca6e11c337daf7 Pavel Skripkin         2021-09-30  652  	 *
ca6e11c337daf7 Pavel Skripkin         2021-09-30  653  	 * State will be updated later in this function in case of success
ca6e11c337daf7 Pavel Skripkin         2021-09-30  654  	 */
ca6e11c337daf7 Pavel Skripkin         2021-09-30  655  	bus->state = MDIOBUS_UNREGISTERED;
ca6e11c337daf7 Pavel Skripkin         2021-09-30  656  
46abc02175b3c2 Lennert Buytenhek      2008-10-08  657  	err = device_register(&bus->dev);
46abc02175b3c2 Lennert Buytenhek      2008-10-08  658  	if (err) {
8d242488ce4627 Joe Perches            2012-06-09  659  		pr_err("mii_bus %s failed to register\n", bus->id);
46abc02175b3c2 Lennert Buytenhek      2008-10-08  660  		return -EINVAL;
46abc02175b3c2 Lennert Buytenhek      2008-10-08  661  	}
46abc02175b3c2 Lennert Buytenhek      2008-10-08  662  
d1e7fe4d92742d Adrian Bunk            2008-02-20  663  	mutex_init(&bus->mdio_lock);
6349084746ff4f Michael Walle          2020-05-06  664  	mutex_init(&bus->shared_lock);
d1e7fe4d92742d Adrian Bunk            2008-02-20  665  
e0183b974d3008 Mike Looijmans         2021-02-02  666  	/* assert bus level PHY GPIO reset */
e0183b974d3008 Mike Looijmans         2021-02-02  667  	gpiod = devm_gpiod_get_optional(&bus->dev, "reset", GPIOD_OUT_HIGH);
69226896ad636b Roger Quadros          2017-04-21  668  	if (IS_ERR(gpiod)) {
0a12ad59295561 Grygorii Strashko      2020-11-19  669  		err = dev_err_probe(&bus->dev, PTR_ERR(gpiod),
0a12ad59295561 Grygorii Strashko      2020-11-19  670  				    "mii_bus %s couldn't get reset GPIO\n",
69226896ad636b Roger Quadros          2017-04-21  671  				    bus->id);
e40e2a2e78664f Thomas Petazzoni       2019-01-16  672  		device_del(&bus->dev);
0a12ad59295561 Grygorii Strashko      2020-11-19  673  		return err;
fe0e4052fb11d5 Sergei Shtylyov        2017-06-12  674  	} else	if (gpiod) {
d396e84c56047b Sergei Shtylyov        2017-06-12  675  		bus->reset_gpiod = gpiod;
6259e0f5478d7a Bruno Thomsen          2020-07-30  676  		fsleep(bus->reset_delay_us);
69226896ad636b Roger Quadros          2017-04-21  677  		gpiod_set_value_cansleep(gpiod, 0);
bb3831294cd507 Bruno Thomsen          2020-07-30  678  		if (bus->reset_post_delay_us > 0)
bb3831294cd507 Bruno Thomsen          2020-07-30  679  			fsleep(bus->reset_post_delay_us);
69226896ad636b Roger Quadros          2017-04-21  680  	}
69226896ad636b Roger Quadros          2017-04-21  681  
c290d1ab12d338 Florian Fainelli       2020-04-18  682  	if (bus->reset) {
c290d1ab12d338 Florian Fainelli       2020-04-18  683  		err = bus->reset(bus);
c290d1ab12d338 Florian Fainelli       2020-04-18  684  		if (err)
c290d1ab12d338 Florian Fainelli       2020-04-18  685  			goto error_reset_gpiod;
c290d1ab12d338 Florian Fainelli       2020-04-18  686  	}
df0c8d911abf6b Florian Fainelli       2017-05-11  687  
c5204ce82da312 Andrew Lunn            2022-04-20  688  	if (bus->probe_capabilities == MDIOBUS_NO_CAP ||
c5204ce82da312 Andrew Lunn            2022-04-20  689  	    bus->probe_capabilities == MDIOBUS_C22 ||
c5204ce82da312 Andrew Lunn            2022-04-20  690  	    bus->probe_capabilities == MDIOBUS_C22_C45) {
c5204ce82da312 Andrew Lunn            2022-04-20  691  		err = mdiobus_scan_bus_c22(bus);
c5204ce82da312 Andrew Lunn            2022-04-20  692  		if (err)
161c8d2f50109b Krzysztof Halasa       2008-12-25  693  			goto error;
161c8d2f50109b Krzysztof Halasa       2008-12-25  694  	}
c5204ce82da312 Andrew Lunn            2022-04-20  695  
c5204ce82da312 Andrew Lunn            2022-04-20  696  	if (bus->probe_capabilities == MDIOBUS_C45 ||
c5204ce82da312 Andrew Lunn            2022-04-20  697  	    bus->probe_capabilities == MDIOBUS_C22_C45) {
c5204ce82da312 Andrew Lunn            2022-04-20  698  		err = mdiobus_scan_bus_c45(bus);
c5204ce82da312 Andrew Lunn            2022-04-20  699  		if (err)
c5204ce82da312 Andrew Lunn            2022-04-20  700  			goto error;
64b1c2b42b555e Herbert Valerio Riedel 2006-05-10  701  	}
f896424cbc6122 Matt Porter            2005-11-02  702  
d0281a56b00c63 Florian Fainelli       2017-03-28  703  	mdiobus_setup_mdiodev_from_board_info(bus, mdiobus_create_device);
648ea0134069cd Florian Fainelli       2017-02-04  704  
e8e5752dc0a56a Krzysztof Halasa       2008-12-17  705  	bus->state = MDIOBUS_REGISTERED;
7590fc6f80ac2c Florian Fainelli       2022-01-03  706  	dev_dbg(&bus->dev, "probed\n");
161c8d2f50109b Krzysztof Halasa       2008-12-25  707  	return 0;
e13934563db047 Andy Fleming           2005-08-24  708  
161c8d2f50109b Krzysztof Halasa       2008-12-25  709  error:
161c8d2f50109b Krzysztof Halasa       2008-12-25 @710  	while (--i >= 0) {
711fdba37a3dd7 Andrew Lunn            2016-01-06  711  		mdiodev = bus->mdio_map[i];
711fdba37a3dd7 Andrew Lunn            2016-01-06  712  		if (!mdiodev)
711fdba37a3dd7 Andrew Lunn            2016-01-06  713  			continue;
711fdba37a3dd7 Andrew Lunn            2016-01-06  714  
711fdba37a3dd7 Andrew Lunn            2016-01-06  715  		mdiodev->device_remove(mdiodev);
711fdba37a3dd7 Andrew Lunn            2016-01-06  716  		mdiodev->device_free(mdiodev);
161c8d2f50109b Krzysztof Halasa       2008-12-25  717  	}
c290d1ab12d338 Florian Fainelli       2020-04-18  718  error_reset_gpiod:
69226896ad636b Roger Quadros          2017-04-21  719  	/* Put PHYs in RESET to save power */
a010a2f6540ecc Florian Fainelli       2017-09-08  720  	if (bus->reset_gpiod)
d396e84c56047b Sergei Shtylyov        2017-06-12  721  		gpiod_set_value_cansleep(bus->reset_gpiod, 1);
69226896ad636b Roger Quadros          2017-04-21  722  
161c8d2f50109b Krzysztof Halasa       2008-12-25  723  	device_del(&bus->dev);
4fd5f812c23c7d Lennert Buytenhek      2008-08-26  724  	return err;
4fd5f812c23c7d Lennert Buytenhek      2008-08-26  725  }
3e3aaf64941698 Russell King           2015-09-24  726  EXPORT_SYMBOL(__mdiobus_register);
4fd5f812c23c7d Lennert Buytenhek      2008-08-26  727  

:::::: The code at line 710 was first introduced by commit
:::::: 161c8d2f50109b44b664eaf23831ea1587979a61 net: PHYLIB mdio fixes #2

:::::: TO: Krzysztof Halasa <khc@pm.waw.pl>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6591D53890E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 01:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240870AbiE3XAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 19:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiE3XAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 19:00:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8ED515A8
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 16:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653951644; x=1685487644;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GK4+EgVeD/QOyFHwiAKeZt8AIZ6VFYmsmDrQEWTfFgU=;
  b=DzHULdXk3NDA+yFaZtB1ACi2n5iqi+ylb70KwGUKFq9MH925L8uD8ORz
   gweoh569MQ2DREXVUFnmHZem56p0PwahNRFQyBKoRe79VJtjXrfy4RZtm
   aHigK3V2rEwqo5jVJZJDTuVyBMQoH5O2LquTFX/c4v5suGXrAiUz3jpBh
   kEDaRmAh6JfI3a1mZwt7EXkgq0RNadN4NZ68XjbP2cb+LWZ/JaNvfHDfw
   NBuUs1ocxKEGjsnYT1tUM7U7B6VfYBTWSf35CkIiV3A0i6LSp8W/wPlpb
   e9bzl71LN4yFj6RBdmpp4/6lffDZFMUBM9PedwGHL3NKTOAyZLEM3HKEr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="257156078"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="257156078"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 16:00:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="666670410"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 30 May 2022 16:00:42 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvoNN-000242-Tc;
        Mon, 30 May 2022 23:00:41 +0000
Date:   Tue, 31 May 2022 07:00:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gerhard Engleder <gerhard@engleder-embedded.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/engleder/tsnep_main.c:1254:34: warning:
 'tsnep_of_match' defined but not used
Message-ID: <202205310654.bV25IHSy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8ab2afa23bd197df47819a87f0265c0ac95c5b6a
commit: 403f69bbdbadb2e601f725be2d00b4ccc7b61c9d tsnep: Add TSN endpoint Ethernet MAC driver
date:   6 months ago
config: i386-buildonly-randconfig-r001-20220530 (https://download.01.org/0day-ci/archive/20220531/202205310654.bV25IHSy-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=403f69bbdbadb2e601f725be2d00b4ccc7b61c9d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 403f69bbdbadb2e601f725be2d00b4ccc7b61c9d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/ethernet/engleder/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/engleder/tsnep_main.c: In function 'tsnep_netdev_set_mac_address':
   drivers/net/ethernet/engleder/tsnep_main.c:1007:31: warning: passing argument 1 of 'ether_addr_copy' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    1007 |         ether_addr_copy(netdev->dev_addr, sock_addr->sa_data);
         |                         ~~~~~~^~~~~~~~~~
   In file included from drivers/net/ethernet/engleder/tsnep.h:11,
                    from drivers/net/ethernet/engleder/tsnep_main.c:18:
   include/linux/etherdevice.h:295:40: note: expected 'u8 *' {aka 'unsigned char *'} but argument is of type 'const unsigned char *'
     295 | static inline void ether_addr_copy(u8 *dst, const u8 *src)
         |                                    ~~~~^~~
   drivers/net/ethernet/engleder/tsnep_main.c: In function 'tsnep_mac_init':
   drivers/net/ethernet/engleder/tsnep_main.c:1054:40: warning: passing argument 1 of 'ether_addr_copy' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    1054 |         ether_addr_copy(adapter->netdev->dev_addr, adapter->mac_address);
         |                         ~~~~~~~~~~~~~~~^~~~~~~~~~
   In file included from drivers/net/ethernet/engleder/tsnep.h:11,
                    from drivers/net/ethernet/engleder/tsnep_main.c:18:
   include/linux/etherdevice.h:295:40: note: expected 'u8 *' {aka 'unsigned char *'} but argument is of type 'const unsigned char *'
     295 | static inline void ether_addr_copy(u8 *dst, const u8 *src)
         |                                    ~~~~^~~
   At top level:
>> drivers/net/ethernet/engleder/tsnep_main.c:1254:34: warning: 'tsnep_of_match' defined but not used [-Wunused-const-variable=]
    1254 | static const struct of_device_id tsnep_of_match[] = {
         |                                  ^~~~~~~~~~~~~~


vim +/tsnep_of_match +1254 drivers/net/ethernet/engleder/tsnep_main.c

  1253	
> 1254	static const struct of_device_id tsnep_of_match[] = {
  1255		{ .compatible = "engleder,tsnep", },
  1256	{ },
  1257	};
  1258	MODULE_DEVICE_TABLE(of, tsnep_of_match);
  1259	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

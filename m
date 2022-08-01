Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA98586C49
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiHANxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiHANxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:53:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFEE15FE8
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 06:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659362013; x=1690898013;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0hpQu1uu9wINrJW93x5kqQTFZzRyJzoFTQayCb226CU=;
  b=ICNp2nY0QoI9/22UFdMUzULG3jgGgFuNyTD0fbwmgINE4ivYtPvqMvjo
   IgTpXRZ2x5DRNLzCflWzJe59c/9shC5f1HK1AlBZtTtRzHUJAllJug+h+
   R22Fyt44QARgV0pNgM2kUtqqZOHBevXgcqoQssCXLdo6fjykYMXYWAmrX
   qcX4grqSVF1CkjJ6LPkB8NJA9k7P48QCPD5xtt701bwK4nbi027oKADrY
   bHG7cbDzG0jGmf+o0+agb9V248+VkCFi+4RyhtNHTdBlU6haJoCupegBM
   SRaSjLz1R0WWkgUjB1LFIXmzjmqr5cVq4GnPVjFYxgwHFFEdA2X4UYlQT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="290359786"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="290359786"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 06:53:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="634894002"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Aug 2022 06:53:31 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIVrP-000F5r-0K;
        Mon, 01 Aug 2022 13:53:31 +0000
Date:   Mon, 1 Aug 2022 21:53:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gerhard Engleder <gerhard@engleder-embedded.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/engleder/tsnep_main.c:1254:34: warning:
 'tsnep_of_match' defined but not used
Message-ID: <202208012104.Xlxe8EYV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerhard,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3d7cb6b04c3f3115719235cc6866b10326de34cd
commit: 403f69bbdbadb2e601f725be2d00b4ccc7b61c9d tsnep: Add TSN endpoint Ethernet MAC driver
date:   8 months ago
config: x86_64-randconfig-r012-20220801 (https://download.01.org/0day-ci/archive/20220801/202208012104.Xlxe8EYV-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=403f69bbdbadb2e601f725be2d00b4ccc7b61c9d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 403f69bbdbadb2e601f725be2d00b4ccc7b61c9d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/ethernet/engleder/

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

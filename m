Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3D5578B46
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbiGRTyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiGRTyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:54:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7652B857
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658174071; x=1689710071;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yP4GRAxkr0w6oWeLkOsBxusOg+Ng1i1whYigu9Zq/zE=;
  b=lx+ckGpu9uvO6RucPsElaK/TBM9OKcb4b3nLqixlt06LlCTZpwnQBN86
   Gwbde4qBIkS50DX5wpc1mWSOJrdaay0S1VB0eVSjZnD+2mcCYC5HvJ0Hz
   dzOwA07ptFBA/N0enkM3sPTCVgdvhbe7Jpq0EEttnXUp4Y/2hAhf5tzz6
   TKQ7aHVs9Td+jwDFXNwZBiUQvuZzWluoHxm7EYniQDI3mG+rqdM1e0rdw
   6mZ1/M9fFkQoHXk0wHBd/yTwkz3zF+5uGksFdtiYMSH1VvtSLr39OaMwM
   4au5nJn7bmGJ7XsqQBm4CnGD30qFW3wc2W/kTl6xkNP1pe20uSsJlzw0X
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="283875148"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="283875148"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 12:54:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="572548976"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 18 Jul 2022 12:54:30 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDWp3-0004h4-KL;
        Mon, 18 Jul 2022 19:54:29 +0000
Date:   Tue, 19 Jul 2022 03:53:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gerhard Engleder <gerhard@engleder-embedded.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/engleder/tsnep_main.c:1254:34: warning:
 'tsnep_of_match' defined but not used
Message-ID: <202207190328.lfGnA2y3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerhard,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ff6992735ade75aae3e35d16b17da1008d753d28
commit: 403f69bbdbadb2e601f725be2d00b4ccc7b61c9d tsnep: Add TSN endpoint Ethernet MAC driver
date:   8 months ago
config: x86_64-randconfig-m031-20220718 (https://download.01.org/0day-ci/archive/20220719/202207190328.lfGnA2y3-lkp@intel.com/config)
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

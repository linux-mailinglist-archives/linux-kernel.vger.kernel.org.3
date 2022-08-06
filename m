Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3F858B376
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 04:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241633AbiHFCjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 22:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbiHFCjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 22:39:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0607C1A3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 19:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659753581; x=1691289581;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VJnA3GiJZ2y867/AR3CgMU49bk8pMjvpu/ndRAskQa4=;
  b=i6+FRgd7empzkLzub+d7iQgdJL6/DkEzd9R/A8zXmwS0l5MFucHYTNaz
   /rM5UekQNsi2yjNKJKo56kJ+yYZuOoooHATLzM9DANzZa4nAUv5RsIZjl
   UUfIx138znIVafl94LDkeLyUbUGdRLpBsGySoNRdW9UPrhtaK8wBBDjVe
   xiGojZmdslxzSr2VV2oPdE5VqcIWSBgqK5qQl902c8ukrkrQfNnYbT/Ga
   28uif/slYwaU7rE7JJCYzuJiSrutQO/h9itLEbgZALqCZwna4api+nR3o
   LB7NcHO5oWFT3aeaqWa7UeLMlHzY4Y2EUGuS5H1JJDowtQ1d9hvFeNbmY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="352055229"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="352055229"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 19:39:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="636697456"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 05 Aug 2022 19:39:39 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oK9j1-000Jvr-0d;
        Sat, 06 Aug 2022 02:39:39 +0000
Date:   Sat, 6 Aug 2022 10:39:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-mmp/devices.c:241:17: sparse: sparse: symbol
 'pxa168_usb_phy_resources' was not declared. Should it be static?
Message-ID: <202208061008.saCftLps-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6614a3c3164a5df2b54abb0b3559f51041cf705b
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   4 months ago
config: arm-randconfig-s051-20220805 (https://download.01.org/0day-ci/archive/20220806/202208061008.saCftLps-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> arch/arm/mach-mmp/devices.c:241:17: sparse: sparse: symbol 'pxa168_usb_phy_resources' was not declared. Should it be static?

vim +/pxa168_usb_phy_resources +241 arch/arm/mach-mmp/devices.c

75b1bdf51c4b5c Neil Zhang     2012-05-03  239  
a225daf72ee788 Lubomir Rintel 2018-11-28  240  #if IS_ENABLED(CONFIG_PHY_PXA_USB)
a225daf72ee788 Lubomir Rintel 2018-11-28 @241  struct resource pxa168_usb_phy_resources[] = {
a225daf72ee788 Lubomir Rintel 2018-11-28  242  	[0] = {
a225daf72ee788 Lubomir Rintel 2018-11-28  243  		.start	= PXA168_U2O_PHYBASE,
a225daf72ee788 Lubomir Rintel 2018-11-28  244  		.end	= PXA168_U2O_PHYBASE + USB_PHY_RANGE,
a225daf72ee788 Lubomir Rintel 2018-11-28  245  		.flags	= IORESOURCE_MEM,
a225daf72ee788 Lubomir Rintel 2018-11-28  246  	},
a225daf72ee788 Lubomir Rintel 2018-11-28  247  };
a225daf72ee788 Lubomir Rintel 2018-11-28  248  

:::::: The code at line 241 was first introduced by commit
:::::: a225daf72ee7885ec897e5624b399a024723246f ARM: mmp: add a pxa-usb-phy device

:::::: TO: Lubomir Rintel <lkundrak@v3.sk>
:::::: CC: Olof Johansson <olof@lixom.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

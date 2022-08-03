Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57D058946F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 00:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbiHCWeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 18:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiHCWe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 18:34:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83E01109
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 15:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659566067; x=1691102067;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Povb9iEscAxy2k1L/392Iysef0xGP+3Q3lx8hf5uHZU=;
  b=DYsY7YYeYsqopsmnXR6PnsH+gBteX9PvVxrR8yHJFAQPU1NE6O6tKFT+
   LedcCZXEFiBX5zw/2n9emvFqme2tOtZ1vF3Lls1jojaLTXPG0yJogby+q
   4IULx2VB4N71W6k99pfV/Le1laUOk7S1uR/onH63bVPmeICqNEzOkTlCc
   wemDXuzdFYLvM+ROLhurt+ID2zuxFXkDM4eV77ntuktyR0+xm2X53fYz6
   445eJ6xJYguutDqkc1YTD2KCx7tzTapg1qBXLqIPwBBCCBeWC6D/P4J6f
   zIijWjp2eloFzaUSS3dY+z6we6UTyEA84ix5x4ZJzvDrIKwThsMc/K4gW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="315661842"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="315661842"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 15:34:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="631327574"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 03 Aug 2022 15:34:26 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJMwb-000HjT-2A;
        Wed, 03 Aug 2022 22:34:25 +0000
Date:   Thu, 4 Aug 2022 06:33:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rmk-arm:zii 42/87] drivers/net/pcs/pcs-xpcs.c:178:16: error:
 implicit declaration of function 'mdiodev_c45_read'; did you mean
 'mdiobus_c45_read'?
Message-ID: <202208040620.UbUqOw7I-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm zii
head:   315d00812d1f8ed8bbbce4e4fd8d32fc883900a0
commit: 8994c74ee066d099110807ffcee3f61ffd62d28b [42/87] net: pcs: xpcs: use mdiodev accessors
config: arc-randconfig-r003-20220803 (https://download.01.org/0day-ci/archive/20220804/202208040620.UbUqOw7I-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm zii
        git checkout 8994c74ee066d099110807ffcee3f61ffd62d28b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/net/pcs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/pcs/pcs-xpcs.c: In function 'xpcs_read':
>> drivers/net/pcs/pcs-xpcs.c:178:16: error: implicit declaration of function 'mdiodev_c45_read'; did you mean 'mdiobus_c45_read'? [-Werror=implicit-function-declaration]
     178 |         return mdiodev_c45_read(xpcs->mdiodev, dev, reg);
         |                ^~~~~~~~~~~~~~~~
         |                mdiobus_c45_read
   drivers/net/pcs/pcs-xpcs.c: In function 'xpcs_write':
>> drivers/net/pcs/pcs-xpcs.c:183:16: error: implicit declaration of function 'mdiodev_c45_write'; did you mean 'mdiobus_c45_write'? [-Werror=implicit-function-declaration]
     183 |         return mdiodev_c45_write(xpcs->mdiodev, dev, reg, val);
         |                ^~~~~~~~~~~~~~~~~
         |                mdiobus_c45_write
   cc1: some warnings being treated as errors


vim +178 drivers/net/pcs/pcs-xpcs.c

   172	
   173	#define xpcs_linkmode_supported(compat, mode) \
   174		__xpcs_linkmode_supported(compat, ETHTOOL_LINK_MODE_ ## mode ## _BIT)
   175	
   176	int xpcs_read(struct dw_xpcs *xpcs, int dev, u32 reg)
   177	{
 > 178		return mdiodev_c45_read(xpcs->mdiodev, dev, reg);
   179	}
   180	
   181	int xpcs_write(struct dw_xpcs *xpcs, int dev, u32 reg, u16 val)
   182	{
 > 183		return mdiodev_c45_write(xpcs->mdiodev, dev, reg, val);
   184	}
   185	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

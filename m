Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB1158944E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 00:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbiHCWNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 18:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiHCWN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 18:13:29 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF9F220E5
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 15:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659564808; x=1691100808;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FyZaaNXlO9avdoPUq+PWtAEvmWODROa4pFcuQDEArzM=;
  b=iTyOObSvNbNXsmzwYB29k7nHHOrhYrVzLHET89Y0/DSbZYMnvFbhVkkv
   lb44HSk6pmSFIrr3WBSbyGrrfKoDkZ8GWyP6e/1Dc6CLcb2I1SYPoYFGp
   TzXgIS8G56FQLETwkN4hjbdEvmow52UkRyolGfdSWkB+YoCiElOYJU3q0
   3n5NIkrZagOFrJwTyTzCC1S0Z5WCSNJdVdkuv3E136C6c0lE0uGCBAb0Z
   T8KCitt+tLPQwhR+DV1qUOBpTVvt9Ks4asoXH75Ugc9wSUE8Qi4lHH7Py
   3gfY8ta+XXTTeh76FNkmHCw/hsZqzJF8VZF6cbjCtNS12l7u146h5W28X
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="269561597"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="269561597"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 15:13:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="692403643"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Aug 2022 15:13:25 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJMcH-000Hid-0U;
        Wed, 03 Aug 2022 22:13:25 +0000
Date:   Thu, 4 Aug 2022 06:13:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [rmk-arm:zii 42/87] drivers/net/pcs/pcs-xpcs.c:178:9: error: call to
 undeclared function 'mdiodev_c45_read'; ISO C99 and later do not support
 implicit function declarations
Message-ID: <202208040637.Ng1pO69r-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm zii
head:   315d00812d1f8ed8bbbce4e4fd8d32fc883900a0
commit: 8994c74ee066d099110807ffcee3f61ffd62d28b [42/87] net: pcs: xpcs: use mdiodev accessors
config: arm-randconfig-r014-20220803 (https://download.01.org/0day-ci/archive/20220804/202208040637.Ng1pO69r-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 495519e5f8232d144ed26e9c18dbcbac6a5f25eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm zii
        git checkout 8994c74ee066d099110807ffcee3f61ffd62d28b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/net/pcs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/pcs/pcs-xpcs.c:178:9: error: call to undeclared function 'mdiodev_c45_read'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return mdiodev_c45_read(xpcs->mdiodev, dev, reg);
                  ^
   drivers/net/pcs/pcs-xpcs.c:178:9: note: did you mean 'mdiobus_c45_read'?
   include/linux/mdio.h:505:19: note: 'mdiobus_c45_read' declared here
   static inline int mdiobus_c45_read(struct mii_bus *bus, int prtad, int devad,
                     ^
>> drivers/net/pcs/pcs-xpcs.c:183:9: error: call to undeclared function 'mdiodev_c45_write'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return mdiodev_c45_write(xpcs->mdiodev, dev, reg, val);
                  ^
   drivers/net/pcs/pcs-xpcs.c:183:9: note: did you mean 'mdiobus_c45_write'?
   include/linux/mdio.h:511:19: note: 'mdiobus_c45_write' declared here
   static inline int mdiobus_c45_write(struct mii_bus *bus, int prtad, int devad,
                     ^
   2 errors generated.


vim +/mdiodev_c45_read +178 drivers/net/pcs/pcs-xpcs.c

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

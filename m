Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC62590FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 13:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbiHLLIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 07:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiHLLIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 07:08:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16444A8CE5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 04:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660302522; x=1691838522;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4ktXzE5RQq0eGiQ1PdlQTV7GNdfQqf9bXxcMzZPMB48=;
  b=IpKqqJjmw+/lyX2cd6MRaoc2iRbCOx2vkba/Wr4pta7iHuvGdukT94MD
   55KWahgRGVCG6Alv08G0W6zF1gy984e7xnm+CUtyJaxyC/WU6aBR0nsja
   RaAGHn28uGr68Uf8OMrieerbKLlJrGYNFaof2Ueql/G/UQTtduECVGQGB
   UnvYG1WUFG6SdAORpJ+NWK31kjEYqMfXWlUe8lYo4ujl37sBZMOvqBuEw
   xYRkDRM7Q2PxZ5sFGMERV63e1XFPM1OT+POpNIMCHTrQNyPrCAO22iIC9
   I7f3ht1OLcrtsJRJKokFt9UqTQnfDWMgOEdI5FIWdjVxDunURDk6hd4Id
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="271348061"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="271348061"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 04:08:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="638864363"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 12 Aug 2022 04:08:40 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMSWt-0000Sg-2B;
        Fri, 12 Aug 2022 11:08:39 +0000
Date:   Fri, 12 Aug 2022 19:08:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-mmp/devices.c:262:17: sparse: sparse: symbol
 'pxa168_u2o_resources' was not declared. Should it be static?
Message-ID: <202208121852.EWOy4J0A-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7ebfc85e2cd7b08f518b526173e9a33b56b3913b
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   4 months ago
config: arm-randconfig-s041-20220812 (https://download.01.org/0day-ci/archive/20220812/202208121852.EWOy4J0A-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-mmp/ arch/arm/mach-socfpga/ drivers/usb/gadget/udc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   arch/arm/mach-mmp/devices.c:241:17: sparse: sparse: symbol 'pxa168_usb_phy_resources' was not declared. Should it be static?
>> arch/arm/mach-mmp/devices.c:262:17: sparse: sparse: symbol 'pxa168_u2o_resources' was not declared. Should it be static?
--
>> arch/arm/mach-socfpga/pm.c:75:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *[assigned] suspend_ocram_base @@
   arch/arm/mach-socfpga/pm.c:75:25: sparse:     expected void const *
   arch/arm/mach-socfpga/pm.c:75:25: sparse:     got void [noderef] __iomem *[assigned] suspend_ocram_base
>> arch/arm/mach-socfpga/pm.c:75:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *[assigned] suspend_ocram_base @@
   arch/arm/mach-socfpga/pm.c:75:25: sparse:     expected void const *
   arch/arm/mach-socfpga/pm.c:75:25: sparse:     got void [noderef] __iomem *[assigned] suspend_ocram_base
>> arch/arm/mach-socfpga/pm.c:75:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *[assigned] suspend_ocram_base @@
   arch/arm/mach-socfpga/pm.c:75:25: sparse:     expected void *
   arch/arm/mach-socfpga/pm.c:75:25: sparse:     got void [noderef] __iomem *[assigned] suspend_ocram_base
--
>> drivers/usb/gadget/udc/atmel_usba_udc.c:1314:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] status @@     got restricted __le16 [usertype] @@
   drivers/usb/gadget/udc/atmel_usba_udc.c:1314:32: sparse:     expected unsigned short [usertype] status
   drivers/usb/gadget/udc/atmel_usba_udc.c:1314:32: sparse:     got restricted __le16 [usertype]
   drivers/usb/gadget/udc/atmel_usba_udc.c:1317:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] status @@     got restricted __le16 [usertype] @@
   drivers/usb/gadget/udc/atmel_usba_udc.c:1317:32: sparse:     expected unsigned short [usertype] status
   drivers/usb/gadget/udc/atmel_usba_udc.c:1317:32: sparse:     got restricted __le16 [usertype]
>> drivers/usb/gadget/udc/atmel_usba_udc.c:1328:40: sparse: sparse: invalid assignment: |=
>> drivers/usb/gadget/udc/atmel_usba_udc.c:1328:40: sparse:    left side has type unsigned short
>> drivers/usb/gadget/udc/atmel_usba_udc.c:1328:40: sparse:    right side has type restricted __le16

vim +/pxa168_u2o_resources +262 arch/arm/mach-mmp/devices.c

a225daf72ee788 Lubomir Rintel 2018-11-28  260  
3524080826c289 Arnd Bergmann  2014-03-12  261  #if IS_ENABLED(CONFIG_USB_MV_UDC)
75b1bdf51c4b5c Neil Zhang     2012-05-03 @262  struct resource pxa168_u2o_resources[] = {
75b1bdf51c4b5c Neil Zhang     2012-05-03  263  	/* regbase */
75b1bdf51c4b5c Neil Zhang     2012-05-03  264  	[0] = {
75b1bdf51c4b5c Neil Zhang     2012-05-03  265  		.start	= PXA168_U2O_REGBASE + U2x_CAPREGS_OFFSET,
75b1bdf51c4b5c Neil Zhang     2012-05-03  266  		.end	= PXA168_U2O_REGBASE + USB_REG_RANGE,
75b1bdf51c4b5c Neil Zhang     2012-05-03  267  		.flags	= IORESOURCE_MEM,
75b1bdf51c4b5c Neil Zhang     2012-05-03  268  		.name	= "capregs",
75b1bdf51c4b5c Neil Zhang     2012-05-03  269  	},
75b1bdf51c4b5c Neil Zhang     2012-05-03  270  	/* phybase */
75b1bdf51c4b5c Neil Zhang     2012-05-03  271  	[1] = {
75b1bdf51c4b5c Neil Zhang     2012-05-03  272  		.start	= PXA168_U2O_PHYBASE,
75b1bdf51c4b5c Neil Zhang     2012-05-03  273  		.end	= PXA168_U2O_PHYBASE + USB_PHY_RANGE,
75b1bdf51c4b5c Neil Zhang     2012-05-03  274  		.flags	= IORESOURCE_MEM,
75b1bdf51c4b5c Neil Zhang     2012-05-03  275  		.name	= "phyregs",
75b1bdf51c4b5c Neil Zhang     2012-05-03  276  	},
75b1bdf51c4b5c Neil Zhang     2012-05-03  277  	[2] = {
75b1bdf51c4b5c Neil Zhang     2012-05-03  278  		.start	= IRQ_PXA168_USB1,
75b1bdf51c4b5c Neil Zhang     2012-05-03  279  		.end	= IRQ_PXA168_USB1,
75b1bdf51c4b5c Neil Zhang     2012-05-03  280  		.flags	= IORESOURCE_IRQ,
75b1bdf51c4b5c Neil Zhang     2012-05-03  281  	},
75b1bdf51c4b5c Neil Zhang     2012-05-03  282  };
75b1bdf51c4b5c Neil Zhang     2012-05-03  283  

:::::: The code at line 262 was first introduced by commit
:::::: 75b1bdf51c4b5c383296de2df9ad83b1b8dd287f ARM: mmp: add usb device support for PXA910

:::::: TO: Neil Zhang <zhangwm@marvell.com>
:::::: CC: Haojian Zhuang <haojian.zhuang@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

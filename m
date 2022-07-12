Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4C557276C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiGLUim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiGLUig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:38:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBDF5F4D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657658315; x=1689194315;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sDqUMNOCl+pBJGMmuUHlrvnXfXOlOt0p9VGdzPjfPHg=;
  b=BpXtFk+N9iKxRIlbeVJbRqImLX3v5VPY1GFxppDq7bTlcRdMMX0eGcdh
   VWvjKdEMhsHISzs90gP37Bv2wEepAXC5h/S4sk/ascY60bSRA+2N01BLg
   pxTawcAjlqICtN2Cq6MdqeFDUNNKEoRgOZgS99QymCaQeKlrofe0oOmV3
   34HF8jb6p4SSHDCmMU7KCXOIIJSP4ofu+r0Ukbqfkh/9NYuoR2a/MmtZF
   CnEAlUeD2lDVe1uMAxZtu0FMEWEwAKstWbErNDlnIMA5BSUTHuUC86Zlm
   oOSo1/O9jDvDphiEMV1bfoJTPMxCD29/xzACnouZZDLWVGGi+eOkufZwv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="265449767"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="265449767"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 13:38:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="622654605"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 12 Jul 2022 13:38:33 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBMeO-0002g3-Hh;
        Tue, 12 Jul 2022 20:38:32 +0000
Date:   Wed, 13 Jul 2022 04:37:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-omap1/devices.c:230:24: sparse: sparse: symbol
 'omap_spi1' was not declared. Should it be static?
Message-ID: <202207130452.LSMR6iix-lkp@intel.com>
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

Hi Stephen,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   72a8e05d4f66b5af7854df4490e3135168694b6b
commit: 250c1a694ff304e5d69e74ab32755eddcc2b8f65 ARM: pxa: convert to multiplatform
date:   9 weeks ago
config: arm-randconfig-s031-20220712 (https://download.01.org/0day-ci/archive/20220713/202207130452.LSMR6iix-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=250c1a694ff304e5d69e74ab32755eddcc2b8f65
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 250c1a694ff304e5d69e74ab32755eddcc2b8f65
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-iop32x/ arch/arm/mach-mmp/ arch/arm/mach-mv78xx0/ arch/arm/mach-omap1/ arch/arm/mach-orion5x/ arch/arm/mach-spear/ arch/arm/mm/ drivers/clk/spear/ drivers/isdn/hardware/mISDN/ drivers/net/ethernet/google/gve/ drivers/scsi/ drivers/usb/host/ sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/arm/mach-omap1/devices.c:230:24: sparse: sparse: symbol 'omap_spi1' was not declared. Should it be static?
>> arch/arm/mach-omap1/devices.c:235:24: sparse: sparse: symbol 'omap_spi2' was not declared. Should it be static?
>> arch/arm/mach-omap1/devices.c:245:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[addressable] [toplevel] platform_data @@     got void [noderef] __iomem * @@
   arch/arm/mach-omap1/devices.c:245:37: sparse:     expected void *[addressable] [toplevel] platform_data
   arch/arm/mach-omap1/devices.c:245:37: sparse:     got void [noderef] __iomem *
   arch/arm/mach-omap1/devices.c:249:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[addressable] [toplevel] platform_data @@     got void [noderef] __iomem * @@
   arch/arm/mach-omap1/devices.c:249:37: sparse:     expected void *[addressable] [toplevel] platform_data
   arch/arm/mach-omap1/devices.c:249:37: sparse:     got void [noderef] __iomem *
--
>> arch/arm/mach-omap1/mcbsp.c:94:17: sparse: sparse: symbol 'omap7xx_mcbsp_res' was not declared. Should it be static?
   arch/arm/mach-omap1/mcbsp.c:171:17: sparse: sparse: symbol 'omap15xx_mcbsp_res' was not declared. Should it be static?
>> arch/arm/mach-omap1/mcbsp.c:278:17: sparse: sparse: symbol 'omap16xx_mcbsp_res' was not declared. Should it be static?
--
>> drivers/usb/host/ohci-omap.c:231:31: sparse: sparse: Using plain integer as NULL pointer
   drivers/usb/host/ohci-omap.c:353:56: sparse: sparse: Using plain integer as NULL pointer

vim +/omap_spi1 +230 arch/arm/mach-omap1/devices.c

c5c4dce45d7538 Cory Maccarrone 2010-01-08  229  
c5c4dce45d7538 Cory Maccarrone 2010-01-08 @230  struct platform_device omap_spi1 = {
c5c4dce45d7538 Cory Maccarrone 2010-01-08  231  	.name           = "omap1_spi100k",
c5c4dce45d7538 Cory Maccarrone 2010-01-08  232  	.id             = 1,
c5c4dce45d7538 Cory Maccarrone 2010-01-08  233  };
c5c4dce45d7538 Cory Maccarrone 2010-01-08  234  
c5c4dce45d7538 Cory Maccarrone 2010-01-08 @235  struct platform_device omap_spi2 = {
c5c4dce45d7538 Cory Maccarrone 2010-01-08  236  	.name           = "omap1_spi100k",
c5c4dce45d7538 Cory Maccarrone 2010-01-08  237  	.id             = 2,
c5c4dce45d7538 Cory Maccarrone 2010-01-08  238  };
c5c4dce45d7538 Cory Maccarrone 2010-01-08  239  
c5c4dce45d7538 Cory Maccarrone 2010-01-08  240  static void omap_init_spi100k(void)
c5c4dce45d7538 Cory Maccarrone 2010-01-08  241  {
028baad5221e5f Aaro Koskinen   2018-11-19  242  	if (!cpu_is_omap7xx())
028baad5221e5f Aaro Koskinen   2018-11-19  243  		return;
028baad5221e5f Aaro Koskinen   2018-11-19  244  
c5c4dce45d7538 Cory Maccarrone 2010-01-08 @245  	omap_spi1.dev.platform_data = ioremap(OMAP7XX_SPI1_BASE, 0x7ff);
c5c4dce45d7538 Cory Maccarrone 2010-01-08  246  	if (omap_spi1.dev.platform_data)
c5c4dce45d7538 Cory Maccarrone 2010-01-08  247  		platform_device_register(&omap_spi1);
c5c4dce45d7538 Cory Maccarrone 2010-01-08  248  
c5c4dce45d7538 Cory Maccarrone 2010-01-08  249  	omap_spi2.dev.platform_data = ioremap(OMAP7XX_SPI2_BASE, 0x7ff);
c5c4dce45d7538 Cory Maccarrone 2010-01-08  250  	if (omap_spi2.dev.platform_data)
c5c4dce45d7538 Cory Maccarrone 2010-01-08  251  		platform_device_register(&omap_spi2);
c5c4dce45d7538 Cory Maccarrone 2010-01-08  252  }
c5c4dce45d7538 Cory Maccarrone 2010-01-08  253  

:::::: The code at line 230 was first introduced by commit
:::::: c5c4dce45d7538ada6e9aac4cdb2909bc1cb28f6 omap1: Add 7xx clocks and pin muxes for SPI

:::::: TO: Cory Maccarrone <darkstar6262@gmail.com>
:::::: CC: Tony Lindgren <tony@atomide.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

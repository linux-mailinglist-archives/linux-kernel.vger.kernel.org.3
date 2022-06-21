Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A15E553B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352455AbiFUUPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbiFUUPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:15:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E001CB2D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655842514; x=1687378514;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bGXRbwjTqUOATWAK5R6YerHSlERTGBCEPEhb+fZuDZA=;
  b=E0eqvaKXbCJ0E8smVXnxptNPKYncAeSyo7UGR7FI1pju+8XBvbXd7Etk
   9O6YXTPDA+JYV03J5nm0qL0d1FiDMdpfHPA67cA+8Y+hYi7+AL9+50pYO
   4uRO5XYndRMKPM3TbeZsNr9QYbfbMaj0sUCSGZQnI6frQ8x4lG+TwGeI1
   vgCpSFmsS0TxA0VvNjKmfld2R1Osuh8WpqhbEf8up/NPNVe0ffWs1UFWR
   YEWu/3C2tPHVtFvrC3EPa+Nhcru+BlnFz2R3vLdm3S0RYHaHfcKguRh3n
   CEOrMzajV/52m4Pzh581fi7qirW0ZbFpRvrwZiKsjXu97MOn6B0hfVjX2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="260657052"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="260657052"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 13:15:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="643801025"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jun 2022 13:15:13 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3kHI-0000NM-FM;
        Tue, 21 Jun 2022 20:15:12 +0000
Date:   Wed, 22 Jun 2022 04:14:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: drivers/platform/mips/rs780e-acpi.c:35:6: warning: no previous
 prototype for 'pm_iowrite'
Message-ID: <202206220419.A7URFBQr-lkp@intel.com>
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
head:   78ca55889a549a9a194c6ec666836329b774ab6d
commit: 0cfd2440aa03ea3d4b04cc2565561cecadcb1257 MIPS: Loongson64: Make RS780E ACPI as a platform driver
date:   2 years, 2 months ago
config: mips-randconfig-r011-20220622 (https://download.01.org/0day-ci/archive/20220622/202206220419.A7URFBQr-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0cfd2440aa03ea3d4b04cc2565561cecadcb1257
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0cfd2440aa03ea3d4b04cc2565561cecadcb1257
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/platform/mips/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/mips/rs780e-acpi.c:35:6: warning: no previous prototype for 'pm_iowrite' [-Wmissing-prototypes]
      35 | void pm_iowrite(u8 reg, u8 value)
         |      ^~~~~~~~~~
>> drivers/platform/mips/rs780e-acpi.c:41:4: warning: no previous prototype for 'pm_ioread' [-Wmissing-prototypes]
      41 | u8 pm_ioread(u8 reg)
         |    ^~~~~~~~~
>> drivers/platform/mips/rs780e-acpi.c:47:6: warning: no previous prototype for 'pm2_iowrite' [-Wmissing-prototypes]
      47 | void pm2_iowrite(u8 reg, u8 value)
         |      ^~~~~~~~~~~
>> drivers/platform/mips/rs780e-acpi.c:53:4: warning: no previous prototype for 'pm2_ioread' [-Wmissing-prototypes]
      53 | u8 pm2_ioread(u8 reg)
         |    ^~~~~~~~~~
   drivers/platform/mips/rs780e-acpi.c:72:6: warning: no previous prototype for 'acpi_registers_setup' [-Wmissing-prototypes]
      72 | void acpi_registers_setup(void)
         |      ^~~~~~~~~~~~~~~~~~~~


vim +/pm_iowrite +35 drivers/platform/mips/rs780e-acpi.c

9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  34  
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29 @35  void pm_iowrite(u8 reg, u8 value)
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  36  {
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  37  	pmio_write_index(PM_INDEX, reg, value);
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  38  }
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  39  EXPORT_SYMBOL(pm_iowrite);
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  40  
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29 @41  u8 pm_ioread(u8 reg)
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  42  {
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  43  	return pmio_read_index(PM_INDEX, reg);
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  44  }
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  45  EXPORT_SYMBOL(pm_ioread);
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  46  
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29 @47  void pm2_iowrite(u8 reg, u8 value)
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  48  {
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  49  	pmio_write_index(PM2_INDEX, reg, value);
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  50  }
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  51  EXPORT_SYMBOL(pm2_iowrite);
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  52  
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29 @53  u8 pm2_ioread(u8 reg)
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  54  {
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  55  	return pmio_read_index(PM2_INDEX, reg);
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  56  }
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  57  EXPORT_SYMBOL(pm2_ioread);
9c057b3e02184b1 drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  58  

:::::: The code at line 35 was first introduced by commit
:::::: 9c057b3e02184b111d3392be75efc7c94f0fdf20 MIPS: Loongson-3: Add chipset ACPI platform driver

:::::: TO: Huacai Chen <chenhc@lemote.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

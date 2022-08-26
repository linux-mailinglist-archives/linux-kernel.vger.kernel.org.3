Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EC35A1EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 04:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244848AbiHZCZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 22:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244154AbiHZCZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:25:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D34C59E0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 19:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661480747; x=1693016747;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DAdEbK/q7nGjXDdZ7NpHAffn5Cx2ccndJW77ay7UV9s=;
  b=nvRIU93p6u7pQOmLb0aqUGexu4tD8qFpnnds3SayRbvJSiULh3L1wS/8
   t+106J7aTKBfNtwlUVrTiX6b1+0ZZ4uFSBiwxHsTkF0vxzAq36lTG5W+G
   A4RbCwvRI5hxWQqLXRaB6IdyLg5EhgC6M0PdXItXiYiRGK4r9/QsE2If9
   N6x9gG+IFPVHrjmMp+CPt/xp12/7qgG6TbUYVNd2o97PD0lLCQ+6lECYh
   lfQBsuJ6lsA3Q0iPtbCGn0gzsKU8T1ndV6tqxU9Wkos6VSiH48aO0qONR
   67qqs6i94x2phHkqIQi4MzN9C32zetIbBHDT6pHsgfko4otzu2eDFZOE6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="320496541"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="320496541"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 19:25:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="587132577"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 25 Aug 2022 19:25:45 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRP2W-0003G0-1a;
        Fri, 26 Aug 2022 02:25:44 +0000
Date:   Fri, 26 Aug 2022 10:25:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-imx/cpu-imx25.c:40:5: warning: no previous prototype
 for 'mx25_revision'
Message-ID: <202208261020.uj1YdaoI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4c612826bec1441214816827979b62f84a097e91
commit: a3102fafdce6f150e5a46e1725bb1732f8953a01 ARM: iop32x: enable multiplatform support
date:   5 months ago
config: arm-randconfig-r032-20220826 (https://download.01.org/0day-ci/archive/20220826/202208261020.uj1YdaoI-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a3102fafdce6f150e5a46e1725bb1732f8953a01
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a3102fafdce6f150e5a46e1725bb1732f8953a01
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-imx/ arch/arm/mach-versatile/ drivers/clk/spear/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/gfp.h:6,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from arch/arm/mach-imx/cpu-imx25.c:8:
   include/linux/mmzone.h: In function '__nr_to_section':
   include/linux/mmzone.h:1404:13: warning: the comparison will always evaluate as 'true' for the address of 'mem_section' will never be NULL [-Waddress]
    1404 |         if (!mem_section[SECTION_NR_TO_ROOT(nr)])
         |             ^
   include/linux/mmzone.h:1390:27: note: 'mem_section' declared here
    1390 | extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
         |                           ^~~~~~~~~~~
   arch/arm/mach-imx/cpu-imx25.c: At top level:
>> arch/arm/mach-imx/cpu-imx25.c:40:5: warning: no previous prototype for 'mx25_revision' [-Wmissing-prototypes]
      40 | int mx25_revision(void)
         |     ^~~~~~~~~~~~~
--
   In file included from include/linux/swap.h:7,
                    from include/linux/suspend.h:5,
                    from arch/arm/mach-imx/pm-imx25.c:7:
   include/linux/mmzone.h: In function '__nr_to_section':
   include/linux/mmzone.h:1404:13: warning: the comparison will always evaluate as 'true' for the address of 'mem_section' will never be NULL [-Waddress]
    1404 |         if (!mem_section[SECTION_NR_TO_ROOT(nr)])
         |             ^
   include/linux/mmzone.h:1390:27: note: 'mem_section' declared here
    1390 | extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
         |                           ^~~~~~~~~~~
   arch/arm/mach-imx/pm-imx25.c: At top level:
>> arch/arm/mach-imx/pm-imx25.c:31:13: warning: no previous prototype for 'imx25_pm_init' [-Wmissing-prototypes]
      31 | void __init imx25_pm_init(void)
         |             ^~~~~~~~~~~~~
--
   In file included from include/linux/gfp.h:6,
                    from include/linux/radix-tree.h:12,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from arch/arm/mach-versatile/versatile.c:13:
   include/linux/mmzone.h: In function '__nr_to_section':
   include/linux/mmzone.h:1404:13: warning: the comparison will always evaluate as 'true' for the address of 'mem_section' will never be NULL [-Waddress]
    1404 |         if (!mem_section[SECTION_NR_TO_ROOT(nr)])
         |             ^
   include/linux/mmzone.h:1390:27: note: 'mem_section' declared here
    1390 | extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
         |                           ^~~~~~~~~~~
   arch/arm/mach-versatile/versatile.c: At top level:
>> arch/arm/mach-versatile/versatile.c:56:14: warning: no previous prototype for 'mmc_status' [-Wmissing-prototypes]
      56 | unsigned int mmc_status(struct device *dev)
         |              ^~~~~~~~~~
--
   In file included from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/clkdev.h:12,
                    from drivers/clk/spear/spear3xx_clock.c:13:
   include/linux/mmzone.h: In function '__nr_to_section':
   include/linux/mmzone.h:1404:13: warning: the comparison will always evaluate as 'true' for the address of 'mem_section' will never be NULL [-Waddress]
    1404 |         if (!mem_section[SECTION_NR_TO_ROOT(nr)])
         |             ^
   include/linux/mmzone.h:1390:27: note: 'mem_section' declared here
    1390 | extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
         |                           ^~~~~~~~~~~
   drivers/clk/spear/spear3xx_clock.c: At top level:
>> drivers/clk/spear/spear3xx_clock.c:390:13: warning: no previous prototype for 'spear3xx_clk_init' [-Wmissing-prototypes]
     390 | void __init spear3xx_clk_init(void __iomem *misc_base, void __iomem *soc_config_base)
         |             ^~~~~~~~~~~~~~~~~


vim +/mx25_revision +40 arch/arm/mach-imx/cpu-imx25.c

d27536c6619221 Jason Liu 2011-08-26  39  
d27536c6619221 Jason Liu 2011-08-26 @40  int mx25_revision(void)

:::::: The code at line 40 was first introduced by commit
:::::: d27536c6619221528114746317def345467a3e80 ARM: mx25: Print silicon revision on boot

:::::: TO: Jason Liu <jason.hui@linaro.org>
:::::: CC: Sascha Hauer <s.hauer@pengutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

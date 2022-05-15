Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA63C527AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 01:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238004AbiEOXsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 19:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiEOXsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 19:48:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C24E019
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 16:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652658480; x=1684194480;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b+hR2F2ZOw1YBVpl9/Ehs08E1LlyG07VOZuDvl3R+sM=;
  b=QgvpH3qjmi/96CDuuWFpuHnU419+bC98PWoxzxDOm0AfRbHX685ADhrT
   3n8KYuY/9XJ9CVDyKExDwJJjSpkPD0KPs24z/hB9sI8/gd5Kp8MhLiF7O
   iILHsSvaUJeg/mU5YR+L9xVzdciTKPvsWZ4RGxF91rrG7o7BGkQX+ZfzP
   DiZ5gGswTHwvOD7VUplU8HeVdgtTT++iJJlfk8xdODHfygtnT3Auwi6qY
   yw0XFnfC1D0rtE6rFtlM6cc/9kE4CIdt9vdlbiSsuMdzmGLw3uKIYBwOT
   T4hV9ow+iB8F2kED5jpioID/Q8Klfpn/Uu80J0ZYs/yQKJT63pzIUw3oy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="251205868"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="251205868"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 16:47:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="604627415"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 May 2022 16:47:57 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqNxs-00021t-Tn;
        Sun, 15 May 2022 23:47:56 +0000
Date:   Mon, 16 May 2022 07:47:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: drivers/iio/adc/rcar-gyroadc.c:300:34: warning:
 'rcar_gyroadc_child_match' defined but not used
Message-ID: <202205160759.pkycZ4CI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0cdd776ec92c0fec768c7079331804d3e52d4b27
commit: af5d716a90ba55635bbdcbf145465b5fdc5a5530 iio: adc: rcar-gyroadc: Enable compile-testing on non-ARM
date:   4 years, 7 months ago
config: i386-buildonly-randconfig-r001-20220516 (https://download.01.org/0day-ci/archive/20220516/202205160759.pkycZ4CI-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af5d716a90ba55635bbdcbf145465b5fdc5a5530
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout af5d716a90ba55635bbdcbf145465b5fdc5a5530
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/bcma/ drivers/i2c/busses/ drivers/iio/adc/ drivers/regulator/ drivers/soc/mediatek/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/workqueue.h:8,
                    from include/linux/srcu.h:34,
                    from include/linux/notifier.h:15,
                    from include/linux/memory_hotplug.h:6,
                    from include/linux/mmzone.h:779,
                    from include/linux/gfp.h:5,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:22,
                    from include/linux/module.h:13,
                    from drivers/iio/adc/rcar-gyroadc.c:17:
   include/linux/timer.h: In function 'timer_setup':
   include/linux/timer.h:178:30: warning: cast between incompatible function types from 'void (*)(struct timer_list *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]
     178 |         __setup_timer(timer, (TIMER_FUNC_TYPE)callback,
         |                              ^
   include/linux/timer.h:143:39: note: in definition of macro '__setup_timer'
     143 |                 (_timer)->function = (_fn);                             \
         |                                       ^~~
   In file included from drivers/iio/adc/rcar-gyroadc.c:17:
   drivers/iio/adc/rcar-gyroadc.c: At top level:
   include/linux/module.h:137:14: warning: 'cleanup_module' specifies less restrictive attribute than its target 'rcar_gyroadc_driver_exit': 'cold' [-Wmissing-attributes]
     137 |         void cleanup_module(void) __attribute__((alias(#exitfn)));
         |              ^~~~~~~~~~~~~~
   include/linux/device.h:1509:1: note: in expansion of macro 'module_exit'
    1509 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/platform_device.h:228:9: note: in expansion of macro 'module_driver'
     228 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/iio/adc/rcar-gyroadc.c:628:1: note: in expansion of macro 'module_platform_driver'
     628 | module_platform_driver(rcar_gyroadc_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/platform_device.h:14,
                    from drivers/iio/adc/rcar-gyroadc.c:18:
   drivers/iio/adc/rcar-gyroadc.c:628:24: note: 'cleanup_module' target declared here
     628 | module_platform_driver(rcar_gyroadc_driver);
         |                        ^~~~~~~~~~~~~~~~~~~
   include/linux/device.h:1505:20: note: in definition of macro 'module_driver'
    1505 | static void __exit __driver##_exit(void) \
         |                    ^~~~~~~~
   drivers/iio/adc/rcar-gyroadc.c:628:1: note: in expansion of macro 'module_platform_driver'
     628 | module_platform_driver(rcar_gyroadc_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/iio/adc/rcar-gyroadc.c:17:
   include/linux/module.h:131:13: warning: 'init_module' specifies less restrictive attribute than its target 'rcar_gyroadc_driver_init': 'cold' [-Wmissing-attributes]
     131 |         int init_module(void) __attribute__((alias(#initfn)));
         |             ^~~~~~~~~~~
   include/linux/device.h:1504:1: note: in expansion of macro 'module_init'
    1504 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/platform_device.h:228:9: note: in expansion of macro 'module_driver'
     228 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/iio/adc/rcar-gyroadc.c:628:1: note: in expansion of macro 'module_platform_driver'
     628 | module_platform_driver(rcar_gyroadc_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/platform_device.h:14,
                    from drivers/iio/adc/rcar-gyroadc.c:18:
   drivers/iio/adc/rcar-gyroadc.c:628:24: note: 'init_module' target declared here
     628 | module_platform_driver(rcar_gyroadc_driver);
         |                        ^~~~~~~~~~~~~~~~~~~
   include/linux/device.h:1500:19: note: in definition of macro 'module_driver'
    1500 | static int __init __driver##_init(void) \
         |                   ^~~~~~~~
   drivers/iio/adc/rcar-gyroadc.c:628:1: note: in expansion of macro 'module_platform_driver'
     628 | module_platform_driver(rcar_gyroadc_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/adc/rcar-gyroadc.c:300:34: warning: 'rcar_gyroadc_child_match' defined but not used [-Wunused-const-variable=]
     300 | static const struct of_device_id rcar_gyroadc_child_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/rcar_gyroadc_child_match +300 drivers/iio/adc/rcar-gyroadc.c

059c53b3232960 Marek Vasut 2017-01-28  299  
059c53b3232960 Marek Vasut 2017-01-28 @300  static const struct of_device_id rcar_gyroadc_child_match[] = {
059c53b3232960 Marek Vasut 2017-01-28  301  	/* Mode 1 ADCs */
059c53b3232960 Marek Vasut 2017-01-28  302  	{
059c53b3232960 Marek Vasut 2017-01-28  303  		.compatible	= "fujitsu,mb88101a",
059c53b3232960 Marek Vasut 2017-01-28  304  		.data		= (void *)RCAR_GYROADC_MODE_SELECT_1_MB88101A,
059c53b3232960 Marek Vasut 2017-01-28  305  	},
059c53b3232960 Marek Vasut 2017-01-28  306  	/* Mode 2 ADCs */
059c53b3232960 Marek Vasut 2017-01-28  307  	{
059c53b3232960 Marek Vasut 2017-01-28  308  		.compatible	= "ti,adcs7476",
059c53b3232960 Marek Vasut 2017-01-28  309  		.data		= (void *)RCAR_GYROADC_MODE_SELECT_2_ADCS7476,
059c53b3232960 Marek Vasut 2017-01-28  310  	}, {
059c53b3232960 Marek Vasut 2017-01-28  311  		.compatible	= "ti,adc121",
059c53b3232960 Marek Vasut 2017-01-28  312  		.data		= (void *)RCAR_GYROADC_MODE_SELECT_2_ADCS7476,
059c53b3232960 Marek Vasut 2017-01-28  313  	}, {
059c53b3232960 Marek Vasut 2017-01-28  314  		.compatible	= "adi,ad7476",
059c53b3232960 Marek Vasut 2017-01-28  315  		.data		= (void *)RCAR_GYROADC_MODE_SELECT_2_ADCS7476,
059c53b3232960 Marek Vasut 2017-01-28  316  	},
059c53b3232960 Marek Vasut 2017-01-28  317  	/* Mode 3 ADCs */
059c53b3232960 Marek Vasut 2017-01-28  318  	{
059c53b3232960 Marek Vasut 2017-01-28  319  		.compatible	= "maxim,max1162",
059c53b3232960 Marek Vasut 2017-01-28  320  		.data		= (void *)RCAR_GYROADC_MODE_SELECT_3_MAX1162,
059c53b3232960 Marek Vasut 2017-01-28  321  	}, {
059c53b3232960 Marek Vasut 2017-01-28  322  		.compatible	= "maxim,max11100",
059c53b3232960 Marek Vasut 2017-01-28  323  		.data		= (void *)RCAR_GYROADC_MODE_SELECT_3_MAX1162,
059c53b3232960 Marek Vasut 2017-01-28  324  	},
059c53b3232960 Marek Vasut 2017-01-28  325  	{ /* sentinel */ }
059c53b3232960 Marek Vasut 2017-01-28  326  };
059c53b3232960 Marek Vasut 2017-01-28  327  

:::::: The code at line 300 was first introduced by commit
:::::: 059c53b3232960cfd38cc46de0a7bedd642021f5 iio: adc: Add Renesas GyroADC driver

:::::: TO: Marek Vasut <marek.vasut+renesas@gmail.com>
:::::: CC: Jonathan Cameron <jic23@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

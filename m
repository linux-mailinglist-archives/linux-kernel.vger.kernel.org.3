Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0C94BD3E6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344017AbiBUCn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:43:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344015AbiBUCn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:43:28 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA25E640C
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 18:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645411385; x=1676947385;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=079l3eFCI+AAzP+enJT/oHzcvI4rC3Rb0968B3Qltuw=;
  b=UnPElITGFv8t+BryQJLQUpZzbMP8ICdQoeG/npybhLiJpevJybKsyRSV
   AWDl/VtR2fb5Z+Mig8ZKgd/h2Ltyb/htC94gi30beuC9F7588rNGvAZ5l
   5wHKprKpt6ZKQ1wy2VfZnS7gGEtnbXoLWSyz7YOsNWuL7SEGcbE/DqrIZ
   B3XVkMJ0bIV4Kjm3LICeqnDzkoZyxFQ+stupwE5myppLJhQ5sldGOVDMF
   6dzYVg/QXzdF2D7L23OBbXi7QqMEEE+V7FMGrOsTvKHIyjCPgjuJEoQi9
   5n0kxxJm84MtcNOUFRhBiEXeUy86NVrG2WYzuyFIqQ64wNtE8V7NfWTYD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="337855437"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="337855437"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 18:43:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="507471634"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Feb 2022 18:43:03 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLyfH-0001DU-9G; Mon, 21 Feb 2022 02:43:03 +0000
Date:   Mon, 21 Feb 2022 10:42:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [jic23-iio:testing 164/201] drivers/iio/adc/ab8500-gpadc.c:1201:67:
 error: macro "DEFINE_RUNTIME_DEV_PM_OPS" requires 4 arguments, but only 3
 given
Message-ID: <202202211004.q7F2574D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
head:   4c3bdc9c82a61368384e42c3c0100c32efa76262
commit: 23a133c1ba6796397da5bf8cad8640d136cf06d3 [164/201] iio:adc:ab8500: Switch from CONFIG_PM guards to pm_ptr() etc
config: arm-u8500_defconfig (https://download.01.org/0day-ci/archive/20220221/202202211004.q7F2574D-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=23a133c1ba6796397da5bf8cad8640d136cf06d3
        git remote add jic23-iio https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
        git fetch --no-tags jic23-iio testing
        git checkout 23a133c1ba6796397da5bf8cad8640d136cf06d3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iio/adc/ab8500-gpadc.c:1201:67: error: macro "DEFINE_RUNTIME_DEV_PM_OPS" requires 4 arguments, but only 3 given
    1201 |                                  ab8500_gpadc_runtime_resume, NULL);
         |                                                                   ^
   In file included from drivers/iio/adc/ab8500-gpadc.c:33:
   include/linux/pm_runtime.h:37: note: macro "DEFINE_RUNTIME_DEV_PM_OPS" defined here
      37 | #define DEFINE_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
         | 
>> drivers/iio/adc/ab8500-gpadc.c:1200:8: error: type defaults to 'int' in declaration of 'DEFINE_RUNTIME_DEV_PM_OPS' [-Werror=implicit-int]
    1200 | static DEFINE_RUNTIME_DEV_PM_OPS(ab8500_gpadc_runtime_suspend,
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/rcupdate.h:29,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/iio/iio.h:10,
                    from drivers/iio/adc/ab8500-gpadc.c:27:
>> drivers/iio/adc/ab8500-gpadc.c:1208:31: error: 'ab8500_gpadc_pm_ops' undeclared here (not in a function); did you mean 'ab8500_gpadc_probe'?
    1208 |                 .pm = pm_ptr(&ab8500_gpadc_pm_ops),
         |                               ^~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:57:44: note: in definition of macro 'PTR_IF'
      57 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   drivers/iio/adc/ab8500-gpadc.c:1208:23: note: in expansion of macro 'pm_ptr'
    1208 |                 .pm = pm_ptr(&ab8500_gpadc_pm_ops),
         |                       ^~~~~~
   drivers/iio/adc/ab8500-gpadc.c:1200:8: warning: 'DEFINE_RUNTIME_DEV_PM_OPS' defined but not used [-Wunused-variable]
    1200 | static DEFINE_RUNTIME_DEV_PM_OPS(ab8500_gpadc_runtime_suspend,
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/ab8500-gpadc.c:955:12: warning: 'ab8500_gpadc_runtime_resume' defined but not used [-Wunused-function]
     955 | static int ab8500_gpadc_runtime_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/ab8500-gpadc.c:945:12: warning: 'ab8500_gpadc_runtime_suspend' defined but not used [-Wunused-function]
     945 | static int ab8500_gpadc_runtime_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/DEFINE_RUNTIME_DEV_PM_OPS +1201 drivers/iio/adc/ab8500-gpadc.c

  1199	
> 1200	static DEFINE_RUNTIME_DEV_PM_OPS(ab8500_gpadc_runtime_suspend,
> 1201					 ab8500_gpadc_runtime_resume, NULL);
  1202	
  1203	static struct platform_driver ab8500_gpadc_driver = {
  1204		.probe = ab8500_gpadc_probe,
  1205		.remove = ab8500_gpadc_remove,
  1206		.driver = {
  1207			.name = "ab8500-gpadc",
> 1208			.pm = pm_ptr(&ab8500_gpadc_pm_ops),

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

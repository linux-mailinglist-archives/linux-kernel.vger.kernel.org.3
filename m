Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553634884C4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 18:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbiAHRCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 12:02:05 -0500
Received: from mga01.intel.com ([192.55.52.88]:36539 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232235AbiAHRCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641661323; x=1673197323;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TcYzdRPhQ+m3PxKtqutXrOivaHHD8Ara1TjaCG1JcxI=;
  b=GlQ1xOsCqvW03/0Kb4ti/nfvidNxRqpL8DFHjhrEVBUsvXnc3StH+2Kt
   c/PzpUg8dZ4EQtCxx6pGKACGrOni+aRRTcyK6l1562kCglhxNPNXZ4og/
   e9us6Dq12QgtMk1TZSah4dx3CIv7OuXIWl8dM5bqJ1FhN39VKAmDeJRTz
   qVxQcJ/Xb9ALWLU+YbR4TdPHdvNQPqkD0lxM92ADv1Cpw0D8A6EzmitTD
   4DES1z1cTcZI+y53aNVx+1JBzq2dVuRbC25GFu/DgVBAIvPq93I85nE7y
   K0wpghsfNmagw6I+zQC69eWCbhfv5FdAYMowV5k4RNsqYJtWAa1Bb73DW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="267343327"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="267343327"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 09:02:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="471629828"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Jan 2022 09:02:01 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6F6P-0000q9-3e; Sat, 08 Jan 2022 17:02:01 +0000
Date:   Sun, 9 Jan 2022 01:01:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2373/2375]
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4460:1: warning: data definition
 has no type or storage class
Message-ID: <202201090037.nahE66F3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   351ceeab2ef96ab2fc306934ddb201b44636181b
commit: 13920d67d91106f4681f468a6c01d404e1924739 [2373/2375] headers/deps: RDMA: Optimize <rdma/ib_verbs.h> dependencies, remove <linux/dim.h> inclusion
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20220109/202201090037.nahE66F3-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=13920d67d91106f4681f468a6c01d404e1924739
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 13920d67d91106f4681f468a6c01d404e1924739
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash drivers/infiniband/hw/hns/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4460:1: warning: data definition has no type or storage class
    4460 | MODULE_DEVICE_TABLE(of, hns_roce_of_match);
         | ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4460:1: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE' [-Werror=implicit-int]
>> drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4460:1: warning: parameter names (without types) in function declaration
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4466:1: warning: data definition has no type or storage class
    4466 | MODULE_DEVICE_TABLE(acpi, hns_roce_acpi_match);
         | ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4466:1: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE' [-Werror=implicit-int]
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4466:1: warning: parameter names (without types) in function declaration
   In file included from include/linux/device_api.h:34,
                    from drivers/infiniband/hw/hns/hns_roce_hw_v1.c:46:
   include/linux/device/driver.h:164:1: warning: data definition has no type or storage class
     164 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/platform_device.h:253:9: note: in expansion of macro 'module_driver'
     253 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4686:1: note: in expansion of macro 'module_platform_driver'
    4686 | module_platform_driver(hns_roce_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/device/driver.h:164:1: error: type defaults to 'int' in declaration of 'module_init' [-Werror=implicit-int]
     164 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/platform_device.h:253:9: note: in expansion of macro 'module_driver'
     253 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4686:1: note: in expansion of macro 'module_platform_driver'
    4686 | module_platform_driver(hns_roce_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/printk.h:7,
                    from include/asm-generic/bug.h:22,
                    from arch/sparc/include/asm/bug.h:25,
                    from include/linux/bug.h:5,
                    from include/linux/cpumask_types.h:12,
                    from include/linux/cpumask.h:5,
                    from include/linux/smp_api.h:12,
                    from include/linux/lockdep_api.h:27,
                    from include/linux/timer.h:5,
                    from include/linux/workqueue_types.h:9,
                    from include/linux/workqueue_api.h:10,
                    from drivers/infiniband/hw/hns/hns_roce_hw_v1.c:33:
   include/linux/export.h:19:30: warning: parameter names (without types) in function declaration
      19 | #define THIS_MODULE ((struct module *)0)
         |                              ^~~~~~
   include/linux/platform_device.h:223:41: note: in expansion of macro 'THIS_MODULE'
     223 |         __platform_driver_register(drv, THIS_MODULE)
         |                                         ^~~~~~~~~~~
   include/linux/device/driver.h:162:16: note: in expansion of macro 'platform_driver_register'
     162 |         return __register(&(__driver) , ##__VA_ARGS__); \
         |                ^~~~~~~~~~
   include/linux/platform_device.h:253:9: note: in expansion of macro 'module_driver'
     253 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4686:1: note: in expansion of macro 'module_platform_driver'
    4686 | module_platform_driver(hns_roce_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/device_api.h:34,
                    from drivers/infiniband/hw/hns/hns_roce_hw_v1.c:46:
   include/linux/device/driver.h:169:1: warning: data definition has no type or storage class
     169 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/platform_device.h:253:9: note: in expansion of macro 'module_driver'
     253 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4686:1: note: in expansion of macro 'module_platform_driver'
    4686 | module_platform_driver(hns_roce_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/device/driver.h:169:1: error: type defaults to 'int' in declaration of 'module_exit' [-Werror=implicit-int]
     169 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/platform_device.h:253:9: note: in expansion of macro 'module_driver'
     253 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4686:1: note: in expansion of macro 'module_platform_driver'
    4686 | module_platform_driver(hns_roce_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/printk.h:7,
                    from include/asm-generic/bug.h:22,
                    from arch/sparc/include/asm/bug.h:25,
                    from include/linux/bug.h:5,
                    from include/linux/cpumask_types.h:12,
                    from include/linux/cpumask.h:5,
                    from include/linux/smp_api.h:12,
                    from include/linux/lockdep_api.h:27,
                    from include/linux/timer.h:5,
                    from include/linux/workqueue_types.h:9,
                    from include/linux/workqueue_api.h:10,
                    from drivers/infiniband/hw/hns/hns_roce_hw_v1.c:33:
   include/linux/export.h:19:30: warning: parameter names (without types) in function declaration
      19 | #define THIS_MODULE ((struct module *)0)
         |                              ^~~~~~
   include/linux/platform_device.h:223:41: note: in expansion of macro 'THIS_MODULE'
     223 |         __platform_driver_register(drv, THIS_MODULE)
         |                                         ^~~~~~~~~~~
   include/linux/device/driver.h:162:16: note: in expansion of macro 'platform_driver_register'
     162 |         return __register(&(__driver) , ##__VA_ARGS__); \
         |                ^~~~~~~~~~
   include/linux/platform_device.h:253:9: note: in expansion of macro 'module_driver'
     253 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4686:1: note: in expansion of macro 'module_platform_driver'
    4686 | module_platform_driver(hns_roce_driver);


vim +4460 drivers/infiniband/hw/hns/hns_roce_hw_v1.c

08805fdbeb2d93 Wei Hu(Xavier  2017-08-30  4455) 
08805fdbeb2d93 Wei Hu(Xavier  2017-08-30  4456) static const struct of_device_id hns_roce_of_match[] = {
08805fdbeb2d93 Wei Hu(Xavier  2017-08-30  4457) 	{ .compatible = "hisilicon,hns-roce-v1", .data = &hns_roce_hw_v1, },
08805fdbeb2d93 Wei Hu(Xavier  2017-08-30  4458) 	{},
08805fdbeb2d93 Wei Hu(Xavier  2017-08-30  4459) };
08805fdbeb2d93 Wei Hu(Xavier  2017-08-30 @4460) MODULE_DEVICE_TABLE(of, hns_roce_of_match);
08805fdbeb2d93 Wei Hu(Xavier  2017-08-30  4461) 

:::::: The code at line 4460 was first introduced by commit
:::::: 08805fdbeb2d9300c09e681793518fb4da522235 RDMA/hns: Split hw v1 driver from hns roce driver

:::::: TO: Wei Hu(Xavier) <xavier.huwei@huawei.com>
:::::: CC: Doug Ledford <dledford@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

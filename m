Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADBC48FA7F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 04:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiAPDiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 22:38:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:55336 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234187AbiAPDit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 22:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642304329; x=1673840329;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=phrOKcCqfYve7ZCYItOLCqXt88tXVS0EGXgvgLblJNk=;
  b=GEnuF7pdnmxiOOmbROJlgcIGdGCVTC7jPya87WMgLtzqP276VVKNcmCH
   C/CWGp0iUnsqUMd/XsVwpFERkMVjaeW2+DozAFJbf7LLWrRydBEPyGCNA
   LeqGnSnvq7dIxRKRPYJDpPcN4z/ismr5ognNFdFTERuq+i4r2RgKno4if
   Mdu6RU7vfMKTNyFjia6cEltMPlMor5cs5tKhxK8UEzv6j2acJahHnDJkY
   oX3s22LjQNfDkHKjTQR/sFmnldtnfyeEPR3gk8pCG1Aw6bZ9SQ5LjYBYT
   VhJNEy5kRBWKi1iIF2YBsblFbs+Qoer4QVsn3WAVi2eZ3Um7jhGdBiplX
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="225140306"
X-IronPort-AV: E=Sophos;i="5.88,292,1635231600"; 
   d="scan'208";a="225140306"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 19:38:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,292,1635231600"; 
   d="scan'208";a="474074595"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 15 Jan 2022 19:38:47 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8wNS-000AQd-S7; Sun, 16 Jan 2022 03:38:46 +0000
Date:   Sun, 16 Jan 2022 11:37:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2375/2384]
 include/linux/device/driver.h:164:1: error: type defaults to 'int' in
 declaration of 'module_init'
Message-ID: <202201160854.9JuTmAwF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: fbd3e447670c4087ece6324134c77241b9c119b9 [2375/2384] headers/deps: RDMA: Optimize <rdma/ib_verbs.h> dependencies, remove <linux/dim.h> inclusion
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20220116/202201160854.9JuTmAwF-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=fbd3e447670c4087ece6324134c77241b9c119b9
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout fbd3e447670c4087ece6324134c77241b9c119b9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4460:1: warning: data definition has no type or storage class
    4460 | MODULE_DEVICE_TABLE(of, hns_roce_of_match);
         | ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4460:1: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE' [-Werror=implicit-int]
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4460:1: warning: parameter names (without types) in function declaration
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
>> include/linux/device/driver.h:164:1: error: type defaults to 'int' in declaration of 'module_init' [-Werror=implicit-int]
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
>> include/linux/device/driver.h:169:1: error: type defaults to 'int' in declaration of 'module_exit' [-Werror=implicit-int]
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
         | ^~~~~~~~~~~~~~~~~~~~~~
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4688:16: error: expected declaration specifiers or '...' before string constant
    4688 | MODULE_LICENSE("Dual BSD/GPL");
         |                ^~~~~~~~~~~~~~
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4689:15: error: expected declaration specifiers or '...' before string constant
    4689 | MODULE_AUTHOR("Wei Hu <xavier.huwei@huawei.com>");
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4690:15: error: expected declaration specifiers or '...' before string constant
    4690 | MODULE_AUTHOR("Nenglong Zhao <zhaonenglong@hisilicon.com>");
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4691:15: error: expected declaration specifiers or '...' before string constant
    4691 | MODULE_AUTHOR("Lijun Ou <oulijun@huawei.com>");
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4692:20: error: expected declaration specifiers or '...' before string constant
    4692 | MODULE_DESCRIPTION("Hisilicon Hip06 Family RoCE Driver");
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/device_api.h:34,
                    from drivers/infiniband/hw/hns/hns_roce_hw_v1.c:46:
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4686:24: warning: 'hns_roce_driver_init' defined but not used [-Wunused-function]
    4686 | module_platform_driver(hns_roce_driver);
         |                        ^~~~~~~~~~~~~~~
   include/linux/device/driver.h:160:19: note: in definition of macro 'module_driver'
     160 | static int __init __driver##_init(void) \
         |                   ^~~~~~~~
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:4686:1: note: in expansion of macro 'module_platform_driver'
    4686 | module_platform_driver(hns_roce_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +164 include/linux/device/driver.h

4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  144  
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  145  /**
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  146   * module_driver() - Helper macro for drivers that don't do anything
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  147   * special in module init/exit. This eliminates a lot of boilerplate.
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  148   * Each module may only use this macro once, and calling it replaces
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  149   * module_init() and module_exit().
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  150   *
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  151   * @__driver: driver name
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  152   * @__register: register function for this driver type
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  153   * @__unregister: unregister function for this driver type
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  154   * @...: Additional arguments to be passed to __register and __unregister.
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  155   *
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  156   * Use this macro to construct bus specific macros for registering
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  157   * drivers, and do not use it on its own.
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  158   */
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  159  #define module_driver(__driver, __register, __unregister, ...) \
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  160  static int __init __driver##_init(void) \
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  161  { \
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  162  	return __register(&(__driver) , ##__VA_ARGS__); \
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  163  } \
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09 @164  module_init(__driver##_init); \
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  165  static void __exit __driver##_exit(void) \
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  166  { \
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  167  	__unregister(&(__driver) , ##__VA_ARGS__); \
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  168  } \
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09 @169  module_exit(__driver##_exit);
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  170  

:::::: The code at line 164 was first introduced by commit
:::::: 4c002c978b7f2f2306d53de051c054504af920a9 device.h: move 'struct driver' stuff out to device/driver.h

:::::: TO: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

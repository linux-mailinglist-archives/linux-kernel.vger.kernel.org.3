Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C514C1F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241342AbiBWXCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBWXCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:02:24 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C268B56220
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 15:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645657313; x=1677193313;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5HSSNd4mtTUdEpQppF1l9Vz/nE3wtEyXw/5HISx0YM8=;
  b=WZSMVD965GksbbKADu0tZv2vwq3qnHQ1nngvvTRiYZ8+cEfGzz4YRcYR
   PokN1Wj9BJ0ZRmzmkaqRdRB7unBBGs/0lplz3gtttxDpCz4L13kOeKE9G
   aUbelwwbUOZ1I3yQSPlZlhR6TLLnqK+nBrohh4wmhNEotwBrUuDg75DX7
   Mg7Hzd/c0+BUHzPdq/57G0L0mKhWBKzthl3qgVcjUHmL2cEubS/Xra//G
   sYkjtTB0pzoHghv5b1w0jaxFevwBXCFaeUNGSIX/6nuTNS7ZFbnwYumeK
   jVSglR9Eog/je8K4IZU9s2ZA3qf9VIcX42M+oLtcKFWo6gZFu5i/wZKpD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="235610545"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="235610545"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 15:01:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="607226335"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 Feb 2022 15:01:51 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN0dq-0001uv-NC; Wed, 23 Feb 2022 23:01:50 +0000
Date:   Thu, 24 Feb 2022 07:01:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2295/2340]
 include/linux/device/driver.h:191:1: warning: data definition has no type or
 storage class
Message-ID: <202202240638.032BHfiI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   97c5eeb4de3ad324ed2a4656b46465299cfd010a
commit: 35386c8cd35ff67eacebac84ab12ca7a39c2d488 [2295/2340] headers/deps: driver/core: Optimize <linux/device/driver.h> dependencies, remove <linux/module.h> inclusion
config: mips-xway_defconfig (https://download.01.org/0day-ci/archive/20220224/202202240638.032BHfiI-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=35386c8cd35ff67eacebac84ab12ca7a39c2d488
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 35386c8cd35ff67eacebac84ab12ca7a39c2d488
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/lantiq/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h:12,
                    from arch/mips/lantiq/xway/dcdc.c:12:
   arch/mips/lantiq/xway/dcdc.c: In function 'dcdc_probe':
   arch/mips/include/asm/mach-lantiq/lantiq.h:18:33: error: implicit declaration of function '__raw_readb'; did you mean '__raw_emt'? [-Werror=implicit-function-declaration]
      18 | #define ltq_r8(reg)             __raw_readb(reg)
         |                                 ^~~~~~~~~~~
   arch/mips/lantiq/xway/dcdc.c:20:25: note: in expansion of macro 'ltq_r8'
      20 | #define dcdc_r8(x)      ltq_r8(dcdc_membase + (x))
         |                         ^~~~~~
   include/linux/dev_printk.h:114:37: note: in expansion of macro 'dcdc_r8'
     114 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                                     ^~~~~~~~~~~
   include/linux/dev_printk.h:154:9: note: in expansion of macro 'dev_printk_index_wrap'
     154 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/lantiq/xway/dcdc.c:33:9: note: in expansion of macro 'dev_info'
      33 |         dev_info(&pdev->dev, "Core Voltage : %d mV\n",
         |         ^~~~~~~~
   arch/mips/lantiq/xway/dcdc.c: At top level:
   arch/mips/lantiq/xway/dcdc.c:52:12: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'dcdc_init'
      52 | int __init dcdc_init(void)
         |            ^~~~~~~~~
>> arch/mips/lantiq/xway/dcdc.c:61:1: warning: data definition has no type or storage class
      61 | arch_initcall(dcdc_init);
         | ^~~~~~~~~~~~~
   arch/mips/lantiq/xway/dcdc.c:61:1: error: type defaults to 'int' in declaration of 'arch_initcall' [-Werror=implicit-int]
>> arch/mips/lantiq/xway/dcdc.c:61:1: warning: parameter names (without types) in function declaration
   arch/mips/lantiq/xway/dcdc.c:44:31: warning: 'dcdc_driver' defined but not used [-Wunused-variable]
      44 | static struct platform_driver dcdc_driver = {
         |                               ^~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   arch/mips/lantiq/xway/vmmc.c:16:15: warning: no previous prototype for 'ltq_get_cp1_base' [-Wmissing-prototypes]
      16 | unsigned int *ltq_get_cp1_base(void)
         |               ^~~~~~~~~~~~~~~~
   In file included from include/linux/platform_device.h:14,
                    from include/linux/of_device.h:7,
                    from include/linux/of_platform.h:12,
                    from arch/mips/lantiq/xway/vmmc.c:8:
   arch/mips/lantiq/xway/vmmc.c:64:25: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'vmmc_driver_init'
      64 | builtin_platform_driver(vmmc_driver);
         |                         ^~~~~~~~~~~
   include/linux/device/driver.h:187:19: note: in definition of macro 'builtin_driver'
     187 | static int __init __driver##_init(void) \
         |                   ^~~~~~~~
   arch/mips/lantiq/xway/vmmc.c:64:1: note: in expansion of macro 'builtin_platform_driver'
      64 | builtin_platform_driver(vmmc_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/device/driver.h:191:1: warning: data definition has no type or storage class
     191 | device_initcall(__driver##_init);
         | ^~~~~~~~~~~~~~~
   include/linux/platform_device.h:263:9: note: in expansion of macro 'builtin_driver'
     263 |         builtin_driver(__platform_driver, platform_driver_register)
         |         ^~~~~~~~~~~~~~
   arch/mips/lantiq/xway/vmmc.c:64:1: note: in expansion of macro 'builtin_platform_driver'
      64 | builtin_platform_driver(vmmc_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/device/driver.h:191:1: error: type defaults to 'int' in declaration of 'device_initcall' [-Werror=implicit-int]
     191 | device_initcall(__driver##_init);
         | ^~~~~~~~~~~~~~~
   include/linux/platform_device.h:263:9: note: in expansion of macro 'builtin_driver'
     263 |         builtin_driver(__platform_driver, platform_driver_register)
         |         ^~~~~~~~~~~~~~
   arch/mips/lantiq/xway/vmmc.c:64:1: note: in expansion of macro 'builtin_platform_driver'
      64 | builtin_platform_driver(vmmc_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> arch/mips/lantiq/xway/vmmc.c:64:25: warning: parameter names (without types) in function declaration
      64 | builtin_platform_driver(vmmc_driver);
         |                         ^~~~~~~~~~~
   include/linux/device/driver.h:187:19: note: in definition of macro 'builtin_driver'
     187 | static int __init __driver##_init(void) \
         |                   ^~~~~~~~
   arch/mips/lantiq/xway/vmmc.c:64:1: note: in expansion of macro 'builtin_platform_driver'
      64 | builtin_platform_driver(vmmc_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/lantiq/xway/vmmc.c:57:31: warning: 'vmmc_driver' defined but not used [-Wunused-variable]
      57 | static struct platform_driver vmmc_driver = {
         |                               ^~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +191 include/linux/device/driver.h

4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  170  
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  171  /**
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  172   * builtin_driver() - Helper macro for drivers that don't do anything
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  173   * special in init and have no exit. This eliminates some boilerplate.
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  174   * Each driver may only use this macro once, and calling it replaces
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  175   * device_initcall (or in some cases, the legacy __initcall).  This is
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  176   * meant to be a direct parallel of module_driver() above but without
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  177   * the __exit stuff that is not used for builtin cases.
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  178   *
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  179   * @__driver: driver name
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  180   * @__register: register function for this driver type
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  181   * @...: Additional arguments to be passed to __register
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  182   *
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  183   * Use this macro to construct bus specific macros for registering
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  184   * drivers, and do not use it on its own.
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  185   */
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  186  #define builtin_driver(__driver, __register, ...) \
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  187  static int __init __driver##_init(void) \
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  188  { \
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  189  	return __register(&(__driver) , ##__VA_ARGS__); \
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  190  } \
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09 @191  device_initcall(__driver##_init);
4c002c978b7f2f Greg Kroah-Hartman 2019-12-09  192  

:::::: The code at line 191 was first introduced by commit
:::::: 4c002c978b7f2f2306d53de051c054504af920a9 device.h: move 'struct driver' stuff out to device/driver.h

:::::: TO: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

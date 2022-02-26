Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB60A4C54AD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 09:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiBZIt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 03:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBZItZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 03:49:25 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2288B5AA53
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 00:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645865331; x=1677401331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dMZMfS1FoJnf3JBqN/cwNb6FK2yldhHv3Np9wbNaAH0=;
  b=evOqVEIX4RWW1HFoD+RglZ27cATrm7qzelaZJOVhaUVHkQnmPM6rB3UM
   doPJSAAup/cV7wYA52+RoIirQUeJY5WXAPiqiYv4wZ9R8z1F1PL4Zg5rN
   a1R898xvKKTEBjzeX7ROPzZ6hs3Dn1uOMEqCnZSyRV3gQxtMShqeCklAY
   OgRg5Wyj1YCKBXgZIy6K3xa6/Q4OFZBkxU4Gja5l4UxQsqRlhmm5+caNd
   2lFTJ+TRkylbcYPCalJ4t2BYkTBK234bdR2fnomNbErDwVIALhF2R+mkO
   DFWd8nev7U8/Qo/kU0NAQpQqWsxJxOsfkJg8lH/eJ7WPovr1YxxLj4mb0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="252837749"
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="252837749"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 00:48:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="608001593"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 26 Feb 2022 00:48:45 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNsku-0005Jm-W3; Sat, 26 Feb 2022 08:48:45 +0000
Date:   Sat, 26 Feb 2022 16:48:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yusuf Khan <yusisamerican@gmail.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, jasowang@redhat.com,
        mikelley@microsoft.com, mst@redhat.com, gregkh@linuxfoundation.org,
        javier@javigon.com, arnd@arndb.de, will@kernel.org,
        axboe@kernel.dk, bjorn.andersson@linaro.org,
        Yusuf Khan <yusisamerican@gmail.com>
Subject: Re: [PATCH v2] drivers: ddcci: upstream DDCCI driver
Message-ID: <202202261644.hcY0BU0k-lkp@intel.com>
References: <20220226040429.1035368-1-yusisamerican@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226040429.1035368-1-yusisamerican@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yusuf,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on staging/staging-testing linus/master v5.17-rc5]
[cannot apply to next-20220225]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Yusuf-Khan/drivers-ddcci-upstream-DDCCI-driver/20220226-120531
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2c271fe77d52a0555161926c232cd5bc07178b39
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220226/202202261644.hcY0BU0k-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7eb8029b70584acc0e9ce82dfdcff13c5496f544
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Yusuf-Khan/drivers-ddcci-upstream-DDCCI-driver/20220226-120531
        git checkout 7eb8029b70584acc0e9ce82dfdcff13c5496f544
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/ddcci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/ddcci/ddcci.c: In function 'ddcci_modalias_clean':
>> drivers/ddcci/ddcci.c:76:17: error: expected '}' before 'else'
      76 |                 else if (c < '0' || (c > '9' && c < 'A') || (c > 'Z' && c < 'a') || c > 'z')
         |                 ^~~~
--
   drivers/ddcci/ddcci-backlight.c: In function 'ddcci_monitor_next_vcp_item':
>> drivers/ddcci/ddcci-backlight.c:168:17: error: expected '}' before 'else'
     168 |                 else if (depth > 0) {
         |                 ^~~~
>> drivers/ddcci/ddcci-backlight.c:186:13: error: invalid storage class for function 'ddcci_monitor_find_vcp'
     186 | static bool ddcci_monitor_find_vcp(unsigned char vcp, const char *s)
         |             ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/ddcci/ddcci-backlight.c:186:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     186 | static bool ddcci_monitor_find_vcp(unsigned char vcp, const char *s)
         | ^~~~~~
>> drivers/ddcci/ddcci-backlight.c:212:12: error: invalid storage class for function 'ddcci_backlight_create_symlink'
     212 | static int ddcci_backlight_create_symlink(struct ddcci_device *ddcci_dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/ddcci/ddcci-backlight.c:240:12: error: invalid storage class for function 'ddcci_backlight_remove_symlink'
     240 | static int ddcci_backlight_remove_symlink(struct ddcci_device *ddcci_dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/ddcci/ddcci-backlight.c:274:12: error: invalid storage class for function 'ddcci_monitor_probe'
     274 | static int ddcci_monitor_probe(struct ddcci_device *dev,
         |            ^~~~~~~~~~~~~~~~~~~
>> drivers/ddcci/ddcci-backlight.c:377:12: error: invalid storage class for function 'ddcci_monitor_remove'
     377 | static int ddcci_monitor_remove(struct ddcci_device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~
>> drivers/ddcci/ddcci-backlight.c:396:27: error: initializer element is not constant
     396 |         .probe          = ddcci_monitor_probe,
         |                           ^~~~~~~~~~~~~~~~~~~
   drivers/ddcci/ddcci-backlight.c:396:27: note: (near initialization for 'ddcci_backlight_driver.probe')
   drivers/ddcci/ddcci-backlight.c:397:27: error: initializer element is not constant
     397 |         .remove         = ddcci_monitor_remove,
         |                           ^~~~~~~~~~~~~~~~~~~~
   drivers/ddcci/ddcci-backlight.c:397:27: note: (near initialization for 'ddcci_backlight_driver.remove')
   In file included from include/linux/device.h:32,
                    from include/linux/backlight.h:12,
                    from drivers/ddcci/ddcci-backlight.c:16:
>> drivers/ddcci/ddcci-backlight.c:400:21: error: invalid storage class for function 'ddcci_backlight_driver_init'
     400 | module_ddcci_driver(ddcci_backlight_driver);
         |                     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/device/driver.h:260:19: note: in definition of macro 'module_driver'
     260 | static int __init __driver##_init(void) \
         |                   ^~~~~~~~
   drivers/ddcci/ddcci-backlight.c:400:1: note: in expansion of macro 'module_ddcci_driver'
     400 | module_ddcci_driver(ddcci_backlight_driver);
         | ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/backlight.h:12,
                    from drivers/ddcci/ddcci-backlight.c:16:
>> include/linux/module.h:131:49: error: invalid storage class for function '__inittest'
     131 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/device/driver.h:264:1: note: in expansion of macro 'module_init'
     264 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/ddcci.h:138:9: note: in expansion of macro 'module_driver'
     138 |         module_driver(__ddcci_driver, ddcci_add_driver, \
         |         ^~~~~~~~~~~~~
   drivers/ddcci/ddcci-backlight.c:400:1: note: in expansion of macro 'module_ddcci_driver'
     400 | module_ddcci_driver(ddcci_backlight_driver);
         | ^~~~~~~~~~~~~~~~~~~
>> drivers/ddcci/ddcci-backlight.c:400:1: warning: 'alias' attribute ignored [-Wattributes]
   In file included from include/linux/device.h:32,
                    from include/linux/backlight.h:12,
                    from drivers/ddcci/ddcci-backlight.c:16:
>> drivers/ddcci/ddcci-backlight.c:400:21: error: invalid storage class for function 'ddcci_backlight_driver_exit'
     400 | module_ddcci_driver(ddcci_backlight_driver);
         |                     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/device/driver.h:265:20: note: in definition of macro 'module_driver'
     265 | static void __exit __driver##_exit(void) \
         |                    ^~~~~~~~
   drivers/ddcci/ddcci-backlight.c:400:1: note: in expansion of macro 'module_ddcci_driver'
     400 | module_ddcci_driver(ddcci_backlight_driver);
         | ^~~~~~~~~~~~~~~~~~~
>> include/linux/device/driver.h:265:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     265 | static void __exit __driver##_exit(void) \
         | ^~~~~~
   include/linux/ddcci.h:138:9: note: in expansion of macro 'module_driver'
     138 |         module_driver(__ddcci_driver, ddcci_add_driver, \
         |         ^~~~~~~~~~~~~
   drivers/ddcci/ddcci-backlight.c:400:1: note: in expansion of macro 'module_ddcci_driver'
     400 | module_ddcci_driver(ddcci_backlight_driver);
         | ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/backlight.h:12,
                    from drivers/ddcci/ddcci-backlight.c:16:
>> include/linux/module.h:139:49: error: invalid storage class for function '__exittest'
     139 |         static inline exitcall_t __maybe_unused __exittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/device/driver.h:269:1: note: in expansion of macro 'module_exit'
     269 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/ddcci.h:138:9: note: in expansion of macro 'module_driver'
     138 |         module_driver(__ddcci_driver, ddcci_add_driver, \
         |         ^~~~~~~~~~~~~
   drivers/ddcci/ddcci-backlight.c:400:1: note: in expansion of macro 'module_ddcci_driver'
     400 | module_ddcci_driver(ddcci_backlight_driver);
         | ^~~~~~~~~~~~~~~~~~~
>> drivers/ddcci/ddcci-backlight.c:400:1: warning: 'alias' attribute ignored [-Wattributes]
   In file included from include/linux/module.h:22,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/backlight.h:12,
                    from drivers/ddcci/ddcci-backlight.c:16:
>> include/linux/moduleparam.h:409:45: error: invalid storage class for function '__check_convenience_symlink'
     409 |         static inline type __always_unused *__check_##name(void) { return(p); }
         |                                             ^~~~~~~~
   include/linux/moduleparam.h:468:35: note: in expansion of macro '__param_check'
     468 | #define param_check_bool(name, p) __param_check(name, p, bool)
         |                                   ^~~~~~~~~~~~~
   include/linux/moduleparam.h:150:9: note: in expansion of macro 'param_check_bool'
     150 |         param_check_##type(name, &(value));                                \
         |         ^~~~~~~~~~~~
   include/linux/moduleparam.h:127:9: note: in expansion of macro 'module_param_named'
     127 |         module_param_named(name, name, type, perm)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/ddcci/ddcci-backlight.c:403:1: note: in expansion of macro 'module_param'
     403 | module_param(convenience_symlink, bool, 0644);
         | ^~~~~~~~~~~~
   include/linux/moduleparam.h:409:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     409 |         static inline type __always_unused *__check_##name(void) { return(p); }
         |         ^~~~~~
   include/linux/moduleparam.h:468:35: note: in expansion of macro '__param_check'
     468 | #define param_check_bool(name, p) __param_check(name, p, bool)
         |                                   ^~~~~~~~~~~~~
   include/linux/moduleparam.h:150:9: note: in expansion of macro 'param_check_bool'
     150 |         param_check_##type(name, &(value));                                \
         |         ^~~~~~~~~~~~
   include/linux/moduleparam.h:127:9: note: in expansion of macro 'module_param_named'
     127 |         module_param_named(name, name, type, perm)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/ddcci/ddcci-backlight.c:403:1: note: in expansion of macro 'module_param'
     403 | module_param(convenience_symlink, bool, 0644);
         | ^~~~~~~~~~~~
   include/linux/moduleparam.h:289:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     289 |         static const char __param_str_##name[] = prefix #name;          \
         |         ^~~~~~
   include/linux/moduleparam.h:176:9: note: in expansion of macro '__module_param_call'
     176 |         __module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   include/linux/moduleparam.h:127:9: note: in expansion of macro 'module_param_named'
     127 |         module_param_named(name, name, type, perm)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/ddcci/ddcci-backlight.c:403:1: note: in expansion of macro 'module_param'
     403 | module_param(convenience_symlink, bool, 0644);
         | ^~~~~~~~~~~~
>> drivers/ddcci/ddcci-backlight.c:411:1: error: expected declaration or statement at end of input
     411 | MODULE_ALIAS("ddcci:monitor-*-*-*-*");
         | ^~~~~~~~~~~~


vim +76 drivers/ddcci/ddcci.c

    65	
    66	/* Replace non-alphanumeric characters in a string (used for modalias) */
    67	static void ddcci_modalias_clean(char *string, size_t n, char replacement)
    68	{
    69		int i;
    70	
    71		for (i = 0; i < n; ++i) {
    72			char c = string[i];
    73	
    74			if (c == 0) {
    75				return;
  > 76			else if (c < '0' || (c > '9' && c < 'A') || (c > 'Z' && c < 'a') || c > 'z')
    77				string[i] = replacement;
    78		}
    79	}
    80	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

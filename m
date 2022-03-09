Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014B04D2DBE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiCILQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiCILQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:16:06 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ED413CEC0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646824507; x=1678360507;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Utk9SS6PsR9Xvg1e/hmDcvs9nDjDFfgM3k6h4tERtw0=;
  b=a6Dd3lRk80RGAlS9bz/9PeJpPmblNyvGD++2PYqlpHQgHMtKqkYHcwXX
   +6sG3/b6okJQMMQsaSf5yzbGXM3AVqqgR8mAmlybRxFx9RndyVQZctKxy
   cqSDPz35N0Q9ghEglAORRTnBwlgVEN0aR/Il2gst7iPFHoGwz2dbW2DBd
   OacMeFE5uuGirJzK52QQd1W+3lldxfK+EYedGXqBQs8YhHZejEOWgfcZe
   aeXEnjHU/iVkIj/DPC3jqGWOa10vQBeCx3Pzxv1krZO+y9LKBnjdiToW5
   81eDG7DnK2QSvhNUTxYrPlasKyi3Jnli2umNsbTtHhawdWsVP360xqW+k
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="341380429"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="341380429"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 03:15:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="596238218"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 09 Mar 2022 03:15:05 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRuHY-00039j-Qw; Wed, 09 Mar 2022 11:15:04 +0000
Date:   Wed, 9 Mar 2022 19:14:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/070-audio 13/15]
 drivers/clk/clk-apple-nco.c:139:16: error: implicit declaration of function
 'FIELD_PREP'
Message-ID: <202203091915.aH27LZEz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/070-audio
head:   1d99a1536d2dd3a0727f8cb942549073f0b3f055
commit: 1bf217d927e0f44f6f66173636f037e43acd065a [13/15] fixup! clk: clk-apple-nco: Add driver for Apple NCO
config: arc-buildonly-randconfig-r005-20220307 (https://download.01.org/0day-ci/archive/20220309/202203091915.aH27LZEz-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/1bf217d927e0f44f6f66173636f037e43acd065a
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/070-audio
        git checkout 1bf217d927e0f44f6f66173636f037e43acd065a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clk/clk-apple-nco.c: In function 'applnco_div_translate':
>> drivers/clk/clk-apple-nco.c:139:16: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     139 |         return FIELD_PREP(DIV_COARSE, tbl->fwd[coarse - COARSE_DIV_OFFSET]) |
         |                ^~~~~~~~~~
   drivers/clk/clk-apple-nco.c: In function 'applnco_div_translate_inv':
>> drivers/clk/clk-apple-nco.c:147:27: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
     147 |         coarse = tbl->inv[FIELD_GET(DIV_COARSE, regval)] + COARSE_DIV_OFFSET;
         |                           ^~~~~~~~~
   drivers/clk/clk-apple-nco.c: At top level:
   drivers/clk/clk-apple-nco.c:322:1: error: expected ',' or ';' before 'static'
     322 | static struct platform_driver applnco_driver = {
         | ^~~~~~
   In file included from drivers/clk/clk-apple-nco.c:16:
   drivers/clk/clk-apple-nco.c: In function 'applnco_driver_init':
   drivers/clk/clk-apple-nco.c:329:24: error: 'applnco_driver' undeclared (first use in this function); did you mean 'applnco_probe'?
     329 | module_platform_driver(applnco_driver);
         |                        ^~~~~~~~~~~~~~
   include/linux/platform_device.h:222:36: note: in definition of macro 'platform_driver_register'
     222 |         __platform_driver_register(drv, THIS_MODULE)
         |                                    ^~~
   include/linux/platform_device.h:252:9: note: in expansion of macro 'module_driver'
     252 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/clk/clk-apple-nco.c:329:1: note: in expansion of macro 'module_platform_driver'
     329 | module_platform_driver(applnco_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk-apple-nco.c:329:24: note: each undeclared identifier is reported only once for each function it appears in
     329 | module_platform_driver(applnco_driver);
         |                        ^~~~~~~~~~~~~~
   include/linux/platform_device.h:222:36: note: in definition of macro 'platform_driver_register'
     222 |         __platform_driver_register(drv, THIS_MODULE)
         |                                    ^~~
   include/linux/platform_device.h:252:9: note: in expansion of macro 'module_driver'
     252 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/clk/clk-apple-nco.c:329:1: note: in expansion of macro 'module_platform_driver'
     329 | module_platform_driver(applnco_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/device.h:32,
                    from include/linux/platform_device.h:13,
                    from drivers/clk/clk-apple-nco.c:16:
   drivers/clk/clk-apple-nco.c: In function 'applnco_driver_exit':
   drivers/clk/clk-apple-nco.c:329:24: error: 'applnco_driver' undeclared (first use in this function); did you mean 'applnco_probe'?
     329 | module_platform_driver(applnco_driver);
         |                        ^~~~~~~~~~~~~~
   include/linux/device/driver.h:267:24: note: in definition of macro 'module_driver'
     267 |         __unregister(&(__driver) , ##__VA_ARGS__); \
         |                        ^~~~~~~~
   drivers/clk/clk-apple-nco.c:329:1: note: in expansion of macro 'module_platform_driver'
     329 | module_platform_driver(applnco_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk-apple-nco.c: In function 'applnco_driver_init':
   include/linux/device/driver.h:263:1: error: control reaches end of non-void function [-Werror=return-type]
     263 | } \
         | ^
   include/linux/platform_device.h:252:9: note: in expansion of macro 'module_driver'
     252 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/clk/clk-apple-nco.c:329:1: note: in expansion of macro 'module_platform_driver'
     329 | module_platform_driver(applnco_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   At top level:
   drivers/clk/clk-apple-nco.c:254:12: warning: 'applnco_probe' defined but not used [-Wunused-function]
     254 | static int applnco_probe(struct platform_device *pdev)
         |            ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +139 drivers/clk/clk-apple-nco.c

4affca42511f75 Martin Povišer 2022-02-08  131  
4affca42511f75 Martin Povišer 2022-02-08  132  static u32 applnco_div_translate(struct applnco_tables *tbl, unsigned int div)
4affca42511f75 Martin Povišer 2022-02-08  133  {
4affca42511f75 Martin Povišer 2022-02-08  134  	unsigned int coarse = div / 4;
4affca42511f75 Martin Povišer 2022-02-08  135  
4affca42511f75 Martin Povišer 2022-02-08  136  	if (WARN_ON(applnco_div_out_of_range(div)))
4affca42511f75 Martin Povišer 2022-02-08  137  		return 0;
4affca42511f75 Martin Povišer 2022-02-08  138  
4affca42511f75 Martin Povišer 2022-02-08 @139  	return FIELD_PREP(DIV_COARSE, tbl->fwd[coarse - COARSE_DIV_OFFSET]) |
4affca42511f75 Martin Povišer 2022-02-08  140  			FIELD_PREP(DIV_FINE, div % 4);
4affca42511f75 Martin Povišer 2022-02-08  141  }
4affca42511f75 Martin Povišer 2022-02-08  142  
4affca42511f75 Martin Povišer 2022-02-08  143  static unsigned int applnco_div_translate_inv(struct applnco_tables *tbl, u32 regval)
4affca42511f75 Martin Povišer 2022-02-08  144  {
4affca42511f75 Martin Povišer 2022-02-08  145  	unsigned int coarse, fine;
4affca42511f75 Martin Povišer 2022-02-08  146  
4affca42511f75 Martin Povišer 2022-02-08 @147  	coarse = tbl->inv[FIELD_GET(DIV_COARSE, regval)] + COARSE_DIV_OFFSET;
4affca42511f75 Martin Povišer 2022-02-08  148  	fine = FIELD_GET(DIV_FINE, regval);
4affca42511f75 Martin Povišer 2022-02-08  149  
4affca42511f75 Martin Povišer 2022-02-08  150  	return coarse * 4 + fine;
4affca42511f75 Martin Povišer 2022-02-08  151  }
4affca42511f75 Martin Povišer 2022-02-08  152  

:::::: The code at line 139 was first introduced by commit
:::::: 4affca42511f7532ad7ce1a4b880e54d612f2d94 clk: clk-apple-nco: Add driver for Apple NCO

:::::: TO: Martin Povišer <povik+lin@cutebit.org>
:::::: CC: Hector Martin <marcan@marcan.st>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

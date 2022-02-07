Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223E84AC5A6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379839AbiBGQaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389646AbiBGQUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:20:34 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8818C0401D2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644250833; x=1675786833;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jGpVpvPyWERCA352dy7V5AUAApivyGrZIj/XPAMo5FU=;
  b=a4j6JFa8N+2qZZ2w/CbjwCKoNvWwz+weigKp+Tw8LJDOHvdYsC/NxW27
   PeRwXuOmv7gYkGpFAO4quciRUWmkCgsLpZajsm0dxf8/zTvdi5osms0TY
   njSDG7y5K8fSooVtr18S4vIXsMJeP3YiRpFNRmEX2GZY1pjuldWJco4Yn
   VTjEo/73KUwjhotkGfcLlob8MAJaGKof6xgTg3yfhbQkdOGxf5vqfYdUc
   FGGtYUX+WE4wU6EZOUYC0PfnlXDIauhmz4RU+PklxtKwF9Yg08Lq+PZUF
   N4GjDKQlcPna7L1gMT+JrgBeMpo+n0Ysz/vBb9C/cA9bdVNUF1MghW8y1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="228718255"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="228718255"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 08:19:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="484470056"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Feb 2022 08:19:43 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nH6ju-0000jI-QE; Mon, 07 Feb 2022 16:19:42 +0000
Date:   Tue, 8 Feb 2022 00:19:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:smc/work 9/18] include/linux/bits.h:35:29: warning: left
 shift count >= width of type
Message-ID: <202202080017.hd9ScSdU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux smc/work
head:   3dcf1f28dd3d0b36f11098cc61187986d00ee253
commit: 4dcb7038ce2579c3fe867685d0fdc3998958edc3 [9/18] platform/apple: Add new Apple Mac SMC driver
config: csky-allyesconfig (https://download.01.org/0day-ci/archive/20220208/202202080017.hd9ScSdU-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/4dcb7038ce2579c3fe867685d0fdc3998958edc3
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux smc/work
        git checkout 4dcb7038ce2579c3fe867685d0fdc3998958edc3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash drivers/clk/ drivers/dma/ drivers/platform/apple/ sound/soc/apple/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/platform/apple/smc_rtkit.c: In function 'apple_smc_cmd':
   drivers/platform/apple/smc_rtkit.c:69:16: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
      69 |         msg = (FIELD_PREP(SMC_MSG, cmd) |
         |                ^~~~~~~~~~
   In file included from include/linux/ratelimit_types.h:5,
                    from include/linux/ratelimit.h:5,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/platform/apple/smc_rtkit.c:8:
>> include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:41: note: in expansion of macro 'GENMASK'
      29 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:73:27: note: in expansion of macro 'SMC_DATA'
      73 |                FIELD_PREP(SMC_DATA, arg));
         |                           ^~~~~~~~
>> include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:41: note: in expansion of macro 'GENMASK'
      29 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:73:27: note: in expansion of macro 'SMC_DATA'
      73 |                FIELD_PREP(SMC_DATA, arg));
         |                           ^~~~~~~~
   drivers/platform/apple/smc_rtkit.c:85:13: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
      85 |         if (FIELD_GET(SMC_ID, smc->cmd_ret) != smc->msg_id) {
         |             ^~~~~~~~~
   In file included from include/linux/ratelimit_types.h:5,
                    from include/linux/ratelimit.h:5,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/platform/apple/smc_rtkit.c:8:
>> include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:41: note: in expansion of macro 'GENMASK'
      29 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:96:39: note: in expansion of macro 'SMC_DATA'
      96 |                 *ret_data = FIELD_GET(SMC_DATA, smc->cmd_ret);
         |                                       ^~~~~~~~
>> include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:41: note: in expansion of macro 'GENMASK'
      29 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:96:39: note: in expansion of macro 'SMC_DATA'
      96 |                 *ret_data = FIELD_GET(SMC_DATA, smc->cmd_ret);
         |                                       ^~~~~~~~
   cc1: some warnings being treated as errors


vim +35 include/linux/bits.h

295bcca84916cb5 Rikard Falkeborn 2020-04-06  33  
295bcca84916cb5 Rikard Falkeborn 2020-04-06  34  #define __GENMASK(h, l) \
95b980d62d52c4c Masahiro Yamada  2019-07-16 @35  	(((~UL(0)) - (UL(1) << (l)) + 1) & \
95b980d62d52c4c Masahiro Yamada  2019-07-16 @36  	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
295bcca84916cb5 Rikard Falkeborn 2020-04-06  37  #define GENMASK(h, l) \
295bcca84916cb5 Rikard Falkeborn 2020-04-06  38  	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
8bd9cb51daac893 Will Deacon      2018-06-19  39  

:::::: The code at line 35 was first introduced by commit
:::::: 95b980d62d52c4c1768ee719e8db3efe27ef52b2 linux/bits.h: make BIT(), GENMASK(), and friends available in assembly

:::::: TO: Masahiro Yamada <yamada.masahiro@socionext.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

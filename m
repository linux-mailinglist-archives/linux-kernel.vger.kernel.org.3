Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094DC4D5F7C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347882AbiCKK3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239701AbiCKK3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:29:50 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8956717F6BE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646994527; x=1678530527;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NhfIPSzwJXId8+VZdMKuXhPcehF31c0r3OdEixOdLnk=;
  b=Pp/DZhoRQlRKyQMxPFymk9FJ1AmkMGU0/IIznwWmemY1moKjRmF1vrhm
   8T3WnTUTxy5mxKCjOni1UIgaNoNB+Z5ws4hm/1r+bNh/+veiBWTpG5w3P
   qwt7abqvXrihhkLHc7vkesGZRsqbJO6xJhCwvjDTP9z3QEPmrspJEPkv9
   MJE8ZvvC5f4pSIwidGeCV1GIoWUiwClXKx8u7JG80GgVN3OHhuKPgos4U
   1JrXgIbxAQM+ud2aD9MmMSC+gtBfr87u0zwBo2ljtBQx2mXtp/h9p/1n0
   vcYJPA52a6Kx/ux72eGaYrHUmr8cQjv+xxhvq1zAbJFG+eKc64igph0ek
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="254375394"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="254375394"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 02:28:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="644891900"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Mar 2022 02:28:45 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nScVo-0006FX-W1; Fri, 11 Mar 2022 10:28:44 +0000
Date:   Fri, 11 Mar 2022 18:28:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.17-rc1 8/8]
 include/linux/kern_levels.h:5:25: warning: format '%x' expects argument of
 type 'unsigned int', but argument 2 has type 'long unsigned int'
Message-ID: <202203111841.1Q9NXFVF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.17-rc1
head:   66e9038ef48dc66c07b12443b73e2d1f3f12cbab
commit: 66e9038ef48dc66c07b12443b73e2d1f3f12cbab [8/8] KASAN horror
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220311/202203111841.1Q9NXFVF-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=66e9038ef48dc66c07b12443b73e2d1f3f12cbab
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.17-rc1
        git checkout 66e9038ef48dc66c07b12443b73e2d1f3f12cbab
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/arm/include/asm/bug.h:60,
                    from include/linux/bug.h:5,
                    from include/linux/kasan.h:5,
                    from arch/arm/mm/kasan_init.c:11:
   arch/arm/mm/kasan_init.c: In function 'kasan_init':
>> include/linux/kern_levels.h:5:25: warning: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'long unsigned int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:519:9: note: in expansion of macro 'printk'
     519 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:14:25: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/linux/printk.h:519:16: note: in expansion of macro 'KERN_INFO'
     519 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~
   arch/arm/mm/kasan_init.c:237:9: note: in expansion of macro 'pr_info'
     237 |         pr_info("clearing PGDs from %08x-%08x\n", KASAN_SHADOW_START, KASAN_SHADOW_END);
         |         ^~~~~~~
   include/linux/kern_levels.h:5:25: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:519:9: note: in expansion of macro 'printk'
     519 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:14:25: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/linux/printk.h:519:16: note: in expansion of macro 'KERN_INFO'
     519 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~
   arch/arm/mm/kasan_init.c:237:9: note: in expansion of macro 'pr_info'
     237 |         pr_info("clearing PGDs from %08x-%08x\n", KASAN_SHADOW_START, KASAN_SHADOW_END);
         |         ^~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

:::::: The code at line 5 was first introduced by commit
:::::: 04d2c8c83d0e3ac5f78aeede51babb3236200112 printk: convert the format for KERN_<LEVEL> to a 2 byte pattern

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

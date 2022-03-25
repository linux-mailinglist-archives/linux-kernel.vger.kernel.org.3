Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3054E6D59
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 05:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355153AbiCYElK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 00:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243070AbiCYElF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 00:41:05 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EB65F24C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 21:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648183171; x=1679719171;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B4UNeiimvHkiGX0TX7pHUeS94Z5SEfUqC5jUtfFxMYw=;
  b=aAjS5EXedzWragHJs8lEOMe12YIwVCTNonw5/2k4GxG3oJKJlws9ygeE
   +OmU8Vdm1ONuzZy3kzd/gMjyz899uw40UTnq9gxxZGvVLwtmf6Ahu6Te3
   U0hUOHf2SOv7ydUVFLLzTgahUDjkck+HATVVho1m5QJ5/4AR8kglmEI1s
   dRbrx5xO+2KWyBO4tRZdONoNiVTXm1dtUjY8iEaRExe9U6QreGYfO9lWP
   U6rR0mJcndeV0RHkvlBdjbDusx1cKl1WcXgVbFDaV6o6of3/G9D+whTh0
   hftMzepvWhmzDJy8hZGoxmJgpvSDPWrl04HXoIQQUbnVu8i+chgKcOBCA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="319260656"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="319260656"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 21:39:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="544932822"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 24 Mar 2022 21:39:29 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXbjU-000Lnb-SY; Fri, 25 Mar 2022 04:39:28 +0000
Date:   Fri, 25 Mar 2022 12:39:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [broonie-misc:for-kernelci 6/7] include/linux/kern_levels.h:5:25:
 warning: format '%d' expects argument of type 'int', but argument 2 has type
 'long unsigned int'
Message-ID: <202203251236.KA4YsYRe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git for-kernelci
head:   0265b10883453897a0ddcdbc21af5031ad5b4a7e
commit: 94c6c005fd4c9113c44acb727292f0acd1434a11 [6/7] TEST - MCLK SETTING
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220325/202203251236.KA4YsYRe-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git/commit/?id=94c6c005fd4c9113c44acb727292f0acd1434a11
        git remote add broonie-misc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git
        git fetch --no-tags broonie-misc for-kernelci
        git checkout 94c6c005fd4c9113c44acb727292f0acd1434a11
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/powerpc/include/asm/bug.h:149,
                    from include/linux/bug.h:5,
                    from arch/powerpc/include/asm/cmpxchg.h:8,
                    from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from sound/soc/codecs/wm8731.c:13:
   sound/soc/codecs/wm8731.c: In function 'wm8731_set_dai_sysclk':
>> include/linux/kern_levels.h:5:25: warning: format '%d' expects argument of type 'int', but argument 2 has type 'long unsigned int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:479:9: note: in expansion of macro 'printk'
     479 |         printk(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:10:25: note: in expansion of macro 'KERN_SOH'
      10 | #define KERN_CRIT       KERN_SOH "2"    /* critical conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:479:16: note: in expansion of macro 'KERN_CRIT'
     479 |         printk(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~
   sound/soc/codecs/wm8731.c:394:25: note: in expansion of macro 'pr_crit'
     394 |                         pr_crit("SET SYSCLK %d\n", clk_get_rate(wm8731->mclk));
         |                         ^~~~~~~
   sound/soc/codecs/wm8731.c: In function 'wm8731_i2c_probe':
>> include/linux/kern_levels.h:5:25: warning: format '%d' expects argument of type 'int', but argument 2 has type 'long unsigned int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:479:9: note: in expansion of macro 'printk'
     479 |         printk(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:10:25: note: in expansion of macro 'KERN_SOH'
      10 | #define KERN_CRIT       KERN_SOH "2"    /* critical conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:479:16: note: in expansion of macro 'KERN_CRIT'
     479 |         printk(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~
   sound/soc/codecs/wm8731.c:751:17: note: in expansion of macro 'pr_crit'
     751 |                 pr_crit("WM8731 MCLK IS %d\n", clk_get_rate(wm8731->mclk));
         |                 ^~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

:::::: The code at line 5 was first introduced by commit
:::::: 04d2c8c83d0e3ac5f78aeede51babb3236200112 printk: convert the format for KERN_<LEVEL> to a 2 byte pattern

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

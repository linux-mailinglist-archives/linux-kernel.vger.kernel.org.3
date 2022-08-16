Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585E9596521
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 00:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbiHPWII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 18:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiHPWIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 18:08:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD63473335
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 15:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660687684; x=1692223684;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r/NS3DQl1MQodpjLTUQmONt+iMp15to1k/iMUg+p9sA=;
  b=fDcLSOpZ2JGbakTYVy+RAeH0XS/ng23uJGHzUVWNdk27L35kwRahSk0p
   iw9ju4eCw4bSBLWBClg2+xI7+hsrcDF42kcAYzsk0TKHYLXRNQyl136EO
   wspMh9cYjACzP1S5CVdeC0CcZCFq3xZjLZzfxSrSiIet0pAh4tHj6IPUy
   Giplj7Wj+MN7brWa8CRi4JKZQh08iua5nfeTVGbNvWhmH1ktZI5YtV++d
   EuPCTKkB/70sSZb8BFLv/pwdaylhH5JJKZlLCX1dnjyuZ2PsTK6zhnd61
   D0t/LTToBez+ZN0QptRlsVTyket3UpYYXOyZpdrgrhVN2yvU2z55HGTOw
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="378631562"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="378631562"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 15:08:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="696540562"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Aug 2022 15:08:02 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO4jC-0000Gk-0h;
        Tue, 16 Aug 2022 22:08:02 +0000
Date:   Wed, 17 Aug 2022 06:07:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:tglx/devel/depthtracking 9/59]
 arch/x86/include/asm/linkage.h:20:3: error: #error Unsupported function
 alignment
Message-ID: <202208170630.b7YljGAi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/depthtracking
head:   9bbf33b92f4c755dd56f4d9bc1b40e94fdd1fff7
commit: bf8d55ad26e37b4ebef53eab531481e6e35d36a2 [9/59] x86/asm: Ensure proper function alignment
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220817/202208170630.b7YljGAi-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/bf8d55ad26e37b4ebef53eab531481e6e35d36a2
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tglx/devel/depthtracking
        git checkout bf8d55ad26e37b4ebef53eab531481e6e35d36a2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/um/user-offsets.c:17:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
      17 | void foo(void)
         |      ^~~
   In file included from include/linux/linkage.h:8,
                    from include/linux/printk.h:8,
                    from include/asm-generic/bug.h:22,
                    from ./arch/um/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   arch/x86/include/asm/linkage.h:15:5: warning: "CONFIG_FUNCTION_ALIGNMENT" is not defined, evaluates to 0 [-Wundef]
      15 | #if CONFIG_FUNCTION_ALIGNMENT == 8
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/linkage.h:17:7: warning: "CONFIG_FUNCTION_ALIGNMENT" is not defined, evaluates to 0 [-Wundef]
      17 | #elif CONFIG_FUNCTION_ALIGNMENT == 16
         |       ^~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/linkage.h:20:3: error: #error Unsupported function alignment
      20 | # error Unsupported function alignment
         |   ^~~~~
   In file included from include/linux/printk.h:8,
                    from include/asm-generic/bug.h:22,
                    from ./arch/um/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/linkage.h:73: warning: "__ALIGN_STR" redefined
      73 | #define __ALIGN_STR     ".align 4,0x90"
         | 
   In file included from include/linux/linkage.h:8,
                    from include/linux/printk.h:8,
                    from include/asm-generic/bug.h:22,
                    from ./arch/um/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   arch/x86/include/asm/linkage.h:23: note: this is the location of the previous definition
      23 | #define __ALIGN_STR             __stringify(__ALIGN)
         | 
   make[2]: *** [scripts/Makefile.build:117: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1207: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:222: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +20 arch/x86/include/asm/linkage.h

    14	
    15	#if CONFIG_FUNCTION_ALIGNMENT == 8
    16	#define __ALIGN			.p2align 3, 0x90;
    17	#elif CONFIG_FUNCTION_ALIGNMENT == 16
    18	#define __ALIGN			.p2align 4, 0x90;
    19	#else
  > 20	# error Unsupported function alignment
    21	#endif
    22	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

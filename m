Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422455764BE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 17:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbiGOPtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 11:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbiGOPtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 11:49:33 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E29F1583F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 08:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657900172; x=1689436172;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tMJM0gpoSjUX4klaDrEskeTxkKDpiAsTsQ/4ST94qrE=;
  b=RrWUt7migTCSoVRGh5yXmXwqBYDVBhnC9AEnwH59V/xkp21J4nLqtx7Y
   7ejLgtRBE4fly2jRtjubiX86T6Avg11UeyO3SWOk0FUs0W6jhn7avOpPT
   slI/XoXNEyV6qhIzGDLOVrUmfQnDVABwKIvqbGKMN/O/9591zn97ot/z2
   E0nNLGFTa2c476/YxyoowT/keG0PuUOrpofuyFSXYgFOLXlnce8YOqPAt
   uN1FrEDUG3y3fs9S7sVNiF2Xm/NKOxGpjA5eEdx/efeJxu5SJ08f7801w
   v2yRfYDM2uZtMAbu/ljmwhBbPlOpmjTlsOJ5/IKXVn2DVJeh1uJ1vIDuu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="265615124"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="265615124"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 08:49:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="686000927"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jul 2022 08:49:31 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCNZK-0000M7-DE;
        Fri, 15 Jul 2022 15:49:30 +0000
Date:   Fri, 15 Jul 2022 23:48:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.19-rc1 25/35]
 arch/mips/include/asm/io.h:114:27: error: conflicting types for
 'virt_to_phys'; have 'phys_addr_t(const volatile void *)' {aka 'long long
 unsigned int(const volatile void *)'}
Message-ID: <202207152323.Zu5bzaHS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.19-rc1
head:   144435741b0a6f31403d3084103678da3b4f9d11
commit: f9b8d36b54a1776051d8adb548924d14cbe57535 [25/35] MIPS: Make virt_to_pfn() a static inline
config: mips-bigsur_defconfig (https://download.01.org/0day-ci/archive/20220715/202207152323.Zu5bzaHS-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=f9b8d36b54a1776051d8adb548924d14cbe57535
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.19-rc1
        git checkout f9b8d36b54a1776051d8adb548924d14cbe57535
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/mips/include/asm/page.h:73,
                    from arch/mips/include/asm/io.h:29,
                    from include/linux/io.h:13,
                    from arch/mips/include/asm/mips-cps.h:11,
                    from arch/mips/include/asm/smp-ops.h:16,
                    from arch/mips/include/asm/smp.h:21,
                    from include/linux/smp.h:113,
                    from arch/mips/include/asm/cpu-type.h:12,
                    from arch/mips/include/asm/timex.h:19,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/compat.h:10,
                    from arch/mips/kernel/asm-offsets.c:12:
   arch/mips/include/asm/page.h: In function 'virt_to_pfn':
   arch/mips/include/asm/page.h:262:40: error: implicit declaration of function 'virt_to_phys'; did you mean 'virt_to_pfn'? [-Werror=implicit-function-declaration]
     262 |         return (unsigned long)PFN_DOWN(virt_to_phys(kaddr));
         |                                        ^~~~~~~~~~~~
   include/linux/pfn.h:20:27: note: in definition of macro 'PFN_DOWN'
      20 | #define PFN_DOWN(x)     ((x) >> PAGE_SHIFT)
         |                           ^
   arch/mips/include/asm/io.h: At top level:
>> arch/mips/include/asm/io.h:114:27: error: conflicting types for 'virt_to_phys'; have 'phys_addr_t(const volatile void *)' {aka 'long long unsigned int(const volatile void *)'}
     114 | static inline phys_addr_t virt_to_phys(const volatile void *x)
         |                           ^~~~~~~~~~~~
   arch/mips/include/asm/page.h:262:40: note: previous implicit declaration of 'virt_to_phys' with type 'int()'
     262 |         return (unsigned long)PFN_DOWN(virt_to_phys(kaddr));
         |                                        ^~~~~~~~~~~~
   include/linux/pfn.h:20:27: note: in definition of macro 'PFN_DOWN'
      20 | #define PFN_DOWN(x)     ((x) >> PAGE_SHIFT)
         |                           ^
   arch/mips/kernel/asm-offsets.c:26:6: warning: no previous prototype for 'output_ptreg_defines' [-Wmissing-prototypes]
      26 | void output_ptreg_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:78:6: warning: no previous prototype for 'output_task_defines' [-Wmissing-prototypes]
      78 | void output_task_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:92:6: warning: no previous prototype for 'output_thread_info_defines' [-Wmissing-prototypes]
      92 | void output_thread_info_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:108:6: warning: no previous prototype for 'output_thread_defines' [-Wmissing-prototypes]
     108 | void output_thread_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:136:6: warning: no previous prototype for 'output_thread_fpu_defines' [-Wmissing-prototypes]
     136 | void output_thread_fpu_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:179:6: warning: no previous prototype for 'output_mm_defines' [-Wmissing-prototypes]
     179 | void output_mm_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:240:6: warning: no previous prototype for 'output_sc_defines' [-Wmissing-prototypes]
     240 | void output_sc_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:253:6: warning: no previous prototype for 'output_signal_defined' [-Wmissing-prototypes]
     253 | void output_signal_defined(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:346:6: warning: no previous prototype for 'output_kvm_defines' [-Wmissing-prototypes]
     346 | void output_kvm_defines(void)
         |      ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:117: arch/mips/kernel/asm-offsets.s] Error 1
   make[2]: Target 'missing-syscalls' not remade because of errors.
   make[1]: *** [arch/mips/Makefile:408: archprepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +114 arch/mips/include/asm/io.h

dfad83cb7193ef Florian Fainelli 2021-03-30  113  
dfad83cb7193ef Florian Fainelli 2021-03-30 @114  static inline phys_addr_t virt_to_phys(const volatile void *x)
dfad83cb7193ef Florian Fainelli 2021-03-30  115  {
dfad83cb7193ef Florian Fainelli 2021-03-30  116  	return __virt_to_phys(x);
dfad83cb7193ef Florian Fainelli 2021-03-30  117  }
dfad83cb7193ef Florian Fainelli 2021-03-30  118  

:::::: The code at line 114 was first introduced by commit
:::::: dfad83cb7193effb6c853a5c7337ac2274a2e2fc MIPS: Add support for CONFIG_DEBUG_VIRTUAL

:::::: TO: Florian Fainelli <f.fainelli@gmail.com>
:::::: CC: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

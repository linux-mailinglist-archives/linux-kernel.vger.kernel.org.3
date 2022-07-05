Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A60256609A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 03:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiGEBQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 21:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiGEBQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 21:16:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6A6E0A0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 18:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656983796; x=1688519796;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=35E8dFu54kqlcdPJb7qppyzPNv4PbMRsJy6OOFjMo/Q=;
  b=E6p7nCl5Ia6mvU/WBusQxBbHO/dG+HSSHks4KLLCdN3/OUo7iTfvMrZk
   rDWlOjtd3jybr/yo4tvY9OzNQD9e8Ke+h+zCRHAEyLqEAdbu7eJlrBq8A
   b/GwgujoqybYWCpIng8eyklZNtLtkz1CB/awd/5sM0IBz/yLt9UlXVjzE
   9NLcDtD6Gh4/uHnjDFUMwn4uFzmDuUxM4wg5pqrqAYwT/DR0xDIMTABoo
   7nIuSVqKeUUmyV6aZX74UVO8vLjNLxIEOkcLsp7wQsTDLn6QzFaz98Srp
   nmNl5Y7tiIizRsM9Zhyv+F4ai+MyvT8KqPBEoT/Nl/L3g2aSlvXO/RRDl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="283249737"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="283249737"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 18:16:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="619562393"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 04 Jul 2022 18:16:34 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8XB3-000IY3-MM;
        Tue, 05 Jul 2022 01:16:33 +0000
Date:   Tue, 5 Jul 2022 09:15:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.19-rc1 25/35]
 arch/mips/include/asm/page.h:262:40: error: implicit declaration of function
 'virt_to_phys'; did you mean 'virt_to_pfn'?
Message-ID: <202207050951.7mOgx4XX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.19-rc1
head:   144435741b0a6f31403d3084103678da3b4f9d11
commit: f9b8d36b54a1776051d8adb548924d14cbe57535 [25/35] MIPS: Make virt_to_pfn() a static inline
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220705/202207050951.7mOgx4XX-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=f9b8d36b54a1776051d8adb548924d14cbe57535
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.19-rc1
        git checkout f9b8d36b54a1776051d8adb548924d14cbe57535
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips prepare

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
>> arch/mips/include/asm/page.h:262:40: error: implicit declaration of function 'virt_to_phys'; did you mean 'virt_to_pfn'? [-Werror=implicit-function-declaration]
     262 |         return (unsigned long)PFN_DOWN(virt_to_phys(kaddr));
         |                                        ^~~~~~~~~~~~
   include/linux/pfn.h:20:27: note: in definition of macro 'PFN_DOWN'
      20 | #define PFN_DOWN(x)     ((x) >> PAGE_SHIFT)
         |                           ^
   In file included from include/linux/io.h:13,
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
   arch/mips/include/asm/io.h: At top level:
>> arch/mips/include/asm/io.h:114:27: error: conflicting types for 'virt_to_phys'; have 'phys_addr_t(const volatile void *)' {aka 'unsigned int(const volatile void *)'}
     114 | static inline phys_addr_t virt_to_phys(const volatile void *x)
         |                           ^~~~~~~~~~~~
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
   arch/mips/kernel/asm-offsets.c:218:6: warning: no previous prototype for 'output_sc_defines' [-Wmissing-prototypes]
     218 | void output_sc_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:253:6: warning: no previous prototype for 'output_signal_defined' [-Wmissing-prototypes]
     253 | void output_signal_defined(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:320:6: warning: no previous prototype for 'output_pbe_defines' [-Wmissing-prototypes]
     320 | void output_pbe_defines(void)
         |      ^~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:332:6: warning: no previous prototype for 'output_pm_defines' [-Wmissing-prototypes]
     332 | void output_pm_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:346:6: warning: no previous prototype for 'output_kvm_defines' [-Wmissing-prototypes]
     346 | void output_kvm_defines(void)
         |      ^~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:390:6: warning: no previous prototype for 'output_cps_defines' [-Wmissing-prototypes]
     390 | void output_cps_defines(void)
         |      ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:117: arch/mips/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1196: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +262 arch/mips/include/asm/page.h

   254	
   255	static inline unsigned long virt_to_pfn(const volatile void *kaddr)
   256	{
   257		/*
   258		 * MIPS virt_to_phys() returns a phys_addr_t which is
   259		 * an unsigned int on MIPS, but the interface expects
   260		 * unsigned long.
   261		 */
 > 262		return (unsigned long)PFN_DOWN(virt_to_phys(kaddr));
   263	}
   264	#define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
   265	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

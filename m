Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656D853CA98
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244602AbiFCNWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244618AbiFCNWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:22:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8241AD83
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654262536; x=1685798536;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BABB7XKMT3EWz8cL5dciTNxC/1yYak42Lifzo56JVzs=;
  b=WrSFypGsEkLucpntJsAoyDiXl63BHFyWjgCtC/0SefaggOqjdKudSpG5
   MhnjF7brnO2VIT8aLYGwROEFgxx4tsClQEOPkWSq3vZKLqb8wHNgkqX/f
   tveHuO6Y2SsVp6cH16QTCglgqdH+r2pEOejEbcNBXBATmv8BqgHtvnX41
   q4sMSmYr+dixKJKRn9fsI5cK1f9ZFie/uSM+/fh0KP931oZT8gQEUMHVq
   AwRfJBdHCWsUf+4umKqDyYZ1wwSKdrnZXTNlIqrqI8EQL4rBxA5Eib7Y2
   qdm5U6BBqymFDmOGfPWN8FVo9X0tgRqmJ79Z+SbuooSnhVEsGpE+nYguh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="301621280"
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="301621280"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 06:22:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="582546910"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jun 2022 06:22:08 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nx7Fg-0007ki-0i;
        Fri, 03 Jun 2022 13:22:08 +0000
Date:   Fri, 3 Jun 2022 21:21:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 26/34]
 arch/mips/include/asm/io.h:114:27: error: conflicting types for
 'virt_to_phys'; have 'phys_addr_t(const volatile void *)' {aka 'long long
 unsigned int(const volatile void *)'}
Message-ID: <202206032141.WWW6AnsT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   1aafd4ba7b78b4ac0013a48a35252654852cb7ab
commit: 528ddc725d2f4c648357c9323487fb3f9a639cb6 [26/34] MIPS: Make virt_to_pfn() a static inline
config: mips-buildonly-randconfig-r003-20220531 (https://download.01.org/0day-ci/archive/20220603/202206032141.WWW6AnsT-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=528ddc725d2f4c648357c9323487fb3f9a639cb6
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout 528ddc725d2f4c648357c9323487fb3f9a639cb6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/mips/include/asm/page.h:74,
                    from arch/mips/include/asm/io.h:29,
                    from arch/mips/include/asm/mmiowb.h:5,
                    from include/linux/spinlock.h:64,
                    from include/linux/ipc.h:5,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/compat.h:14,
                    from arch/mips/kernel/asm-offsets.c:12:
   arch/mips/include/asm/page.h: In function 'virt_to_pfn':
   arch/mips/include/asm/page.h:263:40: error: implicit declaration of function 'virt_to_phys'; did you mean 'virt_to_pfn'? [-Werror=implicit-function-declaration]
     263 |         return (unsigned long)PFN_DOWN(virt_to_phys(kaddr));
         |                                        ^~~~~~~~~~~~
   include/linux/pfn.h:20:27: note: in definition of macro 'PFN_DOWN'
      20 | #define PFN_DOWN(x)     ((x) >> PAGE_SHIFT)
         |                           ^
   In file included from arch/mips/include/asm/mmiowb.h:5,
                    from include/linux/spinlock.h:64,
                    from include/linux/ipc.h:5,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/compat.h:14,
                    from arch/mips/kernel/asm-offsets.c:12:
   arch/mips/include/asm/io.h: At top level:
>> arch/mips/include/asm/io.h:114:27: error: conflicting types for 'virt_to_phys'; have 'phys_addr_t(const volatile void *)' {aka 'long long unsigned int(const volatile void *)'}
     114 | static inline phys_addr_t virt_to_phys(const volatile void *x)
         |                           ^~~~~~~~~~~~
   In file included from arch/mips/include/asm/page.h:74,
                    from arch/mips/include/asm/io.h:29,
                    from arch/mips/include/asm/mmiowb.h:5,
                    from include/linux/spinlock.h:64,
                    from include/linux/ipc.h:5,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/compat.h:14,
                    from arch/mips/kernel/asm-offsets.c:12:
   arch/mips/include/asm/page.h:263:40: note: previous implicit declaration of 'virt_to_phys' with type 'int()'
     263 |         return (unsigned long)PFN_DOWN(virt_to_phys(kaddr));
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
   arch/mips/kernel/asm-offsets.c:179:6: warning: no previous prototype for 'output_mm_defines' [-Wmissing-prototypes]
     179 | void output_mm_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:240:6: warning: no previous prototype for 'output_sc_defines' [-Wmissing-prototypes]
     240 | void output_sc_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:253:6: warning: no previous prototype for 'output_signal_defined' [-Wmissing-prototypes]
     253 | void output_signal_defined(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:120: arch/mips/kernel/asm-offsets.s] Error 1
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

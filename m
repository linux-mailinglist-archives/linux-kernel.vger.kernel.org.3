Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EF754A1D4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240969AbiFMVyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350536AbiFMVyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:54:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D50E205EE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655157244; x=1686693244;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gTWbJ5Wjcw4Fc4kGkde+bUCUS/ZDjaIGfoulkXK8WLs=;
  b=XSn09Fjv9i3vXL/wqhrAsvBAINmW45rlj0IjQ0G9mBDeAp04WbEzcFGF
   /AypNcTCfCBzlQC/qi0uiF9fNn/7E4HpeEcNx2woD9zt4hOUrhdhnnh5H
   ept0lgR6yssWZ8TA7ql77W/l7WQsxJte74HEt0GVv/UyBdW9nn1at/3ao
   OXs3cWNzhLtZn0KgDf7Leiv6iPhzPqbjzAVhT56kuxECRtsKuY8ttRuIP
   9hkjv57vKcSgM6ozssYV8wHWCOYM6W82DpQH8s3PD8AsDsEnskP56f7GI
   GK16HEjZBn+r3nxqDYFI4IfvJLyFDUdeOWl89sd5MmlZVl0X67E44Bavl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="275954186"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="275954186"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 14:54:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="686282254"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2022 14:54:02 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0s0Y-000LBp-2M;
        Mon, 13 Jun 2022 21:54:02 +0000
Date:   Tue, 14 Jun 2022 05:53:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.19-rc1 27/33]
 arch/powerpc/include/asm/page.h:237:9: error: call to undeclared function
 'WARN_ON'; ISO C99 and later do not support implicit function declarations
Message-ID: <202206140540.TntNERxC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.19-rc1
head:   62fa3e7c2288a1f8d5b9bb2c1f31cee3c26df806
commit: d2b930128c4dfdce5bd9470bf79277bd457df960 [27/33] powerpc: Make virt_to_pfn() a static inline
config: powerpc64-randconfig-r006-20220613 (https://download.01.org/0day-ci/archive/20220614/202206140540.TntNERxC-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d378268ead93c85803c270277f0243737b536ae7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc64 cross compiling tool for clang build
        # apt-get install binutils-powerpc64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=d2b930128c4dfdce5bd9470bf79277bd457df960
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.19-rc1
        git checkout d2b930128c4dfdce5bd9470bf79277bd457df960
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
>> arch/powerpc/include/asm/io.h:928:47: warning: incompatible integer to pointer conversion passing 'unsigned long' to parameter of type 'const volatile void *' [-Wint-conversion]
           WARN_ON(IS_ENABLED(CONFIG_DEBUG_VIRTUAL) && !virt_addr_valid(address));
                                                        ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/page.h:245:24: note: expanded from macro 'virt_addr_valid'
           pfn_valid(virt_to_pfn(_addr));                                  \
                                 ^~~~~
   arch/powerpc/include/asm/bug.h:121:29: note: expanded from macro 'WARN_ON'
                   if (__builtin_constant_p((x))) {                \
                                             ^
   arch/powerpc/include/asm/page.h:235:62: note: passing argument to parameter 'kaddr' here
   static inline unsigned long virt_to_pfn(const volatile void *kaddr)
                                                                ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
>> arch/powerpc/include/asm/io.h:928:47: warning: incompatible integer to pointer conversion passing 'unsigned long' to parameter of type 'const volatile void *' [-Wint-conversion]
           WARN_ON(IS_ENABLED(CONFIG_DEBUG_VIRTUAL) && !virt_addr_valid(address));
                                                        ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/page.h:245:24: note: expanded from macro 'virt_addr_valid'
           pfn_valid(virt_to_pfn(_addr));                                  \
                                 ^~~~~
   arch/powerpc/include/asm/bug.h:122:10: note: expanded from macro 'WARN_ON'
                           if (!(x))                               \
                                 ^
   arch/powerpc/include/asm/page.h:235:62: note: passing argument to parameter 'kaddr' here
   static inline unsigned long virt_to_pfn(const volatile void *kaddr)
                                                                ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
>> arch/powerpc/include/asm/io.h:928:47: warning: incompatible integer to pointer conversion passing 'unsigned long' to parameter of type 'const volatile void *' [-Wint-conversion]
           WARN_ON(IS_ENABLED(CONFIG_DEBUG_VIRTUAL) && !virt_addr_valid(address));
                                                        ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/page.h:245:24: note: expanded from macro 'virt_addr_valid'
           pfn_valid(virt_to_pfn(_addr));                                  \
                                 ^~~~~
   arch/powerpc/include/asm/bug.h:132:28: note: expanded from macro 'WARN_ON'
                                      "r" ((__force long)(x)));    \
                                                          ^
   arch/powerpc/include/asm/bug.h:84:7: note: expanded from macro 'WARN_ENTRY'
                     ##__VA_ARGS__ : : label)
                       ^~~~~~~~~~~
   include/linux/compiler_types.h:283:42: note: expanded from macro 'asm_volatile_goto'
   #define asm_volatile_goto(x...) asm goto(x)
                                            ^
   arch/powerpc/include/asm/page.h:235:62: note: passing argument to parameter 'kaddr' here
   static inline unsigned long virt_to_pfn(const volatile void *kaddr)
                                                                ^
   3 warnings generated.
   In file included from <built-in>:4:
   In file included from lib/vdso/gettimeofday.c:5:
   In file included from include/vdso/datapage.h:137:
   In file included from arch/powerpc/include/asm/vdso/gettimeofday.h:7:
>> arch/powerpc/include/asm/page.h:237:9: error: call to undeclared function 'WARN_ON'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return __pa(kaddr) >> PAGE_SHIFT;
                  ^
   arch/powerpc/include/asm/page.h:225:2: note: expanded from macro '__pa'
           VIRTUAL_WARN_ON((unsigned long)(x) < PAGE_OFFSET);              \
           ^
   arch/powerpc/include/asm/page.h:210:28: note: expanded from macro 'VIRTUAL_WARN_ON'
   #define VIRTUAL_WARN_ON(x)      WARN_ON(IS_ENABLED(CONFIG_DEBUG_VIRTUAL) && (x))
                                   ^
>> arch/powerpc/include/asm/page.h:237:9: warning: result of comparison of constant 13835058055282163712 with expression of type 'unsigned long' is always true [-Wtautological-constant-out-of-range-compare]
           return __pa(kaddr) >> PAGE_SHIFT;
                  ^~~~~~~~~~~
   arch/powerpc/include/asm/page.h:225:37: note: expanded from macro '__pa'
           VIRTUAL_WARN_ON((unsigned long)(x) < PAGE_OFFSET);              \
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
   arch/powerpc/include/asm/page.h:210:73: note: expanded from macro 'VIRTUAL_WARN_ON'
   #define VIRTUAL_WARN_ON(x)      WARN_ON(IS_ENABLED(CONFIG_DEBUG_VIRTUAL) && (x))
                                                                                ^
   1 warning and 1 error generated.
   make[2]: *** [arch/powerpc/kernel/vdso/Makefile:74: arch/powerpc/kernel/vdso/vgettimeofday-32.o] Error 1
   make[2]: Target 'include/generated/vdso32-offsets.h' not remade because of errors.
   make[1]: *** [arch/powerpc/Makefile:422: vdso_prepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/WARN_ON +237 arch/powerpc/include/asm/page.h

   234	
   235	static inline unsigned long virt_to_pfn(const volatile void *kaddr)
   236	{
 > 237		return __pa(kaddr) >> PAGE_SHIFT;
   238	}
   239	#define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
   240	#define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
   241	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

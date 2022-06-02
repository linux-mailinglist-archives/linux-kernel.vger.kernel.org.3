Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5D053BDAE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 19:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbiFBR7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 13:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbiFBR7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 13:59:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E6D19282
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 10:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654192743; x=1685728743;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7cd/T3aKkkDKSmIlJXDylki50o+AeXsDVVeUoS5JTms=;
  b=EBJGltlyCpW6jB95maZa3r79XfWNvXDtClSxHEHWc6SK20VGrHb1hGgi
   qngjJjJBMkiZyyYrqg4DG+NQHEi3pl/NVLIEV+w9UFEdbOfCqWR60xTRS
   yywEdogW8I5904CtKQ1nfK7tpgyV2x7/9HmexNF5k6gJzFKuCkWYT/bHy
   ZqxyyVJpxEXiiJuFSpYQKidT52aWASfu4y9fiMs8/i12HeSIritlORMXf
   bavL1HDJ/vEx+qK1Pow4GN7Z2+tIACWF/RM1wbFDJ6wWQOGc9ZjXkIopq
   RreTOQ2qSVLxP+FKzfgq2uzXdC+IbfO5vNFJif6XhWWZrQwfKugbzeEBo
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="276102726"
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="276102726"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 10:58:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="707671916"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 02 Jun 2022 10:58:39 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwp5i-0005Kn-Bp;
        Thu, 02 Jun 2022 17:58:38 +0000
Date:   Fri, 3 Jun 2022 01:58:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 23/31]
 arch/mips/include/asm/page.h:263:33: error: call to undeclared function
 'virt_to_phys'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202206030149.i9E92Rg0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   8e0ac1b6b44d1c62420ad92b2a1cbc106a00f3de
commit: e299c342a63c14e1e2a0971b0726c90e298431ff [23/31] MIPS: Make virt_to_pfn() a static inline
config: mips-randconfig-r022-20220531 (https://download.01.org/0day-ci/archive/20220603/202206030149.i9E92Rg0-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b364c76683f8ef241025a9556300778c07b590c2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=e299c342a63c14e1e2a0971b0726c90e298431ff
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout e299c342a63c14e1e2a0971b0726c90e298431ff
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:14:
   In file included from include/linux/sem.h:5:
   In file included from include/uapi/linux/sem.h:5:
   In file included from include/linux/ipc.h:5:
   In file included from include/linux/spinlock.h:64:
   In file included from arch/mips/include/asm/mmiowb.h:5:
   In file included from arch/mips/include/asm/io.h:29:
>> arch/mips/include/asm/page.h:263:33: error: call to undeclared function 'virt_to_phys'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return (unsigned long)PFN_DOWN(virt_to_phys(kaddr));
                                          ^
   arch/mips/include/asm/page.h:263:33: note: did you mean 'virt_to_pfn'?
   arch/mips/include/asm/page.h:256:29: note: 'virt_to_pfn' declared here
   static inline unsigned long virt_to_pfn(const void *kaddr)
                               ^
   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:14:
   In file included from include/linux/sem.h:5:
   In file included from include/uapi/linux/sem.h:5:
   In file included from include/linux/ipc.h:5:
   In file included from include/linux/spinlock.h:64:
   In file included from arch/mips/include/asm/mmiowb.h:5:
>> arch/mips/include/asm/io.h:115:27: error: static declaration of 'virt_to_phys' follows non-static declaration
   static inline phys_addr_t virt_to_phys(const volatile void *x)
                             ^
   arch/mips/include/asm/io.h:114:22: note: expanded from macro 'virt_to_phys'
   #define virt_to_phys virt_to_phys
                        ^
   arch/mips/include/asm/page.h:263:33: note: previous implicit declaration is here
           return (unsigned long)PFN_DOWN(virt_to_phys(kaddr));
                                          ^
   arch/mips/kernel/asm-offsets.c:26:6: warning: no previous prototype for function 'output_ptreg_defines' [-Wmissing-prototypes]
   void output_ptreg_defines(void)
        ^
   arch/mips/kernel/asm-offsets.c:26:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void output_ptreg_defines(void)
   ^
   static 
   arch/mips/kernel/asm-offsets.c:78:6: warning: no previous prototype for function 'output_task_defines' [-Wmissing-prototypes]
   void output_task_defines(void)
        ^
   arch/mips/kernel/asm-offsets.c:78:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void output_task_defines(void)
   ^
   static 
   arch/mips/kernel/asm-offsets.c:92:6: warning: no previous prototype for function 'output_thread_info_defines' [-Wmissing-prototypes]
   void output_thread_info_defines(void)
        ^
   arch/mips/kernel/asm-offsets.c:92:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void output_thread_info_defines(void)
   ^
   static 
   arch/mips/kernel/asm-offsets.c:108:6: warning: no previous prototype for function 'output_thread_defines' [-Wmissing-prototypes]
   void output_thread_defines(void)
        ^
   arch/mips/kernel/asm-offsets.c:108:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void output_thread_defines(void)
   ^
   static 
   arch/mips/kernel/asm-offsets.c:136:6: warning: no previous prototype for function 'output_thread_fpu_defines' [-Wmissing-prototypes]
   void output_thread_fpu_defines(void)
        ^
   arch/mips/kernel/asm-offsets.c:136:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void output_thread_fpu_defines(void)
   ^
   static 
   arch/mips/kernel/asm-offsets.c:179:6: warning: no previous prototype for function 'output_mm_defines' [-Wmissing-prototypes]
   void output_mm_defines(void)
        ^
   arch/mips/kernel/asm-offsets.c:179:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void output_mm_defines(void)
   ^
   static 
   arch/mips/kernel/asm-offsets.c:218:6: warning: no previous prototype for function 'output_sc_defines' [-Wmissing-prototypes]
   void output_sc_defines(void)
        ^
   arch/mips/kernel/asm-offsets.c:218:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void output_sc_defines(void)
   ^
   static 
   arch/mips/kernel/asm-offsets.c:253:6: warning: no previous prototype for function 'output_signal_defined' [-Wmissing-prototypes]
   void output_signal_defined(void)
        ^
   arch/mips/kernel/asm-offsets.c:253:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void output_signal_defined(void)
   ^
   static 
   arch/mips/kernel/asm-offsets.c:332:6: warning: no previous prototype for function 'output_pm_defines' [-Wmissing-prototypes]
   void output_pm_defines(void)
        ^
   arch/mips/kernel/asm-offsets.c:332:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void output_pm_defines(void)
   ^
   static 
   arch/mips/kernel/asm-offsets.c:346:6: warning: no previous prototype for function 'output_kvm_defines' [-Wmissing-prototypes]
   void output_kvm_defines(void)
        ^
   arch/mips/kernel/asm-offsets.c:346:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void output_kvm_defines(void)
   ^
   static 
   10 warnings and 2 errors generated.
   make[2]: *** [scripts/Makefile.build:120: arch/mips/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/virt_to_phys +263 arch/mips/include/asm/page.h

   255	
   256	static inline unsigned long virt_to_pfn(const void *kaddr)
   257	{
   258		/*
   259		 * MIPS virt_to_phys() returns a phys_addr_t which is
   260		 * an unsigned int on MIPS, but the interface expects
   261		 * unsigned long.
   262		 */
 > 263		return (unsigned long)PFN_DOWN(virt_to_phys(kaddr));
   264	}
   265	#define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
   266	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9034153D87C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 22:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbiFDUPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 16:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbiFDUO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 16:14:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FF313CD7
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 13:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654373693; x=1685909693;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=POqjBBNvv0hw1UQQaBQIn//pfnHjpxlwT4359FcofwM=;
  b=Xo8KfzNYxiqTNh/T4QfK02/5c4AgMIjSbMfBJIbLz5fmqRmdM0qdPDbX
   63FmXr1X9frEoSx+42PXZfBpEYkktWc19wJTjkcDoEfIAKEHVzZDcMdLx
   1MPrLQKzOzaG2BYRcqaxmFNZ7EtdcQY0fIDc+TlYojeSfygdiAAx+aPGF
   JbWUaCGW0owyieQA+XcFtGbqxVPk4vWJNFPuslz8PmTBcFIsjsHYW5v1q
   AgRHT17sqq2LRxs1MjfRYKc3aR9E0TanqJJCIOqvJRMzXwuEsa2dFxnWZ
   TEH0PDK4KvbcDkwcRYJrLhAPlhPPQmcK1MGUmwtBfqKqUhd9XG4n8I7mp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="301853175"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="301853175"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 13:14:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="646931130"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jun 2022 13:14:52 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxaAd-000BBa-LH;
        Sat, 04 Jun 2022 20:14:51 +0000
Date:   Sun, 5 Jun 2022 04:14:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 26/34]
 arch/mips/include/asm/page.h:263:40: error: implicit declaration of function
 'virt_to_phys'; did you mean 'virt_to_pfn'?
Message-ID: <202206050448.4G8omwDM-lkp@intel.com>
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
config: mips-capcella_defconfig (https://download.01.org/0day-ci/archive/20220605/202206050448.4G8omwDM-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.3.0
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
>> arch/mips/include/asm/page.h:263:40: error: implicit declaration of function 'virt_to_phys'; did you mean 'virt_to_pfn'? [-Werror=implicit-function-declaration]
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
>> arch/mips/include/asm/io.h:114:27: error: conflicting types for 'virt_to_phys'; have 'phys_addr_t(const volatile void *)' {aka 'unsigned int(const volatile void *)'}
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
   arch/mips/kernel/asm-offsets.c:346:6: warning: no previous prototype for 'output_kvm_defines' [-Wmissing-prototypes]
     346 | void output_kvm_defines(void)
         |      ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:120: arch/mips/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +263 arch/mips/include/asm/page.h

   255	
   256	static inline unsigned long virt_to_pfn(const volatile void *kaddr)
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

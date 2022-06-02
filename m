Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E903C53B899
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiFBMEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbiFBMDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:03:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22472AD5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 05:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654171424; x=1685707424;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=06oKoylZ5hy0kyfARNFU3V5+uVWK3nr9bavtuErTnls=;
  b=LbVs3o9xIpMzDgBAfZ4/kNbkqb84u4I5E+1Z4Xm+8kRZjnFOozZQn9wy
   T9fnLQFpeaj2LUAatvRd0CrsZr7TN/e8dmz6UXyMr34CRl40+CjSRwcnU
   wUWPamcoPoNjb8O2a1zZKQm6QulMWvSZMrK5JqUgUQDWxotsSZAOTT7nI
   ajBOOJSIEcxz9AAVXI/WQnvi2rrAqu7uW4fJEpxsTI/UeJfI1gmwfdfNt
   z1c88NJf5oF9EYPjYZ0i3/oAZemrbzwUNT/7eHRmW/aXK4a8e4GaiCunz
   HKofXaJmJHjC1iPQFLpynmUvR5J2IJXxIms66zrDWm7ZzpsI8ppDq3dQ4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275934409"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="275934409"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 05:03:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="634018917"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jun 2022 05:03:25 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwjXw-00052x-9r;
        Thu, 02 Jun 2022 12:03:24 +0000
Date:   Thu, 2 Jun 2022 20:02:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 26/31]
 arch/riscv/include/asm/page.h:137:71: error: 'XIP_OFFSET' undeclared; did
 you mean
Message-ID: <202206022035.IIZ3f4Uw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   9083f89a58302e92fad7f144986e307db2350aad
commit: b146654f1463caf323d67e17259aa1606330a701 [26/31] riscv: Make virt_to_pfn() a static inline
config: riscv-randconfig-r042-20220531 (https://download.01.org/0day-ci/archive/20220602/202206022035.IIZ3f4Uw-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=b146654f1463caf323d67e17259aa1606330a701
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout b146654f1463caf323d67e17259aa1606330a701
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
   Depends on HAS_IOMEM && DRM && MMU
   Selected by
   - DRM_SSD130X && HAS_IOMEM && DRM
   In file included from arch/riscv/include/asm/page.h:12,
   from arch/riscv/include/asm/thread_info.h:11,
   from include/linux/thread_info.h:60,
   from include/asm-generic/preempt.h:5,
   from ./arch/riscv/include/generated/asm/preempt.h:1,
   from include/linux/preempt.h:78,
   from include/linux/spinlock.h:55,
   from include/linux/mmzone.h:8,
   from include/linux/gfp.h:6,
   from include/linux/mm.h:7,
   from arch/riscv/kernel/asm-offsets.c:10:
   arch/riscv/include/asm/page.h: In function 'virt_to_pfn':
   arch/riscv/include/asm/page.h:123:82: error: 'KERN_VIRT_SIZE' undeclared (first use in this function)
   123 | ((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < PAGE_OFFSET + KERN_VIRT_SIZE))
   | ^~~~~~~~~~~~~~
   include/linux/pfn.h:20:27: note: in definition of macro 'PFN_DOWN'
   20 | #define PFN_DOWN(x) ((x) >> PAGE_SHIFT)
   | ^
   arch/riscv/include/asm/page.h:165:16: note: in expansion of macro 'phys_to_pfn'
   165 | return phys_to_pfn(__pa(vaddr));
   | ^~~~~~~~~~~
   arch/riscv/include/asm/page.h:144:9: note: in expansion of macro 'is_linear_mapping'
   144 | is_linear_mapping(_x) | ^~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:152:33: note: in expansion of macro '__va_to_pa_nodebug'
   152 | #define __virt_to_phys(x) __va_to_pa_nodebug(x)
   | ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:157:25: note: in expansion of macro '__virt_to_phys'
   157 | #define __pa(x) __virt_to_phys((unsigned long)(x))
   | ^~~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:165:28: note: in expansion of macro '__pa'
   165 | return phys_to_pfn(__pa(vaddr));
   | ^~~~
   arch/riscv/include/asm/page.h:123:82: note: each undeclared identifier is reported only once for each function it appears in
   123 | ((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < PAGE_OFFSET + KERN_VIRT_SIZE))
   | ^~~~~~~~~~~~~~
   include/linux/pfn.h:20:27: note: in definition of macro 'PFN_DOWN'
   20 | #define PFN_DOWN(x) ((x) >> PAGE_SHIFT)
   | ^
   arch/riscv/include/asm/page.h:165:16: note: in expansion of macro 'phys_to_pfn'
   165 | return phys_to_pfn(__pa(vaddr));
   | ^~~~~~~~~~~
   arch/riscv/include/asm/page.h:144:9: note: in expansion of macro 'is_linear_mapping'
   144 | is_linear_mapping(_x) | ^~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:152:33: note: in expansion of macro '__va_to_pa_nodebug'
   152 | #define __virt_to_phys(x) __va_to_pa_nodebug(x)
   | ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:157:25: note: in expansion of macro '__virt_to_phys'
   157 | #define __pa(x) __virt_to_phys((unsigned long)(x))
   | ^~~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:165:28: note: in expansion of macro '__pa'
   165 | return phys_to_pfn(__pa(vaddr));
   | ^~~~
>> arch/riscv/include/asm/page.h:137:71: error: 'XIP_OFFSET' undeclared (first use in this function); did you mean
   137 | (IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP_OFFSET) | ^~~~~~~~~~
   include/linux/pfn.h:20:27: note: in definition of macro 'PFN_DOWN'
   20 | #define PFN_DOWN(x) ((x) >> PAGE_SHIFT)
   | ^
   arch/riscv/include/asm/page.h:165:16: note: in expansion of macro 'phys_to_pfn'
   165 | return phys_to_pfn(__pa(vaddr));
   | ^~~~~~~~~~~
   arch/riscv/include/asm/page.h:145:47: note: in expansion of macro 'kernel_mapping_va_to_pa'
   145 | linear_mapping_va_to_pa(_x) : kernel_mapping_va_to_pa(_x); | ^~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:152:33: note: in expansion of macro '__va_to_pa_nodebug'
   152 | #define __virt_to_phys(x) __va_to_pa_nodebug(x)
   | ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:157:25: note: in expansion of macro '__virt_to_phys'
   157 | #define __pa(x) __virt_to_phys((unsigned long)(x))
   | ^~~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:165:28: note: in expansion of macro '__pa'
   165 | return phys_to_pfn(__pa(vaddr));
   | ^~~~
   Makefile arch block certs crypto drivers fs include init ipc kernel lib mm modules.builtin modules.builtin.modinfo modules.order nr_bisected scripts security sound source usr virt vmlinux.o vmlinux.symvers [scripts/Makefile.build:120: arch/riscv/kernel/asm-offsets.s] Error 1
   Target '__build' not remade because of errors.
   Makefile arch block certs crypto drivers fs include init ipc kernel lib mm modules.builtin modules.builtin.modinfo modules.order nr_bisected scripts security sound source usr virt vmlinux.o vmlinux.symvers [Makefile:1194: prepare0] Error 2
   Target 'prepare' not remade because of errors.
   make: Makefile arch block certs crypto drivers fs include init ipc kernel lib mm modules.builtin modules.builtin.modinfo modules.order nr_bisected scripts security sound source usr virt vmlinux.o vmlinux.symvers [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
   Depends on HAS_IOMEM && DRM && MMU
   Selected by
   - DRM_SSD130X && HAS_IOMEM && DRM


vim +/XIP_OFFSET +137 arch/riscv/include/asm/page.h

2bfc6cd81bd17e Alexandre Ghiti 2021-04-11  133  
658e2c5125bbbc Alexandre Ghiti 2021-06-17  134  #define linear_mapping_va_to_pa(x)	((unsigned long)(x) - kernel_map.va_pa_offset)
44c922572952d8 Vitaly Wool     2021-04-13  135  #define kernel_mapping_va_to_pa(y) ({						\
44c922572952d8 Vitaly Wool     2021-04-13  136  	unsigned long _y = y;							\
59a27e11221338 Alexandre Ghiti 2021-07-21 @137  	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP_OFFSET) ?	\
658e2c5125bbbc Alexandre Ghiti 2021-06-17  138  		((unsigned long)(_y) - kernel_map.va_kernel_xip_pa_offset) :		\
658e2c5125bbbc Alexandre Ghiti 2021-06-17  139  		((unsigned long)(_y) - kernel_map.va_kernel_pa_offset - XIP_OFFSET);	\
44c922572952d8 Vitaly Wool     2021-04-13  140  	})
7094e6acaf7ab8 Alexandre Ghiti 2021-06-04  141  

:::::: The code at line 137 was first introduced by commit
:::::: 59a27e1122133831111f9e2e40fec2307d742487 riscv: Optimize kernel virtual address conversion macro

:::::: TO: Alexandre Ghiti <alex@ghiti.fr>
:::::: CC: Palmer Dabbelt <palmerdabbelt@google.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

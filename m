Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E0153B7ED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbiFBLiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiFBLij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:38:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F8F6D1AB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 04:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654169917; x=1685705917;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2sm/JCPZdpEHeM6hHSyhF5/H0dnllRBjRCa+M4Br4Z8=;
  b=f6q+YlsacDMAWVfDAWdScXE7noqzAIV0jTp6Wk21JfkJigdN4omcKIDI
   QEFppzkP2mWnIQDBXatxpZuJfWrQAF0Wbg8GihxuNeJ6q3oQqQgvihCMV
   FSw5fVE+j8wt5pwYxBfyLQFEsm8dWHOI3+sP0+4i/bAmefRBj7Rcbp/EC
   Uv7W2weLhH4APyIcXM7P0Tuy4KHK/KtgdA0DuQEeQxybwXryBJpxDBx3U
   fOrg0VD+vD1KzHqFFIPLR1z7yXNYWwSfl5NDaTZNPGaFONcDtNWLxkRN4
   VpGGi4jZbJ6K2VbMzGmfNvdE1PVNuB8RwBuvUs457Km26p5Gv0Qfr/SzU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="256398846"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="256398846"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 04:38:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="707531115"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 02 Jun 2022 04:38:24 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwj9j-00051d-Mr;
        Thu, 02 Jun 2022 11:38:23 +0000
Date:   Thu, 2 Jun 2022 19:37:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 18/31]
 arch/arc/include/asm/page.h:96:16: error: implicit declaration of function
 '__pa'
Message-ID: <202206021901.8rEMndYL-lkp@intel.com>
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
commit: 41026b6c37af5a9cf176a9c4cea5b350005f720a [18/31] ARC: mm: Make virt_to_pfn() a static inline
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220602/202206021901.8rEMndYL-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=41026b6c37af5a9cf176a9c4cea5b350005f720a
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout 41026b6c37af5a9cf176a9c4cea5b350005f720a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/arc/include/asm/thread_info.h:16,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/arc/kernel/asm-offsets.c:6:
   arch/arc/include/asm/page.h: In function 'virt_to_pfn':
>> arch/arc/include/asm/page.h:96:16: error: implicit declaration of function '__pa' [-Werror=implicit-function-declaration]
      96 |         return __pa(kaddr) >> PAGE_SHIFT;
         |                ^~~~
   In file included from arch/arc/include/asm/page.h:137,
                    from arch/arc/include/asm/thread_info.h:16,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/arc/kernel/asm-offsets.c:6:
   include/linux/mm.h: In function 'pte_lockptr':
>> arch/arc/include/asm/pgtable-levels.h:163:47: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
     163 | #define pmd_page_vaddr(pmd)     (pmd_val(pmd) & PAGE_MASK)
         |                                 ~~~~~~~~~~~~~~^~~~~~~~~~~~
         |                                               |
         |                                               long unsigned int
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   arch/arc/include/asm/pgtable-levels.h:165:33: note: in expansion of macro 'virt_to_page'
     165 | #define pmd_page(pmd)           virt_to_page(pmd_page_vaddr(pmd))
         |                                 ^~~~~~~~~~~~
   arch/arc/include/asm/pgtable-levels.h:165:46: note: in expansion of macro 'pmd_page_vaddr'
     165 | #define pmd_page(pmd)           virt_to_page(pmd_page_vaddr(pmd))
         |                                              ^~~~~~~~~~~~~~
   include/linux/mm.h:2287:27: note: in expansion of macro 'pmd_page'
    2287 |         return ptlock_ptr(pmd_page(*pmd));
         |                           ^~~~~~~~
   In file included from arch/arc/include/asm/thread_info.h:16,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/arc/kernel/asm-offsets.c:6:
   arch/arc/include/asm/page.h:94:53: note: expected 'const void *' but argument is of type 'long unsigned int'
      94 | static inline unsigned long virt_to_pfn(const void *kaddr)
         |                                         ~~~~~~~~~~~~^~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:120: arch/arc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/__pa +96 arch/arc/include/asm/page.h

    86	
    87	/*
    88	 * Use virt_to_pfn with caution:
    89	 * If used in pte or paddr related macros, it could cause truncation
    90	 * in PAE40 builds
    91	 * As a rule of thumb, only use it in helpers starting with virt_
    92	 * You have been warned !
    93	 */
    94	static inline unsigned long virt_to_pfn(const void *kaddr)
    95	{
  > 96		return __pa(kaddr) >> PAGE_SHIFT;
    97	}
    98	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390B9566078
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 03:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiGEBGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 21:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiGEBGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 21:06:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94BDA46A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 18:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656983195; x=1688519195;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/VCtNXwWi0RKic/18Lj+DbbUDqKp0T7/CX+v3sZX7XA=;
  b=nj9VagxVLAZ8BEMYHoCHTznbpipy/RQqTfZaSOwScXmCQv2MMbqACK5z
   K4CPcwZOCNg2DP6Xbv5tGGvCkZ6LRdAZeQFkU7c4uUOSXjBeMuDC6iu/4
   yw7coDmyGYG0LITRPhUyfpshhefvRSa7gqsGi29AV+Za77V/fT5ZB9d3I
   A8jC4rkDzW07iHJpxdedhonaGATy3vZyQzT0HI9ymbfI+b4MRuf+fNbCG
   Af2XQCaW5JcoOzHMUI1i/xv1pf25d4HuEjDM9sUez1LEs7sSMJHf3WcPJ
   GmuHCPXeRpV14P2iBRjYaV6LZ1T2N42ATO29L/lPYd0KSyNmsviwoObOo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="266244824"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="266244824"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 18:06:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="682334491"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jul 2022 18:06:34 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8X1N-000IXl-Cc;
        Tue, 05 Jul 2022 01:06:33 +0000
Date:   Tue, 5 Jul 2022 09:05:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.19-rc1 22/35]
 arch/m68k/mm/motorola.c:105:56: error: expected expression before 'void'
Message-ID: <202207050800.rbOo1iMO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.19-rc1
head:   144435741b0a6f31403d3084103678da3b4f9d11
commit: 8cf2c4f6ffc43dcbe6847b0264a36b40e5019464 [22/35] m68k/mm: Make virt_to_pfn() a static inline
config: m68k-randconfig-r002-20220703 (https://download.01.org/0day-ci/archive/20220705/202207050800.rbOo1iMO-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=8cf2c4f6ffc43dcbe6847b0264a36b40e5019464
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.19-rc1
        git checkout 8cf2c4f6ffc43dcbe6847b0264a36b40e5019464
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/m68k/include/asm/page_mm.h:140,
                    from arch/m68k/include/asm/page.h:60,
                    from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from arch/m68k/mm/motorola.c:12:
   arch/m68k/mm/motorola.c: In function 'init_pointer_table':
>> arch/m68k/mm/motorola.c:105:56: error: expected expression before 'void'
     105 | #define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page(void *)(page)->lru))
         |                                                        ^~~~
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   arch/m68k/mm/motorola.c:105:43: note: in expansion of macro 'virt_to_page'
     105 | #define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page(void *)(page)->lru))
         |                                           ^~~~~~~~~~~~
   arch/m68k/mm/motorola.c:124:14: note: in expansion of macro 'PD_PTABLE'
     124 |         dp = PD_PTABLE(page);
         |              ^~~~~~~~~
   arch/m68k/mm/motorola.c: In function 'get_pointer_table':
>> arch/m68k/mm/motorola.c:105:56: error: expected expression before 'void'
     105 | #define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page(void *)(page)->lru))
         |                                                        ^~~~
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   arch/m68k/mm/motorola.c:105:43: note: in expansion of macro 'virt_to_page'
     105 | #define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page(void *)(page)->lru))
         |                                           ^~~~~~~~~~~~
   arch/m68k/mm/motorola.c:169:23: note: in expansion of macro 'PD_PTABLE'
     169 |                 new = PD_PTABLE(page);
         |                       ^~~~~~~~~
   arch/m68k/mm/motorola.c: In function 'free_pointer_table':
>> arch/m68k/mm/motorola.c:105:56: error: expected expression before 'void'
     105 | #define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page(void *)(page)->lru))
         |                                                        ^~~~
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   arch/m68k/mm/motorola.c:105:43: note: in expansion of macro 'virt_to_page'
     105 | #define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page(void *)(page)->lru))
         |                                           ^~~~~~~~~~~~
   arch/m68k/mm/motorola.c:193:14: note: in expansion of macro 'PD_PTABLE'
     193 |         dp = PD_PTABLE(page);
         |              ^~~~~~~~~
   arch/m68k/mm/motorola.c: At top level:
   arch/m68k/mm/motorola.c:389:13: warning: no previous prototype for 'paging_init' [-Wmissing-prototypes]
     389 | void __init paging_init(void)
         |             ^~~~~~~~~~~


vim +/void +105 arch/m68k/mm/motorola.c

5ad272abee9fe0 Peter Zijlstra 2020-01-31  104  
237195c0a0ea52 Linus Walleij  2022-06-03 @105  #define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page(void *)(page)->lru))
5ad272abee9fe0 Peter Zijlstra 2020-01-31  106  #define PD_PAGE(ptable) (list_entry(ptable, struct page, lru))
0e071ee6815692 Peter Zijlstra 2020-01-31  107  #define PD_MARKBITS(dp) (*(unsigned int *)&PD_PAGE(dp)->index)
0e071ee6815692 Peter Zijlstra 2020-01-31  108  

:::::: The code at line 105 was first introduced by commit
:::::: 237195c0a0ea524dc14c7e004fc920a288405751 m68k: Pass a pointer to virt_to_pfn() virt_to_page()

:::::: TO: Linus Walleij <linus.walleij@linaro.org>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

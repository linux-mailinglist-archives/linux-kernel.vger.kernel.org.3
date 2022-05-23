Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FC5531959
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiEWTgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiEWTfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:35:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFB24A937
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653333743; x=1684869743;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XXXRYfiXtXJNlcT0mmqmve3T7F1nAg4SNRZHlYMI+N8=;
  b=GeO55lLBVpoptp6vhhPgFEWTO4tK/VKPidgghcIM4Yf9uVi/3azkYRqV
   8iAkRAV5e/MXMsuKKSml6KfYQ8gRa3X6LE3D+4sPuhM4eCUpcg7wVUAv2
   xYUqoBF45XVp76x32R2crfsnUrHeFGHHSllOUz3D2+fz6euZkwRmf9DH+
   zfyUxKsCNAKLjnkVx05s47JWkY9nMgTOViF4iECA4jzZt6y7isdRS8fnX
   vVZu6eVv9hBf6gtFHCYvUJANNPa/8boVkjrf4nT2iWqZbvmTArHj9iBHj
   5fuD2JWujrSWZ1qwlZaftpUqIUmZr2vlpEDK5EA104NhoJ1QBGHE4opmx
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="333975476"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="333975476"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 12:22:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="548130864"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 May 2022 12:22:21 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntDdE-0001OM-OM;
        Mon, 23 May 2022 19:22:20 +0000
Date:   Tue, 24 May 2022 03:21:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 8/17] undefined
 reference to `kernel_sec_start'
Message-ID: <202205240320.ZergT2GA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   a9b76a04739b5b4dbad86664342c8945e83d8e95
commit: 06f73703766c6f636c79d04aae9f83446f1b8ff2 [8/17] ARM: Compile the kernel into VMALLOC
config: arm-buildonly-randconfig-r005-20220523 (https://download.01.org/0day-ci/archive/20220524/202205240320.ZergT2GA-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=06f73703766c6f636c79d04aae9f83446f1b8ff2
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout 06f73703766c6f636c79d04aae9f83446f1b8ff2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   arm-linux-gnueabi-ld: arch/arm/mm/init.o: in function `arm_memblock_init':
>> (.init.text+0x140): undefined reference to `kernel_sec_start'
--
   In file included from arch/arm/include/asm/memory.h:447,
                    from arch/arm/include/asm/page.h:163,
                    from arch/arm/include/asm/thread_info.h:14,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from mm/gup.c:5:
   mm/gup.c: In function '__get_user_pages_locked':
>> mm/gup.c:1599:49: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
    1599 |                         pages[i] = virt_to_page(start);
         |                                                 ^~~~~
         |                                                 |
         |                                                 long unsigned int
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   mm/gup.c:1599:36: note: in expansion of macro 'virt_to_page'
    1599 |                         pages[i] = virt_to_page(start);
         |                                    ^~~~~~~~~~~~
   In file included from arch/arm/include/asm/page.h:163,
                    from arch/arm/include/asm/thread_info.h:14,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from mm/gup.c:5:
   arch/arm/include/asm/memory.h:322:53: note: expected 'const void *' but argument is of type 'long unsigned int'
     322 | static inline unsigned long virt_to_pfn(const void *p)
         |                                         ~~~~~~~~~~~~^
--
   In file included from arch/arm/include/asm/memory.h:447,
                    from arch/arm/include/asm/page.h:163,
                    from arch/arm/include/asm/thread_info.h:14,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from mm/nommu.c:20:
   mm/nommu.c: In function 'free_page_series':
>> mm/nommu.c:501:50: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
     501 |                 struct page *page = virt_to_page(from);
         |                                                  ^~~~
         |                                                  |
         |                                                  long unsigned int
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   mm/nommu.c:501:37: note: in expansion of macro 'virt_to_page'
     501 |                 struct page *page = virt_to_page(from);
         |                                     ^~~~~~~~~~~~
   In file included from arch/arm/include/asm/page.h:163,
                    from arch/arm/include/asm/thread_info.h:14,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from mm/nommu.c:20:
   arch/arm/include/asm/memory.h:322:53: note: expected 'const void *' but argument is of type 'long unsigned int'
     322 | static inline unsigned long virt_to_pfn(const void *p)
         |                                         ~~~~~~~~~~~~^

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

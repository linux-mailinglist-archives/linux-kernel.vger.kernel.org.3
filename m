Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAC5531214
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbiEWPJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbiEWPJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:09:10 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200B15C37F
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653318549; x=1684854549;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aszdY+qE/Mvif+pY9ZtGe77pA6WoR6j8tsvbF7aZQns=;
  b=a22JgJZvpZs/9QckxnChv8ArP+n/qXC8/ukxd/M9EKLfzAdcd6rJXRmE
   ixNncoxNRfLKtfh3T+XvSCtzMyIKelhcUrspcBJP8SF/zd6r8V8Gd8KDM
   eCkHr3cplVtMmqASmYytZfMkdXQAEPYkGwVkUfERrdjbE64WmougbMTce
   dHTYTxeHhkYPYs7cUJaCcpZf7WpCzJgYQEZGUp0y19AANMwX4lyb3aayM
   hnM83xiAmPiTJEUbrvbzB1VpWwUzN/TrlVzuAwgVRy4Wt2iiUN/dai1KA
   6d65lByJfEc+/pNQQp4DDRnYpbJ7RmxK7URZdvyOh3wDRZLGTtYTbVx8+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="253751854"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="253751854"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 08:09:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="548017136"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 May 2022 08:09:07 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nt9gA-0001CU-Lv;
        Mon, 23 May 2022 15:09:06 +0000
Date:   Mon, 23 May 2022 23:08:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 8/17] init.c:undefined
 reference to `kernel_sec_start'
Message-ID: <202205232342.Lnhi7WhN-lkp@intel.com>
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
config: arm-randconfig-r005-20220522 (https://download.01.org/0day-ci/archive/20220523/202205232342.Lnhi7WhN-lkp@intel.com/config)
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
>> init.c:(.init.text+0x200): undefined reference to `kernel_sec_start'
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

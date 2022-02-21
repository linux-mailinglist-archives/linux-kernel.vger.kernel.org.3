Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1D14BEBF1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 21:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiBUUiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 15:38:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbiBUUiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:38:06 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91ED237D4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 12:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645475862; x=1677011862;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qX8Xsf9uYW/5wjOB5lPEm5ztCVf4ox9Ucl0QWXTsloU=;
  b=JjsGLILrG0FXL02cxvwujIqfwiDC+qQDGoHDB3vTiGkEq+vohkqY5wbx
   U7Vi9m/GXA1rI+2ZwGTI1B7rM1JGZ0wFDqSrLJaDOM5gGl57eLZ+HQxXI
   +VIPr8ENaf7McnDtEcRJcpx6GJYr4buybmfQwlHpMBiNAXSj94bQc+O2+
   35x7TeIZ9MbzdBhiQ4RmBkLCizZUyAlHHpGvhi91e9aNEs+RhNl8DA1Tw
   aDKU69Dkj3wqaNI7UAWxY4Zo6U8q+tBQXsD+foX3eRd2aX1G46aIfezJ4
   hqcJTOCzU9EM6jxI5QDISqfq3JUIVkh38lNAQXqb+4WRc4jQWGkcuQj4s
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251517622"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="251517622"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 12:37:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="507739996"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Feb 2022 12:37:41 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMFRE-0001xn-Hh; Mon, 21 Feb 2022 20:37:40 +0000
Date:   Tue, 22 Feb 2022 04:37:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1473/2541]
 arch/powerpc/include/asm/mmu.h:350:16: error: 'rodata_enabled' undeclared;
 did you mean 'radix_enabled'?
Message-ID: <202202220455.TWgApfN0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   601144c0da5edfa67a9654158370da19c67e17e2
commit: 7a3c172e93aad851d12595cde87a6e2a1e209442 [1473/2541] headers/deps: printk: Reduce <linux/printk.h> header dependencies
config: powerpc64-randconfig-r036-20220221 (https://download.01.org/0day-ci/archive/20220222/202202220455.TWgApfN0-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=7a3c172e93aad851d12595cde87a6e2a1e209442
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 7a3c172e93aad851d12595cde87a6e2a1e209442
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:17,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/preempt.h:10,
                    from arch/powerpc/kernel/asm-offsets.c:12:
   arch/powerpc/include/asm/mmu.h: In function 'strict_kernel_rwx_enabled':
>> arch/powerpc/include/asm/mmu.h:350:16: error: 'rodata_enabled' undeclared (first use in this function); did you mean 'radix_enabled'?
     350 |         return rodata_enabled;
         |                ^~~~~~~~~~~~~~
         |                radix_enabled
   arch/powerpc/include/asm/mmu.h:350:16: note: each undeclared identifier is reported only once for each function it appears in
   In file included from arch/powerpc/include/asm/book3s/64/pgtable.h:299,
                    from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:39,
                    from arch/powerpc/include/asm/mmu.h:405,
                    from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:17,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/preempt.h:10,
                    from arch/powerpc/kernel/asm-offsets.c:12:
   arch/powerpc/include/asm/book3s/64/hash.h: At top level:
   arch/powerpc/include/asm/book3s/64/hash.h:244:22: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'hash__vmemmap_create_mapping'
     244 | extern int __meminit hash__vmemmap_create_mapping(unsigned long start,
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/book3s/64/pgtable.h:300,
                    from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:39,
                    from arch/powerpc/include/asm/mmu.h:405,
                    from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:17,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/preempt.h:10,
                    from arch/powerpc/kernel/asm-offsets.c:12:
   arch/powerpc/include/asm/book3s/64/radix.h:289:22: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'radix__vmemmap_create_mapping'
     289 | extern int __meminit radix__vmemmap_create_mapping(unsigned long start,
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:39,
                    from arch/powerpc/include/asm/mmu.h:405,
                    from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:17,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/preempt.h:10,
                    from arch/powerpc/kernel/asm-offsets.c:12:
   arch/powerpc/include/asm/book3s/64/pgtable.h:1085:29: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'vmemmap_create_mapping'
    1085 | static inline int __meminit vmemmap_create_mapping(unsigned long start,
         |                             ^~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/mmu.h:405,
                    from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:17,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/preempt.h:10,
                    from arch/powerpc/kernel/asm-offsets.c:12:
   arch/powerpc/include/asm/book3s/64/mmu.h:231:27: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'early_init_mmu'
     231 | static inline void __init early_init_mmu(void)
         |                           ^~~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/mmu.h:262:13: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'radix_init_pseries'
     262 | void __init radix_init_pseries(void);
         |             ^~~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/paca.h:30,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/preempt.h:10,
                    from arch/powerpc/kernel/asm-offsets.c:12:
   arch/powerpc/include/asm/cpuidle.h:88:12: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'validate_psscr_val_mask'
      88 | int __init validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags);
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/sched.h:12,
                    from include/linux/sched/thread_info_api.h:5,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from arch/powerpc/kernel/asm-offsets.c:12:
   include/linux/sched/per_task.h:48:11: fatal error: generated/asm-offsets.h: No such file or directory
      48 | # include <generated/asm-offsets.h>
         |           ^~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[2]: *** [scripts/Makefile.build:121: arch/powerpc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +350 arch/powerpc/include/asm/mmu.h

bab4c8de6289b4 Michael Ellerman 2016-07-27  346  
28ea38b9cba68e Christophe Leroy 2019-02-21  347  #ifdef CONFIG_STRICT_KERNEL_RWX
28ea38b9cba68e Christophe Leroy 2019-02-21  348  static inline bool strict_kernel_rwx_enabled(void)
28ea38b9cba68e Christophe Leroy 2019-02-21  349  {
28ea38b9cba68e Christophe Leroy 2019-02-21 @350  	return rodata_enabled;
28ea38b9cba68e Christophe Leroy 2019-02-21  351  }
28ea38b9cba68e Christophe Leroy 2019-02-21  352  #else
28ea38b9cba68e Christophe Leroy 2019-02-21  353  static inline bool strict_kernel_rwx_enabled(void)
28ea38b9cba68e Christophe Leroy 2019-02-21  354  {
28ea38b9cba68e Christophe Leroy 2019-02-21  355  	return false;
28ea38b9cba68e Christophe Leroy 2019-02-21  356  }
28ea38b9cba68e Christophe Leroy 2019-02-21  357  #endif
4fcc636615b1a3 Jordan Niethe    2021-06-09  358  

:::::: The code at line 350 was first introduced by commit
:::::: 28ea38b9cba68eec55cf550acd6b36b6f507cd17 powerpc/mmu: add is_strict_kernel_rwx() helper

:::::: TO: Christophe Leroy <christophe.leroy@c-s.fr>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

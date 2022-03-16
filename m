Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074754DBA2A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358147AbiCPVdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358124AbiCPVdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:33:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3192654F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647466314; x=1679002314;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Bf4JKomAlruhcstNZW05X/lq3nwv0fgH8wbcIE/yYRA=;
  b=QrQai2jdTejgd6eIgBPmhvcNtj78Buq051559BX0e+W8mU4IzBInwiYo
   23mpXb3Dq+U+vnybO7z+BGx7WUkEKeDNPEqNNuwrWAuLKMTOjLVvUHwoR
   qSJsl+pCbZvJJnflOe9YrctUDNNJ+6anG4fcifm+eiy+abqASx7OjD+f3
   dBmo9ELPsonBAPkgiYLF+ZttA5UO7Q9r7jcTqSO/F3HfSKwIFy8hnw6+g
   Bisdbz1MovO1m4js6RsiXGar1ciBn99g/UCSSFFIFImFAC4+KKrcevNv5
   rU9KChONDv/sSj+XWfz93J4kT0/SzlYbkX0m1JrZtgicFPzageByBKbaj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="244169998"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="244169998"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 14:31:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="516503899"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2022 14:31:53 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUbFI-000Cxh-Ab; Wed, 16 Mar 2022 21:31:52 +0000
Date:   Thu, 17 Mar 2022 05:31:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1486/2335] arch/powerpc/include/asm/mmu.h:350:16:
 error: 'rodata_enabled' undeclared; did you mean 'radix_enabled'?
Message-ID: <202203170542.lLTUY4Wv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: c9cf83a54a72f523cc78474ba78110c9e89db2a6 [1486/2335] headers/deps: printk: Reduce <linux/printk.h> header dependencies
config: powerpc64-randconfig-r023-20220313 (https://download.01.org/0day-ci/archive/20220317/202203170542.lLTUY4Wv-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=c9cf83a54a72f523cc78474ba78110c9e89db2a6
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout c9cf83a54a72f523cc78474ba78110c9e89db2a6
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
>> arch/powerpc/include/asm/book3s/64/hash.h:244:22: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'hash__vmemmap_create_mapping'
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
>> arch/powerpc/include/asm/book3s/64/radix.h:289:22: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'radix__vmemmap_create_mapping'
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
>> arch/powerpc/include/asm/book3s/64/pgtable.h:1087:29: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'vmemmap_create_mapping'
    1087 | static inline int __meminit vmemmap_create_mapping(unsigned long start,
         |                             ^~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/mmu.h:405,
                    from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:17,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/preempt.h:10,
                    from arch/powerpc/kernel/asm-offsets.c:12:
>> arch/powerpc/include/asm/book3s/64/mmu.h:231:27: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'early_init_mmu'
     231 | static inline void __init early_init_mmu(void)
         |                           ^~~~~~~~~~~~~~
>> arch/powerpc/include/asm/book3s/64/mmu.h:262:13: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'radix_init_pseries'
     262 | void __init radix_init_pseries(void);
         |             ^~~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/paca.h:30,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/preempt.h:10,
                    from arch/powerpc/kernel/asm-offsets.c:12:
>> arch/powerpc/include/asm/cpuidle.h:88:12: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'validate_psscr_val_mask'
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

bab4c8de6289b46 Michael Ellerman 2016-07-27  346  
28ea38b9cba68ee Christophe Leroy 2019-02-21  347  #ifdef CONFIG_STRICT_KERNEL_RWX
28ea38b9cba68ee Christophe Leroy 2019-02-21  348  static inline bool strict_kernel_rwx_enabled(void)
28ea38b9cba68ee Christophe Leroy 2019-02-21  349  {
28ea38b9cba68ee Christophe Leroy 2019-02-21 @350  	return rodata_enabled;
28ea38b9cba68ee Christophe Leroy 2019-02-21  351  }
28ea38b9cba68ee Christophe Leroy 2019-02-21  352  #else
28ea38b9cba68ee Christophe Leroy 2019-02-21  353  static inline bool strict_kernel_rwx_enabled(void)
28ea38b9cba68ee Christophe Leroy 2019-02-21  354  {
28ea38b9cba68ee Christophe Leroy 2019-02-21  355  	return false;
28ea38b9cba68ee Christophe Leroy 2019-02-21  356  }
28ea38b9cba68ee Christophe Leroy 2019-02-21  357  #endif
4fcc636615b1a30 Jordan Niethe    2021-06-09  358  

:::::: The code at line 350 was first introduced by commit
:::::: 28ea38b9cba68eec55cf550acd6b36b6f507cd17 powerpc/mmu: add is_strict_kernel_rwx() helper

:::::: TO: Christophe Leroy <christophe.leroy@c-s.fr>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

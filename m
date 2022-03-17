Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1B84DBF32
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiCQGUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiCQGTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:19:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86DF12BFB3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 23:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647497352; x=1679033352;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZugeSjI0sgiqudJlLiKalDJUVo5trf+1L36TMXl41Wc=;
  b=Phv4xrJ2qkVZzrDVcWmqJR1vyjxQZKb64s4ZeXHdMy+fJvdGiVTYTfHK
   OJCUp15IvLKKiXYXW5NkJrGLzUlrrKvp+14Pxu/albcJ6ibjG/PrlCACe
   dNWawMMQ2ARZ/v8sGHRKKloMMDHv5FNRtSWxkT5YQTpAvIiWJDDm+bRna
   G2LxmAJxE+B0BHoAEttdxurFuA1aDIeDR+c3SGsa5DuNgW6BTA5Jj274V
   /lFEVT7J0+BgL1gXONJ1lwybyIydTKy3KREVUnMtVfTByNt8KzPc/huz6
   dpCNe0Hl4MhY85wxM1vYL3dmxzWgCIuuv4qpYhTjdtY8KrwJU+KQu+KPd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="343227627"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="343227627"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 23:09:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="646937954"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Mar 2022 23:09:10 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUjJu-000DMf-1N; Thu, 17 Mar 2022 06:09:10 +0000
Date:   Thu, 17 Mar 2022 14:09:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1459/2308]
 arch/powerpc/include/asm/cpuidle.h:88:5: error: non-static declaration of
 '__init' follows static declaration
Message-ID: <202203171426.C1DCYH7r-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   ef90a8d1de7ff54bfd0fcfe6371c20f544b14d6d
commit: 8fa058844b0ee9ec6ff329695e80271624683cd3 [1459/2308] headers/deps: printk: Reduce <linux/printk.h> header dependencies
config: powerpc64-randconfig-r002-20220317 (https://download.01.org/0day-ci/archive/20220317/202203171426.C1DCYH7r-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc64 cross compiling tool for clang build
        # apt-get install binutils-powerpc64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=8fa058844b0ee9ec6ff329695e80271624683cd3
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 8fa058844b0ee9ec6ff329695e80271624683cd3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/preempt.h:10:
   In file included from arch/powerpc/include/asm/current.h:13:
   In file included from arch/powerpc/include/asm/paca.h:17:
   In file included from arch/powerpc/include/asm/lppaca.h:46:
   In file included from arch/powerpc/include/asm/mmu.h:405:
   In file included from arch/powerpc/include/asm/book3s/64/mmu.h:39:
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20:
   In file included from arch/powerpc/include/asm/book3s/64/pgtable.h:299:
>> arch/powerpc/include/asm/book3s/64/hash.h:244:21: error: expected ';' after top level declarator
   extern int __meminit hash__vmemmap_create_mapping(unsigned long start,
                       ^
                       ;
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/preempt.h:10:
   In file included from arch/powerpc/include/asm/current.h:13:
   In file included from arch/powerpc/include/asm/paca.h:17:
   In file included from arch/powerpc/include/asm/lppaca.h:46:
   In file included from arch/powerpc/include/asm/mmu.h:405:
   In file included from arch/powerpc/include/asm/book3s/64/mmu.h:39:
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20:
   In file included from arch/powerpc/include/asm/book3s/64/pgtable.h:300:
>> arch/powerpc/include/asm/book3s/64/radix.h:289:21: error: expected ';' after top level declarator
   extern int __meminit radix__vmemmap_create_mapping(unsigned long start,
                       ^
                       ;
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/preempt.h:10:
   In file included from arch/powerpc/include/asm/current.h:13:
   In file included from arch/powerpc/include/asm/paca.h:17:
   In file included from arch/powerpc/include/asm/lppaca.h:46:
   In file included from arch/powerpc/include/asm/mmu.h:405:
   In file included from arch/powerpc/include/asm/book3s/64/mmu.h:39:
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20:
>> arch/powerpc/include/asm/book3s/64/pgtable.h:1087:8: error: 'inline' can only appear on functions
   static inline int __meminit vmemmap_create_mapping(unsigned long start,
          ^
   include/linux/compiler_types.h:149:16: note: expanded from macro 'inline'
   #define inline inline __gnu_inline __inline_maybe_unused notrace
                  ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/preempt.h:10:
   In file included from arch/powerpc/include/asm/current.h:13:
   In file included from arch/powerpc/include/asm/paca.h:17:
   In file included from arch/powerpc/include/asm/lppaca.h:46:
   In file included from arch/powerpc/include/asm/mmu.h:405:
   In file included from arch/powerpc/include/asm/book3s/64/mmu.h:39:
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20:
>> arch/powerpc/include/asm/book3s/64/pgtable.h:1087:8: warning: '__gnu_inline__' attribute only applies to functions [-Wignored-attributes]
   include/linux/compiler_types.h:149:23: note: expanded from macro 'inline'
   #define inline inline __gnu_inline __inline_maybe_unused notrace
                         ^
   include/linux/compiler_attributes.h:160:56: note: expanded from macro '__gnu_inline'
   #define __gnu_inline                    __attribute__((__gnu_inline__))
                                                          ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/preempt.h:10:
   In file included from arch/powerpc/include/asm/current.h:13:
   In file included from arch/powerpc/include/asm/paca.h:17:
   In file included from arch/powerpc/include/asm/lppaca.h:46:
   In file included from arch/powerpc/include/asm/mmu.h:405:
   In file included from arch/powerpc/include/asm/book3s/64/mmu.h:39:
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20:
>> arch/powerpc/include/asm/book3s/64/pgtable.h:1087:8: warning: '__no_instrument_function__' attribute only applies to functions and Objective-C methods [-Wignored-attributes]
   include/linux/compiler_types.h:149:58: note: expanded from macro 'inline'
   #define inline inline __gnu_inline __inline_maybe_unused notrace
                                                            ^
   include/linux/compiler_types.h:129:34: note: expanded from macro 'notrace'
   #define notrace                 __attribute__((__no_instrument_function__))
                                                  ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/preempt.h:10:
   In file included from arch/powerpc/include/asm/current.h:13:
   In file included from arch/powerpc/include/asm/paca.h:17:
   In file included from arch/powerpc/include/asm/lppaca.h:46:
   In file included from arch/powerpc/include/asm/mmu.h:405:
   In file included from arch/powerpc/include/asm/book3s/64/mmu.h:39:
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20:
>> arch/powerpc/include/asm/book3s/64/pgtable.h:1087:19: error: static declaration of '__meminit' follows non-static declaration
   static inline int __meminit vmemmap_create_mapping(unsigned long start,
                     ^
   arch/powerpc/include/asm/book3s/64/radix.h:289:12: note: previous declaration is here
   extern int __meminit radix__vmemmap_create_mapping(unsigned long start,
              ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/preempt.h:10:
   In file included from arch/powerpc/include/asm/current.h:13:
   In file included from arch/powerpc/include/asm/paca.h:17:
   In file included from arch/powerpc/include/asm/lppaca.h:46:
   In file included from arch/powerpc/include/asm/mmu.h:405:
   In file included from arch/powerpc/include/asm/book3s/64/mmu.h:39:
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20:
>> arch/powerpc/include/asm/book3s/64/pgtable.h:1087:28: error: expected ';' after top level declarator
   static inline int __meminit vmemmap_create_mapping(unsigned long start,
                              ^
                              ;
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/preempt.h:10:
   In file included from arch/powerpc/include/asm/current.h:13:
   In file included from arch/powerpc/include/asm/paca.h:17:
   In file included from arch/powerpc/include/asm/lppaca.h:46:
   In file included from arch/powerpc/include/asm/mmu.h:405:
>> arch/powerpc/include/asm/book3s/64/mmu.h:231:8: error: 'inline' can only appear on functions
   static inline void __init early_init_mmu(void)
          ^
   include/linux/compiler_types.h:149:16: note: expanded from macro 'inline'
   #define inline inline __gnu_inline __inline_maybe_unused notrace
                  ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/preempt.h:10:
   In file included from arch/powerpc/include/asm/current.h:13:
   In file included from arch/powerpc/include/asm/paca.h:17:
   In file included from arch/powerpc/include/asm/lppaca.h:46:
   In file included from arch/powerpc/include/asm/mmu.h:405:
>> arch/powerpc/include/asm/book3s/64/mmu.h:231:8: warning: '__gnu_inline__' attribute only applies to functions [-Wignored-attributes]
   include/linux/compiler_types.h:149:23: note: expanded from macro 'inline'
   #define inline inline __gnu_inline __inline_maybe_unused notrace
                         ^
   include/linux/compiler_attributes.h:160:56: note: expanded from macro '__gnu_inline'
   #define __gnu_inline                    __attribute__((__gnu_inline__))
                                                          ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/preempt.h:10:
   In file included from arch/powerpc/include/asm/current.h:13:
   In file included from arch/powerpc/include/asm/paca.h:17:
   In file included from arch/powerpc/include/asm/lppaca.h:46:
   In file included from arch/powerpc/include/asm/mmu.h:405:
>> arch/powerpc/include/asm/book3s/64/mmu.h:231:8: warning: '__no_instrument_function__' attribute only applies to functions and Objective-C methods [-Wignored-attributes]
   include/linux/compiler_types.h:149:58: note: expanded from macro 'inline'
   #define inline inline __gnu_inline __inline_maybe_unused notrace
                                                            ^
   include/linux/compiler_types.h:129:34: note: expanded from macro 'notrace'
   #define notrace                 __attribute__((__no_instrument_function__))
                                                  ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/preempt.h:10:
   In file included from arch/powerpc/include/asm/current.h:13:
   In file included from arch/powerpc/include/asm/paca.h:17:
   In file included from arch/powerpc/include/asm/lppaca.h:46:
   In file included from arch/powerpc/include/asm/mmu.h:405:
>> arch/powerpc/include/asm/book3s/64/mmu.h:231:20: error: variable has incomplete type 'void'
   static inline void __init early_init_mmu(void)
                      ^
>> arch/powerpc/include/asm/book3s/64/mmu.h:231:26: error: expected ';' after top level declarator
   static inline void __init early_init_mmu(void)
                            ^
                            ;
>> arch/powerpc/include/asm/book3s/64/mmu.h:243:9: error: implicit declaration of function 'hash__early_init_mmu_secondary' [-Werror,-Wimplicit-function-declaration]
           return hash__early_init_mmu_secondary();
                  ^
   arch/powerpc/include/asm/book3s/64/mmu.h:243:9: note: did you mean 'radix__early_init_mmu_secondary'?
   arch/powerpc/include/asm/book3s/64/mmu.h:238:13: note: 'radix__early_init_mmu_secondary' declared here
   extern void radix__early_init_mmu_secondary(void);
               ^
>> arch/powerpc/include/asm/book3s/64/mmu.h:243:2: error: void function 'early_init_mmu_secondary' should not return a value [-Wreturn-type]
           return hash__early_init_mmu_secondary();
           ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/mmu.h:262:6: error: variable has incomplete type 'void'
   void __init radix_init_pseries(void);
        ^
   arch/powerpc/include/asm/book3s/64/mmu.h:262:12: error: expected ';' after top level declarator
   void __init radix_init_pseries(void);
              ^
              ;
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/preempt.h:10:
   In file included from arch/powerpc/include/asm/current.h:13:
   In file included from arch/powerpc/include/asm/paca.h:30:
>> arch/powerpc/include/asm/cpuidle.h:88:5: error: non-static declaration of '__init' follows static declaration
   int __init validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags);
       ^
   arch/powerpc/include/asm/book3s/64/mmu.h:231:20: note: previous definition is here
   static inline void __init early_init_mmu(void)
                      ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/preempt.h:10:
   In file included from arch/powerpc/include/asm/current.h:13:
   In file included from arch/powerpc/include/asm/paca.h:30:
>> arch/powerpc/include/asm/cpuidle.h:88:11: error: expected ';' after top level declarator
   int __init validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags);
             ^
             ;
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/preempt.h:79:
   In file included from ./arch/powerpc/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/sched/thread_info_api.h:5:
   In file included from include/linux/sched.h:12:
   include/linux/sched/per_task.h:48:11: fatal error: 'generated/asm-offsets.h' file not found
   # include <generated/asm-offsets.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~
   4 warnings and 15 errors generated.
   make[2]: *** [scripts/Makefile.build:121: arch/powerpc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/__init +88 arch/powerpc/include/asm/cpuidle.h

09206b600c76f2 Gautham R. Shenoy 2017-01-25   86  
a7cd88da970405 Gautham R. Shenoy 2017-03-22   87  unsigned long pnv_cpu_offline(unsigned int cpu);
e5913db1ef2281 Nick Child        2021-12-16  @88  int __init validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags);
09206b600c76f2 Gautham R. Shenoy 2017-01-25   89  static inline void report_invalid_psscr_val(u64 psscr_val, int err)
09206b600c76f2 Gautham R. Shenoy 2017-01-25   90  {
09206b600c76f2 Gautham R. Shenoy 2017-01-25   91  	switch (err) {
09206b600c76f2 Gautham R. Shenoy 2017-01-25   92  	case ERR_EC_ESL_MISMATCH:
09206b600c76f2 Gautham R. Shenoy 2017-01-25   93  		pr_warn("Invalid psscr 0x%016llx : ESL,EC bits unequal",
09206b600c76f2 Gautham R. Shenoy 2017-01-25   94  			psscr_val);
09206b600c76f2 Gautham R. Shenoy 2017-01-25   95  		break;
09206b600c76f2 Gautham R. Shenoy 2017-01-25   96  	case ERR_DEEP_STATE_ESL_MISMATCH:
09206b600c76f2 Gautham R. Shenoy 2017-01-25   97  		pr_warn("Invalid psscr 0x%016llx : ESL cleared for deep stop-state",
09206b600c76f2 Gautham R. Shenoy 2017-01-25   98  			psscr_val);
09206b600c76f2 Gautham R. Shenoy 2017-01-25   99  	}
09206b600c76f2 Gautham R. Shenoy 2017-01-25  100  }
7cba160ad789a3 Shreyas B. Prabhu 2014-12-10  101  #endif
7cba160ad789a3 Shreyas B. Prabhu 2014-12-10  102  

:::::: The code at line 88 was first introduced by commit
:::::: e5913db1ef22817e128f0a794752f7393205e00b powerpc/powernv: Add __init attribute to eligible functions

:::::: TO: Nick Child <nick.child@ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197CF4C1C55
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244473AbiBWTha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244466AbiBWThY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:37:24 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93B43526C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645645015; x=1677181015;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XejRFWffjzHpWmroA4DZ5EqnJeS+quUD9WS2FcF0R0U=;
  b=Ix+TIk1IZvUT2WyAfph4dETSZLZ5XgEZSMmb4RTnB9exVyGwV3KnN9QH
   V1LWc3D51++gWZW+sPFI5hrAgX7zVM5PV3olppr5wyXwgzEscIcLY7375
   NkEkXKSTBJ1EMKVyk73jpF5CQrGrGSSRlZpBUUYAVLffh/PMQywtgblL8
   COHRI75nnwNl84dhenyS6LnuKsOuFTZHaqbgdYDfo3DncSIbpqSovNAzA
   DriIHr/fbraFYYUJtDRDIwjm0yDcFywsjyysGErM6wma+aTXhQiE4nzOB
   kJW9b4tTg/HWkF5vaMiqqcffz9QLVGfKuVmUpmHdqeUPEH9O8C4zWssWR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="232686536"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="232686536"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 11:36:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="684019896"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2022 11:36:45 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMxRM-0001kE-NR; Wed, 23 Feb 2022 19:36:44 +0000
Date:   Thu, 24 Feb 2022 03:36:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1471/2340]
 arch/powerpc/include/asm/mmu.h:350:9: error: use of undeclared identifier
 'rodata_enabled'; did you mean 'radix_enabled'?
Message-ID: <202202240339.NOVtjfye-lkp@intel.com>
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
head:   97c5eeb4de3ad324ed2a4656b46465299cfd010a
commit: 0ca8be0dc3575bd4f7e5e9c4b84cf200f5a8e494 [1471/2340] headers/deps: printk: Reduce <linux/printk.h> header dependencies
config: powerpc64-randconfig-r013-20220223 (https://download.01.org/0day-ci/archive/20220224/202202240339.NOVtjfye-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc64 cross compiling tool for clang build
        # apt-get install binutils-powerpc64le-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=0ca8be0dc3575bd4f7e5e9c4b84cf200f5a8e494
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 0ca8be0dc3575bd4f7e5e9c4b84cf200f5a8e494
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
>> arch/powerpc/include/asm/mmu.h:350:9: error: use of undeclared identifier 'rodata_enabled'; did you mean 'radix_enabled'?
           return rodata_enabled;
                  ^~~~~~~~~~~~~~
                  radix_enabled
   arch/powerpc/include/asm/mmu.h:337:29: note: 'radix_enabled' declared here
   static __always_inline bool radix_enabled(void)
                               ^
>> arch/powerpc/include/asm/mmu.h:350:9: warning: address of function 'radix_enabled' will always evaluate to 'true' [-Wpointer-bool-conversion]
           return rodata_enabled;
           ~~~~~~ ^~~~~~~~~~~~~~
   arch/powerpc/include/asm/mmu.h:350:9: note: prefix with the address-of operator to silence this warning
           return rodata_enabled;
                  ^
                  &
   arch/powerpc/include/asm/mmu.h:350:9: note: suffix with parentheses to turn this into a function call
           return rodata_enabled;
                  ^
                                ()
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
>> arch/powerpc/include/asm/book3s/64/pgtable.h:1241:6: error: implicit declaration of function 'pmd_pte' [-Werror,-Wimplicit-function-declaration]
           if (__pmd_write((*pmdp)))
               ^
   arch/powerpc/include/asm/book3s/64/pgtable.h:1162:38: note: expanded from macro '__pmd_write'
   #define __pmd_write(pmd)        __pte_write(pmd_pte(pmd))
                                               ^
>> arch/powerpc/include/asm/book3s/64/pgtable.h:1241:6: error: passing 'int' to parameter of incompatible type 'pte_t'
           if (__pmd_write((*pmdp)))
               ^~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/pgtable.h:1162:38: note: expanded from macro '__pmd_write'
   #define __pmd_write(pmd)        __pte_write(pmd_pte(pmd))
                                               ^~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/pgtable.h:419:37: note: passing argument to parameter 'pte' here
   static inline int __pte_write(pte_t pte)
                                       ^
   arch/powerpc/include/asm/book3s/64/pgtable.h:1243:20: error: passing 'int' to parameter of incompatible type 'pte_t'
           else if (unlikely(pmd_savedwrite(*pmdp)))
                    ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/pgtable.h:1163:44: note: expanded from macro 'pmd_savedwrite'
   #define pmd_savedwrite(pmd)     pte_savedwrite(pmd_pte(pmd))
                                                  ^
   include/linux/compiler.h:48:41: note: expanded from macro 'unlikely'
   #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
                            ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:33:34: note: expanded from macro '__branch_check__'
                           ______r = __builtin_expect(!!(x), expect);      \
                                                         ^
   arch/powerpc/include/asm/book3s/64/pgtable.h:439:41: note: passing argument to parameter 'pte' here
   static inline bool pte_savedwrite(pte_t pte)
                                           ^
   arch/powerpc/include/asm/book3s/64/pgtable.h:1243:20: error: passing 'int' to parameter of incompatible type 'pte_t'
           else if (unlikely(pmd_savedwrite(*pmdp)))
                    ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/pgtable.h:1163:44: note: expanded from macro 'pmd_savedwrite'
   #define pmd_savedwrite(pmd)     pte_savedwrite(pmd_pte(pmd))
                                                  ^
   include/linux/compiler.h:48:68: note: expanded from macro 'unlikely'
   #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   include/linux/compiler.h:35:19: note: expanded from macro '__branch_check__'
                                                expect, is_constant);      \
                                                        ^~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/pgtable.h:439:41: note: passing argument to parameter 'pte' here
   static inline bool pte_savedwrite(pte_t pte)
                                           ^
   arch/powerpc/include/asm/book3s/64/pgtable.h:1380:20: error: implicit declaration of function 'pmd_pte' [-Werror,-Wimplicit-function-declaration]
           return pte_devmap(pmd_pte(pmd));
                             ^
   arch/powerpc/include/asm/book3s/64/pgtable.h:1380:20: error: passing 'int' to parameter of incompatible type 'pte_t'
           return pte_devmap(pmd_pte(pmd));
                             ^~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/pgtable.h:733:36: note: passing argument to parameter 'pte' here
   static inline int pte_devmap(pte_t pte)
                                      ^
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
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   5 warnings and 20 errors generated.
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

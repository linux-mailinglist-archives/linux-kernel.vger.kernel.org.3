Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D22A4FAA9F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 22:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiDIUIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 16:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiDIUIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 16:08:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B034BB918A
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 13:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649534782; x=1681070782;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q7lXXZrcGokbjzctTDksAKVLmdp98vhQZuyXwN4SL8M=;
  b=YgTDUnsKfwUaIpECzjJgMUsUsSiNdRr/t+UH5SU8bX5GvVVxcosIvjd0
   S2qPWkv2hV8IjZ3Y9anYozY9O8Gyjw8+ubKVyDsLboUU/eL42JbO0b5as
   ZSQb9GsMJ4oG8omK/WVgPTnVpHrp44KVczEsZIS66Xoc7sbexmdwjuz4N
   dlcySmZvnwW6sSogr8ZcXKunWdPk8wMfjnx+3DfkQ1q+tGPzED+VwkYf0
   f5ANIRZCSn3pP7srhWYGsFyYb0hPhbGOijc8MCi3ifNLlIdZ5M9/iSuv0
   lMzAzGXwCwSFFRzzk3hz1e6LRPTsh/kBzGvLN7lIPDg1k2lC95C1G42ac
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="242492298"
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="242492298"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 13:06:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="622282447"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Apr 2022 13:06:20 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndHLg-0000MM-6p;
        Sat, 09 Apr 2022 20:06:20 +0000
Date:   Sun, 10 Apr 2022 04:05:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, zx2c4@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [crng-random:jd/not-zero-entropy 3/12]
 include/linux/atomic/atomic-arch-fallback.h:1280:23: error: implicit
 declaration of function 'arch_atomic64_read'; did you mean
 'arch_atomic_read'?
Message-ID: <202204100416.eSEuEs1x-lkp@intel.com>
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

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git jd/not-zero-entropy
head:   486542a037a538637136e706bb2e636c6b591b5d
commit: b4eebe6411b3edfb28f613b77f41d4f30676ac0e [3/12] random: use sched_clock() for random_get_entropy() if no get_cycles()
config: powerpc64-randconfig-r032-20220410 (https://download.01.org/0day-ci/archive/20220410/202204100416.eSEuEs1x-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=b4eebe6411b3edfb28f613b77f41d4f30676ac0e
        git remote add crng-random git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
        git fetch --no-tags crng-random jd/not-zero-entropy
        git checkout b4eebe6411b3edfb28f613b77f41d4f30676ac0e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/atomic.h:80,
                    from include/linux/cpumask.h:13,
                    from include/linux/smp.h:13,
                    from include/linux/sched/clock.h:5,
                    from include/linux/timex.h:64,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from arch/powerpc/kernel/vdso/vgettimeofday.c:5:
   include/linux/atomic/atomic-arch-fallback.h: In function 'arch_atomic64_read_acquire':
>> include/linux/atomic/atomic-arch-fallback.h:1280:23: error: implicit declaration of function 'arch_atomic64_read'; did you mean 'arch_atomic_read'? [-Werror=implicit-function-declaration]
    1280 |                 ret = arch_atomic64_read(v);
         |                       ^~~~~~~~~~~~~~~~~~
         |                       arch_atomic_read
   include/linux/atomic/atomic-arch-fallback.h: In function 'arch_atomic64_set_release':
>> include/linux/atomic/atomic-arch-fallback.h:1297:17: error: implicit declaration of function 'arch_atomic64_set'; did you mean 'arch_atomic_set'? [-Werror=implicit-function-declaration]
    1297 |                 arch_atomic64_set(v, i);
         |                 ^~~~~~~~~~~~~~~~~
         |                 arch_atomic_set
   include/linux/atomic/atomic-arch-fallback.h: In function 'arch_atomic64_inc':
>> include/linux/atomic/atomic-arch-fallback.h:1475:9: error: implicit declaration of function 'arch_atomic64_add'; did you mean 'arch_atomic_add'? [-Werror=implicit-function-declaration]
    1475 |         arch_atomic64_add(1, v);
         |         ^~~~~~~~~~~~~~~~~
         |         arch_atomic_add
   include/linux/atomic/atomic-arch-fallback.h: In function 'arch_atomic64_inc_return':
>> include/linux/atomic/atomic-arch-fallback.h:1491:16: error: implicit declaration of function 'arch_atomic64_add_return'; did you mean 'arch_atomic_add_return'? [-Werror=implicit-function-declaration]
    1491 |         return arch_atomic64_add_return(1, v);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~
         |                arch_atomic_add_return
   include/linux/atomic/atomic-arch-fallback.h: In function 'arch_atomic64_fetch_inc':
>> include/linux/atomic/atomic-arch-fallback.h:1572:16: error: implicit declaration of function 'arch_atomic64_fetch_add'; did you mean 'arch_atomic_fetch_add'? [-Werror=implicit-function-declaration]
    1572 |         return arch_atomic64_fetch_add(1, v);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
         |                arch_atomic_fetch_add
   include/linux/atomic/atomic-arch-fallback.h: In function 'arch_atomic64_dec':
>> include/linux/atomic/atomic-arch-fallback.h:1646:9: error: implicit declaration of function 'arch_atomic64_sub'; did you mean 'arch_atomic_sub'? [-Werror=implicit-function-declaration]
    1646 |         arch_atomic64_sub(1, v);
         |         ^~~~~~~~~~~~~~~~~
         |         arch_atomic_sub
   include/linux/atomic/atomic-arch-fallback.h: In function 'arch_atomic64_dec_return':
>> include/linux/atomic/atomic-arch-fallback.h:1662:16: error: implicit declaration of function 'arch_atomic64_sub_return'; did you mean 'arch_atomic_sub_return'? [-Werror=implicit-function-declaration]
    1662 |         return arch_atomic64_sub_return(1, v);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~
         |                arch_atomic_sub_return
   include/linux/atomic/atomic-arch-fallback.h: In function 'arch_atomic64_fetch_dec':
>> include/linux/atomic/atomic-arch-fallback.h:1743:16: error: implicit declaration of function 'arch_atomic64_fetch_sub'; did you mean 'arch_atomic_fetch_sub'? [-Werror=implicit-function-declaration]
    1743 |         return arch_atomic64_fetch_sub(1, v);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
         |                arch_atomic_fetch_sub
   include/linux/atomic/atomic-arch-fallback.h: In function 'arch_atomic64_andnot':
>> include/linux/atomic/atomic-arch-fallback.h:1859:9: error: implicit declaration of function 'arch_atomic64_and'; did you mean 'arch_atomic64_inc'? [-Werror=implicit-function-declaration]
    1859 |         arch_atomic64_and(~i, v);
         |         ^~~~~~~~~~~~~~~~~
         |         arch_atomic64_inc
   include/linux/atomic/atomic-arch-fallback.h: In function 'arch_atomic64_fetch_andnot':
>> include/linux/atomic/atomic-arch-fallback.h:1875:16: error: implicit declaration of function 'arch_atomic64_fetch_and'; did you mean 'arch_atomic64_fetch_inc'? [-Werror=implicit-function-declaration]
    1875 |         return arch_atomic64_fetch_and(~i, v);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
         |                arch_atomic64_fetch_inc
   include/linux/atomic/atomic-arch-fallback.h: In function 'arch_atomic64_try_cmpxchg':
>> include/linux/atomic/atomic-arch-fallback.h:2125:13: error: implicit declaration of function 'arch_atomic64_cmpxchg'; did you mean 'arch_atomic_cmpxchg'? [-Werror=implicit-function-declaration]
    2125 |         r = arch_atomic64_cmpxchg(v, o, new);
         |             ^~~~~~~~~~~~~~~~~~~~~
         |             arch_atomic_cmpxchg
   In file included from include/linux/atomic.h:81,
                    from include/linux/cpumask.h:13,
                    from include/linux/smp.h:13,
                    from include/linux/sched/clock.h:5,
                    from include/linux/timex.h:64,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from arch/powerpc/kernel/vdso/vgettimeofday.c:5:
   include/linux/atomic/atomic-long.h: In function 'arch_atomic_long_or':
>> include/linux/atomic/atomic-long.h:329:9: error: implicit declaration of function 'arch_atomic64_or'; did you mean 'arch_atomic_or'? [-Werror=implicit-function-declaration]
     329 |         arch_atomic64_or(i, v);
         |         ^~~~~~~~~~~~~~~~
         |         arch_atomic_or
   include/linux/atomic/atomic-long.h: In function 'arch_atomic_long_fetch_or':
>> include/linux/atomic/atomic-long.h:335:16: error: implicit declaration of function 'arch_atomic64_fetch_or'; did you mean 'arch_atomic_fetch_or'? [-Werror=implicit-function-declaration]
     335 |         return arch_atomic64_fetch_or(i, v);
         |                ^~~~~~~~~~~~~~~~~~~~~~
         |                arch_atomic_fetch_or
   include/linux/atomic/atomic-long.h: In function 'arch_atomic_long_xor':
>> include/linux/atomic/atomic-long.h:359:9: error: implicit declaration of function 'arch_atomic64_xor'; did you mean 'arch_atomic_xor'? [-Werror=implicit-function-declaration]
     359 |         arch_atomic64_xor(i, v);
         |         ^~~~~~~~~~~~~~~~~
         |         arch_atomic_xor
   include/linux/atomic/atomic-long.h: In function 'arch_atomic_long_fetch_xor':
>> include/linux/atomic/atomic-long.h:365:16: error: implicit declaration of function 'arch_atomic64_fetch_xor'; did you mean 'arch_atomic_fetch_xor'? [-Werror=implicit-function-declaration]
     365 |         return arch_atomic64_fetch_xor(i, v);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
         |                arch_atomic_fetch_xor
   include/linux/atomic/atomic-long.h: In function 'arch_atomic_long_xchg':
>> include/linux/atomic/atomic-long.h:389:16: error: implicit declaration of function 'arch_atomic64_xchg'; did you mean 'arch_atomic_xchg'? [-Werror=implicit-function-declaration]
     389 |         return arch_atomic64_xchg(v, i);
         |                ^~~~~~~~~~~~~~~~~~
         |                arch_atomic_xchg
   In file included from include/linux/compiler_types.h:73,
                    from <command-line>:
   include/linux/smp.h: At top level:
>> include/linux/smp.h:34:33: error: requested alignment '20' is not a positive power of 2
      34 |         __aligned(sizeof(struct __call_single_data));
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:33:68: note: in definition of macro '__aligned'
      33 | #define __aligned(x)                    __attribute__((__aligned__(x)))
         |                                                                    ^
   In file included from arch/powerpc/include/asm/book3s/64/hash.h:18,
                    from arch/powerpc/include/asm/book3s/64/pgtable.h:299,
                    from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:38,
                    from arch/powerpc/include/asm/mmu.h:405,
                    from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:17,
                    from arch/powerpc/include/asm/ptrace.h:150,
                    from arch/powerpc/include/asm/processor.h:42,
                    from arch/powerpc/include/asm/thread_info.h:40,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/smp.h:110,
                    from include/linux/sched/clock.h:5,
                    from include/linux/timex.h:64,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from arch/powerpc/kernel/vdso/vgettimeofday.c:5:
   arch/powerpc/include/asm/book3s/64/hash-4k.h: In function 'pte_set_hidx':
>> arch/powerpc/include/asm/book3s/64/hash-4k.h:103:22: warning: left shift count >= width of type [-Wshift-count-overflow]
     103 |         return (hidx << H_PAGE_F_GIX_SHIFT) &
         |                      ^~
   In file included from arch/powerpc/include/asm/book3s/64/pgtable.h:299,
                    from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:38,
                    from arch/powerpc/include/asm/mmu.h:405,
                    from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:17,
                    from arch/powerpc/include/asm/ptrace.h:150,
                    from arch/powerpc/include/asm/processor.h:42,
                    from arch/powerpc/include/asm/thread_info.h:40,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/smp.h:110,
                    from include/linux/sched/clock.h:5,
                    from include/linux/timex.h:64,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from arch/powerpc/kernel/vdso/vgettimeofday.c:5:
   arch/powerpc/include/asm/book3s/64/hash.h: In function 'get_region_id':
>> arch/powerpc/include/asm/book3s/64/hash.h:114:22: warning: right shift count >= width of type [-Wshift-count-overflow]
     114 |         int id = (ea >> 60UL);
         |                      ^~
   arch/powerpc/include/asm/book3s/64/hash-4k.h:23:47: warning: left shift count >= width of type [-Wshift-count-overflow]
      23 | #define H_KERN_MAP_SIZE         (ASM_CONST(1) << REGION_SHIFT)
         |                                               ^~
   arch/powerpc/include/asm/book3s/64/hash.h:86:59: note: in definition of macro 'NON_LINEAR_REGION_ID'
      86 | #define NON_LINEAR_REGION_ID(ea)        ((((unsigned long)ea - H_KERN_VIRT_START) >> REGION_SHIFT) + 2)
         |                                                           ^~
   arch/powerpc/include/asm/book3s/64/hash.h:75:33: note: in expansion of macro 'H_KERN_MAP_SIZE'
      75 | #define H_VMALLOC_SIZE          H_KERN_MAP_SIZE
         |                                 ^~~~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/hash.h:76:52: note: in expansion of macro 'H_VMALLOC_SIZE'
      76 | #define H_VMALLOC_END           (H_VMALLOC_START + H_VMALLOC_SIZE)
         |                                                    ^~~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/hash.h:78:33: note: in expansion of macro 'H_VMALLOC_END'
      78 | #define H_KERN_IO_START         H_VMALLOC_END
         |                                 ^~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/hash.h:80:34: note: in expansion of macro 'H_KERN_IO_START'
      80 | #define H_KERN_IO_END           (H_KERN_IO_START + H_KERN_IO_SIZE)
         |                                  ^~~~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/hash.h:82:33: note: in expansion of macro 'H_KERN_IO_END'
      82 | #define H_VMEMMAP_START         H_KERN_IO_END
         |                                 ^~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/hash.h:95:54: note: in expansion of macro 'H_VMEMMAP_START'
      95 | #define VMEMMAP_REGION_ID       NON_LINEAR_REGION_ID(H_VMEMMAP_START)
         |                                                      ^~~~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/hash.h:96:34: note: in expansion of macro 'VMEMMAP_REGION_ID'
      96 | #define INVALID_REGION_ID       (VMEMMAP_REGION_ID + 1)
         |                                  ^~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/hash.h:120:24: note: in expansion of macro 'INVALID_REGION_ID'
     120 |                 return INVALID_REGION_ID;
         |                        ^~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/hash-4k.h:23:47: warning: left shift count >= width of type [-Wshift-count-overflow]
      23 | #define H_KERN_MAP_SIZE         (ASM_CONST(1) << REGION_SHIFT)
         |                                               ^~
   arch/powerpc/include/asm/book3s/64/hash.h:86:59: note: in definition of macro 'NON_LINEAR_REGION_ID'
      86 | #define NON_LINEAR_REGION_ID(ea)        ((((unsigned long)ea - H_KERN_VIRT_START) >> REGION_SHIFT) + 2)
         |                                                           ^~
   arch/powerpc/include/asm/book3s/64/hash.h:79:33: note: in expansion of macro 'H_KERN_MAP_SIZE'
      79 | #define H_KERN_IO_SIZE          H_KERN_MAP_SIZE
         |                                 ^~~~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/hash.h:80:52: note: in expansion of macro 'H_KERN_IO_SIZE'
      80 | #define H_KERN_IO_END           (H_KERN_IO_START + H_KERN_IO_SIZE)
         |                                                    ^~~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/hash.h:82:33: note: in expansion of macro 'H_KERN_IO_END'
      82 | #define H_VMEMMAP_START         H_KERN_IO_END
         |                                 ^~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/hash.h:95:54: note: in expansion of macro 'H_VMEMMAP_START'
      95 | #define VMEMMAP_REGION_ID       NON_LINEAR_REGION_ID(H_VMEMMAP_START)
         |                                                      ^~~~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/hash.h:96:34: note: in expansion of macro 'VMEMMAP_REGION_ID'
      96 | #define INVALID_REGION_ID       (VMEMMAP_REGION_ID + 1)
         |                                  ^~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/hash.h:120:24: note: in expansion of macro 'INVALID_REGION_ID'
     120 |                 return INVALID_REGION_ID;
         |                        ^~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/book3s/64/pgtable.h:300,
                    from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:38,
                    from arch/powerpc/include/asm/mmu.h:405,
                    from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:17,
                    from arch/powerpc/include/asm/ptrace.h:150,
                    from arch/powerpc/include/asm/processor.h:42,
                    from arch/powerpc/include/asm/thread_info.h:40,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/smp.h:110,
                    from include/linux/sched/clock.h:5,
                    from include/linux/timex.h:64,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from arch/powerpc/kernel/vdso/vgettimeofday.c:5:
   arch/powerpc/include/asm/book3s/64/radix.h: In function 'radix__get_tree_size':
>> arch/powerpc/include/asm/book3s/64/radix.h:309:29: warning: left shift count >= width of type [-Wshift-count-overflow]
     309 |         rts_field |= (0x2UL << 61);
         |                             ^~
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:38,
                    from arch/powerpc/include/asm/mmu.h:405,
                    from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:17,
                    from arch/powerpc/include/asm/ptrace.h:150,
                    from arch/powerpc/include/asm/processor.h:42,
                    from arch/powerpc/include/asm/thread_info.h:40,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/smp.h:110,
                    from include/linux/sched/clock.h:5,
                    from include/linux/timex.h:64,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from arch/powerpc/kernel/vdso/vgettimeofday.c:5:
   arch/powerpc/include/asm/book3s/64/pgtable.h: In function 'pte_pfn':
   arch/powerpc/include/asm/book3s/64/pgtable.h:107:32: warning: left shift count >= width of type [-Wshift-count-overflow]
     107 | #define PTE_RPN_MASK    (((1UL << _PAGE_PA_MAX) - 1) & (PAGE_MASK))
         |                                ^~
   arch/powerpc/include/asm/book3s/64/pgtable.h:653:32: note: in expansion of macro 'PTE_RPN_MASK'
     653 |         return (pte_val(pte) & PTE_RPN_MASK) >> PAGE_SHIFT;
         |                                ^~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/page.h:299,
                    from arch/powerpc/include/asm/vdso/gettimeofday.h:7,
                    from include/vdso/datapage.h:137,
                    from lib/vdso/gettimeofday.c:5,
                    from <command-line>:
   arch/powerpc/include/asm/book3s/64/pgtable.h: In function 'pte_modify':
   arch/powerpc/include/asm/book3s/64/pgtable.h:107:32: warning: left shift count >= width of type [-Wshift-count-overflow]
     107 | #define PTE_RPN_MASK    (((1UL << _PAGE_PA_MAX) - 1) & (PAGE_MASK))
         |                                ^~
   arch/powerpc/include/asm/pgtable-be-types.h:10:37: note: in definition of macro '__pte_raw'
      10 | #define __pte_raw(x)    ((pte_t) { (x) })
         |                                     ^
   include/linux/byteorder/generic.h:92:21: note: in expansion of macro '__cpu_to_be64'
      92 | #define cpu_to_be64 __cpu_to_be64
         |                     ^~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/pgtable.h:127:26: note: in expansion of macro 'PTE_RPN_MASK'
     127 | #define _PAGE_CHG_MASK  (PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
         |                          ^~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/64/pgtable.h:743:54: note: in expansion of macro '_PAGE_CHG_MASK'
     743 |         return __pte_raw((pte_raw(pte) & cpu_to_be64(_PAGE_CHG_MASK)) |
         |                                                      ^~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/book3s/64/mmu.h:38,
                    from arch/powerpc/include/asm/mmu.h:405,
                    from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:17,
                    from arch/powerpc/include/asm/ptrace.h:150,
                    from arch/powerpc/include/asm/processor.h:42,
                    from arch/powerpc/include/asm/thread_info.h:40,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/smp.h:110,
                    from include/linux/sched/clock.h:5,
                    from include/linux/timex.h:64,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from arch/powerpc/kernel/vdso/vgettimeofday.c:5:
   arch/powerpc/include/asm/book3s/64/mmu-hash.h: In function 'segment_shift':
   arch/powerpc/include/asm/book3s/64/mmu-hash.h:262:24: error: 'SID_SHIFT' undeclared (first use in this function); did you mean 'PUD_SHIFT'?
     262 |                 return SID_SHIFT;
         |                        ^~~~~~~~~
         |                        PUD_SHIFT
   arch/powerpc/include/asm/book3s/64/mmu-hash.h:262:24: note: each undeclared identifier is reported only once for each function it appears in
   arch/powerpc/include/asm/book3s/64/mmu-hash.h:263:16: error: 'SID_SHIFT_1T' undeclared (first use in this function); did you mean 'SLB_VSID_SHIFT_1T'?
     263 |         return SID_SHIFT_1T;
         |                ^~~~~~~~~~~~
         |                SLB_VSID_SHIFT_1T
   arch/powerpc/include/asm/book3s/64/mmu-hash.h: In function 'hpte_encode_avpn':
   arch/powerpc/include/asm/book3s/64/mmu-hash.h:338:38: warning: left shift count >= width of type [-Wshift-count-overflow]
     338 |         v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
         |                                      ^~
   arch/powerpc/include/asm/book3s/64/mmu-hash.h: In function 'hpte_old_to_new_r':
   arch/powerpc/include/asm/book3s/64/mmu-hash.h:357:23: warning: right shift count >= width of type [-Wshift-count-overflow]
     357 |                 (((v) >> HPTE_V_SSIZE_SHIFT) << HPTE_R_3_0_SSIZE_SHIFT);
         |                       ^~
   arch/powerpc/include/asm/book3s/64/mmu-hash.h:357:46: warning: left shift count >= width of type [-Wshift-count-overflow]
     357 |                 (((v) >> HPTE_V_SSIZE_SHIFT) << HPTE_R_3_0_SSIZE_SHIFT);
         |                                              ^~
   arch/powerpc/include/asm/book3s/64/mmu-hash.h: In function 'hpt_hash':
   arch/powerpc/include/asm/book3s/64/mmu-hash.h:440:33: error: 'SID_SHIFT' undeclared (first use in this function); did you mean 'PUD_SHIFT'?
     440 |                 mask = (1ul << (SID_SHIFT - VPN_SHIFT)) - 1;
         |                                 ^~~~~~~~~
         |                                 PUD_SHIFT
   arch/powerpc/include/asm/book3s/64/mmu-hash.h:444:33: error: 'SID_SHIFT_1T' undeclared (first use in this function); did you mean 'SLB_VSID_SHIFT_1T'?
     444 |                 mask = (1ul << (SID_SHIFT_1T - VPN_SHIFT)) - 1;
         |                                 ^~~~~~~~~~~~
         |                                 SLB_VSID_SHIFT_1T
   In file included from include/vdso/const.h:5,
                    from include/vdso/bits.h:5,
                    from include/vdso/datapage.h:12,
                    from lib/vdso/gettimeofday.c:5,
                    from <command-line>:


vim +1280 include/linux/atomic/atomic-arch-fallback.h

37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1270  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1271  #ifndef arch_atomic64_read_acquire
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1272  static __always_inline s64
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1273  arch_atomic64_read_acquire(const atomic64_t *v)
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1274  {
dc1b4df09acdca include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2022-02-07  1275  	s64 ret;
dc1b4df09acdca include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2022-02-07  1276  
dc1b4df09acdca include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2022-02-07  1277  	if (__native_word(atomic64_t)) {
dc1b4df09acdca include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2022-02-07  1278  		ret = smp_load_acquire(&(v)->counter);
dc1b4df09acdca include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2022-02-07  1279  	} else {
dc1b4df09acdca include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2022-02-07 @1280  		ret = arch_atomic64_read(v);
dc1b4df09acdca include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2022-02-07  1281  		__atomic_acquire_fence();
dc1b4df09acdca include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2022-02-07  1282  	}
dc1b4df09acdca include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2022-02-07  1283  
dc1b4df09acdca include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2022-02-07  1284  	return ret;
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1285  }
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1286  #define arch_atomic64_read_acquire arch_atomic64_read_acquire
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1287  #endif
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1288  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1289  #ifndef arch_atomic64_set_release
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1290  static __always_inline void
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1291  arch_atomic64_set_release(atomic64_t *v, s64 i)
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1292  {
dc1b4df09acdca include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2022-02-07  1293  	if (__native_word(atomic64_t)) {
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1294  		smp_store_release(&(v)->counter, i);
dc1b4df09acdca include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2022-02-07  1295  	} else {
dc1b4df09acdca include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2022-02-07  1296  		__atomic_release_fence();
dc1b4df09acdca include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2022-02-07 @1297  		arch_atomic64_set(v, i);
dc1b4df09acdca include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2022-02-07  1298  	}
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1299  }
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1300  #define arch_atomic64_set_release arch_atomic64_set_release
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1301  #endif
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1302  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1303  #ifndef arch_atomic64_add_return_relaxed
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1304  #define arch_atomic64_add_return_acquire arch_atomic64_add_return
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1305  #define arch_atomic64_add_return_release arch_atomic64_add_return
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1306  #define arch_atomic64_add_return_relaxed arch_atomic64_add_return
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1307  #else /* arch_atomic64_add_return_relaxed */
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1308  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1309  #ifndef arch_atomic64_add_return_acquire
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1310  static __always_inline s64
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1311  arch_atomic64_add_return_acquire(s64 i, atomic64_t *v)
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1312  {
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1313  	s64 ret = arch_atomic64_add_return_relaxed(i, v);
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1314  	__atomic_acquire_fence();
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1315  	return ret;
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1316  }
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1317  #define arch_atomic64_add_return_acquire arch_atomic64_add_return_acquire
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1318  #endif
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1319  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1320  #ifndef arch_atomic64_add_return_release
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1321  static __always_inline s64
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1322  arch_atomic64_add_return_release(s64 i, atomic64_t *v)
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1323  {
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1324  	__atomic_release_fence();
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1325  	return arch_atomic64_add_return_relaxed(i, v);
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1326  }
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1327  #define arch_atomic64_add_return_release arch_atomic64_add_return_release
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1328  #endif
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1329  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1330  #ifndef arch_atomic64_add_return
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1331  static __always_inline s64
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1332  arch_atomic64_add_return(s64 i, atomic64_t *v)
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1333  {
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1334  	s64 ret;
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1335  	__atomic_pre_full_fence();
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1336  	ret = arch_atomic64_add_return_relaxed(i, v);
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1337  	__atomic_post_full_fence();
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1338  	return ret;
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1339  }
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1340  #define arch_atomic64_add_return arch_atomic64_add_return
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1341  #endif
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1342  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1343  #endif /* arch_atomic64_add_return_relaxed */
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1344  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1345  #ifndef arch_atomic64_fetch_add_relaxed
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1346  #define arch_atomic64_fetch_add_acquire arch_atomic64_fetch_add
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1347  #define arch_atomic64_fetch_add_release arch_atomic64_fetch_add
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1348  #define arch_atomic64_fetch_add_relaxed arch_atomic64_fetch_add
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1349  #else /* arch_atomic64_fetch_add_relaxed */
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1350  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1351  #ifndef arch_atomic64_fetch_add_acquire
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1352  static __always_inline s64
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1353  arch_atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1354  {
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1355  	s64 ret = arch_atomic64_fetch_add_relaxed(i, v);
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1356  	__atomic_acquire_fence();
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1357  	return ret;
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1358  }
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1359  #define arch_atomic64_fetch_add_acquire arch_atomic64_fetch_add_acquire
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1360  #endif
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1361  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1362  #ifndef arch_atomic64_fetch_add_release
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1363  static __always_inline s64
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1364  arch_atomic64_fetch_add_release(s64 i, atomic64_t *v)
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1365  {
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1366  	__atomic_release_fence();
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1367  	return arch_atomic64_fetch_add_relaxed(i, v);
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1368  }
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1369  #define arch_atomic64_fetch_add_release arch_atomic64_fetch_add_release
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1370  #endif
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1371  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1372  #ifndef arch_atomic64_fetch_add
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1373  static __always_inline s64
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1374  arch_atomic64_fetch_add(s64 i, atomic64_t *v)
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1375  {
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1376  	s64 ret;
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1377  	__atomic_pre_full_fence();
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1378  	ret = arch_atomic64_fetch_add_relaxed(i, v);
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1379  	__atomic_post_full_fence();
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1380  	return ret;
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1381  }
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1382  #define arch_atomic64_fetch_add arch_atomic64_fetch_add
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1383  #endif
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1384  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1385  #endif /* arch_atomic64_fetch_add_relaxed */
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1386  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1387  #ifndef arch_atomic64_sub_return_relaxed
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1388  #define arch_atomic64_sub_return_acquire arch_atomic64_sub_return
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1389  #define arch_atomic64_sub_return_release arch_atomic64_sub_return
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1390  #define arch_atomic64_sub_return_relaxed arch_atomic64_sub_return
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1391  #else /* arch_atomic64_sub_return_relaxed */
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1392  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1393  #ifndef arch_atomic64_sub_return_acquire
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1394  static __always_inline s64
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1395  arch_atomic64_sub_return_acquire(s64 i, atomic64_t *v)
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1396  {
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1397  	s64 ret = arch_atomic64_sub_return_relaxed(i, v);
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1398  	__atomic_acquire_fence();
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1399  	return ret;
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1400  }
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1401  #define arch_atomic64_sub_return_acquire arch_atomic64_sub_return_acquire
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1402  #endif
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1403  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1404  #ifndef arch_atomic64_sub_return_release
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1405  static __always_inline s64
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1406  arch_atomic64_sub_return_release(s64 i, atomic64_t *v)
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1407  {
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1408  	__atomic_release_fence();
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1409  	return arch_atomic64_sub_return_relaxed(i, v);
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1410  }
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1411  #define arch_atomic64_sub_return_release arch_atomic64_sub_return_release
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1412  #endif
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1413  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1414  #ifndef arch_atomic64_sub_return
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1415  static __always_inline s64
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1416  arch_atomic64_sub_return(s64 i, atomic64_t *v)
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1417  {
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1418  	s64 ret;
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1419  	__atomic_pre_full_fence();
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1420  	ret = arch_atomic64_sub_return_relaxed(i, v);
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1421  	__atomic_post_full_fence();
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1422  	return ret;
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1423  }
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1424  #define arch_atomic64_sub_return arch_atomic64_sub_return
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1425  #endif
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1426  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1427  #endif /* arch_atomic64_sub_return_relaxed */
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1428  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1429  #ifndef arch_atomic64_fetch_sub_relaxed
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1430  #define arch_atomic64_fetch_sub_acquire arch_atomic64_fetch_sub
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1431  #define arch_atomic64_fetch_sub_release arch_atomic64_fetch_sub
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1432  #define arch_atomic64_fetch_sub_relaxed arch_atomic64_fetch_sub
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1433  #else /* arch_atomic64_fetch_sub_relaxed */
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1434  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1435  #ifndef arch_atomic64_fetch_sub_acquire
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1436  static __always_inline s64
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1437  arch_atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1438  {
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1439  	s64 ret = arch_atomic64_fetch_sub_relaxed(i, v);
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1440  	__atomic_acquire_fence();
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1441  	return ret;
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1442  }
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1443  #define arch_atomic64_fetch_sub_acquire arch_atomic64_fetch_sub_acquire
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1444  #endif
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1445  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1446  #ifndef arch_atomic64_fetch_sub_release
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1447  static __always_inline s64
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1448  arch_atomic64_fetch_sub_release(s64 i, atomic64_t *v)
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1449  {
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1450  	__atomic_release_fence();
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1451  	return arch_atomic64_fetch_sub_relaxed(i, v);
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1452  }
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1453  #define arch_atomic64_fetch_sub_release arch_atomic64_fetch_sub_release
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1454  #endif
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1455  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1456  #ifndef arch_atomic64_fetch_sub
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1457  static __always_inline s64
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1458  arch_atomic64_fetch_sub(s64 i, atomic64_t *v)
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1459  {
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1460  	s64 ret;
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1461  	__atomic_pre_full_fence();
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1462  	ret = arch_atomic64_fetch_sub_relaxed(i, v);
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1463  	__atomic_post_full_fence();
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1464  	return ret;
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1465  }
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1466  #define arch_atomic64_fetch_sub arch_atomic64_fetch_sub
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1467  #endif
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1468  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1469  #endif /* arch_atomic64_fetch_sub_relaxed */
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1470  
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1471  #ifndef arch_atomic64_inc
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1472  static __always_inline void
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1473  arch_atomic64_inc(atomic64_t *v)
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1474  {
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24 @1475  	arch_atomic64_add(1, v);
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1476  }
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1477  #define arch_atomic64_inc arch_atomic64_inc
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1478  #endif
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  1479  

:::::: The code at line 1280 was first introduced by commit
:::::: dc1b4df09acdca7a89806b28f235cd6d8dcd3d24 atomics: Fix atomic64_{read_acquire,set_release} fallbacks

:::::: TO: Mark Rutland <mark.rutland@arm.com>
:::::: CC: Peter Zijlstra <peterz@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FC5498079
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242928AbiAXNI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:08:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:33646 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242781AbiAXNI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643029736; x=1674565736;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1UE4yJTBuYWXm8YEr2krV6YOz7xSpcnUVRYLwdU34IM=;
  b=YX0cRNXY7IN64/BCAm4drgR/ZTolXIkURfbtDtVhJhVgIUwEk1hYKqL0
   /6jYnieA1xiEi+JKq4DrkUDkSpkmblP4uzQaAcopbe8549GJ+gm0wmc6n
   vo/x0bkn5udmeZkjUF4vJBhSrsjpzb5w+LKD7bE0IwfdbRrg82B0WVjR1
   RuYUnAtyzx76bo01PJc7MY0iREW4v/59KzqtVVXJ8fiyXVyeZf/M55Tep
   iRH9BUDPnRuIQXtdLYY0MEGkbV1zS4EzAeP/BrjCyrmk7CFKzFInfXR4T
   LEpCrcicf3YL9DKNLGKBSpJ/O5CxDRfc6KHhq1bxRdu8MGabNhFsr+nrI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="246256460"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="246256460"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 05:08:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="695414953"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Jan 2022 05:08:41 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBz5M-000ILh-HC; Mon, 24 Jan 2022 13:08:40 +0000
Date:   Mon, 24 Jan 2022 21:08:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2376/2384]
 arch/arm64/include/asm/preempt.h:13:47: error: invalid type argument of '->'
 (have 'int')
Message-ID: <202201242026.CrtQ9uF8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: 882f8a5202090503bd884d578674fd1da9a404ff [2376/2384] headers/deps: Introduce the CONFIG_FAST_HEADERS=y config option
config: arm64-buildonly-randconfig-r005-20220124 (https://download.01.org/0day-ci/archive/20220124/202201242026.CrtQ9uF8-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=882f8a5202090503bd884d578674fd1da9a404ff
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 882f8a5202090503bd884d578674fd1da9a404ff
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   arch/arm64/include/asm/preempt.h: In function 'preempt_count':
   include/linux/thread_info.h:28:32: error: implicit declaration of function 'task_thread_info'; did you mean 'task_thread'? [-Werror=implicit-function-declaration]
      28 | # define current_thread_info() task_thread_info(current)
         |                                ^~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/preempt.h:13:16: note: in expansion of macro 'READ_ONCE'
      13 |         return READ_ONCE(current_thread_info()->preempt.count);
         |                ^~~~~~~~~
   arch/arm64/include/asm/preempt.h:13:26: note: in expansion of macro 'current_thread_info'
      13 |         return READ_ONCE(current_thread_info()->preempt.count);
         |                          ^~~~~~~~~~~~~~~~~~~
>> arch/arm64/include/asm/preempt.h:13:47: error: invalid type argument of '->' (have 'int')
      13 |         return READ_ONCE(current_thread_info()->preempt.count);
         |                                               ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/preempt.h:13:16: note: in expansion of macro 'READ_ONCE'
      13 |         return READ_ONCE(current_thread_info()->preempt.count);
         |                ^~~~~~~~~
>> arch/arm64/include/asm/preempt.h:13:47: error: invalid type argument of '->' (have 'int')
      13 |         return READ_ONCE(current_thread_info()->preempt.count);
         |                                               ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/preempt.h:13:16: note: in expansion of macro 'READ_ONCE'
      13 |         return READ_ONCE(current_thread_info()->preempt.count);
         |                ^~~~~~~~~
>> arch/arm64/include/asm/preempt.h:13:47: error: invalid type argument of '->' (have 'int')
      13 |         return READ_ONCE(current_thread_info()->preempt.count);
         |                                               ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/preempt.h:13:16: note: in expansion of macro 'READ_ONCE'
      13 |         return READ_ONCE(current_thread_info()->preempt.count);
         |                ^~~~~~~~~
>> arch/arm64/include/asm/preempt.h:13:47: error: invalid type argument of '->' (have 'int')
      13 |         return READ_ONCE(current_thread_info()->preempt.count);
         |                                               ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/preempt.h:13:16: note: in expansion of macro 'READ_ONCE'
      13 |         return READ_ONCE(current_thread_info()->preempt.count);
         |                ^~~~~~~~~
>> arch/arm64/include/asm/preempt.h:13:47: error: invalid type argument of '->' (have 'int')
      13 |         return READ_ONCE(current_thread_info()->preempt.count);
         |                                               ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/preempt.h:13:16: note: in expansion of macro 'READ_ONCE'
      13 |         return READ_ONCE(current_thread_info()->preempt.count);
         |                ^~~~~~~~~
>> arch/arm64/include/asm/preempt.h:13:47: error: invalid type argument of '->' (have 'int')
      13 |         return READ_ONCE(current_thread_info()->preempt.count);
         |                                               ^~
   include/linux/compiler_types.h:291:27: note: in definition of macro '__unqual_scalar_typeof'
     291 |                 _Generic((x),                                           \
         |                           ^
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/arm64/include/asm/preempt.h:13:16: note: in expansion of macro 'READ_ONCE'
      13 |         return READ_ONCE(current_thread_info()->preempt.count);
         |                ^~~~~~~~~
   In file included from arch/arm64/include/asm/rwonce.h:71,
                    from include/linux/compiler.h:263,
                    from include/asm-generic/bug.h:5,
                    from arch/arm64/include/asm/bug.h:26,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:15,
                    from include/linux/sched.h:2,
                    from arch/arm64/kernel/../../../kernel/sched/per_task_area_struct.h:7,
                    from arch/arm64/kernel/asm-offsets.c:9:
>> arch/arm64/include/asm/preempt.h:13:47: error: invalid type argument of '->' (have 'int')
      13 |         return READ_ONCE(current_thread_info()->preempt.count);
         |                                               ^~
   include/asm-generic/rwonce.h:44:73: note: in definition of macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
   arch/arm64/include/asm/preempt.h:13:16: note: in expansion of macro 'READ_ONCE'
      13 |         return READ_ONCE(current_thread_info()->preempt.count);
         |                ^~~~~~~~~
   In file included from <command-line>:
   arch/arm64/include/asm/preempt.h: In function 'preempt_count_set':
   arch/arm64/include/asm/preempt.h:19:41: error: invalid type argument of '->' (have 'int')
      19 |         WRITE_ONCE(current_thread_info()->preempt.count, pc);
         |                                         ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/preempt.h:19:9: note: in expansion of macro 'WRITE_ONCE'
      19 |         WRITE_ONCE(current_thread_info()->preempt.count, pc);
         |         ^~~~~~~~~~
   arch/arm64/include/asm/preempt.h:19:41: error: invalid type argument of '->' (have 'int')
      19 |         WRITE_ONCE(current_thread_info()->preempt.count, pc);
         |                                         ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/preempt.h:19:9: note: in expansion of macro 'WRITE_ONCE'
      19 |         WRITE_ONCE(current_thread_info()->preempt.count, pc);
         |         ^~~~~~~~~~
   arch/arm64/include/asm/preempt.h:19:41: error: invalid type argument of '->' (have 'int')
      19 |         WRITE_ONCE(current_thread_info()->preempt.count, pc);
         |                                         ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/preempt.h:19:9: note: in expansion of macro 'WRITE_ONCE'
      19 |         WRITE_ONCE(current_thread_info()->preempt.count, pc);
         |         ^~~~~~~~~~
   arch/arm64/include/asm/preempt.h:19:41: error: invalid type argument of '->' (have 'int')
      19 |         WRITE_ONCE(current_thread_info()->preempt.count, pc);
         |                                         ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/preempt.h:19:9: note: in expansion of macro 'WRITE_ONCE'
      19 |         WRITE_ONCE(current_thread_info()->preempt.count, pc);
         |         ^~~~~~~~~~
   arch/arm64/include/asm/preempt.h:19:41: error: invalid type argument of '->' (have 'int')
      19 |         WRITE_ONCE(current_thread_info()->preempt.count, pc);
         |                                         ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~


vim +13 arch/arm64/include/asm/preempt.h

396244692232fc Will Deacon 2018-09-20  10  
396244692232fc Will Deacon 2018-09-20  11  static inline int preempt_count(void)
396244692232fc Will Deacon 2018-09-20  12  {
396244692232fc Will Deacon 2018-09-20 @13  	return READ_ONCE(current_thread_info()->preempt.count);
396244692232fc Will Deacon 2018-09-20  14  }
396244692232fc Will Deacon 2018-09-20  15  

:::::: The code at line 13 was first introduced by commit
:::::: 396244692232fcf0881cb6ba2404be2906f47681 arm64: preempt: Provide our own implementation of asm/preempt.h

:::::: TO: Will Deacon <will.deacon@arm.com>
:::::: CC: Will Deacon <will.deacon@arm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

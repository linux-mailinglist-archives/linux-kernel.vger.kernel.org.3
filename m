Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A214FAF1E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243679AbiDJQ61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240403AbiDJQ6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:58:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D403D3C4A0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 09:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649609773; x=1681145773;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5hgYay+A3u84P1Im7ew9yeUAIZ8FUtOEV39jCStQWtQ=;
  b=JYYysPjddL974XGI3nPIkYlNDKoig3+AOrX6wVfnmMJE2Mo93DQbYavs
   6w/DHhVFrHcbMDbaLT0ZPQZbhRoFv/JZAuYolDmBPYD2SCjqPVWL/d4nB
   xYmm0ZBMWWWi0f/YYz/Zl2SbizRXGO/aUeY6CmwyH61zyJDhZ/rXJZWEN
   KYngxQluET1Ojw+844gJ6ihhy2jP2vljrzgyx6kFD1XdGkwNrM68RJIhQ
   m3sr7bddlTaNy2nqL2VUiNMtuBy5qf9HpdC24aVAeb34lfp2QfRVs9Wyu
   xgCQsbWx8pkVmQWy0h4rug/nKbXKwveb7g9WBrQD65WDbMnXNKSyDPEcX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="286987849"
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="286987849"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 09:56:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="723662459"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Apr 2022 09:56:11 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndarD-0000xr-5D;
        Sun, 10 Apr 2022 16:56:11 +0000
Date:   Mon, 11 Apr 2022 00:55:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, zx2c4@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [crng-random:jd/not-zero-entropy-ktime 10/13]
 include/linux/timekeeping.h:121:9: error: implicit declaration of function
 'timespec64_to_ktime' is invalid in C99
Message-ID: <202204110039.k9CNcBlM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git jd/not-zero-entropy-ktime
head:   340a25fe529e8fc1df1a82b42f021a9d0fa4fb51
commit: 7376542333df813e81252121f5ebd8e91c0fb3b6 [10/13] x86: use ktime_read_raw_clock() for random_get_entropy() instead of zero
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220411/202204110039.k9CNcBlM-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 256c6b0ba14e8a7ab6373b61b7193ea8c0a3651c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=7376542333df813e81252121f5ebd8e91c0fb3b6
        git remote add crng-random git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
        git fetch --no-tags crng-random jd/not-zero-entropy-ktime
        git checkout 7376542333df813e81252121f5ebd8e91c0fb3b6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   include/linux/timekeeping.h:98:15: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
   static inline ktime_t ktime_get_coarse_boottime(void)
                 ^~~~~~~
                 timer_t
   include/linux/types.h:26:26: note: 'timer_t' declared here
   typedef __kernel_timer_t        timer_t;
                                   ^
   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:20:
   In file included from include/linux/slab.h:15:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:21:
   In file included from include/linux/mm_types.h:15:
   In file included from include/linux/uprobes.h:49:
   In file included from arch/x86/include/asm/uprobes.h:13:
   In file included from include/linux/notifier.h:16:
   In file included from include/linux/srcu.h:21:
   In file included from include/linux/workqueue.h:9:
   In file included from include/linux/timer.h:6:
   In file included from include/linux/ktime.h:24:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:65:
   In file included from arch/x86/include/asm/timex.h:6:
   In file included from arch/x86/include/asm/tsc.h:8:
   include/linux/timekeeping.h:106:15: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
   static inline ktime_t ktime_get_clocktai(void)
                 ^~~~~~~
                 timer_t
   include/linux/types.h:26:26: note: 'timer_t' declared here
   typedef __kernel_timer_t        timer_t;
                                   ^
   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:20:
   In file included from include/linux/slab.h:15:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:21:
   In file included from include/linux/mm_types.h:15:
   In file included from include/linux/uprobes.h:49:
   In file included from arch/x86/include/asm/uprobes.h:13:
   In file included from include/linux/notifier.h:16:
   In file included from include/linux/srcu.h:21:
   In file included from include/linux/workqueue.h:9:
   In file included from include/linux/timer.h:6:
   In file included from include/linux/ktime.h:24:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:65:
   In file included from arch/x86/include/asm/timex.h:6:
   In file included from arch/x86/include/asm/tsc.h:8:
   include/linux/timekeeping.h:111:15: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
   static inline ktime_t ktime_get_coarse_clocktai(void)
                 ^~~~~~~
                 timer_t
   include/linux/types.h:26:26: note: 'timer_t' declared here
   typedef __kernel_timer_t        timer_t;
                                   ^
   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:20:
   In file included from include/linux/slab.h:15:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:21:
   In file included from include/linux/mm_types.h:15:
   In file included from include/linux/uprobes.h:49:
   In file included from arch/x86/include/asm/uprobes.h:13:
   In file included from include/linux/notifier.h:16:
   In file included from include/linux/srcu.h:21:
   In file included from include/linux/workqueue.h:9:
   In file included from include/linux/timer.h:6:
   In file included from include/linux/ktime.h:24:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:65:
   In file included from arch/x86/include/asm/timex.h:6:
   In file included from arch/x86/include/asm/tsc.h:8:
   include/linux/timekeeping.h:116:15: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
   static inline ktime_t ktime_get_coarse(void)
                 ^~~~~~~
                 timer_t
   include/linux/types.h:26:26: note: 'timer_t' declared here
   typedef __kernel_timer_t        timer_t;
                                   ^
   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:20:
   In file included from include/linux/slab.h:15:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:21:
   In file included from include/linux/mm_types.h:15:
   In file included from include/linux/uprobes.h:49:
   In file included from arch/x86/include/asm/uprobes.h:13:
   In file included from include/linux/notifier.h:16:
   In file included from include/linux/srcu.h:21:
   In file included from include/linux/workqueue.h:9:
   In file included from include/linux/timer.h:6:
   In file included from include/linux/ktime.h:24:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:65:
   In file included from arch/x86/include/asm/timex.h:6:
   In file included from arch/x86/include/asm/tsc.h:8:
>> include/linux/timekeeping.h:121:9: error: implicit declaration of function 'timespec64_to_ktime' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return timespec64_to_ktime(ts);
                  ^
   include/linux/timekeeping.h:121:9: note: did you mean 'timespec64_to_ns'?
   include/linux/time64.h:127:19: note: 'timespec64_to_ns' declared here
   static inline s64 timespec64_to_ns(const struct timespec64 *ts)
                     ^
   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:20:
   In file included from include/linux/slab.h:15:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:21:
   In file included from include/linux/mm_types.h:15:
   In file included from include/linux/uprobes.h:49:
   In file included from arch/x86/include/asm/uprobes.h:13:
   In file included from include/linux/notifier.h:16:
   In file included from include/linux/srcu.h:21:
   In file included from include/linux/workqueue.h:9:
   In file included from include/linux/timer.h:6:
   In file included from include/linux/ktime.h:24:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:65:
   In file included from arch/x86/include/asm/timex.h:6:
   In file included from arch/x86/include/asm/tsc.h:8:
>> include/linux/timekeeping.h:126:9: error: implicit declaration of function 'ktime_to_ns' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return ktime_to_ns(ktime_get_coarse());
                  ^
   include/linux/timekeeping.h:131:9: error: implicit declaration of function 'ktime_to_ns' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return ktime_to_ns(ktime_get_coarse_real());
                  ^
   include/linux/timekeeping.h:136:9: error: implicit declaration of function 'ktime_to_ns' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return ktime_to_ns(ktime_get_coarse_boottime());
                  ^
   include/linux/timekeeping.h:141:9: error: implicit declaration of function 'ktime_to_ns' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return ktime_to_ns(ktime_get_coarse_clocktai());
                  ^
   include/linux/timekeeping.h:147:15: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
   static inline ktime_t ktime_mono_to_real(ktime_t mono)
                 ^~~~~~~
                 timer_t
   include/linux/types.h:26:26: note: 'timer_t' declared here
   typedef __kernel_timer_t        timer_t;
                                   ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.
   make[2]: *** [scripts/Makefile.build:120: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/timespec64_to_ktime +121 include/linux/timekeeping.h

b9ff604cff1135 Arnd Bergmann      2018-04-27  115  
4c54294d01e605 Jason A. Donenfeld 2019-06-21  116  static inline ktime_t ktime_get_coarse(void)
4c54294d01e605 Jason A. Donenfeld 2019-06-21  117  {
4c54294d01e605 Jason A. Donenfeld 2019-06-21  118  	struct timespec64 ts;
4c54294d01e605 Jason A. Donenfeld 2019-06-21  119  
4c54294d01e605 Jason A. Donenfeld 2019-06-21  120  	ktime_get_coarse_ts64(&ts);
4c54294d01e605 Jason A. Donenfeld 2019-06-21 @121  	return timespec64_to_ktime(ts);
4c54294d01e605 Jason A. Donenfeld 2019-06-21  122  }
4c54294d01e605 Jason A. Donenfeld 2019-06-21  123  
4c54294d01e605 Jason A. Donenfeld 2019-06-21  124  static inline u64 ktime_get_coarse_ns(void)
4c54294d01e605 Jason A. Donenfeld 2019-06-21  125  {
4c54294d01e605 Jason A. Donenfeld 2019-06-21 @126  	return ktime_to_ns(ktime_get_coarse());
4c54294d01e605 Jason A. Donenfeld 2019-06-21  127  }
4c54294d01e605 Jason A. Donenfeld 2019-06-21  128  

:::::: The code at line 121 was first introduced by commit
:::::: 4c54294d01e605a9f992361b924c5d8b12822a6d timekeeping: Add missing _ns functions for coarse accessors

:::::: TO: Jason A. Donenfeld <Jason@zx2c4.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

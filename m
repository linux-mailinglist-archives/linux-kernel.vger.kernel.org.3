Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524354FAA86
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 21:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiDITsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 15:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiDITr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 15:47:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DDC17E1E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 12:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649533549; x=1681069549;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KzNINjm2+iXUwPnU3XQPPB1sVhzwLnuT3ygq32hW7nU=;
  b=TRt4iW/8z7pNsoE3lx/0x2Q9DJZmTdBYy2QqNrS9UkNpOjPqtS2RmAj8
   VsRfeu46QDDphUO6zgg7PWLc9bMvVTfmchiDLALyIm+QaUJS7XpBQSZBh
   Yh9jZTQ2G5U0d1hdDqBFJEMzI/RA6UXPM8DDw3BoyBe8GQSpY0Q5A+Kuk
   ltf5cKdgc55L4cGoHxK1VIJToKac5Swt4Q+3CHzqRqGvZhnjskaPj6q+V
   3YJ2tQbMhcgYZhuWRcSKphkXuPmePTJYK8fZc34709Zi25sv7YLZecwo2
   gshIOqbZecO8YIvDp1erLIQwf4qQcmmVQ6gxaXYPWWYA/bWzeX59zxuNN
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="242489591"
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="242489591"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 12:45:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="622275626"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Apr 2022 12:45:20 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndH1L-0000LX-R8;
        Sat, 09 Apr 2022 19:45:19 +0000
Date:   Sun, 10 Apr 2022 03:45:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, zx2c4@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [crng-random:jd/not-zero-entropy 3/12]
 include/linux/atomic/atomic-arch-fallback.h:1280:9: error: implicit
 declaration of function 'arch_atomic64_read' is invalid in C99
Message-ID: <202204100352.NEfbyVsL-lkp@intel.com>
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
config: powerpc64-randconfig-r016-20220410 (https://download.01.org/0day-ci/archive/20220410/202204100352.NEfbyVsL-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 256c6b0ba14e8a7ab6373b61b7193ea8c0a3651c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc64 cross compiling tool for clang build
        # apt-get install binutils-powerpc64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=b4eebe6411b3edfb28f613b77f41d4f30676ac0e
        git remote add crng-random git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
        git fetch --no-tags crng-random jd/not-zero-entropy
        git checkout b4eebe6411b3edfb28f613b77f41d4f30676ac0e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/vdso/vgettimeofday.c:5:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:64:
   In file included from include/linux/sched/clock.h:5:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:13:
   In file included from include/linux/atomic.h:80:
>> include/linux/atomic/atomic-arch-fallback.h:1280:9: error: implicit declaration of function 'arch_atomic64_read' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   ret = arch_atomic64_read(v);
                         ^
   include/linux/atomic/atomic-arch-fallback.h:1280:9: note: did you mean 'arch_atomic_read'?
   arch/powerpc/include/asm/atomic.h:26:23: note: 'arch_atomic_read' declared here
   static __inline__ int arch_atomic_read(const atomic_t *v)
                         ^
   In file included from arch/powerpc/kernel/vdso/vgettimeofday.c:5:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:64:
   In file included from include/linux/sched/clock.h:5:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:13:
   In file included from include/linux/atomic.h:80:
>> include/linux/atomic/atomic-arch-fallback.h:1297:3: error: implicit declaration of function 'arch_atomic64_set' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   arch_atomic64_set(v, i);
                   ^
   include/linux/atomic/atomic-arch-fallback.h:1297:3: note: did you mean 'arch_atomic_set'?
   arch/powerpc/include/asm/atomic.h:35:24: note: 'arch_atomic_set' declared here
   static __inline__ void arch_atomic_set(atomic_t *v, int i)
                          ^
   In file included from arch/powerpc/kernel/vdso/vgettimeofday.c:5:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:64:
   In file included from include/linux/sched/clock.h:5:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:13:
   In file included from include/linux/atomic.h:80:
>> include/linux/atomic/atomic-arch-fallback.h:1475:2: error: implicit declaration of function 'arch_atomic64_add' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           arch_atomic64_add(1, v);
           ^
   include/linux/atomic/atomic-arch-fallback.h:1475:2: note: did you mean 'arch_atomic_add'?
   arch/powerpc/include/asm/atomic.h:94:1: note: 'arch_atomic_add' declared here
   ATOMIC_OPS(add, add, "c", I, "xer")
   ^
   arch/powerpc/include/asm/atomic.h:90:2: note: expanded from macro 'ATOMIC_OPS'
           ATOMIC_OP(op, asm_op, suffix, sign, ##__VA_ARGS__)              \
           ^
   arch/powerpc/include/asm/atomic.h:41:24: note: expanded from macro 'ATOMIC_OP'
   static __inline__ void arch_atomic_##op(int a, atomic_t *v)             \
                          ^
   <scratch space>:155:1: note: expanded from here
   arch_atomic_add
   ^
   In file included from arch/powerpc/kernel/vdso/vgettimeofday.c:5:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:64:
   In file included from include/linux/sched/clock.h:5:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:13:
   In file included from include/linux/atomic.h:80:
>> include/linux/atomic/atomic-arch-fallback.h:1491:9: error: implicit declaration of function 'arch_atomic64_add_return' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return arch_atomic64_add_return(1, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1491:9: note: did you mean 'arch_atomic_add_return'?
   include/linux/atomic/atomic-arch-fallback.h:211:1: note: 'arch_atomic_add_return' declared here
   arch_atomic_add_return(int i, atomic_t *v)
   ^
   include/linux/atomic/atomic-arch-fallback.h:1500:9: error: implicit declaration of function 'arch_atomic64_add_return' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return arch_atomic64_add_return_acquire(1, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1304:42: note: expanded from macro 'arch_atomic64_add_return_acquire'
   #define arch_atomic64_add_return_acquire arch_atomic64_add_return
                                            ^
   include/linux/atomic/atomic-arch-fallback.h:1509:9: error: implicit declaration of function 'arch_atomic64_add_return' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return arch_atomic64_add_return_release(1, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1305:42: note: expanded from macro 'arch_atomic64_add_return_release'
   #define arch_atomic64_add_return_release arch_atomic64_add_return
                                            ^
   include/linux/atomic/atomic-arch-fallback.h:1518:9: error: implicit declaration of function 'arch_atomic64_add_return' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return arch_atomic64_add_return_relaxed(1, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1306:42: note: expanded from macro 'arch_atomic64_add_return_relaxed'
   #define arch_atomic64_add_return_relaxed arch_atomic64_add_return
                                            ^
>> include/linux/atomic/atomic-arch-fallback.h:1572:9: error: implicit declaration of function 'arch_atomic64_fetch_add' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return arch_atomic64_fetch_add(1, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1572:9: note: did you mean 'arch_atomic_fetch_add'?
   include/linux/atomic/atomic-arch-fallback.h:253:1: note: 'arch_atomic_fetch_add' declared here
   arch_atomic_fetch_add(int i, atomic_t *v)
   ^
   include/linux/atomic/atomic-arch-fallback.h:1581:9: error: implicit declaration of function 'arch_atomic64_fetch_add' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return arch_atomic64_fetch_add_acquire(1, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1346:41: note: expanded from macro 'arch_atomic64_fetch_add_acquire'
   #define arch_atomic64_fetch_add_acquire arch_atomic64_fetch_add
                                           ^
   include/linux/atomic/atomic-arch-fallback.h:1590:9: error: implicit declaration of function 'arch_atomic64_fetch_add' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return arch_atomic64_fetch_add_release(1, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1347:41: note: expanded from macro 'arch_atomic64_fetch_add_release'
   #define arch_atomic64_fetch_add_release arch_atomic64_fetch_add
                                           ^
   include/linux/atomic/atomic-arch-fallback.h:1599:9: error: implicit declaration of function 'arch_atomic64_fetch_add' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return arch_atomic64_fetch_add_relaxed(1, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1348:41: note: expanded from macro 'arch_atomic64_fetch_add_relaxed'
   #define arch_atomic64_fetch_add_relaxed arch_atomic64_fetch_add
                                           ^
>> include/linux/atomic/atomic-arch-fallback.h:1646:2: error: implicit declaration of function 'arch_atomic64_sub' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           arch_atomic64_sub(1, v);
           ^
   include/linux/atomic/atomic-arch-fallback.h:1646:2: note: did you mean 'arch_atomic_sub'?
   arch/powerpc/include/asm/atomic.h:95:1: note: 'arch_atomic_sub' declared here
   ATOMIC_OPS(sub, sub, "c", I, "xer")
   ^
   arch/powerpc/include/asm/atomic.h:90:2: note: expanded from macro 'ATOMIC_OPS'
           ATOMIC_OP(op, asm_op, suffix, sign, ##__VA_ARGS__)              \
           ^
   arch/powerpc/include/asm/atomic.h:41:24: note: expanded from macro 'ATOMIC_OP'
   static __inline__ void arch_atomic_##op(int a, atomic_t *v)             \
                          ^
   <scratch space>:169:1: note: expanded from here
   arch_atomic_sub
   ^
   In file included from arch/powerpc/kernel/vdso/vgettimeofday.c:5:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:64:
   In file included from include/linux/sched/clock.h:5:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:13:
   In file included from include/linux/atomic.h:80:
>> include/linux/atomic/atomic-arch-fallback.h:1662:9: error: implicit declaration of function 'arch_atomic64_sub_return' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return arch_atomic64_sub_return(1, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1662:9: note: did you mean 'arch_atomic_sub_return'?
   include/linux/atomic/atomic-arch-fallback.h:295:1: note: 'arch_atomic_sub_return' declared here
   arch_atomic_sub_return(int i, atomic_t *v)
   ^
   include/linux/atomic/atomic-arch-fallback.h:1671:9: error: implicit declaration of function 'arch_atomic64_sub_return' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return arch_atomic64_sub_return_acquire(1, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1388:42: note: expanded from macro 'arch_atomic64_sub_return_acquire'
   #define arch_atomic64_sub_return_acquire arch_atomic64_sub_return
                                            ^
   include/linux/atomic/atomic-arch-fallback.h:1680:9: error: implicit declaration of function 'arch_atomic64_sub_return' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return arch_atomic64_sub_return_release(1, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1389:42: note: expanded from macro 'arch_atomic64_sub_return_release'
   #define arch_atomic64_sub_return_release arch_atomic64_sub_return
                                            ^
   include/linux/atomic/atomic-arch-fallback.h:1689:9: error: implicit declaration of function 'arch_atomic64_sub_return' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return arch_atomic64_sub_return_relaxed(1, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1390:42: note: expanded from macro 'arch_atomic64_sub_return_relaxed'
   #define arch_atomic64_sub_return_relaxed arch_atomic64_sub_return
                                            ^
>> include/linux/atomic/atomic-arch-fallback.h:1743:9: error: implicit declaration of function 'arch_atomic64_fetch_sub' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return arch_atomic64_fetch_sub(1, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1743:9: note: did you mean 'arch_atomic_fetch_sub'?
   include/linux/atomic/atomic-arch-fallback.h:337:1: note: 'arch_atomic_fetch_sub' declared here
   arch_atomic_fetch_sub(int i, atomic_t *v)
   ^
   include/linux/atomic/atomic-arch-fallback.h:1752:9: error: implicit declaration of function 'arch_atomic64_fetch_sub' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return arch_atomic64_fetch_sub_acquire(1, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1430:41: note: expanded from macro 'arch_atomic64_fetch_sub_acquire'
   #define arch_atomic64_fetch_sub_acquire arch_atomic64_fetch_sub
                                           ^
   include/linux/atomic/atomic-arch-fallback.h:1761:9: error: implicit declaration of function 'arch_atomic64_fetch_sub' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return arch_atomic64_fetch_sub_release(1, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1431:41: note: expanded from macro 'arch_atomic64_fetch_sub_release'
   #define arch_atomic64_fetch_sub_release arch_atomic64_fetch_sub
                                           ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.
   make[2]: *** [arch/powerpc/kernel/vdso/Makefile:73: arch/powerpc/kernel/vdso/vgettimeofday-32.o] Error 1
   make[2]: Target 'include/generated/vdso32-offsets.h' not remade because of errors.
   make[1]: *** [arch/powerpc/Makefile:423: vdso_prepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/arch_atomic64_read +1280 include/linux/atomic/atomic-arch-fallback.h

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

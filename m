Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7875C4FAEDE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243575AbiDJQ12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240592AbiDJQ1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:27:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D93D27B22
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 09:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649607913; x=1681143913;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xmN5YbBTIWQiGIjmyWp1BlSLePBZ1DpmExBB91MT4wU=;
  b=WqYuaZuIeXzC44Ux8W8RxbMae5bJ1U1LWDjJgApMBqmKtCm9vPFYH7VM
   /wWnVl+ZVTE4+/lnzGGTFt06Ls9oyiwpd1Ndcd+32W0LixzrhrXaOI+wP
   Yjb4HLxPUvbDrX2QNOqGtOzbcETzE3HorOGgCyheHufsfEPZiTxzAGJfR
   ofL9OB7zU08cmOYt3ClU7Q++1XC74vU0uevIoEzcNMIv8xv3Azh9MJOaN
   mIAXRwkjIlhezmTEonmSgXZjIb1SK0tsu8+OdYIGXCk6Z/gEOLS5WBgw0
   aaXGT7I+rHeQLIR8wlVMmC/FLQFtz0S8YY3IRGegod8L7OCr5N8zGNfqB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="286986154"
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; 
   d="scan'208";a="286986154"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 09:25:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; 
   d="scan'208";a="659754404"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 10 Apr 2022 09:25:11 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndaNC-0000xC-R1;
        Sun, 10 Apr 2022 16:25:10 +0000
Date:   Mon, 11 Apr 2022 00:24:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, zx2c4@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [crng-random:jd/not-zero-entropy-ktime 7/13]
 include/linux/timekeeping.h:67:8: error: unknown type name 'ktime_t'; did
 you mean 'timer_t'?
Message-ID: <202204110022.wpsdiK5T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git jd/not-zero-entropy-ktime
head:   340a25fe529e8fc1df1a82b42f021a9d0fa4fb51
commit: 51f687126c25fec1a6e2956a1a31c1ef1bc1fb44 [7/13] mips: use ktime_read_raw_clock() for random_get_entropy() instead of zero
config: mips-qi_lb60_defconfig (https://download.01.org/0day-ci/archive/20220411/202204110022.wpsdiK5T-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 256c6b0ba14e8a7ab6373b61b7193ea8c0a3651c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=51f687126c25fec1a6e2956a1a31c1ef1bc1fb44
        git remote add crng-random git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
        git fetch --no-tags crng-random jd/not-zero-entropy-ktime
        git checkout 51f687126c25fec1a6e2956a1a31c1ef1bc1fb44
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:10:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:65:
   In file included from arch/mips/include/asm/timex.h:15:
>> include/linux/timekeeping.h:67:8: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
   extern ktime_t ktime_get(void);
          ^~~~~~~
          timer_t
   include/linux/types.h:26:26: note: 'timer_t' declared here
   typedef __kernel_timer_t        timer_t;
                                   ^
   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:10:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:65:
   In file included from arch/mips/include/asm/timex.h:15:
   include/linux/timekeeping.h:68:8: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
   extern ktime_t ktime_get_with_offset(enum tk_offsets offs);
          ^~~~~~~
          timer_t
   include/linux/types.h:26:26: note: 'timer_t' declared here
   typedef __kernel_timer_t        timer_t;
                                   ^
   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:10:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:65:
   In file included from arch/mips/include/asm/timex.h:15:
   include/linux/timekeeping.h:69:8: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
   extern ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs);
          ^~~~~~~
          timer_t
   include/linux/types.h:26:26: note: 'timer_t' declared here
   typedef __kernel_timer_t        timer_t;
                                   ^
   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:10:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:65:
   In file included from arch/mips/include/asm/timex.h:15:
   include/linux/timekeeping.h:70:8: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
   extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
          ^~~~~~~
          timer_t
   include/linux/types.h:26:26: note: 'timer_t' declared here
   typedef __kernel_timer_t        timer_t;
                                   ^
   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:10:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:65:
   In file included from arch/mips/include/asm/timex.h:15:
   include/linux/timekeeping.h:70:34: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
   extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
                                    ^~~~~~~
                                    timer_t
   include/linux/types.h:26:26: note: 'timer_t' declared here
   typedef __kernel_timer_t        timer_t;
                                   ^
   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:10:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:65:
   In file included from arch/mips/include/asm/timex.h:15:
   include/linux/timekeeping.h:71:8: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
   extern ktime_t ktime_get_raw(void);
          ^~~~~~~
          timer_t
   include/linux/types.h:26:26: note: 'timer_t' declared here
   typedef __kernel_timer_t        timer_t;
                                   ^
   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:10:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:65:
   In file included from arch/mips/include/asm/timex.h:15:
   include/linux/timekeeping.h:77:15: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
   static inline ktime_t ktime_get_real(void)
                 ^~~~~~~
                 timer_t
   include/linux/types.h:26:26: note: 'timer_t' declared here
   typedef __kernel_timer_t        timer_t;
                                   ^
   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:10:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:65:
   In file included from arch/mips/include/asm/timex.h:15:
   include/linux/timekeeping.h:82:15: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
   static inline ktime_t ktime_get_coarse_real(void)
                 ^~~~~~~
                 timer_t
   include/linux/types.h:26:26: note: 'timer_t' declared here
   typedef __kernel_timer_t        timer_t;
                                   ^
   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:10:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:65:
   In file included from arch/mips/include/asm/timex.h:15:
   include/linux/timekeeping.h:93:15: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
   static inline ktime_t ktime_get_boottime(void)
                 ^~~~~~~
                 timer_t
   include/linux/types.h:26:26: note: 'timer_t' declared here
   typedef __kernel_timer_t        timer_t;
                                   ^
   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:10:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:65:
   In file included from arch/mips/include/asm/timex.h:15:
   include/linux/timekeeping.h:98:15: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
   static inline ktime_t ktime_get_coarse_boottime(void)
                 ^~~~~~~
                 timer_t
   include/linux/types.h:26:26: note: 'timer_t' declared here
   typedef __kernel_timer_t        timer_t;
                                   ^
   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:10:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:65:
   In file included from arch/mips/include/asm/timex.h:15:
   include/linux/timekeeping.h:106:15: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
   static inline ktime_t ktime_get_clocktai(void)
                 ^~~~~~~
                 timer_t
   include/linux/types.h:26:26: note: 'timer_t' declared here
   typedef __kernel_timer_t        timer_t;
                                   ^
   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:10:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:65:
   In file included from arch/mips/include/asm/timex.h:15:
   include/linux/timekeeping.h:111:15: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
   static inline ktime_t ktime_get_coarse_clocktai(void)
                 ^~~~~~~
                 timer_t
   include/linux/types.h:26:26: note: 'timer_t' declared here
   typedef __kernel_timer_t        timer_t;
                                   ^
   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:10:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:65:
   In file included from arch/mips/include/asm/timex.h:15:
   include/linux/timekeeping.h:116:15: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
   static inline ktime_t ktime_get_coarse(void)
                 ^~~~~~~
                 timer_t
   include/linux/types.h:26:26: note: 'timer_t' declared here
   typedef __kernel_timer_t        timer_t;
                                   ^
   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:10:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:65:
   In file included from arch/mips/include/asm/timex.h:15:
>> include/linux/timekeeping.h:121:9: error: implicit declaration of function 'timespec64_to_ktime' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return timespec64_to_ktime(ts);
                  ^
   include/linux/timekeeping.h:121:9: note: did you mean 'timespec64_to_ns'?
   include/linux/time64.h:127:19: note: 'timespec64_to_ns' declared here
   static inline s64 timespec64_to_ns(const struct timespec64 *ts)
                     ^
   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:10:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:65:
   In file included from arch/mips/include/asm/timex.h:15:
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
   make[2]: *** [scripts/Makefile.build:120: arch/mips/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +67 include/linux/timekeeping.h

0077dc60f274b9 Thomas Gleixner    2014-07-16   66  
8b094cd03b4a37 Thomas Gleixner    2014-07-16  @67  extern ktime_t ktime_get(void);
0077dc60f274b9 Thomas Gleixner    2014-07-16   68  extern ktime_t ktime_get_with_offset(enum tk_offsets offs);
b9ff604cff1135 Arnd Bergmann      2018-04-27   69  extern ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs);
9a6b51976ea3a3 Thomas Gleixner    2014-07-16   70  extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
f519b1a2e08c91 Thomas Gleixner    2014-07-16   71  extern ktime_t ktime_get_raw(void);
6374f9124efea5 Harald Geyer       2015-04-07   72  extern u32 ktime_get_resolution_ns(void);
8b094cd03b4a37 Thomas Gleixner    2014-07-16   73  
f5264d5d5a0729 Thomas Gleixner    2014-07-16   74  /**
f5264d5d5a0729 Thomas Gleixner    2014-07-16   75   * ktime_get_real - get the real (wall-) time in ktime_t format
f5264d5d5a0729 Thomas Gleixner    2014-07-16   76   */
f5264d5d5a0729 Thomas Gleixner    2014-07-16   77  static inline ktime_t ktime_get_real(void)
f5264d5d5a0729 Thomas Gleixner    2014-07-16   78  {
f5264d5d5a0729 Thomas Gleixner    2014-07-16   79  	return ktime_get_with_offset(TK_OFFS_REAL);
f5264d5d5a0729 Thomas Gleixner    2014-07-16   80  }
f5264d5d5a0729 Thomas Gleixner    2014-07-16   81  
b9ff604cff1135 Arnd Bergmann      2018-04-27   82  static inline ktime_t ktime_get_coarse_real(void)
b9ff604cff1135 Arnd Bergmann      2018-04-27   83  {
b9ff604cff1135 Arnd Bergmann      2018-04-27   84  	return ktime_get_coarse_with_offset(TK_OFFS_REAL);
b9ff604cff1135 Arnd Bergmann      2018-04-27   85  }
b9ff604cff1135 Arnd Bergmann      2018-04-27   86  
a3ed0e4393d688 Thomas Gleixner    2018-04-25   87  /**
a3ed0e4393d688 Thomas Gleixner    2018-04-25   88   * ktime_get_boottime - Returns monotonic time since boot in ktime_t format
a3ed0e4393d688 Thomas Gleixner    2018-04-25   89   *
a3ed0e4393d688 Thomas Gleixner    2018-04-25   90   * This is similar to CLOCK_MONTONIC/ktime_get, but also includes the
a3ed0e4393d688 Thomas Gleixner    2018-04-25   91   * time spent in suspend.
a3ed0e4393d688 Thomas Gleixner    2018-04-25   92   */
a3ed0e4393d688 Thomas Gleixner    2018-04-25   93  static inline ktime_t ktime_get_boottime(void)
a3ed0e4393d688 Thomas Gleixner    2018-04-25   94  {
a3ed0e4393d688 Thomas Gleixner    2018-04-25   95  	return ktime_get_with_offset(TK_OFFS_BOOT);
a3ed0e4393d688 Thomas Gleixner    2018-04-25   96  }
a3ed0e4393d688 Thomas Gleixner    2018-04-25   97  
b9ff604cff1135 Arnd Bergmann      2018-04-27   98  static inline ktime_t ktime_get_coarse_boottime(void)
b9ff604cff1135 Arnd Bergmann      2018-04-27   99  {
b9ff604cff1135 Arnd Bergmann      2018-04-27  100  	return ktime_get_coarse_with_offset(TK_OFFS_BOOT);
b9ff604cff1135 Arnd Bergmann      2018-04-27  101  }
b9ff604cff1135 Arnd Bergmann      2018-04-27  102  
afab07c0e91ecf Thomas Gleixner    2014-07-16  103  /**
afab07c0e91ecf Thomas Gleixner    2014-07-16  104   * ktime_get_clocktai - Returns the TAI time of day in ktime_t format
afab07c0e91ecf Thomas Gleixner    2014-07-16  105   */
afab07c0e91ecf Thomas Gleixner    2014-07-16  106  static inline ktime_t ktime_get_clocktai(void)
afab07c0e91ecf Thomas Gleixner    2014-07-16  107  {
afab07c0e91ecf Thomas Gleixner    2014-07-16  108  	return ktime_get_with_offset(TK_OFFS_TAI);
afab07c0e91ecf Thomas Gleixner    2014-07-16  109  }
afab07c0e91ecf Thomas Gleixner    2014-07-16  110  
b9ff604cff1135 Arnd Bergmann      2018-04-27  111  static inline ktime_t ktime_get_coarse_clocktai(void)
b9ff604cff1135 Arnd Bergmann      2018-04-27  112  {
b9ff604cff1135 Arnd Bergmann      2018-04-27  113  	return ktime_get_coarse_with_offset(TK_OFFS_TAI);
b9ff604cff1135 Arnd Bergmann      2018-04-27  114  }
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

:::::: The code at line 67 was first introduced by commit
:::::: 8b094cd03b4a3793220d8d8d86a173bfea8c285b time: Consolidate the time accessor prototypes

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: John Stultz <john.stultz@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDCE4FAEFC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243647AbiDJQi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243638AbiDJQiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:38:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09463E5D1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 09:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649608573; x=1681144573;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0loIYloekvVvTlX2yLo5GDVjRZ0YZqklYTVZObxaBDw=;
  b=RiKkkE4OVSsqNUnimDJmEJLAagsWJDMVm6PtlPcO5HMTy+5/7salXylW
   0/TKoawVqff6o12RA4hC4j135yDeqmMw0nA6y0hqNSin3H2Qd9iYEG6nP
   5GbonPN04XMk010Gl1b8oITXOD+H97LADFV7Yv2R0SRbp64x2t/BfDCvw
   CfbAWA0JD/fl5b3sCq7SnP64GcHq2iL0fEQwg8mEBVcJNbO4rEpuBgvyZ
   c9OpmCC6WBAm7eKrQHef5pjN9AGCahOIHmTB4uzSEDTJLsJ630RofgeGi
   RiAJFe8tvpMZwiRzvDPhwL4dL7g4GSr4NdnSEgfS3WrC2uWBxkToawXXd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="243865355"
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; 
   d="scan'208";a="243865355"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 09:36:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; 
   d="scan'208";a="723659559"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Apr 2022 09:36:11 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndaXr-0000xT-0X;
        Sun, 10 Apr 2022 16:36:11 +0000
Date:   Mon, 11 Apr 2022 00:35:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, zx2c4@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [crng-random:jd/not-zero-entropy-ktime 10/13]
 include/linux/timekeeping.h:67:8: error: unknown type name 'ktime_t'
Message-ID: <202204110039.Gmsp6oBu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git jd/not-zero-entropy-ktime
head:   340a25fe529e8fc1df1a82b42f021a9d0fa4fb51
commit: 7376542333df813e81252121f5ebd8e91c0fb3b6 [10/13] x86: use ktime_read_raw_clock() for random_get_entropy() instead of zero
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220411/202204110039.Gmsp6oBu-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=7376542333df813e81252121f5ebd8e91c0fb3b6
        git remote add crng-random git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
        git fetch --no-tags crng-random jd/not-zero-entropy-ktime
        git checkout 7376542333df813e81252121f5ebd8e91c0fb3b6
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/tsc.h:8,
                    from arch/x86/include/asm/timex.h:6,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/ktime.h:24,
                    from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/mm_types.h:18,
                    from include/linux/mmzone.h:21,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
>> include/linux/timekeeping.h:67:8: error: unknown type name 'ktime_t'
      67 | extern ktime_t ktime_get(void);
         |        ^~~~~~~
   include/linux/timekeeping.h:68:8: error: unknown type name 'ktime_t'
      68 | extern ktime_t ktime_get_with_offset(enum tk_offsets offs);
         |        ^~~~~~~
   include/linux/timekeeping.h:69:8: error: unknown type name 'ktime_t'
      69 | extern ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs);
         |        ^~~~~~~
   include/linux/timekeeping.h:70:8: error: unknown type name 'ktime_t'
      70 | extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
         |        ^~~~~~~
   include/linux/timekeeping.h:70:34: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
      70 | extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
         |                                  ^~~~~~~
         |                                  timer_t
   include/linux/timekeeping.h:71:8: error: unknown type name 'ktime_t'
      71 | extern ktime_t ktime_get_raw(void);
         |        ^~~~~~~
   include/linux/timekeeping.h:77:15: error: unknown type name 'ktime_t'
      77 | static inline ktime_t ktime_get_real(void)
         |               ^~~~~~~
   include/linux/timekeeping.h:82:15: error: unknown type name 'ktime_t'
      82 | static inline ktime_t ktime_get_coarse_real(void)
         |               ^~~~~~~
   include/linux/timekeeping.h:93:15: error: unknown type name 'ktime_t'
      93 | static inline ktime_t ktime_get_boottime(void)
         |               ^~~~~~~
   include/linux/timekeeping.h:98:15: error: unknown type name 'ktime_t'
      98 | static inline ktime_t ktime_get_coarse_boottime(void)
         |               ^~~~~~~
   include/linux/timekeeping.h:106:15: error: unknown type name 'ktime_t'
     106 | static inline ktime_t ktime_get_clocktai(void)
         |               ^~~~~~~
   include/linux/timekeeping.h:111:15: error: unknown type name 'ktime_t'
     111 | static inline ktime_t ktime_get_coarse_clocktai(void)
         |               ^~~~~~~
   include/linux/timekeeping.h:116:15: error: unknown type name 'ktime_t'
     116 | static inline ktime_t ktime_get_coarse(void)
         |               ^~~~~~~
   include/linux/timekeeping.h: In function 'ktime_get_coarse':
>> include/linux/timekeeping.h:121:16: error: implicit declaration of function 'timespec64_to_ktime'; did you mean 'timespec64_to_ns'? [-Werror=implicit-function-declaration]
     121 |         return timespec64_to_ktime(ts);
         |                ^~~~~~~~~~~~~~~~~~~
         |                timespec64_to_ns
   include/linux/timekeeping.h: In function 'ktime_get_coarse_ns':
>> include/linux/timekeeping.h:126:16: error: implicit declaration of function 'ktime_to_ns' [-Werror=implicit-function-declaration]
     126 |         return ktime_to_ns(ktime_get_coarse());
         |                ^~~~~~~~~~~
   include/linux/timekeeping.h: At top level:
   include/linux/timekeeping.h:147:15: error: unknown type name 'ktime_t'
     147 | static inline ktime_t ktime_mono_to_real(ktime_t mono)
         |               ^~~~~~~
   include/linux/timekeeping.h:147:42: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
     147 | static inline ktime_t ktime_mono_to_real(ktime_t mono)
         |                                          ^~~~~~~
         |                                          timer_t
   include/linux/timekeeping.h: In function 'ktime_get_boottime_ts64':
>> include/linux/timekeeping.h:191:15: error: implicit declaration of function 'ktime_to_timespec64'; did you mean 'ns_to_timespec64'? [-Werror=implicit-function-declaration]
     191 |         *ts = ktime_to_timespec64(ktime_get_boottime());
         |               ^~~~~~~~~~~~~~~~~~~
         |               ns_to_timespec64
>> include/linux/timekeeping.h:191:15: error: incompatible types when assigning to type 'struct timespec64' from type 'int'
   include/linux/timekeeping.h: In function 'ktime_get_coarse_boottime_ts64':
   include/linux/timekeeping.h:196:15: error: incompatible types when assigning to type 'struct timespec64' from type 'int'
     196 |         *ts = ktime_to_timespec64(ktime_get_coarse_boottime());
         |               ^~~~~~~~~~~~~~~~~~~
   include/linux/timekeeping.h: In function 'ktime_get_boottime_seconds':
>> include/linux/timekeeping.h:201:16: error: implicit declaration of function 'ktime_divns'; did you mean 'ktime_get_ns'? [-Werror=implicit-function-declaration]
     201 |         return ktime_divns(ktime_get_coarse_boottime(), NSEC_PER_SEC);
         |                ^~~~~~~~~~~
         |                ktime_get_ns
   include/linux/timekeeping.h: In function 'ktime_get_clocktai_ts64':
   include/linux/timekeeping.h:206:15: error: incompatible types when assigning to type 'struct timespec64' from type 'int'
     206 |         *ts = ktime_to_timespec64(ktime_get_clocktai());
         |               ^~~~~~~~~~~~~~~~~~~
   include/linux/timekeeping.h: In function 'ktime_get_coarse_clocktai_ts64':
   include/linux/timekeeping.h:211:15: error: incompatible types when assigning to type 'struct timespec64' from type 'int'
     211 |         *ts = ktime_to_timespec64(ktime_get_coarse_clocktai());
         |               ^~~~~~~~~~~~~~~~~~~
   include/linux/timekeeping.h: At top level:
   include/linux/timekeeping.h:250:9: error: unknown type name 'ktime_t'
     250 |         ktime_t                 real;
         |         ^~~~~~~
   include/linux/timekeeping.h:251:9: error: unknown type name 'ktime_t'
     251 |         ktime_t                 raw;
         |         ^~~~~~~
   include/linux/timekeeping.h:265:9: error: unknown type name 'ktime_t'
     265 |         ktime_t device;
         |         ^~~~~~~
   include/linux/timekeeping.h:266:9: error: unknown type name 'ktime_t'
     266 |         ktime_t sys_realtime;
         |         ^~~~~~~
   include/linux/timekeeping.h:267:9: error: unknown type name 'ktime_t'
     267 |         ktime_t sys_monoraw;
         |         ^~~~~~~
   include/linux/timekeeping.h:286:44: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
     286 |                         int (*get_time_fn)(ktime_t *device_time,
         |                                            ^~~~~~~
         |                                            timer_t
>> include/linux/timekeeping.h:289:25: error: expected ';', ',' or ')' before 'void'
     289 |                         void *ctx,
         |                         ^~~~
   In file included from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/mm_types.h:18,
                    from include/linux/mmzone.h:21,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
>> include/linux/ktime.h:71:23: error: conflicting types for 'timespec64_to_ktime'; have 'ktime_t(struct timespec64)' {aka 'long long int(struct timespec64)'}
      71 | static inline ktime_t timespec64_to_ktime(struct timespec64 ts)
         |                       ^~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/tsc.h:8,
                    from arch/x86/include/asm/timex.h:6,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/ktime.h:24,
                    from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/mm_types.h:18,
                    from include/linux/mmzone.h:21,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/timekeeping.h:121:16: note: previous implicit declaration of 'timespec64_to_ktime' with type 'int()'
     121 |         return timespec64_to_ktime(ts);
         |                ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/mm_types.h:18,
                    from include/linux/mmzone.h:21,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
>> include/linux/ktime.h:80:19: error: conflicting types for 'ktime_to_ns'; have 's64(const ktime_t)' {aka 'long long int(const long long int)'}
      80 | static inline s64 ktime_to_ns(const ktime_t kt)
         |                   ^~~~~~~~~~~
   In file included from arch/x86/include/asm/tsc.h:8,
                    from arch/x86/include/asm/timex.h:6,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/ktime.h:24,
                    from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/mm_types.h:18,
                    from include/linux/mmzone.h:21,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/timekeeping.h:126:16: note: previous implicit declaration of 'ktime_to_ns' with type 'int()'
     126 |         return ktime_to_ns(ktime_get_coarse());
         |                ^~~~~~~~~~~
   In file included from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/mm_types.h:18,
                    from include/linux/mmzone.h:21,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
>> include/linux/ktime.h:130:19: error: conflicting types for 'ktime_divns'; have 's64(const ktime_t,  s64)' {aka 'long long int(const long long int,  long long int)'}
     130 | static inline s64 ktime_divns(const ktime_t kt, s64 div)
         |                   ^~~~~~~~~~~
   In file included from arch/x86/include/asm/tsc.h:8,
                    from arch/x86/include/asm/timex.h:6,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/ktime.h:24,
                    from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/mm_types.h:18,
                    from include/linux/mmzone.h:21,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/timekeeping.h:201:16: note: previous implicit declaration of 'ktime_divns' with type 'int()'
     201 |         return ktime_divns(ktime_get_coarse_boottime(), NSEC_PER_SEC);
         |                ^~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:120: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/ktime_t +67 include/linux/timekeeping.h

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
b9ff604cff1135 Arnd Bergmann      2018-04-27 @111  static inline ktime_t ktime_get_coarse_clocktai(void)
b9ff604cff1135 Arnd Bergmann      2018-04-27  112  {
b9ff604cff1135 Arnd Bergmann      2018-04-27  113  	return ktime_get_coarse_with_offset(TK_OFFS_TAI);
b9ff604cff1135 Arnd Bergmann      2018-04-27  114  }
b9ff604cff1135 Arnd Bergmann      2018-04-27  115  
4c54294d01e605 Jason A. Donenfeld 2019-06-21 @116  static inline ktime_t ktime_get_coarse(void)
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
4c54294d01e605 Jason A. Donenfeld 2019-06-21  129  static inline u64 ktime_get_coarse_real_ns(void)
4c54294d01e605 Jason A. Donenfeld 2019-06-21  130  {
4c54294d01e605 Jason A. Donenfeld 2019-06-21  131  	return ktime_to_ns(ktime_get_coarse_real());
4c54294d01e605 Jason A. Donenfeld 2019-06-21  132  }
4c54294d01e605 Jason A. Donenfeld 2019-06-21  133  
d48e0cd8fcaf31 Jason A. Donenfeld 2019-06-24  134  static inline u64 ktime_get_coarse_boottime_ns(void)
4c54294d01e605 Jason A. Donenfeld 2019-06-21  135  {
4c54294d01e605 Jason A. Donenfeld 2019-06-21  136  	return ktime_to_ns(ktime_get_coarse_boottime());
4c54294d01e605 Jason A. Donenfeld 2019-06-21  137  }
4c54294d01e605 Jason A. Donenfeld 2019-06-21  138  
4c54294d01e605 Jason A. Donenfeld 2019-06-21  139  static inline u64 ktime_get_coarse_clocktai_ns(void)
4c54294d01e605 Jason A. Donenfeld 2019-06-21  140  {
4c54294d01e605 Jason A. Donenfeld 2019-06-21  141  	return ktime_to_ns(ktime_get_coarse_clocktai());
4c54294d01e605 Jason A. Donenfeld 2019-06-21  142  }
4c54294d01e605 Jason A. Donenfeld 2019-06-21  143  
9a6b51976ea3a3 Thomas Gleixner    2014-07-16  144  /**
9a6b51976ea3a3 Thomas Gleixner    2014-07-16  145   * ktime_mono_to_real - Convert monotonic time to clock realtime
9a6b51976ea3a3 Thomas Gleixner    2014-07-16  146   */
9a6b51976ea3a3 Thomas Gleixner    2014-07-16 @147  static inline ktime_t ktime_mono_to_real(ktime_t mono)
9a6b51976ea3a3 Thomas Gleixner    2014-07-16  148  {
9a6b51976ea3a3 Thomas Gleixner    2014-07-16  149  	return ktime_mono_to_any(mono, TK_OFFS_REAL);
9a6b51976ea3a3 Thomas Gleixner    2014-07-16  150  }
9a6b51976ea3a3 Thomas Gleixner    2014-07-16  151  
897994e32b2b0a Thomas Gleixner    2014-07-16  152  static inline u64 ktime_get_ns(void)
897994e32b2b0a Thomas Gleixner    2014-07-16  153  {
897994e32b2b0a Thomas Gleixner    2014-07-16  154  	return ktime_to_ns(ktime_get());
897994e32b2b0a Thomas Gleixner    2014-07-16  155  }
897994e32b2b0a Thomas Gleixner    2014-07-16  156  
897994e32b2b0a Thomas Gleixner    2014-07-16  157  static inline u64 ktime_get_real_ns(void)
897994e32b2b0a Thomas Gleixner    2014-07-16  158  {
897994e32b2b0a Thomas Gleixner    2014-07-16  159  	return ktime_to_ns(ktime_get_real());
897994e32b2b0a Thomas Gleixner    2014-07-16  160  }
897994e32b2b0a Thomas Gleixner    2014-07-16  161  
9285ec4c8b61d4 Jason A. Donenfeld 2019-06-21  162  static inline u64 ktime_get_boottime_ns(void)
a3ed0e4393d688 Thomas Gleixner    2018-04-25  163  {
a3ed0e4393d688 Thomas Gleixner    2018-04-25  164  	return ktime_to_ns(ktime_get_boottime());
a3ed0e4393d688 Thomas Gleixner    2018-04-25  165  }
a3ed0e4393d688 Thomas Gleixner    2018-04-25  166  
9285ec4c8b61d4 Jason A. Donenfeld 2019-06-21  167  static inline u64 ktime_get_clocktai_ns(void)
fe5fba05b46c79 Peter Zijlstra     2015-03-17  168  {
fe5fba05b46c79 Peter Zijlstra     2015-03-17  169  	return ktime_to_ns(ktime_get_clocktai());
fe5fba05b46c79 Peter Zijlstra     2015-03-17  170  }
fe5fba05b46c79 Peter Zijlstra     2015-03-17  171  
f519b1a2e08c91 Thomas Gleixner    2014-07-16  172  static inline u64 ktime_get_raw_ns(void)
f519b1a2e08c91 Thomas Gleixner    2014-07-16  173  {
f519b1a2e08c91 Thomas Gleixner    2014-07-16  174  	return ktime_to_ns(ktime_get_raw());
f519b1a2e08c91 Thomas Gleixner    2014-07-16  175  }
f519b1a2e08c91 Thomas Gleixner    2014-07-16  176  
4396e058c52e16 Thomas Gleixner    2014-07-16  177  extern u64 ktime_get_mono_fast_ns(void);
f09cb9a1808e35 Peter Zijlstra     2015-03-19  178  extern u64 ktime_get_raw_fast_ns(void);
a3ed0e4393d688 Thomas Gleixner    2018-04-25  179  extern u64 ktime_get_boot_fast_ns(void);
4c3711d7fb4763 Thomas Gleixner    2017-08-31  180  extern u64 ktime_get_real_fast_ns(void);
4396e058c52e16 Thomas Gleixner    2014-07-16  181  
470269027fe7c6 Jason A. Donenfeld 2022-04-10  182  extern u64 ktime_read_raw_clock(void);
470269027fe7c6 Jason A. Donenfeld 2022-04-10  183  
d6c7270e913db7 Thomas Gleixner    2018-03-01  184  /*
06aa376903b6e8 Arnd Bergmann      2018-04-27  185   * timespec64/time64_t interfaces utilizing the ktime based ones
06aa376903b6e8 Arnd Bergmann      2018-04-27  186   * for API completeness, these could be implemented more efficiently
06aa376903b6e8 Arnd Bergmann      2018-04-27  187   * if needed.
d6c7270e913db7 Thomas Gleixner    2018-03-01  188   */
fb7fcc96a86cfa Arnd Bergmann      2018-04-27  189  static inline void ktime_get_boottime_ts64(struct timespec64 *ts)
a3ed0e4393d688 Thomas Gleixner    2018-04-25  190  {
a3ed0e4393d688 Thomas Gleixner    2018-04-25 @191  	*ts = ktime_to_timespec64(ktime_get_boottime());
a3ed0e4393d688 Thomas Gleixner    2018-04-25  192  }
a3ed0e4393d688 Thomas Gleixner    2018-04-25  193  
06aa376903b6e8 Arnd Bergmann      2018-04-27  194  static inline void ktime_get_coarse_boottime_ts64(struct timespec64 *ts)
06aa376903b6e8 Arnd Bergmann      2018-04-27  195  {
06aa376903b6e8 Arnd Bergmann      2018-04-27  196  	*ts = ktime_to_timespec64(ktime_get_coarse_boottime());
06aa376903b6e8 Arnd Bergmann      2018-04-27  197  }
06aa376903b6e8 Arnd Bergmann      2018-04-27  198  
06aa376903b6e8 Arnd Bergmann      2018-04-27  199  static inline time64_t ktime_get_boottime_seconds(void)
06aa376903b6e8 Arnd Bergmann      2018-04-27  200  {
06aa376903b6e8 Arnd Bergmann      2018-04-27 @201  	return ktime_divns(ktime_get_coarse_boottime(), NSEC_PER_SEC);
06aa376903b6e8 Arnd Bergmann      2018-04-27  202  }
06aa376903b6e8 Arnd Bergmann      2018-04-27  203  

:::::: The code at line 67 was first introduced by commit
:::::: 8b094cd03b4a3793220d8d8d86a173bfea8c285b time: Consolidate the time accessor prototypes

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: John Stultz <john.stultz@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

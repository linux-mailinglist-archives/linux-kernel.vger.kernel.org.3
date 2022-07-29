Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EFC5853FF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 18:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbiG2QwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 12:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiG2QwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 12:52:14 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9404088E1D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 09:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659113533; x=1690649533;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rH9DALkJh/2yzBIghrj1jmLQXLUVpyKnWjIJZFTik14=;
  b=b93Dl7volb4slHqpjrnkryb+ytK+D/3aZ6cGNuP4NuhIsGZJe/MDjieD
   59uiKQo55C8G5SsW5EYZJSxjKTIBr9UznGGXp1H3Kbtrrb/NEy4PAo/i2
   oKDa6E2UeZ0neB7umnecnn1/TfmNjvqjlxxafWFagOSQHjEeAETPYZkVb
   Q+KFOnN1XetSFgszLeorAtk/NIgjCSdfN+l/b4z19HAsS+PjIwiJtyNbX
   X+WSHV18trVUK9sFPNQP3cLnXjsJmL0D0Y9i+Xgxs6A1mCU5e8GueO6V7
   lMx+krv2TBcB3ju1mEN0Y2P1NAG3f/01jGsvJ4ycMghn+fX6cMBu326T3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="268573224"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="268573224"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 09:52:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="928802115"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jul 2022 09:52:11 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHTDf-000BtH-0d;
        Fri, 29 Jul 2022 16:52:11 +0000
Date:   Sat, 30 Jul 2022 00:52:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/vdso 8/8]
 arch/riscv/include/asm/vdso/gettimeofday.h:21:31: error: use of undeclared
 identifier '__NR_gettimeofday'; did you mean 'sys_gettimeofday'?
Message-ID: <202207300051.IoNQt2j6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/vdso
head:   02d56061c924adece19bdfad05ea4add32de4b63
commit: 02d56061c924adece19bdfad05ea4add32de4b63 [8/8] random: implement getrandom() in vDSO
config: riscv-randconfig-r042-20220729 (https://download.01.org/0day-ci/archive/20220730/202207300051.IoNQt2j6-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8dfaecc4c24494337933aff9d9166486ca0949f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/02d56061c924adece19bdfad05ea4add32de4b63
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/vdso
        git checkout 02d56061c924adece19bdfad05ea4add32de4b63
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/char/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/char/random.c:62:
   In file included from include/vdso/datapage.h:143:
>> arch/riscv/include/asm/vdso/gettimeofday.h:21:31: error: use of undeclared identifier '__NR_gettimeofday'; did you mean 'sys_gettimeofday'?
           register long nr asm("a7") = __NR_gettimeofday;
                                        ^~~~~~~~~~~~~~~~~
                                        sys_gettimeofday
   include/linux/syscalls.h:775:17: note: 'sys_gettimeofday' declared here
   asmlinkage long sys_gettimeofday(struct __kernel_old_timeval __user *tv,
                   ^
   In file included from drivers/char/random.c:62:
   In file included from include/vdso/datapage.h:143:
>> arch/riscv/include/asm/vdso/gettimeofday.h:21:16: error: incompatible pointer to integer conversion initializing 'long' with an expression of type 'long (struct __kernel_old_timeval *, struct timezone *)' [-Wint-conversion]
           register long nr asm("a7") = __NR_gettimeofday;
                         ^              ~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/vdso/gettimeofday.h:37:31: error: use of undeclared identifier '__NR_clock_gettime'; did you mean 'sys_clock_gettime'?
           register long nr asm("a7") = __NR_clock_gettime;
                                        ^~~~~~~~~~~~~~~~~~
                                        sys_clock_gettime
   include/linux/syscalls.h:663:17: note: 'sys_clock_gettime' declared here
   asmlinkage long sys_clock_gettime(clockid_t which_clock,
                   ^
   In file included from drivers/char/random.c:62:
   In file included from include/vdso/datapage.h:143:
>> arch/riscv/include/asm/vdso/gettimeofday.h:37:16: error: incompatible pointer to integer conversion initializing 'long' with an expression of type 'long (clockid_t, struct __kernel_timespec *)' (aka 'long (int, struct __kernel_timespec *)') [-Wint-conversion]
           register long nr asm("a7") = __NR_clock_gettime;
                         ^              ~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/vdso/gettimeofday.h:53:31: error: use of undeclared identifier '__NR_clock_getres'; did you mean 'sys_clock_getres'?
           register long nr asm("a7") = __NR_clock_getres;
                                        ^~~~~~~~~~~~~~~~~
                                        sys_clock_getres
   include/linux/syscalls.h:665:17: note: 'sys_clock_getres' declared here
   asmlinkage long sys_clock_getres(clockid_t which_clock,
                   ^
   In file included from drivers/char/random.c:62:
   In file included from include/vdso/datapage.h:143:
   arch/riscv/include/asm/vdso/gettimeofday.h:53:16: error: incompatible pointer to integer conversion initializing 'long' with an expression of type 'long (clockid_t, struct __kernel_timespec *)' (aka 'long (int, struct __kernel_timespec *)') [-Wint-conversion]
           register long nr asm("a7") = __NR_clock_getres;
                         ^              ~~~~~~~~~~~~~~~~~
>> drivers/char/random.c:88:42: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
   DEFINE_VVAR_SINGLE(struct vdso_rng_data, _vdso_rng_data);
                                            ^
                                            int
   drivers/char/random.c:88:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
   DEFINE_VVAR_SINGLE(struct vdso_rng_data, _vdso_rng_data);
   ^
   int
   8 errors generated.


vim +21 arch/riscv/include/asm/vdso/gettimeofday.h

ad5d1122b82fbd Vincent Chen 2020-06-09  13  
ad5d1122b82fbd Vincent Chen 2020-06-09  14  static __always_inline
ad5d1122b82fbd Vincent Chen 2020-06-09  15  int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
ad5d1122b82fbd Vincent Chen 2020-06-09  16  			  struct timezone *_tz)
ad5d1122b82fbd Vincent Chen 2020-06-09  17  {
ad5d1122b82fbd Vincent Chen 2020-06-09  18  	register struct __kernel_old_timeval *tv asm("a0") = _tv;
ad5d1122b82fbd Vincent Chen 2020-06-09  19  	register struct timezone *tz asm("a1") = _tz;
ad5d1122b82fbd Vincent Chen 2020-06-09  20  	register long ret asm("a0");
ad5d1122b82fbd Vincent Chen 2020-06-09 @21  	register long nr asm("a7") = __NR_gettimeofday;
ad5d1122b82fbd Vincent Chen 2020-06-09  22  
ad5d1122b82fbd Vincent Chen 2020-06-09  23  	asm volatile ("ecall\n"
ad5d1122b82fbd Vincent Chen 2020-06-09  24  		      : "=r" (ret)
ad5d1122b82fbd Vincent Chen 2020-06-09  25  		      : "r"(tv), "r"(tz), "r"(nr)
ad5d1122b82fbd Vincent Chen 2020-06-09  26  		      : "memory");
ad5d1122b82fbd Vincent Chen 2020-06-09  27  
ad5d1122b82fbd Vincent Chen 2020-06-09  28  	return ret;
ad5d1122b82fbd Vincent Chen 2020-06-09  29  }
ad5d1122b82fbd Vincent Chen 2020-06-09  30  
ad5d1122b82fbd Vincent Chen 2020-06-09  31  static __always_inline
ad5d1122b82fbd Vincent Chen 2020-06-09  32  long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
ad5d1122b82fbd Vincent Chen 2020-06-09  33  {
ad5d1122b82fbd Vincent Chen 2020-06-09  34  	register clockid_t clkid asm("a0") = _clkid;
ad5d1122b82fbd Vincent Chen 2020-06-09  35  	register struct __kernel_timespec *ts asm("a1") = _ts;
ad5d1122b82fbd Vincent Chen 2020-06-09  36  	register long ret asm("a0");
ad5d1122b82fbd Vincent Chen 2020-06-09 @37  	register long nr asm("a7") = __NR_clock_gettime;
ad5d1122b82fbd Vincent Chen 2020-06-09  38  
ad5d1122b82fbd Vincent Chen 2020-06-09  39  	asm volatile ("ecall\n"
ad5d1122b82fbd Vincent Chen 2020-06-09  40  		      : "=r" (ret)
ad5d1122b82fbd Vincent Chen 2020-06-09  41  		      : "r"(clkid), "r"(ts), "r"(nr)
ad5d1122b82fbd Vincent Chen 2020-06-09  42  		      : "memory");
ad5d1122b82fbd Vincent Chen 2020-06-09  43  
ad5d1122b82fbd Vincent Chen 2020-06-09  44  	return ret;
ad5d1122b82fbd Vincent Chen 2020-06-09  45  }
ad5d1122b82fbd Vincent Chen 2020-06-09  46  
ad5d1122b82fbd Vincent Chen 2020-06-09  47  static __always_inline
ad5d1122b82fbd Vincent Chen 2020-06-09  48  int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
ad5d1122b82fbd Vincent Chen 2020-06-09  49  {
ad5d1122b82fbd Vincent Chen 2020-06-09  50  	register clockid_t clkid asm("a0") = _clkid;
ad5d1122b82fbd Vincent Chen 2020-06-09  51  	register struct __kernel_timespec *ts asm("a1") = _ts;
ad5d1122b82fbd Vincent Chen 2020-06-09  52  	register long ret asm("a0");
ad5d1122b82fbd Vincent Chen 2020-06-09 @53  	register long nr asm("a7") = __NR_clock_getres;
ad5d1122b82fbd Vincent Chen 2020-06-09  54  
ad5d1122b82fbd Vincent Chen 2020-06-09  55  	asm volatile ("ecall\n"
ad5d1122b82fbd Vincent Chen 2020-06-09  56  		      : "=r" (ret)
ad5d1122b82fbd Vincent Chen 2020-06-09  57  		      : "r"(clkid), "r"(ts), "r"(nr)
ad5d1122b82fbd Vincent Chen 2020-06-09  58  		      : "memory");
ad5d1122b82fbd Vincent Chen 2020-06-09  59  
ad5d1122b82fbd Vincent Chen 2020-06-09  60  	return ret;
ad5d1122b82fbd Vincent Chen 2020-06-09  61  }
ad5d1122b82fbd Vincent Chen 2020-06-09  62  

:::::: The code at line 21 was first introduced by commit
:::::: ad5d1122b82fbd6a816d1b9d26ee01a6dbc2d757 riscv: use vDSO common flow to reduce the latency of the time-related functions

:::::: TO: Vincent Chen <vincent.chen@sifive.com>
:::::: CC: Palmer Dabbelt <palmerdabbelt@google.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

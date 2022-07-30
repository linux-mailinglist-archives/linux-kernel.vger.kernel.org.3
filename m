Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242AF585854
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 05:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbiG3Doo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 23:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbiG3Doj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 23:44:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643D36D556
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 20:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659152678; x=1690688678;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VYF7j13oSTBVUdfa294ztvd5M5z5fuCnk/gCy9go4mk=;
  b=OLiJsZMiok6qq9mtdhNKXb7MRqSp+CgsDhTFCBMI8krYlkEYANfHfEOu
   HXOnhJMxjL8Uv5a50WqNS5eEieY4Rak/KLEykl+lJCNAAgdkjKkM+xm/n
   z35SvMPTy/LgisMmVasxAKDedMSJUE6FJCbYNs7gtpLWVODA8Z7XZd/Vw
   Wyeg6XrgvUCfkHV6XgAuqBpbWs+VZ1Nzx82oEEc2GdqtbXhORjjBTNeXb
   BzaLMhm0KMQiRDl/kkDDKLw46fCw9P4n9pWKuj6h0dbJFPF5bksPH+1r8
   JgyLp4UbVVuxYtLGQyBFw3KmVHRCjiY0+HpNd7zW1nhZ/BLs3H5d+EXK2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="269270917"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="269270917"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 20:44:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="634325816"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Jul 2022 20:44:36 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHdP1-000CLV-1d;
        Sat, 30 Jul 2022 03:44:35 +0000
Date:   Sat, 30 Jul 2022 11:44:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/vdso 8/8]
 arch/riscv/include/asm/vdso/gettimeofday.h:21:38: error: '__NR_gettimeofday'
 undeclared; did you mean 'sys_gettimeofday'?
Message-ID: <202207301141.7UdnHjAc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/vdso
head:   65b88fc7d65669b6a7f4225aa00acf18b82a7682
commit: 65b88fc7d65669b6a7f4225aa00acf18b82a7682 [8/8] random: implement getrandom() in vDSO
config: riscv-randconfig-r033-20220729 (https://download.01.org/0day-ci/archive/20220730/202207301141.7UdnHjAc-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/65b88fc7d65669b6a7f4225aa00acf18b82a7682
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/vdso
        git checkout 65b88fc7d65669b6a7f4225aa00acf18b82a7682
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/char/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/vdso/datapage.h:143,
                    from drivers/char/random.c:62:
   arch/riscv/include/asm/vdso/gettimeofday.h: In function 'gettimeofday_fallback':
>> arch/riscv/include/asm/vdso/gettimeofday.h:21:38: error: '__NR_gettimeofday' undeclared (first use in this function); did you mean 'sys_gettimeofday'?
      21 |         register long nr asm("a7") = __NR_gettimeofday;
         |                                      ^~~~~~~~~~~~~~~~~
         |                                      sys_gettimeofday
   arch/riscv/include/asm/vdso/gettimeofday.h:21:38: note: each undeclared identifier is reported only once for each function it appears in
   arch/riscv/include/asm/vdso/gettimeofday.h: In function 'clock_gettime_fallback':
>> arch/riscv/include/asm/vdso/gettimeofday.h:37:38: error: '__NR_clock_gettime' undeclared (first use in this function); did you mean 'sys_clock_gettime'?
      37 |         register long nr asm("a7") = __NR_clock_gettime;
         |                                      ^~~~~~~~~~~~~~~~~~
         |                                      sys_clock_gettime
   arch/riscv/include/asm/vdso/gettimeofday.h: In function 'clock_getres_fallback':
>> arch/riscv/include/asm/vdso/gettimeofday.h:53:38: error: '__NR_clock_getres' undeclared (first use in this function); did you mean 'sys_clock_getres'?
      53 |         register long nr asm("a7") = __NR_clock_getres;
         |                                      ^~~~~~~~~~~~~~~~~
         |                                      sys_clock_getres
   drivers/char/random.c: At top level:
   drivers/char/random.c:88:42: error: expected declaration specifiers or '...' before '_vdso_rng_data'
      88 | DEFINE_VVAR_SINGLE(struct vdso_rng_data, _vdso_rng_data);
         |                                          ^~~~~~~~~~~~~~


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

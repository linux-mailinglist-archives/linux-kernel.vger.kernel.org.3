Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF664CB600
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 05:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiCCEze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 23:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiCCEzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 23:55:32 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B0312A767
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 20:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646283287; x=1677819287;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TAdTWW9fmnF0PrDe6bJdQ3LCYVJBCPRMITyyukJOaxM=;
  b=U1qYwojkH40Vf/sLZv6wldy2vNbH5MY+QNRpAR65XrRcNG0Hbjt3VMkj
   n1z+/xeV2zVUwJQlSLz/u74R0m3IWG0X6ARBAiCQF4ryMqZ8Bves0z6tt
   5qT/QyOluxugm05NXLgbIhDjA44+58m/EjYRM+q2YHBxap05m+TkTEdnz
   xgz4VkbN3uxK5s1L3D1ML/NSLZ2xH3K/4bomq+hY6WTgF9MEeBuSID/JL
   EPOWyFSIx4+ZraGtoKjoUPYgdvZkw424lnxWSZjZY2zjytjccbhwRT0X8
   2Lj+Ww9qrw8HRjD79DkVjreBifvpLrodpz97Du1fSt57THAFDspy18xmH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="251154468"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="251154468"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 20:54:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="709778425"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Mar 2022 20:54:45 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPdUC-0000AD-9q; Thu, 03 Mar 2022 04:54:44 +0000
Date:   Thu, 3 Mar 2022 12:54:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Alistair Delva <adelva@google.com>,
        Paul Burton <paul.burton@mips.com>,
        Mark Salyzyn <salyzyn@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-stable
 781/9999] arch/mips/include/asm/vdso/gettimeofday.h:68:38: error:
 '__NR_clock_gettime64' undeclared
Message-ID: <202203031232.U5Jeb2G3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincenzo,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-stable
head:   90a691fca4c2525068d9908ac203e9f09e4e33c0
commit: 6b7f832e465d88fca5f3a07b85e664f962c88e0b [781/9999] BACKPORT: mips: Add support for generic vDSO
config: mips-randconfig-r016-20211028 (https://download.01.org/0day-ci/archive/20220303/202203031232.U5Jeb2G3-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/6b7f832e465d88fca5f3a07b85e664f962c88e0b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-stable
        git checkout 6b7f832e465d88fca5f3a07b85e664f962c88e0b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from lib/vdso/gettimeofday.c:26,
                    from <command-line>:
   arch/mips/include/asm/vdso/gettimeofday.h: In function 'clock_gettime_fallback':
>> arch/mips/include/asm/vdso/gettimeofday.h:68:38: error: '__NR_clock_gettime64' undeclared (first use in this function)
      68 |         register long nr asm("v0") = __NR_clock_gettime64;
         |                                      ^~~~~~~~~~~~~~~~~~~~
   arch/mips/include/asm/vdso/gettimeofday.h:68:38: note: each undeclared identifier is reported only once for each function it appears in
   In file included from <command-line>:
   lib/vdso/gettimeofday.c: In function '__cvdso_clock_gettime32':
   lib/vdso/gettimeofday.c:113:20: error: invalid use of undefined type 'struct compat_timespec'
     113 |                 res->tv_sec = ts.tv_sec;
         |                    ^~
   lib/vdso/gettimeofday.c:114:20: error: invalid use of undefined type 'struct compat_timespec'
     114 |                 res->tv_nsec = ts.tv_nsec;
         |                    ^~
   arch/mips/vdso/vgettimeofday.c: At top level:
   arch/mips/vdso/vgettimeofday.c:14:5: warning: no previous prototype for '__vdso_clock_gettime' [-Wmissing-prototypes]
      14 | int __vdso_clock_gettime(clockid_t clock,
         |     ^~~~~~~~~~~~~~~~~~~~
   arch/mips/vdso/vgettimeofday.c:20:5: warning: no previous prototype for '__vdso_gettimeofday' [-Wmissing-prototypes]
      20 | int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
         |     ^~~~~~~~~~~~~~~~~~~


vim +/__NR_clock_gettime64 +68 arch/mips/include/asm/vdso/gettimeofday.h

    57	
    58	static __always_inline long clock_gettime_fallback(
    59						clockid_t _clkid,
    60						struct __kernel_timespec *_ts)
    61	{
    62		register struct __kernel_timespec *ts asm("a1") = _ts;
    63		register clockid_t clkid asm("a0") = _clkid;
    64		register long ret asm("v0");
    65	#if _MIPS_SIM == _MIPS_SIM_ABI64
    66		register long nr asm("v0") = __NR_clock_gettime;
    67	#else
  > 68		register long nr asm("v0") = __NR_clock_gettime64;
    69	#endif
    70		register long error asm("a3");
    71	
    72		asm volatile(
    73		"       syscall\n"
    74		: "=r" (ret), "=r" (error)
    75		: "r" (clkid), "r" (ts), "r" (nr)
    76		: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
    77		  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
    78	
    79		return error ? -ret : ret;
    80	}
    81	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7177C4CB726
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 07:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiCCGrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 01:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCCGre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 01:47:34 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E25CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 22:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646290009; x=1677826009;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RKz7lI9VwsOUnQol4JTL6gKfI3KbW217oCbu7ZsqHYc=;
  b=FrzHLhglhbi8pMzj2vTj96B35bj5XzeRmjgwGZ3eonQrylo5XKPtYKQn
   SvjT6FOwYgA3GQm1gFyLBOrd4T56h9Cfsmt33yekrC2xHimNBPIuEY8SG
   1LP+etsZCOyGmauEOVsjE+WW6VVvMZJGeSVszdLHvhf84GubSrcEA03xm
   T1lhQVU05ehwW2l1ZIjPa5kFkx6OT7bCxB0XGDzBu/6fnkPxyp49IUb93
   D/cORNQjoTuCEIRMPzAbl0vpL0zAd9Zop7ey/qBC2p+ht9FCqJP3p0K2P
   MDKTTmk1JnDG5luDEd4WCkP371zWi9IBBgaUQ9gz1mGHxuqVWa3Ro9/xN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="234207974"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="234207974"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 22:46:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="511306145"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Mar 2022 22:46:47 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPfEc-0000FV-Fd; Thu, 03 Mar 2022 06:46:46 +0000
Date:   Thu, 3 Mar 2022 14:46:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Alistair Delva <adelva@google.com>,
        Paul Burton <paul.burton@mips.com>,
        Mark Salyzyn <salyzyn@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-stable
 782/9999] arch/mips/include/asm/vdso/gettimeofday.h:94:38: error:
 '__NR_clock_getres_time64' undeclared
Message-ID: <202203031405.oBHU6BPY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincenzo,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-stable
head:   90a691fca4c2525068d9908ac203e9f09e4e33c0
commit: 23dea1cf7ed3846719448e74feeb56c28e3a9019 [782/9999] UPSTREAM: mips: Add clock_getres entry point
config: mips-randconfig-r016-20211028 (https://download.01.org/0day-ci/archive/20220303/202203031405.oBHU6BPY-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/23dea1cf7ed3846719448e74feeb56c28e3a9019
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-stable
        git checkout 23dea1cf7ed3846719448e74feeb56c28e3a9019
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/kernel/ arch/mips/vdso/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from lib/vdso/gettimeofday.c:26,
                    from <command-line>:
   arch/mips/include/asm/vdso/gettimeofday.h: In function 'clock_gettime_fallback':
   arch/mips/include/asm/vdso/gettimeofday.h:70:38: error: '__NR_clock_gettime64' undeclared (first use in this function)
      70 |         register long nr asm("v0") = __NR_clock_gettime64;
         |                                      ^~~~~~~~~~~~~~~~~~~~
   arch/mips/include/asm/vdso/gettimeofday.h:70:38: note: each undeclared identifier is reported only once for each function it appears in
   arch/mips/include/asm/vdso/gettimeofday.h: In function 'clock_getres_fallback':
>> arch/mips/include/asm/vdso/gettimeofday.h:94:38: error: '__NR_clock_getres_time64' undeclared (first use in this function)
      94 |         register long nr asm("v0") = __NR_clock_getres_time64;
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
   lib/vdso/gettimeofday.c: In function '__cvdso_clock_gettime32':
   lib/vdso/gettimeofday.c:113:20: error: invalid use of undefined type 'struct compat_timespec'
     113 |                 res->tv_sec = ts.tv_sec;
         |                    ^~
   lib/vdso/gettimeofday.c:114:20: error: invalid use of undefined type 'struct compat_timespec'
     114 |                 res->tv_nsec = ts.tv_nsec;
         |                    ^~
   lib/vdso/gettimeofday.c: In function '__cvdso_clock_getres_time32':
   lib/vdso/gettimeofday.c:219:20: error: invalid use of undefined type 'struct compat_timespec'
     219 |                 res->tv_sec = ts.tv_sec;
         |                    ^~
   lib/vdso/gettimeofday.c:220:20: error: invalid use of undefined type 'struct compat_timespec'
     220 |                 res->tv_nsec = ts.tv_nsec;
         |                    ^~
   arch/mips/vdso/vgettimeofday.c: At top level:
   arch/mips/vdso/vgettimeofday.c:14:5: warning: no previous prototype for '__vdso_clock_gettime' [-Wmissing-prototypes]
      14 | int __vdso_clock_gettime(clockid_t clock,
         |     ^~~~~~~~~~~~~~~~~~~~
   arch/mips/vdso/vgettimeofday.c:20:5: warning: no previous prototype for '__vdso_gettimeofday' [-Wmissing-prototypes]
      20 | int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
         |     ^~~~~~~~~~~~~~~~~~~
   arch/mips/vdso/vgettimeofday.c:26:5: warning: no previous prototype for '__vdso_clock_getres' [-Wmissing-prototypes]
      26 | int __vdso_clock_getres(clockid_t clock_id,
         |     ^~~~~~~~~~~~~~~~~~~


vim +/__NR_clock_getres_time64 +94 arch/mips/include/asm/vdso/gettimeofday.h

    83	
    84	static __always_inline int clock_getres_fallback(
    85						clockid_t _clkid,
    86						struct __kernel_timespec *_ts)
    87	{
    88		register struct __kernel_timespec *ts asm("a1") = _ts;
    89		register clockid_t clkid asm("a0") = _clkid;
    90		register long ret asm("v0");
    91	#if _MIPS_SIM == _MIPS_SIM_ABI64
    92		register long nr asm("v0") = __NR_clock_getres;
    93	#else
  > 94		register long nr asm("v0") = __NR_clock_getres_time64;
    95	#endif
    96		register long error asm("a3");
    97	
    98		asm volatile(
    99		"       syscall\n"
   100		: "=r" (ret), "=r" (error)
   101		: "r" (clkid), "r" (ts), "r" (nr)
   102		: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
   103		  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
   104	
   105		return error ? -ret : ret;
   106	}
   107	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65C34CB98D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiCCIuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiCCItq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:49:46 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE6D14893E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 00:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646297336; x=1677833336;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B9XqYWHLvkaa/TjL816Vc0P9ZGschj6nW7UtG9d7IQA=;
  b=F9wtpKX9J1PmB4iXJJtA5Q070lwSMxpvqVZDI7lcn4haIieyu5KMEZoV
   ZNRdMSXQbrsmTdvokXKgC7NTYXZCgEGM7neRErtqE87Rx9HBPTYHm8ahO
   M5O61xLNtNl8BXn7eLRU1ZthyS7llTowy3z48iI4igmrrKtLpsmq0WVzc
   LG5kxYhN/45vcl2b37XuO5o0EyKooLNV4iFAq+IUaVue915LTGjiCUVvX
   3qrvZyM6qa+bQYZ7wROSIAnDlE5TZi1oUVZyD4Q7NZQmqCUcG8GflmwpQ
   WTZgQv20f5MsGRhGm+B1OIoXAmJDdQ02ViATLNnrdcp4wu+kaq9irX1Yw
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="314335223"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="314335223"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 00:48:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="576416871"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2022 00:48:54 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPh8i-0000KZ-Dv; Thu, 03 Mar 2022 08:48:48 +0000
Date:   Thu, 3 Mar 2022 16:48:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Alistair Delva <adelva@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Salyzyn <salyzyn@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-stable
 811/9999] arch/mips/vdso/vgettimeofday.c:17:16: error: implicit declaration
 of function '__cvdso_clock_gettime32'; did you mean '__cvdso_clock_gettime'?
Message-ID: <202203031603.lmtSJ2SY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
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
commit: 0854e59101a9219eb1607fb584dde8da4dea220e [811/9999] UPSTREAM: lib/vdso: Build 32 bit specific functions in the right context
config: mips-randconfig-r016-20211028 (https://download.01.org/0day-ci/archive/20220303/202203031603.lmtSJ2SY-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/0854e59101a9219eb1607fb584dde8da4dea220e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-stable
        git checkout 0854e59101a9219eb1607fb584dde8da4dea220e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/vdso/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from lib/vdso/gettimeofday.c:26,
                    from <command-line>:
   arch/mips/include/asm/vdso/gettimeofday.h: In function 'clock_gettime_fallback':
   arch/mips/include/asm/vdso/gettimeofday.h:59:38: error: '__NR_clock_gettime64' undeclared (first use in this function)
      59 |         register long nr asm("v0") = __NR_clock_gettime64;
         |                                      ^~~~~~~~~~~~~~~~~~~~
   arch/mips/include/asm/vdso/gettimeofday.h:59:38: note: each undeclared identifier is reported only once for each function it appears in
   arch/mips/include/asm/vdso/gettimeofday.h: In function 'clock_getres_fallback':
   arch/mips/include/asm/vdso/gettimeofday.h:83:38: error: '__NR_clock_getres_time64' undeclared (first use in this function)
      83 |         register long nr asm("v0") = __NR_clock_getres_time64;
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/vdso/vgettimeofday.c: At top level:
   arch/mips/vdso/vgettimeofday.c:14:5: warning: no previous prototype for '__vdso_clock_gettime' [-Wmissing-prototypes]
      14 | int __vdso_clock_gettime(clockid_t clock,
         |     ^~~~~~~~~~~~~~~~~~~~
   arch/mips/vdso/vgettimeofday.c: In function '__vdso_clock_gettime':
>> arch/mips/vdso/vgettimeofday.c:17:16: error: implicit declaration of function '__cvdso_clock_gettime32'; did you mean '__cvdso_clock_gettime'? [-Werror=implicit-function-declaration]
      17 |         return __cvdso_clock_gettime32(clock, ts);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
         |                __cvdso_clock_gettime
   arch/mips/vdso/vgettimeofday.c: At top level:
   arch/mips/vdso/vgettimeofday.c:36:5: warning: no previous prototype for '__vdso_clock_getres' [-Wmissing-prototypes]
      36 | int __vdso_clock_getres(clockid_t clock_id,
         |     ^~~~~~~~~~~~~~~~~~~
   arch/mips/vdso/vgettimeofday.c: In function '__vdso_clock_getres':
>> arch/mips/vdso/vgettimeofday.c:39:16: error: implicit declaration of function '__cvdso_clock_getres_time32'; did you mean '__cvdso_clock_getres_common'? [-Werror=implicit-function-declaration]
      39 |         return __cvdso_clock_getres_time32(clock_id, res);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                __cvdso_clock_getres_common
   arch/mips/vdso/vgettimeofday.c: At top level:
   arch/mips/vdso/vgettimeofday.c:42:5: warning: no previous prototype for '__vdso_clock_gettime64' [-Wmissing-prototypes]
      42 | int __vdso_clock_gettime64(clockid_t clock,
         |     ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +17 arch/mips/vdso/vgettimeofday.c

6b7f832e465d88 Vincenzo Frascino 2019-06-21  12  
6b7f832e465d88 Vincenzo Frascino 2019-06-21  13  #if _MIPS_SIM != _MIPS_SIM_ABI64
6b7f832e465d88 Vincenzo Frascino 2019-06-21  14  int __vdso_clock_gettime(clockid_t clock,
6b7f832e465d88 Vincenzo Frascino 2019-06-21  15  			 struct old_timespec32 *ts)
6b7f832e465d88 Vincenzo Frascino 2019-06-21  16  {
6b7f832e465d88 Vincenzo Frascino 2019-06-21 @17  	return __cvdso_clock_gettime32(clock, ts);
6b7f832e465d88 Vincenzo Frascino 2019-06-21  18  }
6b7f832e465d88 Vincenzo Frascino 2019-06-21  19  
cf84512fe7aac9 Vincenzo Frascino 2019-11-29  20  #ifdef CONFIG_MIPS_CLOCK_VSYSCALL
cf84512fe7aac9 Vincenzo Frascino 2019-11-29  21  
cf84512fe7aac9 Vincenzo Frascino 2019-11-29  22  /*
cf84512fe7aac9 Vincenzo Frascino 2019-11-29  23   * This is behind the ifdef so that we don't provide the symbol when there's no
cf84512fe7aac9 Vincenzo Frascino 2019-11-29  24   * possibility of there being a usable clocksource, because there's nothing we
cf84512fe7aac9 Vincenzo Frascino 2019-11-29  25   * can do without it. When libc fails the symbol lookup it should fall back on
cf84512fe7aac9 Vincenzo Frascino 2019-11-29  26   * the standard syscall path.
cf84512fe7aac9 Vincenzo Frascino 2019-11-29  27   */
6b7f832e465d88 Vincenzo Frascino 2019-06-21  28  int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
6b7f832e465d88 Vincenzo Frascino 2019-06-21  29  			struct timezone *tz)
6b7f832e465d88 Vincenzo Frascino 2019-06-21  30  {
6b7f832e465d88 Vincenzo Frascino 2019-06-21  31  	return __cvdso_gettimeofday(tv, tz);
6b7f832e465d88 Vincenzo Frascino 2019-06-21  32  }
6b7f832e465d88 Vincenzo Frascino 2019-06-21  33  
cf84512fe7aac9 Vincenzo Frascino 2019-11-29  34  #endif /* CONFIG_MIPS_CLOCK_VSYSCALL */
cf84512fe7aac9 Vincenzo Frascino 2019-11-29  35  
23dea1cf7ed384 Vincenzo Frascino 2019-06-21  36  int __vdso_clock_getres(clockid_t clock_id,
23dea1cf7ed384 Vincenzo Frascino 2019-06-21  37  			struct old_timespec32 *res)
23dea1cf7ed384 Vincenzo Frascino 2019-06-21  38  {
23dea1cf7ed384 Vincenzo Frascino 2019-06-21 @39  	return __cvdso_clock_getres_time32(clock_id, res);
23dea1cf7ed384 Vincenzo Frascino 2019-06-21  40  }
23dea1cf7ed384 Vincenzo Frascino 2019-06-21  41  

:::::: The code at line 17 was first introduced by commit
:::::: 6b7f832e465d88fca5f3a07b85e664f962c88e0b BACKPORT: mips: Add support for generic vDSO

:::::: TO: Vincenzo Frascino <vincenzo.frascino@arm.com>
:::::: CC: Alistair Delva <adelva@google.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

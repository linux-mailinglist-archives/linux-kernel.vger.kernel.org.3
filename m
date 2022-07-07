Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D145696FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 02:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbiGGAkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 20:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiGGAku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 20:40:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C032B27A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 17:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657154448; x=1688690448;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=U26n+kQWz0q8wdV12V4isc3Hur5ns80dJIdpJogzFR4=;
  b=NaAiYr9ShvEcUptNZtrlTpnQ901dcFA9ZrpqFYJFFypru8oiWBIzFHXr
   0gXc4OCdVSdEtbrz2QO2HGy1kZwb9AP10fnzQR8GnNz3r98ylaKf7eqVG
   YW2i5+f61q80dro1krEysrDswVihsoCkxaZwrrpcdtu4RZT0TpYn6Vyfq
   ulngePINlK6jHKuAHfQ8ketvfbTt06pvfD8MAySwM4s2wYMfkTvk4Ku12
   6nDjNFQS0KY6lvtQeb6F1AdGqy1coQfYghlWptlFi45xV4ZZw3Ei4MAHg
   oBttOmY2yk7O8dZErrA1yfPzc/8voNuLWsCTdIEvjzA6YCkaYqVsNGdny
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="285023082"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="285023082"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 17:40:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="568294556"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2022 17:40:46 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9FZW-000LJy-3w;
        Thu, 07 Jul 2022 00:40:46 +0000
Date:   Thu, 7 Jul 2022 08:39:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [jirislaby:lto 15/48] kernel/time/posix-stubs.c:34:43: warning:
 'sys_alarm' alias between functions of incompatible types 'long int(unsigned
 int)' and 'long int(void)'
Message-ID: <202207070821.WRhQ8Tjt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git lto
head:   b5ee1c28376713353cb5355716949d9c6d9b416b
commit: 01f5cbe3762954327188971c56f9909e7f29c4a6 [15/48] lto: Use C version for SYSCALL_ALIAS / cond_syscall
config: microblaze-randconfig-r023-20220706 (https://download.01.org/0day-ci/archive/20220707/202207070821.WRhQ8Tjt-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=01f5cbe3762954327188971c56f9909e7f29c4a6
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby lto
        git checkout 01f5cbe3762954327188971c56f9909e7f29c4a6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/time/posix-stubs.c:25:17: warning: no previous prototype for 'sys_ni_posix_timers' [-Wmissing-prototypes]
      25 | asmlinkage long sys_ni_posix_timers(void)
         |                 ^~~~~~~~~~~~~~~~~~~
   kernel/time/posix-stubs.c:73:5: warning: no previous prototype for 'do_clock_gettime' [-Wmissing-prototypes]
      73 | int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
         |     ^~~~~~~~~~~~~~~~
   In file included from kernel/time/posix-stubs.c:9:
   kernel/time/posix-stubs.c:34:43: warning: 'sys_timer_create' alias between functions of incompatible types 'long int(clockid_t,  struct sigevent *, timer_t *)' {aka 'long int(int,  struct sigevent *, int *)'} and 'long int(void)' [-Wattribute-alias=]
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                                           ^~~~
   kernel/time/posix-stubs.c:34:23: note: in expansion of macro 'SYSCALL_ALIAS_PROTO'
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                       ^~~~~~~~~~~~~~~~~~~
   kernel/time/posix-stubs.c:41:1: note: in expansion of macro 'SYS_NI'
      41 | SYS_NI(timer_create);
         | ^~~~~~
   kernel/time/posix-stubs.c:25:17: note: aliased declaration here
      25 | asmlinkage long sys_ni_posix_timers(void)
         |                 ^~~~~~~~~~~~~~~~~~~
   In file included from kernel/time/posix-stubs.c:9:
   kernel/time/posix-stubs.c:34:43: warning: 'sys_timer_gettime32' alias between functions of incompatible types 'long int(timer_t,  struct old_itimerspec32 *)' {aka 'long int(int,  struct old_itimerspec32 *)'} and 'long int(void)' [-Wattribute-alias=]
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                                           ^~~~
   kernel/time/posix-stubs.c:34:23: note: in expansion of macro 'SYSCALL_ALIAS_PROTO'
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                       ^~~~~~~~~~~~~~~~~~~
   kernel/time/posix-stubs.c:170:1: note: in expansion of macro 'SYS_NI'
     170 | SYS_NI(timer_gettime32);
         | ^~~~~~
   kernel/time/posix-stubs.c:25:17: note: aliased declaration here
      25 | asmlinkage long sys_ni_posix_timers(void)
         |                 ^~~~~~~~~~~~~~~~~~~
   In file included from kernel/time/posix-stubs.c:9:
   kernel/time/posix-stubs.c:34:43: warning: 'sys_timer_settime32' alias between functions of incompatible types 'long int(timer_t,  int,  struct old_itimerspec32 *, struct old_itimerspec32 *)' {aka 'long int(int,  int,  struct old_itimerspec32 *, struct old_itimerspec32 *)'} and 'long int(void)' [-Wattribute-alias=]
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                                           ^~~~
   kernel/time/posix-stubs.c:34:23: note: in expansion of macro 'SYSCALL_ALIAS_PROTO'
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                       ^~~~~~~~~~~~~~~~~~~
   kernel/time/posix-stubs.c:169:1: note: in expansion of macro 'SYS_NI'
     169 | SYS_NI(timer_settime32);
         | ^~~~~~
   kernel/time/posix-stubs.c:25:17: note: aliased declaration here
      25 | asmlinkage long sys_ni_posix_timers(void)
         |                 ^~~~~~~~~~~~~~~~~~~
   In file included from kernel/time/posix-stubs.c:9:
>> kernel/time/posix-stubs.c:34:43: warning: 'sys_alarm' alias between functions of incompatible types 'long int(unsigned int)' and 'long int(void)' [-Wattribute-alias=]
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                                           ^~~~
   kernel/time/posix-stubs.c:34:23: note: in expansion of macro 'SYSCALL_ALIAS_PROTO'
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                       ^~~~~~~~~~~~~~~~~~~
   kernel/time/posix-stubs.c:51:1: note: in expansion of macro 'SYS_NI'
      51 | SYS_NI(alarm);
         | ^~~~~~
   kernel/time/posix-stubs.c:25:17: note: aliased declaration here
      25 | asmlinkage long sys_ni_posix_timers(void)
         |                 ^~~~~~~~~~~~~~~~~~~
   In file included from kernel/time/posix-stubs.c:9:
   kernel/time/posix-stubs.c:34:43: warning: 'sys_clock_adjtime32' alias between functions of incompatible types 'long int(clockid_t,  struct old_timex32 *)' {aka 'long int(int,  struct old_timex32 *)'} and 'long int(void)' [-Wattribute-alias=]
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                                           ^~~~
   kernel/time/posix-stubs.c:34:23: note: in expansion of macro 'SYSCALL_ALIAS_PROTO'
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                       ^~~~~~~~~~~~~~~~~~~
   kernel/time/posix-stubs.c:49:1: note: in expansion of macro 'SYS_NI'
      49 | SYS_NI(clock_adjtime32);
         | ^~~~~~
   kernel/time/posix-stubs.c:25:17: note: aliased declaration here
      25 | asmlinkage long sys_ni_posix_timers(void)
         |                 ^~~~~~~~~~~~~~~~~~~
   In file included from kernel/time/posix-stubs.c:9:
   kernel/time/posix-stubs.c:34:43: warning: 'sys_setitimer' alias between functions of incompatible types 'long int(int,  struct __kernel_old_itimerval *, struct __kernel_old_itimerval *)' and 'long int(void)' [-Wattribute-alias=]
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                                           ^~~~
   kernel/time/posix-stubs.c:34:23: note: in expansion of macro 'SYSCALL_ALIAS_PROTO'
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                       ^~~~~~~~~~~~~~~~~~~
   kernel/time/posix-stubs.c:48:1: note: in expansion of macro 'SYS_NI'
      48 | SYS_NI(setitimer);
         | ^~~~~~
   kernel/time/posix-stubs.c:25:17: note: aliased declaration here
      25 | asmlinkage long sys_ni_posix_timers(void)
         |                 ^~~~~~~~~~~~~~~~~~~
   In file included from kernel/time/posix-stubs.c:9:
   kernel/time/posix-stubs.c:34:43: warning: 'sys_getitimer' alias between functions of incompatible types 'long int(int,  struct __kernel_old_itimerval *)' and 'long int(void)' [-Wattribute-alias=]
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                                           ^~~~
   kernel/time/posix-stubs.c:34:23: note: in expansion of macro 'SYSCALL_ALIAS_PROTO'
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                       ^~~~~~~~~~~~~~~~~~~
   kernel/time/posix-stubs.c:47:1: note: in expansion of macro 'SYS_NI'
      47 | SYS_NI(getitimer);
         | ^~~~~~
   kernel/time/posix-stubs.c:25:17: note: aliased declaration here
      25 | asmlinkage long sys_ni_posix_timers(void)
         |                 ^~~~~~~~~~~~~~~~~~~
   In file included from kernel/time/posix-stubs.c:9:
   kernel/time/posix-stubs.c:34:43: warning: 'sys_clock_adjtime' alias between functions of incompatible types 'long int(clockid_t,  struct __kernel_timex *)' {aka 'long int(int,  struct __kernel_timex *)'} and 'long int(void)' [-Wattribute-alias=]
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                                           ^~~~
   kernel/time/posix-stubs.c:34:23: note: in expansion of macro 'SYSCALL_ALIAS_PROTO'
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                       ^~~~~~~~~~~~~~~~~~~
   kernel/time/posix-stubs.c:46:1: note: in expansion of macro 'SYS_NI'
      46 | SYS_NI(clock_adjtime);
         | ^~~~~~
   kernel/time/posix-stubs.c:25:17: note: aliased declaration here
      25 | asmlinkage long sys_ni_posix_timers(void)
         |                 ^~~~~~~~~~~~~~~~~~~
   In file included from kernel/time/posix-stubs.c:9:
   kernel/time/posix-stubs.c:34:43: warning: 'sys_timer_delete' alias between functions of incompatible types 'long int(timer_t)' {aka 'long int(int)'} and 'long int(void)' [-Wattribute-alias=]
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                                           ^~~~
   kernel/time/posix-stubs.c:34:23: note: in expansion of macro 'SYSCALL_ALIAS_PROTO'
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                       ^~~~~~~~~~~~~~~~~~~
   kernel/time/posix-stubs.c:45:1: note: in expansion of macro 'SYS_NI'
      45 | SYS_NI(timer_delete);
         | ^~~~~~
   kernel/time/posix-stubs.c:25:17: note: aliased declaration here
      25 | asmlinkage long sys_ni_posix_timers(void)
         |                 ^~~~~~~~~~~~~~~~~~~
   In file included from kernel/time/posix-stubs.c:9:
   kernel/time/posix-stubs.c:34:43: warning: 'sys_timer_settime' alias between functions of incompatible types 'long int(timer_t,  int,  const struct __kernel_itimerspec *, struct __kernel_itimerspec *)' {aka 'long int(int,  int,  const struct __kernel_itimerspec *, struct __kernel_itimerspec *)'} and 'long int(void)' [-Wattribute-alias=]
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                                           ^~~~
   kernel/time/posix-stubs.c:34:23: note: in expansion of macro 'SYSCALL_ALIAS_PROTO'
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                       ^~~~~~~~~~~~~~~~~~~
   kernel/time/posix-stubs.c:44:1: note: in expansion of macro 'SYS_NI'
      44 | SYS_NI(timer_settime);
         | ^~~~~~
   kernel/time/posix-stubs.c:25:17: note: aliased declaration here
      25 | asmlinkage long sys_ni_posix_timers(void)
         |                 ^~~~~~~~~~~~~~~~~~~
   In file included from kernel/time/posix-stubs.c:9:
   kernel/time/posix-stubs.c:34:43: warning: 'sys_timer_getoverrun' alias between functions of incompatible types 'long int(timer_t)' {aka 'long int(int)'} and 'long int(void)' [-Wattribute-alias=]
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                                           ^~~~
   kernel/time/posix-stubs.c:34:23: note: in expansion of macro 'SYSCALL_ALIAS_PROTO'
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                       ^~~~~~~~~~~~~~~~~~~
   kernel/time/posix-stubs.c:43:1: note: in expansion of macro 'SYS_NI'
      43 | SYS_NI(timer_getoverrun);
         | ^~~~~~
   kernel/time/posix-stubs.c:25:17: note: aliased declaration here


vim +34 kernel/time/posix-stubs.c

    32	
    33	#ifndef SYS_NI
  > 34	#define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
    35	#endif
    36	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

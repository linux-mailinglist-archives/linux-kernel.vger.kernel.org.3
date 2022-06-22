Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF42F5551F9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377114AbiFVRIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359222AbiFVRHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:07:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0D440E74
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655917617; x=1687453617;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KGKmBGHdKTdqm+Eo1VIi7aI14IRkohgCrxYSKNcLLDE=;
  b=Pl0G3KlosxC9q0puSQjY+RVchQLmf2g13ILHOD2pEEzr7lEDCprkzxpf
   8kw6ghyXCs98ntQe9r8JEnISbxp48kqysAUPSM6ejMfvuUuTm6JXj35ka
   a3PPR4Fi7On94AQ2vuhdf3XL1bIRZIew58zjeGX5klUvhVoWKtT8YnSYz
   zYzq2vkal6bDB/3l4pdOoVtM0z3I3PfRGVpANspl2j8R30D/BVc5Q15S9
   QUbGCzR2z/6XZ/8UkhkKVCjDoRWdXBCmAavQUWzswFp8uZ6CuuvrISkBL
   dnPTF125mBEZRpf5XGR2YrpK2YjBfdBt9ze6QNJveQjs9ings/YrSIWtc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="260298121"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="260298121"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:06:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="677651088"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2022 10:06:55 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o43oc-0001Vh-Ft;
        Wed, 22 Jun 2022 17:06:54 +0000
Date:   Thu, 23 Jun 2022 01:06:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [jirislaby:lto 12/45] kernel/time/posix-stubs.c:34:43: warning:
 'sys_timer_create' alias between functions of incompatible types 'long
 int(clockid_t,  struct sigevent *, timer_t *)' {aka 'long int(int,  struct
 sigevent *, int *)'} and 'long int(void)'
Message-ID: <202206230013.NOIqeuWz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git lto
head:   8047611082d70c5263114fabce8c80a4c3d251fa
commit: d6f8c88795ffd42d25c4d6c8634d9859d2b5ee57 [12/45] lto: Use C version for SYSCALL_ALIAS / cond_syscall
config: arc-randconfig-r043-20220622 (https://download.01.org/0day-ci/archive/20220623/202206230013.NOIqeuWz-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=d6f8c88795ffd42d25c4d6c8634d9859d2b5ee57
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby lto
        git checkout d6f8c88795ffd42d25c4d6c8634d9859d2b5ee57
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash kernel/time/

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
>> kernel/time/posix-stubs.c:34:43: warning: 'sys_timer_create' alias between functions of incompatible types 'long int(clockid_t,  struct sigevent *, timer_t *)' {aka 'long int(int,  struct sigevent *, int *)'} and 'long int(void)' [-Wattribute-alias=]
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
>> kernel/time/posix-stubs.c:34:43: warning: 'sys_timer_gettime32' alias between functions of incompatible types 'long int(timer_t,  struct old_itimerspec32 *)' {aka 'long int(int,  struct old_itimerspec32 *)'} and 'long int(void)' [-Wattribute-alias=]
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
>> kernel/time/posix-stubs.c:34:43: warning: 'sys_timer_settime32' alias between functions of incompatible types 'long int(timer_t,  int,  struct old_itimerspec32 *, struct old_itimerspec32 *)' {aka 'long int(int,  int,  struct old_itimerspec32 *, struct old_itimerspec32 *)'} and 'long int(void)' [-Wattribute-alias=]
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
>> kernel/time/posix-stubs.c:34:43: warning: 'sys_clock_adjtime32' alias between functions of incompatible types 'long int(clockid_t,  struct old_timex32 *)' {aka 'long int(int,  struct old_timex32 *)'} and 'long int(void)' [-Wattribute-alias=]
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
>> kernel/time/posix-stubs.c:34:43: warning: 'sys_setitimer' alias between functions of incompatible types 'long int(int,  struct __kernel_old_itimerval *, struct __kernel_old_itimerval *)' and 'long int(void)' [-Wattribute-alias=]
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
>> kernel/time/posix-stubs.c:34:43: warning: 'sys_getitimer' alias between functions of incompatible types 'long int(int,  struct __kernel_old_itimerval *)' and 'long int(void)' [-Wattribute-alias=]
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
>> kernel/time/posix-stubs.c:34:43: warning: 'sys_clock_adjtime' alias between functions of incompatible types 'long int(clockid_t,  struct __kernel_timex *)' {aka 'long int(int,  struct __kernel_timex *)'} and 'long int(void)' [-Wattribute-alias=]
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
>> kernel/time/posix-stubs.c:34:43: warning: 'sys_timer_delete' alias between functions of incompatible types 'long int(timer_t)' {aka 'long int(int)'} and 'long int(void)' [-Wattribute-alias=]
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
>> kernel/time/posix-stubs.c:34:43: warning: 'sys_timer_settime' alias between functions of incompatible types 'long int(timer_t,  int,  const struct __kernel_itimerspec *, struct __kernel_itimerspec *)' {aka 'long int(int,  int,  const struct __kernel_itimerspec *, struct __kernel_itimerspec *)'} and 'long int(void)' [-Wattribute-alias=]
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
>> kernel/time/posix-stubs.c:34:43: warning: 'sys_timer_getoverrun' alias between functions of incompatible types 'long int(timer_t)' {aka 'long int(int)'} and 'long int(void)' [-Wattribute-alias=]
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                                           ^~~~
   kernel/time/posix-stubs.c:34:23: note: in expansion of macro 'SYSCALL_ALIAS_PROTO'
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                       ^~~~~~~~~~~~~~~~~~~
   kernel/time/posix-stubs.c:43:1: note: in expansion of macro 'SYS_NI'
      43 | SYS_NI(timer_getoverrun);
         | ^~~~~~
   kernel/time/posix-stubs.c:25:17: note: aliased declaration here
      25 | asmlinkage long sys_ni_posix_timers(void)
         |                 ^~~~~~~~~~~~~~~~~~~
   In file included from kernel/time/posix-stubs.c:9:
>> kernel/time/posix-stubs.c:34:43: warning: 'sys_timer_gettime' alias between functions of incompatible types 'long int(timer_t,  struct __kernel_itimerspec *)' {aka 'long int(int,  struct __kernel_itimerspec *)'} and 'long int(void)' [-Wattribute-alias=]
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                                           ^~~~
   kernel/time/posix-stubs.c:34:23: note: in expansion of macro 'SYSCALL_ALIAS_PROTO'
      34 | #define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
         |                       ^~~~~~~~~~~~~~~~~~~
   kernel/time/posix-stubs.c:42:1: note: in expansion of macro 'SYS_NI'
      42 | SYS_NI(timer_gettime);
         | ^~~~~~
   kernel/time/posix-stubs.c:25:17: note: aliased declaration here
      25 | asmlinkage long sys_ni_posix_timers(void)
         |                 ^~~~~~~~~~~~~~~~~~~


vim +34 kernel/time/posix-stubs.c

    32	
    33	#ifndef SYS_NI
  > 34	#define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
    35	#endif
    36	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

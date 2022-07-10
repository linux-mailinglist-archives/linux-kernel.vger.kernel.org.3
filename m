Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F76A56CC25
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 03:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiGJBN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 21:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJBN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 21:13:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7193310FE6
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 18:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657415606; x=1688951606;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q1ztcq2zQXja8rAfMjWjguAIQOT+xsJF3nxiXkkeTB8=;
  b=dwXybpjvFgqomRGyc2lXFXW0Y4fpwCergsGaG+nkqz1k9dDCQGAOPjz+
   XAk7Fvl6y0p5Y0MUZ3xIOs4/MXih+595+q/2Hh9BphJdxV7IXmtGsWn9I
   e+ay+NgFZBWlt44sRqWJcBoBHXl3Q3PDAkLOpygWcTtLLmdaso9pJYz1Y
   MsvtnvYJa+4XTNgIeY8bz4ZIyPN/huCSuhLhKn0sn+prf73mYcF+WDZ4t
   DK7TDmVxfUFWEoHQnCK6H/mj5nYe9GsNpwR26x9AQlZQlpsbmHePYdstJ
   Yoz7FOx233vBHIQl4PCGH7akv761s8GlkHcuJv0tG1bvWTY/FCwDqe3VX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="282022819"
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="282022819"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 18:13:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="569357100"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 09 Jul 2022 18:13:24 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oALVj-000PLE-JE;
        Sun, 10 Jul 2022 01:13:23 +0000
Date:   Sun, 10 Jul 2022 09:12:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [jirislaby:lto 15/48] kernel/time/posix-stubs.c:38:44: error:
 conflicting types for 'compat_sys_timer_create'; have 'long int(void)'
Message-ID: <202207100934.4a4nEUry-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: sparc64-randconfig-r002-20220710 (https://download.01.org/0day-ci/archive/20220710/202207100934.4a4nEUry-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=01f5cbe3762954327188971c56f9909e7f29c4a6
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby lto
        git checkout 01f5cbe3762954327188971c56f9909e7f29c4a6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/time/posix-stubs.c:25:17: warning: no previous prototype for 'sys_ni_posix_timers' [-Wmissing-prototypes]
      25 | asmlinkage long sys_ni_posix_timers(void)
         |                 ^~~~~~~~~~~~~~~~~~~
   kernel/time/posix-stubs.c:73:5: warning: no previous prototype for 'do_clock_gettime' [-Wmissing-prototypes]
      73 | int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
         |     ^~~~~~~~~~~~~~~~
   In file included from kernel/time/posix-stubs.c:9:
>> kernel/time/posix-stubs.c:38:44: error: conflicting types for 'compat_sys_timer_create'; have 'long int(void)'
      38 | #define COMPAT_SYS_NI(name)  SYSCALL_ALIAS(compat_sys_##name, sys_ni_posix_timers)
         |                                            ^~~~~~~~~~~
   include/linux/linkage.h:32:14: note: in definition of macro 'SYSCALL_ALIAS'
      32 |         long a(void) __attribute__((alias(__stringify(name))))
         |              ^
   kernel/time/posix-stubs.c:160:1: note: in expansion of macro 'COMPAT_SYS_NI'
     160 | COMPAT_SYS_NI(timer_create);
         | ^~~~~~~~~~~~~
   In file included from kernel/time/posix-stubs.c:18:
   include/linux/compat.h:727:17: note: previous declaration of 'compat_sys_timer_create' with type 'long int(clockid_t,  struct compat_sigevent *, timer_t *)' {aka 'long int(int,  struct compat_sigevent *, int *)'}
     727 | asmlinkage long compat_sys_timer_create(clockid_t which_clock,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/time/posix-stubs.c:9:
>> kernel/time/posix-stubs.c:38:44: error: conflicting types for 'compat_sys_getitimer'; have 'long int(void)'
      38 | #define COMPAT_SYS_NI(name)  SYSCALL_ALIAS(compat_sys_##name, sys_ni_posix_timers)
         |                                            ^~~~~~~~~~~
   include/linux/linkage.h:32:14: note: in definition of macro 'SYSCALL_ALIAS'
      32 |         long a(void) __attribute__((alias(__stringify(name))))
         |              ^
   kernel/time/posix-stubs.c:164:1: note: in expansion of macro 'COMPAT_SYS_NI'
     164 | COMPAT_SYS_NI(getitimer);
         | ^~~~~~~~~~~~~
   In file included from kernel/time/posix-stubs.c:18:
   include/linux/compat.h:714:17: note: previous declaration of 'compat_sys_getitimer' with type 'long int(int,  struct old_itimerval32 *)'
     714 | asmlinkage long compat_sys_getitimer(int which,
         |                 ^~~~~~~~~~~~~~~~~~~~
   In file included from kernel/time/posix-stubs.c:9:
>> kernel/time/posix-stubs.c:38:44: error: conflicting types for 'compat_sys_setitimer'; have 'long int(void)'
      38 | #define COMPAT_SYS_NI(name)  SYSCALL_ALIAS(compat_sys_##name, sys_ni_posix_timers)
         |                                            ^~~~~~~~~~~
   include/linux/linkage.h:32:14: note: in definition of macro 'SYSCALL_ALIAS'
      32 |         long a(void) __attribute__((alias(__stringify(name))))
         |              ^
   kernel/time/posix-stubs.c:165:1: note: in expansion of macro 'COMPAT_SYS_NI'
     165 | COMPAT_SYS_NI(setitimer);
         | ^~~~~~~~~~~~~
   In file included from kernel/time/posix-stubs.c:18:
   include/linux/compat.h:716:17: note: previous declaration of 'compat_sys_setitimer' with type 'long int(int,  struct old_itimerval32 *, struct old_itimerval32 *)'
     716 | asmlinkage long compat_sys_setitimer(int which,
         |                 ^~~~~~~~~~~~~~~~~~~~
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
   kernel/time/posix-stubs.c:34:43: warning: 'sys_alarm' alias between functions of incompatible types 'long int(unsigned int)' and 'long int(void)' [-Wattribute-alias=]
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


vim +38 kernel/time/posix-stubs.c

7303e30ec1d8fb Dominik Brodowski 2018-04-05  36  
7303e30ec1d8fb Dominik Brodowski 2018-04-05  37  #ifndef COMPAT_SYS_NI
3a4d44b6162555 Al Viro           2017-06-07 @38  #define COMPAT_SYS_NI(name)  SYSCALL_ALIAS(compat_sys_##name, sys_ni_posix_timers)
7303e30ec1d8fb Dominik Brodowski 2018-04-05  39  #endif
baa73d9e478ff3 Nicolas Pitre     2016-11-11  40  

:::::: The code at line 38 was first introduced by commit
:::::: 3a4d44b6162555070194e486ff6b3799a8d323a2 ntp: Move adjtimex related compat syscalls to native counterparts

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

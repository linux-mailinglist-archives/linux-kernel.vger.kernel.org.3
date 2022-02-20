Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523AB4BD1B3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238165AbiBTUwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:52:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiBTUwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:52:15 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D9810C0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645390312; x=1676926312;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=abO5oVK3qEcoWtA8qisLoqpAOYIyfFw/oF77tu8abPo=;
  b=PMpOHSSA/3kdKmTjYFnWjVhKU9HghHNxZKzmB10SSeykXZxOmsS13KI8
   e4d8NU5iQvU39FZLmVawSJrbd5D1VhDpVBaOYEHNQH1N0SDt+5nDsjJdA
   LbmsJcVWGXz861OQG4cJXtwguYd2OFUI1HLEPyZclti5q2vNF9uDAy8Uw
   LqCXiQDlgP7bo4ZOBXBKA2mexK/1WqLAMgE6eclR9hrWW8z6xWHqLQmbO
   gk0gj1QU0iyGpTKRDIJ18UttDHxGkgqDUAevs5xekKlkskI1jhlPuyTEg
   hqzZ42Bfo1uHqOo8SdKed4ir97iTbEe36+lLlWCz6vIwP7Wjk4BRmzyB/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="337833713"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="337833713"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 12:51:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="572900276"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Feb 2022 12:51:51 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLtBO-0000kT-JB; Sun, 20 Feb 2022 20:51:50 +0000
Date:   Mon, 21 Feb 2022 04:51:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ak-misc:lto-5.17-1-wip 13/52] kernel/time/posix-stubs.c:34:43:
 warning: 'sys_timer_create' alias between functions of incompatible types
 'long int(clockid_t,  struct sigevent *, timer_t *)' {aka 'long int(int,
  struct sigevent *, int *)'} and 'long int(void)'
Message-ID: <202202210456.qXsmncqh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git lto-5.17-1-wip
head:   e3a498b1f0eadc0a91ae725fd924588fd660a9af
commit: a80de7a70547b61179e288ef2531c410a47f734e [13/52] lto: Use C version for SYSCALL_ALIAS / cond_syscall
config: arm-randconfig-r002-20220220 (https://download.01.org/0day-ci/archive/20220221/202202210456.qXsmncqh-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git/commit/?id=a80de7a70547b61179e288ef2531c410a47f734e
        git remote add ak-misc https://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git
        git fetch --no-tags ak-misc lto-5.17-1-wip
        git checkout a80de7a70547b61179e288ef2531c410a47f734e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag as appropriate
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

    24	
  > 25	asmlinkage long sys_ni_posix_timers(void)
    26	{
    27		pr_err_once("process %d (%s) attempted a POSIX timer syscall "
    28			    "while CONFIG_POSIX_TIMERS is not set\n",
    29			    current->pid, current->comm);
    30		return -ENOSYS;
    31	}
    32	
    33	#ifndef SYS_NI
  > 34	#define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
    35	#endif
    36	
    37	#ifndef COMPAT_SYS_NI
    38	#define COMPAT_SYS_NI(name)  SYSCALL_ALIAS(compat_sys_##name, sys_ni_posix_timers)
    39	#endif
    40	
  > 41	SYS_NI(timer_create);
    42	SYS_NI(timer_gettime);
  > 43	SYS_NI(timer_getoverrun);
  > 44	SYS_NI(timer_settime);
  > 45	SYS_NI(timer_delete);
  > 46	SYS_NI(clock_adjtime);
  > 47	SYS_NI(getitimer);
  > 48	SYS_NI(setitimer);
  > 49	SYS_NI(clock_adjtime32);
    50	#ifdef __ARCH_WANT_SYS_ALARM
    51	SYS_NI(alarm);
    52	#endif
    53	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

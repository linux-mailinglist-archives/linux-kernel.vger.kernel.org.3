Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D112C4C4658
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbiBYN3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiBYN3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:29:47 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5022028B1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645795754; x=1677331754;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QMuz2HIQuhbF+wGFSkoCZfpI79fD7MB5mtNmCDxoY8c=;
  b=ApUz85Ec1MhduDoonTYwxEW8++YolOwHNNZ+UOcEBEsS1OylGC2p4e2b
   IUWRjn+KRDawyhn4Z+RsmKeumGHXhbCyLlNG4x0Rf204vvs6UAq3uoLzV
   ONojtCf+8vohdgOkT/hiH3On7BqVjrgcl1NtYJFd2K5Ph/dONr2KJoKP3
   mFRlcO6X0HHbD53oSi2/dmkD4FWdTSH6xxwRw5NlxXo84BHaOKRaC4hZv
   pazS+h0tCMN0/nbUYiYhurLv+0VNHDpk4SbAZlaerANHWXQKsWCO87gNI
   lfLG4rWc3tpQ5UascYAOOcNwV2ZexQL7sZ2dz6wvDRnOOGR1AuDCQAzEV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="232466639"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="232466639"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 05:29:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="791797582"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 25 Feb 2022 05:29:12 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNaem-0004Lc-8u; Fri, 25 Feb 2022 13:29:12 +0000
Date:   Fri, 25 Feb 2022 21:28:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [dinguyen:nios2_for_v5.18 6/6]
 arch/csky/include/asm/uaccess.h:11:52: error: 'struct thread_info' has no
 member named 'addr_limit'
Message-ID: <202202252125.PgFR0SAq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git nios2_for_v5.18
head:   048b7695b48a3a4523a7a7fbfedc396b40ccf62f
commit: 048b7695b48a3a4523a7a7fbfedc396b40ccf62f [6/6] uaccess: drop maining CONFIG_SET_FS users
config: csky-defconfig (https://download.01.org/0day-ci/archive/20220225/202202252125.PgFR0SAq-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/commit/?id=048b7695b48a3a4523a7a7fbfedc396b40ccf62f
        git remote add dinguyen https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
        git fetch --no-tags dinguyen nios2_for_v5.18
        git checkout 048b7695b48a3a4523a7a7fbfedc396b40ccf62f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/proc_fs.h:10,
                    from init/main.c:18:
   arch/csky/include/asm/uaccess.h: In function '__access_ok':
>> arch/csky/include/asm/uaccess.h:11:52: error: 'struct thread_info' has no member named 'addr_limit'
      11 |         unsigned long limit = current_thread_info()->addr_limit.seg;
         |                                                    ^~
   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from init/main.c:17:
   include/asm-generic/uaccess.h: In function 'clear_user':
   include/asm-generic/uaccess.h:225:24: warning: passing argument 1 of '__access_ok' makes integer from pointer without a cast [-Wint-conversion]
     225 |         if (!access_ok(to, n))
         |                        ^~
         |                        |
         |                        void *
   include/linux/compiler.h:77:45: note: in definition of macro 'likely'
      77 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   include/asm-generic/uaccess.h:225:14: note: in expansion of macro 'access_ok'
     225 |         if (!access_ok(to, n))
         |              ^~~~~~~~~
   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/proc_fs.h:10,
                    from init/main.c:18:
   arch/csky/include/asm/uaccess.h:9:45: note: expected 'long unsigned int' but argument is of type 'void *'
       9 | static inline int __access_ok(unsigned long addr, unsigned long size)
         |                               ~~~~~~~~~~~~~~^~~~
   init/main.c: At top level:
   init/main.c:768:20: warning: no previous prototype for 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
     768 | void __init __weak arch_post_acpi_subsys_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   init/main.c:780:20: warning: no previous prototype for 'mem_encrypt_init' [-Wmissing-prototypes]
     780 | void __init __weak mem_encrypt_init(void) { }
         |                    ^~~~~~~~~~~~~~~~
   init/main.c:782:20: warning: no previous prototype for 'poking_init' [-Wmissing-prototypes]
     782 | void __init __weak poking_init(void) { }
         |                    ^~~~~~~~~~~
--
   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/tty.h:5,
                    from init/do_mounts.c:6:
   arch/csky/include/asm/uaccess.h: In function '__access_ok':
>> arch/csky/include/asm/uaccess.h:11:52: error: 'struct thread_info' has no member named 'addr_limit'
      11 |         unsigned long limit = current_thread_info()->addr_limit.seg;
         |                                                    ^~
   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from init/do_mounts.c:2:
   include/asm-generic/uaccess.h: In function 'clear_user':
   include/asm-generic/uaccess.h:225:24: warning: passing argument 1 of '__access_ok' makes integer from pointer without a cast [-Wint-conversion]
     225 |         if (!access_ok(to, n))
         |                        ^~
         |                        |
         |                        void *
   include/linux/compiler.h:77:45: note: in definition of macro 'likely'
      77 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   include/asm-generic/uaccess.h:225:14: note: in expansion of macro 'access_ok'
     225 |         if (!access_ok(to, n))
         |              ^~~~~~~~~
   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/tty.h:5,
                    from init/do_mounts.c:6:
   arch/csky/include/asm/uaccess.h:9:45: note: expected 'long unsigned int' but argument is of type 'void *'
       9 | static inline int __access_ok(unsigned long addr, unsigned long size)
         |                               ~~~~~~~~~~~~~~^~~~
   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from init/do_mounts.c:2:
   include/asm-generic/termios.h: In function 'user_termio_to_kernel_termios':
   include/asm-generic/uaccess.h:192:19: warning: passing argument 1 of '__access_ok' makes integer from pointer without a cast [-Wint-conversion]
     192 |         access_ok(__p, sizeof(*ptr)) ?          \
         |                   ^~~
         |                   |
         |                   const void *
   include/linux/compiler.h:77:45: note: in definition of macro 'likely'
      77 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   include/asm-generic/uaccess.h:192:9: note: in expansion of macro 'access_ok'
     192 |         access_ok(__p, sizeof(*ptr)) ?          \
         |         ^~~~~~~~~
   include/asm-generic/termios.h:25:13: note: in expansion of macro 'get_user'
      25 |         if (get_user(tmp, &termio->c_iflag) < 0)
         |             ^~~~~~~~
   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/tty.h:5,
                    from init/do_mounts.c:6:
   arch/csky/include/asm/uaccess.h:9:45: note: expected 'long unsigned int' but argument is of type 'const void *'
       9 | static inline int __access_ok(unsigned long addr, unsigned long size)
         |                               ~~~~~~~~~~~~~~^~~~
   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from init/do_mounts.c:2:
   include/asm-generic/uaccess.h:192:19: warning: passing argument 1 of '__access_ok' makes integer from pointer without a cast [-Wint-conversion]
     192 |         access_ok(__p, sizeof(*ptr)) ?          \
         |                   ^~~
         |                   |
         |                   const void *
   include/linux/compiler.h:77:45: note: in definition of macro 'likely'
      77 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   include/asm-generic/uaccess.h:192:9: note: in expansion of macro 'access_ok'
     192 |         access_ok(__p, sizeof(*ptr)) ?          \
         |         ^~~~~~~~~
   include/asm-generic/termios.h:29:13: note: in expansion of macro 'get_user'
      29 |         if (get_user(tmp, &termio->c_oflag) < 0)
         |             ^~~~~~~~
   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/tty.h:5,
                    from init/do_mounts.c:6:
   arch/csky/include/asm/uaccess.h:9:45: note: expected 'long unsigned int' but argument is of type 'const void *'
       9 | static inline int __access_ok(unsigned long addr, unsigned long size)
         |                               ~~~~~~~~~~~~~~^~~~
   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from init/do_mounts.c:2:
   include/asm-generic/uaccess.h:192:19: warning: passing argument 1 of '__access_ok' makes integer from pointer without a cast [-Wint-conversion]
     192 |         access_ok(__p, sizeof(*ptr)) ?          \
         |                   ^~~
         |                   |
--
   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from init/do_mounts_rd.c:3:
   arch/csky/include/asm/uaccess.h: In function '__access_ok':
>> arch/csky/include/asm/uaccess.h:11:52: error: 'struct thread_info' has no member named 'addr_limit'
      11 |         unsigned long limit = current_thread_info()->addr_limit.seg;
         |                                                    ^~
   In file included from include/linux/kernel.h:20,
                    from init/do_mounts_rd.c:2:
   include/asm-generic/uaccess.h: In function 'clear_user':
   include/asm-generic/uaccess.h:225:24: warning: passing argument 1 of '__access_ok' makes integer from pointer without a cast [-Wint-conversion]
     225 |         if (!access_ok(to, n))
         |                        ^~
         |                        |
         |                        void *
   include/linux/compiler.h:77:45: note: in definition of macro 'likely'
      77 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   include/asm-generic/uaccess.h:225:14: note: in expansion of macro 'access_ok'
     225 |         if (!access_ok(to, n))
         |              ^~~~~~~~~
   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from init/do_mounts_rd.c:3:
   arch/csky/include/asm/uaccess.h:9:45: note: expected 'long unsigned int' but argument is of type 'void *'
       9 | static inline int __access_ok(unsigned long addr, unsigned long size)
         |                               ~~~~~~~~~~~~~~^~~~
--
   In file included from include/linux/uaccess.h:11,
                    from arch/csky/kernel/signal.c:4:
   arch/csky/include/asm/uaccess.h: In function '__access_ok':
>> arch/csky/include/asm/uaccess.h:11:52: error: 'struct thread_info' has no member named 'addr_limit'
      11 |         unsigned long limit = current_thread_info()->addr_limit.seg;
         |                                                    ^~
   In file included from arch/csky/include/asm/bug.h:6,
                    from include/linux/bug.h:5,
                    from include/linux/signal.h:5,
                    from arch/csky/kernel/signal.c:3:
   include/asm-generic/uaccess.h: In function 'clear_user':
   include/asm-generic/uaccess.h:225:24: warning: passing argument 1 of '__access_ok' makes integer from pointer without a cast [-Wint-conversion]
     225 |         if (!access_ok(to, n))
         |                        ^~
         |                        |
         |                        void *
   include/linux/compiler.h:77:45: note: in definition of macro 'likely'
      77 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   include/asm-generic/uaccess.h:225:14: note: in expansion of macro 'access_ok'
     225 |         if (!access_ok(to, n))
         |              ^~~~~~~~~
   In file included from include/linux/uaccess.h:11,
                    from arch/csky/kernel/signal.c:4:
   arch/csky/include/asm/uaccess.h:9:45: note: expected 'long unsigned int' but argument is of type 'void *'
       9 | static inline int __access_ok(unsigned long addr, unsigned long size)
         |                               ~~~~~~~~~~~~~~^~~~
   In file included from arch/csky/include/asm/bug.h:6,
                    from include/linux/bug.h:5,
                    from include/linux/signal.h:5,
                    from arch/csky/kernel/signal.c:3:
   arch/csky/kernel/signal.c: In function 'sys_rt_sigreturn':
   arch/csky/kernel/signal.c:80:24: warning: passing argument 1 of '__access_ok' makes integer from pointer without a cast [-Wint-conversion]
      80 |         if (!access_ok(frame, sizeof(*frame)))
         |                        ^~~~~
         |                        |
         |                        struct rt_sigframe *
   include/linux/compiler.h:77:45: note: in definition of macro 'likely'
      77 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   arch/csky/kernel/signal.c:80:14: note: in expansion of macro 'access_ok'
      80 |         if (!access_ok(frame, sizeof(*frame)))
         |              ^~~~~~~~~
   In file included from include/linux/uaccess.h:11,
                    from arch/csky/kernel/signal.c:4:
   arch/csky/include/asm/uaccess.h:9:45: note: expected 'long unsigned int' but argument is of type 'struct rt_sigframe *'
       9 | static inline int __access_ok(unsigned long addr, unsigned long size)
         |                               ~~~~~~~~~~~~~~^~~~
   In file included from arch/csky/include/asm/bug.h:6,
                    from include/linux/bug.h:5,
                    from include/linux/signal.h:5,
                    from arch/csky/kernel/signal.c:3:
   arch/csky/kernel/signal.c: In function 'setup_rt_frame':
   arch/csky/kernel/signal.c:143:24: warning: passing argument 1 of '__access_ok' makes integer from pointer without a cast [-Wint-conversion]
     143 |         if (!access_ok(frame, sizeof(*frame)))
         |                        ^~~~~
         |                        |
         |                        struct rt_sigframe *
   include/linux/compiler.h:77:45: note: in definition of macro 'likely'
      77 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   arch/csky/kernel/signal.c:143:14: note: in expansion of macro 'access_ok'
     143 |         if (!access_ok(frame, sizeof(*frame)))
         |              ^~~~~~~~~
   In file included from include/linux/uaccess.h:11,
                    from arch/csky/kernel/signal.c:4:
   arch/csky/include/asm/uaccess.h:9:45: note: expected 'long unsigned int' but argument is of type 'struct rt_sigframe *'
       9 | static inline int __access_ok(unsigned long addr, unsigned long size)
         |                               ~~~~~~~~~~~~~~^~~~
   arch/csky/kernel/signal.c: At top level:
   arch/csky/kernel/signal.c:257:17: warning: no previous prototype for 'do_notify_resume' [-Wmissing-prototypes]
     257 | asmlinkage void do_notify_resume(struct pt_regs *regs,
         |                 ^~~~~~~~~~~~~~~~
--
   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:697,
                    from arch/csky/kernel/traps.c:7:
   arch/csky/include/asm/uaccess.h: In function '__access_ok':
>> arch/csky/include/asm/uaccess.h:11:52: error: 'struct thread_info' has no member named 'addr_limit'
      11 |         unsigned long limit = current_thread_info()->addr_limit.seg;
         |                                                    ^~
   In file included from arch/csky/include/asm/bug.h:6,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from ./arch/csky/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from arch/csky/kernel/traps.c:4:
   include/asm-generic/uaccess.h: In function 'clear_user':
   include/asm-generic/uaccess.h:225:24: warning: passing argument 1 of '__access_ok' makes integer from pointer without a cast [-Wint-conversion]
     225 |         if (!access_ok(to, n))
         |                        ^~
         |                        |
         |                        void *
   include/linux/compiler.h:77:45: note: in definition of macro 'likely'
      77 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   include/asm-generic/uaccess.h:225:14: note: in expansion of macro 'access_ok'
     225 |         if (!access_ok(to, n))
         |              ^~~~~~~~~
   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:697,
                    from arch/csky/kernel/traps.c:7:
   arch/csky/include/asm/uaccess.h:9:45: note: expected 'long unsigned int' but argument is of type 'void *'
       9 | static inline int __access_ok(unsigned long addr, unsigned long size)
         |                               ~~~~~~~~~~~~~~^~~~
   arch/csky/kernel/traps.c: At top level:
   arch/csky/kernel/traps.c:57:13: warning: no previous prototype for 'trap_init' [-Wmissing-prototypes]
      57 | void __init trap_init(void)
         |             ^~~~~~~~~
   arch/csky/kernel/traps.c:150:15: warning: no previous prototype for 'do_trap_unknown' [-Wmissing-prototypes]
     150 | DO_ERROR_INFO(do_trap_unknown,
         |               ^~~~~~~~~~~~~~~
   arch/csky/kernel/traps.c:145:27: note: in definition of macro 'DO_ERROR_INFO'
     145 | asmlinkage __visible void name(struct pt_regs *regs)                    \
         |                           ^~~~
   arch/csky/kernel/traps.c:152:15: warning: no previous prototype for 'do_trap_zdiv' [-Wmissing-prototypes]
     152 | DO_ERROR_INFO(do_trap_zdiv,
         |               ^~~~~~~~~~~~
   arch/csky/kernel/traps.c:145:27: note: in definition of macro 'DO_ERROR_INFO'
     145 | asmlinkage __visible void name(struct pt_regs *regs)                    \
         |                           ^~~~
   arch/csky/kernel/traps.c:154:15: warning: no previous prototype for 'do_trap_buserr' [-Wmissing-prototypes]
     154 | DO_ERROR_INFO(do_trap_buserr,
         |               ^~~~~~~~~~~~~~
   arch/csky/kernel/traps.c:145:27: note: in definition of macro 'DO_ERROR_INFO'
     145 | asmlinkage __visible void name(struct pt_regs *regs)                    \
         |                           ^~~~
   arch/csky/kernel/traps.c:157:17: warning: no previous prototype for 'do_trap_misaligned' [-Wmissing-prototypes]
     157 | asmlinkage void do_trap_misaligned(struct pt_regs *regs)
         |                 ^~~~~~~~~~~~~~~~~~
   arch/csky/kernel/traps.c:168:17: warning: no previous prototype for 'do_trap_bkpt' [-Wmissing-prototypes]
     168 | asmlinkage void do_trap_bkpt(struct pt_regs *regs)
         |                 ^~~~~~~~~~~~
   arch/csky/kernel/traps.c:187:17: warning: no previous prototype for 'do_trap_illinsn' [-Wmissing-prototypes]
     187 | asmlinkage void do_trap_illinsn(struct pt_regs *regs)
         |                 ^~~~~~~~~~~~~~~
   arch/csky/kernel/traps.c:210:17: warning: no previous prototype for 'do_trap_fpe' [-Wmissing-prototypes]
     210 | asmlinkage void do_trap_fpe(struct pt_regs *regs)
         |                 ^~~~~~~~~~~
   arch/csky/kernel/traps.c:220:17: warning: no previous prototype for 'do_trap_priv' [-Wmissing-prototypes]
     220 | asmlinkage void do_trap_priv(struct pt_regs *regs)
         |                 ^~~~~~~~~~~~
   arch/csky/kernel/traps.c:230:17: warning: no previous prototype for 'trap_c' [-Wmissing-prototypes]
     230 | asmlinkage void trap_c(struct pt_regs *regs)
         |                 ^~~~~~
..


vim +11 arch/csky/include/asm/uaccess.h

da551281947cb2 Guo Ren 2018-09-05   5  
e58a41c2226847 Guo Ren 2021-04-21   6  #define user_addr_max() \
e58a41c2226847 Guo Ren 2021-04-21  @7  	(uaccess_kernel() ? KERNEL_DS.seg : get_fs().seg)
da551281947cb2 Guo Ren 2018-09-05   8  
e58a41c2226847 Guo Ren 2021-04-21   9  static inline int __access_ok(unsigned long addr, unsigned long size)
da551281947cb2 Guo Ren 2018-09-05  10  {
da551281947cb2 Guo Ren 2018-09-05 @11  	unsigned long limit = current_thread_info()->addr_limit.seg;
da551281947cb2 Guo Ren 2018-09-05  12  
e58a41c2226847 Guo Ren 2021-04-21  13  	return ((addr < limit) && ((addr + size) < limit));
da551281947cb2 Guo Ren 2018-09-05  14  }
e58a41c2226847 Guo Ren 2021-04-21  15  #define __access_ok __access_ok
da551281947cb2 Guo Ren 2018-09-05  16  

:::::: The code at line 11 was first introduced by commit
:::::: da551281947cb2c0ab6e0045529a706af5d79584 csky: User access

:::::: TO: Guo Ren <ren_guo@c-sky.com>
:::::: CC: Guo Ren <ren_guo@c-sky.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

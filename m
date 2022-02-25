Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2974C451A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbiBYM7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237490AbiBYM7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:59:43 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6232A22A254
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645793950; x=1677329950;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h7joErmJ9hJiLR5e+iXdapaHMHnj3XotV7UX/BfczP0=;
  b=OPnGMzwSdFOVP9aeM5Tak1YJpufW9W61FVeDj7KWd/gndasva1778w/6
   3NcRG6ia/Xs4HO8z05Ok3yM2263Nyly/3Ahsur9FKr4VEpzZLVtfZsYSw
   uSA63VInjPFx2qEjtiuo1EAqUtjOBo+rJWhMNjNqasSIQaKv1mlSI/c+6
   /k9ozXNqtvVdiD4IlEXnUKj2Zjqn6abfpy3P81IAAH/BBX8a5A9Tedsad
   KRyGqEI9j2xE0teNszU0uMYVZQiKEGfBEaGRbgAALyyvJd2Nz9Xj9cnlg
   oJukWfSSGWhDWIGLHQ6mmkCVMxqY0N/P5F0W1YzXmM92WB0DH+S8k1hCL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252219402"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="252219402"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 04:59:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="533562118"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Feb 2022 04:59:08 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNaBf-0004K1-Hs; Fri, 25 Feb 2022 12:59:07 +0000
Date:   Fri, 25 Feb 2022 20:58:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [dinguyen:nios2_for_v5.18 6/6] include/asm-generic/uaccess.h:225:24:
 warning: passing argument 1 of '__access_ok' makes integer from pointer
 without a cast
Message-ID: <202202252055.gHgljVUp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git nios2_for_v5.18
head:   048b7695b48a3a4523a7a7fbfedc396b40ccf62f
commit: 048b7695b48a3a4523a7a7fbfedc396b40ccf62f [6/6] uaccess: drop maining CONFIG_SET_FS users
config: csky-defconfig (https://download.01.org/0day-ci/archive/20220225/202202252055.gHgljVUp-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash arch/csky/kernel/ drivers/char/ fs/ kernel/ lib/ mm/ net/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/uaccess.h:11,
                    from arch/csky/kernel/signal.c:4:
   arch/csky/include/asm/uaccess.h: In function '__access_ok':
   arch/csky/include/asm/uaccess.h:11:52: error: 'struct thread_info' has no member named 'addr_limit'
      11 |         unsigned long limit = current_thread_info()->addr_limit.seg;
         |                                                    ^~
   In file included from arch/csky/include/asm/bug.h:6,
                    from include/linux/bug.h:5,
                    from include/linux/signal.h:5,
                    from arch/csky/kernel/signal.c:3:
   include/asm-generic/uaccess.h: In function 'clear_user':
>> include/asm-generic/uaccess.h:225:24: warning: passing argument 1 of '__access_ok' makes integer from pointer without a cast [-Wint-conversion]
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
>> arch/csky/kernel/signal.c:80:24: warning: passing argument 1 of '__access_ok' makes integer from pointer without a cast [-Wint-conversion]
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
   arch/csky/include/asm/uaccess.h:11:52: error: 'struct thread_info' has no member named 'addr_limit'
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
>> include/asm-generic/uaccess.h:225:24: warning: passing argument 1 of '__access_ok' makes integer from pointer without a cast [-Wint-conversion]
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
--
   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:697,
                    from arch/csky/kernel/vdso.c:7:
   arch/csky/include/asm/uaccess.h: In function '__access_ok':
   arch/csky/include/asm/uaccess.h:11:52: error: 'struct thread_info' has no member named 'addr_limit'
      11 |         unsigned long limit = current_thread_info()->addr_limit.seg;
         |                                                    ^~
   In file included from arch/csky/include/asm/bug.h:6,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from ./arch/csky/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/binfmts.h:5,
                    from arch/csky/kernel/vdso.c:4:
   include/asm-generic/uaccess.h: In function 'clear_user':
>> include/asm-generic/uaccess.h:225:24: warning: passing argument 1 of '__access_ok' makes integer from pointer without a cast [-Wint-conversion]
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
                    from arch/csky/kernel/vdso.c:7:
   arch/csky/include/asm/uaccess.h:9:45: note: expected 'long unsigned int' but argument is of type 'void *'
       9 | static inline int __access_ok(unsigned long addr, unsigned long size)
         |                               ~~~~~~~~~~~~~~^~~~
--
   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/uapi/linux/aio_abi.h:31,
                    from include/linux/syscalls.h:77,
                    from arch/csky/kernel/syscall_table.c:4:
   arch/csky/include/asm/uaccess.h: In function '__access_ok':
   arch/csky/include/asm/uaccess.h:11:52: error: 'struct thread_info' has no member named 'addr_limit'
      11 |         unsigned long limit = current_thread_info()->addr_limit.seg;
         |                                                    ^~
   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/uapi/linux/aio_abi.h:31,
                    from include/linux/syscalls.h:77,
                    from arch/csky/kernel/syscall_table.c:4:
   include/asm-generic/uaccess.h: In function 'clear_user':
>> include/asm-generic/uaccess.h:225:24: warning: passing argument 1 of '__access_ok' makes integer from pointer without a cast [-Wint-conversion]
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
                    from include/uapi/linux/aio_abi.h:31,
                    from include/linux/syscalls.h:77,
                    from arch/csky/kernel/syscall_table.c:4:
   arch/csky/include/asm/uaccess.h:9:45: note: expected 'long unsigned int' but argument is of type 'void *'
       9 | static inline int __access_ok(unsigned long addr, unsigned long size)
         |                               ~~~~~~~~~~~~~~^~~~
   include/uapi/asm-generic/unistd.h: At top level:
   arch/csky/kernel/syscall_table.c:8:35: warning: initialized field overwritten [-Woverride-init]
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   include/uapi/asm-generic/unistd.h:29:37: note: in expansion of macro '__SYSCALL'
      29 | #define __SC_COMP(_nr, _sys, _comp) __SYSCALL(_nr, _sys)
         |                                     ^~~~~~~~~
   include/uapi/asm-generic/unistd.h:34:1: note: in expansion of macro '__SC_COMP'
      34 | __SC_COMP(__NR_io_setup, sys_io_setup, compat_sys_io_setup)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: note: (near initialization for 'sys_call_table[0]')
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   include/uapi/asm-generic/unistd.h:29:37: note: in expansion of macro '__SYSCALL'
      29 | #define __SC_COMP(_nr, _sys, _comp) __SYSCALL(_nr, _sys)
         |                                     ^~~~~~~~~
   include/uapi/asm-generic/unistd.h:34:1: note: in expansion of macro '__SC_COMP'
      34 | __SC_COMP(__NR_io_setup, sys_io_setup, compat_sys_io_setup)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: warning: initialized field overwritten [-Woverride-init]
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   include/uapi/asm-generic/unistd.h:36:1: note: in expansion of macro '__SYSCALL'
      36 | __SYSCALL(__NR_io_destroy, sys_io_destroy)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: note: (near initialization for 'sys_call_table[1]')
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   include/uapi/asm-generic/unistd.h:36:1: note: in expansion of macro '__SYSCALL'
      36 | __SYSCALL(__NR_io_destroy, sys_io_destroy)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: warning: initialized field overwritten [-Woverride-init]
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   include/uapi/asm-generic/unistd.h:29:37: note: in expansion of macro '__SYSCALL'
      29 | #define __SC_COMP(_nr, _sys, _comp) __SYSCALL(_nr, _sys)
         |                                     ^~~~~~~~~
   include/uapi/asm-generic/unistd.h:38:1: note: in expansion of macro '__SC_COMP'
      38 | __SC_COMP(__NR_io_submit, sys_io_submit, compat_sys_io_submit)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: note: (near initialization for 'sys_call_table[2]')
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   include/uapi/asm-generic/unistd.h:29:37: note: in expansion of macro '__SYSCALL'
      29 | #define __SC_COMP(_nr, _sys, _comp) __SYSCALL(_nr, _sys)
         |                                     ^~~~~~~~~
   include/uapi/asm-generic/unistd.h:38:1: note: in expansion of macro '__SC_COMP'
      38 | __SC_COMP(__NR_io_submit, sys_io_submit, compat_sys_io_submit)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: warning: initialized field overwritten [-Woverride-init]
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   include/uapi/asm-generic/unistd.h:40:1: note: in expansion of macro '__SYSCALL'
      40 | __SYSCALL(__NR_io_cancel, sys_io_cancel)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: note: (near initialization for 'sys_call_table[3]')
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   include/uapi/asm-generic/unistd.h:40:1: note: in expansion of macro '__SYSCALL'
      40 | __SYSCALL(__NR_io_cancel, sys_io_cancel)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: warning: initialized field overwritten [-Woverride-init]
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   include/uapi/asm-generic/unistd.h:20:34: note: in expansion of macro '__SYSCALL'
      20 | #define __SC_3264(_nr, _32, _64) __SYSCALL(_nr, _32)
         |                                  ^~~~~~~~~
   include/uapi/asm-generic/unistd.h:43:1: note: in expansion of macro '__SC_3264'
      43 | __SC_3264(__NR_io_getevents, sys_io_getevents_time32, sys_io_getevents)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: note: (near initialization for 'sys_call_table[4]')
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   include/uapi/asm-generic/unistd.h:20:34: note: in expansion of macro '__SYSCALL'
      20 | #define __SC_3264(_nr, _32, _64) __SYSCALL(_nr, _32)
         |                                  ^~~~~~~~~
   include/uapi/asm-generic/unistd.h:43:1: note: in expansion of macro '__SC_3264'
      43 | __SC_3264(__NR_io_getevents, sys_io_getevents_time32, sys_io_getevents)
..


vim +/__access_ok +225 include/asm-generic/uaccess.h

eed417ddd52146 Arnd Bergmann      2009-05-13  220  
eed417ddd52146 Arnd Bergmann      2009-05-13  221  static inline __must_check unsigned long
eed417ddd52146 Arnd Bergmann      2009-05-13  222  clear_user(void __user *to, unsigned long n)
eed417ddd52146 Arnd Bergmann      2009-05-13  223  {
e0acd0bd059416 Michael S. Tsirkin 2013-05-26  224  	might_fault();
96d4f267e40f95 Linus Torvalds     2019-01-03 @225  	if (!access_ok(to, n))
eed417ddd52146 Arnd Bergmann      2009-05-13  226  		return n;
eed417ddd52146 Arnd Bergmann      2009-05-13  227  
eed417ddd52146 Arnd Bergmann      2009-05-13  228  	return __clear_user(to, n);
eed417ddd52146 Arnd Bergmann      2009-05-13  229  }
eed417ddd52146 Arnd Bergmann      2009-05-13  230  

:::::: The code at line 225 was first introduced by commit
:::::: 96d4f267e40f9509e8a66e2b39e8b95655617693 Remove 'type' argument from access_ok() function

:::::: TO: Linus Torvalds <torvalds@linux-foundation.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

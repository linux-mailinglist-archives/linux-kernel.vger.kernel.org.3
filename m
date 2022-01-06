Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FED485F4C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 04:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiAFDoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 22:44:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:38114 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230214AbiAFDoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 22:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641440646; x=1672976646;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kGuvxf4XFI6ww+v8yvwKbmzlNOxsz0Vg1/lacgRnCdg=;
  b=Lc7hEIp8Eujy1YN87nvLngFpGwa95nTAEJ7Q9uicqrq5k+Jn9NQECj+T
   E2J/tjYfU56XzcVDsPS1kYwNLIgssakRCNXkcniXzTkHgaGwdQVFcIUtn
   PcuAiwLpmGMssgsP2A2a+mRb5twejqYiFdYE5GkP4aRQaeXurwTpT0xSN
   ry7FYiHloDKfiVAiNMOX31K7CgQ9tKnxWlqVwfNYDqggdc2NLaAnqfk/J
   ngl2xBP/pzuo4cRlCtdf86xm1Codq/dcrfjOncDFt0CQNTE4KT6FkX5xf
   AI3gdyZpS7/d/jTghXjiLwseZMHXv6Dav1IMKI2nu93He95UKMBJaFZPm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229397273"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="229397273"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 19:44:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="513258506"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 05 Jan 2022 19:44:04 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5Jh5-000HIg-Sm; Thu, 06 Jan 2022 03:44:03 +0000
Date:   Thu, 6 Jan 2022 11:43:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [palmer:riscv-extable 12/13] arch/riscv/include/asm/uaccess.h:113:9:
 error: expected ';' before 'if'
Message-ID: <202201061113.u3t3S26G-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git riscv-extable
head:   e47260bcbc2ef5ec1010dab9b28551937b002313
commit: 414aca87942d14a50dfad8e17f412736141101ec [12/13] riscv: extable: add a dedicated uaccess handler
config: riscv-rv32_defconfig (https://download.01.org/0day-ci/archive/20220106/202201061113.u3t3S26G-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/commit/?id=414aca87942d14a50dfad8e17f412736141101ec
        git remote add palmer https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git
        git fetch --no-tags palmer riscv-extable
        git checkout 414aca87942d14a50dfad8e17f412736141101ec
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/tty.h:5,
                    from init/do_mounts.c:6:
   include/asm-generic/termios.h: In function 'user_termio_to_kernel_termios':
>> arch/riscv/include/asm/uaccess.h:113:9: error: expected ';' before 'if'
     113 |         if (err)                                                \
         |         ^~
   arch/riscv/include/asm/uaccess.h:133:17: note: in expansion of macro '__get_user_8'
     133 |                 __get_user_8((x), __gu_ptr, __gu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:168:9: note: in expansion of macro '__get_user_nocheck'
     168 |         __get_user_nocheck(x, __gu_ptr, __gu_err);              \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:196:17: note: in expansion of macro '__get_user'
     196 |                 __get_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   include/asm-generic/termios.h:25:13: note: in expansion of macro 'get_user'
      25 |         if (get_user(tmp, &termio->c_iflag) < 0)
         |             ^~~~~~~~
>> arch/riscv/include/asm/uaccess.h:113:9: error: expected ';' before 'if'
     113 |         if (err)                                                \
         |         ^~
   arch/riscv/include/asm/uaccess.h:133:17: note: in expansion of macro '__get_user_8'
     133 |                 __get_user_8((x), __gu_ptr, __gu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:168:9: note: in expansion of macro '__get_user_nocheck'
     168 |         __get_user_nocheck(x, __gu_ptr, __gu_err);              \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:196:17: note: in expansion of macro '__get_user'
     196 |                 __get_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   include/asm-generic/termios.h:29:13: note: in expansion of macro 'get_user'
      29 |         if (get_user(tmp, &termio->c_oflag) < 0)
         |             ^~~~~~~~
>> arch/riscv/include/asm/uaccess.h:113:9: error: expected ';' before 'if'
     113 |         if (err)                                                \
         |         ^~
   arch/riscv/include/asm/uaccess.h:133:17: note: in expansion of macro '__get_user_8'
     133 |                 __get_user_8((x), __gu_ptr, __gu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:168:9: note: in expansion of macro '__get_user_nocheck'
     168 |         __get_user_nocheck(x, __gu_ptr, __gu_err);              \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:196:17: note: in expansion of macro '__get_user'
     196 |                 __get_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   include/asm-generic/termios.h:33:13: note: in expansion of macro 'get_user'
      33 |         if (get_user(tmp, &termio->c_cflag) < 0)
         |             ^~~~~~~~
>> arch/riscv/include/asm/uaccess.h:113:9: error: expected ';' before 'if'
     113 |         if (err)                                                \
         |         ^~
   arch/riscv/include/asm/uaccess.h:133:17: note: in expansion of macro '__get_user_8'
     133 |                 __get_user_8((x), __gu_ptr, __gu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:168:9: note: in expansion of macro '__get_user_nocheck'
     168 |         __get_user_nocheck(x, __gu_ptr, __gu_err);              \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:196:17: note: in expansion of macro '__get_user'
     196 |                 __get_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   include/asm-generic/termios.h:37:13: note: in expansion of macro 'get_user'
      37 |         if (get_user(tmp, &termio->c_lflag) < 0)
         |             ^~~~~~~~
>> arch/riscv/include/asm/uaccess.h:113:9: error: expected ';' before 'if'
     113 |         if (err)                                                \
         |         ^~
   arch/riscv/include/asm/uaccess.h:133:17: note: in expansion of macro '__get_user_8'
     133 |                 __get_user_8((x), __gu_ptr, __gu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:168:9: note: in expansion of macro '__get_user_nocheck'
     168 |         __get_user_nocheck(x, __gu_ptr, __gu_err);              \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:196:17: note: in expansion of macro '__get_user'
     196 |                 __get_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   include/asm-generic/termios.h:41:13: note: in expansion of macro 'get_user'
      41 |         if (get_user(termios->c_line, &termio->c_line) < 0)
         |             ^~~~~~~~
   include/asm-generic/termios.h: In function 'kernel_termios_to_user_termio':
   arch/riscv/include/asm/uaccess.h:220:19: warning: unused variable '__tmp' [-Wunused-variable]
     220 |         uintptr_t __tmp;                                        \
         |                   ^~~~~
   arch/riscv/include/asm/uaccess.h:249:17: note: in expansion of macro '__put_user_8'
     249 |                 __put_user_8((x), __gu_ptr, __pu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:286:9: note: in expansion of macro '__put_user_nocheck'
     286 |         __put_user_nocheck(__val, __gu_ptr, __pu_err);          \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:313:17: note: in expansion of macro '__put_user'
     313 |                 __put_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   include/asm-generic/termios.h:59:13: note: in expansion of macro 'put_user'
      59 |         if (put_user(termios->c_iflag, &termio->c_iflag) < 0 ||
         |             ^~~~~~~~
   arch/riscv/include/asm/uaccess.h:220:19: warning: unused variable '__tmp' [-Wunused-variable]
     220 |         uintptr_t __tmp;                                        \
         |                   ^~~~~
   arch/riscv/include/asm/uaccess.h:249:17: note: in expansion of macro '__put_user_8'
     249 |                 __put_user_8((x), __gu_ptr, __pu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:286:9: note: in expansion of macro '__put_user_nocheck'
     286 |         __put_user_nocheck(__val, __gu_ptr, __pu_err);          \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:313:17: note: in expansion of macro '__put_user'
     313 |                 __put_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   include/asm-generic/termios.h:60:13: note: in expansion of macro 'put_user'
      60 |             put_user(termios->c_oflag, &termio->c_oflag) < 0 ||
         |             ^~~~~~~~
   arch/riscv/include/asm/uaccess.h:220:19: warning: unused variable '__tmp' [-Wunused-variable]
     220 |         uintptr_t __tmp;                                        \
         |                   ^~~~~
   arch/riscv/include/asm/uaccess.h:249:17: note: in expansion of macro '__put_user_8'
     249 |                 __put_user_8((x), __gu_ptr, __pu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:286:9: note: in expansion of macro '__put_user_nocheck'
     286 |         __put_user_nocheck(__val, __gu_ptr, __pu_err);          \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:313:17: note: in expansion of macro '__put_user'
     313 |                 __put_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   include/asm-generic/termios.h:61:13: note: in expansion of macro 'put_user'
      61 |             put_user(termios->c_cflag, &termio->c_cflag) < 0 ||
         |             ^~~~~~~~
   arch/riscv/include/asm/uaccess.h:220:19: warning: unused variable '__tmp' [-Wunused-variable]
     220 |         uintptr_t __tmp;                                        \
         |                   ^~~~~
   arch/riscv/include/asm/uaccess.h:249:17: note: in expansion of macro '__put_user_8'
     249 |                 __put_user_8((x), __gu_ptr, __pu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:286:9: note: in expansion of macro '__put_user_nocheck'
     286 |         __put_user_nocheck(__val, __gu_ptr, __pu_err);          \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:313:17: note: in expansion of macro '__put_user'
     313 |                 __put_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   include/asm-generic/termios.h:62:13: note: in expansion of macro 'put_user'
      62 |             put_user(termios->c_lflag, &termio->c_lflag) < 0 ||
         |             ^~~~~~~~
   arch/riscv/include/asm/uaccess.h:220:19: warning: unused variable '__tmp' [-Wunused-variable]
     220 |         uintptr_t __tmp;                                        \
         |                   ^~~~~
   arch/riscv/include/asm/uaccess.h:249:17: note: in expansion of macro '__put_user_8'
     249 |                 __put_user_8((x), __gu_ptr, __pu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:286:9: note: in expansion of macro '__put_user_nocheck'
     286 |         __put_user_nocheck(__val, __gu_ptr, __pu_err);          \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:313:17: note: in expansion of macro '__put_user'
     313 |                 __put_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   include/asm-generic/termios.h:63:13: note: in expansion of macro 'put_user'
      63 |             put_user(termios->c_line,  &termio->c_line) < 0 ||
         |             ^~~~~~~~
--
   In file included from include/linux/uaccess.h:11,
                    from arch/riscv/kernel/signal.c:10:
   arch/riscv/kernel/signal.c: In function 'restore_fp_state':
>> arch/riscv/include/asm/uaccess.h:113:9: error: expected ';' before 'if'
     113 |         if (err)                                                \
         |         ^~
   arch/riscv/include/asm/uaccess.h:133:17: note: in expansion of macro '__get_user_8'
     133 |                 __get_user_8((x), __gu_ptr, __gu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:168:9: note: in expansion of macro '__get_user_nocheck'
     168 |         __get_user_nocheck(x, __gu_ptr, __gu_err);              \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/signal.c:50:23: note: in expansion of macro '__get_user'
      50 |                 err = __get_user(value, &sc_fpregs->q.reserved[i]);
         |                       ^~~~~~~~~~
   arch/riscv/kernel/signal.c: In function 'save_fp_state':
   arch/riscv/include/asm/uaccess.h:220:19: warning: unused variable '__tmp' [-Wunused-variable]
     220 |         uintptr_t __tmp;                                        \
         |                   ^~~~~
   arch/riscv/include/asm/uaccess.h:249:17: note: in expansion of macro '__put_user_8'
     249 |                 __put_user_8((x), __gu_ptr, __pu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:286:9: note: in expansion of macro '__put_user_nocheck'
     286 |         __put_user_nocheck(__val, __gu_ptr, __pu_err);          \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/signal.c:74:23: note: in expansion of macro '__put_user'
      74 |                 err = __put_user(0, &sc_fpregs->q.reserved[i]);
         |                       ^~~~~~~~~~
   arch/riscv/kernel/signal.c: In function 'setup_rt_frame':
   arch/riscv/include/asm/uaccess.h:220:19: warning: unused variable '__tmp' [-Wunused-variable]
     220 |         uintptr_t __tmp;                                        \
         |                   ^~~~~
   arch/riscv/include/asm/uaccess.h:249:17: note: in expansion of macro '__put_user_8'
     249 |                 __put_user_8((x), __gu_ptr, __pu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:286:9: note: in expansion of macro '__put_user_nocheck'
     286 |         __put_user_nocheck(__val, __gu_ptr, __pu_err);          \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/signal.c:187:16: note: in expansion of macro '__put_user'
     187 |         err |= __put_user(0, &frame->uc.uc_flags);
         |                ^~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:220:19: warning: unused variable '__tmp' [-Wunused-variable]
     220 |         uintptr_t __tmp;                                        \
         |                   ^~~~~
   arch/riscv/include/asm/uaccess.h:249:17: note: in expansion of macro '__put_user_8'
     249 |                 __put_user_8((x), __gu_ptr, __pu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:286:9: note: in expansion of macro '__put_user_nocheck'
     286 |         __put_user_nocheck(__val, __gu_ptr, __pu_err);          \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/signal.c:188:16: note: in expansion of macro '__put_user'
     188 |         err |= __put_user(NULL, &frame->uc.uc_link);
         |                ^~~~~~~~~~
   arch/riscv/kernel/signal.c: At top level:
   arch/riscv/kernel/signal.c:309:27: warning: no previous prototype for 'do_notify_resume' [-Wmissing-prototypes]
     309 | asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
         |                           ^~~~~~~~~~~~~~~~
--
   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from kernel/fork.c:23:
   include/asm-generic/termios.h: In function 'user_termio_to_kernel_termios':
>> arch/riscv/include/asm/uaccess.h:113:9: error: expected ';' before 'if'
     113 |         if (err)                                                \
         |         ^~
   arch/riscv/include/asm/uaccess.h:133:17: note: in expansion of macro '__get_user_8'
     133 |                 __get_user_8((x), __gu_ptr, __gu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:168:9: note: in expansion of macro '__get_user_nocheck'
     168 |         __get_user_nocheck(x, __gu_ptr, __gu_err);              \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:196:17: note: in expansion of macro '__get_user'
     196 |                 __get_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   include/asm-generic/termios.h:25:13: note: in expansion of macro 'get_user'
      25 |         if (get_user(tmp, &termio->c_iflag) < 0)
         |             ^~~~~~~~
>> arch/riscv/include/asm/uaccess.h:113:9: error: expected ';' before 'if'
     113 |         if (err)                                                \
         |         ^~
   arch/riscv/include/asm/uaccess.h:133:17: note: in expansion of macro '__get_user_8'
     133 |                 __get_user_8((x), __gu_ptr, __gu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:168:9: note: in expansion of macro '__get_user_nocheck'
     168 |         __get_user_nocheck(x, __gu_ptr, __gu_err);              \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:196:17: note: in expansion of macro '__get_user'
     196 |                 __get_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   include/asm-generic/termios.h:29:13: note: in expansion of macro 'get_user'
      29 |         if (get_user(tmp, &termio->c_oflag) < 0)
         |             ^~~~~~~~
>> arch/riscv/include/asm/uaccess.h:113:9: error: expected ';' before 'if'
     113 |         if (err)                                                \
         |         ^~
   arch/riscv/include/asm/uaccess.h:133:17: note: in expansion of macro '__get_user_8'
     133 |                 __get_user_8((x), __gu_ptr, __gu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:168:9: note: in expansion of macro '__get_user_nocheck'
     168 |         __get_user_nocheck(x, __gu_ptr, __gu_err);              \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:196:17: note: in expansion of macro '__get_user'
     196 |                 __get_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   include/asm-generic/termios.h:33:13: note: in expansion of macro 'get_user'
      33 |         if (get_user(tmp, &termio->c_cflag) < 0)
         |             ^~~~~~~~
>> arch/riscv/include/asm/uaccess.h:113:9: error: expected ';' before 'if'
     113 |         if (err)                                                \
         |         ^~
   arch/riscv/include/asm/uaccess.h:133:17: note: in expansion of macro '__get_user_8'
     133 |                 __get_user_8((x), __gu_ptr, __gu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:168:9: note: in expansion of macro '__get_user_nocheck'
     168 |         __get_user_nocheck(x, __gu_ptr, __gu_err);              \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:196:17: note: in expansion of macro '__get_user'
     196 |                 __get_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   include/asm-generic/termios.h:37:13: note: in expansion of macro 'get_user'
      37 |         if (get_user(tmp, &termio->c_lflag) < 0)
         |             ^~~~~~~~
>> arch/riscv/include/asm/uaccess.h:113:9: error: expected ';' before 'if'
     113 |         if (err)                                                \
         |         ^~
   arch/riscv/include/asm/uaccess.h:133:17: note: in expansion of macro '__get_user_8'
     133 |                 __get_user_8((x), __gu_ptr, __gu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:168:9: note: in expansion of macro '__get_user_nocheck'
     168 |         __get_user_nocheck(x, __gu_ptr, __gu_err);              \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:196:17: note: in expansion of macro '__get_user'
     196 |                 __get_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   include/asm-generic/termios.h:41:13: note: in expansion of macro 'get_user'
      41 |         if (get_user(termios->c_line, &termio->c_line) < 0)
         |             ^~~~~~~~
   include/asm-generic/termios.h: In function 'kernel_termios_to_user_termio':
   arch/riscv/include/asm/uaccess.h:220:19: warning: unused variable '__tmp' [-Wunused-variable]
     220 |         uintptr_t __tmp;                                        \
         |                   ^~~~~
   arch/riscv/include/asm/uaccess.h:249:17: note: in expansion of macro '__put_user_8'
     249 |                 __put_user_8((x), __gu_ptr, __pu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:286:9: note: in expansion of macro '__put_user_nocheck'
     286 |         __put_user_nocheck(__val, __gu_ptr, __pu_err);          \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:313:17: note: in expansion of macro '__put_user'
     313 |                 __put_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   include/asm-generic/termios.h:59:13: note: in expansion of macro 'put_user'
      59 |         if (put_user(termios->c_iflag, &termio->c_iflag) < 0 ||
         |             ^~~~~~~~
   arch/riscv/include/asm/uaccess.h:220:19: warning: unused variable '__tmp' [-Wunused-variable]
     220 |         uintptr_t __tmp;                                        \
         |                   ^~~~~
   arch/riscv/include/asm/uaccess.h:249:17: note: in expansion of macro '__put_user_8'
     249 |                 __put_user_8((x), __gu_ptr, __pu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:286:9: note: in expansion of macro '__put_user_nocheck'
     286 |         __put_user_nocheck(__val, __gu_ptr, __pu_err);          \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:313:17: note: in expansion of macro '__put_user'
     313 |                 __put_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   include/asm-generic/termios.h:60:13: note: in expansion of macro 'put_user'
      60 |             put_user(termios->c_oflag, &termio->c_oflag) < 0 ||
         |             ^~~~~~~~
   arch/riscv/include/asm/uaccess.h:220:19: warning: unused variable '__tmp' [-Wunused-variable]
     220 |         uintptr_t __tmp;                                        \
         |                   ^~~~~
   arch/riscv/include/asm/uaccess.h:249:17: note: in expansion of macro '__put_user_8'
     249 |                 __put_user_8((x), __gu_ptr, __pu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:286:9: note: in expansion of macro '__put_user_nocheck'
     286 |         __put_user_nocheck(__val, __gu_ptr, __pu_err);          \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:313:17: note: in expansion of macro '__put_user'
     313 |                 __put_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   include/asm-generic/termios.h:61:13: note: in expansion of macro 'put_user'
      61 |             put_user(termios->c_cflag, &termio->c_cflag) < 0 ||
         |             ^~~~~~~~
   arch/riscv/include/asm/uaccess.h:220:19: warning: unused variable '__tmp' [-Wunused-variable]
     220 |         uintptr_t __tmp;                                        \
         |                   ^~~~~
   arch/riscv/include/asm/uaccess.h:249:17: note: in expansion of macro '__put_user_8'
     249 |                 __put_user_8((x), __gu_ptr, __pu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:286:9: note: in expansion of macro '__put_user_nocheck'
     286 |         __put_user_nocheck(__val, __gu_ptr, __pu_err);          \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:313:17: note: in expansion of macro '__put_user'
     313 |                 __put_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   include/asm-generic/termios.h:62:13: note: in expansion of macro 'put_user'
      62 |             put_user(termios->c_lflag, &termio->c_lflag) < 0 ||
         |             ^~~~~~~~
   arch/riscv/include/asm/uaccess.h:220:19: warning: unused variable '__tmp' [-Wunused-variable]
     220 |         uintptr_t __tmp;                                        \
         |                   ^~~~~
   arch/riscv/include/asm/uaccess.h:249:17: note: in expansion of macro '__put_user_8'
     249 |                 __put_user_8((x), __gu_ptr, __pu_err);  \
         |                 ^~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:286:9: note: in expansion of macro '__put_user_nocheck'
     286 |         __put_user_nocheck(__val, __gu_ptr, __pu_err);          \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:313:17: note: in expansion of macro '__put_user'
     313 |                 __put_user((x), __p) :                          \
         |                 ^~~~~~~~~~
   include/asm-generic/termios.h:63:13: note: in expansion of macro 'put_user'
      63 |             put_user(termios->c_line,  &termio->c_line) < 0 ||
         |             ^~~~~~~~
   kernel/fork.c: At top level:
   kernel/fork.c:161:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     161 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:763:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     763 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from kernel/fork.c:23:
..


vim +113 arch/riscv/include/asm/uaccess.h

    94	
    95	#ifdef CONFIG_64BIT
    96	#define __get_user_8(x, ptr, err) \
    97		__get_user_asm("ld", x, ptr, err)
    98	#else /* !CONFIG_64BIT */
    99	#define __get_user_8(x, ptr, err)				\
   100	do {								\
   101		u32 __user *__ptr = (u32 __user *)(ptr);		\
   102		u32 __lo, __hi;						\
   103		__asm__ __volatile__ (					\
   104			"1:\n"						\
   105			"	lw %1, %3\n"				\
   106			"2:\n"						\
   107			"	lw %2, %4\n"				\
   108			"3:\n"						\
   109			_ASM_EXTABLE_UACCESS_ERR_ZERO(1b, 3b, %0, %1)	\
   110			_ASM_EXTABLE_UACCESS_ERR_ZERO(2b, 3b, %0, %1)	\
   111			: "+r" (err), "=&r" (__lo), "=r" (__hi)		\
   112			: "m" (__ptr[__LSW]), "m" (__ptr[__MSW]))	\
 > 113		if (err)						\
   114			__hi = 0;					\
   115		(x) = (__typeof__(x))((__typeof__((x)-(x)))(		\
   116			(((u64)__hi << 32) | __lo)));			\
   117	} while (0)
   118	#endif /* CONFIG_64BIT */
   119	
   120	#define __get_user_nocheck(x, __gu_ptr, __gu_err)		\
   121	do {								\
   122		switch (sizeof(*__gu_ptr)) {				\
   123		case 1:							\
   124			__get_user_asm("lb", (x), __gu_ptr, __gu_err);	\
   125			break;						\
   126		case 2:							\
   127			__get_user_asm("lh", (x), __gu_ptr, __gu_err);	\
   128			break;						\
   129		case 4:							\
   130			__get_user_asm("lw", (x), __gu_ptr, __gu_err);	\
   131			break;						\
   132		case 8:							\
   133			__get_user_8((x), __gu_ptr, __gu_err);	\
   134			break;						\
   135		default:						\
   136			BUILD_BUG();					\
   137		}							\
   138	} while (0)
   139	
   140	/**
   141	 * __get_user: - Get a simple variable from user space, with less checking.
   142	 * @x:   Variable to store result.
   143	 * @ptr: Source address, in user space.
   144	 *
   145	 * Context: User context only.  This function may sleep.
   146	 *
   147	 * This macro copies a single simple variable from user space to kernel
   148	 * space.  It supports simple types like char and int, but not larger
   149	 * data types like structures or arrays.
   150	 *
   151	 * @ptr must have pointer-to-simple-variable type, and the result of
   152	 * dereferencing @ptr must be assignable to @x without a cast.
   153	 *
   154	 * Caller must check the pointer with access_ok() before calling this
   155	 * function.
   156	 *
   157	 * Returns zero on success, or -EFAULT on error.
   158	 * On error, the variable @x is set to zero.
   159	 */
   160	#define __get_user(x, ptr)					\
   161	({								\
   162		const __typeof__(*(ptr)) __user *__gu_ptr = (ptr);	\
   163		long __gu_err = 0;					\
   164									\
   165		__chk_user_ptr(__gu_ptr);				\
   166									\
   167		__enable_user_access();					\
   168		__get_user_nocheck(x, __gu_ptr, __gu_err);		\
   169		__disable_user_access();				\
   170									\
   171		__gu_err;						\
   172	})
   173	
   174	/**
   175	 * get_user: - Get a simple variable from user space.
   176	 * @x:   Variable to store result.
   177	 * @ptr: Source address, in user space.
   178	 *
   179	 * Context: User context only.  This function may sleep.
   180	 *
   181	 * This macro copies a single simple variable from user space to kernel
   182	 * space.  It supports simple types like char and int, but not larger
   183	 * data types like structures or arrays.
   184	 *
   185	 * @ptr must have pointer-to-simple-variable type, and the result of
   186	 * dereferencing @ptr must be assignable to @x without a cast.
   187	 *
   188	 * Returns zero on success, or -EFAULT on error.
   189	 * On error, the variable @x is set to zero.
   190	 */
   191	#define get_user(x, ptr)					\
   192	({								\
   193		const __typeof__(*(ptr)) __user *__p = (ptr);		\
   194		might_fault();						\
   195		access_ok(__p, sizeof(*__p)) ?		\
   196			__get_user((x), __p) :				\
   197			((x) = 0, -EFAULT);				\
   198	})
   199	
   200	#define __put_user_asm(insn, x, ptr, err)			\
   201	do {								\
   202		__typeof__(*(ptr)) __x = x;				\
   203		__asm__ __volatile__ (					\
   204			"1:\n"						\
   205			"	" insn " %z2, %1\n"			\
   206			"2:\n"						\
   207			_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %0)		\
   208			: "+r" (err), "=m" (*(ptr))			\
   209			: "rJ" (__x));					\
   210	} while (0)
   211	
   212	#ifdef CONFIG_64BIT
   213	#define __put_user_8(x, ptr, err) \
   214		__put_user_asm("sd", x, ptr, err)
   215	#else /* !CONFIG_64BIT */
   216	#define __put_user_8(x, ptr, err)				\
   217	do {								\
   218		u32 __user *__ptr = (u32 __user *)(ptr);		\
   219		u64 __x = (__typeof__((x)-(x)))(x);			\
   220		uintptr_t __tmp;					\
   221		__asm__ __volatile__ (					\
   222			"1:\n"						\
   223			"	sw %z3, %1\n"				\
   224			"2:\n"						\
   225			"	sw %z4, %2\n"				\
   226			"3:\n"						\
   227			_ASM_EXTABLE_UACCESS_ERR(1b, 3b, %0)		\
   228			_ASM_EXTABLE_UACCESS_ERR(2b, 3b, %0)		\
   229			: "+r" (err),					\
   230				"=m" (__ptr[__LSW]),			\
   231				"=m" (__ptr[__MSW])			\
   232			: "rJ" (__x), "rJ" (__x >> 32));		\
   233	} while (0)
   234	#endif /* CONFIG_64BIT */
   235	
   236	#define __put_user_nocheck(x, __gu_ptr, __pu_err)					\
   237	do {								\
   238		switch (sizeof(*__gu_ptr)) {				\
   239		case 1:							\
   240			__put_user_asm("sb", (x), __gu_ptr, __pu_err);	\
   241			break;						\
   242		case 2:							\
   243			__put_user_asm("sh", (x), __gu_ptr, __pu_err);	\
   244			break;						\
   245		case 4:							\
   246			__put_user_asm("sw", (x), __gu_ptr, __pu_err);	\
   247			break;						\
   248		case 8:							\
   249			__put_user_8((x), __gu_ptr, __pu_err);	\
   250			break;						\
   251		default:						\
   252			BUILD_BUG();					\
   253		}							\
   254	} while (0)
   255	
   256	/**
   257	 * __put_user: - Write a simple value into user space, with less checking.
   258	 * @x:   Value to copy to user space.
   259	 * @ptr: Destination address, in user space.
   260	 *
   261	 * Context: User context only.  This function may sleep.
   262	 *
   263	 * This macro copies a single simple value from kernel space to user
   264	 * space.  It supports simple types like char and int, but not larger
   265	 * data types like structures or arrays.
   266	 *
   267	 * @ptr must have pointer-to-simple-variable type, and @x must be assignable
   268	 * to the result of dereferencing @ptr. The value of @x is copied to avoid
   269	 * re-ordering where @x is evaluated inside the block that enables user-space
   270	 * access (thus bypassing user space protection if @x is a function).
   271	 *
   272	 * Caller must check the pointer with access_ok() before calling this
   273	 * function.
   274	 *
   275	 * Returns zero on success, or -EFAULT on error.
   276	 */
   277	#define __put_user(x, ptr)					\
   278	({								\
   279		__typeof__(*(ptr)) __user *__gu_ptr = (ptr);		\
   280		__typeof__(*__gu_ptr) __val = (x);			\
   281		long __pu_err = 0;					\
   282									\
   283		__chk_user_ptr(__gu_ptr);				\
   284									\
   285		__enable_user_access();					\
 > 286		__put_user_nocheck(__val, __gu_ptr, __pu_err);		\
   287		__disable_user_access();				\
   288									\
   289		__pu_err;						\
   290	})
   291	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

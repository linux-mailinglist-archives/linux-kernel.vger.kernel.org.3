Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056B5503481
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 08:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiDPGpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 02:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiDPGp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 02:45:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F41710E57D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 23:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650091375; x=1681627375;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9KKV/seif6yxgWWTpqghmLPpe+H3mHR2P7xtXXdbMOc=;
  b=LyFJmxicyx1JYpu4jEp6p0+C1H9l3NP+xDTRaWOlOMB8F1DTWU8USP5j
   F4yQ157peCoshH4Oo3rv58KmujsHDlS4D7aglxu2tchiXDHUSUx4rlmgA
   Iv5puTZIsRp2fB/8wk7k5vlFI0VQl/MB/KPxhErENqUCF5G4/Maij5tg6
   rO9rGcOTtP77QXMyfdhQvwAemj1Jc5EcMM0vLxI5I25KhwLmrXTl/9bKv
   ZULdwPt6zLTmH0TCo8HyMKTB6q/irbW+wURdlWFalrb+YtcGMODi5OqDA
   lMPhWZCwTdhMcq1rFMGkXAsn7oGvUacNa1mTTYxormdNBDm344aKcZa8P
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="326175395"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="326175395"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 23:42:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="662696699"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Apr 2022 23:42:53 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfc8y-0002s9-BA;
        Sat, 16 Apr 2022 06:42:52 +0000
Date:   Sat, 16 Apr 2022 14:42:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:palmer/linux/tspinlock-v3 5/9]
 kernel/signal.c:887:9: sparse: sparse: incorrect type in argument 1
 (different address spaces)
Message-ID: <202204161458.EiPLtOUS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/tspinlock-v3
head:   fc2d79f0558a2de8cdf896d84f507bf51f90cd0c
commit: 9d7cdf43225edaf8bef5c716927eb6a6c5a0f69b [5/9] RISC-V: Move to generic spinlocks
config: riscv-randconfig-s031-20220414 (https://download.01.org/0day-ci/archive/20220416/202204161458.EiPLtOUS-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/9d7cdf43225edaf8bef5c716927eb6a6c5a0f69b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/tspinlock-v3
        git checkout 9d7cdf43225edaf8bef5c716927eb6a6c5a0f69b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/signal.c: note: in included file (through include/uapi/asm-generic/signal.h, include/asm-generic/signal.h, arch/riscv/include/generated/uapi/asm/signal.h, ...):
   include/uapi/asm-generic/signal-defs.h:83:29: sparse: sparse: multiple address spaces given
   kernel/signal.c:195:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:195:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:195:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:198:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:198:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:198:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:480:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:480:9: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:480:9: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:484:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:484:34: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:484:34: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:542:53: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct k_sigaction *ka @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/signal.c:542:53: sparse:     expected struct k_sigaction *ka
   kernel/signal.c:542:53: sparse:     got struct k_sigaction [noderef] __rcu *
   include/uapi/asm-generic/signal-defs.h:83:29: sparse: sparse: multiple address spaces given
>> kernel/signal.c:887:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t [usertype] *lock @@     got struct atomic_t [noderef] __rcu * @@
   kernel/signal.c:887:9: sparse:     expected struct atomic_t [usertype] *lock
   kernel/signal.c:887:9: sparse:     got struct atomic_t [noderef] __rcu *
   kernel/signal.c:1082:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t [usertype] *lock @@     got struct atomic_t [noderef] __rcu * @@
   kernel/signal.c:1082:9: sparse:     expected struct atomic_t [usertype] *lock
   kernel/signal.c:1082:9: sparse:     got struct atomic_t [noderef] __rcu *
   kernel/signal.c:1330:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:1330:9: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:1330:9: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:1331:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct k_sigaction *action @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/signal.c:1331:16: sparse:     expected struct k_sigaction *action
   kernel/signal.c:1331:16: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/signal.c:1351:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:1351:34: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:1351:34: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:1929:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:1929:36: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:1929:36: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2039:44: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/signal.c:2058:65: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2058:65: sparse:     expected struct task_struct *tsk
   kernel/signal.c:2058:65: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2059:40: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/signal.c:2077:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sighand_struct *psig @@     got struct sighand_struct [noderef] __rcu *[noderef] __rcu sighand @@
   kernel/signal.c:2077:14: sparse:     expected struct sighand_struct *psig
   kernel/signal.c:2077:14: sparse:     got struct sighand_struct [noderef] __rcu *[noderef] __rcu sighand
   kernel/signal.c:2106:46: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct task_struct *t @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2106:46: sparse:     expected struct task_struct *t
   kernel/signal.c:2106:46: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2107:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2107:34: sparse:     expected struct task_struct *parent
   kernel/signal.c:2107:34: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2136:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2136:24: sparse:     expected struct task_struct *parent
   kernel/signal.c:2136:24: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2139:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/signal.c:2139:24: sparse:     expected struct task_struct *parent
   kernel/signal.c:2139:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/signal.c:2172:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/signal.c:2172:17: sparse:     expected struct sighand_struct *sighand
   kernel/signal.c:2172:17: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/signal.c:2213:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2213:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2213:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2215:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2215:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2215:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2266:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2266:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2266:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2322:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2322:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2322:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2363:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2363:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2363:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2365:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2365:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2365:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2464:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2464:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2464:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2548:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2548:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2548:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2560:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2560:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2560:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2595:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2595:52: sparse:     expected struct task_struct *tsk
   kernel/signal.c:2595:52: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2597:49: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/signal.c:2635:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/signal.c:2635:49: sparse:     expected struct sighand_struct *sighand
   kernel/signal.c:2635:49: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/signal.c:2964:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2964:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2964:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2984:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2984:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2984:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3051:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3051:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3051:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3053:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3053:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3053:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3204:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3204:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3204:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3207:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3207:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3207:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3594:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3594:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3594:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3606:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3606:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3606:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3611:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3611:35: sparse:     expected struct spinlock [usertype] *lock

vim +887 kernel/signal.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  866  
fb1d910c178ba0 Tejun Heo      2011-06-14  867  /**
fb1d910c178ba0 Tejun Heo      2011-06-14  868   * ptrace_trap_notify - schedule trap to notify ptracer
fb1d910c178ba0 Tejun Heo      2011-06-14  869   * @t: tracee wanting to notify tracer
fb1d910c178ba0 Tejun Heo      2011-06-14  870   *
fb1d910c178ba0 Tejun Heo      2011-06-14  871   * This function schedules sticky ptrace trap which is cleared on the next
fb1d910c178ba0 Tejun Heo      2011-06-14  872   * TRAP_STOP to notify ptracer of an event.  @t must have been seized by
fb1d910c178ba0 Tejun Heo      2011-06-14  873   * ptracer.
fb1d910c178ba0 Tejun Heo      2011-06-14  874   *
544b2c91a9f14f Tejun Heo      2011-06-14  875   * If @t is running, STOP trap will be taken.  If trapped for STOP and
544b2c91a9f14f Tejun Heo      2011-06-14  876   * ptracer is listening for events, tracee is woken up so that it can
544b2c91a9f14f Tejun Heo      2011-06-14  877   * re-trap for the new event.  If trapped otherwise, STOP trap will be
544b2c91a9f14f Tejun Heo      2011-06-14  878   * eventually taken without returning to userland after the existing traps
544b2c91a9f14f Tejun Heo      2011-06-14  879   * are finished by PTRACE_CONT.
fb1d910c178ba0 Tejun Heo      2011-06-14  880   *
fb1d910c178ba0 Tejun Heo      2011-06-14  881   * CONTEXT:
fb1d910c178ba0 Tejun Heo      2011-06-14  882   * Must be called with @task->sighand->siglock held.
fb1d910c178ba0 Tejun Heo      2011-06-14  883   */
fb1d910c178ba0 Tejun Heo      2011-06-14  884  static void ptrace_trap_notify(struct task_struct *t)
fb1d910c178ba0 Tejun Heo      2011-06-14  885  {
fb1d910c178ba0 Tejun Heo      2011-06-14  886  	WARN_ON_ONCE(!(t->ptrace & PT_SEIZED));
fb1d910c178ba0 Tejun Heo      2011-06-14 @887  	assert_spin_locked(&t->sighand->siglock);
fb1d910c178ba0 Tejun Heo      2011-06-14  888  
fb1d910c178ba0 Tejun Heo      2011-06-14  889  	task_set_jobctl_pending(t, JOBCTL_TRAP_NOTIFY);
910ffdb18a6408 Oleg Nesterov  2013-01-21  890  	ptrace_signal_wake_up(t, t->jobctl & JOBCTL_LISTENING);
fb1d910c178ba0 Tejun Heo      2011-06-14  891  }
fb1d910c178ba0 Tejun Heo      2011-06-14  892  

:::::: The code at line 887 was first introduced by commit
:::::: fb1d910c178ba0c5bc32d3e5a9e82e05b7aad3cd ptrace: implement TRAP_NOTIFY and use it for group stop events

:::::: TO: Tejun Heo <tj@kernel.org>
:::::: CC: Oleg Nesterov <oleg@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

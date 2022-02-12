Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2254B3342
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 06:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiBLFpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 00:45:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiBLFpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 00:45:31 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F6228E1F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 21:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644644728; x=1676180728;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lbLhE0Xz1RaaWRkIFcUZ/DMt102BU6wtZVc6nqc+wpI=;
  b=Ax1KGpMF5vQy6ddDgGjewtpAEVO5cfyHOlORpnKwQCslRcw/AeaWwLux
   wvOVkVn+4BEtF9RWnZOzm8jrQM5l4DvfaPbLHrfYzJq4rdzFwqzwgjq76
   nbNQedT92FJjrQq/SAnGYoA0XecDyuCp97LdQ6oxDla6SZKhBsi3hoxF4
   qk1H1XpLpQcLPf7VRXBFf/BhI2veNWjKoLvNR7tKVODv3r9rifB3sAskg
   zjEn4LSdDd43mIzep2m7lwzV3bFaC9q5zhrr/xH6i3BPi9jdqQftiE2CR
   pppWiy2Gy9IJpOBM9GPzDlrUnzS0EXbV5utGxfLEQ2n4fVllf0JqjPT6m
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="249803361"
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="249803361"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 21:45:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="586575723"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 11 Feb 2022 21:45:26 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIlDq-0005hJ-0v; Sat, 12 Feb 2022 05:45:26 +0000
Date:   Sat, 12 Feb 2022 13:45:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arnd-playground:set_fs 6/11] arch/csky/kernel/signal.c:143:14:
 sparse: sparse: incorrect type in argument 1 (different address spaces)
Message-ID: <202202121334.YatMsSbt-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git set_fs
head:   0a081326831928b0d739bce68b8c0f9138b9c8ba
commit: a954036380ae20dbfa0c203bf6cafb21d1f3cedd [6/11] uaccess: generalize access_ok()
config: csky-randconfig-s032-20220211 (https://download.01.org/0day-ci/archive/20220212/202202121334.YatMsSbt-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?id=a954036380ae20dbfa0c203bf6cafb21d1f3cedd
        git remote add arnd-playground https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
        git fetch --no-tags arnd-playground set_fs
        git checkout a954036380ae20dbfa0c203bf6cafb21d1f3cedd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/csky/kernel/signal.c:142:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct rt_sigframe *frame @@     got void [noderef] __user * @@
   arch/csky/kernel/signal.c:142:15: sparse:     expected struct rt_sigframe *frame
   arch/csky/kernel/signal.c:142:15: sparse:     got void [noderef] __user *
>> arch/csky/kernel/signal.c:143:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got struct rt_sigframe *frame @@
   arch/csky/kernel/signal.c:143:14: sparse:     expected void const [noderef] __user *ptr
   arch/csky/kernel/signal.c:143:14: sparse:     got struct rt_sigframe *frame
   arch/csky/kernel/signal.c:146:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct siginfo [noderef] [usertype] __user *to @@     got struct siginfo * @@
   arch/csky/kernel/signal.c:146:38: sparse:     expected struct siginfo [noderef] [usertype] __user *to
   arch/csky/kernel/signal.c:146:38: sparse:     got struct siginfo *
   arch/csky/kernel/signal.c:149:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long * @@
   arch/csky/kernel/signal.c:149:16: sparse:     expected void const volatile [noderef] __user *ptr
   arch/csky/kernel/signal.c:149:16: sparse:     got unsigned long *
   arch/csky/kernel/signal.c:149:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *ptr @@     got unsigned long * @@
   arch/csky/kernel/signal.c:149:16: sparse:     expected void [noderef] __user *ptr
   arch/csky/kernel/signal.c:149:16: sparse:     got unsigned long *
   arch/csky/kernel/signal.c:150:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got struct ucontext ** @@
   arch/csky/kernel/signal.c:150:16: sparse:     expected void const volatile [noderef] __user *ptr
   arch/csky/kernel/signal.c:150:16: sparse:     got struct ucontext **
   arch/csky/kernel/signal.c:150:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *ptr @@     got struct ucontext ** @@
   arch/csky/kernel/signal.c:150:16: sparse:     expected void [noderef] __user *ptr
   arch/csky/kernel/signal.c:150:16: sparse:     got struct ucontext **
   arch/csky/kernel/signal.c:151:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sigaltstack [noderef] [usertype] __user * @@     got struct sigaltstack * @@
   arch/csky/kernel/signal.c:151:33: sparse:     expected struct sigaltstack [noderef] [usertype] __user *
   arch/csky/kernel/signal.c:151:33: sparse:     got struct sigaltstack *
   arch/csky/kernel/signal.c:152:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct rt_sigframe [noderef] __user *frame @@     got struct rt_sigframe *frame @@
   arch/csky/kernel/signal.c:152:33: sparse:     expected struct rt_sigframe [noderef] __user *frame
   arch/csky/kernel/signal.c:152:33: sparse:     got struct rt_sigframe *frame
   arch/csky/kernel/signal.c:153:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct sigset_t * @@
   arch/csky/kernel/signal.c:153:32: sparse:     expected void [noderef] __user *to
   arch/csky/kernel/signal.c:153:32: sparse:     got struct sigset_t *
   arch/csky/kernel/signal.c: note: in included file:
   include/linux/uaccess.h:107:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   include/linux/uaccess.h:107:39: sparse:     expected void const *from
   include/linux/uaccess.h:107:39: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:141:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:141:33: sparse:     expected void *to
   include/linux/uaccess.h:141:33: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:107:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   include/linux/uaccess.h:107:39: sparse:     expected void const *from
   include/linux/uaccess.h:107:39: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:107:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   include/linux/uaccess.h:107:39: sparse:     expected void const *from
   include/linux/uaccess.h:107:39: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:141:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:141:33: sparse:     expected void *to
   include/linux/uaccess.h:141:33: sparse:     got void [noderef] __user *to
   arch/csky/kernel/signal.c: note: in included file (through include/linux/uaccess.h):
   arch/csky/include/asm/uaccess.h:112:17: sparse: sparse: cast removes address space '__user' of expression
   arch/csky/include/asm/uaccess.h:112:17: sparse: sparse: asm output is not an lvalue
   arch/csky/include/asm/uaccess.h:112:17: sparse: sparse: cast removes address space '__user' of expression
   arch/csky/include/asm/uaccess.h:112:17: sparse: sparse: cast removes address space '__user' of expression
   arch/csky/include/asm/uaccess.h:112:17: sparse: sparse: asm output is not an lvalue
   arch/csky/include/asm/uaccess.h:112:17: sparse: sparse: cast removes address space '__user' of expression
   arch/csky/kernel/signal.c: note: in included file:
   include/linux/uaccess.h:141:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:141:33: sparse:     expected void *to
   include/linux/uaccess.h:141:33: sparse:     got void [noderef] __user *to
   arch/csky/kernel/signal.c: note: in included file (through include/linux/uaccess.h):
   arch/csky/include/asm/uaccess.h:112:17: sparse: sparse: generating address of non-lvalue (11)
   arch/csky/include/asm/uaccess.h:112:17: sparse: sparse: generating address of non-lvalue (11)

vim +143 arch/csky/kernel/signal.c

e9564df753fd54 Guo Ren 2018-09-05  135  
e9564df753fd54 Guo Ren 2018-09-05  136  static int
e9564df753fd54 Guo Ren 2018-09-05  137  setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
e9564df753fd54 Guo Ren 2018-09-05  138  {
e9564df753fd54 Guo Ren 2018-09-05  139  	struct rt_sigframe *frame;
e9564df753fd54 Guo Ren 2018-09-05  140  	int err = 0;
e9564df753fd54 Guo Ren 2018-09-05  141  
bf241682936293 Guo Ren 2019-04-01 @142  	frame = get_sigframe(ksig, regs, sizeof(*frame));
bf241682936293 Guo Ren 2019-04-01 @143  	if (!access_ok(frame, sizeof(*frame)))
bf241682936293 Guo Ren 2019-04-01  144  		return -EFAULT;
e9564df753fd54 Guo Ren 2018-09-05  145  
e9564df753fd54 Guo Ren 2018-09-05  146  	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
e9564df753fd54 Guo Ren 2018-09-05  147  
e9564df753fd54 Guo Ren 2018-09-05  148  	/* Create the ucontext. */
e9564df753fd54 Guo Ren 2018-09-05  149  	err |= __put_user(0, &frame->uc.uc_flags);
bf241682936293 Guo Ren 2019-04-01  150  	err |= __put_user(NULL, &frame->uc.uc_link);
bf241682936293 Guo Ren 2019-04-01  151  	err |= __save_altstack(&frame->uc.uc_stack, regs->usp);
bf241682936293 Guo Ren 2019-04-01  152  	err |= setup_sigcontext(frame, regs);
bf241682936293 Guo Ren 2019-04-01  153  	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
e9564df753fd54 Guo Ren 2018-09-05  154  	if (err)
bf241682936293 Guo Ren 2019-04-01  155  		return -EFAULT;
e9564df753fd54 Guo Ren 2018-09-05  156  
bf241682936293 Guo Ren 2019-04-01  157  	/* Set up to return from userspace. */
87f3248cdb9aea Guo Ren 2021-01-04  158  	regs->lr = (unsigned long)VDSO_SYMBOL(
87f3248cdb9aea Guo Ren 2021-01-04  159  		current->mm->context.vdso, rt_sigreturn);
e9564df753fd54 Guo Ren 2018-09-05  160  
bf241682936293 Guo Ren 2019-04-01  161  	/*
bf241682936293 Guo Ren 2019-04-01  162  	 * Set up registers for signal handler.
bf241682936293 Guo Ren 2019-04-01  163  	 * Registers that we don't modify keep the value they had from
bf241682936293 Guo Ren 2019-04-01  164  	 * user-space at the time we took the signal.
bf241682936293 Guo Ren 2019-04-01  165  	 * We always pass siginfo and mcontext, regardless of SA_SIGINFO,
bf241682936293 Guo Ren 2019-04-01  166  	 * since some things rely on this (e.g. glibc's debug/segfault.c).
bf241682936293 Guo Ren 2019-04-01  167  	 */
bf241682936293 Guo Ren 2019-04-01  168  	regs->pc  = (unsigned long)ksig->ka.sa.sa_handler;
bf241682936293 Guo Ren 2019-04-01  169  	regs->usp = (unsigned long)frame;
bf241682936293 Guo Ren 2019-04-01  170  	regs->a0  = ksig->sig;				/* a0: signal number */
bf241682936293 Guo Ren 2019-04-01  171  	regs->a1  = (unsigned long)(&(frame->info));	/* a1: siginfo pointer */
bf241682936293 Guo Ren 2019-04-01  172  	regs->a2  = (unsigned long)(&(frame->uc));	/* a2: ucontext pointer */
e9564df753fd54 Guo Ren 2018-09-05  173  
bf241682936293 Guo Ren 2019-04-01  174  	return 0;
e9564df753fd54 Guo Ren 2018-09-05  175  }
e9564df753fd54 Guo Ren 2018-09-05  176  

:::::: The code at line 143 was first introduced by commit
:::::: bf241682936293291dcf40fd93cdd0f5e6222902 csky: Reconstruct signal processing

:::::: TO: Guo Ren <ren_guo@c-sky.com>
:::::: CC: Guo Ren <ren_guo@c-sky.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

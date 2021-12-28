Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C42480CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbhL1SpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 13:45:24 -0500
Received: from mga04.intel.com ([192.55.52.120]:65053 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231658AbhL1SpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640717124; x=1672253124;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fGYv5mgtvdW9kjOwwWT2K4cBBnwt6DpPEhDNG75IPw0=;
  b=ae2S2F50Ei+UH3v03wu0tSb8mB+Zw32/NuwpsQD5x0F2dDjm5ke4EXao
   OpvpMHKpLPo0SbuYFVFyI8HkqjLqvNw36hbsy720SoK5uoajhMq2pvCXC
   1zNkmVvvHrKCipdgpNPyQ8SRYEYWIvs6YySNU3crYkAostUMkP2KFKyZr
   2e7CpQNRcmuxsMUMNa40DeEkh8W/RGU9bwRl7DOAaX3KhR1QdcEBfKnCy
   EtV7nl4/CWbKdepaMLhjxwCau3GEU8XsMc8E3hGteXbDcrrjx+zinIfe3
   S9PhAs+lAA1qB5LAk6gvCPtGEPVOrD2a3+OoRdLN8dRWAUFlQTCykLDGg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="240189104"
X-IronPort-AV: E=Sophos;i="5.88,242,1635231600"; 
   d="scan'208";a="240189104"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 10:45:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,242,1635231600"; 
   d="scan'208";a="468202030"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2021 10:45:22 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2HTN-0007wY-Cb; Tue, 28 Dec 2021 18:45:21 +0000
Date:   Wed, 29 Dec 2021 02:45:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [csky-linux:riscv_compat_v2 17/17]
 arch/riscv/kernel/compat_signal.c:199:5: warning: no previous prototype for
 function 'compat_setup_rt_frame'
Message-ID: <202112290250.xtdytZe1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo,

First bad commit (maybe != root cause):

tree:   https://github.com/c-sky/csky-linux riscv_compat_v2
head:   750f87086bdd630f80b9bc3581bc3f329ef20f53
commit: 750f87086bdd630f80b9bc3581bc3f329ef20f53 [17/17] riscv: compat: Add COMPAT Kbuild skeletal support
config: riscv-buildonly-randconfig-r002-20211228 (https://download.01.org/0day-ci/archive/20211229/202112290250.xtdytZe1-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7171af744543433ac75b232eb7dfdaef7efd4d7a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/c-sky/csky-linux/commit/750f87086bdd630f80b9bc3581bc3f329ef20f53
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v2
        git checkout 750f87086bdd630f80b9bc3581bc3f329ef20f53
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/compat_signal.c:199:5: warning: no previous prototype for function 'compat_setup_rt_frame' [-Wmissing-prototypes]
   int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
       ^
   arch/riscv/kernel/compat_signal.c:199:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
   ^
   static 
   1 warning generated.


vim +/compat_setup_rt_frame +199 arch/riscv/kernel/compat_signal.c

520279d27c28fd Guo Ren 2021-12-13  198  
520279d27c28fd Guo Ren 2021-12-13 @199  int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
520279d27c28fd Guo Ren 2021-12-13  200  	struct pt_regs *regs)
520279d27c28fd Guo Ren 2021-12-13  201  {
520279d27c28fd Guo Ren 2021-12-13  202  	struct compat_rt_sigframe __user *frame;
520279d27c28fd Guo Ren 2021-12-13  203  	long err = 0;
520279d27c28fd Guo Ren 2021-12-13  204  
520279d27c28fd Guo Ren 2021-12-13  205  	frame = compat_get_sigframe(ksig, regs, sizeof(*frame));
520279d27c28fd Guo Ren 2021-12-13  206  	if (!access_ok(frame, sizeof(*frame)))
520279d27c28fd Guo Ren 2021-12-13  207  		return -EFAULT;
520279d27c28fd Guo Ren 2021-12-13  208  
520279d27c28fd Guo Ren 2021-12-13  209  	err |= copy_siginfo_to_user32(&frame->info, &ksig->info);
520279d27c28fd Guo Ren 2021-12-13  210  
520279d27c28fd Guo Ren 2021-12-13  211  	/* Create the ucontext. */
520279d27c28fd Guo Ren 2021-12-13  212  	err |= __put_user(0, &frame->uc.uc_flags);
520279d27c28fd Guo Ren 2021-12-13  213  	err |= __put_user(NULL, &frame->uc.uc_link);
520279d27c28fd Guo Ren 2021-12-13  214  	err |= __compat_save_altstack(&frame->uc.uc_stack, regs->sp);
520279d27c28fd Guo Ren 2021-12-13  215  	err |= compat_setup_sigcontext(frame, regs);
520279d27c28fd Guo Ren 2021-12-13  216  	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
520279d27c28fd Guo Ren 2021-12-13  217  	if (err)
520279d27c28fd Guo Ren 2021-12-13  218  		return -EFAULT;
520279d27c28fd Guo Ren 2021-12-13  219  
520279d27c28fd Guo Ren 2021-12-13  220  	regs->ra = (unsigned long)COMPAT_VDSO_SYMBOL(
520279d27c28fd Guo Ren 2021-12-13  221  			current->mm->context.vdso, rt_sigreturn);
520279d27c28fd Guo Ren 2021-12-13  222  
520279d27c28fd Guo Ren 2021-12-13  223  	/*
520279d27c28fd Guo Ren 2021-12-13  224  	 * Set up registers for signal handler.
520279d27c28fd Guo Ren 2021-12-13  225  	 * Registers that we don't modify keep the value they had from
520279d27c28fd Guo Ren 2021-12-13  226  	 * user-space at the time we took the signal.
520279d27c28fd Guo Ren 2021-12-13  227  	 * We always pass siginfo and mcontext, regardless of SA_SIGINFO,
520279d27c28fd Guo Ren 2021-12-13  228  	 * since some things rely on this (e.g. glibc's debug/segfault.c).
520279d27c28fd Guo Ren 2021-12-13  229  	 */
520279d27c28fd Guo Ren 2021-12-13  230  	regs->epc = (unsigned long)ksig->ka.sa.sa_handler;
520279d27c28fd Guo Ren 2021-12-13  231  	regs->sp = (unsigned long)frame;
520279d27c28fd Guo Ren 2021-12-13  232  	regs->a0 = ksig->sig;                     /* a0: signal number */
520279d27c28fd Guo Ren 2021-12-13  233  	regs->a1 = (unsigned long)(&frame->info); /* a1: siginfo pointer */
520279d27c28fd Guo Ren 2021-12-13  234  	regs->a2 = (unsigned long)(&frame->uc);   /* a2: ucontext pointer */
520279d27c28fd Guo Ren 2021-12-13  235  

:::::: The code at line 199 was first introduced by commit
:::::: 520279d27c28fd0bcabaef85d9c71cb592da21c2 riscv: compat: signal: Add rt_frame implementation

:::::: TO: Guo Ren <guoren@linux.alibaba.com>
:::::: CC: Guo Ren <guoren@linux.alibaba.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5B4495090
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345966AbiATOxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:53:09 -0500
Received: from mga07.intel.com ([134.134.136.100]:9242 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232516AbiATOxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642690387; x=1674226387;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Noy+6LqkiM5eEKz+N8lZjE3Eh0k1uiYmZ3BxbONhZeM=;
  b=IXwOozrecvm3lXUmd2UOSt3io/z+UQVQgN4WEzt9T7k8kZxYfZFcep05
   I7zLYFGPnu9nvZ8ft2r4X54Rbgy3gEPg1clqKNM/nm8c/vm5VVTM+GD98
   RKVdDBhtwJq5r5xXzPwJgfNV2DCGJUxA1AlGyBxr9L6H8xKHuF7soENRs
   cElBiX6s6XY7Q5yDHKREirFBESg6a/mUgt9gwZrCrgZktUklC0k0gS1xP
   hGgz4Oof5CcDY5DKmNFP/a8Hr6pZU1dGY/Xt0JH9CV6XZra2Fw8uoaA6Z
   kw3T17tveOV97GPyy3IBj4Wkc+bRiDzS7Nsyeyk05RKcdTCCqFwco+W/x
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="308705710"
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="308705710"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 06:53:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="493440497"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Jan 2022 06:53:06 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAYoD-000EM1-Bm; Thu, 20 Jan 2022 14:53:05 +0000
Date:   Thu, 20 Jan 2022 22:52:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [csky-linux:riscv_compat_v3 16/17]
 arch/riscv/kernel/compat_signal.c:199:5: warning: no previous prototype for
 function 'compat_setup_rt_frame'
Message-ID: <202201202234.gybNbUYU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo,

First bad commit (maybe != root cause):

tree:   https://github.com/c-sky/csky-linux riscv_compat_v3
head:   83f51edf28491d90ae9591131bc7cdd8ce7d3764
commit: ca6210b52caef524df951e60ec5bc09fb3196017 [16/17] riscv: compat: Add COMPAT Kbuild skeletal support
config: riscv-randconfig-r021-20220120 (https://download.01.org/0day-ci/archive/20220120/202201202234.gybNbUYU-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f7b7138a62648f4019c55e4671682af1f851f295)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/c-sky/csky-linux/commit/ca6210b52caef524df951e60ec5bc09fb3196017
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v3
        git checkout ca6210b52caef524df951e60ec5bc09fb3196017
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

97edfbe8120313 Guo Ren 2021-12-13  198  
97edfbe8120313 Guo Ren 2021-12-13 @199  int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
97edfbe8120313 Guo Ren 2021-12-13  200  	struct pt_regs *regs)
97edfbe8120313 Guo Ren 2021-12-13  201  {
97edfbe8120313 Guo Ren 2021-12-13  202  	struct compat_rt_sigframe __user *frame;
97edfbe8120313 Guo Ren 2021-12-13  203  	long err = 0;
97edfbe8120313 Guo Ren 2021-12-13  204  
97edfbe8120313 Guo Ren 2021-12-13  205  	frame = compat_get_sigframe(ksig, regs, sizeof(*frame));
97edfbe8120313 Guo Ren 2021-12-13  206  	if (!access_ok(frame, sizeof(*frame)))
97edfbe8120313 Guo Ren 2021-12-13  207  		return -EFAULT;
97edfbe8120313 Guo Ren 2021-12-13  208  
97edfbe8120313 Guo Ren 2021-12-13  209  	err |= copy_siginfo_to_user32(&frame->info, &ksig->info);
97edfbe8120313 Guo Ren 2021-12-13  210  
97edfbe8120313 Guo Ren 2021-12-13  211  	/* Create the ucontext. */
97edfbe8120313 Guo Ren 2021-12-13  212  	err |= __put_user(0, &frame->uc.uc_flags);
97edfbe8120313 Guo Ren 2021-12-13  213  	err |= __put_user(NULL, &frame->uc.uc_link);
97edfbe8120313 Guo Ren 2021-12-13  214  	err |= __compat_save_altstack(&frame->uc.uc_stack, regs->sp);
97edfbe8120313 Guo Ren 2021-12-13  215  	err |= compat_setup_sigcontext(frame, regs);
97edfbe8120313 Guo Ren 2021-12-13  216  	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
97edfbe8120313 Guo Ren 2021-12-13  217  	if (err)
97edfbe8120313 Guo Ren 2021-12-13  218  		return -EFAULT;
97edfbe8120313 Guo Ren 2021-12-13  219  
97edfbe8120313 Guo Ren 2021-12-13  220  	regs->ra = (unsigned long)COMPAT_VDSO_SYMBOL(
97edfbe8120313 Guo Ren 2021-12-13  221  			current->mm->context.vdso, rt_sigreturn);
97edfbe8120313 Guo Ren 2021-12-13  222  
97edfbe8120313 Guo Ren 2021-12-13  223  	/*
97edfbe8120313 Guo Ren 2021-12-13  224  	 * Set up registers for signal handler.
97edfbe8120313 Guo Ren 2021-12-13  225  	 * Registers that we don't modify keep the value they had from
97edfbe8120313 Guo Ren 2021-12-13  226  	 * user-space at the time we took the signal.
97edfbe8120313 Guo Ren 2021-12-13  227  	 * We always pass siginfo and mcontext, regardless of SA_SIGINFO,
97edfbe8120313 Guo Ren 2021-12-13  228  	 * since some things rely on this (e.g. glibc's debug/segfault.c).
97edfbe8120313 Guo Ren 2021-12-13  229  	 */
97edfbe8120313 Guo Ren 2021-12-13  230  	regs->epc = (unsigned long)ksig->ka.sa.sa_handler;
97edfbe8120313 Guo Ren 2021-12-13  231  	regs->sp = (unsigned long)frame;
97edfbe8120313 Guo Ren 2021-12-13  232  	regs->a0 = ksig->sig;                     /* a0: signal number */
97edfbe8120313 Guo Ren 2021-12-13  233  	regs->a1 = (unsigned long)(&frame->info); /* a1: siginfo pointer */
97edfbe8120313 Guo Ren 2021-12-13  234  	regs->a2 = (unsigned long)(&frame->uc);   /* a2: ucontext pointer */
97edfbe8120313 Guo Ren 2021-12-13  235  

:::::: The code at line 199 was first introduced by commit
:::::: 97edfbe8120313cf2a214c61d72175cf6f564430 riscv: compat: signal: Add rt_frame implementation

:::::: TO: Guo Ren <guoren@linux.alibaba.com>
:::::: CC: Guo Ren <guoren@linux.alibaba.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

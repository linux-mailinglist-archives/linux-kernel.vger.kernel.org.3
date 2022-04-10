Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E37A4FAB62
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 03:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiDJBfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 21:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiDJBfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 21:35:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D74240B9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 18:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649554411; x=1681090411;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NEXrl7JhYIHNqBR9ilbKtxWw8ztkQwjyxO/ZkVtFKck=;
  b=X0GnT6+OuLLzhIPR66pFjAbs4W4QZ2xW9M8WGShAt5laO7Sgf7JX+daG
   cG3k3j1ADWJACWdtX/bOjbbTXa4bPMin+OaEFwVjqtezRKIElMtfR+IJ2
   X5OyCl3Tmjvw3D0q7MhtSleV8+v7du4woZ8rwYz8/5DYsnXLpozDbwmIR
   ihnAKrThJnBWYxPNUDAYhXhGSR6BQ4APyNoJG+i7w+tP8Nc5s2XiPIm3P
   VzeHkpNx1UcdG2kSa6TnTuF84eXKj4bMNLWz0FB0R5LpWblDJPEVE9x4f
   LfcY1TM/4zn6DrVbXrZzlICHXYcux+f5EAx4JEK6b96Fpp4mZ+J0rsS84
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="241863849"
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="241863849"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 18:33:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="622409840"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Apr 2022 18:33:29 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndMSG-0000Yp-JM;
        Sun, 10 Apr 2022 01:33:28 +0000
Date:   Sun, 10 Apr 2022 09:33:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saleem Abdulrasool <abdulras@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: arch/riscv/kernel/signal.c:197:28: error: use of undeclared
 identifier '__vdso_rt_sigreturn_offset'
Message-ID: <202204100900.7BeXEmpM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saleem,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e1f700ebd6bea293abe3c7e2807b252018efde01
commit: fde9c59aebafb91caeed816cc510b56f14aa63ae riscv: explicitly use symbol offsets for VDSO
date:   8 months ago
config: riscv-randconfig-r011-20220410 (https://download.01.org/0day-ci/archive/20220410/202204100900.7BeXEmpM-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 256c6b0ba14e8a7ab6373b61b7193ea8c0a3651c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fde9c59aebafb91caeed816cc510b56f14aa63ae
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout fde9c59aebafb91caeed816cc510b56f14aa63ae
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/riscv/kernel/signal.c:197:28: error: use of undeclared identifier '__vdso_rt_sigreturn_offset'
           regs->ra = (unsigned long)VDSO_SYMBOL(
                                     ^
   arch/riscv/include/asm/vdso.h:20:42: note: expanded from macro 'VDSO_SYMBOL'
           (void __user *)((unsigned long)(base) + __vdso_##name##_offset)
                                                   ^
   <scratch space>:237:1: note: expanded from here
   __vdso_rt_sigreturn_offset
   ^
   arch/riscv/kernel/signal.c:309:27: warning: no previous prototype for function 'do_notify_resume' [-Wmissing-prototypes]
   asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
                             ^
   arch/riscv/kernel/signal.c:309:22: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
                        ^
                        static 
   1 warning and 1 error generated.


vim +/__vdso_rt_sigreturn_offset +197 arch/riscv/kernel/signal.c

e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  173  
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  174  static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  175  	struct pt_regs *regs)
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  176  {
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  177  	struct rt_sigframe __user *frame;
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  178  	long err = 0;
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  179  
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  180  	frame = get_sigframe(ksig, regs, sizeof(*frame));
96d4f267e40f95 Linus Torvalds    2019-01-03  181  	if (!access_ok(frame, sizeof(*frame)))
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  182  		return -EFAULT;
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  183  
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  184  	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  185  
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  186  	/* Create the ucontext. */
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  187  	err |= __put_user(0, &frame->uc.uc_flags);
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  188  	err |= __put_user(NULL, &frame->uc.uc_link);
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  189  	err |= __save_altstack(&frame->uc.uc_stack, regs->sp);
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  190  	err |= setup_sigcontext(frame, regs);
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  191  	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  192  	if (err)
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  193  		return -EFAULT;
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  194  
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  195  	/* Set up to return from userspace. */
6bd33e1ece528f Christoph Hellwig 2019-10-28  196  #ifdef CONFIG_MMU
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10 @197  	regs->ra = (unsigned long)VDSO_SYMBOL(
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  198  		current->mm->context.vdso, rt_sigreturn);
6bd33e1ece528f Christoph Hellwig 2019-10-28  199  #else
6bd33e1ece528f Christoph Hellwig 2019-10-28  200  	/*
6bd33e1ece528f Christoph Hellwig 2019-10-28  201  	 * For the nommu case we don't have a VDSO.  Instead we push two
6bd33e1ece528f Christoph Hellwig 2019-10-28  202  	 * instructions to call the rt_sigreturn syscall onto the user stack.
6bd33e1ece528f Christoph Hellwig 2019-10-28  203  	 */
6bd33e1ece528f Christoph Hellwig 2019-10-28  204  	if (copy_to_user(&frame->sigreturn_code, __user_rt_sigreturn,
6bd33e1ece528f Christoph Hellwig 2019-10-28  205  			 sizeof(frame->sigreturn_code)))
6bd33e1ece528f Christoph Hellwig 2019-10-28  206  		return -EFAULT;
6bd33e1ece528f Christoph Hellwig 2019-10-28  207  	regs->ra = (unsigned long)&frame->sigreturn_code;
6bd33e1ece528f Christoph Hellwig 2019-10-28  208  #endif /* CONFIG_MMU */
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  209  
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  210  	/*
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  211  	 * Set up registers for signal handler.
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  212  	 * Registers that we don't modify keep the value they had from
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  213  	 * user-space at the time we took the signal.
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  214  	 * We always pass siginfo and mcontext, regardless of SA_SIGINFO,
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  215  	 * since some things rely on this (e.g. glibc's debug/segfault.c).
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  216  	 */
a4c3733d32a72f Christoph Hellwig 2019-10-28  217  	regs->epc = (unsigned long)ksig->ka.sa.sa_handler;
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  218  	regs->sp = (unsigned long)frame;
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  219  	regs->a0 = ksig->sig;                     /* a0: signal number */
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  220  	regs->a1 = (unsigned long)(&frame->info); /* a1: siginfo pointer */
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  221  	regs->a2 = (unsigned long)(&frame->uc);   /* a2: ucontext pointer */
e2c0cdfba7f699 Palmer Dabbelt    2017-07-10  222  

:::::: The code at line 197 was first introduced by commit
:::::: e2c0cdfba7f69925afc92b20cd9835d81e11a4f1 RISC-V: User-facing API

:::::: TO: Palmer Dabbelt <palmer@dabbelt.com>
:::::: CC: Palmer Dabbelt <palmer@dabbelt.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

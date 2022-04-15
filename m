Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83027502868
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352362AbiDOKjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238551AbiDOKjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:39:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861566BDCF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 03:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650018999; x=1681554999;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pTU6WGQxA5wtymtGv3FJfm0xuishAo5Rj/AK64c1ahs=;
  b=ecQIujYogBazBeafXe62YDjIgP9YH+/4tS9EcbJUPtI9VhTj/Ph43H/U
   3/f9uS0YVNFVs0/wqQtQR8agnajdGZ9Rl9p7l6d/Dxjo/d5hajjbidswv
   JTaKJr4USUWhgOAUa1IWNiAlUieAGeuSz3v8/SchKo2J157vGz3f6nQc2
   DKQYgzzRj+GPtRNrN+vX9mXFbqyz8W8V3o82gXOfFvV6Z3jDW7Dws8YZb
   ZP+pEjWrHSuzda8YnsjEoFi3CMLV8IMc+3RB4O9z70gJORnINMn1HDj3b
   bUwW2T4GimTBQmHpWkFelHd8LELhmeIChSRAfJ/XZM09qymRoNaQZh1tJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="326038699"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="326038699"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 03:36:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="591595964"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 Apr 2022 03:36:36 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfJJc-0001rF-87;
        Fri, 15 Apr 2022 10:36:36 +0000
Date:   Fri, 15 Apr 2022 18:36:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [ammarfaizi2-block:palmer/linux/riscv-compat 20/20]
 arch/riscv/kernel/compat_signal.c:198:5: warning: no previous prototype for
 function 'compat_setup_rt_frame'
Message-ID: <202204151803.TXKhZhma-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-compat
head:   d84810b12dce65023c222aea22d30e2b22e3016a
commit: d84810b12dce65023c222aea22d30e2b22e3016a [20/20] riscv: compat: Add COMPAT Kbuild skeletal support
config: riscv-randconfig-r015-20220414 (https://download.01.org/0day-ci/archive/20220415/202204151803.TXKhZhma-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b7e6ea489f6dd45a9b0da9ac20871560917b9b0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/d84810b12dce65023c222aea22d30e2b22e3016a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-compat
        git checkout d84810b12dce65023c222aea22d30e2b22e3016a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/compat_signal.c:198:5: warning: no previous prototype for function 'compat_setup_rt_frame' [-Wmissing-prototypes]
   int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
       ^
   arch/riscv/kernel/compat_signal.c:198:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
   ^
   static 
   1 warning generated.


vim +/compat_setup_rt_frame +198 arch/riscv/kernel/compat_signal.c

7b07d6662e1218 Guo Ren 2022-04-05  197  
7b07d6662e1218 Guo Ren 2022-04-05 @198  int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
7b07d6662e1218 Guo Ren 2022-04-05  199  	struct pt_regs *regs)
7b07d6662e1218 Guo Ren 2022-04-05  200  {
7b07d6662e1218 Guo Ren 2022-04-05  201  	struct compat_rt_sigframe __user *frame;
7b07d6662e1218 Guo Ren 2022-04-05  202  	long err = 0;
7b07d6662e1218 Guo Ren 2022-04-05  203  
7b07d6662e1218 Guo Ren 2022-04-05  204  	frame = compat_get_sigframe(ksig, regs, sizeof(*frame));
7b07d6662e1218 Guo Ren 2022-04-05  205  	if (!access_ok(frame, sizeof(*frame)))
7b07d6662e1218 Guo Ren 2022-04-05  206  		return -EFAULT;
7b07d6662e1218 Guo Ren 2022-04-05  207  
7b07d6662e1218 Guo Ren 2022-04-05  208  	err |= copy_siginfo_to_user32(&frame->info, &ksig->info);
7b07d6662e1218 Guo Ren 2022-04-05  209  
7b07d6662e1218 Guo Ren 2022-04-05  210  	/* Create the ucontext. */
7b07d6662e1218 Guo Ren 2022-04-05  211  	err |= __put_user(0, &frame->uc.uc_flags);
7b07d6662e1218 Guo Ren 2022-04-05  212  	err |= __put_user(NULL, &frame->uc.uc_link);
7b07d6662e1218 Guo Ren 2022-04-05  213  	err |= __compat_save_altstack(&frame->uc.uc_stack, regs->sp);
7b07d6662e1218 Guo Ren 2022-04-05  214  	err |= compat_setup_sigcontext(frame, regs);
7b07d6662e1218 Guo Ren 2022-04-05  215  	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
7b07d6662e1218 Guo Ren 2022-04-05  216  	if (err)
7b07d6662e1218 Guo Ren 2022-04-05  217  		return -EFAULT;
7b07d6662e1218 Guo Ren 2022-04-05  218  
7b07d6662e1218 Guo Ren 2022-04-05  219  	regs->ra = (unsigned long)COMPAT_VDSO_SYMBOL(
7b07d6662e1218 Guo Ren 2022-04-05  220  			current->mm->context.vdso, rt_sigreturn);
7b07d6662e1218 Guo Ren 2022-04-05  221  
7b07d6662e1218 Guo Ren 2022-04-05  222  	/*
7b07d6662e1218 Guo Ren 2022-04-05  223  	 * Set up registers for signal handler.
7b07d6662e1218 Guo Ren 2022-04-05  224  	 * Registers that we don't modify keep the value they had from
7b07d6662e1218 Guo Ren 2022-04-05  225  	 * user-space at the time we took the signal.
7b07d6662e1218 Guo Ren 2022-04-05  226  	 * We always pass siginfo and mcontext, regardless of SA_SIGINFO,
7b07d6662e1218 Guo Ren 2022-04-05  227  	 * since some things rely on this (e.g. glibc's debug/segfault.c).
7b07d6662e1218 Guo Ren 2022-04-05  228  	 */
7b07d6662e1218 Guo Ren 2022-04-05  229  	regs->epc = (unsigned long)ksig->ka.sa.sa_handler;
7b07d6662e1218 Guo Ren 2022-04-05  230  	regs->sp = (unsigned long)frame;
7b07d6662e1218 Guo Ren 2022-04-05  231  	regs->a0 = ksig->sig;                     /* a0: signal number */
7b07d6662e1218 Guo Ren 2022-04-05  232  	regs->a1 = (unsigned long)(&frame->info); /* a1: siginfo pointer */
7b07d6662e1218 Guo Ren 2022-04-05  233  	regs->a2 = (unsigned long)(&frame->uc);   /* a2: ucontext pointer */
7b07d6662e1218 Guo Ren 2022-04-05  234  

:::::: The code at line 198 was first introduced by commit
:::::: 7b07d6662e1218841c2b618ab9a9255440ccee85 riscv: compat: signal: Add rt_frame implementation

:::::: TO: Guo Ren <guoren@linux.alibaba.com>
:::::: CC: Palmer Dabbelt <palmer@rivosinc.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

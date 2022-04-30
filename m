Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277C9515D41
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359799AbiD3NMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbiD3NMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:12:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8778233A
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651324135; x=1682860135;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v+FrIAWtw1nKPpwoZOsK89KN2KVuLHBlJX1dIjZsb+E=;
  b=bgDd/bEd7kPbK/0CbCleB9oMGI4l66qMbdPhBoMz8SFlo9QQi/bv3st1
   hInkFwoeaiSf0pTfB8tq9RMIIVYKS6kMJ4n20UGXxUMU0tOdE4H/mGTcV
   gN65kYPXXBdFKbrr/x5XxCK4VJPVd1q+Hea+TJuCu797dI1XXRjpy0GF1
   AqpClrJdKN7Hh90JI+qhuDWPI8JCEHZLGCFv/zuPAfAOaqKeEU62VCnKZ
   tEvTnLIHkFNuteXL0YS75hyuSw7Of5TpWxggJym5FTxGhDztXFNSGL/WA
   uMHVrMLfGk4vg6Ad4iA/ExaAtXGs8yE6BC6DvpplIL8XjAyiCUXGxwqT5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="266717746"
X-IronPort-AV: E=Sophos;i="5.91,188,1647327600"; 
   d="scan'208";a="266717746"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 06:08:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,188,1647327600"; 
   d="scan'208";a="597815981"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 30 Apr 2022 06:08:52 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkmqC-0007FL-0o;
        Sat, 30 Apr 2022 13:08:52 +0000
Date:   Sat, 30 Apr 2022 21:08:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [ammarfaizi2-block:palmer/linux/riscv-compat 20/20]
 arch/riscv/kernel/compat_signal.c:198:5: warning: no previous prototype for
 function 'compat_setup_rt_frame'
Message-ID: <202204302108.jfVPwbXj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-compat
head:   e2009fdf858d6fe01f0b24e35d8347fc8da3210f
commit: e2009fdf858d6fe01f0b24e35d8347fc8da3210f [20/20] riscv: compat: Add COMPAT Kbuild skeletal support
config: riscv-randconfig-r042-20220428 (https://download.01.org/0day-ci/archive/20220430/202204302108.jfVPwbXj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 400775649969b9baf3bc2a510266e7912bb16ae9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/e2009fdf858d6fe01f0b24e35d8347fc8da3210f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-compat
        git checkout e2009fdf858d6fe01f0b24e35d8347fc8da3210f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
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

44be29735fe706 Guo Ren 2022-04-05  197  
44be29735fe706 Guo Ren 2022-04-05 @198  int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
44be29735fe706 Guo Ren 2022-04-05  199  	struct pt_regs *regs)
44be29735fe706 Guo Ren 2022-04-05  200  {
44be29735fe706 Guo Ren 2022-04-05  201  	struct compat_rt_sigframe __user *frame;
44be29735fe706 Guo Ren 2022-04-05  202  	long err = 0;
44be29735fe706 Guo Ren 2022-04-05  203  
44be29735fe706 Guo Ren 2022-04-05  204  	frame = compat_get_sigframe(ksig, regs, sizeof(*frame));
44be29735fe706 Guo Ren 2022-04-05  205  	if (!access_ok(frame, sizeof(*frame)))
44be29735fe706 Guo Ren 2022-04-05  206  		return -EFAULT;
44be29735fe706 Guo Ren 2022-04-05  207  
44be29735fe706 Guo Ren 2022-04-05  208  	err |= copy_siginfo_to_user32(&frame->info, &ksig->info);
44be29735fe706 Guo Ren 2022-04-05  209  
44be29735fe706 Guo Ren 2022-04-05  210  	/* Create the ucontext. */
44be29735fe706 Guo Ren 2022-04-05  211  	err |= __put_user(0, &frame->uc.uc_flags);
44be29735fe706 Guo Ren 2022-04-05  212  	err |= __put_user(NULL, &frame->uc.uc_link);
44be29735fe706 Guo Ren 2022-04-05  213  	err |= __compat_save_altstack(&frame->uc.uc_stack, regs->sp);
44be29735fe706 Guo Ren 2022-04-05  214  	err |= compat_setup_sigcontext(frame, regs);
44be29735fe706 Guo Ren 2022-04-05  215  	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
44be29735fe706 Guo Ren 2022-04-05  216  	if (err)
44be29735fe706 Guo Ren 2022-04-05  217  		return -EFAULT;
44be29735fe706 Guo Ren 2022-04-05  218  
44be29735fe706 Guo Ren 2022-04-05  219  	regs->ra = (unsigned long)COMPAT_VDSO_SYMBOL(
44be29735fe706 Guo Ren 2022-04-05  220  			current->mm->context.vdso, rt_sigreturn);
44be29735fe706 Guo Ren 2022-04-05  221  
44be29735fe706 Guo Ren 2022-04-05  222  	/*
44be29735fe706 Guo Ren 2022-04-05  223  	 * Set up registers for signal handler.
44be29735fe706 Guo Ren 2022-04-05  224  	 * Registers that we don't modify keep the value they had from
44be29735fe706 Guo Ren 2022-04-05  225  	 * user-space at the time we took the signal.
44be29735fe706 Guo Ren 2022-04-05  226  	 * We always pass siginfo and mcontext, regardless of SA_SIGINFO,
44be29735fe706 Guo Ren 2022-04-05  227  	 * since some things rely on this (e.g. glibc's debug/segfault.c).
44be29735fe706 Guo Ren 2022-04-05  228  	 */
44be29735fe706 Guo Ren 2022-04-05  229  	regs->epc = (unsigned long)ksig->ka.sa.sa_handler;
44be29735fe706 Guo Ren 2022-04-05  230  	regs->sp = (unsigned long)frame;
44be29735fe706 Guo Ren 2022-04-05  231  	regs->a0 = ksig->sig;                     /* a0: signal number */
44be29735fe706 Guo Ren 2022-04-05  232  	regs->a1 = (unsigned long)(&frame->info); /* a1: siginfo pointer */
44be29735fe706 Guo Ren 2022-04-05  233  	regs->a2 = (unsigned long)(&frame->uc);   /* a2: ucontext pointer */
44be29735fe706 Guo Ren 2022-04-05  234  

:::::: The code at line 198 was first introduced by commit
:::::: 44be29735fe7065c7d32d1d2cc26b68487ac07b6 riscv: compat: signal: Add rt_frame implementation

:::::: TO: Guo Ren <guoren@linux.alibaba.com>
:::::: CC: Palmer Dabbelt <palmer@rivosinc.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

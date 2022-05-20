Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC01B52F622
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 01:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354078AbiETX00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 19:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354068AbiETX0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 19:26:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178AE65426
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653089181; x=1684625181;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kVjmWwMEvCixYbw/9qk9PdvBuagh38ipestoWpqf7to=;
  b=EmCgryBwn5wdlVd5Yb+B8Tliyvr+SzixrhWqfUPUYA5JkssD0D+L2bpR
   81ZJT0INq1kR/VEDFRcY93V3zyoZsxnrykof1kZ/DHD30bYP0splOS+B6
   SdKlNc4vZxs5vK5p/L5wHV5Dmuv4L1O1wJtP6EYjbpBlxiJkHlJANF0w+
   MbEzMZuXvzALcKtbDD3yHQLIe192rwPfwPgIkouywLkH/NW83YzETuEPa
   OydHT+G3IGhsTxeDb/huGg98C/RVqbk0IzVrUk/lwAx/PNVcuqfPSThEc
   w53Ctuedoa2zoEbmYUHpGQSAdoaMnI2FYAs+29NbyoQbOXuT4d9RUAfRk
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="272896064"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="272896064"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 16:26:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="743717635"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 20 May 2022 16:26:19 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsC0g-0005bq-Do;
        Fri, 20 May 2022 23:26:18 +0000
Date:   Sat, 21 May 2022 07:25:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saleem Abdulrasool <abdulras@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: arch/riscv/kernel/signal.c:197:28: error: use of undeclared
 identifier '__vdso_rt_sigreturn_offset'
Message-ID: <202205210713.al93bRN0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saleem,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b5e1590a26713a8c76896f0f1b99f52ec24e72f
commit: fde9c59aebafb91caeed816cc510b56f14aa63ae riscv: explicitly use symbol offsets for VDSO
date:   9 months ago
config: riscv-randconfig-r042-20220519 (https://download.01.org/0day-ci/archive/20220521/202205210713.al93bRN0-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e00cbbec06c08dc616a0d52a20f678b8fbd4e304)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fde9c59aebafb91caeed816cc510b56f14aa63ae
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout fde9c59aebafb91caeed816cc510b56f14aa63ae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/riscv/kernel/signal.c:197:28: error: use of undeclared identifier '__vdso_rt_sigreturn_offset'
           regs->ra = (unsigned long)VDSO_SYMBOL(
                                     ^
   arch/riscv/include/asm/vdso.h:20:42: note: expanded from macro 'VDSO_SYMBOL'
           (void __user *)((unsigned long)(base) + __vdso_##name##_offset)
                                                   ^
   <scratch space>:204:1: note: expanded from here
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

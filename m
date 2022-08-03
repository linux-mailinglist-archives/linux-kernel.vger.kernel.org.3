Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EE15885C8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 04:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbiHCCas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 22:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiHCCaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 22:30:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E818A1CFDE
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 19:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659493845; x=1691029845;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=svzXtL8TTiYXT6mqM+2nXiVLdwwSFUZuQYT7SkfHC6E=;
  b=EgYlklvGbZMPfqXaHOsJiIgr0I2YixTsMz0+EF3NQI8eSU28ATuidogG
   EsgubqkmkIt93eN9tkcaboqKlELjGmEtHqwbQivlsWZyn3M3Lek3sJXxF
   AhWLSi/mEP+uu5Uy1XhLAw+CQW48jcynjES0mEhfpPl8VIm2Afgv1K67f
   XP09YYOfEEwa0yrqOktJXj8ckIcr5mB06JdUGyw0pByo5/5QBW7ImCqFa
   +Z62mJzXUYGUlHPReiMS4aX2sAOhd4MpAnj+3gAbbgZFIgIrC4Ln1mfzP
   ocjL53AX3zC7jpBcVHJSXoZHKjIrD0W1j6hmmKv82OJcCTIzItQJENbCG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="315421059"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="315421059"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 19:30:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="553151453"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Aug 2022 19:30:43 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ49j-000Ghd-0n;
        Wed, 03 Aug 2022 02:30:43 +0000
Date:   Wed, 3 Aug 2022 10:29:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saleem Abdulrasool <abdulras@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: arch/riscv/kernel/signal.c:197:28: error: use of undeclared
 identifier '__vdso_rt_sigreturn_offset'
Message-ID: <202208031019.E5mj21An-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saleem,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c2a24a7a036b3bd3a2e6c66730dfc777cae6540a
commit: fde9c59aebafb91caeed816cc510b56f14aa63ae riscv: explicitly use symbol offsets for VDSO
date:   11 months ago
config: riscv-randconfig-c006-20220802 (https://download.01.org/0day-ci/archive/20220803/202208031019.E5mj21An-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
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
   <scratch space>:132:1: note: expanded from here
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
--
   ld.lld: error: section .text load address range overlaps with .eh_frame_hdr
   >>> .text range is [0x800, 0x1733]
   >>> .eh_frame_hdr range is [0x9C0, 0x9E3]
>> llvm-nm: error: arch/riscv/kernel/vdso/vdso.so.dbg: No such file or directory


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

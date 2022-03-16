Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86F84DB1C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243066AbiCPNpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241784AbiCPNpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:45:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568B35AA58
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647438234; x=1678974234;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ia464ki27ge9N+7v/cZ9X6DfqHOtFnitVi0AdRUCp78=;
  b=Tf2SvcFZ9lnoZWdS54XWHD84B7Pi71a4/UlI6Qa6mZk2IrpV0ks/5wQZ
   xQw1xsp73BIe3kKb48EagMIjvY1S/geZfNXyKvFERph6q1QMHG5LR5jnT
   I4IgG8sZvH+F41Ngaa3LcBy6qzBvihykdOPV1R67kiFNrhlFbH5/RtWEX
   nq7Wme6aj0UokYkaZHBdQpKeEFkDFo9ExkzF+56Gkea8t3MHyyXSholEx
   JX0dVCfiPb0N9okXZzG1bq1LlXfX5j32huxyLJkrr5ycECcb/UM6P3GYl
   0cf6TKPUUnD7EB/Fk4970thETlZUgrm1qIGVYi92dEp1gSgFk524aFr8F
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256779817"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="256779817"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 06:43:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="513021924"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 16 Mar 2022 06:43:52 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUTwN-000CTJ-GC; Wed, 16 Mar 2022 13:43:51 +0000
Date:   Wed, 16 Mar 2022 21:42:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [csky-linux:riscv_compat_v8 20/20]
 arch/riscv/kernel/compat_signal.c:199:5: warning: no previous prototype for
 function 'compat_setup_rt_frame'
Message-ID: <202203162123.Ksr0CtpZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v8
head:   5e16532e9a75c08518ff196285fe079ee12188ae
commit: 5e16532e9a75c08518ff196285fe079ee12188ae [20/20] riscv: compat: Add COMPAT Kbuild skeletal support
config: riscv-randconfig-r033-20220313 (https://download.01.org/0day-ci/archive/20220316/202203162123.Ksr0CtpZ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/c-sky/csky-linux/commit/5e16532e9a75c08518ff196285fe079ee12188ae
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v8
        git checkout 5e16532e9a75c08518ff196285fe079ee12188ae
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

45847575ba9c88 Guo Ren 2021-12-13  198  
45847575ba9c88 Guo Ren 2021-12-13 @199  int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
45847575ba9c88 Guo Ren 2021-12-13  200  	struct pt_regs *regs)
45847575ba9c88 Guo Ren 2021-12-13  201  {
45847575ba9c88 Guo Ren 2021-12-13  202  	struct compat_rt_sigframe __user *frame;
45847575ba9c88 Guo Ren 2021-12-13  203  	long err = 0;
45847575ba9c88 Guo Ren 2021-12-13  204  
45847575ba9c88 Guo Ren 2021-12-13  205  	frame = compat_get_sigframe(ksig, regs, sizeof(*frame));
45847575ba9c88 Guo Ren 2021-12-13  206  	if (!access_ok(frame, sizeof(*frame)))
45847575ba9c88 Guo Ren 2021-12-13  207  		return -EFAULT;
45847575ba9c88 Guo Ren 2021-12-13  208  
45847575ba9c88 Guo Ren 2021-12-13  209  	err |= copy_siginfo_to_user32(&frame->info, &ksig->info);
45847575ba9c88 Guo Ren 2021-12-13  210  
45847575ba9c88 Guo Ren 2021-12-13  211  	/* Create the ucontext. */
45847575ba9c88 Guo Ren 2021-12-13  212  	err |= __put_user(0, &frame->uc.uc_flags);
45847575ba9c88 Guo Ren 2021-12-13  213  	err |= __put_user(NULL, &frame->uc.uc_link);
45847575ba9c88 Guo Ren 2021-12-13  214  	err |= __compat_save_altstack(&frame->uc.uc_stack, regs->sp);
45847575ba9c88 Guo Ren 2021-12-13  215  	err |= compat_setup_sigcontext(frame, regs);
45847575ba9c88 Guo Ren 2021-12-13  216  	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
45847575ba9c88 Guo Ren 2021-12-13  217  	if (err)
45847575ba9c88 Guo Ren 2021-12-13  218  		return -EFAULT;
45847575ba9c88 Guo Ren 2021-12-13  219  
45847575ba9c88 Guo Ren 2021-12-13  220  	regs->ra = (unsigned long)COMPAT_VDSO_SYMBOL(
45847575ba9c88 Guo Ren 2021-12-13  221  			current->mm->context.vdso, rt_sigreturn);
45847575ba9c88 Guo Ren 2021-12-13  222  
45847575ba9c88 Guo Ren 2021-12-13  223  	/*
45847575ba9c88 Guo Ren 2021-12-13  224  	 * Set up registers for signal handler.
45847575ba9c88 Guo Ren 2021-12-13  225  	 * Registers that we don't modify keep the value they had from
45847575ba9c88 Guo Ren 2021-12-13  226  	 * user-space at the time we took the signal.
45847575ba9c88 Guo Ren 2021-12-13  227  	 * We always pass siginfo and mcontext, regardless of SA_SIGINFO,
45847575ba9c88 Guo Ren 2021-12-13  228  	 * since some things rely on this (e.g. glibc's debug/segfault.c).
45847575ba9c88 Guo Ren 2021-12-13  229  	 */
45847575ba9c88 Guo Ren 2021-12-13  230  	regs->epc = (unsigned long)ksig->ka.sa.sa_handler;
45847575ba9c88 Guo Ren 2021-12-13  231  	regs->sp = (unsigned long)frame;
45847575ba9c88 Guo Ren 2021-12-13  232  	regs->a0 = ksig->sig;                     /* a0: signal number */
45847575ba9c88 Guo Ren 2021-12-13  233  	regs->a1 = (unsigned long)(&frame->info); /* a1: siginfo pointer */
45847575ba9c88 Guo Ren 2021-12-13  234  	regs->a2 = (unsigned long)(&frame->uc);   /* a2: ucontext pointer */
45847575ba9c88 Guo Ren 2021-12-13  235  

:::::: The code at line 199 was first introduced by commit
:::::: 45847575ba9c8837017d2a6af498aaeee0477b3c riscv: compat: signal: Add rt_frame implementation

:::::: TO: Guo Ren <guoren@linux.alibaba.com>
:::::: CC: Guo Ren <guoren@linux.alibaba.com>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

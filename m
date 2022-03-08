Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6CE4D1335
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345306AbiCHJVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiCHJVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:21:16 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4143D1DE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 01:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646731220; x=1678267220;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g31hreQzSjTK6mj+0WHi5CL3qiy0VZEWxvJ3Hd9UIMo=;
  b=RzIJ76/Xw/ZeUHNBPwfL4BMl5e3rWDn1fDqDRy96NP9phgcDbu4gvMNA
   pIrV5i3LnIbYP9I3tiPMLCoYqhcUD10vB5imjLglU0fAg39JAMKYNuC39
   Vnc9pthtaliOOmONNGCs5FmzJpphKJm4qqZLy9KxkiVzQqsRlcYDaVIZM
   Nrs3XJAJ0tAxSgQX4aiObBEOr6yLfcJDfNdrKZSzZLcNnJwRfQSaRMZ+b
   JchBuaJDjL85T296vuNqVsOe31TDBNnKK9PsxGEIfYtE6MQ/acVfAByQw
   jmQkUdIBNdbQziw5N3I95/b/BMb0TJAMz/rw64p+wpFR51KEMyz5AvaLb
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="235246660"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="235246660"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 01:20:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="495389075"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2022 01:20:18 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRW0v-0001Cn-FS; Tue, 08 Mar 2022 09:20:17 +0000
Date:   Tue, 8 Mar 2022 17:19:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [ammarfaizi2-block:palmer/linux/riscv-compat 20/20]
 arch/riscv/kernel/compat_signal.c:199:5: warning: no previous prototype for
 'compat_setup_rt_frame'
Message-ID: <202203081736.viunH1fl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-compat
head:   ab7e33a6b819f009c3c9ccf69b2f44c1ad84a5a0
commit: ab7e33a6b819f009c3c9ccf69b2f44c1ad84a5a0 [20/20] riscv: compat: Add COMPAT Kbuild skeletal support
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220308/202203081736.viunH1fl-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/ab7e33a6b819f009c3c9ccf69b2f44c1ad84a5a0
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-compat
        git checkout ab7e33a6b819f009c3c9ccf69b2f44c1ad84a5a0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/ arch/riscv/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/compat_signal.c:199:5: warning: no previous prototype for 'compat_setup_rt_frame' [-Wmissing-prototypes]
     199 | int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
         |     ^~~~~~~~~~~~~~~~~~~~~


vim +/compat_setup_rt_frame +199 arch/riscv/kernel/compat_signal.c

7fbcda00016ec9 Guo Ren 2022-02-28  198  
7fbcda00016ec9 Guo Ren 2022-02-28 @199  int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
7fbcda00016ec9 Guo Ren 2022-02-28  200  	struct pt_regs *regs)
7fbcda00016ec9 Guo Ren 2022-02-28  201  {
7fbcda00016ec9 Guo Ren 2022-02-28  202  	struct compat_rt_sigframe __user *frame;
7fbcda00016ec9 Guo Ren 2022-02-28  203  	long err = 0;
7fbcda00016ec9 Guo Ren 2022-02-28  204  
7fbcda00016ec9 Guo Ren 2022-02-28  205  	frame = compat_get_sigframe(ksig, regs, sizeof(*frame));
7fbcda00016ec9 Guo Ren 2022-02-28  206  	if (!access_ok(frame, sizeof(*frame)))
7fbcda00016ec9 Guo Ren 2022-02-28  207  		return -EFAULT;
7fbcda00016ec9 Guo Ren 2022-02-28  208  
7fbcda00016ec9 Guo Ren 2022-02-28  209  	err |= copy_siginfo_to_user32(&frame->info, &ksig->info);
7fbcda00016ec9 Guo Ren 2022-02-28  210  
7fbcda00016ec9 Guo Ren 2022-02-28  211  	/* Create the ucontext. */
7fbcda00016ec9 Guo Ren 2022-02-28  212  	err |= __put_user(0, &frame->uc.uc_flags);
7fbcda00016ec9 Guo Ren 2022-02-28  213  	err |= __put_user(NULL, &frame->uc.uc_link);
7fbcda00016ec9 Guo Ren 2022-02-28  214  	err |= __compat_save_altstack(&frame->uc.uc_stack, regs->sp);
7fbcda00016ec9 Guo Ren 2022-02-28  215  	err |= compat_setup_sigcontext(frame, regs);
7fbcda00016ec9 Guo Ren 2022-02-28  216  	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
7fbcda00016ec9 Guo Ren 2022-02-28  217  	if (err)
7fbcda00016ec9 Guo Ren 2022-02-28  218  		return -EFAULT;
7fbcda00016ec9 Guo Ren 2022-02-28  219  
7fbcda00016ec9 Guo Ren 2022-02-28  220  	regs->ra = (unsigned long)COMPAT_VDSO_SYMBOL(
7fbcda00016ec9 Guo Ren 2022-02-28  221  			current->mm->context.vdso, rt_sigreturn);
7fbcda00016ec9 Guo Ren 2022-02-28  222  
7fbcda00016ec9 Guo Ren 2022-02-28  223  	/*
7fbcda00016ec9 Guo Ren 2022-02-28  224  	 * Set up registers for signal handler.
7fbcda00016ec9 Guo Ren 2022-02-28  225  	 * Registers that we don't modify keep the value they had from
7fbcda00016ec9 Guo Ren 2022-02-28  226  	 * user-space at the time we took the signal.
7fbcda00016ec9 Guo Ren 2022-02-28  227  	 * We always pass siginfo and mcontext, regardless of SA_SIGINFO,
7fbcda00016ec9 Guo Ren 2022-02-28  228  	 * since some things rely on this (e.g. glibc's debug/segfault.c).
7fbcda00016ec9 Guo Ren 2022-02-28  229  	 */
7fbcda00016ec9 Guo Ren 2022-02-28  230  	regs->epc = (unsigned long)ksig->ka.sa.sa_handler;
7fbcda00016ec9 Guo Ren 2022-02-28  231  	regs->sp = (unsigned long)frame;
7fbcda00016ec9 Guo Ren 2022-02-28  232  	regs->a0 = ksig->sig;                     /* a0: signal number */
7fbcda00016ec9 Guo Ren 2022-02-28  233  	regs->a1 = (unsigned long)(&frame->info); /* a1: siginfo pointer */
7fbcda00016ec9 Guo Ren 2022-02-28  234  	regs->a2 = (unsigned long)(&frame->uc);   /* a2: ucontext pointer */
7fbcda00016ec9 Guo Ren 2022-02-28  235  

:::::: The code at line 199 was first introduced by commit
:::::: 7fbcda00016ec95ced8262fb949bead0549c9727 riscv: compat: signal: Add rt_frame implementation

:::::: TO: Guo Ren <guoren@linux.alibaba.com>
:::::: CC: Palmer Dabbelt <palmer@rivosinc.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

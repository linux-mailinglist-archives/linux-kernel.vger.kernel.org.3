Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376AB46EB12
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbhLIP1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:27:08 -0500
Received: from mga02.intel.com ([134.134.136.20]:30215 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235389AbhLIP1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639063413; x=1670599413;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RZFJHBfdP6C7iDLd0NSS3cF1752WbL5csfY2j4kzeYU=;
  b=M7eGws+PcgMG2UpE3Txp0YOU4DK+K5mUo7UOsDo9B+YwLnehwYTmi9zA
   XNdl7IX0h1NPhYWG0NN5HRaf3u1W4rqYcVW7v+D4JIvwm9uhbUeO2eSGL
   R5mp41mZt5g3x2tS2+uevg5sHv9ln6Tn7WjueG6SIvNPjWg4/AuJw99cN
   LVIXkwTRXSdoS5VyJI4C+10LbhXUHXosva0fBtHEa+s8zDOLkR0cSCIL4
   Ex3IWBe5vUjYLSGUto2oxzvZbYx/cFLTFt7liuOVCvKyAcWyzWgqBaTEF
   JIKqMZgG3t76aEKG9cCASSaDoHJutNfe+289ulGG9VobpDUZQuUX7QaRz
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="225388270"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="225388270"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 07:23:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="462167236"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 09 Dec 2021 07:23:30 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvLGc-00025C-3H; Thu, 09 Dec 2021 15:23:30 +0000
Date:   Thu, 9 Dec 2021 23:22:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: arch/arm/kernel/traps.c:775:6: warning: no previous prototype for
 function 'abort'
Message-ID: <202112092330.MRS9Xygy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2a987e65025e2b79c6d453b78cb5985ac6e5eb26
commit: 4d576cab16f57e1f87978f6997a725179398341e ARM: 9028/1: disable KASAN in call stack capturing routines
date:   1 year ago
config: arm-randconfig-c002-20211209 (https://download.01.org/0day-ci/archive/20211209/202112092330.MRS9Xygy-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4d576cab16f57e1f87978f6997a725179398341e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4d576cab16f57e1f87978f6997a725179398341e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/kernel/ drivers/media/platform/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm/kernel/traps.c:82:6: warning: no previous prototype for function 'dump_backtrace_stm' [-Wmissing-prototypes]
   void dump_backtrace_stm(u32 *stack, u32 instruction, const char *loglvl)
        ^
   arch/arm/kernel/traps.c:82:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void dump_backtrace_stm(u32 *stack, u32 instruction, const char *loglvl)
   ^
   static 
   arch/arm/kernel/traps.c:445:17: warning: no previous prototype for function 'do_undefinstr' [-Wmissing-prototypes]
   asmlinkage void do_undefinstr(struct pt_regs *regs)
                   ^
   arch/arm/kernel/traps.c:445:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_undefinstr(struct pt_regs *regs)
              ^
              static 
   arch/arm/kernel/traps.c:510:39: warning: no previous prototype for function 'handle_fiq_as_nmi' [-Wmissing-prototypes]
   asmlinkage void __exception_irq_entry handle_fiq_as_nmi(struct pt_regs *regs)
                                         ^
   arch/arm/kernel/traps.c:510:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void __exception_irq_entry handle_fiq_as_nmi(struct pt_regs *regs)
              ^
              static 
   arch/arm/kernel/traps.c:529:17: warning: no previous prototype for function 'bad_mode' [-Wmissing-prototypes]
   asmlinkage void bad_mode(struct pt_regs *regs, int reason)
                   ^
   arch/arm/kernel/traps.c:529:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void bad_mode(struct pt_regs *regs, int reason)
              ^
              static 
   arch/arm/kernel/traps.c:602:16: warning: no previous prototype for function 'arm_syscall' [-Wmissing-prototypes]
   asmlinkage int arm_syscall(int no, struct pt_regs *regs)
                  ^
   arch/arm/kernel/traps.c:602:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage int arm_syscall(int no, struct pt_regs *regs)
              ^
              static 
   arch/arm/kernel/traps.c:728:1: warning: no previous prototype for function 'baddataabort' [-Wmissing-prototypes]
   baddataabort(int code, unsigned long instr, struct pt_regs *regs)
   ^
   arch/arm/kernel/traps.c:727:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void
              ^
              static 
   arch/arm/kernel/traps.c:768:17: warning: no previous prototype for function '__div0' [-Wmissing-prototypes]
   asmlinkage void __div0(void)
                   ^
   arch/arm/kernel/traps.c:768:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void __div0(void)
              ^
              static 
>> arch/arm/kernel/traps.c:775:6: warning: no previous prototype for function 'abort' [-Wmissing-prototypes]
   void abort(void)
        ^
   arch/arm/kernel/traps.c:775:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void abort(void)
   ^
   static 
   arch/arm/kernel/traps.c:783:13: warning: no previous prototype for function 'trap_init' [-Wmissing-prototypes]
   void __init trap_init(void)
               ^
   arch/arm/kernel/traps.c:783:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init trap_init(void)
   ^
   static 
   9 warnings generated.


vim +/abort +775 arch/arm/kernel/traps.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  767  
^1da177e4c3f41 Linus Torvalds 2005-04-16 @768  asmlinkage void __div0(void)
^1da177e4c3f41 Linus Torvalds 2005-04-16  769  {
4ed89f22280614 Russell King   2014-10-28  770  	pr_err("Division by zero in kernel.\n");
^1da177e4c3f41 Linus Torvalds 2005-04-16  771  	dump_stack();
^1da177e4c3f41 Linus Torvalds 2005-04-16  772  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  773  EXPORT_SYMBOL(__div0);
^1da177e4c3f41 Linus Torvalds 2005-04-16  774  
^1da177e4c3f41 Linus Torvalds 2005-04-16 @775  void abort(void)
^1da177e4c3f41 Linus Torvalds 2005-04-16  776  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  777  	BUG();
^1da177e4c3f41 Linus Torvalds 2005-04-16  778  
^1da177e4c3f41 Linus Torvalds 2005-04-16  779  	/* if that doesn't kill us, halt */
^1da177e4c3f41 Linus Torvalds 2005-04-16  780  	panic("Oops failed to kill thread");
^1da177e4c3f41 Linus Torvalds 2005-04-16  781  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  782  

:::::: The code at line 775 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886264884EF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 18:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbiAHRXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 12:23:05 -0500
Received: from mga17.intel.com ([192.55.52.151]:54816 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232177AbiAHRXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641662584; x=1673198584;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Jzr1p1+i2NQ05atcSx6BrGo35zI43G52AZsx5RMGXUk=;
  b=VDY+Z4+FTbtGWXvGNgibWWeWr03/QRyVho1Avd/gDlmzklwLDHxC6jbl
   sEKqx1n/R3T/4vfYIdPfdf5HtOJFMC5pJozpokkLoAIE7Bp//w2NYJNSg
   iSmUpXaIlh5SEX5ufFznAw58/eqWbMLaGTT8z61n6ui2j6PFBhw3VKc27
   FUcFPZaQ3H9lKqp6So9duKb+B9HOnPOl2ApUfbuFYlnHjsOlL1pT3iVKL
   BWLg2ZQ0g5JOapeA5BOv5dXxkG4FOu9SQrxseN6h0ZepMJVWXbFxOVOCf
   qFZayRDtJT+dMOlQBsnYqQgll5zNKyV5riqemMrGpucSJ0PXGTIqeVeYh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="223727172"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="223727172"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 09:23:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="473676394"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Jan 2022 09:23:02 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6FQj-0000rX-RW; Sat, 08 Jan 2022 17:23:01 +0000
Date:   Sun, 9 Jan 2022 01:22:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1626/2300] arch/arm64/kernel/traps.c:1081:13:
 warning: no previous prototype for function 'trap_init'
Message-ID: <202201090114.UJD5Vbez-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   4e348e961395297bb17f101cc63bc133d8a348e9
commit: 7e1545fe3cd7d5ab2472513191e4fbec3467ba2c [1626/2300] headers/deps: tracing: Optimize the <trace/syscall.h> header
config: arm64-buildonly-randconfig-r005-20220108 (https://download.01.org/0day-ci/archive/20220109/202201090114.UJD5Vbez-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f3a344d2125fa37e59bae1b0874442c650a19607)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=7e1545fe3cd7d5ab2472513191e4fbec3467ba2c
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 7e1545fe3cd7d5ab2472513191e4fbec3467ba2c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm64/kernel/traps.c:812:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = "UNRECOGNIZED EC",
                                             ^~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:839:27: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_DABT_LOW]           = "DABT (lower EL)",
                                             ^~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:812:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = "UNRECOGNIZED EC",
                                             ^~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:840:27: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_DABT_CUR]           = "DABT (current EL)",
                                             ^~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:812:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = "UNRECOGNIZED EC",
                                             ^~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:841:27: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_SP_ALIGN]           = "SP Alignment",
                                             ^~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:812:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = "UNRECOGNIZED EC",
                                             ^~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:842:27: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_FP_EXC32]           = "FP (AArch32)",
                                             ^~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:812:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = "UNRECOGNIZED EC",
                                             ^~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:843:27: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_FP_EXC64]           = "FP (AArch64)",
                                             ^~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:812:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = "UNRECOGNIZED EC",
                                             ^~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:844:25: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_SERROR]             = "SError",
                                             ^~~~~~~~
   arch/arm64/kernel/traps.c:812:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = "UNRECOGNIZED EC",
                                             ^~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:845:29: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_BREAKPT_LOW]        = "Breakpoint (lower EL)",
                                             ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:812:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = "UNRECOGNIZED EC",
                                             ^~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:846:29: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_BREAKPT_CUR]        = "Breakpoint (current EL)",
                                             ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:812:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = "UNRECOGNIZED EC",
                                             ^~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:847:29: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_SOFTSTP_LOW]        = "Software Step (lower EL)",
                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:812:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = "UNRECOGNIZED EC",
                                             ^~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:848:29: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_SOFTSTP_CUR]        = "Software Step (current EL)",
                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:812:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = "UNRECOGNIZED EC",
                                             ^~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:849:29: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_WATCHPT_LOW]        = "Watchpoint (lower EL)",
                                             ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:812:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = "UNRECOGNIZED EC",
                                             ^~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:850:29: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_WATCHPT_CUR]        = "Watchpoint (current EL)",
                                             ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:812:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = "UNRECOGNIZED EC",
                                             ^~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:851:25: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_BKPT32]             = "BKPT (AArch32)",
                                             ^~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:812:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = "UNRECOGNIZED EC",
                                             ^~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:852:27: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_VECTOR32]           = "Vector catch (AArch32)",
                                             ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:812:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = "UNRECOGNIZED EC",
                                             ^~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:853:24: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_BRK64]              = "BRK (AArch64)",
                                             ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:812:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = "UNRECOGNIZED EC",
                                             ^~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:1069:12: warning: no previous prototype for function 'early_brk64' [-Wmissing-prototypes]
   int __init early_brk64(unsigned long addr, unsigned int esr,
              ^
   arch/arm64/kernel/traps.c:1069:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __init early_brk64(unsigned long addr, unsigned int esr,
   ^
   static 
>> arch/arm64/kernel/traps.c:1081:13: warning: no previous prototype for function 'trap_init' [-Wmissing-prototypes]
   void __init trap_init(void)
               ^
   arch/arm64/kernel/traps.c:1081:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init trap_init(void)
   ^
   static 
   43 warnings generated.


vim +/trap_init +1081 arch/arm64/kernel/traps.c

9fb7410f955f7a Dave P Martin   2015-07-24  1080  
60ffc30d565281 Catalin Marinas 2012-03-05 @1081  void __init trap_init(void)

:::::: The code at line 1081 was first introduced by commit
:::::: 60ffc30d5652810dd34ea2eec41504222f5d5791 arm64: Exception handling

:::::: TO: Catalin Marinas <catalin.marinas@arm.com>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

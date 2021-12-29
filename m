Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64EDF480F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 04:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbhL2Ddi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 22:33:38 -0500
Received: from mga17.intel.com ([192.55.52.151]:3163 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233058AbhL2Ddh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 22:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640748817; x=1672284817;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JXLCS/DCys6JGqJ75kjlfcZ1ICrtL2OKIvy4XxfmFYg=;
  b=ReJgkN2Fz/V/g8dnFg5aqSBCsZS5M8/RFlmfT4/K4utaQjb9d9S3LGpb
   wywTTc48Fzpf7Ej/hLJUY1eLD6A8MuEyYYDtGc+Xfk5Nr04pH08XgOGVa
   S61B1szTdDrqO9EH5MgVFn4GykJY3DrE0gHpn5j16rziMX0t+qO3hK4wC
   aFTDGztoyt5QL8k9lz1jkeJqhvsxxEQKUwO1hOKGHl2HdqXoZ6dHuW+Hq
   1GxkAI7BBZyqIqhw+GcVXc5jIS1ckhoBupsgwLLpY3wTApKMKZ0M8vRYB
   YL+PquALeHFBL+TbPHJPloO/vqhu2hOLNb+4MNYjnE3mh/OvEGexAHmSm
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="222127418"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="222127418"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 19:33:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="618921684"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Dec 2021 19:33:35 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2PiZ-0008M2-93; Wed, 29 Dec 2021 03:33:35 +0000
Date:   Wed, 29 Dec 2021 11:33:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [csky-linux:riscv_compat_v2 3/17]
 arch/mips/include/asm/compat.h:68:9: warning: 'F_GETLK64' macro redefined
Message-ID: <202112291128.XgMeZiWI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v2
head:   750f87086bdd630f80b9bc3581bc3f329ef20f53
commit: 838b95dc803e1fba08bd1aca85bb3c40f174548c [3/17] asm-generic: fcntl: compat: Remove duplicate definitions
config: mips-randconfig-r003-20211228 (https://download.01.org/0day-ci/archive/20211229/202112291128.XgMeZiWI-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7171af744543433ac75b232eb7dfdaef7efd4d7a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/c-sky/csky-linux/commit/838b95dc803e1fba08bd1aca85bb3c40f174548c
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v2
        git checkout 838b95dc803e1fba08bd1aca85bb3c40f174548c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   error: include/uapi/asm-generic/fcntl.h: leak CONFIG_COMPAT to user-space
   make[2]: *** [scripts/Makefile.headersinst:63: usr/include/asm-generic/fcntl.h] Error 1
   make[2]: Target '__headers' not remade because of errors.
   make[1]: *** [Makefile:1283: headers] Error 2
   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:22:
>> arch/mips/include/asm/compat.h:68:9: warning: 'F_GETLK64' macro redefined [-Wmacro-redefined]
   #define F_GETLK64       33
           ^
   include/uapi/asm-generic/fcntl.h:121:9: note: previous definition is here
   #define F_GETLK64       12      /*  using 'struct flock64' */
           ^
   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:22:
>> arch/mips/include/asm/compat.h:69:9: warning: 'F_SETLK64' macro redefined [-Wmacro-redefined]
   #define F_SETLK64       34
           ^
   include/uapi/asm-generic/fcntl.h:122:9: note: previous definition is here
   #define F_SETLK64       13
           ^
   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:22:
>> arch/mips/include/asm/compat.h:70:9: warning: 'F_SETLKW64' macro redefined [-Wmacro-redefined]
   #define F_SETLKW64      35
           ^
   include/uapi/asm-generic/fcntl.h:123:9: note: previous definition is here
   #define F_SETLKW64      14
           ^
   arch/mips/kernel/asm-offsets.c:26:6: warning: no previous prototype for function 'output_ptreg_defines' [-Wmissing-prototypes]
   void output_ptreg_defines(void)
        ^
   arch/mips/kernel/asm-offsets.c:26:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void output_ptreg_defines(void)
   ^
   static 
   arch/mips/kernel/asm-offsets.c:78:6: warning: no previous prototype for function 'output_task_defines' [-Wmissing-prototypes]
   void output_task_defines(void)
        ^
   arch/mips/kernel/asm-offsets.c:78:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void output_task_defines(void)
   ^
   static 
   arch/mips/kernel/asm-offsets.c:92:6: warning: no previous prototype for function 'output_thread_info_defines' [-Wmissing-prototypes]
   void output_thread_info_defines(void)
        ^
   arch/mips/kernel/asm-offsets.c:92:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void output_thread_info_defines(void)
   ^
   static 
   arch/mips/kernel/asm-offsets.c:108:6: warning: no previous prototype for function 'output_thread_defines' [-Wmissing-prototypes]
   void output_thread_defines(void)
        ^
   arch/mips/kernel/asm-offsets.c:108:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void output_thread_defines(void)
   ^
   static 
   arch/mips/kernel/asm-offsets.c:179:6: warning: no previous prototype for function 'output_mm_defines' [-Wmissing-prototypes]
   void output_mm_defines(void)
        ^
   arch/mips/kernel/asm-offsets.c:179:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void output_mm_defines(void)
   ^
   static 
   arch/mips/kernel/asm-offsets.c:240:6: warning: no previous prototype for function 'output_sc_defines' [-Wmissing-prototypes]
   void output_sc_defines(void)
        ^
   arch/mips/kernel/asm-offsets.c:240:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void output_sc_defines(void)
   ^
   static 
   arch/mips/kernel/asm-offsets.c:253:6: warning: no previous prototype for function 'output_signal_defined' [-Wmissing-prototypes]
   void output_signal_defined(void)
        ^
   arch/mips/kernel/asm-offsets.c:253:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void output_signal_defined(void)
   ^
   static 
   arch/mips/kernel/asm-offsets.c:292:6: warning: no previous prototype for function 'output_octeon_cop2_state_defines' [-Wmissing-prototypes]
   void output_octeon_cop2_state_defines(void)
        ^
   arch/mips/kernel/asm-offsets.c:292:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void output_octeon_cop2_state_defines(void)
   ^
   static 
   11 warnings generated.
   clang-14: error: unsupported argument '-mfix-cn63xxp1' to option 'Wa,'
   make[2]: *** [scripts/Makefile.build:287: scripts/mod/empty.o] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1196: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/F_GETLK64 +68 arch/mips/include/asm/compat.h

^1da177e4c3f41 include/asm-mips/compat.h Linus Torvalds 2005-04-16  67  
^1da177e4c3f41 include/asm-mips/compat.h Linus Torvalds 2005-04-16 @68  #define F_GETLK64	33
^1da177e4c3f41 include/asm-mips/compat.h Linus Torvalds 2005-04-16 @69  #define F_SETLK64	34
^1da177e4c3f41 include/asm-mips/compat.h Linus Torvalds 2005-04-16 @70  #define F_SETLKW64	35
^1da177e4c3f41 include/asm-mips/compat.h Linus Torvalds 2005-04-16  71  

:::::: The code at line 68 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

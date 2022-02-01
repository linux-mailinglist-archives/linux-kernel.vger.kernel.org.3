Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16474A59B0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbiBAKMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:12:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:13770 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234247AbiBAKMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643710352; x=1675246352;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=proOJEQ6dZ/oQT0A9LNKC/zS5sKnyJsyQKktVCkkAEM=;
  b=ggS7oRoK9rEvk+HRG6eftdQ44IKNvVOxVFl3a6Q4+NTILlddN/wUvcEW
   WFKPCNDFlzAd3yHmXlKOI5kjdtWdGtHn9ra7Zyk2knIZXJ0TMq4w4x0nh
   VjNr3S0ytwe59TvcXm4ruzGyinPvCFlUxKRrFc0Yy99IUrjy0uFTy4Woh
   cIRSGMIHlgBVlg0OJDMQPjgNtVeTPpWR/2E10aP57eol7WBntdQkHr3pf
   xs91OdJuZiAOo6xW/YXtbveaV/kiSgNptw2JQBvcTk01/J/2/W28r0JD3
   /nsTxf/v9VurmuOh63yRjvvWiQk1Iz+ZJQ/EUncaOQmiRvbua4OjHDHoO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247613174"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="247613174"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 02:12:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="676036155"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 Feb 2022 02:12:30 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEq9F-000T67-Nr; Tue, 01 Feb 2022 10:12:29 +0000
Date:   Tue, 1 Feb 2022 18:11:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Axtens <dja@axtens.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: arch/powerpc/kernel/vdso32/gettimeofday.S:72:8: error: unsupported
 directive '.stabs'
Message-ID: <202202011736.oIfH0Ze8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   26291c54e111ff6ba87a164d85d4a4e134b7315c
commit: f5140cab448e4819ca6f158cb4130352f73c92e4 powerpc: check for support for -Wa,-m{power4,any}
date:   6 weeks ago
config: powerpc64-randconfig-r004-20220130 (https://download.01.org/0day-ci/archive/20220201/202202011736.oIfH0Ze8-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc64 cross compiling tool for clang build
        # apt-get install binutils-powerpc64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f5140cab448e4819ca6f158cb4130352f73c92e4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f5140cab448e4819ca6f158cb4130352f73c92e4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   <stdin>:1559:2: warning: syscall futex_waitv not implemented [-W#warnings]
   #warning syscall futex_waitv not implemented
    ^
   1 warning generated.
>> arch/powerpc/kernel/vdso32/gettimeofday.S:72:8: error: unsupported directive '.stabs'
   .stabs "_restgpr_31_x:F-1",36,0,0,_restgpr_31_x; .globl _restgpr_31_x; _restgpr_31_x:
          ^
   arch/powerpc/kernel/vdso32/gettimeofday.S:73:8: error: unsupported directive '.stabs'
   .stabs "_rest32gpr_31_x:F-1",36,0,0,_rest32gpr_31_x; .globl _rest32gpr_31_x; _rest32gpr_31_x:
          ^
   make[2]: *** [arch/powerpc/kernel/vdso32/Makefile:55: arch/powerpc/kernel/vdso32/gettimeofday.o] Error 1
   make[2]: Target 'include/generated/vdso32-offsets.h' not remade because of errors.
   make[1]: *** [arch/powerpc/Makefile:423: vdso_prepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +72 arch/powerpc/kernel/vdso32/gettimeofday.S

08c18b63d9656e Christophe Leroy 2021-03-09  68  
08c18b63d9656e Christophe Leroy 2021-03-09  69  /* Routines for restoring integer registers, called by the compiler.  */
08c18b63d9656e Christophe Leroy 2021-03-09  70  /* Called with r11 pointing to the stack header word of the caller of the */
08c18b63d9656e Christophe Leroy 2021-03-09  71  /* function, just beyond the end of the integer restore area.  */
08c18b63d9656e Christophe Leroy 2021-03-09 @72  _GLOBAL(_restgpr_31_x)

:::::: The code at line 72 was first introduced by commit
:::::: 08c18b63d9656e0389087d1956d2b37fd7019172 powerpc/vdso32: Add missing _restgpr_31_x to fix build failure

:::::: TO: Christophe Leroy <christophe.leroy@csgroup.eu>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

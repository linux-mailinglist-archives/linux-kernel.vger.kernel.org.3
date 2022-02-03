Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A6A4A86B6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbiBCOii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:38:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:20395 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbiBCOig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643899116; x=1675435116;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6occSEmEjfPwgizjiWjKtfv0+RPp90I8rXYOrwiIbWU=;
  b=KR9rodA2kz6xbNc82YrAeyayLNg91TXFw4XSF0OpaHasxa2F+9A7FpK3
   KD8frpnAbwz1eNCQ+FzCyFu8e0qdS+zp99fyBslxjDt21dDfi1YyVIs7p
   nnNa/Qqg9ZXMXUNwxaydGhWmr5dn6Wa6CEohcsWDho0mtSUYzglFewVGQ
   vDE0mw03kutW+4yVTXen6SRdGgS0lMUfiLIUtHf8xA5qdjlLBHxPRRBll
   a28QcsppC96IMmkYzqf0+0S0dwi8Scs6+QbN7TSZ9II1oHcyRol8WFIBz
   oB09Bht5jI3jAGW/+VtEC6C1c5Q54Xa2xCMqAnWrEc3spna7AD4t1yIM6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="272650273"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="272650273"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 06:38:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="483255743"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Feb 2022 06:38:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFdFY-000WF4-3t; Thu, 03 Feb 2022 14:38:16 +0000
Date:   Thu, 3 Feb 2022 22:37:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-parisc:5.17-vdso-mini-3 1/1]
 arch/parisc/kernel/vdso32/restart_syscall.S:16: Error: bad or irreducible
 absolute expression
Message-ID: <202202032200.IMpqlhlW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git 5.17-vdso-mini-3
head:   62c208e2c93066ee050644384bb12ca1d0b2bdb1
commit: 62c208e2c93066ee050644384bb12ca1d0b2bdb1 [1/1] parisc: Add initial vDSO support
config: parisc-generic-64bit_defconfig (https://download.01.org/0day-ci/archive/20220203/202202032200.IMpqlhlW-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?id=62c208e2c93066ee050644384bb12ca1d0b2bdb1
        git remote add deller-parisc https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
        git fetch --no-tags deller-parisc 5.17-vdso-mini-3
        git checkout 62c208e2c93066ee050644384bb12ca1d0b2bdb1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   arch/parisc/kernel/vdso64/Makefile:30: FORCE prerequisite is missing
   arch/parisc/kernel/vdso32/restart_syscall.S: Assembler messages:
>> arch/parisc/kernel/vdso32/restart_syscall.S:16: Error: bad or irreducible absolute expression
>> arch/parisc/kernel/vdso32/restart_syscall.S:16: Error: junk at end of line, first unrecognized character is `:'
>> arch/parisc/kernel/vdso32/restart_syscall.S:26: Error: no such instruction: `ldw 0(%sp),%r31'
>> arch/parisc/kernel/vdso32/restart_syscall.S:29: Error: no such instruction: `be 0x100(%sr2,%r0)'
>> arch/parisc/kernel/vdso32/restart_syscall.S:30: Error: no such instruction: `ldi 0,%r20'
>> arch/parisc/kernel/vdso32/restart_syscall.S:32: Error: .cfi_endproc without corresponding .cfi_startproc
   arch/parisc/kernel/vdso32/sigtramp.S: Assembler messages:
>> arch/parisc/kernel/vdso32/sigtramp.S:39: Error: unknown pseudo-op: `.proc'
>> arch/parisc/kernel/vdso32/sigtramp.S:40: Error: unknown pseudo-op: `.callinfo'
>> arch/parisc/kernel/vdso32/sigtramp.S:41: Error: unknown pseudo-op: `.entry'
>> arch/parisc/kernel/vdso32/sigtramp.S:44: Error: no such instruction: `ldi 0,%r25'
>> arch/parisc/kernel/vdso32/sigtramp.S:45: Error: no such instruction: `ldi 173,%r20'
>> arch/parisc/kernel/vdso32/sigtramp.S:46: Error: no such instruction: `ble 0x100(%sr2,%r0)'
   arch/parisc/kernel/vdso32/sigtramp.S:49: Error: no such instruction: `ldi 1,%r25'
   arch/parisc/kernel/vdso32/sigtramp.S:50: Error: no such instruction: `ldi 173,%r20'
   arch/parisc/kernel/vdso32/sigtramp.S:51: Error: no such instruction: `ble 0x100(%sr2,%r0)'
>> arch/parisc/kernel/vdso32/sigtramp.S:54: Error: unknown pseudo-op: `.exit'
>> arch/parisc/kernel/vdso32/sigtramp.S:55: Error: unknown pseudo-op: `.procend'
>> arch/parisc/kernel/vdso32/sigtramp.S:76: Error: unknown pseudo-op: `.stringz'
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34: arch/parisc/kernel/vdso32/restart_syscall.o] Error 1
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34: arch/parisc/kernel/vdso32/sigtramp.o] Error 1
   make[2]: Target 'include/generated/vdso32-offsets.h' not remade because of errors.
   make[1]: *** [arch/parisc/Makefile:188: vdso_prepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +16 arch/parisc/kernel/vdso32/restart_syscall.S

    13	
    14		.text
    15	
  > 16	ENTRY_CFI(__kernel_restart_syscall)
    17		/*
    18		 * Setup a trampoline to restart the syscall
    19		 * with __NR_restart_syscall
    20		 */
    21	
    22		/* load return pointer */
    23	#if defined(__VDSO64__)
    24		ldd	0(%sp), %r31
    25	#elif defined(__VDSO32__)
  > 26		ldw	0(%sp), %r31
    27	#endif
    28	
  > 29		be	0x100(%sr2, %r0)
  > 30		ldi	__NR_restart_syscall, %r20
    31	
  > 32	ENDPROC_CFI(__kernel_restart_syscall)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

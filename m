Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3499F48E2EE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 04:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbiANDU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 22:20:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:55751 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238998AbiANDUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 22:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642130423; x=1673666423;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=sZXhwXvSJxX1HO7SKL04S5qqjxGbKA62SXufmOeWVoo=;
  b=CMlmYu/gO4UwLDpTjFpOl+k++x2XayUBBsz1712Zh78vLjm4C5ZYL8DR
   CA8D+ddHEMLLeEGrXUUadKgTEx8xJTM/AxYJV5d9Do933sDKxT+C2fCHm
   d9dxfrti4FyC9ueyJm6hyegFxeXGC/lZhvvdePnntZL9rjOy/95OxVuG6
   Z0SixkuOWVCXSyHWnwUaxfPgycr6vPDhgDyxp/deyf8km29NBhhKZ6fjI
   bpWRxC6qLAy/JoowusHVE/GFOxBBhL9HMGerpObJ2QrVSwVrjVaZpQA7P
   L/uYnqcAZXXUc0FhDoxFdNDnbO18OFG+DrwkQrzZ91ISBy+3WVAhAa/iF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="241736298"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="241736298"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 19:20:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="620836647"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jan 2022 19:20:22 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8D8X-00081z-LO; Fri, 14 Jan 2022 03:20:21 +0000
Date:   Fri, 14 Jan 2022 11:19:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-parisc:5.16-vdso-6 3/3]
 arch/parisc/kernel/vdso32/sigtramp.S:25: Error: unknown pseudo-op: `.proc'
Message-ID: <202201141151.powsGgZN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git 5.16-vdso-6
head:   02c272b17a2b655236f64f3ccb4931e3cb99b29c
commit: 02c272b17a2b655236f64f3ccb4931e3cb99b29c [3/3] p2-vdso patch by Dave Anglin
config: parisc-randconfig-r013-20220113 (https://download.01.org/0day-ci/archive/20220114/202201141151.powsGgZN-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?id=02c272b17a2b655236f64f3ccb4931e3cb99b29c
        git remote add deller-parisc https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
        git fetch --no-tags deller-parisc 5.16-vdso-6
        git checkout 02c272b17a2b655236f64f3ccb4931e3cb99b29c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/parisc/kernel/vdso64/Makefile:30: FORCE prerequisite is missing
   arch/parisc/kernel/vdso32/restart_syscall.S: Assembler messages:
   arch/parisc/kernel/vdso32/restart_syscall.S:15: Error: bad or irreducible absolute expression
   arch/parisc/kernel/vdso32/restart_syscall.S:15: Error: junk at end of line, first unrecognized character is `:'
   arch/parisc/kernel/vdso32/restart_syscall.S:25: Error: no such instruction: `ldw 0(%sp),%r31'
   arch/parisc/kernel/vdso32/restart_syscall.S:28: Error: no such instruction: `be 0x100(%sr2,%r0)'
   arch/parisc/kernel/vdso32/restart_syscall.S:29: Error: no such instruction: `ldi 0,%r20'
   arch/parisc/kernel/vdso32/restart_syscall.S:31: Error: .cfi_endproc without corresponding .cfi_startproc
   gcc: error: unrecognized command-line option '-mno-space-regs'
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:36: arch/parisc/kernel/vdso32/restart_syscall.o] Error 1
   gcc: error: unrecognized command-line option '-mdisable-fpregs'
   arch/parisc/kernel/vdso32/sigtramp.S: Assembler messages:
>> arch/parisc/kernel/vdso32/sigtramp.S:25: Error: unknown pseudo-op: `.proc'
>> arch/parisc/kernel/vdso32/sigtramp.S:26: Error: unknown pseudo-op: `.callinfo'
>> arch/parisc/kernel/vdso32/sigtramp.S:27: Error: unknown pseudo-op: `.entry'
   arch/parisc/kernel/vdso32/sigtramp.S:30: Error: no such instruction: `ldi 0,%r25'
>> arch/parisc/kernel/vdso32/sigtramp.S:31: Error: no such instruction: `ble 0x100(%sr2,%r0)'
   arch/parisc/kernel/vdso32/datapage.S: Assembler messages:
   arch/parisc/kernel/vdso32/datapage.S:18: Error: bad or irreducible absolute expression
   arch/parisc/kernel/vdso32/datapage.S:18: Error: junk at end of line, first unrecognized character is `:'
   arch/parisc/kernel/vdso32/datapage.S:23: Error: no such instruction: `bl 1f,%r1'
   arch/parisc/kernel/vdso32/datapage.S:24: Error: no such instruction: `depi 0,31,12,%r1'
   arch/parisc/kernel/vdso32/datapage.S:25: Error: no such instruction: `bv %r0(%r2)'
   arch/parisc/kernel/vdso32/datapage.S:26: Error: no such instruction: `ldw 0(%r1),%r28'
   arch/parisc/kernel/vdso32/datapage.S:28: Error: .cfi_endproc without corresponding .cfi_startproc
   arch/parisc/kernel/vdso32/sigtramp.S:32: Error: no such instruction: `ldi 173,%r20'
   arch/parisc/kernel/vdso32/sigtramp.S:34: Error: no such instruction: `ldi 1,%r25'
   arch/parisc/kernel/vdso32/sigtramp.S:35: Error: no such instruction: `ble 0x100(%sr2,%r0)'
   arch/parisc/kernel/vdso32/sigtramp.S:36: Error: no such instruction: `ldi 173,%r20'
>> arch/parisc/kernel/vdso32/sigtramp.S:38: Error: unknown pseudo-op: `.exit'
>> arch/parisc/kernel/vdso32/sigtramp.S:39: Error: unknown pseudo-op: `.procend'
>> arch/parisc/kernel/vdso32/sigtramp.S:85: Error: unknown pseudo-op: `.stringz'
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:36: arch/parisc/kernel/vdso32/sigtramp.o] Error 1
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:36: arch/parisc/kernel/vdso32/datapage.o] Error 1
   gcc: error: unrecognized command-line option '-mschedule=8000'
   gcc: error: unrecognized command-line option '-fzero-call-used-regs=used-gpr'
   gcc: error: unrecognized command-line option '-mno-fast-indirect-calls'; did you mean '-mno-force-indirect-call'?
   gcc: error: unrecognized command-line option '-mno-long-calls'
   gcc: error: unrecognized command-line option '-mlong-calls'
   gcc: error: unrecognized command-line option '-mno-fast-indirect-calls'; did you mean '-mno-force-indirect-call'?
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:39: arch/parisc/kernel/vdso32/vdso32_generic.o] Error 1
   make[2]: Target 'include/generated/vdso32-offsets.h' not remade because of errors.
   make[1]: *** [arch/parisc/Makefile:188: vdso_prepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +25 arch/parisc/kernel/vdso32/sigtramp.S

    11	
    12		.text
    13	
    14	/* The nop here is a hack.  The dwarf2 unwind routines subtract 1 from
    15	   the return address to get an address in the middle of the presumed
    16	   call instruction.  Since we don't have a call here, we artifically
    17	   extend the range covered by the unwind info by adding a nop before
    18	   the real start.  */
    19		nop
    20	
    21	// ENTRY_CFI(__kernel_sigtramp_rt)
    22		.globl __kernel_sigtramp_rt		// 32/64 anhängen
    23		.type __kernel_sigtramp_rt, @function
    24	__kernel_sigtramp_rt:
  > 25		.proc
  > 26		.callinfo NO_CALLS
  > 27		.entry
    28	
    29	.Lsigrt_start = . - 4
    30	0:	ldi	0, %r25			/* (in_syscall=0) */
  > 31		ble  0x100(%sr2, %r0)
    32		ldi  __NR_rt_sigreturn, %r20
    33	
    34	1:	ldi	1, %r25			/* (in_syscall=1) */
    35		ble  0x100(%sr2, %r0)
    36		ldi  __NR_rt_sigreturn, %r20
    37	.Lsigrt_end:
  > 38		.exit
  > 39		.procend
    40		.size __kernel_sigtramp_rt,.-__kernel_sigtramp_rt
    41	
    42	// ENDPROC_CFI(__kernel_sigtramp_rt)
    43	
    44		.section .eh_frame,"a",@progbits
    45	
    46	/* This is where the mcontext_t struct can be found on the stack.  */
    47	#define PTREGS -0x2a0
    48	
    49	/* Size of regs.  */
    50	#define RSIZE 4
    51	
    52	/* Register sp can be found at offset 0x7c in mcontext_t structure. */
    53		.macro cfa_save
    54		.byte 0x0f			/* DW_CFA_def_cfa_expression */
    55		.uleb128 9f - 1f		/*   length */
    56	1:
    57		.byte 0x8e			/*     DW_OP_breg30 */
    58		.sleb128 PTREGS
    59		.byte 0x23			/*     DW_OP_plus_uconst */
    60		.uleb128 0x7c
    61		.byte 0x06			/*     DW_OP_deref */
    62	9:
    63		.endm
    64	
    65	/* Register REGNO can be found at offset OFS of the mcontext_t structure. */
    66		.macro rsave regno,ofs
    67		.byte 0x10		/* DW_CFA_expression */
    68		.uleb128 \regno;	/*   regno */
    69		.uleb128 9f - 1f	/*   length */
    70	1:
    71		.byte 0x8e		/*     DW_OP_breg30 */
    72		.sleb128 PTREGS
    73		.ifne \ofs
    74		.byte 0x23		/*     DW_OP_plus_uconst */
    75		.uleb128 \ofs
    76		.endif
    77	9:
    78		.endm
    79	
    80	.Lcie:
    81		.long .Lcie_end - .Lcie_start
    82	.Lcie_start:
    83		.long 0			/* CIE ID */
    84		.byte 1			/* Version number */
  > 85		.stringz "zRS"		/* NUL-terminated augmentation string */

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

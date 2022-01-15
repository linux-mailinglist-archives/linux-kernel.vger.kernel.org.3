Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCAD48F544
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 06:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiAOFtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 00:49:49 -0500
Received: from mga12.intel.com ([192.55.52.136]:41396 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231184AbiAOFtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 00:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642225787; x=1673761787;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=X+uNjLrQqrG864MPsCgCScuvZzqgftg/0GyKl9rQwAQ=;
  b=hYl036jNzm8nWfL2x2qZKnxjaXFdqs8LbcG9PXwPbPbvv1Q4FrZUQf4U
   KprPbfJFolRI4S7BGbKETyz9oLGdXKm4vvWeo5buM0eKC5zg0tGZS+fQC
   4nmCoDeeiMPQokAB/BAUxwEtlzbSys3GDkNT8LcnnRwwADlCQkYUFeUI6
   5aiaqqBYAe+59ETNfhwOt5bQ/HRYiP7b2u1J1rLbzLuxBs6cRL+ea5DM7
   CGgEc3EI23UttwLZukp8dytm5A0af1A+OJjUVLcpF+/e9/yCYpdyWddGR
   FbO7br1zsqUuyYXB0yPKOTgVQtChIiKt87rLviS6m9TkZaBkOuhVetDC9
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="224365327"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="224365327"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 21:49:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="530599028"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Jan 2022 21:49:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8bwe-0009Qh-SS; Sat, 15 Jan 2022 05:49:44 +0000
Date:   Sat, 15 Jan 2022 13:49:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-parisc:5.16-vdso-6 3/3]
 arch/parisc/kernel/vdso32/sigtramp.S:26: Error: unknown pseudo-op: `.proc'
Message-ID: <202201151353.1cReL9cI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git 5.16-vdso-6
head:   b7e375e2ced653c4615242d90232d4a0238dcac1
commit: b7e375e2ced653c4615242d90232d4a0238dcac1 [3/3] p3-vdso patch by Dave Anglin
config: parisc-randconfig-r005-20220114 (https://download.01.org/0day-ci/archive/20220115/202201151353.1cReL9cI-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?id=b7e375e2ced653c4615242d90232d4a0238dcac1
        git remote add deller-parisc https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
        git fetch --no-tags deller-parisc 5.16-vdso-6
        git checkout b7e375e2ced653c4615242d90232d4a0238dcac1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/parisc/kernel/vdso64/Makefile:30: FORCE prerequisite is missing
   gcc: error: unrecognized command-line option '-mno-space-regs'
   gcc: error: unrecognized command-line option '-mdisable-fpregs'
   gcc: error: unrecognized command-line option '-mschedule=8000'
   arch/parisc/kernel/vdso32/sigtramp.S: Assembler messages:
>> arch/parisc/kernel/vdso32/sigtramp.S:26: Error: unknown pseudo-op: `.proc'
>> arch/parisc/kernel/vdso32/sigtramp.S:27: Error: unknown pseudo-op: `.callinfo'
>> arch/parisc/kernel/vdso32/sigtramp.S:28: Error: unknown pseudo-op: `.entry'
   arch/parisc/kernel/vdso32/sigtramp.S:31: Error: no such instruction: `ldi 0,%r25'
>> arch/parisc/kernel/vdso32/sigtramp.S:32: Error: no such instruction: `ble 0x100(%sr2,%r0)'
   arch/parisc/kernel/vdso32/sigtramp.S:33: Error: no such instruction: `ldi 173,%r20'
   arch/parisc/kernel/vdso32/sigtramp.S:35: Error: no such instruction: `ldi 1,%r25'
   arch/parisc/kernel/vdso32/sigtramp.S:36: Error: no such instruction: `ble 0x100(%sr2,%r0)'
   arch/parisc/kernel/vdso32/sigtramp.S:37: Error: no such instruction: `ldi 173,%r20'
>> arch/parisc/kernel/vdso32/sigtramp.S:39: Error: unknown pseudo-op: `.exit'
>> arch/parisc/kernel/vdso32/sigtramp.S:40: Error: unknown pseudo-op: `.procend'
>> arch/parisc/kernel/vdso32/sigtramp.S:87: Error: unknown pseudo-op: `.stringz'
   arch/parisc/kernel/vdso32/restart_syscall.S: Assembler messages:
   arch/parisc/kernel/vdso32/restart_syscall.S:15: Error: bad or irreducible absolute expression
   arch/parisc/kernel/vdso32/restart_syscall.S:15: Error: junk at end of line, first unrecognized character is `:'
   arch/parisc/kernel/vdso32/restart_syscall.S:25: Error: no such instruction: `ldw 0(%sp),%r31'
   arch/parisc/kernel/vdso32/restart_syscall.S:28: Error: no such instruction: `be 0x100(%sr2,%r0)'
   arch/parisc/kernel/vdso32/restart_syscall.S:29: Error: no such instruction: `ldi 0,%r20'
   arch/parisc/kernel/vdso32/restart_syscall.S:31: Error: .cfi_endproc without corresponding .cfi_startproc
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:36: arch/parisc/kernel/vdso32/sigtramp.o] Error 1
   arch/parisc/kernel/vdso32/datapage.S: Assembler messages:
   arch/parisc/kernel/vdso32/datapage.S:18: Error: bad or irreducible absolute expression
   arch/parisc/kernel/vdso32/datapage.S:18: Error: junk at end of line, first unrecognized character is `:'
   arch/parisc/kernel/vdso32/datapage.S:23: Error: no such instruction: `bl 1f,%r1'
   arch/parisc/kernel/vdso32/datapage.S:24: Error: no such instruction: `depi 0,31,12,%r1'
   arch/parisc/kernel/vdso32/datapage.S:25: Error: no such instruction: `bv %r0(%r2)'
   arch/parisc/kernel/vdso32/datapage.S:26: Error: no such instruction: `ldw 0(%r1),%r28'
   arch/parisc/kernel/vdso32/datapage.S:28: Error: .cfi_endproc without corresponding .cfi_startproc
   gcc: error: unrecognized command-line option '-mno-fast-indirect-calls'; did you mean '-mno-force-indirect-call'?
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:36: arch/parisc/kernel/vdso32/restart_syscall.o] Error 1
   gcc: error: unrecognized command-line option '-mno-long-calls'
   gcc: error: unrecognized command-line option '-mlong-calls'
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:36: arch/parisc/kernel/vdso32/datapage.o] Error 1
   gcc: error: unrecognized command-line option '-mno-fast-indirect-calls'; did you mean '-mno-force-indirect-call'?
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:39: arch/parisc/kernel/vdso32/vdso32_generic.o] Error 1
   make[2]: Target 'include/generated/vdso32-offsets.h' not remade because of errors.
   make[1]: *** [arch/parisc/Makefile:188: vdso_prepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +26 arch/parisc/kernel/vdso32/sigtramp.S

    12	
    13		.text
    14	
    15	/* The nop here is a hack.  The dwarf2 unwind routines subtract 1 from
    16	   the return address to get an address in the middle of the presumed
    17	   call instruction.  Since we don't have a call here, we artifically
    18	   extend the range covered by the unwind info by adding a nop before
    19	   the real start.  */
    20		nop
    21	
    22	// ENTRY_CFI(__kernel_sigtramp_rt)
    23		.globl __kernel_sigtramp_rt		// 32/64 anhängen
    24		.type __kernel_sigtramp_rt, @function
    25	__kernel_sigtramp_rt:
  > 26		.proc
  > 27		.callinfo NO_CALLS
  > 28		.entry
    29	
    30	.Lsigrt_start = . - 4
    31	0:	ldi	0, %r25			/* (in_syscall=0) */
  > 32		ble  0x100(%sr2, %r0)
    33		ldi  __NR_rt_sigreturn, %r20
    34	
    35	1:	ldi	1, %r25			/* (in_syscall=1) */
    36		ble  0x100(%sr2, %r0)
    37		ldi  __NR_rt_sigreturn, %r20
    38	.Lsigrt_end:
  > 39		.exit
  > 40		.procend
    41		.size __kernel_sigtramp_rt,.-__kernel_sigtramp_rt
    42	
    43	// ENDPROC_CFI(__kernel_sigtramp_rt)
    44	
    45		.section .eh_frame,"a",@progbits
    46	
    47	/* This is where the mcontext_t struct can be found on the stack.  */
    48	// #define PTREGS -0x2a0			/* 32-bit process offset */
    49	#define PTREGS CONTEXT_REGS32		/* 32-bit process offset 672 */
    50	
    51	/* Size of regs.  */
    52	#define RSIZE 4
    53	
    54	/* Register sp can be found at offset 0x7c in mcontext_t structure. */
    55		.macro cfa_save
    56		.byte 0x0f			/* DW_CFA_def_cfa_expression */
    57		.uleb128 9f - 1f		/*   length */
    58	1:
    59		.byte 0x8e			/*     DW_OP_breg30 */
    60		.sleb128 PTREGS
    61		.byte 0x23			/*     DW_OP_plus_uconst */
    62		.uleb128 0x7c
    63		.byte 0x06			/*     DW_OP_deref */
    64	9:
    65		.endm
    66	
    67	/* Register REGNO can be found at offset OFS of the mcontext_t structure. */
    68		.macro rsave regno,ofs
    69		.byte 0x10		/* DW_CFA_expression */
    70		.uleb128 \regno;	/*   regno */
    71		.uleb128 9f - 1f	/*   length */
    72	1:
    73		.byte 0x8e		/*     DW_OP_breg30 */
    74		.sleb128 PTREGS
    75		.ifne \ofs
    76		.byte 0x23		/*     DW_OP_plus_uconst */
    77		.uleb128 \ofs
    78		.endif
    79	9:
    80		.endm
    81	
    82	.Lcie:
    83		.long .Lcie_end - .Lcie_start
    84	.Lcie_start:
    85		.long 0			/* CIE ID */
    86		.byte 1			/* Version number */
  > 87		.stringz "zRS"		/* NUL-terminated augmentation string */

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DCD4A2B24
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 03:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352129AbiA2CA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 21:00:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:40945 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344799AbiA2CAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 21:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643421617; x=1674957617;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4zvdgBYh2ls3zOVxz7T83aFv97Nbf8U05HBx7PeqCJo=;
  b=XhCr1B+CL0jpjZ/fqY4btzX6d5CALxdLwJJVsd9vJKBwOjWN1ZdBPUXT
   x95JEFeIxlCJM2h+v1aR0LwNVvIEcbCNdR8CG3/N/oari+Z5ObrXufwD8
   lTOIk5D1QPEibQWhr9ihsz+ygQ0Dgw31210taRzB4VXUFyxNGvQDbRIJW
   b60QNOkAlxDtvHb0TH9PsZFLm59nGP4G9etGk2kd9AXSqfdFTSrok2xtY
   CbPVlln6Jz7+QvAOTH9Or1Il7RM9DsqieSdpMRAnAr9GuxhFDgUm2QNMN
   vSjdTJGj6LAYscZbiq0NCRahFOjPfHUcocK4uYTlGPQI/bujVs1kHhHgm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="246071391"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="246071391"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 18:00:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="478470650"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Jan 2022 18:00:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDd2F-000Od1-Ee; Sat, 29 Jan 2022 02:00:15 +0000
Date:   Sat, 29 Jan 2022 10:00:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-parisc:5.17-vdso-mini-3 1/1]
 arch/parisc/kernel/vdso32/sigtramp.S:39: Error: unknown pseudo-op: `.proc'
Message-ID: <202201290925.4WPmV6eS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git 5.17-vdso-mini-3
head:   8d7e3770fb1fb6c01147f8ebf2914cd2037fac16
commit: 8d7e3770fb1fb6c01147f8ebf2914cd2037fac16 [1/1] parisc: Add vDSO support
config: parisc-generic-64bit_defconfig (https://download.01.org/0day-ci/archive/20220129/202201290925.4WPmV6eS-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?id=8d7e3770fb1fb6c01147f8ebf2914cd2037fac16
        git remote add deller-parisc https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
        git fetch --no-tags deller-parisc 5.17-vdso-mini-3
        git checkout 8d7e3770fb1fb6c01147f8ebf2914cd2037fac16
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/parisc/kernel/vdso64/Makefile:30: FORCE prerequisite is missing
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
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34: arch/parisc/kernel/vdso32/sigtramp.o] Error 1
   arch/parisc/kernel/vdso32/restart_syscall.S: Assembler messages:
>> arch/parisc/kernel/vdso32/restart_syscall.S:16: Error: bad or irreducible absolute expression
>> arch/parisc/kernel/vdso32/restart_syscall.S:16: Error: junk at end of line, first unrecognized character is `:'
>> arch/parisc/kernel/vdso32/restart_syscall.S:26: Error: no such instruction: `ldw 0(%sp),%r31'
>> arch/parisc/kernel/vdso32/restart_syscall.S:29: Error: no such instruction: `be 0x100(%sr2,%r0)'
>> arch/parisc/kernel/vdso32/restart_syscall.S:30: Error: no such instruction: `ldi 0,%r20'
>> arch/parisc/kernel/vdso32/restart_syscall.S:32: Error: .cfi_endproc without corresponding .cfi_startproc
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34: arch/parisc/kernel/vdso32/restart_syscall.o] Error 1
   make[2]: Target 'include/generated/vdso32-offsets.h' not remade because of errors.
   make[1]: *** [arch/parisc/Makefile:186: vdso_prepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +39 arch/parisc/kernel/vdso32/sigtramp.S

    12	
    13		.text
    14	
    15	/* Gdb expects the trampoline is on the stack and the pc is offset from
    16	   a 64-byte boundary by 0, 4 or 5 instructions. Since the vdso trampoline
    17	   is not on the stack, we need a new variant with different offsets and
    18	   data to tell gdb where to find the signal context on the stack.
    19	
    20	   Here we put the offset to the context data at the start of the trampoline
    21	   region and offset the first trampoline by 2 instructions. Please do
    22	   not change the trampoline as the code in gdb depends on the following
    23	   instruction sequence exactly.
    24	 */
    25		.align 64
    26		.word SIGFRAME_CONTEXT_REGS32
    27	
    28	/* The nop here is a hack.  The dwarf2 unwind routines subtract 1 from
    29	   the return address to get an address in the middle of the presumed
    30	   call instruction.  Since we don't have a call here, we artifically
    31	   extend the range covered by the unwind info by adding a nop before
    32	   the real start.
    33	 */
    34		nop
    35	
    36		.globl __kernel_sigtramp_rt
    37		.type __kernel_sigtramp_rt, @function
    38	__kernel_sigtramp_rt:
  > 39		.proc
  > 40		.callinfo FRAME=ASM_SIGFRAME_SIZE32,CALLS,SAVE_RP
  > 41		.entry
    42	
    43	.Lsigrt_start = . - 4
  > 44	0:	ldi	0, %r25			/* (in_syscall=0) */
  > 45		ldi  __NR_rt_sigreturn, %r20
  > 46		ble  0x100(%sr2, %r0)
    47		nop
    48	
    49	1:	ldi	1, %r25			/* (in_syscall=1) */
    50		ldi  __NR_rt_sigreturn, %r20
    51		ble  0x100(%sr2, %r0)
    52		nop
    53	.Lsigrt_end:
  > 54		.exit
  > 55		.procend
    56		.size __kernel_sigtramp_rt,.-__kernel_sigtramp_rt
    57	
    58	
    59		.section .eh_frame,"a",@progbits
    60	
    61	/* This is where the mcontext_t struct can be found on the stack.  */
    62	#define PTREGS SIGFRAME_CONTEXT_REGS32	/* 32-bit process offset is -672 */
    63	
    64	/* Register REGNO can be found at offset OFS of the mcontext_t structure. */
    65		.macro rsave regno,ofs
    66		.byte 0x05		/* DW_CFA_offset_extended */
    67		.uleb128 \regno;	/*   regno */
    68		.uleb128 \ofs		/*   factored offset */
    69		.endm
    70	
    71	.Lcie:
    72		.long .Lcie_end - .Lcie_start
    73	.Lcie_start:
    74		.long 0			/* CIE ID */
    75		.byte 1			/* Version number */
  > 76		.stringz "zRS"		/* NUL-terminated augmentation string */

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

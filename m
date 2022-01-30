Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA6B4A34BE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 07:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346407AbiA3GyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 01:54:06 -0500
Received: from mga03.intel.com ([134.134.136.65]:7724 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240619AbiA3GyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 01:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643525644; x=1675061644;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3ywJ765V9r0/DHraZcptvRpGs4Q7AVr6oQmCawdh+ik=;
  b=IdQRJICCfdCPEIXxKaYrJ9P4ZqZio7mlZpBRyKhifEtcVlOeJti2vRDm
   ChNFC6qJhav5NokevU8Rba3Hegd/bgdJs8BjRoWULPcYAlNc0VIhTM/NK
   6Bk9v2VRt+OTy7pDjvNafvPv8esciY0W2Q+3x/WuwVG5XE5yUKe7F6oNX
   w3assvSnogPZZxbC+TXeNHEwmILcN8kBBIjimhr/7k8mAlX/qF/mN2RZ1
   rboZZOmot1DaFcuuEC3Cg8tyL8UaIygDqahMx82D90dRSQGMNAJh3KRE7
   9gYmqADYZwW99Fy+E6sOwOKn9N/U05DDNQ87IjYAKoci7IMasbk4B3YHS
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="247273285"
X-IronPort-AV: E=Sophos;i="5.88,328,1635231600"; 
   d="scan'208";a="247273285"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 22:54:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,328,1635231600"; 
   d="scan'208";a="496540215"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.171.114]) ([10.249.171.114])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 22:54:01 -0800
Subject: Re: [kbuild-all] Re: [deller-parisc:5.17-vdso-mini-3 1/1]
 arch/parisc/kernel/vdso32/sigtramp.S:39: Error: unknown pseudo-op: `.proc'
To:     Helge Deller <deller@gmx.de>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        John David Anglin <dave.anglin@bell.net>
References: <202201290925.4WPmV6eS-lkp@intel.com>
 <f28b0c22-af83-31bf-8416-e896783fc105@gmx.de>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <5201be65-84af-46ee-9398-8b79a198a63b@intel.com>
Date:   Sun, 30 Jan 2022 14:53:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <f28b0c22-af83-31bf-8416-e896783fc105@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/2022 1:50 AM, Helge Deller wrote:
> On 1/29/22 03:00, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git 5.17-vdso-mini-3
>> head:   8d7e3770fb1fb6c01147f8ebf2914cd2037fac16
>> commit: 8d7e3770fb1fb6c01147f8ebf2914cd2037fac16 [1/1] parisc: Add vDSO support
>> config: parisc-generic-64bit_defconfig (https://download.01.org/0day-ci/archive/20220129/202201290925.4WPmV6eS-lkp@intel.com/config)
>> compiler: hppa64-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?id=8d7e3770fb1fb6c01147f8ebf2914cd2037fac16
>>          git remote add deller-parisc https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
>>          git fetch --no-tags deller-parisc 5.17-vdso-mini-3
>>          git checkout 8d7e3770fb1fb6c01147f8ebf2914cd2037fac16
>>          # save the config file to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc prepare
> 
> I'm somewhat confused by those errors.
> 
> There are two changes which happened in the parisc port:
> 
> 1.) If you want to build a 64bit kernel, you now need "ARCH=parisc64". Before "ARCH=parisc" was sufficient,
> but now ARCH=parisc64 builds 64bit kernel, and ARCH=parisc builds the 32bit kernel.

Hi Helge,

Thanks for the explanation, we'll update to use ARCH=parisc64 for 64bit 
kernel.

> 
> 2.) The patch which is being complained about here is, that it adds an initial vDSO, which
> includes builds the 64- and 32-bit vDSO in the same build.
> So, on a 64bit kernel build (which seems to happen here), the 32-bit gcc-11 compiler needs to be
> installed as well in order to be able to build the 32-bit "compat" vDSO.
> Maybe the errors here are happening, because the 32bit hppa cross compiler is missing?

I tried the below command, the error still exists, is there anything wrong?

$make W=1 --keep-going CROSS_COMPILE=hppa64-linux- -j32 O=./build_dir 
ARCH=parisc64 prepare
...
Assembler messages:
../arch/parisc/kernel/vdso32/sigtramp.S:39: Error: unknown pseudo-op: 
`.proc'
../arch/parisc/kernel/vdso32/restart_syscall.S:16: Error: bad or 
irreducible absolute expression
../arch/parisc/kernel/vdso32/sigtramp.S:40: Error: unknown pseudo-op: 
`.callinfo'
../arch/parisc/kernel/vdso32/restart_syscall.S:16: Error: junk at end of 
line, first unrecognized character is `:'
../arch/parisc/kernel/vdso32/sigtramp.S:41: Error: unknown pseudo-op: 
`.entry'
../arch/parisc/kernel/vdso32/restart_syscall.S:26: Error: no such 
instruction: `ldw 0(%sp),%r31'
../arch/parisc/kernel/vdso32/restart_syscall.S:29: Error: no such 
instruction: `be 0x100(%sr2,%r0)'
../arch/parisc/kernel/vdso32/sigtramp.S:44: Error: no such instruction: 
`ldi 0,%r25'
../arch/parisc/kernel/vdso32/restart_syscall.S:30: Error: no such 
instruction: `ldi 0,%r20'

Best Regards,
Rong Chen

> 
> Could you please check ?
> 
> Helge
> 
> 
>> All errors (new ones prefixed by >>):
>>
>>     arch/parisc/kernel/vdso64/Makefile:30: FORCE prerequisite is missing
>>     arch/parisc/kernel/vdso32/sigtramp.S: Assembler messages:
>>>> arch/parisc/kernel/vdso32/sigtramp.S:39: Error: unknown pseudo-op: `.proc'
>>>> arch/parisc/kernel/vdso32/sigtramp.S:40: Error: unknown pseudo-op: `.callinfo'
>>>> arch/parisc/kernel/vdso32/sigtramp.S:41: Error: unknown pseudo-op: `.entry'
>>>> arch/parisc/kernel/vdso32/sigtramp.S:44: Error: no such instruction: `ldi 0,%r25'
>>>> arch/parisc/kernel/vdso32/sigtramp.S:45: Error: no such instruction: `ldi 173,%r20'
>>>> arch/parisc/kernel/vdso32/sigtramp.S:46: Error: no such instruction: `ble 0x100(%sr2,%r0)'
>>     arch/parisc/kernel/vdso32/sigtramp.S:49: Error: no such instruction: `ldi 1,%r25'
>>     arch/parisc/kernel/vdso32/sigtramp.S:50: Error: no such instruction: `ldi 173,%r20'
>>     arch/parisc/kernel/vdso32/sigtramp.S:51: Error: no such instruction: `ble 0x100(%sr2,%r0)'
>>>> arch/parisc/kernel/vdso32/sigtramp.S:54: Error: unknown pseudo-op: `.exit'
>>>> arch/parisc/kernel/vdso32/sigtramp.S:55: Error: unknown pseudo-op: `.procend'
>>>> arch/parisc/kernel/vdso32/sigtramp.S:76: Error: unknown pseudo-op: `.stringz'
>>     make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34: arch/parisc/kernel/vdso32/sigtramp.o] Error 1
>>     arch/parisc/kernel/vdso32/restart_syscall.S: Assembler messages:
>>>> arch/parisc/kernel/vdso32/restart_syscall.S:16: Error: bad or irreducible absolute expression
>>>> arch/parisc/kernel/vdso32/restart_syscall.S:16: Error: junk at end of line, first unrecognized character is `:'
>>>> arch/parisc/kernel/vdso32/restart_syscall.S:26: Error: no such instruction: `ldw 0(%sp),%r31'
>>>> arch/parisc/kernel/vdso32/restart_syscall.S:29: Error: no such instruction: `be 0x100(%sr2,%r0)'
>>>> arch/parisc/kernel/vdso32/restart_syscall.S:30: Error: no such instruction: `ldi 0,%r20'
>>>> arch/parisc/kernel/vdso32/restart_syscall.S:32: Error: .cfi_endproc without corresponding .cfi_startproc
>>     make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34: arch/parisc/kernel/vdso32/restart_syscall.o] Error 1
>>     make[2]: Target 'include/generated/vdso32-offsets.h' not remade because of errors.
>>     make[1]: *** [arch/parisc/Makefile:186: vdso_prepare] Error 2
>>     make[1]: Target 'prepare' not remade because of errors.
>>     make: *** [Makefile:219: __sub-make] Error 2
>>     make: Target 'prepare' not remade because of errors.
>>
>>
>> vim +39 arch/parisc/kernel/vdso32/sigtramp.S
>>
>>      12
>>      13		.text
>>      14
>>      15	/* Gdb expects the trampoline is on the stack and the pc is offset from
>>      16	   a 64-byte boundary by 0, 4 or 5 instructions. Since the vdso trampoline
>>      17	   is not on the stack, we need a new variant with different offsets and
>>      18	   data to tell gdb where to find the signal context on the stack.
>>      19
>>      20	   Here we put the offset to the context data at the start of the trampoline
>>      21	   region and offset the first trampoline by 2 instructions. Please do
>>      22	   not change the trampoline as the code in gdb depends on the following
>>      23	   instruction sequence exactly.
>>      24	 */
>>      25		.align 64
>>      26		.word SIGFRAME_CONTEXT_REGS32
>>      27
>>      28	/* The nop here is a hack.  The dwarf2 unwind routines subtract 1 from
>>      29	   the return address to get an address in the middle of the presumed
>>      30	   call instruction.  Since we don't have a call here, we artifically
>>      31	   extend the range covered by the unwind info by adding a nop before
>>      32	   the real start.
>>      33	 */
>>      34		nop
>>      35
>>      36		.globl __kernel_sigtramp_rt
>>      37		.type __kernel_sigtramp_rt, @function
>>      38	__kernel_sigtramp_rt:
>>    > 39		.proc
>>    > 40		.callinfo FRAME=ASM_SIGFRAME_SIZE32,CALLS,SAVE_RP
>>    > 41		.entry
>>      42
>>      43	.Lsigrt_start = . - 4
>>    > 44	0:	ldi	0, %r25			/* (in_syscall=0) */
>>    > 45		ldi  __NR_rt_sigreturn, %r20
>>    > 46		ble  0x100(%sr2, %r0)
>>      47		nop
>>      48
>>      49	1:	ldi	1, %r25			/* (in_syscall=1) */
>>      50		ldi  __NR_rt_sigreturn, %r20
>>      51		ble  0x100(%sr2, %r0)
>>      52		nop
>>      53	.Lsigrt_end:
>>    > 54		.exit
>>    > 55		.procend
>>      56		.size __kernel_sigtramp_rt,.-__kernel_sigtramp_rt
>>      57
>>      58
>>      59		.section .eh_frame,"a",@progbits
>>      60
>>      61	/* This is where the mcontext_t struct can be found on the stack.  */
>>      62	#define PTREGS SIGFRAME_CONTEXT_REGS32	/* 32-bit process offset is -672 */
>>      63
>>      64	/* Register REGNO can be found at offset OFS of the mcontext_t structure. */
>>      65		.macro rsave regno,ofs
>>      66		.byte 0x05		/* DW_CFA_offset_extended */
>>      67		.uleb128 \regno;	/*   regno */
>>      68		.uleb128 \ofs		/*   factored offset */
>>      69		.endm
>>      70
>>      71	.Lcie:
>>      72		.long .Lcie_end - .Lcie_start
>>      73	.Lcie_start:
>>      74		.long 0			/* CIE ID */
>>      75		.byte 1			/* Version number */
>>    > 76		.stringz "zRS"		/* NUL-terminated augmentation string */
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 

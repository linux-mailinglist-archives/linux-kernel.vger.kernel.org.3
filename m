Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46F94A3117
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 18:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352700AbiA2Rve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 12:51:34 -0500
Received: from mout.gmx.net ([212.227.15.15]:41589 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235418AbiA2Rvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 12:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643478682;
        bh=qNcEziU7anoQjcklkRi19wVVpM4DUXEcAmwPb3CzST0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=V1L55Dr2iIGh8g42dzg8s2mcVV49BlKEgqabZ6zYPvcfTS8h3uV7MWuyR4fFllSsa
         pk6IZkJPupqLKKYVWLbgZNoYx+zsEMumx2V1Aynk1w7FsW3o+x1ZtqTCC94OSAheCV
         P31FEMouMEi2SeaRto1ZT8MEFweHsRLH/gelyC4Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.149.251]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAONd-1n7V223sl9-00BpWf; Sat, 29
 Jan 2022 18:51:21 +0100
Message-ID: <f28b0c22-af83-31bf-8416-e896783fc105@gmx.de>
Date:   Sat, 29 Jan 2022 18:50:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [deller-parisc:5.17-vdso-mini-3 1/1]
 arch/parisc/kernel/vdso32/sigtramp.S:39: Error: unknown pseudo-op: `.proc'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        John David Anglin <dave.anglin@bell.net>
References: <202201290925.4WPmV6eS-lkp@intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <202201290925.4WPmV6eS-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b+l30rIIDFyFGvwbz8nfcxEqFXhkGA2j2IVgTyfV873LmSn/Z8V
 AKSuMkOQLAR6TzV6KdFzLipnHjfv0Wp9wC9QRrePwBAhZJJRnOCZNJvyvITAoeggu5moEtJ
 LxhlAxZ2WHEXj5JwdIu7IHW0Jj+yZ3nMoqdytyKF4TrsJPzVBVjeGI82gynMz7SZ3uBZ7tj
 U8CNeGE8WT2QqR9tpHqOg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:26Ag1krjYAU=:IoD+SnC49dinKxy9AnIAKi
 oJNtoiJpBjEohzHU98a3bkX44AAjg6djNCE6c69gkJzIiad7hF/vNPtCSB7LrdBA6/ILYTc1t
 IEB7ct19pFU3xqBP6npayPvAEAx4aXMUMZFaO/kdcVjkhh90jqSYsJV/HfHicHsgNApyt+xSY
 omzOV07JKTp8F8RfMpU/K9ji198/LwAMGtL9zWySoFLV5XWcMUc8D1UX+2MJJGuqSscM7bDTE
 jetAo9RtPBK5p9ND+vRs3egfoSsvMOHqvPIBBFhWcjUPyxgYf3rJukACN4T3umk4QuajYaqRr
 S6Ykp7kP/5+bFM4uCtYKpP1U0IjxuvWoOHANna56v39nlQMmeTQ0MOcHN2MgcYRbrDI5KcKe6
 zr/Eem6pU4G9ZJ+aiGhtUpXUb+GA48jDKMB7cTzHTdkyKkxM9autdkd6p7Azn8hvcPyOoWaYX
 gaxbXHQ8XmwEGJ/XqGclvjvE+is81vzAq+IYm0JLTm1R1YO2M0xdBNQphLoCza3TejHOaKyW7
 yrqXkiPkFLMQacwcMTZsBAuIRCRYU2GR64a5FsONKaO1rOUxzzpkcGBbpPv04WkCLIH/JXWET
 +vjtboDb0/W4DOlJAkc60spV2Kxx0P5vyzbtDoTuhB20EUQkP1edMk448Jz9WkkbFPC+sWVPu
 IXKH9jkBCxJA5mjsOj7O8K4Xrc03ltfhUL8mTunbLDXySmGgti0xLhoEjQj1dPyRmfK30fJw2
 K7gG4IT7JZkppax3auZNaIBcsQhvNSUZCiPl4zce3TxVzIaUGBkbM6RycjmlGFLDjTJEMmwgR
 Mcy4bbjeWFDLD5f/i/Cm2h9kZDmla6PZ2IQWB+Dbp87QoBapYLlDu7Tc/COCfCXkvB89QJQPf
 DBhK5G6UjLI88B5wc8VPi5bIToQ524fjwFahw+VPsnSN/lhJlJI0zTlUSv5RW3jH9Z1KYBTjk
 LIyv5vk/dAbZQjhjpV4OJwmdx/GCBxeh7klqlpwEVbTbebIeelQzFNRoM8tU3HruKESeI+ATi
 g7+G3+nii+kzsq+nz0myYcPCYhWMxHVeqIMqpwypkrjLKChjQ8y8PHuf/7hlnVAj7HO34MLZC
 ZCdY7UhXRACX+k=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/22 03:00, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-li=
nux.git 5.17-vdso-mini-3
> head:   8d7e3770fb1fb6c01147f8ebf2914cd2037fac16
> commit: 8d7e3770fb1fb6c01147f8ebf2914cd2037fac16 [1/1] parisc: Add vDSO =
support
> config: parisc-generic-64bit_defconfig (https://download.01.org/0day-ci/=
archive/20220129/202201290925.4WPmV6eS-lkp@intel.com/config)
> compiler: hppa64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sb=
in/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-=
linux.git/commit/?id=3D8d7e3770fb1fb6c01147f8ebf2914cd2037fac16
>         git remote add deller-parisc https://git.kernel.org/pub/scm/linu=
x/kernel/git/deller/parisc-linux.git
>         git fetch --no-tags deller-parisc 5.17-vdso-mini-3
>         git checkout 8d7e3770fb1fb6c01147f8ebf2914cd2037fac16
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cr=
oss O=3Dbuild_dir ARCH=3Dparisc prepare

I'm somewhat confused by those errors.

There are two changes which happened in the parisc port:

1.) If you want to build a 64bit kernel, you now need "ARCH=3Dparisc64". B=
efore "ARCH=3Dparisc" was sufficient,
but now ARCH=3Dparisc64 builds 64bit kernel, and ARCH=3Dparisc builds the =
32bit kernel.

2.) The patch which is being complained about here is, that it adds an ini=
tial vDSO, which
includes builds the 64- and 32-bit vDSO in the same build.
So, on a 64bit kernel build (which seems to happen here), the 32-bit gcc-1=
1 compiler needs to be
installed as well in order to be able to build the 32-bit "compat" vDSO.
Maybe the errors here are happening, because the 32bit hppa cross compiler=
 is missing?

Could you please check ?

Helge


> All errors (new ones prefixed by >>):
>
>    arch/parisc/kernel/vdso64/Makefile:30: FORCE prerequisite is missing
>    arch/parisc/kernel/vdso32/sigtramp.S: Assembler messages:
>>> arch/parisc/kernel/vdso32/sigtramp.S:39: Error: unknown pseudo-op: `.p=
roc'
>>> arch/parisc/kernel/vdso32/sigtramp.S:40: Error: unknown pseudo-op: `.c=
allinfo'
>>> arch/parisc/kernel/vdso32/sigtramp.S:41: Error: unknown pseudo-op: `.e=
ntry'
>>> arch/parisc/kernel/vdso32/sigtramp.S:44: Error: no such instruction: `=
ldi 0,%r25'
>>> arch/parisc/kernel/vdso32/sigtramp.S:45: Error: no such instruction: `=
ldi 173,%r20'
>>> arch/parisc/kernel/vdso32/sigtramp.S:46: Error: no such instruction: `=
ble 0x100(%sr2,%r0)'
>    arch/parisc/kernel/vdso32/sigtramp.S:49: Error: no such instruction: =
`ldi 1,%r25'
>    arch/parisc/kernel/vdso32/sigtramp.S:50: Error: no such instruction: =
`ldi 173,%r20'
>    arch/parisc/kernel/vdso32/sigtramp.S:51: Error: no such instruction: =
`ble 0x100(%sr2,%r0)'
>>> arch/parisc/kernel/vdso32/sigtramp.S:54: Error: unknown pseudo-op: `.e=
xit'
>>> arch/parisc/kernel/vdso32/sigtramp.S:55: Error: unknown pseudo-op: `.p=
rocend'
>>> arch/parisc/kernel/vdso32/sigtramp.S:76: Error: unknown pseudo-op: `.s=
tringz'
>    make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34: arch/parisc/kern=
el/vdso32/sigtramp.o] Error 1
>    arch/parisc/kernel/vdso32/restart_syscall.S: Assembler messages:
>>> arch/parisc/kernel/vdso32/restart_syscall.S:16: Error: bad or irreduci=
ble absolute expression
>>> arch/parisc/kernel/vdso32/restart_syscall.S:16: Error: junk at end of =
line, first unrecognized character is `:'
>>> arch/parisc/kernel/vdso32/restart_syscall.S:26: Error: no such instruc=
tion: `ldw 0(%sp),%r31'
>>> arch/parisc/kernel/vdso32/restart_syscall.S:29: Error: no such instruc=
tion: `be 0x100(%sr2,%r0)'
>>> arch/parisc/kernel/vdso32/restart_syscall.S:30: Error: no such instruc=
tion: `ldi 0,%r20'
>>> arch/parisc/kernel/vdso32/restart_syscall.S:32: Error: .cfi_endproc wi=
thout corresponding .cfi_startproc
>    make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34: arch/parisc/kern=
el/vdso32/restart_syscall.o] Error 1
>    make[2]: Target 'include/generated/vdso32-offsets.h' not remade becau=
se of errors.
>    make[1]: *** [arch/parisc/Makefile:186: vdso_prepare] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:219: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
>
>
> vim +39 arch/parisc/kernel/vdso32/sigtramp.S
>
>     12
>     13		.text
>     14
>     15	/* Gdb expects the trampoline is on the stack and the pc is offse=
t from
>     16	   a 64-byte boundary by 0, 4 or 5 instructions. Since the vdso t=
rampoline
>     17	   is not on the stack, we need a new variant with different offs=
ets and
>     18	   data to tell gdb where to find the signal context on the stack=
.
>     19
>     20	   Here we put the offset to the context data at the start of the=
 trampoline
>     21	   region and offset the first trampoline by 2 instructions. Plea=
se do
>     22	   not change the trampoline as the code in gdb depends on the fo=
llowing
>     23	   instruction sequence exactly.
>     24	 */
>     25		.align 64
>     26		.word SIGFRAME_CONTEXT_REGS32
>     27
>     28	/* The nop here is a hack.  The dwarf2 unwind routines subtract 1=
 from
>     29	   the return address to get an address in the middle of the pres=
umed
>     30	   call instruction.  Since we don't have a call here, we artific=
ally
>     31	   extend the range covered by the unwind info by adding a nop be=
fore
>     32	   the real start.
>     33	 */
>     34		nop
>     35
>     36		.globl __kernel_sigtramp_rt
>     37		.type __kernel_sigtramp_rt, @function
>     38	__kernel_sigtramp_rt:
>   > 39		.proc
>   > 40		.callinfo FRAME=3DASM_SIGFRAME_SIZE32,CALLS,SAVE_RP
>   > 41		.entry
>     42
>     43	.Lsigrt_start =3D . - 4
>   > 44	0:	ldi	0, %r25			/* (in_syscall=3D0) */
>   > 45		ldi  __NR_rt_sigreturn, %r20
>   > 46		ble  0x100(%sr2, %r0)
>     47		nop
>     48
>     49	1:	ldi	1, %r25			/* (in_syscall=3D1) */
>     50		ldi  __NR_rt_sigreturn, %r20
>     51		ble  0x100(%sr2, %r0)
>     52		nop
>     53	.Lsigrt_end:
>   > 54		.exit
>   > 55		.procend
>     56		.size __kernel_sigtramp_rt,.-__kernel_sigtramp_rt
>     57
>     58
>     59		.section .eh_frame,"a",@progbits
>     60
>     61	/* This is where the mcontext_t struct can be found on the stack.=
  */
>     62	#define PTREGS SIGFRAME_CONTEXT_REGS32	/* 32-bit process offset i=
s -672 */
>     63
>     64	/* Register REGNO can be found at offset OFS of the mcontext_t st=
ructure. */
>     65		.macro rsave regno,ofs
>     66		.byte 0x05		/* DW_CFA_offset_extended */
>     67		.uleb128 \regno;	/*   regno */
>     68		.uleb128 \ofs		/*   factored offset */
>     69		.endm
>     70
>     71	.Lcie:
>     72		.long .Lcie_end - .Lcie_start
>     73	.Lcie_start:
>     74		.long 0			/* CIE ID */
>     75		.byte 1			/* Version number */
>   > 76		.stringz "zRS"		/* NUL-terminated augmentation string */

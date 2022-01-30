Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899FF4A35CD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 11:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbiA3KtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 05:49:01 -0500
Received: from mout.gmx.net ([212.227.15.15]:44023 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231549AbiA3KtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 05:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643539730;
        bh=YI3y3UuzqXQvLq0zc3jXDAqQwHFFYc/e4f9sBFjrpgg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=e1r2WSGpsOoiL5PzOk6b58JhMF6KdEu5anQQHt7CrP6PrlYn7ZxS690XOugry/RhZ
         pE7P99B0Hlie71Vr8Nlzm59xa2EnAucPdDvySMVNaKWl9B4dOEQtAkl3sMpMxhPYNg
         Y1+1LAHYGS4cSO8Sk2ejgEyfUi2rEZpO+K+ZjPfQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.133.128]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4b1o-1nCTKu2XdW-001gvw; Sun, 30
 Jan 2022 11:48:50 +0100
Message-ID: <570878b9-a9c8-a12e-4721-32b6ca010995@gmx.de>
Date:   Sun, 30 Jan 2022 11:47:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [kbuild-all] Re: [deller-parisc:5.17-vdso-mini-3 1/1]
 arch/parisc/kernel/vdso32/sigtramp.S:39: Error: unknown pseudo-op: `.proc'
Content-Language: en-US
To:     "Chen, Rong A" <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        John David Anglin <dave.anglin@bell.net>
References: <202201290925.4WPmV6eS-lkp@intel.com>
 <f28b0c22-af83-31bf-8416-e896783fc105@gmx.de>
 <5201be65-84af-46ee-9398-8b79a198a63b@intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <5201be65-84af-46ee-9398-8b79a198a63b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uND09YUYixRGYrLhLWc+mcABPDcN8zAgSTVstuLukJfx81KIznV
 hr5QzX4Q68qGmX9tfPYjDsU/TQOdp17uqxyXxDXyTykeOuIJ7a2BFEhbwMaYsXxLlW8+p84
 9GkjPVer/vgo5aNvueWUSputnvqhHFVYu9Febb92w9FqXw/tnrkQ+GPj74wk/WW4rIWbCaU
 VJ4AIPxVEhSEPBIustbvQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MCyFVcjsChY=:9FQMglLDaWWsj/csUForMC
 a1MqWuNHwt3W18X+7aY8baIfRECbz/B5oTpgpPXRxeUDfsnCfmEBiJn5Fr3ovyAsxSSLGQuJd
 Px9Unwnp3FBBoooAClOcdgfrXvGWgM+UoVOWYo+SVGIljI9tZON+XXTqEy6p49nymNK5MC1RQ
 Bzx33PxN6LhPlJHHqqIDzAx9krgQQKyw/v4G4gMH2alnl/PBvIJAu/UmPZLLYSpiQdls0sTVu
 Cn6q6jDZ9R+addIfrb8fnkQ5zXGS7ufwZhpTD8dJwF4epyoxVrAfh3IYg0ya59+D0cUTjpvuy
 Q74022j+SUgimkVdttgW240aDNWu4aRW+9MmCgoACaNsirg502npfKsoaxk7F7vcloMjYwbDO
 ml9BZzyLf88OYebdNiMpv5Dc5i3PGc2p+we4IA6gHNHY7HemA0Sar1pa4Kza8lTFnTX0gNy9Z
 1aeTrarUx+DSSEygPcWqAHCoGYxLCC8iyOXdGUqt+cqnaTG6aYaQ0HBseUgDROQaXK1CI8aRh
 9J5JsIhzfSIwZCgJo6OCi+9NtLf5lo2YJ1vPq9mACirU4KgZk64Af3YknoehnqwV0FQqPBCVV
 X7qUsnMhq3ao4I3L36TiQVvtYAYM7GezKa4k1Op3fCFJUgnLK54OmIbYchXHYI18F0SQqSyMq
 rHajZ4bDUWIdNVZbxPHPvV07EPv0rOQvlVg6TGXigJyNHGdtxdAiYrGNn4ceFi+aik2kGG+SH
 g9vyUSLH+9BGYp+zqIqQHcWNLG+6BbzqiQtT9Oqab/2k2MYsNg+nJf6LwAO+00Yhmm0ig6uLN
 P0aus4w524t6EkP8y9T6hCVXoyuqlY4kKeUFHwinZBme9sI+E4/cHq6OyKkTqomxmz8jhoqch
 9BIt0uVm9cz6pJlyICIkr8cDrjnc4CGbkirxjpImenahnYZj9RO8l3kPHblR+NgkOxrjTNx5F
 bllfL/ptvNMkey+5OirCZrY7Z4my55GK4mevxyWZGNBFtfnJjviN3330YJwSnB6qjl+1AGioV
 OA8RvWRH7pLkQGi9G17IoyFGeQRsxcySI/tdYEp6+CWZXfq8I77SiBnc32sIMLzGwg3pKus5Q
 8OG1ifisJIREDs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rong Chen,

On 1/30/22 07:53, Chen, Rong A wrote:
> On 1/30/2022 1:50 AM, Helge Deller wrote:
>> On 1/29/22 03:00, kernel test robot wrote:
>>> tree:=C2=A0=C2=A0 https://git.kernel.org/pub/scm/linux/kernel/git/dell=
er/parisc-linux.git 5.17-vdso-mini-3
>>> head:=C2=A0=C2=A0 8d7e3770fb1fb6c01147f8ebf2914cd2037fac16
>>> commit: 8d7e3770fb1fb6c01147f8ebf2914cd2037fac16 [1/1] parisc: Add vDS=
O support
>>> config: parisc-generic-64bit_defconfig (https://download.01.org/0day-c=
i/archive/20220129/202201290925.4WPmV6eS-lkp@intel.com/config)
>>> compiler: hppa64-linux-gcc (GCC) 11.2.0
>>> reproduce (this is a W=3D1 build):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wget https://raw.gith=
ubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cro=
ss
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chmod +x ~/bin/make.c=
ross
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # https://git.kernel.=
org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?id=3D8d7e3770=
fb1fb6c01147f8ebf2914cd2037fac16
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git remote add deller=
-parisc https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linu=
x.git
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git fetch --no-tags d=
eller-parisc 5.17-vdso-mini-3
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git checkout 8d7e3770=
fb1fb6c01147f8ebf2914cd2037fac16
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # save the config fil=
e to linux build tree
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mkdir build_dir
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 COMPILER_INSTALL_PATH=
=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cross O=3Dbuild_dir ARCH=3Dparisc=
 prepare
>>
>> I'm somewhat confused by those errors.
>>
>> There are two changes which happened in the parisc port:
>>
>> 1.) If you want to build a 64bit kernel, you now need "ARCH=3Dparisc64"=
. Before "ARCH=3Dparisc" was sufficient,
>> but now ARCH=3Dparisc64 builds 64bit kernel, and ARCH=3Dparisc builds t=
he 32bit kernel.
>
> Hi Helge,
>
> Thanks for the explanation, we'll update to use ARCH=3Dparisc64 for 64bi=
t kernel.
>
>>
>> 2.) The patch which is being complained about here is, that it adds an =
initial vDSO, which
>> includes builds the 64- and 32-bit vDSO in the same build.
>> So, on a 64bit kernel build (which seems to happen here), the 32-bit gc=
c-11 compiler needs to be
>> installed as well in order to be able to build the 32-bit "compat" vDSO=
.
>> Maybe the errors here are happening, because the 32bit hppa cross compi=
ler is missing?
>
> I tried the below command, the error still exists, is there anything wro=
ng?
>
> $make W=3D1 --keep-going CROSS_COMPILE=3Dhppa64-linux- -j32 O=3D./build_=
dir ARCH=3Dparisc64 prepare

Please drop the "CROSS_COMPILE=3Dhppa64-linux-" part.
It will autodetect the cross compiler, so this is sufficient:

make W=3D1 --keep-going -j32 O=3D./build_dir ARCH=3Dparisc64 prepare

Helge

> ...
> Assembler messages:
> ../arch/parisc/kernel/vdso32/sigtramp.S:39: Error: unknown pseudo-op: `.=
proc'
> ../arch/parisc/kernel/vdso32/restart_syscall.S:16: Error: bad or irreduc=
ible absolute expression
> ../arch/parisc/kernel/vdso32/sigtramp.S:40: Error: unknown pseudo-op: `.=
callinfo'
> ../arch/parisc/kernel/vdso32/restart_syscall.S:16: Error: junk at end of=
 line, first unrecognized character is `:'
> ../arch/parisc/kernel/vdso32/sigtramp.S:41: Error: unknown pseudo-op: `.=
entry'
> ../arch/parisc/kernel/vdso32/restart_syscall.S:26: Error: no such instru=
ction: `ldw 0(%sp),%r31'
> ../arch/parisc/kernel/vdso32/restart_syscall.S:29: Error: no such instru=
ction: `be 0x100(%sr2,%r0)'
> ../arch/parisc/kernel/vdso32/sigtramp.S:44: Error: no such instruction: =
`ldi 0,%r25'
> ../arch/parisc/kernel/vdso32/restart_syscall.S:30: Error: no such instru=
ction: `ldi 0,%r20'
>
> Best Regards,
> Rong Chen
>
>>
>> Could you please check ?
>>
>> Helge
>>
>>
>>> All errors (new ones prefixed by >>):
>>>
>>> =C2=A0=C2=A0=C2=A0 arch/parisc/kernel/vdso64/Makefile:30: FORCE prereq=
uisite is missing
>>> =C2=A0=C2=A0=C2=A0 arch/parisc/kernel/vdso32/sigtramp.S: Assembler mes=
sages:
>>>>> arch/parisc/kernel/vdso32/sigtramp.S:39: Error: unknown pseudo-op: `=
.proc'
>>>>> arch/parisc/kernel/vdso32/sigtramp.S:40: Error: unknown pseudo-op: `=
.callinfo'
>>>>> arch/parisc/kernel/vdso32/sigtramp.S:41: Error: unknown pseudo-op: `=
.entry'
>>>>> arch/parisc/kernel/vdso32/sigtramp.S:44: Error: no such instruction:=
 `ldi 0,%r25'
>>>>> arch/parisc/kernel/vdso32/sigtramp.S:45: Error: no such instruction:=
 `ldi 173,%r20'
>>>>> arch/parisc/kernel/vdso32/sigtramp.S:46: Error: no such instruction:=
 `ble 0x100(%sr2,%r0)'
>>> =C2=A0=C2=A0=C2=A0 arch/parisc/kernel/vdso32/sigtramp.S:49: Error: no =
such instruction: `ldi 1,%r25'
>>> =C2=A0=C2=A0=C2=A0 arch/parisc/kernel/vdso32/sigtramp.S:50: Error: no =
such instruction: `ldi 173,%r20'
>>> =C2=A0=C2=A0=C2=A0 arch/parisc/kernel/vdso32/sigtramp.S:51: Error: no =
such instruction: `ble 0x100(%sr2,%r0)'
>>>>> arch/parisc/kernel/vdso32/sigtramp.S:54: Error: unknown pseudo-op: `=
.exit'
>>>>> arch/parisc/kernel/vdso32/sigtramp.S:55: Error: unknown pseudo-op: `=
.procend'
>>>>> arch/parisc/kernel/vdso32/sigtramp.S:76: Error: unknown pseudo-op: `=
.stringz'
>>> =C2=A0=C2=A0=C2=A0 make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34=
: arch/parisc/kernel/vdso32/sigtramp.o] Error 1
>>> =C2=A0=C2=A0=C2=A0 arch/parisc/kernel/vdso32/restart_syscall.S: Assemb=
ler messages:
>>>>> arch/parisc/kernel/vdso32/restart_syscall.S:16: Error: bad or irredu=
cible absolute expression
>>>>> arch/parisc/kernel/vdso32/restart_syscall.S:16: Error: junk at end o=
f line, first unrecognized character is `:'
>>>>> arch/parisc/kernel/vdso32/restart_syscall.S:26: Error: no such instr=
uction: `ldw 0(%sp),%r31'
>>>>> arch/parisc/kernel/vdso32/restart_syscall.S:29: Error: no such instr=
uction: `be 0x100(%sr2,%r0)'
>>>>> arch/parisc/kernel/vdso32/restart_syscall.S:30: Error: no such instr=
uction: `ldi 0,%r20'
>>>>> arch/parisc/kernel/vdso32/restart_syscall.S:32: Error: .cfi_endproc =
without corresponding .cfi_startproc
>>> =C2=A0=C2=A0=C2=A0 make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34=
: arch/parisc/kernel/vdso32/restart_syscall.o] Error 1
>>> =C2=A0=C2=A0=C2=A0 make[2]: Target 'include/generated/vdso32-offsets.h=
' not remade because of errors.
>>> =C2=A0=C2=A0=C2=A0 make[1]: *** [arch/parisc/Makefile:186: vdso_prepar=
e] Error 2
>>> =C2=A0=C2=A0=C2=A0 make[1]: Target 'prepare' not remade because of err=
ors.
>>> =C2=A0=C2=A0=C2=A0 make: *** [Makefile:219: __sub-make] Error 2
>>> =C2=A0=C2=A0=C2=A0 make: Target 'prepare' not remade because of errors=
.
>>>
>>>
>>> vim +39 arch/parisc/kernel/vdso32/sigtramp.S
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 12
>>> =C2=A0=C2=A0=C2=A0=C2=A0 13=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
.text
>>> =C2=A0=C2=A0=C2=A0=C2=A0 14
>>> =C2=A0=C2=A0=C2=A0=C2=A0 15=C2=A0=C2=A0=C2=A0 /* Gdb expects the tramp=
oline is on the stack and the pc is offset from
>>> =C2=A0=C2=A0=C2=A0=C2=A0 16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a 64-b=
yte boundary by 0, 4 or 5 instructions. Since the vdso trampoline
>>> =C2=A0=C2=A0=C2=A0=C2=A0 17=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is not=
 on the stack, we need a new variant with different offsets and
>>> =C2=A0=C2=A0=C2=A0=C2=A0 18=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data t=
o tell gdb where to find the signal context on the stack.
>>> =C2=A0=C2=A0=C2=A0=C2=A0 19
>>> =C2=A0=C2=A0=C2=A0=C2=A0 20=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Here w=
e put the offset to the context data at the start of the trampoline
>>> =C2=A0=C2=A0=C2=A0=C2=A0 21=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 region=
 and offset the first trampoline by 2 instructions. Please do
>>> =C2=A0=C2=A0=C2=A0=C2=A0 22=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 not ch=
ange the trampoline as the code in gdb depends on the following
>>> =C2=A0=C2=A0=C2=A0=C2=A0 23=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 instru=
ction sequence exactly.
>>> =C2=A0=C2=A0=C2=A0=C2=A0 24=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0 25=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
.align 64
>>> =C2=A0=C2=A0=C2=A0=C2=A0 26=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
.word SIGFRAME_CONTEXT_REGS32
>>> =C2=A0=C2=A0=C2=A0=C2=A0 27
>>> =C2=A0=C2=A0=C2=A0=C2=A0 28=C2=A0=C2=A0=C2=A0 /* The nop here is a hac=
k.=C2=A0 The dwarf2 unwind routines subtract 1 from
>>> =C2=A0=C2=A0=C2=A0=C2=A0 29=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the re=
turn address to get an address in the middle of the presumed
>>> =C2=A0=C2=A0=C2=A0=C2=A0 30=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 call i=
nstruction.=C2=A0 Since we don't have a call here, we artifically
>>> =C2=A0=C2=A0=C2=A0=C2=A0 31=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extend=
 the range covered by the unwind info by adding a nop before
>>> =C2=A0=C2=A0=C2=A0=C2=A0 32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the re=
al start.
>>> =C2=A0=C2=A0=C2=A0=C2=A0 33=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0 34=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
nop
>>> =C2=A0=C2=A0=C2=A0=C2=A0 35
>>> =C2=A0=C2=A0=C2=A0=C2=A0 36=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
.globl __kernel_sigtramp_rt
>>> =C2=A0=C2=A0=C2=A0=C2=A0 37=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
.type __kernel_sigtramp_rt, @function
>>> =C2=A0=C2=A0=C2=A0=C2=A0 38=C2=A0=C2=A0=C2=A0 __kernel_sigtramp_rt:
>>> =C2=A0=C2=A0 > 39=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .proc
>>> =C2=A0=C2=A0 > 40=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .callinfo =
FRAME=3DASM_SIGFRAME_SIZE32,CALLS,SAVE_RP
>>> =C2=A0=C2=A0 > 41=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .entry
>>> =C2=A0=C2=A0=C2=A0=C2=A0 42
>>> =C2=A0=C2=A0=C2=A0=C2=A0 43=C2=A0=C2=A0=C2=A0 .Lsigrt_start =3D . - 4
>>> =C2=A0=C2=A0 > 44=C2=A0=C2=A0=C2=A0 0:=C2=A0=C2=A0=C2=A0 ldi=C2=A0=C2=
=A0=C2=A0 0, %r25=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* (in_syscall=3D0) */
>>> =C2=A0=C2=A0 > 45=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ldi=C2=A0 =
__NR_rt_sigreturn, %r20
>>> =C2=A0=C2=A0 > 46=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ble=C2=A0 =
0x100(%sr2, %r0)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 47=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
nop
>>> =C2=A0=C2=A0=C2=A0=C2=A0 48
>>> =C2=A0=C2=A0=C2=A0=C2=A0 49=C2=A0=C2=A0=C2=A0 1:=C2=A0=C2=A0=C2=A0 ldi=
=C2=A0=C2=A0=C2=A0 1, %r25=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* (in_syscall=3D1) */
>>> =C2=A0=C2=A0=C2=A0=C2=A0 50=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ldi=C2=A0 __NR_rt_sigreturn, %r20
>>> =C2=A0=C2=A0=C2=A0=C2=A0 51=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ble=C2=A0 0x100(%sr2, %r0)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 52=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
nop
>>> =C2=A0=C2=A0=C2=A0=C2=A0 53=C2=A0=C2=A0=C2=A0 .Lsigrt_end:
>>> =C2=A0=C2=A0 > 54=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .exit
>>> =C2=A0=C2=A0 > 55=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .procend
>>> =C2=A0=C2=A0=C2=A0=C2=A0 56=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
.size __kernel_sigtramp_rt,.-__kernel_sigtramp_rt
>>> =C2=A0=C2=A0=C2=A0=C2=A0 57
>>> =C2=A0=C2=A0=C2=A0=C2=A0 58
>>> =C2=A0=C2=A0=C2=A0=C2=A0 59=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
.section .eh_frame,"a",@progbits
>>> =C2=A0=C2=A0=C2=A0=C2=A0 60
>>> =C2=A0=C2=A0=C2=A0=C2=A0 61=C2=A0=C2=A0=C2=A0 /* This is where the mco=
ntext_t struct can be found on the stack.=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0 62=C2=A0=C2=A0=C2=A0 #define PTREGS SIGFRAME_=
CONTEXT_REGS32=C2=A0=C2=A0=C2=A0 /* 32-bit process offset is -672 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0 63
>>> =C2=A0=C2=A0=C2=A0=C2=A0 64=C2=A0=C2=A0=C2=A0 /* Register REGNO can be=
 found at offset OFS of the mcontext_t structure. */
>>> =C2=A0=C2=A0=C2=A0=C2=A0 65=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
.macro rsave regno,ofs
>>> =C2=A0=C2=A0=C2=A0=C2=A0 66=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
.byte 0x05=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* DW_CFA_offset_exte=
nded */
>>> =C2=A0=C2=A0=C2=A0=C2=A0 67=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
.uleb128 \regno;=C2=A0=C2=A0=C2=A0 /*=C2=A0=C2=A0 regno */
>>> =C2=A0=C2=A0=C2=A0=C2=A0 68=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
.uleb128 \ofs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=C2=A0=C2=A0 fac=
tored offset */
>>> =C2=A0=C2=A0=C2=A0=C2=A0 69=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
.endm
>>> =C2=A0=C2=A0=C2=A0=C2=A0 70
>>> =C2=A0=C2=A0=C2=A0=C2=A0 71=C2=A0=C2=A0=C2=A0 .Lcie:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 72=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
.long .Lcie_end - .Lcie_start
>>> =C2=A0=C2=A0=C2=A0=C2=A0 73=C2=A0=C2=A0=C2=A0 .Lcie_start:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 74=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
.long 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
/* CIE ID */
>>> =C2=A0=C2=A0=C2=A0=C2=A0 75=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
.byte 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
/* Version number */
>>> =C2=A0=C2=A0 > 76=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .stringz "=
zRS"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* NUL-terminated augmentat=
ion string */
>> _______________________________________________
>> kbuild-all mailing list -- kbuild-all@lists.01.org
>> To unsubscribe send an email to kbuild-all-leave@lists.01.org
>>


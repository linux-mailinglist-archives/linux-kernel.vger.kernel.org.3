Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079874A8B23
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352934AbiBCSD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 13:03:26 -0500
Received: from mout.gmx.net ([212.227.17.21]:43235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbiBCSDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:03:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643911394;
        bh=rcMALiVU94EBHgGtOoSbUxeTTuHQfsZj0+PxVfDuuX4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=arXjvE5ZJI5QP7F8DIrSdNNhk7JJaIq1AH7P8wYttBl+4F+yWk7JhsTPPGxzqrcx2
         qdFy7dzWoVT6VmSakEK3jW7RWZyazkk6gXri1klCOiBc/bMs4Q8gxZv7OqWYwszTqG
         nk+belRqzl5VPVf+b/S2H4FssZsbzogjip1E39mo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.128.137]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2O2Q-1nCvpX49rq-003yH7; Thu, 03
 Feb 2022 19:03:14 +0100
Message-ID: <7c41f8e2-8018-0984-a734-70ba321d7b48@gmx.de>
Date:   Thu, 3 Feb 2022 19:03:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [deller-parisc:5.17-vdso-mini-3 1/1]
 arch/parisc/kernel/vdso32/restart_syscall.S:16: Error: bad or irreducible
 absolute expression
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202202032200.IMpqlhlW-lkp@intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <202202032200.IMpqlhlW-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5Knd8m93h7yJmDkV+FbSXfWhw6eL72kf4YN0sqBw7c9VNVByZJe
 wLuHhhCV51QYMH/LyACjJMGDY59TZ7/GbIORdhk4ufoWgJybdeyJXZrgPlfawgJKwaS5N5i
 ZLJlgYnM5d4O9/BDzqPCbt3Ea//mHbjiN8jAeRTfDdH5s6ROuHHeyAnAbYCgGLkOLaNKePu
 IsQiR/1hi1dHGmYrOkJYQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7fz1rZn7HsU=:jCdzYwbthAQ9+3t8WkiJoA
 8Vzrp+d2w2BxtIScnNQlfLjpIStFvzPX6UrO/xgktid9mXFXeLWfUFLyAgLoAbO4zMg4MVjs3
 LpphACjoxLpK0CUHUxPScIry8reKDPAAvsizM9EH0mJVRnKa4DkkkUsCJx6LCm35jpLDkgjEC
 voUmqJzC/qBvQGQyunvJ11cZKtpGFLb5a3LdLNewcA7MbbH7i+67dWKlze+sRE6VbcIxZmMyX
 L8YeA3KeI5RSQKklbksGREyqC8MCBADz1rBj49PCPjsodCf7B4sVB+kcRkIKxe+dIguRWYn52
 Fw4gY77FdHGFVX99Q2+SKilwi3RvqyzShqnH83zR2uBe4bDOXctIwC/FinEkyUZGfqeUkaZfA
 Yumn2/NLh/KsAdPFxQrSmXguQqlka2K9TjlHZs9jKat21oC6x+EZ27MUiItSUa8QGU3GUibgp
 1vjesti7yS2QLRN5SywRKxYdRW4SsfeR0G1ugmxPu3ybVmGqyqMHv1LQ1+RsrZ/K4+w98jL/y
 NF9v30vZNmUTXpeEwKOIzpHmF5asxmJSVU2NRoJrckaEzBX45B+h6X7llYI3g8umqVKrz2kzo
 RoGHXrcnKeEVKKmwjCfURS+qswyFkTxK0sSs60RqNdPeeUhzM51NfI5Jl8HkXvsazbbA9wfup
 G3+ltzd9DpGJTY1QqqoNq8FESLge1v0m6lvlpxvd0JEoHFkRJCfdIO0K9vMVZmsKkiMMIRU9I
 fUlCrKIIwUl1qRKETZK/o1vuysRgm+1NUhUIrcTHAUIcEffQvRQu+JgG7O/J0/B1b166ITPOQ
 ecK3QLYHKlJUfhuMNJ28CFmd7cZgnvaLivNKZiLtkUVPZAg88AGxcmuIW4bcrJdKWG4a7trcJ
 TU3JB1pwazoyyT8uldmpbns8bjUI6TIY3R12W1H6cwZlBp4Jgvch7lO7Qj1AtIyi/qVHrNfJa
 vRA00FgOlKVQsqQuBIXxi3CmAmVMBSKymRncyXFThtcbl+ldPusSeGwH5vg0IeXvD2/E/xuvS
 k7Xg8WBvYZ5IWUg3GfNM2+k4VVMF0GK6NYhFZySAJuqaN39AKZCCBqSGgLNbmGu9FctOGAfLu
 FdAVqKKx6ALbaM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 15:37, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-li=
nux.git 5.17-vdso-mini-3
> head:   62c208e2c93066ee050644384bb12ca1d0b2bdb1
> commit: 62c208e2c93066ee050644384bb12ca1d0b2bdb1 [1/1] parisc: Add initi=
al vDSO support
> config: parisc-generic-64bit_defconfig (https://download.01.org/0day-ci/=
archive/20220203/202202032200.IMpqlhlW-lkp@intel.com/config)
> compiler: hppa64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sb=
in/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-=
linux.git/commit/?id=3D62c208e2c93066ee050644384bb12ca1d0b2bdb1
>         git remote add deller-parisc https://git.kernel.org/pub/scm/linu=
x/kernel/git/deller/parisc-linux.git
>         git fetch --no-tags deller-parisc 5.17-vdso-mini-3
>         git checkout 62c208e2c93066ee050644384bb12ca1d0b2bdb1
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cr=
oss O=3Dbuild_dir ARCH=3Dparisc prepare


Please drop the "ARCH=3Dparisc" in this prepare command, so this is suffic=
ient:

	COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cross O=3Db=
uild_dir       prepare


> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconfli=
cts-sr]
>    scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconfl=
icts-rr]

>    arch/parisc/kernel/vdso64/Makefile:30: FORCE prerequisite is missing


Since I'm not a GNU make/Makefile expert, I currently don't know how to pr=
event this
"FORCE prerequisite is missing" warning.
Any help is welcome here :-)

Helge





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
el/vdso32/restart_syscall.o] Error 1
>    make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34: arch/parisc/kern=
el/vdso32/sigtramp.o] Error 1
>    make[2]: Target 'include/generated/vdso32-offsets.h' not remade becau=
se of errors.
>    make[1]: *** [arch/parisc/Makefile:188: vdso_prepare] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:219: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
>
>
> vim +16 arch/parisc/kernel/vdso32/restart_syscall.S
>
>     13
>     14		.text
>     15
>   > 16	ENTRY_CFI(__kernel_restart_syscall)
>     17		/*
>     18		 * Setup a trampoline to restart the syscall
>     19		 * with __NR_restart_syscall
>     20		 */
>     21
>     22		/* load return pointer */
>     23	#if defined(__VDSO64__)
>     24		ldd	0(%sp), %r31
>     25	#elif defined(__VDSO32__)
>   > 26		ldw	0(%sp), %r31
>     27	#endif
>     28
>   > 29		be	0x100(%sr2, %r0)
>   > 30		ldi	__NR_restart_syscall, %r20
>     31
>   > 32	ENDPROC_CFI(__kernel_restart_syscall)
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>


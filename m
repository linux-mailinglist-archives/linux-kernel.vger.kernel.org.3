Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8135A5999E1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348441AbiHSKkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348409AbiHSKkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:40:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648A5E42F7;
        Fri, 19 Aug 2022 03:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660905573;
        bh=52OQy1D24i3g+gSCIBd1HEVjSy9Xm2D1b7NLko9jJJ0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=GF5zxf9cQNzp0n5x/XoMzH+AfX/1M7W+RVRZ6iQFoHHq9bnWywnB0hSRw0ZZrlssR
         XSJyeOHrmKu4yGAF2ZYvtwvYkciZQBgSG5n8uZy72IqJDK4G7Wqjtlrnv3Qius0ep4
         Hn07QVbRPRI1jZL1XpCCfqJ3fc8+lFaY/74dRPgE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.153.160]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvbG2-1nWcPD1tjC-00si2Y; Fri, 19
 Aug 2022 12:39:33 +0200
Message-ID: <cca91e0d-2e7b-fcd3-30a9-2dcfcb11c2e0@gmx.de>
Date:   Fri, 19 Aug 2022 12:38:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: linux-parisc compile failure in current git
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        Meelis Roos <mroos@linux.ee>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <892b6ab7-862c-1c0a-2996-0f8408e5043d@linux.ee>
 <89515325-fc21-31da-d238-6f7a9abbf9a0@gmx.de>
 <CAK7LNATuzry1MUj-VruOVUwU_nH2xJd_2SxD_s_Z1QBb3PVnQw@mail.gmail.com>
 <5dfd81eb-c8ca-b7f5-e80e-8632767c022d@gmx.de>
 <CAK7LNATO_30uHzAe-Vsy+hgu=wwEN_aPGET4Ys78rc3=nSuJsg@mail.gmail.com>
 <YNOafsB81ZcP2r7z@ls3530>
 <f599c358-815f-088e-f2aa-b064ccb64e44@infradead.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <f599c358-815f-088e-f2aa-b064ccb64e44@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C4OA6ZvCk7/Iq3vmg4H3PIWfj7EV3qYg+0nLSBSVlIZT/7YfwPd
 TL++xGShtDLkVwEzWqDxBirajQ0XM1qrk+Pt0Y9zXmW4n/g4FyjdaheAeCU91EPj8mnLCE7
 EN9zM0u6sGk+4eYJpO0a0QZ4gYmWyGYZIkJz3MO2BbCPPKSyg7gk6+8V+AaxRuYumzSQ2++
 DVX5UwsJVd+N2iVTUQqHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ACfwtN4CquE=:jDYM+F7JgamLxnlhKWhnmt
 Ft0aFDIHt/92AR5jLba18QK/47+MyfP2vvYrAGHtH/iD70jJjRiSX2zS/LGKEMWdWOW1wpFhm
 nLxj15PnZ28V1qmgnEMWw3bvw3rOftXQjO3Zhok3bKL+Z1zaac91P9Gn+4M9s8hJrnV86lSYw
 lRVFYzTPoCZVvFzNQbKw+5eu0b5JqBcDX2XIRPDCqCd5W8EbnasQeJ7pLxEjiPDIpN7p6Ub39
 xGOn3fSqcG0oTl8VztZAXTqE4i9ik1v6+FDxyWOeNahad8U5mtsYWIoKJHBTyzuFHIcdrW9Kf
 CUENRMe5602F6uOpoKyruAkaxjA2c4LN1JXfJ42tJOdmWL1i9hO+I5VBYZkE6JhxtsTNlt5Qj
 w3RPYn48a4VOc44V4pHEqqqaJZFeUe55VWMvPSeoKH4MvnVvk5d+mKQkkvxt12ruQpWUS9dMk
 IbkTDY6gmGwmaMbtTD7YLqMk6w1DdvK/Y4kJrR1Ytcf+AnCWq3KEAukGjpL75cwO8Cenyj9V3
 zT5wKzDcRtN6b09GPrrTZY7Kh9X/nxQG/9VnNnXQjfbb4V+QeuCXJdosahZ4AvNeS1aPCax0w
 7rON0Mkc34AePp/fJYrze+JbR7ZOafdWlWqtv07fwd2PJgYmVGdfENobVFFnlwz7/NDt5Y1xw
 gRedmU7dc5P3YAQCOHX1lCZMGMG1igUzK1RRCdqM9EICJaP9LqouQ4vXhBS+Y0xzvjuoOLjTQ
 Ob6Eeh78qVboa2fNnN5ewCDmjeruPTIbExNRFISDiS11NfRB+MvntPOywCCJFALEiQJy94ZlQ
 tfRRe/52ErqHbtHjn52hHHxmwwD6AmaDB8TCAnnbxn2LrgGzAy4YFRTxSFXuzPY+v/KxK7xvv
 XmBxvuAAvEY+R1/5zW+DiB39nucHiFbuZp9RisWuP1+aMLGYk1X70lZ1QZHvlXo2cn3Nsd7io
 5J96SlK4n6YIUjWSgbYBYdaqz/VpkztQE3DIhM1CdczjLgIJuPaLSelohQAGAI9YPpOOyh3ik
 TWj12vKdfe4hHWxTcQC1v3nFM2x6Xd1/aZdo+oFDHvhmAQIGzzmpNCHp+lk4eg+EwRRYAKceL
 hy7T5v/2A5X6n8lHiSsCFnEif7CcDAm6UArSPmh/W6fwz+w0ars1gLMMQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/22 22:59, Randy Dunlap wrote:
> Hi--
>
> On 6/23/21 13:33, Helge Deller wrote:
>> * Masahiro Yamada <masahiroy@kernel.org>:
>>> On Thu, Jun 10, 2021 at 4:04 PM Helge Deller <deller@gmx.de> wrote:
>>>>
>>>> Hi Masahiro,
>>>>
>>>> On 6/10/21 4:03 AM, Masahiro Yamada wrote:
>>>>> On Thu, Jun 10, 2021 at 7:50 AM Helge Deller <deller@gmx.de> wrote:
>
> [snip]
>
>>>>> But, please keep in mind that there is an issue remaining.
>>>>>
>>>>> Please see this code:
>>>>>
>>>>> ifdef CONFIG_64BIT
>>>>> UTS_MACHINE :=3D parisc64
>>>>> CHECKFLAGS +=3D -D__LP64__=3D1
>>>>> CC_ARCHES =3D hppa64
>>>>> LD_BFD :=3D elf64-hppa-linux
>>>>> else # 32-bit
>>>>> CC_ARCHES =3D hppa hppa2.0 hppa1.1
>>>>> LD_BFD :=3D elf32-hppa-linux
>>>>> endif
>>>>>
>>>>>
>>>>> UTS_MACHINE is determined by CONFIG_64BIT.
>>>>>
>>>>> CONFIG_64BIT is defined only after Kconfig is finished.
>>>>> When you are trying to configure the .config,
>>>>> CONFIG_64BIT is not defined yet.
>>>>> So UTS_MACHINE is always 'parisc'.
>>>>
>>>> Yes.
>>>> See above, but it worked when I had SUBARCH=3Dx86 (when running my la=
ptop).
>>>>
>>>>
>>>>> As you know, Kconfig files now have a bunch of 'cc-option' syntax
>>>>> to check the compiler capability in Kconfig time.
>>>>> Hence, you need to provide a proper compiler in Kconfig time too.
>>>>>
>>>>> When you build a 64-bit parisc kernel on a 32-bit parisc machine,
>>>>
>>>> Please note, that we don't have a 64-bit parisc userspace yet (just k=
ernel).
>>>> This means, that all builds on parisc machines are 32bit and do a
>>>> cross-compilation to a parisc64 kernel if requested in the .config.
>>>>
>>>>> Kconfig is passed with CC=3Dgcc since SUBARCH=3D=3DUTS_MACHINE=3D=3D=
parisc.
>>>>> After Kconfig, CROSS_COMPILE=3Dhppa64-* is set,
>>>>> and the kernel is built by CC=3Dhppa64-*-gcc.
>>>>
>>>> Right. That is the old behaviour. Based on the CONFIG_64BIT option
>>>> the hppa64 compiler is choosen for CROSS_COMPILE.
>>>>
>>>>> So, Kconfig evaluated a compiletely different compiler. This is poin=
tless.
>>>>
>>>> Yes, probably.
>>>>
>>>>
>>>>> There are some options
>>>>>
>>>>> [option 1]
>>>>>    revert the parisc bit of 23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3
>>>>>    This will restore the functionality you may want, but
>>>>>    as I said above, Kconfig is doing pointless things.
>>>>
>>>> as mentioned above: Doesn't solve the issue.
>>>>
>>>>> [option 2]
>>>>>     Stop using cc-cross-prefix, and pass CROSS_COMPILE explicitly.
>>>>>     This is what many architectures including arm, arm64 do.
>>>>>     You need to explicitly pass CROSS_COMPILE=3Daarch64-linux-gnu- e=
tc.
>>>>>     if you are cross-compiling arm64.
>>>>
>>>> Might be an option, but it's not as handy as simply choosing CONFIG_6=
4BIT
>>>> and then things are done automatically.
>>>>
>>>>> [option 3]
>>>>>     Introduce ARCH=3Dparisc64.
>>>>>
>>>>>     When you are building 64-bit kernel, you can pass ARCH=3Dparisc6=
4
>>>>>      A patch attached.  (but not tested much)
>>>>
>>>> Tried it, but doesn't work.
>>>> asm-offsets.c is still preprocessed with 32bit compiler (gcc, not hpp=
a20-gcc).
>>>>
>>>> Thanks for your help so far!
>>>> If you like I'm happy to give you an account on a hppa64 machine to r=
eproduce yourself.
>>>> I'll now try to bisect where it goes wrong. There must be something e=
lse before commit 23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3.
>>>>
>>>> Helge
>>>
>>>
>>> Sorry for my late reply.
>>
>> Me too.... :-(
>
> Sorry to jump in even later, but:
>
> I see that
> $ make ARCH=3Dparisc64 defconfig
> does set CONFIG_64BIT.
>
> Is there a way to do
> $ make ARCH=3Dparisc64 allmodconfig
> ?
> That does not set CONFIG_64BIT in my testing.
> (testing on linux-next-20220817)

Right. It seems to delete the CONFIG_64BIT which was set earlier.

> I would like to have a command-line method to do that,
> without editing the .config file.

I found your patch for riscv:
https://lore.kernel.org/all/20210912034538.19404-1-rdunlap@infradead.org/
and added a similiar one for parisc into my for-next git tree:
https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/co=
mmit/?h=3Dfor-next&id=3D34793a5d09d9122f90acfa7e8f705436d5090d4d

Does that help?

Although, I'd prefer a generic solution for this problem, e.g.
a new KCONFIG_MIN_RAND_CONFIG=3D$(srctree)/arch/parisc/configs/32-bit.conf=
ig
option which is used by randconfig/allmodconfig/....
Then it could be set once, and we can get rid of adding similiar patches
to the arches, e.g. in arch/parisc/Makefile it could be:
ifeq ($(ARCH),parisc64)
        KBUILD_DEFCONFIG :=3D generic-64bit_defconfig
	KCONFIG_MIN_RAND_CONFIG =3D $(srctree)/arch/parisc/configs/64-bit.config
else
        KBUILD_DEFCONFIG :=3D generic-32bit_defconfig
	KCONFIG_MIN_RAND_CONFIG =3D $(srctree)/arch/parisc/configs/32-bit.config
endif
Thoughts?

Helge

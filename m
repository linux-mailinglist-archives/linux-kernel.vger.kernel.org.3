Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B025599D3B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348853AbiHSN4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348940AbiHSN4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:56:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2AA100947;
        Fri, 19 Aug 2022 06:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660917343;
        bh=m4iYsB5d5uosfD01rYjV31/9/HdBp1rmh1L13Gst1ro=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=igTHqTcT7CkSqZmCBJ30gPCV/M2A7E+6V6YrNB+greWX1H4MqEgR/NXdKbxoAcMmU
         9xwlKJdHdERZmFFB1VKEsvghudN3hFxEoRfeS/5i+0W6UNTYAY/z/bNFGchrULzp12
         eImI0DISRNvtvWkrA5hxauXYmjBw8X2KYenGz1D4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.153.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mj8qj-1njuQM2ebF-00fDp2; Fri, 19
 Aug 2022 15:55:43 +0200
Message-ID: <39ee0ca2-48a0-755b-605c-3ce1205b9715@gmx.de>
Date:   Fri, 19 Aug 2022 15:54:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: linux-parisc compile failure in current git
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
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
 <CAK7LNAREcSW2Hn3Ty_zTVzTCLgYnFfo=ZcibE2zif1mBWp==4A@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAK7LNAREcSW2Hn3Ty_zTVzTCLgYnFfo=ZcibE2zif1mBWp==4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5voilb2YEtIWZGdXSHYpNN2AZZLkzvFBOVIR4KETBKiIhC6FYKi
 1ChCc5GbUYz6NS3NrMKbQTa3y4I4NR4+uVbLEy69CpAC4Tqn8P7Fo+ZeNF1KI60XDygpojM
 Z6dfoBPnp17VXZjvOOD01oLZhTFHd18hM0kk5nmQ1NkguZfyEBFn7TpRgsC2q1UlM5Vgmcs
 m7G4xwh6vGv53ijUviqEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ocTAnYQ5Tco=:ZJZU2tNYh63sohDrhzLQFe
 9FVVjSjYVnF7D/znlZgEo1kdsoEWPEdPIuGdKGchtwp1d+MjkWDxGlgPJeeQ1KkRiSsOx666c
 gkFteogeA4EM9uS4wJopoj748eOw+LbaLcOxHYCbpgY7YSU9AymuHTO9qHl/VZWKmStynCft4
 IXDzTbXOzwkYegZx4mP6+GPfFqt/Cft1ZHm+35Xb5GKpnXRD214ubDjprQ/2b4IMtPFM9x6si
 1x/2RJ4008VbWL6ev9IW8yR1revakLvJgSQ1Y9lj9YyukT98l9O2wuBkgvopdXqpaZOPsY/Zl
 TTPb8WSJxN/j2nrlCDOhpqOHBkxRIafbcD+gE88ZLEII5r8FLsJlsxgx8fEs/IXXsjRZC5zcF
 oXIeMs09fybv+66eC2Tw6fUU0fR2ou4ACl3FomN6tAZcVmjdsHG1wzZqmwnS2+oo0DixBlo4b
 yPIy9kn7eNDRuocCIzjVtuoDcUfJqIL1pfDjwcYvJkQ0Ts0bVR6rBDjN1AbECqaVTvKAQ3oSn
 s9wc3yJ+24Zk/DYZqG1h8Tisy7lPvX/eOFTZ1IpRgIjXv9R7PzjJXOg1pN2Wqi5veo9mwoQ/T
 2Lyuz8o79d4lQ0ZNrELN0QL96FG8H4SM+2OHXhFB5HJKQFoM7K3mpR4iAhu5Moh1QD67cGRPI
 Mv4eJ8u+Vf6Za+uO74hC/IMLqRIadD8pLl7iIkG6Gznfup8a/zuTuIioFSB/M479n8f6zFBXv
 gFTyhalDr3P66gqdava4K/Pazhr0yz+xGERaFRuexnJvpg7L8r9vwQkiH94JNza7+oQXmsCJ1
 YkWshFmkrNnUOMolZKl19pqWoILES5/YrbAzn/LDS7Fn72VKFX1aUQ9nfW+vIZWrgmAY3TRs1
 zXmW5JikUeZ4k5plWETIEfsr3/vcE0kVmyfR53O0poTH4vXGXQ+2Sl2Ya/7m75Wu6YcCSxNkg
 +plhPvMFFZfisjhtANpIyKs31QxOiVEorE0qnLF7mqvKPBggeOX3JNVTPJFVmlDOSxHy+YFJW
 ddZijG60jO4KVB/NnB0jXT/Yj1jRGzIP02tj0A+g//Xz1625EcedVtjn8HONFSMohjdz81M8D
 R4d3RB8Z9F5uXN6ecHXwiKWdMWSOLkQ7bkmgnGYrFayBrtYmWRLiVLHaw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/22 14:45, Masahiro Yamada wrote:
> On Thu, Aug 18, 2022 at 5:59 AM Randy Dunlap <rdunlap@infradead.org> wro=
te:
>>
>> Hi--
>>
>> On 6/23/21 13:33, Helge Deller wrote:
>>> * Masahiro Yamada <masahiroy@kernel.org>:
>>>> On Thu, Jun 10, 2021 at 4:04 PM Helge Deller <deller@gmx.de> wrote:
>>>>>
>>>>> Hi Masahiro,
>>>>>
>>>>> On 6/10/21 4:03 AM, Masahiro Yamada wrote:
>>>>>> On Thu, Jun 10, 2021 at 7:50 AM Helge Deller <deller@gmx.de> wrote:
>>
>> [snip]
>>
>>>>>> But, please keep in mind that there is an issue remaining.
>>>>>>
>>>>>> Please see this code:
>>>>>>
>>>>>> ifdef CONFIG_64BIT
>>>>>> UTS_MACHINE :=3D parisc64
>>>>>> CHECKFLAGS +=3D -D__LP64__=3D1
>>>>>> CC_ARCHES =3D hppa64
>>>>>> LD_BFD :=3D elf64-hppa-linux
>>>>>> else # 32-bit
>>>>>> CC_ARCHES =3D hppa hppa2.0 hppa1.1
>>>>>> LD_BFD :=3D elf32-hppa-linux
>>>>>> endif
>>>>>>
>>>>>>
>>>>>> UTS_MACHINE is determined by CONFIG_64BIT.
>>>>>>
>>>>>> CONFIG_64BIT is defined only after Kconfig is finished.
>>>>>> When you are trying to configure the .config,
>>>>>> CONFIG_64BIT is not defined yet.
>>>>>> So UTS_MACHINE is always 'parisc'.
>>>>>
>>>>> Yes.
>>>>> See above, but it worked when I had SUBARCH=3Dx86 (when running my l=
aptop).
>>>>>
>>>>>
>>>>>> As you know, Kconfig files now have a bunch of 'cc-option' syntax
>>>>>> to check the compiler capability in Kconfig time.
>>>>>> Hence, you need to provide a proper compiler in Kconfig time too.
>>>>>>
>>>>>> When you build a 64-bit parisc kernel on a 32-bit parisc machine,
>>>>>
>>>>> Please note, that we don't have a 64-bit parisc userspace yet (just =
kernel).
>>>>> This means, that all builds on parisc machines are 32bit and do a
>>>>> cross-compilation to a parisc64 kernel if requested in the .config.
>>>>>
>>>>>> Kconfig is passed with CC=3Dgcc since SUBARCH=3D=3DUTS_MACHINE=3D=
=3Dparisc.
>>>>>> After Kconfig, CROSS_COMPILE=3Dhppa64-* is set,
>>>>>> and the kernel is built by CC=3Dhppa64-*-gcc.
>>>>>
>>>>> Right. That is the old behaviour. Based on the CONFIG_64BIT option
>>>>> the hppa64 compiler is choosen for CROSS_COMPILE.
>>>>>
>>>>>> So, Kconfig evaluated a compiletely different compiler. This is poi=
ntless.
>>>>>
>>>>> Yes, probably.
>>>>>
>>>>>
>>>>>> There are some options
>>>>>>
>>>>>> [option 1]
>>>>>>    revert the parisc bit of 23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f=
3
>>>>>>    This will restore the functionality you may want, but
>>>>>>    as I said above, Kconfig is doing pointless things.
>>>>>
>>>>> as mentioned above: Doesn't solve the issue.
>>>>>
>>>>>> [option 2]
>>>>>>     Stop using cc-cross-prefix, and pass CROSS_COMPILE explicitly.
>>>>>>     This is what many architectures including arm, arm64 do.
>>>>>>     You need to explicitly pass CROSS_COMPILE=3Daarch64-linux-gnu- =
etc.
>>>>>>     if you are cross-compiling arm64.
>>>>>
>>>>> Might be an option, but it's not as handy as simply choosing CONFIG_=
64BIT
>>>>> and then things are done automatically.
>>>>>
>>>>>> [option 3]
>>>>>>     Introduce ARCH=3Dparisc64.
>>>>>>
>>>>>>     When you are building 64-bit kernel, you can pass ARCH=3Dparisc=
64
>>>>>>      A patch attached.  (but not tested much)
>>>>>
>>>>> Tried it, but doesn't work.
>>>>> asm-offsets.c is still preprocessed with 32bit compiler (gcc, not hp=
pa20-gcc).
>>>>>
>>>>> Thanks for your help so far!
>>>>> If you like I'm happy to give you an account on a hppa64 machine to =
reproduce yourself.
>>>>> I'll now try to bisect where it goes wrong. There must be something =
else before commit 23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3.
>>>>>
>>>>> Helge
>>>>
>>>>
>>>> Sorry for my late reply.
>>>
>>> Me too.... :-(
>>
>> Sorry to jump in even later, but:
>>
>> I see that
>> $ make ARCH=3Dparisc64 defconfig
>> does set CONFIG_64BIT.
>
> Strange. It does for me.
> masahiro@grover:~/ref/linux-next$ make ARCH=3Dparisc64 defconfig
> *** Default configuration is based on 'generic-64bit_defconfig'
> #
> # configuration written to .config
> #
> masahiro@grover:~/ref/linux-next$ grep CONFIG_64BIT .config
> CONFIG_64BIT=3Dy

Yes, as Randy said, this works.

>> Is there a way to do
>> $ make ARCH=3Dparisc64 allmodconfig
>> ?
>> That does not set CONFIG_64BIT in my testing.
>> (testing on linux-next-20220817)
>
> Right.
> allmodconfig does not set CONFIG_64BIT.
>
> I think it is the same as before.

Yep.

> Is this thread related?

What thread?

> The reason is 64BIT depends on PA8X00.
>
> allmodconfig chooses PA7000 instead of PA8X00
> in the "Processor type" choice since
> PA7000 is the default.
>
>
> If you apply this patch,
>
>
>
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index 7f059cd1196a..458b8e22e240 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -146,7 +146,7 @@ menu "Processor type and features"
>
>  choice
>         prompt "Processor type"
> -       default PA7000
> +       default PA8X00
>
>  config PA7000
>         bool "PA7000/PA7100"
>
> allmodconfig will start enabling CONFIG_64BIT,
> but it is up to Helge.

That patch "partly" works, in the sense that with:
make ARCH=3Dparisc64 randconfig

you randomly end up with a 32- or 64-bit kernel.
Since "ARCH=3Dparisc64" was given, one probably would expect a 64-bit-enab=
led kernel randconfig,
and with "ARCH=3Dparisc" a 32-bit randconfig.
But, I'm not sure if this intended or not and works that way on other arch=
es as well.

As written in the other mail, I added this patch in for-next:
https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/co=
mmit/?h=3Dfor-next&id=3D34793a5d09d9122f90acfa7e8f705436d5090d4d
The downside is, you need to give a special make target: parisc_randconfig=
 / parisc64_randconfig

Helge

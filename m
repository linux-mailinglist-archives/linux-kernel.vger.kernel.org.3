Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C558E59A4C4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351065AbiHSRZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354365AbiHSRYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:24:47 -0400
X-Greylist: delayed 14226 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 Aug 2022 09:43:25 PDT
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2102F2A420;
        Fri, 19 Aug 2022 09:43:22 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 27JGglHP002479;
        Sat, 20 Aug 2022 01:42:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 27JGglHP002479
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660927368;
        bh=h7OmFP1TiZFyRr7AGv+JjBTsh1N6E7QDmJegzzSKDiI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VabyWCEV+KJIDLTy8yBPX+58uLMlGyWW7b9gj7/wJweZY0NikB3cyPiWZqQf7ZE7y
         PS2KjYClNqRKWLvguRsUVUruHk2uxV4IYdzdyK1/NHo6mMEZQdyWT1Xjik1Wge+67x
         ZyLiVuapZOOlxJ9KlYSBXRN+H/YgUeX2azip060zHmBEKxl/90zp6wXwxAz0CWT/r1
         d+3ikPvhCCpVRad+Nv9nhWXT98PPJfXkQkaqR1MtUSPakduWz6XW+Vx3F/PvN3+lTZ
         NcM6INJCGSkkNuG13yc4c5Ewzq1nVlmrDCXV31UMeyMPJn5DFO0t5GSzZ/mv+iNOer
         mYCa6LBHd4/EA==
X-Nifty-SrcIP: [209.85.221.51]
Received: by mail-wr1-f51.google.com with SMTP id a4so5815698wrq.1;
        Fri, 19 Aug 2022 09:42:47 -0700 (PDT)
X-Gm-Message-State: ACgBeo2jzWI5Xp6HqlXmTHsrVdHFg7Dz/Sn4O6z8rvsAwFZROZBu4EKh
        aLvr4ErZzVgeEKwiVqMDK7zhaJIZnjZZE51f+4U=
X-Google-Smtp-Source: AA6agR6ByMmA6Wfv9XMFk9epGaqy3qR2C9LBhvwMLUGWLPSSbgV9cf9nRAPxhnnunD4VQ2NPs1vequQMcVC6syvESxc=
X-Received: by 2002:a5d:6d89:0:b0:225:16c2:6816 with SMTP id
 l9-20020a5d6d89000000b0022516c26816mr4800644wrs.380.1660927366317; Fri, 19
 Aug 2022 09:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <892b6ab7-862c-1c0a-2996-0f8408e5043d@linux.ee>
 <89515325-fc21-31da-d238-6f7a9abbf9a0@gmx.de> <CAK7LNATuzry1MUj-VruOVUwU_nH2xJd_2SxD_s_Z1QBb3PVnQw@mail.gmail.com>
 <5dfd81eb-c8ca-b7f5-e80e-8632767c022d@gmx.de> <CAK7LNATO_30uHzAe-Vsy+hgu=wwEN_aPGET4Ys78rc3=nSuJsg@mail.gmail.com>
 <YNOafsB81ZcP2r7z@ls3530> <f599c358-815f-088e-f2aa-b064ccb64e44@infradead.org>
 <CAK7LNAREcSW2Hn3Ty_zTVzTCLgYnFfo=ZcibE2zif1mBWp==4A@mail.gmail.com> <39ee0ca2-48a0-755b-605c-3ce1205b9715@gmx.de>
In-Reply-To: <39ee0ca2-48a0-755b-605c-3ce1205b9715@gmx.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 20 Aug 2022 01:41:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQceFhO1-vupRAJy3rU+p+MK97vRuswVXvVEgF7q0akDA@mail.gmail.com>
Message-ID: <CAK7LNAQceFhO1-vupRAJy3rU+p+MK97vRuswVXvVEgF7q0akDA@mail.gmail.com>
Subject: Re: linux-parisc compile failure in current git
To:     Helge Deller <deller@gmx.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Meelis Roos <mroos@linux.ee>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 10:56 PM Helge Deller <deller@gmx.de> wrote:
>
> On 8/19/22 14:45, Masahiro Yamada wrote:
> > On Thu, Aug 18, 2022 at 5:59 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> Hi--
> >>
> >> On 6/23/21 13:33, Helge Deller wrote:
> >>> * Masahiro Yamada <masahiroy@kernel.org>:
> >>>> On Thu, Jun 10, 2021 at 4:04 PM Helge Deller <deller@gmx.de> wrote:
> >>>>>
> >>>>> Hi Masahiro,
> >>>>>
> >>>>> On 6/10/21 4:03 AM, Masahiro Yamada wrote:
> >>>>>> On Thu, Jun 10, 2021 at 7:50 AM Helge Deller <deller@gmx.de> wrote:
> >>
> >> [snip]
> >>
> >>>>>> But, please keep in mind that there is an issue remaining.
> >>>>>>
> >>>>>> Please see this code:
> >>>>>>
> >>>>>> ifdef CONFIG_64BIT
> >>>>>> UTS_MACHINE := parisc64
> >>>>>> CHECKFLAGS += -D__LP64__=1
> >>>>>> CC_ARCHES = hppa64
> >>>>>> LD_BFD := elf64-hppa-linux
> >>>>>> else # 32-bit
> >>>>>> CC_ARCHES = hppa hppa2.0 hppa1.1
> >>>>>> LD_BFD := elf32-hppa-linux
> >>>>>> endif
> >>>>>>
> >>>>>>
> >>>>>> UTS_MACHINE is determined by CONFIG_64BIT.
> >>>>>>
> >>>>>> CONFIG_64BIT is defined only after Kconfig is finished.
> >>>>>> When you are trying to configure the .config,
> >>>>>> CONFIG_64BIT is not defined yet.
> >>>>>> So UTS_MACHINE is always 'parisc'.
> >>>>>
> >>>>> Yes.
> >>>>> See above, but it worked when I had SUBARCH=x86 (when running my laptop).
> >>>>>
> >>>>>
> >>>>>> As you know, Kconfig files now have a bunch of 'cc-option' syntax
> >>>>>> to check the compiler capability in Kconfig time.
> >>>>>> Hence, you need to provide a proper compiler in Kconfig time too.
> >>>>>>
> >>>>>> When you build a 64-bit parisc kernel on a 32-bit parisc machine,
> >>>>>
> >>>>> Please note, that we don't have a 64-bit parisc userspace yet (just kernel).
> >>>>> This means, that all builds on parisc machines are 32bit and do a
> >>>>> cross-compilation to a parisc64 kernel if requested in the .config.
> >>>>>
> >>>>>> Kconfig is passed with CC=gcc since SUBARCH==UTS_MACHINE==parisc.
> >>>>>> After Kconfig, CROSS_COMPILE=hppa64-* is set,
> >>>>>> and the kernel is built by CC=hppa64-*-gcc.
> >>>>>
> >>>>> Right. That is the old behaviour. Based on the CONFIG_64BIT option
> >>>>> the hppa64 compiler is choosen for CROSS_COMPILE.
> >>>>>
> >>>>>> So, Kconfig evaluated a compiletely different compiler. This is pointless.
> >>>>>
> >>>>> Yes, probably.
> >>>>>
> >>>>>
> >>>>>> There are some options
> >>>>>>
> >>>>>> [option 1]
> >>>>>>    revert the parisc bit of 23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3
> >>>>>>    This will restore the functionality you may want, but
> >>>>>>    as I said above, Kconfig is doing pointless things.
> >>>>>
> >>>>> as mentioned above: Doesn't solve the issue.
> >>>>>
> >>>>>> [option 2]
> >>>>>>     Stop using cc-cross-prefix, and pass CROSS_COMPILE explicitly.
> >>>>>>     This is what many architectures including arm, arm64 do.
> >>>>>>     You need to explicitly pass CROSS_COMPILE=aarch64-linux-gnu- etc.
> >>>>>>     if you are cross-compiling arm64.
> >>>>>
> >>>>> Might be an option, but it's not as handy as simply choosing CONFIG_64BIT
> >>>>> and then things are done automatically.
> >>>>>
> >>>>>> [option 3]
> >>>>>>     Introduce ARCH=parisc64.
> >>>>>>
> >>>>>>     When you are building 64-bit kernel, you can pass ARCH=parisc64
> >>>>>>      A patch attached.  (but not tested much)
> >>>>>
> >>>>> Tried it, but doesn't work.
> >>>>> asm-offsets.c is still preprocessed with 32bit compiler (gcc, not hppa20-gcc).
> >>>>>
> >>>>> Thanks for your help so far!
> >>>>> If you like I'm happy to give you an account on a hppa64 machine to reproduce yourself.
> >>>>> I'll now try to bisect where it goes wrong. There must be something else before commit 23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3.
> >>>>>
> >>>>> Helge
> >>>>
> >>>>
> >>>> Sorry for my late reply.
> >>>
> >>> Me too.... :-(
> >>
> >> Sorry to jump in even later, but:
> >>
> >> I see that
> >> $ make ARCH=parisc64 defconfig
> >> does set CONFIG_64BIT.
> >
> > Strange. It does for me.
> > masahiro@grover:~/ref/linux-next$ make ARCH=parisc64 defconfig
> > *** Default configuration is based on 'generic-64bit_defconfig'
> > #
> > # configuration written to .config
> > #
> > masahiro@grover:~/ref/linux-next$ grep CONFIG_64BIT .config
> > CONFIG_64BIT=y
>
> Yes, as Randy said, this works.
>
> >> Is there a way to do
> >> $ make ARCH=parisc64 allmodconfig
> >> ?
> >> That does not set CONFIG_64BIT in my testing.
> >> (testing on linux-next-20220817)
> >
> > Right.
> > allmodconfig does not set CONFIG_64BIT.
> >
> > I think it is the same as before.
>
> Yep.
>
> > Is this thread related?
>
> What thread?


This thread ("linux-parisc compile failure in current git")
was posted more than a year ago.

If you start a new discussion,
let's open a new thread with a proper mail subject.




>
> > The reason is 64BIT depends on PA8X00.
> >
> > allmodconfig chooses PA7000 instead of PA8X00
> > in the "Processor type" choice since
> > PA7000 is the default.
> >
> >
> > If you apply this patch,
> >
> >
> >
> > diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> > index 7f059cd1196a..458b8e22e240 100644
> > --- a/arch/parisc/Kconfig
> > +++ b/arch/parisc/Kconfig
> > @@ -146,7 +146,7 @@ menu "Processor type and features"
> >
> >  choice
> >         prompt "Processor type"
> > -       default PA7000
> > +       default PA8X00
> >
> >  config PA7000
> >         bool "PA7000/PA7100"
> >
> > allmodconfig will start enabling CONFIG_64BIT,
> > but it is up to Helge.
>
> That patch "partly" works, in the sense that with:
> make ARCH=parisc64 randconfig
>
> you randomly end up with a 32- or 64-bit kernel.
> Since "ARCH=parisc64" was given, one probably would expect a 64-bit-enabled kernel randconfig,
> and with "ARCH=parisc" a 32-bit randconfig.
> But, I'm not sure if this intended or not and works that way on other arches as well.


Ah, OK.

Then, you can mimic sparc code.





In the top Makefile:


ifeq ($(ARCH),sparc32)
       SRCARCH := sparc
endif
ifeq ($(ARCH),sparc64)
       SRCARCH := sparc
endif




In arch/sparc/Kconfig:


config 64BIT
        bool "64-bit kernel" if "$(ARCH)" = "sparc"
        default "$(ARCH)" = "sparc64"





"make ARCH=sparc32 randconfig" always disables
CONFIG_64BIT, and randomizes the rest of options.


"make ARCH=sparc64 randconfig" always enables
CONFIG_64BIT, and randomizes the rest of options.


"make ARCH=sparc randconfig" randomizes all options,
including CONFIG_64BIT.





I suggest to introduce ARCH=parisc32





>
> As written in the other mail, I added this patch in for-next:
> https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?h=for-next&id=34793a5d09d9122f90acfa7e8f705436d5090d4d
> The downside is, you need to give a special make target: parisc_randconfig / parisc64_randconfig
>
> Helge



-- 
Best Regards
Masahiro Yamada

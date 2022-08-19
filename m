Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2679C599C74
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349060AbiHSMqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348552AbiHSMqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:46:19 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A77FD2B26
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:46:17 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 27JCju1l019353;
        Fri, 19 Aug 2022 21:45:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 27JCju1l019353
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660913158;
        bh=JMY2MPKM9JyScY3XQCjlJdcr/O0QREUcVVhTTkTMqqc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gR/n065C7EQC7Ze1gfIVtYHPwbzK8gbbTMqfwnr44fGYxwxU1mEcUls1JdOf9UEaj
         wfClfXGvbL79g5hEFRyGeegXBH6vHq9x3dVA2zDSrgGQtSX1Npnl3hYDhJ7L4gvZ8N
         +CzwCh7h5O7vg24DLZWq4nVyY9IQ7Ld+36srWGXFquqpwhWeJeISiSxrYHqOLNbCQW
         oRLWNeAVKwOdKmy/3WLI0qpVQd7Xmpk0YeiKAEOW/F0SIji5vzdV+GxUHU5OTCyzDD
         sL8e4rm7PmI74nQlmpef0EryEn8NWq2UkRjOKou/A93wvpvXKfflcH8JiBrZm/Ymyp
         MStYPRVTe3drw==
X-Nifty-SrcIP: [209.85.128.41]
Received: by mail-wm1-f41.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so977661wmk.3;
        Fri, 19 Aug 2022 05:45:57 -0700 (PDT)
X-Gm-Message-State: ACgBeo26z0ukAASba5Z+3w8MwJBnYDwQcAwQQNlfwIPY5B5ovugW3WLR
        nM+GS1kGcegTsVhW2Z9aaf0pcZVS5CAb2ecjQzI=
X-Google-Smtp-Source: AA6agR77yKJLCnBSr+TKRNvoeR6wcLRSdlktRLs2iwmRq0Cep1GBY04NCj3oZjJReIjk4matMmh6cQ7gSSASyYJ/Ebg=
X-Received: by 2002:a05:600c:1c23:b0:3a5:d936:e5bb with SMTP id
 j35-20020a05600c1c2300b003a5d936e5bbmr4455812wms.59.1660913155712; Fri, 19
 Aug 2022 05:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <892b6ab7-862c-1c0a-2996-0f8408e5043d@linux.ee>
 <89515325-fc21-31da-d238-6f7a9abbf9a0@gmx.de> <CAK7LNATuzry1MUj-VruOVUwU_nH2xJd_2SxD_s_Z1QBb3PVnQw@mail.gmail.com>
 <5dfd81eb-c8ca-b7f5-e80e-8632767c022d@gmx.de> <CAK7LNATO_30uHzAe-Vsy+hgu=wwEN_aPGET4Ys78rc3=nSuJsg@mail.gmail.com>
 <YNOafsB81ZcP2r7z@ls3530> <f599c358-815f-088e-f2aa-b064ccb64e44@infradead.org>
In-Reply-To: <f599c358-815f-088e-f2aa-b064ccb64e44@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 19 Aug 2022 21:45:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAREcSW2Hn3Ty_zTVzTCLgYnFfo=ZcibE2zif1mBWp==4A@mail.gmail.com>
Message-ID: <CAK7LNAREcSW2Hn3Ty_zTVzTCLgYnFfo=ZcibE2zif1mBWp==4A@mail.gmail.com>
Subject: Re: linux-parisc compile failure in current git
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Helge Deller <deller@gmx.de>,
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

On Thu, Aug 18, 2022 at 5:59 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi--
>
> On 6/23/21 13:33, Helge Deller wrote:
> > * Masahiro Yamada <masahiroy@kernel.org>:
> >> On Thu, Jun 10, 2021 at 4:04 PM Helge Deller <deller@gmx.de> wrote:
> >>>
> >>> Hi Masahiro,
> >>>
> >>> On 6/10/21 4:03 AM, Masahiro Yamada wrote:
> >>>> On Thu, Jun 10, 2021 at 7:50 AM Helge Deller <deller@gmx.de> wrote:
>
> [snip]
>
> >>>> But, please keep in mind that there is an issue remaining.
> >>>>
> >>>> Please see this code:
> >>>>
> >>>> ifdef CONFIG_64BIT
> >>>> UTS_MACHINE := parisc64
> >>>> CHECKFLAGS += -D__LP64__=1
> >>>> CC_ARCHES = hppa64
> >>>> LD_BFD := elf64-hppa-linux
> >>>> else # 32-bit
> >>>> CC_ARCHES = hppa hppa2.0 hppa1.1
> >>>> LD_BFD := elf32-hppa-linux
> >>>> endif
> >>>>
> >>>>
> >>>> UTS_MACHINE is determined by CONFIG_64BIT.
> >>>>
> >>>> CONFIG_64BIT is defined only after Kconfig is finished.
> >>>> When you are trying to configure the .config,
> >>>> CONFIG_64BIT is not defined yet.
> >>>> So UTS_MACHINE is always 'parisc'.
> >>>
> >>> Yes.
> >>> See above, but it worked when I had SUBARCH=x86 (when running my laptop).
> >>>
> >>>
> >>>> As you know, Kconfig files now have a bunch of 'cc-option' syntax
> >>>> to check the compiler capability in Kconfig time.
> >>>> Hence, you need to provide a proper compiler in Kconfig time too.
> >>>>
> >>>> When you build a 64-bit parisc kernel on a 32-bit parisc machine,
> >>>
> >>> Please note, that we don't have a 64-bit parisc userspace yet (just kernel).
> >>> This means, that all builds on parisc machines are 32bit and do a
> >>> cross-compilation to a parisc64 kernel if requested in the .config.
> >>>
> >>>> Kconfig is passed with CC=gcc since SUBARCH==UTS_MACHINE==parisc.
> >>>> After Kconfig, CROSS_COMPILE=hppa64-* is set,
> >>>> and the kernel is built by CC=hppa64-*-gcc.
> >>>
> >>> Right. That is the old behaviour. Based on the CONFIG_64BIT option
> >>> the hppa64 compiler is choosen for CROSS_COMPILE.
> >>>
> >>>> So, Kconfig evaluated a compiletely different compiler. This is pointless.
> >>>
> >>> Yes, probably.
> >>>
> >>>
> >>>> There are some options
> >>>>
> >>>> [option 1]
> >>>>    revert the parisc bit of 23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3
> >>>>    This will restore the functionality you may want, but
> >>>>    as I said above, Kconfig is doing pointless things.
> >>>
> >>> as mentioned above: Doesn't solve the issue.
> >>>
> >>>> [option 2]
> >>>>     Stop using cc-cross-prefix, and pass CROSS_COMPILE explicitly.
> >>>>     This is what many architectures including arm, arm64 do.
> >>>>     You need to explicitly pass CROSS_COMPILE=aarch64-linux-gnu- etc.
> >>>>     if you are cross-compiling arm64.
> >>>
> >>> Might be an option, but it's not as handy as simply choosing CONFIG_64BIT
> >>> and then things are done automatically.
> >>>
> >>>> [option 3]
> >>>>     Introduce ARCH=parisc64.
> >>>>
> >>>>     When you are building 64-bit kernel, you can pass ARCH=parisc64
> >>>>      A patch attached.  (but not tested much)
> >>>
> >>> Tried it, but doesn't work.
> >>> asm-offsets.c is still preprocessed with 32bit compiler (gcc, not hppa20-gcc).
> >>>
> >>> Thanks for your help so far!
> >>> If you like I'm happy to give you an account on a hppa64 machine to reproduce yourself.
> >>> I'll now try to bisect where it goes wrong. There must be something else before commit 23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3.
> >>>
> >>> Helge
> >>
> >>
> >> Sorry for my late reply.
> >
> > Me too.... :-(
>
> Sorry to jump in even later, but:
>
> I see that
> $ make ARCH=parisc64 defconfig
> does set CONFIG_64BIT.




Strange. It does for me.



masahiro@grover:~/ref/linux-next$ make ARCH=parisc64 defconfig
*** Default configuration is based on 'generic-64bit_defconfig'
#
# configuration written to .config
#
masahiro@grover:~/ref/linux-next$ grep CONFIG_64BIT .config
CONFIG_64BIT=y










> Is there a way to do
> $ make ARCH=parisc64 allmodconfig
> ?
> That does not set CONFIG_64BIT in my testing.
> (testing on linux-next-20220817)


Right.
allmodconfig does not set CONFIG_64BIT.

I think it is the same as before.
Is this thread related?



The reason is 64BIT depends on PA8X00.

allmodconfig chooses PA7000 instead of PA8X00
in the "Processor type" choice since
PA7000 is the default.


If you apply this patch,



diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 7f059cd1196a..458b8e22e240 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -146,7 +146,7 @@ menu "Processor type and features"

 choice
        prompt "Processor type"
-       default PA7000
+       default PA8X00

 config PA7000
        bool "PA7000/PA7100"





allmodconfig will start enabling CONFIG_64BIT,
but it is up to Helge.




> I would like to have a command-line method to do that,
> without editing the .config file.
>
> Thanks.
> --
> ~Randy



-- 
Best Regards
Masahiro Yamada

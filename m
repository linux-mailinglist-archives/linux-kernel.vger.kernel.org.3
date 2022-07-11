Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA7A56D468
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 07:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiGKFwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 01:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGKFwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 01:52:07 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D28D15A16;
        Sun, 10 Jul 2022 22:52:05 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 26B5pbZA022952;
        Mon, 11 Jul 2022 14:51:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 26B5pbZA022952
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1657518698;
        bh=nJdtwmIgrVPA0dtmVpPR8fp9Vk3EMrRlmk8wkbLbI2w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=obxUlw7OF194lDxjAIa3n2rN6jPm7eELxwBq6iY3pQGba6zF0OcdR1XxugDvxyFdn
         +cmOr74FTMVs+0gU6uh+hcByvVNbJR8I2QYpwNhtru9eOhOb5FvUfpouviOF1Ewh/7
         oUpUvtwgcrMQvOhvJXXvRZENbaNQlTlJuvJDfmx+In98EK0xbxFuVHn0aEKVWOkEZV
         lDThjLUdHlO8B06R7ZjtNJ7RtSYnNCaq7RIPT0TjsE6LmIt9kyQ44z/5HFtocPlBl/
         BFWzF9ER7I9ccZIj0anEW4mmBTouEsiKeqXCfvSr1V2fNVeWtqVDu7T/ODaOT0tV8O
         Vvzpcq9TjBMaw==
X-Nifty-SrcIP: [209.85.128.44]
Received: by mail-wm1-f44.google.com with SMTP id v10-20020a05600c15ca00b003a2db8aa2c4so2387029wmf.2;
        Sun, 10 Jul 2022 22:51:38 -0700 (PDT)
X-Gm-Message-State: AJIora+RyjZ7nF0mWwbOblAS2+jl+buoP5H6mj5tyL8f+pXEz2fOyyL/
        Z/e1AArKLjYluEW9KMHpReMo9/Nl6L85wqqffiQ=
X-Google-Smtp-Source: AGRyM1vsDrLJ6rtJwQeHonOKDhW3TOmc/Pg1e+zzajG3BZKqRdOLhg3kdPsXEWwSsp+e27u8+CqE7x9sWMupfSPLYJ4=
X-Received: by 2002:a05:600c:35d6:b0:3a2:e873:6295 with SMTP id
 r22-20020a05600c35d600b003a2e8736295mr2783183wmq.22.1657518696690; Sun, 10
 Jul 2022 22:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFz2sNBbZyg-_i8_Ldr2e8o9dfvdSfHHuRzVtP2VMAUWPg@mail.gmail.com>
 <20220628210407.3343118-1-ndesaulniers@google.com> <2842572.mvXUDI8C0e@sakura.myxoz.lan>
In-Reply-To: <2842572.mvXUDI8C0e@sakura.myxoz.lan>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 11 Jul 2022 14:50:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNATrgiJX7VGAda4YaXCso2wMufd_X1Q0XMYfG0yGg4mLBw@mail.gmail.com>
Message-ID: <CAK7LNATrgiJX7VGAda4YaXCso2wMufd_X1Q0XMYfG0yGg4mLBw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: drop support for CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3
To:     Miko Larsson <mikoxyzzz@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Chris Down <chris@chrisdown.name>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, X86 ML <x86@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Vineet Gupta <vgupta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 7:48 PM Miko Larsson <mikoxyzzz@gmail.com> wrote:
>
> On Tuesday, 28 June 2022 23:04:07 CEST Nick Desaulniers wrote:
> > The difference in most compilers between `-O3` and `-O2` is mostly down
> > to whether loops with statically determinable trip counts are fully
> > unrolled vs unrolled to a multiple of SIMD width.
> >
> > This patch is effectively a revert of
> > commit 15f5db60a137 ("kbuild,arc: add
> > CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3 for ARC") without re-adding
> > ARCH_CFLAGS
> >
> > Ever since
> > commit cfdbc2e16e65 ("ARC: Build system: Makefiles, Kconfig, Linker
> > script")
> > ARC has been built with -O3, though the reason for doing so was not
> > specified in inline comments or the commit message. This commit does not
> > re-add -O3 to arch/arc/Makefile.
> >
> > Folks looking to experiment with `-O3` (or any compiler flag for that
> > matter) may pass them along to the command line invocation of make:
> >
> > $ make KCFLAGS=-O3
> >
> > Code that looks to re-add an explicit Kconfig option for `-O3` should
> > provide:
> > 1. A rigorous and reproducible performance profile of a reasonable
> >    userspace workload that demonstrates a hot loop in the kernel that
> >    would benefit from `-O3` over `-O2`.
> > 2. Disassembly of said loop body before and after.
> > 3. Provides stats on terms of increase in file size.
> >
>
> Might be worth cleaning up the rest of the kernel of instances of -O3,
> too. -O3 used to build lz4 and mips vdso, for instance. Might be a bit
> of a digression, though


This patch focuses on the removal of CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3,
so I think it is OK as-is.

The rest of cleanups, if needed,
should be submitted separately.




>
> --
> ~miko
>
>


-- 
Best Regards
Masahiro Yamada

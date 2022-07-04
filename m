Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888D7565451
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiGDMHh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Jul 2022 08:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbiGDMHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:07:35 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08AF2AF8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:07:32 -0700 (PDT)
Received: from mail-yw1-f173.google.com ([209.85.128.173]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MWjUc-1o64lt22dE-00X7G7 for <linux-kernel@vger.kernel.org>; Mon, 04 Jul
 2022 14:07:29 +0200
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-31c8340a6f7so39097357b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:07:29 -0700 (PDT)
X-Gm-Message-State: AJIora8aCu6Jv1V2jeGC2QsH19nigiQ87MxgACOj7gXsbq5X4iEbmhnI
        viGWyZiDBsZuMf/4dMdc3E9p+PT9hxDuripuAM8=
X-Google-Smtp-Source: AGRyM1tdip7O5ofNFtvSvIu6DpF5+51ggPWr2utiIY8JDMYNuJUtdzNgCMU5JR7wALsNdPUnX72AuB/jxqr8IHgp8Eo=
X-Received: by 2002:a81:230c:0:b0:31b:f368:d0b0 with SMTP id
 j12-20020a81230c000000b0031bf368d0b0mr32806770ywj.249.1656936448287; Mon, 04
 Jul 2022 05:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220524093939.30927-1-pali@kernel.org> <20220702094405.tp7eo4df7fjvn2ng@pali>
 <8D562851-304F-4153-9194-426CC22B7FF2@ellerman.id.au> <20220704103951.nm4m4kpgnus3ucqo@pali>
In-Reply-To: <20220704103951.nm4m4kpgnus3ucqo@pali>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 Jul 2022 14:07:10 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2tdny8SA7jcqhUZT13iq1mYqjFueC-gnTUZA1JKCtfgg@mail.gmail.com>
Message-ID: <CAK8P3a2tdny8SA7jcqhUZT13iq1mYqjFueC-gnTUZA1JKCtfgg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: e500: Fix compilation with gcc e500 compiler
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Michael Ellerman <michael@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:GpilgNKqm69R1YacwYZlM1F2iCsk+gITlcFJR6a0I2B4llTsjwg
 8UFPMjT9lzDI4Nj/+V9tLHNFpPjXi3h/w2cuBMwFYt+2fsUClZ+pzY5G2k/hy9XrnB00eaL
 TJ/HhS0roon2gAOGNm6KznvIYrwYoGEQduYZ4RjyPJrwBb+gY0tSfAH/h7H6nKjNFTf2j4X
 lO+ZbOa3YYZkQNo1KDXZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ndMVquO8aFg=:3NJVTK6NGTtrdXFlnIdRGd
 aYWdaOKxXB9FY9tUck4EdkwdDPYcwhxvBr0JLvNvvnhZNH3gRPi3rnhGzV9zcuuRkluMnK+g2
 k3y9kx+B0PpCBUfcdfgVQo+dPSZCHqF0DZdN7roEpQriGJBWepAhTttky0n0LZ2hb+eAyFQKG
 EWpLjJLhZDCFUNBo9cDiYQDbJe0l1N0NcawI4SkZJDOMFdoGoYzRnCCnBq3aAJVMQ6gN/tB/L
 2BWenFstxxWZiTbL9W2duq3W9gl/sSTLJr32x3+pkP684XABbo9GG/FdUdI+jTKlARzxEhuaR
 jo8OYWbzc8FZKymk+NRd0nNoGI2TlVGWZ8sLUMKrlGZEI/rR4U9vbe1Kh0aY0LKdrfl6Ml39m
 W5cXt+CeCuQYTgaGCOP68EYCHNG3qRtewxDfMb+Gn1VtxNfJqLE57fEjz8eUbA4XF6R5E0vh+
 FJGNO+g7a/YHEV2NPlSXUoGU/NAkCZL6Yjs8zGPxYj4MYt9h9kORRXrE9XCTCSMnstU79gLCN
 cIa+Cz6aakX/Mcml6JbMX7anCqYSKapGJfNYUKuJs5CaA//llOzU6c668vWDDaRNvDzElYxD/
 NDAQDdACvBneSnRuSkBTq7x5xNZCrPjoHpkNup5YC3PyZo6tjS7W5WNF+UH+sZd0FC1miw19h
 fGn3uw70+tg9/QJofCvQ9RIi6Bg+M/8Sw9tXansftYt4TDLBBPu1aq4Le/QBtE5nCBDrZTNlN
 eX6AMYWeY11Q3HeUmehxgDc8oRWLdrSBFq4Y/g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 4, 2022 at 12:39 PM Pali Rohár <pali@kernel.org> wrote:
> On Monday 04 July 2022 20:23:29 Michael Ellerman wrote:
> > On 2 July 2022 7:44:05 pm AEST, "Pali Rohár" <pali@kernel.org> wrote:
> > >On Tuesday 24 May 2022 11:39:39 Pali Rohár wrote:
> > >> gcc e500 compiler does not support -mcpu=powerpc option. When it is
> > >> specified then gcc throws compile error:
> > >>
> > >>   gcc: error: unrecognized argument in option ‘-mcpu=powerpc’
> > >>   gcc: note: valid arguments to ‘-mcpu=’ are: 8540 8548 native
> > >>
> > >> So do not set -mcpu=powerpc option when CONFIG_E500 is set. Correct option
> > >> -mcpu=8540 for CONFIG_E500 is set few lines below in that Makefile.
> > >>
> > >> Signed-off-by: Pali Rohár <pali@kernel.org>
> > >> Cc: stable@vger.kernel.org
> > >
> > >Michael, do you have any objections about this patch?
> >
> > I don't particularly like it :)
> >
> > From the discussion with Segher, it sounds like this is a problem with a specific build of gcc that you're using, not a general problem with gcc built with e500 support.
>
> Well, the "full" build of gcc for e500 cores with SPE does not support
> -mcpu=powerpc option. So I think this is a general problem. I do not
> think that this is "specific build" as this is the correct build of gcc
> for these processors with e500 cores.
>
> "stripped". build of gcc without SPE support for e500 cores does not
> have this problem...

I can see a couple of problems with the CPU selection, but I don't think
this is a major one, as nobody should be using those SPE compilers for
building the kernel. Just use a modern powerpc-gcc build.

> > Keying it off CONFIG_E500 means it will fix your problem, but not anyone else who has a different non-e500 compiler that also doesn't support -mcpu=powerpc (for whatever reason).
> >
> > So I wonder if a better fix is to use cc-option when setting -mcpu=powerpc.
> >
>
> Comment for that code which adds -mpcu=powerpc says:
>
>   they are needed to set a sane 32-bit cpu target for the 64-bit cross
>   compiler which may default to the wrong ISA.
>
> So I'm not sure how to handle this in other way. GCC uses -mpcu=8540
> option for specifying to compile code for e500 cores and seems that
> -mcpu=8540 is supported by all e500 compilers...
>
> Few lines below is code
>
>   CFLAGS-$(CONFIG_E500) += $(call cc-option,-mcpu=8540 -msoft-float,-mcpu=powerpc)
>
> which for e500 kernel builds user either -mcpu=8540 or -mcpu=powerpc
> (probably as a fallback if -mcpu=8540 is not supported).

The -mcpu=powerpc fallback can probably be skipped here, that must have been
for compilers predating the addition of -mcpu=8540, and even the oldest ones
support that now.

> So for me it looks like that problematic code
>
>   KBUILD_CFLAGS         += -mcpu=powerpc
>   KBUILD_AFLAGS         += -mcpu=powerpc
>
> needs to be somehow skipped when compiling for CONFIG_E500.
>> My change which skips that code base on ifndef CONFIG_E500 should be
> fine as when CONFIG_E500 is disabled it does nothing and when it is
> enabled then code
>
>   CFLAGS-$(CONFIG_E500) += $(call cc-option,-mcpu=8540 -msoft-float,-mcpu=powerpc)
>
> is called which sets -mcpu option suitable for e500.

I think this part is indeed fishy, but adding another special case for E500
seems to take it in the wrong direction.

Nick added this in 4bf4f42a2feb ("powerpc/kbuild: Set default generic
machine type
for 32-bit compile") as a compile-time fix to prevent the default target from
getting used when the compiler supports both 64-bit and 32-bit. This is the
right idea, but it's inconsistent to pass different flags depending on the type
of toolchain, and it loses the more specific options.

Another problem I see is that a kernel that is built for both E500 and E500MC
uses -mcpu=e500mc and may not actually work on the older ones either
(even with your patch).

I think what you actually want is to set one option for each of the
possible CPU types:

CFLAGS_CPU-$(CONFIG_PPC_BOOK3S_32) := -mcpu=powerpc
CFLAGS_CPU-$(CONFIG_PPC_85xx) := -mcpu=8540
CFLAGS_CPU-$(CONFIG_PPC8xx) := -mcpu=860
CFLAGS_CPU-$(CONFIG_PPC44x) := -mcpu=440
CFLAGS_CPU-$(CONFIG_PPC40x) := -mcpu=405
ifdef CONFIG_CPU_LITTLE_ENDIAN
CFLAGS_CPU-$(CONFIG_BOOK3S_64) := -mcpu=power8
else
CFLAGS_CPU-$(CONFIG_BOOK3S_64) := -mcpu=power5
endif
CFLAGS_CPU-$(CONFIG_BOOK3E_64) := -mcpu=powerpc64

For the non-generic CPU types, there is also CONFIG_TARGET_CPU,
and the list above could just get folded into that instead.

       Arnd

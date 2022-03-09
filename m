Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEDD4D2BA4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiCIJUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiCIJUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:20:18 -0500
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17318D687;
        Wed,  9 Mar 2022 01:19:19 -0800 (PST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2299J1WV016568;
        Wed, 9 Mar 2022 18:19:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2299J1WV016568
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1646817542;
        bh=7ptQH0F5J9d2jeE9K6DKb/RLQ+CHx4kcW97GHNeRP3w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T4cDgIb4RLnxUgURlNEoy0XiX1b5w5wP2ymh2l/tihLJRfcawn5UOwTbwaVfKs1yf
         aO99wh2upm1yiFpMTxZGcKNWgFABdA1wCh0JyKUAZb/PIr3+oGT0WiftG83z4HoPiI
         FGMn93hKKPNrbI/TqTrNaYBditOy1DVm+OePsWFHJMQPsXI62RVZDIlBdOEBxJYMYS
         NIWtDcZ48+ImDxwwS7Twmm3re4d81/zF+XFxhGFycArjgmFFOjEV5e+4z5lHawCVHm
         2x997056suRTIM1eJyIrFhucXQV4KLMY/SdNN0iETtyXXmbk/KC2hxnNa/adUWVqw1
         0m+Pp7O78Tdqw==
X-Nifty-SrcIP: [209.85.210.179]
Received: by mail-pf1-f179.google.com with SMTP id g1so1734531pfv.1;
        Wed, 09 Mar 2022 01:19:02 -0800 (PST)
X-Gm-Message-State: AOAM5328vrmA8ZwzRnp5HBFfA83O2fvErvNrW2xFgV3kP/503Y6571b0
        JAidGLWR2mwlLgClf2NgFOzw0giRXWgrq6IUYn4=
X-Google-Smtp-Source: ABdhPJy5QRSZE5cwpNSu1+QJNGk0tz8koEoXrMBDbCx6hK3tNuVOPYULhzCSvBtKznnLBYsWpukwoAxtPjMqBOgCDqk=
X-Received: by 2002:a63:1d44:0:b0:373:5612:629b with SMTP id
 d4-20020a631d44000000b003735612629bmr17462393pgm.352.1646817541465; Wed, 09
 Mar 2022 01:19:01 -0800 (PST)
MIME-Version: 1.0
References: <20220308215615.14183-1-arnd@kernel.org> <CAHk-=wjsCrVxToP0Zx+cUAVZmSKi=Y6NP1+VnBcoPyPPEBfonQ@mail.gmail.com>
 <CAK7LNAQoFFVLfkhA7FC9vDbvc4wdLginYeRHL0xHVAumu6p=uw@mail.gmail.com>
In-Reply-To: <CAK7LNAQoFFVLfkhA7FC9vDbvc4wdLginYeRHL0xHVAumu6p=uw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 9 Mar 2022 18:18:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNASuy5hSOU7Y7Tr8_6Ks1ZqEeUKv_-c6fDjMubq0_ENRaw@mail.gmail.com>
Message-ID: <CAK7LNASuy5hSOU7Y7Tr8_6Ks1ZqEeUKv_-c6fDjMubq0_ENRaw@mail.gmail.com>
Subject: Re: [PATCH 0/4] [v4] Kbuild: std=gnu11 changes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Alex Shi <alexs@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Marco Elver <elver@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 11:16 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Wed, Mar 9, 2022 at 9:09 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Tue, Mar 8, 2022 at 1:56 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > I've incorporated the feedback from Masahiro Yamada in this
> > > version, splitting out one more patch, rebasing on top of
> > > the kbuild tree, and changing the order of the patches.
> > >
> > > Please apply to the kbuild tree.
> >
> > I'd actually like to see this as a separate branch, so that I can
> > merge it early - or other peoples git branches end up depending on it.
>
>
> OK, I can apply this to a separate branch, kbuild-gnu11.
> (and I will queue this up shortly because it is already -rc7)
>
> Then, I will send two pull reqs in the next MW,
> but please note they will conflict with each other,
> between this gnu11 patch set and the following
> one in my usual kbuild branch:
>
> https://patchwork.kernel.org/project/linux-kbuild/patch/20220201213542.2808035-1-quic_eberman@quicinc.com/
>
>
> I hope this is not a complex conflict, but please let me know
> if you have any requests to me.
>
>
>
>
>


All, applied to linux-kbuild/kbuild-gnu11.

If somebody wants to give Reviewed-by, Acked-by, Tested-by, please.

I will append them later.








-- 
Best Regards
Masahiro Yamada

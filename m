Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791194D2964
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiCIHVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiCIHVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:21:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A667109A4E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:20:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6AC2B81E9D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 07:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84027C340F5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 07:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646810434;
        bh=0QXZP8eVgo10f8L1mPMKCddY3p41GJooJb+4El4/TiY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B1Q8u3x/zEgVwf8U1Masn8ZgF8D3nOWrfU2zR9pF90baIpd3AvRlN2tx/Yv+UWcGO
         1Sk53X0X/5TSpQKn9F7xXKgbmTYJk5h1Y8RZi1AUt36pk5JXc0BLymBWMjLzpSegKe
         owhK8FCrZLU1rFBGuO36WP81Q7vuEAm/dVK9lxndA7Y3ikDjJJ2TtMYPPqbKE5SWAn
         7iyXXZ5j7x+pMl5ibicoJwj045iSc0Kf8TRmSk4bFyEOkM//VvlRKgzTHF8TsebZbw
         EytDBMXw5j30Q4MpTcW2OCoVvZJ0JTxfAU/JWErRCPwD75PzJ+qfZK4c43Swvu10H3
         /iFHF5YRfA3/A==
Received: by mail-yb1-f169.google.com with SMTP id g26so2457842ybj.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 23:20:34 -0800 (PST)
X-Gm-Message-State: AOAM531h4KeuHjJILm+xS7p9zN4tOtgGEvs3/RwfSkfj+/n0G2niKNZW
        88aeZR7hgTHyRDEZ0YnoGrd+WuzngwxDvDmit4g=
X-Google-Smtp-Source: ABdhPJw6Ebe3DJZC6cSv+jIP0cnkiQl7B1mqVD4KKRI1Lbgg6k8EgTrADWtFm0f6M7E8i3HT1hzzcrVGCJCwhogovQY=
X-Received: by 2002:a25:af8e:0:b0:622:c778:c0a2 with SMTP id
 g14-20020a25af8e000000b00622c778c0a2mr15451914ybh.50.1646810433470; Tue, 08
 Mar 2022 23:20:33 -0800 (PST)
MIME-Version: 1.0
References: <CAMj1kXEy6n3zZ8Z51kP=tTuOU0xCXLLfC-b6BMpdsjMoM7zGBg@mail.gmail.com>
 <Yh8tWdiWPgZLyQtx@Red> <CAMj1kXGRtdftpoqmd7HBonBBS67jO=YWzoESPAagGfQBZUDQWg@mail.gmail.com>
 <Yh8w7ldudhmbYv4N@Red> <CAMj1kXHri2_tnYhu2gE9xTUOxLY9v1=zODCo1BGfjFTKukiedA@mail.gmail.com>
 <Yh9CbcrfDvN2Z9Y9@Red> <Yh9RI64fThQfnJgS@shell.armlinux.org.uk>
 <CAMj1kXGVwXzAAyDeJqAi+eK1hOB3uShiBb_LORL-_YNvikbsAw@mail.gmail.com>
 <Yh9TdbWwHX/5Bhmt@shell.armlinux.org.uk> <YifuVmkcb1ie7bzk@shell.armlinux.org.uk>
 <Yif+AY3DShT9Z6Q+@shell.armlinux.org.uk>
In-Reply-To: <Yif+AY3DShT9Z6Q+@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 9 Mar 2022 08:20:22 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFB9sUdxJ8UZQqE6mgSYZH2aB_Y7Ps70C-CS2Pr4U8yOg@mail.gmail.com>
Message-ID: <CAMj1kXFB9sUdxJ8UZQqE6mgSYZH2aB_Y7Ps70C-CS2Pr4U8yOg@mail.gmail.com>
Subject: Re: boot flooded with unwind: Index not found
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022 at 02:08, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Mar 09, 2022 at 12:01:26AM +0000, Russell King (Oracle) wrote:
> > To reinterate what I've just put on IRC - we have not got to the bottom
> > of this problem yet - it still very much exists.
> >
> > There seems to be something of a fundamental issue with the unwinder,
> > it now appears to be going wrong and failing to unwind beyond a
> > couple of functions, and the address it's coming out with appears to
> > be incorrect. I've only just discovered this because I created my very
> > own bug, and yet again, the timing sucks with the proximity of the
> > merge window.
> >
> > I'm getting:
> >
> > [   13.198803] [<c0017728>] (unwind_backtrace) from [<c0012828>] (show_stack+0x10/0x14)
> > [   13.198820] [<c0012828>] (show_stack) from [<c2be78d4>] (0xc2be78d4)
> >
> > for the WARN_ON() stacktrace, and that address that apparently called
> > show_stack() is most definitely rubbish and incorrect. This makes any
> > WARN_ON() condition undebuggable.
> >
> > This is with both 9183/1 and 9184/1 applied on top of pulling your
> > "arm-ftrace-for-rmk" tag and also with just the "arm-vmap-stacks-v6"
> > tag. This seems to point at one of these patches breaking the
> > unwinder:
> >
> > a1c510d0adc6 ARM: implement support for vmap'ed stacks
> > 532319b9c418 ARM: unwind: disregard unwind info before stack frame is set up
>
> The above commit appears to be what's breaking the unwinder. Without
> this I get sane stacktraces. With it, the unwinder spits out stupid
> function addresses.
>

OK, then let's revert that patch. It reduces the likelihood that we
can show a sane stacktrace when the stack overflows, but that is not
the end of the world: the important bit is that it gets caught and
that the offending task is terminated.

We can revisit this in the next cycle.

I do think 9183/1 and 9184/1 should be kept, though. There are
definitely cases such as Corentin's that are different from yours
where we might see spurious warnings otherwise.

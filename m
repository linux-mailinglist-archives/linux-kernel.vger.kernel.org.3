Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597BA47FBBE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 11:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbhL0KGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 05:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbhL0KGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 05:06:16 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1CFC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 02:06:15 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x15so59937445edv.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 02:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a0IFERCWVRRvK7i50B8H8ruwc2BOL0IlPbyYMGipFn0=;
        b=R2piZGnu/rpYdYrYmZ9vbMeEiP/yipyxXMcEBoBEFkUe8AV82JLVSo3/F8NFWirdwb
         J+NauYnmJuPanJGhLyU/20oMol7u1RRqjx4odFmkqIzciRRETsAiytqZnHNCBdwTSr1m
         YZ4hLtBEji3KilO4523lVuIH4U/bIVIsuD4ELFss2lcnTzA0gFQfJbRD5S+xOZYEPRdf
         d49M8b4weLoRVIjqMTQFlBgEBaN4gGXnsf+ChuHlWPVfkI80yRGMHdrRkLmqBsg+N3II
         Bfn1BI7ptvrHLTypwBnpjdSfv/9x0x72PZsbE5r1MGGTbnrcSZqwE5sSkbFlkIA6ptEO
         euog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0IFERCWVRRvK7i50B8H8ruwc2BOL0IlPbyYMGipFn0=;
        b=hq3kTob6Ao6m90vbuFMm8p2XAY/O6GlzVQn2HcAOXE0JnxVYGqNR2ODoGDXVY8hLyz
         SlfsIRVfd6vYOrG6P8zeYK7g7iTskNUbDna8fHOKkoeugnbbcKJpInLa8lRsM7fWMYt9
         kkEGwfGG2Qg+43U9vDW/fhj3fJ7KdXLWabVy4V4vu4IS2Oy0kiKDKFbQDj2pgEnVNIfv
         GtRdqOumdDxdwOta6qSksWX7++e8of1xC/uBES7t7y4SpUXuwBVzixQPrMM3zWadXHA8
         WRr3Al5ZI6ZILK4gms7EglbkEDdy6DqsH7fOKLvP2YIGQf7UFmeQwapi90fJCoVFlCSv
         HKtQ==
X-Gm-Message-State: AOAM532eMxNVR14uPvHHJc5puiYBYZU1t7xdsCnFLCDNAB+szLJJ8spB
        CkbfomuAmRkgix2/nF8wAem8Wv7n3HujvqPkQgo=
X-Google-Smtp-Source: ABdhPJwdZTdkbtoLcnSJIGGgqOF4TkdrBTRzs0hRCcsYYAni/J2E0PDkruRZtmY6vMPpntYAkk/wtoF7Pb2gfbTP9Kc=
X-Received: by 2002:a17:906:a3c6:: with SMTP id ca6mr13137879ejb.639.1640599574249;
 Mon, 27 Dec 2021 02:06:14 -0800 (PST)
MIME-Version: 1.0
References: <20211215234946.6494-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VfGwQ7G2b39GO4tN=sxQoiahO2uudy25ALxEkrNcP9eVw@mail.gmail.com>
 <CA+V-a8t1myOt0rhJExem_T2tJUM3PLL9KuXn0=_LtucJPHLkbA@mail.gmail.com>
 <CAHp75VdXKVAZMKqC=0RbkAKKxFsdcxBc0M3N6OQMivHj-w+DHw@mail.gmail.com>
 <CA+V-a8vbsy94MvRpqWQQuRqfEGiX_ZZTTt+dr0r6qnnJAPaEmA@mail.gmail.com>
 <CAHp75VfvOOzwcTBjYg3OzbbdhcpWfaPWZ0h7HZRFOPEQAQMT=A@mail.gmail.com>
 <CAMuHMdWSAOEAvqvr1UqKKmVDMzY3Tb8Y_4XowFPBN6L3TESqYA@mail.gmail.com>
 <CAHp75Vc2puj45n_wMY50OnDemNmFFu-yepCC9_L+DWp1HAzxPw@mail.gmail.com> <CAMuHMdUDts8LWYrftYp0VSxDX8kaP1a9N5YGZDNCAuAsr84EAw@mail.gmail.com>
In-Reply-To: <CAMuHMdUDts8LWYrftYp0VSxDX8kaP1a9N5YGZDNCAuAsr84EAw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Dec 2021 12:05:37 +0200
Message-ID: <CAHp75VeyU8Ub0h_y03b77EBCLtXLeKU7+-pD4E=iBzOo4zNw+Q@mail.gmail.com>
Subject: Re: [PATCH] irqchip/renesas-irqc: Use platform_get_irq_optional() to
 get the interrupt
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 12:02 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Dec 27, 2021 at 10:57 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Dec 27, 2021 at 11:45 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Sun, Dec 26, 2021 at 9:49 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Sun, Dec 26, 2021 at 1:59 AM Lad, Prabhakar
> > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > On Sat, Dec 25, 2021 at 5:40 PM Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > On Sat, Dec 25, 2021 at 7:28 PM Lad, Prabhakar
> > > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > > > On Sat, Dec 25, 2021 at 4:46 PM Andy Shevchenko
> > > > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > > > On Thu, Dec 16, 2021 at 9:52 AM Lad Prabhakar
> > > > > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > > >
> > > > > > > > ret = platform_get_irq_optional(...);
> > > > > > > > if (ret < 0 && ret != -ENXIO)
> > > > > > > >   return ret;
> > > > > > > > if (ret > 0)
> > > > > > > >   ...we got it...
> > > > > > > >
> > > > > > > > It will allow the future API fix of platform_get_irq_optional() to be
> > > > > > > > really optional.
> > > > > > > >
> > > > > > > Later patch [0] (merged into -next) does check for -ENXIO first.
> > > > > > >
> > > > > > > [0] https://lore.kernel.org/lkml/20211216182121.5323-1-prabhakar.mahadev-lad.rj@bp.renesas.com/t/
> > > > > >
> > > > > > The problem is that it doesn't consider 0 as no IRQ.
> > > > > >
> > > > > Can you please point me to the discussion/patch where this API change
> > > > > is considered/discussed. Just to clarify now the new API for
> > > > > platform_get_irq_optional() will return "0" in case there is no
> > > > > interrupt and not not -ENXIO anymore?
> > > >
> > > > The longest one happened here:
> > > > https://lore.kernel.org/linux-ide/20211209145937.77719-1-andriy.shevchenko@linux.intel.com/T/#u
> > > >
> > > > It has links to some other discussions on the topic.
> > > >
> > > > > When will this patch be merged for the new api, so that I can base my
> > > > > patches on top of it to avoid more changes?
> > > >
> > > > You can simply imply that, I dunno when it gets merged (from my point
> > > > of view the users should be fixed first, and since you are adding
> > > > users, the burden is increasing).
> > >
> > > Not only users (drivers), but also providers (architecture-specific code).
> > > IRQ zero is still valid on some architectures, e.g. on SH[1].
> >
> > Are we talking about vIRQ?
> > And users are fine with a big warning?
>
> The warning is only seen when a driver uses platorm_get_irq{,_optional}().
> There are several other ways to obtain interrupts, avoiding the
> big warning.
>
> > My understanding is that the architecture code there is broken. It
> > needs to be fixed to use IRQ domains and all that machinery instead of
> > what it does.
> >
> > 0 is "no IRQ" in Linux.
> >
> > > [1] https://lore.kernel.org/linux-renesas-soc/CAMuHMdUg3=q7gyaVHP0XcYUOo3PQUUv8Hc8wp5faVQ+bTBpg4A@mail.gmail.com/
>
> BTW, perhaps the IRQ subsystem should switch from integer IRQ numbers
> to an opaque object, like was done for GPIO before?

Hasn't it been done a long time ago?
IIRC somewhere in ~2014 timeframe.

> The IRQ subsystem
> is one of the few (only?) subsystems still using plain integers.

It uses opaque objects for which the plain integer is a unique key.

> That
> way we don't need this two-step platform_get_irq_optional() conversion
> (step 1: check for both -ENXIO and zero, step 2: drop the check for
> -ENXIO).


-- 
With Best Regards,
Andy Shevchenko

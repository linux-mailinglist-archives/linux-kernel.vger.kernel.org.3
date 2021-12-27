Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404F547FBB0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 11:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhL0KCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 05:02:46 -0500
Received: from mail-vk1-f173.google.com ([209.85.221.173]:44617 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhL0KCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 05:02:45 -0500
Received: by mail-vk1-f173.google.com with SMTP id b77so8314013vka.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 02:02:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y1XeY/7+bVPzuGGFWiTH/P1ueERxIz7gi1TicQ93tqs=;
        b=rFSoJ4eOhn/OUxgFzUYsb6tjXZ7jIY6numlihKNBNDCYiTln1NPj4n2whqEeTMcEEZ
         LNHaQsrw29pxLgZv7lp8+8fdujpmFUEaQC1RI/rEIOUpb1bNmW0hg/eKcfhPfYJjdiXm
         r1nfjk5e9d26KIHCeKW6J9eW8eAbWfasM5s5f3eVSEyaMoyqnZmoOmuTd9UC1HBkG7W7
         tt8NK5CvtFgYmCtehcAUFLKwqhlEtvB2QnwKzJAcfFqNxrfppViGhTxaZ3uwaZFxg03W
         MWZIrrk9wqpo4WzvPvpV5JSZdxROpnXsZuAu90+gC9N1RSRXajHUAfHINo476zPAmKk+
         TxFA==
X-Gm-Message-State: AOAM530EIL8K9icFjAjGDud/YuodaXkvs1Sm2r47WpIrD/YwTL1ysROf
        xU065jirf1gKyiHLF9QiXS7NnROtejcj0g==
X-Google-Smtp-Source: ABdhPJzeeYMby3g3fmTDt/uFoTvBEKZWy871TKXhx7srD8dpr4SHVZxA9BdhSFEx1eFn7npfrh3+DQ==
X-Received: by 2002:a05:6122:8c6:: with SMTP id 6mr4932818vkg.5.1640599364103;
        Mon, 27 Dec 2021 02:02:44 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id t130sm888569vkc.32.2021.12.27.02.02.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Dec 2021 02:02:43 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id u1so8165559vkn.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 02:02:43 -0800 (PST)
X-Received: by 2002:a1f:4641:: with SMTP id t62mr4836267vka.0.1640599363409;
 Mon, 27 Dec 2021 02:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20211215234946.6494-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VfGwQ7G2b39GO4tN=sxQoiahO2uudy25ALxEkrNcP9eVw@mail.gmail.com>
 <CA+V-a8t1myOt0rhJExem_T2tJUM3PLL9KuXn0=_LtucJPHLkbA@mail.gmail.com>
 <CAHp75VdXKVAZMKqC=0RbkAKKxFsdcxBc0M3N6OQMivHj-w+DHw@mail.gmail.com>
 <CA+V-a8vbsy94MvRpqWQQuRqfEGiX_ZZTTt+dr0r6qnnJAPaEmA@mail.gmail.com>
 <CAHp75VfvOOzwcTBjYg3OzbbdhcpWfaPWZ0h7HZRFOPEQAQMT=A@mail.gmail.com>
 <CAMuHMdWSAOEAvqvr1UqKKmVDMzY3Tb8Y_4XowFPBN6L3TESqYA@mail.gmail.com> <CAHp75Vc2puj45n_wMY50OnDemNmFFu-yepCC9_L+DWp1HAzxPw@mail.gmail.com>
In-Reply-To: <CAHp75Vc2puj45n_wMY50OnDemNmFFu-yepCC9_L+DWp1HAzxPw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Dec 2021 11:02:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUDts8LWYrftYp0VSxDX8kaP1a9N5YGZDNCAuAsr84EAw@mail.gmail.com>
Message-ID: <CAMuHMdUDts8LWYrftYp0VSxDX8kaP1a9N5YGZDNCAuAsr84EAw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/renesas-irqc: Use platform_get_irq_optional() to
 get the interrupt
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

Hi Andy,

On Mon, Dec 27, 2021 at 10:57 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Dec 27, 2021 at 11:45 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Sun, Dec 26, 2021 at 9:49 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Sun, Dec 26, 2021 at 1:59 AM Lad, Prabhakar
> > > <prabhakar.csengg@gmail.com> wrote:
> > > > On Sat, Dec 25, 2021 at 5:40 PM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Sat, Dec 25, 2021 at 7:28 PM Lad, Prabhakar
> > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > > On Sat, Dec 25, 2021 at 4:46 PM Andy Shevchenko
> > > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > > On Thu, Dec 16, 2021 at 9:52 AM Lad Prabhakar
> > > > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > >
> > > > > > > ret = platform_get_irq_optional(...);
> > > > > > > if (ret < 0 && ret != -ENXIO)
> > > > > > >   return ret;
> > > > > > > if (ret > 0)
> > > > > > >   ...we got it...
> > > > > > >
> > > > > > > It will allow the future API fix of platform_get_irq_optional() to be
> > > > > > > really optional.
> > > > > > >
> > > > > > Later patch [0] (merged into -next) does check for -ENXIO first.
> > > > > >
> > > > > > [0] https://lore.kernel.org/lkml/20211216182121.5323-1-prabhakar.mahadev-lad.rj@bp.renesas.com/t/
> > > > >
> > > > > The problem is that it doesn't consider 0 as no IRQ.
> > > > >
> > > > Can you please point me to the discussion/patch where this API change
> > > > is considered/discussed. Just to clarify now the new API for
> > > > platform_get_irq_optional() will return "0" in case there is no
> > > > interrupt and not not -ENXIO anymore?
> > >
> > > The longest one happened here:
> > > https://lore.kernel.org/linux-ide/20211209145937.77719-1-andriy.shevchenko@linux.intel.com/T/#u
> > >
> > > It has links to some other discussions on the topic.
> > >
> > > > When will this patch be merged for the new api, so that I can base my
> > > > patches on top of it to avoid more changes?
> > >
> > > You can simply imply that, I dunno when it gets merged (from my point
> > > of view the users should be fixed first, and since you are adding
> > > users, the burden is increasing).
> >
> > Not only users (drivers), but also providers (architecture-specific code).
> > IRQ zero is still valid on some architectures, e.g. on SH[1].
>
> Are we talking about vIRQ?
> And users are fine with a big warning?

The warning is only seen when a driver uses platorm_get_irq{,_optional}().
There are several other ways to obtain interrupts, avoiding the
big warning.

> My understanding is that the architecture code there is broken. It
> needs to be fixed to use IRQ domains and all that machinery instead of
> what it does.
>
> 0 is "no IRQ" in Linux.
>
> > [1] https://lore.kernel.org/linux-renesas-soc/CAMuHMdUg3=q7gyaVHP0XcYUOo3PQUUv8Hc8wp5faVQ+bTBpg4A@mail.gmail.com/

BTW, perhaps the IRQ subsystem should switch from integer IRQ numbers
to an opaque object, like was done for GPIO before? The IRQ subsystem
is one of the few (only?) subsystems still using plain integers. That
way we don't need this two-step platform_get_irq_optional() conversion
(step 1: check for both -ENXIO and zero, step 2: drop the check for
-ENXIO).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

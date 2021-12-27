Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941DD47FC15
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 12:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbhL0LE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 06:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhL0LE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 06:04:58 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5936C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 03:04:57 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o6so60349715edc.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 03:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WeVLsHIeyiCkAHjd50OJHxjaaYn5T1qPGOcuMQi9uAs=;
        b=CK/JN3fhTDNY1Srt3qYHUD9q5zbJw5JAaWWOCnQVvCX838xLP6ZHjgv9SZs/SAW4z0
         ohhG6f99oyzbAgzNqIGSVY22q39V95CRpcTarjxQu1aLXuVN9v/VZqSMUi8hETGFGo7y
         mdpj0hPImAtroBYbrb5lmqdWEzEyn8/evEjseKkK6+x7dXer1ABpsalzX3llc5TWZWMk
         /u0GtMNo1sCdHhtVgPW99Rbr4swrnnKZ8+BwlVYDFyESJP43ioEpouwMLO/Skfh8tlSf
         K48U03608rhMnpEBsS+J4d+VbwQPqlxa9XFM3yiRk78H82gKEjF1hgML9sBggNFNsH5T
         VElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WeVLsHIeyiCkAHjd50OJHxjaaYn5T1qPGOcuMQi9uAs=;
        b=m0VSwW1QJxMtclNJO8qOcR49C0OER0x8qAPHawF9g6lzESdn3StMV6wq6fDG4DSXf0
         D9lhaJoejN6I9V1coN4NBDePuwmDz/s3jr/MgbXjS4EjgfVX/V8X9vVo7U4Iffq744cT
         zTrLAVdYdfc5k9tRzj/WWLcR1dNGtZYkJFjK6jUudpfPngdigdODRbNrol7cJxdv6cuD
         /gNgI07Na2n8QIt/Ji3CAQ3K//mSJiOlr2l6y1vzgrcAFsrZ4Caib9HL67rXkCBX131e
         mdxLPlxWFrOWThL+0KwsV2jCluY8MlVp9CW5r1bWRjv98wwOTBidE4+JfnXXJ2K45+nT
         iAEQ==
X-Gm-Message-State: AOAM532tgKy6ywhLFSWN3cRMdrHsVEEJQ4rrmzP5PgldhCJUv4yb/Yg0
        HZMkyrK7+NecA0ryI0mUuhA+trwu2zkAlbdhHWh7dggseqc=
X-Google-Smtp-Source: ABdhPJxBYl2uYY0dezYVqt0J/J7L+OL1U6OFJ0fy8PBhde+pA1utUKztjXwn3pS5UUDTMp15KOpMgNajpRLQ9YuU8mU=
X-Received: by 2002:a17:906:a3c6:: with SMTP id ca6mr13282432ejb.639.1640603095574;
 Mon, 27 Dec 2021 03:04:55 -0800 (PST)
MIME-Version: 1.0
References: <20211215234946.6494-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VfGwQ7G2b39GO4tN=sxQoiahO2uudy25ALxEkrNcP9eVw@mail.gmail.com>
 <CA+V-a8t1myOt0rhJExem_T2tJUM3PLL9KuXn0=_LtucJPHLkbA@mail.gmail.com>
 <CAHp75VdXKVAZMKqC=0RbkAKKxFsdcxBc0M3N6OQMivHj-w+DHw@mail.gmail.com>
 <CA+V-a8vbsy94MvRpqWQQuRqfEGiX_ZZTTt+dr0r6qnnJAPaEmA@mail.gmail.com>
 <CAHp75VfvOOzwcTBjYg3OzbbdhcpWfaPWZ0h7HZRFOPEQAQMT=A@mail.gmail.com>
 <CAMuHMdWSAOEAvqvr1UqKKmVDMzY3Tb8Y_4XowFPBN6L3TESqYA@mail.gmail.com>
 <CAHp75Vc2puj45n_wMY50OnDemNmFFu-yepCC9_L+DWp1HAzxPw@mail.gmail.com>
 <CAMuHMdUDts8LWYrftYp0VSxDX8kaP1a9N5YGZDNCAuAsr84EAw@mail.gmail.com>
 <CAHp75VeitNg_fU22UkNGSYpAhtQaba1Scd3CPO0QmRpjkqmSMA@mail.gmail.com>
 <CAMuHMdXpynBNC994vTo8tUc4bcD3HVzb3voNPJS1L8A0MRnyHQ@mail.gmail.com>
 <CAHp75Vc-QKy=po6WT7Cbx43dDmwaRcdhEfgzMSmMSn3kNQiG7g@mail.gmail.com> <CAMuHMdUMDLf+HaH8OYCCvbBwiX28wy8VW-ROWWJQBzE1orCEHQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUMDLf+HaH8OYCCvbBwiX28wy8VW-ROWWJQBzE1orCEHQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Dec 2021 13:04:19 +0200
Message-ID: <CAHp75Vc+FP8Rahieu+oTZwTGPm=h1Sws89zG5z8C-C69T6=XZQ@mail.gmail.com>
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

On Mon, Dec 27, 2021 at 12:58 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Dec 27, 2021 at 11:49 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Dec 27, 2021 at 12:24 PM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Mon, Dec 27, 2021 at 11:10 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Mon, Dec 27, 2021 at 12:02 PM Geert Uytterhoeven
> > > > <geert@linux-m68k.org> wrote:
> > > > > On Mon, Dec 27, 2021 at 10:57 AM Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > On Mon, Dec 27, 2021 at 11:45 AM Geert Uytterhoeven
> > > > > > <geert@linux-m68k.org> wrote:
> > > > > > > On Sun, Dec 26, 2021 at 9:49 AM Andy Shevchenko
> > > > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > > > On Sun, Dec 26, 2021 at 1:59 AM Lad, Prabhakar
> > > > > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > > > > > When will this patch be merged for the new api, so that I can base my
> > > > > > > > > patches on top of it to avoid more changes?
> > > > > > > >
> > > > > > > > You can simply imply that, I dunno when it gets merged (from my point
> > > > > > > > of view the users should be fixed first, and since you are adding
> > > > > > > > users, the burden is increasing).
> > > > > > >
> > > > > > > Not only users (drivers), but also providers (architecture-specific code).
> > > > > > > IRQ zero is still valid on some architectures, e.g. on SH[1].
> > > > > >
> > > > > > Are we talking about vIRQ?
> > > > > > And users are fine with a big warning?
> > > > >
> > > > > The warning is only seen when a driver uses platorm_get_irq{,_optional}().
> > > > > There are several other ways to obtain interrupts, avoiding the
> > > > > big warning.
> > > >
> > > > Forgot to comment on this, then why is it a problem to allow
> > > > platfiorm_get_irq_optional() use 0 for no IRQ?
> > > > So, it seems you gave me a good justification for my way :-)
> > >
> > > In se that is not a problem, assumed by now everybody should have
> > > seen the warning, right?  Unfortunately that assumption is probably
> > > not true, as people may not upgrade their kernel, cfr. my SH Ethernet
> > > example.
> > >
> > > Apart from that, any new conversion to platfiorm_get_irq_optional()
> > > might cause a regression on an obscure platform still using IRQ0.
> >
> > What architectures?
> > Are there any examples besides ethernet drivers on SH?
>
> Sorry, I don't know.
>
> > Let's start  a list:
> > SH: only few cases related to smc911 Ethernet driver
>
> Time to get rid of SH ;-)
>
> > x86: Legacy APIC 1:1 mapping, where 0 is used by timer which doesn't
> > involve platform API
>
> Time to get rid of x86 ;-)

Why (in both cases)? I have mentioned that x86 doesn't use vIRQ0 via
platform APIs, SH can be fixed, if you are interested in fixing, of
course, by switching to IRQ domains.

> > ...???...
> >
> > And what about "getting IRQ without big warning"? What did you have in
> > mind when you put it?
>
> If the driver uses platform_get_resource(..., IORESOURCE_IRQ, ...) to
> get the IRQ number, the warning in platform_get_irq_optional()
> doesn't trigger, as the latter is not called?

So, again, let's put the comment to those drivers then and avoid
obfuscation of the rest of the kernel, would it be feasible?

-- 
With Best Regards,
Andy Shevchenko

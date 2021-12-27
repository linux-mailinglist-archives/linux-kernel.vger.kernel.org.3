Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADDD47FC0B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 11:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbhL0K6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 05:58:21 -0500
Received: from mail-ua1-f50.google.com ([209.85.222.50]:34454 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhL0K6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 05:58:20 -0500
Received: by mail-ua1-f50.google.com with SMTP id t18so18744577uaj.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 02:58:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n/cGXdZkKsVlyjmx+u0RanycZmtJnAc2tB+BlvaPdZw=;
        b=xk5EYvNPxOMYAJmVhb3xySdRQ+ZCJyXbUqJI99jh8uizE0cJLSlOxomFmb2N3JFnnC
         8xLU0Pssqaer8eI1Eold7jUAxhxdCoc0vz7vvag8591DEIW4DgAczlr56gHsnWplQ5Fo
         hxoAxtm6PMbcXcfrtwI8nd4jpZlYFv1kI5q2JGGEOWI3JbljCS3bv+rmFBr1jIftcjox
         fnBVJXteY+CJuFK+930p9igC91GLWe7nqr/6WbCI/C34e3gR+/PxrVUZwBxbCVFJGUk1
         PsUvZbd+86scGXw+9WO+hpUq6lycdC7E7jKH753TUMTxN19pnZFwgxWgWZijak8gb2BK
         yVZQ==
X-Gm-Message-State: AOAM533Z4IkHW7bZjfB0QXDOG0qSaDrKBh37dejaJaaIYy/ptw1KAbcl
        eXVfxlIZcAdTWUX6eI/jQzIRVNeK5PR5Ng==
X-Google-Smtp-Source: ABdhPJxk+rbgRw/7o3vEsWm0sSIoZzUsn1iSUgEezqgVUgQi0bRJZy6JeHgSqfH42g46PbdkNvCDJQ==
X-Received: by 2002:a05:6102:212f:: with SMTP id f15mr4461843vsg.83.1640602699473;
        Mon, 27 Dec 2021 02:58:19 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id j27sm2954510vkl.52.2021.12.27.02.58.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Dec 2021 02:58:19 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id v14so8638782uau.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 02:58:19 -0800 (PST)
X-Received: by 2002:a05:6102:2155:: with SMTP id h21mr4307509vsg.68.1640602698890;
 Mon, 27 Dec 2021 02:58:18 -0800 (PST)
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
 <CAMuHMdXpynBNC994vTo8tUc4bcD3HVzb3voNPJS1L8A0MRnyHQ@mail.gmail.com> <CAHp75Vc-QKy=po6WT7Cbx43dDmwaRcdhEfgzMSmMSn3kNQiG7g@mail.gmail.com>
In-Reply-To: <CAHp75Vc-QKy=po6WT7Cbx43dDmwaRcdhEfgzMSmMSn3kNQiG7g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Dec 2021 11:58:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUMDLf+HaH8OYCCvbBwiX28wy8VW-ROWWJQBzE1orCEHQ@mail.gmail.com>
Message-ID: <CAMuHMdUMDLf+HaH8OYCCvbBwiX28wy8VW-ROWWJQBzE1orCEHQ@mail.gmail.com>
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

On Mon, Dec 27, 2021 at 11:49 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Dec 27, 2021 at 12:24 PM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Mon, Dec 27, 2021 at 11:10 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Mon, Dec 27, 2021 at 12:02 PM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > > > On Mon, Dec 27, 2021 at 10:57 AM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Mon, Dec 27, 2021 at 11:45 AM Geert Uytterhoeven
> > > > > <geert@linux-m68k.org> wrote:
> > > > > > On Sun, Dec 26, 2021 at 9:49 AM Andy Shevchenko
> > > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > > On Sun, Dec 26, 2021 at 1:59 AM Lad, Prabhakar
> > > > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > > > > When will this patch be merged for the new api, so that I can base my
> > > > > > > > patches on top of it to avoid more changes?
> > > > > > >
> > > > > > > You can simply imply that, I dunno when it gets merged (from my point
> > > > > > > of view the users should be fixed first, and since you are adding
> > > > > > > users, the burden is increasing).
> > > > > >
> > > > > > Not only users (drivers), but also providers (architecture-specific code).
> > > > > > IRQ zero is still valid on some architectures, e.g. on SH[1].
> > > > >
> > > > > Are we talking about vIRQ?
> > > > > And users are fine with a big warning?
> > > >
> > > > The warning is only seen when a driver uses platorm_get_irq{,_optional}().
> > > > There are several other ways to obtain interrupts, avoiding the
> > > > big warning.
> > >
> > > Forgot to comment on this, then why is it a problem to allow
> > > platfiorm_get_irq_optional() use 0 for no IRQ?
> > > So, it seems you gave me a good justification for my way :-)
> >
> > In se that is not a problem, assumed by now everybody should have
> > seen the warning, right?  Unfortunately that assumption is probably
> > not true, as people may not upgrade their kernel, cfr. my SH Ethernet
> > example.
> >
> > Apart from that, any new conversion to platfiorm_get_irq_optional()
> > might cause a regression on an obscure platform still using IRQ0.
>
> What architectures?
> Are there any examples besides ethernet drivers on SH?

Sorry, I don't know.

> Let's start  a list:
> SH: only few cases related to smc911 Ethernet driver

Time to get rid of SH ;-)

> x86: Legacy APIC 1:1 mapping, where 0 is used by timer which doesn't
> involve platform API

Time to get rid of x86 ;-)

> ...???...
>
> And what about "getting IRQ without big warning"? What did you have in
> mind when you put it?

If the driver uses platform_get_resource(..., IORESOURCE_IRQ, ...) to
get the IRQ number, the warning in platform_get_irq_optional()
doesn't trigger, as the latter is not called?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

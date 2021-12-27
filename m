Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A11F47FBD1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 11:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbhL0KYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 05:24:01 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:39838 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbhL0KYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 05:24:00 -0500
Received: by mail-ua1-f42.google.com with SMTP id i6so25903491uae.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 02:24:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxvHM5LXWgpwB0/ROzr9DivWkvp9xs4dkuW1sRHIHm0=;
        b=Rb4V/wLksXfO5kdEfRBWsFe8dmbyFEz8P85npGTngeEQ7+oUqUKfrp/B8OmO8FFacv
         LcQZUuGSs6Zo8f06YqevGd4UHFpyAWgKG5ZZw759n20sGjg0F0NrO+bY7RfqpLPmbZrN
         7Y9OBDvoNZeumCOfeuwLalQOpOszOi0LZR+4hZLEgd0NfPdMclwWzXb8pHp4dtGdx1Vl
         3EDtAa18cBQC4FMlyA2fNrF0LhjzgmGY8JAKb2JPvOLjNy3gty7q8zz4Q8WRdO5Q5V1W
         8uwaDDWb/CrlLP2bXxIy4eC+xXyXHiZg8f3R9OWsTS+b6LDLRL2gSQS4vxb05aE5DAiq
         P5+g==
X-Gm-Message-State: AOAM532dbRoFjq7MiEIq0s5Ow8RAj/gSp1zuMkA7V0hPpuky7ylxQwvc
        qzu7+GCwe/9RlqNNngsPueH3QNOJtfvPOQ==
X-Google-Smtp-Source: ABdhPJw8JC5VzgsajS0Ptd7ftDU3+9Buiso7ljMVFtUR8Pel9EOJzZbanhvdzRQOjcNaoV++CKNwDg==
X-Received: by 2002:a05:6102:1358:: with SMTP id j24mr4327156vsl.60.1640600639592;
        Mon, 27 Dec 2021 02:23:59 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id i28sm2959195vkr.16.2021.12.27.02.23.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Dec 2021 02:23:59 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id u1so8189220vkn.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 02:23:59 -0800 (PST)
X-Received: by 2002:a1f:9f04:: with SMTP id i4mr4534025vke.33.1640600638844;
 Mon, 27 Dec 2021 02:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20211215234946.6494-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VfGwQ7G2b39GO4tN=sxQoiahO2uudy25ALxEkrNcP9eVw@mail.gmail.com>
 <CA+V-a8t1myOt0rhJExem_T2tJUM3PLL9KuXn0=_LtucJPHLkbA@mail.gmail.com>
 <CAHp75VdXKVAZMKqC=0RbkAKKxFsdcxBc0M3N6OQMivHj-w+DHw@mail.gmail.com>
 <CA+V-a8vbsy94MvRpqWQQuRqfEGiX_ZZTTt+dr0r6qnnJAPaEmA@mail.gmail.com>
 <CAHp75VfvOOzwcTBjYg3OzbbdhcpWfaPWZ0h7HZRFOPEQAQMT=A@mail.gmail.com>
 <CAMuHMdWSAOEAvqvr1UqKKmVDMzY3Tb8Y_4XowFPBN6L3TESqYA@mail.gmail.com>
 <CAHp75Vc2puj45n_wMY50OnDemNmFFu-yepCC9_L+DWp1HAzxPw@mail.gmail.com>
 <CAMuHMdUDts8LWYrftYp0VSxDX8kaP1a9N5YGZDNCAuAsr84EAw@mail.gmail.com> <CAHp75VeitNg_fU22UkNGSYpAhtQaba1Scd3CPO0QmRpjkqmSMA@mail.gmail.com>
In-Reply-To: <CAHp75VeitNg_fU22UkNGSYpAhtQaba1Scd3CPO0QmRpjkqmSMA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Dec 2021 11:23:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXpynBNC994vTo8tUc4bcD3HVzb3voNPJS1L8A0MRnyHQ@mail.gmail.com>
Message-ID: <CAMuHMdXpynBNC994vTo8tUc4bcD3HVzb3voNPJS1L8A0MRnyHQ@mail.gmail.com>
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

On Mon, Dec 27, 2021 at 11:10 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Dec 27, 2021 at 12:02 PM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Mon, Dec 27, 2021 at 10:57 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Mon, Dec 27, 2021 at 11:45 AM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > > > On Sun, Dec 26, 2021 at 9:49 AM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Sun, Dec 26, 2021 at 1:59 AM Lad, Prabhakar
> > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > > When will this patch be merged for the new api, so that I can base my
> > > > > > patches on top of it to avoid more changes?
> > > > >
> > > > > You can simply imply that, I dunno when it gets merged (from my point
> > > > > of view the users should be fixed first, and since you are adding
> > > > > users, the burden is increasing).
> > > >
> > > > Not only users (drivers), but also providers (architecture-specific code).
> > > > IRQ zero is still valid on some architectures, e.g. on SH[1].
> > >
> > > Are we talking about vIRQ?
> > > And users are fine with a big warning?
> >
> > The warning is only seen when a driver uses platorm_get_irq{,_optional}().
> > There are several other ways to obtain interrupts, avoiding the
> > big warning.
>
> Forgot to comment on this, then why is it a problem to allow
> platfiorm_get_irq_optional() use 0 for no IRQ?
> So, it seems you gave me a good justification for my way :-)

In se that is not a problem, assumed by now everybody should have
seen the warning, right?  Unfortunately that assumption is probably
not true, as people may not upgrade their kernel, cfr. my SH Ethernet
example.

Apart from that, any new conversion to platfiorm_get_irq_optional()
might cause a regression on an obscure platform still using IRQ0.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

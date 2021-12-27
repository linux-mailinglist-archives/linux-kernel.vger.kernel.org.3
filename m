Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF05E47FBED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 11:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbhL0KtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 05:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbhL0KtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 05:49:21 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023D6C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 02:49:21 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id l5so25490458edj.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 02:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MqdLuQZn2YFvG8tagRGU4nog2nT8iEjFVqFbj0wY9p0=;
        b=erSzh3aVB1TZlrYc4AgjbEjLfkadEMWbnE7zGj7sXAKrcVbd8cldfBU3d/t7NxKgeQ
         +oo970vPLMcXfdJkn2NzVLH6FhdUqaI4OUvPQdivzxAcmR29xLsCo7FpagqKxG17hQgZ
         j8qsQpfCr3fifXuwT/XbY2q0ujLjaTaelRhqZcsgPQb85YSw8Gnnv1nOAjlERtleL0Mi
         fKLu2xOMaYeMBNUIsPVkn62H6kaLCXHY4Gbm45x7k8hs/j9cj4aG2JcZbZhtvyxiOX35
         iHhijwqiLjjrqlBBMV91BJ9HaPo2d/o4JZ4M0F50igy/rhDQ4dyJkPEnU96FfJYwYqCc
         42Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MqdLuQZn2YFvG8tagRGU4nog2nT8iEjFVqFbj0wY9p0=;
        b=JniYWd170a2PgVFJnHTWhLWTxBqWZKfZx0+65niBYCmejQG/LqKUq0ohT10mDm1l1+
         zKuWwByQuHBU3mZWgZ48SaKNvTVXuA5d2sm6md19iQRdyE8Y84YAsDg75bkouqsC260V
         6g9h2TXk2h9lPH8Ggbd4H1jJZ1v906YALCddPN5yl2sMO1CAD2Mrr+DUMQnUKqwu54Vy
         O6AkSHtipiNfBIEpvCgPysDyDHG2DFVRlJoNabvJdIiK31Z2YqLQOTwzmfXaXzVjyavX
         7nGmy025ksYEnvRvYz2RSd5e10QOS0HZQfEyEo/tPAOLQh4x0ucQOgoZBuWVubrATzx0
         XQLA==
X-Gm-Message-State: AOAM533FnjPO1xiDZlul7py6JnIQykzO0tuXJMb9KuQLkEsAz0ESU/w1
        HBs6vByKWIXE5f43Jb7baBxSQPD7kdlv3Izb43s=
X-Google-Smtp-Source: ABdhPJxvvouQcfrgN9aO7PkmXYfHhqYaiGZD27TeSkkaJZ+znImov12Yt8kbowAu7r9ZCPLidT22XcH4Bw8k0eTSRpk=
X-Received: by 2002:a05:6402:2ce:: with SMTP id b14mr16004745edx.122.1640602159521;
 Mon, 27 Dec 2021 02:49:19 -0800 (PST)
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
 <CAHp75VeitNg_fU22UkNGSYpAhtQaba1Scd3CPO0QmRpjkqmSMA@mail.gmail.com> <CAMuHMdXpynBNC994vTo8tUc4bcD3HVzb3voNPJS1L8A0MRnyHQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXpynBNC994vTo8tUc4bcD3HVzb3voNPJS1L8A0MRnyHQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Dec 2021 12:48:43 +0200
Message-ID: <CAHp75Vc-QKy=po6WT7Cbx43dDmwaRcdhEfgzMSmMSn3kNQiG7g@mail.gmail.com>
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

On Mon, Dec 27, 2021 at 12:24 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Dec 27, 2021 at 11:10 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Dec 27, 2021 at 12:02 PM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Mon, Dec 27, 2021 at 10:57 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Mon, Dec 27, 2021 at 11:45 AM Geert Uytterhoeven
> > > > <geert@linux-m68k.org> wrote:
> > > > > On Sun, Dec 26, 2021 at 9:49 AM Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > On Sun, Dec 26, 2021 at 1:59 AM Lad, Prabhakar
> > > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > > > When will this patch be merged for the new api, so that I can base my
> > > > > > > patches on top of it to avoid more changes?
> > > > > >
> > > > > > You can simply imply that, I dunno when it gets merged (from my point
> > > > > > of view the users should be fixed first, and since you are adding
> > > > > > users, the burden is increasing).
> > > > >
> > > > > Not only users (drivers), but also providers (architecture-specific code).
> > > > > IRQ zero is still valid on some architectures, e.g. on SH[1].
> > > >
> > > > Are we talking about vIRQ?
> > > > And users are fine with a big warning?
> > >
> > > The warning is only seen when a driver uses platorm_get_irq{,_optional}().
> > > There are several other ways to obtain interrupts, avoiding the
> > > big warning.
> >
> > Forgot to comment on this, then why is it a problem to allow
> > platfiorm_get_irq_optional() use 0 for no IRQ?
> > So, it seems you gave me a good justification for my way :-)
>
> In se that is not a problem, assumed by now everybody should have
> seen the warning, right?  Unfortunately that assumption is probably
> not true, as people may not upgrade their kernel, cfr. my SH Ethernet
> example.
>
> Apart from that, any new conversion to platfiorm_get_irq_optional()
> might cause a regression on an obscure platform still using IRQ0.

What architectures?
Are there any examples besides ethernet drivers on SH?

Let's start  a list:
SH: only few cases related to smc911 Ethernet driver
x86: Legacy APIC 1:1 mapping, where 0 is used by timer which doesn't
involve platform API
...???...

And what about "getting IRQ without big warning"? What did you have in
mind when you put it?

-- 
With Best Regards,
Andy Shevchenko

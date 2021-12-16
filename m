Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C01477AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbhLPRh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhLPRh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:37:26 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60C8C061574;
        Thu, 16 Dec 2021 09:37:25 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id g17so66438911ybe.13;
        Thu, 16 Dec 2021 09:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtD1KjJehQGfe067+3HdZnPPiII65H/dQIq6Z+QIy+A=;
        b=TRxlsLo/T48PN/QFUQ3g+c9fb+l3MZ8y+iTe+CAssMC8lA+ad0KcRnhP80gpPAaCHp
         OJgo5O99rQfYPbg0f3vaO2Ayb6Kr2KypliQuE9GwKs/YT5ghpWYg+OJB7vRL3YUVoQKI
         I7Gufv+0zZU3CYQok5KLeOINSR0fvHq7IRCFooQAUkcDNA1kp7fSu2SekOwrCeK0epn9
         0SYdlfzLJtgbgwEQwjJtdaRTmkTf5JIEr54slCEKwV2Gxo7Nq4DIWQXrjmeBLULHHwnX
         t1NHjqML1KdlVsa34uK/gaUIxkgsB2ww00l+KAGCIG8vyFXH8+h4iskElkisVEL4pP0C
         tmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtD1KjJehQGfe067+3HdZnPPiII65H/dQIq6Z+QIy+A=;
        b=qWTAbKXXTyn9fRhcvYav+Ar3R9VdITDXIZZTL1a/fgvw8OvB7TtVl58UCPBa18YoUp
         uKKzQwdwRvfAnuzy6CuCEV556CN/7JSTMLb3t0Pk/0MDI5wcfF/Z3bwjfJ21Ks71hetX
         /W8PNW7doT9q/aS0f5GvdC0KbG1aMsRsBibbwR6twGEocyIEv/cAOnnKK6aF7luZ9nsb
         ixmuZsLvOapjqF1w6YqWproi5A6u+kg9kU0h4C2dVjuWGqJVmN5dbqaRGM8yFJm82a5z
         J+vFNOf6Luf+ZOVUw6MOC8ntfynoMsX0HAcEi6dIc51xl/jAGOHYE0SRzb4u/FbIyn9+
         cytQ==
X-Gm-Message-State: AOAM532fmg8XYrNalfgg9R0s3GxRQP+5YSThNjy5bBKQO9eyNBnYI4++
        tTe+WnQyEqc0tA/Q8j9/OdjHBcX9/CHh8OryI54=
X-Google-Smtp-Source: ABdhPJyfMtFm0yQRd+kvj9a1D94IsLTbkRk34pv6ajb9LkI5n6//mWVcwJDdiO6xD/DDbU3ATGc0mA1B13jAyvdac9Y=
X-Received: by 2002:a25:84c1:: with SMTP id x1mr14668634ybm.690.1639676245159;
 Thu, 16 Dec 2021 09:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20211215234448.5631-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXObL9brpFQL87qe79HcxXjjMqQ_oKdEwcRyH0CW1mJeg@mail.gmail.com>
 <CA+V-a8vs1qVKXDwnw9ZK3=N3JsrdnmH+WZ265gzUeg_AmmcfDg@mail.gmail.com> <CAMuHMdX6uC2siQ6+g4RTPk4vvxi4y17WCdU6GhQf6j5fuo34nw@mail.gmail.com>
In-Reply-To: <CAMuHMdX6uC2siQ6+g4RTPk4vvxi4y17WCdU6GhQf6j5fuo34nw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 16 Dec 2021 17:36:59 +0000
Message-ID: <CA+V-a8uRtzNuibBnnWi-OKx0dSaK=f0Ddb_fFXjj_F55bNGzKw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/renesas-intc-irqpin: Use platform_get_irq_optional()
 to get the interrupt
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Thu, Dec 16, 2021 at 2:31 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Dec 16, 2021 at 3:23 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Thu, Dec 16, 2021 at 8:45 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Thu, Dec 16, 2021 at 12:45 AM Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > > > allocation of IRQ resources in DT core code, this causes an issue
> > > > when using hierarchical interrupt domains using "interrupts" property
> > > > in the node as this bypassed the hierarchical setup and messed up the
> > > > irq chaining.
> > > >
> > > > In preparation for removal of static setup of IRQ resource from DT core
> > > > code use platform_get_irq_optional().
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > > --- a/drivers/irqchip/irq-renesas-intc-irqpin.c
> > > > +++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
> > >
> > > > @@ -418,12 +417,14 @@ static int intc_irqpin_probe(struct platform_device *pdev)
> > > >
> > > >         /* allow any number of IRQs between 1 and INTC_IRQPIN_MAX */
> > > >         for (k = 0; k < INTC_IRQPIN_MAX; k++) {
> > > > -               irq = platform_get_resource(pdev, IORESOURCE_IRQ, k);
> > > > -               if (!irq)
> > > > +               ret = platform_get_irq_optional(pdev, k);
> > > > +               if (ret == -EPROBE_DEFER)
> > > > +                       goto err0;
> > > > +               if (ret < 0)
> > > >                         break;
> > >
> > > Shouldn't all errors be considered fatal, except for -ENXIO (no
> > > interrupt)?
> > >
> > Initial behavior of this driver was even if one
> > platform_get_resource() succeeded the probe continued further, this is
>
> Indeed, the loop obtained all interrupts present, until no more are to found.
> In the old logic, it would return a NULL resource for the first
> non-existing one.
> In the new logic, it would return -ENXIO.
> Hence you need to check for -ENXIO in the loop, to distinguish "no more
> interrupts" from actual errors.
>
Thanks for the clarification, I'll post a v2 with the changes.

> > the same behavior which I wanted to keep with this code while using
> > platform_get_irq_optional(). But as you pointed out I'll change it to below:
> >
> > +               ret = platform_get_irq(pdev, k);
> > +               if (ret < 0)
> > +                       goto err0;
> >
> > We bail out any error case and will also drop the check for (nirqs < 1).
>
> I think that check should stay: there should be at least one interrupt.
>
Agreed.

Cheers,
Prabhakar
> > > >                 p->irq[k].p = p;
> > > > -               p->irq[k].requested_irq = irq->start;
> > > > +               p->irq[k].requested_irq = ret;
> > > >         }
> > > >
> > > >         nirqs = k;
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

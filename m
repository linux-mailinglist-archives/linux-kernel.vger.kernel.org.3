Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F8651459B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356694AbiD2JrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244541AbiD2JrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:47:09 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70E4BE9F1;
        Fri, 29 Apr 2022 02:43:48 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2ef5380669cso79408227b3.9;
        Fri, 29 Apr 2022 02:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Kg3hGg7aSQtOExCKtXSFZRSUP75e6nI3Aslv19Y7vA=;
        b=TZF6d1SWhW6T1e7EkSodGQRYWm/8NaFP8evsK09WZzyAdjhiFi3leY8CW5P+6jJryI
         j4zxovudMYqZPPzH8LLnKztlVEwxwVGfeks9injDB80fcmwjvwipeAjbCJSV0QzLQHkh
         /gdK3nQ9svbNJdEOOCq2Igc83rASG+dciYrOu+IIwfH4iuobI3dbh33Uur7VEIol8YYB
         4ThkbHnT8gLtnzS+Vk5mDTOcGHqb4oBzBHw+ajZOj0WYtE6CTKSxJFobJm/WneFC6Q/L
         FkyTeoCSXiJy9Q90dJOQilWD7mJiQ0sDMD7JeNBiMB+Ohbz2ZvUGFic8NkdArAn/is/t
         cgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Kg3hGg7aSQtOExCKtXSFZRSUP75e6nI3Aslv19Y7vA=;
        b=Irvbuu/WqS5S8yDKcHSUDQCiuDdx16TB0Bu2CAcqaVW6sj/8utcWimrJLLWAk+XPLg
         Os6bjBEM43J73mywG+Fq3kDcCdO2kLLRzUgok7F21ufJWcXG9V7gF5reLncdf4pvOMwf
         Y4LmrnU3Hvnl88OJ5+/FzAei+Fc0e9wzqinhwJyGku+o1bWOkEZiVa744hher0W7Wnv8
         pUfkP/VLRYordBmAtEdGosj86BFLanCfId8vKmWcDSG2O/HtrpxnuvnnPxGhXeLtEUss
         56/MaNcByUSgqEl0a7wthVmqe/kDt3U87vBaFsM3EagLlRMQG8Vhw5a8mRaunY39Dh+w
         dFLQ==
X-Gm-Message-State: AOAM5323pIFxQnDCXxPhgZAsMlRBD5zkhz7t+XuEndtF2tskRNwR0agU
        l3xzZbMifIT/Jdum5MIycKJ7ygwaX2RMc20v8Ow=
X-Google-Smtp-Source: ABdhPJx1hDX7pnjETYTkdntFjdt5Nq6fxhad4iQ13SDXFdm2nMnRkoJufGnLbvDiVVAaEHweo2vkFXH2I0QzR4maH4Y=
X-Received: by 2002:a81:6a46:0:b0:2f4:dc3f:e8f8 with SMTP id
 f67-20020a816a46000000b002f4dc3fe8f8mr38317183ywc.292.1651225427891; Fri, 29
 Apr 2022 02:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220421221159.31729-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220421221159.31729-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVqk1ryzzK9-BZCMDPeyjfF1-8hMpzUoEPCcg8pJ2-ang@mail.gmail.com>
In-Reply-To: <CAMuHMdVqk1ryzzK9-BZCMDPeyjfF1-8hMpzUoEPCcg8pJ2-ang@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 29 Apr 2022 10:43:21 +0100
Message-ID: <CA+V-a8tosEeNqzPZsdX=VCKTrkQfAhpMRWQDwva+fpQGc8x+jA@mail.gmail.com>
Subject: Re: [PATCH 2/2] irqchip: Add RZ/G2L IA55 Interrupt Controller driver
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Thu, Apr 28, 2022 at 10:42 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Fri, Apr 22, 2022 at 12:12 AM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Add a driver for the Renesas RZ/G2L Interrupt Controller.
> >
> > This supports external pins being used as interrupts. It supports
> > one line for NMI, 8 external pins and 32 GPIO pins (out of 123)
> > to be used as IRQ lines.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > @@ -0,0 +1,447 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Renesas RZ/G2L IRQC Driver
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corporation.
> > + *
> > + * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/of_address.h>
> > +#include <linux/reset.h>
> > +#include <linux/spinlock.h>
> > +
> > +#define IRQC_IRQ_START                 1
> > +#define IRQC_IRQ_COUNT                 8
> > +#define IRQC_TINT_START                        9
>
> = IRQC_IRQ_START + IRQC_IRQ_COUNT
>
OK

> > +#define IRQC_TINT_COUNT                        32
> > +#define IRQC_NUM_IRQ                   41
>
> = IRQC_TINT_START + IRQC_TINT_COUNT
>
OK.

> Should these be in a DT binding header file?
>
> Combining all types into a single linear number space makes it hard
> to extend the range, when reusing for an SoC that supports more
> interrupt sources.
>
Or  DT data maybe?

> > +static void rzg2l_irq_eoi(struct irq_data *d)
> > +{
> > +       struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > +       unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
> > +       u16 bit = BIT(hw_irq);
>
> I guess you can just use u32?
>
OK, will do

> > +       u32 reg;
> > +
> > +       reg = readl_relaxed(priv->base + ISCR);
> > +       if (reg & bit)
> > +               writel_relaxed(GENMASK(IRQC_IRQ_COUNT - 1, 0) & ~bit,
>
> As writes to the unused upper bits are ignored, you can drop the
> masking with GENMASK(IRQC_IRQ_COUNT - 1, 0), and be prepared for more
> interrupt sources.
>
Agreed.

> > +                              priv->base + ISCR);
> > +}
> > +
> > +static void rzg2l_tint_eoi(struct irq_data *d)
> > +{
> > +       struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > +       unsigned int hw_irq = irqd_to_hwirq(d);
>
> "irqd_to_hwirq(d) - IRQC_TINT_START", for symmetry with
> rzg2l_irq_eoi()?
>
OK.

> > +       u32 bit = BIT(hw_irq - IRQC_TINT_START);
> > +       u32 reg;
> > +
> > +       reg = readl_relaxed(priv->base + TSCR);
> > +       if (reg & bit)
> > +               writel_relaxed(GENMASK(IRQC_TINT_COUNT - 1, 0) & ~bit,
>
> Drop the masking with all-ones?
>
You mean instead of a mask just use the reg instead?

Cheers,
Prabhakar

> > +                              priv->base + TSCR);
> > +}
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

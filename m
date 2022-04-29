Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D867D514625
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357191AbiD2KDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245313AbiD2KDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:03:14 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D8BC6652;
        Fri, 29 Apr 2022 02:59:56 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id f38so13603792ybi.3;
        Fri, 29 Apr 2022 02:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AQSV+QWSMrNw5VJ+vqoDbTeHdj6QMGyrAo741kb/mH0=;
        b=D+3Hj7lsJ9qWdwbyHHbudss4pbecp1JUNMrmF08My+268hqYaOjo3CxkTwAt4Qt2bA
         T0KNvt/jGQchHNUiIXD1YB1m4MzLbk00glMENXR+HN0X2/qSWhfOjon+Xf+tbBHgQODC
         A47IFW0kdtbs/repN9IOQiGHmTtebaV9q0Ye6Du54vKuyLThQzCtM5hJXEJDstY3WrU3
         cffdprv5dWIokgb6jAN0S55gG8t+knMU6y6v2qH3VneN0I6nVaApmpfKpfu9KfYkV8R+
         UEC/RdIOFGDN9ITgD/6N307jEuHk2kMcGwVddeQMuk5EDIEda/6CmDz1JLJ9PayAp1rK
         XHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AQSV+QWSMrNw5VJ+vqoDbTeHdj6QMGyrAo741kb/mH0=;
        b=KKbHa7Ddk6J82uP7IVbpQ4ufFWmtal68b+fm59KvcJ21UbEfhtrzWGi7q/oyVOOYe0
         K/I34Fvu6rt32BOsqLagv6yIWCZ7CW6U62G9Bpi6zhBUg6pStidv0K2SNrsRWQnJlfcZ
         EBSR9NiLzRt04oPBwligrY66941Bh3W2p69kJ7orvTpuwmEtlOCN3l/jSplXDbshhKfS
         GGTxI9MgLjcVJaZXZSooiF8RrFErZ7DO8KCp1qevXowLHMFptCZ+3pnSVdzE1unzQBza
         gBZCWSFqXzG/CunVpPPvLRcHiIsn74dJr4d3XAqYGEhthpx+8Z/tsq1dM0rixSCEWSpS
         Sh9g==
X-Gm-Message-State: AOAM530koqc7I5kD1Pag/GSS/V3c7e/0qicmbyIDf2lip+DMcrRIiLSQ
        3Z6d/IIRVXae+WrEntddwILGPGZwVsS8tpzCvckFaLbFzPcemA==
X-Google-Smtp-Source: ABdhPJxK+mSRIxbq7ZjY3oQpbn9XxNGyi2jVcDrPy7XVZ7bKs1bNhVxfTDneDCTglx1rHsYTBsckyEPChVL/nMFyQoM=
X-Received: by 2002:a25:2a52:0:b0:648:f7b4:7cb8 with SMTP id
 q79-20020a252a52000000b00648f7b47cb8mr6535056ybq.431.1651226395982; Fri, 29
 Apr 2022 02:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220421221159.31729-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220421221159.31729-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVqk1ryzzK9-BZCMDPeyjfF1-8hMpzUoEPCcg8pJ2-ang@mail.gmail.com>
 <CA+V-a8tosEeNqzPZsdX=VCKTrkQfAhpMRWQDwva+fpQGc8x+jA@mail.gmail.com> <CAMuHMdWTQkxZjCtWhcRnOo6w-Vz6SKrjuaK-YOMr=qfwLnD7Rg@mail.gmail.com>
In-Reply-To: <CAMuHMdWTQkxZjCtWhcRnOo6w-Vz6SKrjuaK-YOMr=qfwLnD7Rg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 29 Apr 2022 10:59:29 +0100
Message-ID: <CA+V-a8sJrODEXosafcsk64gwPRRu6Bv+bO5JDfmbXZpqw-W2Og@mail.gmail.com>
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

On Fri, Apr 29, 2022 at 10:53 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Fri, Apr 29, 2022 at 11:43 AM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Thu, Apr 28, 2022 at 10:42 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Fri, Apr 22, 2022 at 12:12 AM Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > Add a driver for the Renesas RZ/G2L Interrupt Controller.
> > > >
> > > > This supports external pins being used as interrupts. It supports
> > > > one line for NMI, 8 external pins and 32 GPIO pins (out of 123)
> > > > to be used as IRQ lines.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> > > > --- /dev/null
> > > > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > > > @@ -0,0 +1,447 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Renesas RZ/G2L IRQC Driver
> > > > + *
> > > > + * Copyright (C) 2022 Renesas Electronics Corporation.
> > > > + *
> > > > + * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > + */
> > > > +
> > > > +#include <linux/clk.h>
> > > > +#include <linux/err.h>
> > > > +#include <linux/io.h>
> > > > +#include <linux/irqchip.h>
> > > > +#include <linux/irqdomain.h>
> > > > +#include <linux/of_address.h>
> > > > +#include <linux/reset.h>
> > > > +#include <linux/spinlock.h>
> > > > +
> > > > +#define IRQC_IRQ_START                 1
> > > > +#define IRQC_IRQ_COUNT                 8
> > > > +#define IRQC_TINT_START                        9
> > >
> > > = IRQC_IRQ_START + IRQC_IRQ_COUNT
> > >
> > OK
> >
> > > > +#define IRQC_TINT_COUNT                        32
> > > > +#define IRQC_NUM_IRQ                   41
> > >
> > > = IRQC_TINT_START + IRQC_TINT_COUNT
> > >
> > OK.
> >
> > > Should these be in a DT binding header file?
> > >
> > > Combining all types into a single linear number space makes it hard
> > > to extend the range, when reusing for an SoC that supports more
> > > interrupt sources.
> > >
> > Or  DT data maybe?
>
> Let's leave it for now. As I missed that DT consumers will refer to
> external interrupt numbers only (is that actually enforced?), there
> won't be an issue.
>
> The driver can be changed later to derive IRQC_IRQ_COUNT from the
> compatible value, when needed.
>
Agreed.

> > > > +       u32 reg;
> > > > +
> > > > +       reg = readl_relaxed(priv->base + ISCR);
> > > > +       if (reg & bit)
> > > > +               writel_relaxed(GENMASK(IRQC_IRQ_COUNT - 1, 0) & ~bit,
> > >
> > > As writes to the unused upper bits are ignored, you can drop the
> > > masking with GENMASK(IRQC_IRQ_COUNT - 1, 0), and be prepared for more
> > > interrupt sources.
> > >
> > Agreed.
>
> > > > +       u32 bit = BIT(hw_irq - IRQC_TINT_START);
> > > > +       u32 reg;
> > > > +
> > > > +       reg = readl_relaxed(priv->base + TSCR);
> > > > +       if (reg & bit)
> > > > +               writel_relaxed(GENMASK(IRQC_TINT_COUNT - 1, 0) & ~bit,
> > >
> > > Drop the masking with all-ones?
> > >
> > You mean instead of a mask just use the reg instead?
>
> No, I meant to drop the masking with GENMASK(IRQC_TINT_COUNT - 1, 0),
> cfr. for external interrupts.
>
Ahh right, I missed that.

Cheers,
Prabhakar

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

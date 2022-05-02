Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8321E516A46
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 07:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383321AbiEBFZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 01:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbiEBFZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 01:25:29 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980951A064;
        Sun,  1 May 2022 22:22:01 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id g28so24277168ybj.10;
        Sun, 01 May 2022 22:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h0S6lgpEgIBiX1LNh6vnZzSlK5+OJoieOd/tDumqVYQ=;
        b=Pg5OWiL1C1NG4t1Akrt8OzF9rK7qIbFjX0OWkvNJBd50V34GQBnKgYLE3Pc6mR8OoW
         ptb1IembQ7dPV3IUtXcLlpQ3AEm2sFlijZSZUCLCX4Ub8DcG5uimMTJnU48albRY3RVt
         iYrpFWb1dkpxKTyykQpTQ7BSQBTOccgoXnGoeXtJOy1wZMmdahXB8I4vhTE78VWPgl+i
         KiR/i0hXhpPmjqHSeHV4k4gvB0as5jHP0FDZoX3uf9gawo9flXGCP+Y8R3t5EQSCx5O8
         +F3wh4uvPgzCJi0d4dVMjPV+Cy0SGBB8azcS9OPaGym+uXhfSbib33L+/yBLz6IEY4tj
         cq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h0S6lgpEgIBiX1LNh6vnZzSlK5+OJoieOd/tDumqVYQ=;
        b=rmwm7WCngZaj+H8zfwAHvCIZ4P37LffXGVRP3wnRXfxI609sSrnW58IZUn7WNlAK0W
         W1Uz9YEuo6kl2EHsLFtyaPyr0TPOq1Yg73DA5IL6rnOe+cU0jAs/OmCrb1T73BmV/cOi
         oxTgRVUBsggZQNzOCXeUDnBadh6cxqOQXnhCPKRsMJZMEHy5qnm91CR+VKu63Ojan9gA
         C88WdHIVRYnWRRwa3LGry2e6xYtL988p+6BiQNTvJN1JUc+cdQuNEZEClGqMbur1XmUK
         matleCX1tJq6l0O7Hi3SCzo6pEC0LDa/sNg8i31xoTHigFGZZUP2Gtr8sMPkTUCGrtVp
         FVfA==
X-Gm-Message-State: AOAM531BEAfSlPgU4yCHMFYSFVr6wVTHG3QEEqq3TWUGih3sK8YCR3ZD
        p2LEcjTQ8jhnuMppklZZJGHhXxPjHcuJ/4VQkDMfaKXQWfm5gQ==
X-Google-Smtp-Source: ABdhPJwKW8E886UaDpY97eiOjRMw/xgZmZQT2IsChIW21uVEBehu9zoVBPT3x8xG8+RVIv1Nx6RGPMyPmkO8CxgNI7c=
X-Received: by 2002:a25:8812:0:b0:633:7bd8:16ff with SMTP id
 c18-20020a258812000000b006337bd816ffmr9220534ybl.645.1651468920822; Sun, 01
 May 2022 22:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220421221159.31729-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220421221159.31729-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVqk1ryzzK9-BZCMDPeyjfF1-8hMpzUoEPCcg8pJ2-ang@mail.gmail.com>
 <CA+V-a8tosEeNqzPZsdX=VCKTrkQfAhpMRWQDwva+fpQGc8x+jA@mail.gmail.com>
 <CAMuHMdWTQkxZjCtWhcRnOo6w-Vz6SKrjuaK-YOMr=qfwLnD7Rg@mail.gmail.com> <CA+V-a8sJrODEXosafcsk64gwPRRu6Bv+bO5JDfmbXZpqw-W2Og@mail.gmail.com>
In-Reply-To: <CA+V-a8sJrODEXosafcsk64gwPRRu6Bv+bO5JDfmbXZpqw-W2Og@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 2 May 2022 06:21:34 +0100
Message-ID: <CA+V-a8suzvW8yLvuj=Knf895KaGmQEghP2R8u_ki3MSFA5pTwQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Fri, Apr 29, 2022 at 10:59 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Geert,
>
> On Fri, Apr 29, 2022 at 10:53 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> >
> > Hi Prabhakar,
> >
> > On Fri, Apr 29, 2022 at 11:43 AM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Thu, Apr 28, 2022 at 10:42 AM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > > > On Fri, Apr 22, 2022 at 12:12 AM Lad Prabhakar
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > > Add a driver for the Renesas RZ/G2L Interrupt Controller.
> > > > >
> > > > > This supports external pins being used as interrupts. It supports
> > > > > one line for NMI, 8 external pins and 32 GPIO pins (out of 123)
> > > > > to be used as IRQ lines.
> > > > >
> > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > > > > --- /dev/null
> > > > > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > > > > @@ -0,0 +1,447 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * Renesas RZ/G2L IRQC Driver
> > > > > + *
> > > > > + * Copyright (C) 2022 Renesas Electronics Corporation.
> > > > > + *
> > > > > + * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > + */
> > > > > +
> > > > > +#include <linux/clk.h>
> > > > > +#include <linux/err.h>
> > > > > +#include <linux/io.h>
> > > > > +#include <linux/irqchip.h>
> > > > > +#include <linux/irqdomain.h>
> > > > > +#include <linux/of_address.h>
> > > > > +#include <linux/reset.h>
> > > > > +#include <linux/spinlock.h>
> > > > > +
> > > > > +#define IRQC_IRQ_START                 1
> > > > > +#define IRQC_IRQ_COUNT                 8
> > > > > +#define IRQC_TINT_START                        9
> > > >
> > > > = IRQC_IRQ_START + IRQC_IRQ_COUNT
> > > >
> > > OK
> > >
> > > > > +#define IRQC_TINT_COUNT                        32
> > > > > +#define IRQC_NUM_IRQ                   41
> > > >
> > > > = IRQC_TINT_START + IRQC_TINT_COUNT
> > > >
> > > OK.
> > >
> > > > Should these be in a DT binding header file?
> > > >
> > > > Combining all types into a single linear number space makes it hard
> > > > to extend the range, when reusing for an SoC that supports more
> > > > interrupt sources.
> > > >
> > > Or  DT data maybe?
> >
> > Let's leave it for now. As I missed that DT consumers will refer to
> > external interrupt numbers only (is that actually enforced?), there
> > won't be an issue.
> >
> > The driver can be changed later to derive IRQC_IRQ_COUNT from the
> > compatible value, when needed.
> >
> Agreed.
>
> > > > > +       u32 reg;
> > > > > +
> > > > > +       reg = readl_relaxed(priv->base + ISCR);
> > > > > +       if (reg & bit)
> > > > > +               writel_relaxed(GENMASK(IRQC_IRQ_COUNT - 1, 0) & ~bit,
> > > >
> > > > As writes to the unused upper bits are ignored, you can drop the
> > > > masking with GENMASK(IRQC_IRQ_COUNT - 1, 0), and be prepared for more
> > > > interrupt sources.
> > > >
> > > Agreed.
> >
> > > > > +       u32 bit = BIT(hw_irq - IRQC_TINT_START);
> > > > > +       u32 reg;
> > > > > +
> > > > > +       reg = readl_relaxed(priv->base + TSCR);
> > > > > +       if (reg & bit)
> > > > > +               writel_relaxed(GENMASK(IRQC_TINT_COUNT - 1, 0) & ~bit,
> > > >
> > > > Drop the masking with all-ones?
> > > >
> > > You mean instead of a mask just use the reg instead?
> >
> > No, I meant to drop the masking with GENMASK(IRQC_TINT_COUNT - 1, 0),
> > cfr. for external interrupts.
> >
> Ahh right, I missed that.
>
I would need reg to clear off the bit if I drop the mask.

Cheers,
Prabhakar

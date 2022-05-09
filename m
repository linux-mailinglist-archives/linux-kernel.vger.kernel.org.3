Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979C7520547
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 21:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240577AbiEIT2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 15:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240567AbiEIT2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 15:28:47 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD1513C344;
        Mon,  9 May 2022 12:24:52 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id r11so26762857ybg.6;
        Mon, 09 May 2022 12:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6eYHL3htjuqUuc5ZQAjLpv+iz8OHLUbS2twjBjqyVGo=;
        b=SwjaZh6vcE92Xn0LoEo7La82fpVvifhHHOOOtoSaO0qtVMWhhQO7NFtCA+W7ueMH+M
         UNhOVFDlLv4V+R3GmEyvXHkBFVuPvW+X06/re+MJg4Jzi9jf0O2kDTWkFeViJFH4FlXd
         l3d9fiLGN4RqHklQBYYJ8gy3+b63lX1mY0Uq0CyZRu+4NlSIr52I3wKuo9yunabgJGlC
         xEAONdLCFfFeeVFvXQUqItnPfucuaZO1Q/SjFbFwHYrdJQPNJP/CYKUrWpEqjG5lFYo1
         KCIgQKapovTiYYADVfhtSbdjzqR932TDqMOOXUWpZ+QN9lZXtKBOzL/VFQHrp0ErJXIy
         Rzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6eYHL3htjuqUuc5ZQAjLpv+iz8OHLUbS2twjBjqyVGo=;
        b=WQCf3t6o9i3HfBr+ATGjJW2sfpLFpSIwZcP81PqMiHxrkGZTd+GKM7ESWl4ecofGMC
         7ogXnbdUWmwQEMnJfnQTtNqCvgz0pdBc99KYjHTD22svV2OxL4MJTuFo1AmdXuSAbPz7
         U9U3yMVBlfM9ZjvNsSjLwTqMFkpPvyhXLZ2aBbJtqo9sgEgqpOPEN33LdKTR7JjXmIII
         Nu+MjnNBIPSJ2BRtcZWoe+8R/dzycYKzvP1JYRl+vvK0PXv/Lt7ULheXrf0DFopU3zR5
         ySmIT1DotCc5Q6Q7zY6W4XUtwt657xc8cpwZ2eGgb1KfwR1KOo3TAoPv3d69G7s7fe1A
         Jf9w==
X-Gm-Message-State: AOAM5322LAhOA5LgCCBOLeFMEULmE51ioknf76guTq3f8xmPFI6uYBJ0
        OX+uYGX1s5c6w3DCyXxHI4mliK1NnCpXq/v2gpiW+aT5bu3C5w==
X-Google-Smtp-Source: ABdhPJxbmv4gl3f8BwWDkVhsiQ2Vn2r1krelgX6Sd+Ncpn/ySOC77iTTCE/WHZiKyq2Epq7UMwxIZ7X0KGZlyCNt8Ng=
X-Received: by 2002:a25:83d1:0:b0:648:725c:6a05 with SMTP id
 v17-20020a2583d1000000b00648725c6a05mr14335902ybm.218.1652124292128; Mon, 09
 May 2022 12:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220509050953.11005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220509050953.11005-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922B58BB70B92813041745786C69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdVuLq1Q2KB7gFQ5MsQmyUTv4yuu-GUBVn_xGwKhUwYQZg@mail.gmail.com>
In-Reply-To: <CAMuHMdVuLq1Q2KB7gFQ5MsQmyUTv4yuu-GUBVn_xGwKhUwYQZg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 9 May 2022 20:24:25 +0100
Message-ID: <CA+V-a8uG8qzzWj+=6EhzSd5j8NC3bpf=9tU9jgxzK8Cg75BTtw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller driver
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
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

Thank you for the review.

On Mon, May 9, 2022 at 10:10 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Mon, May 9, 2022 at 9:22 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > Subject: [PATCH v2 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller
> > > driver
> > >
> > > Add a driver for the Renesas RZ/G2L Interrupt Controller.
> > >
> > > This supports external pins being used as interrupts. It supports one line
> > > for NMI, 8 external pins and 32 GPIO pins (out of 123) to be used as IRQ
> > > lines.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> > > --- /dev/null
> > > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
>
> > > +static void rzg2l_irqc_irq_disable(struct irq_data *d) {
> > > +     unsigned int hw_irq = irqd_to_hwirq(d);
> > > +
> > > +     if (hw_irq >= IRQC_TINT_START && hw_irq <= IRQC_TINT_COUNT) {
> > > +             struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > > +             u32 offset = hw_irq - IRQC_TINT_START;
> > > +             u32 tssr_offset = TSSR_OFFSET(offset);
> > > +             u8 tssr_index = TSSR_INDEX(offset);
> > > +             u32 reg;
> > > +
> > > +             raw_spin_lock(&priv->lock);
> > > +             reg = readl_relaxed(priv->base + TSSR(tssr_index));
> > > +             reg &= ~(TSSEL_MASK << tssr_offset);
> > > +             writel_relaxed(reg, priv->base + TSSR(tssr_index));
> > > +             raw_spin_unlock(&priv->lock);
> > > +     }
> > > +     irq_chip_disable_parent(d);
> > > +}
>
> > > +static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type) {
> > > +     struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > > +     unsigned int hwirq = irqd_to_hwirq(d);
> > > +     u32 titseln = hwirq - IRQC_TINT_START;
> > > +     u32 offset;
> > > +     u8 sense;
> > > +     u32 reg;
> > > +
> > > +     switch (type & IRQ_TYPE_SENSE_MASK) {
> > > +     case IRQ_TYPE_EDGE_RISING:
> > > +             sense = TITSR_TITSEL_EDGE_RISING;
> > > +             break;
> > > +
> > > +     case IRQ_TYPE_EDGE_FALLING:
> > > +             sense = TITSR_TITSEL_EDGE_FALLING;
> > > +             break;
> > > +
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +
> >
> > > +     if (titseln < TITSR0_MAX_INT) {
> > > +             offset = TITSR0;
> > > +     } else {
> > > +             titseln /= TITSEL_WIDTH;
> > > +             offset  = TITSR1;
> > > +     }
> >
> > as TITSR0 (0x24) and TITSR1(0x28) are contiguous address location
> >
> > May be like others, above declare it as
> > u32 offset = TITSR0; ??
> >
> > and here
> >  if ((titseln >= TITSR0_MAX_INT) {
> >         titseln /= TITSEL_WIDTH;
> >         offset  += 4;
> >  }
>
> Why "titseln /= TITSEL_WIDTH"?
> Shouldn't that be "titseln -= TITSR0_MAX_INT"?

Ouch, that should be "titseln -= TITSR0_MAX_INT".

> Do I need more coffee?
>
> Can't you define TITSR_{OFFSET,INDEX}() helper macros, like for
> TSSR above?
>
you mean a macro to get the TITSELx offset?

Cheers,
Prabhakar

> > > +
> > > +     raw_spin_lock(&priv->lock);
> > > +     reg = readl_relaxed(priv->base + offset);
> > > +     reg &= ~(IRQ_MASK << (titseln * TITSEL_WIDTH));
> > > +     reg |= sense << (titseln * TITSEL_WIDTH);
> > > +     writel_relaxed(reg, priv->base + offset);
> > > +     raw_spin_unlock(&priv->lock);
> > > +
> > > +     return 0;
> > > +}
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

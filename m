Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8E55253C7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357097AbiELRgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242790AbiELRgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:36:45 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1D3326DC;
        Thu, 12 May 2022 10:36:44 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id v59so11048420ybi.12;
        Thu, 12 May 2022 10:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KciQs1/yGPFy4fqE//6Ur4aaE5S7VXUIcGW3EivMUbE=;
        b=oyqcMoSqA9aJbw6tLEyAEmjGIo5MGdgCc178Lenc5EP96fr8XQpAKmLnA0r3Hi77nE
         518JToT5uKJfGIh9i852Ija2MoD3hdQ0F14OmHn0ZLpw5B1kVXqS0UcIM0LtEGz+x6oo
         03JwJm4oSNliaI7ciuuM594DUQEuyWnx1yxB2wCorI1NmSCMnJ03PtPwSrnZr9ZvLDlb
         vYlrXeMT10Pp523tln1zkXiJX/Dj3pEjFBGWwisLCoohWK3vMh6RHb1quHAJzt/mSJzI
         uwPM4GZI+j256eRqydeg/bRYI7p3Yqqeaq3DDxUqm/nqQirO/4B7kLiaBfaxE0WXlPLu
         b7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KciQs1/yGPFy4fqE//6Ur4aaE5S7VXUIcGW3EivMUbE=;
        b=QC/UqLAfrk9XGplj4Rm1tT02TGPvqt6umhPI8uPCbNen73fbFJ4MsDemg5K+QLgQTu
         McR5kuj5AiPyWxB0wTSMDhB6OT2hYIML56kT5xr0CRwJB2hwWs0qvdBRiwG1dKP5DXJl
         C2jqVjGmS4Fqr5Z6DJSweQvkSjqEThWdxm35ezjENdAXCGtPFYaH9pDN4lgzpL8+yCvn
         bdMKBdKvSvaUispWWpBzyuQsKPM2Di0CeIXqvk2eTn0P+zCoYi1CamaYb4jzNZxCr4qn
         folLg/uTnTtPc6okKc8nempP1NYobi0ffCgUGwBHhD9SRmZ+YajYVVl8wHsFFRMsynsa
         GKoA==
X-Gm-Message-State: AOAM531GeW1/WkHo9s2Fsh7OSeMuW7xRXQLgDE1lcycaSChAvUctmT3t
        lOYW4AB2gV6XfTbIbVUGTF/vgxroC0r3XIOoLlezGyvxCiPfIg==
X-Google-Smtp-Source: ABdhPJy7tamfWD3GzonlIuCs/c5Z8ME6ymOgP0txO82R0MNHZdWpF2nfgYrkTEGiVeSfyg5H1eLJ6i+GhPCdudBItZ8=
X-Received: by 2002:a25:83d1:0:b0:648:725c:6a05 with SMTP id
 v17-20020a2583d1000000b00648725c6a05mr915020ybm.218.1652377003238; Thu, 12
 May 2022 10:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXDQ+eECWwvAGOb-MaN16H17qm_v_1baZ7PdT8qx9McSw@mail.gmail.com>
In-Reply-To: <CAMuHMdXDQ+eECWwvAGOb-MaN16H17qm_v_1baZ7PdT8qx9McSw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 12 May 2022 18:36:16 +0100
Message-ID: <CA+V-a8tNrJQtAQYoUKVwH9w4QOyA9JUWNjiYDPUPsj6UuJ4vaA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to
 handle GPIO interrupt
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
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

Thank you for the review.

On Thu, May 12, 2022 at 8:39 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, May 11, 2022 at 8:32 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Add IRQ domian to RZ/G2L pinctrl driver to handle GPIO interrupt.
>
> domain
>
ouch.

> > GPIO0-GPIO122 pins can be used as IRQ lines but only 32 pins can be
> > used as IRQ lines at given time. Selection of pins as IRQ lines
>
> at a given time
>
will fix that.

> > is handled by IA55 (which is the IRQC block) which sits in between the
> > GPIO and GIC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
>
> >  static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
> >  {
> >         struct device_node *np = pctrl->dev->of_node;
> >         struct gpio_chip *chip = &pctrl->gpio_chip;
> >         const char *name = dev_name(pctrl->dev);
> > +       struct irq_domain *parent_domain;
> >         struct of_phandle_args of_args;
> > +       struct device_node *parent_np;
> > +       struct gpio_irq_chip *girq;
> >         int ret;
> >
> > +       parent_np = of_irq_find_parent(np);
> > +       if (!parent_np)
> > +               return -ENXIO;
> > +
> > +       parent_domain = irq_find_host(parent_np);
> > +       of_node_put(parent_np);
> > +       if (!parent_domain)
> > +               return -EPROBE_DEFER;
> > +
> >         ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &of_args);
> >         if (ret) {
> >                 dev_err(pctrl->dev, "Unable to parse gpio-ranges\n");
> > @@ -1138,6 +1330,15 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
> >         chip->base = -1;
> >         chip->ngpio = of_args.args[2];
> >
> > +       girq = &chip->irq;
> > +       girq->chip = &rzg2l_gpio_irqchip;
> > +       girq->fwnode = of_node_to_fwnode(np);
> > +       girq->parent_domain = parent_domain;
> > +       girq->child_to_parent_hwirq = rzg2l_gpio_child_to_parent_hwirq;
> > +       girq->populate_parent_alloc_arg = rzg2l_gpio_populate_parent_fwspec;
> > +       girq->child_irq_domain_ops.free = rzg2l_gpio_irq_domain_free;
> > +       girq->ngirq = RZG2L_TINT_MAX_INTERRUPT;
> > +
>
> I think you need to provide a .init_valid_mask() callback, as
> gpiochip_irqchip_remove() relies on that for destroying interrupts.
Are you suggesting  the callback to avoid looping through all the GPIO pins?

> However, the mask will need to be dynamic, as GPIO interrupts can be
> mapped and unmapped to one of the 32 available interrupts dynamically,
> right?
Yep that's correct.

> I'm not sure if that can be done easily: if gpiochip_irqchip_irq_valid()
> is ever called too early, before the mapping is done, it would fail.
>
The mask initialization is a one time process and that is during
adding the GPIO chip. At this stage we won't be knowing what will be
the valid GPIO pins used as interrupts. Maybe the core needs to
implement a callback which lands in the GPIO controller driver to tell
if the gpio irq line is valid. This way we can handle dynamic
interrupts.

Cheers,
Prabhakar

> >         pctrl->gpio_range.id = 0;
> >         pctrl->gpio_range.pin_base = 0;
> >         pctrl->gpio_range.base = 0;
>
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

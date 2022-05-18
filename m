Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B0052C309
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241753AbiERTFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241721AbiERTFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:05:13 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA65219C39;
        Wed, 18 May 2022 12:05:11 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id j2so5394387ybu.0;
        Wed, 18 May 2022 12:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Ym4EPTW2IHjVAJfTWMpp3zavD3cyKN/HSx+d8rQORU=;
        b=Pp++3AvSh/NrzEJlRJfor3jo6mR/jcOKRu1/OEg168HP+cBI1p7HHGIVRzBoocP8Ri
         yMHAzFrV/L+S9YWJByxOahZB3YLrXdlMw4fZwUjHCIiXoY1fB+An9ijnlCN8SnFmFYW+
         Xn3qxZQObCurz/Qtxk/kL+Q8Q4GHwp08EnY1yVDtZw64zisQSGPIqR/4OQ4NosEVU5hF
         DA8IJi24j4v30Ui5pfIgq+ifF0K9W1pPf5VdY0nc4UaC15yC0gVaTEdSC5U+4bwsNNtG
         cIxywXeplw+H3iJhR7EI528KKeHGmXM0F8I8xKK1dIbrTf2drEwKvb5r39j/8UFCegue
         LPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Ym4EPTW2IHjVAJfTWMpp3zavD3cyKN/HSx+d8rQORU=;
        b=uUNlWyu/mrw2+lfPYa8ds1glwJgKKBeX5FB5a8SBAmGvafCUUW7oS3d1xHslChnwm2
         9r5+NRXnZcGWPP5/5qZtpKcVih6r6kRLaySn+47toiM7NkA+lt2eaR3QwOYqJUmLngoC
         aZSZarbILN2rQ4r2G/ESFjZwEDCgZDkQ8j52tMMBllwnEPoSoE8Mh9WRmQMJjZ7h6BYx
         GvfLbb/5nhyHMh1rcs3oZ1Z3E+bKTmbg2lvzOKKelovKf1vmY43KtYw+a2rkBxkFl/Q7
         aIQ/mq/l12p9sQBqTr5v1z6ofB+O27VAaTOgfdDI25VUeSYyRcw4MEzJshOZ/fkUgfzV
         p8Yw==
X-Gm-Message-State: AOAM532qbst6C0RinSNNJeC9qvHp8JVG1nxiJrvwzr/8+Y+A7n5NtDvU
        9rJaF9+J5vv/DCaDjzIr6folkKRIqRrAuj6qQMk=
X-Google-Smtp-Source: ABdhPJyuxRfWvsTcaDsykoIPgSkD5uQYOpIzUjI8pKKYDFYTcAWsKKCe30HMAIiT1GgyccfNOLzNpSII7O4Iv5CjVss=
X-Received: by 2002:a25:ab84:0:b0:64e:3d2:8a6f with SMTP id
 v4-20020a25ab84000000b0064e03d28a6fmr988996ybi.431.1652900710872; Wed, 18 May
 2022 12:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXDQ+eECWwvAGOb-MaN16H17qm_v_1baZ7PdT8qx9McSw@mail.gmail.com>
 <CA+V-a8tNrJQtAQYoUKVwH9w4QOyA9JUWNjiYDPUPsj6UuJ4vaA@mail.gmail.com>
 <CAMuHMdVazy9y_U6Nva+B-3vuX1Ersq+QirXDDgSh28pj8s=EJA@mail.gmail.com>
 <CA+V-a8s2Gf22MPLoZMJS_5uDwzOboJ2i8rZ3KdRFy7a7wv8pGg@mail.gmail.com>
 <CAMuHMdXHJ385isGd-x8u4sFm1w=rxOC89SUryYbSd34bijkb0g@mail.gmail.com>
 <CA+V-a8uXakF45TLvpsfeAY_EZKDGHr-wfgqLR_LTz1ZAo8FYmg@mail.gmail.com> <CAMuHMdVD_f-fZDw=ZhCmR6V3osTooode3exBUwCjJEvY=goS9A@mail.gmail.com>
In-Reply-To: <CAMuHMdVD_f-fZDw=ZhCmR6V3osTooode3exBUwCjJEvY=goS9A@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 18 May 2022 20:04:44 +0100
Message-ID: <CA+V-a8uqoR3tJrfGAR-bTz23HR0=63kDd9TYuPRPesc8LWBT0Q@mail.gmail.com>
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

On Mon, May 16, 2022 at 8:14 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Fri, May 13, 2022 at 8:13 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Fri, May 13, 2022 at 3:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, May 13, 2022 at 3:56 PM Lad, Prabhakar
> > > <prabhakar.csengg@gmail.com> wrote:
> > > > On Fri, May 13, 2022 at 7:53 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Thu, May 12, 2022 at 7:36 PM Lad, Prabhakar
> > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > > On Thu, May 12, 2022 at 8:39 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > On Wed, May 11, 2022 at 8:32 PM Lad Prabhakar
> > > > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > > > > > Add IRQ domian to RZ/G2L pinctrl driver to handle GPIO interrupt.
> > > > > > > > GPIO0-GPIO122 pins can be used as IRQ lines but only 32 pins can be
> > > > > > > > used as IRQ lines at given time. Selection of pins as IRQ lines
> > > > > > > > is handled by IA55 (which is the IRQC block) which sits in between the
> > > > > > > > GPIO and GIC.
> > > > > > > >
> > > > > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > >
> > > > > > > Thanks for your patch!
> > > > > > >
> > > > > > > > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > > > > > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > > > >
> > > > > > > >  static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
> > > > > > > >  {
> > > > > > > >         struct device_node *np = pctrl->dev->of_node;
> > > > > > > >         struct gpio_chip *chip = &pctrl->gpio_chip;
> > > > > > > >         const char *name = dev_name(pctrl->dev);
> > > > > > > > +       struct irq_domain *parent_domain;
> > > > > > > >         struct of_phandle_args of_args;
> > > > > > > > +       struct device_node *parent_np;
> > > > > > > > +       struct gpio_irq_chip *girq;
> > > > > > > >         int ret;
> > > > > > > >
> > > > > > > > +       parent_np = of_irq_find_parent(np);
> > > > > > > > +       if (!parent_np)
> > > > > > > > +               return -ENXIO;
> > > > > > > > +
> > > > > > > > +       parent_domain = irq_find_host(parent_np);
> > > > > > > > +       of_node_put(parent_np);
> > > > > > > > +       if (!parent_domain)
> > > > > > > > +               return -EPROBE_DEFER;
> > > > > > > > +
> > > > > > > >         ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &of_args);
> > > > > > > >         if (ret) {
> > > > > > > >                 dev_err(pctrl->dev, "Unable to parse gpio-ranges\n");
> > > > > > > > @@ -1138,6 +1330,15 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
> > > > > > > >         chip->base = -1;
> > > > > > > >         chip->ngpio = of_args.args[2];
> > > > > > > >
> > > > > > > > +       girq = &chip->irq;
> > > > > > > > +       girq->chip = &rzg2l_gpio_irqchip;
> > > > > > > > +       girq->fwnode = of_node_to_fwnode(np);
> > > > > > > > +       girq->parent_domain = parent_domain;
> > > > > > > > +       girq->child_to_parent_hwirq = rzg2l_gpio_child_to_parent_hwirq;
> > > > > > > > +       girq->populate_parent_alloc_arg = rzg2l_gpio_populate_parent_fwspec;
> > > > > > > > +       girq->child_irq_domain_ops.free = rzg2l_gpio_irq_domain_free;
> > > > > > > > +       girq->ngirq = RZG2L_TINT_MAX_INTERRUPT;
> > > > > > > > +
> > > > > > >
> > > > > > > I think you need to provide a .init_valid_mask() callback, as
> > > > > > > gpiochip_irqchip_remove() relies on that for destroying interrupts.
> > > > > > Are you suggesting  the callback to avoid looping through all the GPIO pins?
> > > > >
> > > > > gpiochip_irqchip_remove() does:
> > > > >
> > > > >         /* Remove all IRQ mappings and delete the domain */
> > > > >         if (gc->irq.domain) {
> > > > >                 unsigned int irq;
> > > > >
> > > > >                 for (offset = 0; offset < gc->ngpio; offset++) {
>                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > >                        if (!gpiochip_irqchip_irq_valid(gc, offset))
> > > > >                                 continue;
> > > > >
> > > > >                         irq = irq_find_mapping(gc->irq.domain, offset);
> > > > >                         irq_dispose_mapping(irq);
> > > > >                 }
> > > > >
> > > > >                 irq_domain_remove(gc->irq.domain);
> > > > >
> > > > >         }
> > > > >
> > > > > The main thing is not about avoiding to loop through all GPIO pins,
> > > > > but to avoid irq_{find,dispose}_mapping() doing the wrong thing.
> > > > So in our case if we don't implement valid masks, that would mean all
> > > > the pins are valid. irq_find_mapping() would return 0 if no mapping is
> > > > found to the corresponding offset and irq_dispose_mapping() would
> > > > simply return back without doing anything if virq == 0.(In this patch
> > > > rzg2l_gpio_free() does call irq_{find,dispose}_mapping())
> > >
> > > But "offset" is a number from the GPIO offset space (0-122), while
> >
> > The "offset" reported by kernel is 120-511:
>
> Offsets 120-511 are global GPIO numbers, i.e. starting from
> gpio_chip.base.
> The loop in gpiochip_irqchip_remove() uses local GPIO numbers,
> starting from zero.
> So these offsets are not the same.
>
My bad, offsets will be raging from 0 - 392

> Likewise, I believe the "offset" passed to irq_find_mapping() is an
> irq number (hwirq) local to the domain, i.e. also starting at 0.
> And it must be smaller than the size (32) passed to
> irq_domain_create_hierarchy().
>
Since in the current implementation, offset is used as hwirq, the
irq_find_mapping() returned the correct virqs.

> When passed a non-zero size, irq_domain_create_hierarchy()
> calls into __irq_domain_add(), with size == hwirq_max == 32:
>
>     /**
>      * __irq_domain_add() - Allocate a new irq_domain data structure
>      * @fwnode: firmware node for the interrupt controller
>      * @size: Size of linear map; 0 for radix mapping only
>      * @hwirq_max: Maximum number of interrupts supported by controller
>      * @direct_max: Maximum value of direct maps; Use ~0 for no limit; 0 for no
>      *              direct mapping
>      * @ops: domain callbacks
>      * @host_data: Controller private data pointer
>      *
>      * Allocates and initializes an irq_domain structure.
>      * Returns pointer to IRQ domain, or NULL on failure.
>      */
>     struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode,
> unsigned int size,
>                                         irq_hw_number_t hwirq_max, int
> direct_max,
>                                         const struct irq_domain_ops *ops,
>                                         void *host_data)
>
I have now updated the code to have hwirq's ranging from 0-31 and
implemented the child_offset_to_irq() callback.

> > > > > But we do need to handle the (possible) mismatch between GPIO
> > > > > offset (index) and IRQ offset in the above code.
> > > > >
> > > > Agreed, do you see any possibility of the mismatch I have missed?
> > >
> > > gpiochip_to_irq():
> > >
> > >         if (irq_domain_is_hierarchy(domain)) {
> > >                 struct irq_fwspec spec;
> > >
> > >                 spec.fwnode = domain->fwnode;
> > >                 spec.param_count = 2;
> > >                 spec.param[0] = gc->irq.child_offset_to_irq(gc, offset);
> > >                 spec.param[1] = IRQ_TYPE_NONE;
> > >
> > >                 return irq_create_fwspec_mapping(&spec);
> > >         }
> > >
> > > Same here: in the absence of a child_offset_to_irq() callback,
> > > the default gpiochip_child_offset_to_irq_noop() will be used,
> > > assuming an identity mapping between GPIO numbers and IRQ
> > > numbers.
> > >
> > Agreed, gpiochip_child_offset_to_irq_noop will return the "offset",
> > but irq_create_fwspec_mapping() in gpiochip_to_irq() will return the
> > virq number which will not be equal to the offset.
>
> Shouldn't spec.param[0] be in the range 0-31, as 32 is the size of
> the IRQ domain allocated?
>
Right agreed, but looks like GPIO core is lenient. I have created a
patch to do some checking in the GPIO core.

Cheers,
Prabhakar

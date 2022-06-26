Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC83D55ADCF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 02:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbiFZAf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 20:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiFZAf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 20:35:26 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3E013F30;
        Sat, 25 Jun 2022 17:35:24 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id r3so10800788ybr.6;
        Sat, 25 Jun 2022 17:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tj+3/i4dGkG1RXaP0jdbNan4HTbj1pH9ooQb/lBwHwQ=;
        b=U9K3FE1REOBbgp49jyF+b8nZSbECffDmcEL4J6vlgbTZZH65gltGezwnQAGJO/pmFb
         wBG3+WATVcSWEbPZsi4V1fqoOn57w7ZA0EjckhR0PkFfeF+2kB4K45khIhemwEzD/b7F
         8Ekp6AJ2AUJWT3gXPOXOUBZKcAEQeDBkS32quxK7Q6g4d2J0zVmSjvvtQTU95mmfE1wJ
         5DqpkXxmTG0O6tF4dx5svoevZwrtLxjBlH+Nn+LGqiG+LnQuMvDAjELn22ts/y2KLLI2
         SsTY5GPkqkiVHKPgpbN9UnzdcJpEaOzY5uoynrtZVgQKSPAwwEdGnSEZBMTFtI6PP2Dj
         jk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tj+3/i4dGkG1RXaP0jdbNan4HTbj1pH9ooQb/lBwHwQ=;
        b=5dLrQmDrtPRZMeY81k+REAnFBKCHOULXrsmUB/32/pDgOnAkiC41C4OatClF6O1wTc
         n6ORN1VLSbBG4Qdgi71pdl4PqcLaucMfnKymf9/sLgJnDIDZaEc24ApxNg0swxG2KVvR
         Oh9nSlVhaN06womyLa41mWv1Uxt/NLZnxdkDpEZYZkMmPPpatuKnrmKvS5v6c2GYs9r0
         CcC7Ndmrr6BS88mc+Xvm+wSdiEEGHHpZK8cisB/I4C0GjPbXc/XuLxK7a3klw/QsqwjC
         6XQprQBkX+qdKrD8PpxVIukda12WB5NPrKdgbkDq03yygAti7ZUl/ov8CvNoh+6eqVzS
         dqEw==
X-Gm-Message-State: AJIora86cD94J0dk0x5OHztXRhMbS91Q/YulUn3Jdpd5a7qw5fOlmxNg
        jvZi0DC5SuzO6bF6RVsV50MMJGDWAzAgawGI2ak=
X-Google-Smtp-Source: AGRyM1vhGlkDaXxjpOuY6+cv3Yq5MQC11xily9cqoQuUATSSWpqv1DbiMdWSIGvLk0CfFwe+4pxZtFp4r5GtKQD86EA=
X-Received: by 2002:a25:1c04:0:b0:660:1ffc:fb9 with SMTP id
 c4-20020a251c04000000b006601ffc0fb9mr6615948ybc.431.1656203724095; Sat, 25
 Jun 2022 17:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220624180311.3007-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220624180311.3007-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8735ftf73p.wl-maz@kernel.org> <CA+V-a8ukQsotuWLm6_qR79qO9n_Ffo2e79AitC_=53ocsjZtzA@mail.gmail.com>
 <87h7492c58.wl-maz@kernel.org> <CA+V-a8tFn7aS-1jD6o9TX9kNDQ=4S3xWCXwkww3Es2+Red6vmA@mail.gmail.com>
 <87zgi0eniw.wl-maz@kernel.org>
In-Reply-To: <87zgi0eniw.wl-maz@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sun, 26 Jun 2022 01:34:58 +0100
Message-ID: <CA+V-a8tiU_vkd6Q=ypkJobopZ8fR-NUGftg5JB4nQEb04GLY9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] irqchip/sifive-plic: Add support for Renesas RZ/Five SoC
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

Hi Marc,

On Sat, Jun 25, 2022 at 5:05 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 25 Jun 2022 14:03:33 +0100,
> "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> >
> > [1  <text/plain; UTF-8 (7bit)>]
> > Hi Marc,
> >
> > On Sat, Jun 25, 2022 at 12:52 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
>
> [...]
>
> > > You are just reinventing the wheel we are already have, except that
> > > yours is a bit square ;-). What really should happen is that the
> > > set_type method should set the correct flow depending on the trigger
> > > of the interrupt, and *never* have to check the configuration on the
> > > handling path.
> > >
> > A Bit lost here..
> >
> > We have the below chained handler:
> >
> > static void plic_handle_irq(struct irq_desc *desc)
> > {
> >     struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> >     struct irq_chip *chip = irq_desc_get_chip(desc);
> >     void __iomem *claim = handler->hart_base + CONTEXT_CLAIM;
> >     irq_hw_number_t hwirq;
> >
> >     WARN_ON_ONCE(!handler->present);
> >
> >     chained_irq_enter(chip, desc);
> >
> >     while ((hwirq = readl(claim))) {
> >         int err = generic_handle_domain_irq(handler->priv->irqdomain,
> >                             hwirq);
> >         if (unlikely(err))
> >             pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
> >                     hwirq);
> >     }
> >
> >     chained_irq_exit(chip, desc);
> > }
> >
> > static void plic_irq_eoi(struct irq_data *d)
> > {
> >     struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> >
> >     if (irqd_irq_masked(d)) {
> >         plic_irq_unmask(d);
> >         writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> >         plic_irq_mask(d);
> >     } else {
> >         writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> >     }
> > }
> >
> > Where it's claiming -> handling interrupt -> interrupt completion in
> > eoi which is according to architecture.
> >
> >
> > Now with fasteoi_ack flow If I introduce the below ack callback to
> > issue interrupt completion.
> >
> > static void plic_irq_ack(struct irq_data *d)
> > {
> >     struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> >
> >     if (irqd_irq_masked(d)) {
> >         plic_irq_unmask(d);
> >         writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> >         plic_irq_mask(d);
> >     } else {
> >         writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> >     }
> > }
> >
> > Here we are issuing an interrupt completion first, and later in the
> > handler  plic_handle_irq() we are claiming the interrupt by reading
> > the claim register. With this we are not following [0].
>
> Whatever [0] says doesn't really matter, since the HW is totally
> busted.
>
OK

> > Do you think this flow is OK (interrupt completion -> Interrupt claim
> > -> handle IRQ)?
>
> You keep missing my point. Edge and Level *must* have different flows
> and this also implies different callbacks. You can't just handle both
> at once. You should have something like this (untested):
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index bb87e4c3b88e..5e072be32d9f 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -176,16 +176,52 @@ static void plic_irq_eoi(struct irq_data *d)
>         }
>  }
>
> +static int broken_set_type(struct irq_data *d, unsigned int type);
> +
>  static struct irq_chip plic_chip = {
>         .name           = "SiFive PLIC",
>         .irq_mask       = plic_irq_mask,
>         .irq_unmask     = plic_irq_unmask,
>         .irq_eoi        = plic_irq_eoi,
> +       .irq_set_type   = broken_set_type,
> +#ifdef CONFIG_SMP
> +       .irq_set_affinity = plic_set_affinity,
> +#endif
> +};
> +
> +static void broken_eoi(struct irq_data *data) {}
> +
> +static struct irq_chip plic_chip_edge = {
> +       .name           = "Edgy PLIC",
> +       .irq_mask       = plic_irq_mask,
> +       .irq_unmask     = plic_irq_unmask,
> +       .irq_ack        = plic_irq_eoi,
> +       .irq_eoi        = broken_eoi,
> +       .irq_set_type   = broken_set_type,
>  #ifdef CONFIG_SMP
>         .irq_set_affinity = plic_set_affinity,
>  #endif
>  };
>
> +static int broken_set_type(struct irq_data *d, unsigned int type)
> +{
> +       if (!plic_is_totaly_broken())
> +               return 0;
> +
> +       if (type == IRQ_TYPE_EDGE_RISING)
> +               irq_set_chip_handler_name_locked(d, plic_chip_edge,
> +                                                handle_fasteoi_ack_irq,
> +                                                "Edge");
> +       else if (type == IRQ_TYPE_LEVEL_HIGH)
> +               irq_set_chip_handler_name_locked(d, plic_chip,
> +                                                handle_fasteoi_irq,
> +                                                "Level");
> +       else
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
>  static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
>                               irq_hw_number_t hwirq)
>  {
>
> which applies the correct flow and chip depending on the trigger
> information. This also implies that for chained PLICs, the secondary
> PLIC output is handled as a level into the primary PLIC.
>
Agreed, the above chunk does work. I'll re-spin a v2 with the above included.

Cheers,
Prabhakar

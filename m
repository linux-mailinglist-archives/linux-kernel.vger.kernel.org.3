Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D099D55AA50
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 15:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiFYNEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 09:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiFYNED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 09:04:03 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B7FE19;
        Sat, 25 Jun 2022 06:04:01 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3176b6ed923so47396497b3.11;
        Sat, 25 Jun 2022 06:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/9OFaB4h6IMq/rg9Plnm8+Xn65NgnDcPOTKbYYDfaHI=;
        b=kDO6sM2e/ADDV5FJhZbIfn7S9hD2SlLtFEpu5ZVoH8aNscBk/EckYsYmjRN7bmsCrz
         bWnkMbQ1zfzp4itbyqBWs4PZEeZ44SYnNazLxWmEd2zXVPcCbdYgENO5s3PYDdp1mBKp
         ZQGOOozoLCJoNlRu47f4s2aEsaWSwO99yWxJF9xaxdDoH5hU5O+ZALNj60wr/wTaZJaK
         l4Njw3UHqcG2V4whlAWV9bILWkq9L/sbWAyBz1CHkbOHy+6iQSd9XyM6jxpkQPp5XW7a
         RWl/cF2vToZSsShWuZsqQJdC9MLOlMdj7Fo+G3PVNuPA1mggpo8ziBxMbJfGw1a7139b
         u8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9OFaB4h6IMq/rg9Plnm8+Xn65NgnDcPOTKbYYDfaHI=;
        b=YImxuxJHbfCgIpTp15YYNLSh0rrp9BQ8XYM2RgYoFwXPIww8JOX79EBkN/5FFgCIuu
         nVSyHxa2ob/MRIu/BVW/0sfO6XMf57+MJDBZRw52Jh6JNAtV7Y39cdh66Po3RUjoxQjt
         2wurlhbLGlgjhe26u91lpa8qGMJ867E4yq/U9oo3xaKvx00cjUyAt42n4O1AtMZ8UuyI
         3ErXHW2byIig07YQ/7Lu5mmNmh6PjUiSt+wpl53NJXbSjW37EuePTEOuEQj83jjWuDY0
         +1I5fOulEAcwb7uCYIxXSWDs+cJYIlKogtjgKYwb/KgRULzCYU+tnTIoC2u0wjm/5KZP
         cQ9A==
X-Gm-Message-State: AJIora9Z01raG5zVPkC4fIVmyqydSa8P+tn+FI64dGwnFmhbm+QwKbkf
        aN0yAc4995Q11jDhXQvRHeAUdGQg66BxVmWBgYCqRST22SSQNA==
X-Google-Smtp-Source: AGRyM1sp26XXyCof44+FVY9yOdRYJ2piZA1svu5HCqKBgGNd9NevPmfQnOJjcDtzPPkmcvtou39atX80v11gnx4JZBk=
X-Received: by 2002:a81:989:0:b0:318:38c3:ade0 with SMTP id
 131-20020a810989000000b0031838c3ade0mr4560224ywj.292.1656162240292; Sat, 25
 Jun 2022 06:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220624180311.3007-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220624180311.3007-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8735ftf73p.wl-maz@kernel.org> <CA+V-a8ukQsotuWLm6_qR79qO9n_Ffo2e79AitC_=53ocsjZtzA@mail.gmail.com>
 <87h7492c58.wl-maz@kernel.org>
In-Reply-To: <87h7492c58.wl-maz@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 25 Jun 2022 14:03:33 +0100
Message-ID: <CA+V-a8tFn7aS-1jD6o9TX9kNDQ=4S3xWCXwkww3Es2+Red6vmA@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="0000000000000623a205e2455256"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000623a205e2455256
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Sat, Jun 25, 2022 at 12:52 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 25 Jun 2022 10:54:44 +0100,
> "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> >
> > Hi Marc,
> >
> > Thank you for the review.
> >
> > On Sat, Jun 25, 2022 at 10:03 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Fri, 24 Jun 2022 19:03:11 +0100,
> > > Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > >
> > > > The Renesas RZ/Five SoC has a RISC-V AX45MP AndesCore with NCEPLIC100. The
> > > > NCEPLIC100 supports both edge-triggered and level-triggered interrupts. In
> > > > case of edge-triggered interrupts NCEPLIC100 ignores the next interrupt
> > > > edge until the previous completion message has been received and
> > > > NCEPLIC100 doesn't support pending interrupt counter, hence losing the
> > > > interrupts if not acknowledged in time.
> > > >
> > > > So the workaround for edge-triggered interrupts to be handled correctly
> > > > and without losing is that it needs to be acknowledged first and then
> > > > handler must be run so that we don't miss on the next edge-triggered
> > > > interrupt.
> > > >
> > > > This patch adds a new compatible string for Renesas RZ/Five SoC and
> > > > changes the chained interrupt haindler for RZ/Five SoC.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > > RFC-->v1:
> > > > * Fixed review comments pointed by Geert
> > > > * Dropped handle_fasteoi_ack_irq support as for the PLIC we need to
> > > > claim the interrupt by reading the register and then acknowledge it.
> > >
> > > Why? This is exactly what the fasteoi_ack flow gives you, and your
> > > initial patch was much better that this one in that regard.
> > >
> > > > * Add a new chained handler for RZ/Five SoC.
> > > > ---
> > > >  drivers/irqchip/irq-sifive-plic.c | 95 +++++++++++++++++++++++++++++--
> > > >  1 file changed, 91 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > > > index 173446cc9204..f53dff49e122 100644
> > > > --- a/drivers/irqchip/irq-sifive-plic.c
> > > > +++ b/drivers/irqchip/irq-sifive-plic.c
> > > > @@ -60,10 +60,13 @@
> > > >  #define      PLIC_DISABLE_THRESHOLD          0x7
> > > >  #define      PLIC_ENABLE_THRESHOLD           0
> > > >
> > > > +#define PLIC_INTERRUPT_CELL_SIZE2    2
> > > > +
> > > >  struct plic_priv {
> > > >       struct cpumask lmask;
> > > >       struct irq_domain *irqdomain;
> > > >       void __iomem *regs;
> > > > +     u32 intsize;
> > > >  };
> > > >
> > > >  struct plic_handler {
> > > > @@ -163,7 +166,7 @@ static int plic_set_affinity(struct irq_data *d,
> > > >  }
> > > >  #endif
> > > >
> > > > -static void plic_irq_eoi(struct irq_data *d)
> > > > +static void plic_irq_ack(struct irq_data *d)
> > > >  {
> > > >       struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> > > >
> > > > @@ -176,6 +179,23 @@ static void plic_irq_eoi(struct irq_data *d)
> > > >       }
> > > >  }
> > > >
> > > > +static void plic_irq_eoi(struct irq_data *d)
> > > > +{
> > > > +     struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> > > > +     unsigned int irq = irq_find_mapping(handler->priv->irqdomain, d->hwirq);
> > > > +
> > > > +     /*
> > > > +      * For Renesas RZ/Five (R9A07G043) SoC if the interrupt type is
> > > > +      * IRQ_TYPE_EDGE_RISING we have already acknowledged it in the
> > > > +      * handler.
> > > > +      */
> > > > +     if (handler->priv->intsize == PLIC_INTERRUPT_CELL_SIZE2 &&
> > >
> > > This costs you an extra two reads on the fast path, which is an
> > > unnecessary overhead for existing systems that do not suffer from this
> > > problem. Consider turning it into a static key.
> > >
> > Sorry, by static key what did you mean?
>
> See Documentation/staging/static-keys.rst
>
Thanks for the pointer.

> >
> > > Also, blindly renaming  plic_irq_eoi() to ack() is extremely
> > > confusing. I really think you should have your own callbacks instead
> > > of making a mess of the existing one.
> > >
> > Ok will do.
> >
> > > > +         (irq_get_trigger_type(irq) & IRQ_TYPE_EDGE_RISING))
> > > > +             return;
> > > > +
> > > > +     plic_irq_ack(d);
> > > > +}
> > > > +
> > > >  static const struct irq_chip plic_chip = {
> > > >       .name           = "SiFive PLIC",
> > > >       .irq_mask       = plic_irq_mask,
> > > > @@ -198,6 +218,19 @@ static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
> > > >       return 0;
> > > >  }
> > > >
> > > > +static int plic_irq_domain_translate(struct irq_domain *d,
> > > > +                                  struct irq_fwspec *fwspec,
> > > > +                                  unsigned long *hwirq,
> > > > +                                  unsigned int *type)
> > > > +{
> > > > +     struct plic_priv *priv = d->host_data;
> > > > +
> > > > +     if (priv->intsize == PLIC_INTERRUPT_CELL_SIZE2)
> > > > +             return irq_domain_translate_twocell(d, fwspec, hwirq, type);
> > > > +
> > > > +     return irq_domain_translate_onecell(d, fwspec, hwirq, type);
> > > > +}
> > > > +
> > > >  static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> > > >                                unsigned int nr_irqs, void *arg)
> > > >  {
> > > > @@ -206,7 +239,7 @@ static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> > > >       unsigned int type;
> > > >       struct irq_fwspec *fwspec = arg;
> > > >
> > > > -     ret = irq_domain_translate_onecell(domain, fwspec, &hwirq, &type);
> > > > +     ret = plic_irq_domain_translate(domain, fwspec, &hwirq, &type);
> > > >       if (ret)
> > > >               return ret;
> > > >
> > > > @@ -220,11 +253,55 @@ static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> > > >  }
> > > >
> > > >  static const struct irq_domain_ops plic_irqdomain_ops = {
> > > > -     .translate      = irq_domain_translate_onecell,
> > > > +     .translate      = plic_irq_domain_translate,
> > > >       .alloc          = plic_irq_domain_alloc,
> > > >       .free           = irq_domain_free_irqs_top,
> > > >  };
> > > >
> > > > +/*
> > > > + * On Renesas RZ/Five (R9A07G043) SoC IRQ_TYPE_LEVEL_HIGH and
> > > > + * IRQ_TYPE_EDGE_RISING interrupts are the supported interrupt types.
> > > > + * If the global interrupt source was edge-triggered NCEPLIC100 (PLIC
> > > > + * core on Renesas RZ/Five SoC) ignores next edge interrupts until the
> > > > + * previous completion message is received. NCEPLIC100 on Renesas RZ/Five
> > > > + * SoC doesn't stack the pending interrupts so in case there is a delay
> > > > + * in handling the IRQ_TYPE_EDGE_RISING interrupt we lose the subsequent
> > > > + * interrupts. The workaround for IRQ_TYPE_EDGE_RISING interrupt is to
> > > > + * first we have to claim the interrupt by reading the claim register,
> > > > + * then quickly issue an complete interrupt by writing the source ID
> > > > + * register back to the claim  register and then later run the handler.
> > > > + */
> > > > +static void renesas_rzfive_plic_handle_irq(struct irq_desc *desc)
> > > > +{
> > > > +     struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> > > > +     struct irq_chip *chip = irq_desc_get_chip(desc);
> > > > +     void __iomem *claim = handler->hart_base + CONTEXT_CLAIM;
> > > > +     irq_hw_number_t hwirq;
> > > > +     unsigned int irq;
> > > > +     int err;
> > > > +
> > > > +     WARN_ON_ONCE(!handler->present);
> > > > +
> > > > +     chained_irq_enter(chip, desc);
> > > > +
> > > > +     while ((hwirq = readl(claim))) {
> > > > +             irq = irq_find_mapping(handler->priv->irqdomain, hwirq);
> > > > +             if (!irq) {
> > > > +                     pr_warn_ratelimited("can't find mapping for hwirq %lu\n", hwirq);
> > > > +                     break;
> > > > +             }
> > > > +
> > > > +             if (irq_get_trigger_type(irq) & IRQ_TYPE_EDGE_RISING)
> > > > +                     plic_irq_ack(irq_get_irq_data(irq));
> > > > +
> > > > +             err = generic_handle_irq(irq);
> > >
> > > No. We're not going back to this sort of constructs. Using the
> > > fasteoi_ack flow should work if properly configured. Also, looking up
> > > the interrupt *four* times in various tables/trees is not exactly the
> > > sort of things I want to see for a driver written in this century.
> > >
> > > Please explain why fasteoi_ack doesn't work. It really should work out
> > > of the box (I asked you to look into debugfs last time, but didn't ear
> > > anything from you on the subject). And if something is broken, let's
> > > fix it. But none of the above, please.
> > >
> > Handling an interrupt is a two-step process [0] first you claim the
> > interrupt by reading the claim register, then you complete the
> > interrupt by writing that source ID back to the same claim register.
>
> I'm familiar with the architecture.
>
> >
> > Now if we go with fasteoi_ack flow this wont fit as we are first
> > writing into the claim register (Interrupt completion) and then in the
> > chained handler we are reading the claim register (claim the
> > interrupt) and then run the handler (which my RFC patch did).
> >
> > With this patch I make sure we follow [0] for LEVEL interrupt and and
> > for EDGE we first claim then issue interrupt completion if EDGE
> > interrupt and then later run the handler (due to the core issue).
> >
> > Let me know if my understanding is wrong here.
>
> You are just reinventing the wheel we are already have, except that
> yours is a bit square ;-). What really should happen is that the
> set_type method should set the correct flow depending on the trigger
> of the interrupt, and *never* have to check the configuration on the
> handling path.
>
A Bit lost here..

We have the below chained handler:

static void plic_handle_irq(struct irq_desc *desc)
{
    struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
    struct irq_chip *chip = irq_desc_get_chip(desc);
    void __iomem *claim = handler->hart_base + CONTEXT_CLAIM;
    irq_hw_number_t hwirq;

    WARN_ON_ONCE(!handler->present);

    chained_irq_enter(chip, desc);

    while ((hwirq = readl(claim))) {
        int err = generic_handle_domain_irq(handler->priv->irqdomain,
                            hwirq);
        if (unlikely(err))
            pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
                    hwirq);
    }

    chained_irq_exit(chip, desc);
}

static void plic_irq_eoi(struct irq_data *d)
{
    struct plic_handler *handler = this_cpu_ptr(&plic_handlers);

    if (irqd_irq_masked(d)) {
        plic_irq_unmask(d);
        writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
        plic_irq_mask(d);
    } else {
        writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
    }
}

Where it's claiming -> handling interrupt -> interrupt completion in
eoi which is according to architecture.


Now with fasteoi_ack flow If I introduce the below ack callback to
issue interrupt completion.

static void plic_irq_ack(struct irq_data *d)
{
    struct plic_handler *handler = this_cpu_ptr(&plic_handlers);

    if (irqd_irq_masked(d)) {
        plic_irq_unmask(d);
        writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
        plic_irq_mask(d);
    } else {
        writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
    }
}

Here we are issuing an interrupt completion first, and later in the
handler  plic_handle_irq() we are claiming the interrupt by reading
the claim register. With this we are not following [0].

Do you think this flow is OK (interrupt completion -> Interrupt claim
-> handle IRQ)?

[0] https://github.com/riscv/riscv-plic-spec/blob/master/riscv-plic.adoc#interrupt-flow

Cheers,
Prabhakar

--0000000000000623a205e2455256
Content-Type: image/png; name="interrupt.png"
Content-Disposition: attachment; filename="interrupt.png"
Content-Transfer-Encoding: base64
Content-ID: <f_l4tw77do0>
X-Attachment-Id: f_l4tw77do0

iVBORw0KGgoAAAANSUhEUgAABIAAAAKICAIAAACHSRZaAAAAAXNSR0IArs4c6QAAAARnQU1BAACx
jwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAFCMSURBVHhe7d2/j9zGni/s+39pbmAlVmJFFhY4
Ai6mEys5DtZKVskamIGVWIm1gRUcRepgFRwosoBdC1hYDexVJOAFZhNF04kVCbiAIkXnrWKx+at/
zEzPkEPWPA8KdpMskt3fogR+RDb7f/0DAACAQQhgAAAAAxHAuH6n/+//0zRN29jKvyYAIBcCGNev
c76laZpWtfKvCQDIhQDG9eucb2maplWt/GsCAHIhgHH9OudbmqZpVSv/mgCAXAhgXL/O+ZamaVrV
yr8mACAXAhjXr3O+dTPb3//11sG/vujM3Nr+5+f7B//89+6cf/q3/2nM0bS1drHDbByt/GsCAHIh
gHH9Oudbw7f/+7d/Ovg/P//fcvI//+3/3PqX/4inqvf/9p/Nbvu3//jng05e6rQzO6y1ztub4om1
dkYLR0V9WG5ocdAPui0cusXScBivBfKLH2bNFv+YXMcxVv41AQC5EMC4fp3zrW1tLWO8+JcNZ5Nh
5oWDUzuAFeepYUf/8/P91ulv3HLnZLfdqjdzZs/UWv1X582bz6rLtxdPoNcWbWrV1s48iS/beS6g
/c+Lvw98hW37HuOQ1Z+3/0t/F6rPFV2NDJ/xAkdy2ul/hP+G46p1RK3auQ+zLW1HAGsPR7tdOrOV
f00AQC4EMK5f53xrWwunjO3z0XBCufGf8+MlrHDmt3YCurV1A1jccjyBDns8/0Yabdsba7aqT/Fu
U97rIUjUJ/Fx++0z46I1lu7cez9vb1fbuseiYo3xSmf/e43UudtQ9dmVZGJrHlexDqs/EXW4Kraw
eifxXe1xmJV/gs5sO2veHaa9W/nXBADkQgDj+nXOt7a05ulmNWf7qWQ80Tzv+d9aALvqtuPWr3S1
bUO83NzWT9CLk+AyMaYqNU6LO5Pb21AB4wJtyx7jpZu1wep9BIevz7kuXRYhpzgMmgdPWY34llaj
f8HDbGOLmz3n5axi13vvqNPKvyYAIBcCGNevc761pa1nibPTRTxZP8cpYyPVnHnl6pytPjPe3Drn
1quz7fV8VbV0Ohs6NM5rqwpsC2DV/LNalR/Si3gnW7nfuLXifLr5NtofcFW02O2f/638CP/89w2T
jTdTTaYXf1vdXZkqE2emjXfO4+tLPdtb471Vo5/20vhccbONvZTb3Phmqvnlm1/77J13u63z9jez
9onCWo1atea3D+mY7Tsliq04kNa2cO7DrNGaH/b8f5qu6s9RbOVfEwCQCwGM69c539rSNmSJff45
P577ds8O4yljeaodz+83nYbuOmet2tZgEM+St5+SptP36ly/0RpvrJ7TeG/x5LjY6Y4Adr5T4Soz
tN9MfTJddYjzWzGgfpNp3VbMWEsd1QhWk6lb+T4bW+70T23jzFZrvrfO1jqfa9vH3P1mdnz21Rvb
3Hn3m2kNU7HZfyreSWr//PciaIUWR/9//rNYcbXB1aJO+5e/xb3UR0t7p81Wf4q11vwnjHP8c0bx
llpvY/dgnauVf00AQC4EMK5f53xrc1v943135hlnhJ3WOnuu2voJaDzX3BTDtrf2lZl0srurVSfc
RXb62+b7zdbfWHGy3trUrgAW3saWE+tuqzJD8c7bH6SavzqZ7ubJ1WffsO6mTXUmt3Xr9K+XtrJK
t3XeWzW5YS/bdrrzzez67Kt3u63zrjezWrfs1khKabK109ja//pQHQBF/3rQqwP+YofZqjU2Wx57
3bdRt+JDdbdTzLzIn6MNrfxrAgByIYBx/TrnWxvb5otd8fRu+xnhWtt2BrntBDTGsM0npmtt9zvp
nIg3WthFPBFvnTTXbf2NhTmNOlRxqzpR3hHA4qKtp8Lx/RdbqF5sn1+UsRUCQ4tb3rbu7snO/I2R
pmobZzZbp5Lb9rJtsrv97ps512evXu/xZuKhUi2Kew9b+PvZj0NsJKVNx9JFD7NVax4zcRf3t3zr
cueflMZ726uVf00AQC4EMK5f53xrQ+ucsNatnTd2tniOuCUFbT8BPW+LG68urMV32zpB39Ian+jc
Z8ZhTuNc/CIBbMsuylZVuFPqTfO3lmvbursnO/OL1NHMPKv57aWtmaGtKtD5mNv2sm2yu9PumznX
Z69eX/jNhN2tDtE4s/yk7UGvW3FIn9FaK144gIUWK1BsKrzDVZHbfcLb2JkPL/CHdGMr/5oAgFwI
YFy/zvnWemvFm07bnSvKFk8Bd9w9tfME9BwtvIdNJ6arVpzE/+vO93nuM+M4p3F6HVpxaludGa8F
sNWn3nYSX7Yzs0Fz/rbPu23d3ZPxxab33Om/ahsHqyhLsVbnvcXJTVvbNhlf7Hwz5/ns2zqf883E
1hrHM8YutGrL6fW2I23Loo0l3dB2bLloxSikw3L1ZmITwACgRQDj+nXOt7qteXK5ocXTux2np+VV
gp1fFTvvCeimlk46t55fxnPr1dvb8UHOfWYc5jQ+7PqpbWdO44pK3HvnLL/RqgywNRsUMbLcctxL
/caqLW9dN7W4hdWbL7ZQr1Wdshfzy8Fq7rHZ2nvvDkFzC43Xu99bNbntzdT923uvq9p4t53OF30z
sTUG7uwWt1wfFa1jqb2dcx9mm1pz+Da15sZjWZoH3vk/y4ZW/jUBALkQwLh+nfOtVitOiDedhTfa
pj7ppDy2s88sz3kC2mnF+XR9sr7W4nlnWLp+Yr3pLZ37zDjMuUgAC5OdE/30nhutEwk6YaAx2Y6y
1ccPbdV/+7qNOeVa//IfoRTF0tStevJ7uf3YdoTnclHZ2ntpvrdq3d3vrZrc9mZa/Td99ua73db5
nG8mtmKtTR+829Jh1uzZPJbilq8igMXtnPV+2hsP1bj/txfFZ+98tAu38q8JAMiFAMb165xvNVo8
DT0jfRUtnkGms8N0phja7hPKdjt/AGue92+9GlC+h+3/6l92aJyYds+M67P2zl6qABbfc2svRbRb
22/Vf7wtVuOy5+hX1sb0Ztohs9HKIJQOkrXDrPoj0OpctHMfZo2W+pyrJqtjsm5XcuyVf00AQC4E
MK5f53xLu1lNANN2tvKvCQDIhQDG9eucb2k3qwlg2s5W/jUBALkQwLh+nfMtTdO0qpV/TQBALgQw
rl/nfEvTNK1q5V8TAJALAYzr1znf0jRNq1r51wQA5EIA4/p1zrc0TdOqVv41AQC5EMC4fp3zLU3T
tKqVf00AQC4EMK5f53xL0zStauVfEwCQCwGM69c539I0Tata+dcEAORCAAMAABiIAAYAADAQAQwA
AGAgAhgAAMBABDAAAICBCGAAAAADEcAAAAAGIoABAAAMRAADAAAYiAAGAAAwEAEMAABgIAIYAADA
QAQwAACAgQhgAAAAAxHAAAAABiKAAQAADEQAAwAAGIgABgAAMBABDAAAYCACGAAAwECuJoAtl8vy
1VCG3yMAAMAlnRXAlvPZwdGinNgo9Lg1mw8Zh4bfI9lbHB/cOmi34/K433K8df9otLbg+AQAYCMB
DIIYn1aJq7A4Ojg4LI6ycwSw+Lq5ehHGWpsDAIDo/AEsnFMezhfxRLP4N/763LT8V//ydLMxpz5p
DTMP5/NwRptW7Ey2z33jie/GPaaZ63uEy1sLYMWRVhzC1Yu2MLtxTHY71PkNAABqFwpgVQoKE1W+
ap59ts5El/PDZp92HmtO7ghg9R7j1nac78KlbA5gxZwtx1uYnQ7I+ELWAgDgXC4WwDbFpMbpaT0z
iYs2ncJ2JncFsMY5cTXZWR0uby2A1ZewthxvYXY6ULuHPQAAbHWVAay4SLW6P3DVikWxT+PstjO5
I4A1LyxUO6r3CFckHoTtQ7c69rYcb2G2AAYAwAVddQDbHIxiHwGMEWsfhC1bjrcwOx2o8cX6LYh+
KAEAgA16vQWxEvvsFcA2dmvsEa7GJQLYxg5x6bYNAgBwc11pACte1xfBYp/6WzSNk9ENk+2HKNZ7
rBLdlsd+wJW4TABLr5t9ikN3y+YYD5cpAYDhXT6AhS7FV79aCWrDt2gap6OdySBlrWKV+Nz5xh6P
w46KRY3T2/Ye4fLOCGDlQVi10LX+o5FUx3Bs/oHgQjZ+fTS0Pv+Ix2E1TADA8M4KYNdpxzkxkKMY
a9e/UNcHAQwAuB4C2IS5gYrcbAxgceb6ZbEwt/l77mFOdREyza+uT8asVa5eRq7GHH/FAADDEsBG
IX7DLZ0OxnaeKwDxDNK/35ObmLU6x3/r74HiT0pKVkWIqv8MxG51vIp/jupuVa/Gk1r9CQIArseY
A9gNUfyzfTNoxu/XnZk8nT6So5iddv4DxObH/xTzG38eii+VFd0a31YtxLWKP1z+BAEA10MAu2bx
X/TXwlbj3+mLE8X64lh97ljOKddtzClXrE40yy2k1/WWN2y2+2Zi58Yk9C4elhsDWHV7YWh1AKsO
z+6xuspdRRKrVixb8Scgri6AAQDDE8CuVzit3H3D4a77r1anj61TySpi1aeki6PZ7DB1CFsoXmzZ
bOtyQesEF4YQDrpNtyCuUlPzEG0dn7sCWPVno6X1pwYAYDAXDmDFyfqqOT2/pHi6WQWec2iffa6d
kiarE9Mwv+gRzkHj0/zjrNY5a63eQiOYXfS9TV55op+aU/PrEY+6dgBbHcal9h+B+mBud4u5K3Wr
+3fE1Y0yADC8iwWw9i1q8QxGBruUTsiJk1UGaJ6GNrNBffaZTh+Lc81qadmKRWGt2HlxXPy6WpxV
zllZ32yYVY5p95JC3orKNz5uURnH9vDiQKwFsOqgLf+ApA7xj0BjiOo/EasDu/6TUmezuLV69Wo2
AMBgLhTAwmnN9nOjdKKTzubr85p4JlSfJNX9Q+f2I6TDjO66wcZt5mStpEmsRpqfTiVXZ4qtAjYC
2ObiFEVehv+GVcJ2jhbh5WpDWzabdh1ex+3fmAASP2y3hPWZehA7rB2HYWbnMegbu3ERoYRrfyIa
V93TkZyOzFjt9iFaHtVxOMK4tEaq2kK98fJfLm7MUQ4AjMSFAlhxHrP5fKW1KJ4wrU7ttwew5klq
66RqNbv5OkxsixnT1r6ouBI+ejpTDBVrfupNAawVn9pC0Y7nKXSF/vGstF5l82aDuOW41pZtZqiq
9maxIJuO7WJ+XcY4WU3lerhORucIBwAYjYt+B6z6N+b2v/HHU9jm+XoVqHYFsHoDGyNEd2ZcZT2q
TF9R0m4xV/9U3yxCc36rgPF1vYW4yipOxNdlt8Xx4awq4NbNphk37MpA90hri/VpLt34jwXrG4lL
b04Jr1/zsO8MDQDAmFz4IRwrqySWzjHD2U/rfKc6AdoVwKr5Gy8XlDGg3XI9qep82OaJ+5b7r1ar
lF1jPVfd6ijVrH/Rv04I2zYbhY2130Pmdgewrcf22jFc1rNuuR6u49QcApUHAEZr7wBWiGfqxel+
TwHMadS1iMO6PZDkpzqMW5bLNOf8AczhCgDAWS4SwDZcKFjlq+4pe5W7zhXANm15y0z6F7LEDYsS
VaZqiIf07mP7HMcwAAC0XfwhHI0T1eKenzpQbX1QQTm/eN3oX5+8NnJa3Gazf7W7eIK7fpmCKxVK
ftD+QtoNUXzwxueOB2TrOFwdrJ1ju3EMO1wBADjbhW9BbHx3qHOmXpyAbphfnMvGVvwa1eYAVswo
uzUvIzS26XSWflUHamytQ3jzsb12DDtcAQA4y+W+AwYAAMC5CWAAAAADEcAAAAAGIoABAAAMRAAD
AAAYiAAGAAAwEAEMAABgIAIYAADAQAQwAACAgQhgAAAAAxHAAAAABiKAAQAADGTQAHZwcCu0coJ+
KHKvlHecjAsAMBUCWG4UuVfKO07GBQCYCgEsN4rcK+UdJ+MCAEyFAJYbRe6V8o6TcQEApkIAy40i
90p5x8m4AABTIYDlRpF7pbzjZFwAgKkYNIABAADcZAIYAADAQNyCmBtF7pXyjpNxAQCmQgDLjSL3
SnnHybgAAFMhgOVGkXulvONkXACAqRDAcqPIvVLecTIuAMBUCGC5UeReKe84GRcAYCoEsNwocq+U
d5yMCwAwFYMGMAAAgJtMAAMAABiIWxBzo8i9Ut5xMi4AwFQIYLlR5F4p7zgZFwBgKgSw3Chyr5R3
nIwLADAVAlhuFLlXyjtOxgUAmAoBLDeK3CvlHSfjAgBMhQCWG0XulfKOk3EBAKZi0AAGAABwkwlg
AAAAA3ELYm4UuVfKO07GBQCYCgEsN4rcK+UdJ+MCAEyFAJYbRe6V8o6TcQEApkIAy40i90p5x8m4
AABTIYDlRpF7pbzjZFwAgKkQwHKjyL1S3nEyLgDAVAwawAAAAG4yAQwAAGAgbkHMjSL3SnnHybgA
AFMhgOVGkXulvONkXACAqRDAcqPIvVLecTIuAMBUCGC5UeReKe84GRcAYCoEsNwocq+Ud5yMCwAw
FQJYbhS5V8o7TsYFAJiKQQMYAADATSaAAQAADMQtiLlR5F4p7zgZFwBgKgYNYN9//9fQygn6oci9
Ut5xMi430H//93//13/9VzkBANPhClhuFLlXyjtOxuUGkr4AmCgBLDeK3CvlHSfjAgBMhQCWG0Xu
lfKOk3EBAKZCAMuNIvdKecfJuAAAUyGA5UaRe6W842RcAICpEMByo8i9Ut5xMi4AwFQIYLlR5F4p
7zgZFwBgKgSw3Chyr5R3nIwLADAVuQSw5Xx2cDhfllObLefHx4vdXa7Y8Ht0Jtoz5R0n4wIATEUu
AWxxdHBwtCgnNlsc35qdEdGu2PB7DJyJ9kp5x8m4AABTkUkAW84PD8qsszgOSWy5OJ7Ffa1mLudp
8mCViJbzssPB4XGdkcJa88XiaFZ260yGjTQustWRr+g2j93i9stLXmt7HEraaTnBVVPecTIuAMBU
5BHAirRzXKSheC9iKwXVEay6RBZfH666hMB2K61arjtf3TS4PtnIUjHypdViElt1K7a2YY8Dciba
K+UdJ+MCAExFHgGsEaJCHKpjUshAqzhUz2/MLLSiVHPB+mS5j6i6vbBx8S3aurWhOBPtlfKOk3EB
AKYiiwAWrzWVNweG/NNIPXUwq3NR7BzfRqsVi9rr7p6stxySWHqRVDuq9zis9InKCa6a8o6TcQEA
piKLALaovo4V0lXja1qNYFY/D6Pu3NFed/dkveVOt7ijlLuu5QkcgTPRXinvOBkXAGAqcghgVeaJ
L5vhqs5ajXsUY3baGMDa6+6cjFe3VnnuuPn4+zqYNfY4LGeivVLecTIuAMBUZBDAQuhZXWsKLxtX
neqbAOtclCZiYEsrLI5DlCqSVXvdDZNlAFuWDzystxz2Xj6BI215Nb91ZWwwzkR7pbzjZFwAgKnI
IIA1rjVteU5GkYfirsuF1UPqQ3aqfii5vW53Mm7tsFglPj6x2nKR8eb1ojpytfc4oPS5ygmumvKO
k3EBAKYii++AXZ/r+qLXDs5Ee6W842RcAICpEMAuY9l5AscYOBPtlfKOk3EBAKZCALuMzoM6RsGZ
aK+Ud5yMCwAwFQJYbhS5V8o7TsYFAJgKASw3itwr5R0n4wIATIUAlhtF7pXyjpNxAQCmIoMAtvph
rqLNjtNvchUL5odX+4jCxXH5WPnqxfnER9IP9rDEfopMSXnHybgAAFMx+QAWf4mr/CHkOBWiUZjs
J+tUzzy86MMPG79U1j9nor1S3nEyLgDAVEw9gK1dXIo/snxUzGg8onA5T7+8PDueL8Ma5fyiQ/Wj
zI2tLBfz2fovNdcb3LDl9q8wN+bPjhbzo7D0IoHtUtLbLie4aso7TsYFAJiKyV8Bi5e8Yo4qJ2sh
aKVMFRPXYbpGFm9KnMUrZqv5Vb5qBLlFIy+FeBb6VPPLGxBXL4otrzYQe5aXuRrzl3FrxTsslgzA
mWivlHecjAsAMBVZfAfs+DBueXZUf/0rhqD0BbBGsopiTKpzVL2g061Sz6++UbZly3F+seXO/DhZ
7nEQzkR7pbzjZFwAgKnIIIAVljGGxUdxrKJP+ZyMEH9at/9tCFSFxvWreAfi0fHx0Wx2mG5ELPNa
5wkccctxaauFBdv3OIz0TsoJrpryjpNxAQCmIpcAltR3DIbYU6SgeAdg8/a/KmitOiR1aioukc3m
i8UyaMyv+m/b8kp3fuhfRbshOBPtlfKOk3EBAKZi0gFsQ7ZZHKcAFnJUkYJigmrEoZiOqqDVmV9M
duJTNRm2s7pw1vhqWaNnZeseB+JMtFfKO07GBQCYimlfAYtP4KifQZ+eeLG6PFUms+qaWIpGq3sU
qxxVWH19K/U5nKeXi0b/aoP1lkPXeM9h2nT8Htos5a7mHovraRtzWm+cifZKecfJuAAAUzH1WxBX
X/0q2ixEoBR8mt/vajwRfh5iUjdHRavrZtGy+lnn9AT5YkG1wfaWV4+wD7uun1YfO6UthIw3L36m
rF7Uv/R+ygmumvKOk3EBAKYir++AnSFesxo2DV0DZ6K9Ut5xMi4AwFRkHsDiPYqrH0gublAc9G7A
a+FMtFfKO07GBQCYiuyvgC3ms+JXwkKbHeV+9Su6jiLfIMo7TsYFAJiKG3UL4o2gyL1S3nEyLgDA
VAhguVHkXinvOBkXAGAqBLDc9FLk9HT+3TdwLufHzUdBDmD4PTqGx8q4AABTIYDlppcin+P5Jc1H
+Q9j+D0GjuFxMi4AwFQIYLnpo8jxh6rLrLM4Dkms+gG0cmbxm9TFfqsZq19IO1w9hDIIa80Xi/gz
a0W3zmTYSOMiWx35im6rH2db/d7a2h6HknZaTjAaxgUAmIprCGDff//XJ09+fv78+atXr94XysVc
hR7ORIu0k363Ot6L2EpBdQSrLpHF14erLiGw3Sp/8jqtO1/dNLg+2chSMfJVP5lddSu2tmGPA+qh
vFwB4wIATMU1BLCQuN69excCWPDw4Q8hj927922Yf//+X8LrH3/8MS1K2ezz58/lypxPD2eijRAV
4lAdk0IGWsWhen5jZqEVpZoL1ifLfUTV7YWNi2/R1q0NpYfycgWMCwAwFSO6BTFkrRS6Xrx4EQJY
SGIhj82KX/G6e/eb8DqktZTN3r79I3T7+PHPck0arv5MNF5rKm8ODPmnkXrqYFbnotg5voFWKxa1
1909WW85JLH0Iql2VO9xWOkTlROMhnEBAKZiMt8BS9ns5cuXIYA9efJzyGMPHnwXtnb79lfhdWhP
n/4SFr1+/VvodnJyUq5281z9meii+jpWSFeNr2k1gln9PIy6c0d73d2T9ZY73eKOUu66lidwBFdf
Xq6CcQEApiKHh3B8+PAhhK4QvUIAe/bs15THQjAL+wohLbx+/PinsCiEtyLEvf/y5Uu5Zo6uvMhV
5okvm+GqzlqNexRjdtoYwNrr7pyMV7dWee64+fj7Opg19jisno5hLsm4AABTkUMA2+Hjxz9D4nr7
9o8QwIKUze7e/Sa8jfSVs0ePHqVF7969Cz0/ffpUrjlZV13kEHpW15rCy8ZVp/omwDoXpYkY2NIK
i+MQpYpk1V53w2QZwJblAw/rLYe9l0/gSFtezW9dGRvM8Mcw52FcAICpyDyA7RCyVnE97H0KYCGJ
hTwWUll4h3fufJ2iWlr05s3vodvp6Wm55rhddZEb15q2PCejyENxp+XC6iH1ITtVP5TcXrc7GbcW
v+wXH1sfH3JfbrnIePN6UR252nscUPpc5QSjYVwAgKm4uQFshy9fvqRslr5y9vjxTyGMpceBhJay
WfrK2QifpD+VIp/HdX3Ra4ecypsT4wIATIUAdmEnJychcYXoFQJYiGEpj6WPFkJaeJ2epP/ixYuU
za7wSfrPnv0aNrt7g3kUubDsPIFjDDIqb1aMCwAwFQLYVTo9PQ2J682b30MAC1I2u3Pn6/Cp7937
NryunqSfvnJ20SfpVw9+fPz4p223RGZU5M6DOkYho/JmxbgAAFMhgA0kPQ5k4y9QV0/Sf/bs17Ao
PUn/w4cP5ZoNqX/VQh4LYa9ctpIWlRNcNeUdJ+MCAEyFAHb9dvwCdWjpSfpPnvwcFqU5nXb37jdh
xer5jWlmes2VU95xMi4AwFQIYGOXstnLly+fPv0lFXBbe/z4p5OTk/S6XJmrprzjZFwAgKkQwCaj
Clc7WvqSWGjlOlcl/uZya0fF8+LLhddjOT+unnE/oPTxywlGw7gAAFMhgE3Gmze/pwJWLX157Nmz
X1+//i3Es9QtLUqvr0r8Pa728+CX8xDJrvMJGdf1hPo+ysvlGRcAYCoEsMl4+fLlvXvfpucovnv3
btsTFPsockg7nd9Njo+IP1g9I345X/3ycvO3kv+xXJTzZ2Hu4qjxq82Nh8vHa2urILdtOyH+FR/q
YHZUzC5/hTluudFtGGm/5QSjYVwAgKkQwHLTQ5EXxwe3ujccVsGpSGLlzYDLRs/Y4XAe54e58S2V
80P/RmyK4Sot2LWdo3J2TGLVTq/n+lsOx3BR6jOi6/B3eF5ujzmMCwBwMwhgubn6Iq+frxcBqQhO
YVnrMtQqULXnN7cQAlUZraLVnYTbtpMC2K1Z59Q8zGz2HlAOx3DKtOXEZsPf4XnJPeYwLgDAzSCA
5ebqi1xEoHY7PC6ubRXJqrOoCGbNxBXVP6kcklXjPHt1pWvbdgrL+VGxdHV9rBnPBpfeWzkxTbF6
5RgU4xLidLqls5wZw3D6mNWMTbeGhrXmi0UcmqJbZzJsZOONpkW3ckCrXL22x4tLq5cTAAAjJoDl
5sqL3PoCWHHtqz5L3nYtpTM/nGCXW2ifl4eplNPOviYTdhy/CZY2M/z1mcr0j+Ei7aQ6xvq3UlBZ
1Th/NRzFGK26rAJzOT/0rzNxd7IxQt3rmWV6bxxLzT3uZfrjAgDcFAJYbq66yOHUeHWWnMRz6FWI
2nbe3J7fuOpVXHIpXgX1pZht2wn7qvddvZNGDBjc9I/hRvU2l7c5vzGz0IpSzQXrk40RqgJz4+Jb
tHVrFzf9cQEAbgoBLDdXXeT1tBNPylen1+Xr4tS5uEg1SzmqvrixDOfWrcsmqcOyvA9t93Zi/7Du
anbaTpzZvL9xUJM/hhvVawTjoB7oOhcV9U8fuW7Fova6uyfrLYckll4k1Y7qPe4rvbdyAgBgxASw
3FxxkTemnZipqotgq28QhcRVRqXC6tx9djw/btx2mO4kTF/oat1JuGU78fn1xczGd8DCpuOcy52x
7ym9w3JiiuLYlRl48+2gRUwqx6Xu3NFed/dkveVOt7ijlLtaR8JeJj8uAMCNIYDlZnxFXjRvO5y6
qR/DVebpjkudteoLVkV22jh2nTHdNRmvbq3y3HEzzNfBrLHHfU19XACAm0MAy83oihzOsy95dWNM
Jn4Mh8FYXWtqj0t9E2Cdi9LElltDm2O6PlkGsPaNpnF+2HuxtbCk2PJqfuvK2B4mPi4AwA0igOVm
bEVufx1o8iZ+DDeuNS02PyejyEPxM5YLN94a2l63Oxm3tuFG0yLjzetF9VHR3uNe0jssJwAARkwA
y40i90p593b5L3rtYFwAgKkQwHKTivz99399/Pin54V37969f//+w4cPZQ8uwTG8r2XnCRxXy7gA
AFMhgOUmFTkkruDFixchgD158nPIY6HdufN1WDSbHYbXDx/+kOLZmze/p87l+uzkGN5X50EdV8y4
AABTIYDl5swif/78OSWuV69ehQD27NmvKZ7du/dtWDH8N02G+WFp6JM6h7XK9W82x/A4GRcAYCoE
sNxcvsgpcb1+/Vtxhez5w4c/hDx2//5fwmZv3/4qxbMnT35OS1Pnjx//LFfOnWN4nIwLADAVAlhu
+i7yhw8fQuJ6+/aPFMB+/PHHkMcePPgu7Te8CJNhZloauoXOJycn5crT13d52Y9xAQCmQgDLzfUW
+fT0tLgk9j4FsMePf0pXzG7f/iq8q/v3/5Im09LXr39Lnb98+VKuP3pTOobjbyt3nu0eH/h+xtPe
l/Pj1ePm658QiD/VFT94WLLn7wps3OzVmdK4AAA3mwCWmzEX+dOnTylxvXz5MgSwp09/SXns7t1v
wnsO/02TYX5YGvqkzmGtcv0RmNAxvDi+dTA7XPuJ5DMeRbjxYfGXj0y9PoM+mNC4AAA3nACWm+kW
+cuXLylxpaeDBCmPpaeDhJYmO4/XPz09Lde/CiEEPnv2646vtE2nvPFi12y+aD38PV4TWz2KcDlf
/cJy9ZvIcZX0AYuwlJ5bGH+7Oc0sfm25fpjhMmw79Z8dVbuoZ9Y/3Lxxs4UN7yEoOlQ/AH2+3Ja2
X04AAIyYAJabjIt8cnISEtebN7+nAPbo0aOQx2azw/SR0+P1w8y0ND1e/0JfPwu5K20qtIcPfwhb
KBc0pKXlxKjF4BQSU/PiVXhd5pnilsIqH6We6fWskY7Kq2fVi+brmOXKaFdvtjEzRLGw2XK9bZvd
+h5a4a3a+Q7TGRcA4KYTwHJzY4ucng7y7t27FMDS00FCSwU5z+P1Q1pLnat29+43oXPzHsg0v5wY
syrzVC9iJkthpptqYoJK6SckqNWCOrmFmWU2qma2txB3sX5nY6PPhs2e6z2sd9tmMuMCANx4Alhu
FHmjjx//TIlr449Th/+G19XFtPUW4lyIdmE7aTJtc8xinimDS8wwRbRZvQj/b+elKvzUKahIa+nl
KjJF5cy1LawsF/Oj4+OjUMl0I2K1he5md76HRuIqr+OdaSrjAgAggOVGkfeQfpz66dNfUvW2terb
aOVqIxZyTpV5ymxTZZ54o+DqhsBC1Tm8WIWf0LsMSGVkilYz17ZQiGEppL7FYhnUu9u42a3vod5v
1NjIblMZFwAAASw3iry358+fp+ptbA8efPfkyc/pdbnCeIXg0rhzL8aYo0WVedJkWhTEyRSxmpeb
wuvUJyyuItBqZjs+lfmqk6nqyU2b3fUeNm7kDBMZFwAAASw7iry3x49/StVL7fvigfivXr1qPskj
LSonxivEmNaFo5iRZtV9gDERzebFUy7iUwtX18piClqtFZJP3XkVgVozQ14qNjA/bOS6w3naUthq
KFSKgFs3u+U91MGx2HjZ/wwTGRcAAAEsO4q8t2fPfg2J6/Xr3z58+FDOWjON8q5fOIpzmtfEVg95
PzgsU1AxNwah4kpU/UWssOJqtda3s2KsKrYwO2qsf1TPnFcrbtpsnL3pPdQJLWrcu3iGYjsOewBg
AgSw3Chyr5R3nIwLADAVAlhuFLlXyjtOxgUAmAoBLDeK3CvlHSfjAgBMhQCWG0XulfKOk3EBAKZC
AMuNIvdKecfJuAAAUyGA5UaRe6W842RcAICpEMByo8i9Ut5xMi4AwFQIYLlR5F4p7zgZFwBgKgSw
3Chyr5R3nIwLADAVAlhuFLlXyjtOxgUAmAoBLDeK3KtU3u+//+vjxz89L7x79+79+/enp6dlD66D
wx4AmAoBLDeK3KtU3pC4ghcvXoQA9uTJzyGPhXb79ldh0YMH34XXjx49SvHs7ds/Qs8PHz6U69MP
hz0AMBUCWG4UuVdnlvfz588pnr18+TIEsKdPf0nx7M6dr8OK9+//Jbx++PCHFM9ev/4tdS5XZl8O
ewBgKgSw3Chyry5Z3i9fvqTE9erVqxDAnj37NcWzu3e/CZu9d+/bNBnmh6WhT+oc1irXZwuHPQAw
FQJYbhS5V32XNyWu169/K66QPU95LASzsNM7d75Ok0+f/hIWvXjxInX+9OlTufIN5rAHAKZCAMuN
Ivfqest7cnISEtebN7+nePbw4Q8hj81mh+Et3b79VYpn1dNBUjz7+PHPcuWsOewBgKkQwHKjyL0a
c3k/fPgQEtfbt3+kAPbo0aOQxx48+C695/R0kB9//DEtzezpIGMeFwCAJgEsN4rcq+mW9/T0NCSu
d+/epQAWkli6YpY+0Wx2GF5XTwd58+b30Pnk5KRcefSmOy4AwE0jgOVGkXuVa3k/fvwzJK4gBbDH
j39K8Sw9W796OkhaWj28cZing3z+/PnMHTnsAYCpEMByo8i9upnl/fTpU0pc6afPOs/Wv3v3mzSZ
ng7y8uXL1DkEp3L9ywmbCjsKG9/xfTaHPQAwFQJYbhS5V8q7rvPTZ51n61dPB3ny5OewtHp44/mf
DvL69W+p7KE9fPjDmze/lwsa0tJyAgBgxASw3Chyr5T3ojo/fRakPJaerR9amqyeDvLu3bvQ+fT0
tFz/H/8ImS31rFqIdmFm8/n7aX45AQAwYgJYbhS5V+cq73I+OzicL8upzZbz4+PF7i5XbPg9nk+K
Z9VPn6Vn69+//5dU6tnssIpq6y3EtrBu2EiaTBsEABgzASw3ityrc5V3cXRwcLQoJzZbHN+anRHR
rtjwe7wSJycnIY+lsm9rVVor1wEAGDEBLDeK3KvzlHc5Pzwos87iOCSx5eJ4FtdazVzO0+TBKhEt
52WHg8PjOiOFteaLxdGs7NaZDBtpXGSrI1/RbR67xe2Xl7zW9jgp1U+Zrbd797599OjR8+fP02S5
AgDAiAlguVHkXp2jvEXaOS7SULwXsZWC6ghWXSKLrw9XXUJgu5VWLdedr24aXJ9sZKkY+dJqMYmt
uhVb27DHqWnegjibHT5+/FN6kkfz2fRpaTkBADBiAlhuFLlX5yhvI0SFOFTHpJCBVnGont+YWWhF
qeaC9clyH1F1e2Hj4lu0dWuT8uTJz69evdr9q9AOewBgKgSw3Chyr84ub7zWVN4cGPJPI/XUwazO
RbFz3GCrFYva6+6erLccklh6kVQ7qveYqVS6cgIAYMQEsNwocq/OLu+i+jpWSFeNr2k1gln9PIy6
c0d73d2T9ZY73eKOUu6a6BM4zs9hDwBMhQCWG0Xu1ZnlrTJPfNkMV3XWatyjGLPTxgDWXnfnZLy6
tcpzx83H39fBrLHHTDnsAYCpEMByo8i9Oqu8IfSsrjWFl42rTvVNgHUuShMxsKUVFschShXJqr3u
hskygC3LBx7WWw57L5/Akba8mt+6MpYfhz0AMBUCWG4UuVdnlbdxrWnLczKKPBQ3Ui6sHlIfslP1
Q8ntdbuTcWuHxSrx8YnVlouMN68X1ZGrvcccpQKWEwAAIyaA5UaRezXm8mb/Ra8dHPYAwFQIYLlR
5F6NuLzLzhM4bhSHPQAwFQJYbhS5VyMub+dBHTeLwx4AmAoBLDeK3CvlHSfjAgBMhQCWG0XulfKO
k3EBAKZCAMuNIvdKecfJuAAAUyGA5UaRe3UV5Y2/9xV/vCu2w+P0s12FxfEZT4pfzg9v7HMOd3PY
AwBTIYDlRpF7denyxh8Kq3/vq/lzyTf7MYaX5LAHAKZCAMuNIvfqcuUtfhC5c5ErzCufXlg/xjDm
svVfZ646pFXif28dzI7my3hJLXa+wVfHLjcuAADDEcByo8i9ulR5F0cHO54UH5ambBa7rS6FhWwV
MliaCIkrvQodZuW9i4vj8H4OU0Y78w7GjDnsAYCpEMByo8i9ukx5Y1janpC2fL8rXjRL86sO4UV1
sau5TQGsnAAAGDEBLDeK3KvLlDcEpE0Rq9SIT8vF/Oj4+Gg2O0w3Iqb5VYfGdmI8q9a6OV8he//+
/bt3754/f/706S/ff//XDx8+OOwBgKkQwHKjyL26THk3BrDVzCo+xXsOD2bzxWIZxNnl7YitDqvQ
VX9trP06Ex8//hmy1qtXr0LWevToUchat29/defO1+HFjz/+GGa+fv1b6PD582eHPQAwFQJYbhS5
V5cpb/PWwVKVr8KLtKjzPbF6cpWv6kjWWKvzeoI6F7Xu3/9LqPNsdhheP3v2a5gfOpycnJS91zjs
AYCpEMByo8i9ulx548Wr6qmG8VGH1bWs6gkcKV+ll0WHMrNVHZoJrZrZeT1i57yo9enTp3KF83HY
AwBTIYDlRpF7ddnyhlCVHhkf2uyo+hHm5hM4lvOj8meaZ0eL+VEKYBufwNFcq/EVsrG45EWtC0kl
LScAAEZMAMuNIvdKeddtvKgVWngRJsPMsCh0CN3KFXpgXACAqRDAcqPIvbrh5d14USv8N7wOc8L8
sDT0KXsPyGEPAEyFAJYbRe7VDSnvGC5qXYjDHgCYCgEsN4rcq/zKe3JyEqJU56LWvXvfXvtFrQtx
2AMAUyGA5UaRezXd8n769CnkqNevfwuZ6scffwz56s6dr8NnCS8ePvwhzHz58mXocHp6Wq4wKQ57
AGAqBLDcKHKvJlHe6qLWs2e/hnw1m8XnLqaLWk+e/Bzmv337R+jw5cuXcoXpc9gDAFMhgOVGkXs1
qvLmfVHrQhz2AMBUCGC5UeReXVd5N17Uunv3m4wval2Iwx4AmAoBLDeK3Kszy/vmze8PHnwX/ltO
X9C2i1phm+F1mPnixYvQ4cOHD+UKFBz2AMBUCGC5UeRebSvvly9fXr16de/et6lDiEnlgu12XNR6
/PinMD+kuNDh8+fP5Qpst21cAADGRgDLjSL3ar28nz59CgkqXaeq2pMnP5eLM7motVwcH87KT3d4
PF8sy/n/WBzfOl6Urzdazg9n86p7X1LZywkAgBETwHKjyL1qlvf09PTx459u3/4qzWy29MjBdFEr
xK3wOkSvyV7UWhwf3Jodr0LXcjGf3TooU9dyPjvsP16dLZW9nAAAGDEBLDeK3KtU3hCiHj16lF5v
bCF0hT4nJyflahMWIlYVt1bCvIOjYlbIZulFkctCz+Lj12mt6pBWif+9dTA7mi/jJbXY+YqujqX9
lhMAACMmgOVGkXuVyrvxqlenlStM3eLoYBWxNghLUzaL3VaXwkK2ChksTYTElV6FDrPy3sXFcajP
YcpoZ97BeE5Z1RwAyJoAlhtF7lVV3s+fP79///7ly5fpERp3736TFlXt48c/0yqTFsPS9oS05ftd
8aJZml91CC+qi13NbQpgAMBNI4DlRpF7tbu8IZKlh208fPhDHk+KDwFpU8QqNeLTcjE/Oj4+ms0O
042IaX7VobGdGM+qta7qK2QOewBgKgSw3Chyr25aeTcGsNXMKj7Few4PZvPFYhnE2eXtiK0Oq9BV
f22s/fpSHPYAwFQIYLlR5F7dtPI2bx0sVfkqvEiLOt8TqydX+aqOZI21Oq8vx2EPAEyFAJYbRe7V
zStvvHhVPdUwPuqwupZVPYEj5av0suhQZraqQzOhVTM7ry/HYQ8ATIUAlhtF7tVNLG8IVemR8aHN
jqofYW4+gWM5Pyp/pnl2tJgfpQC28QkczbUaXyG7rJs4LgDANAlguVHkXinvOBkXAGAqBLDcKHKv
lHecjAsAMBUCWG4UuVfKO07GBQCYCgEsN4rcK+UdJ+MCAEyFAJYbRe6V8o6TcQEApkIAy40i90p5
x8m4AABTIYDlRpF7lU95429zxc/SaIdX9VD44aWPUE4AAIyYAJYbRe5VNuVt/jZXspw3fi55ahz2
AMBUCGC5UeReZVPexfGtg84Fr+V8dnBY/V7y8Sx+0nhZrBHTYmwrKhB/kbn6OeXZfLH6IebZ8ep3
moPNG1kch5i3DGul7dQLNm186zvpSCuWEwAAIyaA5UaRe5VLeUMKutW94TDelFhcASuSWJmkQlKq
eqYOaXYMS0Xn4lbGEMHi7KJzGaniRsKK5et6I8X8VU4LE6v+Gze+7Z2scdgDAFMhgOVGkXuVSXmL
YNO6nlTEm+KaWCMUFWIcSrknZa3mNa60tHMV68yN1As6Aayz8e0bWZPJuAAAN4AAlhtF7lUm5S3S
TrsdHpdXseIVqu7SVexZlrcarq5KhS0dt65KlRkpbqQV8KrsFF40MlXrolZ34zvfSUdaWk4AAIyY
AJYbRe5VHuVtfQGsed9gkG4FLCc2CivEL2uVeWrWClrlltc2stpju/9aTmtt/Ox3UstjXACAm0AA
y40i9yqL8obc07q1r4g6qyAUQ9Gm2BP61OtUWwjhbVOg6mwkTqbAFvo35lcRa+PGOxvZyWEPAEyF
AJYbRe5VFuVt3fhXiJlndU2sfF3EoeJ61KxIQWWIWs1OWyhmVk/gaGwkXVVbmx/6N5Jf/Z2ujRuP
cze9k00c9gDAVAhguVHkXuVQ3ph2Ojf+pYtR1UWw1TPi20/FWC7KZ81XX9MqEtQ83TQYZzY3Wm/k
sExiQdhLmdCixXF9IW5942nuxneyLvUpJwAARkwAy40i90p5m5oJ6noZFwBgKgSw3Chyr5S3Ydl5
Asc1Mi4AwFQIYLlR5P68e/cu1PZ//+9bzwth8v3796enp+XiG6f9RI1r5bAHAKZCAMuNIvfn48c/
U3lfvHgRAtiTJz9///1fQ7t9+6sw88GD78LrR48epXj29u0fIZ59+PChXJk+OewBgKkQwHKjyL3a
Ud7Pnz+HxBW8fPkyBLCnT39J8ezOna/DKvfv/yW8fvjwhxTPXr/+LXUuV+ZyHPYAwFQIYLlR5F7t
Xd4vX76kxPXq1asQwJ49+zXFs7t3vwkbvHfv2zQZ5oeloU/qHNYq12cnhz0AMBUCWG4UuVf9lTcl
rtevfyuukD1PeSwEs7C7O3e+TpNPn/4SFr148SJ1/vTpU7nyjeewBwCmQgDLjSL36rrKe3JyEhLX
mze/p3j28OEPIY/NZvEHuG7f/irFs8ePf0pLUzz7+PHPcuUbwGEPAEyFAJYbRe7VOMv74cOHkLje
vv0jBbBHjx6FPPbgwXfp3aang/z4449paZZPBxnnuAAArBPAcqPIvZpieU9PT0PievfuXQpgIYml
K2bps8xmh+F19XSQN29+D51PTk7KlSdiiuMCANxMAlhuFLlX+ZX348c/Q+IKUgB7/PinFM/Ss/Wr
p4OkpdXDG4d5Osjnz5/PuSOHPQAwFQJYbhS5VzetvJ8+fUqJK/30WefZ+nfvfpMm09NBXr58mTqH
4FSufzlhU2FHYeNnfp/NYQ8ATIUAlhtF7pXyNnV++qzzbP3q6SBPnvwcllYPbzz/00Fev/4tFTy0
hw9/ePPm93LBmtSnnAAAGDEBLDeK3CvlPb/OT58FKY+lZ+uHliarp4O8e/cudD49PS3X/8c/QmZL
PasWol2Yuf78/bS0nAAAGDEBLDeK3CvlvUIpnlU/fZaerX///l9SkWezwyqqrbcQ28K65YaMCwAw
HQJYbhS5V8o7mJOTk5DHUsG3tZDWXr169fnz5zRZrgkAMGICWG4UuVfKO6Tqp8zW27173z569Oh5
8avTnz59SjPL1QAARkwAy40i90p5h9S8BXE2O3z8+Kf0JI/1Z9MbFwBgKgSw3Chyr/Yv73I+Ozic
L8upzZbz4+PF7i5XbPg9XsSTJz+/evXqPL8K7bAHAKZCAMuNIvdq//Iujg4OjhblxGaL41uzMyLa
FRt+jz1x2AMAUyGA5UaRe7V3eZfzw4My6yyOQxJbLo5ncVOrmct5mjxYJaLlvOxwcHhcZ6Sw1nyx
OJqV3TqTYSONi2x15Cu6zWO3uP3yktfaHqcsfZByAgBgxASw3Chyr/Ytb5F2jos0FO9FbKWgOoJV
l8ji68NVlxDYbqVVy3Xnq5sG1ycbWSpGvrRaTGKrbsXWNuxx4hz2AMBUCGC5UeRe7VveRogKcaiO
SSEDreJQPb8xs9CKUs0F65PlPqLq9sLGxbdo69amzGEPAEyFAJYbRe7VnuWN15rKmwND/mmknjqY
1bkodo57abViUXvd3ZP1lkMSSy+Sakf1HqcvVamcAAAYMQEsN4rcqz3Lu6i+jhXSVeNrWo1gVj8P
o+7c0V5392S95U63uKOUu7J5AkfgsAcApkIAy40i92q/8laZJ75shqs6azXuUYzZaWMAa6+7czJe
3VrluePm4+/rYNbY4/Q57AGAqRDAcqPIvdqrvCH0rK41hZeNq071TYB1LkoTMbClFRbHIUoVyaq9
7obJMoAtywce1lsOey+fwJG2vJrfujI2aQ57AGAqBLDcKHKv9ipv41rTludkFHkobrlcWD2kPmSn
6oeS2+t2J+PWDotV4uMTqy0XGW9eL6ojV3uPE5dqVU4AAIyYAJYbRe7V5Mqb0xe9dnDYAwBTIYDl
RpF7NbXyLjtP4MiVwx4AmAoBLDeK3KuplbfzoI5sOewBgKkQwHKjyL1S3nEyLgDAVAhguVHkXinv
OBkXAGAqBLDcKHKvlHecjAsAMBUCWG4UuVfnKG/85a74M1yxHR6nH+Dqx+L4rIfIL+fHq6fYL+eH
GT8O0WEPAEyFAJYbRe7VWeWNP/lV/3JX84ePr97ZTzi8Ic+gDxz2AMBUCGC5UeRe7Sxv8dPGnbgV
5lXPIVzOVz+v3PhB5NQh/vfWwexovowX0GKfOjktjmfzxfwoXVWr013zCYcbtly8mbRKnLO7c1B0
qH4Aemq5LX3ScgIAYMQEsNwocq92lXdxdFCFnHVFxCrTU4hA8XUxP6w1K+9UXByHjR+mPvXthXGz
IUQVc0NAKgNVMT/1iFsu10odyhVTtCtextdptW1vo5i/SndhYmKXzhz2AMBUCGC5UeRe7ShvjE9l
mlnXjTTL+WHqHF+sFjS3UAWwZoeguWIxe+uWi2hXLrhQ5/VuI/Tly5f379+/efP78+fPHz165LAH
AKZCAMuNIvdqR3lDZNoaWkKiOWh9X6tKPo21YuxJaah4XfavkljSXDH+P245vqVWKzrU4arVefPb
CC8ab75xGW0cPnz48O7du5C1njz5+fvv/3rnztd3734TXjx9+kuYGZJY+uBlbwCAERPAcqPIvdpR
3o0BrJwZbyNs3Z0Y5hfJpxl1im9hpZf16zqJJasVV/PXtlxpvJ+tnbtbS9Zy2pA+ffoUAtXLly+f
Pfs1RKz79/8SCh5e/PjjjyFrvX37R1hadm1w2AMAUyGA5UaRe7WjvPFqUieBVUkmvmgknzi5dkkq
vK5Wr1+HJLYpGlUd4pyNAWxTtOt0jpOpTzP7hamdX2a7Op3bCB88+C7UNiSuELfCnFevXoWlnz9/
Lnvv5LAHAKZCAMuNIvdqZ3lj5qmeUhgfQd+KQLeqB2nMZ6vvejWjTni96l2/LjLS5hXLzqFHnFns
tHiC4qzKWqvkVnfe8jZC50Z0bN67eIW23UYYJtNthKenp2XXi3PYAwBTIYDlRpF7dUZ5Q6pJD5EP
bXaUkk6pesL7wWEZgVLUWSWf5rewFs0ncBzPywfTN54a3+zc2HLzIfVFMCsS4JbO9dtoZb9i7404
to/dtxG+efP7xtsILyN9/HICAGDEBLDcKHKvBi7v5bNQ39JthK9f/7bjNsKQx8revXHYAwBTIYDl
RpF7NWx5l50ncFy76jbCx49/SrcRhnZVtxFehsMeAJgKASw3ityrYcvbfjbGsD5+/LN5G+G9e9+G
Dx5ePHr0qKfbCC/DYQ8ATIUAlhtF7lWW5d19G2HIYMPcRngZDnsAYCoEsNwocq8yKO+ZtxGGDmXX
6XDYAwBTIYDlRpF7Na3ybryN8MGD78Z5G+FlOOwBgKkQwHKjyL0abXl33EYY0tckbiO8DIc9ADAV
AlhuFLlXIynv7tsIw6Ip3kZ4GQ57AGAqBLDcKHKvhi/veW4j/PLlS9n7pnLYAwBTIYDlRpF71Wt5
b/hthJfhsAcApkIAy40i9+oKy7vtNsIweTNvI7wMhz0AMBUCWG4UuVf7lXf3bYSvX//mNsJLctgD
AFMhgOVGkXt1ZnmbtxE+fPhDuo0wJK7mbYQhj5W9uSIOewBgKgSw3ChyrzrlPTk5ad5GePv2V24j
vBYOewBgKgSw3ChyT9JthKm8zdsIHz78wW2E127HYf/06S9hgIIXL16EMfIUEwDgeglguVHky9tx
G2Eqr9sIx2bHYZ+icrPNZochlZ2cnJQ9AAAGJIDlRpEvav02wtCatxE2z9SVd5x2jMudO1+npest
pOvT09OyHwDAIASw3CjyDuk2whcvXnSeRnj+2wiVd5x2jEtatK2FsB3GvewKANA/ASw3ipzsuI3w
6dNf0teB9riNUHnHafe4nJ6ehuEOwriHgyF1bja3IwIAgxHAcnMzi7z7NsK3b/+4qjNsx/A4XXRc
Xr161bw1MaSycgEAQM8EsNxkX+SNtxHOZofN2wg/f/5c9r5qjuFx2mNcwkFy9+43acVwFJVzAQB6
JoDlJqci93Qb4WU4hsdpv3EJB1JaUQADAAYjgOVmukUe7DbCy3AMj9N+4yKAAQDDE8ByM4ki776N
8NWrV73eRngZjuFx2m9cBDAAYHgCWG7GVuSQo9ZvI7x795tw7lvdRjih32JyDI/TfuMigAEAwxPA
cnO9RT45OXn79o/12wh//PHH8dxGeBmO4XHab1wEMABgeAJYbs5Z5A8fPlzy8RXVbYRPn/4STmQn
dBvhZTiGx2m/cRHAAIDhCWC5ObPIIRc9evQo9Hnz5vdy1lk6txGGlBVWr24jDDOndRvhZZxZXq7F
fuMigAEAwxPAcrOjyG/f/lGdcYb24sWLckHb+m2EoXN4Ud1GGOJW2fXmSaUrJxiN/cZFAAMAhieA
5WZjkV+//i1dtmq2EKi23UYYXmd8G+FlpNKVE4zGfuMigAEAwxPActMs8pcvX0KISrFqY7uZtxFe
RqpbOcFo7DcuAhgAMDwBLDepyJ8/f37x4kXIV2lyY7tz5+tyHc4tla6cYDT2GxcBDAAYngCWm1Tk
kL7CyeX9+39Jk9vap0+fytU4n1S3coLR2G9cBDAAYHgCWG7Wi/zhw4f3798/f/68+UWv1Kb+q1zD
Wy8vY7DfuAhgAMDwBLDcnLPIKZWF/5bTnI9jeJz2GxcBDAAYngCWG0XulfKO037jIoABAMMTwHKj
yL1S3nHab1wEMABgeAJYbhS5V8o7TvuNiwAGAAxPAMuNIvdKecdpv3ERwACA4QlguVHkXinvOO03
LgIYADA8ASw3itwr5R2n/cZFAAMAhieA5UaRe6W847TfuAhgAMDwBLDcKHKvlHec9hsXAQwAGJ4A
lhtF7pXyjtN+4yKAAQDDE8Byo8i9Ut5x2m9cBDAAYHgCWG4UuVfKO077jctVBLDFcdzC0aKcDJbz
WWfOZRTbn82X1esr2zIAcD0EsNwocq+Ud5z2GxcBDAAYngCWG0XulfKO037jMkQAW86P42TRZkcp
SFV95ouj2WrRolwUhHUOi1UOjxfz7QFsuZivVo89q/XTxg+Pj9PS5pYBgOsngOVGkXulvOO037j0
H8DS0kYro1Tq027HaRubFm0KYIvjdp+DW2WvzhZWcwGAkRDAcqPIvVLecdpvXK4ugK23ZiQrLItr
WeX8MiOlcLRcHMVVyol5umyVYtNyXlwKWw9gqdtsXl7dWjaz2SqAlYkOABgXASw3itwr5R2n/cZl
kAC2XC7m8+OjWXlVqpmRDlcXp4qNpJSVwlidnRqLmgEsdeu2tMHOxgGAcRHAcqPIvVLecdpvXHq/
BTFdmJodLRbLZatno0/USFkCGADkTgDLjSL3SnnHab9x6TuApRsIZ0WaWpbP2zgrgIUlRbcUn857
C2KLAAYAoyaA5UaRe6W847TfuFQB7M6dr8tZF7YrgG26TnVWACsXtdt6AIsT7T6htbYggAHASAlg
uVHkXinvOO03Lo8f/5RWDO3Bg+8+fPhQLriAnQEs3oO4eqD8fJkuZ6XrYdsDWNB4DP1852Pojw+L
y2WxzcIOVvMFMAAYMwEsN4rcK+Udp/3G5d27d2nFqj169OjVq1enp6dlDwCAqyaA5UaRe6W847T3
uDx9+ktad73dufP199//NbTQ59OnT+UKAACXI4DlRpF7pbzjdJlxef36t7t3v0lb2NYePXpU9gYA
uBwBLDeK3CvlHafLjMvnz5+bXwbb2B48+K7sDQBwOQJYbhS5V8o7TnuPy7t37+7c+Tqtvq3du/ft
yclJuQIAwOUIYLlR5F4p7zjtNy6fPn1aT1+z2eGzZ7+GYPb+/Xu5CwC4cgJYbhS5V8o7TvuNSwha
acXQbt/+6vnz558/fy6XnS09FL7VZrN543n0V2v9efcAwCQJYLlR5F4p7zjtNy7VDzGH9vHjn+Xc
89oQwGKrf84LAGADASw3itwr5R2n/calCmD37n1bzrqAtUtSy+acHT+1XC6aL47Kn1GeHS3K0LZj
0YaNb+oWrH7HOc5s7hcAGAUBLDeK3CvlHaf9xuVaA1i7HaeOOxatb7zdNm5hdhgTmgAGAGMigOVG
kXulvOO037hcRQBba60gtCuApanl4iiudfaiDQFsQ7ewpOi22ly6FJamAIBREMByo8i9Ut5x2m9c
rjiAzY7m9Y2AZwaww1UqOuei9QC2qVsKY2UIDJpbAABGQQDLjSL3SnnHab9xubJbEMubD8tLUoUz
A9hFFzV2t6ObAAYAoyeA5UaRe6W847TfuFzld8BCJio2tco+KSOFyZh92rcC9hnAyrfhFkQAGC8B
LDeK3CvlHaf9xuVqH8JRpp3VnMVx3HKrDRDAykWr5iEcADA+AlhuFLlXyjtO+43L1QawOvyUV8EW
x2UWOjxezM+Xsi4fwIrJtN9Z6NBZBABcPwEsN4rcK+Udp/3G5XIBbJRCNIufKES+Yqr1HEUAYBQE
sNwocq+Ud5z2G5cMA1h1Fa7R5C8AGBUBLDeK3CvlHaf9xiXHABYve81n6dtooR3O0mNAAIDREMBy
o8i9Ut5x2m9c8gxgAMC4CWC5UeReKe847TcuAhgAMDwBLDeK3CvlHaf9xkUAAwCGJ4DlRpF7pbzj
tN+4CGAAwPAEsNwocq+Ud5z2GxcBDAAYngCWG0XulfKO037jIoABAMMTwHKjyL1S3nHab1wEMABg
eAJYbhS5V8o7TvuNiwAGAAxPAMuNIvdKecdpv3ERwACA4QlguVHkXinvOO03LgIYADA8ASw3itwr
5R2n/cZFAAMAhieA5UaRe6W847TfuAhgAMDwBLDcKHKvlHec9hsXAQwAGJ4AlhtF7pXyjtN+4yKA
AQDDE8Byo8i9Ut5x2m9cBDAAYHgCWG4UuVfKO077jYsABgAMTwDLjSL3SnnHab9xEcAAgOEJYLlR
5F4p7zjtNy4CGAAwPAEsN4rcK+Udp/3GRQADAIYngOVGkXulvOO037gIYADA8ASw3Chyr5R3nPYb
FwEMABieAJYbRe6V8o7TfuPy4MF3aUUBDAAYjACWG0XulfKO00XH5fPnz0+e/JzWCm02OywXAAD0
TADLjSL3SnnH6Zzj8unTpzdvfn/8+Ke7d79Jq6T28uXLsgcAQM8EsNwocq+Ud5x2jMv33/81tHv3
vk191tvDhz+UXQEA+ieA5UaRe6W847RjXG7f/iotXW937nzt2hcAMDABLDeK3CvlHacd47Lx2tfd
u988fvzTp0+fyk4AAEMRwHKjyL1S3nHaMS7pUYfpRsSHD394+fLlhw8fymUAAIMTwHKjyL1S3nEy
LgDAVAhguVHkXinvOBkXAGAqBLDcKHKvlHecjAsAMBUCWG4UuVfKO07GBQCYCgEsN4rcK+UdJ+MC
AEyFAJYbRe6V8o6TcQEApkIAy40i90p5x8m4AABTIYDlRpF7pbzjZFwAgKkQwHKjyL1S3nEyLgDA
VAhguVHkXinvOBkXAGAqBLDcKHKvlHecjAsAMBUCWG4UuVfKO07GBQCYCgEsN4rcK+UdJ+MCAEyF
AJYbRe6V8o6TcQEApkIAy40i90p5x8m4AABTIYDlRpF7pbzjZFwAgKkQwHKjyL1S3nEyLgDAVAhg
uVHkXinvOBkXAGAqBLDcKHKvlHecjAsAMBUCWG4UuVfKO07GBQCYCgEsN4rcK+UdJ+MCAEyFAJYb
Re6V8o6TcQEApkIAy40i90p5x8m4AABTIYDlRpF7pbzjZFwAgKkQwHKjyL1S3nEyLgDAVAhguVHk
XinvOBkXAGAqBLDcKHKvlHecjAsAMBUCWG4UuVfKO07GBQCYCgEsN4rcK+UdJ+MCAEyFAJYbRe6V
8o6TcQEApkIAy40i90p5x8m4AABTIYDlRpF7pbzjZFwAgKkQwHKjyL1S3nEyLgDAVAhguVHkXinv
OBkXAGAqBLDcKHKvlHecjAsAMBUCWG4UuVfKO07GBQCYCgEsN4rcK+UdJ+MCAEyFAJYbRe6V8o6T
cQEApkIAy40i90p5x8m4AABTMWgAAwAAuMkEMAAAgIG4BTE3itwr5R0n4wIATIUAlhtF7pXyjpNx
AQCmQgDLjSL3SnnHybgAAFMhgOVGkXulvONkXACAqRDAcqPIvVLecTIuAMBUCGC5UeReKe84GRcA
YCoGDWAAAAA3mQAGAAAwELcg5kaRe6W842RcAICpEMByo8i9Ut5xMi4AwFQIYLlR5F4p7zgZFwBg
KgSw3Chyr5R3nIwLADAVAlhuFLlXyjtOxgUAmAoBLDeK3CvlHSfjAgBMxaABDAAA4CYTwAAAAAbi
FsTcKHKvlHecjAsAMBUCWG4UuVfKO07GBQCYCgEsN4rcK+UdJ+MCAEyFAJYbRe6V8o6TcQEApkIA
y40i90p5x8m4AABTIYDlRpF7pbzjZFwAgKkYNIABAADcZAIYAADAQNyCmBtF7pXyjpNxAQCmQgDL
jSL3SnnHybgAAFMhgOVGkXulvONkXACAqRDAcqPIvVLecTIuAMBUCGC5UeReKe84GRcAYCoEsNwo
cq+Ud5yMCwAwFYMGMAAAgJtMAAMAABiIWxBzo8i9Ut5xMi4AwFQMGsC+//6voZUT9EORe6W842Rc
AICpcAsiAADAQAQwAACAgQhgAAAAAxHAAAAABiKAAQAADEQAAwAAGIgABgAAMBABDAAAYCACGAAA
wEAEMAAAgIEIYAAAAAMRwAAAAAYigAEAAAxEAAMAABiIAAYAADAQAQwAAGAgAhgAAMBABDAAAICB
CGAAAAADEcAAAAAGIoABAAAMRAADAAAYiAAGAAAwEAEMAABgIAIYnOHf//3ff/rpp3ICAAAuQQCD
M4T09b/+lz8pAABcAaeVAAAAAxHAAAAABiKAAQAADEQAAwAAGIgABgAAMBABDAAAYCACGAAAwEAE
MAAAgIEIYAAAAAMRwAAAAAYigAEAAAxEAAMAABiIAAYAADAQAQwAAGAgAhgAAMBABDAAAICBCGAA
AAADEcAAAAAGIoABAAAMRAADAAAYiAAGAAAwEAEMAABgIAIYAADAQAQwAACAgQhgAAAAAxHAAAAA
BiKAAQAADEQAAwAAGIgABgAAMBABDAAAYCACGAAAwEAEMAAAgIEIYAAAAAMRwAAAAAYigAEAAAxE
AAMAABiIAAYAADAQAQwAAGAgAhgAAMBABDAAAICBCGAAAAADEcAAAAAGIoABAAAMRAADAAAYiAAG
AAAwEAEMAABgIAIYAADAQAQwAACAgQhgAAAAAxHAAAAABiKAAQAADEQAAwAAGIgABgAAMBABDAAA
YCACGAAAwEAEMAAAgIEIYAAAAAMRwAAAAAYigAEAAAxEAAMAABiIAAYAADAQAQwAAGAgAhgAAMBA
BDAAAICBCGAAAAADEcAAAAAGIoABAAAMRAADAAAYiAAGAAAwEAEMAABgIAIYAADAQAQwAACAgQhg
AAAAAxHAAAAABiKAAQAADEQAAwAAGIgABgAAMBABDAAAYCACGAAAwEAEMAAAgIEIYAAAAAMRwAAA
AAYigAEAAAxEAAMAABiIAAYAADAQAQwAAGAgAhgAAMBABDAAAICBCGAAAAADEcAAAAAGIoABAAAM
RAADAAAYiAAGAAAwEAEMAABgIAIYAADAQAQwAACAgQhgAAAAAxHAAAAABiKAAQAADEQAAwAAGIgA
BgAAMBABDAAAYBD/+Mf/D4NeiSzerTvuAAAAAElFTkSuQmCC
--0000000000000623a205e2455256--

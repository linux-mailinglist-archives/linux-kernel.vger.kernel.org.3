Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5645352545A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357458AbiELSBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357468AbiELSBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:01:39 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861C7326DE;
        Thu, 12 May 2022 11:01:34 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id y76so11255359ybe.1;
        Thu, 12 May 2022 11:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P2Z7C4AYnqmN1fJ4A3LOaxRz+0uCusfSuGUkn36he00=;
        b=XNfV1ATX15rJxMuZXB3ybE75+i4OnBI7kfdeDBcuIyhcJY1h9qsUi0LX2q3cm5JL83
         D0i72oJpPe5zrbb1d+VS0GOFOtQSRT/ESIFiAicUi5dS3JG1i/Ul1x6ubjUv1Hj+2VUd
         SMFQlORik55Rnxs7YQBKMVqIJAJhuWIWJ3SB1kO5Gzb/H9ovmGonnVIhb58tHCX4uJT5
         z3ntBaV8Kc/jvd/TEftaDu8xWAVzlYZJLGCMMThIvuBHY/DzYs0EuOiLzOCz5PrMlEyo
         150qSJNmycU+48P4Ehm8CM6IVxWoAGUx2kKN2jqmfUuyyI+irzhMoQtxln7WzgdSfB/5
         3OCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P2Z7C4AYnqmN1fJ4A3LOaxRz+0uCusfSuGUkn36he00=;
        b=GJa0/iUOp5UpI9YFcRxkS/HcreZFbGMtzhZiMF+90xsl3mknwyR8xpvHMzdJY4/Rei
         HTeMMAkWaeda41bV3dmItdAP1s+qxP3ZSagSk3B93YykUqL3bNFqCSClgfVJ7fnQ+DzQ
         UDWUyvBXVB7fSVlo9iFtUSgpsh7ub1teBezp15ZmFg7hkntSD12x70TqGZns9H5lMP4G
         2U3AcGIsOE/eUlpA1awzTCybPOR2W3GB4wwUF7bOkSOKW3HGd2Bkl33zIKw4Qc5fweXC
         vAwgZEOtkcJ0IM+VQPMLOaUUmtUYvEhfQbkD/2WEIDP4DoCQOfcSxZbRL7DpW2Kx9LLd
         v9xg==
X-Gm-Message-State: AOAM531RtNJjsCFClrzf0L8/4ILDzEHqW38wkHupSe1LrEjCMeeqTPlW
        hMKP4Gkvc/F2KMg/QWe49oD9V7EPZFDpyk4mm9A=
X-Google-Smtp-Source: ABdhPJwhNf2PpfuRuLgI2qKabNA/bdljUFEQv7+eDKrRotBSjX3OtEN/+j6LuLfxGVV4bmh8xiSvQvBOjGbNzTUH4js=
X-Received: by 2002:a25:83d1:0:b0:648:725c:6a05 with SMTP id
 v17-20020a2583d1000000b00648725c6a05mr1012525ybm.218.1652378493736; Thu, 12
 May 2022 11:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <OS0PR01MB5922AC4FB9D5A04180F46C2A86C89@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922AC4FB9D5A04180F46C2A86C89@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 12 May 2022 19:01:06 +0100
Message-ID: <CA+V-a8uCFoje_LRkCOXtA+04sEhGDzae=RrxPcn9n3TE=h9k2w@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller driver
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
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

Hi Biju,

Thank you for the review.

On Wed, May 11, 2022 at 8:25 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Prabhakar,
>
> > Subject: [PATCH v3 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller
> > driver
> >
> > Add a driver for the Renesas RZ/G2L Interrupt Controller.
> >
> > This supports external pins being used as interrupts. It supports one line
> > for NMI, 8 external pins and 32 GPIO pins (out of 123) to be used as IRQ
> > lines.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/irqchip/Kconfig             |   8 +
> >  drivers/irqchip/Makefile            |   1 +
> >  drivers/irqchip/irq-renesas-rzg2l.c | 444 ++++++++++++++++++++++++++++
> >  3 files changed, 453 insertions(+)
> >  create mode 100644 drivers/irqchip/irq-renesas-rzg2l.c
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig index
> > 15edb9a6fcae..f3d071422f3b 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -242,6 +242,14 @@ config RENESAS_RZA1_IRQC
> >         Enable support for the Renesas RZ/A1 Interrupt Controller, to use
> > up
> >         to 8 external interrupts with configurable sense select.
> >
> > +config RENESAS_RZG2L_IRQC
> > +     bool "Renesas RZ/G2L (and alike SoC) IRQC support" if COMPILE_TEST
> > +     select GENERIC_IRQ_CHIP
> > +     select IRQ_DOMAIN_HIERARCHY
> > +     help
> > +       Enable support for the Renesas RZ/G2L (and alike SoC) Interrupt
> > Controller
> > +       for external devices.
> > +
> >  config SL28CPLD_INTC
> >       bool "Kontron sl28cpld IRQ controller"
> >       depends on MFD_SL28CPLD=y || COMPILE_TEST diff --git
> > a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile index
> > 160a1d8ceaa9..eaa56eec2b23 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -51,6 +51,7 @@ obj-$(CONFIG_RDA_INTC)                      += irq-rda-intc.o
> >  obj-$(CONFIG_RENESAS_INTC_IRQPIN)    += irq-renesas-intc-irqpin.o
> >  obj-$(CONFIG_RENESAS_IRQC)           += irq-renesas-irqc.o
> >  obj-$(CONFIG_RENESAS_RZA1_IRQC)              += irq-renesas-rza1.o
> > +obj-$(CONFIG_RENESAS_RZG2L_IRQC)     += irq-renesas-rzg2l.o
> >  obj-$(CONFIG_VERSATILE_FPGA_IRQ)     += irq-versatile-fpga.o
> >  obj-$(CONFIG_ARCH_NSPIRE)            += irq-zevio.o
> >  obj-$(CONFIG_ARCH_VT8500)            += irq-vt8500.o
> > diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-
> > renesas-rzg2l.c
> > new file mode 100644
> > index 000000000000..61435d8dbe1a
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > @@ -0,0 +1,444 @@
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
> > +#define IRQC_IRQ_START                       1
> > +#define IRQC_IRQ_COUNT                       8
> > +#define IRQC_TINT_START                      (IRQC_IRQ_START + IRQC_IRQ_COUNT)
> > +#define IRQC_TINT_COUNT                      32
> > +#define IRQC_NUM_IRQ                 (IRQC_TINT_START + IRQC_TINT_COUNT)
> > +
> > +#define ISCR                         0x10
> > +#define IITSR                                0x14
> > +#define TSCR                         0x20
> > +#define TITSR0                               0x24
> > +#define TITSR1                               0x28
> > +#define TITSR0_MAX_INT                       16
> > +#define TITSEL_WIDTH                 0x2
> > +#define TSSR(n)                              (0x30 + ((n) * 4))
> > +#define TIEN                         BIT(7)
> > +#define TSSEL_SHIFT(n)                       (8 * (n))
> > +#define TSSEL_MASK                   GENMASK(7, 0)
> > +#define IRQ_MASK                     0x3
> > +
> > +#define TSSR_OFFSET(n)                       ((n) % 4)
> > +#define TSSR_INDEX(n)                        ((n) / 4)
> > +
> > +#define TITSR_TITSEL_EDGE_RISING     0
> > +#define TITSR_TITSEL_EDGE_FALLING    1
> > +#define TITSR_TITSEL_LEVEL_HIGH              2
> > +#define TITSR_TITSEL_LEVEL_LOW               3
> > +
> > +#define IITSR_IITSEL(n, sense)               ((sense) << ((n) * 2))
> > +#define IITSR_IITSEL_LEVEL_LOW               0
> > +#define IITSR_IITSEL_EDGE_FALLING    1
> > +#define IITSR_IITSEL_EDGE_RISING     2
> > +#define IITSR_IITSEL_EDGE_BOTH               3
> > +#define IITSR_IITSEL_MASK(n)         IITSR_IITSEL((n), 3)
> > +
> > +#define TINT_EXTRACT_HWIRQ(x)                ((x) & ~GENMASK(31, 16))
> > +#define TINT_EXTRACT_GPIOINT(x)              ((x) >> 16)
> > +
> > +struct rzg2l_irqc_priv {
> > +     void __iomem *base;
> > +     struct of_phandle_args map[IRQC_NUM_IRQ];
> > +     raw_spinlock_t lock;
> > +};
> > +
> > +struct rzg2l_irqc_chip_data {
> > +     int tint;
> > +};
> > +
> > +static struct rzg2l_irqc_priv *irq_data_to_priv(struct irq_data *data)
> > +{
> > +     return data->domain->host_data;
> > +}
> > +
> > +static void rzg2l_irq_eoi(struct irq_data *d) {
> > +     unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
> > +     struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > +     u32 bit = BIT(hw_irq);
> > +     u32 reg;
> > +
> > +     reg = readl_relaxed(priv->base + ISCR);
> > +     if (reg & bit)
> > +             writel_relaxed(reg & ~bit, priv->base + ISCR); }
> > +
> > +static void rzg2l_tint_eoi(struct irq_data *d) {
> > +     unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_TINT_START;
> > +     struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > +     u32 bit = BIT(hw_irq);
> > +     u32 reg;
> > +
> > +     reg = readl_relaxed(priv->base + TSCR);
> > +     if (reg & bit)
> > +             writel_relaxed(reg & ~bit, priv->base + TSCR); }
> > +
> > +static void rzg2l_irqc_eoi(struct irq_data *d) {
> > +     struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > +     unsigned int hw_irq = irqd_to_hwirq(d);
> > +
> > +     raw_spin_lock(&priv->lock);
> > +     if (hw_irq >= IRQC_IRQ_START && hw_irq <= IRQC_IRQ_COUNT)
> > +             rzg2l_irq_eoi(d);
> > +     else if (hw_irq >= IRQC_TINT_START && hw_irq <= IRQC_TINT_COUNT)
> > +             rzg2l_tint_eoi(d);
> > +     raw_spin_unlock(&priv->lock);
> > +     irq_chip_eoi_parent(d);
> > +}
> > +
> > +static void rzg2l_irqc_irq_disable(struct irq_data *d) {
> > +     unsigned int hw_irq = irqd_to_hwirq(d);
> > +
> > +     if (hw_irq >= IRQC_TINT_START && hw_irq <= IRQC_TINT_COUNT) {
> > +             struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > +             u32 offset = hw_irq - IRQC_TINT_START;
> > +             u32 tssr_offset = TSSR_OFFSET(offset);
> > +             u8 tssr_index = TSSR_INDEX(offset);
> > +             u32 reg;
> > +
> > +             raw_spin_lock(&priv->lock);
> > +             reg = readl_relaxed(priv->base + TSSR(tssr_index));
> > +             reg &= ~(TSSEL_MASK << tssr_offset);
> > +             writel_relaxed(reg, priv->base + TSSR(tssr_index));
> > +             raw_spin_unlock(&priv->lock);
> > +     }
> > +     irq_chip_disable_parent(d);
> > +}
> > +
> > +static void rzg2l_irqc_irq_enable(struct irq_data *d) {
> > +     unsigned int hw_irq = irqd_to_hwirq(d);
> > +
> > +     if (hw_irq >= IRQC_TINT_START && hw_irq <= IRQC_TINT_COUNT) {
> > +             struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > +             struct rzg2l_irqc_chip_data *chip_data = d->chip_data;
> > +             u32 offset = hw_irq - IRQC_TINT_START;
> > +             u32 tssr_offset = TSSR_OFFSET(offset);
> > +             u8 tssr_index = TSSR_INDEX(offset);
> > +             u32 reg;
> > +
> > +             raw_spin_lock(&priv->lock);
> > +             reg = readl_relaxed(priv->base + TSSR(tssr_index));
> > +             reg |= (TIEN | chip_data->tint) << TSSEL_SHIFT(tssr_offset);
> > +             writel_relaxed(reg, priv->base + TSSR(tssr_index));
> > +             raw_spin_unlock(&priv->lock);
> > +     }
> > +     irq_chip_enable_parent(d);
> > +}
> > +
> > +static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type) {
> > +     unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
> > +     struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > +     u16 sense, tmp;
> > +
> > +     switch (type & IRQ_TYPE_SENSE_MASK) {
> > +     case IRQ_TYPE_LEVEL_LOW:
> > +             sense = IITSR_IITSEL_LEVEL_LOW;
> > +             break;
> > +
> > +     case IRQ_TYPE_EDGE_FALLING:
> > +             sense = IITSR_IITSEL_EDGE_FALLING;
> > +             break;
> > +
> > +     case IRQ_TYPE_EDGE_RISING:
> > +             sense = IITSR_IITSEL_EDGE_RISING;
> > +             break;
> > +
> > +     case IRQ_TYPE_EDGE_BOTH:
> > +             sense = IITSR_IITSEL_EDGE_BOTH;
> > +             break;
> > +
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     raw_spin_lock(&priv->lock);
> > +     tmp = readl_relaxed(priv->base + IITSR);
> > +     tmp &= ~IITSR_IITSEL_MASK(hw_irq);
> > +     tmp |= IITSR_IITSEL(hw_irq, sense);
> > +     writel_relaxed(tmp, priv->base + IITSR);
> > +     raw_spin_unlock(&priv->lock);
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type) {
> > +     struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > +     unsigned int hwirq = irqd_to_hwirq(d);
> > +     u32 titseln = hwirq - IRQC_TINT_START;
> > +     u32 offset;
> > +     u8 sense;
> > +     u32 reg;
> > +
> > +     switch (type & IRQ_TYPE_SENSE_MASK) {
> > +     case IRQ_TYPE_EDGE_RISING:
> > +             sense = TITSR_TITSEL_EDGE_RISING;
> > +             break;
> > +
> > +     case IRQ_TYPE_EDGE_FALLING:
> > +             sense = TITSR_TITSEL_EDGE_FALLING;
> > +             break;
> > +
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     offset = TITSR0;
> > +     if (titseln >= TITSR0_MAX_INT) {
> > +             titseln -= TITSR0_MAX_INT;
> > +             offset = TITSR1;
> > +     }
> > +
> > +     raw_spin_lock(&priv->lock);
> > +     reg = readl_relaxed(priv->base + offset);
> > +     reg &= ~(IRQ_MASK << (titseln * TITSEL_WIDTH));
> > +     reg |= sense << (titseln * TITSEL_WIDTH);
> > +     writel_relaxed(reg, priv->base + offset);
> > +     raw_spin_unlock(&priv->lock);
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_irqc_set_type(struct irq_data *d, unsigned int type) {
> > +     unsigned int hw_irq = irqd_to_hwirq(d);
> > +     int ret = -EINVAL;
> > +
> > +     if (hw_irq >= IRQC_IRQ_START && hw_irq <= IRQC_IRQ_COUNT)
> > +             ret = rzg2l_irq_set_type(d, type);
> > +     else if (hw_irq >= IRQC_TINT_START && hw_irq <= IRQC_TINT_COUNT)
> > +             ret = rzg2l_tint_set_edge(d, type);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH); }
> > +
> > +static struct irq_chip irqc_chip = {
> > +     .name                   = "rzg2l-irqc",
> > +     .irq_eoi                = rzg2l_irqc_eoi,
> > +     .irq_mask               = irq_chip_mask_parent,
> > +     .irq_unmask             = irq_chip_unmask_parent,
> > +     .irq_disable            = rzg2l_irqc_irq_disable,
> > +     .irq_enable             = rzg2l_irqc_irq_enable,
> > +     .irq_get_irqchip_state  = irq_chip_get_parent_state,
> > +     .irq_set_irqchip_state  = irq_chip_set_parent_state,
> > +     .irq_retrigger          = irq_chip_retrigger_hierarchy,
> > +     .irq_set_type           = rzg2l_irqc_set_type,
> > +     .flags                  = IRQCHIP_MASK_ON_SUSPEND |
> > +                               IRQCHIP_SET_TYPE_MASKED |
> > +                               IRQCHIP_SKIP_SET_WAKE,
> > +};
> > +
> > +static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int virq,
> > +                         unsigned int nr_irqs, void *arg) {
> > +     struct rzg2l_irqc_priv *priv = domain->host_data;
> > +     struct rzg2l_irqc_chip_data *chip_data = NULL;
> > +     struct irq_fwspec spec;
> > +     irq_hw_number_t hwirq;
> > +     int tint = -EINVAL;
> > +     unsigned int type;
> > +     unsigned int i;
> > +     int ret;
> > +
> > +     ret = irq_domain_translate_twocell(domain, arg, &hwirq, &type);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /*
> > +      * For TINIT interrupts ie where pinctrl driver is child of irqc
>
> Minor pick. Typo TINIT->TINT?? Similarly, 2 other places below.
>
Oops will fix that.

Cheers,
Prabhakar

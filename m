Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB95C55A91F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbiFYKzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 06:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiFYKzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 06:55:12 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E9B1DA4E;
        Sat, 25 Jun 2022 03:55:11 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3178ea840easo45671947b3.13;
        Sat, 25 Jun 2022 03:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jOJtvlzmGU8PmeIsBqlIwj2gSyF9BeUerfqCvHD4oGs=;
        b=jaaRQTtZd18kAVaGfNEvxsxbjHj/Y94vuMMaMx/yEEeJezGb36EVatBlQzKr0itY6m
         g+i+HTauu2mg0hvYMNsKnSJIjEmPPhfsv/erth7AI3bOVDzIbpw9fEe/ZuHLJvekYPBG
         pVcnpBWO+TvGXmoR7qDlt+CC9pxaV7++tbASQ454Aeum+FzbNjGZTjOf5l31LAKOBYko
         dDsoW8YaPVyfhmGh4/xSr+2L4DO++5Do8sQp0fdkj9TYjOimmq0fAwbQkPrHJN8ViUd0
         WAXOJ6cHRE9n2H4Oeislp1+kOWaLmQML2g4xfet8tWLdbcDPDBuEkuDhUmYiBxdh1diq
         xf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jOJtvlzmGU8PmeIsBqlIwj2gSyF9BeUerfqCvHD4oGs=;
        b=Pkd3vlV8m/1B7rrHUMfL/pzfKqDUgIYoiQ2NQvAfYHrQTBATGa/2rBwRVyZJHjRAFI
         LRv4O6HQ1iDNrkfqU3cbZhjSF/+/3bZ0EqrH+6ZyM2eQ5lRlY2PmFx+Kp80bDz0XbH/I
         JdcRWiQqPRmmEPLV2pxQobTdiszfvGGmNLcWQPTr7+vh7ZuaFvpjGE4ycH43+U39DH8q
         zGdWUNOIXGSZCqtrrdmoebR5nY4GSimCzl+3PNQtTmPluaAnBusLK53lJ7IA9Y6Oktnm
         kuQZuyyKU4LePYMOLijyQ5vHGzIpr21++ms7KFBL8dp9FoNVeyd7n5HNH0oJTlnKZV8/
         gFvA==
X-Gm-Message-State: AJIora+Sg0AGELk8I1Vv7SK96ZbZe2LvI/lwCFlRrpGYZFETi3g+ijNQ
        sxJ7GfvtmUAUh25w67z6+Tv5pT2Jupc6uiRzFs4=
X-Google-Smtp-Source: AGRyM1tMQZ1g+uYn79r3Qm8lfadVcIc2yQUCvPcrOdsOwuraEJqnVd0BQSykdWun3pkR/4hBsL3P4OmnngEZaGK4ZDg=
X-Received: by 2002:a81:80c2:0:b0:31b:71d9:5946 with SMTP id
 q185-20020a8180c2000000b0031b71d95946mr3609481ywf.265.1656154510210; Sat, 25
 Jun 2022 03:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220523174238.28942-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220523174238.28942-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <871qvdf5tb.wl-maz@kernel.org>
In-Reply-To: <871qvdf5tb.wl-maz@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 25 Jun 2022 11:54:44 +0100
Message-ID: <CA+V-a8veE6-4C+9kyTNxqsf0jB5xCGhcHncTSM3ejDzBAfz=Bw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Thank you for the review.

On Sat, Jun 25, 2022 at 10:30 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 23 May 2022 18:42:35 +0100,
> Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > Add a driver for the Renesas RZ/G2L Interrupt Controller.
> >
> > This supports external pins being used as interrupts. It supports
> > one line for NMI, 8 external pins and 32 GPIO pins (out of 123)
> > to be used as IRQ lines.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/irqchip/Kconfig             |   8 +
> >  drivers/irqchip/Makefile            |   1 +
> >  drivers/irqchip/irq-renesas-rzg2l.c | 425 ++++++++++++++++++++++++++++
> >  3 files changed, 434 insertions(+)
> >  create mode 100644 drivers/irqchip/irq-renesas-rzg2l.c
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 15edb9a6fcae..f3d071422f3b 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -242,6 +242,14 @@ config RENESAS_RZA1_IRQC
> >         Enable support for the Renesas RZ/A1 Interrupt Controller, to u=
se up
> >         to 8 external interrupts with configurable sense select.
> >
> > +config RENESAS_RZG2L_IRQC
> > +     bool "Renesas RZ/G2L (and alike SoC) IRQC support" if COMPILE_TES=
T
> > +     select GENERIC_IRQ_CHIP
> > +     select IRQ_DOMAIN_HIERARCHY
> > +     help
> > +       Enable support for the Renesas RZ/G2L (and alike SoC) Interrupt=
 Controller
> > +       for external devices.
> > +
> >  config SL28CPLD_INTC
> >       bool "Kontron sl28cpld IRQ controller"
> >       depends on MFD_SL28CPLD=3Dy || COMPILE_TEST
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index 160a1d8ceaa9..eaa56eec2b23 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -51,6 +51,7 @@ obj-$(CONFIG_RDA_INTC)                      +=3D irq-=
rda-intc.o
> >  obj-$(CONFIG_RENESAS_INTC_IRQPIN)    +=3D irq-renesas-intc-irqpin.o
> >  obj-$(CONFIG_RENESAS_IRQC)           +=3D irq-renesas-irqc.o
> >  obj-$(CONFIG_RENESAS_RZA1_IRQC)              +=3D irq-renesas-rza1.o
> > +obj-$(CONFIG_RENESAS_RZG2L_IRQC)     +=3D irq-renesas-rzg2l.o
> >  obj-$(CONFIG_VERSATILE_FPGA_IRQ)     +=3D irq-versatile-fpga.o
> >  obj-$(CONFIG_ARCH_NSPIRE)            +=3D irq-zevio.o
> >  obj-$(CONFIG_ARCH_VT8500)            +=3D irq-vt8500.o
> > diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-=
renesas-rzg2l.c
> > new file mode 100644
> > index 000000000000..a846c6ee11d7
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > @@ -0,0 +1,425 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Renesas RZ/G2L IRQC Driver
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corporation.
> > + *
> > + * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/reset.h>
> > +#include <linux/spinlock.h>
> > +
> > +#define IRQC_IRQ_START                       1
> > +#define IRQC_IRQ_COUNT                       8
> > +#define IRQC_TINT_START                      (IRQC_IRQ_START + IRQC_IR=
Q_COUNT)
> > +#define IRQC_TINT_COUNT                      32
> > +#define IRQC_NUM_IRQ                 (IRQC_TINT_START + IRQC_TINT_COUN=
T)
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
> > +#define TINT_EXTRACT_HWIRQ(x)           FIELD_GET(GENMASK(15, 0), (x))
> > +#define TINT_EXTRACT_GPIOINT(x)         FIELD_GET(GENMASK(31, 16), (x)=
)
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
> > +static void rzg2l_irq_eoi(struct irq_data *d)
> > +{
> > +     unsigned int hw_irq =3D irqd_to_hwirq(d) - IRQC_IRQ_START;
> > +     struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> > +     u32 bit =3D BIT(hw_irq);
> > +     u32 reg;
> > +
> > +     reg =3D readl_relaxed(priv->base + ISCR);
> > +     if (reg & bit)
> > +             writel_relaxed(reg & ~bit, priv->base + ISCR);
> > +}
> > +
> > +static void rzg2l_tint_eoi(struct irq_data *d)
> > +{
> > +     unsigned int hw_irq =3D irqd_to_hwirq(d) - IRQC_TINT_START;
> > +     struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> > +     u32 bit =3D BIT(hw_irq);
> > +     u32 reg;
> > +
> > +     reg =3D readl_relaxed(priv->base + TSCR);
> > +     if (reg & bit)
> > +             writel_relaxed(reg & ~bit, priv->base + TSCR);
> > +}
> > +
> > +static void rzg2l_irqc_eoi(struct irq_data *d)
> > +{
> > +     struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> > +     unsigned int hw_irq =3D irqd_to_hwirq(d);
> > +
> > +     raw_spin_lock(&priv->lock);
> > +     if (hw_irq >=3D IRQC_IRQ_START && hw_irq <=3D IRQC_IRQ_COUNT)
> > +             rzg2l_irq_eoi(d);
> > +     else if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ)
> > +             rzg2l_tint_eoi(d);
> > +     raw_spin_unlock(&priv->lock);
> > +     irq_chip_eoi_parent(d);
> > +}
> > +
> > +static void rzg2l_irqc_irq_disable(struct irq_data *d)
> > +{
> > +     unsigned int hw_irq =3D irqd_to_hwirq(d);
> > +
> > +     if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
> > +             struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> > +             u32 offset =3D hw_irq - IRQC_TINT_START;
> > +             u32 tssr_offset =3D TSSR_OFFSET(offset);
> > +             u8 tssr_index =3D TSSR_INDEX(offset);
> > +             u32 reg;
> > +
> > +             raw_spin_lock(&priv->lock);
> > +             reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
> > +             reg &=3D ~(TSSEL_MASK << tssr_offset);
> > +             writel_relaxed(reg, priv->base + TSSR(tssr_index));
> > +             raw_spin_unlock(&priv->lock);
> > +     }
> > +     irq_chip_disable_parent(d);
> > +}
> > +
> > +static void rzg2l_irqc_irq_enable(struct irq_data *d)
> > +{
> > +     unsigned int hw_irq =3D irqd_to_hwirq(d);
> > +
> > +     if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
> > +             struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> > +             unsigned long chip_data =3D *(unsigned long *)d->chip_dat=
a;
> > +             u32 offset =3D hw_irq - IRQC_TINT_START;
> > +             u32 tssr_offset =3D TSSR_OFFSET(offset);
> > +             u8 tssr_index =3D TSSR_INDEX(offset);
> > +             u32 reg;
> > +
> > +             raw_spin_lock(&priv->lock);
> > +             reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
> > +             reg |=3D (TIEN | chip_data) << TSSEL_SHIFT(tssr_offset);
> > +             writel_relaxed(reg, priv->base + TSSR(tssr_index));
> > +             raw_spin_unlock(&priv->lock);
> > +     }
> > +     irq_chip_enable_parent(d);
> > +}
> > +
> > +static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
> > +{
> > +     unsigned int hw_irq =3D irqd_to_hwirq(d) - IRQC_IRQ_START;
> > +     struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> > +     u16 sense, tmp;
> > +
> > +     switch (type & IRQ_TYPE_SENSE_MASK) {
> > +     case IRQ_TYPE_LEVEL_LOW:
> > +             sense =3D IITSR_IITSEL_LEVEL_LOW;
> > +             break;
> > +
> > +     case IRQ_TYPE_EDGE_FALLING:
> > +             sense =3D IITSR_IITSEL_EDGE_FALLING;
> > +             break;
> > +
> > +     case IRQ_TYPE_EDGE_RISING:
> > +             sense =3D IITSR_IITSEL_EDGE_RISING;
> > +             break;
> > +
> > +     case IRQ_TYPE_EDGE_BOTH:
> > +             sense =3D IITSR_IITSEL_EDGE_BOTH;
> > +             break;
> > +
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     raw_spin_lock(&priv->lock);
> > +     tmp =3D readl_relaxed(priv->base + IITSR);
> > +     tmp &=3D ~IITSR_IITSEL_MASK(hw_irq);
> > +     tmp |=3D IITSR_IITSEL(hw_irq, sense);
> > +     writel_relaxed(tmp, priv->base + IITSR);
> > +     raw_spin_unlock(&priv->lock);
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
> > +{
> > +     struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> > +     unsigned int hwirq =3D irqd_to_hwirq(d);
> > +     u32 titseln =3D hwirq - IRQC_TINT_START;
> > +     u32 offset;
> > +     u8 sense;
> > +     u32 reg;
> > +
> > +     switch (type & IRQ_TYPE_SENSE_MASK) {
> > +     case IRQ_TYPE_EDGE_RISING:
> > +             sense =3D TITSR_TITSEL_EDGE_RISING;
> > +             break;
> > +
> > +     case IRQ_TYPE_EDGE_FALLING:
> > +             sense =3D TITSR_TITSEL_EDGE_FALLING;
> > +             break;
> > +
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     offset =3D TITSR0;
> > +     if (titseln >=3D TITSR0_MAX_INT) {
> > +             titseln -=3D TITSR0_MAX_INT;
> > +             offset =3D TITSR1;
> > +     }
> > +
> > +     raw_spin_lock(&priv->lock);
> > +     reg =3D readl_relaxed(priv->base + offset);
> > +     reg &=3D ~(IRQ_MASK << (titseln * TITSEL_WIDTH));
> > +     reg |=3D sense << (titseln * TITSEL_WIDTH);
> > +     writel_relaxed(reg, priv->base + offset);
> > +     raw_spin_unlock(&priv->lock);
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_irqc_set_type(struct irq_data *d, unsigned int type)
> > +{
> > +     unsigned int hw_irq =3D irqd_to_hwirq(d);
> > +     int ret =3D -EINVAL;
> > +
> > +     if (hw_irq >=3D IRQC_IRQ_START && hw_irq <=3D IRQC_IRQ_COUNT)
> > +             ret =3D rzg2l_irq_set_type(d, type);
> > +     else if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ)
> > +             ret =3D rzg2l_tint_set_edge(d, type);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
> > +}
> > +
> > +static const struct irq_chip irqc_chip =3D {
> > +     .name                   =3D "rzg2l-irqc",
> > +     .irq_eoi                =3D rzg2l_irqc_eoi,
> > +     .irq_mask               =3D irq_chip_mask_parent,
> > +     .irq_unmask             =3D irq_chip_unmask_parent,
> > +     .irq_disable            =3D rzg2l_irqc_irq_disable,
> > +     .irq_enable             =3D rzg2l_irqc_irq_enable,
> > +     .irq_get_irqchip_state  =3D irq_chip_get_parent_state,
> > +     .irq_set_irqchip_state  =3D irq_chip_set_parent_state,
> > +     .irq_retrigger          =3D irq_chip_retrigger_hierarchy,
> > +     .irq_set_type           =3D rzg2l_irqc_set_type,
> > +     .flags                  =3D IRQCHIP_MASK_ON_SUSPEND |
> > +                               IRQCHIP_SET_TYPE_MASKED |
> > +                               IRQCHIP_SKIP_SET_WAKE,
> > +};
> > +
> > +static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int vi=
rq,
> > +                         unsigned int nr_irqs, void *arg)
> > +{
> > +     struct rzg2l_irqc_priv *priv =3D domain->host_data;
> > +     unsigned long *chip_data =3D NULL;
>
> Why the init to NULL?
>
Can be dropped.

> > +     struct irq_fwspec spec;
> > +     irq_hw_number_t hwirq;
> > +     int tint =3D -EINVAL;
> > +     unsigned int type;
> > +     unsigned int i;
> > +     int ret;
> > +
> > +     ret =3D irq_domain_translate_twocell(domain, arg, &hwirq, &type);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /*
> > +      * For TINT interrupts ie where pinctrl driver is child of irqc d=
omain
> > +      * the hwirq and TINT are encoded in fwspec->param[0].
> > +      * hwirq for TINT range from 9-40, hwirq is embedded 0-15 bits an=
d TINT
> > +      * from 16-31 bits. TINT from the pinctrl driver needs to be prog=
rammed
> > +      * in IRQC registers to enable a given gpio pin as interrupt.
> > +      */
> > +     if (hwirq > IRQC_IRQ_COUNT) {
> > +             tint =3D TINT_EXTRACT_GPIOINT(hwirq);
> > +             hwirq =3D TINT_EXTRACT_HWIRQ(hwirq);
> > +
> > +             if (hwirq < IRQC_TINT_START)
> > +                     return -EINVAL;
> > +     }
> > +
> > +     if (hwirq > (IRQC_NUM_IRQ - 1))
> > +             return -EINVAL;
> > +
> > +     chip_data =3D kzalloc(sizeof(*chip_data), GFP_KERNEL);
>
> Are we really allocating an unsigned long for something that already
> fits in something that is pointer-sized?
>
I think I received some feedback to use unsigned long.  Let me know
what you want me to use here.

> > +     if (!chip_data)
> > +             return -ENOMEM;
> > +     *chip_data =3D tint;
>
> So here, *chip_data can be set to -EINVAL if hwirq <=3D IRQC_IRQ_COUNT?
> This can't be right.
>
Yes *chip_data can be -EINVAL. IRQC block handles IRQ0-7 and
GPIOINT0-122. So the -EINVAL here is for IRQ0-7 case were dont
required the chip data in the call backs hence -EINVAL, Whereas for
GPIOINT0-122 we need chip_data in the callbacks as this value needs to
be programmed in the hardware registers.

> > +
> > +     ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &irqc_=
chip,
> > +                                         chip_data);
> > +     if (ret) {
> > +             kfree(chip_data);
> > +             return ret;
> > +     }
> > +
> > +     spec.fwnode =3D domain->parent->fwnode;
> > +     spec.param_count =3D priv->map[hwirq].args_count;
> > +     for (i =3D 0; i < spec.param_count; i++)
> > +             spec.param[i] =3D priv->map[hwirq].args[i];
>
> Why isn't that simply:
>
>         spec =3D priv->map[hwirq];
>
spec is of type =E2=80=98struct irq_fwspec=E2=80=99 and map is of type =E2=
=80=98struct of_phandle_args=E2=80=99.

> as this really is the interrupt you want to map to?
>
Yes.

> > +
> > +     ret =3D irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &spec=
);
>
> or even better:
>
>         ret =3D irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
>                                            &priv->map[hwirq]);
>
Does not work as map is of type =E2=80=98struct of_phandle_args=E2=80=99.

> > +     if (ret)
> > +             kfree(chip_data);
> > +
> > +     return ret;
> > +}
> > +
> > +static void rzg2l_irqc_domain_free(struct irq_domain *domain, unsigned=
 int virq,
> > +                                unsigned int nr_irqs)
> > +{
> > +     struct irq_data *d;
> > +
> > +     d =3D irq_domain_get_irq_data(domain, virq);
> > +     if (d)
> > +             kfree(d->chip_data);
> > +
> > +     irq_domain_free_irqs_common(domain, virq, nr_irqs);
> > +}
> > +
> > +static const struct irq_domain_ops rzg2l_irqc_domain_ops =3D {
> > +     .alloc =3D rzg2l_irqc_alloc,
> > +     .free =3D rzg2l_irqc_domain_free,
> > +     .translate =3D irq_domain_translate_twocell,
> > +};
> > +
> > +static int rzg2l_irqc_parse_map(struct rzg2l_irqc_priv *priv,
> > +                             struct device_node *np)
> > +{
> > +     unsigned int i;
> > +     int ret;
> > +
> > +     for (i =3D 0; i < IRQC_NUM_IRQ; i++) {
> > +             ret =3D of_irq_parse_one(np, i, &priv->map[i]);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_irqc_init(struct device_node *node, struct device_nod=
e *parent)
> > +{
> > +     struct irq_domain *irq_domain, *parent_domain;
> > +     struct platform_device *pdev;
> > +     struct reset_control *resetn;
> > +     struct rzg2l_irqc_priv *priv;
> > +     int ret;
> > +
> > +     pdev =3D of_find_device_by_node(node);
> > +     if (!pdev)
> > +             return -ENODEV;
> > +
> > +     parent_domain =3D irq_find_host(parent);
> > +     if (!parent_domain) {
> > +             dev_err(&pdev->dev, "cannot find parent domain\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     priv->base =3D devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NU=
LL);
> > +     if (IS_ERR(priv->base))
> > +             return PTR_ERR(priv->base);
> > +
> > +     ret =3D rzg2l_irqc_parse_map(priv, node);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "cannot parse interrupts: %d\n", ret)=
;
> > +             return ret;
> > +     }
> > +
> > +     resetn =3D devm_reset_control_get_exclusive_by_index(&pdev->dev, =
0);
> > +     if (IS_ERR(resetn))
> > +             return IS_ERR(resetn);
> > +
> > +     ret =3D reset_control_deassert(resetn);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "failed to deassert resetn pin, %d\n"=
, ret);
> > +             return ret;
> > +     }
> > +
> > +     pm_runtime_enable(&pdev->dev);
> > +     ret =3D pm_runtime_resume_and_get(&pdev->dev);
> > +     if (ret < 0) {
> > +             dev_err(&pdev->dev, "pm_runtime_resume_and_get failed: %d=
\n", ret);
> > +             goto pm_disable;
> > +     }
>
> If using runtime PM, why isn't the core IRQ code made aware of this
> dependency by registering the device with irq_domain_set_pm_device()
> instead of leaving it enabled forever?
>
Ouch will add irq_domain_set_pm_device() below.

Cheers,
Prabhakar

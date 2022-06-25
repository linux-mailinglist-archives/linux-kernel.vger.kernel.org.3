Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEDA55AC25
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 21:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiFYT1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 15:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiFYT1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 15:27:11 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1577613E2A;
        Sat, 25 Jun 2022 12:27:10 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3176b6ed923so52323177b3.11;
        Sat, 25 Jun 2022 12:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3tWhPRCDafQWUkPgVsROlclarSgmO3/WZsq0SZww5zg=;
        b=fGt8g4Adky0dTHEHDKfQs7fiT2SEeFg6E3BUcaMjvwJ6OU/woS7guDlyzq7b9pEuCv
         dpVQxBAH/di7aO42KVcypxOBeCgPUnElP+iUa/nPkcVJXEKEyhQd/wyKXeyfki6ZFBkR
         L5C7R3KF+jfcxJpDPQsYz5IaR+/3M1+PfuWR7pZcP+JiYrCTvm03w0qQIKmPOMlulQIm
         0wpdxhUmAFz6ulTf4sVhg8xzoUC4G4YZqYvDKkQ4O66yiBX8K5Do89gUkMOnIuNpvaod
         NS898V5WiEeMaPNauzCJ5HueQAfJl1IjCV6+VyB/heWR61WUnljanA0v7/4QvXwdVanU
         sFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tWhPRCDafQWUkPgVsROlclarSgmO3/WZsq0SZww5zg=;
        b=X1qjD4eEKZ+1Q+gqqZyTyqCp1fWJvQFDyM2RSla+BgNU+qgwQFNu0/Es6skdKx6WDP
         svGFMQvPPiRvdDnxCGgfiUlAwmH1J9THPunSooaogxRtYhjiUHt2isHWgJ7z0v0I55LS
         Q5HQlOJ13BiyH0Bf2NwViVUdhA73gY5tI/Z1N6Vv0gcCZsVklslOY3K535bCliZQpwgb
         y4l5VdSPI5bfbDHga+cM1MD6KlQoa1Uc+idcIjoRBcQO1rD6ABmSXEqSm+ThzRYUQgq9
         SitlDq+25J5ALuQ5M6bZjxuvg9mbgAzhQ/Gde6REo95poTbsdQ9x2qre8Md9JezJOofa
         GqNw==
X-Gm-Message-State: AJIora8xkRwPmLrKhNPkJN2FipWwI/FNt5YF+pCnxSUJ8K2dPTD0VOlZ
        9qDSyWHnzRrNwQAWYUyDVRhTjG3d8s1skO4r9Ls=
X-Google-Smtp-Source: AGRyM1tJ61JAEg2oK/oCDuS9kFAC60cq0TxlXU43pUpHtQgK1dvQL+qFp4MRkyfGKAG1bY9wVBV6OGY7rdjm/EfgVeU=
X-Received: by 2002:a81:600a:0:b0:318:81bc:e928 with SMTP id
 u10-20020a81600a000000b0031881bce928mr5946529ywb.119.1656185229325; Sat, 25
 Jun 2022 12:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220523174238.28942-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220523174238.28942-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <871qvdf5tb.wl-maz@kernel.org> <CA+V-a8veE6-4C+9kyTNxqsf0jB5xCGhcHncTSM3ejDzBAfz=Bw@mail.gmail.com>
 <87fsjt2bep.wl-maz@kernel.org> <CA+V-a8td93QOCC8cHLEPaba-hnX2gjydmKTbaCrF+zgH7hH8Jg@mail.gmail.com>
 <87y1xkencl.wl-maz@kernel.org>
In-Reply-To: <87y1xkencl.wl-maz@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 25 Jun 2022 20:26:43 +0100
Message-ID: <CA+V-a8tKfGngEz51+Gw_3wK7zNzuw4Ubfm0zEB-jQJijS8f+2g@mail.gmail.com>
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

On Sat, Jun 25, 2022 at 5:09 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 25 Jun 2022 13:48:08 +0100,
> "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> >
> > Hi Marc,
> >
> > On Sat, Jun 25, 2022 at 1:08 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Sat, 25 Jun 2022 11:54:44 +0100,
> > > "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> > > >
> > > > Hi Marc,
> > > >
> > > > Thank you for the review.
> > > >
> > > > On Sat, Jun 25, 2022 at 10:30 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > >
> > > > > On Mon, 23 May 2022 18:42:35 +0100,
> > > > > Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > > >
> > >
> > > [...]
> > >
> > > > > > +static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int virq,
> > > > > > +                         unsigned int nr_irqs, void *arg)
> > > > > > +{
> > > > > > +     struct rzg2l_irqc_priv *priv = domain->host_data;
> > > > > > +     unsigned long *chip_data = NULL;
> > > > >
> > > > > Why the init to NULL?
> > > > >
> > > > Can be dropped.
> > > >
> > > > > > +     struct irq_fwspec spec;
> > > > > > +     irq_hw_number_t hwirq;
> > > > > > +     int tint = -EINVAL;
> > > > > > +     unsigned int type;
> > > > > > +     unsigned int i;
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     ret = irq_domain_translate_twocell(domain, arg, &hwirq, &type);
> > > > > > +     if (ret)
> > > > > > +             return ret;
> > > > > > +
> > > > > > +     /*
> > > > > > +      * For TINT interrupts ie where pinctrl driver is child of irqc domain
> > > > > > +      * the hwirq and TINT are encoded in fwspec->param[0].
> > > > > > +      * hwirq for TINT range from 9-40, hwirq is embedded 0-15 bits and TINT
> > > > > > +      * from 16-31 bits. TINT from the pinctrl driver needs to be programmed
> > > > > > +      * in IRQC registers to enable a given gpio pin as interrupt.
> > > > > > +      */
> > > > > > +     if (hwirq > IRQC_IRQ_COUNT) {
> > > > > > +             tint = TINT_EXTRACT_GPIOINT(hwirq);
> > > > > > +             hwirq = TINT_EXTRACT_HWIRQ(hwirq);
> > > > > > +
> > > > > > +             if (hwirq < IRQC_TINT_START)
> > > > > > +                     return -EINVAL;
> > > > > > +     }
> > > > > > +
> > > > > > +     if (hwirq > (IRQC_NUM_IRQ - 1))
> > > > > > +             return -EINVAL;
> > > > > > +
> > > > > > +     chip_data = kzalloc(sizeof(*chip_data), GFP_KERNEL);
> > > > >
> > > > > Are we really allocating an unsigned long for something that already
> > > > > fits in something that is pointer-sized?
> > > > >
> > > > I think I received some feedback to use unsigned long.  Let me know
> > > > what you want me to use here.
> > >
> > > I think this is just a waste of memory, but I don't really care.
> > >
> > Is there any better way I can handle it?
>
> How about (shock, horror) a cast?
>
Right I get you now..

> >
> > > >
> > > > > > +     if (!chip_data)
> > > > > > +             return -ENOMEM;
> > > > > > +     *chip_data = tint;
> > > > >
> > > > > So here, *chip_data can be set to -EINVAL if hwirq <= IRQC_IRQ_COUNT?
> > > > > This can't be right.
> > > > >
> > > > Yes *chip_data can be -EINVAL. IRQC block handles IRQ0-7 and
> > > > GPIOINT0-122. So the -EINVAL here is for IRQ0-7 case were dont
> > > > required the chip data in the call backs hence -EINVAL, Whereas for
> > > > GPIOINT0-122 we need chip_data in the callbacks as this value needs to
> > > > be programmed in the hardware registers.
> > >
> > > I can't see anything that checks it (let alone the difference in
> > > types). And if it isn't checked, this means that the allocation is
> > > pointless.
> > >
> > There are checks for example below:
> >
> > static void rzg2l_irqc_irq_enable(struct irq_data *d)
> > {
> >     unsigned int hw_irq = irqd_to_hwirq(d);
> >
> >     if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
> >         struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> >         unsigned long chip_data = *(unsigned long *)d->chip_data;
> >         u32 offset = hw_irq - IRQC_TINT_START;
> >         u32 tssr_offset = TSSR_OFFSET(offset);
> >         u8 tssr_index = TSSR_INDEX(offset);
> >         u32 reg;
> >
> >         raw_spin_lock(&priv->lock);
> >         reg = readl_relaxed(priv->base + TSSR(tssr_index));
> >         reg |= (TIEN | chip_data) << TSSEL_SHIFT(tssr_offset);
> >         writel_relaxed(reg, priv->base + TSSR(tssr_index));
> >         raw_spin_unlock(&priv->lock);
> >     }
> >     irq_chip_enable_parent(d);
> > }
> >
> > This check hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ here
> > would mean its GPIOINT0-122 and then the chip data will be used.
>
> That doesn't check the content of chip_data if outside of this
> condition. Nonetheless, you allocate an unsigned long to store
> -EINVAL. Not only this is a pointless allocation, but you use it to
> store something that you never retrieve the first place. Don't you see
> the problem?
>
... and when using cast I no longer need the allocation.

Cheers,
Prabhakar

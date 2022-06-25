Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D1355AA1A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 14:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbiFYMsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 08:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiFYMsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 08:48:36 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC2017599;
        Sat, 25 Jun 2022 05:48:34 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-318889e6a2cso47323797b3.1;
        Sat, 25 Jun 2022 05:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pSrQucjneBEV33bL8EXRjpcp4KUNHnVHmvxgy91j5E4=;
        b=nQe3v9bDh0mj1Mf+c6S9DzsJrObqOLc2Ttel/m/3Prj621ZfV8zXx2qDJ+fcBdGuTm
         Aqt/FyuUccjpbtt6eNx/TEJILdD0hXuZadtOkhhutyv2SMvArmsTBpEDz01DRJpNA7vE
         gC27YANgyt6btKpdX+QYWgQ20ZJo7GmwVWlfXR73KA57Qv/ZhBDy6+I75TV1EXy43gJN
         x1Md+KR/WiWva29n/vOg+Y6poLqCAtJ0H9xuYzdxV7BLBBSdHRg27Dy2emFyMSbwyeaG
         IHR2rmtVONP1UxSEJQoKyUnAqFdJqZbRDdkzswgomMTTq4PGn94MYwQ8piTkX8Zro67a
         YM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pSrQucjneBEV33bL8EXRjpcp4KUNHnVHmvxgy91j5E4=;
        b=na0v1rE4Z1F8jT9DRywgtb/rKeaSAqtpmqnFfdVJGbaR/txuruP1J7c+7bJaP2PX+n
         ygIZz6ayNaymx9EgLXeSz9Ojq6pA5M0MCVjbZT6jTzIr9iRQaCx67HJ7ZqB2UGacvK5Q
         cjz822TDGL5AtTCgYyhMIqad6e2r2nY1hajoLVqd5ci2dz0ClhXKP9/d8dsFlm7Et3y8
         myXusCTRVeLmw8/0drNjdDqeE1JdfzEdS25yqkOB0iqd/BlPBNicUGhlzPw7acQG42kR
         ggq9umLCZrTkf5rDhJ1Wt3kHnVFkxGH2MXPQ0nPn6UizyMK861OKGIwcgKRPl9/8iVlq
         bYVQ==
X-Gm-Message-State: AJIora+Zbd8n/GRDe9/HnQQ38pIH3c7y6yoFCg0CGIaUs3EuZXP/HKuz
        GFmRUNJJhz2Y5wVmaU8qdAe7ygrlJKQqaiwNVhM=
X-Google-Smtp-Source: AGRyM1t8gI4m0LMlEovcOlP6DZZoYOUUgB9mdswUgzi89OfMZcaSeLehwbVOejFPsnc2W5qQjVbawYjJtN8Is8LMLGw=
X-Received: by 2002:a0d:cb13:0:b0:318:39b9:89fc with SMTP id
 n19-20020a0dcb13000000b0031839b989fcmr4603440ywd.413.1656161314148; Sat, 25
 Jun 2022 05:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220523174238.28942-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220523174238.28942-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <871qvdf5tb.wl-maz@kernel.org> <CA+V-a8veE6-4C+9kyTNxqsf0jB5xCGhcHncTSM3ejDzBAfz=Bw@mail.gmail.com>
 <87fsjt2bep.wl-maz@kernel.org>
In-Reply-To: <87fsjt2bep.wl-maz@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 25 Jun 2022 13:48:08 +0100
Message-ID: <CA+V-a8td93QOCC8cHLEPaba-hnX2gjydmKTbaCrF+zgH7hH8Jg@mail.gmail.com>
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

On Sat, Jun 25, 2022 at 1:08 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 25 Jun 2022 11:54:44 +0100,
> "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> >
> > Hi Marc,
> >
> > Thank you for the review.
> >
> > On Sat, Jun 25, 2022 at 10:30 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Mon, 23 May 2022 18:42:35 +0100,
> > > Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > >
>
> [...]
>
> > > > +static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned in=
t virq,
> > > > +                         unsigned int nr_irqs, void *arg)
> > > > +{
> > > > +     struct rzg2l_irqc_priv *priv =3D domain->host_data;
> > > > +     unsigned long *chip_data =3D NULL;
> > >
> > > Why the init to NULL?
> > >
> > Can be dropped.
> >
> > > > +     struct irq_fwspec spec;
> > > > +     irq_hw_number_t hwirq;
> > > > +     int tint =3D -EINVAL;
> > > > +     unsigned int type;
> > > > +     unsigned int i;
> > > > +     int ret;
> > > > +
> > > > +     ret =3D irq_domain_translate_twocell(domain, arg, &hwirq, &ty=
pe);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     /*
> > > > +      * For TINT interrupts ie where pinctrl driver is child of ir=
qc domain
> > > > +      * the hwirq and TINT are encoded in fwspec->param[0].
> > > > +      * hwirq for TINT range from 9-40, hwirq is embedded 0-15 bit=
s and TINT
> > > > +      * from 16-31 bits. TINT from the pinctrl driver needs to be =
programmed
> > > > +      * in IRQC registers to enable a given gpio pin as interrupt.
> > > > +      */
> > > > +     if (hwirq > IRQC_IRQ_COUNT) {
> > > > +             tint =3D TINT_EXTRACT_GPIOINT(hwirq);
> > > > +             hwirq =3D TINT_EXTRACT_HWIRQ(hwirq);
> > > > +
> > > > +             if (hwirq < IRQC_TINT_START)
> > > > +                     return -EINVAL;
> > > > +     }
> > > > +
> > > > +     if (hwirq > (IRQC_NUM_IRQ - 1))
> > > > +             return -EINVAL;
> > > > +
> > > > +     chip_data =3D kzalloc(sizeof(*chip_data), GFP_KERNEL);
> > >
> > > Are we really allocating an unsigned long for something that already
> > > fits in something that is pointer-sized?
> > >
> > I think I received some feedback to use unsigned long.  Let me know
> > what you want me to use here.
>
> I think this is just a waste of memory, but I don't really care.
>
Is there any better way I can handle it?

> >
> > > > +     if (!chip_data)
> > > > +             return -ENOMEM;
> > > > +     *chip_data =3D tint;
> > >
> > > So here, *chip_data can be set to -EINVAL if hwirq <=3D IRQC_IRQ_COUN=
T?
> > > This can't be right.
> > >
> > Yes *chip_data can be -EINVAL. IRQC block handles IRQ0-7 and
> > GPIOINT0-122. So the -EINVAL here is for IRQ0-7 case were dont
> > required the chip data in the call backs hence -EINVAL, Whereas for
> > GPIOINT0-122 we need chip_data in the callbacks as this value needs to
> > be programmed in the hardware registers.
>
> I can't see anything that checks it (let alone the difference in
> types). And if it isn't checked, this means that the allocation is
> pointless.
>
There are checks for example below:

static void rzg2l_irqc_irq_enable(struct irq_data *d)
{
    unsigned int hw_irq =3D irqd_to_hwirq(d);

    if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
        struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
        unsigned long chip_data =3D *(unsigned long *)d->chip_data;
        u32 offset =3D hw_irq - IRQC_TINT_START;
        u32 tssr_offset =3D TSSR_OFFSET(offset);
        u8 tssr_index =3D TSSR_INDEX(offset);
        u32 reg;

        raw_spin_lock(&priv->lock);
        reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
        reg |=3D (TIEN | chip_data) << TSSEL_SHIFT(tssr_offset);
        writel_relaxed(reg, priv->base + TSSR(tssr_index));
        raw_spin_unlock(&priv->lock);
    }
    irq_chip_enable_parent(d);
}

This check hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ here
would mean its GPIOINT0-122 and then the chip data will be used.

> >
> > > > +
> > > > +     ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &i=
rqc_chip,
> > > > +                                         chip_data);
> > > > +     if (ret) {
> > > > +             kfree(chip_data);
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     spec.fwnode =3D domain->parent->fwnode;
> > > > +     spec.param_count =3D priv->map[hwirq].args_count;
> > > > +     for (i =3D 0; i < spec.param_count; i++)
> > > > +             spec.param[i] =3D priv->map[hwirq].args[i];
> > >
> > > Why isn't that simply:
> > >
> > >         spec =3D priv->map[hwirq];
> > >
> > spec is of type =E2=80=98struct irq_fwspec=E2=80=99 and map is of type =
=E2=80=98struct of_phandle_args=E2=80=99.
> >
> > > as this really is the interrupt you want to map to?
> > >
> > Yes.
> >
> > > > +
> > > > +     ret =3D irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &=
spec);
> > >
> > > or even better:
> > >
> > >         ret =3D irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
> > >                                            &priv->map[hwirq]);
> > >
> > Does not work as map is of type =E2=80=98struct of_phandle_args=E2=80=
=99.
>
> Which begs the question: why don't you convert it to an irq_fwspec the
> first place and be done with it?
>
Right..
> >
> > > > +     if (ret)
> > > > +             kfree(chip_data);
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static void rzg2l_irqc_domain_free(struct irq_domain *domain, unsi=
gned int virq,
> > > > +                                unsigned int nr_irqs)
> > > > +{
> > > > +     struct irq_data *d;
> > > > +
> > > > +     d =3D irq_domain_get_irq_data(domain, virq);
> > > > +     if (d)
> > > > +             kfree(d->chip_data);
> > > > +
> > > > +     irq_domain_free_irqs_common(domain, virq, nr_irqs);
> > > > +}
> > > > +
> > > > +static const struct irq_domain_ops rzg2l_irqc_domain_ops =3D {
> > > > +     .alloc =3D rzg2l_irqc_alloc,
> > > > +     .free =3D rzg2l_irqc_domain_free,
> > > > +     .translate =3D irq_domain_translate_twocell,
> > > > +};
> > > > +
> > > > +static int rzg2l_irqc_parse_map(struct rzg2l_irqc_priv *priv,
> > > > +                             struct device_node *np)
>
> nit: this function could afford being renamed to something more
> correct. It really doesn't map anything, only retrieves the output
> interrupts.
>
Sure will do.

> > > > +{
> > > > +     unsigned int i;
> > > > +     int ret;
> > > > +
> > > > +     for (i =3D 0; i < IRQC_NUM_IRQ; i++) {
> > > > +             ret =3D of_irq_parse_one(np, i, &priv->map[i]);
>
> Make map an array of irq_fwspec, and use of_phandle_args_to_fwspec()
> for the conversion.
>
... Good point, will do.

> > > > +             if (ret)
> > > > +                     return ret;
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int rzg2l_irqc_init(struct device_node *node, struct device=
_node *parent)
> > > > +{
> > > > +     struct irq_domain *irq_domain, *parent_domain;
> > > > +     struct platform_device *pdev;
> > > > +     struct reset_control *resetn;
> > > > +     struct rzg2l_irqc_priv *priv;
> > > > +     int ret;
> > > > +
> > > > +     pdev =3D of_find_device_by_node(node);
> > > > +     if (!pdev)
> > > > +             return -ENODEV;
> > > > +
> > > > +     parent_domain =3D irq_find_host(parent);
> > > > +     if (!parent_domain) {
> > > > +             dev_err(&pdev->dev, "cannot find parent domain\n");
> > > > +             return -ENODEV;
> > > > +     }
> > > > +
> > > > +     priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > > > +     if (!priv)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     priv->base =3D devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0=
, NULL);
> > > > +     if (IS_ERR(priv->base))
> > > > +             return PTR_ERR(priv->base);
> > > > +
> > > > +     ret =3D rzg2l_irqc_parse_map(priv, node);
> > > > +     if (ret) {
> > > > +             dev_err(&pdev->dev, "cannot parse interrupts: %d\n", =
ret);
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     resetn =3D devm_reset_control_get_exclusive_by_index(&pdev->d=
ev, 0);
> > > > +     if (IS_ERR(resetn))
> > > > +             return IS_ERR(resetn);
> > > > +
> > > > +     ret =3D reset_control_deassert(resetn);
> > > > +     if (ret) {
> > > > +             dev_err(&pdev->dev, "failed to deassert resetn pin, %=
d\n", ret);
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     pm_runtime_enable(&pdev->dev);
> > > > +     ret =3D pm_runtime_resume_and_get(&pdev->dev);
> > > > +     if (ret < 0) {
> > > > +             dev_err(&pdev->dev, "pm_runtime_resume_and_get failed=
: %d\n", ret);
> > > > +             goto pm_disable;
> > > > +     }
> > >
> > > If using runtime PM, why isn't the core IRQ code made aware of this
> > > dependency by registering the device with irq_domain_set_pm_device()
> > > instead of leaving it enabled forever?
> > >
> > Ouch will add irq_domain_set_pm_device() below.
>
> You'll need a bit more than that. You'll either need to take a PM
> reference on each alloc, or improve irq_chip_pm_{get,put}() to talk
> the hierarchy.
>
Aha I see.

> That's probably a separate patch.
>
Agreed will make it a separate patch, once the driver gets in.


Cheers,
Prabhakar

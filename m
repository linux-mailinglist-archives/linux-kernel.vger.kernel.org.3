Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC864EA69D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 06:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiC2Edm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 00:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiC2Edk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 00:33:40 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0535832044;
        Mon, 28 Mar 2022 21:31:58 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n63-20020a1c2742000000b0038d0c31db6eso711187wmn.1;
        Mon, 28 Mar 2022 21:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M6q0ziPfO+aI8ZFi1uzU1SciRFsF3Dbngun8DDFrbXw=;
        b=hzpSSofFNoXc98hBPOpon5UCPE1T5YNufpGDTtxX9Atd4L8cDackUS+6WLQXPK8TNO
         I27Fb8TU5EWDotTxIbtvQHz6Gx7PDzCkXyXlTxEhUCyjfggx1nP9xcjYodlb1qZnIXEX
         3Pj7LYir4y2v/0ch6kTYKD/A53kijDbFtjyxsDveJBlmQTFf+QQOsCZE7b2GkKzo8E3U
         uMHb7ucpS+0EWJN3d3M036J5VputrI2ECwGaXrCzjOV/IOEb8Pihn7hsK087e/JzlesE
         bXXBMT1xYiQDm6xnrYGQwJvH+q9GamzVmkmPoYWU0iVnw+t7NOb5rA0VRmp7rWRxpLkE
         9slQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M6q0ziPfO+aI8ZFi1uzU1SciRFsF3Dbngun8DDFrbXw=;
        b=2Tp+y5NUeRXDmYjsvBdYmeE4gwBkm4rmMtWoLYGWw/oAwCc8CpiSCN0UswpnB0Zwtz
         C2KEjF6YDMFIU3c5YQB9U+SIoV+BZjd1xqdIZ7eWWoAvInmxRhUAzXEFcRIoaSNX1cZz
         fZuSxePPJ3wLmtL+lcjbphcO48imrhUfxNDcZ3POksIR/4zJ5PS5FICrN948PEzI4FSQ
         pmycBgxxiumiuNdULmB0ikJOoDivKNtQu0nEfcwU37b3TN2HBEReEke+Pnc2A84zIs22
         bin9s/3Vo1wCa4nvC64q/jh/HeOD7uHNSmMOmR9k3KYPxU3yQ4vJcBvNZLiw1BVC6EwV
         xMSg==
X-Gm-Message-State: AOAM533NREb7c1l6Po2XvekNVeiaTEyDr2E5lDa8Mbd4clI5SN7cI5SG
        /FMQX/FI6/qTqHlsXmR+Oi1jv+eBOYKmtxq6D8o=
X-Google-Smtp-Source: ABdhPJyGCItzRoYc5wfGtuXFL3PNtrpS4XqPRp3sPlge5FqpimmYPbhCyx5vRKRLPraXCbVmjuxQHQLRavEPkSgDCXg=
X-Received: by 2002:a05:600c:5029:b0:38c:9768:b4c with SMTP id
 n41-20020a05600c502900b0038c97680b4cmr3886589wmr.123.1648528316414; Mon, 28
 Mar 2022 21:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220311164628.378849-1-gengcixi@gmail.com> <20220311164628.378849-4-gengcixi@gmail.com>
 <CADBw62pAitwJK6cf_zMo-N=-NGf3Y5S9SPBRcLpbz5yzNefQOQ@mail.gmail.com>
In-Reply-To: <CADBw62pAitwJK6cf_zMo-N=-NGf3Y5S9SPBRcLpbz5yzNefQOQ@mail.gmail.com>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Tue, 29 Mar 2022 12:31:20 +0800
Message-ID: <CAF12kFs-=s5Rj42gSfVHYRQ30m2m_gdmAjBmB0cdb7VMS5evjw@mail.gmail.com>
Subject: Re: [PATCH V2 3/7] iio: adc: sc27xx: structure adjuststment and optimization
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?5pyx546J5piOIChZdW1pbmcgWmh1LzExNDU3KQ==?= 
        <yuming.zhu1@unisoc.com>, linux-iio@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Baolin Wang <baolin.wang7@gmail.com> =E4=BA=8E2022=E5=B9=B43=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=B8=89 21:55=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Mar 12, 2022 at 12:47 AM Cixi Geng <gengcixi@gmail.com> wrote:
> >
> > From: Cixi Geng <cixi.geng1@unisoc.com>
> >
> > Introduce one variant device data structure to be compatible
> > with SC2731 PMIC since it has different scale and ratio calculation
> > and so on.
> >
> > Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > ---
> >  drivers/iio/adc/sc27xx_adc.c | 95 ++++++++++++++++++++++++++++++------
> >  1 file changed, 80 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.=
c
> > index aee076c8e2b1..68629fbcfec5 100644
> > --- a/drivers/iio/adc/sc27xx_adc.c
> > +++ b/drivers/iio/adc/sc27xx_adc.c
> > @@ -12,9 +12,9 @@
> >  #include <linux/slab.h>
> >
> >  /* PMIC global registers definition */
> > -#define SC27XX_MODULE_EN               0xc08
> > +#define SC2731_MODULE_EN               0xc08
> >  #define SC27XX_MODULE_ADC_EN           BIT(5)
> > -#define SC27XX_ARM_CLK_EN              0xc10
> > +#define SC2731_ARM_CLK_EN              0xc10
> >  #define SC27XX_CLK_ADC_EN              BIT(5)
> >  #define SC27XX_CLK_ADC_CLK_EN          BIT(6)
> >
> > @@ -78,6 +78,23 @@ struct sc27xx_adc_data {
> >         int channel_scale[SC27XX_ADC_CHANNEL_MAX];
> >         u32 base;
> >         int irq;
> > +       const struct sc27xx_adc_variant_data *var_data;
> > +};
> > +
> > +/*
> > + * Since different PMICs of SC27xx series can have different
> > + * address and ratio, we should save ratio config and base
> > + * in the device data structure.
> > + */
> > +struct sc27xx_adc_variant_data {
> > +       u32 module_en;
> > +       u32 clk_en;
> > +       u32 scale_shift;
> > +       u32 scale_mask;
> > +       const struct sc27xx_adc_linear_graph *bscale_cal;
> > +       const struct sc27xx_adc_linear_graph *sscale_cal;
> > +       void (*init_scale)(struct sc27xx_adc_data *data);
> > +       int (*get_ratio)(int channel, int scale);
> >  };
> >
> >  struct sc27xx_adc_linear_graph {
> > @@ -103,6 +120,17 @@ static struct sc27xx_adc_linear_graph small_scale_=
graph =3D {
> >         100, 341,
> >  };
> >
> > +/* Add these for sc2731 pmic, and the [big|small]_scale_graph_calib fo=
r common's */
> > +static const struct sc27xx_adc_linear_graph sc2731_big_scale_graph_cal=
ib =3D {
> > +       4200, 850,
> > +       3600, 728,
> > +};
> > +
> > +static const struct sc27xx_adc_linear_graph sc2731_small_scale_graph_c=
alib =3D {
> > +       1000, 838,
> > +       100, 84,
> > +};
> > +
> >  static const struct sc27xx_adc_linear_graph big_scale_graph_calib =3D =
{
> >         4200, 856,
> >         3600, 733,
> > @@ -130,11 +158,11 @@ static int sc27xx_adc_scale_calibration(struct sc=
27xx_adc_data *data,
> >         size_t len;
> >
> >         if (big_scale) {
> > -               calib_graph =3D &big_scale_graph_calib;
> > +               calib_graph =3D data->var_data->bscale_cal;
> >                 graph =3D &big_scale_graph;
> >                 cell_name =3D "big_scale_calib";
> >         } else {
> > -               calib_graph =3D &small_scale_graph_calib;
> > +               calib_graph =3D data->var_data->sscale_cal;
>
> Now which function will use big_scale_graph_calib and
> small_scale_graph_calib?  Seems you add an unused warning?
yes, it is a unused, since these calibs used for sc2730 and sc2720
I will remove in this patch and add in patch4/7.
>
> >                 graph =3D &small_scale_graph;
> >                 cell_name =3D "small_scale_calib";
> >         }
> > @@ -160,7 +188,7 @@ static int sc27xx_adc_scale_calibration(struct sc27=
xx_adc_data *data,
> >         return 0;
> >  }
> >
> > -static int sc27xx_adc_get_ratio(int channel, int scale)
> > +static int sc2731_adc_get_ratio(int channel, int scale)
> >  {
> >         switch (channel) {
> >         case 1:
> > @@ -185,6 +213,21 @@ static int sc27xx_adc_get_ratio(int channel, int s=
cale)
> >         return SC27XX_VOLT_RATIO(1, 1);
> >  }
> >
> > +/*
> > + * According to the datasheet set specific value on some channel.
> > + */
> > +static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
> > +               if (i =3D=3D 5)
> > +                       data->channel_scale[i] =3D 1;
>
> Can you add some comments to explain why channel 5 needs to set scale to =
1?
In the current software design, SC2731 supports 2 scales, channel 5
uses big scale, others use smale
I will add the comment in next version.
>
> > +               else
> > +                       data->channel_scale[i] =3D 0;
> > +       }
> > +}
> > +
> >  static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
> >                            int scale, int *val)
> >  {
> > @@ -208,10 +251,11 @@ static int sc27xx_adc_read(struct sc27xx_adc_data=
 *data, int channel,
> >                 goto disable_adc;
> >
> >         /* Configure the channel id and scale */
> > -       tmp =3D (scale << SC27XX_ADC_SCALE_SHIFT) & SC27XX_ADC_SCALE_MA=
SK;
> > +       tmp =3D (scale << data->var_data->scale_shift) & data->var_data=
->scale_mask;
> >         tmp |=3D channel & SC27XX_ADC_CHN_ID_MASK;
> >         ret =3D regmap_update_bits(data->regmap, data->base + SC27XX_AD=
C_CH_CFG,
> > -                                SC27XX_ADC_CHN_ID_MASK | SC27XX_ADC_SC=
ALE_MASK,
> > +                                SC27XX_ADC_CHN_ID_MASK |
> > +                                data->var_data->scale_mask,
> >                                  tmp);
> >         if (ret)
> >                 goto disable_adc;
> > @@ -262,8 +306,9 @@ static void sc27xx_adc_volt_ratio(struct sc27xx_adc=
_data *data,
> >                                   int channel, int scale,
> >                                   u32 *div_numerator, u32 *div_denomina=
tor)
> >  {
> > -       u32 ratio =3D sc27xx_adc_get_ratio(channel, scale);
> > +       u32 ratio;
> >
> > +       ratio =3D data->var_data->get_ratio(channel, scale);
> >         *div_numerator =3D ratio >> SC27XX_RATIO_NUMERATOR_OFFSET;
> >         *div_denominator =3D ratio & SC27XX_RATIO_DENOMINATOR_MASK;
> >  }
> > @@ -432,13 +477,13 @@ static int sc27xx_adc_enable(struct sc27xx_adc_da=
ta *data)
> >  {
> >         int ret;
> >
> > -       ret =3D regmap_update_bits(data->regmap, SC27XX_MODULE_EN,
> > +       ret =3D regmap_update_bits(data->regmap, data->var_data->module=
_en,
> >                                  SC27XX_MODULE_ADC_EN, SC27XX_MODULE_AD=
C_EN);
> >         if (ret)
> >                 return ret;
> >
> >         /* Enable ADC work clock and controller clock */
> > -       ret =3D regmap_update_bits(data->regmap, SC27XX_ARM_CLK_EN,
> > +       ret =3D regmap_update_bits(data->regmap, data->var_data->clk_en=
,
> >                                  SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK=
_EN,
> >                                  SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK=
_EN);
> >         if (ret)
> > @@ -456,10 +501,10 @@ static int sc27xx_adc_enable(struct sc27xx_adc_da=
ta *data)
> >         return 0;
> >
> >  disable_clk:
> > -       regmap_update_bits(data->regmap, SC27XX_ARM_CLK_EN,
> > +       regmap_update_bits(data->regmap, data->var_data->clk_en,
> >                            SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN, 0=
);
> >  disable_adc:
> > -       regmap_update_bits(data->regmap, SC27XX_MODULE_EN,
> > +       regmap_update_bits(data->regmap, data->var_data->module_en,
> >                            SC27XX_MODULE_ADC_EN, 0);
> >
> >         return ret;
> > @@ -470,21 +515,39 @@ static void sc27xx_adc_disable(void *_data)
> >         struct sc27xx_adc_data *data =3D _data;
> >
> >         /* Disable ADC work clock and controller clock */
> > -       regmap_update_bits(data->regmap, SC27XX_ARM_CLK_EN,
> > +       regmap_update_bits(data->regmap, data->var_data->clk_en,
> >                            SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN, 0=
);
> >
> > -       regmap_update_bits(data->regmap, SC27XX_MODULE_EN,
> > +       regmap_update_bits(data->regmap, data->var_data->module_en,
> >                            SC27XX_MODULE_ADC_EN, 0);
> >  }
> >
> > +static const struct sc27xx_adc_variant_data sc2731_data =3D {
> > +       .module_en =3D SC2731_MODULE_EN,
> > +       .clk_en =3D SC2731_ARM_CLK_EN,
> > +       .scale_shift =3D SC27XX_ADC_SCALE_SHIFT,
> > +       .scale_mask =3D SC27XX_ADC_SCALE_MASK,
> > +       .bscale_cal =3D &sc2731_big_scale_graph_calib,
> > +       .sscale_cal =3D &sc2731_small_scale_graph_calib,
> > +       .init_scale =3D sc2731_adc_scale_init,
> > +       .get_ratio =3D sc2731_adc_get_ratio,
> > +};
> > +
> >  static int sc27xx_adc_probe(struct platform_device *pdev)
> >  {
> >         struct device *dev =3D &pdev->dev;
> >         struct device_node *np =3D dev->of_node;
> >         struct sc27xx_adc_data *sc27xx_data;
> > +       const struct sc27xx_adc_variant_data *pdata;
> >         struct iio_dev *indio_dev;
> >         int ret;
> >
> > +       pdata =3D of_device_get_match_data(dev);
> > +       if (!pdata) {
> > +               dev_err(dev, "No matching driver data found\n");
> > +               return -EINVAL;
> > +       }
> > +
> >         indio_dev =3D devm_iio_device_alloc(dev, sizeof(*sc27xx_data));
> >         if (!indio_dev)
> >                 return -ENOMEM;
> > @@ -520,6 +583,8 @@ static int sc27xx_adc_probe(struct platform_device =
*pdev)
> >         }
> >
> >         sc27xx_data->dev =3D dev;
> > +       sc27xx_data->var_data =3D pdata;
> > +       sc27xx_data->var_data->init_scale(sc27xx_data);
> >
> >         ret =3D sc27xx_adc_enable(sc27xx_data);
> >         if (ret) {
> > @@ -546,7 +611,7 @@ static int sc27xx_adc_probe(struct platform_device =
*pdev)
> >  }
> >
> >  static const struct of_device_id sc27xx_adc_of_match[] =3D {
> > -       { .compatible =3D "sprd,sc2731-adc", },
> > +       { .compatible =3D "sprd,sc2731-adc", .data =3D &sc2731_data},
> >         { }
> >  };
> >  MODULE_DEVICE_TABLE(of, sc27xx_adc_of_match);
> > --
> > 2.25.1
> >
>
>
> --
> Baolin Wang

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F2D497A05
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242050AbiAXIHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbiAXIHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:07:36 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14399C06173B;
        Mon, 24 Jan 2022 00:07:36 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id i67so1347964wma.0;
        Mon, 24 Jan 2022 00:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IQyuoyAjn/3wnjleMO1fKTfmVMZ//kX3WpenfwhdQ+Q=;
        b=hUpsGt9ymnkI/AxNgOljMYzNT6vLangFj0ZRKSTmPXZcV94YAFpN+1Vtkm9yVFzS+M
         frdxdiRARclmW1sXd3LmydJ1ON2a85UKm0sUjBA3FUAIUq//Xd9yuBWkuNzCgt6uVCVk
         KA5CHm4gO8C81DSmc3/GtYJ46O3Y2TPqEE3DO31OmaBW0/GHfU3Xl1rkEs+nHEomthHh
         llHyvMT5a13OwJTxDUS8hgZWq8yMzJBrIwMMvPUSh6irSgjP2lCibdD4irfxe0x+0+pf
         MilvlAi1PZZj3dzyzGl7bVp1AYF8rFCfttlbfwz47FALIPBbYV37Os2yfjVQvY5fR5HM
         rhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IQyuoyAjn/3wnjleMO1fKTfmVMZ//kX3WpenfwhdQ+Q=;
        b=6xK0pOHsSHWnifUbPzga9h/X/nGXx45MvER9t91C/qiMxXeJXQtyHbhjz+eQoBTCme
         ggeqK6JHlPpHS00ht/6UaxuWj+He8jGSMbi/Pct3KgPG3HI1GfNwfvos7zU01E2YpEdZ
         noSgb67aELWHsAg/A8ZFe0olas6nEzuAnOduIutQmDN+V2DzikZehorHV2bJuuZ7EXUo
         neH+kornnHei54IUhf6w6iXh2ycmSuMGT60vilQlUh8vubTNL1zQtsq8rhn9IoAhHCeD
         uEilaSTRCD7DUHSL63OE9dR/PWXNO0WJ0Fps3Cd3LUOqKiWwpxAvIoVYDP7VZ9Xn50vK
         fxXw==
X-Gm-Message-State: AOAM531h66QTk3npsb/nBYHTZ5Ss52hafZXTLPmbF1LPO/xl0BuaQNaU
        HBeofigRL+nM/ON9HBRixU9HNR8fWDZhO/AKCtjsnrEZ+Xw=
X-Google-Smtp-Source: ABdhPJzBWgOyq5fcOqLBNzKDVqnz6kg6sCApziJLKCTdO7kOegqYUGJjRBOkso4fQGDZggX/w9RHdGxqOdwHJ8twHwM=
X-Received: by 2002:a05:600c:1e0e:: with SMTP id ay14mr673702wmb.77.1643011654496;
 Mon, 24 Jan 2022 00:07:34 -0800 (PST)
MIME-Version: 1.0
References: <20220106125947.139523-1-gengcixi@gmail.com> <20220106125947.139523-4-gengcixi@gmail.com>
 <CADBw62pBCdrbRspTV9Yck4DP8DE=ECGmEtD74NOtm1YRT3DM8w@mail.gmail.com>
 <CAF12kFu6O-gfiqp4j24zxC_GqCwJ2Q5KGYYaCtnagmUFB_bsVg@mail.gmail.com> <CADBw62rSdWN-L8HbnyMrUNp=x0pDdKR6MyKO4yfu00MnrN4L-g@mail.gmail.com>
In-Reply-To: <CADBw62rSdWN-L8HbnyMrUNp=x0pDdKR6MyKO4yfu00MnrN4L-g@mail.gmail.com>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Mon, 24 Jan 2022 16:06:58 +0800
Message-ID: <CAF12kFvUfykKfeRAJACFRk31pmEBQEPw402x0JN4i1uv0EK1zg@mail.gmail.com>
Subject: Re: [PATCH 3/7] iio: adc: sc27xx: structure adjuststment and optimization
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, jic23@kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?5pyx546J5piOIChZdW1pbmcgWmh1LzExNDU3KQ==?= 
        <yuming.zhu1@unisoc.com>, linux-iio@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang7@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8817=E6=
=97=A5=E5=91=A8=E4=B8=80 14:15=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jan 13, 2022 at 9:54 AM Cixi Geng <gengcixi@gmail.com> wrote:
> >
> > Baolin Wang <baolin.wang7@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=887=
=E6=97=A5=E5=91=A8=E4=BA=94 15:03=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Thu, Jan 6, 2022 at 9:00 PM Cixi Geng <gengcixi@gmail.com> wrote:
> > > >
> > > > From: Cixi Geng <cixi.geng1@unisoc.com>
> > > >
> > > > Introduce one variant device data structure to be compatible
> > > > with SC2731 PMIC since it has different scale and ratio calculation
> > > > and so on.
> > > >
> > > > Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> > > > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > > > ---
> > > >  drivers/iio/adc/sc27xx_adc.c | 94 ++++++++++++++++++++++++++++++--=
----
> > > >  1 file changed, 79 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_=
adc.c
> > > > index aee076c8e2b1..d2712e54ee79 100644
> > > > --- a/drivers/iio/adc/sc27xx_adc.c
> > > > +++ b/drivers/iio/adc/sc27xx_adc.c
> > > > @@ -12,9 +12,9 @@
> > > >  #include <linux/slab.h>
> > > >
> > > >  /* PMIC global registers definition */
> > > > -#define SC27XX_MODULE_EN               0xc08
> > > > +#define SC2731_MODULE_EN               0xc08
> > > >  #define SC27XX_MODULE_ADC_EN           BIT(5)
> > > > -#define SC27XX_ARM_CLK_EN              0xc10
> > > > +#define SC2731_ARM_CLK_EN              0xc10
> > > >  #define SC27XX_CLK_ADC_EN              BIT(5)
> > > >  #define SC27XX_CLK_ADC_CLK_EN          BIT(6)
> > > >
> > > > @@ -78,6 +78,23 @@ struct sc27xx_adc_data {
> > > >         int channel_scale[SC27XX_ADC_CHANNEL_MAX];
> > > >         u32 base;
> > > >         int irq;
> > > > +       const struct sc27xx_adc_variant_data *var_data;
> > > > +};
> > > > +
> > > > +/*
> > > > + * Since different PMICs of SC27xx series can have different
> > > > + * address and ratio, we should save ratio config and base
> > > > + * in the device data structure.
> > > > + */
> > > > +struct sc27xx_adc_variant_data {
> > > > +       u32 module_en;
> > > > +       u32 clk_en;
> > > > +       u32 scale_shift;
> > > > +       u32 scale_mask;
> > > > +       const struct sc27xx_adc_linear_graph *bscale_cal;
> > > > +       const struct sc27xx_adc_linear_graph *sscale_cal;
> > > > +       void (*init_scale)(struct sc27xx_adc_data *data);
> > > > +       int (*get_ratio)(int channel, int scale);
> > > >  };
> > > >
> > > >  struct sc27xx_adc_linear_graph {
> > > > @@ -103,6 +120,16 @@ static struct sc27xx_adc_linear_graph small_sc=
ale_graph =3D {
> > > >         100, 341,
> > > >  };
> > > >
> > > > +static const struct sc27xx_adc_linear_graph sc2731_big_scale_graph=
_calib =3D {
> > > > +       4200, 850,
> > > > +       3600, 728,
> > > > +};
> > > > +
> > > > +static const struct sc27xx_adc_linear_graph sc2731_small_scale_gra=
ph_calib =3D {
> > > > +       1000, 838,
> > > > +       100, 84,
> > > > +};
> > >
> > > The original big_scale_graph_calib and small_scale_graph_calib are fo=
r
> > > SC2731 PMIC, why add new structure definition for SC2731?
> > >
> > > > +
> > > >  static const struct sc27xx_adc_linear_graph big_scale_graph_calib =
=3D {
> > > >         4200, 856,
> > > >         3600, 733,
> > > > @@ -130,11 +157,11 @@ static int sc27xx_adc_scale_calibration(struc=
t sc27xx_adc_data *data,
> > > >         size_t len;
> > > >
> > > >         if (big_scale) {
> > > > -               calib_graph =3D &big_scale_graph_calib;
> > > > +               calib_graph =3D data->var_data->bscale_cal;
> > > >                 graph =3D &big_scale_graph;
> > > >                 cell_name =3D "big_scale_calib";
> > > >         } else {
> > > > -               calib_graph =3D &small_scale_graph_calib;
> > > > +               calib_graph =3D data->var_data->sscale_cal;
> > > >                 graph =3D &small_scale_graph;
> > > >                 cell_name =3D "small_scale_calib";
> > > >         }
> > > > @@ -160,7 +187,7 @@ static int sc27xx_adc_scale_calibration(struct =
sc27xx_adc_data *data,
> > > >         return 0;
> > > >  }
> > > >
> > > > -static int sc27xx_adc_get_ratio(int channel, int scale)
> > > > +static int sc2731_adc_get_ratio(int channel, int scale)
> > > >  {
> > > >         switch (channel) {
> > > >         case 1:
> > > > @@ -185,6 +212,21 @@ static int sc27xx_adc_get_ratio(int channel, i=
nt scale)
> > > >         return SC27XX_VOLT_RATIO(1, 1);
> > > >  }
> > > >
> > > > +/*
> > > > + * According to the datasheet set specific value on some channel.
> > > > + */
> > > > +static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
> > > > +{
> > > > +       int i;
> > > > +
> > > > +       for (i =3D 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
> > > > +               if (i =3D=3D 5)
> > > > +                       data->channel_scale[i] =3D 1;
> > > > +               else
> > > > +                       data->channel_scale[i] =3D 0;
> > > > +       }
> > > > +}
> > >
> > > This is unnecessary I think, please see sc27xx_adc_write_raw() that
> > > can set the channel scale.
> > Did you mean that all the PMIC's scale_init function should put into
> > the sc27xx_adc_write_raw?
>
> No.
>
> > but the scale_init is all different by each PMIC, if implemented in
> > the write_raw, will add a lot of
> > if or switch_case branch
>
> What I mean is we should follow the original method to set the channel
> scale by iio_info. Please also refer to other drivers how ot handle
> the channel scale.
Hi Baolin,  I understand the adc_write_raw() function is the method to set
channal scale for the userspace, we can change the channel scale by write
a value on a user code. did i understand right?
out  scale_init is to set scale value when the driver probe stage, and I al=
so
did not found other adc driver use the adc_write_raw() during the driver
 initialization phase.
>
> --
> Baolin Wang

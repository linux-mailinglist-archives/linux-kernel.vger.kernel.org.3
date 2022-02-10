Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D754B07BE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbiBJIHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:07:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236986AbiBJIHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:07:44 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4FDDA9;
        Thu, 10 Feb 2022 00:07:46 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id r14so4366177qtt.5;
        Thu, 10 Feb 2022 00:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TVYSg+OxTjVaNAgB6NwlM5J+eE/fcNTtaPofr5yQvvQ=;
        b=l0RKS81b03BokBAd4vJnF9HmwulKS1SgRTG8WQpcrfgm51WesanjdivSm8RU/74SLG
         HGK0FperYZpRC/H2vpJG70bDRjkb/4nq4yYyboM8mtg3PUpYtG3N2ANnjm1uCwX4xa1Q
         uqW0b7HVXZbFxfTYnEM6RopwDPPfjnHPqDg+c6DV2bFFKREoF2C/gwGUjCb5yd+qQnq/
         QKvkFHHroN2lfGuOIGoqcIEj/QkVc2Dg/tfbV4q1nWuC+dUM8PA1JRTVHyGrLJWHBRZi
         xkuefX3iiKhFL+PC+LsMq9f2CA/TW7poY/dQ1FWIwtE51A72V6/pqZH5TZbCqan7UQMs
         Udzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TVYSg+OxTjVaNAgB6NwlM5J+eE/fcNTtaPofr5yQvvQ=;
        b=xUDO2vSnkSek/TCtptRP6VDM4v4QNKINtOT3/54Ko2wruTS9rid/Tp8jl86BWa5W6h
         quD2vvM+fhRWCuDhOcZwqXG+XHo+dDJtKrj2o00nNUE8/jw9FfUzOpC6ypBFMZx68+7Z
         ohXjKb3WITwnhmMJbvztpGJHj5znUSVHpeRHb1Skhbc5WZjDQCwWiYTTfvVm2ViMeKM2
         ovCRpIW+Kz+gHKygRCk2CiXUZzncd3QFNhwNHFNpG6FJx8QZNrxdrAph4np8UTYEtDno
         BuxGuM+nm8tl6HyXSxS4ARGis14ocuU814mpBj1bJ9RONfb3L2A5l9qX/kDnbz7YnDnK
         X1zA==
X-Gm-Message-State: AOAM5336UFmD5bc+bdtGIwKoCdEKwVhtw5LLT77QVD2l24ONfWsAazBV
        G+jUmsBuQXuXHtqrTvL9lHI0tqq3ApOsx/anLTpWBDpfrbc=
X-Google-Smtp-Source: ABdhPJwURy17wsQBDLIi72pX2fqdF0ejSN/LaUS/vt6CgjrIO5Q1MbvgI5n72abAGLInLv/vDoY35jPr8XLpZUrXD7c=
X-Received: by 2002:a05:622a:5ce:: with SMTP id d14mr3937765qtb.624.1644480465287;
 Thu, 10 Feb 2022 00:07:45 -0800 (PST)
MIME-Version: 1.0
References: <20220106125947.139523-1-gengcixi@gmail.com> <20220106125947.139523-4-gengcixi@gmail.com>
 <CADBw62pBCdrbRspTV9Yck4DP8DE=ECGmEtD74NOtm1YRT3DM8w@mail.gmail.com>
 <CAF12kFu6O-gfiqp4j24zxC_GqCwJ2Q5KGYYaCtnagmUFB_bsVg@mail.gmail.com>
 <CADBw62rSdWN-L8HbnyMrUNp=x0pDdKR6MyKO4yfu00MnrN4L-g@mail.gmail.com> <CAF12kFvUfykKfeRAJACFRk31pmEBQEPw402x0JN4i1uv0EK1zg@mail.gmail.com>
In-Reply-To: <CAF12kFvUfykKfeRAJACFRk31pmEBQEPw402x0JN4i1uv0EK1zg@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Thu, 10 Feb 2022 16:08:35 +0800
Message-ID: <CADBw62pmtbzr78c9J20cFbNRuTrntGg_E8TH_g=LciCVGYrYqQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] iio: adc: sc27xx: structure adjuststment and optimization
To:     Cixi Geng <gengcixi@gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 4:07 PM Cixi Geng <gengcixi@gmail.com> wrote:
>
> Baolin Wang <baolin.wang7@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8817=
=E6=97=A5=E5=91=A8=E4=B8=80 14:15=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, Jan 13, 2022 at 9:54 AM Cixi Geng <gengcixi@gmail.com> wrote:
> > >
> > > Baolin Wang <baolin.wang7@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=88=
7=E6=97=A5=E5=91=A8=E4=BA=94 15:03=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Thu, Jan 6, 2022 at 9:00 PM Cixi Geng <gengcixi@gmail.com> wrote=
:
> > > > >
> > > > > From: Cixi Geng <cixi.geng1@unisoc.com>
> > > > >
> > > > > Introduce one variant device data structure to be compatible
> > > > > with SC2731 PMIC since it has different scale and ratio calculati=
on
> > > > > and so on.
> > > > >
> > > > > Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> > > > > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > > > > ---
> > > > >  drivers/iio/adc/sc27xx_adc.c | 94 ++++++++++++++++++++++++++++++=
------
> > > > >  1 file changed, 79 insertions(+), 15 deletions(-)
> > > > >
> > > > > diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27x=
x_adc.c
> > > > > index aee076c8e2b1..d2712e54ee79 100644
> > > > > --- a/drivers/iio/adc/sc27xx_adc.c
> > > > > +++ b/drivers/iio/adc/sc27xx_adc.c
> > > > > @@ -12,9 +12,9 @@
> > > > >  #include <linux/slab.h>
> > > > >
> > > > >  /* PMIC global registers definition */
> > > > > -#define SC27XX_MODULE_EN               0xc08
> > > > > +#define SC2731_MODULE_EN               0xc08
> > > > >  #define SC27XX_MODULE_ADC_EN           BIT(5)
> > > > > -#define SC27XX_ARM_CLK_EN              0xc10
> > > > > +#define SC2731_ARM_CLK_EN              0xc10
> > > > >  #define SC27XX_CLK_ADC_EN              BIT(5)
> > > > >  #define SC27XX_CLK_ADC_CLK_EN          BIT(6)
> > > > >
> > > > > @@ -78,6 +78,23 @@ struct sc27xx_adc_data {
> > > > >         int channel_scale[SC27XX_ADC_CHANNEL_MAX];
> > > > >         u32 base;
> > > > >         int irq;
> > > > > +       const struct sc27xx_adc_variant_data *var_data;
> > > > > +};
> > > > > +
> > > > > +/*
> > > > > + * Since different PMICs of SC27xx series can have different
> > > > > + * address and ratio, we should save ratio config and base
> > > > > + * in the device data structure.
> > > > > + */
> > > > > +struct sc27xx_adc_variant_data {
> > > > > +       u32 module_en;
> > > > > +       u32 clk_en;
> > > > > +       u32 scale_shift;
> > > > > +       u32 scale_mask;
> > > > > +       const struct sc27xx_adc_linear_graph *bscale_cal;
> > > > > +       const struct sc27xx_adc_linear_graph *sscale_cal;
> > > > > +       void (*init_scale)(struct sc27xx_adc_data *data);
> > > > > +       int (*get_ratio)(int channel, int scale);
> > > > >  };
> > > > >
> > > > >  struct sc27xx_adc_linear_graph {
> > > > > @@ -103,6 +120,16 @@ static struct sc27xx_adc_linear_graph small_=
scale_graph =3D {
> > > > >         100, 341,
> > > > >  };
> > > > >
> > > > > +static const struct sc27xx_adc_linear_graph sc2731_big_scale_gra=
ph_calib =3D {
> > > > > +       4200, 850,
> > > > > +       3600, 728,
> > > > > +};
> > > > > +
> > > > > +static const struct sc27xx_adc_linear_graph sc2731_small_scale_g=
raph_calib =3D {
> > > > > +       1000, 838,
> > > > > +       100, 84,
> > > > > +};
> > > >
> > > > The original big_scale_graph_calib and small_scale_graph_calib are =
for
> > > > SC2731 PMIC, why add new structure definition for SC2731?
> > > >
> > > > > +
> > > > >  static const struct sc27xx_adc_linear_graph big_scale_graph_cali=
b =3D {
> > > > >         4200, 856,
> > > > >         3600, 733,
> > > > > @@ -130,11 +157,11 @@ static int sc27xx_adc_scale_calibration(str=
uct sc27xx_adc_data *data,
> > > > >         size_t len;
> > > > >
> > > > >         if (big_scale) {
> > > > > -               calib_graph =3D &big_scale_graph_calib;
> > > > > +               calib_graph =3D data->var_data->bscale_cal;
> > > > >                 graph =3D &big_scale_graph;
> > > > >                 cell_name =3D "big_scale_calib";
> > > > >         } else {
> > > > > -               calib_graph =3D &small_scale_graph_calib;
> > > > > +               calib_graph =3D data->var_data->sscale_cal;
> > > > >                 graph =3D &small_scale_graph;
> > > > >                 cell_name =3D "small_scale_calib";
> > > > >         }
> > > > > @@ -160,7 +187,7 @@ static int sc27xx_adc_scale_calibration(struc=
t sc27xx_adc_data *data,
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > -static int sc27xx_adc_get_ratio(int channel, int scale)
> > > > > +static int sc2731_adc_get_ratio(int channel, int scale)
> > > > >  {
> > > > >         switch (channel) {
> > > > >         case 1:
> > > > > @@ -185,6 +212,21 @@ static int sc27xx_adc_get_ratio(int channel,=
 int scale)
> > > > >         return SC27XX_VOLT_RATIO(1, 1);
> > > > >  }
> > > > >
> > > > > +/*
> > > > > + * According to the datasheet set specific value on some channel=
.
> > > > > + */
> > > > > +static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
> > > > > +{
> > > > > +       int i;
> > > > > +
> > > > > +       for (i =3D 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
> > > > > +               if (i =3D=3D 5)
> > > > > +                       data->channel_scale[i] =3D 1;
> > > > > +               else
> > > > > +                       data->channel_scale[i] =3D 0;
> > > > > +       }
> > > > > +}
> > > >
> > > > This is unnecessary I think, please see sc27xx_adc_write_raw() that
> > > > can set the channel scale.
> > > Did you mean that all the PMIC's scale_init function should put into
> > > the sc27xx_adc_write_raw?
> >
> > No.
> >
> > > but the scale_init is all different by each PMIC, if implemented in
> > > the write_raw, will add a lot of
> > > if or switch_case branch
> >
> > What I mean is we should follow the original method to set the channel
> > scale by iio_info. Please also refer to other drivers how ot handle
> > the channel scale.
> Hi Baolin,  I understand the adc_write_raw() function is the method to se=
t
> channal scale for the userspace, we can change the channel scale by write
> a value on a user code. did i understand right?
> out  scale_init is to set scale value when the driver probe stage, and I =
also
> did not found other adc driver use the adc_write_raw() during the driver
>  initialization phase.

Hi Jonathan,

How do you think about the method in this patch to set the channel
scale? Thanks.

--=20
Baolin Wang

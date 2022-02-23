Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2554C1314
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240571AbiBWMrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiBWMrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:47:14 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292A02DD4F;
        Wed, 23 Feb 2022 04:46:46 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v21so4161898wrv.5;
        Wed, 23 Feb 2022 04:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1KDDeL+fAKAGSCPVC1Cy9+urbGEB6jY9aqThbyb4akw=;
        b=SCLOCvUeuahNIq7wkUZVh7DiLmZIs5eeOzZeWGl4Rbv7iWB9EWtmtJPM3unh9QSeNG
         E3+NTqaT0naujpD1WfbaFQ1Dz4GAQQqkrMBUl19N2NBKrlLYAUaru8SfjIT1puJwl75b
         BV94THjh3UCr5MtuqMWLsqe43mNzfN71XUW/4gSTPAklOeWIRKCNhS5ghpykVvWvvHq7
         Xym+4eU9Hy8xpdxzT5HovNM6SvU3gATUQGEJSQ7NZgDh9vG7JjCrbl8snFsJ3R0g0qUg
         Ot8TEvsg5k0OjOj17zBb5Ph0BaIX03QapybrtjMDaAvPWZSph2JvkNy8q408/dCXwcVy
         6/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1KDDeL+fAKAGSCPVC1Cy9+urbGEB6jY9aqThbyb4akw=;
        b=rb9E1uZRZaptFA/CFzPQIK+mrFiSz7Yr3ZWSLMfndF5psgbY3IyIeuF0oGz8Ch7T26
         vRa9NQQQkEsxFBsN3I2sP40/Zul3TO53BJKsxY+H6cpHrTLa0EKiiGAZSvPVU8ESRc9s
         oMfiKHvuvj2h7QX4KRA6nGLnER10GE3HXCp5mEdbkQ/XXs5zdndf+J9TPVG8+FfDO7rq
         h4xQmTxrc3HMnzvQvajty1mbVhnEh+8mxEM+zmY/GqvnsXtsNpd6HnxhJf7rguE9huOV
         32NgYVdEpXw50BLJKuFuCNZwYDnvgLFGGGB5+3BtigiL+6yRhWWwLu9CdZfFspzqEFBO
         54/Q==
X-Gm-Message-State: AOAM532mmyKXB2TcoAys+qFLhN6wWM31lzHR+ck1jIYlcEBZyj5GEkvB
        0WIdgcVhcbVjgRQLiZGVtC4Ye2UX2Qw4MLTyBXw=
X-Google-Smtp-Source: ABdhPJxi2J4xeewLp3yBk5mY6VKE1hfSaGiAzOPNJ6GrTaGBdHbKmli1Gf+H1flitG29iPYzgB8X0lqEThSNE86lnnk=
X-Received: by 2002:a05:6000:2a5:b0:1e8:d9dc:f369 with SMTP id
 l5-20020a05600002a500b001e8d9dcf369mr22144300wry.589.1645620404611; Wed, 23
 Feb 2022 04:46:44 -0800 (PST)
MIME-Version: 1.0
References: <20220106125947.139523-1-gengcixi@gmail.com> <20220106125947.139523-4-gengcixi@gmail.com>
 <CADBw62pBCdrbRspTV9Yck4DP8DE=ECGmEtD74NOtm1YRT3DM8w@mail.gmail.com>
 <CAF12kFu6O-gfiqp4j24zxC_GqCwJ2Q5KGYYaCtnagmUFB_bsVg@mail.gmail.com>
 <CADBw62rSdWN-L8HbnyMrUNp=x0pDdKR6MyKO4yfu00MnrN4L-g@mail.gmail.com>
 <CAF12kFvUfykKfeRAJACFRk31pmEBQEPw402x0JN4i1uv0EK1zg@mail.gmail.com> <CADBw62pmtbzr78c9J20cFbNRuTrntGg_E8TH_g=LciCVGYrYqQ@mail.gmail.com>
In-Reply-To: <CADBw62pmtbzr78c9J20cFbNRuTrntGg_E8TH_g=LciCVGYrYqQ@mail.gmail.com>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Wed, 23 Feb 2022 20:46:08 +0800
Message-ID: <CAF12kFtV_dpHukd2v0UwSoAFsDbNXZLPSnSSK9dqq7hnoJh9UQ@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang7@gmail.com> =E4=BA=8E2022=E5=B9=B42=E6=9C=8810=E6=
=97=A5=E5=91=A8=E5=9B=9B 16:07=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jan 24, 2022 at 4:07 PM Cixi Geng <gengcixi@gmail.com> wrote:
> >
> > Baolin Wang <baolin.wang7@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8817=
=E6=97=A5=E5=91=A8=E4=B8=80 14:15=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Thu, Jan 13, 2022 at 9:54 AM Cixi Geng <gengcixi@gmail.com> wrote:
> > > >
> > > > Baolin Wang <baolin.wang7@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=
=887=E6=97=A5=E5=91=A8=E4=BA=94 15:03=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > On Thu, Jan 6, 2022 at 9:00 PM Cixi Geng <gengcixi@gmail.com> wro=
te:
> > > > > >
> > > > > > From: Cixi Geng <cixi.geng1@unisoc.com>
> > > > > >
> > > > > > Introduce one variant device data structure to be compatible
> > > > > > with SC2731 PMIC since it has different scale and ratio calcula=
tion
> > > > > > and so on.
> > > > > >
> > > > > > Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> > > > > > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > > > > > ---
> > > > > >  drivers/iio/adc/sc27xx_adc.c | 94 ++++++++++++++++++++++++++++=
++------
> > > > > >  1 file changed, 79 insertions(+), 15 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc2=
7xx_adc.c
> > > > > > index aee076c8e2b1..d2712e54ee79 100644
> > > > > > --- a/drivers/iio/adc/sc27xx_adc.c
> > > > > > +++ b/drivers/iio/adc/sc27xx_adc.c
> > > > > > @@ -12,9 +12,9 @@
> > > > > >  #include <linux/slab.h>
> > > > > >
> > > > > >  /* PMIC global registers definition */
> > > > > > -#define SC27XX_MODULE_EN               0xc08
> > > > > > +#define SC2731_MODULE_EN               0xc08
> > > > > >  #define SC27XX_MODULE_ADC_EN           BIT(5)
> > > > > > -#define SC27XX_ARM_CLK_EN              0xc10
> > > > > > +#define SC2731_ARM_CLK_EN              0xc10
> > > > > >  #define SC27XX_CLK_ADC_EN              BIT(5)
> > > > > >  #define SC27XX_CLK_ADC_CLK_EN          BIT(6)
> > > > > >
> > > > > > @@ -78,6 +78,23 @@ struct sc27xx_adc_data {
> > > > > >         int channel_scale[SC27XX_ADC_CHANNEL_MAX];
> > > > > >         u32 base;
> > > > > >         int irq;
> > > > > > +       const struct sc27xx_adc_variant_data *var_data;
> > > > > > +};
> > > > > > +
> > > > > > +/*
> > > > > > + * Since different PMICs of SC27xx series can have different
> > > > > > + * address and ratio, we should save ratio config and base
> > > > > > + * in the device data structure.
> > > > > > + */
> > > > > > +struct sc27xx_adc_variant_data {
> > > > > > +       u32 module_en;
> > > > > > +       u32 clk_en;
> > > > > > +       u32 scale_shift;
> > > > > > +       u32 scale_mask;
> > > > > > +       const struct sc27xx_adc_linear_graph *bscale_cal;
> > > > > > +       const struct sc27xx_adc_linear_graph *sscale_cal;
> > > > > > +       void (*init_scale)(struct sc27xx_adc_data *data);
> > > > > > +       int (*get_ratio)(int channel, int scale);
> > > > > >  };
> > > > > >
> > > > > >  struct sc27xx_adc_linear_graph {
> > > > > > @@ -103,6 +120,16 @@ static struct sc27xx_adc_linear_graph smal=
l_scale_graph =3D {
> > > > > >         100, 341,
> > > > > >  };
> > > > > >
> > > > > > +static const struct sc27xx_adc_linear_graph sc2731_big_scale_g=
raph_calib =3D {
> > > > > > +       4200, 850,
> > > > > > +       3600, 728,
> > > > > > +};
> > > > > > +
> > > > > > +static const struct sc27xx_adc_linear_graph sc2731_small_scale=
_graph_calib =3D {
> > > > > > +       1000, 838,
> > > > > > +       100, 84,
> > > > > > +};
> > > > >
> > > > > The original big_scale_graph_calib and small_scale_graph_calib ar=
e for
> > > > > SC2731 PMIC, why add new structure definition for SC2731?
> > > > >
> > > > > > +
> > > > > >  static const struct sc27xx_adc_linear_graph big_scale_graph_ca=
lib =3D {
> > > > > >         4200, 856,
> > > > > >         3600, 733,
> > > > > > @@ -130,11 +157,11 @@ static int sc27xx_adc_scale_calibration(s=
truct sc27xx_adc_data *data,
> > > > > >         size_t len;
> > > > > >
> > > > > >         if (big_scale) {
> > > > > > -               calib_graph =3D &big_scale_graph_calib;
> > > > > > +               calib_graph =3D data->var_data->bscale_cal;
> > > > > >                 graph =3D &big_scale_graph;
> > > > > >                 cell_name =3D "big_scale_calib";
> > > > > >         } else {
> > > > > > -               calib_graph =3D &small_scale_graph_calib;
> > > > > > +               calib_graph =3D data->var_data->sscale_cal;
> > > > > >                 graph =3D &small_scale_graph;
> > > > > >                 cell_name =3D "small_scale_calib";
> > > > > >         }
> > > > > > @@ -160,7 +187,7 @@ static int sc27xx_adc_scale_calibration(str=
uct sc27xx_adc_data *data,
> > > > > >         return 0;
> > > > > >  }
> > > > > >
> > > > > > -static int sc27xx_adc_get_ratio(int channel, int scale)
> > > > > > +static int sc2731_adc_get_ratio(int channel, int scale)
> > > > > >  {
> > > > > >         switch (channel) {
> > > > > >         case 1:
> > > > > > @@ -185,6 +212,21 @@ static int sc27xx_adc_get_ratio(int channe=
l, int scale)
> > > > > >         return SC27XX_VOLT_RATIO(1, 1);
> > > > > >  }
> > > > > >
> > > > > > +/*
> > > > > > + * According to the datasheet set specific value on some chann=
el.
> > > > > > + */
> > > > > > +static void sc2731_adc_scale_init(struct sc27xx_adc_data *data=
)
> > > > > > +{
> > > > > > +       int i;
> > > > > > +
> > > > > > +       for (i =3D 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
> > > > > > +               if (i =3D=3D 5)
> > > > > > +                       data->channel_scale[i] =3D 1;
> > > > > > +               else
> > > > > > +                       data->channel_scale[i] =3D 0;
> > > > > > +       }
> > > > > > +}
> > > > >
> > > > > This is unnecessary I think, please see sc27xx_adc_write_raw() th=
at
> > > > > can set the channel scale.
> > > > Did you mean that all the PMIC's scale_init function should put int=
o
> > > > the sc27xx_adc_write_raw?
> > >
> > > No.
> > >
> > > > but the scale_init is all different by each PMIC, if implemented in
> > > > the write_raw, will add a lot of
> > > > if or switch_case branch
> > >
> > > What I mean is we should follow the original method to set the channe=
l
> > > scale by iio_info. Please also refer to other drivers how ot handle
> > > the channel scale.
> > Hi Baolin,  I understand the adc_write_raw() function is the method to =
set
> > channal scale for the userspace, we can change the channel scale by wri=
te
> > a value on a user code. did i understand right?
> > out  scale_init is to set scale value when the driver probe stage, and =
I also
> > did not found other adc driver use the adc_write_raw() during the drive=
r
> >  initialization phase.
>
> Hi Jonathan,
>
> How do you think about the method in this patch to set the channel
> scale? Thanks.
>
Hi Jonathan,
Could you have a loot at this patch ,and give some advice about the
method to set the channel scale? Thanks very much.
> --
> Baolin Wang

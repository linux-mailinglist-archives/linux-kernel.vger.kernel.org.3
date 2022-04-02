Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719944F00D7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354561AbiDBK5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240318AbiDBK5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:57:51 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B07148660;
        Sat,  2 Apr 2022 03:55:59 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso4909885wme.5;
        Sat, 02 Apr 2022 03:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bOsiEyruhUKUlqtWSkK3ESTScUa+KpMNdERqTOZhOJI=;
        b=dmL24i3ycwBZZQ0G5m6x7W3TmRr0UUZszRbt6ue0+ZjnJjkVL8xvIWyugDBo5pg22z
         n5Osfdi277+ApJ58mE4/xZRZg+UdEZDikFRiYBGX//LjlAsOFSBiYupZ4Cs4Pl08eTXm
         9uc6xjkYV7oCONQBbkiaXsd5O8t5ZI/7DSAVNTQrlC9VQZXCkHI5HLq+D/+WwZg3W0u1
         IXhvsP3PMBageFiC8Jdx3wKMayU0pt5RkCvMz2/w5VC7f2syBoxDklDnJzmMtLTqCM90
         ctmmzQNRNsfAshBwaxEnFZfHp4dU4w2zuKNcaPxllpZ6RONgh7YVIpa6VxN2sm3WwOTQ
         YERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bOsiEyruhUKUlqtWSkK3ESTScUa+KpMNdERqTOZhOJI=;
        b=Ejnha2I/O1SpD2kfxD9FI8yBWPVHIHqZ7Ap6/jNaoQrH/2kRZPzIqr8GAflorAorIW
         S/vwNm30WykH7P8kqJIJQYG2p4xwqBoro9F254A2D0gUAIKGTzC/DhZ9dRbTIo6+9Z1R
         joz2KVbpQPVsyIbkvMEY0S+aUfK3dWEjZcVFFXI15CwDO8MD0P3VcauR6PxU09IUposO
         kY8aTh9k90tuciyTq4Ld0o3XYHEnLy1MwEM9r8Vq7mMpY+wAz7QM/tHmAHJk3MEw7M29
         G5LFaxEpUxIrKGIzR7fxPGxQy2PTeLNDM6qt3NhBjMj7TduFF7Xl7g6isRxT5QABNIhn
         2M2A==
X-Gm-Message-State: AOAM533QkYxAPj/HC5Y6KxCJOcCDiojfisKz7+L/3c4s12c9OlA0hIOJ
        gF2y47Fgb/uwA7n3ZolLepxAzLX6MM6kc0eh9ug=
X-Google-Smtp-Source: ABdhPJzrJKSF1aNFZjncezmdMM0WpnTed9vQ7FcpC0HBtEyobZezzm7DE3pEF2aPZK7T+fSt0OJf/LRNRWKg2eviE10=
X-Received: by 2002:a05:600c:5029:b0:38c:9768:b4c with SMTP id
 n41-20020a05600c502900b0038c97680b4cmr11786227wmr.123.1648896957391; Sat, 02
 Apr 2022 03:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220311164628.378849-1-gengcixi@gmail.com> <20220311164628.378849-7-gengcixi@gmail.com>
 <20220320144151.66450e9a@jic23-huawei>
In-Reply-To: <20220320144151.66450e9a@jic23-huawei>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Sat, 2 Apr 2022 18:55:21 +0800
Message-ID: <CAF12kFsWVQin76KvWnfRszo+w033yjoL5DKc7ttXvywBcZPh5A@mail.gmail.com>
Subject: Re: [PATCH V2 6/7] iio: adc: sc27xx: add support for PMIC ump9620
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?5pyx546J5piOIChZdW1pbmcgWmh1LzExNDU3KQ==?= 
        <yuming.zhu1@unisoc.com>, linux-iio@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Jonathan Cameron <jic23@kernel.org> =E4=BA=8E2022=E5=B9=B43=E6=9C=8820=E6=
=97=A5=E5=91=A8=E6=97=A5 22:34=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, 12 Mar 2022 00:46:27 +0800
> Cixi Geng <gengcixi@gmail.com> wrote:
>
> > From: Cixi Geng <cixi.geng1@unisoc.com>
> >
> > The ump9620 is variant from sc27xx chip, add it in here.
> >
> > Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> Hi,
>
> Same comments as made earlier apply here.
> * Should there be a co-developed-by marking here or should
> the from reflect Yuming Zhu as the patch author with you in
> the role of being on the path to upstream?
> * change log below the ---
> * No blank lines or non tag lines in the tag block - use
> comments at the end of the lines if you want to give
> reported-by for particularly things.
>
> Also, I'm not immediately spotting where Baolin gave
> a tag.
>
> Comments inline.
>
> There are a few places in here where you have significant deviation betwe=
en
> the code that runs for this new device and previously supported parts.
> Doing that via if / else tends not to scale as yet more parts are added i=
n
> future. Perhaps it would be better to move to some device type specific
> callbacks for more of these cases.  This would be similar to the init_sca=
le
> and get_ratio function pointers you already have in the variant data.
>
> Thanks,
>
> Jonathan
>
> >
> > V2 changes:
> > 1. remove duplicated function
> > Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>
> >
> > 2. fix the smatch warnings
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/iio/adc/sc27xx_adc.c | 305 ++++++++++++++++++++++++++++++-----
> >  1 file changed, 266 insertions(+), 39 deletions(-)
> >
> > diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.=
c
> > index b89637c051ac..e9b680e9c275 100644
> > --- a/drivers/iio/adc/sc27xx_adc.c
> > +++ b/drivers/iio/adc/sc27xx_adc.c
> > @@ -15,12 +15,16 @@
> >  /* PMIC global registers definition */
> >  #define SC2730_MODULE_EN             0x1808
> >  #define SC2731_MODULE_EN             0xc08
> > +#define UMP9620_MODULE_EN            0x2008
> >  #define SC27XX_MODULE_ADC_EN         BIT(5)
> >  #define SC2721_ARM_CLK_EN            0xc0c
> >  #define SC2730_ARM_CLK_EN            0x180c
> >  #define SC2731_ARM_CLK_EN            0xc10
> > +#define UMP9620_ARM_CLK_EN           0x200c
> > +#define UMP9620_XTL_WAIT_CTRL0               0x2378
> >  #define SC27XX_CLK_ADC_EN            BIT(5)
> >  #define SC27XX_CLK_ADC_CLK_EN                BIT(6)
> > +#define UMP9620_XTL_WAIT_CTRL0_EN    BIT(8)
> >
> >  /* ADC controller registers definition */
> >  #define SC27XX_ADC_CTL                       0x0
> > @@ -82,6 +86,13 @@
> >  enum sc27xx_pmic_type {
> >       SC27XX_ADC,
> >       SC2721_ADC,
> > +     UMP9620_ADC,
> > +};
> > +
> > +enum ump96xx_scale_cal {
> > +     UMP96XX_VBAT_SENSES_CAL,
> > +     UMP96XX_VBAT_DET_CAL,
> > +     UMP96XX_CH1_CAL,
> >  };
> >
> >  struct sc27xx_adc_data {
> > @@ -139,6 +150,11 @@ static struct sc27xx_adc_linear_graph small_scale_=
graph =3D {
> >       100, 341,
> >  };
> >
> > +static struct sc27xx_adc_linear_graph ump9620_bat_det_graph =3D {
> > +     1400, 3482,
> > +     200, 476,
> > +};
> > +
> >  /* Add these for sc2731 pmic, and the [big|small]_scale_graph_calib fo=
r common's */
> >  static const struct sc27xx_adc_linear_graph sc2731_big_scale_graph_cal=
ib =3D {
> >       4200, 850,
> > @@ -165,16 +181,41 @@ static int sc27xx_adc_get_calib_data(u32 calib_da=
ta, int calib_adc)
> >       return ((calib_data & 0xff) + calib_adc - 128) * 4;
> >  }
> >
> > +/* get the adc nvmem cell calibration data */
> > +static int adc_nvmem_cell_calib_data(struct sc27xx_adc_data *data, con=
st char *cell_name)
> > +{
>
> This looks to be a bit of refactoring that could be sensibly pulled out b=
efore this
> patch.
Ok, I will do pull out the refactor part in a single patch
>
> > +     struct nvmem_cell *cell;
> > +     void *buf;
> > +     u32 origin_calib_data =3D 0;
>
> Why initialise the above?   I don't see it being used
> in any paths where it isn't already initialised.

Hi Jonathan:
It used origin_calib_data in memcpy,and the length of data
may less than sizeof(u32). we expect the other bits keeps 0;
So we initialise 0 in here.
>
> > +     size_t len =3D 0;
> > +
> > +     if (!data)
> > +             return -EINVAL;
> > +
> > +     cell =3D nvmem_cell_get(data->dev, cell_name);
> > +     if (IS_ERR(cell))
> > +             return PTR_ERR(cell);
> > +
> > +     buf =3D nvmem_cell_read(cell, &len);
> > +     if (IS_ERR(buf)) {
> > +             nvmem_cell_put(cell);
> > +             return PTR_ERR(buf);
> > +     }
> > +
> > +     memcpy(&origin_calib_data, buf, min(len, sizeof(u32)));
> > +
> > +     kfree(buf);
> > +     nvmem_cell_put(cell);
> > +     return origin_calib_data;
> > +}
> > +
> >  static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
> >                                       bool big_scale)
> >  {
> >       const struct sc27xx_adc_linear_graph *calib_graph;
> >       struct sc27xx_adc_linear_graph *graph;
> > -     struct nvmem_cell *cell;
> >       const char *cell_name;
> >       u32 calib_data =3D 0;
> > -     void *buf;
> > -     size_t len;
> >
> >       if (big_scale) {
> >               calib_graph =3D data->var_data->bscale_cal;
> > @@ -186,24 +227,63 @@ static int sc27xx_adc_scale_calibration(struct sc=
27xx_adc_data *data,
> >               cell_name =3D "small_scale_calib";
> >       }
> >
> > -     cell =3D nvmem_cell_get(data->dev, cell_name);
> > -     if (IS_ERR(cell))
> > -             return PTR_ERR(cell);
> > -
> > -     buf =3D nvmem_cell_read(cell, &len);
> > -     nvmem_cell_put(cell);
> > -
> > -     if (IS_ERR(buf))
> > -             return PTR_ERR(buf);
> > -
> > -     memcpy(&calib_data, buf, min(len, sizeof(u32)));
> > +     calib_data =3D adc_nvmem_cell_calib_data(data, cell_name);
> >
> >       /* Only need to calibrate the adc values in the linear graph. */
> >       graph->adc0 =3D sc27xx_adc_get_calib_data(calib_data, calib_graph=
->adc0);
> >       graph->adc1 =3D sc27xx_adc_get_calib_data(calib_data >> 8,
> >                                               calib_graph->adc1);
> >
> > -     kfree(buf);
> > +     return 0;
> > +}
> > +
> > +static int ump96xx_adc_scale_cal(struct sc27xx_adc_data *data,
> > +                                     enum ump96xx_scale_cal cal_type)
> > +{
> > +     struct sc27xx_adc_linear_graph *graph =3D NULL;
>
> Always set below, so don't initialize here. Same for other
> local variables.
here do make no sense, remove the initalise in next version.
>
> > +     const char *cell_name1 =3D NULL, *cell_name2 =3D NULL;
> > +     int adc_calib_data1 =3D 0, adc_calib_data2 =3D 0;
> > +
> > +     if (!data)
> > +             return -EINVAL;
> > +
> > +     if (cal_type =3D=3D UMP96XX_VBAT_DET_CAL) {
> > +             graph =3D &ump9620_bat_det_graph;
> > +             cell_name1 =3D "vbat_det_cal1";
> > +             cell_name2 =3D "vbat_det_cal2";
> > +     } else if (cal_type =3D=3D UMP96XX_VBAT_SENSES_CAL) {
> > +             graph =3D &big_scale_graph;
> > +             cell_name1 =3D "big_scale_calib1";
> > +             cell_name2 =3D "big_scale_calib2";
> > +     } else if (cal_type =3D=3D UMP96XX_CH1_CAL) {
> > +             graph =3D &small_scale_graph;
> > +             cell_name1 =3D "small_scale_calib1";
> > +             cell_name2 =3D "small_scale_calib2";
> > +     } else {
> > +             graph =3D &small_scale_graph;
> > +             cell_name1 =3D "small_scale_calib1";
> > +             cell_name2 =3D "small_scale_calib2";
> > +     }
> > +
> > +     adc_calib_data1 =3D adc_nvmem_cell_calib_data(data, cell_name1);
> > +     if (adc_calib_data1 < 0) {
> > +             dev_err(data->dev, "err! %s:%d\n", cell_name1, adc_calib_=
data1);
> > +             return adc_calib_data1;
> > +     }
> > +
> > +     adc_calib_data2 =3D adc_nvmem_cell_calib_data(data, cell_name2);
> > +     if (adc_calib_data2 < 0) {
> > +             dev_err(data->dev, "err! %s:%d\n", cell_name2, adc_calib_=
data2);
> > +             return adc_calib_data2;
> > +     }
> > +
> > +     /*
> > +      *Read the data in the two blocks of efuse and convert them into =
the
> > +      *calibration value in the ump9620 adc linear graph.
> > +      */
> > +     graph->adc0 =3D (adc_calib_data1 & 0xfff0) >> 4;
> > +     graph->adc1 =3D (adc_calib_data2 & 0xfff0) >> 4;
> > +
> >       return 0;
> >  }
> >
> > @@ -394,6 +474,50 @@ static int sc2731_adc_get_ratio(int channel, int s=
cale)
> >       return SC27XX_VOLT_RATIO(1, 1);
> >  }
> >
> > +static int ump9620_adc_get_ratio(int channel, int scale)
> > +{
> > +     switch (channel) {
> > +     case 11:
> > +             return SC27XX_VOLT_RATIO(1, 1);
> > +     case 14:
> > +             switch (scale) {
> > +             case 0:
> > +                     return SC27XX_VOLT_RATIO(68, 900);
> > +             default:
> > +                     return SC27XX_VOLT_RATIO(1, 1);
> > +             }
> > +     case 15:
> > +             switch (scale) {
> > +             case 0:
> > +                     return SC27XX_VOLT_RATIO(1, 3);
> > +             default:
> > +                     return SC27XX_VOLT_RATIO(1, 1);
> > +             }
> > +     case 21:
> > +     case 22:
> > +     case 23:
> > +             switch (scale) {
> > +             case 0:
> > +                     return SC27XX_VOLT_RATIO(3, 8);
> > +             default:
> > +                     return SC27XX_VOLT_RATIO(1, 1);
> > +             }
> > +     default:
> > +             switch (scale) {
> > +             case 0:
> > +                     return SC27XX_VOLT_RATIO(1, 1);
> > +             case 1:
> > +                     return SC27XX_VOLT_RATIO(1000, 1955);
> > +             case 2:
> > +                     return SC27XX_VOLT_RATIO(1000, 2600);
> > +             case 3:
> > +                     return SC27XX_VOLT_RATIO(1000, 4060);
> > +             default:
> > +                     return SC27XX_VOLT_RATIO(1, 1);
> > +             }
> > +     }
> > +}
> > +
> >  /*
> >   * According to the datasheet set specific value on some channel.
> >   */
> > @@ -453,6 +577,22 @@ static void sc2731_adc_scale_init(struct sc27xx_ad=
c_data *data)
> >       }
> >  }
> >
> > +static void ump9620_adc_scale_init(struct sc27xx_adc_data *data)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
> > +             if (i =3D=3D 10 || i =3D=3D 19 || i =3D=3D 30 || i =3D=3D=
 31)
> > +                     data->channel_scale[i] =3D 3;
> > +             else if (i =3D=3D 7 || i =3D=3D 9)
> > +                     data->channel_scale[i] =3D 2;
> > +             else if (i =3D=3D 0 || i =3D=3D 13)
> > +                     data->channel_scale[i] =3D 1;
> > +             else
> > +                     data->channel_scale[i] =3D 0;
> > +     }
> > +}
> > +
> >  static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
> >                          int scale, int *val)
> >  {
> > @@ -567,7 +707,7 @@ static void sc27xx_adc_volt_ratio(struct sc27xx_adc=
_data *data,
> >       *div_denominator =3D ratio & SC27XX_RATIO_DENOMINATOR_MASK;
> >  }
> >
> > -static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
> > +static int adc_to_volt(struct sc27xx_adc_linear_graph *graph,
> >                             int raw_adc)
> >  {
> >       int tmp;
> > @@ -576,6 +716,31 @@ static int sc27xx_adc_to_volt(struct sc27xx_adc_li=
near_graph *graph,
> >       tmp /=3D (graph->adc0 - graph->adc1);
> >       tmp +=3D graph->volt1;
> >
> > +     return tmp;
> > +}
> > +
> > +static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
> > +                           int raw_adc)
> > +{
> > +     int tmp;
> > +
> > +     tmp =3D adc_to_volt(graph, raw_adc);
> > +
> > +     return tmp < 0 ? 0 : tmp;
> > +}
> > +
> > +static int ump96xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph, =
int scale,
> > +                           int raw_adc)
> > +{
> > +     int tmp;
> > +
> > +     tmp =3D adc_to_volt(graph, raw_adc);
> > +
> > +     if (scale =3D=3D 2)
> > +             tmp =3D tmp * 2600 / 1000;
> > +     else if (scale =3D=3D 3)
> > +             tmp =3D tmp * 4060 / 1000;
> > +
> >       return tmp < 0 ? 0 : tmp;
> >  }
> >
> > @@ -585,23 +750,46 @@ static int sc27xx_adc_convert_volt(struct sc27xx_=
adc_data *data, int channel,
> >       u32 numerator, denominator;
> >       u32 volt;
> >
> > -     /*
> > -      * Convert ADC values to voltage values according to the linear g=
raph,
> > -      * and channel 5 and channel 1 has been calibrated, so we can jus=
t
> > -      * return the voltage values calculated by the linear graph. But =
other
> > -      * channels need be calculated to the real voltage values with th=
e
> > -      * voltage ratio.
> > -      */
> > -     switch (channel) {
> > -     case 5:
> > -             return sc27xx_adc_to_volt(&big_scale_graph, raw_adc);
> > +     if (data->var_data->pmic_type =3D=3D UMP9620_ADC) {
> > +             switch (channel) {
> > +             case 0:
> > +                     if (scale =3D=3D 1)
> > +                             volt =3D sc27xx_adc_to_volt(&ump9620_bat_=
det_graph, raw_adc);
> > +                     else
> > +                             volt =3D ump96xx_adc_to_volt(&small_scale=
_graph, scale, raw_adc);
> > +                     break;
> > +             case 11:
> > +                     volt =3D sc27xx_adc_to_volt(&big_scale_graph, raw=
_adc);
> > +                     break;
> > +             default:
> > +                     if (scale =3D=3D 1)
> > +                             volt =3D sc27xx_adc_to_volt(&ump9620_bat_=
det_graph, raw_adc);
> > +                     else
> > +                             volt =3D ump96xx_adc_to_volt(&small_scale=
_graph, scale, raw_adc);
> > +                     break;
> > +             }
> >
> > -     case 1:
> > -             return sc27xx_adc_to_volt(&small_scale_graph, raw_adc);
> > +             if (channel =3D=3D 0 && scale =3D=3D 1)
> > +                     return volt;
> > +     } else {
> > +             /*
> > +              * Convert ADC values to voltage values according to the =
linear graph,
> > +              * and channel 5 and channel 1 has been calibrated, so we=
 can just
> > +              * return the voltage values calculated by the linear gra=
ph. But other
> > +              * channels need be calculated to the real voltage values=
 with the
> > +              * voltage ratio.
> > +              */
> > +             switch (channel) {
> > +             case 5:
> > +                     return sc27xx_adc_to_volt(&big_scale_graph, raw_a=
dc);
> >
> > -     default:
> > -             volt =3D sc27xx_adc_to_volt(&small_scale_graph, raw_adc);
> > -             break;
> > +             case 1:
> > +                     return sc27xx_adc_to_volt(&small_scale_graph, raw=
_adc);
> > +
> > +             default:
> > +                     volt =3D sc27xx_adc_to_volt(&small_scale_graph, r=
aw_adc);
> > +                     break;
> > +             }
> >       }
> >
> >       sc27xx_adc_volt_ratio(data, channel, scale, &numerator, &denomina=
tor);
> > @@ -619,6 +807,7 @@ static int sc27xx_adc_read_processed(struct sc27xx_=
adc_data *data,
> >               return ret;
> >
> >       *val =3D sc27xx_adc_convert_volt(data, channel, scale, raw_adc);
> > +
> >       return 0;
> >  }
> >
> > @@ -736,21 +925,42 @@ static int sc27xx_adc_enable(struct sc27xx_adc_da=
ta *data)
> >       if (ret)
> >               return ret;
> >
> > -     /* Enable ADC work clock and controller clock */
> > +     /* Enable 26MHz crvstal oscillator wait cycles for UMP9620 ADC */
> > +     if (data->var_data->pmic_type =3D=3D UMP9620_ADC) {
> > +             ret =3D regmap_update_bits(data->regmap, UMP9620_XTL_WAIT=
_CTRL0,
> > +                                      UMP9620_XTL_WAIT_CTRL0_EN,
> > +                                      UMP9620_XTL_WAIT_CTRL0_EN);
> > +     }
> > +
> > +     /* Enable ADC work clock */
> >       ret =3D regmap_update_bits(data->regmap, data->var_data->clk_en,
> >                                SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_E=
N,
> >                                SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_E=
N);
> >       if (ret)
> >               goto disable_adc;
> >
> > -     /* ADC channel scales' calibration from nvmem device */
> > -     ret =3D sc27xx_adc_scale_calibration(data, true);
> > -     if (ret)
> > -             goto disable_clk;
> > +     /* ADC channel scales calibration from nvmem device */
> > +     if (data->var_data->pmic_type =3D=3D UMP9620_ADC) {
> > +             ret =3D ump96xx_adc_scale_cal(data, UMP96XX_VBAT_SENSES_C=
AL);
> > +             if (ret)
> > +                     goto disable_clk;
> >
> > -     ret =3D sc27xx_adc_scale_calibration(data, false);
> > -     if (ret)
> > -             goto disable_clk;
> > +             ret =3D ump96xx_adc_scale_cal(data, UMP96XX_VBAT_DET_CAL)=
;
> > +             if (ret)
> > +                     goto disable_clk;
> > +
> > +             ret =3D ump96xx_adc_scale_cal(data, UMP96XX_CH1_CAL);
> > +             if (ret)
> > +                     goto disable_clk;
> > +     } else {
> > +             ret =3D sc27xx_adc_scale_calibration(data, true);
> > +             if (ret)
> > +                     goto disable_clk;
> > +
> > +             ret =3D sc27xx_adc_scale_calibration(data, false);
> > +             if (ret)
> > +                     goto disable_clk;
> > +     }
> >
> >       return 0;
> >
> > @@ -774,6 +984,10 @@ static void sc27xx_adc_disable(void *_data)
> >
> >       regmap_update_bits(data->regmap, data->var_data->module_en,
> >                          SC27XX_MODULE_ADC_EN, 0);
> > +
> > +     if (data->var_data->pmic_type =3D=3D UMP9620_ADC)
> > +             regmap_update_bits(data->regmap, UMP9620_XTL_WAIT_CTRL0,
> > +                             UMP9620_XTL_WAIT_CTRL0_EN, 0);
> >  }
> >
> >  static const struct sc27xx_adc_variant_data sc2731_data =3D {
> > @@ -824,6 +1038,18 @@ static const struct sc27xx_adc_variant_data sc272=
0_data =3D {
> >       .get_ratio =3D sc2720_adc_get_ratio,
> >  };
> >
> > +static const struct sc27xx_adc_variant_data ump9620_data =3D {
> > +     .pmic_type =3D UMP9620_ADC,
> > +     .module_en =3D UMP9620_MODULE_EN,
> > +     .clk_en =3D UMP9620_ARM_CLK_EN,
> > +     .scale_shift =3D SC27XX_ADC_SCALE_SHIFT,
> > +     .scale_mask =3D SC27XX_ADC_SCALE_MASK,
> > +     .bscale_cal =3D &big_scale_graph,
> > +     .sscale_cal =3D &small_scale_graph,
> > +     .init_scale =3D ump9620_adc_scale_init,
> > +     .get_ratio =3D ump9620_adc_get_ratio,
> > +};
> > +
> >  static int sc27xx_adc_probe(struct platform_device *pdev)
> >  {
> >       struct device *dev =3D &pdev->dev;
> > @@ -917,6 +1143,7 @@ static const struct of_device_id sc27xx_adc_of_mat=
ch[] =3D {
> >       { .compatible =3D "sprd,sc2730-adc", .data =3D &sc2730_data},
> >       { .compatible =3D "sprd,sc2721-adc", .data =3D &sc2721_data},
> >       { .compatible =3D "sprd,sc2720-adc", .data =3D &sc2720_data},
> > +     { .compatible =3D "sprd,ump9620-adc", .data =3D &ump9620_data},
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(of, sc27xx_adc_of_match);
>

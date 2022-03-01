Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1674C8408
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 07:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiCAG3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 01:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiCAG3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:29:10 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CBC57B36;
        Mon, 28 Feb 2022 22:28:27 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so728559wmp.5;
        Mon, 28 Feb 2022 22:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pWn16AqiLrfX1zebjhB5rEinNun20KnuW9bQckIBJC8=;
        b=TgTuw2EwRUTqgMpH6oWu/LUo4Tj0DaFq2gazb8ukk2M3E5/N/ABnZq0JN+mM815Ir9
         vcgeDnECaVsw5QKgVp2TQprmJ75xfE7Q6Z46b7RN/DNTKR7QWx+YdLObRbto2cx62b76
         U2Eizso9FS2bTMBrKswDzRbpOry/gMiKnA0EbBCVm7muvxnd8HShq6B1E7K9lYPJcGA2
         ufdDL0oUpRNchJdWw4xSxScgUuh60nKzX5uqHuna+MBM6k52Efm5kO3D+4Qs++AxWTY1
         66sbxn9PxSVef8cZmyoJn7blrikHWzY2mf89TbTVevUvJahlgApgW6lbAfNhWvftwYEr
         GInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pWn16AqiLrfX1zebjhB5rEinNun20KnuW9bQckIBJC8=;
        b=tXhUMKpCEIpLZkJbYWwJwl6w2BOxkmgt6FmzILtHoSXUR2BFtgWNoaepdTQJ1UtZQp
         3yPfvxmTkEkLWz2r+MZpwdSLEZ6pJZzhmBDcjDjwYZzpFKEqaQk7YkBMarEErO8CM58s
         HF3Az6BXyaTG7Qu2ZdwPB9UWX5AJVu4dekQUrbDE7vCQXYIqatHQNnReUQ3jBWe2R7bB
         xbrHH045MW2OJEUPfpULX0Q0HdmWRupWTuCAxRPDB+IAz9ZsKTIA3i+Z2Q6KAwIZMiRv
         T/K6JN5NLno55x93AIefWQQKpmh7KyYzy/ezpjbsNL0BQHGFbkGKWJgDGT0kexe+7bD0
         kSXQ==
X-Gm-Message-State: AOAM532rdixdAL8dXyjMsOCjzgiFOP+r2L/G8nHWOnqid66v5FDyBV6M
        qqT312h0L83H+db4KH9a1zjpvWZ6VGdv6XD0E3g=
X-Google-Smtp-Source: ABdhPJw5lGRgmvJqRxK5pgVS2VyC04FiWUkY4OzVfoIcOgkPNqK2YKMpbei0S4C0NMIQ0+vl+S9PndX5tVzQcUVaQyw=
X-Received: by 2002:a05:600c:42d6:b0:380:ed47:43e8 with SMTP id
 j22-20020a05600c42d600b00380ed4743e8mr15770755wme.61.1646116106338; Mon, 28
 Feb 2022 22:28:26 -0800 (PST)
MIME-Version: 1.0
References: <20220106125947.139523-1-gengcixi@gmail.com> <20220106125947.139523-4-gengcixi@gmail.com>
 <CADBw62pBCdrbRspTV9Yck4DP8DE=ECGmEtD74NOtm1YRT3DM8w@mail.gmail.com>
 <CAF12kFu6O-gfiqp4j24zxC_GqCwJ2Q5KGYYaCtnagmUFB_bsVg@mail.gmail.com>
 <CADBw62rSdWN-L8HbnyMrUNp=x0pDdKR6MyKO4yfu00MnrN4L-g@mail.gmail.com>
 <CAF12kFvUfykKfeRAJACFRk31pmEBQEPw402x0JN4i1uv0EK1zg@mail.gmail.com>
 <CADBw62pmtbzr78c9J20cFbNRuTrntGg_E8TH_g=LciCVGYrYqQ@mail.gmail.com>
 <CAF12kFtV_dpHukd2v0UwSoAFsDbNXZLPSnSSK9dqq7hnoJh9UQ@mail.gmail.com> <20220225101942.00002f43@Huawei.com>
In-Reply-To: <20220225101942.00002f43@Huawei.com>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Tue, 1 Mar 2022 14:27:50 +0800
Message-ID: <CAF12kFtQH3_EsPBnDgBL59tYZ6wintgt9yceS2tUiB1Pv8qjgQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] iio: adc: sc27xx: structure adjuststment and optimization
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
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

Jonathan Cameron <Jonathan.Cameron@huawei.com> =E4=BA=8E2022=E5=B9=B42=E6=
=9C=8825=E6=97=A5=E5=91=A8=E4=BA=94 18:19=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 23 Feb 2022 20:46:08 +0800
> Cixi Geng <gengcixi@gmail.com> wrote:
>
> > Baolin Wang <baolin.wang7@gmail.com> =E4=BA=8E2022=E5=B9=B42=E6=9C=8810=
=E6=97=A5=E5=91=A8=E5=9B=9B 16:07=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Mon, Jan 24, 2022 at 4:07 PM Cixi Geng <gengcixi@gmail.com> wrote:
> > > >
> > > > Baolin Wang <baolin.wang7@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=
=8817=E6=97=A5=E5=91=A8=E4=B8=80 14:15=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > On Thu, Jan 13, 2022 at 9:54 AM Cixi Geng <gengcixi@gmail.com> wr=
ote:
> > > > > >
> > > > > > Baolin Wang <baolin.wang7@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=
=9C=887=E6=97=A5=E5=91=A8=E4=BA=94 15:03=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > >
> > > > > > > On Thu, Jan 6, 2022 at 9:00 PM Cixi Geng <gengcixi@gmail.com>=
 wrote:
> > > > > > > >
> > > > > > > > From: Cixi Geng <cixi.geng1@unisoc.com>
> > > > > > > >
> > > > > > > > Introduce one variant device data structure to be compatibl=
e
> > > > > > > > with SC2731 PMIC since it has different scale and ratio cal=
culation
> > > > > > > > and so on.
> > > > > > > >
> > > > > > > > Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> > > > > > > > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > > > > > > > ---
> > > > > > > >  drivers/iio/adc/sc27xx_adc.c | 94 ++++++++++++++++++++++++=
++++++------
> > > > > > > >  1 file changed, 79 insertions(+), 15 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc=
/sc27xx_adc.c
> > > > > > > > index aee076c8e2b1..d2712e54ee79 100644
> > > > > > > > --- a/drivers/iio/adc/sc27xx_adc.c
> > > > > > > > +++ b/drivers/iio/adc/sc27xx_adc.c
> > > > > > > > @@ -12,9 +12,9 @@
> > > > > > > >  #include <linux/slab.h>
> > > > > > > >
> > > > > > > >  /* PMIC global registers definition */
> > > > > > > > -#define SC27XX_MODULE_EN               0xc08
> > > > > > > > +#define SC2731_MODULE_EN               0xc08
> > > > > > > >  #define SC27XX_MODULE_ADC_EN           BIT(5)
> > > > > > > > -#define SC27XX_ARM_CLK_EN              0xc10
> > > > > > > > +#define SC2731_ARM_CLK_EN              0xc10
> > > > > > > >  #define SC27XX_CLK_ADC_EN              BIT(5)
> > > > > > > >  #define SC27XX_CLK_ADC_CLK_EN          BIT(6)
> > > > > > > >
> > > > > > > > @@ -78,6 +78,23 @@ struct sc27xx_adc_data {
> > > > > > > >         int channel_scale[SC27XX_ADC_CHANNEL_MAX];
> > > > > > > >         u32 base;
> > > > > > > >         int irq;
> > > > > > > > +       const struct sc27xx_adc_variant_data *var_data;
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +/*
> > > > > > > > + * Since different PMICs of SC27xx series can have differe=
nt
> > > > > > > > + * address and ratio, we should save ratio config and base
> > > > > > > > + * in the device data structure.
> > > > > > > > + */
> > > > > > > > +struct sc27xx_adc_variant_data {
> > > > > > > > +       u32 module_en;
> > > > > > > > +       u32 clk_en;
> > > > > > > > +       u32 scale_shift;
> > > > > > > > +       u32 scale_mask;
> > > > > > > > +       const struct sc27xx_adc_linear_graph *bscale_cal;
> > > > > > > > +       const struct sc27xx_adc_linear_graph *sscale_cal;
> > > > > > > > +       void (*init_scale)(struct sc27xx_adc_data *data);
> > > > > > > > +       int (*get_ratio)(int channel, int scale);
> > > > > > > >  };
> > > > > > > >
> > > > > > > >  struct sc27xx_adc_linear_graph {
> > > > > > > > @@ -103,6 +120,16 @@ static struct sc27xx_adc_linear_graph =
small_scale_graph =3D {
> > > > > > > >         100, 341,
> > > > > > > >  };
> > > > > > > >
> > > > > > > > +static const struct sc27xx_adc_linear_graph sc2731_big_sca=
le_graph_calib =3D {
> > > > > > > > +       4200, 850,
> > > > > > > > +       3600, 728,
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +static const struct sc27xx_adc_linear_graph sc2731_small_s=
cale_graph_calib =3D {
> > > > > > > > +       1000, 838,
> > > > > > > > +       100, 84,
> > > > > > > > +};
> > > > > > >
> > > > > > > The original big_scale_graph_calib and small_scale_graph_cali=
b are for
> > > > > > > SC2731 PMIC, why add new structure definition for SC2731?
> > > > > > >
> > > > > > > > +
> > > > > > > >  static const struct sc27xx_adc_linear_graph big_scale_grap=
h_calib =3D {
> > > > > > > >         4200, 856,
> > > > > > > >         3600, 733,
> > > > > > > > @@ -130,11 +157,11 @@ static int sc27xx_adc_scale_calibrati=
on(struct sc27xx_adc_data *data,
> > > > > > > >         size_t len;
> > > > > > > >
> > > > > > > >         if (big_scale) {
> > > > > > > > -               calib_graph =3D &big_scale_graph_calib;
> > > > > > > > +               calib_graph =3D data->var_data->bscale_cal;
> > > > > > > >                 graph =3D &big_scale_graph;
> > > > > > > >                 cell_name =3D "big_scale_calib";
> > > > > > > >         } else {
> > > > > > > > -               calib_graph =3D &small_scale_graph_calib;
> > > > > > > > +               calib_graph =3D data->var_data->sscale_cal;
> > > > > > > >                 graph =3D &small_scale_graph;
> > > > > > > >                 cell_name =3D "small_scale_calib";
> > > > > > > >         }
> > > > > > > > @@ -160,7 +187,7 @@ static int sc27xx_adc_scale_calibration=
(struct sc27xx_adc_data *data,
> > > > > > > >         return 0;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > -static int sc27xx_adc_get_ratio(int channel, int scale)
> > > > > > > > +static int sc2731_adc_get_ratio(int channel, int scale)
> > > > > > > >  {
> > > > > > > >         switch (channel) {
> > > > > > > >         case 1:
> > > > > > > > @@ -185,6 +212,21 @@ static int sc27xx_adc_get_ratio(int ch=
annel, int scale)
> > > > > > > >         return SC27XX_VOLT_RATIO(1, 1);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +/*
> > > > > > > > + * According to the datasheet set specific value on some c=
hannel.
> > > > > > > > + */
> > > > > > > > +static void sc2731_adc_scale_init(struct sc27xx_adc_data *=
data)
> > > > > > > > +{
> > > > > > > > +       int i;
> > > > > > > > +
> > > > > > > > +       for (i =3D 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
> > > > > > > > +               if (i =3D=3D 5)
> > > > > > > > +                       data->channel_scale[i] =3D 1;
> > > > > > > > +               else
> > > > > > > > +                       data->channel_scale[i] =3D 0;
> > > > > > > > +       }
> > > > > > > > +}
> > > > > > >
> > > > > > > This is unnecessary I think, please see sc27xx_adc_write_raw(=
) that
> > > > > > > can set the channel scale.
> > > > > > Did you mean that all the PMIC's scale_init function should put=
 into
> > > > > > the sc27xx_adc_write_raw?
> > > > >
> > > > > No.
> > > > >
> > > > > > but the scale_init is all different by each PMIC, if implemente=
d in
> > > > > > the write_raw, will add a lot of
> > > > > > if or switch_case branch
> > > > >
> > > > > What I mean is we should follow the original method to set the ch=
annel
> > > > > scale by iio_info. Please also refer to other drivers how ot hand=
le
> > > > > the channel scale.
> > > > Hi Baolin,  I understand the adc_write_raw() function is the method=
 to set
> > > > channal scale for the userspace, we can change the channel scale by=
 write
> > > > a value on a user code. did i understand right?
> > > > out  scale_init is to set scale value when the driver probe stage, =
and I also
> > > > did not found other adc driver use the adc_write_raw() during the d=
river
> > > >  initialization phase.
> > >
> > > Hi Jonathan,
> > >
> > > How do you think about the method in this patch to set the channel
> > > scale? Thanks.
> > >
> > Hi Jonathan,
> > Could you have a loot at this patch ,and give some advice about the
> > method to set the channel scale? Thanks very much.
>
> Hi, thanks for poking me on this - I'd missed the question buried deep in=
 the thread!
>
> Anyhow, I don't quite follow the discussion but think it could be focused
> on one of 2 questions...
>
> 1) Does setting an initial default make sense?
>    Yes, this is an acceptable thing to do if there is a particular set of=
 defaults
>    and there is no risk of regressions (i.e. the device wasn't previously=
 supported
>    with different defaults).
> 2) Should you use the write_raw callback to actually do the setting?
>    Probably not as it has a set of parameters that don't make as much sen=
se from within
>    the driver.  It 'might' make sense to have a common _set() function fo=
r this
>    feature which is called both in this initialization case and from the =
write_raw()
>    function however as that could do bounds checking etc in one common pl=
ace.
>    However, it is very simple here, so perhaps not necessary.
>
> Jonathan
>
Hi Jonathan, thanks for your comment !
And Baolin, I will send a new verision for the patches tto keep the
scale_init and
fix other issues . thanks!
> > > --
> > > Baolin Wang
>

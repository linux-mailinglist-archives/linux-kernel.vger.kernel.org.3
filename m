Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79D0525B85
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377266AbiEMGVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377293AbiEMGVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:21:04 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A64527FFE;
        Thu, 12 May 2022 23:21:00 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h24so1318755pgh.12;
        Thu, 12 May 2022 23:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aqwaJ57YXB9tZGr2dlUVfvm7g+7008zF1rGwOmFBcNE=;
        b=pwugGQJ8fZkDbb6OWTBkywz6bSy7oNtGDzNE0U8hPn3j/NuaAPdvL2d4ie/Vpot3EQ
         l/BMjAPmh7KPZCbSV5jLvodzy7H0ao2Hi7mUUMI1l4eiPWcQk93OM7Az9E8R0Fzg/Tiw
         L8yfFglSfcXriBsEleJmO4rIXDCFhwMmMcyE8vmsgsUIKLbyE5IBzt2BMpdeYaliL5bp
         tYZidQmKGIDZgxdvLmio1m/xCWqQzZJFXjiVHopORvkD20SYzw0HrzuwLlMVHPsggB6U
         KML4LwcuHeDzOANTFjDEWVrS5Eyqh/DcmE/3rlHDwjMZEQeouF5C8OXesfiSOhXJp1WP
         g2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aqwaJ57YXB9tZGr2dlUVfvm7g+7008zF1rGwOmFBcNE=;
        b=63Buxk1UvbVCIzptryAHEa/aykYPc1tZoXEP7NQD+qzMQvM1RFdwbU/RgEns9SYCos
         SOqvehutZ8qMpiVqs7LnFOQleGIA2Pmrbe58T+HIuKG71aqjUZtVKEmifeefusvUYzXw
         zSTYOoyNkIbr4e57D/jy5KZ+gxMdx/rJlU1iMWfifr7ZFOzEPMb5w2qJDWqHVuAIjcep
         fma9jQEnQyRmGUc272euwqsPbLVewLpAp5alHvkFlCLGmarASWnDAsaM3kKELTw1SHBd
         ufit6NsYWSuuEqoJwyIETjPzukTRhJLq7GGyS7TOKM4DMWLr9ysuRO8YQPxuFg+eFHLv
         gRxA==
X-Gm-Message-State: AOAM531ZJBEBNzPodxXoozTo9lLrawFdzZyIr8rqaOr+l0DRBm3bex8H
        YZD2ARKswSzXXw3nAneodFvc97ck4XCzlll7B2E=
X-Google-Smtp-Source: ABdhPJxXtFoym/g3OUpI+aQ+lEUQC/vBhdwoPutmtOwGuog5cX9dwGVrcebfQdFn50bq/jvkO3pWxwX0xseS1mPbXJY=
X-Received: by 2002:a63:6bc4:0:b0:3c1:e5d5:61d7 with SMTP id
 g187-20020a636bc4000000b003c1e5d561d7mr2665747pgc.418.1652422859860; Thu, 12
 May 2022 23:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20220510141753.3878390-4-Qing-wu.Li@leica-geosystems.com.cn>
 <CA+U=Dsqu_5JVyhs8juznQ5SyBx1V6Q5yT-fsnYuoYHX9ESE=Tg@mail.gmail.com> <AS8PR06MB784537D5C27DE4D867CF5064D7CB9@AS8PR06MB7845.eurprd06.prod.outlook.com>
In-Reply-To: <AS8PR06MB784537D5C27DE4D867CF5064D7CB9@AS8PR06MB7845.eurprd06.prod.outlook.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 13 May 2022 09:20:48 +0300
Message-ID: <CA+U=DsomRtNXAMoe=RKvf3b2BVxM_612HDmmvFYOs-pQ8Qw5qw@mail.gmail.com>
Subject: Re: [PATCH V2 3/6] iio: accel: bmi088: modified the device name
To:     LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 7:18 PM LI Qingwu
<qing-wu.li@leica-geosystems.com.cn> wrote:
>
>
> > -----Original Message-----
> > From: Alexandru Ardelean <ardeleanalex@gmail.com>
> > Sent: Thursday, May 12, 2022 3:32 PM
> > To: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> > Cc: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> > <lars@metafoo.de>; mchehab+huawei@kernel.org; linux-iio
> > <linux-iio@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>; Rob H=
erring
> > <robh+dt@kernel.org>; Mike Looijmans <mike.looijmans@topic.nl>; devicet=
ree
> > <devicetree@vger.kernel.org>
> > Subject: Re: [PATCH V2 3/6] iio: accel: bmi088: modified the device nam=
e
> >
> > This email is not from Hexagon=E2=80=99s Office 365 instance. Please be=
 careful while
> > clicking links, opening attachments, or replying to this email.
> >
> >
> > On Tue, May 10, 2022 at 5:18 PM LI Qingwu
> > <Qing-wu.Li@leica-geosystems.com.cn> wrote:
> > >
> > > It is possible to have multiple sensors connected on the same
> > > platform, To support multiple sensors, the commit makes it possible t=
o
> > > obtain the device name by reading the chip ID instead of the device-t=
ree
> > name.
> > > To be compatible with previous versions, renam bmi088a to bmi088-acce=
l.
> >
> > // my spellcheck in GMail found this :p
> >
> > typo: renam -> rename
> >
> > I also have a comment about a duplication that is highlighted by this c=
hange.
> >
> > You can disregard my comment about the duplication and leave this chang=
e
> > as-is.
> >
> > >
> > > Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> > > ---
> > >  drivers/iio/accel/bmi088-accel-core.c | 6 +++---
> > > drivers/iio/accel/bmi088-accel-spi.c  | 4 +---
> > >  drivers/iio/accel/bmi088-accel.h      | 2 +-
> > >  3 files changed, 5 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/iio/accel/bmi088-accel-core.c
> > > b/drivers/iio/accel/bmi088-accel-core.c
> > > index 8fee1d02e773..de2385e4dad5 100644
> > > --- a/drivers/iio/accel/bmi088-accel-core.c
> > > +++ b/drivers/iio/accel/bmi088-accel-core.c
> > > @@ -459,7 +459,7 @@ static const struct iio_chan_spec
> > > bmi088_accel_channels[] =3D {
> > >
> > >  static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tb=
l[] =3D {
> > >         [0] =3D {
> > > -               .name =3D "bmi088a",
> > > +               .name =3D "bmi088-accel",
> > >                 .chip_id =3D 0x1E,
> > >                 .channels =3D bmi088_accel_channels,
> > >                 .num_channels =3D ARRAY_SIZE(bmi088_accel_channels),
> > > @@ -524,7 +524,7 @@ static int bmi088_accel_chip_init(struct
> > > bmi088_accel_data *data)  }
> > >
> > >  int bmi088_accel_core_probe(struct device *dev, struct regmap *regma=
p,
> > > -       int irq, const char *name, bool block_supported)
> > > +       int irq, bool block_supported)
> > >  {
> > >         struct bmi088_accel_data *data;
> > >         struct iio_dev *indio_dev;
> > > @@ -545,7 +545,7 @@ int bmi088_accel_core_probe(struct device *dev,
> > > struct regmap *regmap,
> > >
> > >         indio_dev->channels =3D data->chip_info->channels;
> > >         indio_dev->num_channels =3D data->chip_info->num_channels;
> > > -       indio_dev->name =3D name ? name : data->chip_info->name;
> > > +       indio_dev->name =3D data->chip_info->name;
> >
> > (with this change) i can better see, a bit of duplication between the s=
pi_device
> > table and the chip_info table
> >
> > this was not introduced by this change, but it was made a bit more obvi=
ous by
> > this change;
> >
> > one way to address this, is to remove the `const char *name;` and conti=
nue
> > using the `name` provided as a parameter from bmi088_accel_core_probe()=
;
> > (apologies if I seem to have changed my mind (from the previous changes=
et), but
> > I did not see it too well before)
> >
> > and we can convert
> >
> > enum {
> >    ID_BMI088,
> >    ID_BMI085,
> >    ...
> > };
> >
> >  static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[=
] =3D {
> >          [ID_BMI088] =3D {
> >                  .chip_id =3D 0x1E,
> >                  .channels =3D bmi088_accel_channels,
> >                 .num_channels =3D ARRAY_SIZE(bmi088_accel_channels),
> >         },
> >          [ID_BMI085] =3D {
> >          ........
> >
> Thanks Ardelean,
>
> There is a case where some different sensors are connected to one system,
> For user space is nice if can detect which sensor is present, if using th=
e name in spi_device table,
> the name may be inconsistent with the connected sensor. What's your opini=
on?

I'd let Jonathan have the last word on this.

Typically, what I've seen (in practice), that when you write a
device-tree for a board and you add (for example) BMI088 for board
RevA, but on RevB it is decided to go with BMI085, then some people
want to enforce this from the device-tree.

So, if in the DT someone specifies bmi088-accel (as compatible
string), then it could fail on probe if it detects bmi085-accel.
Right now, this isn't happening with the driver (as it is now).

On the other hand, some other people want this flexibility where if
you specify bmi088-accel, bmi085-accel or bmi090-accel, then they like
the interchange-ability at the device-tree level.

I don't know which is better. I'm not sure this was enforced (or maybe
I missed it).

But a more common practice (that I remember in some IIO drivers) is
that the chip_info table (or a chip_id value)  can be added to
spi_device_table.
When the DT tries to probe the driver and reads a different ID (from
SPI) it would fail the probe.

These are just some thoughts. Not a final conclusion.

>
>
> > >         indio_dev->available_scan_masks =3D bmi088_accel_scan_masks;
> > >         indio_dev->modes =3D INDIO_DIRECT_MODE;
> > >         indio_dev->info =3D &bmi088_accel_info; diff --git
> > > a/drivers/iio/accel/bmi088-accel-spi.c
> > > b/drivers/iio/accel/bmi088-accel-spi.c
> > > index dd1e3f6cf211..0fed0081e1fd 100644
> > > --- a/drivers/iio/accel/bmi088-accel-spi.c
> > > +++ b/drivers/iio/accel/bmi088-accel-spi.c
> > > @@ -42,7 +42,6 @@ static struct regmap_bus bmi088_regmap_bus =3D {
> > > static int bmi088_accel_probe(struct spi_device *spi)  {
> > >         struct regmap *regmap;
> > > -       const struct spi_device_id *id =3D spi_get_device_id(spi);
> > >
> > >         regmap =3D devm_regmap_init(&spi->dev, &bmi088_regmap_bus,
> > >                         spi, &bmi088_regmap_conf); @@ -52,8 +51,7
> > @@
> > > static int bmi088_accel_probe(struct spi_device *spi)
> > >                 return PTR_ERR(regmap);
> > >         }
> > >
> > > -       return bmi088_accel_core_probe(&spi->dev, regmap, spi->irq,
> > id->name,
> > > -                                      true);
> > > +       return bmi088_accel_core_probe(&spi->dev, regmap, spi->irq,
> > > + true);
> > >  }
> > >
> > >  static int bmi088_accel_remove(struct spi_device *spi) diff --git
> > > a/drivers/iio/accel/bmi088-accel.h b/drivers/iio/accel/bmi088-accel.h
> > > index 5c25f16b672c..c32afe9606a8 100644
> > > --- a/drivers/iio/accel/bmi088-accel.h
> > > +++ b/drivers/iio/accel/bmi088-accel.h
> > > @@ -12,7 +12,7 @@ extern const struct regmap_config
> > > bmi088_regmap_conf;  extern const struct dev_pm_ops
> > > bmi088_accel_pm_ops;
> > >
> > >  int bmi088_accel_core_probe(struct device *dev, struct regmap *regma=
p,
> > int irq,
> > > -                           const char *name, bool block_supported);
> > > +                           bool block_supported);
> > >  int bmi088_accel_core_remove(struct device *dev);
> > >
> > >  #endif /* BMI088_ACCEL_H */
> > > --
> > > 2.25.1
> > >

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AF2527288
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 17:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbiENPVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 11:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiENPU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 11:20:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC982F3AB;
        Sat, 14 May 2022 08:20:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AE75B80759;
        Sat, 14 May 2022 15:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BD0C340EE;
        Sat, 14 May 2022 15:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652541654;
        bh=Z8Md+8ecvSyhtwYs22RuKb9xT3iaFbQCQnF5RcGY2pU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fc6UwBNscI4nCpvMwe44hWG1gCnAtD35nxA1pGul+fN45Yx+Btz6extXypLma12Kx
         4ie+wL7VTGRA+W8RLKdU2fNcu63pRg2bPqeKss4aquftuVsKbD8tJaOCGjzkFUs5OE
         yWsMFRs+irGYoMpZVc6XN1Vexb/Rjq5RhDzZ6f3Wrp/CKY8f/xrMkpnMO55iBiO4wK
         KzAoh0EaYrQKYUbl2hoTNR9/30VlwtB0UbYwuJZT27LtEwV4k2bRy2TiHQ2YP+40Mp
         TdtXUGnfY/0W+x777+D5sBjZo1nCERMd/5CUJPFznefyMWLIbsQE528szbUtwmSpP0
         g4otCHOS2xGJA==
Date:   Sat, 14 May 2022 16:29:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     LI Qingwu <qing-wu.li@leica-geosystems.com.cn>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH V2 3/6] iio: accel: bmi088: modified the device name
Message-ID: <20220514162928.213831c1@jic23-huawei>
In-Reply-To: <CA+U=DsomRtNXAMoe=RKvf3b2BVxM_612HDmmvFYOs-pQ8Qw5qw@mail.gmail.com>
References: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220510141753.3878390-4-Qing-wu.Li@leica-geosystems.com.cn>
        <CA+U=Dsqu_5JVyhs8juznQ5SyBx1V6Q5yT-fsnYuoYHX9ESE=Tg@mail.gmail.com>
        <AS8PR06MB784537D5C27DE4D867CF5064D7CB9@AS8PR06MB7845.eurprd06.prod.outlook.com>
        <CA+U=DsomRtNXAMoe=RKvf3b2BVxM_612HDmmvFYOs-pQ8Qw5qw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2022 09:20:48 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Thu, May 12, 2022 at 7:18 PM LI Qingwu
> <qing-wu.li@leica-geosystems.com.cn> wrote:
> >
> > =20
> > > -----Original Message-----
> > > From: Alexandru Ardelean <ardeleanalex@gmail.com>
> > > Sent: Thursday, May 12, 2022 3:32 PM
> > > To: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> > > Cc: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> > > <lars@metafoo.de>; mchehab+huawei@kernel.org; linux-iio
> > > <linux-iio@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>; Rob=
 Herring
> > > <robh+dt@kernel.org>; Mike Looijmans <mike.looijmans@topic.nl>; devic=
etree
> > > <devicetree@vger.kernel.org>
> > > Subject: Re: [PATCH V2 3/6] iio: accel: bmi088: modified the device n=
ame
> > >
> > > This email is not from Hexagon=E2=80=99s Office 365 instance. Please =
be careful while
> > > clicking links, opening attachments, or replying to this email.
> > >
> > >
> > > On Tue, May 10, 2022 at 5:18 PM LI Qingwu
> > > <Qing-wu.Li@leica-geosystems.com.cn> wrote: =20
> > > >
> > > > It is possible to have multiple sensors connected on the same
> > > > platform, To support multiple sensors, the commit makes it possible=
 to
> > > > obtain the device name by reading the chip ID instead of the device=
-tree =20
> > > name. =20
> > > > To be compatible with previous versions, renam bmi088a to bmi088-ac=
cel. =20
> > >
> > > // my spellcheck in GMail found this :p
> > >
> > > typo: renam -> rename
> > >
> > > I also have a comment about a duplication that is highlighted by this=
 change.
> > >
> > > You can disregard my comment about the duplication and leave this cha=
nge
> > > as-is.
> > > =20
> > > >
> > > > Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> > > > ---
> > > >  drivers/iio/accel/bmi088-accel-core.c | 6 +++---
> > > > drivers/iio/accel/bmi088-accel-spi.c  | 4 +---
> > > >  drivers/iio/accel/bmi088-accel.h      | 2 +-
> > > >  3 files changed, 5 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/accel/bmi088-accel-core.c
> > > > b/drivers/iio/accel/bmi088-accel-core.c
> > > > index 8fee1d02e773..de2385e4dad5 100644
> > > > --- a/drivers/iio/accel/bmi088-accel-core.c
> > > > +++ b/drivers/iio/accel/bmi088-accel-core.c
> > > > @@ -459,7 +459,7 @@ static const struct iio_chan_spec
> > > > bmi088_accel_channels[] =3D {
> > > >
> > > >  static const struct bmi088_accel_chip_info bmi088_accel_chip_info_=
tbl[] =3D {
> > > >         [0] =3D {
> > > > -               .name =3D "bmi088a",
> > > > +               .name =3D "bmi088-accel",
> > > >                 .chip_id =3D 0x1E,
> > > >                 .channels =3D bmi088_accel_channels,
> > > >                 .num_channels =3D ARRAY_SIZE(bmi088_accel_channels),
> > > > @@ -524,7 +524,7 @@ static int bmi088_accel_chip_init(struct
> > > > bmi088_accel_data *data)  }
> > > >
> > > >  int bmi088_accel_core_probe(struct device *dev, struct regmap *reg=
map,
> > > > -       int irq, const char *name, bool block_supported)
> > > > +       int irq, bool block_supported)
> > > >  {
> > > >         struct bmi088_accel_data *data;
> > > >         struct iio_dev *indio_dev;
> > > > @@ -545,7 +545,7 @@ int bmi088_accel_core_probe(struct device *dev,
> > > > struct regmap *regmap,
> > > >
> > > >         indio_dev->channels =3D data->chip_info->channels;
> > > >         indio_dev->num_channels =3D data->chip_info->num_channels;
> > > > -       indio_dev->name =3D name ? name : data->chip_info->name;
> > > > +       indio_dev->name =3D data->chip_info->name; =20
> > >
> > > (with this change) i can better see, a bit of duplication between the=
 spi_device
> > > table and the chip_info table
> > >
> > > this was not introduced by this change, but it was made a bit more ob=
vious by
> > > this change;
> > >
> > > one way to address this, is to remove the `const char *name;` and con=
tinue
> > > using the `name` provided as a parameter from bmi088_accel_core_probe=
();
> > > (apologies if I seem to have changed my mind (from the previous chang=
eset), but
> > > I did not see it too well before)
> > >
> > > and we can convert
> > >
> > > enum {
> > >    ID_BMI088,
> > >    ID_BMI085,
> > >    ...
> > > };
> > >
> > >  static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tb=
l[] =3D {
> > >          [ID_BMI088] =3D {
> > >                  .chip_id =3D 0x1E,
> > >                  .channels =3D bmi088_accel_channels,
> > >                 .num_channels =3D ARRAY_SIZE(bmi088_accel_channels),
> > >         },
> > >          [ID_BMI085] =3D {
> > >          ........
> > > =20
> > Thanks Ardelean,
> >
> > There is a case where some different sensors are connected to one syste=
m,
> > For user space is nice if can detect which sensor is present, if using =
the name in spi_device table,
> > the name may be inconsistent with the connected sensor. What's your opi=
nion? =20
>=20
> I'd let Jonathan have the last word on this.
>=20
> Typically, what I've seen (in practice), that when you write a
> device-tree for a board and you add (for example) BMI088 for board
> RevA, but on RevB it is decided to go with BMI085, then some people
> want to enforce this from the device-tree.

In my view the device tree should be using fallbacks for this, so
actually always list the real device first then have other compatible entri=
es.
Thus if it turns out there is something unique that means we can't
just the whoami value, we have a more precise description (this
has happened with IIRC the mpu6050 supported parts).

>=20
> So, if in the DT someone specifies bmi088-accel (as compatible
> string), then it could fail on probe if it detects bmi085-accel.
> Right now, this isn't happening with the driver (as it is now).
>=20
> On the other hand, some other people want this flexibility where if
> you specify bmi088-accel, bmi085-accel or bmi090-accel, then they like
> the interchange-ability at the device-tree level.
>=20
> I don't know which is better. I'm not sure this was enforced (or maybe
> I missed it).
>=20
> But a more common practice (that I remember in some IIO drivers) is
> that the chip_info table (or a chip_id value)  can be added to
> spi_device_table.
> When the DT tries to probe the driver and reads a different ID (from
> SPI) it would fail the probe.

So we've had a few threads about this recently and some advice
from the device tree maintainers.  Where there is a Whoami or similar
register, the expectation is that a driver should at most 'warn' about
an incorrect device tree binding rather than failing the probe.
what it does then is dependent on whether the driver has info on the
chip id value found.  If it matches a different one then we can hopefully
assume that is the correct part (this isn't always true as we have
had device with the same ID that weren't compatible).  If it is unknown
then the assumption should be that the devicetree is correct and the
part is compatible so we should carry on anyway with whatever was
specified.

Idea being that if a new truly compatible part is released then
compatible =3D "bosch,newpart", "bosch,oldpart" should work
even though we don't know the chip id for the new part.


>=20
> These are just some thoughts. Not a final conclusion.
>=20
> >
> > =20
> > > >         indio_dev->available_scan_masks =3D bmi088_accel_scan_masks;
> > > >         indio_dev->modes =3D INDIO_DIRECT_MODE;
> > > >         indio_dev->info =3D &bmi088_accel_info; diff --git
> > > > a/drivers/iio/accel/bmi088-accel-spi.c
> > > > b/drivers/iio/accel/bmi088-accel-spi.c
> > > > index dd1e3f6cf211..0fed0081e1fd 100644
> > > > --- a/drivers/iio/accel/bmi088-accel-spi.c
> > > > +++ b/drivers/iio/accel/bmi088-accel-spi.c
> > > > @@ -42,7 +42,6 @@ static struct regmap_bus bmi088_regmap_bus =3D {
> > > > static int bmi088_accel_probe(struct spi_device *spi)  {
> > > >         struct regmap *regmap;
> > > > -       const struct spi_device_id *id =3D spi_get_device_id(spi);
> > > >
> > > >         regmap =3D devm_regmap_init(&spi->dev, &bmi088_regmap_bus,
> > > >                         spi, &bmi088_regmap_conf); @@ -52,8 +51,7 =
=20
> > > @@ =20
> > > > static int bmi088_accel_probe(struct spi_device *spi)
> > > >                 return PTR_ERR(regmap);
> > > >         }
> > > >
> > > > -       return bmi088_accel_core_probe(&spi->dev, regmap, spi->irq,=
 =20
> > > id->name, =20
> > > > -                                      true);
> > > > +       return bmi088_accel_core_probe(&spi->dev, regmap, spi->irq,
> > > > + true);
> > > >  }
> > > >
> > > >  static int bmi088_accel_remove(struct spi_device *spi) diff --git
> > > > a/drivers/iio/accel/bmi088-accel.h b/drivers/iio/accel/bmi088-accel=
.h
> > > > index 5c25f16b672c..c32afe9606a8 100644
> > > > --- a/drivers/iio/accel/bmi088-accel.h
> > > > +++ b/drivers/iio/accel/bmi088-accel.h
> > > > @@ -12,7 +12,7 @@ extern const struct regmap_config
> > > > bmi088_regmap_conf;  extern const struct dev_pm_ops
> > > > bmi088_accel_pm_ops;
> > > >
> > > >  int bmi088_accel_core_probe(struct device *dev, struct regmap *reg=
map, =20
> > > int irq, =20
> > > > -                           const char *name, bool block_supported);
> > > > +                           bool block_supported);
> > > >  int bmi088_accel_core_remove(struct device *dev);
> > > >
> > > >  #endif /* BMI088_ACCEL_H */
> > > > --
> > > > 2.25.1
> > > > =20


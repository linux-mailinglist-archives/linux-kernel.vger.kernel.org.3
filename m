Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C2B510559
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbiDZR1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiDZR1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:27:33 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E5C17079;
        Tue, 26 Apr 2022 10:24:17 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 53B865FD0A;
        Tue, 26 Apr 2022 20:24:14 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1650993854;
        bh=c7dH5qiHwS+Eagz/ndROpLhN/xPAqOD05MAEGga35Ro=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=giAIbr5zKbxl8AiaVwLwQiM8s4p0F3u2QLcFKKuqgYub6o2FdMKlpFNkKboX0w6s1
         OZezYNEnPxTmz3M2kwDxGtwVOC0CEMA3rVTvoQzzxOiXkf3U0cRNLfTLoaeoadFSo0
         LyiFMcaf8IgB7DTrX537hXvz79MEHErjIbVQsI+lC/4kM7A0xB4GFINZkROGQv1tLI
         eKUdRpMU2ID5H/rPH749aOja0dZa7I14gmTV5NL5zYC25jKSObw8ErZrRus550Sp4D
         MgOuFmi6dEffAPauqMfHNU9eBvxn61XlZoTEVXvNruzHLc/zBvQ7NeInAzPCYEzCYb
         JTpeT70NyEvbQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue, 26 Apr 2022 20:24:11 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Topic: [PATCH v1 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Index: AQHYVASOybrxT0DjfUWoYWuGUlWOX6z4bouAgAnb/gA=
Date:   Tue, 26 Apr 2022 17:23:24 +0000
Message-ID: <20220426172406.s4h6g7nrpytaq263@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220419154555.24191-1-ddrokosov@sberdevices.ru>
 <20220419154555.24191-3-ddrokosov@sberdevices.ru>
 <20220420115023.00006a25@Huawei.com>
In-Reply-To: <20220420115023.00006a25@Huawei.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C78A66373A32264A96AD72BA5DBD7B40@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/04/26 12:39:00 #19363785
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan,

Thank you for such detailed review. Please find my comments and
questions below.

On Wed, Apr 20, 2022 at 11:50:23AM +0100, Jonathan Cameron wrote:
> On Tue, 19 Apr 2022 15:45:55 +0000
> Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru> wrote:
>=20
> > MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> > sensitivity consumer applications. It has dynamical user selectable ful=
l
> > scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measuremen=
ts
> > with output data rates from 1Hz to 1000Hz.
> >=20
> > This driver supports following MSA311 features:
> >     - IIO interface
> >     - Different power modes: NORMAL, SUSPEND and LOW (using pm_runtime)
> >     - ODR (Output Data Rate) selection
> >     - Scale and samp_freq selection
> >     - IIO triggered buffer, IIO reg access
> >     - NEW_DATA interrupt + trigger
> >=20
> > Below features to be done:
> >     - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
> >=20
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> Hi Dmitry,
>=20
> An initial review below.  Mostly style related stuff as driver looks pret=
ty good
> for a first posting.
>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> >  MAINTAINERS                |    6 +
> >  drivers/iio/accel/Kconfig  |   13 +
> >  drivers/iio/accel/Makefile |    2 +
> >  drivers/iio/accel/msa311.c | 2068 ++++++++++++++++++++++++++++++++++++=
++++++++
> >  4 files changed, 2089 insertions(+)
> >  create mode 100644 drivers/iio/accel/msa311.c
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index cd0f68d..c75be17 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12478,6 +12478,12 @@ F:	drivers/mtd/
> >  F:	include/linux/mtd/
> >  F:	include/uapi/mtd/
> > =20
> > +MEMSENSING MICROSYSTEMS MSA311 ACCELEROMETER DRIVER
> > +M:	Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Maintained
> > +F:	drivers/iio/accel/msa311.c
> > +
> >  MEN A21 WATCHDOG DRIVER
> >  M:	Johannes Thumshirn <morbidrsa@gmail.com>
> >  L:	linux-watchdog@vger.kernel.org
> > diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> > index 49587c9..88a265b 100644
> > --- a/drivers/iio/accel/Kconfig
> > +++ b/drivers/iio/accel/Kconfig
> > @@ -508,6 +508,19 @@ config MMA9553
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called mma9553.
> > =20
> > +config MSA311
> > +	tristate "MEMSensing Digital 3-Axis Accelerometer Driver"
> > +	depends on I2C
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> > +	select REGMAP_I2C
> > +	help
> > +	  Say yes here to build support for the MEMSensing MSA311
> > +	  accelerometer driver.
> > +
> > +	  To compile this driver as a module, choose M here: the module will =
be
> > +	  called msa311.
> > +
> >  config MXC4005
> >  	tristate "Memsic MXC4005XC 3-Axis Accelerometer Driver"
> >  	depends on I2C
> > diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> > index d03e2f6..b1ddcaa 100644
> > --- a/drivers/iio/accel/Makefile
> > +++ b/drivers/iio/accel/Makefile
> > @@ -55,6 +55,8 @@ obj-$(CONFIG_MMA9551_CORE)	+=3D mma9551_core.o
> >  obj-$(CONFIG_MMA9551)		+=3D mma9551.o
> >  obj-$(CONFIG_MMA9553)		+=3D mma9553.o
> > =20
> > +obj-$(CONFIG_MSA311)		+=3D msa311.o
> > +
> >  obj-$(CONFIG_MXC4005)		+=3D mxc4005.o
> >  obj-$(CONFIG_MXC6255)		+=3D mxc6255.o
> > =20
> > diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
> > new file mode 100644
> > index 00000000..9f81b60
> > --- /dev/null
> > +++ b/drivers/iio/accel/msa311.c
> > @@ -0,0 +1,2068 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * msa311.c - MEMSensing digital 3-Axis accelerometer
> > + *
> > + * MSA311 is a tri-axial, low-g accelerometer with I2C digital output =
for
> > + * sensitivity consumer applications. It has dynamical user selectable=
 full
> > + * scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measur=
ements
> > + * with output data rates from 1Hz to 1000Hz.
> > + *
> > + * MSA311 is available in an ultra small (2mm x 2mm, height 0.95mm) LG=
A package
> > + * and is guaranteed to operate over -40C to +85C.
> > + *
> > + * This driver supports following MSA311 features:
> > + *     - IIO interface
> > + *     - Different power modes: NORMAL, SUSPEND and LOW
>=20
> There is partial support for LOW but how do you get into that mode?
>=20

You are right, LOW mode is not used now for any flow. I'll remove LOW
mode mention from commit msg. To be honest, I have no idea how we can use
LOW mode in this driver, because SUSPEND mode is pretty good for low
power state and NORMAL is okay for data flow.

> > + *     - ODR (Output Data Rate) selection
> > + *     - Scale selection
> > + *     - IIO triggered buffer
> > + *     - NEW_DATA interrupt + trigger
> > + *
> > + * Below features to be done:
> > + *     - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
> > + *
> > + * Copyright (c) 2022, SberDevices. All Rights Reserved.
> > + *
> > + * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > + */
> > +
> > +#include <linux/i2c.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/module.h>
>=20
> #include <linux/mod_devicetable.h>
>=20

Ack

> > +#include <linux/pm.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> > +
> > +#define MSA311_DRV_NAME "msa311"
> > +
> > +/* Register map */
> > +
> > +enum msa311_regs {
> > +	MSA311_SOFT_RESET =3D 0x00,
>=20
> I'd like to see the naming of these conveying that
> they are registers addreses. =20
>=20
> MSA311_SOFT_RESET_REG for example would do that nicely.
>=20

I agree, it's more readable

> > +	MSA311_PARTID,
> > +	MSA311_ACC_X_LSB,
> > +	MSA311_ACC_X_MSB,
> > +	MSA311_ACC_Y_LSB,
> > +	MSA311_ACC_Y_MSB,
> > +	MSA311_ACC_Z_LSB,
> > +	MSA311_ACC_Z_MSB,
> > +
> > +	MSA311_MOTION_INT =3D 0x09,
>=20
> As you have lots of gaps in here and the enum type is never
> used, this would be better as a set of #define MSA311_DATA_INT_REG etc
> so we can very quickly check the addresses are correct.
>=20

Okay, I'll use #define instead of enum for registers offsets on the v2.

> > +	MSA311_DATA_INT,
> > +	MSA311_TAP_ACTIVE_STS,
> > +	MSA311_ORIENT_STS,
> > +
> > +	MSA311_RANGE =3D 0x0F,
> > +	MSA311_ODR,
> > +	MSA311_PWR_MODE,
> > +	MSA311_SWAP_POLARITY,
> > +
> > +	MSA311_INT_SET_0 =3D 0x16,
> > +	MSA311_INT_SET_1,
> > +
> > +	MSA311_INT_MAP_0 =3D 0x19,
> > +	MSA311_INT_MAP_1,
> > +
> > +	MSA311_INT_CONFIG =3D 0x20,
> > +	MSA311_INT_LATCH,
> > +	MSA311_FREEFALL_DUR,
> > +	MSA311_FREEFALL_TH,
> > +	MSA311_FREEFALL_HY,
> > +
> > +	MSA311_ACTIVE_DUR =3D 0x27,
> > +	MSA311_ACTIVE_TH,
> > +
> > +	MSA311_TAP_DUR =3D 0x2A,
> > +	MSA311_TAP_TH,
> > +	MSA311_ORIENT_HY,
> > +	MSA311_Z_BLOCK,
> > +
> > +	MSA311_OFFSET_X =3D 0x38,
> > +	MSA311_OFFSET_Y,
> > +	MSA311_OFFSET_Z,
> > +
> > +	MSA311_MAX_REGS,
> > +};
> > +
> > +enum msa311_fields {
> > +	F_SOFT_RESET_I2C, F_SOFT_RESET_SPI,
> > +
> > +	F_PARTID,
> > +
> > +	F_ACC_X_LSB, F_ACC_X_MSB,
> > +
> > +	F_ACC_Y_LSB, F_ACC_Y_MSB,
> > +
> > +	F_ACC_Z_LSB, F_ACC_Z_MSB,
> > +
> > +	F_ORIENT_INT, F_S_TAP_INT, F_D_TAP_INT, F_ACTIVE_INT, F_FREEFALL_INT,
> > +
> > +	F_NEW_DATA_INT,
> > +
> > +	F_TAP_SIGN, F_TAP_FIRST_X, F_TAP_FIRST_Y, F_TAP_FIRST_Z, F_ACTV_SIGN,
> > +	F_ACTV_FIRST_X, F_ACTV_FIRST_Y, F_ACTV_FIRST_Z,
> > +
> > +	F_ORIENT_Z, F_ORIENT_X_Y,
> > +
> > +	F_FS,
> > +
> > +	F_X_AXIS_DIS, F_Y_AXIS_DIS, F_Z_AXIS_DIS, F_ODR,
> > +
> > +	F_PWR_MODE, F_LOW_POWER_BW,
> > +
> > +	F_X_POLARITY, F_Y_POLARITY, F_Z_POLARITY, F_X_Y_SWAP,
> > +
> > +	F_ORIENT_INT_EN, F_S_TAP_INT_EN, F_D_TAP_INT_EN, F_ACTIVE_INT_EN_Z,
> > +	F_ACTIVE_INT_EN_Y, F_ACTIVE_INT_EN_X,
> > +
> > +	F_NEW_DATA_INT_EN, F_FREEFALL_INT_EN,
> > +
> > +	F_INT1_ORIENT, F_INT1_S_TAP, F_INT1_D_TAP, F_INT1_ACTIVE,
> > +	F_INT1_FREEFALL,
> > +
> > +	F_INT1_NEW_DATA,
> > +
> > +	F_INT1_OD, F_INT1_LVL,
> > +
> > +	F_RESET_INT, F_LATCH_INT,
> > +
> > +	F_FREEFALL_DUR,
> > +
> > +	F_FREEFALL_TH,
> > +
> > +	F_FREEFALL_MODE, F_FREEFALL_HY,
> > +
> > +	F_ACTIVE_DUR,
> > +
> > +	F_ACTIVE_TH,
> > +
> > +	F_TAP_QUIET, F_TAP_SHOCK, F_TAP_DUR,
> > +
> > +	F_TAP_TH,
> > +
> > +	F_ORIENT_HYST, F_ORIENT_BLOCKING, F_ORIENT_MODE,
> > +
> > +	F_Z_BLOCKING,
> > +
> > +	F_OFFSET_X, F_OFFSET_Y, F_OFFSET_Z,
> > +
> > +	F_MAX_FIELDS,
> > +};
> > +
> > +static const struct reg_field msa311_reg_fields[] =3D {
> > +	/*
> > +	 * Soft Reset
>=20
> Name of field is clear from the code, so don't repeat.
>=20

Ack

> > +	 *
> > +	 * 0:soft reset disable, 1:soft reset enable
>=20
> I would try to keep the documentation minimal as some of this is
> obvious from the naming.  For instance, if a field is called
> SOFT_RESET then assuption is write 1 causes a reset.
>=20
> Documentation is good, but too much documentation just adds
> noise when people are reviewing and has a habit of becoming
> wrong over time.
>=20

I take your point. In the v2 patchset I'll collapse such documentation.

> > +	 */
> > +	[F_SOFT_RESET_I2C] =3D REG_FIELD(MSA311_SOFT_RESET, 2, 2),
> > +	[F_SOFT_RESET_SPI] =3D REG_FIELD(MSA311_SOFT_RESET, 5, 5),
> > +
> > +	/*
> > +	 * Part ID
> > +	 *
> > +	 * Default: 0x13
> > +	 */
> > +	[F_PARTID] =3D REG_FIELD(MSA311_PARTID, 0, 7),
>=20
> That's the whole register. What benefit is there in treating it
> like a field?
>=20

Actually, I wanted to generalize access to registers with and w/o
fields in one way. That's why I use REG_FIELD for all types of registers.
Do you think this is a bad idea and overengineering?

> > +
> > +	/*
> > +	 * X_axis Data LSB/MSB
> > +	 *
> > +	 * ACC_X =3D (ACC_X_MSB[7:0] << 4) | ACC_X_LSB[7:4]
> > +	 */
> > +	[F_ACC_X_LSB] =3D REG_FIELD(MSA311_ACC_X_LSB, 4, 7),
> > +	[F_ACC_X_MSB] =3D REG_FIELD(MSA311_ACC_X_MSB, 0, 7),
>=20
> Using fields for these two registers make it harder to see
> what is going on in the code. I would access them as whole
> registers and you should be able to do a bulk read to get
> them both followed by endian conversion.
>=20

Ack, I provide more detailed answer below

> > +
> > +	/*
> > +	 * Y_axis Data LSB/MSB
> > +	 * ACC_Y =3D (ACC_Y_MSB[7:0] << 4) | ACC_Y_LSB[7:4]
> > +	 */
> > +	[F_ACC_Y_LSB] =3D REG_FIELD(MSA311_ACC_Y_LSB, 4, 7),
> > +	[F_ACC_Y_MSB] =3D REG_FIELD(MSA311_ACC_Y_MSB, 0, 7),
> > +
> > +	/*
> > +	 * Z_axis Data LSB/MSB
> > +	 *
> > +	 * ACC_Z =3D (ACC_Z_MSB[7:0] << 4) | ACC_Z_LSB[7:4]
> > +	 */
> > +	[F_ACC_Z_LSB] =3D REG_FIELD(MSA311_ACC_Z_LSB, 4, 7),
> > +	[F_ACC_Z_MSB] =3D REG_FIELD(MSA311_ACC_Z_MSB, 0, 7),
> > +
> > +	/*
> > +	 * Motion Interrupt
> > +	 *
> > +	 * ORIENT_INT: orientation interrupt status, 0: inactive, 1: active
>=20
> As it's a status field it would be very odd if 0 meant inactive, so I thi=
nk
> you can drop that element.  Naming of field should also provide enough
> information that the comemnts aren't adding much.
>=20

As I mentioned in the above comments, I'll rework documentation part

> > +	 * S_TAP_INT: single tap interrupt status, 0: inactive, 1: active
> > +	 * D_TAP_INT: double tap interrupt status, 0: inactive, 1: active
> > +	 * ACTIVE_INT: active interrupt status, 0: inactive, 1: active
> > +	 * FREEFALL_INT: freefall interrupt status, 0: inactive, 1: active
> > +	 */
> > +	[F_ORIENT_INT] =3D REG_FIELD(MSA311_MOTION_INT, 6, 6),
> > +	[F_S_TAP_INT] =3D REG_FIELD(MSA311_MOTION_INT, 5, 5),
> > +	[F_D_TAP_INT] =3D REG_FIELD(MSA311_MOTION_INT, 4, 4),
> > +	[F_ACTIVE_INT] =3D REG_FIELD(MSA311_MOTION_INT, 2, 2),
> > +	[F_FREEFALL_INT] =3D REG_FIELD(MSA311_MOTION_INT, 0, 0),
> > +
> > +	/*
> > +	 * Data Interrupt
> > +	 *
> > +	 * NEW_DATA_INT: new data interrupt status, 0: inactive,1: active
> > +	 */
> > +	[F_NEW_DATA_INT] =3D REG_FIELD(MSA311_DATA_INT, 0, 0),
> > +
> > +	/*
> > +	 * Tap Active Status
> > +	 *
> > +	 * TAP_SIGN: sign of tap triggering signal, 0 : positive, 1: negative
>=20
> These are less obvious to me, so good to document.
>=20

I need to re-check it during implementation of TAP events.
Maybe this is a bug in the datasheet, so I need to test it experimentally.
I think it would be better to delete such comment in the v2 and
add it in the next patchsets after the TAP events feature is done.

> > +	 * TAP_FIRST_X: tap interrupt triggered by x axis,
> > +	 *              1:positive, 0:negative
>=20
> However, I'm not sure we need to call out 1:positive etc for each of them=
 as
> that bit is fairly obvious.
>=20

Ack

> > +	 * TAP_FIRST_Y: tap interrupt triggered by y axis,
> > +	 *              1:positive, 0:negative
> > +	 * TAP_FIRST_Z: tap interrupt triggered by z axis,
> > +	 *              1:positive, 0:negative
> > +	 * ACTIVE_SIGN: sign of active interrupt, 0: positive, 1: negative
> > +	 * ACTIVE_FIRST_X: active interrupt triggered by x axis,
> > +	 *                 1:positive, 0:negative
> > +	 * ACTIVE_FIRST_Y: active interrupt triggered by y axis,
> > +	 *                 1:positive, 0:negative
> > +	 * ACTIVE_FIRST_Z: active interrupt triggered by z axis,
> > +	 *                 1:positive, 0:negative
> > +	 */
> > +	[F_TAP_SIGN] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS, 7, 7),
> > +	[F_TAP_FIRST_X] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS, 6, 6),
> > +	[F_TAP_FIRST_Y] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS, 5, 5),
> > +	[F_TAP_FIRST_Z] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS, 4, 4),
> > +	[F_ACTV_SIGN] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS, 3, 3),
> > +	[F_ACTV_FIRST_X] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS, 2, 2),
> > +	[F_ACTV_FIRST_Y] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS, 1, 1),
> > +	[F_ACTV_FIRST_Z] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS, 0, 0),
> > +
> > +	/*
> > +	 * Orientation Status
> > +	 *
> > +	 * ORIENT[2]: orientation value of z axis,
> > +	 *            0:upward looking, 1:downward looking
> > +	 * ORIENT[1:0]: orientation value of x/y axes
> > +	 *              00: portrait upright
> > +	 *              01: portrait upside down
> > +	 *              10: landscape left,
> > +	 *              11: landscape right
> > +	 */
> > +	[F_ORIENT_Z] =3D REG_FIELD(MSA311_ORIENT_STS, 6, 6),
> > +	[F_ORIENT_X_Y] =3D REG_FIELD(MSA311_ORIENT_STS, 4, 5),
> > +
> > +	/*
> > +	 * Acceleration Range
> > +	 *
> > +	 * FS[1:0]: acceleration range of x/y/z axes,
> > +	 *          00:+/-2g, 01:+/-4g, 10:+/-8g, 11:+/-16g
> > +	 *
> > +	 * Axis data is 12-bit signed value, so
> > +	 *
> > +	 * fs0 =3D (2 + 2) * 9.81 / (2<<11) =3D 0.009580
> > +	 * fs1 =3D (4 + 4) * 9.81 / (2<<11) =3D 0.019160
> > +	 * fs2 =3D (8 + 8) * 9.81 / (2<<11) =3D 0.038320
> > +	 * fs3 =3D (16 + 16) * 9.81 / (2<<11) =3D 0.076641
>=20
> I would move this information to alongside the scale control
> code rather than here.
>=20

Ack

> > +	 */
> > +	[F_FS] =3D REG_FIELD(MSA311_RANGE, 0, 1),
> > +
> > +	/*
> > +	 * Output Data Rate
> > +	 *
> > +	 * X_AXIS_DIS: 0: enable, 1: disable
> > +	 * Y_AXIS_DIS: 0: enable, 1: disable
> > +	 * Z_AXIS_DIS: 0: enable, 1: disable
> > +	 * ODR[3:0]: 0000: 1Hz (not available in normal mode)
> > +	 *           0001: 1.95Hz (not available in normal mode)
> > +	 *           0010: 3.9Hz
> > +	 *           0011: 7.81Hz
> > +	 *           0100: 15.63Hz
> > +	 *           0101: 31.25Hz
> > +	 *           0110: 62.5Hz
> > +	 *           0111: 125Hz
> > +	 *           1000: 250Hz
> > +	 *           1001: 500Hz (not available in low power mode)
> > +	 *           1010-1111:1000hz (not available in low power mode)
> This documentation is repeated below. No need to have it here as well.
>=20

Ack

> > +	 */
> > +	[F_X_AXIS_DIS] =3D REG_FIELD(MSA311_ODR, 7, 7),
> > +	[F_Y_AXIS_DIS] =3D REG_FIELD(MSA311_ODR, 6, 6),
> > +	[F_Z_AXIS_DIS] =3D REG_FIELD(MSA311_ODR, 5, 5),
> > +	[F_ODR] =3D REG_FIELD(MSA311_ODR, 0, 3),
> > +
> > +	/*
> > +	 * Power Mode/Bandwidth
> > +	 *
> > +	 * PWR_MODE: 00: normal mode, 01: low power mode, 11: suspend mode
> > +	 * LOW_POWER_BW[3:0]: 0000-0010: 1.95Hz
> > +	 *                    0011: 3.9Hz
> > +	 *                    0100: 7.81Hz
> > +	 *                    0101: 15.63Hz
> > +	 *                    0110: 31.25Hz
> > +	 *                    0111: 62.5Hz
> > +	 *                    1000: 125Hz
> > +	 *                    1001: 250Hz
> > +	 *                    1010-1111: 500Hz
> > +	 */
> > +	[F_PWR_MODE] =3D REG_FIELD(MSA311_PWR_MODE, 6, 7),
> > +	[F_LOW_POWER_BW] =3D REG_FIELD(MSA311_PWR_MODE, 1, 4),
> > +
> > +	/*
> > +	 * Swap Polarity
> > +	 *
> > +	 * X_POLARITY: the polarity of X axis, 0: not reverse, 1: reverse
> > +	 * Y_POLARITY: the polarity of Y axis, 0: not reverse, 1: reverse
> > +	 * Z_POLARITY: the polarity of Z axis, 0: not reverse, 1: reverse
> > +	 * X_Y_SWAP: output of X/Y axis, 0: not swap, 1: swap
> > +	 */
> > +	[F_X_POLARITY] =3D REG_FIELD(MSA311_SWAP_POLARITY, 3, 3),
> > +	[F_Y_POLARITY] =3D REG_FIELD(MSA311_SWAP_POLARITY, 2, 2),
> > +	[F_Z_POLARITY] =3D REG_FIELD(MSA311_SWAP_POLARITY, 1, 1),
> > +	[F_X_Y_SWAP] =3D REG_FIELD(MSA311_SWAP_POLARITY, 0, 0),
> > +
> > +	/*
> > +	 * Interrupt Set 0
> > +	 *
> > +	 * ORIENT_INT_EN: orient interrupt, 0: disable, 1: enable
> > +	 * S_TAP_INT_EN: single tap interrupt, 0: disable, 1: enable
> > +	 * D_TAP_INT_EN: double tap interrupt, 0: disable, 1: enable
> > +	 * ACTIVE_INT_EN_Z: active interrupt for the z axis,
> > +	 *                  0: disable, 1: enable
> > +	 * ACTIVE_INT_EN_Y: active interrupt for the y axis,
> > +	 *                  0: disable, 1: enable
> > +	 * ACTIVE_INT_EN_X: active interrupt for the x axis,
> > +	 *                  0: disable, 1: enable
> > +	 */
> > +	[F_ORIENT_INT_EN] =3D REG_FIELD(MSA311_INT_SET_0, 6, 6),
> > +	[F_S_TAP_INT_EN] =3D REG_FIELD(MSA311_INT_SET_0, 5, 5),
> > +	[F_D_TAP_INT_EN] =3D REG_FIELD(MSA311_INT_SET_0, 4, 4),
> > +	[F_ACTIVE_INT_EN_Z] =3D REG_FIELD(MSA311_INT_SET_0, 2, 2),
> > +	[F_ACTIVE_INT_EN_Y] =3D REG_FIELD(MSA311_INT_SET_0, 1, 1),
> > +	[F_ACTIVE_INT_EN_X] =3D REG_FIELD(MSA311_INT_SET_0, 0, 0),
> > +
> > +	/*
> > +	 * Interrupt Set 1
> > +	 *
> > +	 * NEW_DATA_INT_EN: new data interrupt, 0: disable, 1: enable
> > +	 * FREEFALL_INT_EN: freefall interrupt, 0: disable, 1: enable
> > +	 */
> > +	[F_NEW_DATA_INT_EN] =3D REG_FIELD(MSA311_INT_SET_1, 4, 4),
> > +	[F_FREEFALL_INT_EN] =3D REG_FIELD(MSA311_INT_SET_1, 3, 3),
> > +
> > +	/*
> > +	 * Interrupt Map 0
> > +	 *
> > +	 * INT1_ORIENT: map orientation interrupt to INT1, 0: disable, 1: ena=
ble
> > +	 * INT1_S_TAP: map single tap interrupt to INT1, 0: disable, 1: enabl=
e
> > +	 * INT1_D_TAP: map double tap interrupt to INT1, 0: disable, 1: enabl=
e
> > +	 * INT1_ACTIVE: map active interrupt to INT1, 0: disable, 1: enable
> > +	 * INT1_FREEFALL: map freefall interrupt to INT1, 0: disable, 1: enab=
le
> > +	 */
> > +	[F_INT1_ORIENT] =3D REG_FIELD(MSA311_INT_MAP_0, 6, 6),
> > +	[F_INT1_S_TAP] =3D REG_FIELD(MSA311_INT_MAP_0, 5, 5),
> > +	[F_INT1_D_TAP] =3D REG_FIELD(MSA311_INT_MAP_0, 4, 4),
> > +	[F_INT1_ACTIVE] =3D REG_FIELD(MSA311_INT_MAP_0, 2, 2),
> > +	[F_INT1_FREEFALL] =3D REG_FIELD(MSA311_INT_MAP_0, 0, 0),
> > +
> > +	/*
> > +	 * Interrupt Map 1
> > +	 *
> > +	 * INT1_NEW_DATA: map new data interrupt to INT1, 0: disable, 1: enab=
le
> > +	 */
> > +	[F_INT1_NEW_DATA] =3D REG_FIELD(MSA311_INT_MAP_1, 0, 0),
> > +
> > +	/*
> > +	 * Interrupt Config
> > +	 *
> > +	 * INT1_OD: select output for INT1, 0: push-pull, 1: open-drain
> > +	 * INT1_LVL: select active level for INT1, 0: low, 1: high
> > +	 */
> > +	[F_INT1_OD] =3D REG_FIELD(MSA311_INT_CONFIG, 1, 1),
> > +	[F_INT1_LVL] =3D REG_FIELD(MSA311_INT_CONFIG, 0, 0),
> > +
> > +	/*
> > +	 * Interrupt Latch
> > +	 *
> > +	 * RESET_INT: reset or not,
> > +	 *            1: reset all latched interrupt,
> > +	 *            0: not reset all latched interrupt
> > +	 * LATCH_INT[3:0]: 0000: non-latched
> > +	 *                 0001: temporary latched 250ms
>=20
> I'd prefer to see this as a set of suitably named defines
> rather than as comments.
>=20

It's already located below in the enum
+/* Latch INT modes */
+enum {
+	MSA311_LATCH_INT_NOT_LATCHED,
+	MSA311_LATCH_INT_250MS,
+	MSA311_LATCH_INT_500MS,
+	MSA311_LATCH_INT_1S,
+	MSA311_LATCH_INT_2S,
+	MSA311_LATCH_INT_4S,
+	MSA311_LATCH_INT_8S,
+	MSA311_LATCH_INT_1MS =3D 0xA,
+	MSA311_LATCH_INT_2MS,
+	MSA311_LATCH_INT_25MS,
+	MSA311_LATCH_INT_50MS,
+	MSA311_LATCH_INT_100MS,
+	MSA311_LATCH_INT_LATCHED,
+};
I'll delete duplicated information from comment then

> > +	 *                 0010: temporary latched 500ms
> > +	 *                 0011: temporary latched 1s
> > +	 *                 0100: temporary latched 2s
> > +	 *                 0101: temporary latched 4s
> > +	 *                 0110: temporary latched 8s
> > +	 *                 0111: latched
> > +	 *                 1000: non-latched
> > +	 *                 1001: temporary latched 1ms
> > +	 *                 1010: temporary latched 1ms
> > +	 *                 1011: temporary latched 2ms
> > +	 *                 1100: temporary latched 25ms
> > +	 *                 1101: temporary latched 50ms
> > +	 *                 1110: temporary latched 100ms
> > +	 *                 1111: latched
> > +	 */
> > +	[F_RESET_INT] =3D REG_FIELD(MSA311_INT_LATCH, 7, 7),
> > +	[F_LATCH_INT] =3D REG_FIELD(MSA311_INT_LATCH, 0, 3),
> > +
> > +	/*
> > +	 * Freefall Duration
> > +	 *
> > +	 * FREEFALL_DUR[7:0]: delay_time is (FREEFALL_DUR[7:0] + 1) * 2ms,
> > +	 *                    range from 2ms to 512ms,
> > +	 *                    the default delay time is 20ms
>=20
> Again, I don't see benefit in fields when they cover the whole registers.
>=20

The main idea was reg access generalization and reg/fields enumeration
in one place. In other words, this is a style feature.

> > +	 */
> > +	[F_FREEFALL_DUR] =3D REG_FIELD(MSA311_FREEFALL_DUR, 0, 7),
> > +
> > +	/*
> > +	 * Freefall Threshold
> > +	 *
> > +	 * FREEFALL_TH[7:0]: threshold value is freefall_th[7:0] * 7.81mg,
> > +	 *                   default value is 375mg
> > +	 */
> > +	[F_FREEFALL_TH] =3D REG_FIELD(MSA311_FREEFALL_TH, 0, 7),
> > +
> > +	/*
> > +	 * Freefall Hysteresis
> > +	 *
> > +	 * FREEFALL_MODE: 0: single mode, 1: sum_mode
> > +	 * FREEFALL_HY[1:0]: freefall hysteresis time is
> > +	 *                   FREEFALL_HY[1:0] * 125mg
> > +	 */
> > +	[F_FREEFALL_MODE] =3D REG_FIELD(MSA311_FREEFALL_HY, 2, 2),
> > +	[F_FREEFALL_HY] =3D REG_FIELD(MSA311_FREEFALL_HY, 0, 1),
> > +
> > +	/*
> > +	 * Active Duration Time
> > +	 *
> > +	 * ACTIVE_DUR[1:0]: active duration time is (ACTIVE_DUR[1:0] + 1)ms
> > +	 */
> > +	[F_ACTIVE_DUR] =3D REG_FIELD(MSA311_ACTIVE_DUR, 0, 1),
> > +
> > +	/*
> > +	 * Active Interrupt Threshold
> > +	 *
> > +	 * ACTIVE_TH[7:0]: threshold of active interrupt
> > +	 *                 3.91mg/LSB (2g range)
> > +	 *                 7.81mg/LSB (4g range)
> > +	 *                 15.625mg/LSB (8g range)
> > +	 *                 31.25mg/LSB (16g range)
> > +	 */
> > +	[F_ACTIVE_TH] =3D REG_FIELD(MSA311_ACTIVE_TH, 0, 7),
> > +
> > +	/*
> > +	 * Tap Duration
> > +	 *
> > +	 * TAP_QUIET: 0: tap quiet duration 30ms, 1: tap quiet duration 20ms
> > +	 * TAP_SHOCK: 0: tap shock duration 50ms, 1: tap shock duration 70ms
> > +	 * TAP_DUR[2:0]: selects the length of the time window for the
> > +	 *               second shock
> > +	 *               000: 50ms
> > +	 *               001:100ms
> > +	 *               010:150ms
> > +	 *               011:200ms
> > +	 *               100:250ms
> > +	 *               101:375ms
> > +	 *               110:500ms
> > +	 *               111:700ms
> > +	 */
> > +	[F_TAP_QUIET] =3D REG_FIELD(MSA311_TAP_DUR, 7, 7),
> > +	[F_TAP_SHOCK] =3D REG_FIELD(MSA311_TAP_DUR, 6, 6),
> > +	[F_TAP_DUR] =3D REG_FIELD(MSA311_TAP_DUR, 0, 2),
> > +
> > +	/*
> > +	 * Tap Interrupt Threshold
> > +	 *
> > +	 * TAP_TH[4:0]: threshold of tap interrupt.
> > +	 *              62.5mg/LSB(2g range)
> > +	 *              125mg/LSB(4g range)
> > +	 *              250mg/LSB(8g range)
> > +	 *              500mg/LSB(16g range)
> > +	 */
> > +	[F_TAP_TH] =3D REG_FIELD(MSA311_TAP_TH, 0, 4),
> > +
> > +	/*
> > +	 * Orientation Hysteresis
> > +	 *
> > +	 * ORIENT_HYST[2:0]: set the hysteresis of the orientation interrupt,
> > +	 *                   1LSB is 62.5mg.
> > +	 * ORIENT_BLOCKING[1:0]: select the block mode
> > +	 *                       00: no blocking
> > +	 *                       01: z_axis blocking
> > +	 *                       10: z_axis blocking or slope in any axis > 0=
.2g
> > +	 *                       11: no blocking
> > +	 * ORIENT_MODE[1:0]: set the thresholds
> > +	 *                   00: symmetrical
> > +	 *                   01: high-asymmetrical
> > +	 *                   10: low-asymmetrical
> > +	 *                   11: symmetrical
> > +	 */
> > +	[F_ORIENT_HYST] =3D REG_FIELD(MSA311_ORIENT_HY, 4, 6),
> > +	[F_ORIENT_BLOCKING] =3D REG_FIELD(MSA311_ORIENT_HY, 2, 3),
> > +	[F_ORIENT_MODE] =3D REG_FIELD(MSA311_ORIENT_HY, 0, 1),
> > +
> > +	/*
> > +	 * ACC_Z block
> > +	 *
> > +	 * Z_BLOCKING[3:0]: defines the block acc_z between 0g to 0.9375g
> > +	 */
> > +	[F_Z_BLOCKING] =3D REG_FIELD(MSA311_Z_BLOCK, 0, 3),
> > +
> > +	/*
> > +	 * Offset Compensation
> > +	 *
> > +	 * OFFSET_X[7:0]: the offset compensation value for X axis,
> > +	 *                1LSB is 3.9mg
> > +	 * OFFSET_Y[7:0]: the offset compensation value for Y axis,
> > +	 *                1LSB is 3.9mg
> > +	 * OFFSET_Z[7:0]: the offset compensation value for Z axis,
> > +	 *                1LSB is 3.9mg
> > +	 */
> > +	[F_OFFSET_X] =3D REG_FIELD(MSA311_OFFSET_X, 0, 7),
> > +	[F_OFFSET_Y] =3D REG_FIELD(MSA311_OFFSET_Y, 0, 7),
> > +	[F_OFFSET_Z] =3D REG_FIELD(MSA311_OFFSET_Z, 0, 7),
>=20
> Note I've only commented on some of these, but many of the comments apply
> in multiple places.
>=20

Okay, I can rework the whole registers access to reg API instead of
fields API, but actually I don't see any benefits except code style.

> > +};
> > +
> > +#define MSA311_WHO_AM_I 0x13
> > +
> > +/* Possible Full Scale ranges */
> > +enum {
> > +	MSA311_FS_2G,
> > +	MSA311_FS_4G,
> > +	MSA311_FS_8G,
> > +	MSA311_FS_16G,
> > +};
> > +
> > +#define msa311_fs_available "0.009580 0.019160 0.038320 0.076641"
> > +static const int msa311_fs_table[] =3D { 9580, 19160, 38320, 76641 };
> > +
> > +/* Possible Output Data Rate values */
>=20
> These don't seem to be all supported currently.  So remove the ones that
> aren't until you have the mode handling in place (or maybe I'm missing so=
mething...)
>=20

Nope, all ODR values are supported currently, but it's not necessary
handling all of them from the code. I handle only special cases, like
ODR limitations in the different power modes. Normal ODR values are
installed from the IIO userspace stack.

> > +enum {
> > +	MSA311_ODR_1_HZ,
> > +	MSA311_ODR_1_95_HZ,
> > +	MSA311_ODR_3_9_HZ,
> > +	MSA311_ODR_7_81_HZ,
> > +	MSA311_ODR_15_63_HZ,
> > +	MSA311_ODR_31_25_HZ,
> > +	MSA311_ODR_62_5_HZ,
> > +	MSA311_ODR_125_HZ,
> > +	MSA311_ODR_250_HZ,
> > +	MSA311_ODR_500_HZ,
> > +	MSA311_ODR_1000_HZ,
> > +};
> > +
> > +#define msa311_odr_available "1 1.95 3.9 7.81 15.63 31.25 62.5 125 250=
 500 1000"
> > +static const struct {
> > +	int val;
> > +	int val2;
> > +} msa311_odr_table[] =3D {
> > +	{1, 0}, {1, 950000}, {3, 900000}, {7, 810000}, {15, 630000},
> > +	{31, 250000}, {62, 500000}, {125, 0}, {250, 0}, {500, 0}, {1000, 0}
> > +};
> > +
> > +/* All Power Modes */
> > +enum {
> > +	MSA311_PWR_MODE_NORMAL,
> > +	MSA311_PWR_MODE_LOW,
> > +	MSA311_PWR_MODE_SUSPEND =3D 0x3,
>=20
> Given the gap, I would suggest setting all values explicitly.
>=20

I will try it out in the v2 patch for all enums with gaps.

> > +};
> > +
> > +#define MSA311_PWR_SLEEP_DELAY_MS 2000 /* Autosuspend delay */
> > +
> > +/* Possible INT1 types and levels */
> > +enum {
> > +	MSA311_INT1_OD_PUSH_PULL,
> > +	MSA311_INT1_OD_OPEN_DRAIN,
> > +};
> > +
> > +enum {
> > +	MSA311_INT1_LVL_LOW,
> > +	MSA311_INT1_LVL_HIGH,
> > +};
> > +
> > +/* Latch INT modes */
> > +enum {
> > +	MSA311_LATCH_INT_NOT_LATCHED,
> > +	MSA311_LATCH_INT_250MS,
> > +	MSA311_LATCH_INT_500MS,
> > +	MSA311_LATCH_INT_1S,
> > +	MSA311_LATCH_INT_2S,
> > +	MSA311_LATCH_INT_4S,
> > +	MSA311_LATCH_INT_8S,
> > +	MSA311_LATCH_INT_1MS =3D 0xA,
> > +	MSA311_LATCH_INT_2MS,
> > +	MSA311_LATCH_INT_25MS,
> > +	MSA311_LATCH_INT_50MS,
> > +	MSA311_LATCH_INT_100MS,
> > +	MSA311_LATCH_INT_LATCHED,
> > +};
> > +
> > +/* Readonly MSA311 registers */
> > +static const struct regmap_range msa311_readonly_registers[] =3D {
> > +	regmap_reg_range(MSA311_PARTID, MSA311_ORIENT_STS),
> > +};
> > +
> > +static const struct regmap_access_table msa311_writeable_table =3D {
> > +	.no_ranges =3D msa311_readonly_registers,
> > +	.n_no_ranges =3D ARRAY_SIZE(msa311_readonly_registers),
> > +};
> > +
> > +/* Writeonly MSA311 registers */
> > +static const struct regmap_range msa311_writeonly_registers[] =3D {
> > +	regmap_reg_range(MSA311_SOFT_RESET, MSA311_SOFT_RESET),
> > +};
> > +
> > +static const struct regmap_access_table msa311_readable_table =3D {
> > +	.no_ranges =3D msa311_writeonly_registers,
> > +	.n_no_ranges =3D ARRAY_SIZE(msa311_writeonly_registers),
> > +};
> > +
> > +/* Volatile MSA311 registers, they will not be cached in the regmap rb=
tree */
> > +static const struct regmap_range msa311_volatile_registers[] =3D {
> > +	regmap_reg_range(MSA311_ACC_X_LSB, MSA311_ORIENT_STS),
> > +};
> > +
> > +static const struct regmap_access_table msa311_volatile_table =3D {
> > +	.yes_ranges =3D msa311_volatile_registers,
> > +	.n_yes_ranges =3D ARRAY_SIZE(msa311_volatile_registers),
> > +};
> > +
> > +/*
> > + * MSA311 regmap definition, supports readonly, writeonly registers,
> > + * rbtree cache with certain volatile registers
>=20
> What does this comment add given the structure elements make most of this
> immediately clear? I would drop the comment.
>=20

Ack

> > + */
> > +static const struct regmap_config msa311_regmap_config =3D {
> > +	.name =3D MSA311_DRV_NAME,
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +	.max_register =3D MSA311_OFFSET_Z,
> > +	.wr_table =3D &msa311_writeable_table,
> > +	.rd_table =3D &msa311_readable_table,
> > +	.volatile_table =3D &msa311_volatile_table,
> > +	.cache_type =3D REGCACHE_RBTREE,
> > +};
> > +
> > +/**
> > + * MSA311_GENMASK() - MSA311 reg_field mask generator
> > + *
> > + * @field: requested regfield from msa311_reg_fields table
> > + *
> > + * @return: This helper returns reg_field mask to be applied.
> > + */
> > +#define MSA311_GENMASK(field) ({                \
> > +	typeof(field) _field =3D (field);       \
> > +	GENMASK(msa311_reg_fields[_field].msb,  \
> > +		msa311_reg_fields[_field].lsb); \
> > +})
> > +
> > +/**
> > + * struct msa311_priv - MSA311 internal private state
> > + * @i2c: I2C client object
> > + * @lock: State guard
>=20
> What state?  Need to be very clear what this covers.  There doesn't seem
> to be a lot of state to guard.  Possibly it's about read modify write
> cycles, but that's not what this implies.
>=20

This lock mainly protects register access from different processes.
We can access different registers during several userspace actions,
like iio_readdev, iio_attr, iio_reg, etc.
I've checked regmap code more careful and saw regmap_lock abstraction.
Looks like it should be enough for me, so I can delete this one and use
regmap_lock instead.

> > + * @new_data_trig: Optional NEW_DATA interrupt driven trigger used
> > + *                 to notify external consumers a new sample is ready
> > + * @new_data_trig_enabled: NEW_DATA interrupt driver trigger state,
> > + *                         can be changed by trigger->ops->set_trigger=
_state()
> > + * @regs: Underlying I2C bus adapter used to abstract slave
> > + *        register accesses
> > + * @fields: Abstract objects for each registers fields access
> > + */
> > +struct msa311_priv {
> > +	struct i2c_client *i2c;
> > +	struct mutex lock; /* state guard */
> > +
> > +	struct iio_trigger *new_data_trig;
> > +	bool new_data_trig_enabled;
> > +
> > +	struct regmap *regs;
> > +	struct regmap_field *fields[F_MAX_FIELDS];
> > +};
> > +
> > +/**
> > + * struct msa311_axis - MSA311 axis decriptor
> > + * @lsb: LSB regmap_field object
> > + * @msb: MSB regmap_field object
> > + */
> > +struct msa311_axis {
> > +	struct regmap_field *lsb;
> > +	struct regmap_field *msb;
> > +};
> > +
> > +/* Channels */
> > +
> > +enum msa311_si {
> > +	MSA311_SI_X,
> > +	MSA311_SI_Y,
> > +	MSA311_SI_Z,
> > +	MSA311_SI_TIMESTAMP,
> > +	MSA311_SI_NONE =3D -1,
>=20
> SI_NONE isn't used so drop it.
>=20

Ack

> > +};
> > +
> > +/**
> > + * MSA311_ACCEL_CHANNEL() - Construct MSA311 accelerometer channel des=
criptor
> > + *
> > + * @axis: axis name in uppercase
> > + */
> > +#define MSA311_ACCEL_CHANNEL(axis) {                           \
> > +	.type =3D IIO_ACCEL,                                     \
> > +	.modified =3D 1,                                         \
> > +	.channel2 =3D IIO_MOD_##axis,                            \
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),          \
> > +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) | \
> > +				BIT(IIO_CHAN_INFO_SAMP_FREQ),  \
> > +	.scan_index =3D MSA311_SI_##axis,                        \
> > +	.scan_type =3D {                                         \
> > +		.sign =3D 's',                                   \
> > +		.realbits =3D 12,                                \
> > +		.storagebits =3D 16,                             \
> > +		.shift =3D 4,                                    \
> > +		.endianness =3D IIO_LE,                          \
>=20
> Looks like you are unwinding the endianness of the data in the driver. Yo=
u
> should not be doing that.
>=20

Do you mean it's better to just apply IIO_CPU type and IIO core will
resolve this question automatically?
I'm talking about the function iio_show_fixed_type() from
drivers/iio/industrialio-buffer.c.

> > +	},                                                     \
> > +	.datasheet_name =3D "ACC_"#axis                          \
> > +}
> > +
> > +/**
> > + * MSA311_TIMESTAMP_CHANNEL() - Construct MSA311 timestamp channel des=
criptor
> > + */
> > +#define MSA311_TIMESTAMP_CHANNEL() IIO_CHAN_SOFT_TIMESTAMP(MSA311_SI_T=
IMESTAMP)
> > +
> > +static const struct iio_chan_spec msa311_channels[] =3D {
> > +	MSA311_ACCEL_CHANNEL(X),
> > +	MSA311_ACCEL_CHANNEL(Y),
> > +	MSA311_ACCEL_CHANNEL(Z),
> > +	MSA311_TIMESTAMP_CHANNEL(),
> > +};
> > +
> > +/* Attributes */
> > +
> > +/* Full Scale Range */
> > +static IIO_CONST_ATTR(in_accel_scale_available, msa311_fs_available);
> > +
> > +/* Output Data Rate */
> > +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(msa311_odr_available);
> > +
> > +static struct attribute *msa311_attrs[] =3D {
> > +	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
> > +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>=20
> Please change over to using the read_avail() callback and
> info_mask_*_avail bitmaps.
>=20
> Where possible we avoid doing these by hand as then they can't be
> used by consumer drivers in kernel (or not in a standard way at least!)
>=20
> You have appropriate tables already so it shouldn't add much code and
> avoids duplication of the list of values.
>=20

I see, thank you for the suggestion, will change it in the v2 then.

> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group msa311_attr_group =3D {
> > +	.attrs =3D msa311_attrs,
> > +};
> > +
> > +/**
> > + * msa311_get_odr() - Read Output Data Rate (ODR) value from MSA311 ac=
cel
> > + *
> > + * @msa311: MSA311 internal private state
> > + * @odr: output ODR value
> > + *
> > + * This function should be called under msa311->lock.
> > + * It filters the same 1000Hz ODR register values based on datasheet i=
nfo.
> > + * ODR can be equal to 1010-1111 for 1000Hz, but function returns 1010
> > + * all the time.
>=20
> I would move this comment down to where you do the clamping in the code.
>=20

Ack

> > + *
> > + * @return: 0 on success, -ERRNO in other failures
> > + */
> > +static inline int msa311_get_odr(struct msa311_priv *msa311, unsigned =
int *odr)
> > +{
> > +	int err;
> > +
> > +	err =3D regmap_field_read(msa311->fields[F_ODR], odr);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev, "failed to read odr value (%d)\n",
> > +			err);
> > +		return err;
> > +	}
> > +
> > +	/* Filter same ODR values */
> > +	if (*odr > MSA311_ODR_1000_HZ)
> > +		*odr =3D MSA311_ODR_1000_HZ;
> > +
> > +	return err;
> > +}
> > +
> > +/**
> > + * msa311_set_odr() - Setup Output Data Rate (ODR) value for MSA311 ac=
cel
> > + *
> > + * @msa311: MSA311 internal private state
> > + * @odr: requested ODR value
> > + *
> > + * This function should be called under msa311->lock. Possible ODR val=
ues:
> > + *     - 1Hz (not available in normal mode)
> > + *     - 1.95Hz (not available in normal mode)
> > + *     - 3.9Hz
> > + *     - 7.81Hz
> > + *     - 15.63Hz
> > + *     - 31.25Hz
> > + *     - 62.5Hz
> > + *     - 125Hz
> > + *     - 250Hz
> > + *     - 500Hz (not available in low power mode)
> > + *     - 1000Hz (not available in low power mode)
> > + *
> > + * @return: 0 on success, -EINVAL for bad ODR value in the certain pow=
er mode,
> > + *          -ERRNO in other failures
> > + */
> > +static inline int msa311_set_odr(struct msa311_priv *msa311, unsigned =
int odr)
> > +{
> > +	const char *mode =3D NULL;
> > +	unsigned int pwr_mode;
> > +	bool good_odr =3D false;
> > +	int err;
> > +
> > +	err =3D regmap_field_read(msa311->fields[F_PWR_MODE], &pwr_mode);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev, "failed to read pwr_mode (%d)\n",
> > +			err);
> > +		return err;
> > +	}
> > +
> > +	/* Filter bad ODR values */
> > +	switch (pwr_mode) {
> > +	case MSA311_PWR_MODE_LOW:
>=20
> I can't see where the mode is set to LOW. As such, perhaps this is suppor=
t
> to add later?
>=20

I'm not sure we will use LOW mode for any flow. Do you think LOW pwr
mode should fall through to unknown default branch?

> > +		mode =3D "low";
> > +		good_odr =3D (odr < MSA311_ODR_500_HZ);
> > +		break;
> > +	case MSA311_PWR_MODE_NORMAL:
> > +		mode =3D "normal";
> > +		good_odr =3D (odr > MSA311_ODR_1_95_HZ);
> > +		break;
> > +	case MSA311_PWR_MODE_SUSPEND:
> > +		mode =3D "suspend";
> > +		break;
> > +	default:
> > +		mode =3D "unknown";
> > +		break;
> > +	}
> > +
> > +	if (!good_odr) {
> > +		dev_err(&msa311->i2c->dev,
> > +			"failed to set odr %u.%uHz, not available in %s mode\n",
> > +			msa311_odr_table[odr].val,
> > +			msa311_odr_table[odr].val2 / 1000, mode);
> > +		return -EINVAL;
> > +	}
> > +
> > +	err =3D regmap_field_write(msa311->fields[F_ODR], odr);
> > +	if (err)
> > +		dev_err(&msa311->i2c->dev, "failed to set odr value (%d)\n",
> > +			err);
> > +
> > +	return err;
> > +}
> > +
> > +/**
> > + * msa311_wait_for_next_data() - Wait next accel data available after =
resume
> > + *
> > + * @msa311: MSA311 internal private state
> > + *
> > + * @return: 0 on success, -EINTR if msleep() was interrupted,
> > + *          -ERRNO in other failures
> > + */
> > +static int msa311_wait_for_next_data(struct msa311_priv *msa311)
> > +{
> > +	static const int unintr_thresh_ms =3D 20;
> > +	unsigned int odr;
> > +	unsigned long wait_ms;
> > +	unsigned long freq_uhz;
> > +	int err;
> > +
> > +	err =3D msa311_get_odr(msa311, &odr);
> > +	if (err) {
> > +		dev_warn(&msa311->i2c->dev,
> > +			 "cannot get actual freq (%d)\n", err);
> > +		/* Use lowest Output Data Rate, this is not fatal error */
>=20
> Say why this error can happen.  To me it looks like a comms failure so
> it might as well be fatal.
>=20

Function msa311_wait_for_next_data() is used from power mode transition
flow (SUSPEND -> NORMAL) to achieve actual accel data after resume is
done. I suppose it's better to work on the lowest ODR than not work at
all and stay in the SUSPEND mode.

> > +		odr =3D MSA311_ODR_1_HZ;
> > +		err =3D 0;
> > +	}
> > +
> > +	freq_uhz =3D msa311_odr_table[odr].val * USEC_PER_SEC +
> > +		   msa311_odr_table[odr].val2;
> > +	wait_ms =3D (USEC_PER_SEC * MSEC_PER_SEC) / freq_uhz;
> > +
> > +	if (wait_ms < unintr_thresh_ms)
>=20
> Comments needed on why this dance is needed.
>=20

Okay, it doesn't allow to process to wait in uninterruptible sleep
for a long time. I'll provide the comment.

> > +		usleep_range(wait_ms * USEC_PER_MSEC,
> > +			     unintr_thresh_ms * USEC_PER_MSEC);
> > +	else
> > +		err =3D msleep_interruptible(wait_ms) ? -EINTR : 0;
> > +
> > +	return err;
> > +}
> > +
> > +/**
> > + * msa311_set_pwr_mode() - Install certain MSA311 power mode
> > + *
> > + * @msa311: MSA311 internal private state
> > + * @mode: Power mode can be equal to NORMAL, SUSPEND and LOW
> > + *
> > + * This function should be called under msa311->lock.
> > + *
> > + * @return: 0 on success, -ERRNO on failure
> > + */
> > +static int msa311_set_pwr_mode(struct msa311_priv *msa311, unsigned in=
t mode)
> > +{
> > +	unsigned int prev_mode;
> > +	int err;
> > +
> > +	dev_dbg(&msa311->i2c->dev, "transition to %s mode\n",
> > +		(mode =3D=3D MSA311_PWR_MODE_LOW) ? "low" :
> > +		(mode =3D=3D MSA311_PWR_MODE_NORMAL) ? "normal" :
> > +		"suspend");
> > +
> > +	err =3D regmap_field_read(msa311->fields[F_PWR_MODE], &prev_mode);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev,
> > +			"cannot read previous pwr mode (%d)\n", err);
> > +		return err;
> > +	}
> > +
> > +	err =3D regmap_field_write(msa311->fields[F_PWR_MODE], mode);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev, "bad pwr mode transition (%d)\n",
> > +			err);
> > +		return err;
> > +	}
> > +
> > +	/* Wait actual data if we wakeup */
> > +	if (prev_mode =3D=3D MSA311_PWR_MODE_SUSPEND &&
> > +	    mode =3D=3D MSA311_PWR_MODE_NORMAL)
> > +		err =3D msa311_wait_for_next_data(msa311);
> > +
> > +	return err;
> > +}
> > +
> > +/**
> > + * msa311_normal_mode() - Transit MSA311 power state to NORMAL mode
> > + *
> > + * @msa311: MSA311 internal private state
> > + *
> > + * This function should be called under msa311->lock.
> > + *
> > + * @return: 0 on success, -ERRNO on failure
> > + */
> > +static inline int msa311_normal_mode(struct msa311_priv *msa311)
> > +{
> > +	return msa311_set_pwr_mode(msa311, MSA311_PWR_MODE_NORMAL);
>=20
> This wrapper doesn't seem to add any value over just replacing all calls
> with the direct call to msa311_set_pwr_mode()
>=20

Ack

> > +}
> > +
> > +/**
> > + * msa311_suspend_mode() - Transit MSA311 power state to SUSPEND mode
> > + *
> > + * @msa311: MSA311 internal private state
> > + *
> > + * This function should be called under msa311->lock.
> > + *
> > + * @return: 0 on success, -ERRNO on failure
> > + */
> > +static inline int msa311_suspend_mode(struct msa311_priv *msa311)
> > +{
> > +	return msa311_set_pwr_mode(msa311, MSA311_PWR_MODE_SUSPEND);
>=20
> As above, wrapper doesn't seem to add anything so drop it.
>=20

Ack

> > +}
> > +
> > +/**
> > + * msa311_powerup() - MSA311 resume power state using pm_runtime syste=
m
> > + *
> > + * @msa311: MSA311 internal private state
> > + *
> > + * @return: 0 on success, -ERRNO if cannot resume and get pm counter
> > + */
> > +static inline int msa311_powerup(struct msa311_priv *msa311)
> > +{
> > +	return pm_runtime_resume_and_get(&msa311->i2c->dev);
>=20
> Another wrapper that doesn't add anything. Please drop.
>=20

Ack

> > +}
> > +
> > +/**
> > + * msa311_powerdown() - MSA311 suspend power state using pm_runtime sy=
stem
> > + *
> > + * @msa311: MSA311 internal private state
> > + */
> > +static inline void msa311_powerdown(struct msa311_priv *msa311)
> > +{
> > +	pm_runtime_mark_last_busy(&msa311->i2c->dev);
> > +	pm_runtime_put_autosuspend(&msa311->i2c->dev);
>=20
> Drop this wrapper as well. It is better to be able to immediately see wha=
t is
> going on where this is called.
> =20

Ack

> > +}
> > +
> > +/**
> > + * msa311_chan_to_axis() - Translate IIO channel spec to MSA311 axis d=
escriptor
> > + *
> > + * @msa311: MSA311 internal private state
> > + * @chan: IIO channel specification
> > + *
> > + * @return: appropriate msa311_axis object or NULL msa311_axis for unk=
nown
> > + *          IIO channel spec
> > + */
> > +static inline
> > +struct msa311_axis msa311_chan_to_axis(struct msa311_priv *msa311,
> > +				       const struct iio_chan_spec * const chan)
> > +{
> > +	struct msa311_axis axis =3D { NULL, NULL };
> > +
> > +	switch (chan->scan_index) {
> > +	case MSA311_SI_X:
> > +		axis.lsb =3D msa311->fields[F_ACC_X_LSB];
> > +		axis.msb =3D msa311->fields[F_ACC_X_MSB];
> > +		break;
> > +
> > +	case MSA311_SI_Y:
> > +		axis.lsb =3D msa311->fields[F_ACC_Y_LSB];
> > +		axis.msb =3D msa311->fields[F_ACC_Y_MSB];
> > +		break;
> > +
> > +	case MSA311_SI_Z:
> > +		axis.lsb =3D msa311->fields[F_ACC_Z_LSB];
> > +		axis.msb =3D msa311->fields[F_ACC_Z_MSB];
> > +		break;
> > +	}
> > +
> > +	return axis;
> > +}
> > +
> > +/**
> > + * msa311_get_axis() - Read MSA311 accel data for certain IIO channel =
spec
> > + *
> > + * @msa311: MSA311 internal private state
> > + * @chan: IIO channel specification
> > + * @data: Output accel data for requested IIO channel spec
> > + *
> > + * This function should be called under msa311->lock.
> > + *
> > + * @return: 0 on success, -EINVAL for unknown IIO channel specificatio=
n,
> > + *          -ERRNO in other failures
> > + */
> > +static int msa311_get_axis(struct msa311_priv *msa311,
> > +			   const struct iio_chan_spec * const chan,
> > +			   unsigned int *data)
> > +{
> > +	struct msa311_axis axis;
> > +	unsigned int lsb, msb;
> > +	int err;
> > +
> > +	axis =3D msa311_chan_to_axis(msa311, chan);
> > +	if (!axis.lsb)
> > +		return -EINVAL;
> > +
> > +	err =3D regmap_field_read(axis.lsb, &lsb);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev,
> > +			"failed to read lsb value of axis %s (%d)\n",
> > +			chan->datasheet_name, err);
> > +		return err;
> > +	}
> > +
> > +	err =3D regmap_field_read(axis.msb, &msb);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev,
> > +			"failed to read msb value of axis %s (%d)\n",
> > +			chan->datasheet_name, err);
> > +		return err;
> > +	}
> > +
> > +	*data =3D (msb << chan->scan_type.shift) | lsb;
>=20
> This is unusual. Needs a comment on why only the msb is being
> shifted. I suspect this a side effect of using fields here which
> I think is a bad idea as this should be a bulk read across
> the register pairs.
>=20
>=20

You are right, it's a side effect of regmap_field_* API usage.
I thought about bulk reads instead of regmap_field_* for MSB/LSB pairs,
but made a choice to reg access generalization through the fields.
But I don't mind taking bulk operations here, so it will be fixed
in the next version.

> > +
> > +	return err;
> > +}
> > +
> > +static int msa311_read_raw_data(struct msa311_priv *msa311,
> > +				struct iio_chan_spec const *chan,
> > +				int *val, int *val2)
> > +{
> > +	unsigned int axis;
> > +	int err;
> > +
> > +	err =3D msa311_powerup(msa311);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev, "failed powerup (%d)\n", err);
> > +		return err;
> > +	}
> > +
> > +	mutex_lock(&msa311->lock);
> > +	err =3D msa311_get_axis(msa311, chan, &axis);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev,
> > +			"cannot get axis %s (%d)\n",
> > +			chan->datasheet_name, err);
> > +		mutex_unlock(&msa311->lock);
> > +		return err;
> > +	}
> > +	mutex_unlock(&msa311->lock);
>=20
> Usual trick for this pattern is to check the error after unlock.
>=20
> 	mutex_lock(&msa311->lock);
> 	err =3D msa311_get_axis(msa311, chan, &axis);
> 	mutex_unlock(&msa311->lock);
> 	if (err) {
> 		dev_err()..
> 		return err;
> 	}
>=20

Exactly, I've used the same pattern for other places.
Looks like here I forgot this one :-)

> > +
> > +	msa311_powerdown(msa311);
> > +
> > +	*val =3D sign_extend32(axis, chan->scan_type.realbits - 1);
> > +	*val2 =3D 0;
> > +
> > +	return IIO_VAL_INT;
> > +}
> > +
> > +static int msa311_read_scale(struct msa311_priv *msa311, int *val, int=
 *val2)
> > +{
> > +	unsigned int fs;
> > +	int err;
> > +
> > +	mutex_lock(&msa311->lock);
> > +	err =3D regmap_field_read(msa311->fields[F_FS], &fs);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev,
> > +			"cannot get actual scale (%d)\n", err);
> > +		mutex_unlock(&msa311->lock);
> > +		return err;
> > +	}
> > +	mutex_unlock(&msa311->lock);
> > +
> > +	*val =3D 0;
> > +	*val2 =3D msa311_fs_table[fs];
> > +
> > +	return IIO_VAL_INT_PLUS_MICRO;
> > +}
> > +
> > +static int msa311_read_samp_freq(struct msa311_priv *msa311,
> > +				 int *val, int *val2)
> > +{
> > +	unsigned int odr;
> > +	int err;
> > +
> > +	mutex_lock(&msa311->lock);
> > +	err =3D msa311_get_odr(msa311, &odr);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev,
> > +			"cannot get actual freq (%d)\n", err);
> > +		mutex_unlock(&msa311->lock);
> > +		return err;
> > +	}
> > +	mutex_unlock(&msa311->lock);
> > +
> > +	*val =3D msa311_odr_table[odr].val;
> > +	*val2 =3D msa311_odr_table[odr].val2;
> > +
> > +	return IIO_VAL_INT_PLUS_MICRO;
> > +}
> > +
> > +/**
> > + * msa311_read_raw() - IIO interface function to request attr/accel da=
ta
> > + *
> > + * @indio_dev: The IIO device associated with MSA311
> > + * @chan: IIO channel specification
> > + * @val: Output data value, first part
> > + * @val2: Output data value, second part
> > + * @mask: Value type selector
> > + *
> > + * @return: IIO_VAL_* type on success,
> > + *          -EINVAL for unknown value type (bad mask),
> > + *          -EBUSY if IIO buffer enabled,
> > + *          -ERRNO in other failures
> > + */
> > +static int msa311_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan,
> > +			   int *val, int *val2, long mask)
> > +{
> > +	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
> > +	int err =3D -EINVAL;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (iio_buffer_enabled(indio_dev))
> > +			return -EBUSY;
> > +
> > +		err =3D msa311_read_raw_data(msa311, chan, val, val2);
>=20
> 		return msa311_read_raw_data()
>=20
> Same in other cases...
>=20

Ack

> > +		break;
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		err =3D msa311_read_scale(msa311, val, val2);
> > +		break;
> > +
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		err =3D msa311_read_samp_freq(msa311, val, val2);
> > +		break;
>=20
> 	default:
> 		return -EINVAL;
>=20

Ack

> > +	}
> > +
> > +	return err;
> > +}
> > +
> > +static int msa311_write_scale(struct msa311_priv *msa311, int val, int=
 val2)
> > +{
> > +	unsigned int fs;
> > +	int err =3D -EINVAL;
> > +
> > +	/* Skip such values */
> > +	if (val !=3D 0)
> > +		return 0;
> > +
> > +	err =3D msa311_powerup(msa311);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev, "failed powerup (%d)\n", err);
> > +		return err;
> > +	}
> > +
> > +	mutex_lock(&msa311->lock);
> > +	for (fs =3D 0; fs < ARRAY_SIZE(msa311_fs_table); ++fs)
> > +		if (val2 =3D=3D msa311_fs_table[fs]) {
>=20
> Handle failure to match..
>=20

Okay, I'll provide dev_err() log about missing requested fs value.

> > +			err =3D regmap_field_write(msa311->fields[F_FS], fs);
> > +			if (err) {
> > +				dev_err(&msa311->i2c->dev,
> > +					"cannot update scale (%d)\n", err);
> > +				goto failed;
> > +			}
> > +
> > +			break;
> > +		}
> > +
> > +failed:
> > +	mutex_unlock(&msa311->lock);
> > +
> > +	msa311_powerdown(msa311);
> > +
> > +	return err;
> > +}
> > +
> > +static int msa311_write_samp_freq(struct msa311_priv *msa311, int val,=
 int val2)
> > +{
> > +	unsigned int odr;
> > +	int err =3D -EINVAL;
>=20
> err doesn't need initializing.
>=20

Ack

> > +
> > +	err =3D msa311_powerup(msa311);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev, "failed powerup (%d)\n", err);
> > +		return err;
> > +	}
> > +
> > +	mutex_lock(&msa311->lock);
> > +	for (odr =3D 0; odr < ARRAY_SIZE(msa311_odr_table); ++odr)
> > +		if (val =3D=3D msa311_odr_table[odr].val &&
> > +		    val2 =3D=3D msa311_odr_table[odr].val2) {
>=20
> If it doesn't match, we want to return an error.
>=20

Ack

> > +			err =3D msa311_set_odr(msa311, odr);
> > +			if (err) {
> > +				dev_err(&msa311->i2c->dev,
> > +					"cannot update freq (%d)\n", err);
> > +				goto failed;
> > +			}
> > +
> > +			break;
> > +		}
> > +
> > +failed:
> > +	mutex_unlock(&msa311->lock);
> > +
> > +	msa311_powerdown(msa311);
> > +
> > +	return err;
> > +}
> > +
> > +/**
> > + * msa311_write_raw() - IIO interface function to write attr/accel dat=
a
> > + *
> > + * @indio_dev: The IIO device associated with MSA311
> > + * @chan: IIO channel specification
> > + * @val: Input data value, first part
> > + * @val2: Input data value, second part
> > + * @mask: Value type selector
> > + *
> > + * @return: 0 on success,
> > + *          -EINVAL for unknown value type (bad mask),
> > + *          -ERRNO in other failures
> > + */
> > +static int msa311_write_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int val, int val2, long mask)
> > +{
> > +	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
> > +	int err =3D -EINVAL;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SCALE:
> > +		if (iio_buffer_enabled(indio_dev))
> > +			return -EBUSY;
> > +
> > +		err =3D msa311_write_scale(msa311, val, val2);
>=20
> 		return msa311_write_scale()
>=20

Ack

> > +		break;
> > +
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		if (iio_buffer_enabled(indio_dev))
> > +			return -EBUSY;
> > +
> > +		err =3D msa311_write_samp_freq(msa311, val, val2);
>=20
> 		return msa311_write_samp_req();
>=20

Ack

> > +		break;
>=20
> 	default:
> 		return -EINVAL;
>=20

Ack

> > +	}
> > +
> > +	return err;
> > +}
> > +
> > +/**
> > + * msa311_debugfs_reg_access() - IIO interface function to read/write =
registers
> > + *
> > + * @indio_dev: The IIO device associated with MSA311
> > + * @reg: Register offset
> > + * @writeval: Input value to be written (applicable if readval =3D=3D =
NULL)
> > + * @readval: Output value to be read, should be not NULL, if it's read=
 operation
> > + *
> > + * @return: 0 on success,
> > + *          -EINVAL for wrong register offset
> > + *          -ERRNO in other failures
> > + */
> > +static int msa311_debugfs_reg_access(struct iio_dev *indio_dev,
> > +				     unsigned int reg, unsigned int writeval,
> > +				     unsigned int *readval)
> > +{
> > +	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
> > +	int err;
> > +
> > +	if (reg > regmap_get_max_register(msa311->regs))
> > +		return -EINVAL;
> > +
> > +	err =3D msa311_powerup(msa311);
>=20
> I'd much rather see the runtime_pm calls here as that will make it clear
> you aren't actually powering up and down if it's already running but rath=
er
> messing around with reference counts.
>=20

Ack

> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev, "failed powerup (%d)\n", err);
> > +		return err;
> > +	}
> > +
> > +	mutex_lock(&msa311->lock);
>=20
> Why is lock needed here?  The internal regmap lock should be enough
> I think.
>=20

As I mentioned above, this lock is needed to protect register accesses
between several processes. But looks like regmap_lock should be enough.

> > +
> > +	if (!readval)
> > +		err =3D regmap_write(msa311->regs, reg, writeval);
> > +	else
> > +		err =3D regmap_read(msa311->regs, reg, readval);
> > +
> > +	mutex_unlock(&msa311->lock);
> > +
> > +	msa311_powerdown(msa311);
> > +
> > +	if (err)
> > +		dev_err(&msa311->i2c->dev,
> > +			"cannot %s register %u from debugfs (%d)\n",
> > +			(!readval) ? "write" : "read", reg, err);
> > +
> > +	return err;
> > +}
> > +
> > +/**
> > + * msa311_buffer_preenable() - IIO buffer interface preenable actions
> > + *
> > + * @indio_dev: The IIO device associated with MSA311
> > + *
> > + * @return: 0 on success,
> > + *          -ERRNO in other failures
> > + */
> > +static int msa311_buffer_preenable(struct iio_dev *indio_dev)
> > +{
> > +	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
> > +	int err;
 > +
> > +	err =3D msa311_powerup(msa311);
> > +	if (err)
> > +		dev_err(&msa311->i2c->dev, "failed powerup (%d)\n", err);
> > +
> > +	return err;
> > +}
> > +
> > +/**
> > + * msa311_buffer_postdisable() - IIO buffer interface postdisable acti=
ons
> > + *
> > + * @indio_dev: The IIO device associated with MSA311
> > + *
> > + * @return: 0 on success,
> > + *          -ERRNO in other failures
> > + */
> > +static int msa311_buffer_postdisable(struct iio_dev *indio_dev)
> > +{
> > +	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
> > +
> > +	msa311_powerdown(msa311);
>=20
> Ah.. See comment below on trigger. Why do it for buffer and trigger?
> runtime_pm is ref counted so it won't matter, but seems a bit unusual.
>=20

Ack

> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * msa311_set_new_data_trig_state() - IIO trigger interface to change =
trig state
> > + *
> > + * @trig: The IIO device trigger for new data event
> > + * @state: New state (enabled or disabled)
> > + *
> > + * This function changes NEW_DATA interrupt driver trigger state to en=
abled or
> > + * disabled.
> > + *
> > + * @return: 0 on success,
> > + *          -ERRNO in other failures
> > + */
> > +static int msa311_set_new_data_trig_state(struct iio_trigger *trig, bo=
ol state)
> > +{
> > +	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
> > +	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
> > +	int err =3D 0;
> > +
> > +	if (state)
> > +		err =3D msa311_powerup(msa311);
>=20
> Superficially it feels like power control should be in the buffer enable
> rather than trigger enable. See below for discussion of whether other tri=
ggers
> can be used with this device if the interrupt isn't wired for example.
>=20

As mentioned in the discussion about other triggers, I will try to
support and test different triggers without irq enabled and will
redesign the power approach.

> > +	else
> > +		msa311_powerdown(msa311);
> > +
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev,
> > +			"failed %s (%d)\n",
> > +			state ? "powerup" : "powerdown", err);
>=20
> Given you don't set Err on powerdown you won't hit that path.
>=20

Ack

> > +		return err;
> > +	}
> > +
> > +	mutex_lock(&msa311->lock);
> > +
> > +	WRITE_ONCE(msa311->new_data_trig_enabled, state);
>=20
> You are doing this under a lock. Why is WRITE_ONCE needed?
> Personally I'd be tempted to use the flag in the register once you've
> stopped using new_data_trig_enabled as suggested below.
>=20

I will use register to save trigger state in the v2, so
new_data_trig_enabled will be removed.

> > +
> > +	err =3D regmap_field_write(msa311->fields[F_NEW_DATA_INT_EN], state);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev,
> > +			"cannot %s buffer due to new_data_int failure (%d)\n",
> > +			state ? "enable" : "disable", err);
> > +		if (state) {
> > +			mutex_unlock(&msa311->lock);
> > +			msa311_powerdown(msa311);
> > +			return err;
> > +		}
> > +	}
> > +
> > +	mutex_unlock(&msa311->lock);
> > +
> > +	return err;
> > +}
> > +
> > +/**
> > + * msa311_reenable() - IIO trigger interface to reenable trigger inter=
rupt
> > + *
> > + * @trig: The IIO device trigger wanted to reenable
> > + */
> > +static void msa311_reenable(struct iio_trigger *trig)
> > +{
> > +	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
> > +	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
> > +	int err;
> > +
> > +	mutex_lock(&msa311->lock);
> > +
> > +	/* Reset all latched interrupts */
>=20
> Should only be resetting interrupts related to the trigger.  Otherwise yo=
u have
> a race against handling of other interrupts (once added).
>=20

Unfortunately, MSA311 has only one IRQ (multifunctional).
You can enable different IRQ functions through the IRQ event mapping,
but from hardware perspective it will be only one IRQ.
It means MSA311 can reset only one IRQ line with all enabled functions
together.

> > +	err =3D regmap_field_write(msa311->fields[F_RESET_INT], 1);
> > +
> > +	mutex_unlock(&msa311->lock);
> > +
> > +	if (err)
> > +		dev_err(&msa311->i2c->dev,
> > +			"cannot reset all latched interrupts (%d)\n", err);
> > +}
> > +
> > +/**
> > + * msa311_validate_device() - IIO trigger interface to validate reques=
ted device
> > + *
> > + * @trig: Appropriate IIO trigger
> > + * @indio_dev: Requested IIO device
> > + *
> > + * @return: 0 on success,
> > + *         -EINVAL when indio_dev isn't linked with appropriate trigge=
r
> > + */
> > +static int msa311_validate_device(struct iio_trigger *trig,
> > +				  struct iio_dev *indio_dev)
> > +{
> > +	struct iio_dev *indio =3D iio_trigger_get_drvdata(trig);
> > +
> > +	if (indio !=3D indio_dev)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * msa311_buffer_thread() - IIO buffer thread to push channels actual =
data
> > + *
> > + * @irq:  The software interrupt assigned to @p
> > + * @p: The IIO poll function dispatched by external trigger our device=
 is
> > + *     attached to.
> > + *
> > + * @return: IRQ_HANDLED all the time
> > + */
> > +static irqreturn_t msa311_buffer_thread(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf =3D p;
> > +	struct iio_dev *indio_dev =3D pf->indio_dev;
> > +	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
> > +	const struct iio_chan_spec *chan;
> > +	unsigned int axis;
> > +	int bit =3D 0, err, i =3D 0;
> > +
> > +	/* Ensure correct alignment of time stamp when present */
> > +	struct {
> > +		s16 channels[MSA311_SI_Z + 1];
>=20
> Why +1?  Just to ensure no holes to get zeroing to work?
>=20

Nope, it's just because MSA311_SI_Z is an index, but we need to declare
an array for all channels.

> > +		s64 ts;
> > +	} __aligned(8) buf =3D {0};
>=20
> This doesn't guarantee the expected alignment.  The problem is x86_32 whi=
ch
> aligns s64 to 4 bytes where IIO guarantees natural alignment on all archi=
tectures.
> You need
>=20
> 	struct {
> 		s16 channels[MSA311_SI_Z];
> 		s64 ts __aligned(8);
> 	} buf;
>=20
> Can't use {0} as that is not guaranteed to zero holes (IIRC). So need
> an explicit memset(&buf);
>=20
>=20

Ack

> > +
> > +	mutex_lock(&msa311->lock);
> > +
> > +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> > +			 indio_dev->masklength) {
> > +		chan =3D &msa311_channels[bit];
> > +		err =3D msa311_get_axis(msa311, chan, &axis);
> > +		if (err) {
> > +			dev_err(&msa311->i2c->dev,
> > +				"cannot get axis %s (%d)\n",
> > +				chan->datasheet_name, err);
> > +			mutex_unlock(&msa311->lock);
> > +			goto err;
> > +		}
> > +		buf.channels[i++] =3D sign_extend32(axis,
> > +						  chan->scan_type.realbits - 1);
>=20
> That should be up to userspace, not done in kernel which should present t=
he raw data
> without sign extension.
>=20
>=20

I agree, it's bad idea to adjust sign bits from buffer raw data
perspective. But what's about IIO_CHAN_INFO_RAW IIO iface? Is it
applicable there too? As I see in the libiio channel implementation
can convert all data to appropriate format (take into account sign and
endianness values).
It means we shouldn't extend sign bits for IIO_CHAN_INFO_RAW as well.
Please correct me if I'm wrong.

> > +	}
> > +
> > +	mutex_unlock(&msa311->lock);
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &buf, pf->timestamp);
> > +
> > +err:
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +/**
> > + * msa311_irq_handler() - Process MSA311 hardware interrupts (INT1 lin=
e)
> > + *
> > + * @irq:  Interrupt line the hardware uses to notify new data has arri=
ved.
> > + * @p: The IIO device associated with the sampling hardware.
> > + *
> > + * @return: IRQ_WAKE_THREAD all the time
> > + */
> > +static irqreturn_t msa311_irq_handler(int irq, void *p)
> > +{
> > +	struct iio_dev *indio_dev =3D p;
> > +	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
> > +
> > +	/* TODO: notify motion triggers */
>=20
> You probably can't do that in the top half, so this comment seems
> misleading.
>=20

Ah... Looks like I've mistyped. Of course, better place for such
activity is bottom half trigger handler.

> > +
> > +	if (READ_ONCE(msa311->new_data_trig_enabled))
> > +		iio_trigger_poll(msa311->new_data_trig);
> As below. I would not rely on the assumption that the interrupt was cause=
d
> by this being set.
>=20

I agree with you. It's better to remove new_data_trig_enabled usage and
check irq status from register value.

> > +
> > +	return IRQ_WAKE_THREAD;
> > +}
> > +
> > +/**
> > + * msa311_irq_thread() - Interrupt bottom-half handler.
> > + *
> > + * @irq:  Interrupt line the hardware uses to notify new data has arri=
ved.
> > + * @p: The IIO device associated with the sampling hardware.
> > + *
> > + * @return: IRQ_HANDLED all the time
> > + */
> > +static irqreturn_t msa311_irq_thread(int irq, void *p)
> > +{
> > +	struct iio_dev *indio_dev =3D p;
>=20
> As indio_dev isn't used here, you can just pass p into iio_priv()
> without loss of readability.
>=20

Ack

> > +	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
> > +	unsigned int new_data_int_status;
> > +	int err;
> > +
> > +	mutex_lock(&msa311->lock);
> > +
> > +	/* TODO: push motion events */
> > +
> > +	/* Ack NEW_DATA interrupt */
> > +	err =3D regmap_field_read(msa311->fields[F_NEW_DATA_INT],
> > +				&new_data_int_status);
> > +
> > +	mutex_unlock(&msa311->lock);
>=20
> I'd expect to see iio_trigger_poll_chained() (one day I'll give
> that function a better name) in here after we
> have verified that the interrupt in question was the right one.
> Note that will break use of top half measurement of timestamp
> for the buffer so you would need to handle that.
>=20
>=20

Could you please explain which benefit we have with
iio_trigger_poll_chained()? Is it lower latency due to top half handling?
I've deeped into this function and compared it with
iio_trigger_poll() and looks like the main difference is top/bottom half
location for trigger handlers. Is that the correct understanding?

> > +
> > +	if (err)
> > +		dev_err(&msa311->i2c->dev,
> > +			"cannot retrieve new_data interrupt status (%d)\n",
> > +			err);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +/**
> > + * msa311_check_partid() - Check MSA311 WHO_AM_I identifier.
> > + *
> > + * @msa311: MSA311 internal private state
> > + *
> > + * @return: 0 on success (MSA311 device was found on the I2C bus)
> > + *          -ENODEV when MSA311 device is not presented on the I2C bus
> > + *          -ERRNO in other failures
> > + */
> > +static int msa311_check_partid(struct msa311_priv *msa311)
> > +{
> > +	unsigned int partid;
> > +	int err;
> > +
> > +	err =3D regmap_field_read(msa311->fields[F_PARTID], &partid);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev, "failed to read partid (%d)\n", err);
> > +		return err;
> > +	}
> > +
> > +	if (partid !=3D MSA311_WHO_AM_I) {
> > +		dev_err(&msa311->i2c->dev, "invalid partid (%#x)\n", partid);
>=20
> So... We've had a lot of discussion of this in various drivers recently a=
nd
> as a general rule the preferred option is to just warn on the wrong WHOAM=
I
> and carry on.  The reason is that enables future parts that happen to be
> compatible to use fallback compatibles and work on older kernels.
>=20

Okay, I didn't know about that. I'll change it to dev_warn() in the v2 patc=
h.
Please suggest where do you discuss such niceties, in the IRC IIO channel?

> > +		return -ENODEV;
> > +	}
> > +
> > +	dev_info(&msa311->i2c->dev, "Found MSA311 chip[%#x]\n", partid);
> > +
> > +	return err;
> > +}
> > +
> > +/**
> > + * msa311_soft_reset() - Make soft reset operation for MSA311 device.
> > + *
> > + * @msa311: MSA311 internal private state
> > + *
> > + * @return: 0 on success, -ERRNO in other failures
> > + */
> > +static int msa311_soft_reset(struct msa311_priv *msa311)
> > +{
> > +	int err;
> > +
> > +	err =3D regmap_write(msa311->regs, MSA311_SOFT_RESET,
> > +			   MSA311_GENMASK(F_SOFT_RESET_I2C) |
> > +			   MSA311_GENMASK(F_SOFT_RESET_SPI));
> > +	if (err)
> > +		return err;
> > +
> > +	usleep_range(5000, 10000);
> > +
> > +	return err;
> err definitely 0 here so
> 	return 0; to make that explicit.
>=20

Ack

> > +}
> > +
> > +/**
> > + * msa311_chip_init() - MSA311 chip initialization sequence
> > + *
> > + * @msa311: MSA311 internal private state
> > + *
> > + * We do not need to hold msa311->lock here, because this function is =
used
> > + * during I2C driver probing process only.
> > + *
> > + * @return: 0 on success, -ERRNO in other failures
> > + */
> > +static int msa311_chip_init(struct msa311_priv *msa311)
> > +{
> > +	int err;
> > +
> > +	err =3D msa311_check_partid(msa311);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D msa311_soft_reset(msa311);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev,
> > +			"cannot soft reset all logic (%d)\n", err);
> > +		return err;
>=20
> dev_err_probe() for all these.
>=20

Ack

> > +	}
> > +
> > +	err =3D msa311_normal_mode(msa311);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev,
> > +			"bad normal pwr mode transition (%d)\n", err);
> > +		return err;
> > +	}
> > +
> > +	err =3D regmap_write(msa311->regs, MSA311_RANGE, MSA311_FS_16G);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev,
> > +			"failed to setup accel range (%d)\n", err);
> > +		return err;
> > +	}
> > +
> > +	/* Disable all interrupts by default */
> > +	err =3D regmap_write(msa311->regs, MSA311_INT_SET_0, 0);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev,
> > +			"cannot disable set0 interrupts (%d)\n", err);
> > +		return err;
> > +	}
> > +	err =3D regmap_write(msa311->regs, MSA311_INT_SET_1, 0);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev,
> > +			"cannot disable set1 interrupts (%d)\n", err);
> > +		return err;
> > +	}
> > +
> > +	/* Unmap all INT1 interrupts by default */
> > +	err =3D regmap_write(msa311->regs, MSA311_INT_MAP_0, 0);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev,
> > +			"failed to unmap map0 interrupts (%d)\n", err);
> > +		return err;
> > +	}
> > +	err =3D regmap_write(msa311->regs, MSA311_INT_MAP_1, 0);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev,
> > +			"failed to unmap map1 interrupts (%d)\n", err);
> > +		return err;
> > +	}
> > +
> > +	/* Disable all axis by default */
> > +	err =3D regmap_update_bits(msa311->regs, MSA311_ODR,
> > +				 MSA311_GENMASK(F_X_AXIS_DIS) |
> > +				 MSA311_GENMASK(F_Y_AXIS_DIS) |
> > +				 MSA311_GENMASK(F_Z_AXIS_DIS), 0);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev,
> > +			"cannot enable all axes (%d)\n", err);
> > +		return err;
> > +	}
> > +
> > +	err =3D msa311_set_odr(msa311, MSA311_ODR_125_HZ);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev,
> > +			"failed to set accel frequency (%d)\n", err);
> > +		return err;
> > +	}
> > +
> > +	usleep_range(10000, 15000);
>=20
> Comment needed to justify this sleep. Probably a spec reference.
>=20

Okay, I'll provide more justifying notes here in the v2.

> > +
> > +	return err;
> > +}
> > +
> > +/**
> > + * msa311_setup_interrupts() - MSA311 interrupts initialization sequen=
ce
> > + *
> > + * @msa311: MSA311 internal private state
> > + *
> > + * We do not need to hold msa311->lock here, because this function is =
used
> > + * during I2C driver probing process only.
> > + *
> > + * @return: 0 on success, -ERRNO in other failures
> > + */
> > +static int msa311_setup_interrupts(struct msa311_priv *msa311)
> > +{
> > +	int err;
> > +
> > +	err =3D regmap_field_write(msa311->fields[F_INT1_OD],
> > +				 MSA311_INT1_OD_PUSH_PULL);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D regmap_field_write(msa311->fields[F_INT1_LVL],
> > +				 MSA311_INT1_LVL_HIGH);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D regmap_field_write(msa311->fields[F_LATCH_INT],
> > +				 MSA311_LATCH_INT_LATCHED);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D regmap_field_write(msa311->fields[F_INT1_NEW_DATA], 1);
>=20
> return regmap_field_write()...
>=20

Ack

> > +
> > +	return err;
> > +}
> > +
> > +/**
> > + * msa311_regmap_init() - MSA311 registers mapping initialization
> > + *
> > + * @msa311: MSA311 internal private state
> > + *
> > + * We do not need to hold msa311->lock here, because this function is =
used
> > + * during I2C driver probing process only.
> > + *
> > + * @return: 0 on success, -ERRNO in other failures
> > + */
> > +static int msa311_regmap_init(struct msa311_priv *msa311)
> > +{
> > +	struct regmap *regmap;
> > +	struct regmap_field **fields =3D msa311->fields;
> > +	int i;
> > +
> > +	regmap =3D devm_regmap_init_i2c(msa311->i2c, &msa311_regmap_config);
> > +	if (IS_ERR(regmap)) {
> > +		dev_err(&msa311->i2c->dev, "failed to register i2c regmap\n");
>=20
> dev_err_probe() preferred for things called from probe() same elsewhere.
>=20

Ack

> > +		return PTR_ERR(regmap);
> > +	}
> > +	msa311->regs =3D regmap;
> > +
> > +	for (i =3D 0; i < F_MAX_FIELDS; ++i) {
> > +		fields[i] =3D devm_regmap_field_alloc(&msa311->i2c->dev,
> > +						    msa311->regs,
> > +						    msa311_reg_fields[i]);
> > +		if (IS_ERR(msa311->fields[i])) {
> > +			dev_err(&msa311->i2c->dev,
> > +				"failed to allocate reg field[%d]\n", i);
> > +			return PTR_ERR(msa311->fields[i]);
>=20
> dev_err_probe()
>=20

Ack

> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct iio_info msa311_info =3D {
> > +	.attrs =3D &msa311_attr_group,
> > +	.read_raw =3D msa311_read_raw,
> > +	.write_raw =3D msa311_write_raw,
> > +	.debugfs_reg_access =3D msa311_debugfs_reg_access,
> > +};
> > +
> > +static const struct iio_buffer_setup_ops msa311_buffer_setup_ops =3D {
> > +	.preenable =3D msa311_buffer_preenable,
> > +	.postdisable =3D msa311_buffer_postdisable,
> > +};
> > +
> > +static const struct iio_trigger_ops msa311_new_data_trig_ops =3D {
> > +	.set_trigger_state =3D msa311_set_new_data_trig_state,
> > +	.reenable =3D msa311_reenable,
> > +	.validate_device =3D msa311_validate_device,
> > +};
> > +
> > +/**
> > + * msa311_probe() - MSA311 main I2C driver probe function
> > + *
> > + * @i2c: I2C client associated with MSA311 device
> > + * @id: Matching device id
> > + *
> > + * @return: 0 on success
> > + *          -ENOMEM due to memory allocation failures
> > + *          -ERRNO in other failures
> > + */
> > +static int msa311_probe(struct i2c_client *i2c,
> > +			const struct i2c_device_id *id)
>=20
> Use probe_new() callback rather than probe() for new I2C drivers.
>=20

Ack

> > +{
> > +	struct msa311_priv *msa311;
> > +	struct iio_dev *indio_dev;
> > +	int err;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(&i2c->dev, sizeof(*msa311));
> > +	if (!indio_dev) {
> > +		dev_err(&i2c->dev, "iio device allocation failed\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	msa311 =3D iio_priv(indio_dev);
> > +	msa311->i2c =3D i2c;
> > +	i2c_set_clientdata(i2c, indio_dev);
> > +
> > +	indio_dev->dev.parent =3D &i2c->dev;
>=20
> This should already be set by internals of devm_iio_device_alloc()
>=20

I didn't know that, good catch. I'll fix it in the v2 patch.

> > +
> > +	err =3D msa311_regmap_init(msa311);
> > +	if (err) {
> > +		dev_err(&i2c->dev, "cannot initialize regmap (%d)\n", err);
>=20
> For error handling in probe() please use
> 	dev_err_probe() throughout.
>=20

Ack

> > +		return err;
> > +	}
> > +
> > +	err =3D msa311_chip_init(msa311);
> > +	if (err)
> > +		return err;
> > +
> > +	mutex_init(&msa311->lock);
> > +
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE; /* setup buffered mode later =
*/
> > +	indio_dev->channels =3D msa311_channels;
> > +	indio_dev->num_channels =3D ARRAY_SIZE(msa311_channels);
> > +	indio_dev->name =3D i2c->name;
> > +	indio_dev->info =3D &msa311_info;
> > +
> > +	if (i2c->irq > 0) {
> > +		err =3D devm_request_threaded_irq(&i2c->dev, i2c->irq,
> > +						msa311_irq_handler,
> > +						msa311_irq_thread,
> > +						IRQF_TRIGGER_RISING,
> > +						i2c->name,
> > +						indio_dev);
> > +		if (err) {
> > +			dev_err(&i2c->dev, "failed to request irq (%d)\n", err);
> > +			goto err_lock_destroy;
>=20
> One advantage of dropping mutex_destroy() below is you can return directl=
y
> from all of these paths.
>=20

Agreed

> > +		}
> > +
> > +		msa311->new_data_trig =3D devm_iio_trigger_alloc(&i2c->dev,
>=20
> I would use a local variable for trig to shorten some of these lines.
> 		trig =3D devm_iio_trigger_alloc();
> 		if (!trig)
> 			return -ENOMEM;
>=20
> 		msa311->new_data_trig =3D trig;
>=20

Ack

> > +							       "%s-new-data",
> > +							       indio_dev->name);
> > +		if (!msa311->new_data_trig) {
> > +			dev_err(&i2c->dev, "cannot allocate new data trig\n");
> > +			err =3D -ENOMEM;
> > +			goto err_lock_destroy;
> > +		}
> > +
> > +		msa311->new_data_trig->dev.parent =3D &i2c->dev;
> > +		msa311->new_data_trig->ops =3D &msa311_new_data_trig_ops;
> > +		iio_trigger_set_drvdata(msa311->new_data_trig, indio_dev);
> > +		indio_dev->trig =3D msa311->new_data_trig;
>=20
> This will create a double free if you were to change the trigger.
> 		indio_dev->trig =3D iio_trigger_get(trig);
>=20

I didn't take into account other trigger usage.
I'll rework this place for the v2.

> > +		err =3D devm_iio_trigger_register(&i2c->dev,
> > +						msa311->new_data_trig);
> > +		if (err) {
> > +			dev_err(&i2c->dev,
> > +				"failed to register new data trig (%d)\n", err);
> > +			goto err_lock_destroy;
> > +		}
> > +
> > +		err =3D devm_iio_triggered_buffer_setup(&i2c->dev,
>=20
> Can the device operate using other triggers?  So far you haven't prevente=
d
> that (you need to provide the validate_trigger() callback if you want to
> restrict it).  If it works, then the buffer setup should not be gated
> on irq being available as you should be able to use a hrtimer trigger
> etc.
>=20

I didn't test the driver with our triggers w/o irq.
I'll try to support other triggers and use validate_trigger() if any.

> > +						      indio_dev,
> > +						      iio_pollfunc_store_time,
> > +						      msa311_buffer_thread,
> > +						      &msa311_buffer_setup_ops);
> > +		if (err) {
> > +			dev_err(&i2c->dev,
> > +				"failed to setup iio triggered buffer (%d)\n",
> > +				err);
> > +			goto err_lock_destroy;
> > +		}
> > +
> > +		err =3D msa311_setup_interrupts(msa311);
>=20
> This is related to the trigger rather than the buffer, so move it up abov=
e
> the buffer setup.
>=20

Okay

> > +		if (err) {
> > +			dev_err(&i2c->dev, "failed to setup interrupts (%d)\n",
> > +				err);
> > +			goto err_lock_destroy;
> > +		}
> > +	}
> > +
> > +	err =3D msa311_suspend_mode(msa311);
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev,
> > +			"bad suspend pwr mode transition (%d)\n", err);
> > +		goto err_lock_destroy;
> > +	}
> > +
> > +	err =3D pm_runtime_set_active(&i2c->dev);
>=20
> I'm confused. You seem to have suspended the chip then specified that it =
is not
> suspended to runtime_pm.
>=20

Yes, because of using autosuspend pm flow.
But maybe pm_runtime_set_active() is an extra step, because we don't use
any register communication before auto-suspend event raising up.

> > +	if (err) {
> > +		dev_err(&i2c->dev,
> > +			"failed to active runtime pm (%d)\n", err);
> > +		goto err_lock_destroy;
> > +	}
> > +
> > +	pm_runtime_enable(&i2c->dev);
> > +	pm_runtime_set_autosuspend_delay(&i2c->dev, MSA311_PWR_SLEEP_DELAY_MS=
);
> > +	pm_runtime_use_autosuspend(&i2c->dev);
> > +
> > +	err =3D devm_iio_device_register(&i2c->dev, indio_dev);
> > +	if (err) {
> > +		dev_err(&i2c->dev, "iio device register failed (%d)\n", err);
> > +		goto err_poweroff_msa311;
> > +	}
> > +
> > +	return err;
> > +
> > +err_poweroff_msa311:
> > +	pm_runtime_get_sync(&i2c->dev);
> > +	pm_runtime_disable(&i2c->dev);
> > +	pm_runtime_set_suspended(&i2c->dev);
> > +	pm_runtime_put_noidle(&i2c->dev);
> > +
> > +err_lock_destroy:
> > +	mutex_destroy(&msa311->lock);
>=20
> Don't bother destroying the mutex.  That is only useful when trying
> to debug use after free and we aren't going to get any of those in probe.
>=20

Ack

> > +
> > +	return err;
> > +}
> > +
> > +/**
> > + * msa311_remove() - MSA311 main I2C driver remove function
> > + *
> > + * @i2c: I2C client associated with MSA311 device
> > + *
> > + * @return: 0 all the time
> > + */
> > +static int msa311_remove(struct i2c_client *i2c)
> > +{
> > +	struct iio_dev *indio_dev =3D i2c_get_clientdata(i2c);
> > +	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
> > +
> > +	pm_runtime_get_sync(&i2c->dev);
> > +	pm_runtime_disable(&i2c->dev);
> > +	pm_runtime_set_suspended(&i2c->dev);
> > +	pm_runtime_put_noidle(&i2c->dev);
>=20
> It probably makes sense to use=20
> devm_add_action_or_reset() with appropriate callback to handle this
> power management.
>=20

Yes, looks like it's a good cleanup helper.

> > +
> > +	mutex_lock(&msa311->lock);
> > +	msa311_suspend_mode(msa311);
> > +	mutex_unlock(&msa311->lock);
>=20
> Why do we have suspend in the remove() function but not in error handling
> of probe()?
>=20

You are totally right here. Of course, it's better to suspend the chip
in probe() error path.

> > +
> > +	mutex_destroy(&msa311->lock);
>=20
> mutex destroy is only relevant if you are destroying a mutex that might
> still be used.  It's debug only and we almost never bother doing it=20
> in remove() functions.
>=20

Ack

> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * msa311_runtime_suspend() - MSA311 pm runtime suspend callback
> > + *
> > + * @dev: Device object associated with MSA311
> > + *
> > + * @return: 0 on success, -EAGAIN due to MSA311 pm errors, please try =
later
> > + */
> > +static int __maybe_unused msa311_runtime_suspend(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
>=20
> As below use dev_get_drvdata() same in other cases.
> =20

Okay

> > +	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
> > +	int err;
> > +
> > +	dev_info(&msa311->i2c->dev, "suspending %s\n", dev->driver->name);
> Too noisy. dev_dbg() or drop.
>=20

Agreed

> > +
> > +	mutex_lock(&msa311->lock);
> > +	err =3D msa311_suspend_mode(msa311);
> > +	mutex_unlock(&msa311->lock);
> > +
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev,
> > +			"failed to power off device (%d)\n", err);
> > +		err =3D -EAGAIN;
>=20
> As far as I can see this is a device comms failure.  Normally
> we just give up in such cases and return err;
> 		return err;
>=20

Ack

> > +	}
> > +
> > +	return err;
>=20
> return 0;
>=20

Ack

> > +}
> > +
> > +/**
> > + * msa311_runtime_resume() - MSA311 pm runtime resume callback
> > + *
>=20
> No blank line here.  Same in similar cases throughout the driver.
>=20

Ack

> > + * @dev: Device object associated with MSA311
> > + *
> > + * @return: 0 on success, -EAGAIN due to MSA311 pm errors, please try =
later
>=20
> This is new syntax to me. It 'might' be fine but please run the kernel-do=
c
> build script on the whole file and fix any warnings.
>=20

I've run kernel-doc with dtb checkers, they didn't show any errors or warni=
ngs.
This is reguired step in the our internal patch preparing process.

=3D=3D=3D=3D=3D
scripts/kernel-doc -v -man -Werror drivers/iio/accel/msa311.c > msa311.man =
&& man ./msa311.man
drivers/iio/accel/msa311.c:652: info: Scanning doc for function MSA311_GENM=
ASK
drivers/iio/accel/msa311.c:665: info: Scanning doc for struct msa311_priv
drivers/iio/accel/msa311.c:688: info: Scanning doc for struct msa311_axis
drivers/iio/accel/msa311.c:708: info: Scanning doc for function MSA311_ACCE=
L_CHANNEL
drivers/iio/accel/msa311.c:731: info: Scanning doc for function MSA311_TIME=
STAMP_CHANNEL
drivers/iio/accel/msa311.c:761: info: Scanning doc for function msa311_get_=
odr
drivers/iio/accel/msa311.c:792: info: Scanning doc for function msa311_set_=
odr
drivers/iio/accel/msa311.c:862: info: Scanning doc for function msa311_wait=
_for_next_data
drivers/iio/accel/msa311.c:900: info: Scanning doc for function msa311_set_=
pwr_mode
drivers/iio/accel/msa311.c:942: info: Scanning doc for function msa311_norm=
al_mode
drivers/iio/accel/msa311.c:956: info: Scanning doc for function msa311_susp=
end_mode
drivers/iio/accel/msa311.c:970: info: Scanning doc for function msa311_powe=
rup
drivers/iio/accel/msa311.c:982: info: Scanning doc for function msa311_powe=
rdown
drivers/iio/accel/msa311.c:993: info: Scanning doc for function msa311_chan=
_to_axis
drivers/iio/accel/msa311.c:1028: info: Scanning doc for function msa311_get=
_axis
drivers/iio/accel/msa311.c:1148: info: Scanning doc for function msa311_rea=
d_raw
drivers/iio/accel/msa311.c:1258: info: Scanning doc for function msa311_wri=
te_raw
drivers/iio/accel/msa311.c:1297: info: Scanning doc for function msa311_deb=
ugfs_reg_access
drivers/iio/accel/msa311.c:1344: info: Scanning doc for function msa311_buf=
fer_preenable
drivers/iio/accel/msa311.c:1364: info: Scanning doc for function msa311_buf=
fer_postdisable
drivers/iio/accel/msa311.c:1381: info: Scanning doc for function msa311_set=
_new_data_trig_state
drivers/iio/accel/msa311.c:1432: info: Scanning doc for function msa311_ree=
nable
drivers/iio/accel/msa311.c:1455: info: Scanning doc for function msa311_val=
idate_device
drivers/iio/accel/msa311.c:1475: info: Scanning doc for function msa311_buf=
fer_thread
drivers/iio/accel/msa311.c:1526: info: Scanning doc for function msa311_irq=
_handler
drivers/iio/accel/msa311.c:1547: info: Scanning doc for function msa311_irq=
_thread
drivers/iio/accel/msa311.c:1580: info: Scanning doc for function msa311_che=
ck_partid
drivers/iio/accel/msa311.c:1610: info: Scanning doc for function msa311_sof=
t_reset
drivers/iio/accel/msa311.c:1632: info: Scanning doc for function msa311_chi=
p_init
drivers/iio/accel/msa311.c:1722: info: Scanning doc for function msa311_set=
up_interrupts
drivers/iio/accel/msa311.c:1756: info: Scanning doc for function msa311_reg=
map_init
drivers/iio/accel/msa311.c:1811: info: Scanning doc for function msa311_pro=
be
drivers/iio/accel/msa311.c:1949: info: Scanning doc for function msa311_rem=
ove
drivers/iio/accel/msa311.c:1975: info: Scanning doc for function msa311_run=
time_suspend
drivers/iio/accel/msa311.c:2003: info: Scanning doc for function msa311_run=
time_resume
=3D=3D=3D=3D=3D

> > + */
> > +static int __maybe_unused msa311_runtime_resume(struct device *dev)
>=20
> With changes suggested below you won't need the __maybe_unused on these.
>=20

I didn't know about pm_ptr() and PTR_IF(). Incredible macro, thank you
for suggestion!

> > +{
> > +	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
>=20
> dev_get_drvdata() to avoid bouncing backwards and forwards.
> There have been various discussions about this and whether it is balanced
> but general conclusion was that it was fairly obvious these were accessin=
g
> the same underlying storage and that there is no chance of that changing
> in future.
>=20
>=20

Ack

> > +	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
> > +	int err;
> > +
> > +	dev_info(&msa311->i2c->dev, "resuming %s\n", dev->driver->name);
>=20
> This is excessive noise so reduce to dev_dbg or drop.
>=20

Ack

> > +
> > +	mutex_lock(&msa311->lock);
> > +	err =3D msa311_normal_mode(msa311);
> > +	mutex_unlock(&msa311->lock);
> > +
> > +	if (err) {
> > +		dev_err(&msa311->i2c->dev,
> > +			"failed to power on device (%d)\n", err);
> > +		err =3D -EAGAIN;
> > +	}
> > +
> > +	return err;
> > +}
> > +
> > +static const struct dev_pm_ops msa311_pm_ops =3D {
> > +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> > +				pm_runtime_force_resume)
> > +	SET_RUNTIME_PM_OPS(msa311_runtime_suspend,
> > +			   msa311_runtime_resume, NULL)
> > +};
>=20
> Please use the new DEFINE_RUNTIME_DEV_PM_OPS for this and see below...
>=20

Agreed. It looks purer.

> > +
> > +static const struct i2c_device_id msa311_i2c_id[] =3D {
> > +	{ .name =3D MSA311_DRV_NAME },
>=20
> I'd rather see the string here than a define given we are matching
> on it so good to see what it is directly.
>=20

I use one string definition for regmap config, i2c device name,
and i2c driver name. Do you mean I need to duplicate it or
use different strings?
I suppose if we can use one string, maybe better to define it in the one pl=
ace.

> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, msa311_i2c_id);
> > +
> > +#ifdef CONFIG_OF
>=20
> As below, drop this protection. It brings more disadvantages than
> it is worth.
>=20

Ack

> > +static const struct of_device_id msa311_of_match[] =3D {
> > +	{ .compatible =3D "memsensing,msa311" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, msa311_of_match);
> > +#else
> > +#define msa311_of_match NULL
> > +#endif
> > +
> > +static struct i2c_driver msa311_driver =3D {
> > +	.driver =3D {
> > +		.name =3D MSA311_DRV_NAME,
> > +		.owner =3D THIS_MODULE,
> > +		.of_match_table =3D of_match_ptr(msa311_of_match),
>=20
> Don't use of_match_ptr(). It prevents use of this table for
> ACPI PRP0001 based bindings and it's not worth doing just
> to save a few bytes on non DT systems.
>=20

Okay. Should I use .acpi_match_table in addition to .of_match_table?

> > +		.pm =3D &msa311_pm_ops,
>=20
> 		.pm =3D pm_ptr(&msa311_pm_ops),
>=20

Ack

> > +	},
> > +	.probe		=3D msa311_probe,
> > +	.remove		=3D msa311_remove,
> > +	.id_table	=3D msa311_i2c_id,
> > +};
> > +
> > +module_i2c_driver(msa311_driver);
> > +
> > +MODULE_AUTHOR("Dmitry Rokosov <ddrokosov@sberdevices.ru>");
> > +MODULE_DESCRIPTION("MEMSensing MSA311 3-axis accelerometer driver");
> > +MODULE_LICENSE("GPL v2");
>=20

--=20
Thank you,
Dmitry=

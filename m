Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DF3599CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348582AbiHSM6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348571AbiHSM6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:58:37 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5518E5AA12;
        Fri, 19 Aug 2022 05:58:30 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id AEE915FD0A;
        Fri, 19 Aug 2022 15:58:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660913908;
        bh=mV32apQZiwpfkDAVJ5k4DpFpqFlO7XNn+FZ43GXY+9E=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=GZKDeT5nGi6bKKmu6VujALnQB2iPqGFXgb2IA3GxiFGQUyvy6flF5FWn+dBTn9M5Y
         Dpu+VveeemJ1rPC5XN+Ib08fEkgtK8gGFBpENehKn1fM1GCgPWYpNlYclb1A2PXEVS
         k8Z+IKYgxNJ5mr8mt0rO4VrG3GpdmyjyH0RViQ6HEcgbMcHUIMXV3xgAljs6EW169T
         aZcwqy+4UoKB6i950/rDo169xTw0dP/CyNQvctr7jjLT8UBI7EQv9nO+GeyV1drhcq
         7hYWFXEoZKJjcqvWfNyjpVs0aDISshrbZRhXH8hSMxpg9RkzewpHRodRVia2EMPdNX
         IeLfqOMn9FiPA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri, 19 Aug 2022 15:58:22 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>,
        "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
        "jani.nikula@intel.com" <jani.nikula@intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/4] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Topic: [PATCH v6 3/4] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Index: AQHYsaUBRyDxGBAJ7E6dKrTfsTk6Jq21uX2AgABHogA=
Date:   Fri, 19 Aug 2022 12:57:54 +0000
Message-ID: <20220819125818.37qc66akgercd6zb@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220816191842.14020-1-ddrokosov@sberdevices.ru>
 <20220816191842.14020-4-ddrokosov@sberdevices.ru>
 <CAHp75VewJ1taLhsCb4_yEQHpw4VDXRhkxpL0jzdu-JsajfF6oA@mail.gmail.com>
In-Reply-To: <CAHp75VewJ1taLhsCb4_yEQHpw4VDXRhkxpL0jzdu-JsajfF6oA@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <41BD410FFE7FDA4788784A43920F1154@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/19 07:02:00 #20132955
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 11:41:55AM +0300, Andy Shevchenko wrote:

[...]

> > Spec: https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.=
pdf
>=20
> Have you ever seen such a tag?
> We have the Datasheet that is more or less established for this kind of l=
inks.

As I mentioned before, if I use Datasheet tag, line length limit will be
exceeded. If it's okay, I don't mind.

[...]

> > +       char chip_name[10];
>=20
> Why limit it to 10? You may use devm_kasprintf()

Oh, didn't know about that. Thank you for suggestion!

>=20
> > +       struct iio_trigger *new_data_trig;
> > +       struct regulator *vdd;
> > +};
>=20
> ...
>=20
> > +static inline int msa311_set_odr(struct msa311_priv *msa311, unsigned =
int odr)
>=20
> Why inline?
>=20

Why not? :) It's short function which is good to be inline, I think.

> > +{
> > +       struct device *dev =3D msa311->dev;
> > +       unsigned int pwr_mode;
>=20
> > +       bool good_odr =3D false;
>=20
> Can it be split to see the assignments together below?
>=20
> > +       int err;
> > +
> > +       err =3D regmap_field_read(msa311->fields[F_PWR_MODE], &pwr_mode=
);
> > +       if (err)
> > +               return err;
> > +
> > +       /* Filter bad ODR values */
> > +       if (pwr_mode =3D=3D MSA311_PWR_MODE_NORMAL)
> > +               good_odr =3D (odr > MSA311_ODR_1_95_HZ);
>=20
> else
>   good_odr =3D false;
>=20

No problem.

> > +       if (!good_odr) {
> > +               dev_err(dev,
> > +                       "can't set odr %u.%06uHz, not available in %s m=
ode\n",
> > +                       msa311_odr_table[odr].integral,
> > +                       msa311_odr_table[odr].microfract,
> > +                       msa311_pwr_modes[pwr_mode]);
> > +               return -EINVAL;
> > +       }
> > +
> > +       return regmap_field_write(msa311->fields[F_ODR], odr);
> > +}
>=20
> ...
>=20
> > +       if (wait_ms < unintr_thresh_ms)
> > +               usleep_range(wait_ms * USEC_PER_MSEC,
> > +                            unintr_thresh_ms * USEC_PER_MSEC);
> > +       else
> > +               return msleep_interruptible(wait_ms) ? -EINTR : 0;
>=20
> Can be refactored to simple
>=20
> else if (msleep...)
>   return -EINTR;
>=20
> Same amount of LoCs, but more readable.
>=20

Agreed.

> > +       return 0;
>=20
> ...
>=20
> > +err:
>=20
> We usually name labels after what they are doing, I don't see any
> error here, but notify done. Hence,
>=20
> out_notify_done:
>=20

Yes, usually I'm trying to fit the same rules. Will rework this place.


> > +       iio_trigger_notify_done(indio_dev->trig);
> > +
> > +       return IRQ_HANDLED;
>=20
> ...
>=20
> > +       used =3D scnprintf(msa311->chip_name, sizeof(msa311->chip_name)=
,
> > +                        "msa311-%hhx", partid);
>=20
> How 'used' is being used?
>=20

Oops

> > +       return 0;
> > +}
>=20
> ...
>=20
> > +       const char zero_bulk[2] =3D {0};
>=20
> 0 is not needed, '{ }' will work.
>=20
> ...
>=20
> > +       /*
> > +        * Register powerdown deferred callback which suspends the chip
> > +        * after module unloaded.
> > +        *
> > +        * MSA311 should be in SUSPEND mode in the two cases:
> > +        * 1) When driver is loaded, but we do not have any data or
> > +        *    configuration requests to it (we are solving it using
> > +        *    autosuspend feature).
> > +        * 2) When driver is unloaded and device is not used (devm acti=
on is
> > +        *    used in this case).
> > +        */
>=20
> ...
>=20
> > +static struct i2c_driver msa311_driver =3D {
> > +       .driver =3D {
> > +               .name =3D "msa311",
>=20
> > +               .owner =3D THIS_MODULE,
>=20
> Redundant.
>=20

You are right. I see that i2c_register_driver initialize .owner to
THIS_MODULE. Thank you for pointing.

[...]

--=20
Thank you,
Dmitry=

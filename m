Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C00959306A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242671AbiHOOC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242584AbiHOOCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:02:20 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133E822B33;
        Mon, 15 Aug 2022 07:02:15 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id AA39A5FD05;
        Mon, 15 Aug 2022 17:02:12 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660572132;
        bh=+gk1zIe/2wlOR10+rhMR8vZyUOoo8PbfRZUFI4FuEik=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=beWTLuaEQ+aONnlAW/G59TyPHF26QbQtq1PHhhYI4FDliH3UGPKs9yOyRIlhpwctO
         DAUDcHOkAVEpjl4EUhBkWB6Gk8eFSBgYBlb2LJx7to8ff6ykVWbJ6SVcPkeUVbwXax
         9RmU1axM5Jsq47aO/saV2qGRpu3BKLaxtv669qH5vA9praMXrISn0nSnM1t3awGlG0
         kHrk/1zwedj0t8217KHVqD+cWi7zGOY4xWr8o0mrSUunwVTkQjA5aBBC2gDqM+w4Id
         abdo8J8T+++caor/mkVjn+DrWWGMIO+cYRpNfsKiwwWBHTxxwk6tmv7IWR4/400fsB
         dCVC3/bRNK47w==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Mon, 15 Aug 2022 17:02:05 +0300 (MSK)
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
Subject: Re: [PATCH v5 6/7] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Topic: [PATCH v5 6/7] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Index: AQHYrmvoIVWL45TwmUSMsw+zEhPYFa2rqEkAgAQnwoA=
Date:   Mon, 15 Aug 2022 14:01:13 +0000
Message-ID: <20220815140201.5dpjpk35tdewcpvu@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220812165243.22177-1-ddrokosov@sberdevices.ru>
 <20220812165243.22177-7-ddrokosov@sberdevices.ru>
 <CAHp75Ve8VtwGX6YeuGvhUat5UfoLXB4RdkW4vc1kQUk71+_aCA@mail.gmail.com>
In-Reply-To: <CAHp75Ve8VtwGX6YeuGvhUat5UfoLXB4RdkW4vc1kQUk71+_aCA@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <987B2D9B23A0EB4184D532ADE9321F15@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/15 12:17:00 #20121227
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 13, 2022 at 01:34:40AM +0300, Andy Shevchenko wrote:

[...]

> > Spec: https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.=
pdf
>=20
> Can you use Datasheet: tag below (just before your SoB tag)?

Sure, I can move it on the previous line beforce SoB tag.
But with Datasheet: tag this line will be over the commit msg line limit.
If you don't mind I will stay with Spec: tag instead of Datasheet:

[...]

> > +static const struct {
> > +       int val;
> > +       int val2;
> > +} msa311_fs_table[] =3D {
> > +       {0, 9580}, {0, 19160}, {0, 38320}, {0, 76641}
> > +};
>=20
> At least you may deduplicate the type definition for these data structure=
s, like
>=20
> struct iio_float {
>   int integer;
>   int fract;
> };

Agreed. I will make deduplication of this type inside msa311 driver
only.

[...]

> > +               dev_err(dev,
> > +                       "cannot set odr %u.%luHz, not available in %s m=
ode\n",
> > +                       msa311_odr_table[odr].val,
> > +                       msa311_odr_table[odr].val2 / MILLIHZ_PER_HZ,
>=20
> Logically it's MICROHZ_PER_MILLIHZ.
>=20

You are right. But I think it would be better to print the original val2
value with zero-padding.

[...]

> > +       freq_uhz =3D msa311_odr_table[odr].val * MICROHZ_PER_HZ +
> > +                  msa311_odr_table[odr].val2;
> > +       wait_ms =3D (MICROHZ_PER_HZ / freq_uhz) * MSEC_PER_SEC;
>=20
> On the contrary this seems correct.

Good

> > +       err =3D iio_device_claim_direct_mode(indio_dev);
> > +       if (err)
> > +               return err;
> > +
> > +       mutex_lock(&msa311->lock);
> > +       err =3D msa311_get_axis(msa311, chan, &axis);
> > +       mutex_unlock(&msa311->lock);
> > +
> > +       iio_device_release_direct_mode(indio_dev);
> > +
> > +       if (err) {
> > +               dev_err(dev, "cannot get axis %s (%pe)\n",
> > +                       chan->datasheet_name, ERR_PTR(err));
> > +               return err;
> > +       }
> > +
> > +       pm_runtime_mark_last_busy(dev);
> > +       pm_runtime_put_autosuspend(dev);
>=20
> All error cases above miss the PM restoration. Is it on purpose?
> Otherwise fix it here and check everywhere else.

Nice catch! This is a bug. I'll fix it in v6

> > +       used =3D scnprintf(msa311->chip_name, sizeof(msa311->chip_name)=
,
> > +                        "msa311-%hhx", partid);
>=20
> > +       msa311->chip_name[used] =3D '\0';
>=20
> What is this for exactly?
>=20

Ah, you are right, scnprintf() makes null terminating inside.

> > +       /* Disable all interrupts by default */
> > +       err =3D regmap_write(msa311->regs, MSA311_INT_SET_0_REG, 0);
> > +       if (err)
> > +               return dev_err_probe(dev, err,
> > +                                    "cannot disable set0 interrupts\n"=
);
> > +
> > +       err =3D regmap_write(msa311->regs, MSA311_INT_SET_1_REG, 0);
> > +       if (err)
> > +               return dev_err_probe(dev, err,
> > +                                    "cannot disable set1 interrupts\n"=
);
>=20
> Wondering if the above can be combined to bulk write.
>=20

I will try and rework this place if it's workable.

> > +       /* Unmap all INT1 interrupts by default */
> > +       err =3D regmap_write(msa311->regs, MSA311_INT_MAP_0_REG, 0);
> > +       if (err)
> > +               return dev_err_probe(dev, err,
> > +                                    "failed to unmap map0 interrupts\n=
");
> > +
> > +       err =3D regmap_write(msa311->regs, MSA311_INT_MAP_1_REG, 0);
> > +       if (err)
> > +               return dev_err_probe(dev, err,
> > +                                    "failed to unmap map1 interrupts\n=
");
>=20
> Ditto.

The same as above.

[...]

--=20
Thank you,
Dmitry=

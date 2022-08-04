Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4D658A05B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbiHDSRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiHDSRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:17:37 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2406C116;
        Thu,  4 Aug 2022 11:17:31 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id D5F135FD06;
        Thu,  4 Aug 2022 21:17:29 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1659637049;
        bh=Tvb9VvakfApSPWdpoQx5Q1AcS3jGz0l17iYUSKjdN+M=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=n3Kwntd7y5Fw+H3WQtG0ajJUj379omQjTE6t8oUetMppbYkAYtektxKsKJuUc3KI9
         YGinavIhcy5VGBc5VvlvSe8bKXoQDXcfioV1QUbwUuB2aCJvKPlqNiaqGF7v3xyj5A
         R//M+CGQIQd6+9ISsK2OZE0wY5Mw2WHgLn7KNQ4fU6+WLKpfbW5lTs/QuVefKm0ESn
         C4NlzRrjNaFB5CJFXTqIglytwei94XH+2HOItkhJbptACoT7j4LkFs8ZpsJqM9JL1W
         +kg/pm3VV3NAWGkxexIayoqLdJKAzXhKrd9FoyYiJrX3QfL93dvKnmf7GGkXDuYT5T
         dTnI0WCaZLuGw==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Thu,  4 Aug 2022 21:17:28 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Topic: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Index: AQHYpzqIoQnaRj7vNkq2cXUUGjAB/62dQgeAgAAYQICAAYHbgA==
Date:   Thu, 4 Aug 2022 18:17:05 +0000
Message-ID: <20220804181723.4bljpxcwkj6cnn2f@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220803131132.19630-1-ddrokosov@sberdevices.ru>
 <20220803131132.19630-3-ddrokosov@sberdevices.ru>
 <CAHp75VcVuC6yVoB1kycCOfqMa=JfCtbe3WYSK5qndtYcJy3vpg@mail.gmail.com>
 <20220803191621.tzrmndkygfe7nlpx@CAB-WSD-L081021.sigma.sbrf.ru>
In-Reply-To: <20220803191621.tzrmndkygfe7nlpx@CAB-WSD-L081021.sigma.sbrf.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <88CACE263C12EA449953E33B2739D1C6@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/04 16:30:00 #20051329
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy,

I have one question about str_read_write() helper, please find it below.

On Wed, Aug 03, 2022 at 07:16:13PM +0000, Dmitry Rokosov wrote:
> Hello Andy,
>=20
> Thank you for quick review,
>=20
> On Wed, Aug 03, 2022 at 07:49:33PM +0200, Andy Shevchenko wrote:
> > On Wed, Aug 3, 2022 at 3:11 PM Dmitry Rokosov <DDRokosov@sberdevices.ru=
> wrote:
> > >
> > > MSA311 is a tri-axial, low-g accelerometer with I2C digital output fo=
r
> > > sensitivity consumer applications. It has dynamic user-selectable ful=
l
> > > scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurem=
ents
> > > with output data rates from 1Hz to 1000Hz.
> > >
> > > Spec: https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-EN=
G.pdf
> > >
> > > This driver supports following MSA311 features:
> > >     - IIO interface
> > >     - Different power modes: NORMAL and SUSPEND (using pm_runtime)
> > >     - ODR (Output Data Rate) selection
> > >     - Scale and samp_freq selection
> > >     - IIO triggered buffer, IIO reg access
> > >     - NEW_DATA interrupt + trigger
> > >
> > > Below features to be done:
> > >     - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
> > >     - Low Power mode
> >=20
> > Thanks for an update, my comments below.

[...]

> >=20
> > ...
> >=20
> > > +               dev_err(dev, "cannot %s register %u from debugfs (%d)=
\n",
> > > +                       readval ? "read" : "write", reg, err);
> >=20
> > You may consider taking [1] as a precursor here and use str_read_write(=
).
> >=20
> > [1]: https://lore.kernel.org/linux-i2c/20220703154232.55549-1-andriy.sh=
evchenko@linux.intel.com/
>=20
> Oh, really... Thank you for suggestion!

I have taken it closer, and it's really helpful and nice, but looks like
it's not merged to linux-next.
Please advise how I can use it in the driver. Should I provide
"Depends-On:" tag as I did for my HZ units patchset?

--=20
Thank you,
Dmitry=

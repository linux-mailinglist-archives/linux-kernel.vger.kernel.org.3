Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764F854F916
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382656AbiFQOXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiFQOXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:23:07 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A7313F14;
        Fri, 17 Jun 2022 07:23:01 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id A3D9B5FD02;
        Fri, 17 Jun 2022 17:22:58 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1655475778;
        bh=Jdzs37PQONv+MWbIBgcYFpdKs3EVFCoHkcvkdPG8Yh8=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=mKtGSg/oUWAu5xHFLhdo62tmRerPWeQ025Z+ujrDdbMSg9Jy5TTf+JeZvRNOrFhw/
         LdwD8DB5g/B63Fjzf0cazM0D2QdnAhw/LOKjRzr6q7hwjNttLw/EN0j88JJRlbJKR4
         ZMCXUw8G9zVh2z/q1Il2pHmeNxFfYQB65KZk9Ff5hh3KehA4ffkocg19qN+YJgouiG
         P3bHqP5RbUI9IL3MXGU0FijsasjbKm75t+AiaBsR+DO2eMBXwSvMrw4Az9PonVHind
         FXfNfMO7VRi0hARyVGEWP5EJH6y9/C1hWWxUQHsBNzWuM6ySWaIeO8hh4AyPV/+njC
         Jf+9E7REh9omQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri, 17 Jun 2022 17:22:45 +0300 (MSK)
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
Subject: Re: [PATCH v3 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Topic: [PATCH v3 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Index: AQHYgW2+up0uMWdZgUWEAW/5cCPkBq1RwVQAgABPMQCAABr0AIABSsaA
Date:   Fri, 17 Jun 2022 14:22:22 +0000
Message-ID: <20220617142239.wq43wjdxdc2cq37r@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220616104211.9257-1-ddrokosov@sberdevices.ru>
 <20220616104211.9257-3-ddrokosov@sberdevices.ru>
 <CAHp75Vc0+ckNnm2tzLMPrjeFRjwoj3zy0C4koNShFRG3kP8b6w@mail.gmail.com>
 <20220616170218.dihjli46spimozeg@CAB-WSD-L081021.sigma.sbrf.ru>
 <CAHp75VdEY9z_0=sAkKOico9JKYPOX6yqnoetiW49oFHm+SeUoQ@mail.gmail.com>
In-Reply-To: <CAHp75VdEY9z_0=sAkKOico9JKYPOX6yqnoetiW49oFHm+SeUoQ@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <90F88ACC28C1C841A6FDC5B0F822968E@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/06/17 11:24:00 #19799334
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 08:38:46PM +0200, Andy Shevchenko wrote:
> On Thu, Jun 16, 2022 at 7:02 PM Dmitry Rokosov <DDRokosov@sberdevices.ru>=
 wrote:
> > On Thu, Jun 16, 2022 at 02:18:52PM +0200, Andy Shevchenko wrote:
> > > On Thu, Jun 16, 2022 at 12:42 PM Dmitry Rokosov
> > > <DDRokosov@sberdevices.ru> wrote:
>=20
> ...
>=20
> > > Not sure why you put those blank lines herey, it makes code not compa=
ct.
> >
> > Here I use blank lines to split fields from different registers.
> > In other words, in the msa311_fields enum one line contains fields from=
 one
> > register. But for some heavy registers (like TAP_ACTIVE_STS) we have so=
 many
> > fields and their declaration doesn't fit to 80 symbols.
> > So I've made a decision to split registers using blank lines.
>=20
> Better is to add a comment explaining what register is described
> below, and not just a blank line.
>=20
> ...
>=20

Agreed, I'll do that in the v4.

...

> > > > +       wait_ms =3D (USEC_PER_SEC * MSEC_PER_SEC) / freq_uhz;
> > >
> > > This looks very odd from a physics perspective: sec * sec * sec =3D=
=3D sec ?!
> > >
> > > Perhaps you meant some HZ* macros from units.h?
> > >
> >
> > I suppose because of UHZ calculation I have to use NANO instead of
> > USEC_PER_SEC in the following line:
> >
> >         freq_uhz =3D msa311_odr_table[odr].val * USEC_PER_SEC +
> >                    msa311_odr_table[odr].val2;
> >
> > But below line is right from physics perspective. 1sec =3D 1/Hz, so
> > msec =3D (USEC_PER_SEC / freq_uhz) * MSEC_PER_SEC:
> >
> >         wait_ms =3D (USEC_PER_SEC * MSEC_PER_SEC) / freq_uhz;
> >
> > Or do you mean that I should change MSEC_PER_SEC to just MILLI?
>=20
> 1 / Hz =3D 1 sec. That's how physics defines it. Try to figure out what
> you meant by above multiplications / divisions and come up with the
> best that fits your purposes.
>=20
> ...
>=20

From my point of view, I've already implemented the best way to calculate
how much time I need to wait for the next data chunk based on ODR Hz
value :-)

ODR value from the table has val integer part and val2 in microHz.
By this line we calculate microHz conversion to take into account val2
part:


    freq_uhz =3D msa311_odr_table[odr].val * USEC_PER_SEC +
               msa311_odr_table[odr].val2;

By the next line we try to calculate miliseconds for msleep() from ODR
microHz value:

    wait_ms =3D (USEC_PER_SEC * MSEC_PER_SEC) / freq_uhz;

(USEC_PER_SEC / freq_uhz) =3D> seconds
seconds * MSEC_PER_SEC =3D> milliseconds

USEC_PER_SEC and MSEC_PER_SEC are just coefficients, they are not
measured in "seconds" units.

> > > > +                       if (err) {
> > > > +                               dev_err(dev, "cannot update freq (%=
d)\n", err);
> > > > +                               goto failed;
> > > > +                       }
> > >
> > > Why is this inside the loop and more important under lock? Also you
> > > may cover the initial error code by this message when moving it out o=
f
> > > the loop and lock.
> > >
> > > Ditto for other code snippets in other function(s) where applicable.
> >
> > Yes, I can move dev_err() outside of loop. But all ODR search loop
> > should be under lock fully, because other msa311 operations should not
> > be executed when we search proper ODR place.
>=20
> I didn't suggest getting rid of the lock.
>=20
> ...
>=20

Sorry, I didn't get you... But I fully agree with you about dev_err()
movement.

> > > > +       mutex_lock(&msa311->lock);
> > > > +       err =3D regmap_field_write(msa311->fields[F_NEW_DATA_INT_EN=
], state);
> > > > +       mutex_unlock(&msa311->lock);
> > >
> > > > +
> > >
> > > No need.
> >
> > Sorry, I don't understand. We do not need to call it under lock, right?
> > I think we have to wrap it by msa311 lock, because other msa311
> > operations should not be executed when we enable or disable new data
> > interrupt (for example ODR value changing or something else).
>=20
> The blank line is not needed, I specifically commented on the
> emphasized paragraph (by delimiting it with blank lines and leaving
> the rest for the better context for you to understand, it seems it did
> the opposite...).
>=20
> ...
>=20

Yep, didn't get you properly... Sorry for that...

--=20
Thank you,
Dmitry=

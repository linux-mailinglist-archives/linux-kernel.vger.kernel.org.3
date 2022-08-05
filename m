Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9EB58AC4D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240878AbiHEOT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiHEOTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:19:53 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EDC4199B;
        Fri,  5 Aug 2022 07:19:51 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id E67115FD06;
        Fri,  5 Aug 2022 17:19:49 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1659709189;
        bh=2M6mlM/MoXNXXYasdLSREXOJkY3rzZBjBB//cb49t9k=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=DqYRfH8rbhQ8yil6RL8X69Jm4L0sa7CiOsZWykbaFOAobNc78Uniw5vSG+N4Hi8hW
         BCmVSTD+hwpVuIrZGFmGVi9cbPVBCjv3Rh6HMZIeaiRurIZFAFBdrrsriNjvRnBngp
         taSCRixmSQqjqh09YB3iO9ex2BOZMd5BKZxxvuYBvqRAhkGRClL9PHJ5MwZiDkmKOL
         z9SlzhTludyLSoIXery+Ia6dhSxtDpHWDG0rj2nrysUhpDJDqhdBfyOYYGXtOqSqPE
         ju3OzwovvK/9woRyyE6NrFUUynsr5WYDtQ566FJthpNv8Y9VBboU3dMuInddHsgBbN
         En6wCIbsJX6+w==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri,  5 Aug 2022 17:19:49 +0300 (MSK)
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
Thread-Index: AQHYpzqIoQnaRj7vNkq2cXUUGjAB/62dQgeAgAAYQICAAYT0AIABTNeA
Date:   Fri, 5 Aug 2022 14:19:21 +0000
Message-ID: <20220805141945.sqbhvojckfbmfh7w@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220803131132.19630-1-ddrokosov@sberdevices.ru>
 <20220803131132.19630-3-ddrokosov@sberdevices.ru>
 <CAHp75VcVuC6yVoB1kycCOfqMa=JfCtbe3WYSK5qndtYcJy3vpg@mail.gmail.com>
 <20220803191621.tzrmndkygfe7nlpx@CAB-WSD-L081021.sigma.sbrf.ru>
 <CAHp75VdCWKCVws_xp7igCAGYFC7bxkQgCyXFohQR5PHzTkoSpg@mail.gmail.com>
In-Reply-To: <CAHp75VdCWKCVws_xp7igCAGYFC7bxkQgCyXFohQR5PHzTkoSpg@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <700F76D94560BE41BF1C8EDED97E9E49@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/05 06:43:00 #20054623
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 08:28:28PM +0200, Andy Shevchenko wrote:
> > > > +static const struct {
> > > > +       int val;
> > > > +       int val2;
> > > > +} msa311_fs_table[] =3D {
> > > > +       {0, 9580}, {0, 19160}, {0, 38320}, {0, 76641}
> > > > +};
> > >
> > > Besides that this struct is defined not only once in the file, this i=
s
> > > very well NIH struct s32_fract. Why not use the latter?
>=20
> > Good point, but looks like this struct is not so popular in the other
> > kernel drivers:
>=20
> It's simply new, it is not about popularity. I would put it as it's
> not _yet_ so popular.

Okay, no problem. I've already reworked it to s32_fract locally.

>=20
> ...
>=20
> > grep "s32_fract" -r -l . | wc -l
> > 3
>=20
> Hint: `git grep` much much faster on Git repositories (it goes via
> index and not working copy) and see
> `git grep -lw s32_fract`
>=20

Thank you for the hint. Actually I'm using ripgrep for the kernel
fuzzysearching, it's faster than git grep. Here I gave an example based
on grep command, because it's general shell command for the searching
substrings I suppose.

> ...
>=20
> > > > +       .cache_type =3D REGCACHE_RBTREE,
> > >
> > > Tree hash is good for sparse data, do you really have it sparse (a lo=
t
> > > of  big gaps in between)?
> >
> > I suppose so. MSA311 regmap has ~6 gaps.
>=20
> Yes and how long is each gap in comparison to the overall space?

The longest gap is 0xb bytes.
>=20
> ...
>=20
> > > > +       for (fs =3D 0; fs < ARRAY_SIZE(msa311_fs_table); ++fs)
> > >
> > > fs++ will work as well.
> >
> > I would prefer ++fs if you don't mind :)
>=20
> Why? It's a non-standard pattern, and needs an explanation.
>=20

From statistics point of view, you are right :)

$ rg "for" | rg "\+\+[a-z]" | wc -l
7271
$ rg "for" | rg "[a-z]\+\+" | wc -l
81247

[...]

> > > > +                               dev_err(dev, "cannot update freq (%=
d)\n", err);
> > >
> > > frequency
> >
> > It will be more ugly due 80 symbols restriction.
>=20
> Nope, it will be understandable by the user. You do code for the user
> and then for the developer, right?

Sure, that's good point.

[...]

>=20
> ...
>=20
> > > > +               dev_dbg(dev, "found MSA311 compatible chip[%#x]\n",=
 partid);
> > >
> > > Useless message.
> >
> > Why? It's under dynamic debug, so I will see it if I really want to.
>=20
> So what the point of the _successful_ detection? You already know from
> the code, that partid, you know by other means that probe was
> successful, why this message is needed? Especially for debugging when
> we have initcall_debug option.
>=20

Agreed

[...]

--=20
Thank you,
Dmitry=

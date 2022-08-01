Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DC4586B89
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbiHANCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbiHANCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:02:41 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A34205D6;
        Mon,  1 Aug 2022 06:02:38 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 9E84F5FD18;
        Mon,  1 Aug 2022 16:02:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1659358955;
        bh=ltfa8vCGViX0X05znzT7k8Dpx3ILLRGYQ6OuPvZNc/E=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=GPi38vX0eAJ70L+h70wKbHM+TChQmTTkwVdr6y0h9GSlZtBiAMPwzMZUfpwYSIT/u
         rc5Qa/qS/9Xm2bkS18z+1YRaeZ1gEXuMvKWjyKyafRwtffokj7FFcBbFHikRqurREA
         dFiapTaSnIgABvTPFZ6vY0/SEi+9b6QWCwOLiN6dk6lD83jXgOe/ltnRu+6rofxKlg
         slCTtJl28I3x03pZg7Oh22F4BTvSvZOU8PDV9IDFC6kRxc38qG7prCAb8EkQx3ms/H
         Ii2P66M/NINl9PR48rVasvExku0tMskC+zvG4w4Bwr0405egMS7sUOOPDuMAwA8gFr
         8a22AsCfyPTVg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Mon,  1 Aug 2022 16:02:31 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] units: complement the set of Hz units
Thread-Topic: [PATCH v2 1/3] units: complement the set of Hz units
Thread-Index: AQHYo2/exMPEjcXGek6GXlZKNuELJ62VcaEAgAK6RYCAAajVgA==
Date:   Mon, 1 Aug 2022 13:01:40 +0000
Message-ID: <20220801130227.htocnkpkwiscpxur@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220729172332.19118-1-ddrokosov@sberdevices.ru>
 <20220729172332.19118-2-ddrokosov@sberdevices.ru>
 <CAHp75VfGEPVBWbZ16widVCjgCnYAoUurjDj+-2pgC2oBQR12ZQ@mail.gmail.com>
 <20220731124140.777ddd05@jic23-huawei>
In-Reply-To: <20220731124140.777ddd05@jic23-huawei>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D0C9721DA8A8F448B1C2C7C296701CEA@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/01 10:27:00 #20025860
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan,

Thank you for the review. Please find my comments below.

On Sun, Jul 31, 2022 at 12:41:55PM +0100, Jonathan Cameron wrote:
> On Fri, 29 Jul 2022 20:02:42 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>=20
> > On Fri, Jul 29, 2022 at 7:23 PM Dmitry Rokosov <DDRokosov@sberdevices.r=
u> wrote:
> > >
> > > Currently, Hz units do not have milli, micro and nano Hz coefficients=
.
> > > Some drivers (IIO especially) use their analogues to calculate
> > > appropriate Hz values. This patch includes them to units.h definition=
s,
> > > so they can be used from different kernel places. =20
> >=20
> > ...
> >=20
> > > +#define NHZ_PER_HZ             1000000000UL
> > > +#define UHZ_PER_HZ             1000000UL
> > > +#define MILLIHZ_PER_HZ         1000UL =20
> >=20
> > Oh, but then a bit of consistency?
> >=20
> > MICRO
> > NANO
> Tricky given existing items, but I agree we shouldn't make
> it worse.

Okay, agree. I'll change them to MILLI/MICRO/NANO in the next version.

>=20
> However, I'm not 100% sold on why we need these conversions relative to H=
Z.
> What's wrong with using MILLI / NANO etc as already defined?  I guess
> there is a 'documentation' like effect of making it clear these are frequ=
ency
> unit conversions, but I don't think it makes sense to add it for all the =
other
> types of unit, so why is Hz special?

Yes, you are totally right, it has some 'documenation' effect from
a physics theory perspective. Kernel already has some units for HZ, so I
think it's a bad idea when sometimes we have to use *HZ for KILO and
MEGA units, but sometimes we have to use abstract MILLI/MICRO/NANO
coefficients. In other words, I suppose the right way is to choose one
option from the following list:
   - remove all *HZ units and use abstract units instead
   - complement *HZ units and use them

In my opinion, the second one is better, because *HZ units are good
opposite to *SEC units (from time64.h).

>=20
> I'm not sure why we have the existing ones for HZ with the
> exception of KHZ_PER_MEGAHZ.
>=20
> Jonathan
>=20
> >=20
>=20

--=20
Thank you,
Dmitry=

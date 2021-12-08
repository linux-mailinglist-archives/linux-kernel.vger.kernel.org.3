Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E5A46D4F7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbhLHOCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbhLHOCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:02:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CE0C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 05:59:12 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1muxTM-0003RN-WC; Wed, 08 Dec 2021 14:59:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1muxTL-003Pmj-Ms; Wed, 08 Dec 2021 14:59:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1muxTK-0001f2-Lh; Wed, 08 Dec 2021 14:59:02 +0100
Date:   Wed, 8 Dec 2021 14:59:02 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     David Jander <david@protonic.nl>
Cc:     David Lechner <david@lechnology.com>, linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1] counter: interrupt-cnt: add counter_push_event()
Message-ID: <20211208135902.7j3aawytt3jlqgwr@pengutronix.de>
References: <20211123134540.416695-1-o.rempel@pengutronix.de>
 <YZ3XAeYyfGblfaOi@shinobu>
 <20211124072720.GA30281@pengutronix.de>
 <YZ7tv79LQwLL7h3T@shinobu>
 <f73650b6-5a08-9ea9-9ecb-c47665ef07b0@lechnology.com>
 <20211207081602.45b1423c@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mkfxf4qp7vifqjee"
Content-Disposition: inline
In-Reply-To: <20211207081602.45b1423c@erd992>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mkfxf4qp7vifqjee
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello David,

On Tue, Dec 07, 2021 at 08:16:02AM +0100, David Jander wrote:
> On Mon, 6 Dec 2021 13:24:18 -0600
> David Lechner <david@lechnology.com> wrote:
>=20
> > On 11/24/21 7:58 PM, William Breathitt Gray wrote:
> > > On Wed, Nov 24, 2021 at 08:27:20AM +0100, Oleksij Rempel wrote: =20
> > >> Hi William,
> > >>
> > >> On Wed, Nov 24, 2021 at 03:09:05PM +0900, William Breathitt Gray wro=
te: =20
> > >>> On Tue, Nov 23, 2021 at 02:45:40PM +0100, Oleksij Rempel wrote: =20
> > >>>> Add counter_push_event() to notify user space about new pulses
> > >>>>
> > >>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > >>>> ---
> > >>>>   drivers/counter/interrupt-cnt.c | 2 ++
> > >>>>   1 file changed, 2 insertions(+)
> > >>>>
> > >>>> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/int=
errupt-cnt.c
> > >>>> index 8514a87fcbee..b237137b552b 100644
> > >>>> --- a/drivers/counter/interrupt-cnt.c
> > >>>> +++ b/drivers/counter/interrupt-cnt.c
> > >>>> @@ -31,6 +31,8 @@ static irqreturn_t interrupt_cnt_isr(int irq, vo=
id *dev_id)
> > >>>>  =20
> > >>>>   	atomic_inc(&priv->count);
> > >>>>  =20
> > >>>> +	counter_push_event(&priv->counter, COUNTER_EVENT_OVERFLOW, 0);
> > >>>> +
> > >>>>   	return IRQ_HANDLED;
> > >>>>   }
> > >>>>  =20
> > >>>> --=20
> > >>>> 2.30.2 =20
> > >>>
> > >>> Hi Oleksij,
> > >>>
> > >>> It looks like this is pushing a COUNTER_EVENT_OVERFLOW event every =
time
> > >>> an interrupt is handled, which I suspect is not what you want to ha=
ppen.
> > >>> The COUNTER_EVENT_OVERFLOW event indicates a count value overflow e=
vent,
> > >>> so you'll need to check for a count value overflow before pushing t=
he
> > >>> event.
> > >>>
> > >>> It would be good idea to implement a ceiling extension as well (you=
 can
> > >>> use the COUNTER_COMP_CEILING() macro) so that users can configure t=
he
> > >>> particular point where the value overflows. =20
> > >>
> > >> Thank you!
> > >>
> > >> What would be the best and resource effective strategy for periodica=
lly
> > >> getting frequency of interrupts/pulses? This is actual information w=
hich is
> > >> needed for my use case.
> > >>
> > >> So far, I was pushing every event to the user space, which is working
> > >> but probably not the most resource effective method of doing it.
> > >>
> > >> Regards,
> > >> Oleskij
> > >> --=20
> > >> Pengutronix e.K.                           |                        =
     |
> > >> Steuerwalder Str. 21                       | http://www.pengutronix.=
de/  |
> > >> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-=
0    |
> > >> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-=
5555 | =20
> > >=20
> > > We could introduce a new Counter change-of-state event type which wou=
ld
> > > trigger whenever the count value changes, but I agree with you that t=
his
> > > is likely not the best way for us to derive the frequency of the
> > > interrupts due to the indirection of handling and parsing the event
> > > data.
> > >=20
> > > Instead, perhaps introducing a "frequency" or "period" Count extension
> > > would make more sense here. This extension could report the value del=
ta
> > > between counts, or alternatively the time delta from which you can
> > > derive frequency. Regarding implementation, you can store the previous
> > > value in a variable, updating it whenever an interrupt occurs, and
> > > compute the particular delta every time a read is requested by the us=
er.
> > >=20
> > > David Lechner is implementing something similar for the TI eQEP driver
> > > to expose speed, so I'm CCing them here in case this is of interest to
> > > them.
> > >  =20
> >=20
> > Based on my experience, I would recommend that counter drivers be as
> > "thin" as possible. They shouldn't try to provide any information that
> > the hardware itself doesn't provide. In other words, the kernel should
> > provide userspace the information needed to calculate the speed/rate
> > but not try to do the actual calculation in the kernel. Inevitably
> > there are nuances for specific use cases that can't all possibly be
> > handled by such an implementation.
>=20
> I completely agree with this. While interrupts aren't really meant for
> measuring frequency, and this being somewhat of a mis-use of something, i=
t is
> still possible to do and very useful in many cases. That said, while the
> counter framework is AFAIK the best fit for this, the main use-case for t=
his
> driver is measuring wheel speed (and similar "speeds"). For this, the min=
imum
> amount of information the driver needs to provide user-space with to do
> reliable calculations, is high-resolution time-stamps of GPIO events. A s=
imple
> counter is not suited, because there can be glitches that need to be dete=
cted.
> If user-space gets a buffer full of consecutive time-stamps (don't need t=
o be
> all of them, just a sample of n consecutive timestamps), as well as total
> count, all needed calculations, glitch filtering, low-pass filtering, etc=
=2E..
> can be done in user-space just fine.
>=20
> > I've tried using gpio interrupts to try to calculate speed/rate in
> > the kernel before and it simply doesn't work reliably. Interrupts
> > get missed and the calculation will be off.
>=20
> Exactly. Been there, done that.
> For reliable speed calculations of a mechanical system, the properties of=
 the
> mechanical system need to be known, like physical limits of accelerations,
> maximum (or minimum) speed, etc. The minimum set of input data needed by a
> user-space application to do these calculations is total pulse count in
> addition to a buffer of timestamps of n consecutive input events (raising=
 or
> falling edges on GPIO). So IMHO this is what the driver should provide, a=
nd
> in the most resource-efficient way possible. This particular driver will =
be
> used 3 times on the same SoC, with each up to 10-15k pulses per second. T=
hat
> is a lot of interrupts for an embedded system, so they better consume as
> little resources as possible. Filling a ring buffer with timestamps shoul=
d be
> possible, as long as no locking is involved. Locks in IRQ context must be
> avoided at all costs, specially in this case.
>=20
> > For really slow counts (i.e. 1 count/second), I can see a use for
> > generating an event on each count though. For high rates, I would
> > just read the count every 100ms in usespace and divide the change in
> > the number of counts by the time period to get the rate.
>=20
> For slow counts, I agree, but for high rates, I don't (see above). There =
can
> be glitches and false events that can (and must) be effectively filtered =
out.
> For that user-space needs to know the time of each event during the
> measurement period.

No sure I understood the problem here. If you keep the driver as is and
in userspace just read out the counter value twice and measure the time
between the reads[1], you can calculate the average frequency of the
event in userspace.

Isn't that good enough?

Best regards
Uwe

[1] maybe support this timing by providing a timestamp with the read
    value to reduce timing jitter.

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mkfxf4qp7vifqjee
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGwuiMACgkQwfwUeK3K
7AkzqQf9H805qI3GrlxiNoK2zp/ScyCZ8YbXwZ8dKt9uEsSyKPdwPcRW2cPrMMLj
dUTKBEs5m4Z48mp+whQPoa+2M5+UbUWHkLThhHaa0G+RSjRfn1Ei8r7qjVV0RXhp
4Ex+3DHlAYyUxN0vyqWb9lVzf1QHySWCnkxOn0wOnWglz/XlwHM7glD5qAqcnsPY
+RGELJac3pg5jL265FBKsnuXGCqvt+/7NuUJy79pULvwxI+Dhk+GKW6RsZIEqDlQ
r0DMG3j+KNoSUTaupzzzwVZ0Xo4lYB0RFXNLPYJeB4DWJH4WRVTjz24yDCOnb4Jj
iHgn8BvvPw7p9xkfKozodO9VmlDBDA==
=s5Z5
-----END PGP SIGNATURE-----

--mkfxf4qp7vifqjee--

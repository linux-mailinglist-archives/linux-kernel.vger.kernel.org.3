Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295E4475492
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbhLOIse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhLOIsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:48:33 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250DDC061574;
        Wed, 15 Dec 2021 00:48:33 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so19747075pja.1;
        Wed, 15 Dec 2021 00:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jhttsu8a6/OycA6zi2HrkxjstRN4FdF2SawJIVi2xH0=;
        b=X7X9JXd6V4rklf/T5MPCgB5Um5O+rOqENVuylm7ZX8v+gFRyxHDkdrtsPVfBz/Wp7N
         2ywFu56NMSPqpymBSLt0PgcLfiSMv6vjn0a+o/loHap+EnD8sQCqnZ57tsyxEcXvk6H8
         BVcmSoo91HNFu51c2/OlDc+zoVHy0MpBGu63xoGY1DE87Qf19nc8vikfc9u54DYFZlSW
         kOs50/JPQdaZlIz5mwEm+Q2l85v1Rd4yzzlXzj7iZEekbw/WtUrnMKMCg7n5mxYAtZxB
         pIbxx1xenJgGhUSAqxh2Lu8vA++tjkUwUbr5IJ2JAI0UJ6Pfyb3upNTEJf7BL3cP4ikP
         jC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jhttsu8a6/OycA6zi2HrkxjstRN4FdF2SawJIVi2xH0=;
        b=2phIBEuvcNNwyoOKBAvgjh5BOUBNN/1DvFgZaq4JwpqtDru+CHnj0Vv1sH2uTQjcgE
         VPBwGUOtOyumnYmIwiZYq9HHvEzEtvc0snnN7OOUhrpuiGl5k4quiDeQWj6o3HeC1wdx
         U8z6GRUk7hbfOn26cCVkfiJBmmpAu4wwQjZDAjpUZKVGCncL3tnGrk2J6OvjqM3geulV
         e/rbJDcxJ0VmaLMtMLpwmBoVeI9S2z/sHHrJ24mS3kkNdDPqRmsyF4oJzBpFBCkHunSi
         130234U5qTotpptxsB2Hh02FttR+zg+dcr6No7M5MKOQdIylPbS7342TpIKV0Rq1bAFh
         65jA==
X-Gm-Message-State: AOAM532Ft7nKOeIWRrKEqd8biadIa/FE8ab0nr9uwvgawWUht9NXWkCy
        WIwG6AkzJZnF4rA7e6R+V5HnYqUzGZTEdA==
X-Google-Smtp-Source: ABdhPJzet1cbGegAdCF8M4TDBHkTrNOc20mOa48x4sczoc+UWoy/xPVQkTnRtWcvqwod6X0Sy1nAnw==
X-Received: by 2002:a17:90b:4f85:: with SMTP id qe5mr10606715pjb.167.1639558112544;
        Wed, 15 Dec 2021 00:48:32 -0800 (PST)
Received: from shinobu ([37.120.154.45])
        by smtp.gmail.com with ESMTPSA id 66sm1606509pga.4.2021.12.15.00.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 00:48:31 -0800 (PST)
Date:   Wed, 15 Dec 2021 17:48:26 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Jander <david@protonic.nl>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        David Lechner <david@lechnology.com>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1] counter: interrupt-cnt: add counter_push_event()
Message-ID: <Ybmr2kCLScuGZ41h@shinobu>
References: <20211123134540.416695-1-o.rempel@pengutronix.de>
 <YZ3XAeYyfGblfaOi@shinobu>
 <20211124072720.GA30281@pengutronix.de>
 <YZ7tv79LQwLL7h3T@shinobu>
 <f73650b6-5a08-9ea9-9ecb-c47665ef07b0@lechnology.com>
 <20211207081602.45b1423c@erd992>
 <20211208135902.7j3aawytt3jlqgwr@pengutronix.de>
 <20211208171035.6ad117af@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0NmGEM62bMBapzpv"
Content-Disposition: inline
In-Reply-To: <20211208171035.6ad117af@erd992>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0NmGEM62bMBapzpv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 08, 2021 at 05:10:35PM +0100, David Jander wrote:
>=20
> Dear Uwe,
>=20
> On Wed, 8 Dec 2021 14:59:02 +0100
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > Hello David,
> >=20
> > On Tue, Dec 07, 2021 at 08:16:02AM +0100, David Jander wrote:
> > > On Mon, 6 Dec 2021 13:24:18 -0600
> > > David Lechner <david@lechnology.com> wrote:
> > >  =20
> > > > On 11/24/21 7:58 PM, William Breathitt Gray wrote: =20
> > > > > On Wed, Nov 24, 2021 at 08:27:20AM +0100, Oleksij Rempel wrote:  =
 =20
> > > > >> Hi William,
> > > > >>
> > > > >> On Wed, Nov 24, 2021 at 03:09:05PM +0900, William Breathitt Gray=
 wrote:   =20
> > > > >>> On Tue, Nov 23, 2021 at 02:45:40PM +0100, Oleksij Rempel wrote:=
   =20
> > > > >>>> Add counter_push_event() to notify user space about new pulses
> > > > >>>>
> > > > >>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > > >>>> ---
> > > > >>>>   drivers/counter/interrupt-cnt.c | 2 ++
> > > > >>>>   1 file changed, 2 insertions(+)
> > > > >>>>
> > > > >>>> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter=
/interrupt-cnt.c
> > > > >>>> index 8514a87fcbee..b237137b552b 100644
> > > > >>>> --- a/drivers/counter/interrupt-cnt.c
> > > > >>>> +++ b/drivers/counter/interrupt-cnt.c
> > > > >>>> @@ -31,6 +31,8 @@ static irqreturn_t interrupt_cnt_isr(int irq=
, void *dev_id)
> > > > >>>>  =20
> > > > >>>>   	atomic_inc(&priv->count);
> > > > >>>>  =20
> > > > >>>> +	counter_push_event(&priv->counter, COUNTER_EVENT_OVERFLOW, 0=
);
> > > > >>>> +
> > > > >>>>   	return IRQ_HANDLED;
> > > > >>>>   }
> > > > >>>>  =20
> > > > >>>> --=20
> > > > >>>> 2.30.2   =20
> > > > >>>
> > > > >>> Hi Oleksij,
> > > > >>>
> > > > >>> It looks like this is pushing a COUNTER_EVENT_OVERFLOW event ev=
ery time
> > > > >>> an interrupt is handled, which I suspect is not what you want t=
o happen.
> > > > >>> The COUNTER_EVENT_OVERFLOW event indicates a count value overfl=
ow event,
> > > > >>> so you'll need to check for a count value overflow before pushi=
ng the
> > > > >>> event.
> > > > >>>
> > > > >>> It would be good idea to implement a ceiling extension as well =
(you can
> > > > >>> use the COUNTER_COMP_CEILING() macro) so that users can configu=
re the
> > > > >>> particular point where the value overflows.   =20
> > > > >>
> > > > >> Thank you!
> > > > >>
> > > > >> What would be the best and resource effective strategy for perio=
dically
> > > > >> getting frequency of interrupts/pulses? This is actual informati=
on which is
> > > > >> needed for my use case.
> > > > >>
> > > > >> So far, I was pushing every event to the user space, which is wo=
rking
> > > > >> but probably not the most resource effective method of doing it.
> > > > >>
> > > > >> Regards,
> > > > >> Oleskij
> > > > >> --=20
> > > > >> Pengutronix e.K.                           |                    =
         |
> > > > >> Steuerwalder Str. 21                       | http://www.pengutro=
nix.de/  |
> > > > >> 31137 Hildesheim, Germany                  | Phone: +49-5121-206=
917-0    |
> > > > >> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206=
917-5555 |   =20
> > > > >=20
> > > > > We could introduce a new Counter change-of-state event type which=
 would
> > > > > trigger whenever the count value changes, but I agree with you th=
at this
> > > > > is likely not the best way for us to derive the frequency of the
> > > > > interrupts due to the indirection of handling and parsing the eve=
nt
> > > > > data.
> > > > >=20
> > > > > Instead, perhaps introducing a "frequency" or "period" Count exte=
nsion
> > > > > would make more sense here. This extension could report the value=
 delta
> > > > > between counts, or alternatively the time delta from which you can
> > > > > derive frequency. Regarding implementation, you can store the pre=
vious
> > > > > value in a variable, updating it whenever an interrupt occurs, and
> > > > > compute the particular delta every time a read is requested by th=
e user.
> > > > >=20
> > > > > David Lechner is implementing something similar for the TI eQEP d=
river
> > > > > to expose speed, so I'm CCing them here in case this is of intere=
st to
> > > > > them.
> > > > >    =20
> > > >=20
> > > > Based on my experience, I would recommend that counter drivers be as
> > > > "thin" as possible. They shouldn't try to provide any information t=
hat
> > > > the hardware itself doesn't provide. In other words, the kernel sho=
uld
> > > > provide userspace the information needed to calculate the speed/rate
> > > > but not try to do the actual calculation in the kernel. Inevitably
> > > > there are nuances for specific use cases that can't all possibly be
> > > > handled by such an implementation. =20
> > >=20
> > > I completely agree with this. While interrupts aren't really meant for
> > > measuring frequency, and this being somewhat of a mis-use of somethin=
g, it is
> > > still possible to do and very useful in many cases. That said, while =
the
> > > counter framework is AFAIK the best fit for this, the main use-case f=
or this
> > > driver is measuring wheel speed (and similar "speeds"). For this, the=
 minimum
> > > amount of information the driver needs to provide user-space with to =
do
> > > reliable calculations, is high-resolution time-stamps of GPIO events.=
 A simple
> > > counter is not suited, because there can be glitches that need to be =
detected.
> > > If user-space gets a buffer full of consecutive time-stamps (don't ne=
ed to be
> > > all of them, just a sample of n consecutive timestamps), as well as t=
otal
> > > count, all needed calculations, glitch filtering, low-pass filtering,=
 etc...
> > > can be done in user-space just fine.
> > >  =20
> > > > I've tried using gpio interrupts to try to calculate speed/rate in
> > > > the kernel before and it simply doesn't work reliably. Interrupts
> > > > get missed and the calculation will be off. =20
> > >=20
> > > Exactly. Been there, done that.
> > > For reliable speed calculations of a mechanical system, the propertie=
s of the
> > > mechanical system need to be known, like physical limits of accelerat=
ions,
> > > maximum (or minimum) speed, etc. The minimum set of input data needed=
 by a
> > > user-space application to do these calculations is total pulse count =
in
> > > addition to a buffer of timestamps of n consecutive input events (rai=
sing or
> > > falling edges on GPIO). So IMHO this is what the driver should provid=
e, and
> > > in the most resource-efficient way possible. This particular driver w=
ill be
> > > used 3 times on the same SoC, with each up to 10-15k pulses per secon=
d. That
> > > is a lot of interrupts for an embedded system, so they better consume=
 as
> > > little resources as possible. Filling a ring buffer with timestamps s=
hould be
> > > possible, as long as no locking is involved. Locks in IRQ context mus=
t be
> > > avoided at all costs, specially in this case.
> > >  =20
> > > > For really slow counts (i.e. 1 count/second), I can see a use for
> > > > generating an event on each count though. For high rates, I would
> > > > just read the count every 100ms in usespace and divide the change in
> > > > the number of counts by the time period to get the rate. =20
> > >=20
> > > For slow counts, I agree, but for high rates, I don't (see above). Th=
ere can
> > > be glitches and false events that can (and must) be effectively filte=
red out.
> > > For that user-space needs to know the time of each event during the
> > > measurement period. =20
> >=20
> > No sure I understood the problem here. If you keep the driver as is and
> > in userspace just read out the counter value twice and measure the time
> > between the reads[1], you can calculate the average frequency of the
> > event in userspace.
> >=20
> > Isn't that good enough?
>=20
> No, I'm afraid it isn't, for two reasons:
>=20
> 1. These counters are often used in environments, where glitches can and =
do
> happen. So sometimes there are fake events. The only way to tell fake from
> real pulses, is to filter them. Unfortunately you need the timestamps of =
each
> event for that.
>=20
> 2. Another reason for having time-stamps is the case when the frequency i=
s low
> and one still requires fast accurate measurements. In that case timestamps
> provide a way of accurately measuring period time.
>=20
> Best regards,
>=20
> --=20
> David Jander
> Protonic Holland.

Keeping drivers focused on just exposing the hardware data and
functionality is likely the best path to choose, so my earlier
suggestion of a "frequency" extension would better be left for userspace
to handle.

So in order to enable userspace to derive frequency, you need reliable
timestamps for enough consecutive events to provide an adequate size
sample of data on which to perform filtering and other such operations.

If we add a COUNTER_EVENT_CHANGE_OF_STATE or similar, every count change
will generate an event with a logged timestamp. Is the problem with this
solution primarily that the Counter event queue is currently utilizing
spinlocks for synchronization?

William Breathitt Gray

--0NmGEM62bMBapzpv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmG5q9oACgkQhvpINdm7
VJKggg/7BepSOAfGKEuogmOtDARfqM5bPzb5dZL6lko3F1Ivv1NBoV9q4a2HBDUA
AH2oeN9hP03FxUHl08+MoUaZ93/L7mXT0aiQuoatm9QYQcigxGKr63+HEfyZmYMN
1cRqNLdUWBHt5LfxElV1UorWzAyA0YpYPOFWkXYbctHUxXY1BANV9dbiNe/zYIzy
12CMF+1wg/Mibq7eEx6gmfajBXdevuAMsTncetFvUebF01P7W86h4YyCSbleebZZ
LS2f/QgB90WOAxzYrlWA0JKHQPKZKIpJQTj7IjEPLmO36OYUbgE9XRLITQYXtQ6u
Xmdv3hXYSwqxfmVfZwmTvgWiRYGWNH3/j1kk3/clkbz9cuidUrfpac+m4WquTsQk
+FAZb98DekBeBwGxqu7L3M/d+yRMuT8DwK5ruhQf46vpbQeuYzXxkDnByDQJveYl
XbHecbPzy/M6xkzQiC5yy13AcOJbT3bZbowuSVugkZw9abPNf6eqFTwaPAKXVCQN
ycLdTP6PR+ubyfYYfDtbYaweCe/gwpVhOuTkeIy7JB50DrkEVwOHwnHY+r1G75zL
98l/86g9vwJWbBgWnYKCT4qW6kDaLomijyz75m0ekFm37DwGlYpHt1fsCf54EgrZ
8yu1UY9QTQ/chsYaDLSd0BZtgo/ZMWuJ0qjzRxPzEL+laXtEczI=
=Awmw
-----END PGP SIGNATURE-----

--0NmGEM62bMBapzpv--

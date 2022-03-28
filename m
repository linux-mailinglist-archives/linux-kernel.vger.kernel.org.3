Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D30C4E9EB2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 20:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245071AbiC1SJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 14:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245010AbiC1SJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 14:09:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99005DE42
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 11:07:52 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nYtmI-0007iB-Qd; Mon, 28 Mar 2022 20:07:42 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-3f39-5bba-2215-6d78.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:3f39:5bba:2215:6d78])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0478655CFA;
        Mon, 28 Mar 2022 18:07:39 +0000 (UTC)
Date:   Mon, 28 Mar 2022 20:07:39 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Hurley <peter@hurleysoftware.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Esben Haabendal <esben@geanix.com>,
        Steven Walter <stevenrwalter@gmail.com>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?utf-8?B?QW5kcsOp?= Pribil <a.pribil@beck-ipc.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] RT scheduling policies for workqueues
Message-ID: <20220328180739.o2nka5u72jj66ipg@pengutronix.de>
References: <20220323145600.2156689-1-linux@rasmusvillemoes.dk>
 <YkGIhYKJG+w4L7ge@linutronix.de>
 <20220328100927.5ax34nea7sp7jdsy@pengutronix.de>
 <YkHyzcfiyjLfIVOo@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jaohf7esmtmkbeyj"
Content-Disposition: inline
In-Reply-To: <YkHyzcfiyjLfIVOo@slm.duckdns.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jaohf7esmtmkbeyj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.03.2022 07:39:25, Tejun Heo wrote:
> Hello,
>=20
> On Mon, Mar 28, 2022 at 12:09:27PM +0200, Marc Kleine-Budde wrote:
> > > Having a kthread per "low-latency" tty instance is something I would
> > > prefer. The kwork corner is an anonymous worker instance and probably
> > > does more harm than good. Especially if it is a knob for everyone whi=
ch
> > > is used for the wrong reasons and manages to be harmful in the end.
> > > With a special kthread for a particular tty, the thread can be assign=
ed
> > > with the desired priority within the system and ttyS1 can be
> > > distinguished from ttyS0 (and so on). This turned out to be useful in=
 a
> > > few setups over the years.
> >=20
> > +1
> >=20
> > The networking subsystem has gone the same/similar way with NAPI. NAPI
> > handling can be switched from the softirq to kernel thread on a per
> > interface basis.
>=20
> I wonder whether it'd be useful to provide a set of wrappers which can ma=
ke
> switching between workqueue and kworker easy. Semantics-wise, they're
> already mostly aligned and it shouldn't be too difficult to e.g. make an
> unbounded workqueue be backed by a dedicated kthread_worker instead of
> shared pool depending on a flag, or even allow switching dynamically.

For NAPI a sysfs entry was added to switch to threaded mode:

| 5fdd2f0e5c64 net: add sysfs attribute to control napi threaded mode
| 29863d41bb6e net: implement threaded-able napi poll loop support
| 898f8015ffe7 net: extract napi poll functionality to __napi_poll()

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--jaohf7esmtmkbeyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJB+WgACgkQrX5LkNig
013Z1ggAtDuYsJ8eovJaR23f5iytmtRRTA6QccpR0Mkf20o+g47two6oUywEU5dq
mC3OVmG8STeZflRuUelhII1ghKhmUUXGAN5z/lYuTypmKeGJoZeebPuwYPjUbGo2
gHxxsKFpBhanPh4uFgFzq1AYPmdMYIdL1Io/fbjym0BL41fyKmJJsTFJ9P9iAQmn
AXFr/VwU/Q0NbQD/SUKkzs0CvOoE5Zh1UvE2EIQCtFP8xUqiCAGx6ko0yEPrC5bS
NOsJKRrO6rSHY3wIFW0r77w2mxQIkzn3W8EWVL7037RMiYt4EQjgbLs2+cPh7DfS
+XEHOZs0yK2jpFKOpITZDOWfkPW+0g==
=s07w
-----END PGP SIGNATURE-----

--jaohf7esmtmkbeyj--

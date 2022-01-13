Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816CD48D987
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbiAMOLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbiAMOLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:11:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6CAC061748
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 06:11:38 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n80pD-0004V4-Ph; Thu, 13 Jan 2022 15:11:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n80pC-00A5Lh-0y; Thu, 13 Jan 2022 15:11:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n80pA-0006ua-DG; Thu, 13 Jan 2022 15:11:32 +0100
Date:   Thu, 13 Jan 2022 15:11:32 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     vishakha.joshi@intel.com, thierry.reding@gmail.com,
        lee.jones@linaro.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko.nikula@linux.intel.com,
        vijayakannan.ayyathurai@intel.com, bala.senthil@intel.com,
        tamal.saha@intel.com, lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v1 1/2] pwm: Add count to sysfs for Intel PWM driver
Message-ID: <20220113141132.vec2zisfdkrznyis@pengutronix.de>
References: <20220103081610.6656-1-vishakha.joshi@intel.com>
 <20220103081610.6656-2-vishakha.joshi@intel.com>
 <20220103121454.rduz4jftean4hkaw@pengutronix.de>
 <YdRSnxqIJf1C14+x@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u72jbzcajrumdalo"
Content-Disposition: inline
In-Reply-To: <YdRSnxqIJf1C14+x@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u72jbzcajrumdalo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jan 04, 2022 at 03:58:55PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 03, 2022 at 01:14:54PM +0100, Uwe Kleine-K=F6nig wrote:
> > If we really want to support a count, I request that all drivers that
> > don't support it get updated to refuse a request with count !=3D 0.
>=20
> Hmm... Not sure it worth it, perhaps taking into account above the -1
> (in unsigned type) returned on ->get_state() can suffice as not supporting
> feature?

In my eyes that's a bad idea. You have to touch most drivers anyhow to
set the -1. So the outcome is the worst possible combination: Many
changes and still much implicit logic distributed between the drivers
and the core about what is supported and what not.

(Or you have to initialize .count =3D -1 before calling the get_state
callback. Then you get rid of "have to touch most drivers". But that's
still ugly IMO.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--u72jbzcajrumdalo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHgMxAACgkQwfwUeK3K
7AmDBQf7B23shrh6K5S5ryerAtQS5Hv4ZvlQkTE8d0pz8YXutZTfHVgj5xnaF94f
4Q2orikGdjr9iSCmc64nxpcYLTBuTBScU1DGdUcplnr/o2xj0wkjlbcHDSYN/cl7
ulTv1hWy14Ux7F5n6jHRJR16U6pn4Vl3PiCCXUO0iTpZe7/I38bgHLcX+EgCzm1t
VWBxwr2Kza5c0ph4q8NSY/cPHoBsxJFB2pHnqfTJl5FyA3wCKaA/S+4TjXmI4H+F
NtZqUoCBnKzJoClrL50v4EOWJPp6WSSS77nyxtv4Ni4stC4mBw4spo9a2An4LOvm
dQtt5mCoKGZm7IzAp/xr2NYXjviKrw==
=f3+d
-----END PGP SIGNATURE-----

--u72jbzcajrumdalo--

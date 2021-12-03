Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F3946729D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 08:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378893AbhLCHet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 02:34:49 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:58674 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378867AbhLCHes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 02:34:48 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 500211C0BB1; Fri,  3 Dec 2021 08:31:23 +0100 (CET)
Date:   Fri, 3 Dec 2021 08:31:21 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yihao Han <hanyihao@vivo.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] leds: tca6507: Get rid of duplicate of_node
 assignment
Message-ID: <20211203073121.GA27457@amd>
References: <20211202210613.78584-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20211202210613.78584-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> GPIO library does copy the of_node from the parent device of
> the GPIO chip, there is no need to repeat this in the individual
> drivers. Remove assignment here.
>=20
> For the details one may look into the of_gpio_dev_init()
> implementation.

So... where do you see of_gpio_dev_init called in this particular
case?

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmGpx8kACgkQMOfwapXb+vIlQACgwevJyz0u/fsHQoWp3ppV+CkN
1FkAnjl8dZrSOnn+BbLlOnCH+VW3fM5B
=AZim
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--

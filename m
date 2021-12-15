Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3847476346
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbhLOU1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:27:46 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:45902 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235970AbhLOU1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:27:45 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 49C8D1C0B98; Wed, 15 Dec 2021 21:27:44 +0100 (CET)
Date:   Wed, 15 Dec 2021 21:27:36 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>,
        Yihao Han <hanyihao@vivo.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] leds: lgm-sso: Get rid of duplicate of_node
 assignment
Message-ID: <20211215202736.GC28336@duo.ucw.cz>
References: <20211214142739.60071-1-andriy.shevchenko@linux.intel.com>
 <20211214142739.60071-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
In-Reply-To: <20211214142739.60071-2-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2021-12-14 16:27:39, Andy Shevchenko wrote:
> GPIO library does copy the of_node from the parent device of
> the GPIO chip, there is no need to repeat this in the individual
> drivers. Remove assignment here.
>=20
> For the details one may look into the of_gpio_dev_init()
implementation.

Thank you, applied the series.
								Pavel
							=09
--=20
http://www.livejournal.com/~pavelmachek

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYbpPuAAKCRAw5/Bqldv6
8oy2AJ4ys8RDCqR/ZAocUmHs0AQS46CQCQCfQ2r17x/rM+igACR13gte02fxrCU=
=vAae
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAE247634D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbhLOU3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:29:06 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:46028 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbhLOU3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:29:05 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 438731C0B98; Wed, 15 Dec 2021 21:29:04 +0100 (CET)
Date:   Wed, 15 Dec 2021 21:29:00 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH] leds: ktd2692: Drop calling dev_of_node() in
 ktd2692_parse_dt
Message-ID: <20211215202900.GD28336@duo.ucw.cz>
References: <20211213190331.5531-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LKTjZJSUETSlgu2t"
Content-Disposition: inline
In-Reply-To: <20211213190331.5531-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LKTjZJSUETSlgu2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2021-12-13 19:03:31, Lad Prabhakar wrote:
> output of dev_of_node() is already assigned to "np" variable in
> ktd2692_parse_dt(). Use "np" variable to check if OF node is NULL
> instead of calling dev_of_node() again.
>=20
> Signed-off-by: Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com>

Thank you, applied.
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--LKTjZJSUETSlgu2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYbpQDAAKCRAw5/Bqldv6
8gUUAJ4/V1LxUnQ1beWiP7tdh1xcnkhCjwCeLWBZWvn0mPD8vM4KYc9f4IW8dvI=
=aAmM
-----END PGP SIGNATURE-----

--LKTjZJSUETSlgu2t--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F42D4882F0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 10:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbiAHJxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 04:53:10 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:33528 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbiAHJxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 04:53:09 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C0CC41C0B79; Sat,  8 Jan 2022 10:53:07 +0100 (CET)
Date:   Sat, 8 Jan 2022 10:53:06 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Pavel Machek <pavel@denx.de>,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: rzg2l_adc: Fix typo
Message-ID: <20220108095306.GA32266@amd>
References: <20220107172529.12361-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20220107172529.12361-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2022-01-07 17:25:29, Lad Prabhakar wrote:
> Fix typo RZG2L_ADSMP_DEFUALT_SAMPLING -> RZG2L_ADSMP_DEFAULT_SAMPLING.
>=20
> Reported-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Pavel Machek <pavel@denx.de>

Thank you.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmHZXwIACgkQMOfwapXb+vJd/wCdG4P08xtXY5i02VJ9n+Jl5QGx
nqUAn3eSndJgvb/zgv6ncU8HSAyDdPQH
=G+qI
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

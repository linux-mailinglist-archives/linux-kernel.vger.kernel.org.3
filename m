Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF901496C44
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 13:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiAVMGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 07:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiAVMGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 07:06:53 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304D6C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 04:06:53 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nBFAM-00043F-3N; Sat, 22 Jan 2022 13:06:46 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 80CE61FDB0;
        Sat, 22 Jan 2022 12:06:44 +0000 (UTC)
Date:   Sat, 22 Jan 2022 13:06:41 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm64: vdso: Fix "no previous prototype" warning
Message-ID: <20220122120641.h7p4xujjolkxe52o@pengutronix.de>
References: <20220109113504.1921017-1-mkl@pengutronix.de>
 <20220121121234.47273-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v3wc56hczuai2w67"
Content-Disposition: inline
In-Reply-To: <20220121121234.47273-1-vincenzo.frascino@arm.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v3wc56hczuai2w67
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.01.2022 12:12:34, Vincenzo Frascino wrote:
> If compiling the arm64 kernel with W=3D1 the following warning is produce=
d:
>=20
> | arch/arm64/kernel/vdso/vgettimeofday.c:9:5: error: no previous prototyp=
e for =E2=80=98__kernel_clock_gettime=E2=80=99 [-Werror=3Dmissing-prototype=
s]
> |     9 | int __kernel_clock_gettime(clockid_t clock,
> |       |     ^~~~~~~~~~~~~~~~~~~~~~
> | arch/arm64/kernel/vdso/vgettimeofday.c:15:5: error: no previous prototy=
pe for =E2=80=98__kernel_gettimeofday=E2=80=99 [-Werror=3Dmissing-prototype=
s]
> |    15 | int __kernel_gettimeofday(struct __kernel_old_timeval *tv,
> |       |     ^~~~~~~~~~~~~~~~~~~~~
> | arch/arm64/kernel/vdso/vgettimeofday.c:21:5: error: no previous prototy=
pe for =E2=80=98__kernel_clock_getres=E2=80=99 [-Werror=3Dmissing-prototype=
s]
> |    21 | int __kernel_clock_getres(clockid_t clock_id,
> |       |     ^~~~~~~~~~~~~~~~~~~~~
>=20
> This patch removes "-Wmissing-prototypes" and "-Wmissing-declarations" co=
mpilers
> flags from the compilation of vgettimeofday.c to make possible to build t=
he
> kernel with CONFIG_WERROR enabled.
>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Tested-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--v3wc56hczuai2w67
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHr804ACgkQqclaivrt
76lrEggAqM1dSpWkhhPT/0GqJ26yMtySWRcxr8pTM1k4+vRl8ZtWH65MeuKqI0hv
hhlZuQHbmke4L0/bsnrQPIjbYglJL6uUNP5ZSPE/S/SGb+f4a2kdx4V0xENfdjXi
ZXUNU7tLNAOq3v14TeijAkvJXEMETHz2Asy37mKJruqLRnUcdRKDc3Okam+XJfVC
EVD4Fkn4B9iisomiT3u9mm6U729ZbgXc4mXl1aH78H/zT1I9UmbblecyCJUtCD+M
5a4/NtVCYH1DjZMF1b75PCVJOBef21HP85wUUEOEPLqleILvqlcRvKRP4P0KZzMv
mbIyvUDhm1Unp+VgB8WcmbhmpVE8uw==
=v0d+
-----END PGP SIGNATURE-----

--v3wc56hczuai2w67--

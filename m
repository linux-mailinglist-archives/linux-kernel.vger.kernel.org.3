Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFE74684B7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 13:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384902AbhLDMTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 07:19:22 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:59078 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbhLDMTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 07:19:21 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7E8E11C0BA4; Sat,  4 Dec 2021 13:15:54 +0100 (CET)
Date:   Sat, 4 Dec 2021 13:15:53 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        James.Bottomley@HansenPartnership.com, svens@stackframe.org,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.4 4/9] parisc: Provide an extru_safe() macro to
 extract unsigned bits
Message-ID: <20211204121553.GA14855@duo.ucw.cz>
References: <20211130145402.947049-1-sashal@kernel.org>
 <20211130145402.947049-4-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20211130145402.947049-4-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Helge Deller <deller@gmx.de>
>=20
> [ Upstream commit 169d1a4a2adb2c246396c56aa2f9eec3868546f1 ]
>=20
> The extru instruction leaves the most significant 32 bits of the
> target register in an undefined state on PA 2.0 systems.
> Provide a macro to safely use extru on 32- and 64-bit machines.

As the macro is not used by subsequent 4.4 patches, I don't believe
this is suitable for -stable.

Best regards,
								Pavel
--=20
 'DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk'
 'HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany'


--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYatb+QAKCRAw5/Bqldv6
8vZgAJwNJfS0alYMDuhThPe/0GSNC3mCqQCfekVNPzFj9sq4DMHvmkIQFmBgrsI=
=2sbg
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

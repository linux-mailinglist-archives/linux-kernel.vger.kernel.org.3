Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610EB477B65
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240619AbhLPSUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240617AbhLPSUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:20:53 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB5DC061574;
        Thu, 16 Dec 2021 10:20:51 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFL5W0PJJz4xRC;
        Fri, 17 Dec 2021 05:20:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639678847;
        bh=cwW1GNemnFM2ClOGTVorwhD3nm7PjCegHZv+igwtO3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p+qsUg6qjPA4Z4DZ0PU2mQOJkjBtBrbyGWVKj/cU3bsu2dGfhejAZkGL5WHh/qPfs
         Mz7F6sWQ7c9xlZNWIIPJ7SdeNxnMvPC6AUtXmO8JSf3FsVcxbTh1jUXBBg1gTWRiur
         TAdtisD3UeUjEYtsuu1j97ZFej3g+FtnCd1nrzkm9SaiZ67vHQQF8YzFCAhBhE5UX/
         mPdn5RBo8u13AzoQf1OydUVG8b37q41o47p3K7CeYcfdSmd46dMNwsgaNPHq7QwQks
         vH4r+NmEdOA5w7KWupjXlJ3UIeA24yy2HYew7qfM3hPJ40W2aSoiED8C/Spklegv1T
         voy1zYB0le/Lw==
Date:   Fri, 17 Dec 2021 05:20:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Wudi Wang <wangwudi@hisilicon.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the irqchip tree
Message-ID: <20211217052046.619006b8@canb.auug.org.au>
In-Reply-To: <20211217051927.68516ed4@canb.auug.org.au>
References: <20211217051927.68516ed4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oCvk0FrW7wWY9Ad.EooqWgR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oCvk0FrW7wWY9Ad.EooqWgR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 17 Dec 2021 05:19:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> In commit
>=20
>   d094b4332232 ("irqchip/irq-gic-v3-its.c: Force synchronisation when iss=
uing INVALL")
>=20
> Fixes tag
>=20
>   Fixes: cc2d3216f53 ("irqchip: GICv3: ITS command queue")
>=20
> has these problem(s):
>=20
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").

That commit is actually in the irqchip-fixes tree, sorry.

--=20
Cheers,
Stephen Rothwell

--Sig_/oCvk0FrW7wWY9Ad.EooqWgR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG7g34ACgkQAVBC80lX
0GzNTwf/SaehyLxbkN7dfWve6gGkw0f2RXFRJQRK8L2UfHROox8I0W6aX4zyXlDc
vnm3mRg04fXa+ORNmg0G5Hm2agUG3/xsWzo6QdTecbd1+vjIhApuFiDU1fEULEYd
wW0FGq79Y5spXOwwON+v4MXf6M1j1vgL00H4/uQt5IlgySjooG8bDNYv21pNBy2x
GcUd0xGf2RpacSgoKkBPIq+wX32wOuEZc6FpKxikFkad5wEH+6p2s+MtPuI2/yHH
I8Y1qB2JYkn2gJxSiyvpnIdD1yi+Koq9+6TLVBnF0j7eBGefwYMrUj01arE4UbUA
wbNvLoR6VPQAhezMaLL+76uDXso+Sw==
=Qx8F
-----END PGP SIGNATURE-----

--Sig_/oCvk0FrW7wWY9Ad.EooqWgR--

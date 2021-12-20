Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C8F47B5FC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 23:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhLTWuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 17:50:50 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:46203 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhLTWuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 17:50:50 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JHvv452VMz4xgw;
        Tue, 21 Dec 2021 09:50:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1640040644;
        bh=tQIEBuYI1fm/9s/HzeSCbj3kUqPT3tDLkAGpSYeRH3A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T0Km/qDvl6/94cR8fG0+lSjMuSFz5EppLhOHUKK8S2nsGLinka6V8fD1uQM1QyA+N
         mcMA7H1HCo5QhEStMjIJ8muYefgRwm3Fru/0AZZmK3fuU9zmLcmVS/+rICi5Aqn7wI
         eqjKlNGuQyrcEe0CPMYa2Zvc+ZYarTmWovAOOaHl6S/gwA2UQ7XzkJS4nN0ECbO3Nq
         EuxkTZVw4djGSoCb4TZpLMkODzEZws8W+IZbIhpJw7KLmjDG/+iJf54BM/FAExrtXz
         PTpnYe31gsi5s5oSb5f3v7RY6PyXY3T323HoJxtC6wvFskgp28y/4m6wxfMSTalC1F
         5uSVedFpYTNew==
Date:   Tue, 21 Dec 2021 09:50:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Andy Gross <agross@kernel.org>
Cc:     broonie@kernel.org, Colin Cross <ccross@android.com>,
        Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: linux-next: manual merge of the tegra tree with the qcom tree
Message-ID: <20211221095039.29f8c42e@canb.auug.org.au>
In-Reply-To: <20211216080100.3496490-1-broonie@kernel.org>
References: <20211216080100.3496490-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SBao8dYeu=rP9jpKHP5SsqI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SBao8dYeu=rP9jpKHP5SsqI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 16 Dec 2021 08:01:00 +0000 broonie@kernel.org wrote:
>
> Today's linux-next merge of the tegra tree got a conflict in:
>=20
>   arch/arm/configs/multi_v7_defconfig
>=20
> between commit:
>=20
>   7495af9308354 ("ARM: multi_v7_defconfig: Enable drivers for DragonBoard=
 410c")
>=20
> from the qcom tree and commit:
>=20
>   ca1f7d245f530 ("ARM: config: multi v7: Enable display drivers used by T=
egra devices")
>=20
> from the tegra tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc arch/arm/configs/multi_v7_defconfig
> index ae227d309dc1b,3d509bc134440..0000000000000
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@@ -705,7 -690,7 +708,8 @@@ CONFIG_DRM_PANEL_ORISETECH_OTM8009A=3D
>   CONFIG_DRM_PANEL_RAYDIUM_RM68200=3Dm
>   CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=3Dm
>   CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=3Dm
>  +CONFIG_DRM_DISPLAY_CONNECTOR=3Dm
> + CONFIG_DRM_LVDS_CODEC=3Dm
>   CONFIG_DRM_NXP_PTN3460=3Dm
>   CONFIG_DRM_PARADE_PS8622=3Dm
>   CONFIG_DRM_SII902X=3Dm

This is now a conflict between the arm-soc and qcom trees.

--=20
Cheers,
Stephen Rothwell

--Sig_/SBao8dYeu=rP9jpKHP5SsqI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHBCL8ACgkQAVBC80lX
0Gw7qQf7BMJibwOsGvQKYAwvRY0HBdD5d4t5hmWUNkjAcHOj13zGAn/RUU6Fi1ua
SQMnT2MC6Hs1B1QUttBvbWcEIFHpjXHWnmG8l3eu4Cmwzo7shU+qssM8dz1ATuMv
BJFEdmKi0o63ljblCAt1295fXBjQJQQa0o/Dt3Q/IM+dnyiLeDg4yF0vV+0G+wY1
XCTAhNZyWwmJ6lnLBmKzhsjaz/eM4W8SpXn6qWZp+yWPyPOA7kjCPhpsv3tFGb6h
BzfqjxeIPga+7aFFAnrxdVqaJ4mP+9TqBBU7ELYl0oDa543fEdsHjcirn+yTQQ+G
jfVbHgv05JNj/YBYj1i8sAvBxURoUg==
=Lqt4
-----END PGP SIGNATURE-----

--Sig_/SBao8dYeu=rP9jpKHP5SsqI--

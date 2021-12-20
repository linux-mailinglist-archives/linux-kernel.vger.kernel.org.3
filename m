Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008AE47B5FF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 23:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhLTWxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 17:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhLTWxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 17:53:23 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7F8C061574;
        Mon, 20 Dec 2021 14:53:23 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JHvy31YGzz4xgt;
        Tue, 21 Dec 2021 09:53:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1640040801;
        bh=zarnCU9pvCFNhcKAoGy0fT71OCU0CnGr0wO7wfOFdKk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tgJNsvf7uZRXvUiU9qNAPORYiSYWiVDKTjzw4ePkF4zi6+vgLzdWE2owWRH35JOBF
         qeuyXBrts0QgzAEvosicIYRj/DYCeW9JoUxYQiHI27jOhWs0D1bhRgqRy6jMPkDis6
         yXoq0xQdhvPSyOOyhz/+rk+qZIjPDfqnU1yN1wDWRLbfrC8Rfhq6ay2YQSw78PBAjS
         84qctEJxV3FqhffWy9IsutuwEnPAxFnUr6q286WfJodJpUOFtrjPJz5hyCbrvu/UYS
         2mrRI/yhu1Ku1f6eVxbAXJEStrMfb4fp79jIczNCLwodvxgVXpz8ZQg8cObxOiO12x
         CWMuDkNJgi4KQ==
Date:   Tue, 21 Dec 2021 09:53:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Russell King <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: linux-next: manual merge of the samsung-krzk tree with the arm
 tree
Message-ID: <20211221095314.432527ff@canb.auug.org.au>
In-Reply-To: <20211220094012.5a340d45@canb.auug.org.au>
References: <20211220094012.5a340d45@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Zpdj7pn9cp/JR48okQ4_z4L";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Zpdj7pn9cp/JR48okQ4_z4L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 20 Dec 2021 09:40:12 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the samsung-krzk tree got a conflict in:
>=20
>   arch/arm/Kconfig
>=20
> between commit:
>=20
>   54f481a2308e ("ARM: remove old-style irq entry")
>=20
> from the arm tree and commit:
>=20
>   3ac5f9db26bb ("ARM: samsung: Remove HAVE_S3C2410_I2C and use direct dep=
endencies")
>=20
> from the samsung-krzk tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
>=20
> diff --cc arch/arm/Kconfig
> index 15bc7fba0761,391f07c17096..000000000000
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@@ -471,7 -478,7 +471,6 @@@ config ARCH_S3C24X
>   	select CLKSRC_SAMSUNG_PWM
>   	select GPIO_SAMSUNG
>   	select GPIOLIB
> - 	select HAVE_S3C2410_I2C if I2C
>  -	select GENERIC_IRQ_MULTI_HANDLER
>   	select NEED_MACH_IO_H
>   	select S3C2410_WATCHDOG
>   	select SAMSUNG_ATAGS

This is now a conflict between the arm and arm-soc trees.

--=20
Cheers,
Stephen Rothwell

--Sig_/Zpdj7pn9cp/JR48okQ4_z4L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHBCVoACgkQAVBC80lX
0GwFLwgAjj3wnCwqKcoCE2lmOpzPkl7z+MFqDQ/cBrZVJbJhlArK5fBsmmbmSzr8
HSGLzRMZNA9YWVmmwyD9QWlBFnAI6O8VlPGtpr0mr7mIZBv/ooVZYMA54hzkgnnz
XfpBbROxKgg3T14tdjbMauP0uz0lQosQnXzzydTPBGr2a1+GQnttYBaA5CXN2m1F
XYiw2JvrO7HKbarZk96Y26NiPYeGbPXJ0ztoDeLrZ8srJNjOyu6UXZbLJGt/IuXD
JU8SQTnfxFMQL6HZ4IoH/b1M32Q6a+gSRp2DnsWp5rJlzNxjY7U5tAxWgAoVMwBA
pspN1vPElJ0ms3mStdthM9RBsnDBeg==
=9Hp9
-----END PGP SIGNATURE-----

--Sig_/Zpdj7pn9cp/JR48okQ4_z4L--

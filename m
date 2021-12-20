Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E6047AA03
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 13:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhLTM7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 07:59:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57190 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhLTM7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:59:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84C1761052;
        Mon, 20 Dec 2021 12:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94BDC36AE9;
        Mon, 20 Dec 2021 12:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640005161;
        bh=cvkjnL8Vt4Ov4zMUd3/Cmz+GyzMZAAaM2YMINoQw4N0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JYQ2U66cYNkrvZfycRjpxFalLKRv4iDByDGyHrqkvlcJ3NHulktQ8DowT80sabbyJ
         EjEX1xnNo0nvWwotPKuHw8R98nS2L3Nb1Fb3J8V79ifUPCUOTJynpFGOlabpM4yEmJ
         6f9EQQtmXc1Icqmn8Qd2OAXoULNsBQKqlWihdMVkoC6dWOBBhd2rPfT7zntnzdYgCf
         tFitLJYAV96cVBFvONS0kGK6sXBNMnFBy5VWyV9JS4v9yBaxBHDmfwRhF1ansG/ygM
         UDoOCDblKMvywdd0NQD0pQfQQUvFhPOMnLFYrXI1Dbn2939yKG5xD2F9n0C/a1SvwV
         eF5kVXGTKurxg==
Date:   Mon, 20 Dec 2021 12:59:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     robh+dt@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, bgolaszewski@baylibre.com,
        sean.wang@mediatek.com, bayi.cheng@mediatek.com,
        gch981213@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v7 2/4] dt-bindings: spi: spi-mtk-nor: add new clock name
 'axi' for spi nor
Message-ID: <YcB+Ih5KkdaXGvsS@sirena.org.uk>
References: <20211220121825.6446-1-tinghan.shen@mediatek.com>
 <20211220121825.6446-3-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NST5rrJ6CjnkHa/k"
Content-Disposition: inline
In-Reply-To: <20211220121825.6446-3-tinghan.shen@mediatek.com>
X-Cookie: Christ was born in 4 B.C.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NST5rrJ6CjnkHa/k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 20, 2021 at 08:18:23PM +0800, Tinghan Shen wrote:
> Some mtk spi nor has dedicated dma(s) inside. Add a new clock name, axi,
> for spi nor dma bus clock.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--NST5rrJ6CjnkHa/k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHAfiIACgkQJNaLcl1U
h9CFkQf+PYaFOrmJrFz0nn/s4JFUuZA/0JmpfjK6Cv9M4kE+d077UHibmgwtxJnm
MsH5VHjOgH7VdSFmaOi8vbSVyjjgEIQv23PP4JeNIJdZ9PO04XsveM9RosrAndfo
T4H5HQTulqCYybkNBff2P1koJMZLitk9DilbGRv0KSQx6kf2fu04Hkp6Gb38ryee
I2CydD5ul/+DCAG6VV1d9Q+dmYM3VH1qQnktN34pLpyVsDQX5MGaPDtS2xEzm+Bn
W6nVpc6qqH2aNt3bQcil1SYjOnPx4urfxJ0+Nq0xhmbl+YsVFN8fdwq+LNbdBxYp
89C6bb664Q3Tyj8qZMl0y9Iqn2tRiQ==
=k7OU
-----END PGP SIGNATURE-----

--NST5rrJ6CjnkHa/k--

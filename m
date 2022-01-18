Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23C9492BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346964AbiARRGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiARRGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:06:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23385C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 09:06:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A3A161471
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 17:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADB7C340E0;
        Tue, 18 Jan 2022 17:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642525565;
        bh=ZFgCwFtYPKdyAExQU4X13HYFF3am3ud7wOGEu6ZI/zY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G2lZV0mxFZly9yUCbQQjaopNqJBnzh2peaIX1mEwPmk3cbliMq8HiIeAvFohF1LRZ
         VyYSRG+3uOiZ2mnRRzc9lY/JXi2vHYLghsp3UE1MKW53hhpDHYEGEycxyV1pBxr7v8
         iUcU9C+xVzYCrm4wyTLkwQYS4CYwBqbZ6A8LKvobMHiO2TMQWQLP13x1L9cTI3X24T
         ahXKdHqCTeFkOtfyoZRgGQqHeG4LFqZdUGrFULTDsSXwEcxPSwb8Fo/PG45vY7mhHp
         wrT6TIXJgz2l33LbsACbhEXTjzc6CGxEfNEjxxIOCPIDYQM3nYKsei2Ljf3WxPTRMY
         tPfy00pBZAARA==
Date:   Tue, 18 Jan 2022 17:06:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Julian Braha <julianbraha@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        fazilyildiran@gmail.com
Subject: Re: [PATCH] ASoC: au1x: fix unmet dependency on SND_SOC_I2C_AND_SPI
 for SND_SOC_WM8731
Message-ID: <YebzePGTGKtud5V/@sirena.org.uk>
References: <20220117054539.81757-1-julianbraha@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rcN1/5c2jtyHEDQY"
Content-Disposition: inline
In-Reply-To: <20220117054539.81757-1-julianbraha@gmail.com>
X-Cookie: Do YOU have redeeming social value?
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rcN1/5c2jtyHEDQY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 17, 2022 at 12:45:39AM -0500, Julian Braha wrote:
> @@ -54,6 +54,7 @@ config SND_SOC_DB1000
>  config SND_SOC_DB1200
>  	tristate "DB1200/DB1300/DB1550 Audio support"
>  	depends on SND_SOC_AU1XPSC
> +	depends on SND_SOC_I2C_AND_SPI
>  	select SND_SOC_AU1XPSC_AC97
>  	select SND_SOC_AC97_CODEC
>  	select SND_SOC_WM9712

This obviously not sensible, not only is _I2C_AND_SPI a control that
shouldn't be selected by any driver but this machine is AC'97 based so
clearly doesn't need either I2C or SPI support.  Whatever is going on
this isn't it.

--rcN1/5c2jtyHEDQY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHm83gACgkQJNaLcl1U
h9D0EAf/YaPyqYe1yDtTzANlhZM1UgEWj2lhHxrQhBSNUkdF3H9P0kwdU+PIiOng
NV8Xwe+JRM5dhecC5lCBCx0ZjwldbqIzGjAnSXN+60EyureNfYrPQNMNshc6g/eZ
5atQE9TqUArsS4KotL66zRNoPKuYQKFTV+/u0mjFPPngDCwVUXWDvbQx56KGomqx
Z2R4GP81UDqSoOh04g7KfqUzzj7ioanE/Cf72lj7zseLfsNXGCe7FuQ/5qZBoV2W
89YIX6pC4wIiCwyfiv+RXoGJHyj2L10mmILXj7BlYOgAnlrrkPGDw4s5zZaVeimh
Hy//ODGrYbXt/b+uG8rP+8KT0zGfpQ==
=dGet
-----END PGP SIGNATURE-----

--rcN1/5c2jtyHEDQY--

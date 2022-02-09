Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964C74AF7EA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbiBIROq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiBIROl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:14:41 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979F2C0613C9;
        Wed,  9 Feb 2022 09:14:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C925DCE217B;
        Wed,  9 Feb 2022 17:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C0EC340E7;
        Wed,  9 Feb 2022 17:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644426881;
        bh=KmQnaxQsd8tWRUE0dgiUF3bbTMXeLTiG0S5CMRklXOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iX3QFJXURiy/BYT/P/50Xt/nWPtP2qjDvG/MPzv8IELY2ZuIlrMTFNbPcCsCixe68
         faT9XXs7PvSWUhPJ8iwW5DimfCHFmcTDQ+qqmO4ao0T9eLloCUOFZTA/I3202tc9X6
         gad1RZrRNVSvZSjGnY8PEXcrIvrq671FjF7v53mXfeqeqDCE2lMG4MNx/NKPfpSays
         GnmfTS8tUarC7ZPKZNdjhIQEBEo20LfEWGP0WVR0L7x165sukRV/nayc4WwSLEoPGc
         90mcfPoEZKi7KpSXFvF/WAPMCveTUW+oVm9c7/8XEWGoR7DNfTUy4RVvu1EyDQC7uM
         pfm+sNyuKrKGA==
Date:   Wed, 9 Feb 2022 17:14:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Sanjay R Mehta <sanju.mehta@amd.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 3/3] spi: amd: Add support for version AMDI0062
Message-ID: <YgP2fIbASQym9sUP@sirena.org.uk>
References: <20220209165733.43134-1-andrealmeid@collabora.com>
 <20220209165733.43134-4-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Nq1nuf3xSYjIUi2L"
Content-Disposition: inline
In-Reply-To: <20220209165733.43134-4-andrealmeid@collabora.com>
X-Cookie: Disc space -- the final frontier!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq1nuf3xSYjIUi2L
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 09, 2022 at 01:57:33PM -0300, Andr=E9 Almeida wrote:

> @@ -190,6 +237,9 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *a=
md_spi,
>  	message->actual_length =3D tx_len + rx_len + 1;
>  	/* complete the transaction */
>  	message->status =3D 0;
> +
> +	if (amd_spi->version =3D=3D AMD_SPI_V2)
> +		amd_spi_clear_chip(amd_spi, message->spi->chip_select);
>  	spi_finalize_current_message(master);
> =20
>  	return 0;

Why is this one not a switch statement - what happens with v3?

--Nq1nuf3xSYjIUi2L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmID9nsACgkQJNaLcl1U
h9A0Qwf9Gg01GvU3Xy2gJheu2SLY5idNFtvNIaKyK/XGmRPzYfYoZAAyNRC/pQMk
PksSF2s0WzzF/xSb5ErG6xRkGg03txjkbmRjIWI8hW5gCOcIj8ECgeHoUSMf7WQ2
zyU+Sp1RaXOoW6JWiBeJ+7fYfuFrQeHVFbTc+Eo6QcVZ827I/NBcRD8w31CJx59B
lRXzvSJJw2rf1SUd7IW76FGO24L90opSyK7giqRPnWgrFshnVcpZNNVhncF2sMgu
acMj9gNnITIATnFokdb+VFWSpp3P3UIWZzmYew9M4hRFK1lj/QDMNXDFYc0oJnG0
yzuCbLocnvPeVWGq3nbPLFB7dPBk+w==
=/dze
-----END PGP SIGNATURE-----

--Nq1nuf3xSYjIUi2L--

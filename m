Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFD44AF871
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbiBIR2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238249AbiBIR2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:28:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78A4C05CB92;
        Wed,  9 Feb 2022 09:28:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F6A261AB2;
        Wed,  9 Feb 2022 17:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8B2C36AF6;
        Wed,  9 Feb 2022 17:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644427688;
        bh=YmAIxEno5LTUIboDX0UvlUq4mkk2NIWuBpWmhDK76M0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dQ7+p3ddtsYKQd7tlYazVVgp4esDpAj4OSVjgo1r0CwR1a22sr3UoAL3Awbq95Yky
         pjG9H8jZ4vm6uqFLKaBDGAcJcDWqZ2qliq2WyBOoKXKy0NfiUfNvpI6QOyfxkNn6sa
         nC6yXZC9DMiO+DYLINHAExWZb4JYnnB60ZepqoGy/38WxO7Ay9zX5v9caH4+g0gdPa
         cAd1gzmjYGX1rECoBztUb1hyame+h/DVINUA65a2DP38l/pKjRQxQsqPj7stapH91c
         yorE+35XALs+stkpY2hiPi3uJMDyzcOZgkOvtLTdxNzdNDoxc/JfBAqirG5do6Ylrt
         QAiU2St2etqaA==
Date:   Wed, 9 Feb 2022 17:28:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Sanjay R Mehta <sanju.mehta@amd.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 3/3] spi: amd: Add support for version AMDI0062
Message-ID: <YgP5o0pBL/DuZsn4@sirena.org.uk>
References: <20220209165733.43134-1-andrealmeid@collabora.com>
 <20220209165733.43134-4-andrealmeid@collabora.com>
 <YgP2fIbASQym9sUP@sirena.org.uk>
 <2126f6c0-fd6e-1f8e-b450-837270d03d31@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VqjBKmlu1rbTJJPM"
Content-Disposition: inline
In-Reply-To: <2126f6c0-fd6e-1f8e-b450-837270d03d31@collabora.com>
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


--VqjBKmlu1rbTJJPM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 09, 2022 at 02:18:59PM -0300, Andr=E9 Almeida wrote:
> =C0s 14:14 de 09/02/22, Mark Brown escreveu:

> >> +
> >> +	if (amd_spi->version =3D=3D AMD_SPI_V2)
> >> +		amd_spi_clear_chip(amd_spi, message->spi->chip_select);
> >>  	spi_finalize_current_message(master);
> >> =20
> >>  	return 0;

> > Why is this one not a switch statement - what happens with v3?

> A switch statement should work as well, but currently v1 does nothing
> and there's no v3 for now. I think we can change for a switch if v3
> requires to do something here as well.

Please write it in an extensible fashion now so people aren't tempted to
add an if/else tree.

--VqjBKmlu1rbTJJPM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmID+aMACgkQJNaLcl1U
h9DPVAf6AvEeBLe/3krwEBvUdey0nmwvrvQET78+T836ijYPeHfrW1kHcPbH0sVy
BZS8DOyz7DDECDqyQ0XaKWnIs7XrlZyLI+PF8wMvwCaYHUBnSAp0TZKnONZ4pNF8
NuvY2SNpfPaVG+hAPlQJQa4NgTGyFwgf7fH8DMJvALCw831QFVCSOnwFmDcwxKoQ
BT3WPmAK9FTXxTQ2ZxqCjoFhs5PyS/BR41cTozRweL06XukMMaaXK6+zWyTA3mkH
FnVGJbMvNpGH/SLs6AQfT+2OU3MhkoPieJSEG8coOrU3/WWElCRoYjnrrQzZHRFc
4rUfUK9QJCjR0wvGzQB1VNbBHKrTKQ==
=yc+e
-----END PGP SIGNATURE-----

--VqjBKmlu1rbTJJPM--

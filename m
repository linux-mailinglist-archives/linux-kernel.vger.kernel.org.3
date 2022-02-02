Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A884A7598
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbiBBQPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:15:43 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51928 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239492AbiBBQPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:15:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4295B8311D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 16:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4D6C004E1;
        Wed,  2 Feb 2022 16:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643818539;
        bh=NSl+AXiIfbyRo6KNZjQLXSisPFKjjyWLyGto+1YZntI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pmuQen2qUw0drDe1n1CPByOU8Exkw3RhKGA+lKMHHK6Lnht9sFzKtTa0XQfAzEtB7
         Y9FXJC9rjTDOFPDreoxlNtGFx4v1bMtYwfNHBchVNLundHg/9YTbZpdflEvQi5JbqF
         RbSduhGFLxDRoLDa/Q4ED1vjJMtoOvrO1+VtEim2R7tycm+9HLDGENwi9YSmX8ainY
         ziV8t45BSFxLp9y+aU9b5HrRCknEAVrVL1wO//kf7m7n+5cyxM5veUMqqXAAavJtmr
         kebA62uvfpUauOvHEhqWHEscS4k4SgBscS5RA1rtuYNyDsTijyPyPiR3ywW8fhUmmT
         cQ6hXpsF8ZsGA==
Date:   Wed, 2 Feb 2022 16:15:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [mtd:spi-mem-ecc 30/30] ld.lld: error: undefined symbol:
 nand_ecc_unregister_on_host_hw_engine
Message-ID: <YfquJwtbg/hF5WJF@sirena.org.uk>
References: <202202011308.a6RlPiGp-lkp@intel.com>
 <20220202154504.7737deed@xps13>
 <YfqhJZ+BzfMrpN4Y@sirena.org.uk>
 <20220202163452.746d50ca@xps13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AALprmCZZjyoQqQJ"
Content-Disposition: inline
In-Reply-To: <20220202163452.746d50ca@xps13>
X-Cookie: Quack!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AALprmCZZjyoQqQJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 02, 2022 at 04:34:52PM +0100, Miquel Raynal wrote:
> > On Wed, Feb 02, 2022 at 03:45:04PM +0100, Miquel Raynal wrote:

> > > I've failed to prevent faulty configurations with regular depends
> > > on/select keywords, so I've come with a new solution which received a
> > > successful build coverage test from the 0-day robots. =20

> > > In order to still be able to use the spi controller driver (=3Dy) whi=
le
> > > mtd is =3Dm or =3Dn, I need to add an IS_REACHABLE() check in a coupl=
e of
> > > headers. This way we can just imply the right MTD symbols from the
> > > SPI_MXIC Kconfig entry. =20

> > Isn't this just a case where we shouldn't allow MTD to be built modular?

> How would you do that in a nice Kconfig way?

depends on MTD=3Dy if SPI_MXC=3Dy

--AALprmCZZjyoQqQJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH6riYACgkQJNaLcl1U
h9BE6Af/e2cwOSkpkXbG+eNGA/p9TwcEzQ+VQEoMNe3DzuKUdN4ZSx1l7NaUFa0Q
iN6ygsz7T/jVwu2thHjKNWEiC5guogEIwh6zaGh9dJ7Dt2baWSS0qG7jJNvc3pI0
G6SaQAPIrno9Ew2g49X2BOdy0dU8ASYysFMYAHVTRcCX7D/osF4NUM9nMj2zuzy1
YSVFamQNC61cKSMMwWe7UoUEsEgF9ZX31dZmY3C1UaLXX1h3wMQimMKAPy92XvI0
HC1sQnSC5ce3i2zwIGgJr4a8+IUuIDszD6ifGf3+bCROqqsxk/XkcCqzO3YOM/L5
oUejd3ZQKs17yHaaUADvtDg7DGIeRw==
=fvfd
-----END PGP SIGNATURE-----

--AALprmCZZjyoQqQJ--

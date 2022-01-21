Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A05A4962C0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiAUQ0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiAUQ0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:26:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F18C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 08:26:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF908619EF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 16:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47472C340E1;
        Fri, 21 Jan 2022 16:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642782365;
        bh=1vHIwJsBRLQCxgSGQ1UoXTwllhWt8UmRNtwq6cQVQPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uma6TWuakbPz2uuSLuwGrrU8ZdhwrSQKTPqOw7HqgHBs5oWL+iTjyDL2c5fqT71e6
         74I3SjQ/d2pSh3wJ02QGK5WQVgAGTEvGwUQC4zUCsr+CdR70WAgNI3jug9U7r/bmnF
         DafVHeDUKdXR/damzPDBYmfN7JV2mwGjBP9Bp/YYQYYodjn0V7Kh+nKjnaXGqsgiKW
         L8DfWE4q14DF0z2+j0ENzBWRQY5gxIXgKM80hrdQg3aeTlbV1571a5HmUcoSijUaou
         a/dbFR6afwly8fPaPByGQuNk1DJPwr2C8RgWHqRbVUsPamaYzwz3K+6xKUdqUm7KTO
         bz1BnI4zuI1aA==
Date:   Fri, 21 Jan 2022 16:26:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Detlev Casanova <detlev.casanova@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2 1/9] regulator: rpi-panel: Register with a unique
 backlight name
Message-ID: <Yeremcbzpj2LqFOD@sirena.org.uk>
References: <20220121152056.2044551-1-detlev.casanova@collabora.com>
 <20220121152056.2044551-2-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="psymr21bK8MZ3W1X"
Content-Disposition: inline
In-Reply-To: <20220121152056.2044551-2-detlev.casanova@collabora.com>
X-Cookie: Alimony is the high cost of leaving.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--psymr21bK8MZ3W1X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 21, 2022 at 10:20:48AM -0500, Detlev Casanova wrote:
>=20
> Use the parent dev_name. It's not as readable, but is unique.
>=20
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> ---
>  drivers/regulator/rpi-panel-attiny-regulator.c | 3 +--

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--psymr21bK8MZ3W1X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHq3pgACgkQJNaLcl1U
h9AIewf+Mx/v15NVUQgbtBeRygdOyL+iarZNbVB1JjeCG2BRXwu04xdKTJXB5WOT
U7feDrfHBva/BETD7HEdXk02Ii6zRMEKzoDr84tyLdntfZTSUsICMgXwH0x8O6mD
hyLf0iI+IbP34rCJ+ZYQ+4ohuGYk8rK+1GMHiGzqh5J8p2kk9Y+mO2fIH35J/mkS
hn+30VpAWAVT00oQQ4KqeJq2MnoIM49mPrblsrXVKLuT/C53eRHiKiCPO/pwer5p
aIn3Ex15SBaFi4fYqQEZieduXhPAXgyShUiGncECD19jeFY740g9TodLl2+jRMgo
8hhLe1cuSuSBWbmo4Y6ZnMOnxomlCw==
=zNk1
-----END PGP SIGNATURE-----

--psymr21bK8MZ3W1X--

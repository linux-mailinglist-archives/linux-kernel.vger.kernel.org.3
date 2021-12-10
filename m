Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A4A470C98
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344429AbhLJVeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344408AbhLJVeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:34:04 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38701C061746;
        Fri, 10 Dec 2021 13:30:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 81B6ACE2D32;
        Fri, 10 Dec 2021 21:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337DEC341C7;
        Fri, 10 Dec 2021 21:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639171825;
        bh=mhXONTVugbiKgVpsUASFxSzDBV2TO+pj3CmiHV5IAzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sR35pgV4Qnzlxq2SW9ma1wxqBhGIWM13b/25sX5mXGEHNLq1ljHGqMzU1CPhD81iS
         1garM2LwgIsFOEqfbZ7lDnrjLrB0oWQfD8unKB4XsvVEIyHiWVv9c9K5hNQpRyq4CW
         fdPpiAb1rdEBsM+e9IylXawWHSoe/fJvP4wBGfZpZqZ1WaH+IriD9l3i30tfGwqoyz
         j8j18jup1Wnm8D3H2zO7tJTc5N7Fo5gwXF+eF4VRHCBWYpW9FR6kTjMOeBaMcFoNKz
         yPQnTwUABBl05owbg0si+VEk2qd1cnKaJfXQqtuhhf2aYoDUYlXsnvPnzOMFq5nwTG
         uH1l/P0bHalbg==
Date:   Fri, 10 Dec 2021 21:30:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     sfr@canb.auug.org.au, linux-next@vger.kernel.org, jeyu@kernel.org,
        mcgrof@bombadil.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Next/Trees: update the modules tree
Message-ID: <YbPG7IYbHmGrbdG2@sirena.org.uk>
References: <20211208195931.3369500-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WIo+rdGFG0rmczps"
Content-Disposition: inline
In-Reply-To: <20211208195931.3369500-1-mcgrof@kernel.org>
X-Cookie: One picture is worth 128K words.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIo+rdGFG0rmczps
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 08, 2021 at 11:59:31AM -0800, Luis Chamberlain wrote:
> Upon Jessica's request I'm helping with modules maintenance
> so this patch reflect this and updates the trees to mine. For
> the last v5.16 merge window I have already sent my first
> pull request which was merged for v5.16-rc1. I'll queue up fixes
> on the modules_linus branch.
>=20
> I'm now queuing up changes for the next release and so will be putting
> those in the modules_next branch to match parity with the same style
> used by Jessica.

I just saw this - I'll roll this into my -next builds from Monday, but
you should check that Stephen picks this up when he returns.

--WIo+rdGFG0rmczps
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGzxuwACgkQJNaLcl1U
h9AexAf/eSr6/DnA06lgiGtaz0XLOcUmbrRusH1X1z8LrT/Ol8Fdvxf88ORRPJrR
OYw6jExzImqaaTg9HmrVMd676ObUFEZ8J0Eyn2VfCJ+uN04S75h5dGcEKUmx9F8e
uQHgbFwkJRJQkWNRB0KtDoOOd6TpmXpxiXPzgVxK11Mx4WmKRg4I3/zYt7jKuqge
A8ggTHl0rD+BZSWjX0oKi6PkD1Z7rcakoZ3gLlfvkdbwDXGRrd6w1hHyj70gIN3h
m0KAM1fgPChDmaEbE0dh3HI5Sfzk6hq+7CXH1yl3MO8x255vXSflOS3ILZRueL+s
oxAXW4Vy7ncvcdTbQUyrhBk9Hnl2ZA==
=Get1
-----END PGP SIGNATURE-----

--WIo+rdGFG0rmczps--

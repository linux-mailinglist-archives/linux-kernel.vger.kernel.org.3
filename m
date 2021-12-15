Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD3D476038
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238693AbhLOSGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:06:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34108 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbhLOSGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:06:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67D4BB8204E;
        Wed, 15 Dec 2021 18:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77039C36AE2;
        Wed, 15 Dec 2021 18:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639591571;
        bh=8Vukks1X4DUWPbSz+K9uq/FbIbt5tKotx6wmBIKGRfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=erarZoMxOT2M7a+BV9BL0KV6RKrY+lgtoXf9lA0ibUKkb3D+rzFNPizrbzNQ47PRb
         csY5p1FwGjzBO1aYx2wR9x12ppspxOs3IK2nv3C5cnci9YB370tQ8j/uKWVZKtJf6L
         SJka1mgeRyjRkKeLOnMWQ7yELXL1uXGeXlCp+Lv6lTu770GKVsDyYZjsuNgIHlJBV1
         K5hH8WZD6tXCYHtUJOt57RUOoBe0gOUEk+oKQUvk3GRkGwTOMoHwLWRBriASakazbY
         9aPBKo1NSxHPaXSB9kSMKxHkMPZRACm+j+5kgrYURA3FEzpP/v/VhKvKgbpCqMz5ol
         Nx5cKHPgMjNhA==
Date:   Wed, 15 Dec 2021 18:06:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Dec 14
Message-ID: <Yboui5aym4eB6oP8@sirena.org.uk>
References: <20211214223228.1745315-1-broonie@kernel.org>
 <YboPz454GCe6ZA7g@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SoLG3GS5cOfv0PWZ"
Content-Disposition: inline
In-Reply-To: <YboPz454GCe6ZA7g@smile.fi.intel.com>
X-Cookie: No solicitors.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SoLG3GS5cOfv0PWZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 15, 2021 at 05:54:55PM +0200, Andy Shevchenko wrote:

Please note that due to people replying with random bug reports against
the actual code in -next replying to the -next message isn't a super
good way of getting my attention you can get lost in the noise.

> Thanks, I see tags now.

I fixed the bug with the script, it doesn't check for errors when
tagging unfortunately.

> The other issue I have noticed is that gpio-intel branches [1] are out of the
> merge. I haven't got any email about any issues with them.

> Do you have the latest and greatest list of repositories to merge?

You can see in the merge log that it's getting skipped due to an issue
with the previous tree (which also has a build failure causing me to
need to revert it) upsetting the script.

--SoLG3GS5cOfv0PWZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG6LooACgkQJNaLcl1U
h9AC2gf9G3fxaP3PBpfPy0TJpRqzg4J1rHvS77ZvBusgqVOAgrMTzoazdIddWY2b
edjZrppaZmRg2t76RzZ50eEfcdLZoPDP/MqIoBW6fmgPcmAExfj2i4KlZqeWH035
8LxP5G+92fv6j4DY2CXDm7HC3QCySc/8SUDgP8ebO1U8K5NeXbhalZyDgJVGVoj+
VIkDvumbcVwzUuVDc3WGJRcm1lwaFVt46RuF9fdE0A2Tg4xvseZ9xtGpyOqJZsku
Q+CUJZg63uXxDYtMZfADZqBFdFgIvyhaNiJaPvV1kk+256nKczMYwR2+LIZDtLYg
vIOkQiw+MsaSkd/vD99kSDXm/Nkz5A==
=/AdQ
-----END PGP SIGNATURE-----

--SoLG3GS5cOfv0PWZ--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D46E48685D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241717AbiAFRXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:23:25 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:46176 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241633AbiAFRXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:23:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 38150CE265D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 17:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B924C36AEB;
        Thu,  6 Jan 2022 17:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641489800;
        bh=Kz5pNgMyH9pdYalAblw0QrKEnjnAGQLqJoFfNcP8EpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dgqCBrv0Y7h8Tht7V4a3k1LEqvZ1LT5VqAdR0mJaUz+rfMVsmn0i2yAoU23tbIuvL
         m874L+/2j2cIRq8Sz0ZS4nXCns5CiWd10EACk0np8nuX4UyBFadYNZALfQnDDhCJ2E
         RkKkYMjMVLq5fev3RT2EPmKJdSecAtHY6kKm1VVf6/IgLq2W1mhbifgrU1Oa0PvOiK
         c/vrPyfejdMzTtpih1qqy8xvqIO8GBG5svmTZCPtrfxODEdUaTaPVh7QG4ZBDSnqIE
         cWo9PSoWkO0qD63NuX/YK9t3pDtq000k/exeNBYDRNCSN3gS1F3A6aJX+HTlmGLBRF
         WSaAw99AhaqwA==
Date:   Thu, 6 Jan 2022 17:23:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andre Werner <andre.werner@systec-electronic.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "anson.huang@nxp.com" <anson.huang@nxp.com>,
        "yibin.gong@nxp.com" <yibin.gong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] linux: regulator: pca9450.h: Correct register masks for
 LDOs
Message-ID: <Ydclg91r75H8vM0A@sirena.org.uk>
References: <59372065.103064.1638543313537@ox4u.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i1/UL5Yf2JdI8WDL"
Content-Disposition: inline
In-Reply-To: <59372065.103064.1638543313537@ox4u.de>
X-Cookie: To stay youthful, stay useful.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i1/UL5Yf2JdI8WDL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 03, 2021 at 03:55:13PM +0100, Andre Werner wrote:

> Within the defines of the register masks for LDO3 and LDO4,
> the most significant bit was missing. The datasheet said
> the range is 4:0 bits. Thus, the output voltage cannot be
> set above 1.7V for each.

Actually this doesn't apply against current code:

Applying: regulator: pca9450.h: Correct register masks for LDOs
Using index info to reconstruct a base tree...
error: patch failed: include/linux/regulator/pca9450.h:196
error: include/linux/regulator/pca9450.h: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.

Please check and resend - I suspect it'd been mangled by your mail
software.

--i1/UL5Yf2JdI8WDL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHXJYMACgkQJNaLcl1U
h9DTJgf9EcmPZ6Io5yeDQVYFGOA9qOQFE4RAD1MEslAAeLBMuxtFOn8CPp0/qzBA
HM3TD0OuEIke7FsDZPHl//2iUvBYOLuo2NWXucI9w97Zr+07OVO0sqKJzU2IJTg3
g0Fxo4/g/INXfKfcKl1u9Jka4QVIbpcqdtbrSD7ObySDTuFZ2VS4mrUOdA+oU3y2
Wt82blntc8uDxCOxwYsrrjyX8DSNelO7CtzdJYXI4soJ6brf+Kwfs+C3nQrZbzBI
LSBagkM/X1PL+O+7Jn5NUYyhedsnS3MvUvzyYmOwSXmujzYJp6Izqz5PYyR+Cx3W
xdDLnxhmCWGbBv7mV2IIBzPPw32pCA==
=EY4V
-----END PGP SIGNATURE-----

--i1/UL5Yf2JdI8WDL--

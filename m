Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879A748680D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241488AbiAFRAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241426AbiAFRAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:00:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E57C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 09:00:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89526B82295
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 17:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F0FC36AEB;
        Thu,  6 Jan 2022 17:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641488411;
        bh=22PQNwSRS5YEIY51QytBLxTIdXQaOtaK6c/x+LqB/VI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sB0Qk0VeIRsvybT4EiAYRJVEz6ehugcxVDIVmhVZcg+gozQYMU6EBaInI1Dt401VY
         ysSDB/tB7QE5LSBsfzLo2gGdrXzq8kNhscHf/8c4Y/XyZNth1v4jtU3HOL1O9T0rnr
         8Y5pSveTXaZYZMYHrdx7bzmAWSRd1rFeblb2DRH4MzERsrEmiJSbmAzhQliGQdR+Xr
         kzxJUq7cE6Of2f3nlDlHoitHYibW3s4JlnaOOuARq/egWOHwaP8pixc5CAUJb2HBMz
         oyM5DjD0nN2zcpH18PXniJa1z5hwrf/xKRtiOPxnx3iI2Sp4RCkUUl1Qa0IShY2FhN
         7ejbj0BBeCRjA==
Date:   Thu, 6 Jan 2022 17:00:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Werner 
        <andre.werner@systec-electronic.com>
Cc:     lgirdwood@gmail.com, anson.huang@nxp.com, yibin.gong@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux: regulator: pca9450.h: Correct register masks for
 LDOs
Message-ID: <YdcgErc/fN7Z1HzM@sirena.org.uk>
References: <59372065.103064.1638543313537@ox4u.de>
 <c8a8b54f-3784-e473-a59b-3fa202f79f96@systec-electronic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UNf3GG0UEVA2t872"
Content-Disposition: inline
In-Reply-To: <c8a8b54f-3784-e473-a59b-3fa202f79f96@systec-electronic.com>
X-Cookie: Kill Ugly Radio
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UNf3GG0UEVA2t872
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 07, 2021 at 10:05:56AM +0100, Andr=E9 Werner wrote:
>  From 6dda12150785665ddd1059d53aa22bf902bfe4aa Mon Sep 17 00:00:00 2001
> From: Andre Werner <andre.werner@systec-electronic.com>
> Date: Mon, 22 Nov 2021 15:40:17 +0100
> Subject: [PATCH] linux: regulator: pca9450.h: Correct register masks for=
=20
> LDOs
>=20
> Within the defines of the register masks for LDO3 and LDO4,
> the most significant bit was missing. The datasheet said
> the range is 4:0 bits. Thus, the output voltage cannot be
> set above 1.7V for each.

Please submit patches using subject lines and a format reflecting the
style for the subsystem, this makes it easier for people to identify
relevant patches.  Look at what existing commits in the area you're
changing are doing and make sure your subject lines visually resemble
what they're doing.  There's no need to resubmit to fix this alone.

--UNf3GG0UEVA2t872
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHXIBEACgkQJNaLcl1U
h9ATlwf+OAYxcjU3KAb1ZNrCHVGe6dPmDCcxtHbDV+/9eq/1020YY1T1hD6HZi2H
TP1k0M7qEA9k+Q7ot+Svx0tAF7cG/PdV/X4czdtjDfT42HxyjYXn3e/EfY1JrV2S
FtkeW3lRpi4SX/p3ei/xg2fWqkVLjA8591jMwz5dhU8OI3FfRSi9nAo2Vjp8IoM6
kO03++/2kuPQVdI+1/CQBUHJwNemDXNrfmGWaNqEOnCZwdXQ+ZYF11SNM8hneHWh
5EpAnbWzmZ9+5YkTh4eSCyEO52KGU6aRsA3PYPLjxo+OkJjtEp+u9Zp8Y3kREhTt
1Bp3XPhr8YszTMI0PI5exbocOiOG5g==
=mL9B
-----END PGP SIGNATURE-----

--UNf3GG0UEVA2t872--

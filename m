Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A03D46DD1E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240361AbhLHUhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:37:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54402 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbhLHUhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:37:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51B60B82283
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 20:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BE0C00446;
        Wed,  8 Dec 2021 20:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638995630;
        bh=r1/q2rQ0/0tYGAU7ST7svoRBXsOnMiacT4GBfHWjxdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/fW5CAQfTPKV7dY2YpSc0nf28ZfU5WYILbZeoN/Br8Pb7agTZpThA1/8gfZ78yrf
         em8fCmy113CGj84ziw60ukL50wqp8sWmkkF2lJOBG7FRDebRJnkg1hEYOGrOIGWkS/
         xbwC8XwNrFZBGqUU4JfZDquY48fbbtVxJYM5dtkmphMMe57Uc5MbuwCysynOPrN0Dh
         HR2b8KJHjQ0qdkxk4293ohUM1QihRnUp9ieLX/haPK6X+39ewvnooLAyWIGBJSLloO
         xcuxFNLc8jpcxQQicYAphPca8CCtw8wsbMAdIWM1NpxFTLCveHF5XzWy33iZy4PCm6
         ZajpDbIYrzROA==
Date:   Wed, 8 Dec 2021 20:33:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        Alexander.Deucher@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: max98357a: Add mixer control to mute/unmute speaker
Message-ID: <YbEWqP6/TOCJn0gk@sirena.org.uk>
References: <20211208185850.1555996-1-AjitKumar.Pandey@amd.com>
 <1571a09a-a766-a733-e23f-36cf1ab14b86@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TA1bawbBm9qo3pPG"
Content-Disposition: inline
In-Reply-To: <1571a09a-a766-a733-e23f-36cf1ab14b86@perex.cz>
X-Cookie: Alex Haley was adopted!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TA1bawbBm9qo3pPG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 08, 2021 at 09:25:04PM +0100, Jaroslav Kysela wrote:
> On 08. 12. 21 19:58, Ajit Kumar Pandey wrote:
> > Add "Playback Switch" mixer control to mute or unmute speaker
> > playback from ucm conf depend on use cases.

> The "Playback Switch" is too short. It should be more specific (Headphone,
> Speaker etc.).

The device is a speaker driver, it's likely to be getting a prefix added
as it's bound into the machine driver if there's any issues here.

--TA1bawbBm9qo3pPG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGxFqcACgkQJNaLcl1U
h9B8ZAf/UwgVSTLxxiaMAAeFArbqjreZZ+s4y1+l+ILfdze6v2axOfqMlvGgDZgT
IF1tVBmcKT16JSQOdoRnx0Ca8h+LeHj6Oxa/3KMdB3IqXOmjr8Jt08/bxI/rZ4hE
nSjONcl+0gDdbXXNJsyOXilXzQWrYENomcNbdAHjjkqTpDx+wLQjAr+5ssoJ0muO
sSGAPxe6aYUHGSHgO4kwalfOOaY4ULFqOAWS3dPmgfb4R93r0+WURcBhrg8Dm0Ad
pyEzt74ZEgKx/kTjP4ZX5oIkDuvKhg/S041WoCtdLah9k6yTeMc2x4HrTrK3fwlo
hODKZLvxg9oiRe9zvJ89lpCdQRmAOQ==
=IwSH
-----END PGP SIGNATURE-----

--TA1bawbBm9qo3pPG--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A03487DC4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 21:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiAGUbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 15:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiAGUbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 15:31:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A4EC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 12:31:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F307F61FF8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 20:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAB7C36AE9;
        Fri,  7 Jan 2022 20:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641587498;
        bh=/wpuMD9OOisNRGFRlhHHAAK0F5/sZOZI14kx6dDgZTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sgf9+oXD4ttp5o28HWx876LOlj5mxppFZ/xDFZxCWf7ew8ciekbD/hPiQK/HkoBmM
         QyyxsbcBGSKRhTdYiNKzZ68MZtWdetxYmEAd9I87xjtJ+jVkRe1tmQQUJdAjFxpNoQ
         EZaO/CfAPeBzkeaEezxZnrDyPgM9zxVAgwdWEH8pjjERXIx8+Aw9fJdW7uV+M9Dyyf
         wLWbpkp5tJDMulFMQsVInjQY3g45pBkBBXvo6cjJfEUWISwqUrv+BdJBqpqhZEDOPl
         x27F2jzEouSeHxvM+rVAH0UoqxxJxBHyUUnPqgS2MngUqz0FUL2xiJAHlNR2EM4H0Y
         1ERaOtOYjdsdQ==
Date:   Fri, 7 Jan 2022 21:31:35 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Song Liu <songliubraving@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Special regressions report for the pending 5.16 release
Message-ID: <YdijJ5G0LIzoz0fU@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Song Liu <songliubraving@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <7cd73147-2170-a0cd-c64e-ded4bef645b0@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gD7LRmKZFfRlZ0hV"
Content-Disposition: inline
In-Reply-To: <7cd73147-2170-a0cd-c64e-ded4bef645b0@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gD7LRmKZFfRlZ0hV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> * There is an open regression "Applications that need amdgpu doesn't run
> after waking up from suspend":
>=20
> https://lore.kernel.org/all/1295184560.182511.1639075777725@mail.yahoo.co=
m/
>=20
> Wolfram (CCed) plans to revert a i2c commit to fix it, but I'm not sure
> if he plans to send in onwards for 5.16 (or if that would be a good idea
> at all):
>=20
> https://lore.kernel.org/lkml/20220106122452.18719-1-wsa@kernel.org/

I'll send a pull request tomorrow.


--gD7LRmKZFfRlZ0hV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmHYoycACgkQFA3kzBSg
KbZTjw//Y9avqqKlpNG1bUO59LdpXav6oQg6LfjrAotnALltaBXvZY3zVwRdMNCE
pxoOrVa6b3ItT6IgdMSQu75l0/cOV0OZlOeC5+mCi75ixTXcNxIc8N+ewIvOmUTv
ttK2wHDsdbHtqhY/mj6DRzLq/afLW/+PTBkWeKkgWgGQHHa58TWoRGJVrg9IimV1
ONZTYiiPlg4VHA39b/lcxCA1S20ucssJmyj76S/1vj2qRC5qORmspN2ToOOV1oWp
7VJoFEXCQp+GAvQqG4Z2Nc7uSVroHLbbC97xSiHY3U2TL8brcHiztzsKF8Yyxbws
pdkuS2q6ux06LCrI2UuC9E6kuLi2VU7Xo7q6t24jv6vtkhte6wxRknAmf1oAM8Mm
D9rQm5zvPOWaaO9Aiq4gGuRPEtpaluOYm04SM3jE3CcUu5wr0Jm6oDUgOMRQ7ZxL
Ndj0nt+9r99pea/BRwKbWpjcrqS87Rwh1iJw1/R62hg2CB3OmQTF/9Fpynm6nWaB
wi2+k42xcH1Bl8nWWXC2LOaRJmcY7hHzMKF444jQFeaFsRBzRpK1/7crBJrsnecf
SLnDBPUqjOajyujY6jqVESzRnlqF8b6eN3eYxwwG4u71RjzKJEMOomG6Fyo3R8tr
tqeVHs2IHK6xYcXCch7tN3tI+3fqqMzLMyZyUlS7WTRCpti4Gxg=
=DlEs
-----END PGP SIGNATURE-----

--gD7LRmKZFfRlZ0hV--

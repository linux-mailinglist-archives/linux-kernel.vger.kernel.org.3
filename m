Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5870847350A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242375AbhLMTdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhLMTdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:33:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F210C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:33:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6F5EB81258
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 19:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68627C34600;
        Mon, 13 Dec 2021 19:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639424016;
        bh=Z2zy5DQsVwdlD7Snphkyw1Y8KT4qtUpTZX1aYQ4vKlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VvBcjY34DWme2BMmckJOWoF1TWjUM49wYvhzygtjyj0CWXjBkTQWlG16AtgGkPZF3
         c/dJcQ/UZjIQkvxNFFNlPFgSBrvkPqjC/xPzeAPI+FJ7wP0fuXjKSUBZySKWIK0NBz
         rEEi21Q3buvLqTDCRD2OJRBni8JIpXg9M07KoK4K6108EsXzZjT51fXnooWMzMmPjO
         kLqnQU28PVluRgZTSkdjogUuq9GnC98SBJtmn/v5dz4xN8vBQ6quh/7VmCFabtH8IS
         ++SUkbzzhL2wkXg1fTn9KwW/uQOf5VAqxbwYWCpnEtNE9uOuVjqYri2Zz3VltLtkZ4
         RxUHF5PfAzhHQ==
Date:   Mon, 13 Dec 2021 19:33:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Werner <Andre.Werner@b-tu.de>
Cc:     lgirdwood@gmail.com, anson.huang@nxp.com,
        linux-kernel@vger.kernel.org, andre.werner@systec-electronic.com
Subject: Re: [PATCH] regulator: pca9450.h: Correct register masks for LDOs
Message-ID: <YbegDDszsM4GyMyV@sirena.org.uk>
References: <20211213082319.Horde.z0oaiJ-O4G6vhVbw4WSBjnN@webmail.b-tu.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NZ4DAW0EvkWSLz1t"
Content-Disposition: inline
In-Reply-To: <20211213082319.Horde.z0oaiJ-O4G6vhVbw4WSBjnN@webmail.b-tu.de>
X-Cookie: Your love life will be... interesting.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NZ4DAW0EvkWSLz1t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 13, 2021 at 08:23:19AM +0100, Andr=E9 Werner wrote:
> Within the defines of the register masks for LDO3 and LDO4,
> the most significant bit was missing. The datasheet said
> the range is 4:0 bits. Thus, the output voltage cannot be
> set above 1.7V for each.

This doesn't apply against current code, please check and resend.

--NZ4DAW0EvkWSLz1t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG3oAsACgkQJNaLcl1U
h9BRuwgAgNfocFN+lalOtCQx0vg8vSBPF19bTbQhSFCRefvJZIAb+YTmA6obiW5P
LFvkOh61v4xJjJthinAOaIc3YQ39gyNQZ0w4GVb0KNLDJ8IUzDErsqM51qrBGIU/
bwNpFfcJcnQpdrYsZTZVoc9/X1MdYA1ezxJWdv0M8SLJD2DB4dsSURyqF50tceV2
oK6zmC15bv/c3Q+8qZHbffx1L1Rlp02bqorB6kKDnl8oi/myXmNrsnRGgZ6P0E1F
1ShtPr1Uu5x56fW/stKluz5KU2KGELqSbUmfnAHnfFx3AvN8huetQLGWmtCAZl+B
gLQt881MshYUrv3yM9SsIRvXnPcVjQ==
=sSvu
-----END PGP SIGNATURE-----

--NZ4DAW0EvkWSLz1t--

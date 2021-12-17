Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A91479105
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbhLQQML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbhLQQMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:12:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626C4C061574;
        Fri, 17 Dec 2021 08:12:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3EB46CE256D;
        Fri, 17 Dec 2021 16:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4976DC36AE7;
        Fri, 17 Dec 2021 16:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639757526;
        bh=NJqVqqHMBJNYS4INcUvMyUogrj1AyJcGAuJ7eO65acM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T/eLXlxhQb72obtFNLI6dNqcfknDNHQnMq2Xiq7hZWibNDXnWXFIKVPy/udWf7MZP
         KMy3czDHV6yNZQ7oU8JPFC064/FCS2TtHSnkOR0UZN1N0jMOwJ3HYjZA+2qyBa+FA0
         EEQhYPZ632IKtbfJgucthx0D7Rwm8X3MWm6mcbgUdWJoTYObOCqddoQPcLAAkJ4bL5
         NsKHHygnYTfi3rQs0yGoPd2uc0KW+WC+plEEMNL5tX7Jla2eSN/bV18QaOG3IDGHX8
         jSSaKnZmtRUkKeeIT13U8Spzt8ynd1Wy7/0g/uuINmowKU9vlsyu3Gn9C9ZXnIAmMk
         OKbjrKNEkvNpQ==
Date:   Fri, 17 Dec 2021 16:12:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [next] arm64: efi-rt-wrapper.S:8: Error: unknown mnemonic `bti'
 -- `bti c'
Message-ID: <Yby20BrmNBtb6tIq@sirena.org.uk>
References: <CA+G9fYt-k1daHarGoXKz7uYvsAcDMNM2bk7jRcYBNf0sRE=+LQ@mail.gmail.com>
 <YbyX+I2PBwio0MYk@arm.com>
 <YbyjerZen9CwYKSV@sirena.org.uk>
 <YbyyaX/7S+1PqRYq@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FCf4TVWqNuFUwEgu"
Content-Disposition: inline
In-Reply-To: <YbyyaX/7S+1PqRYq@arm.com>
X-Cookie: Pause for storage relocation.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCf4TVWqNuFUwEgu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 17, 2021 at 03:53:13PM +0000, Catalin Marinas wrote:
> On Fri, Dec 17, 2021 at 02:49:30PM +0000, Mark Brown wrote:

> > That seems sensible to me, especially given the small number of files
> > affected.  The other thing would be to decide that all assembly files
> > should have the header included by default but that seems like it's
> > invasive and probably disproportionate.

> There's also this:

True, that's even simpler.

--FCf4TVWqNuFUwEgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG8ts8ACgkQJNaLcl1U
h9Baxwf9FG98F42vNcPSAQbfym+WERd2dWA1By1/W2kIxksDKl9srlcVE2e1WPaw
TGIga2RzdN25r753e8UYHuePX02RF2kMGP/1mZBk9osSj8PXjYnfRZ8o4pLuWHV3
rJi9T2oYnDTvlrs7JTJO1zADZmS3jB0UVlz0KKBNq6CvM8OwvtIjSCEBcm7QnRTX
iZ7R46WubF7a/NCJ6+l/N/edC891rLvwr+EyrFmzcdtZrdA3c2pHc+Txm+iWQRXc
JFr7rqlSiNhQMtifnNDpGWbPCvm0Tb8DRN3iG3u0n1FLWPNwe+gWuQH9NWAlpNMa
Uo2s+i/06dDUvK/0QKPw5UMZUIlvFw==
=0aSP
-----END PGP SIGNATURE-----

--FCf4TVWqNuFUwEgu--

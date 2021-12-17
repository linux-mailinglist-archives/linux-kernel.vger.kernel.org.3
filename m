Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EAB478E68
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237546AbhLQOtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 09:49:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40322 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237521AbhLQOti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:49:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CE26B82895;
        Fri, 17 Dec 2021 14:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29769C36AFC;
        Fri, 17 Dec 2021 14:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639752575;
        bh=EMm774hpvxjpsGiW3u1nm84U3/HfmSK5izURSqwT6zc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nAw9/0E9+4PKY+9SMX5CesuooGXfzmoJVU8yZHl1yY1c9rOwyucC0SnxASAoryB7O
         mMbFFGJsB0s8WPHCmPZlGr3cUUi+elMjghSMu5GVqJOmOV88ULVZR4uOsZJbe+nsGW
         fdr0JWuG8Bcha3Bezj2PMgwW52SrSDZjAAIUW1iE5I+1iBuExe34jvTYfnOVV0QkZ9
         5z8dDK5YLxD50tAgyYx79Lfoqb7enmgH0OXqfMWGDDhxWER/L4DSejS3SjOLoRn97u
         ziw5tNFt2TmSsCedxHJX2Xc8GgNzF1WnP8i/KRQ6kzFW4ekVog+NwIaXdveMWN8n8J
         mPyZQyNEBljsA==
Date:   Fri, 17 Dec 2021 14:49:30 +0000
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
Message-ID: <YbyjerZen9CwYKSV@sirena.org.uk>
References: <CA+G9fYt-k1daHarGoXKz7uYvsAcDMNM2bk7jRcYBNf0sRE=+LQ@mail.gmail.com>
 <YbyX+I2PBwio0MYk@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Va1p4PryjZpyCAyp"
Content-Disposition: inline
In-Reply-To: <YbyX+I2PBwio0MYk@arm.com>
X-Cookie: Pause for storage relocation.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Va1p4PryjZpyCAyp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 17, 2021 at 02:00:24PM +0000, Catalin Marinas wrote:
> On Thu, Dec 16, 2021 at 09:30:44AM +0530, Naresh Kamboju wrote:
> > [ Please ignore this email if it is already reported ]

It's probably not worth reporting -next issues to the -next maintainer
unless they're specifically in the -next merge - I'd not read this
report since it was part of a small batch of reports you'd sent at the
same time which appeared to be being sent to me because I was running
-next rather than them being directed at me.  It can result in things
that need attention getting missed.

> We defined the bti macro in assembler.h but that's not included by
> linkage.h and not all asm files seem to include the former. At a quick
> grep we need the diff below, not sure it's the best solution:

That seems sensible to me, especially given the small number of files
affected.  The other thing would be to decide that all assembly files
should have the header included by default but that seems like it's
invasive and probably disproportionate.

--Va1p4PryjZpyCAyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG8o3oACgkQJNaLcl1U
h9CI7wf/WJqOqpWBndvkOvlu15KjhOVxLQcN+6kvwdCJOE0fAALSssjcDszIqWTk
e9oUB0RLIPWtbaHQnmj+vePeoexGWOtCWySW78i8zwbGvEk/XxCYJkZOwGVWrKIN
guEY0hpcgycV6I5eqA9ONXx9nMvePGOY5xpJMWdZcHO662/G9ZxMZsXstkgB82jR
0OInp2N2P4oQHuPOLbxAvOGaxxNDko+6SVyokfG5dOTFxnHO9XB0sDOKP8QO0XfW
Qmj2vRi62sErMFyVtT8nvmBPK8QNxYhcBt1UhBJrsHMQkhyhSXjxL/f6nt9+9OVW
2xUwGK/6M5U/q7KxmLQXkdkCJ9ljaA==
=o/mJ
-----END PGP SIGNATURE-----

--Va1p4PryjZpyCAyp--

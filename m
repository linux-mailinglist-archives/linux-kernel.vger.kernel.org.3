Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12D14760F7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343916AbhLOSnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:43:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48720 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbhLOSnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:43:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0C1CB8207C;
        Wed, 15 Dec 2021 18:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E7DC36AE3;
        Wed, 15 Dec 2021 18:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639593829;
        bh=0CChQAveQgYabA/A7L2N5fVkhXrekErzoIEpsSSqaFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mvdk8AuVVE8PACwmSlN8LjRY3Sg0RHH2QCZqdgxy39asB2LdlHtmDweDPwhxrrGwT
         MkVkIgdQu/sQ9tDxzHwt+SFBhRTzOrcDy8G06Mzp+5JT/zxfABv3+/E4ksUjUjdQQ4
         8IOSOERRvoagQu+86Ya6n8No5v1RWhqdS3qMKe153FiygdGr9Tq/5y9WZgdLjew0ZC
         5COtoJWdp3URB5ZKTAUj2MaBaPpicZ/ID3SdQxFKtUPGxQi2XHwZIj0I/nJuMHtTP0
         8P8ZHjfSu6yDCB8kmEy+MnYIIttq8CIi9tgp+Csjl4QdhZmGtuekMhBS3Vw2dmvghn
         u3nA3lCfHKYKw==
Date:   Wed, 15 Dec 2021 18:43:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Dec 14
Message-ID: <Ybo3Yad2Jm0+sN+c@sirena.org.uk>
References: <20211214223228.1745315-1-broonie@kernel.org>
 <YboPz454GCe6ZA7g@smile.fi.intel.com>
 <Yboui5aym4eB6oP8@sirena.org.uk>
 <Ybo2i0lmD2kx/cg6@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T88+xw8PeA6oWNd1"
Content-Disposition: inline
In-Reply-To: <Ybo2i0lmD2kx/cg6@smile.fi.intel.com>
X-Cookie: No solicitors.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T88+xw8PeA6oWNd1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 15, 2021 at 08:40:11PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 15, 2021 at 06:06:03PM +0000, Mark Brown wrote:

> > You can see in the merge log that it's getting skipped due to an issue
> > with the previous tree (which also has a build failure causing me to
> > need to revert it) upsetting the script.

> Yes, I see now. But as far as I know my repo doesn't have issues (neither
> compilation nor merge), or at least nobody so far informed me about.

Like I say it's an issue with the *previous* tree which upsets the
script.

--T88+xw8PeA6oWNd1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG6N2AACgkQJNaLcl1U
h9C4hAf+MqdXBRWywGGuLiRGM11ckMW4s4cZHK997CGsh6br+KZJVOCGQ/7evnjV
+8eRBY2tEYicyQEOrknjuNACLeoGyiU9uGBReDKO06rLefMg4EAPT3D/g1Dng27l
/pzQQnUbHmXzyv0kSl7n3DHSH7seqhs2ooCCSAhrjQWk4z96BKe6E65YnjFNW7vu
BLGQxw31QsSshsr0b+ROTAq3/DLIAGG+uFOBlSokKpiD9tnPvXUJD+tJ0jiXVY5o
qeju8g8JH2EOIuqNzkEKpv+jg7coLihIU5URIf66I7fTw/g0ckKXKx1Hf9DN99JL
g0s2PleL6bbzfkyKFB5d90P8gw4Tuw==
=4AZG
-----END PGP SIGNATURE-----

--T88+xw8PeA6oWNd1--

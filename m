Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C50492C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347168AbiARRYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:24:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47838 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347228AbiARRYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:24:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE39661497
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 17:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F2AC340E0;
        Tue, 18 Jan 2022 17:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642526678;
        bh=0i0HALl5CElF6itWK4Xy0OfN+GttciYs6AltWZomMco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rsGEjOwZOk5i1sLuSbsh1LxofF510yXoBH/XuBlF892ZaeApOziGnm6+axqdDvfqy
         quLZPPQTCl7hYNaxvNQzn9ORzzbBPmXeRnGIONwl50YNVHEofWgHo754dja+AJRy7b
         EoQ7dVBEwxSmvIj227CcVycHrVwF0Z4X5tP8mcaVN3k6Gip1BZvzMWNPzYo428Cb9o
         saVux0NmrM87yJ6L9vUB+aB+o+Vw8lSbBQ8lW7VaV32fhgmDu5TUds8V2Sv5uLMOTQ
         MLGk3HsK+vN2I9EJh9LN2gKemtBr4MuO5AK6osEbL7GtnaiY2rEjbnzkVZuIeUodk9
         Xfe0dUs0tcruA==
Date:   Tue, 18 Jan 2022 17:24:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     krzysztof.kozlowski@canonical.com, s.nawrocki@samsung.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] sound/soc/samsung: remove unneeded ret variable
Message-ID: <Yeb30O1vtFp3f+32@sirena.org.uk>
References: <20220117110357.863990-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n97Ndc2+f45Gv264"
Content-Disposition: inline
In-Reply-To: <20220117110357.863990-1-chi.minghao@zte.com.cn>
X-Cookie: Do YOU have redeeming social value?
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n97Ndc2+f45Gv264
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 17, 2022 at 11:03:57AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
>=20
> Return value from io_remap_pfn_range() directly instead
> of taking this in another redundant variable.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--n97Ndc2+f45Gv264
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHm99AACgkQJNaLcl1U
h9CdiQf/cnwAHPfUpdi2ZcXMAIQm5U0l8eYevcDqjxNLufpObRVWCnvxnC8ifOq9
5f9LNKmNG5ZHg1NL6s78jKmIECpU1eltowb+52BCOkTX11QPrAx29q6PllczRWqX
PSmDJTkAqNLC6RFX8Z6xD06xiNfRwapsZT3Ywmo/AQcAySKceNi4gEz7POTHWfZl
Hl06im/X/knMu3j9gg0gJ9LWgScmXyWKCN1fShKFOWI0C0eGYtV8/KmE/ITjJ0q5
KsUBQR4ZKNz+7xou/azWgCTj+NVB7WzB7OfZnd7VrAVsG5mThW+ALsFd2dm3ACkO
P95hTOdPbff+pteD40441nxhPgbKXQ==
=Y7G+
-----END PGP SIGNATURE-----

--n97Ndc2+f45Gv264--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D717476330
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhLOUZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:25:31 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44836 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhLOUZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:25:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D01F361AA2;
        Wed, 15 Dec 2021 20:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83D9C36AE3;
        Wed, 15 Dec 2021 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639599928;
        bh=BVkzCzFwrOwCwYtYhefPQ6DcWed6QHqjelnD/Kl5z40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RCtu/RoqhecceDeymibV29/lFoWKyAgE74YOq7yR1BiJae8NrnLmXWA9FFLkFPlRf
         +Q/ouiPMkOUxU6ftt1lVERwV0rCU3/4IibMZBsMLhcGyLgEMcuNF+Onyg65ajMei4Z
         tecUOC5ZtXmrGgxM8JeRu08TTwok5kpLJNBcl4MRza+tMUI5hYDlZUt0T9szhtAJsp
         3R3guhftWuUcMpTwpZOKRSVLY18nWCmQQ5+bidm+tvRFYCCew9i7QX8IMlIaRYnFj2
         Q0R/Aei1HuaveFEPDLLEsVZiFdlT2ePSVr9VYbPdU+abMf94OZ7XQlJZZ8+SQZH3an
         bKDPtTVUWne2A==
Date:   Wed, 15 Dec 2021 20:25:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        ~okias/devicetree@lists.sr.ht, Dmitry Osipenko <digetx@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: sound: nvidia,tegra-audio: Convert
 multiple txt bindings to yaml
Message-ID: <YbpPModNbC1aLWvy@sirena.org.uk>
References: <20211211224946.79875-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lvwbvfwXnj48lQFC"
Content-Disposition: inline
In-Reply-To: <20211211224946.79875-1-david@ixit.cz>
X-Cookie: Void where prohibited by law.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lvwbvfwXnj48lQFC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 11, 2021 at 11:49:44PM +0100, David Heidelberg wrote:
> Convert Tegra audio complex with the
>   * ALC5632
>   * MAX98090
>   * RT5640
>   * RT5677

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--lvwbvfwXnj48lQFC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG6TzEACgkQJNaLcl1U
h9AePAgAg6ul9yfOmKkMFgIJAAizLWOO5NqKi49ulaQFjkUkT6t369xEd3ypgnbX
+fdj6ae4ZqM7LHJFuyht8V+oJ74bdZ02bezUXvh4FrILkiibqFfR6OkIGNpIHemK
o1BpcH4wXGSy2qIbrUa6kVPwhzK40//o1pfskfzG9EN7FAmcCCnbwuOPZPKbrTt4
xOyNCP3kd6h4S0yt85jGY4T/czPvvAqM/0FpvqMtWbQNFxk5ULsvbZUESVhCICzl
8YTgGUpYnrbwJL/bXKTc4Kg3I0WYCoS5AcFNQJFI7tiruY5fDQxIDiafZ7EDk7RB
EnVAWBDelCmTSLxhwJamgK2+tTMzNg==
=/kfI
-----END PGP SIGNATURE-----

--lvwbvfwXnj48lQFC--

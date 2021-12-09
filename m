Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F5A46E887
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbhLIMhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:37:11 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:48788 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhLIMhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:37:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 000CFCE2502;
        Thu,  9 Dec 2021 12:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8D6C004DD;
        Thu,  9 Dec 2021 12:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639053210;
        bh=sWr/NrFu6zQlEeNJMoIdbEl294FdYrmPpjcG639oY8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y00cTWykjzWYzOUvO106tGsw0WB/LoPcdhUf0cu+LKU5gTDIyXdC5OA18aan3NadB
         e1GoN2T2jF4+QLbI1eNcQmxCaFKl03bzTr4+6nooPcxpiBHv4SDcobxYjkOvH3vnIP
         +U+HJXVKu7ej053Q0h+koHvYiW58l27PBPUDqoiPJ5kgTOn1A1gO4B5s8mu+96IZML
         cxW6xGVMXwgOO73kURluwd3x5IsAeDz5RCpz//66spe5Uy5AOdXMF7fwKtkfjxrVfu
         BTtAj/terlo+0Ctb4NGvc7i82BsSJ3Le4yN6wd5e8nMyzQu6ICmsudl0SjNKK/Yco6
         e3+ixeP07nupw==
Date:   Thu, 9 Dec 2021 12:33:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Dec 8
Message-ID: <YbH3lT7fh+YCCwjx@sirena.org.uk>
References: <20211208183814.71b0c51e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNxFrKzN5/LzK9Kc"
Content-Disposition: inline
In-Reply-To: <20211208183814.71b0c51e@canb.auug.org.au>
X-Cookie: One picture is worth 128K words.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNxFrKzN5/LzK9Kc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 08, 2021 at 06:38:14PM +1100, Stephen Rothwell wrote:

> News: I will (probably) do no linux-next releases between Dec 9 and Dec
> 19, inclusive.

I'll try to start provide some cover for this, probably starting
tomorrow unless a build for today runs *very* well.

--PNxFrKzN5/LzK9Kc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGx95UACgkQJNaLcl1U
h9DJ3gf/Tw4YRca2osFwsIt1ijKkAomrmGnftVZgAGvBSc96saYIFJOMC1Md6K2f
8xI1HmvztSfwoyVpJt+hsfW6zXJmtH9HU74/n5Z8kxfIFXK9HtyeulrV4wCVsTmM
t7FMQgMas7pd9+NATj0K67L0D7CPqXJ7zZyunc+ZWdpvebHu5zkd5A1XDn/sgUKM
eu3srpTxJPL7+RFEXxiW8r5GtmLbpabR2xJTqvRe0gBHvWUU1x5qlk/3l5Ftewbe
xLh2S+wwX1/7glaBVZtaW7dv9I3Rkamsh6Du2I1Y0YUk8rZhe+38HpPshw+piTZ9
RSgXi1/Mz1jFsNnFAQy0fwJdiRmpAw==
=Qy3T
-----END PGP SIGNATURE-----

--PNxFrKzN5/LzK9Kc--

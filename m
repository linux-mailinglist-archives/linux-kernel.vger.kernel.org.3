Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AE646F676
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhLIWK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbhLIWK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:10:56 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAB1C061746;
        Thu,  9 Dec 2021 14:07:21 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J97S50V8Gz4xhB;
        Fri, 10 Dec 2021 09:07:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639087637;
        bh=T+Kdi+vbaEfG5wP1THycl/1FYdnwHVcRUi+N90Ph6Zk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W0NO90e0zx5WByPQWg/tkvdcrTtJZxinzNQWcZm6HOF/nD35/0XGtzzVbOd6A+F+V
         zqaPuyYWGDTq+osTep1r0WzPVI+a6BLHPNMDBRHm1q+xHL/uq+rbgO5/XUtYETwtn8
         ldmEXQxyB3lw0PVVYPfK37NOB7a2AoAL1jnOkcEJiCEjncXzFLvFpDi2/mtGaM7VHG
         Iq+7W6VryrjmvSVm/NnD8psbl2xhC88JUeTBY9czhYj3ImTDGFpvXOr3YUvUGGP9iG
         22Nb3i/S4IjuCtCPd/W5a4sf4dLJlVmcmdmuIE6rPruxFFQM1YqC01k76IO+OWZbp2
         dW0gYnTZzlmsA==
Date:   Fri, 10 Dec 2021 09:07:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Dec 8
Message-ID: <20211210090716.6a991c08@canb.auug.org.au>
In-Reply-To: <YbH3lT7fh+YCCwjx@sirena.org.uk>
References: <20211208183814.71b0c51e@canb.auug.org.au>
        <YbH3lT7fh+YCCwjx@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PfepCrFLRDLsGuOTotOxXj8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PfepCrFLRDLsGuOTotOxXj8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Thu, 9 Dec 2021 12:33:25 +0000 Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Dec 08, 2021 at 06:38:14PM +1100, Stephen Rothwell wrote:
>=20
> > News: I will (probably) do no linux-next releases between Dec 9 and Dec
> > 19, inclusive. =20
>=20
> I'll try to start provide some cover for this, probably starting
> tomorrow unless a build for today runs *very* well.

Thanks very much, Mark. Good luck :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/PfepCrFLRDLsGuOTotOxXj8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGyfhQACgkQAVBC80lX
0GzwZwf/TeRyyCeb65WuWR4RzfJ5Op6p5fDbKo86PZULigQJV/PNOIUKIbl4vWUA
kUstBx/YsDtIwtSGxJ5UsRUCAAaVWbULFI9Fc0uqZohk0Bxl/nDcfTOcCSzvuYdY
brXrABtOVRd8AdqGNsFolL5N/4obOQ4aUUhaLRXaoQS5rxaPrRhSNkwKn6vw+aiR
06AawE4NEABXW2yh5Y8p9CrVDuBxT3CSpJUrNHS+AYGdE6nS1vdk997RsUQr0gZL
zCwXua/wEBnLpD0oi6LIyoeNeE0b5XG7U7lK1YhcGiDYsG1hCg66InDlyu9V6Ifh
giLHENvyLJRN+z+6mZ/iEewiPazoRg==
=s1Iu
-----END PGP SIGNATURE-----

--Sig_/PfepCrFLRDLsGuOTotOxXj8--

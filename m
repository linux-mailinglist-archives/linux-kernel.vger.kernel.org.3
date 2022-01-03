Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BCD48364A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbiACRkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:40:17 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49442 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiACRkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:40:10 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 94CF31F40F22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641231609;
        bh=jba+qGYPoJxadgjHqJkPUWClPPhUueOgEbofNmbVao8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jzciOK1oBh8BA/iUQo/fJ8O4H+vVLkQVF8dnDhqfbd0AXDF/O28ci5A4nulrEu8AG
         Uc4GbNQWNYGc+eqBxYH2CLt08tWZnjVFPULSFkfwYUCazh2s3Lo9bW7Kr5rEFP4Qxb
         XeOnmjegBXq8hW5N+wpwGmu+PVU9e8aJBVrOnDcgYALikHMLLlFwISa1GzlGf3Wz+C
         luEZawf+ruw6qfqnOJWJCl9i391rfJKPuHdHZZ19fJOIMxSVmaKx8qU2m/l83z3Baq
         lJIb7A6FMykf733yqlBSEUTa8gGi0GCJJFgLtNhkVKQGGaf6E+RpQJ8qTPDA0q7Sf6
         JrbHqCPLGnDAw==
Received: by earth.universe (Postfix, from userid 1000)
        id 0E6843C0CB7; Mon,  3 Jan 2022 18:40:08 +0100 (CET)
Date:   Mon, 3 Jan 2022 18:40:08 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] power: supply: ab8500: Fix the error handling path of
 ab8500_charger_probe()
Message-ID: <20220103174008.ixhrgigw63m5mic6@earth.universe>
References: <24a8b7e7b7b8f9f4b8eaad6707f420d55fd10aac.1640722789.git.christophe.jaillet@wanadoo.fr>
 <CACRpkdbTo2Xp9EUWPHjGafLRTh_9Vt54VoJ8fwDsbBukai3+Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j5w7uj7gojjsprdn"
Content-Disposition: inline
In-Reply-To: <CACRpkdbTo2Xp9EUWPHjGafLRTh_9Vt54VoJ8fwDsbBukai3+Fw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j5w7uj7gojjsprdn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 02, 2022 at 07:43:55AM +0100, Linus Walleij wrote:
> On Tue, Dec 28, 2021 at 9:43 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>=20
> > Since the commit below, ab8500_bm_of_remove() needs to be called after a
> > successful ab8500_bm_of_probe() call.
> > This commit has only updated the remove function.
> >
> > Fix the error handling path of the probe the same way.
> >
> > Fixes: 6252c706cdb0 ("power: supply: ab8500: Standardize operating temp=
erature")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>=20
> Nice catch,
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, queued.

-- Sebastian

--j5w7uj7gojjsprdn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmHTNPcACgkQ2O7X88g7
+ppMgw/+JBF67FPkXlyFeGx5QLedhsp9fAeGvWODTgAhKMsBrkpVD145ocWOlPmC
yr7Zg5JgFeK1SsONRraMpia7cCwOnI9BHh2HC6Ux0rCRpDYSf8yef+VyZZMNXhKG
yn7XyEChqCZebEJwcp0UXrA6LMiLdV7XImqsRnPoYUYHOHAYxmdPtebHEFap/OTN
zArBAArDskIsfcVZBU7iTMYo7rWGII8uzyZV15ceAR5H/I3FQ5eKT7Ct1nrVrDEh
J0J6BXqBSlTQdK9AyvhK9lBACsrUOX0aIdGSo/Rwj3wR/Pj4/I9rNOQK9p+i5xOp
zfcWVsa+G38XrwOqLNz0Pdkgx6yaylsIs4+P24Ur+I+yDAuP4uQBl313/Kl0rY4S
OsO4K6IavojjL8hVo0fvvbDy+ZkzYl21aMtOfWZOL59FD5Ul1NUt8bX3xguRZpqK
V23XjObrZCAr9lm2k7jafcscnejnLgCazW1JpwiQGxpv5+QzQX9UoQcmQVISmYtX
+qa28TmnHqqjdy/VJ4ZvztVlYV7ycmNAkH2gg4EwsMLzmQ2JgBl0RlP+q6e1iJC5
PRwqTiEkwGZJzLNhs8P3kTr/X23GWON31WjtjKsLaxP1rXBpTcPuVY8l/qgPDro2
aNZN7ib2jy19eevKULKIOa38BcOPkOFfM5ey16EKG4KRlT8/q60=
=RhbU
-----END PGP SIGNATURE-----

--j5w7uj7gojjsprdn--

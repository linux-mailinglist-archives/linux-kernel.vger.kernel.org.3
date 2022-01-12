Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF5348CD17
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiALU05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:26:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47190 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357633AbiALU03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:26:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D655861987;
        Wed, 12 Jan 2022 20:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F33C36AE9;
        Wed, 12 Jan 2022 20:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642019188;
        bh=cmhLy2J1afnp6gpFyGDqLtbbQq3RXm2M4Drjehcc+as=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cNSrvhelUyjndS3PPZTl/RDy22wCDC7kDValteAjswg90E0eyZVvA3cDUOwePKlEj
         Vn+ZlFwx1m8Z/mNi0LMJoMwkUUL4+pPc16RVOAE89+xv4Z0pg4tndnCLTYGcPg5Ub0
         pzkgeOHo80+zVQIRetMINaTl/YkoTHaeB1CQnwZrNVcPTfMjr8wGh+JLpB57SWww6X
         YJrKdr/x4oudEb3Kty/gKtJdcbgfz6hXEOZxQosiqsOn4W2PXblFDXqoWYXUeMbQix
         8Gcb9HwRjzua8wnsHGQoxxsAAe3bsQZFB/CLC1saAgI9jNT6Nb1d5aI8oWfY07Dzu9
         jzdc8gdkfFEPg==
Date:   Wed, 12 Jan 2022 20:26:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Beer <daniel.beer@igorinstitute.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Liu <andy-liu@ti.com>,
        Derek Simkowiak <derek.simkowiak@igorinstitute.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: add support for TAS5805M digital amplifier
Message-ID: <Yd85bjKEX9JnoOlI@sirena.org.uk>
References: <61dccc59.1c69fb81.e1d98.02e3@mx.google.com>
 <Yd26p8rF3arufd2R@sirena.org.uk>
 <20220111192806.GA10345@nyquist.nev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UGyhJCW8stP9TZVM"
Content-Disposition: inline
In-Reply-To: <20220111192806.GA10345@nyquist.nev>
X-Cookie: Bridge ahead.  Pay troll.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UGyhJCW8stP9TZVM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 12, 2022 at 08:28:06AM +1300, Daniel Beer wrote:

> The blob of register writes we get given from PPC3 contains a whole lot
> of explicit page and book changes, and there's not an easy way to tell
> regmap about this, as far as I know. Do you think it's acceptable to
> stick with explicit paging for this reason, or is there a way to make
> this work with regmap's paging?

That's probably fine.  It's *really* hard to get enthusiastic about this
system design TBH, just injecting a stream of unverified register writes=20
is going to make the driver very fragile against changes but I'm not
sure you're going to much better there.

--UGyhJCW8stP9TZVM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHfOW4ACgkQJNaLcl1U
h9C27Af/ZA51Bc25kI6lte8YUiUwu/1vUA916HbEzpc+2TziDfzVZ2mmt3NxQTfK
HdHHYFi7zHa/bpWKG8tVM5r388IyqQ+YZzBeX4PD//wdAquv1U5JQ8/zhsuatH8n
8uFa4haY7Ww5CePjpPHWo3d7tla/3eXV6RaBz4ML+4ZkZrSYSTVPKqSsH8kiHtnA
nhNzgM6PPCaUYZlstuq66ram2KTY2kLsga0nZqTr9ZYRp0FPunBFxJ3IXN5/wvRh
JIUOPMEENVzWFC2L4ew98mSDn3Xo7s6cx41YRRQDt+w/O4bpMYDFrnk5MhWa7Ay8
KI5VE72wzmr/miI2yPhTU0CHMDtXNw==
=cyWj
-----END PGP SIGNATURE-----

--UGyhJCW8stP9TZVM--

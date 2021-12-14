Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13272474349
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbhLNNSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:18:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41462 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbhLNNSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:18:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC673B818CC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 13:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E2AC34601;
        Tue, 14 Dec 2021 13:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639487893;
        bh=DX7qx5rjAMJYjHUOVwfHBaPOp5lvN/uPIAbsXb5K8Pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mnOUNJR0/rjQKS2wmWK3j2k4RWDh0GIL78DyS2o89H4PuZHY01lhlqeZtBRj3eEXh
         Zz3TMqWe3zAguYVxGCiXXTDQrQSRjwJ3NBLwQEc2VDbb6Pp4OVKnJuaDw4p/YdiP30
         kudYp9THPFxDxyPcoG6gXqwlvhGR/ACBfLG3iRc3vnKJUVTj1Pl89i8AO3PEBpVtyB
         vKW1cqbMGEPzTOLMKiqx7lpG+Lc0uy53gZfHktbRsPUSSBi0IQlvA7im+PC3KYsa0A
         8qj3G1EsjMfkQ9mecwKSrPc6LWdv95uiiiAcyaff9iCTLjpLNhwGkA6LWPobgWqmJR
         OfL5un/NScUhQ==
Date:   Tue, 14 Dec 2021 13:18:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Werner <Andre.Werner@b-tu.de>
Cc:     lgirdwood@gmail.com, anson.huang@nxp.com,
        linux-kernel@vger.kernel.org, andre.werner@systec-electronic.com
Subject: Re: [PATCH] regulator: pca9450.h: Correct register masks for LDOs
Message-ID: <YbiZkA3OzSTvPb1M@sirena.org.uk>
References: <20211213082319.Horde.z0oaiJ-O4G6vhVbw4WSBjnN@webmail.b-tu.de>
 <YbegDDszsM4GyMyV@sirena.org.uk>
 <20211214133555.Horde.vtlLH95Iq91Ch-lE2bqCnJL@webmail.b-tu.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0aoBd4dwZFwy0agh"
Content-Disposition: inline
In-Reply-To: <20211214133555.Horde.vtlLH95Iq91Ch-lE2bqCnJL@webmail.b-tu.de>
X-Cookie: No solicitors.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0aoBd4dwZFwy0agh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 14, 2021 at 01:35:55PM +0100, Andr=E9 Werner wrote:
>=20
> Quoting Mark Brown <broonie@kernel.org>:
>=20
> > On Mon, Dec 13, 2021 at 08:23:19AM +0100, Andr=E9 Werner wrote:
> > > Within the defines of the register masks for LDO3 and LDO4,
> > > the most significant bit was missing. The datasheet said
> > > the range is 4:0 bits. Thus, the output voltage cannot be
> > > set above 1.7V for each.
> >=20
> > This doesn't apply against current code, please check and resend.
>=20
> From ade25a42e56c341073fc4b35e8096d01522b9046 Mon Sep 17 00:00:00 2001
> From: Andre Werner <andre.werner@systec-electronic.com>
> Date: Tue, 14 Dec 2021 08:41:14 +0100
> Subject: [PATCH] linux: regulator: pca9450.h: Correct register masks for =
LDOs

Please follow the patch submission process documented in
submitting-patches.rst - send patches in the documented format as
separate mails, not buried in the middle of a reply in the middle of
another thread.

--0aoBd4dwZFwy0agh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG4mY8ACgkQJNaLcl1U
h9B3JQf+MwoljSfzBjD7M/M/cQtnXofA0bvB328T0WKoDP01lRGMo3msLLTfB/Cy
46t271bELXS0Pc+3ftXDhiO798+8W+66uWTUUrERmi/TE67Y39g30MfL9S3xBfZH
7rbPBZ7ytUjWOKopYW0l2lq6niOHudf+E/JIBo+saaTO+X7bye4s1QqI64YVZwPx
e39BPwd99egiR81kte53htmgHv5jWNd7EiVUcKBUkWP3rdXSAkvM2j041tLpf775
R1u+9eCkj/7tM/Cnv5+SBHWSer5SrXlZpW6iZ1AEJ0oOmEt4oeDWcPq08FBXcDea
6KI7UzZzmgQdAG5/rpGNlAGauWjGZg==
=GyoN
-----END PGP SIGNATURE-----

--0aoBd4dwZFwy0agh--

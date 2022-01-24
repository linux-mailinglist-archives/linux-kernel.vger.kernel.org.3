Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCAA149A089
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1844879AbiAXXKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581269AbiAXWRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:17:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EA3C04A2D5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:45:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD49EB8121C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 20:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677CEC340E5;
        Mon, 24 Jan 2022 20:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643057136;
        bh=yrceQicqpEIe7QLu9/qr6uF5VLg1Sq98e0P9UJLrRlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jq28KEBd4ggLqKrCYV3myDJMtlj5L7GOiePTyMeAN4LQ2qizDarBE+TpI4EMAJEeh
         VEfNL3meHpQRJfSfyfgVma9C32VAFCg8cXa04NWUBa1jLzP5yYcPRy4otsZ35qv6+1
         n5d6b8ru44U0QPQ7YIN+o8RYbcZV8l0qwYK7yk4ORKS6jNSh+ifNp2fnhozI5UFmO4
         +1T2vBbZ+cCjX3xwOj7xVerW6b7luhj3DDVinXfglQRDxTwdYWCjn1faov30g/Ggwv
         ryzdBjFbDFVOCD2RUhchR8wL2eH+u1LhkDjHmHS2VVXSVYiiTatHXPMFB4mABn/rm/
         HBaPjyxQg14YQ==
Date:   Mon, 24 Jan 2022 20:45:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Detlev Casanova <detlev.casanova@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2 8/9] regulator/rpi-panel-attiny: Don't read the LCD
 power status
Message-ID: <Ye8P7PmOzy6tCnpi@sirena.org.uk>
References: <20220121152056.2044551-1-detlev.casanova@collabora.com>
 <20220121152056.2044551-9-detlev.casanova@collabora.com>
 <Yerfr8Nj43TTPcAF@sirena.org.uk>
 <5533342.DvuYhMxLoT@falcon9>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="STjVNrkqRnBsFO5k"
Content-Disposition: inline
In-Reply-To: <5533342.DvuYhMxLoT@falcon9>
X-Cookie: The second best policy is dishonesty.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--STjVNrkqRnBsFO5k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 24, 2022 at 03:22:35PM -0500, Detlev Casanova wrote:
> On Friday, January 21, 2022 11:30:39 A.M. EST Mark Brown wrote:

> > If that's the case since you're using regmap would it not make sense to
> > enable caching in order to minimise reads in general.

> Would caching avoid all reads if the values are written at least once bef=
ore?=20
> The idea here is to make sure they are never read, I'm not sure if the re=
gmap=20
> cache ensures no read in this situation.

All reads for which the value in the hardware is known, either from a
register default or from a previous write.

--STjVNrkqRnBsFO5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHvD+sACgkQJNaLcl1U
h9DFpAf/X58GVi+nxaZJiA37YVmb1AEiCDAqPyThZzF1EWKawel6wnA/r/fVzii+
0ZRht60C/f91ODum1VtcLEdHgE4GT0If7AAVmR5vKVcJn0YTy8L2epouCpiTjn73
hdyjzqXOm4AmBdRnQhazMzR8S/FpqaG079U8GRix1dx90KVJBHLSE54MdwMtEhsu
isXP7FGLZp6suBXoIPJ+2fJuUwALVuecTMv+yxpIkzFS6oPCzrr9CWzDK4CORSyh
7kAc5fwIOCeyXhz1neTd+tXCdaNhlxMI0S0RmTbYGnQbX1PkDBuZiBuswoZKbGK9
qn40MKHWoxa06IOKtu19597dl+tduA==
=Orsc
-----END PGP SIGNATURE-----

--STjVNrkqRnBsFO5k--

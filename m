Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1594668B4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359781AbhLBQ4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359757AbhLBQ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:56:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4591C06174A;
        Thu,  2 Dec 2021 08:53:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 657F662754;
        Thu,  2 Dec 2021 16:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E453C00446;
        Thu,  2 Dec 2021 16:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638463990;
        bh=Xm0WA4hHGXe4BK5HdH6TJWZ1ld/3ywHizG+gb1ycEfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pl5pToVZMFSh3GNT/vOudFUnvrWcu225AOeSTkrKmyw8mZvJmllgoFNYKGZPw5X+9
         8i0QgajcuRxuLn/AocXNpwxmWotnCOK89JAyq0/qmTTV9e7++72FcESxHaxuUhLiUu
         3LLdvZJCNcyKoL25wc+Ju2wU7YwqLm8MKoo64iJSV7CDKh2lXIiEzMQgs4nPoGiAO8
         aH84xILN5641zYKu7UHHNoi9pDlTQqQirItbdpn3SIRrAIPKNVFCyjfesOA65MTt03
         gvKkfSWY5xIqis0XM3km2d0/CZCMCTgQXtt5e3LMHA2F1HjXzuNDvrX7egbLVhdAup
         sDmOTLuW6WN7g==
Date:   Thu, 2 Dec 2021 16:53:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@opensource.cirrus.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: Re: [PATCH 1/3] spi: Revert "spi: Remove unused function
 spi_busnum_to_master()"
Message-ID: <Yaj58Znf7ioGSLLm@sirena.org.uk>
References: <20211202162421.7628-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4B24liYr2woZhgQ9"
Content-Disposition: inline
In-Reply-To: <20211202162421.7628-1-sbinding@opensource.cirrus.com>
X-Cookie: Put no trust in cryptic comments.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4B24liYr2woZhgQ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 02, 2021 at 04:24:19PM +0000, Stefan Binding wrote:
> From: Lucas Tanure <tanureal@opensource.cirrus.com>
>=20
> Revert commit bdc7ca008e1f ("spi: Remove unused function
> spi_busnum_to_master()")
> This function is needed for the spi version of i2c multi
> instantiate driver.

If we're going to restore this API we should rename it to _controller()
while we're at it.

--4B24liYr2woZhgQ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGo+fAACgkQJNaLcl1U
h9Dwjwf/dUAC8fE1p6xCqErlc7IgO1UeO5bMU/AEJiPSfUUXCWTtxIuK8mVfk3w/
4mxz36WI/UGrbK93y+38ONgwU7HOlLOftixSdjciDYWM9GKz2OZeYOVTCEkAYB3e
cgZmcTQ/Mfm8kOjrth5wTswqhBc3k/08IKIqlENZ+aQioQWab86DOhFGWWfT1OsR
VMK9VZ74yCsNVk0Xa4DkIX/y8RVdGteJoEXK0HcwBVqXzXHxSga+WfavRdDJxnvP
xCEJN9iSeYoe+xoJ2yLfJFCg3o+yAuA7UstYlwE5EdWp2zE5GW4BBxSzIvQkUF3/
fpooMbekY7XxxZQ26KJ1P74a95Gwgw==
=x5pV
-----END PGP SIGNATURE-----

--4B24liYr2woZhgQ9--

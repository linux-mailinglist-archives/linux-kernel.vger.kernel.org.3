Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E6349B583
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385593AbiAYN5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:57:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42046 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385478AbiAYNyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:54:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79CD4B81800;
        Tue, 25 Jan 2022 13:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE166C340E0;
        Tue, 25 Jan 2022 13:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643118882;
        bh=4rIe1zqG4uqfonzu3BiGJCEJZPf0mpGzKQWhiuYB+xc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WEl+jx3XcfxdD1HyyZsL5xuZY0ecR9GJgiqCB5aw7sQJ5O+wkpfQeXbBaCp93Ex30
         bsxfHIh9sUnNOSpAOjQCUEpn8i0zikJOkxKjMJUT4N+yqQl08CV1/vdwA3GFZvFt+t
         Bck5npqcB2YiloVpGWVdiT6Viuy7zh8mVstQH9EDBvUdTZkhJ2MxLaqkP21aY6QwAn
         AhJhLf10J5U98pDwrpCI2IDx7e2ycsrQyzyZrOhi6AED5yLtLCXeWdpA6luZdkbdea
         cfzC5v/CynRTp79nN4Ybri/FrTWSWi3ETPHstcek2W210bHDJNmdX11pyWkIvzC9rx
         jbVmYRVUrJr0A==
Date:   Tue, 25 Jan 2022 13:54:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        andi@etezian.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add FSD SPI support
Message-ID: <YfABHDjdTgxytcUY@sirena.org.uk>
References: <CGME20220125032811epcas5p3ef7b2f4e4906c1da8ccb4a0b3ed9a591@epcas5p3.samsung.com>
 <20220125031604.76009-1-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6JkcGt5fzoOL7xil"
Content-Disposition: inline
In-Reply-To: <20220125031604.76009-1-alim.akhtar@samsung.com>
X-Cookie: Formatted to fit your screen.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6JkcGt5fzoOL7xil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 25, 2022 at 08:46:01AM +0530, Alim Akhtar wrote:

> Note: This series is depended on [1] patches which adds
> support of FSD SoC and on Krzysztof's v6 [2] of spi schema changes
>=20
> [1] https://lkml.org/lkml/2022/1/24/583
> [2] https://lkml.org/lkml/2022/1/24/120

Please resend this when it can be applied, either wait until the
dependencies are in place or rebase on top of current code.  In general
only build time dependencies matter here, the SoC support being merged
shouldn't be an issue one way or another.

--6JkcGt5fzoOL7xil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHwARsACgkQJNaLcl1U
h9CrDgf/XVhh2NrG4TbUGu2fJfgKzSEfgDJWYGaXXHThEbTw8/2XQbUYZ1WCLXcT
SPdwv/cJEHFV4x3vjTyf99wE56WhowWyTFG6ubBr7AgMr1oM4nb2En6zrJChgqPd
sI0AdFMZEh4z3CohEc4xQL8Z9PZZMXyI6DMv+OHIzYk+QYal9jXj7Hj2DEKjjRE+
2RzmU1d3rTYHZSgaHi0yDetG+PzLqH75Hv+VuYWBuBeBoughWBk/Z0IpS2tglA4Q
n7yrOFg805GgduKJjz5PefNDka0XmUMFlpFgfw8xhrlIPTvb1KaKvUu4iSyrJJPg
J7INAl0E2QXPIwz8YrixYxvy8SrP/A==
=Itzz
-----END PGP SIGNATURE-----

--6JkcGt5fzoOL7xil--

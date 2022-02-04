Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6784A9A46
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358970AbiBDNrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:47:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40974 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiBDNrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:47:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69D6361C24;
        Fri,  4 Feb 2022 13:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEB9C004E1;
        Fri,  4 Feb 2022 13:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643982464;
        bh=iuYAQR81rHR1Tyl9iL+h45RpntYsIYEQMeGVkHwsV3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rhoveJj2Rsk204CRZ7uVsbiYKD4taXHOnOJHNL083wndzUG4H0A6F+14Fjc++wedt
         CU9gnM1WngkzKPti5VH2VUN+6sYX3j9lkQcKEn9Ud9yHoykNhu7eGK6ZXTQT/RHVNM
         gFEAktAGJC9StR5zSK17GKYbnsubp4qoc9tbPStrg/5E4/+GKIlIDEe+oFayakwa3p
         I9MH8dujAYqsg97kx3LJBZGCh+8CEGXZ7GT2DFwKOKOYGgbGHNOkkCCpw3wj9vDTCB
         nR8DqmenP9dzr7mBNjXcRGYEBT+jLFCGh7Q++ZbbWNu4c0se8egDG6gSPABnSIrhSl
         JeoisgZqSw+KA==
Date:   Fri, 4 Feb 2022 13:47:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        skomatineni@nvidia.com, ldewangan@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de
Subject: Re: [PATCH 5/6] dt-bindings: spi: Tegra QUAD SPI combined sequence
Message-ID: <Yf0uehfkEOeladlE@sirena.org.uk>
References: <1643970576-31503-1-git-send-email-kyarlagadda@nvidia.com>
 <1643970576-31503-6-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BPrcS7UDX2/GdqkJ"
Content-Disposition: inline
In-Reply-To: <1643970576-31503-6-git-send-email-kyarlagadda@nvidia.com>
X-Cookie: Torque is cheap.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BPrcS7UDX2/GdqkJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 04, 2022 at 03:59:35PM +0530, Krishna Yarlagadda wrote:

> +  nvidia,cmb-xfer:
> +    description:
> +      Enable combined sequence transfers for read and program sequence
> +      if supported by hardware. Tegra194 and later chips support this
> +      feature. Default is non combined sequence. SPI message should
> +      contain CMD-ADDR-DATA transfers to combine and send to hardware.
> +    type: boolean

Why is this a DT property - why would systems not wish to use this
feature if it is available?

--BPrcS7UDX2/GdqkJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH9LnoACgkQJNaLcl1U
h9DLVwf9ESZ9zwUH/6myb7lIIE0RShnSmYP9ivbcTEMnmYpRgJ1nuLz5EdNbA1/U
fRUjukneaBFlPoIMvnCXd6h+rF1pT1Pk58kpzFXnUpH8xCeOYhNIMDmVT6pCCAkG
zHx9Zr0GN9VRxwpYRkOrz2AarvBCglnrS7fAcTWL9Og+ITS8PX+3yMMIy0QBcPLp
Jvrp56JNc9Ma0MLtnIcRT06ohs5yaiOMOhkGyqucZyg3WXwMVtmjgH/mH7vYbscC
8z56oQuLQ6le1p49MOUqkxCe1Fvhw8ql3v0LmTq+ZvNKTUJZCztlszFbdqBDoFeU
30PVUfUr8rOC03ZcYXuSnm5hionI8A==
=lmIL
-----END PGP SIGNATURE-----

--BPrcS7UDX2/GdqkJ--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923094C0188
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbiBVSmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiBVSmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:42:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B8D3190C;
        Tue, 22 Feb 2022 10:41:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F8D161295;
        Tue, 22 Feb 2022 18:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F537C340E8;
        Tue, 22 Feb 2022 18:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645555296;
        bh=PlcILcXwOi9fBpsm7seOqoPGQWIfouA8pxkgWFTFfJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D8+SlpmptrI87aGvfboenq5So/2aJLP0cDinsaic44I2HTUR0bMnVtONdsmMCafKE
         LQ4vpL2j5lwsKlYbDYy+oEeOuHgMZoS4t7NHcl1UzDwoJ6VQVtUzXFHWH0XzHoE7+4
         x2CjSraa+BqwHwpK3DQiteyQVgPdd6F5mmg/ZAiz3Xh5QuGtSvf/qC0oI8y/GlrRbL
         wa8v4t6tEhHsGGrsyGrFQ6TQZXF9VlLbxSaV6u51LJNz9EHTbd2+i+0TkwXHS2mAK6
         hhU3R5t+Ef8rvxbaxk4GMn1nDLnNBvnwYd9M3rZN65xjWbOE7sxJC5ukNdYjpxs5P/
         3oYesyjVyZ6FQ==
Date:   Tue, 22 Feb 2022 18:41:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        skomatineni@nvidia.com, ldewangan@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v2 5/5] spi: tegra210-quad: combined sequence mode
Message-ID: <YhUuW+MlgeQRTVZB@sirena.org.uk>
References: <20220222175611.58051-1-kyarlagadda@nvidia.com>
 <20220222175611.58051-6-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WWVA/QWcCulnhLx/"
Content-Disposition: inline
In-Reply-To: <20220222175611.58051-6-kyarlagadda@nvidia.com>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WWVA/QWcCulnhLx/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 22, 2022 at 11:26:11PM +0530, Krishna Yarlagadda wrote:

> +	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
> +	val |= QSPI_CMB_SEQ_EN;
> +	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);

I notice that nothing seems to clear QSPI_CMB_SEQ_EN - is that self
clearing or something?

--WWVA/QWcCulnhLx/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIVLloACgkQJNaLcl1U
h9CEGAf/VSroGQl8z/3WJdxNVBdGUYCSFKyikKK8yzn9796Gh2t+sA96yEW6uFJY
x45RQmeKDruKl5sWoDb695A3S6g6fwP8hO3ZbARV/06g9Ib7DZsB9WTpuVICXXZ2
AO7Pysc3R0qBb+4XKZpgWt+8g5u16UXptgmGa7bUI02gJNW3Nn4/RfcR3hsNnKOe
9uAeq2Dpncm8H5+gxP0i8Ngr1aba8MZHa61Rr0j/I2zLADVK4Mcwpy6XfVZoNXns
UlZvRs0FiygfEQnLEJ3a9Q9ZAPMPnE1/iJi9LtyS/H7SpIx0POv/AbKtaEWgHe/E
NaSmsp5CtTJg3R8H3LDX8fDxif7ARQ==
=z2l3
-----END PGP SIGNATURE-----

--WWVA/QWcCulnhLx/--

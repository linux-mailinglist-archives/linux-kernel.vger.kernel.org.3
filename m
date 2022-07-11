Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1566357099C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiGKR5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKR5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:57:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD96A7CB7B;
        Mon, 11 Jul 2022 10:57:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49AE46145D;
        Mon, 11 Jul 2022 17:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7195C34115;
        Mon, 11 Jul 2022 17:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657562258;
        bh=66yYQfKl/YLS5wD4GP7bcE4dcGlfdzfb42/jEMs2kS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q6ehtBiTbeatHD5D/mSfDAzQxwo6ytFwQnSTbk4W4ljdvNoT8UYq7u6M2d/SXrf7O
         Cljw5AH/OdgrH0OmFn1O330UuJLd5gC/kCjJs25HqQwj2EYsrt8nJimjKMU0BDQM0u
         /Ad2XDxnt3PhIzHeHuG8aQ/c3i1feaKyoKpEIf6jxS/iEOfUuXd4J3z7J6yeQth8my
         7JPX7u6VDDTEEhGG4ZYB1VVKLgOYA/+gqEoPoGVJos03sinbmUdUHwtgEqolZEeej+
         YB7VzORveVWMFExyv6qtR5f7wkTLTg/1v53V8iFW0Ggu7cK6CyeOBf3KwJ32sobx6k
         SLB2DTgo8Xceg==
Date:   Mon, 11 Jul 2022 18:57:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Han Xu <han.xu@nxp.com>
Cc:     haibo.chen@nxp.com, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
        ashish.kumar@nxp.com
Subject: Re: [PATCH] MAINTAINERS: change the NXP FSPI driver maintainer.
Message-ID: <YsxkjTbXkWr/jMzS@sirena.org.uk>
References: <20220711160802.4938-1-han.xu@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XkYE34yJWNNcVhab"
Content-Disposition: inline
In-Reply-To: <20220711160802.4938-1-han.xu@nxp.com>
X-Cookie: I am NOMAD!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XkYE34yJWNNcVhab
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 11, 2022 at 11:08:02AM -0500, Han Xu wrote:
> Haibo Chen and me will take over the NXP FSPI driver maintainer role.

Copying in Ashish just to make sure he's seen this.

> Signed-off-by: Han Xu <han.xu@nxp.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 83fbc0bad264..070ff36c0a7e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14266,7 +14266,8 @@ S:	Maintained
>  F:	drivers/net/phy/nxp-c45-tja11xx.c
> =20
>  NXP FSPI DRIVER
> -M:	Ashish Kumar <ashish.kumar@nxp.com>
> +M:	Han Xu <han.xu@nxp.com>
> +M:	Haibo Chen <haibo.chen@nxp.com>
>  R:	Yogesh Gaur <yogeshgaur.83@gmail.com>
>  L:	linux-spi@vger.kernel.org
>  S:	Maintained
> --=20
> 2.17.1
>=20

--XkYE34yJWNNcVhab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLMZIwACgkQJNaLcl1U
h9CmtQf+LPx/j9MPFAZisYzG8ohPqgnrl5zZvuN3ZofQzITZmwCWaRDBoX1wjeBV
mq5ceS50D625MIBKNQRLfOIAEqmZ0dfcvgEbfgnu7PRLfyn/CgZsEzgXnkYNqCZH
efzUsliU5dwetU+5wWwRhyEEnoHlezJ0vOVaR4AQXwlAK1CGqdgaYKCOLElGveGd
/mr17YseknhhhhTIKbP0Jf87kvEKwb2+p6CpeexUyrsoxXQXIBvM0rJE20iLqaek
jiYSLoFkyxXjT8bsnjsVTikPMyUcE6bmi6f+BLoDYCxu7ld5OmVqnwgGs4uXwoZV
8JBGcN/Brq90Hl/0UIWq5h9l5xYdSA==
=KCfx
-----END PGP SIGNATURE-----

--XkYE34yJWNNcVhab--

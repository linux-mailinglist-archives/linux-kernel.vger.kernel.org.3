Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8394B4B0E5A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242151AbiBJNYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:24:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237587AbiBJNYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:24:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956BC1B5;
        Thu, 10 Feb 2022 05:24:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41AB7B82542;
        Thu, 10 Feb 2022 13:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97DEC004E1;
        Thu, 10 Feb 2022 13:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644499481;
        bh=ViynvLIQDsJVAJBLbYN5w/IOJ3P4Uxv4v6juOv+xZyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gItkCPtKoy6GdMXg82CIa87ENm4a3P3P9M+aF0xm3hfzRif0qZPfQgr+UnNMZL/Ds
         KAYO/5+G2nfRuMg44tsmx8PYtt2PO5xWuCiuJEwGvj+W4PO9jAt2Kn2oG8B026iKpr
         pkQfi/N8iQgdy9vsOwLgj/ljjroVLCvUCPJA6tJ+HuvjHhGMPBj1WZCPm5M/rcboiS
         Y0NR/iF09U+VYu4gj5OoD9Tkj9YYZ/14obS7bOXYXxYKAiEx7vODQIwKXAO+LunibS
         08Y7YOtWxrrBoD5YDKwHLYy5H42R3VcZxKa5ThCJWKC0ZH0eblm/nx/5hrjrv4SAiu
         lTh2xd9mmXKyQ==
Date:   Thu, 10 Feb 2022 13:24:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Apertis package maintainers <packagers@lists.apertis.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        ariel.dalessandro@collabora.com, festevam@gmail.com,
        krzysztof.kozlowski@canonical.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH 1/2] ASoC: bindings: fsl-asoc-card: Add compatible for
 tlv320aic31xx codec
Message-ID: <YgUSEvMGMoSQYy5v@sirena.org.uk>
References: <20220207164946.558862-1-packagers@lists.apertis.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CYrnMS08Bmr4w452"
Content-Disposition: inline
In-Reply-To: <20220207164946.558862-1-packagers@lists.apertis.org>
X-Cookie: Only God can make random selections.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CYrnMS08Bmr4w452
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 07, 2022 at 01:49:45PM -0300, Apertis package maintainers wrote:
> From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
>=20
> Commit 8c9b9cfb7724 ("ASoC: fsl-asoc-card: Support
> fsl,imx-audio-tlv320aic31xx codec")' added support for tlv320aic31xx
> codec to fsl-asoc-card, but missed the related device-tree compatible
> string documentation. Fix this.
>=20
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---

This has a signoff from Ariel but the mail comes from something called
"Apertis package maintainers" and I really can't tell if there's a good
signoff chain here, please see Documentation/process/submitting-patches.rst
for details on what this is and why it's important.  The submission
really needs to come from an actual person who's providing a signoff.

--CYrnMS08Bmr4w452
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIFEhEACgkQJNaLcl1U
h9DDqgf8CJDwEojZnDvk8O6VbLMqNsI7vZnNWIite24PPFflMdCzOcl2IVhXN4T5
apANt9Yr2O8JzrVxlcFO2rfi0cRDtZoF7Vx/jnpLuVm9jlsLmO+K+HlHUZBUL2XZ
YUyCW4rigVG6DEoecWrb5Qn6aEqiJ1LAg6G8MLXo9cxe1e2qLZoMVQqcxrbsuFrv
yo0cAeBtxUqdShl5BZPi6kdT46fHEXMyosHIDNjpN+82h89Bi9ZwHety4rUYGRA9
civSqSx4+uVuCih0WZJWUNc2U2Mu0RVWjX6HXMrbL3WZxEXNh1nJpv8YIp4jbush
8DxcuUQz2QS9oyXliknsdIJdLIkCsg==
=8Brv
-----END PGP SIGNATURE-----

--CYrnMS08Bmr4w452--

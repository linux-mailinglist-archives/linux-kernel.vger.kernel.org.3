Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63804B0E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242213AbiBJN3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:29:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240857AbiBJN3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:29:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DC2BA9;
        Thu, 10 Feb 2022 05:29:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 944B860F2A;
        Thu, 10 Feb 2022 13:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF278C004E1;
        Thu, 10 Feb 2022 13:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644499753;
        bh=1DwUq7RIYQm8udrJkhokXVG//5cUWIfeguf7stIQViI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dDo2QnLy1bBULtmMeho8GZaMVBdLDpKsgm/q4u9nLjcZlHVgORGWuFTGWOPQnEWDb
         WB9gHjP0J0OeM8dNb7DyaqZTd0eYsz+RKxzKtv5UjyvuaXO/2m2sC+bz3AvWU5AgGw
         Px4NU+72FlWT/Yu+ggJNhE+7AvzYi79WW31ROqo5kJXw/sUQ2wJG4SUxUJZ5yfblqf
         SXU8chOgWUPvNLVuFezHaoHKubLqKbjLKo3Sb4JMmQgWzh3M8XlHzKNE/239fEv3uG
         LPZYtYK5hXWetadjfwLDgSLr3G0Ih3LBFFkCHVSZtuajj46VdjCIcXHaeAnxRSati8
         cNByXr3eawcXw==
Date:   Thu, 10 Feb 2022 13:29:06 +0000
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
Message-ID: <YgUTImUs470jVdYs@sirena.org.uk>
References: <20220207164946.558862-1-packagers@lists.apertis.org>
 <YgUSEvMGMoSQYy5v@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YLFsHYkxWKuQwxsz"
Content-Disposition: inline
In-Reply-To: <YgUSEvMGMoSQYy5v@sirena.org.uk>
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


--YLFsHYkxWKuQwxsz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 10, 2022 at 01:24:34PM +0000, Mark Brown wrote:
> On Mon, Feb 07, 2022 at 01:49:45PM -0300, Apertis package maintainers wro=
te:
> > From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> >=20
> > Commit 8c9b9cfb7724 ("ASoC: fsl-asoc-card: Support
> > fsl,imx-audio-tlv320aic31xx codec")' added support for tlv320aic31xx
> > codec to fsl-asoc-card, but missed the related device-tree compatible
> > string documentation. Fix this.
> >=20
> > Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> > ---
>=20
> This has a signoff from Ariel but the mail comes from something called
> "Apertis package maintainers" and I really can't tell if there's a good
> signoff chain here, please see Documentation/process/submitting-patches.r=
st
> for details on what this is and why it's important.  The submission
> really needs to come from an actual person who's providing a signoff.

=2E..and in fact the address for this group(?) isn't even deliverable :(

--YLFsHYkxWKuQwxsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIFEyIACgkQJNaLcl1U
h9B/Ywf9EqP7whzzNL2Uso8FORWO2d2z5HQhklyv9TumCpmhCGDlJ1ClJRt0/073
2sQ+e4rSTfp5pcTjFQeCCoZ7+2waeH90+mhzZnUvbn0S++x0vY2gRsqpNz6gpAZZ
b3qyxjUlisl61t9pxufe96Jluj2RDQVC274IUh2ia3CRZxWsExR08aG2k8sNRJkx
W6pg0t7U7pu16rMppTAHgtP4hwHc4xEaNuWl0mpu5UZSF4kCbaJHvOVUc9OdzXf4
zor1fVCrO1JENWj7KBcIWjiTmtc+o6SK1D4rvZrsFPaX6sXz6NYf9KjO9oYrHQQc
yX2SAurKvl6mCu5wdlKw0Yp9MrG0rA==
=9wIg
-----END PGP SIGNATURE-----

--YLFsHYkxWKuQwxsz--

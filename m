Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A302591015
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 13:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbiHLLdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 07:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiHLLdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 07:33:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454C7ADCCE;
        Fri, 12 Aug 2022 04:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6C63616D9;
        Fri, 12 Aug 2022 11:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D13C433D7;
        Fri, 12 Aug 2022 11:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660303986;
        bh=4pxvzoeARritwSA7t5/xds/KLSaUDZC3mc4bIbfFMMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TyZvwqDODPH1OA6HSRGl1wTO4a9tCG8z4Xggb5pWwT/Bs7VeDxbi4rr5+3TJCUXse
         UPXrYqe2XPJ6BxBkDDh2c+8HL0e+qK/lgApfoZiRLxf7IcY73rcxX65Wxs/fln30Uh
         hnew1iYPXfYHNmn+lgcPyXMI/h9M2FAFqDh9vmLNWW0ts/P4xtQjCie4mape+WZtBq
         2ebL4jgo9z1jp8b/dtdxfJyUi2EtiME6Y9FhHzudEdnrhdo6jTbbghhUtnz2R47Eu1
         dcgNJDVDbfERfScTrZ7E1sabAQ2mn01rfHSFuEy9ZnOha3LcCbVSDdO6qCjFRAF3Bj
         kSWXZitpqnDLA==
Date:   Fri, 12 Aug 2022 12:32:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoning.wang@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: lpspi: add dmas property
Message-ID: <YvY6a9SiFzAx5M2n@sirena.org.uk>
References: <20220812073452.45763-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tSFccgfutfxwui54"
Content-Disposition: inline
In-Reply-To: <20220812073452.45763-1-peng.fan@oss.nxp.com>
X-Cookie: No foreign coins.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tSFccgfutfxwui54
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 12, 2022 at 03:34:51PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> The LPSPI has dma capability, so add dma property.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--tSFccgfutfxwui54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL2OmsACgkQJNaLcl1U
h9AZIQf+PG4laPB+WUPIuqs6cmZr4n5FkU6dT2b2omVeJG0RhPuj6j3/ZjEN7skW
5LILVD2sQbxTFZiVmUqWmTdFw8gt8p/hTzoEEDS8pZqczdiDymAxsMg5BmI8aO6Y
J277FvQcbDjdBv/G8LEhvw2MhEwcU2tpLM/w5VM5QGEEvtH43y+ZZg6LIj+yaqPT
bluDMhENWSIynNA58Y9yIb5UYo8xtlUkntpNwDYlFX9PS2SLVrxpPW12i9dMod6J
J1pcM/JO55exKvgmkHPypQAyZWVzilheZBgBoMidr9IvecAPah1snMYuvc+jFSuQ
5mu2MZ+D3h/CP9mJc9UjVjOMyfKNNw==
=AYh+
-----END PGP SIGNATURE-----

--tSFccgfutfxwui54--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1278F586BD4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiHANVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiHANVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:21:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E433190C;
        Mon,  1 Aug 2022 06:21:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D0FE6123D;
        Mon,  1 Aug 2022 13:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D24C433C1;
        Mon,  1 Aug 2022 13:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659360071;
        bh=7e0dTmhFx+56bBcJ6Y3DtCgg1R1SoO55/B5NXZOPu9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S4M8w3TBSbNBVIsF/Z7fjbZzzoIsKfeQqgKcf3XvMz+9yReF6FlVVwXBN8Ffrmytf
         UqtOnG3SMkA1N1cyhr+TfjxvT3NsowaLYpfRVS8Yz7P7tJAptsdnk8GRm+CCdiwEcA
         BZe0C+Aupy3NkKMAQVdHmoD+P/TYiDvuZidCqPihwMAtUZOlsnmvUN5PH5PBEgDpSc
         2qZKhVxlqs5Api2GZYIpdEAXIXN7WG0e4ZQby3qFVCGywiQkcP3R/ZU6mMBZBE4iJh
         8xniOr1r2iu/hct/mDf59tMIKG4DpdhQIDlS34v4hD7jokJs0mo+3mzzy3dPJSiJqe
         4bxHN5LezGgcQ==
Date:   Mon, 1 Aug 2022 14:21:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Frieder Schrempf <frieder@fris.de>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Per-Daniel Olsson <perdo@axis.com>,
        Rickard x Andersson <rickaran@axis.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: regulator: pca9450: Allow arbitrary
 regulator names
Message-ID: <YufTP621Bsu8HVpP@sirena.org.uk>
References: <20220801131554.116795-1-frieder@fris.de>
 <20220801131554.116795-3-frieder@fris.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JWmVWoJ1B2kx7JRC"
Content-Disposition: inline
In-Reply-To: <20220801131554.116795-3-frieder@fris.de>
X-Cookie: Dieters live life in the fasting lane.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JWmVWoJ1B2kx7JRC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 01, 2022 at 03:15:46PM +0200, Frieder Schrempf wrote:

>            regulator-name:
> -            pattern: "^LDO[1-5]$"
>              description:
> -              should be "LDO1", ..., "LDO5"
> +              Should be "LDO1", ..., "LDO5" or whatever the name of the boards
> +              voltage rail powered by this regulator is.

This should simply be removed from the bindings for the device, devices
have no business placing any constraint on this generic binding.

--JWmVWoJ1B2kx7JRC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLn0z8ACgkQJNaLcl1U
h9CEAAf/ZXvEWO84dnTjhR2gC5OAiPghcP72eMgl/gtvLjw8i5HnZeEsWjpv44H6
TubfpF7w723cBXiAZR4uvVvHDS/7d4qKV3dcZvCRLalbkAar3JdIw4aQk3UZvixJ
xvcbsSL5vyyy6ZX+EWynbcuBNaQARHZm4K3S5upU+r85aoyi8tRdItDkAIQqt2hB
rfHUqiQuCm9VN6HCsch9xs0jXdfvTOLFiFcraZsFT+8iHMykuPLEPAeHU01MXBXH
wDjZztUombin+DaKLXrrKb8zzLy7RS8Fl6YfDF1zxfFpyDwA365E6iM+GaFxMCdC
ycZn91MGoBRe00RH984fgA0AuA94Ng==
=0UzI
-----END PGP SIGNATURE-----

--JWmVWoJ1B2kx7JRC--

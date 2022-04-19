Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD425075E6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355082AbiDSRGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355601AbiDSRGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:06:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11BD4739C;
        Tue, 19 Apr 2022 09:56:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A92DB6186B;
        Tue, 19 Apr 2022 16:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1822FC385A9;
        Tue, 19 Apr 2022 16:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650387376;
        bh=3NRP654HFnFZGmWHY3+1xWkxGDvnG9rzmMDHyklXIoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pzPpQ6cXLw1jVQDrxl2oIoAiuJfMXBWfRJh22XIi8S9Wh0fOnGqqkFD8/xKtn+q2z
         40Z957Dcl2GqnnlB1Z66sZuCZEdVTvarzUBoKJMQ6SJ/pMHfKptk4g0AlCgkuMxkXp
         tso7BnIG0KF9c3HE4hlvYmUZnM0CaTFFoH+ODfy1lrOpjjqmDUmD/D3SO3kq7/pz5R
         p7cPtbPrbDNiqJHwvZyhcCEusp1AZ32Q3RqbOD4A5C0BWXDy5NKKm1GL1uhNpb7TLa
         3tdnjRM5rIuWdYdCrEkDTjcv8GPuX/wSOov4GDPCX9Eb94Cw+K6gACzgHM1I3+xbSm
         rbPhvVvJwTKYQ==
Date:   Tue, 19 Apr 2022 17:56:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: regulator: Add bindings for Silicon
 Mitus SM5703 regulators
Message-ID: <Yl7pqgjza/ZfajyM@sirena.org.uk>
References: <20220419160058.9998-1-markuss.broks@gmail.com>
 <20220419160058.9998-2-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CdUwKxME8103iGOY"
Content-Disposition: inline
In-Reply-To: <20220419160058.9998-2-markuss.broks@gmail.com>
X-Cookie: That's what she said.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CdUwKxME8103iGOY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 19, 2022 at 07:00:54PM +0300, Markuss Broks wrote:

> +description: |
> +  SM5703 regulators node should be a sub node of the SM5703 MFD node. See SM5703 MFD
> +  bindings at Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml

Why is this a separate binding with a compatible rather than just being
part of the main MFD binding?  Alternatively, why aren't the regulators
described individually in the DT (ie, one node/compatible per regulator)?

--CdUwKxME8103iGOY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJe6akACgkQJNaLcl1U
h9CvOAgAg0Aii8vFN3u8uYhCarcCb6/ZvrcswwERKJJbU0v4bNjMrMcvHJsm84dG
sPqqVG+E9AJbLEMFF01/Dz3xQsipdTrPY61uLn+DT702YkZ0laY8ryv8tOjxgoBL
LHDSNnHK9kNgHHl1tRgMLoXmCg+amAj2Q8uSoJz73+VnSaV+Qtr4clJa4UuvIu6U
L5wUqVBRy74mG/LbO7G5um1aWcn9lgMR6w8sSf2s/BOVuLSbjUGr2yoZ+6I0WgDv
HVZvK/WX11DhFSKWI+LJQExY0NmsbIjsnAtER8OY2QXMkGw20TjMpCFs8wwhvFlI
8PNDne6WTwmQRkAn6CFQer/37PTz9A==
=g3pw
-----END PGP SIGNATURE-----

--CdUwKxME8103iGOY--

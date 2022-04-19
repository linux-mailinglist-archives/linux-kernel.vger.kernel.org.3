Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3222D507CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358337AbiDSWv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiDSWvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:51:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408632F3AB;
        Tue, 19 Apr 2022 15:49:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEFF8B81CAD;
        Tue, 19 Apr 2022 22:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC806C385A5;
        Tue, 19 Apr 2022 22:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650408549;
        bh=ov3PvKKki13/1eLwKdiLOM8jKV1zr/37HvkGq3CI5lc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jB7NESt8bRIOjqQiiyPv3VQ3QgrjLwswpciitEyrfWoW76xgkQuXDab5icLPt65nT
         6K4B20FDkS+JcmiuD5uwLjez6OPBgutP7OMWqpPtLvdEPCeWuOQn/o8P0WR0IxvYyS
         g3XQDyUNjHTn0wulppFb1hUS1i19ZfAHLmQ7l8G5l0eu6dn4Gue6tPUfEikgeQuYeb
         QP7C9/dM/46rNMSBWy82BJIFXkoK3egu0/QU6jbr1QtVIUUOVz+FKaOXGHCXJKY315
         +xz/YiB5X3z2ZcH+RI+me9KAPkV7t9kjJmJH2P3l6J8BiSrxoNorb5qOyLM6jNpHWz
         i3jYmWJlr/Dtw==
Date:   Tue, 19 Apr 2022 23:49:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] regulator: dt-bindings: qcom,rpmh: update maintainers
Message-ID: <Yl88YM+a2atNcbPH@sirena.org.uk>
References: <20220411110253.231745-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TUNYajfTzsbIEEGv"
Content-Disposition: inline
In-Reply-To: <20220411110253.231745-1-krzysztof.kozlowski@linaro.org>
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


--TUNYajfTzsbIEEGv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 11, 2022 at 01:02:53PM +0200, Krzysztof Kozlowski wrote:

>  maintainers:
> -  - David Collins <collinsd@codeaurora.org>
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Bjorn, is this OK for you?

--TUNYajfTzsbIEEGv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJfPF8ACgkQJNaLcl1U
h9CTSAf/W7DFE1FxCRuSyZJvjTGWX07rpEcY35GPS9uQdbl64+xHBiCYGDVUhpY5
CGey2Uh443T2YIOpjJbspIIoidcO7xj7SiHmuYu8u+eEqg4cvWALCNuJQ+QVNBrm
yLGrp211kbnlce2rfQEqym8+LdmiftyBZVT6j9Qs6rIuRhG40FcgTecs9wDk2d35
3G6Wg3rfK4fhoxXGY7hwTMGsz1AZlgnKbmFNuHHhZT72ASgNOv31t+m7R5fnakCA
I6HwtQFJW3QWDIdytpTdSPuHBlbQzDyLwqAy6YBl00P/7HL5iWWZ3E145i2ktt4P
/AAWJuFTjcB8qduil3b/oq8ASnv41w==
=Mjhi
-----END PGP SIGNATURE-----

--TUNYajfTzsbIEEGv--

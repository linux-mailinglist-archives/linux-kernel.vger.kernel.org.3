Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14C54B574D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352128AbiBNQoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:44:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiBNQoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:44:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19E04DF73;
        Mon, 14 Feb 2022 08:44:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B51F61504;
        Mon, 14 Feb 2022 16:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AD7C340E9;
        Mon, 14 Feb 2022 16:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644857041;
        bh=SIYLoF8Mkd7JQXNm+IeUIOoBVgKJOvKJXz6i4dRzNUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r0XA18a6Ya2F/64yUSZv6NElDDCr7yfafEwf6n8Yphj52MOIAU8fjb1TJO/br8l8m
         OvGHo7Tyx5vUjNECMbiJmcJ9Bxr5uvYMUGmza3GXJgFRPd9SV2thD4mVLe6BZQpnvf
         aYDohSDdes7CrjuNefdvMhWGNe2s3BupLDuu5ZfCJ00KBb3gT/72sl9TVc1RBUQEE/
         jgiTw5iWlz2bvFIJ9HAjzgEWM7Be6r6e8NxD/7Wdv4my9ceOWQycK+zieiMW+whsiU
         tDmh2Mn10v2X5VLVW/ziYcq4fAGaMFPGMN1D/JHRQb5nj0X0Cli/RbMm+WQQ2sx0qr
         3pPGStAMcFkhA==
Date:   Mon, 14 Feb 2022 16:43:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 3/4] regulator: dt-bindings: maxim,max14577: convert
 to dtschema
Message-ID: <YgqGy7a/kq2+jZQm@sirena.org.uk>
References: <20220111174337.223320-1-krzysztof.kozlowski@canonical.com>
 <20220111174337.223320-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FoD6jvcpqI2y8x16"
Content-Disposition: inline
In-Reply-To: <20220111174337.223320-4-krzysztof.kozlowski@canonical.com>
X-Cookie: Am I in GRADUATE SCHOOL yet?
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FoD6jvcpqI2y8x16
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 11, 2022 at 06:43:36PM +0100, Krzysztof Kozlowski wrote:

> +    required:
> +      - regulator-name

Why is regulator-name required?  While it's a good idea for users to
document names for supplies on their boards it shouldn't be a
requirement or something that a driver would care about.

--FoD6jvcpqI2y8x16
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIKhssACgkQJNaLcl1U
h9DetAf/U2VJufH0jzvuwJgDE1eCUzCCUABE7KCvyPwuwTvX9+4eMT+WvKFdIFTw
qSoGZAzooVKMAIxoo03NhbqQSub1whXeU6oTp0fLYebYeybGAPApJ2f6bbK4Kyxp
o6+IwcgUgREWZR1yoZLWI5Td6wj1bKSNN7mNOoeFaQO6+mGzVJszfIGJxUesrQ3L
v/ksIyY4XpGJ3YidExzgkvgoCbERHKCy/1Aopca9vaMkk4s6A2NdFQlo/jschnGF
FLU6NkLVxN8qPo+6zRmN1BmNwVzk5BUxzzlbc4f6Ev6PweEE42VjqBMYqfI7du5/
z+1qU2zMDcbT+F0jTWReFI6QM4z9Ug==
=sfd1
-----END PGP SIGNATURE-----

--FoD6jvcpqI2y8x16--

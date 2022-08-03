Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E5C588CF5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbiHCN3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiHCN3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:29:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70FF1572F;
        Wed,  3 Aug 2022 06:29:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8480E61474;
        Wed,  3 Aug 2022 13:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33014C433C1;
        Wed,  3 Aug 2022 13:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659533352;
        bh=H+0eDJ9Sq1WjJkKL0Z8+pd7LyjWylUny76gy/Ij3f0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GpLpRo9OQZ71Mz+mO+dd4t106jmQ2vV8Pgj8KDlM7iv0z8fIC+8a/AQ92j65f7KM6
         q8i0lJXr+bxl3Z2dkhjlsNVNAPjiCAQXHFZpVQ/hEpJtTRi40nrCfHzAJjHPZN2lxR
         rze7BJItI3RXxCcbqBmdjvjLGd6F37/mVWnDTbSlQ0UKGea9tzX1jGhthzeogq6I6q
         bYg+A3u3odn3MTxXUN5eCLFZmGxpADkRjyANqhJSWfZOBu/4AUK/yI8jP3ayfDlDEE
         sXkQS1TKDCTzU5A2AARQpiiLFpsQtP3q1ciY9CkbvPuTjqc0HkpblpTtRzIy+5aQdf
         nBNWha1A6JxYw==
Date:   Wed, 3 Aug 2022 14:29:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor.dooley@microchip.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: dt-binding: add Microchip CoreQSPI compatible
Message-ID: <Yup4JLh00HZxFQLc@sirena.org.uk>
References: <20220801094255.664548-1-nagasuresh.relli@microchip.com>
 <20220801094255.664548-2-nagasuresh.relli@microchip.com>
 <6d36b192-9e63-ec13-5583-22b81c99c18b@linaro.org>
 <Yuki3jpCSJDdXcWA@sirena.org.uk>
 <dc7bca02-5eb3-3b33-8911-a950b630f197@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZnAW8elfYnmgY8P/"
Content-Disposition: inline
In-Reply-To: <dc7bca02-5eb3-3b33-8911-a950b630f197@linaro.org>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZnAW8elfYnmgY8P/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 03, 2022 at 08:11:03AM +0200, Krzysztof Kozlowski wrote:
> On 02/08/2022 15:13, Mark Brown wrote:
> > On Tue, Aug 02, 2022 at 10:52:25AM +0200, Krzysztof Kozlowski wrote:
> >> On 01/08/2022 11:42, Naga Sureshkumar Relli wrote:

> >>> +    oneOf:
> >>> +      - description: Microchip's Polarfire SoC SPI controller.
> >>> +        const: microchip,mpfs-spi
> >>> +      - description: Microchip's Polarfire SoC QSPI controller.

> >> Useless descriptions - they repeat compatible. Just keep it as enum and
> >> skip descriptions. What value do they bring?

> > Someone not familiar with the full Microchip product line might not be
> > aware of the expansion of mpfs, it's not blindingly obvious.

> Then it should be explained in title/description of the binding, not in
> compatible. This is the usual way of providing some text description,
> not for each compatible by repeating the compatible text.

I'm not convinced this is a useful rule to try to enforce, and I'm not
sure how well it will work if the same IP is used in several different
places.  It's not clear to me what the benefit is intended to be.

--ZnAW8elfYnmgY8P/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLqeCMACgkQJNaLcl1U
h9BtCwf/Twfz4j0RnwW5hKGkDaikzKjLIzHtIBcnlnyLGkREvr5gdchiKFrLQx9s
fqfJaEQZAWbaNHb41xJe9xewfWxVSyAifK+ryID6BEh+qwCq6LqmXPLBVvNUgQyO
gy7nZbCshtfhU0MWhJ0OjU/v6jXQ6eVjv7QehggDLra30JV3PCK0tps0p+xeQEUx
z+Tu1q47knfkj9MfPypKvRGvUk2V41drFPijq0DMCuHUJYgjS6W7+OS5dwLQXX5h
S1t6EYEjjX+D6uFceV6a1lt0eQl82DUxysuDCPRok4SAW0TjA3/DuwIdyobv4fYM
j1XNW2JUkWuVJGuKM5aYvwu8A+In1w==
=6o4p
-----END PGP SIGNATURE-----

--ZnAW8elfYnmgY8P/--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185BA56722A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiGEPKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGEPJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:09:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325D7FC9;
        Tue,  5 Jul 2022 08:07:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBA6D61A94;
        Tue,  5 Jul 2022 15:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA99C341C7;
        Tue,  5 Jul 2022 15:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657033656;
        bh=vsE2Uo6WfEyXctqBCJ3lS6iBB4TAXOeD1CiiDdYC5Kc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sv1aNTYToTaYYK64bJcX+bhHxp+ZmLhKQ+DsPfrwouhpB/xkDb6NtLWHOPzCjEXDj
         b0ZWn9nIPtls6tcJnCspdnuymjGd4UzXFZoXXlW9Wlftu9P+1hD589f00LttgabmW6
         DYQjrJd/wDGv6qzN7B9TMnOJdC6CWCr2St68/hiNhUcWlPBHTLerK7z+4sQYQOPpZz
         qKjEQSaS2UWCSg48bBLczGgmP4OcWF0oRL8U77C1QMwAzC7gSJ5KgCsy58Z4CNlp0X
         UmXVCXOiDnezTzfPS1BmeY3Veyn4KHQ1VY2/l358QC5lm3BCceGiBt52xLpbz+2RR2
         n4fH0jZjM365Q==
Date:   Tue, 5 Jul 2022 16:07:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Han Xu <han.xu@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bough Chen <haibo.chen@nxp.com>, ashish.kumar@nxp.com,
        yogeshgaur.83@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, singh.kuldeep87k@gmail.com,
        tudor.ambarus@microchip.com, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        festevam@gmail.com, dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, zhengxunli@mxic.com.tw
Subject: Re: [PATCH 07/11] dt-bindings: spi: spi-nxp-fspi: add a new property
 nxp,fspi-dll-slvdly
Message-ID: <YsRTryAlyJjm9A9+@sirena.org.uk>
References: <ef676df1-77e0-b8ee-3950-97eade8ddd5b@linaro.org>
 <VI1PR04MB40167A70FBE772DF91047A4190819@VI1PR04MB4016.eurprd04.prod.outlook.com>
 <59d360ef-5374-c7a7-2995-854ab3715b25@linaro.org>
 <DU2PR04MB87747C9A8F18D8300461D6B197819@DU2PR04MB8774.eurprd04.prod.outlook.com>
 <f33ad190-f5c7-d9fa-088b-5538ab1f4d59@linaro.org>
 <DU2PR04MB877492F346BAA10B2AA7428497819@DU2PR04MB8774.eurprd04.prod.outlook.com>
 <62f113a0cdb0d58bf04ab0b274912eb7@walle.cc>
 <be521f90-97ce-c61d-d7d6-8f2bde24d824@linaro.org>
 <20220705145226.tarpvub6bh67tj63@umbrella>
 <d4a69511eea5195b2ee7726bda5a8a33@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4udQM6FbAizsjM/e"
Content-Disposition: inline
In-Reply-To: <d4a69511eea5195b2ee7726bda5a8a33@walle.cc>
X-Cookie: Only God can make random selections.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4udQM6FbAizsjM/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 05, 2022 at 04:58:40PM +0200, Michael Walle wrote:
> Am 2022-07-05 16:52, schrieb Han Xu:

> > IMO, use the unit "-degrees" makes it more complicate. Personaly I would
> > calculate how many clock cycle delay needed, such as 1/4 clock cycle or
> > half
> > clock cycle. Using degree brings extra calculation.

> What is the extra calculation here? For hardware engineer who has to
> specify this, it is easier to give the delay in clock phase (in degrees)
> rather than reading the documentation and transform that into a value
> given in 1/32 part of a clock, that should be part of the driver.

IME if it's a hardware engineer specifying things by the time they get
as far as a software engineer they'll often have been turned into "write
these values to these registers".

--4udQM6FbAizsjM/e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLEU68ACgkQJNaLcl1U
h9Bu8Af9EyBCmFmk3mzR3XypchGxUzMgpzu2lp5Y+4noP+jzxwkCC3HmaqS24VvW
ft41g07lerfiYg2kCb86XMAlb5nXgdc1gaEAYS8tSRgiurRz/h1k1hq7sq2TGVr3
AfWFGc5K/k3oPRjMEfgrC+ozTPuEV6UNC4nOANcB7S6fXNT4IHIw2K/gN6iNcoZW
iaygnVrlyXUCEOiR+vy+lBZU3xKJkw0zblwhobVpxJC3PhDIybaJPSB2i/BHJgQM
BpcI3Axig8k6h15SZQzbO7KkHzRtw0SdAEUyDNsmqkhN4Hrm3oHZj27LIV4BFl80
YmBtn2mAnbCpa1u65sUZvTfFHSzMAQ==
=DJMN
-----END PGP SIGNATURE-----

--4udQM6FbAizsjM/e--

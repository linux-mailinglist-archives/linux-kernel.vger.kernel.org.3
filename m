Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE12E58F03A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiHJQTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiHJQS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:18:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA7A7C773;
        Wed, 10 Aug 2022 09:18:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93A43B81D67;
        Wed, 10 Aug 2022 16:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FF3C433D6;
        Wed, 10 Aug 2022 16:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660148335;
        bh=WOQyPg8F0GVppRHtF6EF9IpQjF8KSCRpyTeSvQhMwxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S89LvgN8qVLeqDRD2w8AhD8yUAPYdHlfhL6whMkMxakEohbZ+Un4+LjsfKKaIaUe7
         EJsJZeZPXTn3F6xD/lHbj5AEBAPRflPFS0IdDB/1GtTyuKpu6AG9Blr/jff7Dbl+ZC
         G1adPQFCuYz404oBBoeY4IjfH5FrDXs9fnje8W/WQ8dLSYq3Oykw/u6P686Omusjzl
         KZYjpx612gkx65/8XkAzwHWLoeJ/KLAZapG4/G7VFgkV9wdCkZ1hAXN3rF34y6D/rG
         Eo3ONAbz+SMT+pkve212jW7LMzFgPVgtBEub//Gg0L3+sJQUFVQn2oMIX44rB/uapM
         MjeFMq3Bc9cuw==
Date:   Wed, 10 Aug 2022 17:18:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Pratyush Yadav <p.yadav@ti.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi/panel: dt-bindings: drop 3-wire from common
 properties
Message-ID: <YvPaaOgCUABREOcX@sirena.org.uk>
References: <20220810131311.428645-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C7paN41YzbGadmb4"
Content-Disposition: inline
In-Reply-To: <20220810131311.428645-1-krzysztof.kozlowski@linaro.org>
X-Cookie: First pull up, then pull down.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7paN41YzbGadmb4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 10, 2022 at 04:13:11PM +0300, Krzysztof Kozlowski wrote:
> The spi-3wire property is device specific and should be accepted only if
> device really needs them.  Drop it from common spi-peripheral-props.yaml
> schema, mention in few panel drivers which use it and include instead in
> the SPI controller bindings.  The controller bindings will provide
> spi-3wire type validation and one place for description.  Each device
> schema must list the property if it is applicable.

What's the plan for getting this merged?  I can just apply it at -rc1 if
that works for people?

--C7paN41YzbGadmb4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLz2mgACgkQJNaLcl1U
h9ChMQf9H6LPOdfGbu1FptjroVm8hHLsgruU3wnuUkhB1F1WtZkMEbcb9zAEutl7
JxSo0Fu8wBzvndSpzXzOyZlQsukueeOcTXd9lFZI3NQmKRSD7DAgl9UzMeXnETdx
aarr1MxJYaTONXaMvQxrCLMLuaqNZ7eQ4XexnuXrv52Lh6LYp52/IAijKwfH19oz
E79hMp+bVng67iZRNwn+0HuZgbR83ZCyDqFJpP9li7m756PseyEU2nf1F3cYP0D6
Y8hVZ02benHf+kIxA0nQR4FjM2OV1tuzvDobJikC3V3OLg8VVGoM4aZEbM6rEiaP
gTGuMwxcZU0NSsmxTd30vnu3YkgzCg==
=keHt
-----END PGP SIGNATURE-----

--C7paN41YzbGadmb4--

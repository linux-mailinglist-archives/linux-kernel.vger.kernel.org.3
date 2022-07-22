Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCA357E6C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbiGVSnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiGVSnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:43:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD23B82F9F;
        Fri, 22 Jul 2022 11:43:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65541B829E0;
        Fri, 22 Jul 2022 18:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BAAC341C6;
        Fri, 22 Jul 2022 18:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658515409;
        bh=mfIRv2wuhp8KHLeBKI5SqG9q732q4GvGt+OdQIlx6t4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rXgNWAkx2zzzKaEVN67f/NA8hj5ybOxmP5JJLSZNRLCt8UPqRwqRRWvYn5SjaZvoe
         WhBDkhlb6SAR7J5I1WCswQcUwXwmTIYdAqgdgBKpgqmzl/JWgBMMN3GiDsD6Ya4Pjn
         1o6vidn0H2AVq25yRHYB4BVuqdhYFOVAcBcPHIO2ziyxNJVbtSgtPQNyVeLtV+mdZJ
         t8HbDdfb8QFjlaKIayJMrJhi6d025Dw64BK9Id1sKCLFVMQBaA40c7nmUpEf9mSi2P
         v4qMr4zCljCx7pTg7tGWd8Q5d6B1iaAwzI+ljZRdi8reqF24S5KhrTBQXmHwqDEpzy
         X63CZjh6TmB0Q==
Date:   Fri, 22 Jul 2022 19:43:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, openbmc@lists.ozlabs.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] spi: npcm-pspi: Add NPCM845 peripheral SPI support
Message-ID: <YtrvyyMGm64hFG5j@sirena.org.uk>
References: <20220722114136.251415-1-tmaimon77@gmail.com>
 <20220722114136.251415-3-tmaimon77@gmail.com>
 <afae04e0-76a3-1bcb-5b47-9944fa9ab2c0@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ry/50fY3hlFre6NP"
Content-Disposition: inline
In-Reply-To: <afae04e0-76a3-1bcb-5b47-9944fa9ab2c0@linaro.org>
X-Cookie: Yow!  I want my nose in lights!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ry/50fY3hlFre6NP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 22, 2022 at 08:31:22PM +0200, Krzysztof Kozlowski wrote:
> On 22/07/2022 13:41, Tomer Maimon wrote:

> >  static const struct of_device_id npcm_pspi_match[] = {
> >  	{ .compatible = "nuvoton,npcm750-pspi", .data = NULL },
> > +	{ .compatible = "nuvoton,npcm845-pspi", .data = NULL },

> The devices look compatible, so why not reusing 750 compatible and
> adding more specific upfront only in the bindings instead?

...with a fallback list required by the bindings so the driver actually
binds.  Note that bindings are currently not in YAML format so there'd
be even less enforcement of that than normal, and as they're currently
written the bindings don't require fallback.

--ry/50fY3hlFre6NP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLa78sACgkQJNaLcl1U
h9AEwwf+OtPY0/qOhQEJ/2NsoSOb8GSd7aJy+EOe87QYuCJBD5JsoZiLHai6ubHa
0zs/2vrhlkyXG7cwFqmhim4KR5XhbU5vrBrqV3SLNb8tKfRF8EcUNpG8jK9S+Pih
GldFX6HoidQdZAZK7eGvXsWymaJavKEeLJ+jD/GQ15LnlNSVyxSYF/IW0rd9SP3L
5MdwDI3SLPefhUfFmSd/QEZ5ZbY3RLRvCkkUIaFLC/0VwC9mYV0NbBUQm2RbC5EO
ljTGswpc41I4VTgs9IAuLgPetUsqecivo4Q8Iriwb+7g2SMbIaHf6LtJQqaOGqvc
0BWDzIyUZDxzu3tiB6I3WNJupudE9A==
=7ol/
-----END PGP SIGNATURE-----

--ry/50fY3hlFre6NP--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A2957E6E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbiGVS5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGVS5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:57:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24F7564E1;
        Fri, 22 Jul 2022 11:57:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EA2A60EF5;
        Fri, 22 Jul 2022 18:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E4EC341C6;
        Fri, 22 Jul 2022 18:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658516253;
        bh=qlEQPdf/GEeiUyuZqjpiKhRwwr7dWbJkJKm74rG3gHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZGN2F3osr2Hq6PPOQhOQ1WeOpiCkN0aTbcI154Js7LbHdACxRictYupgPmRkj0YOm
         KaxMujrBOXVITl+gkBHSpoEJ4Vi9BNIL0BDBiBc5SXX69HEKrVdTGbc/xUTLGnhECE
         RyguhwKcwHJPR1y8pEastYamufBv956gW1ottf49KfeGF5IugfxDV5r3zOWh5+JqmP
         JOqJdIpmfqvq0Q2r28sMpQFXcDt3F7ezx6NxJ7LnRmpNmVFKpJ6zMZy9SWOruNb5H4
         ZRCCIytU+J9x80IHBCtrT5WpjHCV1U1qV9ZTYdzCKYEoPQJW+DvbvmqERDiGzuRYrO
         e3MM8tTzWWemw==
Date:   Fri, 22 Jul 2022 19:57:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, openbmc@lists.ozlabs.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] spi: npcm-pspi: Add NPCM845 peripheral SPI support
Message-ID: <YtrzF9BFJrXfxiz0@sirena.org.uk>
References: <20220722114136.251415-1-tmaimon77@gmail.com>
 <20220722114136.251415-3-tmaimon77@gmail.com>
 <afae04e0-76a3-1bcb-5b47-9944fa9ab2c0@linaro.org>
 <YtrvyyMGm64hFG5j@sirena.org.uk>
 <0c8688d5-b0c1-8cc1-ec27-292acbb38dfc@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UbxSBqEr8U0AN/GQ"
Content-Disposition: inline
In-Reply-To: <0c8688d5-b0c1-8cc1-ec27-292acbb38dfc@linaro.org>
X-Cookie: Yow!  I want my nose in lights!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UbxSBqEr8U0AN/GQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 22, 2022 at 08:47:24PM +0200, Krzysztof Kozlowski wrote:
> On 22/07/2022 20:43, Mark Brown wrote:

> > ...with a fallback list required by the bindings so the driver actually
> > binds.  Note that bindings are currently not in YAML format so there'd
> > be even less enforcement of that than normal, and as they're currently
> > written the bindings don't require fallback.

> Yes, the bindings document should be rephrased but we were living like
> that for few years. :)

The binding document as it stands only has one compatible, there's no
existing problem with it other than the YAML conversion.  If we're
adding something new that requires a fallback we should be explicit
about that rather than have something that's actively misleading where
previously things were clear.  I don't mind if we add the compatible to
the driver or document the requirement for the fallback but we should do
one of the two.

--UbxSBqEr8U0AN/GQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLa8xcACgkQJNaLcl1U
h9CC6Af+Kw0oDGAT+xBaRBeKTXmSgfg/pO7Y8Mf9MVM+HhbN19e3qM65lfnixOKg
fcMyys82+nUBbEDFf77vFrXDJzaPNjsNdDBfczogsFMkJDhNO0bPwMs4Op1T444k
Bp/OYMF3fxgsrparA9XaVn3J4g25TZeNq9z3YaJ4eXtmLFbUybaLFF8KaN3byzLm
0aAcUtXMB4v7jaa+x6GBNhMQ2NkLUUEEGltmV78/l6w/PTCvjwGH6EpB69mmWFDM
dHxqz/Ac6Y/TiiR3ZgaHdbJBjOfOydiyINeMHyeGE5P6Xn5KCVvl41kIaq3g6rG7
sGK66BmAjWTb1mDHmmwM7wa+WbjHLQ==
=yVCU
-----END PGP SIGNATURE-----

--UbxSBqEr8U0AN/GQ--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01114F7E17
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244800AbiDGLdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbiDGLdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:33:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DFA2E9F3;
        Thu,  7 Apr 2022 04:31:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1819661E80;
        Thu,  7 Apr 2022 11:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7CAC385A0;
        Thu,  7 Apr 2022 11:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649331093;
        bh=pAQlo9VKRGjLf7hnntocI7qznMtnPAZRWg9jZ+ojOHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ELW66sYnXkyaAVA6351QFt8aTuVYZDHX90TAc0q6uqjOSULQtghTxPjdV/qy+SAo/
         HoyD6rDG4velCLBWezYrwYqeHgbbTR9uCVGIhRTZkeT8CWooM7d8aEupyk334z6Cr7
         p54bLIzW0sofu1S9R5dtzmq47Oh32ESQ8FTJz9HudovtfZv0hXKCm7s0DU7zcEROSF
         iCHfd1Ilb4jEIh0DPDxmKRjt+YH0N4rEOshJGQhu8lsLFx+MDlrI5fKsnNsfRmlluz
         D4Dm1GOn6azBLG8sa+VKFIPKiNNYdSOpR/4130NxD/qIGlQ5+0WaPc+Wd1R11TW8jB
         dch9f06RJOn/Q==
Date:   Thu, 7 Apr 2022 12:31:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Manohar.Puri@microchip.com, UNGLinuxDriver@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        devicetree@vger.kernel.org, kavyasree.kotagiri@microchip.com,
        krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        nicolas.ferre@microchip.com, robh+dt@kernel.org,
        tudor.ambarus@microchip.com
Subject: Re: [PATCH] spi: atmel,quadspi: Define lan966x QSPI
Message-ID: <Yk7LjrvqSLbzPYkw@sirena.org.uk>
References: <Yk7Ex5ltaxC7Z+N6@sirena.org.uk>
 <20220407112345.148316-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="70S9eEVN4l3t2VB6"
Content-Disposition: inline
In-Reply-To: <20220407112345.148316-1-michael@walle.cc>
X-Cookie: Look ere ye leap.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--70S9eEVN4l3t2VB6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 07, 2022 at 01:23:45PM +0200, Michael Walle wrote:

> > > +      - microchip,lan966x-qspi

> > Generally DT compatibles should be for specific SoCs rather than having
> > wildcards in them, even if that means you have to list a lot of SoCs.
> > Having used wildcards in the past doesn't mean it's a good idea to
> > continue adding them!

> The subject should also be prefixed with "dt-bindings: ".

I tend to complain about people doing that.

> Mark, I did a git log on
> Documentation/devicetree/bindings/spi/atmel,quadspi.yaml and all the
> subjects are without "dt-bindings:" although the original patch was with
> that prefix [1]. Is that intended?

Yes.

--70S9eEVN4l3t2VB6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJOy44ACgkQJNaLcl1U
h9CK0Qf/eynzvwn+qunlhuPIQLhYf6kD/1JDE42i7LImEZFGGG9ob3onn3C3rbg5
m0sbxoHJNz9VbUGKJmUy4A66/QyJP8bJApwnQwatPocPaNmgsroJ/Llh1lsvUajG
AefNPi+c1lsM9iyn3Gth6Ayu0+UJitpDlLOGOVqzPv0dfS7TumeguofMOnaa8VEI
OnUbmD37HW2UabIeGbExxv1kywu5ZESKlOK482er+mhomgH2L2KvLDYX5a4c28kE
H/bL0V5TKaJC7y+FF9nVJ6sk17xDL+cma0hx2m2ADj5lShT/ZuYJPsQGfIR/8h6e
b8Wfd6g+R0bCFExvIAyGNZdSYPkh/Q==
=/+W7
-----END PGP SIGNATURE-----

--70S9eEVN4l3t2VB6--

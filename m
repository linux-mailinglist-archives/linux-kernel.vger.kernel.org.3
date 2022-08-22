Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895AA59BF79
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbiHVMZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbiHVMZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:25:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED698E0F;
        Mon, 22 Aug 2022 05:25:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BB16B81132;
        Mon, 22 Aug 2022 12:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91E5C433D7;
        Mon, 22 Aug 2022 12:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661171132;
        bh=m1TktFVlldD0iGrCw8ofyQ/cTXQAPa0Io0sL/xjSK9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n2tKqYsOAV0KDcN/tiWD5ojdxWXInPmQ1ZXUVnZpVWilKUtal+F6WTmtPKGSVLpbF
         wjR3d31j4PDGKhaGSLOVT4dCUqiBOtxFzIHYXYI0J1WFBSpeMmiCJnrMeHQYbZuQdv
         4UFhGgxdhtQMM5TPyPz3ViXyhcdedkCZpEEz6mKJcwz94ib3Nvs03iZRzmLX+WBhBL
         FsgY6X6V7fdkKJaP3onOjCaAhW26svc5X11kBQGzR1EqhjgTEncKB56NCFfjTRbgP8
         uvTWbICwqkUTa8IO9UBis2Qg+GtM03FKVwWmeghUHSTMU65xUeZoJq9ahN06+kOm+/
         KYuNtJGJoek7w==
Date:   Mon, 22 Aug 2022 13:25:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, yamada.masahiro@socionext.com,
        p.zabel@pengutronix.de, piotrs@cadence.com, p.yadav@ti.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, will@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 17/17] mmc: sdhci-cadence: Support mmc hardware reset
Message-ID: <YwN1s4bEKP2jX8Qm@sirena.org.uk>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-18-brad@pensando.io>
 <CAPDyKFoYdQirftoEQAMBwXKXqSo-tu9EUvL6B6vHCj6cDd14ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WTu6/ccq9jWtsAFn"
Content-Disposition: inline
In-Reply-To: <CAPDyKFoYdQirftoEQAMBwXKXqSo-tu9EUvL6B6vHCj6cDd14ug@mail.gmail.com>
X-Cookie: Do not write in this space.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WTu6/ccq9jWtsAFn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 22, 2022 at 12:53:22PM +0200, Ulf Hansson wrote:

> Other than the comments above, I wonder about what merging strategy we
> should use for the series. I believe it looks fine for me to pick up
> the mmc related patches, thus we can apply patches on a per subsystem
> basis, right?

Yes, if there's no relationship between the different subsystem
components (which looks like the case?) they should probably just go
separately - they can probably be submitted separately too.

--WTu6/ccq9jWtsAFn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMDdbIACgkQJNaLcl1U
h9CrnQf/R4IGSSuvA+pTi1ROvJpYHxOoK6FAG8Ycn1tJWAbnibo3z/Zh9CAvgPFX
PCVYAuRbfJuV23rSlmJsrwkJEoOb5+kjfkBtRwA2ANra5+IXeoHGBxplvSiIQDOl
BVbcHOg4W3fn7hHy6x+Mkv/hMNo5V8zgeS+/p6Gl/l2MzXdmwJOSYQjCRjHiGqN8
Vg3cJZsXsfBMO0fLsYYJyxRHgkVsMjAzIq+2m6YgUp3YHsRgeTFf3NMC485S3afs
ywRgJt0Qm+ooktyFBKSWLkIliKN3WqxD+k7hAY1A2Nxolpgdujxg2gvJ8N7QfQDQ
luu7bymmtiES89rc5qPHEcSwAAUkUQ==
=rg/C
-----END PGP SIGNATURE-----

--WTu6/ccq9jWtsAFn--

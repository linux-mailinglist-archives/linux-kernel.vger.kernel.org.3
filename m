Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E663B57E6B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbiGVSkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiGVSkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:40:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF287DF93;
        Fri, 22 Jul 2022 11:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 749FA60EDC;
        Fri, 22 Jul 2022 18:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0612C341C6;
        Fri, 22 Jul 2022 18:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658515213;
        bh=5d2CxmU9AENpMob659VU6/m+ASfwTBzbjgVodKTKjJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BejbpjJFNI/WK9FjeD2uItfqn59IZDDTupoIL/CYiXcOjyCfpMDNCn6gFW0Lddhc4
         y9wXMeM0YKLcDiO3uw6tBklCC8qY1xFkRt3KMQVXoklm0lAi9uxh2IJM/KRABdBVJn
         9xdxAYIsV5PznPVFcr+QBWJ2xAe/EnbRxZhPyi/EGZlsH/MsVVjJXP+pJZ6wkfL+Sq
         wp46O5+ckWjxfD5afF3ElwkJKpVQm6Zicf/48VYCGHJKlZvpBriZ4RBAdz9BkaAVVp
         GmBLr32hAvIOH/ejgTB3yBBhDqxDAJ3QVGXoFfl2B2NlYyB3FIFUiIDkbaBzdB/p1p
         rfeTTCcuwsing==
Date:   Fri, 22 Jul 2022 19:40:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     jerome Neanne <jneanne@baylibre.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, nm@ti.com,
        kristo@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        msp@baylibre.com, j-keerthy@ti.c, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 08/14] regulator: drivers: Add TI TPS65219 PMIC
 regulators support
Message-ID: <YtrvBLvcDZHM2qY9@sirena.org.uk>
References: <20220719091742.3221-1-jneanne@baylibre.com>
 <20220719091742.3221-9-jneanne@baylibre.com>
 <YtayikFdidxXXubS@sirena.org.uk>
 <b89db08e-3a06-5a8d-2c24-eb087ee3ca7e@baylibre.com>
 <YtqabjVY1vRgjZlM@sirena.org.uk>
 <45c6843e-0447-cf5e-6f1a-3920032ac88c@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hitHSkzE9R3acAMO"
Content-Disposition: inline
In-Reply-To: <45c6843e-0447-cf5e-6f1a-3920032ac88c@baylibre.com>
X-Cookie: Yow!  I want my nose in lights!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hitHSkzE9R3acAMO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 22, 2022 at 03:30:11PM +0200, jerome Neanne wrote:
> > @@ -0,0 +1,414 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * tps65219-regulator.c
> > + *

> Please make the entire comment a C++ one so things look more
> intentional.

> checkpatch is complaining about that:

> ---------------------------------------------------------------------
> v5.19-rc6-PB-MSP1/0005-mfd-drivers-Add-TI-TPS65219-PMIC-support.patch
> ---------------------------------------------------------------------
> WARNING: Improper SPDX comment style for 'drivers/mfd/tps65219.c', please
> use '//' instead
> #91: FILE: drivers/mfd/tps65219.c:1:
> +/* SPDX-License-Identifier: GPL-2.0

> Let me know if I should ignore checkpatch recommendations here.

checkpatch is complaining about you having written a C comment there,
I'm asking you to make the entire block a C++ comment.  checkpatch won't
complain if you do that.

Please fix your mail client to clearly indicate quoted sections of text,
it's quite hard to read things as they are.

--hitHSkzE9R3acAMO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLa7wQACgkQJNaLcl1U
h9AmIAf/QFBWNGXGoSRXrf91mFze1AK1dqijdQlKoRNVaWCW8ZCVhIYxj3XZ9c+k
Edk8kq3rIeYWCQ4CEzXuL5uevLKYTdOE7GJLZWSEe5C8uY0OJTFLH54eKnynN4Ab
hqs4FdjR2Ng6wyXoav9D6q4+PojTq7zBB3Fm6rPec9Ua0AA8YRcWXrDpc4TC3yb2
eHYDXkaPLJ5MmY3hSsf6IrA5lj/yqh4oMd8DI3ncV8GvShGFmDA7tgdvXmHhVI9g
23vvpV2t93OVWPWHXo9VWmur52v3Witf7pRUmciu1zpQP4rskkd+iUPf7GBXiWoc
0iAT0AkJE1mU8dU/z4mlAUwgiPUWDg==
=smpH
-----END PGP SIGNATURE-----

--hitHSkzE9R3acAMO--

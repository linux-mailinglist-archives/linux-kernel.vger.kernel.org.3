Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DBF4C705B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237483AbiB1PMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbiB1PML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:12:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC417D013;
        Mon, 28 Feb 2022 07:11:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16AC860F82;
        Mon, 28 Feb 2022 15:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE607C340E7;
        Mon, 28 Feb 2022 15:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646061091;
        bh=9cfu46kfT0YYObqGd09mZYMm5lKn9yaccVHWiLQMjEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UNJPrKLu9xKuVbNg+b73ZeDZ6fTwEpn8JeSaUWWaTs9Ar7jGusXTUtQLnJE5PiBBa
         MSu0zp06O9wrBXxINiV+jy5pci+ZA4poZv5uZunsBrzFEH1Yl57sIVv46muYq3SJJy
         4FbFDC0PmUfbBwMmIyxwowjd6yGHS59vojsHrohyLG1/GGNedtnRf7SzPlU8vByiJ7
         nckt5sBFnQAf0X/H9cR1dzg+771XU9ieJlTj01f6Yzdykv2ehQNM2ikoRfJ5U9m/TO
         TFgXHnVoByTJFoo3+OSCHW1iT7PRMFnib82XfugbGQjFyNd9k4njSLRdtZYY2pp7YX
         6yizDZz7LTTOA==
Date:   Mon, 28 Feb 2022 15:11:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: spi: Update clocks property for ARM
 pl022
Message-ID: <YhzmHgV3L+3nmt+Y@sirena.org.uk>
References: <20220228124345.99474-1-singh.kuldeep87k@gmail.com>
 <20220228124345.99474-2-singh.kuldeep87k@gmail.com>
 <6e14bdd4-5924-dd58-41ef-5bdb5561913b@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JIbKIh/u1QuU3fht"
Content-Disposition: inline
In-Reply-To: <6e14bdd4-5924-dd58-41ef-5bdb5561913b@arm.com>
X-Cookie: Killing turkeys causes winter.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JIbKIh/u1QuU3fht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 28, 2022 at 02:26:12PM +0000, Robin Murphy wrote:

> Who says that minItems is missing? Looking at the PL022 TRM[1] it seems
> clear that SSPCLK is pretty fundamental to useful operation. If that DT ever
> worked, it must be that the same clock is wired to both inputs, and the fact
> that that's how the neighbouring PL011 is described is strongly suggestive.

Well, it could also be that the clock is wired to some other clock which
is always on (which I guess is why the driver allows this in the first
place, there's a lot of sloppy code around stuff like that in the tree).

> If the point of schema is to find errors in DTs, doesn't it make more sense
> to fix the DTs than to weaken the schema just to shut it up?

I do agree on this point though, given that the clock is actually
required for useful operation what's happening here is that the schema
is detecting an error in the use of the binding.

--JIbKIh/u1QuU3fht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIc5h0ACgkQJNaLcl1U
h9CHCwf/TtI0aqZuzjNSWV4dcV7lKWubKyQkOIckU3pacyuWAGNxWwihWd0w5FMd
lyZAHmDVTpD+fwI3zaJ/eBLn0RPET3/dzHhQBKvDg/ejGIoWFjdIfIwZ5YC+Is3r
B2QzdK33gFHdSEAtN+wsgAiLdkZfZMxW5xTKa/59ub/5kFSlfoTXKGhfls2uD27w
+U3oT20NaGZl//aoqoJ+9w0KIb1HTBZcmu4NTJ3FzaZ5hEsafS/z9s7Emap3e+EX
sxWbB6atRl6loSvbvvzKGg+HVA79itnSRDnWkGZ2szwULwOQjZMi4GhitOVchsoG
cBxG8hBKA7EjTW+jzGk49VVBaiwzAA==
=vkXY
-----END PGP SIGNATURE-----

--JIbKIh/u1QuU3fht--

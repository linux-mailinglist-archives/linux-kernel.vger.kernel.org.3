Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A910A50A6FB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390725AbiDURXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390505AbiDURXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:23:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744542B1B6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:21:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1035861DF2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 17:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DE7C385A1;
        Thu, 21 Apr 2022 17:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650561662;
        bh=WuG3mEg/8lhQCajKRUfY5lcdr1UBJIgbvl5qAQTm+EY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QgU9T0yPDN+B9ndtK6XGBtJz7BOCT2pQGzZtRilym1TB1fF1H4OfAvk8ixGMBldhD
         86IQupGzW9mQTW+UVdMOlzVM7RmIPhHD0b6dv+3KPDS40b9sfIjHGVbzKSzJ9EdANb
         fLYYUIP0IaXf/QvH2/ldBkPA5M0Gs5/d8L5iuiSArtxtls3b0yrQFhAOzFk68CFvLl
         Dk3+HdS8UhgbFXkXTmrlo6etqzcQw/WWk9PmRKH34oE0inbVTSJpxCSJ38tPxsmvDO
         d/jiuaRtBv5NGu31Cb2qpMvODgvEE/uhTA5++8pGrHhoAKqytXxixnsX8z4l/lrqGi
         p9huEZboOlSLQ==
Date:   Thu, 21 Apr 2022 18:20:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dmitry Shmidt <dimitrysh@google.com>
Subject: Re: [PATCH 1/2] Revert "ASoC: meson: axg-tdm-interface: manage
 formatters in trigger"
Message-ID: <YmGSeVbwWtyHP/Tz@sirena.org.uk>
References: <20220421155725.2589089-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IrsbsSdYKQuD+rKo"
Content-Disposition: inline
In-Reply-To: <20220421155725.2589089-1-narmstrong@baylibre.com>
X-Cookie: Two percent of zero is almost nothing.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IrsbsSdYKQuD+rKo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 21, 2022 at 05:57:24PM +0200, Neil Armstrong wrote:
> This reverts commit bf5e4887eeddb48480568466536aa08ec7f179a5 because
> the following and required commit e138233e56e9829e65b6293887063a1a3ccb2d68

One other thing - these should be Fixes: tags, that helps tooling figure
out things like backports.

Also:

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--IrsbsSdYKQuD+rKo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJhkngACgkQJNaLcl1U
h9C8Fgf/VidmSJ2cMNCtprev2dZXNKdvl5hp5ru5Oetxz+eMGSCdPjKGw4OW35Dc
mj7OuaoYqZ6+1sHDdYhwtY5rpDGBpxXsRrLLun3ddBp6SrgFIFVZH4hUWAljayN4
eLXEOdvmlTixcnKoGgvEnl7FxldrV3Ojvi6VixOhXWTpDPo3dlj1BoJvHKvU5rsr
A3Iip2GOibnZvUxLfzblfBzGs6jg7kAdUF19GflvFDoSNtCMJ2O/lAULE6QUA8CC
+dkIBIWWJCHsGgwtaRPfridNv0z1gHS+gWQOxb1F8MM7zWcoVqHg3FQBNm+pRVIX
DL2OPncZcm5/LpBtB0O7NM88PFr70Q==
=JmF7
-----END PGP SIGNATURE-----

--IrsbsSdYKQuD+rKo--

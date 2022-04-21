Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CD050A66C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390491AbiDURCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiDURBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:01:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B140627B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:59:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C91A461DB3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1578C385A1;
        Thu, 21 Apr 2022 16:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650560343;
        bh=+kLX02+pvp0VAy7mZikCPZm3m+jcmFNycfkdqROEoG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W3SHqRLXFzShZFzr3y8krzbijHOnldDnMtuCLa00QdChMiuy1i4ZxmDQHLDToEZVs
         uLkKjUbQDKEo9gAWBIOSxVduMi9GFtbXCF9K0GyP8lyf8tjYtQtk1C7RA4V2VkmwnA
         iDlpWplntXOBBAvmzpsCiHsDb1f+qzCENxUUzez79+R71kn8SQAZoia12LIWfLkUQG
         Lf5zODhiJF6dc6Sh4cL7tKS/saLhylN5FBGNauYIXEY6LpEvrZODapz8vmT4nwwyJq
         sWhwTBF+RWkTpg4TPDgyi2uOMSBbByyYJmWvk5dmYz180M2wMXxvltygk4xCg4yhIP
         DIZzbg9ZbzyqA==
Date:   Thu, 21 Apr 2022 17:58:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dmitry Shmidt <dimitrysh@google.com>
Subject: Re: [PATCH 1/2] Revert "ASoC: meson: axg-tdm-interface: manage
 formatters in trigger"
Message-ID: <YmGNUoOIHMDkciR8@sirena.org.uk>
References: <20220421155725.2589089-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3eyDRwkM/Maj7Zsh"
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


--3eyDRwkM/Maj7Zsh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 21, 2022 at 05:57:24PM +0200, Neil Armstrong wrote:
> This reverts commit bf5e4887eeddb48480568466536aa08ec7f179a5 because
> the following and required commit e138233e56e9829e65b6293887063a1a3ccb2d68
> causes the following system crash when using audio:

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--3eyDRwkM/Maj7Zsh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJhjVEACgkQJNaLcl1U
h9AZOAf+OjEB0rx20UWIL90pvczAy+XNaaircBEQ0cphHGKM9TrfcEbYFOlQm3qV
o6k6orFrbhYlVELViEbuHsjPrZVY3/NEowdMEK5eBwG1V3OdrLFDgSqKjpmRiWrX
eODgqxRNJ2U+7gBaBwJumlBUi2X0p5u5nVFlgvwmL87yKOl+Uom45nqL/ib7WMnM
VtrFfTZPgATIq/S98eN1SuswUtyYrtN7i7C+5Q7qGiIKKr067Vium6gBIliiLY19
pAT7lVyUEdDHWvNOrQdGveWoxe9Ospr+uvruoR8dGdp2BqC1tFXlrUHn9bm4S0Ai
AgQu/b0xjh2BW63QSFeG7clYApQUOg==
=5BRg
-----END PGP SIGNATURE-----

--3eyDRwkM/Maj7Zsh--

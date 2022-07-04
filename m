Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D88565C0D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbiGDQYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbiGDQYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:24:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF4E6266
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DE2AB810D8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 16:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B245FC341CB;
        Mon,  4 Jul 2022 16:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656951874;
        bh=dDT6TcD454XFvSSPajF93+eR+cdOB5pLYEIieol3Tg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cllBcGmGun0bGXF+xOhCyyQ3okyGPRag8ICHdOSd6H/WKjUcWh6ZJC0NbSS5d3nba
         Goh4o7nDdCZOypukCMs0bMuOIfhvcQuROptYbAPL6PkyKIck8pKM9Jk/4a3fno0gzi
         Z/r4qC6FbiI/mjav8WBG4S0h0jdvZT7cWe1N8kTque9/gnleTwaY+jl5j+ui6Zwv0N
         /aLvv0inknwwWMny2CtfQ5vFQpYKmmZO2ajyMMXQc6KILxobjxU/f1txMUlOkz1taM
         ovKtQvsn3owy/nyK77tW1QfPrGn60fMlQwxOl+sUuGoz3HBwOxAqtVr4kr4QkPPDg5
         TVxwDcSn3K5lA==
Date:   Mon, 4 Jul 2022 17:24:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        patches@opensource.cirrus.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ASoC: madera: Replace kernel.h with the necessary
 inclusions
Message-ID: <YsMUPXoy4LrW1IHj@sirena.org.uk>
References: <20220603170707.48728-1-andriy.shevchenko@linux.intel.com>
 <1b5ba014-44ca-e753-141a-d8ff5fd248bb@opensource.cirrus.com>
 <YsG3kKwmoqF2MxU2@smile.fi.intel.com>
 <YsLCwQM0gbhFhSke@sirena.org.uk>
 <CAHp75VeCTEE4-O1LLYNunf_ZU164i8rnqeRf9dvp=R=_eEC=ig@mail.gmail.com>
 <YsMIzz6JkTLw7heY@sirena.org.uk>
 <CAHp75VfkOndCsu9S3M-ftKAtVntsPkRKUuaOo2xOa2w5c3xZkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CxxRMsZICbib0xwR"
Content-Disposition: inline
In-Reply-To: <CAHp75VfkOndCsu9S3M-ftKAtVntsPkRKUuaOo2xOa2w5c3xZkg@mail.gmail.com>
X-Cookie: MERYL STREEP is my obstetrician!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CxxRMsZICbib0xwR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 04, 2022 at 05:51:44PM +0200, Andy Shevchenko wrote:

> I found that there are files that are related to the sound/soc/* one
> way or another, but listed only in a certain record of MAINTAINERS
> without being listed as part of ASoC record. Does it mean I have to
> always remember to add ASoC maintainers to each patch that touches one
> of such files and doesn't provide them? OR do we need to fix
> MAINTAINERS for such files by listing them in the ASoC record?

Presumably one of those two will be required, yes.

--CxxRMsZICbib0xwR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLDFDwACgkQJNaLcl1U
h9DSVAf/S3iXNGaYbDWtAqUgnKnomBWTIuS4NYgbEUukfyEBUlfmidchhYVk/2rV
iFqF9gtVHB3+f+hAZnQuQdo0AJJmv7Ww1ysdbuXJx7G54el199rLMOdQynjK9ylJ
XcYtDkZ/8tpK0zEwRdunGQxgBFIw7yUTOK8prA0wkw+dF0VolTZGlKoZIwtOZu3f
+3LgwhLrB9utQIo4xidl/hnaElC+v9xxL2qxmz5HAz1aemQRyCshhnJ1UCn+sH+S
BBS/KKHm8NUtex6i+LS/G+JL6h3BZvMld/qfD9bUjxtvb9Fybw/rcAf9sf+HyrRK
KP03PMHKUEIbjD8LyFFnAvQswssNXg==
=KWbX
-----END PGP SIGNATURE-----

--CxxRMsZICbib0xwR--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC3E58F023
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiHJQLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbiHJQKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:10:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E3367CBB;
        Wed, 10 Aug 2022 09:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EA1A611D0;
        Wed, 10 Aug 2022 16:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2CFC433B5;
        Wed, 10 Aug 2022 16:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660147820;
        bh=QTQpyH18zwzbYkh2/bVnVVxQxt/jCGHQ7waGnCuPTY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iS2jpbq12KbFuPQqfi8BvF272M+SGoG8VIl+h/5inlSO7fcu22uH/kVebSIyFwS55
         cIBNwSg5+g+ReIVxHgBRI6u2RIUDTwjykyg9sd7ulYOKNk/ghgm02tH1wOngrKEbkb
         VE/cqiV6v8ezV3y4LPj8HxKtP/ySY9WtpqE+3/S3A411Tuy1cmlnHDLExT0sPSZN1O
         vYc9HClcOFXGAXWJeYI6xjTeFZ0Y+/bBYPuLsUimgsotPjB80Jm3CNcZgAqjf/I+rH
         8eGpPvJXWsKg9cT8rNO3tcJNHobDAdqqxRajNv3hVQgY5c6wXm3TVItHj0HHpPdfjm
         P3PYFeUKvXsDg==
Date:   Wed, 10 Aug 2022 17:10:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Da Xue <da@libre.computer>
Subject: Re: [PATCH] spi: meson-spicc: save pow2 datarate between messages
Message-ID: <YvPYZ/0o/Xa+vDKa@sirena.org.uk>
References: <20220809152019.461741-1-narmstrong@baylibre.com>
 <YvJ84qkuXdvVgXRm@sirena.org.uk>
 <39c2f53b-8f53-ceb1-ae0c-81e5e53d01aa@baylibre.com>
 <YvOmnDJA+ov49chC@sirena.org.uk>
 <518f22f4-1582-924c-9eaa-28ebbe53a632@baylibre.com>
 <YvPBX7zJ72RXnrpk@sirena.org.uk>
 <9dabe979-f6b5-329d-f017-a8f0c00adeca@baylibre.com>
 <YvPFZZ2HT2zK9XjQ@sirena.org.uk>
 <c7bfda2e-8135-fd2e-5d2b-5f547215bb18@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GD/R3KVKIHaGYn3m"
Content-Disposition: inline
In-Reply-To: <c7bfda2e-8135-fd2e-5d2b-5f547215bb18@baylibre.com>
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


--GD/R3KVKIHaGYn3m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 10, 2022 at 05:51:33PM +0200, Neil Armstrong wrote:
> On 10/08/2022 16:49, Mark Brown wrote:

> > I don't recall the code for clock providers being that hard?  They're
> > generally pretty small, some of the ASoC CODEC drivers did something
> > similar.

> Seems over-engineering to me, but I can explore this path if it's the best
> route to follow.

Please.

> > > had an open-coded function which perfectly worked before.

> > Except in the cases it didn't...

> It did but wasn't generic enough to take the new clock path introduced
> in the new SoCs.

Right, it's leaving landmines lying around - it's hard for me to be
confident that we couldn't also get another surprise due to a new test
case exercising the code differently somehow, never mind the fragility
of the code.

> > > I'm perfectly OK to remove the CCF driver for the legacy clock path
> > > and return back to the old open coded calculation since it perfectly
> > > worked and stop using the legacy clock path for new SoCs since it would
> > > never be selected anyway...

> > It does seem better to go the clock provider route TBH.

> I'm afraid this won't fix the problem since CCF won't set the clock again
> if the rate is already ok in it's cache, we'd still need to save the divider
> value and restore it after the reset as I did on this exact patch.

The goal here is to ensure that the clock framework's idea of what the
programmed configuration is and the SPI driver's idea of what that is
can't get out of sync - instead of saving the value by virtue of reading
it back out of the hardware at some specific point and hoping that
there's never any changes triggered by the clock framework between the
save and restore the driver is getting notified whenever there's a
change being made and can update the cache then.  That way we ensure
we can't miss any cases and things are robust.

--GD/R3KVKIHaGYn3m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLz2GYACgkQJNaLcl1U
h9BETgf6A4XinT60F61d/MHWSmN4hMrkGsjOwipHMdahU+IQyfLjeAQG6DS4MOB8
xmzwQ4p72BFI8WW3ttEvto1jiGZmYBDfWypFnMfxZh4BqMHfcz3KjJsuXH7yIotF
8D+fv1hMWS00JoEm9Vow2NJF76Hs5ElPIKwryFN9GejdOQZiFx8X/klsCke5oVG1
tY3IrNkZTz8m3X0xjspyoSQZvPMwyUnLILMyXxSaKTUyFgmhWnV8RGHvwRvzwEV4
WKboOjCQv4mtNNceitVoM3nhEI7NGzaZvKYQ0ETpG+sgkP/vUSRIxvCdU6pesVl6
uoy/LMriG0xzBwxB2IoExcZCCF1bZw==
=cIX0
-----END PGP SIGNATURE-----

--GD/R3KVKIHaGYn3m--

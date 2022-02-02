Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704324A717C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344309AbiBBNZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:25:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41616 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiBBNZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:25:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 364F0617B4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 13:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D83C340ED;
        Wed,  2 Feb 2022 13:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643808307;
        bh=jchafuS6+vgsXiYnWLpJZef5yK8Vi9yCKhPRLY9XIYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t+wbDdbrzp+LdeTHhq+CwqAEM19xFXWbBh+pnpwJ5F2hTXAlGxlv//iRG+s21sMvn
         zCKcoYOXoIghmr9Lsmrm19alsdMs0oqf7H5AEkwhnszjPq31nNkaHch8WaSCQe4Cwg
         9aiNNvaJ4xDZ38DFNjCAvUNsSECRSDuXrdHC9DWplPnFted5A6kLIt+k9II6Ne81is
         L7urJ4VRUQLd9XdGUIwuRPP6/4V8SxIVPJ9gSMPv1CZYhnr/faWszWRCjitZM5W90Q
         wsldzHWd/onsINGMfpmOlmanvJI0kM1n0lMV7AW90/JyoBpXj9QcWE+K0wuvoW8JWS
         LreF9gj10eSpw==
Date:   Wed, 2 Feb 2022 13:25:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Curtis Malainey <cujomalainey@google.com>
Cc:     V sujith kumar Reddy <vsujithkumar.reddy@amd.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        Vijendar.Mukunda@amd.com,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
        "Pandey, Ajit Kumar" <ajitkumar.pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd: acp: Set gpio_spkr_en to None for max speaker
 amplifer in machine driver
Message-ID: <YfqGLtmGBsD2WqtH@sirena.org.uk>
References: <20220131203225.1418648-1-vsujithkumar.reddy@amd.com>
 <YfmCWuD88sT8YxfG@sirena.org.uk>
 <CAOReqxiGW+8BR5VRVHDJuBXxkpB_oQ_4TTNBqm1tuK6shUKLpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OYVC+pEbH0ukOWFY"
Content-Disposition: inline
In-Reply-To: <CAOReqxiGW+8BR5VRVHDJuBXxkpB_oQ_4TTNBqm1tuK6shUKLpg@mail.gmail.com>
X-Cookie: Quack!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OYVC+pEbH0ukOWFY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 01, 2022 at 01:43:38PM -0800, Curtis Malainey wrote:

> Yes that is correct, this is the quick fix that will alleviate the
> gpio contention issue. But I think there is a better solution here.
> According to the sheet I have, the pin for the alc1019 is the same as
> the max98357a and its a shutdown pin for the amp.

OK, that sounds like it should be added to the driver then.

--OYVC+pEbH0ukOWFY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH6hi0ACgkQJNaLcl1U
h9BM6wf/bydWhYb/gkHNtrvSQ/dJxc7Gf7XsY0PY63Xddav43XnO7jtGQHNgIusX
TGAwX/Nv1vdJO3clfk/cwBTy8mXL77lEBiEY+uauRpbD7N215EDFKBO/oYOoMmGB
8G/TGXoxF6FVirgzW2MhYh8Kg3biGxV2xQ5B+oBKW1QvCYp8cvP026GjuegtWJSa
WbvAo3nan6hAo8M3JoYl0/UiUQT22Lt+c/JBhrqKtTVsWiQ9m96W+5uU1qyt3B4E
5NNXyzFvpRh2k0AonStGPzaefdVSRAArEUNKq0wZO0OzWJJ5xUF1Ru19m8CSvygz
jebBoykr+hBTV4pb9Qlv27O7vxYiag==
=18y7
-----END PGP SIGNATURE-----

--OYVC+pEbH0ukOWFY--

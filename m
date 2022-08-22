Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5DE59C3C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbiHVQKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbiHVQKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:10:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6AC31EED
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69A8760DF3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F115C433C1;
        Mon, 22 Aug 2022 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661184646;
        bh=gCwhkp8J3xaZGPaqVMWBuR/OwEF4x6qUJE6qmrENXoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KA+jLmi0nplH//vaycJ8J3O8N5Sjiv6P1hDWJjIT+uOGDTmC87PSOU/OPr2KvAVTW
         8/ersCZW7VCT6dZch2V1RrGZUubBY7boyWmqCzy2duR4FcFqPDCFbCnseGtp8VxIu7
         kK5vIzZDyv2hWW0AEMKktnU0U274pFL3cGd+ZgnhNc7Ck1Vl/QX8lDCuVKP8sN1Fjo
         6NH9Xfgs7w7xdGBO3JpUfQwkb7zgHsKsHffaEthsyFU01yiO4Fdm8/p5MBSMHFSXQW
         kMyFrAPwafb0InFNZ+bN7MccWt92gsqu1PtYeptN5dQI3EVDUqzszUxy77IO6D3KOp
         dLRhqkr7wXIpA==
Date:   Mon, 22 Aug 2022 17:10:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: dapm: Export new 'graph.dot' file in debugfs
Message-ID: <YwOqgSrs6YC6yPm6@sirena.org.uk>
References: <20220822095242.3779-1-povik+lin@cutebit.org>
 <YwN2Pd4Ez08yDFno@sirena.org.uk>
 <3234D74E-0DFF-4BB5-87ED-6135BAC1F31D@cutebit.org>
 <YwN+0yHSOSC2aD+J@sirena.org.uk>
 <6EDC1D4B-4B84-49A2-A60A-EA15D27251A7@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5yPmWPqk0dnkKzey"
Content-Disposition: inline
In-Reply-To: <6EDC1D4B-4B84-49A2-A60A-EA15D27251A7@cutebit.org>
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


--5yPmWPqk0dnkKzey
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2022 at 03:11:48PM +0200, Martin Povi=C5=A1er wrote:
> > On 22. 8. 2022, at 15:04, Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Aug 22, 2022 at 02:38:09PM +0200, Martin Povi=C5=A1er wrote:

> >> simply having a =E2=80=98graph.dot=E2=80=99 at hand, especially since =
it requires
> >> little code. (Although sure there=E2=80=99s the danger of it growing.)

> > I'm also worried about people going in and wanting other more tool
> > specific formats adding, if we didn't have anything at all it'd be one
> > thing but we do have something.

> Sure, although I would argue DOT is by a large margin the standard
> format to represent graphs in.

Well, the debugfs stuff there is more a general tool for introspecting
the current DAPM state than it is indended to draw a pretty picture.
When I wrote it the scale of the devices I was working with was such
that I'm not usre a full graph would've been terribly useful, and
there's even larger devices since then (though also a lot of systems
like yours which do use very much smaller devices).

--5yPmWPqk0dnkKzey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMDqoEACgkQJNaLcl1U
h9D9VAf+MnEV02nZUZwb9irIJfZY639DB1FaV+ttrHkW88nPvWzx6hoWWjjtJWwY
AacOlqdh12ZlKYkCWyUkWODvfcaY+/OZmEFX5o8QTCsaScpWIDFcp4FugRb5vkUc
Q9XVmiTAuhlRrmbH27mZaRU9NGygI9gx2uuAbbL6IFg2+EV8G4amfgbptVVhfBQo
nOhlsC1oVIN3W4Tsedb8W4IWzWokGBxtXyyNZNeSH7mY2e3A0Y0Xz7UhOofmzhfi
hyVMHxT3qUVYr7t9EHpuXoX5lPZPbGH3c7rqMBHaWgQSh1Z9pbx7qIoMkIFUn+M0
ah2+kGm3Lybw2GO+SOtB0qHIs2JNFw==
=FQWw
-----END PGP SIGNATURE-----

--5yPmWPqk0dnkKzey--

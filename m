Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2515052839D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbiEPL6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiEPL6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:58:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FAF13E1D
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 04:58:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35051B80B55
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB4FC34115;
        Mon, 16 May 2022 11:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652702283;
        bh=rfFycng6c5zxV0M2PP3i/7r8VQ/4NpWOHpLX5DwKyP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GuRqau51YuaNMtj9tI9QqGAAIbziDVelJigO4PgSydjpeXjmvGhH4Vq7hCfbpQFLx
         bSQKQfau6yS4R2l6tFNaDB5NQJkrzWRUa7SO9lmHAyhxnBDAxF50GMqfrCTEuLwU2v
         qccqnnmhGkcCiXG6hjPVaOc6fuVYdGk7ssECew3JehrAcCPUlq3HRdNvQ+wwRm7FwY
         tfMsmlUfLG+wceSbVzSTwGUl9Wtqz7QkA0MFh/MxvFzjPJOkyCSKHohBkPDUXIOnnk
         lBFYlwSyHsSJJSirf5FjlZni3XtqmyJihGX3eWix6hfAZMQvwfLZ2rFtnBFNfM4H78
         NhESCBisbTd4A==
Date:   Mon, 16 May 2022 12:57:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linux-amarula@amarulasolutions.com, linuxfancy@googlegroups.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: max98088: add support for reg_4a_cfg_bypass reg
Message-ID: <YoI8RJc17naBOlaO@sirena.org.uk>
References: <20220512074359.446999-1-tommaso.merciai@amarulasolutions.com>
 <YnzdcubW7m+CwnvN@sirena.org.uk>
 <20220512104642.GD649073@tom-ThinkPad-T14s-Gen-2i>
 <YnznExLDOvRpXNVh@sirena.org.uk>
 <20220512110959.GF649073@tom-ThinkPad-T14s-Gen-2i>
 <YnztJxdSFau6SYC5@sirena.org.uk>
 <20220513152055.GI649073@tom-ThinkPad-T14s-Gen-2i>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ceUhA335UWeXMnkR"
Content-Disposition: inline
In-Reply-To: <20220513152055.GI649073@tom-ThinkPad-T14s-Gen-2i>
X-Cookie: May be too intense for some viewers.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ceUhA335UWeXMnkR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 13, 2022 at 05:20:55PM +0200, Tommaso Merciai wrote:
> On Thu, May 12, 2022 at 12:19:03PM +0100, Mark Brown wrote:

> > That sounds exactly like a DAPM control, please make them DAPM controls.

> Sorry again, but I'm quite new on alsa subsystem. I need an help on figur=
ing out
> on how to implements your solution. From what you suggest I got that I ne=
ed to create
> a bypass mixer for every switch (4 -> SPK, REC, MIC2, INA):

It depends how the audio is routed - that would be a fairly unusual
structure for hardware but it's possible.  Often bypass paths feed into
mixers that have other, non-bypass paths.

> After that, I need to route the new control mixers on the switch:

>  {"Out Mixer SPK", "SPK Bypass Switch", "RECN"},
>  {"Out Mixer REC", "REC Bypass Switch", "RECP"},
>  {"Out Mixer MIC", "MIC2 Bypass Switch", "MIC1"},
>  {"Out Mixer INA", "INA Bypass Switch", "INA"},

> Then route the bypass switch to the new output:
>=20
>  {"SPKL", NULL, "SPK Bypass Switch"},
>  {"RECN", NULL, "REC Bypass Switch"},
>  {"MIC2", NULL, "MIC2 Bypass Switch"},
>  {"MIC1", NULL, "INA Bypass Switch"},

> I'm in the right way? What do you think about?

That's pretty much it if they're a bunch of separate things.

> Can you point me a similar bypass switch into the kernel to take as refer=
ence?

If you search for "Bypass" in sound/soc/codecs you'll see a bunch of
examples - a lot of the Wolfson devices have bypass paths for example.
You'll see that for example with wm9713 the bypass paths go into mixers
that have other inputs rather than being totally separate things - I see
that this device has things like "Right SPK Mixer" which look like they
might fit here.

--ceUhA335UWeXMnkR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKCPEMACgkQJNaLcl1U
h9Dw3wf+PoN0Y0CruSm0ULIA40MzPzZAb5sVvY5eRMdgy8F/P6oiUcXEm/CwkunJ
by9BfIUpZ4PQTXUcLH9jzp/fXmHimgPNTLDhZLyzylSj2YfoSNXB2COb/nPs1Lzg
NiewyyWMNdZ2/ojAyDwbJSY1FxXKtSKV8NyErnmA09asUBKg+dIOFr1IlDcb8Xoy
X+LugM2PG01eWLLJE9qbkVoAw12iREQok41v3/BQcqlS55S84jHiO/pbwjZZSQxQ
8z7mfl0dyClBF+nZUeTGooc6TsSjYCllwRczNBZrM265khn6oEYYj3aOw+ZP66nh
IHc6PlU+pbA7OHC+c8kZkYd3rD5Dyw==
=3p9m
-----END PGP SIGNATURE-----

--ceUhA335UWeXMnkR--

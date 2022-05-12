Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0489524A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352475AbiELKMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352382AbiELKMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:12:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBDD63508
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:12:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21009B82701
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A62C385B8;
        Thu, 12 May 2022 10:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652350327;
        bh=Oey5BXGPbf1OugkOQQFP+E2qKsEx1HsDDiLcia9Q0nQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CA554f/a0F6olDd5UTIsirFcM+zB4aDqr5WhbIvwyyXkhDo/cP78AtprtqRVcB6SE
         t8nV4m7RGgGWftGkF68aDKcbMf5U/OZc5CNeVrEk9Z3o54apQCf174PtjBWlgXcCiL
         bSq7MWVkthCDAb8M3WaF5NHejiC1jI+HBi4nCTGXJt3yndCr75vh20YZS8jOznoZLX
         DaSxGg7VBWrJ5ANPRN8L62JZ3ZnGZ0oGXLOVF1H0JmSLzknEtPAgRskKVAI2jvMFtj
         d6h/AbatCH6+SGyMzGXnMLvXQZco74bNhdsPrCcFex72baicEk+xGqD84Jq3Ad7lkt
         8mQ5TQC7dpVrQ==
Date:   Thu, 12 May 2022 11:12:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linux-amarula@amarulasolutions.com, linuxfancy@googlegroups.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: max98088: add support for reg_4a_cfg_bypass reg
Message-ID: <YnzdcubW7m+CwnvN@sirena.org.uk>
References: <20220512074359.446999-1-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Rk/8LQJNy9MPTC4G"
Content-Disposition: inline
In-Reply-To: <20220512074359.446999-1-tommaso.merciai@amarulasolutions.com>
X-Cookie: Oh, wow!  Look at the moon!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Rk/8LQJNy9MPTC4G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 12, 2022 at 09:43:58AM +0200, Tommaso Merciai wrote:

> Add mixer controls support for M98088_REG_4A_CFG_BYPASS register

> +++ b/sound/soc/codecs/max98088.c
> @@ -486,6 +486,11 @@ static const struct snd_kcontrol_new max98088_snd_co=
ntrols[] =3D {
>         SOC_SINGLE("EQ1 Switch", M98088_REG_49_CFG_LEVEL, 0, 1, 0),
>         SOC_SINGLE("EQ2 Switch", M98088_REG_49_CFG_LEVEL, 1, 1, 0),
> =20
> +       SOC_SINGLE("SPK Bypass Switch", M98088_REG_4A_CFG_BYPASS, 0, 1, 0=
),
> +       SOC_SINGLE("REC Bypass Switch", M98088_REG_4A_CFG_BYPASS, 1, 1, 0=
),
> +       SOC_SINGLE("MIC2 Bypass Switch", M98088_REG_4A_CFG_BYPASS, 4, 1, =
0),
> +       SOC_SINGLE("INA Bypass Switch", M98088_REG_4A_CFG_BYPASS, 7, 1, 0=
),

These look like they should be DAPM controls since they're controlling
audio routing but they're being added as regular controls.

--Rk/8LQJNy9MPTC4G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ83XEACgkQJNaLcl1U
h9B8ngf+PqafSiaHQZbAhE4xWyxrNCZE8LZdLVxT4EoKR0laiFWL/7SXyI7tdfRl
KK9c0GvCubb9MbNPl3lhFmsPutwnNGpfZmG9JQt3DNcPuyyubB9AJAxq2QUQkIPr
buGHa5C3sFvBgWK7s/tkbSiZRvAYDCYlNZULXD27e8l02qUUK/H5QH9ZB+6EM+j5
n/y4IGIU8FfioDS52UQE11f/lEaRG/arItQ8QYbdBEKOInA+Vm3eCu54j+nLknjr
zBnkr+920iw3UdzBNIasCDnzF2oW5W5tMGWvZEDT8QuQnwGDVuRvkajAylFn+PkE
BbRJ2CENvy9DMpzy5+Wg4RJVTUTuuA==
=emk8
-----END PGP SIGNATURE-----

--Rk/8LQJNy9MPTC4G--

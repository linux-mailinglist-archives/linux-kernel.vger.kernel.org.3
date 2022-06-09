Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53733544DC6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243948AbiFINeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239509AbiFINdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:33:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8007451E58;
        Thu,  9 Jun 2022 06:33:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0355661D3E;
        Thu,  9 Jun 2022 13:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A641BC34114;
        Thu,  9 Jun 2022 13:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654781630;
        bh=By/LmjmkZstbquCKqvZQy6ApS9VkUQsifOo+GuV6Dko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jBjS/rOwm0hXNM3I8qiEPO7/IWTr1BS4RG6x9wN9iGRDrDP9gF+wZT1lEBA/ZPR3E
         /IznIWKF1BjwRBQm+yZjYzHz4pWUj8mScY/u/lV2NkIej/gw6RywABIeNCvJs9IdK4
         th2rkhqsJp/PKLG3zb1z9m9UeN6qRprBs562Aj/2KeDD+OeNMciH67M6F5pVx6scZ0
         ZcH7msHNtn5u64cIA6FePjvBIyLF4Ix87m6SMxaXkGNAhALWn6ZXdcMSUKX09U5OZ7
         bEByuQ0LUh4bmqVP9WuIiZTTSWrp0ZzdcUuzDTDkfYjNAEF0IfjvbysQQuF/vGSYMc
         rGQAi9DvNHL8g==
Date:   Thu, 9 Jun 2022 14:33:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev
Subject: Re: [RFC PATCH v2 5/5] ASoC: apple: Add macaudio machine driver
Message-ID: <YqH2uCgaedf0HQPE@sirena.org.uk>
References: <20220606191910.16580-1-povik+lin@cutebit.org>
 <20220606191910.16580-6-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Yt9911NapMtJ1eUK"
Content-Disposition: inline
In-Reply-To: <20220606191910.16580-6-povik+lin@cutebit.org>
X-Cookie: Space is limited.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Yt9911NapMtJ1eUK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2022 at 09:19:10PM +0200, Martin Povi=C5=A1er wrote:

> +		/*
> +		 * Primary FE
> +		 *
> +		 * The mclk/fs ratio at 64 for the primary frontend is important
> +		 * to ensure that the headphones codec's idea of left and right
> +		 * in a stereo stream over I2S fits in nicely with everyone else's.
> +		 * (This is until the headphones codec's driver supports
> +		 * set_tdm_slot.)
> +		 *
> +		 * The low mclk/fs ratio precludes transmitting more than two
> +		 * channels over I2S, but that's okay since there is the secondary
> +		 * FE for speaker arrays anyway.
> +		 */
> +		.mclk_fs =3D 64,
> +	},

This seems weird - it looks like it's confusing MCLK and the bit clock
for the audio bus.  These are two different clocks.  Note that it's very
common for devices to require a higher MCLK/fs ratio to deliver the best
audio performance, 256fs is standard.

> +	{
> +		/*
> +		 * Secondary FE
> +		 *
> +		 * Here we want frames plenty long to be able to drive all
> +		 * those fancy speaker arrays.
> +		 */
> +		.mclk_fs =3D 256,
> +	}

Same thing here - this is at least confusing MCLK and the bit clock.

> +static bool macaudio_match_kctl_name(const char *pattern, const char *na=
me)
> +{
> +	if (pattern[0] =3D=3D '*') {
> +		int namelen, patternlen;
> +
> +		pattern++;
> +		if (pattern[0] =3D=3D ' ')
> +			pattern++;
> +
> +		namelen =3D strlen(name);
> +		patternlen =3D strlen(pattern);
> +
> +		if (namelen > patternlen)
> +			name +=3D (namelen - patternlen);
> +	}
> +
> +	return !strcmp(name, pattern);
> +}
> +
> +static int macaudio_limit_volume(struct snd_soc_card *card,
> +				 const char *pattern, int max)
> +{
> +	struct snd_kcontrol *kctl;
> +	struct soc_mixer_control *mc;
> +	int found =3D 0;
> +
> +	list_for_each_entry(kctl, &card->snd_card->controls, list) {
> +		if (!macaudio_match_kctl_name(pattern, kctl->id.name))
> +			continue;
> +
> +		found++;
> +		dev_dbg(card->dev, "limiting volume on '%s'\n", kctl->id.name);
> +
> +		/*
> +		 * TODO: This doesn't decrease the volume if it's already
> +		 * above the limit!
> +		 */
> +		mc =3D (struct soc_mixer_control *)kctl->private_value;
> +		if (max <=3D mc->max)
> +			mc->platform_max =3D max;
> +
> +	}
> +
> +	return found;
> +}

This shouldn't be open coded in a driver, please factor it out into the
core so we've got an API for "set limit X on control Y" then call that.

--Yt9911NapMtJ1eUK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKh9rcACgkQJNaLcl1U
h9Be8Qf/cbx1SuNmXunfKG1D6mfqR8Q1iocw25ztL4MzTR16bJ8oAGIVuIFGvp6F
65sLYF0riHrCUz1DZvyFCKmcDB+GeSWR9BICYOSnaQg6DnBXQdaBl3uY7v9DRrA6
ypLzKzTdy5LhR58xRaThyGAiep77ZxpxGmOmPyMZS+oq+NQ4idOE/5z5ENxRSg3n
qjMDlWlotFv3MjVNNBBFmZsH1oWa2CuxnXjpM/JrOAhEk7rt7Ylx4I3Bhqpv+lgo
++g3qBUAP1cMdsyYOJza5Jkh4WynmGe3dQ7zj68UbdWoGtvHV8x6SucSnSeVrWXM
IzZswmQla/NHnxdszylvTnONJmU8kg==
=K4AF
-----END PGP SIGNATURE-----

--Yt9911NapMtJ1eUK--

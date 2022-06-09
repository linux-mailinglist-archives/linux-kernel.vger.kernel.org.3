Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67FB544D48
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244111AbiFINQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbiFINQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:16:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00973BB299;
        Thu,  9 Jun 2022 06:16:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E6EA61CE3;
        Thu,  9 Jun 2022 13:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F2FC34114;
        Thu,  9 Jun 2022 13:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654780570;
        bh=adIY73cUSCNwOEj4s+9TfwrvjgCT5vabHNIojXe/1uY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WYPI/dFW/4u4zTXC/IoaW+gqiph/U3f8dUrIV74OlJs0SAnkbFcVND+snhWDy+MYh
         6ioLbFofSxMV7wfxsQubzFcp7eTHg3LR3D+RM3LC975VPbwms9sD1u0fzMbkuK+7aZ
         Hq6J0DhKtzTC3IsvGKX9eswrN40xD110OJDrNfNDsCNKB94cTJL53JgZBEcnqbkddT
         lLTbP/uNM2VCh5PIs/E4J25prK2pS1ggzPizFluCG2fNfVAlxsCvzIncZN5RMqgVXo
         sxWPPRxk2eVKbDsvcyXmElZHZvHsWOE8mcZOC/F3x32x/sWUjeGTGdnynKF84hiXFL
         9k55FZrg5hBdg==
Date:   Thu, 9 Jun 2022 14:16:04 +0100
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
Message-ID: <YqHylN3xba9XFrF8@sirena.org.uk>
References: <20220606191910.16580-1-povik+lin@cutebit.org>
 <20220606191910.16580-6-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zP4ArPesiXfS095U"
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


--zP4ArPesiXfS095U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2022 at 09:19:10PM +0200, Martin Povi=C5=A1er wrote:

> + *  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90       =E2=94=8C=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BA =E2=94=8C=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90     =E2=94=8C=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=90
> + *  =E2=94=82 Primary  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=A4                 =E2=94=82 Mux =E2=94=82 =
=E2=94=80=E2=94=80=E2=96=BA =E2=94=82 Speakers =E2=94=82
> + *  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98       =E2=94=82    =E2=94=8C=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=96=BA =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=98     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
> + *                =E2=94=8C=E2=94=80=E2=94=80=E2=94=80 =E2=94=82 =E2=94=
=80=E2=94=80=E2=94=80=E2=94=98             =E2=96=B2
> + *  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90  =E2=94=82    =E2=94=82         =
         =E2=94=82
> + *  =E2=94=82Secondary =E2=94=9C=E2=94=80=E2=94=80=E2=94=98    =E2=94=82=
     =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=90
> + *  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98       =E2=94=9C=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=96=BA=E2=94=82Plug-in Demux=E2=94=82
> + *                     =E2=94=82     =E2=94=94=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=AC=E2=94=98
> + *                     =E2=94=82                  =E2=94=82
> + *                     =E2=94=82                  =E2=96=BC
> + *                     =E2=94=82                 =E2=94=8C=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90     =E2=94=8C=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=90
> + *                     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=96=BA =E2=94=82 Mux =E2=94=82 =E2=94=80=E2=94=80=
=E2=96=BA =E2=94=82Headphones=E2=94=82
> + *                                       =E2=94=94=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=98     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98

As far as I can tell this demux is entirely software based - why not
just expose the routing control to userspace and let it handle
switching (which I suspect may be more featureful than what's
implemented here)?

> +static int macaudio_jack_event(struct notifier_block *nb, unsigned long =
event,
> +                               void *data)
> +{
> +       struct snd_soc_jack *jack =3D data;
> +       struct macaudio_snd_data *ma =3D snd_soc_card_get_drvdata(jack->c=
ard);
> +
> +       ma->jack_plugin_state =3D !!event;
> +
> +       if (!ma->plugin_demux_kcontrol)
> +               return 0;
> +
> +       snd_soc_dapm_mux_update_power(&ma->card.dapm, ma->plugin_demux_kc=
ontrol,
> +                                     ma->jack_plugin_state,
> +                                     (struct soc_enum *) &macaudio_plugi=
n_demux_enum, NULL);
> +
> +       return 0;
> +}

This should be integrated with the core jack detection stuff in
soc-jack.c and/or the core stuff that's wrapping - that way you'll
ensure that events are generated and status readable via all the
interfaces userspace might be looking for.  The ASoC stuff also has some
DAPM integration for turning on/off outputs which might DTRT for you if
you do need it in kernel.

--zP4ArPesiXfS095U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKh8pQACgkQJNaLcl1U
h9A35AgAhc/b4LJ2GElO9+hrXTNIF0hkl2AmactD2FfUXkE/CAfoLDtaK/5RtjeR
4ybKT5miFOnvG5bzMVTQV8BtLKiT9AI3ABDsuj2QMvaTZ95Y3tgqZh738EQAYB5l
Qrie4m9HHqjp1dLdqvNcgVTg1QWzIddKaMB7bI0FHITUZVqgcq5qZiAtAZ3GGBeP
ZIdkYMVLhyEIUpjXpYOlHjgxo2wKs+ixIyN9BonMvX6aSOLNXmI/vuqVPYp8uuvn
u+WXjidw0QlG2gU2kgnncbugvKNMKm4YcCd+CcQ7q4wrwQbH12DT7uD0X2m1/kVE
py9WhKEDlJiKgkRkR7GjmWGf2OmarA==
=P1Mm
-----END PGP SIGNATURE-----

--zP4ArPesiXfS095U--

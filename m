Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BA64ED9F5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbiCaM6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236475AbiCaM6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:58:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01402128D9;
        Thu, 31 Mar 2022 05:56:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1CE1617C0;
        Thu, 31 Mar 2022 12:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84ED6C340F2;
        Thu, 31 Mar 2022 12:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648731372;
        bh=DfI4w1o+FCYxsAC0rPn+xFaT1PUgndy6Pzulupfti64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k/1uDpG0COuH/xMycH1jXEnaAzYEpDjT5p7kU8rL4PHWzMMQXC+b+2cYoSf0m2F12
         qxbJx8hW/8ikoGtSzP79VFsft4uHhbHea2hb00KmUMLsNcb/lBaBICgpkEhL1kfrRR
         FhCaLlT9xc5IhKlKDyMom56/wnaMhWeIgHSM72t9LH7QgBaWFcjznoWhPtebcvDsGz
         R1qbHGThUeONUvt2Ahw6SsUmSNlNGcl4G4rEcY8ubwIecE37Y8mMekI9I/iwHiK226
         ueWktgb253XuGKtf35tC2WuDIaiSIUvtbZj123P2me2Gpmf7oaNVeKDksy+TMEQyWt
         z8+yBENsT3S1A==
Date:   Thu, 31 Mar 2022 13:56:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik@cutebit.org>
Cc:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>
Subject: Re: [RFC PATCH 5/5] ASoC: Add macaudio machine driver
Message-ID: <YkWk5vvBlC/Orpdr@sirena.org.uk>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <20220331000449.41062-6-povik+lin@cutebit.org>
 <YkWXs/f7edZwg1+W@sirena.org.uk>
 <4651D426-BA1A-418F-90E5-278C705DA984@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2p1SKEdgaX+tzFpw"
Content-Disposition: inline
In-Reply-To: <4651D426-BA1A-418F-90E5-278C705DA984@cutebit.org>
X-Cookie: Reunite Gondwondaland!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2p1SKEdgaX+tzFpw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 31, 2022 at 02:08:51PM +0200, Martin Povi=C5=A1er wrote:
> > On 31. 3. 2022, at 13:59, Mark Brown <broonie@kernel.org> wrote:

> >> +	for_each_rtd_components(rtd, i, component)
> >> +		snd_soc_component_set_jack(component, &ma->jack, NULL);

> > What is the jack configuration this is attempting to describe?  It looks
> > like you have some dedicated speaker driver devices which are going to
> > get attached to jacks here for example.

> We know the speakers will ignore the set_jack call. There=E2=80=99s one j=
ack and
> this way we know the jack codec will attach to it, for speakers it=E2=80=
=99s a no-op.
> (If you prefer I will special-case it to the jack codec.)

It would be better to special case, this looks obviously wrong and will
break if someone adds error handling.

> >> +	return !strcmp(name, pattern);
> >> +}

> > This looks worryingly like use case configuration.

> I go over this in the cover letter! This is fixing the TDM slot selection
> and disabling voltage/current sensing on the speaker amp codecs, which ha=
ve
> no business being exposed to userspace as options. This is not use case,
> this not letting people blow their speakers from userspace.

Your comments in the cover letter are all pretty vague too, that just
says that these controls are "ridiculous" which isn't terribly specific
about what the actual goal is.  If it's just "I can't see why anyone
would want to configure this" then that's a decision you're taking about
what people might want to do which is broadly a use case configuration
and the control should be left there in case someone comes up with an
idea.

--2p1SKEdgaX+tzFpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJFpOUACgkQJNaLcl1U
h9CYzQf/Y08TIa0AXiiPTKniPzL9m3d7ArsJSmeKBxGOiqTtZ7kzWb4ElKSSGfRR
SQBABq69Qoxq9aWhUfdocdGNf3I/MtDc8k0XUs4bO3MQgKJ0WIivkGNpRPield9D
tbiVirXSxTSN28zrzJHzZZti6MVAFNCRjlrF+qOhAH2K6qKQNwcFwOYSFEjQaGLp
noni9E2T7cwSkwem3gxTP6FDHdT2ivx3fwBArNpZ3WqWwK+3cBrlSD+pMYoPdWVD
PMv8/IfgYHYm+ojMI6ILkAic1KojFLwM1stvNfFtR7fOO8QJEeSfPhKg18zLwvHj
N1ZH9xNFrO4kKrMnwL7uEZAtBTHoGQ==
=khz2
-----END PGP SIGNATURE-----

--2p1SKEdgaX+tzFpw--

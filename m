Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3664EDB90
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbiCaOU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiCaOUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:20:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A620205C4;
        Thu, 31 Mar 2022 07:18:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2FCAB82118;
        Thu, 31 Mar 2022 14:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED4DC340ED;
        Thu, 31 Mar 2022 14:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648736311;
        bh=esnRoKwPaWXl+mUZ11prb3bCZgCH28Gl04pKeuJeJMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OuVRxthYGIVQh8Qd+oZBXVLCkWmukm9g7G48c22SH+zMZmK4CgOQQ1QZLOFyGirn7
         z5f8/KNpTNPt9XS1P+DZejUoEXH0pKG1wBg5AAFkj4H0hb9vhiy0k4fwWvH+5RxtXQ
         NR+OtOYjGIyCmjIaSRoGB7gqRJXB8lf0PBGV0XxXY/+tPbC9eR+0VfDFyYBwh5Gscj
         c1MXWPz0s3lV9X3gCvggzHJsZzumQlHX+awirVZ2MVFEcC5oP64r60gHNprKrI7gVa
         hf02crrQRIR711tL5eEOYt4qr0m2j0Tbgo6CR2ggL9M+LXDKKO+n9TxxeGfSoPktKD
         urORRDAKvxMbA==
Date:   Thu, 31 Mar 2022 15:18:24 +0100
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
Subject: Re: [RFC PATCH 0/5] Apple Macs machine-level ASoC driver
Message-ID: <YkW4MPh8VWc8eSGg@sirena.org.uk>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <YkWfziQzprEsWL72@sirena.org.uk>
 <CCE4A06E-6D6F-457D-B3C5-C36209BF38D3@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zQ72vPhT+YMlpKH0"
Content-Disposition: inline
In-Reply-To: <CCE4A06E-6D6F-457D-B3C5-C36209BF38D3@cutebit.org>
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


--zQ72vPhT+YMlpKH0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 31, 2022 at 03:28:12PM +0200, Martin Povi=C5=A1er wrote:
> > On 31. 3. 2022, at 14:34, Mark Brown <broonie@kernel.org> wrote:

> > The broad issue here is that what you consider ridiculous someone else
> > might have some bright ideas for configuring dynamically - if things are
> > being exposed for dynamic configuration it's probably because someone
> > wanted them, if the control is genuinely useless then it should just be

> Well but these are codec drivers reused on different systems, it can both
> be 'not genuinely useless=E2=80=99 on some system and ridiculous to leave=
 open on
> the systems I am trying to write drivers for.

It wouldn't be the first time that we've had someone turn up with a new
idea for how to configure an already existing bit of hardware, part of
the reason for this approach is that people do get surprised by user
creativity with their systems.

> > The TDM swap thing you're mentioning looks like it's a left/right
> > selection which people do use sometimes as a way of doing mono mixes and
> > reorientation.  The ISENSE/VSENSE is less obvious, though it's possible
> > there's issues with not having enough slots on a heavily used TDM bus or
> > sometimes disabling the speaker protection processing for whatever
> > reason.

> Not only that. On TAS2770 the default value for =E2=80=98ASI1 Sel=E2=80=
=99 is =E2=80=98I2C offset=E2=80=99
> meaning the speaker amp driver ignores my set_tdm_slot calls. If you tell
> me it=E2=80=99s okay to change that behaviour and it won=E2=80=99t be con=
sidered backwards
> compatibility breaking, that would be part of the solution I am seeking
> here.

Having the default state be muted or not routed is quite common, UCM
files or equivalent are typically required for embedded style hardware
like this.

> But even then, what for example if the system has a single speaker (as it
> does on the Mac mini to be covered by this driver) and the I2S bus is left
> undriven for the duration of unused TDM slots? That may genuinely pose
> a risk of people blowing their speakers by switching something in alsamix=
er.

Right, so that's a more sensible and valid use case.  We do have the
platform_max feature available for precisely this reason - that's
probably more appropriate here since if there's a danger of people
blowing their speaker with a floating input they could also blow their
speaker with just a very loud audio signal so limiting the volume people
can set on the speaker driver seems sensible and would also cover them
for misrouting.  Whatever the device might pick up from noise on an
undriven bus could also be played as audio down the bus.  This does
become a little fun with speaker protection as we'd want to raise the
kernel limit so that userspace can dynamically manage the volume to
contorl power (though that might be done with software control), but
it's easy enoguh to raise limits later.

On the other hand it seems like userspace might reasonably choose to do
a mono mix for this output entirely in software, in which case telling
the speaker amp to pick up one channel would make sense, or to just play
out a stereo signal over I2S and have the amplifier do a mono mix and
I'm not seeing why we'd force one or the other in the machine driver.

> The ISENSE/VSENSE controls are also actually useless on these systems as =
we
> are not doing anything to pick up the measured values (which are sent back
> over the I2S lines). I don=E2=80=99t know if there can be driver conflict=
 between

Presumably someone might want to work on figuring that out though, and
=66rom a hardware safety point of view it would be better if they did.

> two speaker amps trying to drive the I2S lines at the same time should
> the user happen to enable SENSE facilities on more than one of them.
> Now I can grudgingly study that and rule it out but I would rather hide
> the controls altogether.

Yes, having two devices driving the bus at the same time wouldn't be
great.  How is the TDM slot selection for the signals done in the
hardware, I'm not seeing anything immediately obvious in the driver?
I'd have thought that things would be implemented such that you could
implement speaker protection on all speakers simultaneously but perhaps
not.

> That=E2=80=99s the reasoning anyway. To reiterate, seems to me the contro=
ls
> are useless/confusing at best and dangerous at worst.

I'm just not seeing an issue for the slot selection.

--zQ72vPhT+YMlpKH0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJFuDAACgkQJNaLcl1U
h9A9lwf/ddJhTaQ1UaqX3Bsb+GxAlui6cFVoONTfyUAR+vMtAaidhxfYhY8qmtt0
pkQSmWdb1l8QtQ5pz0SQdW/ZhFi7CfdvDHLGtDCZHAUxCBrya28XC3ebn72jeGgK
5vNs8vzfVvSpt7B7vseX89U1CvevM4iVkiu2paMQInPWGKjXAN/HtrELENEW20SE
FV3WAR7m1aNrPc7sZ0d5Nvyr0QQsdTvUeDG48ZlPxy1Ta1SV2zX5qx5os9kXQE6K
nTzwHh8cyH+t0kJASLEzsV28RBKGOUfCiNM8PSen/SfnsBAXEIeajIYeAGT7ZuJd
r82cdFoj4At/BFUt9A/IvZMhqO36dQ==
=YzFu
-----END PGP SIGNATURE-----

--zQ72vPhT+YMlpKH0--

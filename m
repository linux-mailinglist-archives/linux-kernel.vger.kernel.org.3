Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA35C50B7E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447717AbiDVNJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiDVNJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:09:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ACC22B3E;
        Fri, 22 Apr 2022 06:06:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E18A962067;
        Fri, 22 Apr 2022 13:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B50C385A4;
        Fri, 22 Apr 2022 13:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650632803;
        bh=hDIXGys28YU1AgFgBUhJKgfBRTj9j4CvWUnRGcwIekE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GDVYCD4SK6NLWfa+RGm24cWgtClaJixuJEYfnuky3gUNwzOfdD0CGXZO8Eu/sY+j1
         ZVC92Jrn8r2HESDlKi3bCxMxW5eKidgN/pXmpI2z2xOz1dU5cRx55slt3VyedgM2/A
         M+AL4OFN4MsUVYb53/Hp55PLCflOuaV4AylLzVKmgZQfWe58+xa8KNcHAGmegzsIOP
         +IWFHNFUMKBg79uVOZOznzEwT1+8z/vDxqgSAVLq6pAqw561qXm9LJd6gXsB/bFQLr
         LoZ8cI+qF5MpFp1om5KR9PnEJlffpw1x/NCG43Xz5qsd2L2vEw8IsPmnEDUhWb0pU+
         LZb3bg00ZPS4w==
Date:   Fri, 22 Apr 2022 14:06:37 +0100
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
Message-ID: <YmKoXbh04ZEs3dSZ@sirena.org.uk>
References: <YkXKmxJ0R3qpUoH4@sirena.org.uk>
 <DB0255C3-C9EC-4EFA-A377-C4BB1073D9B3@cutebit.org>
 <YmKPQ6kLCPz+2XTJ@sirena.org.uk>
 <B68302F2-3D77-4065-8A16-A9CC690AE10B@cutebit.org>
 <YmKSgHrbb/7koM36@sirena.org.uk>
 <A1574F30-62D2-467D-A40B-8FD7C6B8BCFA@cutebit.org>
 <YmKeEKa0w2xLM9cL@sirena.org.uk>
 <6F6130F3-381C-4AB7-B618-CDC4C4A37C9B@cutebit.org>
 <YmKjL9bOtOmsFWTs@sirena.org.uk>
 <3CD969AD-7316-4D83-AD92-CC85ED817125@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h//nqm2TleJK+t0c"
Content-Disposition: inline
In-Reply-To: <3CD969AD-7316-4D83-AD92-CC85ED817125@cutebit.org>
X-Cookie: Whoever dies with the most toys wins.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h//nqm2TleJK+t0c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2022 at 02:53:54PM +0200, Martin Povi=C5=A1er wrote:

> > Oh, I see - the speaker actually allows configuration of the slots
> > independently.  Usually the left/right thing on mono devices only does
> > something for I2S where the bus clocking enforces that there be both
> > left and right channels.  Either configuration is fine by me TBH, if you
> > can do that then you could just keep them mapped to the same channel
> > then mark the control as disabled since it should have no effect.

> Well but is there some established way to mark a control as disabled?

snd_ctl_activate_id().

> Another issue here is that if I disable it I can=E2=80=99t leave the rout=
ing
> control in it=E2=80=99s default value, which is =E2=80=98I2C Offset=E2=80=
=99 and makes the speaker
> amp ignore the slot mapping.

Sure, that's fine - if a control genuinely has no effect it's fine to
hide it from userspace.  The issue is where it's just that you don't see
the use, if the control demonstrably does nothing then that's fine.

--h//nqm2TleJK+t0c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJiqFwACgkQJNaLcl1U
h9AV8gf9GwzHMBap1p3cUin8nTIQKJwTl9QCbOmThnWJbuYKWeALxn2lKmviBaj9
cK6oSVKCxCZlda0aKQSesJ4okIAQLbk1o4567sntkbBp6CuktSmlTOir7R6xVydZ
IP/+pe8VGfqKFgLN+IHvNPMwOOA22UfsGhAA5M3A7i4B4qApwIVJlQicJ4TwD7y1
jCZABx6q6DJoq7nclV1aSGvFZOZqGy2YxtAkHBs9vACqznwKchY7Z2lqZC7e0ys4
Yl571RGhhMUWViVPe1xg65Jg/GOWHnzggLuPEk7M7ZGnriQF5KvEVVLpAaW8Wt0c
F1qXhhnmhgJzm6oJkzV/zd7+paTaRg==
=qSEG
-----END PGP SIGNATURE-----

--h//nqm2TleJK+t0c--

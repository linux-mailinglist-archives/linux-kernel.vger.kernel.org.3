Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B3D50B635
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 13:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447104AbiDVLgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 07:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiDVLgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:36:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDD0F14;
        Fri, 22 Apr 2022 04:33:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC77FB82C2E;
        Fri, 22 Apr 2022 11:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4348C385A4;
        Fri, 22 Apr 2022 11:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650627206;
        bh=3jfuEAzvI+fireVbhLAA89FI7cLlXG2gLVIt5mnBIg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N4xc6sPbo+yCUgMVCAfbmL9aaI0wq2uWC3lRyQp75hx9AB4KcChx7EvF3ADbYj3re
         gjC5jcLuiV0rrYIRHI2hV1QJ9RN7Wef3noIirHog3grPtVx9m2FkUUx9dP+R0qYwNV
         G6m1sInmZfIGXe5R3kzj6N0QL39ugPMBC63JxbP3xL0Zi5tcYr9i4g5MxxEInSG30o
         VR5rygxQY/QCxUbIAi/iZxSHWejn0IhHm1atF2cWDlA3JlK077bU5reZv/HUHaFLZM
         lOp9ohClb795LjV5CoLtPsIFEU/5EVPXXXFzitBgXBLis95T1yA32uKghxdnjcCuGH
         P1lrjqCWbiDTQ==
Date:   Fri, 22 Apr 2022 12:33:20 +0100
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
Message-ID: <YmKSgHrbb/7koM36@sirena.org.uk>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <YkWfziQzprEsWL72@sirena.org.uk>
 <CCE4A06E-6D6F-457D-B3C5-C36209BF38D3@cutebit.org>
 <YkW4MPh8VWc8eSGg@sirena.org.uk>
 <6D199EAB-FE14-4030-96A7-2E0E89D25FAB@cutebit.org>
 <YkXKmxJ0R3qpUoH4@sirena.org.uk>
 <DB0255C3-C9EC-4EFA-A377-C4BB1073D9B3@cutebit.org>
 <YmKPQ6kLCPz+2XTJ@sirena.org.uk>
 <B68302F2-3D77-4065-8A16-A9CC690AE10B@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HUPCgzDyOfBhsa/5"
Content-Disposition: inline
In-Reply-To: <B68302F2-3D77-4065-8A16-A9CC690AE10B@cutebit.org>
X-Cookie: Whoever dies with the most toys wins.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HUPCgzDyOfBhsa/5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2022 at 01:28:20PM +0200, Martin Povi=C5=A1er wrote:
> > On 22. 4. 2022, at 13:19, Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Apr 22, 2022 at 12:43:30PM +0200, Martin Povi=C5=A1er wrote:

> >> One final thought on the playback routing controls: On systems with >2
> >> speakers, the codecs need to be assigned slots through set_tdm_slot.
> >> The macaudio driver RFCed here assigns a single slot to each speaker,
> >> making the effect of each speaker's routing control this:

=2E..

> > I don't quite grasp the difference between the arrangement you're
> > proposing and assigning a single slot to each speaker?  Possibly it's
> > just a reordering of the slots?

> Ah, maybe what=E2=80=99s missing is the fact that the way the speaker amp=
 drivers
> are written, if they are assigned two slots with a call to set_tdm_slot,
> the first slot is considered 'left' and the second is 'right'.

> So in the arrangement I am proposing the 'Left', 'Right' and 'LeftRight'
> values of the routing control have the nominal effect (within the left-ri=
ght
> speaker pair), while in the other arrangement it is as I described above.

So previously each speaker would get two slots but now it just gets one?

--HUPCgzDyOfBhsa/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJikn8ACgkQJNaLcl1U
h9Apfwf9FyqYZwZ2D2ZxnG/lVxGl4cjqMmJe5FgwZCDKQPzM3Y9o4137S0U7kLTz
QM1Jf+3LJgVkdvJN/Hj3GaJPazdeXB6mMQ5o3p28PEe/ASqNKJCa6Z1UcQ5zdcaZ
D89JCKjmGPoHjNWiZCSRE6k7kXhtJO5MyXxNCgXAf5bk7352nedgPmg/4PapUL82
sEV/b496dYNV/EQ6HLGey/73P3cKc6w+urEcUQKaPcFlLWjK1J9ZP+TQuBdSxBNp
MjkcoQoQSNrw0PJ/rQWd++JkLimYQDwFEkaNeLWmh+K/L3/vCdun88ZtIbdeM3NL
VwJzyNbDoxmUu+IBEFgYIa+SP/YvUw==
=k+NI
-----END PGP SIGNATURE-----

--HUPCgzDyOfBhsa/5--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCAF50B793
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447626AbiDVMre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiDVMrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:47:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B7657157;
        Fri, 22 Apr 2022 05:44:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36EBDB82CC4;
        Fri, 22 Apr 2022 12:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F28C385A4;
        Fri, 22 Apr 2022 12:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650631476;
        bh=ki0hTvuIJuDOgNjUVtZYJlOKFfmg1R+HALk0WgFLZEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fyGk2KyeZy2x5vXffR3TGv5cq1NK8+zSo4tmCE5iiXndE9vjI9+Pu0+s/6CxHKEWW
         TWUQcrX+95VluIByopjc9Q+yB2RC4cHbq0cIxmihcNLn+x7b5VK0wQ24/L6yxiiac9
         TlLmGQOT4LcY8Y3oFDjHpgWdTJzMQb7KPDcP45lbD4XRlvAlFz+Z0FpbL2lo3fK49+
         UG8+A0WR8SmOHRe+UfvNm2CriW3HrIbPGBU2/dc7N7OID0ZXOcnAC1D6OKv3YLOnKI
         PpDqDpHtrLxs6X+hHGUPsWnVxj+p1QrBFS7DmPJgHcA2sZqlKiQ1O/+p5K0+M//BHz
         4/FXX9H+IAgAA==
Date:   Fri, 22 Apr 2022 13:44:31 +0100
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
Message-ID: <YmKjL9bOtOmsFWTs@sirena.org.uk>
References: <YkW4MPh8VWc8eSGg@sirena.org.uk>
 <6D199EAB-FE14-4030-96A7-2E0E89D25FAB@cutebit.org>
 <YkXKmxJ0R3qpUoH4@sirena.org.uk>
 <DB0255C3-C9EC-4EFA-A377-C4BB1073D9B3@cutebit.org>
 <YmKPQ6kLCPz+2XTJ@sirena.org.uk>
 <B68302F2-3D77-4065-8A16-A9CC690AE10B@cutebit.org>
 <YmKSgHrbb/7koM36@sirena.org.uk>
 <A1574F30-62D2-467D-A40B-8FD7C6B8BCFA@cutebit.org>
 <YmKeEKa0w2xLM9cL@sirena.org.uk>
 <6F6130F3-381C-4AB7-B618-CDC4C4A37C9B@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bYTaVvKVekkp0dWZ"
Content-Disposition: inline
In-Reply-To: <6F6130F3-381C-4AB7-B618-CDC4C4A37C9B@cutebit.org>
X-Cookie: Whoever dies with the most toys wins.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bYTaVvKVekkp0dWZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2022 at 02:36:03PM +0200, Martin Povi=C5=A1er wrote:

> > Ah, I think the confusion here is that I'm using slot and channel
> > interchangably whereas you're saying that previously the driver would
> > allocate two channels to each speaker with duplicate data?

> I guess you could say that. Not that there=E2=80=99s duplicate data on th=
e I2S
> bus, but the speaker amp would previously be configured to look for the
> left and right channel in the same TDM slot (see e.g. set_tdm_slot of
> tas2770 [0]).  (Each speaker amp drives a single speaker, but it still
> has a notion of left and right channel.)

Oh, I see - the speaker actually allows configuration of the slots
independently.  Usually the left/right thing on mono devices only does
something for I2S where the bus clocking enforces that there be both
left and right channels.  Either configuration is fine by me TBH, if you
can do that then you could just keep them mapped to the same channel
then mark the control as disabled since it should have no effect.

--bYTaVvKVekkp0dWZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJioy4ACgkQJNaLcl1U
h9Df+Af7BVfaaDh84vZFovAdNIOaGWSK6YJTe1gp55f0uHtkMsLtSZuiAujBSQ/w
Nno/WtvJKhmcmW+4PXZQHALD/lEFCeFewb610xzQwZ138ywneO+HwyJs6LpywmeP
sWrCS5aTOh7233H4pw36L5e6MQUwZ12NPZwoIDvsExmKxBf9IV5/SQGB4w3eotB3
XI0J0eUs4lt10VFnPpIsWEBdHZMrXE7mGA17k/BK+lTcyzKzgxNnEjvLjKeeXQ8D
m/v6feP2laYn4Ii1P//pjhlGJrjOasW1ufDOP85HhaJeREav2IqxrIg+3fr0n2+D
+J/U8+Gq0HAZBz2k2kyCOyDBpBCbuA==
=/wjL
-----END PGP SIGNATURE-----

--bYTaVvKVekkp0dWZ--

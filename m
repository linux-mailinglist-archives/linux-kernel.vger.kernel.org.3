Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F37549B1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354404AbiAYK03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347218AbiAYKWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:22:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92764C06174E;
        Tue, 25 Jan 2022 02:22:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 309E26163D;
        Tue, 25 Jan 2022 10:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532EDC340E0;
        Tue, 25 Jan 2022 10:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643106135;
        bh=YerMbkc6dlBfEzftLB78yr0Bys2g6geU05DzpcgGsj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ap6R05pzhynxijnMFSvcFKPnA6pyHpu96dSMyF8tmgX505u9TjTeaJ4j6KcENlWdA
         TNVB8Tx3sWDKspGQTD+2stRIykbj3h8X9bdIIm1VWNYmpJIqs8X6kH/hTonCFN7n4q
         yC4+DtUQQnmIafTQjjANist0cTR+355iEoAavlCbQ7wcGAvdoaS1rzvXhKKHM/HVRm
         m8AytoReg6Q+xiIk/GfvbQlUdSL7HMb9O9tTKtXrj5v3V790D33BEIzm4J+U2jvhJd
         t4gVBqOtA4bClDnKmc1hnd3i6Q6d7sNFlw1DNRUClc0C1EQyVkqw4Vv2fFu9tUFtIK
         pgcOULKq4hQcA==
Date:   Tue, 25 Jan 2022 10:22:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Pavel Machek <pavel@denx.de>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] ASoC: sh: rz-ssi: Drop calling rz_ssi_pio_recv()
 recursively
Message-ID: <Ye/PUmxc5NhMB1qL@sirena.org.uk>
References: <20220115012303.29651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220115012303.29651-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="D9HilRlcR5U8gm1B"
Content-Disposition: inline
In-Reply-To: <20220115012303.29651-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Cookie: Absence makes the heart go wander.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D9HilRlcR5U8gm1B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 15, 2022 at 01:22:59AM +0000, Lad Prabhakar wrote:
> Instead of recursively calling rz_ssi_pio_recv() use a loop instead
> to read the samples from RX fifo.

This doesn't apply against current code, please check and resend.

--D9HilRlcR5U8gm1B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHvz1EACgkQJNaLcl1U
h9AuXAf+J482bfctfHGgzaSOcZn2LDDxwFGwOwLtquLzILu5bPTVG/quNGfYgtEU
HGqK6idi7rHuKvuUdwtoK0VySpDxWPuKZ91xtGSh/UYdweO4OpXBo/Yl6Fsel056
CMrksjPT+WyZ+Veo4gpfgUlAyhV+gbaklVKBdPq9wjBTZJHaUkQ4YiugUbEL77gl
Bmj9bty8bX3U81PkNwgFhZYMgDznwy1IphYe29R/twQdDYUrZ2kfptRv1fQdRXt7
EIsxu1wrAyMdqVeDbMEEzA65XJV7cEtziHslAZC4jnCbYXTAcrWH5eS6Qz+rFYII
nSEJKsZsmMUEHqi3jbXZclzF9jXwVQ==
=fdPr
-----END PGP SIGNATURE-----

--D9HilRlcR5U8gm1B--

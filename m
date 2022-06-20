Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839A155230A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 19:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbiFTRvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 13:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbiFTRvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 13:51:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A87BF5A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:51:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4896FCE1394
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 17:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A9DC3411B;
        Mon, 20 Jun 2022 17:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655747490;
        bh=YIgNjSq3f/fSYQUMfXVVS8LqTX72gbak6AL5yhmAddQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OPHf2EMryZkCn/Ivutf7DRoHTA2U1z5nudkzKWAkEQI6X75557EmWs2hUJFNNCBRe
         O4D3EDEVxbqb9IzWrGKgksQC+LKTpHfzRPRQi0+wToYA8BvNkfEYq9IPczMM3+NG2K
         RpJIO5sT2DAKS56tPQXs+6a5GkIno5Xa9cwDmSjoXiheO01faS3UGRuFW3/Jiczop3
         PBmJY7K875a8BUK3IsD9yIpkuwZdoJz/9lL908S1fBtzXFNYc/hg0AtBl6xudfKf/t
         f/9VKyJQrVPJQjD3dJY59DtJ/MWJb56mXC3tnTIT96KHY/8xtfpHe40HwSm6eJaMDe
         ou8XIxe94IMtg==
Date:   Mon, 20 Jun 2022 18:51:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH RFC 1/2] regmap: add option to disable debugfs
Message-ID: <YrCznap77OyHu4bO@sirena.org.uk>
References: <20220620134758.1286480-1-aisheng.dong@nxp.com>
 <20220620134758.1286480-2-aisheng.dong@nxp.com>
 <YrCM0reni+x/KWsG@sirena.org.uk>
 <DB9PR04MB84779EF2842D789FA66094C380B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrCXILblKsp6DuN3@sirena.org.uk>
 <DB9PR04MB8477CD99D5847291A629994180B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dJzXVW8NRqbosNga"
Content-Disposition: inline
In-Reply-To: <DB9PR04MB8477CD99D5847291A629994180B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
X-Cookie: Good day to avoid cops.  Crawl to work.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dJzXVW8NRqbosNga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 20, 2022 at 04:15:40PM +0000, Aisheng Dong wrote:

> > The driver is going to need to power the device back up to access the v=
olatile
> > registers so it can take the device out of cache only mode when it's do=
ing that
> > can't it?

> Sorry, I didn't quite get it.
> There's no problem in driver to access volatile registers as it usually w=
ill power up
> device first by rpm.

So the runtime power managment seems like a good place to manage cache
only mode.

> But for debugfs, from what I saw in code, if there's a volatile register,=
 _regmap_read()
> will bypass cache and try to read the register value from HW.
> Then system may hang as no one powered up the device before.
> Anything I missed?

> static int _regmap_read(struct regmap *map, unsigned int reg,
>                         unsigned int *val)
> {
>         int ret;
>         void *context =3D _regmap_map_get_context(map);
>=20
>         if (!map->cache_bypass) {
>                 ret =3D regcache_read(map, reg, val);
>                 if (ret =3D=3D 0)
>                         return 0;
>         }
>=20
>         ret =3D map->reg_read(context, reg, val);

That's not what the code is upstream, upstream between the cache_bypass
check and the reg_read we have=20

	if (map->cache_only)
		return -EBUSY;

	if (!regmap_readable(map, reg))
		return -EIO;

so if we can't satisfy the read from the cache then we'll hit the
cache_only check and return -EBUSY before we start trying to do any
physical I/O.  The debugfs code will handle that gracefully, indicating
that it couldn't get a value for the volatile register by showing all Xs
for the value.  If none of the registers are cached then the file won't
be terribly useful but it at least shouldn't cause any errors with
accessing the device when it's powered down.

> Or you mean simply forgetting about volatile registers and let debugfs
> to read the stale value from cache?

We shouldn't cache anything for volatile registers, if we are then
that's an issue.

--dJzXVW8NRqbosNga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKws5wACgkQJNaLcl1U
h9CYfgf/dQNt14w+5JBnQsIiDhV+bKcWs2KBHDk3AoeYyt/UKW39MzvTi5+dvhaM
KWUt1LDFuSivoHxaR58hLq+45RNeDPEk0c/XwTPFJnFq7WincE6koGNSgKRNn2q8
VPdt6nvNU19dPuQLk947C/jfCRTbl7d0G5d2LHUMbqJJfDlNkSoGhcGPQQvJjZKG
7nkmwdQ36K3ikblzNmkN8IFbBaAvcxde2GkbS2PYdGEg1C+gmBlxg7cNhf54Ns2d
uX6RkAa904aeyvjJZV/u8FFHQgGoRlkJRxxseTYPJy9GjxT7pdR9hVvrjUQde/C5
lYkyc/bBG9KcRfxjT4kS9CvjprZ67w==
=kTjW
-----END PGP SIGNATURE-----

--dJzXVW8NRqbosNga--

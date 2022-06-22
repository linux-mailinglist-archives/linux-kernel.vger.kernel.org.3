Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83735554A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiFVMgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 08:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242186AbiFVMgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:36:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B753A710
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 05:36:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46E49B81E85
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 12:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C74C34114;
        Wed, 22 Jun 2022 12:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655901395;
        bh=jOa+odScmqCTMf1FbHvSnG/Mq4KSaMWGp9RcCHpXpi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OoOm6VeG+5XOVevoRPVIJ3o9Hop8vlWn3P8jMADP4iAUCszQb8ivgULLJO5nOo6/e
         1837mFLFMWYQCogony9sqKWEp9hJtmnF0YsEDguf9SroHxIRKLGwBTyUjC/kHvemU4
         tXMlasxRqVMsKGftPe6DQn+6DH+Vq2c3xVhknlkovIFfK/d29kx0kef4sgF+Gk3hjB
         PWE7ZIj25tN8lCx31KQXiFAPi12nQVmJw3qGzXFAdMf4bTleZAOTmkoE6BsUGSDxnK
         icAqjBmIgLZKlcyCMnyUKHlfVHrtYu1fF4xQ6OzZeqD7dMwXHH5LzqsWYc2RQpRqa7
         oWG7K0rDvdV4Q==
Date:   Wed, 22 Jun 2022 13:36:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dong Aisheng <dongas86@gmail.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH RFC 1/2] regmap: add option to disable debugfs
Message-ID: <YrMMzizzE7rIji5x@sirena.org.uk>
References: <20220620134758.1286480-2-aisheng.dong@nxp.com>
 <YrCM0reni+x/KWsG@sirena.org.uk>
 <DB9PR04MB84779EF2842D789FA66094C380B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrCXILblKsp6DuN3@sirena.org.uk>
 <DB9PR04MB8477CD99D5847291A629994180B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrCznap77OyHu4bO@sirena.org.uk>
 <DB9PR04MB847785E1861525FC1E4AD97280B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrHkXH1M4NydBfQT@sirena.org.uk>
 <DB9PR04MB84772F73D4AA1B49F87BECCF80B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <CAA+hA=RQVRHzdy_ZpwcC-ZB8mwUYuMYu_iLNAfuPcMCS1G9WXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZZCgliGg7GaewtNo"
Content-Disposition: inline
In-Reply-To: <CAA+hA=RQVRHzdy_ZpwcC-ZB8mwUYuMYu_iLNAfuPcMCS1G9WXA@mail.gmail.com>
X-Cookie: Truckers welcome.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZZCgliGg7GaewtNo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 22, 2022 at 06:12:49PM +0800, Dong Aisheng wrote:

> NOTE:  i didn't fix _regmap_write() as i.MX controls regmap write well in=
 driver
> with power enabled first, so don't have issues in reality.

I can't tell what you think the problem is with _regmap_write()?

> It can be fixed in a separate patch later if needed.
> You may check if it's as your expected solution.

> For syscon, I still have no idea how to fix it if I can't disable it.
>=20
> diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcach=
e.c
> index 2eaffd3224c9..da1702fd57cc 100644
> --- a/drivers/base/regmap/regcache.c
> +++ b/drivers/base/regmap/regcache.c
> @@ -495,7 +495,7 @@ EXPORT_SYMBOL_GPL(regcache_drop_region);
>  void regcache_cache_only(struct regmap *map, bool enable)
>  {
>         map->lock(map->lock_arg);
> -       WARN_ON(map->cache_bypass && enable);
> +//     WARN_ON(map->cache_bypass && enable);
>         map->cache_only =3D enable;
>         trace_regmap_cache_only(map, enable);
>         map->unlock(map->lock_arg);

What is the purpose of this change?  Why would the combination of cache
only and bypass modes work be a good idea, and how should things behave
in that case?

> diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk=
-ctrl.c
> index 7ebc28709e94..12f0f9a24fad 100644
> --- a/drivers/soc/imx/imx8m-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8m-blk-ctrl.c

The changes in here look reasonable, though I'm not familiar with this
driver so might be missing something.

--ZZCgliGg7GaewtNo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKzDM0ACgkQJNaLcl1U
h9B8ewf/db1XoZtqCMkzJ+Bwo3iFGRS1XPNR2dgGVbiw37sHxM37BCmbsh6C2XO8
8AfvJq+6fuVxwMmj1OR1UuYc+ZeB/gzDY2TiiyBCTBbKfSu9wj+YRjw2t1Hvo/vI
FORzylahVGXqXl7cqIfbHEOzzWPUC94Z5bkbPdUp3R5e/nx0nIDB6C+AwOtFWtTB
aA3RWELlPZOoAcu3VoRNn/sgnN/0R59VGFvV/AsskaR5KxGw+B+lkE3UdjPB8FS+
hmRa71iM6ROooNsg7aBaT7IHcjC5w0DgWNBsc4p321qGqbpmFGFL0hSnQjMpL48l
HX8F6GuqgQLzQ6r7JBFiz7fIGlCC9A==
=ZDKy
-----END PGP SIGNATURE-----

--ZZCgliGg7GaewtNo--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1735555150
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358840AbiFVQ1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350478AbiFVQ1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:27:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BE83F8BA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:27:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D00061913
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AF3C34114;
        Wed, 22 Jun 2022 16:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655915234;
        bh=DyYH6uhmU3zMb9mouFy6uFvKCKUdXZL2QKDEo9cMQ6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D1pF3q3OV1E0qnjTJ39Cl/qlC0tc/6MJhpW6XeIjEae7qHLfIa0e3Aa/7bMOGpCqG
         4xeEkGNo/pbhXtd3hSkfusVcHkz/rvZ3Yu7JrKRu7VTi6acVHfLArDjxvBvMKB7mrN
         i40OfSFaH+I2uBbnLxAFaY0lctI5NlrTPzJPyA/31yoZoRNL8oBNZm9UTq+8iQBG/Q
         yVH5Px98afK1GYtsKBPwUQDYSkP3niBeTx94pkOkVy9S2LRQfW/hwrtmzW4JRPZays
         7ONpB2vSJsddTDbkH8jxB/+SnRCRg7C65sZjjxNORWIDfEfFp0+gPleY/yKkD2+kHs
         kfvsYi9f9hdFA==
Date:   Wed, 22 Jun 2022 17:27:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dong Aisheng <dongas86@gmail.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH RFC 1/2] regmap: add option to disable debugfs
Message-ID: <YrNC3eHx7ARQy/Vd@sirena.org.uk>
References: <DB9PR04MB84779EF2842D789FA66094C380B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrCXILblKsp6DuN3@sirena.org.uk>
 <DB9PR04MB8477CD99D5847291A629994180B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrCznap77OyHu4bO@sirena.org.uk>
 <DB9PR04MB847785E1861525FC1E4AD97280B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrHkXH1M4NydBfQT@sirena.org.uk>
 <DB9PR04MB84772F73D4AA1B49F87BECCF80B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <CAA+hA=RQVRHzdy_ZpwcC-ZB8mwUYuMYu_iLNAfuPcMCS1G9WXA@mail.gmail.com>
 <YrMMzizzE7rIji5x@sirena.org.uk>
 <CAA+hA=SA7BY8WxrbuRAOsuHyz+bx-EJq-UT_YLW5wYMS+io+pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VcQDeV43aI8PD0Ko"
Content-Disposition: inline
In-Reply-To: <CAA+hA=SA7BY8WxrbuRAOsuHyz+bx-EJq-UT_YLW5wYMS+io+pg@mail.gmail.com>
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


--VcQDeV43aI8PD0Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 23, 2022 at 12:05:46AM +0800, Dong Aisheng wrote:
> On Wed, Jun 22, 2022 at 8:36 PM Mark Brown <broonie@kernel.org> wrote:

> > On Wed, Jun 22, 2022 at 06:12:49PM +0800, Dong Aisheng wrote:
> >
> > > NOTE:  i didn't fix _regmap_write() as i.MX controls regmap write well in driver
> > > with power enabled first, so don't have issues in reality.

> > I can't tell what you think the problem is with _regmap_write()?

> Because from what I see,  _regmap_write() seems still can write to HW
> register even with cache_only mode set theoretically.

Ah, I see - we don't enforce cache_only if bypass is enabled somehow,
but we will complain if you try to enable both at the same time so I'm
not sure that's an issue?

> > > -       WARN_ON(map->cache_bypass && enable);
> > > +//     WARN_ON(map->cache_bypass && enable);

> > What is the purpose of this change?  Why would the combination of cache
> > only and bypass modes work be a good idea, and how should things behave
> > in that case?

> Because without this change, there will be a kernel dump caused by
> WARN_ON when drivers call regcache_cache_only(map, true) after power
> is off. There's no cache used in the imx blkctl driver. So map->cache_bypass
> is default to true.

cache_bypass is only going to be true if something enabled bypass, why
would a device that doesn't use a cache enable bypass?  It does get
turned on transiently by things like patching but those only make sense
if the device can be accessed so caceh_only shouldn't be on then.

--VcQDeV43aI8PD0Ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKzQtwACgkQJNaLcl1U
h9BB7Qf/QfSoUpqy0MvH/JvWmZwOVLno2deYkhInVLyqUuLwPvh/GT/q6VOMiho9
FIykZbViiNKvegquav32trRYCkfIDc1qN3p00y1iXudZs5fQ/AWcxy47yAcOjOvN
CWye/H2quJTdKC+lNc6VVjR6u2FuRtUHfB9okNnYzqrDbeWutUHgDL8WA+kan9X1
JrtOTtr5iP9Ps+KjYI/uZY5F5Gi5yu8zXN9BBsq/CzVjugC4JFe63SWnTOCfQFeG
fYxI9BZpE3ikkXPhlkzsuf1keuaRs4CqjNj9vY8Y8TstMl7UTecLNqs7/SzdCFyD
la5/sOJ+CQMDpPeZGgd02VtTFKmE9w==
=u7Zw
-----END PGP SIGNATURE-----

--VcQDeV43aI8PD0Ko--

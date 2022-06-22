Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554A95551BA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377023AbiFVQvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376887AbiFVQu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:50:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497CC40E73
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:48:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC4A961B1F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF452C3411B;
        Wed, 22 Jun 2022 16:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655916536;
        bh=HKAwj6WqHsFCizeY3YQTqEfxSzWhZ074BWZUt4AykcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gn07NX4XJW2TBPErhOJSQPWok8YUaMQHmpcwfee9PC84zM1ypWc/JkQCdfgXozvp8
         1MrKfvqHUQRBW9kKHDbCIHoGblR9udb43LNsl1jgkF5A6onQVZLgMQdPk8L4xaFXf9
         nZLW8BrU7y3bCxwDpYoUG8WmTttKiDgqeBNYJsHnfX5oLG3UI3MTdr3V2TmpChaEx/
         Ek1YnHHx8FFM4ijCaBFSEDCOcQQqRCwluL7T9wizMdN9rzAZH1m4bm39Op3lE7TwFw
         kBTqJ5E9n5Qqku5LaB9ujVZc77vKdKsyWZ1QmJRD8nmvP7sfrxWSxplUKwfHZZOT8E
         lczUlS74UadJQ==
Date:   Wed, 22 Jun 2022 17:48:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dong Aisheng <dongas86@gmail.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH RFC 1/2] regmap: add option to disable debugfs
Message-ID: <YrNH8/eaYHYeAWNJ@sirena.org.uk>
References: <DB9PR04MB8477CD99D5847291A629994180B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrCznap77OyHu4bO@sirena.org.uk>
 <DB9PR04MB847785E1861525FC1E4AD97280B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrHkXH1M4NydBfQT@sirena.org.uk>
 <DB9PR04MB84772F73D4AA1B49F87BECCF80B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <CAA+hA=RQVRHzdy_ZpwcC-ZB8mwUYuMYu_iLNAfuPcMCS1G9WXA@mail.gmail.com>
 <YrMMzizzE7rIji5x@sirena.org.uk>
 <CAA+hA=SA7BY8WxrbuRAOsuHyz+bx-EJq-UT_YLW5wYMS+io+pg@mail.gmail.com>
 <YrNC3eHx7ARQy/Vd@sirena.org.uk>
 <CAA+hA=SHgp1jZn1Qwrcu3fMnn22aaVimS4+Y2hPcWehS4zdRoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xDUxxgqnT7sUsrLu"
Content-Disposition: inline
In-Reply-To: <CAA+hA=SHgp1jZn1Qwrcu3fMnn22aaVimS4+Y2hPcWehS4zdRoA@mail.gmail.com>
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


--xDUxxgqnT7sUsrLu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 23, 2022 at 12:42:51AM +0800, Dong Aisheng wrote:
> On Thu, Jun 23, 2022 at 12:27 AM Mark Brown <broonie@kernel.org> wrote:

> > cache_bypass is only going to be true if something enabled bypass, why
> > would a device that doesn't use a cache enable bypass?  It does get
> > turned on transiently by things like patching but those only make sense
> > if the device can be accessed so caceh_only shouldn't be on then.

> It was enabled by default according to the code:
> __regmap_init -> regcache_init

Ah, right.  That makes sense - we should relax the check to only apply
if there is actually a cache.

--xDUxxgqnT7sUsrLu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKzR/IACgkQJNaLcl1U
h9DGaQf/ZCq9VWO3ofHpZRx0yp3FDK4aUd7qAalJ1T73pWVSk7oN0B7WFLEEZUjp
psfGcIzztckSoJIL7vxfGayS32ZsOXsetjkKDlRaitE2pHOx5nriGV3b888D1ysA
6jJk43hzFnEjU17YONVOmlSMPrNs8PV0YvIedT9V2WofKY+YWIRCnLgS4Gc0GvgK
4utsH9r12dYIQDtUkMcLWgrw/Sy7dw9SApe8NcbphkVKY2HVyf8ZFRjaIAIu3phI
Q5sGhkVjAwrqOMocr+TEu+1tycGS53JpqrPSiIJJ/gITYfstLCd4hfZ4ciD0/xmF
vnwAoLGLmg1EYxvvUYgm+C9meNyIQg==
=Ke7G
-----END PGP SIGNATURE-----

--xDUxxgqnT7sUsrLu--

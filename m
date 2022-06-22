Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C665551FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377036AbiFVRIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377306AbiFVRIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:08:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4639142496
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:07:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 242F661B89
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 17:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2992AC34114;
        Wed, 22 Jun 2022 17:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655917639;
        bh=jgUJecCzFXvnTsqrwru1uRnoQwtYzOYNC/yDvPGBGoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IhZwI4Q6iVlC+S04Q/J29TcboiwU+MljMXhoIKGg/AarqIIaTjhvPWG8Z5naLox1B
         n9KzIptntxltqPY1UQX7h6+eshcKX5oThDpAfbbkf+5lPHZNJDhE22vQrk6ovDr6oN
         6Y17fZSrph0Xy4r8ZUdj4pEGcqUwbIhTfj8ATiOakPESMDJzko75CuWYd/Zhi8KQpt
         6VBVVsuA1I+MzepLJnoupAngeGMWvT1Jz8keDZX/TCuwguPcCsaBPRgu7Kgxak/iez
         Grfx6FYsk6nAPs/Mx6RdBLf4M9kYE6s+/BCOLQj4HZkBCOSKpStEzvhVWHDEibsMvn
         /cE+zahQqxROw==
Date:   Wed, 22 Jun 2022 18:07:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dong Aisheng <dongas86@gmail.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH RFC 1/2] regmap: add option to disable debugfs
Message-ID: <YrNMQ1GLR03WX5IE@sirena.org.uk>
References: <DB9PR04MB847785E1861525FC1E4AD97280B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrHkXH1M4NydBfQT@sirena.org.uk>
 <DB9PR04MB84772F73D4AA1B49F87BECCF80B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <CAA+hA=RQVRHzdy_ZpwcC-ZB8mwUYuMYu_iLNAfuPcMCS1G9WXA@mail.gmail.com>
 <YrMMzizzE7rIji5x@sirena.org.uk>
 <CAA+hA=SA7BY8WxrbuRAOsuHyz+bx-EJq-UT_YLW5wYMS+io+pg@mail.gmail.com>
 <YrNC3eHx7ARQy/Vd@sirena.org.uk>
 <CAA+hA=SHgp1jZn1Qwrcu3fMnn22aaVimS4+Y2hPcWehS4zdRoA@mail.gmail.com>
 <YrNH8/eaYHYeAWNJ@sirena.org.uk>
 <CAA+hA=SsTeTF80dL6cT6Ef7Y9Q3Fhj4Jp0S-_nk=UK1HsZ4hYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8qqGhfl8w2IBtgLF"
Content-Disposition: inline
In-Reply-To: <CAA+hA=SsTeTF80dL6cT6Ef7Y9Q3Fhj4Jp0S-_nk=UK1HsZ4hYw@mail.gmail.com>
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


--8qqGhfl8w2IBtgLF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 23, 2022 at 01:01:12AM +0800, Dong Aisheng wrote:
> On Thu, Jun 23, 2022 at 12:48 AM Mark Brown <broonie@kernel.org> wrote:

> > Ah, right.  That makes sense - we should relax the check to only apply
> > if there is actually a cache.

> If we don't remove the WARN_ON in regcache_cache_only(), how
> would you suggest the fix?

In exactly the manner I suggested above.

--8qqGhfl8w2IBtgLF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKzTEIACgkQJNaLcl1U
h9Diqwf+Nz4r4ln8IKyQtWv2S6rFk5jVlzqo7clQkJiexuryvvBKMzraOfs4olcX
a5kjTZUEH3b5yW8+xvIaTt2AXOxnNwqnWc0Z//7FrL3+SUv4JlRJUQQwzSZ7UE7v
30Syy4I74zSePHlCMvXFz5Ji1lyAPuJgzLYKCh14+zj48JIfxCuY+Bbm+CRXqS84
XuQFwTq90Re41/8i9Q7tKMnNHwWT4CMlxXt7zBpCEvuiYfWnIzOYWIHuok0BO5Fm
cRSMsQ9N4xeFPicCu59mEd101vxejcC3lrtjKtGdVGFzoG9nFUnxze9ErMESG0LN
08DQYKM4mPPMPNxGchA2Bqh001F/Dw==
=NXAf
-----END PGP SIGNATURE-----

--8qqGhfl8w2IBtgLF--

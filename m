Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D6655237E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244916AbiFTSEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244936AbiFTSEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:04:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F95318E3C;
        Mon, 20 Jun 2022 11:04:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C14416156D;
        Mon, 20 Jun 2022 18:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8716C3411B;
        Mon, 20 Jun 2022 18:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655748282;
        bh=w6vacAfaqohw95S+mHKQgM+EKeWnz+yRbKl9pZAYgT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PDbsfohMbYv3MffqWofo0S7UAM3OWif/Gh/rKbWiB5wStzqG5O9JTSUqCxbcdE0QC
         R/gf2j1b5t9kZBUtQHuHnZCby4kToF6ZQz8v25NCzG35JTNUA9cascUN+S073vlodc
         747BGINyYhkum55MlnQPY8NgidJYQETduCBfJE5A9qcQLGtD/NX5B3SDxToS08R8zW
         QczCMm7/qmod4Dj1zd4PhHwZxjs0ft4iu8z/zXspS/6BzPCOojI/0tjp4NrGKMyer5
         Yn4WJ/mWub0Pq9N6Cf4r5eu01pjH3Bh2o/AVSJBcJ8HwigExQEsdjrModduyoJzPRf
         7e8dlrFn6tAOQ==
Date:   Mon, 20 Jun 2022 19:04:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierluigi Passaro <pierluigi.p@variscite.com>
Cc:     Alifer Willians de Moraes <alifer.m@variscite.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Eran Matityahu <eran.m@variscite.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: wm8904: add DMIC support
Message-ID: <YrC2tLI+nUxOGsIX@sirena.org.uk>
References: <AM6PR08MB43760A5F78137DAE68FE99C7FFB09@AM6PR08MB4376.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VOCVAPjBvueWLvm9"
Content-Disposition: inline
In-Reply-To: <AM6PR08MB43760A5F78137DAE68FE99C7FFB09@AM6PR08MB4376.eurprd08.prod.outlook.com>
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


--VOCVAPjBvueWLvm9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 20, 2022 at 05:52:43PM +0000, Pierluigi Passaro wrote:
> > > Just for my understanding, are you suggesting to set a device tree
> > > property to force a fixed behavior in the driver ?

> > Yes.

> Why should we use a fixed behavior ?

The things that are fixed by the design should be fixed.

> > The device shares pins between the line inputs and the DMIC inputs so at
> > least some of the configuration is going to be determinted at system
> > design time, that will fix the usable values of at least one of the
> > controls which ought to be reflected in the runtime behaviour.

> In our design we use:
> - pin 1: DMIC_CLK
> - pin 24: LINEIN2R
> - pin 26: LINEIN2L
> - pin 27: DMIC_DATA

> we have no pins shared among DMIC and LINEIN.

This means that DMICDAT2 is not usefully selectable at runtime, you've
got IN1 as digital and IN2 as analogue, so while the DMIC/ADC switch is
useful the DMIC1/2 switch is not.

--VOCVAPjBvueWLvm9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKwtrMACgkQJNaLcl1U
h9AVVAf8CNJ1pKU5n40o+hAHDCPrpMkjTpft6KOXuI6XY7ImplHB1hCdT7Q6WATf
aBd0+QPrVbh1F8JPhUXGwsovT2NTqxO3mnuv8rf3W6/q+sBvebRFd6JFtqPixkRx
it74je2CMTZXE5dCFp/IC6RfN1A73ommQqkSbMHv/ISFBDJXFwCtBXCkip3sHmIu
ogp7fB7pZYgfsxh24nHeREBI+HAiwbqefgu7wDTBQ3DEIbWYq3xRffqucidYnUwp
yenPU0ysSpOEBZXcU9QxvKxlh+H3dPNF4xNKNHXzqIt3IPWJF2WFF4JLdxKGzvoF
pAKrexCNszAQZt19PrBca61dzOHDeg==
=G8Fe
-----END PGP SIGNATURE-----

--VOCVAPjBvueWLvm9--

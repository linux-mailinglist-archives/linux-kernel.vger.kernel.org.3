Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E2457A5D3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239094AbiGSRxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiGSRxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:53:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2CC5722B;
        Tue, 19 Jul 2022 10:53:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E81AB81C5C;
        Tue, 19 Jul 2022 17:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F26C341CA;
        Tue, 19 Jul 2022 17:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658253211;
        bh=GI+gJxOPyNxkeHfU9ebTLjaH3IEL1Dm94PwYhl9hk6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S4wPcfZb6jg68De5mTy/hkg5epiRO2WAZrtjq8IvGLKyEkLNNRjECSsWheqzbSJkO
         z2OSXsAFvrm/xt60yBGa2+n24Cp6I5bEcBp10LNjfCJ72IrUhw4OohcW8de6YMEQXX
         PY5fzBgKHSQ/u9kfD33STL7BIxvzSvZyj+DscB1oLUc2IejZOmu87AdItzFiTZ6jT2
         mAQ1r3Dp1hRA9O0ciDd4YyUgmh8E4Hkcb14EctookT9o8MedApGe0cewv1Ney+yH/T
         OSJ4DURtjjSOhT2z5sG6ViWVNSxZW7A8kpnbgC4/zT6aYd1rtGkTQR+bTk6kn+Msi1
         QhiscTJ1aok3A==
Date:   Tue, 19 Jul 2022 18:53:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "git@xilinx.com" <git@xilinx.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [RFC PATCH 1/2] spi: Add multiple CS support for a single SPI
 device
Message-ID: <YtbvlYZoRDz6i+pS@sirena.org.uk>
References: <20220606112607.20800-1-amit.kumar-mahapatra@xilinx.com>
 <20220606112607.20800-2-amit.kumar-mahapatra@xilinx.com>
 <YqHfccvhy7e5Bc6m@sirena.org.uk>
 <DM6PR12MB2809F6C7D80B60556218D627DCB59@DM6PR12MB2809.namprd12.prod.outlook.com>
 <YrRXTrYN3BuShbzg@sirena.org.uk>
 <DM6PR12MB28091BEB013B6F1903B5CDE3DC8B9@DM6PR12MB2809.namprd12.prod.outlook.com>
 <YtGNnT2cP5HIayp3@sirena.org.uk>
 <BN7PR12MB280220006B18F06E9ADA31F5DC8F9@BN7PR12MB2802.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="goT4hZWVlB+2fFB9"
Content-Disposition: inline
In-Reply-To: <BN7PR12MB280220006B18F06E9ADA31F5DC8F9@BN7PR12MB2802.namprd12.prod.outlook.com>
X-Cookie: We have ears, earther...FOUR OF THEM!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--goT4hZWVlB+2fFB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 19, 2022 at 01:21:41PM +0000, Mahapatra, Amit Kumar wrote:

> I agree, so for checking the controller multiple chip select capability(u=
sing=20
> more than one chip select at once) we can define a new spi controller DT=
=20
> property like "multi-cs-cap"(please suggest a better name).=20
> The controller that can support multiple chip selects should have this pr=
operty=20
> in the spi controller DT node. The spi core will check ctlr->multi-cs-cap=
 to=20
> operate multiple chip select in parallel.

I'm not sure this needs to be a DT property, it's more just something we
infer from the compatible.  The name seems fine, as does the flag in the
controller data.

> > the chip selects are available and that the controller can do something=
 useful
> > with them (and probably have an implementation in the core for doing so=
 via
> > GPIO).

> Here are you referring to the usecase in which a controller implementing =
multi CS
> support using GPIO? =20

Yes, we probably ought to.

--goT4hZWVlB+2fFB9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLW75QACgkQJNaLcl1U
h9CJnQf/dhICrU3mfuXOY461g8QV5eETdPaVby8yNx8MlhoRgqDFNvA2zwezWfcJ
Vdj2/Q3LEjalNXzquO2TSl0gkTWNWi+QDzBjvETXKV7vKYwm59poI8MVBhqI7N99
RhZyxKvL/6aHGOJP4/WD2/6iQsg1g2lMVb4M0SYM85zZAVJFoA/OuNoBPgGE7jUM
ldycb+CE7awq5PS5RNcvtb8NWx/GrLvx+fpGG787yzBH207JvbUY0my2m26k2LCD
gsJA7gzrrxbYjaCH+0Tdb5PMSOf5XN6eOvcq3rNq5D9AHQSPojbqLJF1gNWz+iS7
uVUdG/qU6Mm16YocVIgnDpsb31WwnA==
=p2xo
-----END PGP SIGNATURE-----

--goT4hZWVlB+2fFB9--

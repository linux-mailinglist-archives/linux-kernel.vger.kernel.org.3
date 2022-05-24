Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8607532A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 14:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbiEXMme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 08:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiEXMmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 08:42:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA02C87A3F;
        Tue, 24 May 2022 05:42:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 786E461525;
        Tue, 24 May 2022 12:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2101FC385AA;
        Tue, 24 May 2022 12:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653396149;
        bh=uluCb6ToQhx8UjfMpB8qBxFTdkdzFTm5HZvSWwomJJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pkozsteKGaDG/TmaQcuF6Blhx7cPiAYgUOHStDiyw4jczuTYZDyNI1WPwIcMJacs5
         udsSEPy2aentDFzq2c7gPZ6YlgiMnuIsFzSIr1scBsMvYwngMOlPaQjWNDuy2ofRok
         LBFoaH71+d2077xvKYFQZyYqwXXi7ac/LybTAkKwBXH7z9nYsrdmVOZJ3jDpz2TjhX
         258USGQ5dtN3gC2C9jBI1r6mwob1Fk/2jXDp3tmuAi6oXOFaQAKffA0wSqLTTIuR/u
         gOWxO8kOTtT/kR0rvoRYoIFp9ca+1VbUmRXAPjcOslzvSF5GdABbagNhcaaBJnCzC2
         K/ikwKiLPNztw==
Date:   Tue, 24 May 2022 13:42:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alistair Francis <alistair@alistair23.me>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-hwmon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Andreas Kemnade <andreas@kemnade.info>,
        Zhang Rui <rui.zhang@intel.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: Re: [PATCH v20 1/4] mfd: silergy,sy7636a: Add config option
Message-ID: <YozSrmW2N15KxOlc@sirena.org.uk>
References: <20220330094126.30252-1-alistair@alistair23.me>
 <20220330094126.30252-2-alistair@alistair23.me>
 <45acc349-8fea-f755-065c-c561949c45af@roeck-us.net>
 <CAKmqyKOqjperoku_uOy4sCa6LmCUtfB7SCvhLEKxLtcwDkzRyA@mail.gmail.com>
 <YmEQ1/Gs15gUxYdh@google.com>
 <CAKmqyKPqUuwguio07Jr99DV-3paEkmU-qJp6tERxPoU79BCAgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y3DUZVf2sywO4L1W"
Content-Disposition: inline
In-Reply-To: <CAKmqyKPqUuwguio07Jr99DV-3paEkmU-qJp6tERxPoU79BCAgw@mail.gmail.com>
X-Cookie: A man's best friend is his dogma.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y3DUZVf2sywO4L1W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 24, 2022 at 09:55:37PM +1000, Alistair Francis wrote:
> On Thu, Apr 21, 2022 at 6:07 PM Lee Jones <lee.jones@linaro.org> wrote:
> > On Wed, 20 Apr 2022, Alistair Francis wrote:

> > > Any chance of getting this in for 5.18? It would be nice to have the
> > > configs all sorted before the release

> > Can't do anything without Mark's Ack.

> Can this be included in 5.19? I can re-send the series if required

Please don't send content free pings, please resubmit patches if you
think they've been dropped on the floor (which is probably what happened
here, but I don't have context any more for what it is).  Content free
pings require people to go digging through mail archives to find out
what you're asking about, if they're even online and able to do so at
the time they look at your mail.

--y3DUZVf2sywO4L1W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKM0q0ACgkQJNaLcl1U
h9AFxAf/aZV+MyOwF+RYJ45h8Mv2F3f2u0hsR7avAitcpycD1h4D1xmW66JDlLug
SNc7PnthshYzyeHKJeb0T5H0YuBxb2WaIWHDNwhvcVCI1CEyQRf2I4xNf1j06mhB
2kYEqefpfkQpDd2JIpQTyreZkJzddOw0yzoEBOLaJzESHO5v78mHqDYRFqvHeb7V
n1OhA7dGgZGSx/C989GSe1eF1x7z9dmCqk4s3lwmtGd1QpWZuwS0NWgdIDiDhvHt
Wivc2SeQz56ydFip8rmCT0i5eT7PFc+e14Xy1TJvopGQHbOSkoqEP3XIl2N/Y/BY
cAdWRnmwK96wudMjpdFBuuErofxy/g==
=boSv
-----END PGP SIGNATURE-----

--y3DUZVf2sywO4L1W--

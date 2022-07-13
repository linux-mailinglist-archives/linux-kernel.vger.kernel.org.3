Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02AC572DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbiGMGLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiGMGLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:11:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF461C74A1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:11:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBVbA-0007AM-5d; Wed, 13 Jul 2022 08:11:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBVb9-000eqF-6S; Wed, 13 Jul 2022 08:11:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBVb8-004sbw-99; Wed, 13 Jul 2022 08:11:46 +0200
Date:   Wed, 13 Jul 2022 08:11:43 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>
Subject: Re: [PATCH 6/7] pwm: dwc: remove the CONFIG_OF in timer clock
Message-ID: <20220713061143.qvgt5wry3onbswlg@pengutronix.de>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
 <20220712100113.569042-7-ben.dooks@sifive.com>
 <bcbd1b29-7c6d-1d1d-2c72-b8818e99c65c@linaro.org>
 <77c97281-96d9-c969-18cf-6e609098aa57@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yywwgvrzbnvxjnxs"
Content-Disposition: inline
In-Reply-To: <77c97281-96d9-c969-18cf-6e609098aa57@sifive.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yywwgvrzbnvxjnxs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 12, 2022 at 11:20:23AM +0100, Ben Dooks wrote:
> On 12/07/2022 11:09, Krzysztof Kozlowski wrote:
> > On 12/07/2022 12:01, Ben Dooks wrote:
> > > We should probably change from the #ifdef added earlier in
> > > 49a0f4692a8752c7b03cb26d54282bee5c8c71bb ("wm: dwc: add timer clock")
> > > and just have it always in the dwc data so if we have a system with
> > > both PCI and OF probing it should work
> > >=20
> > > -- consider merging with original patch
> >=20
> > Missing SoB. Please run checkpatch.
>=20
> This was meant to be an RFC about whether it should be a single patch
> or merged back into the previous one.

+1 for merging these

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yywwgvrzbnvxjnxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLOYhwACgkQwfwUeK3K
7Anlkgf+PzfFU+vh+ZG2uD+0UJ1DqmgG+ptqG5hMxqBIBY95jJTmFQhXsDZ4MXGG
cAp8rQObOhcDNgR8QBXVghQpeFMFdAPnV4j3bLERToB0Mqatd6JXi8VyN0ji27or
RbCiDnSf+gBWa6t9tk6i6PHi3Eg1qMyRUtRmORruJNt1d/B2XKz6v2eAWWHIsJH0
6Sf2U8Niqg8q26bMZJqe1UHxXok1omEQj/7yjp5MwM+gpNUQ8kBTcc/9SB3Vao4v
Tm0ikwxMYVsBQEez7dnx3flHmwoKhJHt1uwKi7DPQVA3Qf1G/NiALr32gqk0etqc
dZ61QOY3ZKu18/Hzgiste1wMU02GbQ==
=Yud/
-----END PGP SIGNATURE-----

--yywwgvrzbnvxjnxs--

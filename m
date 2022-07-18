Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDA2577CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbiGRHyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiGRHyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:54:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50F1636A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 00:54:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDLaE-0001WB-2p; Mon, 18 Jul 2022 09:54:26 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDLaD-001fcN-2M; Mon, 18 Jul 2022 09:54:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDLaC-005uvA-Af; Mon, 18 Jul 2022 09:54:24 +0200
Date:   Mon, 18 Jul 2022 09:54:22 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>
Subject: Re: [PATCH 1/7] pwm: change &pci->dev to dev in probe
Message-ID: <20220718075422.tpxjkua67w4y2lee@pengutronix.de>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
 <20220712100113.569042-2-ben.dooks@sifive.com>
 <20220713081633.5lsunbl5mfnngdrs@pengutronix.de>
 <2cd139dd-559e-7975-41a7-c813bc5851ea@sifive.com>
 <20220718074954.4z4qiz2pbuyrzaje@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ngh2iorqj3djqfbj"
Content-Disposition: inline
In-Reply-To: <20220718074954.4z4qiz2pbuyrzaje@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ngh2iorqj3djqfbj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jul 18, 2022 at 09:49:54AM +0200, Uwe Kleine-K=F6nig wrote:
> On Mon, Jul 18, 2022 at 08:19:16AM +0100, Ben Dooks wrote:
> > On 13/07/2022 09:16, Uwe Kleine-K=F6nig wrote:
> > > On Tue, Jul 12, 2022 at 11:01:07AM +0100, Ben Dooks wrote:
> > > > The dwc_pwm_probe() assignes dev to be &pci->dev but then uses
> > > > &pci->dev throughout the function. Change these all to the be
> > > > 'dev' variable to make lines shorter.
> > >=20
> > > Looks reasonable.
> > >=20
> > > Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > ack for 1/7 or the series?
>=20
> The former. For the other patches I assume they will change in v2.

Oh well, and 2/7 is so obviously a preparation patch that I'll wait to
see v2 for that one, too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ngh2iorqj3djqfbj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLVEawACgkQwfwUeK3K
7AmTggf6A0ecpKFfBLiPjo/NNYwaME/rIWapOnrvy/ycFw1mJRqbs7Yys4jnN3Wp
PEhd18VJo1i0pzD0tTlNayIso/8vm3oBwVyfCWazfm99Z0Fg5za+prV+51Jf4Vgz
mnzDGFuMiXFYItmDPPlGOV0FVJsH2h07dalUkFCTtReX7CW/OoLHgt1eZ2OQgKsM
ECw8Q/k+46q7qiXc2shR9Pk+G3svCkXZtVI5lhlqZnNdGnPKEU0Ixk/uo///C9pM
2qJ2yRCNAzCPK2YWRVf43OuT4mHhMHxv32JlkqEWuUczQsqvQNPDj4xEj5BGy8/D
TSSiVYp1pjGib45T5rRSKLIQgKZQKw==
=Bzbt
-----END PGP SIGNATURE-----

--ngh2iorqj3djqfbj--

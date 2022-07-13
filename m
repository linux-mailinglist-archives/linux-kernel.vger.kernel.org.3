Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB9F5739BF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbiGMPIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236827AbiGMPI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:08:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D07B4C61C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:08:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBdy4-0001Jr-Tk; Wed, 13 Jul 2022 17:08:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBdy3-000jno-4t; Wed, 13 Jul 2022 17:07:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBdy2-004wvj-E3; Wed, 13 Jul 2022 17:07:58 +0200
Date:   Wed, 13 Jul 2022 17:07:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>
Subject: Re: [PATCH 3/7] pwm: dwc: add of/platform support
Message-ID: <20220713150755.bimcq2yiuvxn6n6v@pengutronix.de>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
 <20220712100113.569042-4-ben.dooks@sifive.com>
 <20220712221715.GT1823936-robh@kernel.org>
 <feaacf44-f9a8-b892-d8ba-8a396b49d56b@sifive.com>
 <20220713135230.gjbd3v6iih2uicpu@pengutronix.de>
 <7999fec2-847a-86ce-ed78-d2a9008bf654@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r7fomtcfvjlx7yip"
Content-Disposition: inline
In-Reply-To: <7999fec2-847a-86ce-ed78-d2a9008bf654@sifive.com>
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


--r7fomtcfvjlx7yip
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 13, 2022 at 03:30:07PM +0100, Ben Dooks wrote:
> On 13/07/2022 14:52, Uwe Kleine-K=F6nig wrote:
> > On Wed, Jul 13, 2022 at 12:56:55PM +0100, Ben Dooks wrote:
> > > On 12/07/2022 23:17, Rob Herring wrote:
> > > > On Tue, Jul 12, 2022 at 11:01:09AM +0100, Ben Dooks wrote:
> > > > > The dwc pwm controller can be used in non-PCI systems, so allow
> > > > > either platform or OF based probing.
> > > > >=20
> > > > > Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>=20
> [snip]
>=20
> > > > > +properties:
> > > > > +  "#pwm-cells":
> > > > > +    description: |
> > > > > +      See pwm.yaml in this directory for a description of the ce=
lls format.
> > > >=20
> > > > pwm.yaml doesn't define how many cells. You need to. And you don't =
need
> > > > generic descriptions.
> > >=20
> > >   "#pwm-cells":
> > >      const: 1
> > >=20
> > > should be sufficient then?
> >=20
> > I would expect a value of (at least) 2 or (better) 3.
>=20
> OOPS, forgot the phandle.
>=20
> I will have to check if we have any support yet for dealing
> with any of the pwm flags yet.

I didn't double check, but given that the driver only supports inversed
polarity it might not even work without passing the flag for inversed
polarity. Having said that, I expect you have to only add "#pwm-cells =3D
<3>;" to your dts and then everything should work just fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--r7fomtcfvjlx7yip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLO38gACgkQwfwUeK3K
7AlmswgAiqMblcZKY2HC5SkMnNz6H6mHLNEgzeCkHIteMgyJPzS3xsuSjuwWz+3m
iA0HC08MY1I3nWzSTnnJjMakMX5dUIgn6Q95KVUSshSP2WHXX17DyOYwnZ18Du+0
hxvFsp6x1tOEuFbcMSzYSxVwDCXahYUszFVz22O9ieNBsxk3/tf1v17lD9+kq8qt
8YGnzYHLuL3m+7UENkVpqsXfDpWp2Nzshupq7g8TZFXfXX08lje5c7WK85q9JrKb
dhyk6VsWrCJa4yXoNKpEE2WTZ8VZbQPwYyK+wyNgx83zI4l6wLKpkRjo2+4gQm2q
0XbMxpCuONMAOhmV/BqzA46zdi6ggA==
=CVm7
-----END PGP SIGNATURE-----

--r7fomtcfvjlx7yip--

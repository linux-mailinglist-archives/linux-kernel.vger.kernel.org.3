Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1725573805
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbiGMNx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbiGMNw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:52:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E63710552
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:52:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBcn6-0007Lb-9G; Wed, 13 Jul 2022 15:52:36 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBcn5-000it0-54; Wed, 13 Jul 2022 15:52:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBcn4-004wNy-DQ; Wed, 13 Jul 2022 15:52:34 +0200
Date:   Wed, 13 Jul 2022 15:52:30 +0200
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
Message-ID: <20220713135230.gjbd3v6iih2uicpu@pengutronix.de>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
 <20220712100113.569042-4-ben.dooks@sifive.com>
 <20220712221715.GT1823936-robh@kernel.org>
 <feaacf44-f9a8-b892-d8ba-8a396b49d56b@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3hofxsieqbcumnqk"
Content-Disposition: inline
In-Reply-To: <feaacf44-f9a8-b892-d8ba-8a396b49d56b@sifive.com>
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


--3hofxsieqbcumnqk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 13, 2022 at 12:56:55PM +0100, Ben Dooks wrote:
> On 12/07/2022 23:17, Rob Herring wrote:
> > On Tue, Jul 12, 2022 at 11:01:09AM +0100, Ben Dooks wrote:
> > > The dwc pwm controller can be used in non-PCI systems, so allow
> > > either platform or OF based probing.
> > >=20
> > > Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> > > ---
> > >   .../devicetree/bindings/pwm/pwm-synposys.yaml | 40 ++++++++++++++
> >=20
> > Use compatible string for filename.
>=20
> ok, will fix.
>=20
> > >   drivers/pwm/Kconfig                           |  5 +-
> > >   drivers/pwm/pwm-dwc.c                         | 53 ++++++++++++++++=
+++
> > >   3 files changed, 96 insertions(+), 2 deletions(-)
> > >   create mode 100644 Documentation/devicetree/bindings/pwm/pwm-synpos=
ys.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/pwm/pwm-synposys.yaml =
b/Documentation/devicetree/bindings/pwm/pwm-synposys.yaml
> > > new file mode 100644
> > > index 000000000000..38ac0da75272
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pwm/pwm-synposys.yaml
> > > @@ -0,0 +1,40 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +# Copyright (C) 2022 SiFive, Inc.
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pwm/pwm-synposys.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Synopsys PWM controller
> > > +
> > > +maintainers:
> > > +   - Ben Dooks <ben.dooks@sifive.com>
> > > +
> > > +properties:
> > > +  "#pwm-cells":
> > > +    description: |
> > > +      See pwm.yaml in this directory for a description of the cells =
format.
> >=20
> > pwm.yaml doesn't define how many cells. You need to. And you don't need
> > generic descriptions.
>=20
>  "#pwm-cells":
>     const: 1
>=20
> should be sufficient then?

I would expect a value of (at least) 2 or (better) 3.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3hofxsieqbcumnqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLOzhsACgkQwfwUeK3K
7Am62Qf+L9AW+vafE1WIr4bBIe4Lm7ps4yWWhhUuZ+QOa9k+eiwk377vUZ0JOty4
aobS23SPOM4gC+g5GERQZFShXLEHJDnEMlVj3+dXMfTlmQsxatoLc51Of9My4XS7
1+SeH73rG2LrtTRr5AvmFM7dVxUsTZO5clWP3ROueytPiWSVyqs2ioFgCq6e1rlF
xBLzOYCdXwi5CllVnC1znliuv5CcuO7eewSWX09ifeBFrp1EvYr5IxoPe4ZIg6Yz
GFuZXIbPhAJZS/LFhrQNTAYLjzwz2xpBAA5BID9jeON9Uf0hqhtVnhtdsv3OFN7z
TM+PdAFvbek87NuBqneOjFzZaDBVKA==
=U4yZ
-----END PGP SIGNATURE-----

--3hofxsieqbcumnqk--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37A255441D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351946AbiFVHGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiFVHGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:06:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CB436B4F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:06:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3uRD-0004HY-5U; Wed, 22 Jun 2022 09:06:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3uR8-001z48-QP; Wed, 22 Jun 2022 09:06:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3uR9-000MZh-Dv; Wed, 22 Jun 2022 09:06:03 +0200
Date:   Wed, 22 Jun 2022 09:06:00 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, hvilleneuve@dimonoff.com,
        l.stach@pengutronix.de, abbaraju.manojsai@amarulasolutions.com,
        jagan@amarulasolutions.com, matteo.lisi@engicam.com,
        tharvey@gateworks.com, t.remmet@phytec.de, t.remmet@phytec.deh,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 00/14] arm64: dts: imx8mp: correct pad settings
Message-ID: <20220622070600.gb3wep7rltwdivkk@pengutronix.de>
References: <20220622061410.853301-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lubhnzxzir5q7thf"
Content-Disposition: inline
In-Reply-To: <20220622061410.853301-1-peng.fan@oss.nxp.com>
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


--lubhnzxzir5q7thf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jun 22, 2022 at 02:13:56PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> i.MX8MP iomux pad BIT3 and BIT0 are reserved bits. Writing 1 to the
> reserved bit will be ignored and reading will still return 0. Although
> function not broken with reserved bits set, we should not set reserved
> bits.

I wonder how you found these. Some time ago I wrote a tool for such
issues[1]. Currently it only supports i.MX25, i.MX6DL and i.MX6Q, but
extending it for the other SoCs should be only some industious effort.

Best regards
Uwe

[1] https://git.pengutronix.de/cgit/tools/dt-utils/tree/src/dtblint-imx-pin=
mux.c


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lubhnzxzir5q7thf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKyv1UACgkQwfwUeK3K
7Ak5tQf+OE38jVlL1zck0KGSrmTkCjS5+6rj/je/5cZayMomqkMUgZOntcQtpNkA
kmCVLSqHz0yu0zOAuHu0c0ka82B8le6jUvpC3LhbDpRnqeNXyBeMIR+U3AtlEpti
uAA4VECVjHRwHIHmIdQ9FWEA2M+sJCjcQrSl0Xa8JXWnPxEF5vJ8USbzV54ku/oc
yYvfLxwnoDrUVNN3APnAekj6O7JZLKGkCHe4SFr9wjeKMnPjH+L0t/uO6/Ype20z
bUbVGC5dnp0i2+2Fi4q72BtWZmwK6wrwbcCpbMWCbps0e+Q1EAJ/XGuOUfB3cEjG
6c0RlhF9h/FWG+hiZYCcdsoLGU32cg==
=57EK
-----END PGP SIGNATURE-----

--lubhnzxzir5q7thf--

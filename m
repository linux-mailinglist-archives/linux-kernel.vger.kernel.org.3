Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C117457CD3D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiGUOVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiGUOVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:21:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453FA255AA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:21:11 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oEX2p-0008Lg-Er; Thu, 21 Jul 2022 16:20:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oEX2o-002Kis-3x; Thu, 21 Jul 2022 16:20:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oEX2m-006bNr-RQ; Thu, 21 Jul 2022 16:20:48 +0200
Date:   Thu, 21 Jul 2022 16:20:30 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor.Dooley@microchip.com
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Daire.McNamara@microchip.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 3/4] pwm: add microchip soft ip corePWM driver
Message-ID: <20220721142030.yh7x3ebr2b4fcunc@pengutronix.de>
References: <20220712142557.1773075-1-conor.dooley@microchip.com>
 <20220712142557.1773075-4-conor.dooley@microchip.com>
 <c49776c2-4807-91c1-010a-a33bd98b68b7@microchip.com>
 <ee05749f-c33f-3505-4309-f4d036de92a1@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4suvbrt6oxi7xwmi"
Content-Disposition: inline
In-Reply-To: <ee05749f-c33f-3505-4309-f4d036de92a1@microchip.com>
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


--4suvbrt6oxi7xwmi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jul 21, 2022 at 11:05:54AM +0000, Conor.Dooley@microchip.com wrote:
> Should I resubmit now with the warnings fixed?
> It is a pair of unused-result on the mutexes & a unused-variable so
> they should not have much of an impact on any review you would give
> for this version.

Don't wait for me to find the time to look. If you have some pending
changes I prefer not to look at the series with known drawbacks.

So fire at will.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4suvbrt6oxi7xwmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLZYKUACgkQwfwUeK3K
7AkxQQf8CGigHoaGeRlvc6ke1AQFqpgAqUiMm4kG+jUXB8lI6Y445+UNkGE+UGgB
Vzg1MpwRfqXPyOgCpA4BKA1iQRL9D1qk/nwtzb0slAUS0nBscMOSLb5Qd78JQvuJ
x/8JKAQ0ivFmPk9CxGK4RkFqczhCZtP5zfHNd6HEA6DNSEebfDnnUTuO0yj5vfnF
UTjccjTv3ziVf2k6d0oyv9gpgtAzFEanFoUTSI3dV26+C+8xubZKKfAqVPuXny+8
eA712nmjtz5f5RPyxSsPHeytpE+kRNVG4InAI5m8FcOGkMhoM4mHGWQNxfn7O4mR
g4YP+IGhny0+Panxk5OvAZ69xSHUGw==
=7gkN
-----END PGP SIGNATURE-----

--4suvbrt6oxi7xwmi--

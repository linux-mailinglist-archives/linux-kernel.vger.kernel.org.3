Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AD55391C2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238008AbiEaNWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344746AbiEaNV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:21:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A11229826
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:21:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nw1oi-0000fa-7H; Tue, 31 May 2022 15:21:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nw1oi-005efT-S7; Tue, 31 May 2022 15:21:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nw1og-00DJcI-RM; Tue, 31 May 2022 15:21:46 +0200
Date:   Tue, 31 May 2022 15:21:46 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 2/2] pwm: mediatek: add MT8365 support
Message-ID: <20220531132146.2zgqda4krzinpnjz@pengutronix.de>
References: <20220530205038.917431-1-fparent@baylibre.com>
 <20220530205038.917431-2-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vghzb7bo5uqxchra"
Content-Disposition: inline
In-Reply-To: <20220530205038.917431-2-fparent@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vghzb7bo5uqxchra
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 30, 2022 at 10:50:38PM +0200, Fabien Parent wrote:
> Add support for PWM on MT8365
>=20
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

looks reasonable

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vghzb7bo5uqxchra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKWFmgACgkQwfwUeK3K
7Alc5wgAhtJ1RC3404iVoUzmztvxCsqFqWXCCs7ABL7F4nca8vj+sLX6wtYzYwLR
o1Jxc8nRei/tSuMbWz0XEUS479GGdFs3+XATIdc1QzSGsR9cXShBtec+cywRSNrN
uRAJMb+BSx0exbP8LyUx4zDNkrL1HHsd3nwKtR8FGf0FrQxe+Qtv63o/BMpdhWr6
LZ3Qq3qg5bZ+DdJlqnlXDNC7AYxmE5e+Hl1nZs0g0oSxG628nJ5MbGhoL6ubmPhk
FEMNgX35Fr9Kz6IHYfSWeBU2RAeU/xHCZRpaLq0JZx5i1L/GKOeTatx3yaWk4HQZ
Yl7UcqI+LDiOEWSeNs+RuGSpZbfu1w==
=4/fJ
-----END PGP SIGNATURE-----

--vghzb7bo5uqxchra--

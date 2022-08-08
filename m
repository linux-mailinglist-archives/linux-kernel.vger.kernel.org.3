Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E21B58C48F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 10:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbiHHIDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 04:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiHHIDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 04:03:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFCE13D73
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 01:03:35 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oKxjI-00013K-AU; Mon, 08 Aug 2022 10:03:16 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 45B26C45C4;
        Mon,  8 Aug 2022 08:03:12 +0000 (UTC)
Date:   Mon, 8 Aug 2022 10:03:10 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add PolarFire SoC dt bindings
Message-ID: <20220808080310.ets2zqhgjbymajkx@pengutronix.de>
References: <20220805134908.749935-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="akuyayyjxuecv7hz"
Content-Disposition: inline
In-Reply-To: <20220805134908.749935-1-conor.dooley@microchip.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
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


--akuyayyjxuecv7hz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.08.2022 14:49:09, Conor Dooley wrote:
> So far when I added bindings for the platform I never added them to
> our MAINTAINERS entry. No time like the present to improve the coverage.
>=20
> Suggested-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> I have another maintainers change queued, I'll send this via soc along
> with it unless there are any objections.
>=20
> CC: Mark Brown <broonie@kernel.org>
> CC: Wolfram Sang <wsa@kernel.org>
> CC: Thierry Reding <thierry.reding@gmail.com>
> CC: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> CC: Jassi Brar <jassisinghbrar@gmail.com>
> CC: Linus Walleij <linus.walleij@linaro.org>
> CC: Bartosz Golaszewski <brgl@bgdev.pl>
> CC: Wolfgang Grandegger <wg@grandegger.com>
> CC: Marc Kleine-Budde <mkl@pengutronix.de>

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de> # for can

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--akuyayyjxuecv7hz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLwwzwACgkQrX5LkNig
013l+wgApwvDL8b9qW0m6aPWs7WXpXGzFfqR5PZFh+o3IpIYaQurj3KbQ9S0rSRP
iRq2vTbwdn/9aVMaiXRGm0ueJ0MJbZ4qLXQlUQ3ZCvC41Laobgm6AXaZwerwrINe
sCQm+ruJUoVvf2I7zDEjYx1OaCrIS8slPOHXHnN2EZk+PqNzXuKy3BShRACjsAyw
SKxCgmfoiKlSTM+nEw6QOmEkPKHf2Nz6aqmOeNNVZ7wocMU8jmwYdBMrK1X2fNpQ
xXNUFTRALOW/CS/dLohurp5hpnBzzufYu/mO8hCDCfgSSdF25ZjzJWhYE3YdORTO
11gCmKQ41hHEz92LOr94vyPPl0QfZg==
=udbm
-----END PGP SIGNATURE-----

--akuyayyjxuecv7hz--

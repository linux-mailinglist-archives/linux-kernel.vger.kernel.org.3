Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE11D4B8F93
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbiBPRn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:43:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbiBPRnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:43:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2752B1007
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:43:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nKOKr-0002mV-1E; Wed, 16 Feb 2022 18:43:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nKOKn-00H0SM-3Z; Wed, 16 Feb 2022 18:43:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nKOKl-003bGa-LT; Wed, 16 Feb 2022 18:43:19 +0100
Date:   Wed, 16 Feb 2022 18:43:19 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        alexandre.belloni@bootlin.com, mcoquelin.stm32@gmail.com,
        richard.genoud@gmail.com, festevam@gmail.com,
        s.hauer@pengutronix.de, linux@armlinux.org.uk,
        nicolas.ferre@microchip.com, alexandre.torgue@foss.st.com,
        ludovic.desroches@microchip.com, lukas@wunner.de,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-serial@vger.kernel.org, shawnguo@kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2 7/9] serial: imx: remove redundant assignment in
 rs485_config
Message-ID: <20220216174319.rajioisll5b5pfpe@pengutronix.de>
References: <20220216001803.637-1-LinoSanfilippo@gmx.de>
 <20220216001803.637-8-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="da2lbr7flv5tn5tr"
Content-Disposition: inline
In-Reply-To: <20220216001803.637-8-LinoSanfilippo@gmx.de>
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


--da2lbr7flv5tn5tr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 16, 2022 at 01:18:01AM +0100, Lino Sanfilippo wrote:
> In uart_set_rs485_config() the serial core already assigns the passed
> serial_rs485 struct to the uart port.
>=20
> So remove the assignment in the drivers rs485_config() function to avoid
> reduncancy.
>=20
> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--da2lbr7flv5tn5tr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmINN7QACgkQwfwUeK3K
7AlQGAf/ac6fGA3JlB+w+RAXYkZDqG//NDFsdlUzOp7B8hIJ80nDvlVkn9v/gp57
rMUw1/NgNSpn7hyc+3oy9WKurjdN9U2jBd9aIjas2NT5aWJv+AOOmere37nv5N0O
1PUkAm33WZ4vgu9ldLE3al/zvpxjJghaycEZx7+Udtgu7NjtnkMus8XqDQ1TEx6D
RaucYDkywS0Um62zqye+r9kHxEA9wBvdrsHPRf0cw0SpjU01SQ002+zfgpw0BZNh
R+Bmr8a/V6ays42x/njh9U5yNI/vJ4xWWMdZUfSz9u9UYTwArtJlh/hid7FQp6AK
e0RXvaXZKEdVXnU6KKl4m8SoamPP5g==
=S/7p
-----END PGP SIGNATURE-----

--da2lbr7flv5tn5tr--

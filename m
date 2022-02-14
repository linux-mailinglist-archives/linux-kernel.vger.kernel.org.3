Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6224B427E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241247AbiBNHH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:07:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiBNHHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:07:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16F2580D8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 23:07:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJVRQ-0005fD-S8; Mon, 14 Feb 2022 08:06:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJVRK-00GUcs-Oc; Mon, 14 Feb 2022 08:06:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJVRJ-002o8C-8b; Mon, 14 Feb 2022 08:06:25 +0100
Date:   Mon, 14 Feb 2022 08:06:22 +0100
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
Subject: Re: [PATCH 1/9] serial: core: move RS485 configuration tasks from
 drivers into core
Message-ID: <20220214070622.rz5cv6yy3aarvrjv@pengutronix.de>
References: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
 <20220213222737.15709-2-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5shxigssusof4hd3"
Content-Disposition: inline
In-Reply-To: <20220213222737.15709-2-LinoSanfilippo@gmx.de>
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


--5shxigssusof4hd3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 13, 2022 at 11:27:29PM +0100, Lino Sanfilippo wrote:
> Several drivers that support setting the RS485 configuration via userspace
> implement on or more of the following tasks:

s/on/one/

>=20
> - in case of an invalid RTS configuration (both RTS after send and RTS on
>   send set or both unset) fall back to enable RTS on send and disable RTS
>   after send
>=20
> - nullify the padding field of the returned serial_rs485 struct
>=20
> - copy the configuration into the uart port struct
>=20
> - limit RTS delays to 100 ms
>=20
> Move these tasks into the serial core to make them generic and to provide
> a consistent beheviour among all drivers.

s/beheviour/behaviour/

> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> ---
>  drivers/tty/serial/serial_core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 846192a7b4bf..3fab4070359c 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1282,8 +1282,21 @@ static int uart_set_rs485_config(struct uart_port =
*port,
>  	if (copy_from_user(&rs485, rs485_user, sizeof(*rs485_user)))
>  		return -EFAULT;
> =20
> +	/* pick sane settings if the user hasn't */
> +	if (!(rs485.flags & SER_RS485_RTS_ON_SEND) =3D=3D
> +	    !(rs485.flags & SER_RS485_RTS_AFTER_SEND)) {
> +		rs485.flags |=3D SER_RS485_RTS_ON_SEND;
> +		rs485.flags &=3D ~SER_RS485_RTS_AFTER_SEND;
> +	}
> +	/* clamp the delays to [0, 100ms] */
> +	rs485.delay_rts_before_send =3D min(rs485.delay_rts_before_send, 100U);
> +	rs485.delay_rts_after_send =3D min(rs485.delay_rts_after_send, 100U);
> +	memset(rs485.padding, 0, sizeof(rs485.padding));
> +
>  	spin_lock_irqsave(&port->lock, flags);
>  	ret =3D port->rs485_config(port, &rs485);
> +	if (!ret)
> +		port->rs485 =3D rs485;

I was only Cc:d for the imx patch (patch #7) and tried to verify the
claim there that "the serial core already assigns the passed
configuration to the uart port". That failed when I looked at my kernel
tree.

So it would be great, if you sent dependencies (or at least a cover
letter) to all recipients of a given patch to ease review. Also I want
to suggest to mention uart_set_rs485_config() in the commit log of the
imx patch (and probably the others) to simplify verifying the claim
there.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5shxigssusof4hd3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIJ/2sACgkQwfwUeK3K
7AkxRwf/b3f/DboNsFG5mzr/yWa7KUZT9A+zxiz+7iI+Gl/R3UndBgCYH0G4WnLL
7MwSMvP+oKUYgZqWLQ+EO/B4cr+mIwjxaqmcKzRuz26E9FsPaDfvuyLW/vqvEBBQ
ivXeHn3Uwr7DFKixX67XUwThUqxuxe40AV24L7Hm7F/Z8RkwwtAL/hlH8a4qLet/
xL4BpeVAAFzCrorg+mwjwQx3LQrHyvft1z/4HuWiI6UBQ23O3ZIYC7uL3EURLbmT
eLKoFaLA/zjjdDWfFEPseb+D9ve5ek+PA/PPOUBr1zPFHo4GJSOFT+In/LJ5KKxG
cI48t2esb6pZZCOf/2kwqdevzevzdA==
=Yr+Q
-----END PGP SIGNATURE-----

--5shxigssusof4hd3--

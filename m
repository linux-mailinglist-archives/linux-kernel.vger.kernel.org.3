Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870355474DB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 15:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbiFKNiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 09:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiFKNiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 09:38:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FE5BF8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 06:37:59 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o01JK-0003pT-1Q; Sat, 11 Jun 2022 15:37:54 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id ADE5092DB9;
        Sat, 11 Jun 2022 13:31:32 +0000 (UTC)
Date:   Sat, 11 Jun 2022 15:31:32 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Max Staudt <max@enpas.org>
Cc:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220611133132.bqxlnqwp53qq6qor@pengutronix.de>
References: <20220602213544.68273-1-max@enpas.org>
 <CAMZ6RqLLn3tE6kPd+yyHURsbBU_jVKN=u4=YvhZVyAf_NyRqCQ@mail.gmail.com>
 <CAMZ6RqKM7Z3GzO6vKyWf7D1z=HvJBN2QaZz1==LBsEJKjz=Qag@mail.gmail.com>
 <20220611151649.5a9c5676.max@enpas.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jrfniq2pzy2znubv"
Content-Disposition: inline
In-Reply-To: <20220611151649.5a9c5676.max@enpas.org>
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


--jrfniq2pzy2znubv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.06.2022 15:16:49, Max Staudt wrote:
> On Sat, 4 Jun 2022 00:47:10 +0900
> Vincent Mailhol <vincent.mailhol@gmail.com> wrote:
>=20
> > > > +#define ELM327_CAN_CONFIG_SEND_SFF           0x8000
> > > > +#define ELM327_CAN_CONFIG_VARIABLE_DLC       0x4000
> > > > +#define ELM327_CAN_CONFIG_RECV_BOTH_SFF_EFF  0x2000
> > > > +#define ELM327_CAN_CONFIG_BAUDRATE_MULT_8_7  0x1000 =20
> >=20
> > This ELM327_CAN_CONFIG_BAUDRATE_MULT_8_7 macro is not used.
>=20
> True. It does document a flag in the ELM327 configuration registers
> though, and it was originally meant for adding 7/8 bitrates (e.g. 87500
> as a companion to 100000). I never got around to implementing those
> bitrates, though.
>=20
> I find opportunistic documentation helpful for future reference and
> to give casual readers hints - can I leave it in there anyway, or is it
> deemed an eyesore?

IMHO leave it in the driver.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--jrfniq2pzy2znubv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKkmTEACgkQrX5LkNig
012h1QgArRe6Ygprzy/rsgBoX66oIX4v1SxjMrPdlWyVML0O/vf6sAB/Th1Ujp4/
baciutN59F4rlC5D6bAP4n2UUKTBWiUAdNpa/sV/eKKr5AQGWEKxWIqHcOsuFBDc
LlQh0/UitfSFtjUGHeJxUjqHUjKxJnNuRGCgRf+iD4O9M7bgwOH2y3RM7ddrke0p
22qVHJ/dT1/Lc7jF6gMEZPAsOiDqvC1l3PswcBXwE9ea1N9wka0eIRPtLaH16MZN
/2UPlH4kf1knS6P73LTFt2ooWNGze3ff9gQJoSiGqNOGJWpCWX4TmPNtzcqHGwtm
N6uj88rAOwikrggsjEQO+jjSOwhZMg==
=edMq
-----END PGP SIGNATURE-----

--jrfniq2pzy2znubv--

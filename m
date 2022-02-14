Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B141C4B59D5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 19:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357429AbiBNSXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:23:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357448AbiBNSXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:23:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD4460ABE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:23:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJg0S-00063J-6p; Mon, 14 Feb 2022 19:23:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJg0K-00GbDc-9H; Mon, 14 Feb 2022 19:23:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJg0I-003BDB-Qj; Mon, 14 Feb 2022 19:23:14 +0100
Date:   Mon, 14 Feb 2022 19:23:11 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     alexandre.belloni@bootlin.com, festevam@gmail.com,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        richard.genoud@gmail.com, gregkh@linuxfoundation.org,
        s.hauer@pengutronix.de, linux@armlinux.org.uk,
        nicolas.ferre@microchip.com, alexandre.torgue@foss.st.com,
        ludovic.desroches@microchip.com, lukas@wunner.de,
        linux-imx@nxp.com, mcoquelin.stm32@gmail.com,
        linux-serial@vger.kernel.org, shawnguo@kernel.org,
        jirislaby@kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/9] serial: core: move RS485 configuration tasks from
 drivers into core
Message-ID: <20220214182311.xaxkdgw5x66vubvv@pengutronix.de>
References: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
 <20220213222737.15709-2-LinoSanfilippo@gmx.de>
 <20220214070622.rz5cv6yy3aarvrjv@pengutronix.de>
 <edbb9e1d-bed4-0850-08f4-029c4fcbfd5c@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5yzygnvea2gsyqvu"
Content-Disposition: inline
In-Reply-To: <edbb9e1d-bed4-0850-08f4-029c4fcbfd5c@gmx.de>
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


--5yzygnvea2gsyqvu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lino,

On Mon, Feb 14, 2022 at 04:09:53PM +0100, Lino Sanfilippo wrote:
> On 14.02.22 at 08:06, Uwe Kleine-K=F6nig wrote:
> > I was only Cc:d for the imx patch (patch #7) and tried to verify the
> > claim there that "the serial core already assigns the passed
> > configuration to the uart port". That failed when I looked at my kernel
> > tree.
> >
> > So it would be great, if you sent dependencies (or at least a cover
> > letter) to all recipients of a given patch to ease review. Also I want
> > to suggest to mention uart_set_rs485_config() in the commit log of the
> > imx patch (and probably the others) to simplify verifying the claim
> > there.
>=20
> Thanks for the review, I will correct the typos in the next version.
> I will also cc you directly for the next version if you dont mind.

I don't mind. I get so many patches by mail, I'm good at ignoring them
;-)

> get_maintainers only spit out "Pengutronix Kernel Team" so I used that
> address for the whole series (including the cover letter).

That's why I eventually found the whole series and could reply to patch
#1.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5yzygnvea2gsyqvu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIKngwACgkQwfwUeK3K
7An98wf/bBKlqhAAMwMSKVu53e8nF1ZTSQ/QjAhBecE3mD4HgqyKTzgmzkKeHYFj
KFZpNW2T05fcPMre0otOoR+7X1a2jOMv9lg2c11F6zor06DU6+RrIbtgMuzCFKJW
tpM9//kD8f+OcUSESal/ZRzAS683pu+nO0x2N06+h4kRiUVfb6y2UToQhiCniQjO
PtPtboM3S+ZistvDYzuo2sVXaYA7C8pTcGVbY8fO2dhWqvbwb//kIQt3ZsFvDnhj
g8xi+7QVAJvKcQy9FpB0SKAcCpIx/gy+AnoezVMbbshQejDbrVQ+SYPq7wtka2PB
L9NSe4gLIQM2kMMxpd8Fprm67oy+Rw==
=KXKx
-----END PGP SIGNATURE-----

--5yzygnvea2gsyqvu--

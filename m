Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CD4526154
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380019AbiEMLqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380014AbiEMLqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:46:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD3353737
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:46:49 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1npTkr-0007eF-0E; Fri, 13 May 2022 13:46:45 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0503D7D95B;
        Fri, 13 May 2022 11:46:42 +0000 (UTC)
Date:   Fri, 13 May 2022 13:46:42 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220513114642.77jfdscjwzgyiwm3@pengutronix.de>
References: <20220512182921.193462-1-max@enpas.org>
 <CAMZ6Rq+BwL1NPTLtC5sQAd4z1Kc1TFJPPoW-i+0RZ5dnFaWYiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m3okyqmyt2uyv2he"
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+BwL1NPTLtC5sQAd4z1Kc1TFJPPoW-i+0RZ5dnFaWYiw@mail.gmail.com>
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


--m3okyqmyt2uyv2he
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13.05.2022 11:38:31, Vincent Mailhol wrote:
> > +static void elm327_parse_line(struct can327 *elm, size_t len)
> > +{
> > +       lockdep_assert_held(&elm->lock);
>=20
> You are using many of those lockdep_assert_held(&elm->lock);
>=20
> I guess you put them for debug purpose and probaly some of those can
> be removed (if you see a genuine risk at some places, then OK to keep
> as a safety net, but a bit of clean up can be done here, I think).
>=20
> This comment applies to all use of lockdep_assert_held().

These statements document that the code must be called with the lock
held. They optimize away if lockdep is not enabled. Better keep them in
place.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--m3okyqmyt2uyv2he
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJ+RSAACgkQrX5LkNig
012MwwgAm4xVfAxO42VZQ8ps/XQLvThpyouR3oifOiYnXEGYdIaIqDgPWxvWBJIV
wmj8CBnW2CePSkFQofw8tkT1RH1wSyLf8vPzvOPpXkFAlLT5PbAq86cfeyRxyR8L
0jPsGPrRYnQtYQ/tLMqPaCOVypsndd+kAYZGSzRkvzTiroKtgeTNbKZUYwTjvcbG
rcbFsPNNJjizATaINWrR+C9irJ6E3KPixRAI/3/dn4Xt6uVEJweGGHzm/sciyczz
1TvdOsU3f0rRJ3Xh0zbc9dQRWl5npYUaA2CMBeZu9rm/J5amgmxf2EA9YTtc0YiW
7Wz3qq3BmSoUKqmoZCca4aSwCKilPA==
=K50O
-----END PGP SIGNATURE-----

--m3okyqmyt2uyv2he--

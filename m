Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3131254778C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 22:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiFKUk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 16:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiFKUk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 16:40:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D326BFDF
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 13:40:55 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o07ud-0004up-4j; Sat, 11 Jun 2022 22:40:51 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C391992FE2;
        Sat, 11 Jun 2022 20:40:49 +0000 (UTC)
Date:   Sat, 11 Jun 2022 22:40:49 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Max Staudt <max@enpas.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: Break loopback loop on loopback documentation
Message-ID: <20220611204049.vl2axh226ypf62x3@pengutronix.de>
References: <20220611171155.9090-1-max@enpas.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rcew5lslwr33jarn"
Content-Disposition: inline
In-Reply-To: <20220611171155.9090-1-max@enpas.org>
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


--rcew5lslwr33jarn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.06.2022 19:11:55, Max Staudt wrote:
> There are two sections called "Local Loopback of Sent Frames".
> One was meant to link to the other, but pointed at itself instead.
>=20
> Signed-off-by: Max Staudt <max@enpas.org>

Applied to can-next/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--rcew5lslwr33jarn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKk/c4ACgkQrX5LkNig
010BFAf9Gr8nlz3GXNO34KOOpJrQ6/tKNEJDztmq8GKY2Q0saDHMhpaNeJn1w70L
MUG2Z/w4UZC68sofUIxyP6JAkZ5w7Wm1KjIZuO4DaIuqp8WTXbm38oct2ICXyKlk
WlzZvymHlyJYlqd9zeO29FGnarsKIvdGC7IwWLZ6GCW5jXT61Vg9z7YFZSiVob8C
buwHllXaxthJrY5xTIXArUYOF9W+KXEICiTXZVTz+umWtoQw8pyBMJtPY+0JzaTX
03HjT1nieiHHITFSR6Hz0XGLhibvWOqfM3c0CzIpQ8e9ZmWU4KZ4wvYCqED7kc6U
Tka/6O7cNcpCDM/CafOchODQjQ4aSA==
=Am4J
-----END PGP SIGNATURE-----

--rcew5lslwr33jarn--

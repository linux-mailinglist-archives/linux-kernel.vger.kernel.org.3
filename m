Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848C6550946
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 10:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiFSIGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 04:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiFSIGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 04:06:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C79811153
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 01:06:09 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o2pwY-0007GD-IL; Sun, 19 Jun 2022 10:06:02 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-83f1-6e60-bc5c-b382.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:83f1:6e60:bc5c:b382])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 818E09957B;
        Sun, 19 Jun 2022 08:05:59 +0000 (UTC)
Date:   Sun, 19 Jun 2022 10:05:59 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Max Staudt <max@enpas.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: Add N_CAN327 line discipline ID for ELM327 based
 CAN driver
Message-ID: <20220619080559.v5mhhma2zgnnkwa7@pengutronix.de>
References: <20220618180134.9890-1-max@enpas.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="owpoekinhglksnf6"
Content-Disposition: inline
In-Reply-To: <20220618180134.9890-1-max@enpas.org>
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


--owpoekinhglksnf6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.06.2022 20:01:34, Max Staudt wrote:
> The actual driver will be added via the CAN tree.
>=20
> Signed-off-by: Max Staudt <max@enpas.org>

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--owpoekinhglksnf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKu2OQACgkQrX5LkNig
011aaAf/Y6ZBjHfzzzO+sookX7gHRQXDSsurd9/TaxqKOoA1Jxkb/Ki0D889anAR
BIe1exkLt60uaEKMsIXYWNAYGajbWNE6HohisRiDDSIlA5GD0IGPqNVhbiXXOuw1
crN+l1CoqG6J+a2uhURhPVa8LrGAjwodIUqI3OSsouDXtEcSl9or+hrOFITmTgYf
KT4aB4OozinoiRIjQAchGsBhoUFO0N1nLMm6uXWImWB3vhGd5z0L93Thrzg2Q4yB
MzoS/2tDBcLDgwsMU2SAVb4o+R9kTpBUN8ZqM3Up7kB6GERo1VHJIlXgyO+LmpEU
YAX4d/SwpKodjRlhwK4R18wJWBTfCA==
=8C5C
-----END PGP SIGNATURE-----

--owpoekinhglksnf6--

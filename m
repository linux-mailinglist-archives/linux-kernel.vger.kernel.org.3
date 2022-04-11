Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8234FBBDA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345974AbiDKMRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241594AbiDKMQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:16:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8614B40E62
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:14:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ndsw7-0003bV-RC; Mon, 11 Apr 2022 14:14:27 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ndsw6-002No1-JO; Mon, 11 Apr 2022 14:14:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ndsw4-002b3w-7w; Mon, 11 Apr 2022 14:14:24 +0200
Date:   Mon, 11 Apr 2022 14:14:24 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: Re: [PATCHv2] serial: 8250: Fix runtime PM for start_tx() for empty
 buffer
Message-ID: <20220411121424.7pc3jjsqglxbfakt@pengutronix.de>
References: <20220411111657.16744-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gesvtf2gmiko2n45"
Content-Disposition: inline
In-Reply-To: <20220411111657.16744-1-tony@atomide.com>
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


--gesvtf2gmiko2n45
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2022 at 02:16:57PM +0300, Tony Lindgren wrote:
> Commit 932d596378b0 ("serial: 8250: Return early in .start_tx() if there
> are no chars to send") caused a regression where the drivers implementing
> runtime PM stopped idling. This is because serial8250_rpm_put_tx() is now
> unbalanced on early return, it normally gets called at __stop_tx().
>=20
> Fixes: 932d596378b0 ("serial: 8250: Return early in .start_tx() if there =
are no chars to send")
> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks for cleaning up behind me,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gesvtf2gmiko2n45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJUG50ACgkQwfwUeK3K
7AnyNQgAm9+Gx+Zu14wbYB/VB5sPoHur0onFhMVLygQZZ19CEy8drNGl3RlwEVgI
XePEBiYTTPSIicfnlKt5iUJ3na0sw0a2P9cuusLA20Uh6wvJ0MBDWwtOqxNxANAT
ruMELsGXugkGKuNUr4xZC03zaFMWEl7/iCHnZkDC+h/ZlNYQ94myvHKNxFD6BY/u
fjCsGzty90/ymOqYnxcn4aDHd5l0LkWG5Et3qM+YfG73RyAx1tNyWWN55rW6dCWV
BtEi4oVpj6NFJlR1egUDpr9Ezckj98YxTyYTK5bvBWsVtt3dy0KVoXDvDQ1Q+W4Q
KxBkdQgC6J6iwrTdH3+zF/3O/hXA1A==
=xXFf
-----END PGP SIGNATURE-----

--gesvtf2gmiko2n45--

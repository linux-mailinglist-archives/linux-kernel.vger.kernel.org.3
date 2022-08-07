Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E738C58BA5C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 11:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbiHGJDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 05:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbiHGJDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 05:03:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA90565FE
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 02:03:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKcBZ-0002vK-K8; Sun, 07 Aug 2022 11:03:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKcBW-002GU6-Kk; Sun, 07 Aug 2022 11:03:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKcBY-00A7GQ-3d; Sun, 07 Aug 2022 11:03:00 +0200
Date:   Sun, 7 Aug 2022 11:03:00 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 3/4] pwm: sysfs: Replace sprintf() with sysfs_emit()
Message-ID: <20220807090300.7fvyqda32ikzehhz@pengutronix.de>
References: <20220806212331.40086-1-andriy.shevchenko@linux.intel.com>
 <20220806212331.40086-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6jluiwfmhef7epht"
Content-Disposition: inline
In-Reply-To: <20220806212331.40086-3-andriy.shevchenko@linux.intel.com>
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


--6jluiwfmhef7epht
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Aug 07, 2022 at 12:23:30AM +0300, Andy Shevchenko wrote:
> For sysfs outputs, it's safer to use a new helper, sysfs_emit(),
> instead of the raw sprintf() & co. This patch replaces such a
> sprintf() call straightforwardly with the new helper.

TIL!

There is no actual harm in using sprintf, but for consistency and to
provide a good reference for copying, conversion to sysfs_emit() seems
sensible.

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6jluiwfmhef7epht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLvf8EACgkQwfwUeK3K
7AnNUAf+MvaCnyKLUe/exC8B7cbzoNrDN4rNnDaWApnZbm2hvPFiH4IS4eJ44ymk
kvNB7m2+sXcrLGTgVJgjmylWTPdnvYpkDx19q6LlqghE+k+DLCCsUA5qiIw+ZOaQ
9wdYOiwARLgHKoW5dtAyXOmn3eqzH+RjNAWZwKd9qQ8IQFltgJwVQ0XyquOBmmEx
uXmCk2RpWoA9lr0ZWy4LzUHeP3qmjAefOMY78/njomaDvjM2OlGmKot7YtYerGFn
9+8oVqR2LQCPlXz5IbyvOB5hemHgj7G85C1Mb72LrtgzjOBDc0BTrIGWwVzp17EN
5m6/fY8NJChKInPK0XRLjVu7cBr96g==
=dy+P
-----END PGP SIGNATURE-----

--6jluiwfmhef7epht--

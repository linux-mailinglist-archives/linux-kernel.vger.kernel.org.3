Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA79451D205
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389424AbiEFHPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389409AbiEFHP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:15:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115D266CA0
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:11:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nmrmX-0000sR-Qk; Fri, 06 May 2022 08:49:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nmrmO-000egL-IQ; Fri, 06 May 2022 08:49:31 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nmrmM-007tsw-Dy; Fri, 06 May 2022 08:49:30 +0200
Date:   Fri, 6 May 2022 08:49:27 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     lizhe <sensor1010@163.com>
Cc:     lee.jones@linaro.org, fthain@linux-m68k.org,
        akrowiak@linux.ibm.com, pasic@linux.ibm.com, jjherne@linux.ibm.com,
        freude@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, zbr@ioremap.net, perex@perex.cz,
        tiwai@suse.com, bvanassche@acm.org, dan.j.williams@intel.com,
        srinivas.kandagatla@linaro.org, wens@csie.org,
        colin.king@intel.com, hare@suse.de, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] kernel/drivers: Remove redundant driver match function
Message-ID: <20220506064927.7y7a422jqbse22fr@pengutronix.de>
References: <20220506045952.136290-1-sensor1010@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o5fzikc3dnjeidfk"
Content-Disposition: inline
In-Reply-To: <20220506045952.136290-1-sensor1010@163.com>
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


--o5fzikc3dnjeidfk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, May 05, 2022 at 09:59:52PM -0700, lizhe wrote:
> If there is no driver match function, the driver core assumes that each
> candidate pair (driver, device) matches, see driver_match_device().
>=20
> Signed-off-by: lizhe <sensor1010@163.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig.org>

Side note: While looking through this patch I was surprised to see there
are two different busses for ac97: sound/ac97/bus.c + sound/ac97_bus.c .
It seems the duplication exists since 2017.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--o5fzikc3dnjeidfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJ0xPQACgkQwfwUeK3K
7Ak9lwf+LvgkLmWcst9CMzoJ2w5AdNZjtnWS36MvuyEFgHUH2e6lrfReaAAj9LGp
1EPinO6S6UBPvzVTbTVcduAlnaWER3O6XDIiS1b0Z2NOchX6AHUfHjQzckmL7ZU6
6W3P8jmVsNgbwmD2NXh98qjpmKMnmw56AjbBfYKSM1jWGookg2NUKkvN5175wSnQ
FNAIVdMaTspMZKRJU8bhkXSCARu9oAYn88U3QFUsgfzRK4KZu3UfqU75+QZjAzE3
q7A4nOBFl0GHZUE/kQMPWdYm1OgPbvxaDYz2DmWN+7Dqc+0HkUUYYeATdYs8OUO0
SBdhfXzll9P8xFZvdeusA+8B6DgGYg==
=nsQs
-----END PGP SIGNATURE-----

--o5fzikc3dnjeidfk--

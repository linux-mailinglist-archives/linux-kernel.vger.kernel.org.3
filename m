Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B840A4B0763
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbiBJHk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:40:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbiBJHk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:40:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B97C58
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 23:40:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nI44S-0000X2-8R; Thu, 10 Feb 2022 08:40:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nI44Q-00FfMG-KB; Thu, 10 Feb 2022 08:40:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nI44P-00EEQc-7S; Thu, 10 Feb 2022 08:40:49 +0100
Date:   Thu, 10 Feb 2022 08:40:46 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     zhaoxiao <zhaoxiao@uniontech.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: vt8500: Rename variable pointing to driver private
 data
Message-ID: <20220210074046.vxskduecvgiehvnl@pengutronix.de>
References: <20220209064755.7287-1-zhaoxiao@uniontech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fyuwep3g3kqdbwyv"
Content-Disposition: inline
In-Reply-To: <20220209064755.7287-1-zhaoxiao@uniontech.com>
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


--fyuwep3g3kqdbwyv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 09, 2022 at 02:47:55PM +0800, zhaoxiao wrote:
> Status quo is that variables of type struct vt8500_chip * are named
> "pwm", "chip" or "pc". The two formers are all not optimal because

There are no variables named "pwm" or "pc".

> usually only struct pwm_device * variables are named "pwm" and "chip" is
> usually used for variabled of type struct pwm_chip *.
>=20
> So consistently use the same and non-conflicting name "pc".

The intention is fine, but you missed a few instances that are named
"vt8500". The statistic in mainline looks as follows:

	$ git grep -o -h -E 'struct vt8500_chip \*[a-zA-Z0-9_]*' linus/master driv=
ers/pwm/pwm-vt8500.c | sort | uniq -c
	      2 struct vt8500_chip *chip
	      5 struct vt8500_chip *vt8500

(So there 2 variabled named "chip" (that you renamed to "pc") and 5 that
are named "vt8500". I prefer to rename the "chip"s to "vt8500".

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fyuwep3g3kqdbwyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIEwXsACgkQwfwUeK3K
7AmJmwf4pLI+xky/sNclDRJg2Ypliqo7er293BmkpQULSlxeCTscd0Cl5DAuPzu5
EqieGUMK5TWQXrCzmByT4/DZMdAVZKD/MS562QMmt31ZO+qyGFiT52iFAShqqDbv
KHE48UL7Qx3z3lTl3BLW/kDAanm24DtzQA5q6jT3EWko1HGbmM94Lk6xOfj0CgG1
I0seC3QwNugGJ79qjwkbb+bHCcMo2JGkMTFPPy7mibkfx5l5MnbPWLYU7uJHdR5w
A7ynb5iknN/OxjrbVv0/r8B9+PWN0uOWRVOCNGiK6ZIIeN8YvhDxHVke1hNYnowP
S41JpAYy9TdGGvSTYBy56A1KPeBh
=EHRm
-----END PGP SIGNATURE-----

--fyuwep3g3kqdbwyv--

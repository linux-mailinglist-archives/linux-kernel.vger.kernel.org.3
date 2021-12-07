Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86B846BC23
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbhLGNJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236827AbhLGNJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:09:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F18BC061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 05:05:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1muaAA-0007ZU-Oh; Tue, 07 Dec 2021 14:05:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1muaA8-003EEC-Ka; Tue, 07 Dec 2021 14:05:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1muaA7-0004ej-Fz; Tue, 07 Dec 2021 14:05:39 +0100
Date:   Tue, 7 Dec 2021 14:05:39 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     lizhe <sensor1010@163.com>
Cc:     ulf.hansson@linaro.org, srinivas.pandruvada@linux.intel.com,
        pali@kernel.org, TheSven73@gmail.com, lznuaa@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/mmc/core/bus: Remove redundant driver match
 function
Message-ID: <20211207130539.r4zdbyh76kiiid4o@pengutronix.de>
References: <20211207095029.96387-1-sensor1010@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kgftqftmrcsxvhor"
Content-Disposition: inline
In-Reply-To: <20211207095029.96387-1-sensor1010@163.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kgftqftmrcsxvhor
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 07, 2021 at 01:50:29AM -0800, lizhe wrote:
> If there is no driver match function, the driver core assumes
> that each candidate pair (driver, device) matches. See function
> driver_match_device().
>=20
> Drop the mmc bus's match function that always returned 1 and
> so implements the same behaviour as when there is no match
> function.
>=20
> Signed-off-by: lizhe <sensor1010@163.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

If you want to make it easier for maintainers to take your patches,
consider using -v2 for git send-email (or git format-patch) the next
time.

Best regards and thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kgftqftmrcsxvhor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGvXBUACgkQwfwUeK3K
7AlKBwf9FxVQIGM6u2nURsuCrG1EH0cROtww75N7Vh3nYFI5/FMdHliUpsmnHPDo
Y4McC5H/KG9PUAIrUM8lRRG3DSi8t3KG6lL0N6OXrLKuiKighSlMTDrwSwLCcdMB
FPlHceGZe4JjEFnaIv85prtb7v3Kb4G+4Yuj6kwU9hwyhoX/XkVB5L+bEsP7kHxI
f3V0xE+jszjLraH0OE5W/8+6AUhUisZ7kDqaDDqI43KDv6z00NCcknkXSsQ7tUfM
B6OJdHrJQsv8ExI1ZWem3kiSVIk8gfUAVgdZ/oVwd83FE5BFsmsehK/Alxb6xwh2
kHjeUhXABkZ1pwTFr3sk7DBApPr7ZA==
=5y5l
-----END PGP SIGNATURE-----

--kgftqftmrcsxvhor--

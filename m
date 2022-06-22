Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017D3554261
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 07:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356628AbiFVFtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 01:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiFVFtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 01:49:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB96A36681
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 22:49:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3tF4-0002bW-Th; Wed, 22 Jun 2022 07:49:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3tF0-001yAk-Gu; Wed, 22 Jun 2022 07:49:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3tF1-000LxY-59; Wed, 22 Jun 2022 07:49:27 +0200
Date:   Wed, 22 Jun 2022 07:49:27 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     jic23@kernel.org, lars@metafoo.de, ardeleanalex@gmail.com,
        andy.shevchenko@gmail.com, antoniu.miclaus@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: magnetometer: hmc5843: Remove duplicate 'the'
Message-ID: <20220622054927.u7im55jm5ya3n43l@pengutronix.de>
References: <20220622035925.5008-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pi74chydd7ox3t34"
Content-Disposition: inline
In-Reply-To: <20220622035925.5008-1-jiangjian@cdjrlc.com>
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


--pi74chydd7ox3t34
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jun 22, 2022 at 11:59:25AM +0800, Jiang Jian wrote:
> Fix an obvious typing error, found by spellcheck(1).

Oh, did I guess the real tool that found the issue, or did you just copy
my suggestion without adapting it to reality?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pi74chydd7ox3t34
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKyrV0ACgkQwfwUeK3K
7AmWLQf9Fso4Hn6ayY6q6Kynp1uQf/BejFjELME6RopXauLx5o3JalrQTlc65czn
sfSTFPFKGHe/wucCKzjhvfsBtehFgUUDkHylWfLh27gIUIMEB0qzE49SHemTId0b
Hum4jmvm1NYZG1xjavXW7qWs449xHCd6A6sZxPcfXccd3yncZFbBm2IFG979oJFG
39gSNNIfXFyrRJpxwzjAheZwiJ7v3sb+G8pRH6fmEth/+iJ1e2ukpF+DU3w033Th
/HulLDDouby+VPk10MAM+xlR2UmoI5TTedAWs9Bve+WczDi5164uQDWAHzxPfuHR
asjDXrfGkEpGnCbTqSjahdSQZNci6w==
=zJAQ
-----END PGP SIGNATURE-----

--pi74chydd7ox3t34--

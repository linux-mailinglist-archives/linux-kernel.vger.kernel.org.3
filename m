Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FFB550CE9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 22:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbiFSUZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 16:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiFSUZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 16:25:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C38B7D4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 13:25:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o31Tj-0001i2-RS; Sun, 19 Jun 2022 22:25:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o31Td-001Vpv-6C; Sun, 19 Jun 2022 22:24:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o31Td-00HRae-Vz; Sun, 19 Jun 2022 22:24:57 +0200
Date:   Sun, 19 Jun 2022 22:24:50 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Song Chen <chensong_2000@189.cn>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, lee.jones@linaro.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        elder@ieee.org, elder@linaro.org
Subject: Re: [PATCH v6] staging: greybus: introduce pwm_ops::apply
Message-ID: <20220619202450.c2ixwemrbwp2sazt@pengutronix.de>
References: <1647597432-27586-1-git-send-email-chensong_2000@189.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5jkw6rzfmqkhrj35"
Content-Disposition: inline
In-Reply-To: <1647597432-27586-1-git-send-email-chensong_2000@189.cn>
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


--5jkw6rzfmqkhrj35
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Mar 18, 2022 at 05:57:12PM +0800, Song Chen wrote:
> Introduce newer .apply function in pwm_ops to replace legacy operations
> including enable, disable, config and set_polarity.
>=20
> This guarantees atomic changes of the pwm controller configuration.
>=20
> Signed-off-by: Song Chen <chensong_2000@189.cn>

for the record: This patch was applied by Greg, I'm marking it as
"handled elsewhere" in the pwm patchwork.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5jkw6rzfmqkhrj35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKvhg8ACgkQwfwUeK3K
7AmNLQgAgW5qLr1UcrL5DrcIQNINK32n730Ls2hUGI/4QcZxbJfI+42XR2JJAtY8
zGdWSiy7adHCdo4xPHTCGYYfYvP56MMFe3+5pgvrgvP+wjg6b40vmthvZJT5njZU
LO30ySHraprHm9ju74JLWacI+ChO5ecDbj2kbDvTMftnWd5t7UkpkIH5dcMdOtso
kEpXl5GtpYXDle+1vhgqT+Goy2103t4YF2s4ArfikN/kSxlCQ2eWHWTMkprkILGm
0h5HrrMEmcuLD8PHqk2n0tqrjNcZHVvMatdRnXEG1jzzv53eTrOrvT1IRvfxM1F+
sPsuSMuSIxxWQ0B4PNjjJVCGAM2SVg==
=5fqr
-----END PGP SIGNATURE-----

--5jkw6rzfmqkhrj35--

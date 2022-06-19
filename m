Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A19B55095E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 10:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbiFSIcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 04:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiFSIcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 04:32:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8268311465
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 01:32:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o2qLi-0001fL-SW; Sun, 19 Jun 2022 10:32:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o2qLg-001Pfh-76; Sun, 19 Jun 2022 10:32:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o2qLg-00HL6m-QJ; Sun, 19 Jun 2022 10:32:00 +0200
Date:   Sun, 19 Jun 2022 10:32:00 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>, kernel@pengutronix.de,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] mfd: tc6387xb: Drop disable callback that is never
 called
Message-ID: <20220619083200.gx3ardiogbarlvzs@pengutronix.de>
References: <20220530192430.2108217-1-u.kleine-koenig@pengutronix.de>
 <20220530192430.2108217-4-u.kleine-koenig@pengutronix.de>
 <YqpJ+GDjsMsILL4P@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qbf2y2k4xo46jin6"
Content-Disposition: inline
In-Reply-To: <YqpJ+GDjsMsILL4P@google.com>
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


--qbf2y2k4xo46jin6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lee,

On Wed, Jun 15, 2022 at 10:07:04PM +0100, Lee Jones wrote:
> On Mon, 30 May 2022, Uwe Kleine-K=F6nig wrote:
>=20
> > The driver never calls the disable callback, so drop the member from
> > the platform struct and all callbacks from the actual platform datas.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  arch/arm/mach-pxa/eseries.c  | 1 -
> >  include/linux/mfd/tc6387xb.h | 1 -
> >  2 files changed, 2 deletions(-)
>=20
> Applied, thanks.

Are these already in a public tree? They are not in next and
git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git#for-mfd-next
doesn't contain commits that are not in v5.19-rc1.

I assume they are still in an internal tree and I just need some
patience until they are pushed out?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qbf2y2k4xo46jin6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKu3v4ACgkQwfwUeK3K
7AkmDwf7B0pRWMi6VQcMNKDL37XlQANm6JrKCdqRYKoefy3p8fZD+GisVMqV4wto
/gD11/TMrMiG6s5TiMDyI7amZGnxcl31kA44QLilPWb1wqNQjvY+giApdSSUqbMB
BPhnLJkB8nZROTXFocE+vBPSh35rgiWkJuoeppoeQbfi5kAdL2MUErRhYnUV4hfi
QHQ1zKqLg1VHHQZoYvzWl3Rnc4oxrUxnft358phTarQbUt0yuo1iI/zGqRBmcXHl
l8Gb39fwMLPZehQOe3Q3kwWYJRd6krCUGTEX2JzLYtNoFvnuBh8espBHCmtJBeUK
JRulX1JVd3W7FDiCcVHhSCEr1WDQSg==
=rM+S
-----END PGP SIGNATURE-----

--qbf2y2k4xo46jin6--

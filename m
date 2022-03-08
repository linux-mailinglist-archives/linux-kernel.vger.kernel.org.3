Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6CB4D1C2D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347898AbiCHPpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbiCHPpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:45:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDC54EF65
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:44:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nRc0q-0003S5-KN; Tue, 08 Mar 2022 16:44:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nRc0p-003TO2-5V; Tue, 08 Mar 2022 16:44:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nRc0n-007pR8-GD; Tue, 08 Mar 2022 16:44:33 +0100
Date:   Tue, 8 Mar 2022 16:44:29 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     hammer hsieh <hammerh0314@gmail.com>
Cc:     linux-pwm@vger.kernel.org, wells.lu@sunplus.com,
        devicetree@vger.kernel.org,
        "hammer.hsieh" <hammer.hsieh@sunplus.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        thierry.reding@gmail.com, kernel@pengutronix.de,
        lee.jones@linaro.org
Subject: Re: [PATCH v2 2/2] pwm:sunplus-pwm:Add Sunplus SoC PWM Driver
Message-ID: <20220308154429.ztv3l42euu2hf3ye@pengutronix.de>
References: <1646374812-2988-1-git-send-email-hammerh0314@gmail.com>
 <1646374812-2988-3-git-send-email-hammerh0314@gmail.com>
 <20220304185702.i6csx2r3mokfmr6o@pengutronix.de>
 <CAOX-t56cycXMga_grJcpmSG68ve5-RuTsbtaEQi9Ui0A+5uhSg@mail.gmail.com>
 <20220307131018.6wrdsiixmgdtnodt@pengutronix.de>
 <CAOX-t56F2u_1=tA4N4Wvicw-e9J4ksN__J70QZtjZwJRjgesUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6f3hgpz5jb2dmeu5"
Content-Disposition: inline
In-Reply-To: <CAOX-t56F2u_1=tA4N4Wvicw-e9J4ksN__J70QZtjZwJRjgesUQ@mail.gmail.com>
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


--6f3hgpz5jb2dmeu5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Mar 08, 2022 at 08:03:55PM +0800, hammer hsieh wrote:
> > IMHO yes. (Though the most likely error -ENOMEM, in this case no error
> > message should be emitted.)
> >
>=20
>  ok, will add error message like below.
>         if (ret < 0) {
>                 dev_err(dev, "failed to release clock: %d\n", ret);
>                 return ret;
>         }
> or should i modify like
>         if (ret < 0) {
>                 dev_err(dev, "failed to release clock: %d\n", ret);
>                 return ERR_PTR(ret);
>         }
> i didn't find reference code for it, not sure which one is better?

It depends if you return a pointer or an int. Also please make use of
%pe instead of %d for error codes to make it easier to understand.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6f3hgpz5jb2dmeu5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmInedoACgkQwfwUeK3K
7AkJKQgAhvEhvRse9Q9dBf2kr2xCcHcFD66QcDDAt8vq4hxZNJPKwmx19iZRE+En
TbbFIYldZshOH3eQvl6C9eEGtO5xiW3MKWgWRxjy0dngINIO3UqyxmmwnlY4FgWF
69sWMjvx0yB3zw14/zU+UgPsc7j03yb8DwpLGFWCgKgzzLb1n+nCLrupYe33Ph1n
BJWMD2Y97/GYlH4Q8OKsO3IyYr6qkoNB4jYVupb40JHI046EBjWQ1u2xUxGsuKcn
cCylifL66UXWsVs8Cl6n9hpiwg0jKM04H1Jwqz99ak2hz2OKcrbYGjdPtxYL3LzN
VIVavWS6prPerd+iJD+vDMd2B4fm7A==
=4RJz
-----END PGP SIGNATURE-----

--6f3hgpz5jb2dmeu5--

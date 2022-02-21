Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEFB4BDF27
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359159AbiBUNiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:38:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359139AbiBUNiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:38:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16A213E22
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:37:41 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nM8sa-0007tK-MQ; Mon, 21 Feb 2022 14:37:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nM8sY-000R0Q-Ao; Mon, 21 Feb 2022 14:37:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nM8sX-004bq8-12; Mon, 21 Feb 2022 14:37:25 +0100
Date:   Mon, 21 Feb 2022 14:37:24 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v16 21/40] pwm: tegra: Add runtime PM and OPP support
Message-ID: <20220221133724.iusksyn7n7hmxil2@pengutronix.de>
References: <20211130232347.950-1-digetx@gmail.com>
 <20211130232347.950-22-digetx@gmail.com>
 <20220221081727.jeq2jff5ewjzubxv@pengutronix.de>
 <677beebd-5a16-297f-c09a-fa4b72c001c9@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l5jzzhwrtignnt6r"
Content-Disposition: inline
In-Reply-To: <677beebd-5a16-297f-c09a-fa4b72c001c9@gmail.com>
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


--l5jzzhwrtignnt6r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Feb 21, 2022 at 12:53:58PM +0300, Dmitry Osipenko wrote:
> 21.02.2022 11:17, Uwe Kleine-K=C3=B6nig =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> @@ -344,7 +387,10 @@ static const struct of_device_id tegra_pwm_of_mat=
ch[] =3D {
> >>  MODULE_DEVICE_TABLE(of, tegra_pwm_of_match);
> >> =20
> >>  static const struct dev_pm_ops tegra_pwm_pm_ops =3D {
> >> -	SET_SYSTEM_SLEEP_PM_OPS(tegra_pwm_suspend, tegra_pwm_resume)
> >> +	SET_RUNTIME_PM_OPS(tegra_pwm_runtime_suspend, tegra_pwm_runtime_resu=
me,
> >> +			   NULL)
> >> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> >> +				pm_runtime_force_resume)
> >>  };
> >> =20
> >>  static struct platform_driver tegra_pwm_driver =3D {
> > I admit to not completely understand the effects of this patch, but I
> > don't see a problem either. So for me this patch is OK:
> >=20
> > Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > I spot a problem, it's not introduced by this patch however: If the
> > consumer of the PWM didn't stop the hardware, the suspend should IMHO be
> > prevented.
>=20
> Why? The PWM driver itself will stop the h/w on suspend.

Stopping the PWM might be bad. Only the consumer can know if it's ok to
stop the PWM on suspend. If so the consumer should stop the PWM in their
suspend callback and the PWM should prevent suspend if it wasn't
stopped.

> > I wonder if the patches in this series go in in one go via an ARM or
> > Tegra tree, or each patch via its respective maintainer tree.
>=20
> This series, including this patch, was already applied to 5.17 via the
> tegra/soc tree. No action is needed anymore.

Ah, I missed that, thanks.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--l5jzzhwrtignnt6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmITlYwACgkQwfwUeK3K
7Ak0Awf7Bng3Bp8dIdZWVJ0IKQy7Zh14yrunKW/TyOp4ENrNgLtH1N+DE2F332Mj
dYGX26syp+azTB+kvoYCzH3Ro0Cisl+Ssvvm95pL0PiFStqoSwXJgti+dSqIWspK
bwYm7tYUNcvJecG8YuuCZwSrUC6N15wccUN/VU2i8ZTOWfVAjmAKbxTNj6yLJNIU
VvWsqthnEOGiHxH6KueZlwL3DRbTZ2QmykKmUaUFAnJwvjH24B6lAFHQnUDOFIQv
vIbPMFpKTOvm8tOIFpqse8QJLzRAHbu5iuIiZkGnN5MVJg2C6fbo2fYVM1Ya/2c2
YXsdY3K0KB4X8v/eFrEX5qZdljYVCA==
=NwNV
-----END PGP SIGNATURE-----

--l5jzzhwrtignnt6r--

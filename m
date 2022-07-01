Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C9D562D07
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbiGAHug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiGAHud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:50:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCBB3B021
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 00:50:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o7BPu-0007uW-5E; Fri, 01 Jul 2022 09:50:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o7BPl-003k5A-TE; Fri, 01 Jul 2022 09:50:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o7BPo-002HCn-Qz; Fri, 01 Jul 2022 09:50:12 +0200
Date:   Fri, 1 Jul 2022 09:50:12 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, sean.anderson@seco.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.or,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v7 2/2] pwm: Add clock based PWM output driver
Message-ID: <20220701075012.xpkcd5xk42frevyq@pengutronix.de>
References: <20220612132203.290726-1-nikita@trvn.ru>
 <20220612132203.290726-3-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3uwpkzq4s4gxoyon"
Content-Disposition: inline
In-Reply-To: <20220612132203.290726-3-nikita@trvn.ru>
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


--3uwpkzq4s4gxoyon
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Jun 12, 2022 at 06:22:03PM +0500, Nikita Travkin wrote:
> Some systems have clocks exposed to external devices. If the clock
> controller supports duty-cycle configuration, such clocks can be used as
> pwm outputs. In fact PWM and CLK subsystems are interfaced with in a
> similar way and an "opposite" driver already exists (clk-pwm). Add a
> driver that would enable pwm devices to be used via clk subsystem.
>=20
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> --
>=20
> Changes in v2:
>  - Address Uwe's review comments:
>    - Round set clk rate up
>    - Add a description with limitations of the driver
>    - Disable and unprepare clock before removing pwmchip
> Changes in v3:
>  - Use 64bit version of div round up
>  - Address Uwe's review comments:
>    - Reword the limitations to avoid incorrect claims
>    - Move the clk_enabled flag assignment
>    - Drop unnecessary statements
> Changes in v5:
>  - add missed returns
> Changes in v6:
>  - Unprepare the clock on error
>  - Drop redundant limitations points
> Changes in v7:
>  - Rename some variables to be in line with common naming
>=20
> --
> It seems like my mailserver wasn't able to send the last review
> response to Uwe's so I'll repeat here that afaict clk.h has all the
> methods stubbed out so compiling without HAVE_CLK is possible.
> Sorry for a long delay with sending this since v6.
>=20
> ---
>  drivers/pwm/Kconfig   |  10 +++
>  drivers/pwm/Makefile  |   1 +
>  drivers/pwm/pwm-clk.c | 141 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 152 insertions(+)
>  create mode 100644 drivers/pwm/pwm-clk.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 904de8d61828..60d13a949bc5 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -140,6 +140,16 @@ config PWM_BRCMSTB
>  	  To compile this driver as a module, choose M Here: the module
>  	  will be called pwm-brcmstb.c.
> =20
> +config PWM_CLK
> +	tristate "Clock based PWM support"
> +	depends on HAVE_CLK || COMPILE_TEST
> +	help
> +	  Generic PWM framework driver for outputs that can be
> +	  muxed to clocks.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-clk.
> +
>  config PWM_CLPS711X
>  	tristate "CLPS711X PWM support"
>  	depends on ARCH_CLPS711X || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 5c08bdb817b4..7bf1a29f02b8 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_PWM_BCM_KONA)	+=3D pwm-bcm-kona.o
>  obj-$(CONFIG_PWM_BCM2835)	+=3D pwm-bcm2835.o
>  obj-$(CONFIG_PWM_BERLIN)	+=3D pwm-berlin.o
>  obj-$(CONFIG_PWM_BRCMSTB)	+=3D pwm-brcmstb.o
> +obj-$(CONFIG_PWM_CLK)		+=3D pwm-clk.o
>  obj-$(CONFIG_PWM_CLPS711X)	+=3D pwm-clps711x.o
>  obj-$(CONFIG_PWM_CRC)		+=3D pwm-crc.o
>  obj-$(CONFIG_PWM_CROS_EC)	+=3D pwm-cros-ec.o
> diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
> new file mode 100644
> index 000000000000..357d0c50dedd
> --- /dev/null
> +++ b/drivers/pwm/pwm-clk.c
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Clock based PWM controller
> + *
> + * Copyright (c) 2021 Nikita Travkin <nikita@trvn.ru>
> + *
> + * This is an "adapter" driver that allows PWM consumers to use
> + * system clocks with duty cycle control as PWM outputs.
> + *
> + * Limitations:
> + * - Due to the fact that exact behavior depends on the underlying
> + *   clock driver, various limitations are possible.
> + * - Underlying clock may not be able to give 0% or 100% duty cycle
> + *   (constant off or on), exact behavior will depend on the clock.
> + * - When the PWM is disabled, the clock will be disabled as well,
> + *   line state will depend on the clock.
> + * - The clk API doesn't expose the necessary calls to implement
> + *   .get_state().
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/math64.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/pwm.h>
> +
> +struct pwm_clk_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	bool clk_enabled;
> +};
> +
> +#define to_pwm_clk_chip(_chip) container_of(_chip, struct pwm_clk_chip, =
chip)
> +
> +static int pwm_clk_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	struct pwm_clk_chip *pcchip =3D to_pwm_clk_chip(chip);
> +	int ret;
> +	u32 rate;
> +	u64 period =3D state->period;
> +	u64 duty_cycle =3D state->duty_cycle;
> +
> +	if (!state->enabled) {
> +		if (pwm->state.enabled) {
> +			clk_disable(pcchip->clk);
> +			pcchip->clk_enabled =3D false;
> +		}
> +		return 0;
> +	} else if (!pwm->state.enabled) {
> +		ret =3D clk_enable(pcchip->clk);
> +		if (ret)
> +			return ret;
> +		pcchip->clk_enabled =3D true;
> +	}

Maybe point out here that this introduces a glitch that cannot be
prevented. Something like:

	/*
	 * We have to enable the clk before setting the rate and
	 * duty_cycle, that however results in a window where the clk is
	 * on with a (potentially) different setting. Also setting
	 * period and duty_cycle are two separate calls, so that
	 * probably isn't atomic either.
	 */

> +	rate =3D DIV64_U64_ROUND_UP(NSEC_PER_SEC, period);
> +	ret =3D clk_set_rate(pcchip->clk, rate);
> +	if (ret)
> +		return ret;
> +
> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> +		duty_cycle =3D period - duty_cycle;
> +
> +	return clk_set_duty_cycle(pcchip->clk, duty_cycle, period);
> +}
> +
> +static const struct pwm_ops pwm_clk_ops =3D {
> +	.apply =3D pwm_clk_apply,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int pwm_clk_probe(struct platform_device *pdev)
> +{
> +	struct pwm_clk_chip *pcchip;
> +	int ret;
> +
> +	pcchip =3D devm_kzalloc(&pdev->dev, sizeof(*pcchip), GFP_KERNEL);
> +	if (!pcchip)
> +		return -ENOMEM;
> +
> +	pcchip->clk =3D devm_clk_get(&pdev->dev, NULL);

You can use devm_clk_get_prepared() here and drop the clk_prepare()
below and the clk_unprepare in .remove().

> +	if (IS_ERR(pcchip->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pcchip->clk),
> +				     "Failed to get clock\n");
> +
> +	pcchip->chip.dev =3D &pdev->dev;
> +	pcchip->chip.ops =3D &pwm_clk_ops;
> +	pcchip->chip.npwm =3D 1;
> +
> +	ret =3D clk_prepare(pcchip->clk);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to prepare clock\n");
> +
> +	ret =3D pwmchip_add(&pcchip->chip);
> +	if (ret < 0) {
> +		clk_unprepare(pcchip->clk);
> +		return dev_err_probe(&pdev->dev, ret, "Failed to add pwm chip\n");
> +	}
> +
> +	platform_set_drvdata(pdev, pcchip);
> +	return 0;
> +}
> +
> +static int pwm_clk_remove(struct platform_device *pdev)
> +{
> +	struct pwm_clk_chip *pcchip =3D platform_get_drvdata(pdev);
> +
> +	pwmchip_remove(&pcchip->chip);
> +
> +	if (pcchip->clk_enabled)
> +		clk_disable(pcchip->clk);
> +
> +	clk_unprepare(pcchip->clk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id pwm_clk_dt_ids[] =3D {
> +	{ .compatible =3D "clk-pwm", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, pwm_clk_dt_ids);
> +
> +static struct platform_driver pwm_clk_driver =3D {
> +	.driver =3D {
> +		.name =3D "pwm-clk",
> +		.of_match_table =3D pwm_clk_dt_ids,
> +	},
> +	.probe =3D pwm_clk_probe,
> +	.remove =3D pwm_clk_remove,
> +};
> +module_platform_driver(pwm_clk_driver);
> +
> +MODULE_ALIAS("platform:pwm-clk");
> +MODULE_AUTHOR("Nikita Travkin <nikita@trvn.ru>");
> +MODULE_DESCRIPTION("Clock based PWM driver");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3uwpkzq4s4gxoyon
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmK+pzEACgkQwfwUeK3K
7AngMQf/Ws107J1sIiVxaqdrYD4+Cx6V5xGjrNrezwkcS/MvvLxp/Uw0JKe2NAAd
XrgWW9nsL34daYFG+nco21JHpWn8muLPUhiFfy9raVGqfIRKMBBG/Z2Kn5dPt3/B
D/zhc0/zabg9/Y3lusX9U8tRqo8+ZD3W4rE7saiMiYUvU9+y95kHpp6Jc+Jf5uAE
MSY0KFcqueQHtAzbBABGAtShRgL3q1s8bEZ1acuetU07m3uMz5/vS6bHYJqTYagU
kYT9+DScOsGMprAQU5X6q7FpJck4IAIhgrwep4L3MN7UwO7D5uz0biQ1PSD8+dH6
q8HZByE0oqcw/qoWyAPjIpaa3GOAcA==
=HjdW
-----END PGP SIGNATURE-----

--3uwpkzq4s4gxoyon--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF51E4DC403
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 11:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiCQKeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 06:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbiCQKes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:34:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE67811A1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 03:33:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nUnRb-0006Fg-3C; Thu, 17 Mar 2022 11:33:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nUnRZ-001EUT-Fz; Thu, 17 Mar 2022 11:33:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nUnRX-009kJB-Bg; Thu, 17 Mar 2022 11:33:19 +0100
Date:   Thu, 17 Mar 2022 11:33:19 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Hammer Hsieh <hammerh0314@gmail.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wells.lu@sunplus.com,
        hammer.hsieh@sunplus.com
Subject: Re: [PATCH v3 2/2] pwm: sunplus-pwm: Add Sunplus SoC SP7021 PWM
 Driver
Message-ID: <20220317103319.7irzmjknsr4hlrq3@pengutronix.de>
References: <1647237097-29172-1-git-send-email-hammerh0314@gmail.com>
 <1647237097-29172-3-git-send-email-hammerh0314@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ytfycacticac6xgy"
Content-Disposition: inline
In-Reply-To: <1647237097-29172-3-git-send-email-hammerh0314@gmail.com>
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


--ytfycacticac6xgy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 14, 2022 at 01:51:37PM +0800, Hammer Hsieh wrote:
> Add Sunplus SoC SP7021 PWM Driver
>=20
> Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
> ---
> Changes in v3:
>  - Addressed all comments from Uwe Kleine-K=F6nig.
>=20
>  MAINTAINERS               |   1 +
>  drivers/pwm/Kconfig       |  11 +++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-sunplus.c | 232 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 245 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sunplus.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e1cb7eb..6644bae 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18535,6 +18535,7 @@ SUNPLUS PWM DRIVER
>  M:	Hammer Hsieh <hammerh0314@gmail.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pwm/sunplus,sp7021-pwm.yaml
> +F:	drivers/pwm/pwm-sunplus.c
> =20
>  SUNPLUS RTC DRIVER
>  M:	Vincent Shih <vincent.sunplus@gmail.com>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 21e3b05..54cfb50 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -572,6 +572,17 @@ config PWM_SUN4I
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sun4i.
> =20
> +config PWM_SUNPLUS
> +	tristate "Sunplus PWM support"
> +	depends on ARCH_SUNPLUS || COMPILE_TEST
> +	depends on HAS_IOMEM && OF
> +	help
> +	  Generic PWM framework driver for the PWM controller on
> +	  Sunplus SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sunplus.
> +
>  config PWM_TEGRA
>  	tristate "NVIDIA Tegra PWM support"
>  	depends on ARCH_TEGRA || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 708840b..be58616 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -53,6 +53,7 @@ obj-$(CONFIG_PWM_STM32)		+=3D pwm-stm32.o
>  obj-$(CONFIG_PWM_STM32_LP)	+=3D pwm-stm32-lp.o
>  obj-$(CONFIG_PWM_STMPE)		+=3D pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+=3D pwm-sun4i.o
> +obj-$(CONFIG_PWM_SUNPLUS)	+=3D pwm-sunplus.o
>  obj-$(CONFIG_PWM_TEGRA)		+=3D pwm-tegra.o
>  obj-$(CONFIG_PWM_TIECAP)	+=3D pwm-tiecap.o
>  obj-$(CONFIG_PWM_TIEHRPWM)	+=3D pwm-tiehrpwm.o
> diff --git a/drivers/pwm/pwm-sunplus.c b/drivers/pwm/pwm-sunplus.c
> new file mode 100644
> index 0000000..b6ab077
> --- /dev/null
> +++ b/drivers/pwm/pwm-sunplus.c
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PWM device driver for SUNPLUS SP7021 SoC
> + *
> + * Links:
> + *   Reference Manual:
> + *   https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
> + *
> + *   Reference Manual(PWM module):
> + *   https://sunplus.atlassian.net/wiki/spaces/doc/pages/461144198/12.+P=
ulse+Width+Modulation+PWM

On that wiki page someone wants to make s/desable/disable/

> + *
> + * Limitations:
> + * - Only supports normal polarity.
> + * - It output low when PWM channel disabled.
> + * - When the parameters change, current running period will not be comp=
leted
> + *     and run new settings immediately.
> + * - In .apply() PWM output need to write register FREQ and DUTY. When f=
irst write FREQ
> + *     done and not yet write DUTY, it has short timing gap use new FREQ=
 and old DUTY.

good

> + *
> + * Author: Hammer Hsieh <hammerh0314@gmail.com>
> + */
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +#define SP7021_PWM_CONTROL0		0x000
> +#define SP7021_PWM_CONTROL1		0x004

The link above calls these PWM_MODE0 and PWM_MODE1, also the other
register names don't match.

> +#define SP7021_PWM_FREQ(ch)		(0x008 + 4 * (ch))
> +#define SP7021_PWM_DUTY(ch)		(0x018 + 4 * (ch))
> +#define SP7021_PWM_FREQ_MAX		GENMASK(15, 0)
> +#define SP7021_PWM_DUTY_MAX		GENMASK(7, 0)
> +#define SP7021_PWM_CONTROL_EN(ch)	BIT(ch)

I'm a big fan of consistently naming register defines. I'd do something
like:

	#define SP7021_PWM_MODE0		0x000
	#define SP7021_PWM_MODE0_PWMEN(ch)		BIT(ch)
	#define SP7021_PWM_MODE0_BYPASS(ch)		BIT(8 + (ch))

	#define SP7021_PWM_MODE1		0x004
	#define SP7021_PWM_MODE1_CNTx_EN(ch)		BIT(ch)
	...

such that register names match the manual and register fields have the
register as a prefix. That way its easier spotable when there is a
mismatch. (e.g. someone tries to set SP7021_PWM_MODE1_CNTx_EN(1) in
SP7021_PWM_MODE0.)


> +#define SP7021_PWM_NUM			4
> +#define SP7021_PWM_BYPASS_BIT_SHIFT	8
> +#define SP7021_PWM_DD_SEL_BIT_SHIFT	8

When you use the bit masks and FIELD_PREP you never should need a define
for a shift.

> +#define SP7021_PWM_FREQ_SCALER		256
> +
> +struct sunplus_pwm {
> +	struct pwm_chip chip;
> +	void __iomem *base;
> +	struct clk *clk;
> +};
> +
> +static inline struct sunplus_pwm *to_sunplus_pwm(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct sunplus_pwm, chip);
> +}
> +
> +static int sunplus_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     const struct pwm_state *state)
> +{
> +	struct sunplus_pwm *priv =3D to_sunplus_pwm(chip);
> +	u32 dd_freq, duty, control0, control1;
> +	u64 max_period, period_ns, duty_ns, clk_rate;
> +
> +	if (state->polarity !=3D pwm->state.polarity)
> +		return -EINVAL;
> +
> +	if (!state->enabled) {
> +		/* disable pwm channel output */
> +		control0 =3D readl(priv->base + SP7021_PWM_CONTROL0);
> +		control0 &=3D ~SP7021_PWM_CONTROL_EN(pwm->hwpwm);
> +		writel(control0, priv->base + SP7021_PWM_CONTROL0);
> +		/* disable pwm channel clk source */
> +		control1 =3D readl(priv->base + SP7021_PWM_CONTROL1);
> +		control1 &=3D ~SP7021_PWM_CONTROL_EN(pwm->hwpwm);
> +		writel(control1, priv->base + SP7021_PWM_CONTROL1);
> +		return 0;
> +	}
> +
> +	clk_rate =3D clk_get_rate(priv->clk);
> +	/*
> +	 * SP7021_PWM_FREQ_MAX 16 bits, SP7021_PWM_FREQ_SCALER 8 bits
> +	 * NSEC_PER_SEC 30 bits, won't overflow.
> +	 */
> +	max_period =3D mul_u64_u64_div_u64(SP7021_PWM_FREQ_MAX, (u64)SP7021_PWM=
_FREQ_SCALER
> +				* NSEC_PER_SEC, clk_rate);
> +
> +	period_ns =3D min(state->period, max_period);
> +	duty_ns =3D state->duty_cycle;

duty_ns =3D min(state->duty_cycle, period_ns);

> +
> +	/*
> +	 * cal pwm freq and check value under range
> +	 * clk_rate 202.5MHz 28 bits, period_ns max 82849185 27 bits, won't ove=
rflow.
> +	 */
> +	dd_freq =3D mul_u64_u64_div_u64(clk_rate, period_ns, (u64)SP7021_PWM_FR=
EQ_SCALER
> +				* NSEC_PER_SEC);
> +
> +	if (dd_freq =3D=3D 0)
> +		return -EINVAL;
> +
> +	if (dd_freq > SP7021_PWM_FREQ_MAX)
> +		dd_freq =3D SP7021_PWM_FREQ_MAX;

This cannot happen after period_ns was limited to max_period, can it?
I wonder if there is a max_period value that is cheaper to calculate
(e.g. no division) and still is good enough to ensure that the
calculation for dd_freq doesn't overflow. The reasoning there includes
clk_rate =3D 202.5 MHz. So maybe something like:

	clk_rate =3D clk_get_rate(priv->clk);
=09
	/*
	 * The following calculations might overflow if clk is bigger
	 * than 256 GHz. In practise it's 202.5MHz, so this limitation
	 * is only theoretic.
	 */
	if (clk_rate > (u64)SP7021_PWM_FREQ_SCALER * NSEC_PER_SEC)
		return -EINVAL;

	/*
	 * With clk_rate limited above we have dd_freq <=3D state->period,
	 * so this cannot overflow.
	 */
	dd_freq =3D mul_u64_u64_div_u64(clk_rate, state->period,
				      (u64)SP7021_PWM_FREQ_SCALER * NSEC_PER_SEC);

	if (dd_freq =3D=3D 0)
		return -EINVAL;

	if (dd_freq > SP7021_PWM_FREQ_MAX)
		dd_freq =3D SP7021_PWM_FREQ_MAX;


> +	writel(dd_freq, priv->base + SP7021_PWM_FREQ(pwm->hwpwm));
> +
> +	/* cal and set pwm duty */
> +	control0 =3D readl(priv->base + SP7021_PWM_CONTROL0);
> +	control0 |=3D SP7021_PWM_CONTROL_EN(pwm->hwpwm);
> +	control1 =3D readl(priv->base + SP7021_PWM_CONTROL1);
> +	control1 |=3D SP7021_PWM_CONTROL_EN(pwm->hwpwm);
> +	if (duty_ns =3D=3D period_ns) {
> +		/* PWM channel output =3D high */
> +		control0 |=3D SP7021_PWM_CONTROL_EN(pwm->hwpwm + SP7021_PWM_BYPASS_BIT=
_SHIFT);
> +		duty =3D SP7021_PWM_DUTY_MAX;
> +	} else {
> +		control0 &=3D ~SP7021_PWM_CONTROL_EN(pwm->hwpwm + SP7021_PWM_BYPASS_BI=
T_SHIFT);
> +		/*
> +		 * duty_ns <=3D period_ns 27 bits, SP7021_PWM_FREQ_SCALER 8 bits
> +		 * won't overflow.
> +		 */
> +		duty =3D mul_u64_u64_div_u64(duty_ns, (u64)SP7021_PWM_FREQ_SCALER,
> +					   period_ns);

Note this might configure a duty cycle that is too small.
Consider:

	clk_rate =3D 202500000
	period =3D 3333643
	duty_cycle =3D 3306391

Then we get dd_freq =3D 2636 and duty =3D 253.

With dd_freq =3D 2636 and duty =3D 254 the resulting duty_cycle is

	2636 * 1000000000 * 254 / 202500000 =3D 3306390.12345679

so 254 would be the better value. The problem is that you use period_ns
in the division which however is a bit of as the real period is a tad
smaller.

So the right thing to do here is:

	duty =3D duty_ns * clk / (dd_freq * NSEC_PER_SEC)

> +		duty |=3D (pwm->hwpwm << SP7021_PWM_DD_SEL_BIT_SHIFT);
> +	}
> +	writel(duty, priv->base + SP7021_PWM_DUTY(pwm->hwpwm));

I don't understand the DDx SEL bitfield in this register. Is it right
that it is 0 for all 4 PWMs?

> +	writel(control1, priv->base + SP7021_PWM_CONTROL1);
> +	writel(control0, priv->base + SP7021_PWM_CONTROL0);
> +
> +	return 0;
> +}
> +
> +static void sunplus_pwm_get_state(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> +				  struct pwm_state *state)
> +{
> +	struct sunplus_pwm *priv =3D to_sunplus_pwm(chip);
> +	u32 control0, freq, duty;
> +	u64 clk_rate;
> +
> +	control0 =3D readl(priv->base + SP7021_PWM_CONTROL0);
> +
> +	if (control0 & BIT(pwm->hwpwm)) {
> +		clk_rate =3D clk_get_rate(priv->clk);
> +		freq =3D readl(priv->base + SP7021_PWM_FREQ(pwm->hwpwm));

I'd call this dd_freq to match the variable name in .apply().

> +		duty =3D readl(priv->base + SP7021_PWM_DUTY(pwm->hwpwm));
> +		duty &=3D ~GENMASK(9, 8);

That looks wrong, The bit field 9:8 is the divisor source select. Also
please introduce a define for GENMASK(9,8).

> +		/*
> +		 * freq 16 bits, SP7021_PWM_FREQ_SCALER 8 bits
> +		 * NSEC_PER_SEC 30 bits, won't overflow.
> +		 */
> +		state->period =3D DIV64_U64_ROUND_UP((u64)freq * (u64)SP7021_PWM_FREQ_=
SCALER
> +						* NSEC_PER_SEC, clk_rate);
> +		/*
> +		 * freq 16 bits, duty 8 bits, NSEC_PER_SEC 30 bits, won't overflow.
> +		 */
> +		state->duty_cycle =3D DIV64_U64_ROUND_UP((u64)freq * (u64)duty * NSEC_=
PER_SEC,
> +						       clk_rate);
> +		state->enabled =3D true;
> +	} else {
> +		state->enabled =3D false;
> +	}
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +}
> +
> +static const struct pwm_ops sunplus_pwm_ops =3D {
> +	.apply =3D sunplus_pwm_apply,
> +	.get_state =3D sunplus_pwm_get_state,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static void sunplus_pwm_clk_release(void *data)
> +{
> +	struct clk *clk =3D data;
> +
> +	clk_disable_unprepare(clk);
> +}
> +
> +static int sunplus_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct sunplus_pwm *priv;
> +	int ret;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "get pwm clock failed\n");
> +
> +	ret =3D clk_prepare_enable(priv->clk);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to enable clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D devm_add_action_or_reset(dev, sunplus_pwm_clk_release, priv->cl=
k);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to release clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	priv->chip.dev =3D dev;
> +	priv->chip.ops =3D &sunplus_pwm_ops;
> +	priv->chip.npwm =3D SP7021_PWM_NUM;
> +
> +	ret =3D devm_pwmchip_add(dev, &priv->chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Cannot register sunplus PWM\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sunplus_pwm_of_match[] =3D {
> +	{ .compatible =3D "sunplus,sp7021-pwm", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sunplus_pwm_of_match);
> +
> +static struct platform_driver sunplus_pwm_driver =3D {
> +	.probe		=3D sunplus_pwm_probe,
> +	.driver		=3D {
> +		.name	=3D "sunplus-pwm",
> +		.of_match_table =3D sunplus_pwm_of_match,
> +	},
> +};
> +module_platform_driver(sunplus_pwm_driver);
> +
> +MODULE_DESCRIPTION("Sunplus SoC PWM Driver");
> +MODULE_AUTHOR("Hammer Hsieh <hammerh0314@gmail.com>");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ytfycacticac6xgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIzDmwACgkQwfwUeK3K
7Am8XAf+PnKi9NZB9HViUSV8v0rloYKUiQ3u0b86c8vkYTJe8ocG4rL+kZg3NC36
ihuYw9WdYtM402wgoL7TJKpHKbzNckkdqUJvmvUg2iXsHJcWI7YUrd39BQoIO+bJ
SUJnKUekT6b6VwXx0rYroU2fk7R6K6WMWbUbGYSWmzv5kG14lXP/rwN7LKnyOuW+
amRyr0IzLR6K16mSL+bKXtcnLe4f/FchsaRoMbB6SGxdY4UlXVzqRTgr+mLvGUFn
1BL51l9ttVHyjTwdXAxRWrrjX4kGmXENP1K0dhug23wB7obe/vOxINi+PtcMy09g
n/6RarrSYEC4pVEXCzU+PHwBmR2OyA==
=/D3w
-----END PGP SIGNATURE-----

--ytfycacticac6xgy--

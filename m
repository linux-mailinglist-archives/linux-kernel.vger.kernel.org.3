Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E74478FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbhLQP2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhLQP2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:28:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD9CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 07:28:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1myFA2-0006rT-Ba; Fri, 17 Dec 2021 16:28:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1myFA1-0053F3-3P; Fri, 17 Dec 2021 16:28:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1myFA0-0006X4-1W; Fri, 17 Dec 2021 16:28:40 +0100
Date:   Fri, 17 Dec 2021 16:28:39 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Hammer Hsieh <hammerh0314@gmail.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wells.lu@sunplus.com,
        Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: Re: [PATCH v1 2/2] pwm:sunplus-pwm:Add Sunplus SoC PWM Driver
Message-ID: <20211217152839.vjzgvpha2shcitdj@pengutronix.de>
References: <1639741568-5846-1-git-send-email-hammer.hsieh@sunplus.com>
 <1639741568-5846-3-git-send-email-hammer.hsieh@sunplus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w5p6wprgtelmsga2"
Content-Disposition: inline
In-Reply-To: <1639741568-5846-3-git-send-email-hammer.hsieh@sunplus.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w5p6wprgtelmsga2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Dec 17, 2021 at 07:46:08PM +0800, Hammer Hsieh wrote:
> Add Sunplus SoC PWM Driver
>=20
> Signed-off-by: Hammer Hsieh <hammer.hsieh@sunplus.com>
> ---
>  MAINTAINERS               |   1 +
>  drivers/pwm/Kconfig       |  11 +++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-sunplus.c | 192 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 205 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sunplus.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 721ed79..1c9e3c5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18246,6 +18246,7 @@ SUNPLUS PWM DRIVER
>  M:	Hammer Hsieh <hammer.hsieh@sunplus.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
> +F:	drivers/pwm/pwm-sunplus.c
> =20
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 21e3b05..9df5d5f 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -526,6 +526,17 @@ config PWM_SPRD
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sprd.
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
>  config PWM_STI
>  	tristate "STiH4xx PWM support"
>  	depends on ARCH_STI || COMPILE_TEST
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
> index 0000000..0ae59fc
> --- /dev/null
> +++ b/drivers/pwm/pwm-sunplus.c
> @@ -0,0 +1,192 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PWM device driver for SUNPLUS SoCs
> + *
> + * Author: Hammer Hsieh <hammer.hsieh@sunplus.com>
> + */

Please add a section here about your hardware limitations. Please stick
to the format used in e.g. pwm-sifive.c. That is a block starting with

 * Limitations:

and then a list of issues. One such item is: Only supports normal
polarity.

> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +#define PWM_SUP_CONTROL0	0x000
> +#define PWM_SUP_CONTROL1	0x004
> +#define PWM_SUP_FREQ_BASE	0x008
> +#define PWM_SUP_DUTY_BASE	0x018
> +#define PWM_SUP_FREQ(ch)	(PWM_SUP_FREQ_BASE + 4 * (ch))
> +#define PWM_SUP_DUTY(ch)	(PWM_SUP_DUTY_BASE + 4 * (ch))
> +#define PWM_SUP_FREQ_MAX	GENMASK(15, 0)
> +#define PWM_SUP_DUTY_MAX	GENMASK(7, 0)
> +
> +#define PWM_SUP_NUM		4
> +#define PWM_BYPASS_BIT_SHIFT	8
> +#define PWM_DD_SEL_BIT_SHIFT	8
> +#define PWM_SUP_FREQ_SCALER	256
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
> +static void sunplus_reg_init(void __iomem *base)
> +{
> +	u32 i, value;
> +
> +	/* turn off all pwm channel output */
> +	value =3D readl(base + PWM_SUP_CONTROL0);
> +	value &=3D ~GENMASK((PWM_SUP_NUM - 1), 0);
> +	writel(value, base + PWM_SUP_CONTROL0);
> +
> +	/* init all pwm channel clock source */
> +	value =3D readl(base + PWM_SUP_CONTROL1);
> +	value |=3D GENMASK((PWM_SUP_NUM - 1), 0);
> +	writel(value, base + PWM_SUP_CONTROL1);
> +
> +	/* init all freq and duty setting */
> +	for (i =3D 0; i < PWM_SUP_NUM; i++) {
> +		writel(0, base + PWM_SUP_FREQ(i));
> +		writel(0, base + PWM_SUP_DUTY(i));
> +	}

Please keep the PWM in their boot-up state. That is, if the bootloader
enabled a display with a bootsplash, don't disable the backlight when
the PWM driver loads.

> +}
> +
> +static int sunplus_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     const struct pwm_state *state)
> +{
> +	struct sunplus_pwm *priv =3D to_sunplus_pwm(chip);
> +	u32 period_ns, duty_ns, value;
> +	u32 dd_freq, duty;
> +	u64 tmp;
> +

	if (state->polarity !=3D PWM_POLARITY_NORMAL)
		return -EINVAL;

> +	if (!state->enabled) {
> +		value =3D readl(priv->base + PWM_SUP_CONTROL0);
> +		value &=3D ~BIT(pwm->hwpwm);
> +		writel(value, priv->base + PWM_SUP_CONTROL0);
> +		return 0;
> +	}
> +
> +	period_ns =3D state->period;

state->period is an u64, so you might loose precision here.

> +	duty_ns =3D state->duty_cycle;

ditto

> +
> +	/* cal pwm freq and check value under range */
> +	tmp =3D clk_get_rate(priv->clk) * (u64)period_ns;

This might overflow?

> +	tmp =3D DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
> +	tmp =3D DIV_ROUND_CLOSEST_ULL(tmp, PWM_SUP_FREQ_SCALER);

In general you should pick the highest period that isn't bigger than the
requested period. I didn't check in detail, but using round-closest is a
strong hint that you get that wrong.

> +	dd_freq =3D (u32)tmp;
> +
> +	if (dd_freq =3D=3D 0)
> +		return -EINVAL;
> +
> +	if (dd_freq > PWM_SUP_FREQ_MAX)
> +		dd_freq =3D PWM_SUP_FREQ_MAX;
> +
> +	writel(dd_freq, priv->base + PWM_SUP_FREQ(pwm->hwpwm));
> +
> +	/* cal and set pwm duty */
> +	value =3D readl(priv->base + PWM_SUP_CONTROL0);
> +	value |=3D BIT(pwm->hwpwm);
> +	if (duty_ns =3D=3D period_ns) {
> +		value |=3D BIT(pwm->hwpwm + PWM_BYPASS_BIT_SHIFT);
> +		duty =3D PWM_SUP_DUTY_MAX;
> +	} else {
> +		value &=3D ~BIT(pwm->hwpwm + PWM_BYPASS_BIT_SHIFT);
> +		tmp =3D (u64)duty_ns * PWM_SUP_FREQ_SCALER + (period_ns >> 1);
> +		tmp =3D DIV_ROUND_CLOSEST_ULL(tmp, (u64)period_ns);
> +		duty =3D (u32)tmp;
> +		duty |=3D (pwm->hwpwm << PWM_DD_SEL_BIT_SHIFT);

This is also more inexact than necessary. In general don't use period_ns
in the calculation of duty register settings. As with period you're
supposed to pick the biggest possible dutycycle not bigger than the
requested value.

Consider a PWM that with register P =3D P and register D =3D D implements a
PWM output with period =3D 1000 * P ns and duty_cycle =3D 1000 * D ns

For a request of period =3D 39900 and duty_cycle =3D 12100, you have to pick
P =3D 39 and D =3D 12. However P * duty_ns / period_ns =3D 11.82 ...

> +	}
> +	writel(value, priv->base + PWM_SUP_CONTROL0);
> +	writel(duty, priv->base + PWM_SUP_DUTY(pwm->hwpwm));
> +
> +	return 0;
> +}
> +
> +static void sunplus_pwm_get_state(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> +				  struct pwm_state *state)
> +{
> +	struct sunplus_pwm *priv =3D to_sunplus_pwm(chip);
> +	u32 value;
> +
> +	value =3D readl(priv->base + PWM_SUP_CONTROL0);
> +
> +	if (value & BIT(pwm->hwpwm))
> +		state->enabled =3D true;
> +	else
> +		state->enabled =3D false;

This looks incomplete. Please enable PWM_DEBUG during your tests and
address all output generated by that.

As the general idea is that passing the result from .get_state() to
=2Eapply shouldn't modify the output, you have (in general) round up
divisions in .get_state().

> +}
> +
> +static const struct pwm_ops sunplus_pwm_ops =3D {
> +	.apply =3D sunplus_pwm_apply,
> +	.get_state =3D sunplus_pwm_get_state,
> +	.owner =3D THIS_MODULE,
> +};
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
> +	priv->clk =3D devm_clk_get_optional(dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "get pwm clock failed\n");
> +
> +	ret =3D clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(dev,
> +				       (void(*)(void *))clk_disable_unprepare,
> +				       priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	priv->chip.dev =3D dev;
> +	priv->chip.ops =3D &sunplus_pwm_ops;
> +	priv->chip.npwm =3D PWM_SUP_NUM;
> +
> +	sunplus_reg_init(priv->base);
> +
> +	platform_set_drvdata(pdev, priv);

This is unused, so please drop this.

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
> +MODULE_AUTHOR("Hammer Hsieh <hammer.hsieh@sunplus.com>");
> +MODULE_LICENSE("GPL v2");

"GPL" has the same semantic and is the more usual, so I suggest to use
that one.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--w5p6wprgtelmsga2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmG8rJ8ACgkQwfwUeK3K
7AkYrAgAnyexKVg4DDqCmeOpnMI8WshsOcwzm89l+NUKYPVKC/0ugxOcmNkkYwts
EOOIXC/cCBK2PnqkVZpKgTTdMQ8201pIJTer190PeTkms6iHyyPbXK0L3kUf9BmF
I1Dla60HeNpt646ssAXfPDKdDc2aQMhtAnjIbgK8CNsdlzu8+PIj/QHbn1GX8uyg
3KHe8fJ6JH9lmc1RJnbb94BTXjVNgXeEs7ci0PnK/M3WQ3QWrBjH2CVeE6Z4kqs2
oBSLh8w30YUeBOjEiK+PBsu4Mmg4yj36mL2YqQmVqFuTUnLNwMHFC8fjSZbX8Wo/
rHwll+Br4tv6M/FvbFOSUEFrUg7uIw==
=9KAW
-----END PGP SIGNATURE-----

--w5p6wprgtelmsga2--

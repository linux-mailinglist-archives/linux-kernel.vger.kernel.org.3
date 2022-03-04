Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA28C4CDD0D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiCDS6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiCDS6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:58:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6621D790A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:57:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nQD6u-0007KJ-SE; Fri, 04 Mar 2022 19:57:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nQD6t-002fOo-VL; Fri, 04 Mar 2022 19:57:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nQD6s-006z3F-DY; Fri, 04 Mar 2022 19:57:02 +0100
Date:   Fri, 4 Mar 2022 19:57:02 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Hammer Hsieh <hammerh0314@gmail.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wells.lu@sunplus.com,
        hammer.hsieh@sunplus.com
Subject: Re: [PATCH v2 2/2] pwm:sunplus-pwm:Add Sunplus SoC PWM Driver
Message-ID: <20220304185702.i6csx2r3mokfmr6o@pengutronix.de>
References: <1646374812-2988-1-git-send-email-hammerh0314@gmail.com>
 <1646374812-2988-3-git-send-email-hammerh0314@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nfe4uycujul6nwas"
Content-Disposition: inline
In-Reply-To: <1646374812-2988-3-git-send-email-hammerh0314@gmail.com>
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


--nfe4uycujul6nwas
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Mar 04, 2022 at 02:20:12PM +0800, Hammer Hsieh wrote:
> Add Sunplus SoC PWM Driver
>=20
> Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
> ---
> Changes in v2:
>  - Addressed all comments from Uwe Kleine-K=F6nig.
>  - rebase kernel to 5.17 rc5
>=20
>  MAINTAINERS               |   1 +
>  drivers/pwm/Kconfig       |  11 +++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-sunplus.c | 229 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 242 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sunplus.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 825b714..8710c8e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18535,6 +18535,7 @@ SUNPLUS PWM DRIVER
>  M:	Hammer Hsieh <hammerh0314@gmail.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
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
> index 0000000..170534f
> --- /dev/null
> +++ b/drivers/pwm/pwm-sunplus.c
> @@ -0,0 +1,229 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PWM device driver for SUNPLUS SoCs

Is there a public manual available for this hardware? If yes, please add
a link here.

> + *
> + * Limitations:
> + * - Only supports normal polarity.

How does the HW behave when it's disabled? Usual candidates are:
 - It freezes at where it currently is
 - It outputs low
 - It becomes tristate

Please note this in the Limitations section, too.

Another thing to mention is if running periods are completed when the
parameters change.

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
> +#define PWM_SUP_CONTROL0	0x000
> +#define PWM_SUP_CONTROL1	0x004
> +#define PWM_SUP_FREQ_BASE	0x008
> +#define PWM_SUP_DUTY_BASE	0x018
> +#define PWM_SUP_FREQ(ch)	(PWM_SUP_FREQ_BASE + 4 * (ch))
> +#define PWM_SUP_DUTY(ch)	(PWM_SUP_DUTY_BASE + 4 * (ch))

I'd not give PWM_SUP_FREQ_BASE and PWM_SUP_DUTY_BASE a name here, just

	#define PWM_SUP_FREQ(ch)	(0x008 + 4 * (ch))
	...

> +#define PWM_SUP_FREQ_MAX	GENMASK(15, 0)
> +#define PWM_SUP_DUTY_MAX	GENMASK(7, 0)
> +
> +#define PWM_SUP_NUM		4
> +#define PWM_BYPASS_BIT_SHIFT	8
> +#define PWM_DD_SEL_BIT_SHIFT	8
> +#define PWM_SUP_FREQ_SCALER	256

Please use a consistent prefix for the driver specific defines.

> +struct sunplus_pwm {
> +	struct pwm_chip chip;
> +	void __iomem *base;
> +	struct clk *clk;
> +	u32 approx_period[PWM_SUP_NUM];
> +	u32 approx_duty_cycle[PWM_SUP_NUM];
> +};
> +
> +static inline struct sunplus_pwm *to_sunplus_pwm(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct sunplus_pwm, chip);
> +}
> +
> +static void sunplus_pwm_free(struct pwm_chip *chip, struct pwm_device *p=
wm)
> +{
> +	struct sunplus_pwm *priv =3D to_sunplus_pwm(chip);
> +	u32 value;
> +
> +	/* disable pwm channel output */
> +	value =3D readl(priv->base + PWM_SUP_CONTROL0);
> +	value &=3D ~BIT(pwm->hwpwm);
> +	writel(value, priv->base + PWM_SUP_CONTROL0);
> +	/* disable pwm channel clk source */
> +	value =3D readl(priv->base + PWM_SUP_CONTROL1);
> +	value &=3D ~BIT(pwm->hwpwm);
> +	writel(value, priv->base + PWM_SUP_CONTROL1);

the .free callback isn't supposed to modify the hardware.

> +}
> +
> +static int sunplus_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     const struct pwm_state *state)
> +{
> +	struct sunplus_pwm *priv =3D to_sunplus_pwm(chip);
> +	u32 dd_freq, duty, value, value1;

As value and value1 hold register values for PWM_SUP_CONTROL0 and
PWM_SUP_CONTROL1, I'd call them control0 and control1 respectively.

> +	u32 tmp, rate;
> +	u64 max_period, period_ns, duty_ns, clk_rate;
> +
> +	if (state->polarity !=3D pwm->state.polarity)
> +		return -EINVAL;
> +
> +	if (!state->enabled) {
> +		/* disable pwm channel output */
> +		value =3D readl(priv->base + PWM_SUP_CONTROL0);
> +		value &=3D ~BIT(pwm->hwpwm);

I'd give this one a name. Something like:

	#define PWM_SUP_CONTROL_EN(ch)	BIT(ch)

(Pick the right name from the manual.)

> +		writel(value, priv->base + PWM_SUP_CONTROL0);
> +		/* disable pwm channel clk source */
> +		value =3D readl(priv->base + PWM_SUP_CONTROL1);
> +		value &=3D ~BIT(pwm->hwpwm);
> +		writel(value, priv->base + PWM_SUP_CONTROL1);
> +		return 0;
> +	}
> +
> +	clk_rate =3D clk_get_rate(priv->clk);
> +	rate =3D (u32)clk_rate / 100000;

This cast doesn't change anything, does it?

> +	max_period =3D PWM_SUP_FREQ_MAX * (PWM_SUP_FREQ_SCALER * 10000 / rate);

Here you have rounding issues. Consider rate =3D 3329. Then you get
max_period =3D 0xffff * (2560000 / 3329) =3D 0xffff * 768 =3D 50330880.

However the actual result is 50396395.31...

Also dividing by the result of a division looses precision.

> +
> +	if (state->period > max_period)
> +		return -EINVAL;

No, you're supposed to implement the biggest period possible not bigger
than the requested period. So the right thing here is:

> +	period_ns =3D state->period;

period =3D min(state->period, max_period);

> +	duty_ns =3D state->duty_cycle;
> +
> +	priv->approx_period[pwm->hwpwm] =3D (u32)period_ns / 100;
> +	priv->approx_duty_cycle[pwm->hwpwm] =3D (u32)duty_ns / 100;

Tracking period_ns / 100 seems strange and vulnerable to rounding
issues.

> +	/* cal pwm freq and check value under range */
> +	dd_freq =3D rate * priv->approx_period[pwm->hwpwm] / (PWM_SUP_FREQ_SCAL=
ER * 100);

This is all too complicated, you just need:

	dd_freq =3D mul_u64_u64_div_u64(clk_rate, period, (u64)PWM_SUP_FREQ_SCALER=
 * NSEC_PER_SEC)

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
> +	value1 =3D readl(priv->base + PWM_SUP_CONTROL1);
> +	value1 |=3D BIT(pwm->hwpwm);
> +	if (duty_ns =3D=3D period_ns) {
> +		value |=3D BIT(pwm->hwpwm + PWM_BYPASS_BIT_SHIFT);
> +		duty =3D PWM_SUP_DUTY_MAX;
> +	} else {
> +		value &=3D ~BIT(pwm->hwpwm + PWM_BYPASS_BIT_SHIFT);
> +		tmp =3D priv->approx_duty_cycle[pwm->hwpwm] * PWM_SUP_FREQ_SCALER;
> +		tmp /=3D priv->approx_period[pwm->hwpwm];

Please use the exact values available.

> +		duty =3D (u32)tmp;
> +		duty |=3D (pwm->hwpwm << PWM_DD_SEL_BIT_SHIFT);
> +	}
> +	writel(duty, priv->base + PWM_SUP_DUTY(pwm->hwpwm));
> +	writel(value1, priv->base + PWM_SUP_CONTROL1);
> +	writel(value, priv->base + PWM_SUP_CONTROL0);

What is the difference between CONTROL1 and CONTROL0?

> +	return 0;
> +}
> +
> +static void sunplus_pwm_get_state(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> +				  struct pwm_state *state)
> +{
> +	struct sunplus_pwm *priv =3D to_sunplus_pwm(chip);
> +	u32 value, freq, duty, rate, freq_tmp, duty_tmp;
> +	u64 tmp, clk_rate;
> +
> +	value =3D readl(priv->base + PWM_SUP_CONTROL0);
> +
> +	if (value & BIT(pwm->hwpwm)) {
> +		clk_rate =3D clk_get_rate(priv->clk);
> +		rate =3D (u32)clk_rate / 100000;
> +		freq =3D readl(priv->base + PWM_SUP_FREQ(pwm->hwpwm));
> +		duty =3D readl(priv->base + PWM_SUP_DUTY(pwm->hwpwm));
> +		duty &=3D ~GENMASK(9, 8);
> +
> +		freq_tmp =3D rate * priv->approx_period[pwm->hwpwm] / (PWM_SUP_FREQ_SC=
ALER * 100);
> +		duty_tmp =3D priv->approx_duty_cycle[pwm->hwpwm] * PWM_SUP_FREQ_SCALER=
 /
> +				priv->approx_period[pwm->hwpwm];
> +
> +		if (freq =3D=3D freq_tmp && duty =3D=3D duty_tmp) {
> +			state->period =3D priv->approx_period[pwm->hwpwm] * 100;
> +			state->duty_cycle =3D priv->approx_duty_cycle[pwm->hwpwm] * 100;
> +		} else {
> +			tmp =3D (u64)freq * PWM_SUP_FREQ_SCALER * 10000;
> +			state->period =3D div64_u64(tmp, rate);
> +			tmp =3D (u64)freq * (u64)duty * 10000;
> +			state->duty_cycle =3D div64_u64(tmp, rate);
> +		}
> +		state->enabled =3D true;
> +	} else {
> +		state->enabled =3D false;
> +	}
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +}

When .get_state() is first called, .apply wasn't called yet. Then
priv->approx_period[pwm->hwpwm] is zero and the returned result is
wrong. Please read the register values and calculate the implemented
output without caching.

> +static const struct pwm_ops sunplus_pwm_ops =3D {
> +	.free =3D sunplus_pwm_free,
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

If priv->clk is the dummy clk, clk_get_rate returns 0. This is bad as
(at lease up to now) you divide by rate in .apply().

> +
> +	ret =3D clk_prepare_enable(priv->clk);
> +	if (ret)

missing error message

> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(dev,
> +				       (void(*)(void *))clk_disable_unprepare,

Without checking my C book I'm unsure if this is save on all platforms.
I'd implement a oneline function for this.

> +				       priv->clk);
> +	if (ret)

missing error message

> +		return ret;
> +
> +	priv->chip.dev =3D dev;
> +	priv->chip.ops =3D &sunplus_pwm_ops;
> +	priv->chip.npwm =3D PWM_SUP_NUM;
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
> --=20
> 2.7.4
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nfe4uycujul6nwas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIiYPoACgkQwfwUeK3K
7AkFUgf/fgwv5RR1fJPBqV3VgkEmoaXS0HUkGCBizTRErv34mxDZO5FD3GhJQ/7D
hLDdtwYtfntkg8+dazdNXJSuHdpANPm8bFV+NIUaBD2pkr4UeFHcO1WqT1PztUO0
9YVHpvKPUpFRGaU3TTZ87dMXNhabuuloOfso2SaWwPTa8rE+j9TvfIvsEt7En9NO
pX4jqVBfh6IAJhHt6uhAmHJ93bqZj7FVjDDKelBrphnVZB8PbUcUSPW2nhlLwK7U
YViM/ZuICl0VAv3u2eY/UezrHkGaLM+fOlvoHvxSsBj+6R1ECVDcHyDi5LmaVA3S
6Cebie9Ht4XvebL8x+UreLDWjjJOFw==
=WCLk
-----END PGP SIGNATURE-----

--nfe4uycujul6nwas--

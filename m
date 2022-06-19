Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DA5550D52
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 23:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbiFSVgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 17:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiFSVgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 17:36:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6BCAE5A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 14:36:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o32aC-0007hT-2I; Sun, 19 Jun 2022 23:35:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o32a7-001WKi-3z; Sun, 19 Jun 2022 23:35:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o32a7-00HS9b-QX; Sun, 19 Jun 2022 23:35:43 +0200
Date:   Sun, 19 Jun 2022 23:35:20 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] pwm: Add support for the MSTAR MSC313 PWM
Message-ID: <20220619213520.qonqdv4e7zkvpeo7@pengutronix.de>
References: <20220615070813.7720-1-romain.perier@gmail.com>
 <20220615070813.7720-3-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="silqiuwepn6la4xp"
Content-Disposition: inline
In-Reply-To: <20220615070813.7720-3-romain.perier@gmail.com>
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


--silqiuwepn6la4xp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jun 15, 2022 at 09:08:10AM +0200, Romain Perier wrote:
> From: Daniel Palmer <daniel@0x0f.com>
>=20
> This adds support for the PWM block on the Mstar MSC313e SoCs and newer.
>=20
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> Co-developed-by: Romain Perier <romain.perier@gmail.com>
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  MAINTAINERS               |   1 +
>  drivers/pwm/Kconfig       |  10 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-msc313e.c | 242 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 254 insertions(+)
>  create mode 100644 drivers/pwm/pwm-msc313e.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2316278d9db9..45d001643b93 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2389,6 +2389,7 @@ F:	arch/arm/mach-mstar/
>  F:	drivers/clk/mstar/
>  F:	drivers/clocksource/timer-msc313e.c
>  F:	drivers/gpio/gpio-msc313.c
> +F:	drivers/pwm/pwm-msc313e.c
>  F:	drivers/rtc/rtc-msc313.c
>  F:	drivers/watchdog/msc313e_wdt.c
>  F:	include/dt-bindings/clock/mstar-*
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 904de8d61828..802573122b25 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -651,6 +651,16 @@ config PWM_VT8500
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-vt8500.
> =20
> +config PWM_MSC313E
> +	tristate "MStar MSC313e PWM support"
> +	depends on ARCH_MSTARV7 || COMPILE_TEST
> +	help
> +	  Generic PWM framework driver for MSTAR MSC313e.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-msc313e.
> +
> +

only one empty line between entries, and also please stick to alphabetic
ordering.

>  config PWM_XILINX
>  	tristate "Xilinx AXI Timer PWM support"
>  	depends on OF_ADDRESS
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 5c08bdb817b4..e24a48c78335 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -61,4 +61,5 @@ obj-$(CONFIG_PWM_TWL)		+=3D pwm-twl.o
>  obj-$(CONFIG_PWM_TWL_LED)	+=3D pwm-twl-led.o
>  obj-$(CONFIG_PWM_VISCONTI)	+=3D pwm-visconti.o
>  obj-$(CONFIG_PWM_VT8500)	+=3D pwm-vt8500.o
> +obj-$(CONFIG_PWM_MSC313E)	+=3D pwm-msc313e.o
>  obj-$(CONFIG_PWM_XILINX)	+=3D pwm-xilinx.o
> diff --git a/drivers/pwm/pwm-msc313e.c b/drivers/pwm/pwm-msc313e.c
> new file mode 100644
> index 000000000000..f20419c6b9be
> --- /dev/null
> +++ b/drivers/pwm/pwm-msc313e.c
> @@ -0,0 +1,242 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Daniel Palmer <daniel@thingy.jp>
> + * Copyright (C) 2022 Romain Perier <romain.perier@gmail.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/of_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +#define DRIVER_NAME "msc313e-pwm"
> +
> +#define CHANNEL_OFFSET	0x80
> +#define REG_DUTY	0x8
> +#define REG_PERIOD	0x10
> +#define REG_DIV		0x18
> +#define REG_CTRL	0x1c
> +#define REG_SWRST	0x1fc
> +
> +struct msc313e_pwm_channel {
> +	struct regmap_field *clkdiv;
> +	struct regmap_field *polarity;
> +	struct regmap_field *dutyl;
> +	struct regmap_field *dutyh;
> +	struct regmap_field *periodl;
> +	struct regmap_field *periodh;
> +	struct regmap_field *swrst;
> +};
> +
> +struct msc313e_pwm {
> +	struct regmap *regmap;
> +	struct pwm_chip pwmchip;
> +	struct clk *clk;
> +	struct msc313e_pwm_channel channels[];
> +};
> +
> +struct msc313e_pwm_info {
> +	unsigned int channels;
> +};
> +
> +#define to_msc313e_pwm(ptr) container_of(ptr, struct msc313e_pwm, pwmchi=
p)
> +
> +static const struct regmap_config msc313e_pwm_regmap_config =3D {
> +	.reg_bits =3D 16,
> +	.val_bits =3D 16,
> +	.reg_stride =3D 4,
> +};
> +
> +static const struct msc313e_pwm_info msc313e_data =3D {
> +	.channels =3D 8,
> +};
> +
> +static const struct msc313e_pwm_info ssd20xd_data =3D {
> +	.channels =3D 4,
> +};
> +
> +static void msc313e_pwm_writecounter(struct regmap_field *low, struct re=
gmap_field *high, u32 value)
> +{
> +	regmap_field_write(low, value);
> +	regmap_field_write(high, value >> 16);

Is this racy? E.g. if the hw is running and the low register overflows
before the high register is updated?

> +}
> +
> +static int msc313e_pwm_config(struct pwm_chip *chip, struct pwm_device *=
device,
> +			      int duty_ns, int period_ns)
> +{
> +	struct msc313e_pwm *pwm =3D to_msc313e_pwm(chip);
> +	struct msc313e_pwm_channel *channel =3D &pwm->channels[device->hwpwm];
> +	unsigned long long nspertick =3D DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, cl=
k_get_rate(pwm->clk));
> +	unsigned long long div =3D 1;
> +
> +	/* fit the period into the period register by prescaling the clk */
> +	while (DIV_ROUND_CLOSEST_ULL(period_ns, (nspertick =3D DIV_ROUND_CLOSES=
T_ULL(nspertick, div)))
> +	      > 0x3ffff){

Strange line breaking.

Dividing by a division is inexact, also please round down, not
round-closest.

Please test your driver with PWM_DEBUG enabled, and use something like I
proposed in
https://lore.kernel.org/linux-pwm/20220607200755.tgsrwe4ten5inw27@pengutron=
ix.de .


> +		div++;
> +		if (div > (0xffff + 1)) {
> +			dev_err(chip->dev, "Can't fit period into period register\n");
> +			return -EINVAL;
> +		}

If the requested period is too big, please configure the biggest
possible period.

Also .apply() shouldn't emit error messages as this might flood the
kernel log.

> +	}
> +
> +	regmap_field_write(channel->clkdiv, div - 1);
> +	msc313e_pwm_writecounter(channel->dutyl, channel->dutyh,
> +				 DIV_ROUND_CLOSEST_ULL(duty_ns, nspertick));
> +	msc313e_pwm_writecounter(channel->periodl, channel->periodh,
> +				 DIV_ROUND_CLOSEST_ULL(period_ns, nspertick));
> +
> +	return 0;
> +};
> +
> +static int msc313e_pwm_set_polarity(struct pwm_chip *chip, struct pwm_de=
vice *device,
> +				    enum pwm_polarity polarity)
> +{
> +	struct msc313e_pwm *pwm =3D to_msc313e_pwm(chip);
> +	struct msc313e_pwm_channel *channel =3D &pwm->channels[device->hwpwm];
> +	unsigned int pol =3D 0;
> +
> +	if (polarity =3D=3D PWM_POLARITY_INVERSED)
> +		pol =3D 1;
> +	regmap_field_update_bits(channel->polarity, 1, pol);
> +
> +	return 0;
> +}
> +
> +static int msc313e_pwm_enable(struct pwm_chip *chip, struct pwm_device *=
device)
> +{
> +	struct msc313e_pwm *pwm =3D to_msc313e_pwm(chip);
> +	struct msc313e_pwm_channel *channel =3D &pwm->channels[device->hwpwm];
> +	int ret;
> +
> +	ret =3D clk_prepare_enable(pwm->clk);
> +	if (ret)
> +		return ret;
> +
> +	regmap_field_write(channel->swrst, 0);
> +
> +	return 0;
> +}
> +
> +static void msc313e_pwm_disable(struct pwm_chip *chip, struct pwm_device=
 *device)
> +{
> +	struct msc313e_pwm *pwm =3D to_msc313e_pwm(chip);
> +	struct msc313e_pwm_channel *channel =3D &pwm->channels[device->hwpwm];
> +
> +	regmap_field_write(channel->swrst, 1);
> +	clk_disable(pwm->clk);

how does the hardware behave on disable? Does it emit the inactive
level? Or 0? Or does it freeze? Or high-Z? Please document that like
it's done e.g. in drivers/pwm/pwm-sl28cpld.c. Stick to the format used
there. (i.e. "Limitations:" + a list of hardware properties in the
toplevel comment.)

Does setting swrst ("software reset"?) reset the other registers?

> +}
> +
> +static int msc313e_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	if (state->enabled) {
> +		msc313e_pwm_enable(chip, pwm);
> +		msc313e_pwm_set_polarity(chip, pwm, state->polarity);
> +		msc313e_pwm_config(chip, pwm, state->duty_cycle, state->period);

If you enable at the end, you might prevent a glitch. I assume the
glitch isn't preventable in general?

Is the currently running period completed when a new configuration is
written to the registers?

As msc313e_pwm_enable calls clk_prepare_enable() unconditionally, and
it's valid to call pwm_apply several times in a row with state->enabled
=3D true, the clk calls are not balanced.

> +	} else {
> +		msc313e_pwm_disable(chip, pwm);
> +	}
> +	return 0;
> +}
> +
> +static void msc313e_get_state(struct pwm_chip *chip, struct pwm_device *=
device,
> +			      struct pwm_state *state)
> +{
> +	struct msc313e_pwm *pwm =3D to_msc313e_pwm(chip);
> +	struct msc313e_pwm_channel *channel =3D &pwm->channels[device->hwpwm];
> +	unsigned int pol =3D 0;
> +
> +	regmap_field_read(channel->polarity, &pol);
> +	state->polarity =3D pol;

I'd prefer something like:

state->polarity =3D pol ? PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;

to not hardcode the values of the PWM constants in the driver.

Also this is incomplete, you need to handle .duty_cycle, .period and
=2Eenabled, too.

> +}
> +
> +static const struct pwm_ops msc313e_pwm_ops =3D {
> +	.config =3D msc313e_pwm_config,
> +	.set_polarity =3D msc313e_pwm_set_polarity,
> +	.enable =3D msc313e_pwm_enable,
> +	.disable =3D msc313e_pwm_disable,

Please drop these. If there is an apply functions, these are all unused.

> +	.apply =3D msc313e_apply,
> +	.get_state =3D msc313e_get_state,
> +	.owner =3D THIS_MODULE
> +};
> +
> +static int msc313e_pwm_probe(struct platform_device *pdev)
> +{
> +	const struct msc313e_pwm_info *match_data;
> +	struct device *dev =3D &pdev->dev;
> +	struct msc313e_pwm *pwm;
> +	__iomem void *base;
> +	int i;
> +
> +	match_data =3D of_device_get_match_data(dev);
> +	if (!match_data)
> +		return -EINVAL;
> +
> +	base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	pwm =3D devm_kzalloc(dev, struct_size(pwm, channels, match_data->channe=
ls), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	pwm->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(pwm->clk))
> +		return dev_err_probe(dev, PTR_ERR(pwm->clk), "Cannot get clk\n");
> +
> +	pwm->regmap =3D devm_regmap_init_mmio(dev, base, &msc313e_pwm_regmap_co=
nfig);
> +	if (IS_ERR(pwm->regmap))
> +		return dev_err_probe(dev, PTR_ERR(pwm->regmap), "Cannot get regmap\n");
> +
> +	for (i =3D 0; i < match_data->channels; i++) {
> +		unsigned int offset =3D CHANNEL_OFFSET * i;
> +		struct reg_field div_clkdiv_field =3D REG_FIELD(offset + REG_DIV, 0, 7=
);
> +		struct reg_field ctrl_polarity_field =3D REG_FIELD(offset + REG_CTRL, =
4, 4);
> +		struct reg_field dutyl_field =3D REG_FIELD(offset + REG_DUTY, 0, 15);
> +		struct reg_field dutyh_field =3D REG_FIELD(offset + REG_DUTY + 4, 0, 2=
);
> +		struct reg_field periodl_field =3D REG_FIELD(offset + REG_PERIOD, 0, 1=
5);
> +		struct reg_field periodh_field =3D REG_FIELD(offset + REG_PERIOD + 4, =
0, 2);
> +		struct reg_field swrst_field =3D REG_FIELD(REG_SWRST, i, i);
> +
> +		pwm->channels[i].clkdiv =3D devm_regmap_field_alloc(dev, pwm->regmap,
> +								  div_clkdiv_field);
> +		pwm->channels[i].polarity =3D devm_regmap_field_alloc(dev, pwm->regmap,
> +								    ctrl_polarity_field);
> +		pwm->channels[i].dutyl =3D devm_regmap_field_alloc(dev, pwm->regmap, d=
utyl_field);
> +		pwm->channels[i].dutyh =3D devm_regmap_field_alloc(dev, pwm->regmap, d=
utyh_field);
> +		pwm->channels[i].periodl =3D devm_regmap_field_alloc(dev, pwm->regmap,=
 periodl_field);
> +		pwm->channels[i].periodh =3D devm_regmap_field_alloc(dev, pwm->regmap,=
 periodh_field);
> +		pwm->channels[i].swrst =3D devm_regmap_field_alloc(dev, pwm->regmap, s=
wrst_field);

Huh, never saw something like that. Is that really easier than using
regmap_write()?

> +	}
> +
> +	pwm->pwmchip.dev =3D dev;
> +	pwm->pwmchip.ops =3D &msc313e_pwm_ops;
> +	pwm->pwmchip.base =3D -1;

Please drop this line

> +	pwm->pwmchip.npwm =3D match_data->channels;
> +	pwm->pwmchip.of_xlate =3D of_pwm_xlate_with_flags;

You can drop this, this is assigned by default in the pwmchip_add
function.

> +	pwm->pwmchip.of_pwm_n_cells =3D 3;

I didn't double check, but if the dtb has #pwm-cells =3D <3> this isn't
needed.

> +
> +	platform_set_drvdata(pdev, pwm);

This is unused -> drop.

> +	return devm_pwmchip_add(dev, &pwm->pwmchip);
> +}
> +
> +static const struct of_device_id msc313e_pwm_dt_ids[] =3D {
> +	{ .compatible =3D "mstar,msc313e-pwm", .data =3D &msc313e_data },
> +	{ .compatible =3D "mstar,ssd20xd-pwm", .data =3D &ssd20xd_data },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, msc313e_pwm_dt_ids);
> +
> +static struct platform_driver msc313e_pwm_driver =3D {
> +	.probe =3D msc313e_pwm_probe,
> +	.driver =3D {
> +		.name =3D DRIVER_NAME,
> +		.of_match_table =3D msc313e_pwm_dt_ids,
> +	},
> +};
> +module_platform_driver(msc313e_pwm_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Mstar MSC313e PWM driver");
> +MODULE_AUTHOR("Daniel Palmer <daniel@thingy.jp>");
> --=20

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--silqiuwepn6la4xp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKvlpUACgkQwfwUeK3K
7AlzsQf/RY9U+Lyajw1cDmiTyhNYqB8fzUUESTBtOT3NKqbboYz5YbYxBGPQpqQ9
v9Ng1I1+UMJfu3Gs/5T2SHrMTKiXt8HUhbrZZu+SfdqDjJzrfSEKLLZeSZNIpKfB
xj6vrVifuLX7xjvfOlUfM99eTknF7Vtih1zDbBp/wJnP34w0eio3OIarQ2DPonOE
z4dw89YcYuD6YvhWGHeY8zL9G9f1vrYfW36pAktWD7Oa3BLNup1u/Lwr/rfaBgVK
DXyFrxBBULozjFoDd4RaF407RMZk4ZOmXTeHEAlx9Vc0/zVr/lz3DqURPGGKi7ef
6vFYBFDnAGka8rjuInVQpkGsT+coLw==
=0Sk+
-----END PGP SIGNATURE-----

--silqiuwepn6la4xp--

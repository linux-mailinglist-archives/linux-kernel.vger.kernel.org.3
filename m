Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B625856CA7C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 18:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiGIQCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 12:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGIQCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 12:02:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF47E11150
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 09:02:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oACuK-0001RI-7e; Sat, 09 Jul 2022 18:02:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oACuF-005Szo-1L; Sat, 09 Jul 2022 18:02:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oACuH-0048jN-TF; Sat, 09 Jul 2022 18:02:09 +0200
Date:   Sat, 9 Jul 2022 18:02:06 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 3/4] pwm: add microchip soft ip corePWM driver
Message-ID: <20220709160206.cw5luo7kxdshoiua@pengutronix.de>
References: <20220708143923.1129928-1-conor.dooley@microchip.com>
 <20220708143923.1129928-4-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yivmdduo6omkair4"
Content-Disposition: inline
In-Reply-To: <20220708143923.1129928-4-conor.dooley@microchip.com>
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


--yivmdduo6omkair4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Conor,

On Fri, Jul 08, 2022 at 03:39:22PM +0100, Conor Dooley wrote:
> Add a driver that supports the Microchip FPGA "soft" PWM IP core.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pwm/Kconfig              |  10 +
>  drivers/pwm/Makefile             |   1 +
>  drivers/pwm/pwm-microchip-core.c | 355 +++++++++++++++++++++++++++++++
>  3 files changed, 366 insertions(+)
>  create mode 100644 drivers/pwm/pwm-microchip-core.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 904de8d61828..007ea5750e73 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -383,6 +383,16 @@ config PWM_MEDIATEK
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-mediatek.
> =20
> +config PWM_MICROCHIP_CORE
> +	tristate "Microchip corePWM PWM support"
> +	depends on SOC_MICROCHIP_POLARFIRE || COMPILE_TEST
> +	depends on HAS_IOMEM && OF
> +	help
> +	  PWM driver for Microchip FPGA soft IP core.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-microchip-core.
> +
>  config PWM_MXS
>  	tristate "Freescale MXS PWM support"
>  	depends on ARCH_MXS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 5c08bdb817b4..43feb7cfc66a 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_PWM_LPSS_PCI)	+=3D pwm-lpss-pci.o
>  obj-$(CONFIG_PWM_LPSS_PLATFORM)	+=3D pwm-lpss-platform.o
>  obj-$(CONFIG_PWM_MESON)		+=3D pwm-meson.o
>  obj-$(CONFIG_PWM_MEDIATEK)	+=3D pwm-mediatek.o
> +obj-$(CONFIG_PWM_MICROCHIP_CORE)	+=3D pwm-microchip-core.o
>  obj-$(CONFIG_PWM_MTK_DISP)	+=3D pwm-mtk-disp.o
>  obj-$(CONFIG_PWM_MXS)		+=3D pwm-mxs.o
>  obj-$(CONFIG_PWM_NTXEC)		+=3D pwm-ntxec.o
> diff --git a/drivers/pwm/pwm-microchip-core.c b/drivers/pwm/pwm-microchip=
-core.c
> new file mode 100644
> index 000000000000..3471eb2c8645
> --- /dev/null
> +++ b/drivers/pwm/pwm-microchip-core.c
> @@ -0,0 +1,355 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * corePWM driver for Microchip "soft" FPGA IP cores.
> + *
> + * Copyright (c) 2021-2022 Microchip Corporation. All rights reserved.
> + * Author: Conor Dooley <conor.dooley@microchip.com>
> + * Documentation:
> + * https://www.microsemi.com/document-portal/doc_download/1245275-corepw=
m-hb
> + *
> + * Limitations:
> + * - If the IP block is configured without "shadow registers", all regis=
ter
> + *   writes will take effect immediately, causing glitches on the output.
> + *   If shadow registers *are* enabled, a write to the "SYNC_UPDATE" reg=
ister
> + *   notifies the core that it needs to update the registers defining the
> + *   waveform from the contents of the "shadow registers".
> + * - The IP block has no concept of a duty cycle, only rising/falling ed=
ges of
> + *   the waveform. Unfortunately, if the rising & falling edges register=
s have
> + *   the same value written to them the IP block will do whichever of a =
rising
> + *   or a falling edge is possible. I.E. a 50% waveform at twice the req=
uested
> + *   period. Therefore to get a 0% waveform, the output is set the max h=
igh/low
> + *   time depending on polarity.
> + * - The PWM period is set for the whole IP block not per channel. The d=
river
> + *   will only change the period if no other PWM output is enabled.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/spinlock.h>
> +
> +#define PREG_TO_VAL(PREG) ((PREG) + 1)
> +
> +#define MCHPCOREPWM_PRESCALE_MAX	0x100
> +#define MCHPCOREPWM_PERIOD_STEPS_MAX	0xff
> +#define MCHPCOREPWM_PERIOD_MAX		0xff00
> +
> +#define MCHPCOREPWM_PRESCALE	0x00
> +#define MCHPCOREPWM_PERIOD	0x04
> +#define MCHPCOREPWM_EN(i)	(0x08 + 0x04 * (i)) /* 0x08, 0x0c */
> +#define MCHPCOREPWM_POSEDGE(i)	(0x10 + 0x08 * (i)) /* 0x10, 0x18, ..., 0=
x88 */
> +#define MCHPCOREPWM_NEGEDGE(i)	(0x14 + 0x08 * (i)) /* 0x14, 0x1c, ..., 0=
x8c */
> +#define MCHPCOREPWM_SYNC_UPD	0xe4
> +
> +struct mchp_core_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	spinlock_t lock; /* protect the shared period */
> +	void __iomem *base;
> +	u32 sync_update_mask;
> +};
> +
> +static inline struct mchp_core_pwm_chip *to_mchp_core_pwm(struct pwm_chi=
p *chip)
> +{
> +	return container_of(chip, struct mchp_core_pwm_chip, chip);
> +}
> +
> +static void mchp_core_pwm_enable(struct pwm_chip *chip, struct pwm_devic=
e *pwm, bool enable)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u8 channel_enable, reg_offset, shift;
> +
> +	/*
> +	 * There are two adjacent 8 bit control regs, the lower reg controls
> +	 * 0-7 and the upper reg 8-15. Check if the pwm is in the upper reg
> +	 * and if so, offset by the bus width.
> +	 */
> +	reg_offset =3D MCHPCOREPWM_EN(pwm->hwpwm >> 3);
> +	shift =3D pwm->hwpwm > 7 ? pwm->hwpwm - 8 : pwm->hwpwm;

I would have used

	shift =3D pwm->hwpwm & 7;

here. Maybe it's subjective, but for me it's a more obvious match to
pwm->hwpwm >> 3 then.

> +	spin_lock(&mchp_core_pwm->lock);
> +
> +	channel_enable =3D readb_relaxed(mchp_core_pwm->base + reg_offset);
> +	channel_enable &=3D ~(1 << shift);
> +	channel_enable |=3D (enable << shift);
> +
> +	writel_relaxed(channel_enable, mchp_core_pwm->base + reg_offset);
> +
> +	/*
> +	 * Write to the sync update registers so that channels with shadow
> +	 * registers will also get their enable update. This operation is a NOP
> +	 * for channels without shadow registers.
> +	 */
> +	writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
> +
> +	spin_unlock(&mchp_core_pwm->lock);
> +}
> +
> +static void mchp_core_pwm_apply_duty(struct pwm_chip *chip, struct pwm_d=
evice *pwm,
> +				     const struct pwm_state *state, u8 prescale, u8 period_steps)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u64 duty_steps, period, tmp;
> +	u8 posedge, negedge;
> +	u16 prescale_val =3D PREG_TO_VAL(prescale);
> +	u8 period_steps_val =3D PREG_TO_VAL(period_steps);
> +
> +	period =3D period_steps_val * prescale_val * NSEC_PER_SEC;
> +	period =3D DIV64_U64_ROUND_UP(period, clk_get_rate(mchp_core_pwm->clk));
> +
> +	/*
> +	 * Calculate the duty cycle in multiples of the prescaled period:
> +	 * duty_steps =3D duty_in_ns / step_in_ns
> +	 * step_in_ns =3D (prescale * NSEC_PER_SEC) / clk_rate
> +	 * The code below is rearranged slightly to only divide once.
> +	 *
> +	 * Because the period is per channel, it is possible that the requested
> +	 * duty cycle is longer than the period, in which case cap it to the
> +	 * period.
> +	 */
> +	if (state->duty_cycle > period) {
> +		duty_steps =3D period_steps_val;
> +	} else {
> +		duty_steps =3D state->duty_cycle * clk_get_rate(mchp_core_pwm->clk);
> +		tmp =3D prescale_val * NSEC_PER_SEC;
> +		duty_steps =3D div64_u64(duty_steps, tmp);
> +	}
> +
> +	/*
> +	 * Turn the output on unless posedge =3D=3D negedge, in which case the
> +	 * duty is intended to be 0, but limitations of the IP block don't
> +	 * allow a zero length duty cycle - so just set the max high/low time
> +	 * respectively.
> +	 */
> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED) {
> +		negedge =3D !duty_steps ? period_steps_val : 0u;
> +		posedge =3D duty_steps;
> +	} else {
> +		posedge =3D !duty_steps ? period_steps_val : 0u;
> +		negedge =3D duty_steps;
> +	}
> +
> +	writel_relaxed(posedge, mchp_core_pwm->base + MCHPCOREPWM_POSEDGE(pwm->=
hwpwm));
> +	writel_relaxed(negedge, mchp_core_pwm->base + MCHPCOREPWM_NEGEDGE(pwm->=
hwpwm));
> +}
> +
> +static int mchp_core_pwm_apply_period(struct pwm_chip *chip, const struc=
t pwm_state *state,
> +				      u8 *prescale, u8 *period_steps)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u64 tmp, clk_rate;
> +	u16 prescale_val, period_steps_val;
> +
> +	/*
> +	 * Calculate the period cycles and prescale values.
> +	 * The registers are each 8 bits wide & multiplied to compute the period
> +	 * using the formula:
> +	 * (clock_period) * (prescale + 1) * (period_steps + 1)
> +	 * so the maximum period that can be generated is 0x10000 times the
> +	 * period of the input clock.
> +	 * However, due to the design of the "hardware", it is not possible to
> +	 * attain a 100% duty cycle if the full range of period_steps is used.
> +	 * Therefore period_steps is restricted to 0xFE and the maximum multiple
> +	 * of the clock period attainable is 0xFF00.
> +	 */
> +	clk_rate =3D clk_get_rate(mchp_core_pwm->clk);

+	/* If clk_rate is too big, the following multiplication might overflow */

> +	if (clk_rate >=3D NSEC_PER_SEC)
> +		return -EINVAL;
> +
> +	tmp =3D mul_u64_u64_div_u64(state->period, clk_rate, NSEC_PER_SEC);
> +
> +	if (tmp >=3D MCHPCOREPWM_PERIOD_MAX) {
> +		*prescale =3D MCHPCOREPWM_PRESCALE_MAX - 1;
> +		*period_steps =3D MCHPCOREPWM_PERIOD_STEPS_MAX - 1;
> +		goto write_registers;
> +	}
> +
> +	for (prescale_val =3D 1; prescale_val <=3D MCHPCOREPWM_PRESCALE_MAX; pr=
escale_val++) {
> +		period_steps_val =3D div_u64(tmp, prescale_val);
> +		if (period_steps_val > MCHPCOREPWM_PERIOD_STEPS_MAX)
> +			continue;
> +		*period_steps =3D period_steps_val - 1;
> +		*prescale =3D prescale_val - 1;
> +		break;
> +	}

OK, so you want to find the smallest prescale_val such that

	prescale_val * MCHPCOREPWM_PERIOD_STEPS_MAX >=3D tmp

=2E You can calculate that without a loop as:

	prescale_val =3D div_u64(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX);


> +
> +write_registers:
> +	writel_relaxed(*prescale, mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
> +	writel_relaxed(*period_steps, mchp_core_pwm->base + MCHPCOREPWM_PERIOD);
> +
> +	return 0;
> +}
> +
> +static int mchp_core_pwm_apply(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       const struct pwm_state *state)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	struct pwm_state current_state =3D pwm->state;
> +	bool period_locked;
> +	u64 period;
> +	u16 channel_enabled;
> +	u8 prescale, period_steps;
> +	int ret;
> +
> +	if (!state->enabled) {
> +		mchp_core_pwm_enable(chip, pwm, false);
> +		return 0;
> +	}
> +
> +	/*
> +	 * If the only thing that has changed is the duty cycle or the polarity,
> +	 * we can shortcut the calculations and just compute/apply the new duty
> +	 * cycle pos & neg edges
> +	 * As all the channels share the same period, do not allow it to be
> +	 * changed if any other channels are enabled.
> +	 */
> +	spin_lock(&mchp_core_pwm->lock);
> +
> +	channel_enabled =3D (((u16)readb_relaxed(mchp_core_pwm->base + MCHPCORE=
PWM_EN(1)) << 8) |
> +		readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_EN(0)));
> +	period_locked =3D channel_enabled & ~(1 << pwm->hwpwm);
> +
> +	if ((!current_state.enabled || current_state.period !=3D state->period)=
 && !period_locked) {
> +		ret =3D mchp_core_pwm_apply_period(chip, state, &prescale, &period_ste=
ps);
> +		if (ret) {
> +			spin_unlock(&mchp_core_pwm->lock);
> +			return ret;
> +		}
> +	} else {
> +		prescale =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
> +		period_steps =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PERIO=
D);
> +	}
> +
> +	/*
> +	 * If the period is locked, it may not be possible to use a period less
> +	 * than that requested.
> +	 */
> +	period =3D PREG_TO_VAL(period_steps) *  PREG_TO_VAL(prescale) * NSEC_PE=
R_SEC;

s/  / /

> +	do_div(period, clk_get_rate(mchp_core_pwm->clk));
> +	if (period > state->period) {
> +		spin_unlock(&mchp_core_pwm->lock);
> +		return -EINVAL;
> +	}

I would consider it easier to do the following (in pseudo syntax):

	prescale, period_steps =3D calculate_hwperiod(period);

	if (period_locked):
		hwprescale =3D readb_relaxed(PRESCALE)
		hwperiod_steps =3D readb_relaxed(PERIOD)

		if period_steps * prescale < hwperiod_steps * hwprescale:
			return -EINVAL
		else
			prescale, period_steps =3D hwprescale,
			hwperiod_steps
=09
	duty_steps =3D calculate_hwduty(duty, prescale)
	if (duty_steps > period_steps)
		duty_steps =3D period_steps


> +	mchp_core_pwm_apply_duty(chip, pwm, state, prescale, period_steps);
> +
> +	/*
> +	 * Notify the block to update the waveform from the shadow registers.
> +	 * The updated values will not appear on the bus until they have been
> +	 * applied to the waveform at the beginning of the next period. We must
> +	 * write these registers and wait for them to be applied before calling
> +	 * enable().
> +	 */
> +	if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm)) {
> +		writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
> +		usleep_range(state->period, state->period * 2);
> +	}
> +
> +	spin_unlock(&mchp_core_pwm->lock);
> +
> +	mchp_core_pwm_enable(chip, pwm, true);

I already asked in the last round: Do you really need to write the
SYNC_UPD register twice? I would expect that you don't?!

Also the locking looks fishy here. It would be simpler (and maybe even
more robust, didn't think deeply about it) to assume in
mchp_core_pwm_enable() that the caller holds the lock. Then you only
grab the lock once during .apply() and nothing strange can happen in the
gap.

> +	return 0;
> +}
> +
> +static void mchp_core_pwm_get_state(struct pwm_chip *chip, struct pwm_de=
vice *pwm,
> +				    struct pwm_state *state)
> +{
> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> +	u8 prescale, period_steps, duty_steps;
> +	u8 posedge, negedge;
> +	u16 channel_enabled;
> +

I'd take the lock here to be sure to get a consistent return value.

> +	channel_enabled =3D (((u16)readb_relaxed(mchp_core_pwm->base + MCHPCORE=
PWM_EN(1)) << 8) |
> +		readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_EN(0)));

micro optimisation: You're reading two register values here, but only use
one. Shadowing the enabled registers in mchp_core_pwm might also be an
idea.

> +	if (channel_enabled & 1 << pwm->hwpwm)

I'm always unsure about the associativity of & and <<, so I would have
written that as

	if (channel_enabled & (1 << pwm->hwpwm))

I just tested that for the umpteens time and your code is fine, so this
is only for human readers like me.

> +		state->enabled =3D true;
> +	else
> +		state->enabled =3D false;
> +
> +	prescale =3D PREG_TO_VAL(readb_relaxed(mchp_core_pwm->base + MCHPCOREPW=
M_PRESCALE));
> +
> +	posedge =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_POSEDGE(pwm=
->hwpwm));
> +	negedge =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_NEGEDGE(pwm=
->hwpwm));
> +
> +	duty_steps =3D abs((s16)posedge - (s16)negedge);

If duty_steps =3D=3D 0 the returned result is wrong. I suggest to fix that,
at least mention the problem in a comment.

> +	state->duty_cycle =3D duty_steps * prescale * NSEC_PER_SEC;

Can this overflow?

> +	do_div(state->duty_cycle, clk_get_rate(mchp_core_pwm->clk));

What is the typical return value of clk_get_rate(mchp_core_pwm->clk)?
You need to round up here. Did you test your driver with PWM_DEBUG on?
During test please do for a few fixed periods:

	for duty_cycle in [0 .. period]:
		pwm_apply(mypwm, {.period =3D period, .duty_cycle =3D duty_cycle, .enable=
d =3D true, ...})

	for duty_cycle in [period .. 0]:
		pwm_apply(mypwm, {.period =3D period, .duty_cycle =3D duty_cycle, .enable=
d =3D true, ...})

and check there is no output claiming a miscalculation.

> +	state->polarity =3D negedge < posedge ? PWM_POLARITY_INVERSED : PWM_POL=
ARITY_NORMAL;
> +
> +	period_steps =3D PREG_TO_VAL(readb_relaxed(mchp_core_pwm->base + MCHPCO=
REPWM_PERIOD));
> +	state->period =3D period_steps * prescale * NSEC_PER_SEC;
> +	do_div(state->period, clk_get_rate(mchp_core_pwm->clk));

you need to round up here, too.

(The reasoning for the rounding direction is that applying the state
returned by .get_state() should not change the hw settings. If you round
down in both .apply() and .get_state() this doesn't work.)

> +}
> +
> +static const struct pwm_ops mchp_core_pwm_ops =3D {
> +	.apply =3D mchp_core_pwm_apply,
> +	.get_state =3D mchp_core_pwm_get_state,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static const struct of_device_id mchp_core_of_match[] =3D {
> +	{
> +		.compatible =3D "microchip,corepwm-rtl-v4",
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mchp_core_of_match);
> +
> +static int mchp_core_pwm_probe(struct platform_device *pdev)
> +{
> +	struct mchp_core_pwm_chip *mchp_pwm;
> +	struct resource *regs;
> +	int ret;
> +
> +	mchp_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*mchp_pwm), GFP_KERNEL);
> +	if (!mchp_pwm)
> +		return -ENOMEM;
> +
> +	mchp_pwm->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &reg=
s);
> +	if (IS_ERR(mchp_pwm->base))
> +		return PTR_ERR(mchp_pwm->base);
> +
> +	mchp_pwm->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(mchp_pwm->clk))
> +		return PTR_ERR(mchp_pwm->clk);

		return dev_err_probe(....)

> +
> +	if (of_property_read_u32(pdev->dev.of_node, "microchip,sync-update-mask=
",
> +				 &mchp_pwm->sync_update_mask))
> +		mchp_pwm->sync_update_mask =3D 0u;
> +
> +	spin_lock_init(&mchp_pwm->lock);
> +
> +	mchp_pwm->chip.dev =3D &pdev->dev;
> +	mchp_pwm->chip.ops =3D &mchp_core_pwm_ops;
> +	mchp_pwm->chip.npwm =3D 16;
> +
> +	ret =3D devm_pwmchip_add(&pdev->dev, &mchp_pwm->chip);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> +
> +	platform_set_drvdata(pdev, mchp_pwm);

This is not necessary any more now after .remove() is gone.

> +
> +	return 0;
> +}
> +

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yivmdduo6omkair4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLJpnsACgkQwfwUeK3K
7AnhOQf8CxOgozaaCIqU33B6F0fw2GTwvtpDq2EEUCLinF8xOKMS6LteCXHzdH1t
rjbzLmxnsTHll3oYI8zxP1E0ENywKhLfFh/HNK3enTP+Vv9NJ04nSD/iro/JMjTi
iE1d7tzHIs9f2I0Ho2si48xCWSxO1KBp0K2kFhBmgR5nAZmkyeLN8/vvemvP8t2H
gpPrJ8wzXO6W8bYAFpUBCmi3DJf//2X8QW2nss3JKacd7nK6Wt/WMJuLZo/rDtv3
6jqda7iZJ9ADIIlztCXz5tN14dySkwMhJ7PI3UPqTu17Kox0UHvPNGXs5uBTM7is
m6yZmuolFejqiRVkct52CMnfOGLDfw==
=hqIQ
-----END PGP SIGNATURE-----

--yivmdduo6omkair4--

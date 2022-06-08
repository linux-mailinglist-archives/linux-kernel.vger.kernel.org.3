Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46317543737
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244216AbiFHPVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244296AbiFHPR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:17:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3767011098C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:13:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nyxMu-0008CD-1k; Wed, 08 Jun 2022 17:13:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nyxMu-007DGX-DN; Wed, 08 Jun 2022 17:13:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nyxMs-00F09c-2g; Wed, 08 Jun 2022 17:13:10 +0200
Date:   Wed, 8 Jun 2022 17:13:08 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor.Dooley@microchip.com
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        Daire.McNamara@microchip.com, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20220608151308.ym6ls3ku6ukhtly6@pengutronix.de>
References: <20220607084551.2735922-1-conor.dooley@microchip.com>
 <20220607084551.2735922-2-conor.dooley@microchip.com>
 <20220607200755.tgsrwe4ten5inw27@pengutronix.de>
 <eefc366e-1d32-7565-0d6d-243b8addc381@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2eejere4qctl5jk6"
Content-Disposition: inline
In-Reply-To: <eefc366e-1d32-7565-0d6d-243b8addc381@microchip.com>
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


--2eejere4qctl5jk6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Conor,

On Wed, Jun 08, 2022 at 12:12:37PM +0000, Conor.Dooley@microchip.com wrote:
> On 07/06/2022 21:07, Uwe Kleine-K=F6nig wrote:
> > On Tue, Jun 07, 2022 at 09:45:51AM +0100, Conor Dooley wrote:
> >> Add a driver that supports the Microchip FPGA "soft" PWM IP core.
> >>
> >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >> ---
> >>   drivers/pwm/Kconfig              |  10 ++
> >>   drivers/pwm/Makefile             |   1 +
> >>   drivers/pwm/pwm-microchip-core.c | 289 +++++++++++++++++++++++++++++=
++
> >>   3 files changed, 300 insertions(+)
> >>   create mode 100644 drivers/pwm/pwm-microchip-core.c
> >>
> >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> >> index 21e3b05a5153..a651848e444b 100644
> >> --- a/drivers/pwm/Kconfig
> >> +++ b/drivers/pwm/Kconfig
> >> @@ -383,6 +383,16 @@ config PWM_MEDIATEK
> >>   	  To compile this driver as a module, choose M here: the module
> >>   	  will be called pwm-mediatek.
> >>  =20
> >> +config PWM_MICROCHIP_CORE
> >> +	tristate "Microchip corePWM PWM support"
> >> +	depends on SOC_MICROCHIP_POLARFIRE || COMPILE_TEST
> >> +	depends on HAS_IOMEM && OF
> >> +	help
> >> +	  PWM driver for Microchip FPGA soft IP core.
> >> +
> >> +	  To compile this driver as a module, choose M here: the module
> >> +	  will be called pwm-microchip-core.
> >> +
> >>   config PWM_MXS
> >>   	tristate "Freescale MXS PWM support"
> >>   	depends on ARCH_MXS || COMPILE_TEST
> >> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> >> index 708840b7fba8..d29754c20f91 100644
> >> --- a/drivers/pwm/Makefile
> >> +++ b/drivers/pwm/Makefile
> >> @@ -33,6 +33,7 @@ obj-$(CONFIG_PWM_LPSS_PCI)	+=3D pwm-lpss-pci.o
> >>   obj-$(CONFIG_PWM_LPSS_PLATFORM)	+=3D pwm-lpss-platform.o
> >>   obj-$(CONFIG_PWM_MESON)		+=3D pwm-meson.o
> >>   obj-$(CONFIG_PWM_MEDIATEK)	+=3D pwm-mediatek.o
> >> +obj-$(CONFIG_PWM_MICROCHIP_CORE)	+=3D pwm-microchip-core.o
> >>   obj-$(CONFIG_PWM_MTK_DISP)	+=3D pwm-mtk-disp.o
> >>   obj-$(CONFIG_PWM_MXS)		+=3D pwm-mxs.o
> >>   obj-$(CONFIG_PWM_NTXEC)		+=3D pwm-ntxec.o
> >> diff --git a/drivers/pwm/pwm-microchip-core.c b/drivers/pwm/pwm-microc=
hip-core.c
> >> new file mode 100644
> >> index 000000000000..2cc1de163bcc
> >> --- /dev/null
> >> +++ b/drivers/pwm/pwm-microchip-core.c
> >> @@ -0,0 +1,289 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * corePWM driver for Microchip FPGAs
> >> + *
> >> + * Copyright (c) 2021-2022 Microchip Corporation. All rights reserved.
> >> + * Author: Conor Dooley <conor.dooley@microchip.com>
> >> + *
> >=20
> > Is there a public datasheet for that hardware? If yes, please add a link
> > here.
>=20
> Not quite a datasheet since this is for an FPGA core not a "real" part.
> I can link the following "handbook" for it though (direct download link):
> https://www.microsemi.com/document-portal/doc_download/1245275-corepwm-hb

Anything that might be worth reading if a question about the driver's
behaviour pops up is helpful. But ideally the comments about the
registers are good enough that it's not needed. Still having a document
around is good.
=20
> >> + */
> >> +
> >> +#include <linux/clk.h>
> >> +#include <linux/err.h>
> >> +#include <linux/io.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of_device.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/pwm.h>
> >> +#include <linux/math.h>
> >> +
> >> +#define PREG_TO_VAL(PREG) ((PREG) + 1)
> >> +
> >> +#define PRESCALE_REG	0x00u
> >> +#define PERIOD_REG	0x04u
> >> +#define PWM_EN_LOW_REG	0x08u
> >> +#define PWM_EN_HIGH_REG	0x0Cu
> >> +#define SYNC_UPD_REG	0xE4u
> >> +#define POSEDGE_OFFSET	0x10u
> >> +#define NEGEDGE_OFFSET	0x14u
> >> +#define CHANNEL_OFFSET	0x08u
> >=20
> > Can you please prefix these register symbols with a driver prefix?
> > Unique register names are good for tools like ctags and then it's
> > obvious to the reader, that the defines are driver specific.
> >=20
> >> +struct mchp_core_pwm_registers {
> >> +	u8 posedge;
> >> +	u8 negedge;
> >> +	u8 period_steps;
> >> +	u8 prescale;
> >=20
> > these are the four registers for each channel, right? Can you add a
> > short overview how these registers define the resulting output wave.
>=20
> Ehh, only the edges are per channel. Does that change anything about
> your feedback?
> I'll add an explanation for each, sure.

So the channels share the same period? If so you'll have to keep track
of which PWM channels are enabled and only change the period if no other
running channel is affected.

> >> +};
> >> +
> >> +struct mchp_core_pwm_chip {
> >> +	struct pwm_chip chip;
> >> +	struct clk *clk;
> >> +	void __iomem *base;
> >> +	struct mchp_core_pwm_registers *regs;
> >> +};
> >> +
> >> +static inline struct mchp_core_pwm_chip *to_mchp_core_pwm(struct pwm_=
chip *chip)
> >> +{
> >> +	return container_of(chip, struct mchp_core_pwm_chip, chip);
> >> +}
> >> +
> >> +static void mchp_core_pwm_enable(struct pwm_chip *chip, struct pwm_de=
vice *pwm,
> >> +				 bool enable)
> >> +{
> >> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> >> +	u8 channel_enable, reg_offset, shift;
> >> +
> >> +	/*
> >> +	 * There are two adjacent 8 bit control regs, the lower reg controls
> >> +	 * 0-7 and the upper reg 8-15. Check if the pwm is in the upper reg
> >> +	 * and if so, offset by the bus width.
> >> +	 */
> >> +	reg_offset =3D PWM_EN_LOW_REG + (pwm->hwpwm >> 3) * sizeof(u32);
> >> +	shift =3D pwm->hwpwm > 7 ? pwm->hwpwm - 8 : pwm->hwpwm;
> >> +
> >> +	channel_enable =3D readb_relaxed(mchp_core_pwm->base + reg_offset);
> >> +	channel_enable &=3D ~(1 << shift);
> >> +	channel_enable |=3D (enable << shift);
> >> +
> >> +	writel_relaxed(channel_enable, mchp_core_pwm->base + reg_offset);
> >> +}
> >> +
> >> +static void mchp_core_pwm_calculate_duty(struct pwm_chip *chip,
> >> +					 const struct pwm_state *desired_state,
> >> +					 struct mchp_core_pwm_registers *regs)
> >> +{
> >> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> >> +	u64 clk_period =3D NSEC_PER_SEC;
> >> +	u64 duty_steps;
> >> +
> >> +	/* Calculate the clk period and then the duty cycle edges */
> >> +	do_div(clk_period, clk_get_rate(mchp_core_pwm->clk));
> >> +
> >> +	duty_steps =3D desired_state->duty_cycle * PREG_TO_VAL(regs->period_=
steps);
> >> +	do_div(duty_steps, (clk_period * PREG_TO_VAL(regs->period_steps)));
> >=20
> > Don't divide by a result of a division.
> >=20
> >> +	if (desired_state->polarity =3D=3D PWM_POLARITY_INVERSED) {
> >> +		regs->negedge =3D 0u;
> >> +		regs->posedge =3D duty_steps;
> >> +	} else {
> >> +		regs->posedge =3D 0u;
> >> +		regs->negedge =3D duty_steps;
> >> +	}
> >> +}
> >> +
> >> +static void mchp_core_pwm_apply_duty(const u8 channel,
> >> +				     struct mchp_core_pwm_chip *pwm_chip,
> >> +				     struct mchp_core_pwm_registers *regs)
> >> +{
> >> +	void __iomem *channel_base =3D pwm_chip->base + channel * CHANNEL_OF=
FSET;
> >> +
> >> +	writel_relaxed(regs->posedge, channel_base + POSEDGE_OFFSET);
> >> +	writel_relaxed(regs->negedge, channel_base + NEGEDGE_OFFSET);
> >> +}
> >> +
> >> +static void mchp_core_pwm_apply_period(struct mchp_core_pwm_chip *pwm=
_chip,
> >> +				       struct mchp_core_pwm_registers *regs)
> >> +{
> >> +	writel_relaxed(regs->prescale, pwm_chip->base + PRESCALE_REG);
> >> +	writel_relaxed(regs->period_steps, pwm_chip->base + PERIOD_REG);
> >> +}
> >> +
> >> +static int mchp_core_pwm_calculate_base(struct pwm_chip *chip,
> >> +					const struct pwm_state *desired_state,
> >> +					u8 *period_steps_r, u8 *prescale_r)
> >> +{
> >> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> >> +	u64 tmp =3D desired_state->period;
> >> +
> >> +	/* Calculate the period cycles and prescale value */
> >> +	tmp *=3D clk_get_rate(mchp_core_pwm->clk);
> >> +	do_div(tmp, NSEC_PER_SEC);
> >> +
> >> +	if (tmp > 65535) {
> >=20
> > If a too long period is requested, please configure the biggest possible
> > period.
> >=20
> >> +		dev_err(chip->dev,
> >> +			"requested prescale exceeds the maximum possible\n");
> >=20
> > No error message in .apply() please.
>=20
> No /error/ or no error /message/?

No error message. Otherwise a userspace application might easily trash
the kernel log.

> As in, can I make it a dev_warn or do you want it removed entirely
> and replaced by capping at the max value?

Yes, just cap to the max value. So the rule is always to pick the
biggest possible period not bigger than the requested period. And for
that one pick the biggest duty_cycle not bigger than the requested
duty_cycle.

> >> +	if (desired_state->enabled) {
> >> +		if (current_state.enabled &&
> >> +		    current_state.period =3D=3D desired_state->period &&
> >> +		    current_state.polarity =3D=3D desired_state->polarity) {
> >=20
> > If everything is as before, why are you doing something at all?
>=20
> This is a change in duty without any other change.
> Could just remove this & recalculate everything when apply is called
> to simply the logic?

Ah, right. A comment (e.g. "only duty cycle changed") would be good for
such stupid readers like me :-)

I don't feel strong here. For many cases the period (and polarity) is
kept constant and only duty_cycle changes. So optimizing for that case
looks ok.

> >> +			mchp_core_pwm_calculate_duty(chip, desired_state, mchp_core_pwm->r=
egs);
> >> +			mchp_core_pwm_apply_duty(channel, mchp_core_pwm, mchp_core_pwm->re=
gs);
> >> +		} else {
> >> +			ret =3D mchp_core_pwm_calculate_base(chip, desired_state, &period_=
steps_r,
> >> +							   &prescale_r);
> >> +			if (ret) {
> >> +				dev_err(chip->dev, "failed to calculate base\n");
> >=20
> > mchp_core_pwm_calculate_base might already emit an error message. Apply
> > shouldn't emit an error message at all.
> >=20
> >> +				return ret;
> >> +			}
> >> +
> >> +			mchp_core_pwm->regs->period_steps =3D period_steps_r;
> >> +			mchp_core_pwm->regs->prescale =3D prescale_r;
> >> +
> >> +			mchp_core_pwm_calculate_duty(chip, desired_state, mchp_core_pwm->r=
egs);
> >> +			mchp_core_pwm_apply_duty(channel, mchp_core_pwm, mchp_core_pwm->re=
gs);
> >> +			mchp_core_pwm_apply_period(mchp_core_pwm, mchp_core_pwm->regs);
> >=20
> > Is there a race where e.g. the output is defined by the previous period
> > and the new duty_cycle?
>=20
> "Yes". It depends on how the IP block is configured. I'll add a write to
> the sync register (which is a NOP if not configured for sync mode).

Several drivers have a "Limitations" section at the top of the driver.
Something like that would be good to document there. Please stick to the
format found in e.g. pwm-sl28cpld.c, that is: "Limitations:" (even if
it's more about "Hardware Details") and then a list of items without
empty line in between for easy greppability.

> >=20
> >> +		}
> >> +
> >> +		if (mchp_core_pwm->regs->posedge =3D=3D mchp_core_pwm->regs->negedg=
e)
> >> +			mchp_core_pwm_enable(chip, pwm, false);
> >> +		else
> >> +			mchp_core_pwm_enable(chip, pwm, true);
> >=20
> > Here is a race: If the PWM is running and it configured to be disabled
> > with a different duty_cycle/period the duty_cycle/period might be
> > (shortly) visible on the output with is undesirable.
>=20
> This is trying to work around some nasty behaviour in the IP block.
> If negedge =3D=3D posedge, it gives you a 50% duty cycle at twice the
> period you asked for.
> ie since the negedge and posedge are at the same time, it does
> whichever edge is actually possible each time that period step is
> reached.

I didn't understand the normal behaviour of these registers yet, so
cannot comment. Usually it's a good idea to document corner cases in
comments.

> If the state requested is disabled, it should be caught by the if()
> prior to entering this & exit early & avoid this entirely.
>=20
> I'll put the sync reg write after this, so if the block is configured
> to support sync updates, the output waveform won't do anything odd.

Sounds good.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2eejere4qctl5jk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKgvIIACgkQwfwUeK3K
7Al99gf+JvX6SezMaQzX9g6ogJm+XqqyDA0wAs1hfiK0jp32AqodG3J0AZmYVHGn
LhQlmbCiZTx2+64nhYPUtlyWhQ7wfRtLJyFq0avakuwenXKMJb8RtjCClHx/NAvk
U51vn2OxTXGgCfBt9RyruLOl5sBG3P8EMXA6GWRTEkrRg68lnEqRiv4qI3GLD51P
u1ec17LA2gM9ROdqnL/4+DH48uw6Br+XXWwUr1w1CSth/Tfumu00YHGUE8kfLZG5
oUY7dSSLtXLvnsFCa+h1UyT0LbYTwofvACb/LGj8WzgTOCInGCZbXtWnNbRNDw++
71d7uA85aZke9k+SjMGaYJLjeMC3OQ==
=CaMD
-----END PGP SIGNATURE-----

--2eejere4qctl5jk6--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2034CFF24
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242599AbiCGMvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbiCGMus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:50:48 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10BB89312;
        Mon,  7 Mar 2022 04:49:52 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2d07ae0b1c4so162255177b3.11;
        Mon, 07 Mar 2022 04:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yT/uCJX9PSVDtmtMqhl9wmLaLWmjQVFY6JKoL44L0c0=;
        b=YZWIpu8WLNXFFDiwZtrehh7I6Dt8MD8Kf2pUFSzCNcoxfrHlO09iohqTb+082smR/S
         1m+OvAGeTiu5rnrQ639Ezo44XwH1pw4vmpMJSVUD4NeXPoURuJfqN9zSK/LGHvIJ5oO6
         smH8FSQe0mRihpFq1FgwWuce6e8+zZmLMVHASuPLZCRJ5S/JxXbKprqRq39c4rHQ8DUn
         QoNoVab2EaWmFqKvnxAJd0Wnn1e2+si3Qq4ju1376ugOl4bwNs0mSiELoz6+iKBPviU1
         AOOOezG+8CYEbFJUeB3/pSngurK5oRDw3+8RBZXjcAlfkLT2aZX8mzKfF1XbC4JBEsO5
         9Yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yT/uCJX9PSVDtmtMqhl9wmLaLWmjQVFY6JKoL44L0c0=;
        b=JtQE+cj2Qph69BLE7gUI7iL3KFz6UmA9iau/l2Y/9l29V8AzgmFnqI3HYG3AufZ4Pq
         kHtDNGdsAK+VH0UmeIr7+CpyTojixFf0tw2JhMwHGyQMHc0w9zHjKj+o9YoYFPhxCkr5
         4j6VYQiv5gjIG76wCtHxX4T/QH8uwDtv5k5Dhn10qfuteiMd6VCKzdcx5M/swwFw0SvH
         /N3CICXuXL/v7JsIdydloCxcp6q0LAaQI8cc0kC3r9YjI1HGMxaFRfQStzzXc/IJPcLp
         wIQGvCKvpGWusjD5ZlwoEhEbp+COTY0Dg2kD7VZ8Q5umQ/2HZhBubfrLtAJpxJuOBNcF
         eJdw==
X-Gm-Message-State: AOAM530riOiWB1sT0JRmb5BBQQGmMayHxRdpznMfg0zBJk16GQJHHNDn
        Q6tEsjtEs4s9t7eTPgcjTMzbi7wJFgIKX+JNRsQ=
X-Google-Smtp-Source: ABdhPJyrrPhmVkgOULV60dcpSM4wSEHFg53pDhILibVQK3BKnUWFq8fd+B/nZ7fAo82yCD/5aZ0Y9UAB0Aos4Io2eFU=
X-Received: by 2002:a81:6a02:0:b0:2dc:2e6d:6c31 with SMTP id
 f2-20020a816a02000000b002dc2e6d6c31mr8074563ywc.221.1646657391934; Mon, 07
 Mar 2022 04:49:51 -0800 (PST)
MIME-Version: 1.0
References: <1646374812-2988-1-git-send-email-hammerh0314@gmail.com>
 <1646374812-2988-3-git-send-email-hammerh0314@gmail.com> <20220304185702.i6csx2r3mokfmr6o@pengutronix.de>
In-Reply-To: <20220304185702.i6csx2r3mokfmr6o@pengutronix.de>
From:   hammer hsieh <hammerh0314@gmail.com>
Date:   Mon, 7 Mar 2022 20:50:10 +0800
Message-ID: <CAOX-t56cycXMga_grJcpmSG68ve5-RuTsbtaEQi9Ui0A+5uhSg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pwm:sunplus-pwm:Add Sunplus SoC PWM Driver
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wells.lu@sunplus.com,
        "hammer.hsieh" <hammer.hsieh@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2022=E5=B9=
=B43=E6=9C=885=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=882:57=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Hello,
>
> On Fri, Mar 04, 2022 at 02:20:12PM +0800, Hammer Hsieh wrote:
> > Add Sunplus SoC PWM Driver
> >
> > Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
> > ---
> > Changes in v2:
> >  - Addressed all comments from Uwe Kleine-K=C3=B6nig.
> >  - rebase kernel to 5.17 rc5
> >
> >  MAINTAINERS               |   1 +
> >  drivers/pwm/Kconfig       |  11 +++
> >  drivers/pwm/Makefile      |   1 +
> >  drivers/pwm/pwm-sunplus.c | 229 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  4 files changed, 242 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-sunplus.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 825b714..8710c8e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18535,6 +18535,7 @@ SUNPLUS PWM DRIVER
> >  M:   Hammer Hsieh <hammerh0314@gmail.com>
> >  S:   Maintained
> >  F:   Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
> > +F:   drivers/pwm/pwm-sunplus.c
> >
> >  SUNPLUS RTC DRIVER
> >  M:   Vincent Shih <vincent.sunplus@gmail.com>
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 21e3b05..54cfb50 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -572,6 +572,17 @@ config PWM_SUN4I
> >         To compile this driver as a module, choose M here: the module
> >         will be called pwm-sun4i.
> >
> > +config PWM_SUNPLUS
> > +     tristate "Sunplus PWM support"
> > +     depends on ARCH_SUNPLUS || COMPILE_TEST
> > +     depends on HAS_IOMEM && OF
> > +     help
> > +       Generic PWM framework driver for the PWM controller on
> > +       Sunplus SoCs.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called pwm-sunplus.
> > +
> >  config PWM_TEGRA
> >       tristate "NVIDIA Tegra PWM support"
> >       depends on ARCH_TEGRA || COMPILE_TEST
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 708840b..be58616 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -53,6 +53,7 @@ obj-$(CONFIG_PWM_STM32)             +=3D pwm-stm32.o
> >  obj-$(CONFIG_PWM_STM32_LP)   +=3D pwm-stm32-lp.o
> >  obj-$(CONFIG_PWM_STMPE)              +=3D pwm-stmpe.o
> >  obj-$(CONFIG_PWM_SUN4I)              +=3D pwm-sun4i.o
> > +obj-$(CONFIG_PWM_SUNPLUS)    +=3D pwm-sunplus.o
> >  obj-$(CONFIG_PWM_TEGRA)              +=3D pwm-tegra.o
> >  obj-$(CONFIG_PWM_TIECAP)     +=3D pwm-tiecap.o
> >  obj-$(CONFIG_PWM_TIEHRPWM)   +=3D pwm-tiehrpwm.o
> > diff --git a/drivers/pwm/pwm-sunplus.c b/drivers/pwm/pwm-sunplus.c
> > new file mode 100644
> > index 0000000..170534f
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-sunplus.c
> > @@ -0,0 +1,229 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PWM device driver for SUNPLUS SoCs
>
> Is there a public manual available for this hardware? If yes, please add
> a link here.
>

yes, will add links as below
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://sunplus.atlassian.net/wiki/spaces/doc/pages/461144198/12.+Pulse+Wid=
th+Modulation+PWM

> > + *
> > + * Limitations:
> > + * - Only supports normal polarity.
>
> How does the HW behave when it's disabled? Usual candidates are:
>  - It freezes at where it currently is
>  - It outputs low
>  - It becomes tristate
>
> Please note this in the Limitations section, too.
>
> Another thing to mention is if running periods are completed when the
> parameters change.
>

ok, will add note as below
  Limitations:
  - Only supports normal polarity.
  - It output low when PWM channel disabled.
  - When the parameters change, current running period will not be complete=
d
      and run new settings immediately.

> > + *
> > + * Author: Hammer Hsieh <hammerh0314@gmail.com>
> > + */
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +
> > +#define PWM_SUP_CONTROL0     0x000
> > +#define PWM_SUP_CONTROL1     0x004
> > +#define PWM_SUP_FREQ_BASE    0x008
> > +#define PWM_SUP_DUTY_BASE    0x018
> > +#define PWM_SUP_FREQ(ch)     (PWM_SUP_FREQ_BASE + 4 * (ch))
> > +#define PWM_SUP_DUTY(ch)     (PWM_SUP_DUTY_BASE + 4 * (ch))
>
> I'd not give PWM_SUP_FREQ_BASE and PWM_SUP_DUTY_BASE a name here, just
>
>         #define PWM_SUP_FREQ(ch)        (0x008 + 4 * (ch))
>         ...
>

ok, will modify it.

> > +#define PWM_SUP_FREQ_MAX     GENMASK(15, 0)
> > +#define PWM_SUP_DUTY_MAX     GENMASK(7, 0)
> > +
> > +#define PWM_SUP_NUM          4
> > +#define PWM_BYPASS_BIT_SHIFT 8
> > +#define PWM_DD_SEL_BIT_SHIFT 8
> > +#define PWM_SUP_FREQ_SCALER  256
>
> Please use a consistent prefix for the driver specific defines.
>

ok, will modify it.

> > +struct sunplus_pwm {
> > +     struct pwm_chip chip;
> > +     void __iomem *base;
> > +     struct clk *clk;
> > +     u32 approx_period[PWM_SUP_NUM];
> > +     u32 approx_duty_cycle[PWM_SUP_NUM];
> > +};
> > +
> > +static inline struct sunplus_pwm *to_sunplus_pwm(struct pwm_chip *chip=
)
> > +{
> > +     return container_of(chip, struct sunplus_pwm, chip);
> > +}
> > +
> > +static void sunplus_pwm_free(struct pwm_chip *chip, struct pwm_device =
*pwm)
> > +{
> > +     struct sunplus_pwm *priv =3D to_sunplus_pwm(chip);
> > +     u32 value;
> > +
> > +     /* disable pwm channel output */
> > +     value =3D readl(priv->base + PWM_SUP_CONTROL0);
> > +     value &=3D ~BIT(pwm->hwpwm);
> > +     writel(value, priv->base + PWM_SUP_CONTROL0);
> > +     /* disable pwm channel clk source */
> > +     value =3D readl(priv->base + PWM_SUP_CONTROL1);
> > +     value &=3D ~BIT(pwm->hwpwm);
> > +     writel(value, priv->base + PWM_SUP_CONTROL1);
>
> the .free callback isn't supposed to modify the hardware.
>

But how to turn pwm channel off ?
I add .free function for turn it off.
In user space
  cd /sys/class/pwm/pwmchip0
  echo 0 > export
  cd pwm0
  echo 20000000 > period
  echo 1000000 > duty_cycle
  echo 1 > enable
  cd ..
  echo 0 > unexport ; turn off pwm will call .free function

> > +}
> > +
> > +static int sunplus_pwm_apply(struct pwm_chip *chip, struct pwm_device =
*pwm,
> > +                          const struct pwm_state *state)
> > +{
> > +     struct sunplus_pwm *priv =3D to_sunplus_pwm(chip);
> > +     u32 dd_freq, duty, value, value1;
>
> As value and value1 hold register values for PWM_SUP_CONTROL0 and
> PWM_SUP_CONTROL1, I'd call them control0 and control1 respectively.
>

ok, will modify it.

> > +     u32 tmp, rate;
> > +     u64 max_period, period_ns, duty_ns, clk_rate;
> > +
> > +     if (state->polarity !=3D pwm->state.polarity)
> > +             return -EINVAL;
> > +
> > +     if (!state->enabled) {
> > +             /* disable pwm channel output */
> > +             value =3D readl(priv->base + PWM_SUP_CONTROL0);
> > +             value &=3D ~BIT(pwm->hwpwm);
>
> I'd give this one a name. Something like:
>
>         #define PWM_SUP_CONTROL_EN(ch)  BIT(ch)
>
> (Pick the right name from the manual.)
>

That means it need to implement
PWM_SUP_CONTROL_EN(ch) and PWM_SUP_CONTROL_DIS(ch) ?

> > +             writel(value, priv->base + PWM_SUP_CONTROL0);
> > +             /* disable pwm channel clk source */
> > +             value =3D readl(priv->base + PWM_SUP_CONTROL1);
> > +             value &=3D ~BIT(pwm->hwpwm);
> > +             writel(value, priv->base + PWM_SUP_CONTROL1);
> > +             return 0;
> > +     }
> > +
> > +     clk_rate =3D clk_get_rate(priv->clk);
> > +     rate =3D (u32)clk_rate / 100000;
>
> This cast doesn't change anything, does it?
>

yes, clk_rate should be 202.5MHz, to prevent overflow use 2025 to calculate=
.

> > +     max_period =3D PWM_SUP_FREQ_MAX * (PWM_SUP_FREQ_SCALER * 10000 / =
rate);
>
> Here you have rounding issues. Consider rate =3D 3329. Then you get
> max_period =3D 0xffff * (2560000 / 3329) =3D 0xffff * 768 =3D 50330880.
>
> However the actual result is 50396395.31...
>
> Also dividing by the result of a division looses precision.
>

I am not sure how to fix the rounding issue.(thinking...)

> > +
> > +     if (state->period > max_period)
> > +             return -EINVAL;
>
> No, you're supposed to implement the biggest period possible not bigger
> than the requested period. So the right thing here is:
>
> > +     period_ns =3D state->period;
>
> period =3D min(state->period, max_period);
>

ok, will modify it.

> > +     duty_ns =3D state->duty_cycle;
> > +
> > +     priv->approx_period[pwm->hwpwm] =3D (u32)period_ns / 100;
> > +     priv->approx_duty_cycle[pwm->hwpwm] =3D (u32)duty_ns / 100;
>
> Tracking period_ns / 100 seems strange and vulnerable to rounding
> issues.
>

In patch v1, you suggest to enable PWM_DEBUG and make sure there is no warn=
ing.
For fix ".apply is not idempotent" issue.
I add approx_period / approx_duty_cycle for it.

> > +     /* cal pwm freq and check value under range */
> > +     dd_freq =3D rate * priv->approx_period[pwm->hwpwm] / (PWM_SUP_FRE=
Q_SCALER * 100);
>
> This is all too complicated, you just need:
>

ok, will modify it.

>         dd_freq =3D mul_u64_u64_div_u64(clk_rate, period, (u64)PWM_SUP_FR=
EQ_SCALER * NSEC_PER_SEC)
>
> > +     if (dd_freq =3D=3D 0)
> > +             return -EINVAL;
> > +
> > +     if (dd_freq > PWM_SUP_FREQ_MAX)
> > +             dd_freq =3D PWM_SUP_FREQ_MAX;
> > +
> > +     writel(dd_freq, priv->base + PWM_SUP_FREQ(pwm->hwpwm));
> > +
> > +     /* cal and set pwm duty */
> > +     value =3D readl(priv->base + PWM_SUP_CONTROL0);
> > +     value |=3D BIT(pwm->hwpwm);
> > +     value1 =3D readl(priv->base + PWM_SUP_CONTROL1);
> > +     value1 |=3D BIT(pwm->hwpwm);
> > +     if (duty_ns =3D=3D period_ns) {
> > +             value |=3D BIT(pwm->hwpwm + PWM_BYPASS_BIT_SHIFT);
> > +             duty =3D PWM_SUP_DUTY_MAX;
> > +     } else {
> > +             value &=3D ~BIT(pwm->hwpwm + PWM_BYPASS_BIT_SHIFT);
> > +             tmp =3D priv->approx_duty_cycle[pwm->hwpwm] * PWM_SUP_FRE=
Q_SCALER;
> > +             tmp /=3D priv->approx_period[pwm->hwpwm];
>
> Please use the exact values available.
>

The same reason, in case of enable PWM_DEBUG.
first call .apply , then it will call .get_state for verify the calculation=
.

> > +             duty =3D (u32)tmp;
> > +             duty |=3D (pwm->hwpwm << PWM_DD_SEL_BIT_SHIFT);
> > +     }
> > +     writel(duty, priv->base + PWM_SUP_DUTY(pwm->hwpwm));
> > +     writel(value1, priv->base + PWM_SUP_CONTROL1);
> > +     writel(value, priv->base + PWM_SUP_CONTROL0);
>
> What is the difference between CONTROL1 and CONTROL0?
>

PWM CONTROL0 for PWM channel switch.
PWM CONTROL1 for PWM clock source switch.
Actually PWM supports 8 channels , but clock source only 4 sets.
For easy control(now submit), I just support 4 PWM channels, and one
clock source for one pwm channel.
For complicated control(not now), 8 PWM channels 4 clock source , need
to manage clock source / pwm channel enable or not
while request/free pwm channel.

> > +     return 0;
> > +}
> > +
> > +static void sunplus_pwm_get_state(struct pwm_chip *chip, struct pwm_de=
vice *pwm,
> > +                               struct pwm_state *state)
> > +{
> > +     struct sunplus_pwm *priv =3D to_sunplus_pwm(chip);
> > +     u32 value, freq, duty, rate, freq_tmp, duty_tmp;
> > +     u64 tmp, clk_rate;
> > +
> > +     value =3D readl(priv->base + PWM_SUP_CONTROL0);
> > +
> > +     if (value & BIT(pwm->hwpwm)) {
> > +             clk_rate =3D clk_get_rate(priv->clk);
> > +             rate =3D (u32)clk_rate / 100000;
> > +             freq =3D readl(priv->base + PWM_SUP_FREQ(pwm->hwpwm));
> > +             duty =3D readl(priv->base + PWM_SUP_DUTY(pwm->hwpwm));
> > +             duty &=3D ~GENMASK(9, 8);
> > +
> > +             freq_tmp =3D rate * priv->approx_period[pwm->hwpwm] / (PW=
M_SUP_FREQ_SCALER * 100);
> > +             duty_tmp =3D priv->approx_duty_cycle[pwm->hwpwm] * PWM_SU=
P_FREQ_SCALER /
> > +                             priv->approx_period[pwm->hwpwm];
> > +
> > +             if (freq =3D=3D freq_tmp && duty =3D=3D duty_tmp) {
> > +                     state->period =3D priv->approx_period[pwm->hwpwm]=
 * 100;
> > +                     state->duty_cycle =3D priv->approx_duty_cycle[pwm=
->hwpwm] * 100;
> > +             } else {
> > +                     tmp =3D (u64)freq * PWM_SUP_FREQ_SCALER * 10000;
> > +                     state->period =3D div64_u64(tmp, rate);
> > +                     tmp =3D (u64)freq * (u64)duty * 10000;
> > +                     state->duty_cycle =3D div64_u64(tmp, rate);
> > +             }
> > +             state->enabled =3D true;
> > +     } else {
> > +             state->enabled =3D false;
> > +     }
> > +
> > +     state->polarity =3D PWM_POLARITY_NORMAL;
> > +}
>
> When .get_state() is first called, .apply wasn't called yet. Then
> priv->approx_period[pwm->hwpwm] is zero and the returned result is
> wrong. Please read the register values and calculate the implemented
> output without caching.
>

The same reason, in case of enable PWM_DEBUG.
first call .apply , then it will call .get_state for verify the calculation=
.

In get_state, I thought about that.
first called .get_state, read register value to calculate period and duty_c=
ycle.
after calling .apply , caching data approx_period / approx_duty_cycle
will not zero.
then get_state will use caching data to do PWM_DEBUG self verification.
I will think about how to solve the PWM_DEBUG ".apply is not idempotent" is=
sue.

> > +static const struct pwm_ops sunplus_pwm_ops =3D {
> > +     .free =3D sunplus_pwm_free,
> > +     .apply =3D sunplus_pwm_apply,
> > +     .get_state =3D sunplus_pwm_get_state,
> > +     .owner =3D THIS_MODULE,
> > +};
> > +
> > +static int sunplus_pwm_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct sunplus_pwm *priv;
> > +     int ret;
> > +
> > +     priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(priv->base))
> > +             return PTR_ERR(priv->base);
> > +
> > +     priv->clk =3D devm_clk_get_optional(dev, NULL);
> > +     if (IS_ERR(priv->clk))
, > > +             return dev_err_probe(dev, PTR_ERR(priv->clk),
> > +                                  "get pwm clock failed\n");
>
> If priv->clk is the dummy clk, clk_get_rate returns 0. This is bad as
> (at lease up to now) you divide by rate in .apply().
>

I check many pwm drivers , they are called devm_clk_get_optional( ) or
devm_clk_get( ).
Could you tell me how to do it in a probe ?

> > +
> > +     ret =3D clk_prepare_enable(priv->clk);
> > +     if (ret)
>
> missing error message
>

ok, will add error message.

> > +             return ret;
> > +
> > +     ret =3D devm_add_action_or_reset(dev,
> > +                                    (void(*)(void *))clk_disable_unpre=
pare,
>
> Without checking my C book I'm unsure if this is save on all platforms.
> I'd implement a oneline function for this.
>

ok, will implement it in one line.
static void sunplus_pwm_clk_release(*data)
{
   struct clk *clk =3D data;
   clk_disable_unprepare(clk);
}
 ret =3D devm_add_action_or_reset(dev, sunplus_pwm_clk_release, priv->clk);

> > +                                    priv->clk);
> > +     if (ret)
>
> missing error message
>

I didn't see another driver add an error message, is it necessary?

> > +             return ret;
> > +
> > +     priv->chip.dev =3D dev;
> > +     priv->chip.ops =3D &sunplus_pwm_ops;
> > +     priv->chip.npwm =3D PWM_SUP_NUM;
> > +
> > +     ret =3D devm_pwmchip_add(dev, &priv->chip);
> > +     if (ret < 0)
> > +             return dev_err_probe(dev, ret, "Cannot register sunplus P=
WM\n");
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id sunplus_pwm_of_match[] =3D {
> > +     { .compatible =3D "sunplus,sp7021-pwm", },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, sunplus_pwm_of_match);
> > +
> > +static struct platform_driver sunplus_pwm_driver =3D {
> > +     .probe          =3D sunplus_pwm_probe,
> > +     .driver         =3D {
> > +             .name   =3D "sunplus-pwm",
> > +             .of_match_table =3D sunplus_pwm_of_match,
> > +     },
> > +};
> > +module_platform_driver(sunplus_pwm_driver);
> > +
> > +MODULE_DESCRIPTION("Sunplus SoC PWM Driver");
> > +MODULE_AUTHOR("Hammer Hsieh <hammerh0314@gmail.com>");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.7.4
> >
> >
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

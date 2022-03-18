Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDE94DD6F3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbiCRJTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbiCRJTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:19:48 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE473A718;
        Fri, 18 Mar 2022 02:18:27 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2e5827a76f4so84837747b3.6;
        Fri, 18 Mar 2022 02:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=93Roa/3/8LQ3dVHsgObT1jYsY41CAK9mz/gXRqikm30=;
        b=IkFgb0vCzEk7JIMVqKU4ipMlEbrLvQQqvhHsh3gBpY0cv8/5Ga7HAjlLLHjdXDcler
         x981MZ101BJaf3i4jE4eyVj/BTFrCaNehIujeTRPThewPKS1poByLlpysxu+rGCizLZX
         Lgt8go5eKNWvaEtzbpYJL7JO72NecXzGwBHn0QGQKDFcDf1FQkniFx/8iNhY6mrM16JB
         goMl1M4Cotu/f+f2R1vskmC2kcMYNAhNEERfPepAXttiXhxDQQzxM1QUzFccs94PpvNj
         cQgLe9sTsWSFTcD8cOmMj7uZbMplZSe/3T1lNHiXu5K4kL0Antl6S1OHN9/wjwcdWjY7
         zp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=93Roa/3/8LQ3dVHsgObT1jYsY41CAK9mz/gXRqikm30=;
        b=v3cIh/VS8FjPUA4j18SXQSS6uFkf22qUjXLNrg/AUp60KHMQRZ7ZcWsEtmki8iLeeY
         g93q4PCBoCB0xTr2tyE0a2ZHxSteSkxAjdwPM39TTiinyUvqRFqxuJTNBnZxD1RGo5rC
         eLYaYm4Ylxv9JbruCr5hk9oPR193/RzvIr962x9wb4w/GxYGL6TrvyO376Sg1qfWsFqq
         l0xjEifZHTgwRiqs3Rmk3P0NDo4gJcy5UY6sYs7HOwwkhMEkJelC941hKMu3T7NFd5Xw
         LyfW3lZpwASEEtFJWZRjsa7GbmJPk0i+a0nX3YL57QeOSzXDGyiJSWnq/LPfXz/gSTMj
         pXNQ==
X-Gm-Message-State: AOAM531Ev6aaSCjdFMm9coL/wbFHJBpFd5kcZ5/CHDfaQ25DBJMMdI7G
        BcTS9diV8+ABM+wU7tTCGVwkUSe8K54ugRGMCU0=
X-Google-Smtp-Source: ABdhPJznvvccngMD/MAdzLeM6mkJofMSVV+dHZB7JFy+Y/urLuHjzzJfZCmW1Lt+wROqlaHCNUJP7iR1NreG/UlMtzI=
X-Received: by 2002:a0d:da45:0:b0:2d0:bd53:b39 with SMTP id
 c66-20020a0dda45000000b002d0bd530b39mr9968051ywe.463.1647595106909; Fri, 18
 Mar 2022 02:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <1647237097-29172-1-git-send-email-hammerh0314@gmail.com>
 <1647237097-29172-3-git-send-email-hammerh0314@gmail.com> <20220317103319.7irzmjknsr4hlrq3@pengutronix.de>
In-Reply-To: <20220317103319.7irzmjknsr4hlrq3@pengutronix.de>
From:   hammer hsieh <hammerh0314@gmail.com>
Date:   Fri, 18 Mar 2022 17:18:46 +0800
Message-ID: <CAOX-t5641GnkVBa2JArL4b4jRDBcu9twMpZbj+0Y71x5mcvJbw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pwm: sunplus-pwm: Add Sunplus SoC SP7021 PWM Driver
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

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2022=E5=B9=
=B43=E6=9C=8817=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:33=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On Mon, Mar 14, 2022 at 01:51:37PM +0800, Hammer Hsieh wrote:
> > Add Sunplus SoC SP7021 PWM Driver
> >
> > Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
> > ---
> > Changes in v3:
> >  - Addressed all comments from Uwe Kleine-K=C3=B6nig.
> >
> >  MAINTAINERS               |   1 +
> >  drivers/pwm/Kconfig       |  11 +++
> >  drivers/pwm/Makefile      |   1 +
> >  drivers/pwm/pwm-sunplus.c | 232 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  4 files changed, 245 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-sunplus.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e1cb7eb..6644bae 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18535,6 +18535,7 @@ SUNPLUS PWM DRIVER
> >  M:   Hammer Hsieh <hammerh0314@gmail.com>
> >  S:   Maintained
> >  F:   Documentation/devicetree/bindings/pwm/sunplus,sp7021-pwm.yaml
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
> > index 0000000..b6ab077
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-sunplus.c
> > @@ -0,0 +1,232 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PWM device driver for SUNPLUS SP7021 SoC
> > + *
> > + * Links:
> > + *   Reference Manual:
> > + *   https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
> > + *
> > + *   Reference Manual(PWM module):
> > + *   https://sunplus.atlassian.net/wiki/spaces/doc/pages/461144198/12.=
+Pulse+Width+Modulation+PWM
>
> On that wiki page someone wants to make s/desable/disable/
>

wiki page desable typo fixed.

> > + *
> > + * Limitations:
> > + * - Only supports normal polarity.
> > + * - It output low when PWM channel disabled.
> > + * - When the parameters change, current running period will not be co=
mpleted
> > + *     and run new settings immediately.
> > + * - In .apply() PWM output need to write register FREQ and DUTY. When=
 first write FREQ
> > + *     done and not yet write DUTY, it has short timing gap use new FR=
EQ and old DUTY.
>
> good
>
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
> > +#define SP7021_PWM_CONTROL0          0x000
> > +#define SP7021_PWM_CONTROL1          0x004
>
> The link above calls these PWM_MODE0 and PWM_MODE1, also the other
> register names don't match.
>
> > +#define SP7021_PWM_FREQ(ch)          (0x008 + 4 * (ch))
> > +#define SP7021_PWM_DUTY(ch)          (0x018 + 4 * (ch))
> > +#define SP7021_PWM_FREQ_MAX          GENMASK(15, 0)
> > +#define SP7021_PWM_DUTY_MAX          GENMASK(7, 0)
> > +#define SP7021_PWM_CONTROL_EN(ch)    BIT(ch)
>
> I'm a big fan of consistently naming register defines. I'd do something
> like:
>
>         #define SP7021_PWM_MODE0                0x000
>         #define SP7021_PWM_MODE0_PWMEN(ch)              BIT(ch)
>         #define SP7021_PWM_MODE0_BYPASS(ch)             BIT(8 + (ch))
>
>         #define SP7021_PWM_MODE1                0x004
>         #define SP7021_PWM_MODE1_CNTx_EN(ch)            BIT(ch)
>         ...
>
> such that register names match the manual and register fields have the
> register as a prefix. That way its easier spotable when there is a
> mismatch. (e.g. someone tries to set SP7021_PWM_MODE1_CNTx_EN(1) in
> SP7021_PWM_MODE0.)
>
>
> > +#define SP7021_PWM_NUM                       4
> > +#define SP7021_PWM_BYPASS_BIT_SHIFT  8
> > +#define SP7021_PWM_DD_SEL_BIT_SHIFT  8
>
> When you use the bit masks and FIELD_PREP you never should need a define
> for a shift.
>

ok, all define will be like below in next patch.
and all u32 control0,control1;
will change to u32 mode0, mode1;

#define SP7021_PWM_MODE0                0x000
#define SP7021_PWM_MODE0_PWMEN(ch)      BIT(ch)
#define SP7021_PWM_MODE0_BYPASS(ch)     BIT(8 + (ch))
#define SP7021_PWM_MODE1                0x004
#define SP7021_PWM_MODE1_CNTx_EN(ch)    BIT(ch)

#define SP7021_PWM_FREQ(ch)             (0x008 + 4 * (ch))
#define SP7021_PWM_FREQ_MAX             GENMASK(15, 0)

#define SP7021_PWM_DUTY(ch)             (0x018 + 4 * (ch))
#define SP7021_PWM_DUTY_DD_SEL(ch)      FIELD_PREP(GENMASK(9, 8), ch)
#define SP7021_PWM_DUTY_MAX             GENMASK(7, 0)
#define SP7021_PWM_DUTY_MASK            SP7021_PWM_DUTY_MAX
#define SP7021_PWM_FREQ_SCALER          256
#define SP7021_PWM_NUM                  4

> > +#define SP7021_PWM_FREQ_SCALER               256
> > +
> > +struct sunplus_pwm {
> > +     struct pwm_chip chip;
> > +     void __iomem *base;
> > +     struct clk *clk;
> > +};
> > +
> > +static inline struct sunplus_pwm *to_sunplus_pwm(struct pwm_chip *chip=
)
> > +{
> > +     return container_of(chip, struct sunplus_pwm, chip);
> > +}
> > +
> > +static int sunplus_pwm_apply(struct pwm_chip *chip, struct pwm_device =
*pwm,
> > +                          const struct pwm_state *state)
> > +{
> > +     struct sunplus_pwm *priv =3D to_sunplus_pwm(chip);
> > +     u32 dd_freq, duty, control0, control1;
> > +     u64 max_period, period_ns, duty_ns, clk_rate;
> > +
> > +     if (state->polarity !=3D pwm->state.polarity)
> > +             return -EINVAL;
> > +
> > +     if (!state->enabled) {
> > +             /* disable pwm channel output */
> > +             control0 =3D readl(priv->base + SP7021_PWM_CONTROL0);
> > +             control0 &=3D ~SP7021_PWM_CONTROL_EN(pwm->hwpwm);
> > +             writel(control0, priv->base + SP7021_PWM_CONTROL0);
> > +             /* disable pwm channel clk source */
> > +             control1 =3D readl(priv->base + SP7021_PWM_CONTROL1);
> > +             control1 &=3D ~SP7021_PWM_CONTROL_EN(pwm->hwpwm);
> > +             writel(control1, priv->base + SP7021_PWM_CONTROL1);
> > +             return 0;
> > +     }
> > +
> > +     clk_rate =3D clk_get_rate(priv->clk);
> > +     /*
> > +      * SP7021_PWM_FREQ_MAX 16 bits, SP7021_PWM_FREQ_SCALER 8 bits
> > +      * NSEC_PER_SEC 30 bits, won't overflow.
> > +      */
> > +     max_period =3D mul_u64_u64_div_u64(SP7021_PWM_FREQ_MAX, (u64)SP70=
21_PWM_FREQ_SCALER
> > +                             * NSEC_PER_SEC, clk_rate);
> > +
> > +     period_ns =3D min(state->period, max_period);
> > +     duty_ns =3D state->duty_cycle;
>
> duty_ns =3D min(state->duty_cycle, period_ns);
>

ok, but I think I will remove max_period calculation code.
And take your another recomanded code.

> > +
> > +     /*
> > +      * cal pwm freq and check value under range
> > +      * clk_rate 202.5MHz 28 bits, period_ns max 82849185 27 bits, won=
't overflow.
> > +      */
> > +     dd_freq =3D mul_u64_u64_div_u64(clk_rate, period_ns, (u64)SP7021_=
PWM_FREQ_SCALER
> > +                             * NSEC_PER_SEC);
> > +
> > +     if (dd_freq =3D=3D 0)
> > +             return -EINVAL;
> > +
> > +     if (dd_freq > SP7021_PWM_FREQ_MAX)
> > +             dd_freq =3D SP7021_PWM_FREQ_MAX;
>
> This cannot happen after period_ns was limited to max_period, can it?
> I wonder if there is a max_period value that is cheaper to calculate
> (e.g. no division) and still is good enough to ensure that the
> calculation for dd_freq doesn't overflow. The reasoning there includes
> clk_rate =3D 202.5 MHz. So maybe something like:
>
>         clk_rate =3D clk_get_rate(priv->clk);
>
>         /*
>          * The following calculations might overflow if clk is bigger
>          * than 256 GHz. In practise it's 202.5MHz, so this limitation
>          * is only theoretic.
>          */
>         if (clk_rate > (u64)SP7021_PWM_FREQ_SCALER * NSEC_PER_SEC)
>                 return -EINVAL;
>
>         /*
>          * With clk_rate limited above we have dd_freq <=3D state->period=
,
>          * so this cannot overflow.
>          */
>         dd_freq =3D mul_u64_u64_div_u64(clk_rate, state->period,
>                                       (u64)SP7021_PWM_FREQ_SCALER * NSEC_=
PER_SEC);
>
>         if (dd_freq =3D=3D 0)
>                 return -EINVAL;
>
>         if (dd_freq > SP7021_PWM_FREQ_MAX)
>                 dd_freq =3D SP7021_PWM_FREQ_MAX;
>

ok, will modify it as your recomanded code.

>
> > +     writel(dd_freq, priv->base + SP7021_PWM_FREQ(pwm->hwpwm));
> > +
> > +     /* cal and set pwm duty */
> > +     control0 =3D readl(priv->base + SP7021_PWM_CONTROL0);
> > +     control0 |=3D SP7021_PWM_CONTROL_EN(pwm->hwpwm);
> > +     control1 =3D readl(priv->base + SP7021_PWM_CONTROL1);
> > +     control1 |=3D SP7021_PWM_CONTROL_EN(pwm->hwpwm);
> > +     if (duty_ns =3D=3D period_ns) {
> > +             /* PWM channel output =3D high */
> > +             control0 |=3D SP7021_PWM_CONTROL_EN(pwm->hwpwm + SP7021_P=
WM_BYPASS_BIT_SHIFT);
> > +             duty =3D SP7021_PWM_DUTY_MAX;
> > +     } else {
> > +             control0 &=3D ~SP7021_PWM_CONTROL_EN(pwm->hwpwm + SP7021_=
PWM_BYPASS_BIT_SHIFT);
> > +             /*
> > +              * duty_ns <=3D period_ns 27 bits, SP7021_PWM_FREQ_SCALER=
 8 bits
> > +              * won't overflow.
> > +              */
> > +             duty =3D mul_u64_u64_div_u64(duty_ns, (u64)SP7021_PWM_FRE=
Q_SCALER,
> > +                                        period_ns);
>
> Note this might configure a duty cycle that is too small.
> Consider:
>
>         clk_rate =3D 202500000
>         period =3D 3333643
>         duty_cycle =3D 3306391
>
> Then we get dd_freq =3D 2636 and duty =3D 253.
>
> With dd_freq =3D 2636 and duty =3D 254 the resulting duty_cycle is
>
>         2636 * 1000000000 * 254 / 202500000 =3D 3306390.12345679
>
> so 254 would be the better value. The problem is that you use period_ns
> in the division which however is a bit of as the real period is a tad
> smaller.
>
> So the right thing to do here is:
>
>         duty =3D duty_ns * clk / (dd_freq * NSEC_PER_SEC)
>

ok, duty calculation have two method
duty =3D duty_ns *256 / period_ns
duty =3D duty_ns * clk / (dd_freq * NSEC_PER_SEC)
In this case , it is better with duty =3D duty_ns * clk / (dd_freq * NSEC_P=
ER_SEC)
will modify it.

> > +             duty |=3D (pwm->hwpwm << SP7021_PWM_DD_SEL_BIT_SHIFT);
> > +     }
> > +     writel(duty, priv->base + SP7021_PWM_DUTY(pwm->hwpwm));
>
> I don't understand the DDx SEL bitfield in this register. Is it right
> that it is 0 for all 4 PWMs?
>

PWM0 can select DD0 ~DD3, 0x9c007a18 dd_sel[9:8] and pwm0 duty[7:0]
PWM1 can select DD0 ~DD3, 0x9c007a1c dd_sel[9:8] and pwm1 duty[7:0]
PWM2 can select DD0 ~DD3, 0x9c007a20 dd_sel[9:8] and pwm2 duty[7:0]
PWM3 can select DD0 ~DD3, 0x9c007a24 dd_sel[9:8] and pwm3 duty[7:0]
I will design the driver settings as
PWM0 select DD0
PWM1 select DD1
PWM2 select DD2
PWM3 select DD3
PWM DUTY REG contains dd_sel[9:8] and duty[7:0] for each pwm channel.
once duty calculation done, must conbine dd_sel[9:8] =3D pwm->hwpwm (0
or 1 or 2 or 3)
then write it to PWM DUTY REG.
before
duty |=3D (pwm->hwpwm << SP7021_PWM_DD_SEL_BIT_SHIFT);
after
#define SP7021_PWM_DUTY_DD_SEL(ch)      FIELD_PREP(GENMASK(9, 8), ch)
duty =3D SP7021_PWM_DUTY_DD_SEL(pwm->hwpwm) | duty;

> > +     writel(control1, priv->base + SP7021_PWM_CONTROL1);
> > +     writel(control0, priv->base + SP7021_PWM_CONTROL0);
> > +
> > +     return 0;
> > +}
> > +
> > +static void sunplus_pwm_get_state(struct pwm_chip *chip, struct pwm_de=
vice *pwm,
> > +                               struct pwm_state *state)
> > +{
> > +     struct sunplus_pwm *priv =3D to_sunplus_pwm(chip);
> > +     u32 control0, freq, duty;
> > +     u64 clk_rate;
> > +
> > +     control0 =3D readl(priv->base + SP7021_PWM_CONTROL0);
> > +
> > +     if (control0 & BIT(pwm->hwpwm)) {
> > +             clk_rate =3D clk_get_rate(priv->clk);
> > +             freq =3D readl(priv->base + SP7021_PWM_FREQ(pwm->hwpwm));
>
> I'd call this dd_freq to match the variable name in .apply().
>

ok, will modify it.

> > +             duty =3D readl(priv->base + SP7021_PWM_DUTY(pwm->hwpwm));
> > +             duty &=3D ~GENMASK(9, 8);
>
> That looks wrong, The bit field 9:8 is the divisor source select. Also
> please introduce a define for GENMASK(9,8).
>

ok, will modify it.
#define SP7021_PWM_DUTY_MAX             GENMASK(7, 0)
#define SP7021_PWM_DUTY_MASK            SP7021_PWM_DUTY_MAX
For duty_cycle calculation, must mask dd_sel[9:8] and only get duty[7:0] va=
lue.
duty =3D readl(priv->base + SP7021_PWM_DUTY(pwm->hwpwm));
before
duty &=3D ~GENMASK(9, 8);
after
duty =3D FIELD_GET(SP7021_PWM_DUTY_MASK, duty);

> > +             /*
> > +              * freq 16 bits, SP7021_PWM_FREQ_SCALER 8 bits
> > +              * NSEC_PER_SEC 30 bits, won't overflow.
> > +              */
> > +             state->period =3D DIV64_U64_ROUND_UP((u64)freq * (u64)SP7=
021_PWM_FREQ_SCALER
> > +                                             * NSEC_PER_SEC, clk_rate)=
;
> > +             /*
> > +              * freq 16 bits, duty 8 bits, NSEC_PER_SEC 30 bits, won't=
 overflow.
> > +              */
> > +             state->duty_cycle =3D DIV64_U64_ROUND_UP((u64)freq * (u64=
)duty * NSEC_PER_SEC,
> > +                                                    clk_rate);
> > +             state->enabled =3D true;
> > +     } else {
> > +             state->enabled =3D false;
> > +     }
> > +
> > +     state->polarity =3D PWM_POLARITY_NORMAL;
> > +}
> > +
> > +static const struct pwm_ops sunplus_pwm_ops =3D {
> > +     .apply =3D sunplus_pwm_apply,
> > +     .get_state =3D sunplus_pwm_get_state,
> > +     .owner =3D THIS_MODULE,
> > +};
> > +
> > +static void sunplus_pwm_clk_release(void *data)
> > +{
> > +     struct clk *clk =3D data;
> > +
> > +     clk_disable_unprepare(clk);
> > +}
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
> > +     priv->clk =3D devm_clk_get(dev, NULL);
> > +     if (IS_ERR(priv->clk))
> > +             return dev_err_probe(dev, PTR_ERR(priv->clk),
> > +                                  "get pwm clock failed\n");
> > +
> > +     ret =3D clk_prepare_enable(priv->clk);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to enable clock: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     ret =3D devm_add_action_or_reset(dev, sunplus_pwm_clk_release, pr=
iv->clk);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to release clock: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     priv->chip.dev =3D dev;
> > +     priv->chip.ops =3D &sunplus_pwm_ops;
> > +     priv->chip.npwm =3D SP7021_PWM_NUM;
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
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

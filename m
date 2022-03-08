Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F023D4D16CD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346668AbiCHMEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbiCHMEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:04:35 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44D62716B;
        Tue,  8 Mar 2022 04:03:38 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2dc242a79beso188114797b3.8;
        Tue, 08 Mar 2022 04:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x7Oa/E5lUf4EgiypJay0bd2GtZIds5o04KnCIOMTRm4=;
        b=T9nrjoXWGxr3oateDkaWtdH2aal4QTTkOlxIdzZIgMcge/4QtVsXJCwSDvAzT+wlXJ
         Sc04EM2G5+afZYZPb+TbBYZjBSnRMPU5fHjSLoCH/ATB6tda40G2mcS+/91aHsghDGrb
         bczu578m7ku2yFVjNofTcIcRJDEwSXVbdq0MBt9MIhKt8RBzmN+Tnf9iouz0pFOCwTnL
         Zo94GMK4Yr+p6UgtiDn5RJlYXLu7MaWqVe0IPPAQ5VdjIND4mJlkWAdbNAVt/+0rdfvd
         BcijsFv6giyLhKQqrk3kMWnUT7IVsDQRZZxM1dYGvfrU9IliZ0KZh+w40eHachoNlY8R
         K4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x7Oa/E5lUf4EgiypJay0bd2GtZIds5o04KnCIOMTRm4=;
        b=Q98Lrzru+IhgvqnFc8qvVeZcRxJR9o9g9Z7a8sj+oZoW8AroYI6MN/jfMOWjsq7hRH
         OBQOb3SzuGzKznsBB1RzQJGa9NDSXGhRmz8bekx15LF6HIpQyaRBNq02vL3gDiB+1CEN
         NKscmQ41dhY1soPmP1Zf4HEsyTo7Ku0XA5ecfnbBVcCOpFlQiiouLCoHDtveVaqyEMzi
         KboetOpUsecGNI1Cn/5D+AuQuKmnnbBOF6IXgt2gIAffxn6N1K/L7rGafKrEiLopGqsd
         t1LRn2wdpTBer+vbx9+h+e6Rfux0gZlSIWdemsNBrdZEKdtLhbuOA7uzxqOJVfH+XJAY
         Lz/g==
X-Gm-Message-State: AOAM531JU/NNX2bdE4Wci5MN/v74j65SdRZj43nveeOZQAFCZRqLwcYA
        mN+VMvwO35lU9Z8XA8P090psM7h++zPDSTI/+LU=
X-Google-Smtp-Source: ABdhPJwoW8yzjqUKOiZsJVPRQNOhChNhR6JcSUV7fG0YXbGPJxirAKR609Qvugn+2oRbU7bSdGthYpQbswaOGEo0OZg=
X-Received: by 2002:a0d:d584:0:b0:2db:da4a:e9e9 with SMTP id
 x126-20020a0dd584000000b002dbda4ae9e9mr12396691ywd.383.1646741017534; Tue, 08
 Mar 2022 04:03:37 -0800 (PST)
MIME-Version: 1.0
References: <1646374812-2988-1-git-send-email-hammerh0314@gmail.com>
 <1646374812-2988-3-git-send-email-hammerh0314@gmail.com> <20220304185702.i6csx2r3mokfmr6o@pengutronix.de>
 <CAOX-t56cycXMga_grJcpmSG68ve5-RuTsbtaEQi9Ui0A+5uhSg@mail.gmail.com> <20220307131018.6wrdsiixmgdtnodt@pengutronix.de>
In-Reply-To: <20220307131018.6wrdsiixmgdtnodt@pengutronix.de>
From:   hammer hsieh <hammerh0314@gmail.com>
Date:   Tue, 8 Mar 2022 20:03:55 +0800
Message-ID: <CAOX-t56F2u_1=tA4N4Wvicw-e9J4ksN__J70QZtjZwJRjgesUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pwm:sunplus-pwm:Add Sunplus SoC PWM Driver
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wells.lu@sunplus.com,
        "hammer.hsieh" <hammer.hsieh@sunplus.com>, kernel@pengutronix.de
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
=B43=E6=9C=887=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=889:10=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Hello,
>
> On Mon, Mar 07, 2022 at 08:50:10PM +0800, hammer hsieh wrote:
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2022=
=E5=B9=B43=E6=9C=885=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=882:57=E5=
=AF=AB=E9=81=93=EF=BC=9A
> > > On Fri, Mar 04, 2022 at 02:20:12PM +0800, Hammer Hsieh wrote:
> > > > diff --git a/drivers/pwm/pwm-sunplus.c b/drivers/pwm/pwm-sunplus.c
> > > > new file mode 100644
> > > > index 0000000..170534f
> > > > --- /dev/null
> > > > +++ b/drivers/pwm/pwm-sunplus.c
> > > > @@ -0,0 +1,229 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * PWM device driver for SUNPLUS SoCs
> > >
> > > Is there a public manual available for this hardware? If yes, please =
add
> > > a link here.
> >
> > yes, will add links as below
> > https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
> > https://sunplus.atlassian.net/wiki/spaces/doc/pages/461144198/12.+Pulse=
+Width+Modulation+PWM
> >
> > > > + *
> > > > + * Limitations:
> > > > + * - Only supports normal polarity.
> > >
> > > How does the HW behave when it's disabled? Usual candidates are:
> > >  - It freezes at where it currently is
> > >  - It outputs low
> > >  - It becomes tristate
> > >
> > > Please note this in the Limitations section, too.
> > >
> > > Another thing to mention is if running periods are completed when the
> > > parameters change.
> > >
> >
> > ok, will add note as below
> >   Limitations:
> >   - Only supports normal polarity.
> >   - It output low when PWM channel disabled.
> >   - When the parameters change, current running period will not be comp=
leted
> >       and run new settings immediately.
>
> Sounds good.
>
> Other thing that might maybe happen: in .apply() you write the register
> for period first and then the one for duty_cycle. Can it happen, that
> for a moment the output is defined by new period and old duty_cycle?
> That would be another thing to note.
>

ok, i will add note for it.
  - In .apply() PWM output need to write register FREQ and DUTY. When
first write FREQ
      done and not yet write DUTY, it has short timing gap use new
FREQ and old DUTY.

> > > > +struct sunplus_pwm {
> > > > +     struct pwm_chip chip;
> > > > +     void __iomem *base;
> > > > +     struct clk *clk;
> > > > +     u32 approx_period[PWM_SUP_NUM];
> > > > +     u32 approx_duty_cycle[PWM_SUP_NUM];
> > > > +};
> > > > +
> > > > +static inline struct sunplus_pwm *to_sunplus_pwm(struct pwm_chip *=
chip)
> > > > +{
> > > > +     return container_of(chip, struct sunplus_pwm, chip);
> > > > +}
> > > > +
> > > > +static void sunplus_pwm_free(struct pwm_chip *chip, struct pwm_dev=
ice *pwm)
> > > > +{
> > > > +     struct sunplus_pwm *priv =3D to_sunplus_pwm(chip);
> > > > +     u32 value;
> > > > +
> > > > +     /* disable pwm channel output */
> > > > +     value =3D readl(priv->base + PWM_SUP_CONTROL0);
> > > > +     value &=3D ~BIT(pwm->hwpwm);
> > > > +     writel(value, priv->base + PWM_SUP_CONTROL0);
> > > > +     /* disable pwm channel clk source */
> > > > +     value =3D readl(priv->base + PWM_SUP_CONTROL1);
> > > > +     value &=3D ~BIT(pwm->hwpwm);
> > > > +     writel(value, priv->base + PWM_SUP_CONTROL1);
> > >
> > > the .free callback isn't supposed to modify the hardware.
> >
> > But how to turn pwm channel off ?
> > I add .free function for turn it off.
> > In user space
> >   cd /sys/class/pwm/pwmchip0
> >   echo 0 > export
> >   cd pwm0
> >   echo 20000000 > period
> >   echo 1000000 > duty_cycle
> >   echo 1 > enable
> >   cd ..
> >   echo 0 > unexport ; turn off pwm will call .free function
>
> unexport should just keep the PWM configured as is. To turn it of, don't
> unexport but echo 0 > enable.
>

ok, i will remove .free function.

> > > > +     u32 tmp, rate;
> > > > +     u64 max_period, period_ns, duty_ns, clk_rate;
> > > > +
> > > > +     if (state->polarity !=3D pwm->state.polarity)
> > > > +             return -EINVAL;
> > > > +
> > > > +     if (!state->enabled) {
> > > > +             /* disable pwm channel output */
> > > > +             value =3D readl(priv->base + PWM_SUP_CONTROL0);
> > > > +             value &=3D ~BIT(pwm->hwpwm);
> > >
> > > I'd give this one a name. Something like:
> > >
> > >         #define PWM_SUP_CONTROL_EN(ch)  BIT(ch)
> > >
> > > (Pick the right name from the manual.)
> >
> > That means it need to implement
> > PWM_SUP_CONTROL_EN(ch) and PWM_SUP_CONTROL_DIS(ch) ?
>
> PWM_SUP_CONTROL_EN(ch) should be enough, PWM_SUP_CONTROL_DIS(ch) would
> just be 0 which doens't make much sense.
>

ok , i will add #define PWM_SP7021_CONTROL_EN(ch) BIT(ch).
value &=3D ~BIT(pwm->hwpwm); should be change to
value &=3D ~PWM_SP7021_CONTROL_EN(pwm->hwpwm);

> >
> > > > +             writel(value, priv->base + PWM_SUP_CONTROL0);
> > > > +             /* disable pwm channel clk source */
> > > > +             value =3D readl(priv->base + PWM_SUP_CONTROL1);
> > > > +             value &=3D ~BIT(pwm->hwpwm);
> > > > +             writel(value, priv->base + PWM_SUP_CONTROL1);
> > > > +             return 0;
> > > > +     }
> > > > +
> > > > +     clk_rate =3D clk_get_rate(priv->clk);
> > > > +     rate =3D (u32)clk_rate / 100000;
> > >
> > > This cast doesn't change anything, does it?
> >
> > yes, clk_rate should be 202.5MHz, to prevent overflow use 2025 to calcu=
late.
>
> I only talked about the cast, so
>
>         rate =3D clk_rate / 100000;
>
> should have the same effect and is a tad nicer.
>

since i use mul_u64_u64_div_u64(a,b,c)
max_period =3D mul_u64_u64_div_u64(PWM_SP7021_FREQ_MAX,
(u64)PWM_SP7021_FREQ_SCALER
  * NSEC_PER_SEC, clk_rate);
seems not necessary for "rate =3D clk_rate / 100000".

> > > > +     max_period =3D PWM_SUP_FREQ_MAX * (PWM_SUP_FREQ_SCALER * 1000=
0 / rate);
> > >
> > > Here you have rounding issues. Consider rate =3D 3329. Then you get
> > > max_period =3D 0xffff * (2560000 / 3329) =3D 0xffff * 768 =3D 5033088=
0.
> > >
> > > However the actual result is 50396395.31...
> > >
> > > Also dividing by the result of a division looses precision.
> > >
> >
> > I am not sure how to fix the rounding issue.(thinking...)
>
> the mul_u64_u64_div_u64 I suggested should be good.
>

it works.
 dd_freq =3D mul_u64_u64_div_u64(clk_rate, period_ns, (u64)PWM_SP7021_FREQ_=
SCALER
                 * NSEC_PER_SEC);

> > > > +     if (dd_freq =3D=3D 0)
> > > > +             return -EINVAL;
> > > > +
> > > > +     if (dd_freq > PWM_SUP_FREQ_MAX)
> > > > +             dd_freq =3D PWM_SUP_FREQ_MAX;
> > > > +
> > > > +     writel(dd_freq, priv->base + PWM_SUP_FREQ(pwm->hwpwm));
> > > > +
> > > > +     /* cal and set pwm duty */
> > > > +     value =3D readl(priv->base + PWM_SUP_CONTROL0);
> > > > +     value |=3D BIT(pwm->hwpwm);
> > > > +     value1 =3D readl(priv->base + PWM_SUP_CONTROL1);
> > > > +     value1 |=3D BIT(pwm->hwpwm);
> > > > +     if (duty_ns =3D=3D period_ns) {
> > > > +             value |=3D BIT(pwm->hwpwm + PWM_BYPASS_BIT_SHIFT);
> > > > +             duty =3D PWM_SUP_DUTY_MAX;
> > > > +     } else {
> > > > +             value &=3D ~BIT(pwm->hwpwm + PWM_BYPASS_BIT_SHIFT);
> > > > +             tmp =3D priv->approx_duty_cycle[pwm->hwpwm] * PWM_SUP=
_FREQ_SCALER;
> > > > +             tmp /=3D priv->approx_period[pwm->hwpwm];
> > >
> > > Please use the exact values available.
> >
> > The same reason, in case of enable PWM_DEBUG.
> > first call .apply , then it will call .get_state for verify the calcula=
tion.
>
> The overall goal is not to please PWM_DEBUG, but to use exact
> calculations and if you did that, PWM_DEBUG should be happy, too.
>

sure, will remove approx_xxxx code.

> > > > +             duty =3D (u32)tmp;
> > > > +             duty |=3D (pwm->hwpwm << PWM_DD_SEL_BIT_SHIFT);
> > > > +     }
> > > > +     writel(duty, priv->base + PWM_SUP_DUTY(pwm->hwpwm));
> > > > +     writel(value1, priv->base + PWM_SUP_CONTROL1);
> > > > +     writel(value, priv->base + PWM_SUP_CONTROL0);
> > >
> > > What is the difference between CONTROL1 and CONTROL0?
> >
> > PWM CONTROL0 for PWM channel switch.
> > PWM CONTROL1 for PWM clock source switch.
> > Actually PWM supports 8 channels , but clock source only 4 sets.
> > For easy control(now submit), I just support 4 PWM channels, and one
> > clock source for one pwm channel.
> > For complicated control(not now), 8 PWM channels 4 clock source , need
> > to manage clock source / pwm channel enable or not
> > while request/free pwm channel.
>
> So you can use (say) clk 2 to "drive" PWM channel 6? Where is that
> mapping defined. Only implementing 4 channels with a 1:1 mapping is ok,
> but you might want to ensure the mapping is indeed 1:1.
>

PWM CONTROL0 REG[7:0] for PWM channel on/off
PWM CONTROL1 REG[3:0] for PWM clock source on/off
PWM FREQ REG[15:0] freq =3D 1/clk_rate *256 * FREQ REG[15:0]
PWM DUTY REG[7:0] for duty,  REG[9:8] for clock source select.
  duty |=3D (pwm->hwpwm << PWM_DD_SEL_BIT_SHIFT); can make sure
clock source 0 for pwm0
clock source 1 for pwm1
clock source 2 for pwm2
clock source 3 for pwm3

> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static void sunplus_pwm_get_state(struct pwm_chip *chip, struct pw=
m_device *pwm,
> > > > +                               struct pwm_state *state)
> > > > +{
> > > > +     struct sunplus_pwm *priv =3D to_sunplus_pwm(chip);
> > > > +     u32 value, freq, duty, rate, freq_tmp, duty_tmp;
> > > > +     u64 tmp, clk_rate;
> > > > +
> > > > +     value =3D readl(priv->base + PWM_SUP_CONTROL0);
> > > > +
> > > > +     if (value & BIT(pwm->hwpwm)) {
> > > > +             clk_rate =3D clk_get_rate(priv->clk);
> > > > +             rate =3D (u32)clk_rate / 100000;
> > > > +             freq =3D readl(priv->base + PWM_SUP_FREQ(pwm->hwpwm))=
;
> > > > +             duty =3D readl(priv->base + PWM_SUP_DUTY(pwm->hwpwm))=
;
> > > > +             duty &=3D ~GENMASK(9, 8);
> > > > +
> > > > +             freq_tmp =3D rate * priv->approx_period[pwm->hwpwm] /=
 (PWM_SUP_FREQ_SCALER * 100);
> > > > +             duty_tmp =3D priv->approx_duty_cycle[pwm->hwpwm] * PW=
M_SUP_FREQ_SCALER /
> > > > +                             priv->approx_period[pwm->hwpwm];
> > > > +
> > > > +             if (freq =3D=3D freq_tmp && duty =3D=3D duty_tmp) {
> > > > +                     state->period =3D priv->approx_period[pwm->hw=
pwm] * 100;
> > > > +                     state->duty_cycle =3D priv->approx_duty_cycle=
[pwm->hwpwm] * 100;
> > > > +             } else {
> > > > +                     tmp =3D (u64)freq * PWM_SUP_FREQ_SCALER * 100=
00;
> > > > +                     state->period =3D div64_u64(tmp, rate);
> > > > +                     tmp =3D (u64)freq * (u64)duty * 10000;
> > > > +                     state->duty_cycle =3D div64_u64(tmp, rate);
> > > > +             }
> > > > +             state->enabled =3D true;
> > > > +     } else {
> > > > +             state->enabled =3D false;
> > > > +     }
> > > > +
> > > > +     state->polarity =3D PWM_POLARITY_NORMAL;
> > > > +}
> > >
> > > When .get_state() is first called, .apply wasn't called yet. Then
> > > priv->approx_period[pwm->hwpwm] is zero and the returned result is
> > > wrong. Please read the register values and calculate the implemented
> > > output without caching.
> >
> > The same reason, in case of enable PWM_DEBUG.
> > first call .apply , then it will call .get_state for verify the calcula=
tion.
> >
> > In get_state, I thought about that.
> > first called .get_state, read register value to calculate period and du=
ty_cycle.
> > after calling .apply , caching data approx_period / approx_duty_cycle
> > will not zero.
> > then get_state will use caching data to do PWM_DEBUG self verification.
> > I will think about how to solve the PWM_DEBUG ".apply is not idempotent=
" issue.
>
> I'd say: Don't cache anything. In .get_state() just read the registers an=
d
> determine .duty_cycle and .period from them, and in .apply() do the
> inverse.
>

got it.
i will modify code like below, and it works.
        state->period =3D mul_u64_u64_div_u64((u64)freq,
(u64)PWM_SP7021_FREQ_SCALER
                                        * NSEC_PER_SEC, clk_rate) + 1UL;
        state->duty_cycle =3D mul_u64_u64_div_u64((u64)freq, (u64)duty *
NSEC_PER_SEC,
                                        clk_rate) + 1UL;
seems like i need to plus 1 for it, or ".apply is not idempotent" will happ=
en.

> > > > +     priv->clk =3D devm_clk_get_optional(dev, NULL);
> > > > +     if (IS_ERR(priv->clk))
> > , > > +             return dev_err_probe(dev, PTR_ERR(priv->clk),
> > > > +                                  "get pwm clock failed\n");
> > >
> > > If priv->clk is the dummy clk, clk_get_rate returns 0. This is bad as
> > > (at lease up to now) you divide by rate in .apply().
> > >
> >
> > I check many pwm drivers , they are called devm_clk_get_optional( ) or
> > devm_clk_get( ).
> > Could you tell me how to do it in a probe ?
>
> You can only sensibly use devm_clk_get_optional() if you don't rely on
> the rate of the clk. So the way to go here is to just use
> devm_clk_get().
>

ok, will modify it, change to devm_clk_get().

> > > > +     ret =3D devm_add_action_or_reset(dev,
> > > > +                                    (void(*)(void *))clk_disable_u=
nprepare,
> > >
> > > Without checking my C book I'm unsure if this is save on all platform=
s.
> > > I'd implement a oneline function for this.
> >
> > ok, will implement it in one line.
> > static void sunplus_pwm_clk_release(*data)
> > {
> >    struct clk *clk =3D data;
> >    clk_disable_unprepare(clk);
> > }
> >  ret =3D devm_add_action_or_reset(dev, sunplus_pwm_clk_release, priv->c=
lk);
> >
>
> *nod*
>
> > > > +                                    priv->clk);
> > > > +     if (ret)
> > >
> > > missing error message
> > >
> >
> > I didn't see another driver add an error message, is it necessary?
>
> IMHO yes. (Though the most likely error -ENOMEM, in this case no error
> message should be emitted.)
>

 ok, will add error message like below.
        if (ret < 0) {
                dev_err(dev, "failed to release clock: %d\n", ret);
                return ret;
        }
or should i modify like
        if (ret < 0) {
                dev_err(dev, "failed to release clock: %d\n", ret);
                return ERR_PTR(ret);
        }
i didn't find reference code for it, not sure which one is better?

thank you.

> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

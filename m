Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE644CFFAC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238680AbiCGNLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiCGNLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:11:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8586E54F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:10:37 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nRD82-0008CC-KX; Mon, 07 Mar 2022 14:10:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nRD80-003DWU-Kg; Mon, 07 Mar 2022 14:10:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nRD7y-007YIv-Ty; Mon, 07 Mar 2022 14:10:18 +0100
Date:   Mon, 7 Mar 2022 14:10:18 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     hammer hsieh <hammerh0314@gmail.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wells.lu@sunplus.com,
        "hammer.hsieh" <hammer.hsieh@sunplus.com>, kernel@pengutronix.de
Subject: Re: [PATCH v2 2/2] pwm:sunplus-pwm:Add Sunplus SoC PWM Driver
Message-ID: <20220307131018.6wrdsiixmgdtnodt@pengutronix.de>
References: <1646374812-2988-1-git-send-email-hammerh0314@gmail.com>
 <1646374812-2988-3-git-send-email-hammerh0314@gmail.com>
 <20220304185702.i6csx2r3mokfmr6o@pengutronix.de>
 <CAOX-t56cycXMga_grJcpmSG68ve5-RuTsbtaEQi9Ui0A+5uhSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r2auzwuukbtlhojx"
Content-Disposition: inline
In-Reply-To: <CAOX-t56cycXMga_grJcpmSG68ve5-RuTsbtaEQi9Ui0A+5uhSg@mail.gmail.com>
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


--r2auzwuukbtlhojx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Mar 07, 2022 at 08:50:10PM +0800, hammer hsieh wrote:
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2022=E5=
=B9=B43=E6=9C=885=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=882:57=E5=AF=
=AB=E9=81=93=EF=BC=9A
> > On Fri, Mar 04, 2022 at 02:20:12PM +0800, Hammer Hsieh wrote:
> > > diff --git a/drivers/pwm/pwm-sunplus.c b/drivers/pwm/pwm-sunplus.c
> > > new file mode 100644
> > > index 0000000..170534f
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-sunplus.c
> > > @@ -0,0 +1,229 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * PWM device driver for SUNPLUS SoCs
> >
> > Is there a public manual available for this hardware? If yes, please add
> > a link here.
>=20
> yes, will add links as below
> https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
> https://sunplus.atlassian.net/wiki/spaces/doc/pages/461144198/12.+Pulse+W=
idth+Modulation+PWM
>=20
> > > + *
> > > + * Limitations:
> > > + * - Only supports normal polarity.
> >
> > How does the HW behave when it's disabled? Usual candidates are:
> >  - It freezes at where it currently is
> >  - It outputs low
> >  - It becomes tristate
> >
> > Please note this in the Limitations section, too.
> >
> > Another thing to mention is if running periods are completed when the
> > parameters change.
> >
>=20
> ok, will add note as below
>   Limitations:
>   - Only supports normal polarity.
>   - It output low when PWM channel disabled.
>   - When the parameters change, current running period will not be comple=
ted
>       and run new settings immediately.

Sounds good.

Other thing that might maybe happen: in .apply() you write the register
for period first and then the one for duty_cycle. Can it happen, that
for a moment the output is defined by new period and old duty_cycle?
That would be another thing to note.

> > > +struct sunplus_pwm {
> > > +     struct pwm_chip chip;
> > > +     void __iomem *base;
> > > +     struct clk *clk;
> > > +     u32 approx_period[PWM_SUP_NUM];
> > > +     u32 approx_duty_cycle[PWM_SUP_NUM];
> > > +};
> > > +
> > > +static inline struct sunplus_pwm *to_sunplus_pwm(struct pwm_chip *ch=
ip)
> > > +{
> > > +     return container_of(chip, struct sunplus_pwm, chip);
> > > +}
> > > +
> > > +static void sunplus_pwm_free(struct pwm_chip *chip, struct pwm_devic=
e *pwm)
> > > +{
> > > +     struct sunplus_pwm *priv =3D to_sunplus_pwm(chip);
> > > +     u32 value;
> > > +
> > > +     /* disable pwm channel output */
> > > +     value =3D readl(priv->base + PWM_SUP_CONTROL0);
> > > +     value &=3D ~BIT(pwm->hwpwm);
> > > +     writel(value, priv->base + PWM_SUP_CONTROL0);
> > > +     /* disable pwm channel clk source */
> > > +     value =3D readl(priv->base + PWM_SUP_CONTROL1);
> > > +     value &=3D ~BIT(pwm->hwpwm);
> > > +     writel(value, priv->base + PWM_SUP_CONTROL1);
> >
> > the .free callback isn't supposed to modify the hardware.
>=20
> But how to turn pwm channel off ?
> I add .free function for turn it off.
> In user space
>   cd /sys/class/pwm/pwmchip0
>   echo 0 > export
>   cd pwm0
>   echo 20000000 > period
>   echo 1000000 > duty_cycle
>   echo 1 > enable
>   cd ..
>   echo 0 > unexport ; turn off pwm will call .free function

unexport should just keep the PWM configured as is. To turn it of, don't
unexport but echo 0 > enable.

> > > +     u32 tmp, rate;
> > > +     u64 max_period, period_ns, duty_ns, clk_rate;
> > > +
> > > +     if (state->polarity !=3D pwm->state.polarity)
> > > +             return -EINVAL;
> > > +
> > > +     if (!state->enabled) {
> > > +             /* disable pwm channel output */
> > > +             value =3D readl(priv->base + PWM_SUP_CONTROL0);
> > > +             value &=3D ~BIT(pwm->hwpwm);
> >
> > I'd give this one a name. Something like:
> >
> >         #define PWM_SUP_CONTROL_EN(ch)  BIT(ch)
> >
> > (Pick the right name from the manual.)
>=20
> That means it need to implement
> PWM_SUP_CONTROL_EN(ch) and PWM_SUP_CONTROL_DIS(ch) ?

PWM_SUP_CONTROL_EN(ch) should be enough, PWM_SUP_CONTROL_DIS(ch) would
just be 0 which doens't make much sense.

>=20
> > > +             writel(value, priv->base + PWM_SUP_CONTROL0);
> > > +             /* disable pwm channel clk source */
> > > +             value =3D readl(priv->base + PWM_SUP_CONTROL1);
> > > +             value &=3D ~BIT(pwm->hwpwm);
> > > +             writel(value, priv->base + PWM_SUP_CONTROL1);
> > > +             return 0;
> > > +     }
> > > +
> > > +     clk_rate =3D clk_get_rate(priv->clk);
> > > +     rate =3D (u32)clk_rate / 100000;
> >
> > This cast doesn't change anything, does it?
>=20
> yes, clk_rate should be 202.5MHz, to prevent overflow use 2025 to calcula=
te.

I only talked about the cast, so

	rate =3D clk_rate / 100000;

should have the same effect and is a tad nicer.

> > > +     max_period =3D PWM_SUP_FREQ_MAX * (PWM_SUP_FREQ_SCALER * 10000 =
/ rate);
> >
> > Here you have rounding issues. Consider rate =3D 3329. Then you get
> > max_period =3D 0xffff * (2560000 / 3329) =3D 0xffff * 768 =3D 50330880.
> >
> > However the actual result is 50396395.31...
> >
> > Also dividing by the result of a division looses precision.
> >
>=20
> I am not sure how to fix the rounding issue.(thinking...)

the mul_u64_u64_div_u64 I suggested should be good.

> > > +     if (dd_freq =3D=3D 0)
> > > +             return -EINVAL;
> > > +
> > > +     if (dd_freq > PWM_SUP_FREQ_MAX)
> > > +             dd_freq =3D PWM_SUP_FREQ_MAX;
> > > +
> > > +     writel(dd_freq, priv->base + PWM_SUP_FREQ(pwm->hwpwm));
> > > +
> > > +     /* cal and set pwm duty */
> > > +     value =3D readl(priv->base + PWM_SUP_CONTROL0);
> > > +     value |=3D BIT(pwm->hwpwm);
> > > +     value1 =3D readl(priv->base + PWM_SUP_CONTROL1);
> > > +     value1 |=3D BIT(pwm->hwpwm);
> > > +     if (duty_ns =3D=3D period_ns) {
> > > +             value |=3D BIT(pwm->hwpwm + PWM_BYPASS_BIT_SHIFT);
> > > +             duty =3D PWM_SUP_DUTY_MAX;
> > > +     } else {
> > > +             value &=3D ~BIT(pwm->hwpwm + PWM_BYPASS_BIT_SHIFT);
> > > +             tmp =3D priv->approx_duty_cycle[pwm->hwpwm] * PWM_SUP_F=
REQ_SCALER;
> > > +             tmp /=3D priv->approx_period[pwm->hwpwm];
> >
> > Please use the exact values available.
>=20
> The same reason, in case of enable PWM_DEBUG.
> first call .apply , then it will call .get_state for verify the calculati=
on.

The overall goal is not to please PWM_DEBUG, but to use exact
calculations and if you did that, PWM_DEBUG should be happy, too.

> > > +             duty =3D (u32)tmp;
> > > +             duty |=3D (pwm->hwpwm << PWM_DD_SEL_BIT_SHIFT);
> > > +     }
> > > +     writel(duty, priv->base + PWM_SUP_DUTY(pwm->hwpwm));
> > > +     writel(value1, priv->base + PWM_SUP_CONTROL1);
> > > +     writel(value, priv->base + PWM_SUP_CONTROL0);
> >
> > What is the difference between CONTROL1 and CONTROL0?
>=20
> PWM CONTROL0 for PWM channel switch.
> PWM CONTROL1 for PWM clock source switch.
> Actually PWM supports 8 channels , but clock source only 4 sets.
> For easy control(now submit), I just support 4 PWM channels, and one
> clock source for one pwm channel.
> For complicated control(not now), 8 PWM channels 4 clock source , need
> to manage clock source / pwm channel enable or not
> while request/free pwm channel.

So you can use (say) clk 2 to "drive" PWM channel 6? Where is that
mapping defined. Only implementing 4 channels with a 1:1 mapping is ok,
but you might want to ensure the mapping is indeed 1:1.

> > > +     return 0;
> > > +}
> > > +
> > > +static void sunplus_pwm_get_state(struct pwm_chip *chip, struct pwm_=
device *pwm,
> > > +                               struct pwm_state *state)
> > > +{
> > > +     struct sunplus_pwm *priv =3D to_sunplus_pwm(chip);
> > > +     u32 value, freq, duty, rate, freq_tmp, duty_tmp;
> > > +     u64 tmp, clk_rate;
> > > +
> > > +     value =3D readl(priv->base + PWM_SUP_CONTROL0);
> > > +
> > > +     if (value & BIT(pwm->hwpwm)) {
> > > +             clk_rate =3D clk_get_rate(priv->clk);
> > > +             rate =3D (u32)clk_rate / 100000;
> > > +             freq =3D readl(priv->base + PWM_SUP_FREQ(pwm->hwpwm));
> > > +             duty =3D readl(priv->base + PWM_SUP_DUTY(pwm->hwpwm));
> > > +             duty &=3D ~GENMASK(9, 8);
> > > +
> > > +             freq_tmp =3D rate * priv->approx_period[pwm->hwpwm] / (=
PWM_SUP_FREQ_SCALER * 100);
> > > +             duty_tmp =3D priv->approx_duty_cycle[pwm->hwpwm] * PWM_=
SUP_FREQ_SCALER /
> > > +                             priv->approx_period[pwm->hwpwm];
> > > +
> > > +             if (freq =3D=3D freq_tmp && duty =3D=3D duty_tmp) {
> > > +                     state->period =3D priv->approx_period[pwm->hwpw=
m] * 100;
> > > +                     state->duty_cycle =3D priv->approx_duty_cycle[p=
wm->hwpwm] * 100;
> > > +             } else {
> > > +                     tmp =3D (u64)freq * PWM_SUP_FREQ_SCALER * 10000;
> > > +                     state->period =3D div64_u64(tmp, rate);
> > > +                     tmp =3D (u64)freq * (u64)duty * 10000;
> > > +                     state->duty_cycle =3D div64_u64(tmp, rate);
> > > +             }
> > > +             state->enabled =3D true;
> > > +     } else {
> > > +             state->enabled =3D false;
> > > +     }
> > > +
> > > +     state->polarity =3D PWM_POLARITY_NORMAL;
> > > +}
> >
> > When .get_state() is first called, .apply wasn't called yet. Then
> > priv->approx_period[pwm->hwpwm] is zero and the returned result is
> > wrong. Please read the register values and calculate the implemented
> > output without caching.
>=20
> The same reason, in case of enable PWM_DEBUG.
> first call .apply , then it will call .get_state for verify the calculati=
on.
>=20
> In get_state, I thought about that.
> first called .get_state, read register value to calculate period and duty=
_cycle.
> after calling .apply , caching data approx_period / approx_duty_cycle
> will not zero.
> then get_state will use caching data to do PWM_DEBUG self verification.
> I will think about how to solve the PWM_DEBUG ".apply is not idempotent" =
issue.

I'd say: Don't cache anything. In .get_state() just read the registers and
determine .duty_cycle and .period from them, and in .apply() do the
inverse.

> > > +     priv->clk =3D devm_clk_get_optional(dev, NULL);
> > > +     if (IS_ERR(priv->clk))
> , > > +             return dev_err_probe(dev, PTR_ERR(priv->clk),
> > > +                                  "get pwm clock failed\n");
> >
> > If priv->clk is the dummy clk, clk_get_rate returns 0. This is bad as
> > (at lease up to now) you divide by rate in .apply().
> >
>=20
> I check many pwm drivers , they are called devm_clk_get_optional( ) or
> devm_clk_get( ).
> Could you tell me how to do it in a probe ?

You can only sensibly use devm_clk_get_optional() if you don't rely on
the rate of the clk. So the way to go here is to just use
devm_clk_get().

> > > +     ret =3D devm_add_action_or_reset(dev,
> > > +                                    (void(*)(void *))clk_disable_unp=
repare,
> >
> > Without checking my C book I'm unsure if this is save on all platforms.
> > I'd implement a oneline function for this.
>=20
> ok, will implement it in one line.
> static void sunplus_pwm_clk_release(*data)
> {
>    struct clk *clk =3D data;
>    clk_disable_unprepare(clk);
> }
>  ret =3D devm_add_action_or_reset(dev, sunplus_pwm_clk_release, priv->clk=
);
>=20

*nod*

> > > +                                    priv->clk);
> > > +     if (ret)
> >
> > missing error message
> >
>=20
> I didn't see another driver add an error message, is it necessary?

IMHO yes. (Though the most likely error -ENOMEM, in this case no error
message should be emitted.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--r2auzwuukbtlhojx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmImBDcACgkQwfwUeK3K
7AnVaAgAhJJ05MIAoQYFoGdi6n63rMm1Lztd1uxdu8UNsO3rY2C6SmLGvV/sIRRE
/tE/NCQKdqE83W100LEGkEazrmheeZCsC9qbM97AgeNByX/tZUPKYgnKY7q5fSqy
oWeATu0AASCXGHkD76q502hR1+MHLLjnveqKihyVjP5VAURVyLqGnniN/5mzdeSb
lTYOO/cJ4dwz7nVLz3mLuldOlkOvCeNtSOaWQ0ddvlU6FAAJCBPp2+Iea4XZoSlc
VRK3McPwP9LPYUQbZ+AvAlAzLvp0E5sQRJnSnSpJYktfBTbaL5oLAtIOm+ft7JjC
Pr0yd4B5E8/gvUXdgdGJhtCWzz2nsQ==
=64DV
-----END PGP SIGNATURE-----

--r2auzwuukbtlhojx--

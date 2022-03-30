Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5B94ECFDA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350699AbiC3W7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbiC3W7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:59:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834943B54C;
        Wed, 30 Mar 2022 15:58:01 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w21so26703261wra.2;
        Wed, 30 Mar 2022 15:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xvhtfkqMJ4c4d0N7V3wRfS/b5WAt6hdOl2FpSbIa3zM=;
        b=T5l4Gcz7z5PbCmOeC8FeId4PmKPeJWr1zyDTCDIoPt0PSy3tenfCeJTA527sw8q+Tq
         WfL7wYX3NEZtOtT7ift7oY7JMMzKK8rpgxKVvhvBJkRLmgJL3frVkNA+aYSOibT4x10r
         Ma9H88p6q+0cirRe8uTBIYqo3ehpzakeBJjZAKXXM8+hFxynHAt+uMXfl6W/K1AGY+oP
         EpAQZBEN5E/BkG+e+iKpU7LVZssNXSpgz0LwwnJUUg+nCjN2+k317NwZW+vIXoKLb6/F
         qIOJscuMOUDkHfc10/3P3OsBjadB2LdjM+ARVFYRN1MKPwT87o+HWM4sy1bBfELp4Yim
         VAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xvhtfkqMJ4c4d0N7V3wRfS/b5WAt6hdOl2FpSbIa3zM=;
        b=TItT5P5T0ZWTVFkgx4r2IA8tT5VUcOtaiasfEfM/E9DJceVtsm0z/5X5iY+SeWwdKZ
         KSe87eSiEWJq8o7iifwAKsgzKYPqMqhrPw30IFr/vOMuCgrQmi9wEP1B9blttWlvg2iJ
         wRuOittalp8k+vg83xjncjzvAg84EAln4zEx+/XjLsPxeHdsjzNTHxicebg1r05ZLmB9
         SnaYPDjOhrzL2zGnGJF2LaoEBXzQ0HW9Ob7FSsuuhrJXsfjcaBAzvToJGgkmIZBTZDoB
         jQPaNvAWb+ngBc2XHj73UBr1lPNy5x2yykizmcBT4IQ3WkyN95SjuY7fNWJqvRGbo8x3
         f7Ug==
X-Gm-Message-State: AOAM530mrg6Ik8o1H2s7lXCd+rJ3i2eyRFWdmavSM0+9vA0acWJmJg/u
        M/7tGgCoTTSI+ebnbCCokZRuGUwuD6PDRFvwDUA=
X-Google-Smtp-Source: ABdhPJwKCvvv7HP6KRuVXCwv6EqbC0M3tiuDc46GUtfDqUp0XyBhnX5zpBa/KHPYtB6hA1cCBtJOGtBOZbVHy6xIotk=
X-Received: by 2002:adf:f20f:0:b0:203:fc73:a9a0 with SMTP id
 p15-20020adff20f000000b00203fc73a9a0mr1666467wro.418.1648681079978; Wed, 30
 Mar 2022 15:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220330090947.9100-1-chenxiangrui@huaqin.corp-partner.google.com>
 <YkSQY5NSYcov21Ig@google.com>
In-Reply-To: <YkSQY5NSYcov21Ig@google.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 30 Mar 2022 15:57:48 -0700
Message-ID: <CAF6AEGvtK6gvhJqKweLoG2pdbo=Hu=3xjNySXkT84GLqbKkp+Q@mail.gmail.com>
Subject: Re: [PATCH] CHROMIUM: arm64: dts: qcom: Add sc7180-gelarshie
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 2:58 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Wed, Mar 30, 2022 at 05:09:46PM +0800, Mars Chen wrote:
>
> > Subject: CHROMIUM: arm64: dts: qcom: Add sc7180-gelarshie
>
> No CHROMIUM tag for upstream posts.
>
> > Initial attempt at Gelarshie device tree.
>
> This is not very useful. If you don't want to reveal much information
> about an unreleased device you could say something generic like
> "Add device tree for Gelarshie, a trogdor variant".
>
> > BUG=b:225756600
> > TEST=emerge-strongbad chromeos-kernel-5_4
>
> drop these
>
> > Signed-off-by: Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> >  arch/arm64/boot/dts/qcom/Makefile             |   1 +
> >  .../dts/qcom/sc7180-trogdor-gelarshie-r0.dts  |  15 +
> >  .../dts/qcom/sc7180-trogdor-gelarshie.dtsi    | 304 ++++++++++++++++++
> >  3 files changed, 320 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts
> >  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > index f9e6343acd03..cf8f88b065c3 100644
> > --- a/arch/arm64/boot/dts/qcom/Makefile
> > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > @@ -57,6 +57,7 @@ dtb-$(CONFIG_ARCH_QCOM)     += sc7180-trogdor-coachz-r1.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += sc7180-trogdor-coachz-r1-lte.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += sc7180-trogdor-coachz-r3.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += sc7180-trogdor-coachz-r3-lte.dtb
> > +dtb-$(CONFIG_ARCH_QCOM)      += sc7180-trogdor-gelarshie-r0.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += sc7180-trogdor-homestar-r2.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += sc7180-trogdor-homestar-r3.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += sc7180-trogdor-homestar-r4.dtb
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts
> > new file mode 100644
> > index 000000000000..027d6d563a5f
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts
> > @@ -0,0 +1,15 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Google Gelarshie board device tree source
> > + *
> > + * Copyright 2022 Google LLC.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "sc7180-trogdor-gelarshie.dtsi"
> > +
> > +/ {
> > +     model = "Google Gelarshie (rev0+)";
> > +     compatible = "google,gelarshie", "qcom,sc7180";
> > +};
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi
> > new file mode 100644
> > index 000000000000..842f6cac6c27
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi
> > @@ -0,0 +1,304 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Google Gelarshie board device tree source
> > + *
> > + * Copyright 2022 Google LLC.
> > + */
> > +
> > +#include "sc7180.dtsi"
> > +#include "sc7180-trogdor-mipi-camera.dtsi"
>
> drop the mipi camera include, it is not upstream
>
> > +
> > +ap_ec_spi: &spi6 {};
> > +ap_h1_spi: &spi0 {};
> > +
> > +#include "sc7180-trogdor.dtsi"
> > +#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
> > +
> > +/* Deleted nodes from trogdor.dtsi */
> > +
> > +/delete-node/ &alc5682;
> > +/delete-node/ &pp3300_codec;
> > +
> > +/ {
> > +     /* BOARD-SPECIFIC TOP LEVEL NODES */
> > +
> > +     adau7002: audio-codec-1 {
> > +             compatible = "adi,adau7002";
> > +             IOVDD-supply = <&pp1800_l15a>;
> > +             wakeup-delay-ms = <80>;
> > +             #sound-dai-cells = <0>;
> > +     };
> > +};
> > +
> > +&backlight {
> > +     pwms = <&cros_ec_pwm 0>;
> > +};
> > +
> > +&camcc {
> > +     status = "okay";
> > +};
> > +
> > +&cros_ec {
> > +     cros_ec_proximity: proximity {
> > +             compatible = "google,cros-ec-mkbp-proximity";
> > +             label = "proximity-wifi";
> > +     };
> > +};
> > +
> > +ap_ts_pen_1v8: &i2c4 {
> > +     status = "okay";
> > +     clock-frequency = <400000>;
> > +
> > +     ap_ts: touchscreen@5d {
> > +             compatible = "goodix,gt7375p";
> > +             reg = <0x5d>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&ts_int_l>, <&ts_reset_l>;
> > +
> > +             interrupt-parent = <&tlmm>;
> > +             interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +             reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
> > +
> > +             vdd-supply = <&pp3300_ts>;
> > +     };
> > +};
> > +
> > +&i2c7 {
> > +     status = "disabled";
> > +};
> > +
> > +&i2c9 {
> > +     status = "disabled";
> > +};
> > +
> > +&mdp {
> > +     chromium-enable-overlays;
> > +};
>
> I can't find documentation for 'chromium-enable-overlays', what is this
> supposed to do?

it's a downstream workaround .. this can be dropped from upstream dt

BR,
-R

> > +
> > +&panel {
> > +     compatible = "edp-panel";
> > +};
> > +
> > +&pm6150_adc {
> > +     skin-temp-thermistor@4e {
> > +             reg = <ADC5_AMUX_THM2_100K_PU>;
> > +             qcom,ratiometric;
> > +             qcom,hw-settle-time = <200>;
> > +     };
> > +};
> > +
> > +&pm6150_adc_tm {
> > +     status = "okay";
> > +
> > +     skin-temp-thermistor@1 {
> > +             reg = <1>;
> > +             io-channels = <&pm6150_adc ADC5_AMUX_THM2_100K_PU>;
> > +             qcom,ratiometric;
> > +             qcom,hw-settle-time-us = <200>;
> > +     };
> > +};
>
> The thermistor is currently unused, drop it and add it later when you
> add the corresponding thermal zone.
>
> > +
> > +&pp1800_uf_cam {
> > +     status = "okay";
> > +};
> > +
> > +&pp1800_wf_cam {
> > +     status = "okay";
> > +};
> > +
> > +&pp2800_uf_cam {
> > +     status = "okay";
> > +};
> > +
> > +&pp2800_wf_cam {
> > +     status = "okay";
> > +};
> > +
> > +&pp3300_dx_edp {
> > +     gpio = <&tlmm 67 GPIO_ACTIVE_HIGH>;
> > +};
> > +
> > +&sdhc_2 {
> > +     status = "okay";
> > +};
> > +
> > +&sn65dsi86_out {
> > +     data-lanes = <0 1 2 3>;
> > +};
> > +
> > +&sound {
> > +     compatible = "google,sc7180-coachz";
>
> Is 'sc7180-coachz' intended because the config is the same as for
> coachz or should this be 'sc7180-gelarshie'?

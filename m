Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81776568C5D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiGFPIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiGFPI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:08:28 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E3AE86;
        Wed,  6 Jul 2022 08:08:26 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b24so11240871qkn.4;
        Wed, 06 Jul 2022 08:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fiRRxOZJQca+onQTxG6YxZ3iz34eD7bdAqBIrSyxbbo=;
        b=nRMefuEZIe7rKiC26E9KAQY5dk54cixodhUcsRFlTn7152lyM8Ul0ZbLRheho6olsi
         WDUR77vknEaqO7YXjY6paP/51tjrZelOJcoOfbHDl0d8PHcTMos1/uFTyEuHzVE8q/jJ
         j4dXIxWZ3OvaBEidl33AuWiSnBoJ2v8Vbg4re1pSlAgHcIyFPJq6i1UupZLbGE/oha1d
         +k0C1DeNionerAV0HPTGyX6B/HNxRs/F5NgjuP8yAGVm12StSTHyhrF3NS1jTTO5Du/0
         CB/nxxGfVA7F3ErHYtFoC5Rhotb6lBnmKOusDeyZsUS3vbdH1GUKpJbWWHHMdW5UlYTg
         YHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fiRRxOZJQca+onQTxG6YxZ3iz34eD7bdAqBIrSyxbbo=;
        b=W98802Qrg/JfIflxNk2T0GmJallr8vSjpug0fx/WEGfPBrwKcKwFzpLL7w048xfrxe
         jpmbZcNSDgwLWRsyMdPd/kOC+a9ncQ/zd3cipSD8V3pT6+jIVOcruoB3olLT5Vgvdm/a
         Nm4WI6sLEjKniS73okDS3WooCwzTcYCWNsEQXU5nR+NvLpYGaGdg05GZoGBym1vpVhpq
         XnrborVl0VM6JjPJ9UrGhMCf9cQELp9TXo6D+3+2Fxd97FkH0HEEI0pMUqBEz7APC6kK
         WrqO4o2J/+JcwHEW327IUsFZ22o9Q72NOjjkS6Iv5lX5eteIqeoEU+fvSLjxdp6Wlqoa
         03jQ==
X-Gm-Message-State: AJIora8UYDe1J4cR5JqMwj/upu6LPgm4xd6YotGCeW60/lZhkZ+CTK9N
        MfQTcAnf0MLXncGVHxoYVKA+cNWsYyj6xnc3mzQfvsJJnYg=
X-Google-Smtp-Source: AGRyM1tkv0qbWgPV08FG3lb7/F99cqnEdUrvpBxyh5xvwLVLNUT89sYVHwh8RpcfsNTbQqhiaZWWQhbTytzmLyGs6uE=
X-Received: by 2002:a05:620a:4547:b0:6b1:4f80:d5a8 with SMTP id
 u7-20020a05620a454700b006b14f80d5a8mr26514496qkp.87.1657120105698; Wed, 06
 Jul 2022 08:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220704212402.1715182-1-robimarko@gmail.com> <20220704212402.1715182-11-robimarko@gmail.com>
 <a443cd40-a1d5-6e17-1c49-d592a590f1f8@somainline.org>
In-Reply-To: <a443cd40-a1d5-6e17-1c49-d592a590f1f8@somainline.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 6 Jul 2022 17:08:14 +0200
Message-ID: <CAOX2RU55pAZNiYRT4NOw9W+XZe17vBi+9Wrm5zz99Mctd8g1aA@mail.gmail.com>
Subject: Re: [PATCH v6 11/12] arm64: dts: qcom: add PMP8074 DTSI
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lee.jones@linaro.org, Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Linus Walleij <linus.walleij@linaro.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>, jic23@kernel.org,
        lars@metafoo.de, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
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

On Wed, 6 Jul 2022 at 14:27, Konrad Dybcio <konrad.dybcio@somainline.org> wrote:
>
>
>
> On 4.07.2022 23:24, Robert Marko wrote:
> > PMP8074 is a companion PMIC to the Qualcomm IPQ8074 series that is
> > controlled via SPMI.
> >
> > Add DTSI for it providing GPIO, regulator and RTC support.
> >
> > RTC is disabled by default as there is no built-in battery so it will
> > loose time unless board vendor added a battery, so make it optional.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> > Changes in v6:
> > * Add RTC and GPIO nodes
> >
> > Changes in v5:
> > * Remove #address-cells and #size-cells as they are not required for
> > regulator subnodes
> > ---
> >  arch/arm64/boot/dts/qcom/pmp8074.dtsi | 125 ++++++++++++++++++++++++++
> >  1 file changed, 125 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/pmp8074.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/qcom/pmp8074.dtsi b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
> > new file mode 100644
> > index 000000000000..a3b395e4d78f
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
> > @@ -0,0 +1,125 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> Hi,
>
> Please consider BSD3, or at least dual-licensing with some permissive
> license (so that for example BSDs can re-use these DTs).

Hi Konrad,

I will dual-license with BSD-3-Clause, it's not an issue.

> > +
> > +#include <dt-bindings/spmi/spmi.h>
> > +#include <dt-bindings/iio/qcom,spmi-vadc.h>
> > +
> > +&spmi_bus {
> > +     pmic@0 {
> > +             compatible = "qcom,pmp8074", "qcom,spmi-pmic";
> > +             reg = <0x0 SPMI_USID>;
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +
> > +             pmp8074_adc: adc@3100 {
> > +                     compatible = "qcom,spmi-adc-rev2";
> > +                     reg = <0x3100>;
> > +                     interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> > +                     #address-cells = <1>;
> > +                     #size-cells = <0>;
> > +                     #io-channel-cells = <1>;
> > +
> > +                     ref_gnd@0 {
> No underscores in node names, please change this to ref-gnd (and consequently
> for all other nodes). Note that this only concerns node names and not labels.

Will fixup in v7.
>
> > +                             reg = <ADC5_REF_GND>;
> > +                             qcom,pre-scaling = <1 1>;
> > +                     };
> > +
> > +                     vref_1p25@1 {
> > +                             reg = <ADC5_1P25VREF>;
> > +                             qcom,pre-scaling = <1 1>;
> > +                     };
> > +
> > +                     vref_vadc@2 {
> > +                             reg = <ADC5_VREF_VADC>;
> > +                             qcom,pre-scaling = <1 1>;
> > +                     };
> > +
> > +                     pmic_die: die_temp@6 {
> > +                             reg = <ADC5_DIE_TEMP>;
> > +                             qcom,pre-scaling = <1 1>;
> > +                     };
> > +
> > +                     xo_therm: xo_temp@76 {
> > +                             reg = <ADC5_XO_THERM_100K_PU>;
> > +                             qcom,ratiometric;
> > +                             qcom,hw-settle-time = <200>;
> > +                             qcom,pre-scaling = <1 1>;
> > +                     };
> > +
> > +                     pa_therm1: thermistor1@77 {
> > +                             reg = <ADC5_AMUX_THM1_100K_PU>;
> > +                             qcom,ratiometric;
> > +                             qcom,hw-settle-time = <200>;
> > +                             qcom,pre-scaling = <1 1>;
> > +                     };
> > +
> > +                     pa_therm2: thermistor2@78 {
> > +                             reg = <ADC5_AMUX_THM2_100K_PU>;
> > +                             qcom,ratiometric;
> > +                             qcom,hw-settle-time = <200>;
> > +                             qcom,pre-scaling = <1 1>;
> > +                     };
> > +
> > +                     pa_therm3: thermistor3@79 {
> > +                             reg = <ADC5_AMUX_THM3_100K_PU>;
> > +                             qcom,ratiometric;
> > +                             qcom,hw-settle-time = <200>;
> > +                             qcom,pre-scaling = <1 1>;
> > +                     };
> > +
> > +                     vph_pwr@131 {
> > +                             reg = <ADC5_VPH_PWR>;
> > +                             qcom,pre-scaling = <1 3>;
> > +                     };
> > +             };
> > +
> > +             pmp8074_rtc: rtc@6000 {
> > +                     compatible = "qcom,pm8941-rtc";
> > +                     reg = <0x6000>;
> > +                     reg-names = "rtc", "alarm";
> > +                     interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
> > +                     allow-set-time;
> > +                     status = "disabled";
> Isn't this PMIC-internal, aka accessible on all devices using PMP8074?

Yes, however as I have written in the commit description there is no battery
backup present until the board vendor puts one and so your RTC will loose
time as soon as power is lost and you are back to 1970.

>
> > +             };
> > +
> > +             pmp8074_gpios: gpio@c000 {
> > +                     compatible = "qcom,pmp8074-gpio", "qcom,spmi-gpio";
> > +                     reg = <0xc000>;
> > +                     gpio-controller;
> > +                     #gpio-cells = <2>;
> > +                     gpio-ranges = <&pmp8074_gpios 0 0 12>;
> > +                     interrupt-controller;
> > +                     #interrupt-cells = <2>;
> > +             };
> > +     };
> > +
> > +     pmic@1 {
> > +             compatible = "qcom,pmp8074", "qcom,spmi-pmic";
> > +             reg = <0x1 SPMI_USID>;
> > +
> > +             regulators {
> > +                     compatible = "qcom,pmp8074-regulators";
> > +
> > +                     s3: s3 {
> > +                             regulator-name = "vdd_s3";
> > +                             regulator-min-microvolt = <592000>;
> > +                             regulator-max-microvolt = <1064000>;
>
> Are you sure no other configurations are supported with this PMIC?
> Otherwise you may accidentally burn somebody's board by setting up
> regulators in a place that's not usually expected to have them..

These values are read directly from the PMIC spec sheet as I thankfully have
the spec sheet.

Since PMP8074 is exclusively an IPQ8074 companion part then
S3 will always be the CPU cluster regulator, S4 is the NPU cores regulator,
L11 is the SDIO I/O regulator.

There is plenty of other regulators inside, and support for them is
included in the
patches for the SPMI driver, however, they dont really have a kernel consumer
currently, so I decided not to include them in the DTSI.
QFPROM is fed by one of the LDO-s as well, will add that later once QFPROM
support is being worked on, no ETA as I am doing this in my free time.
All regulators have a default value set by the PMIC and then by the boot FW
anyway.

Regards,
Robert
>
> Konrad
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                     };
> > +
> > +                     s4: s4 {
> > +                             regulator-name = "vdd_s4";
> > +                             regulator-min-microvolt = <712000>;
> > +                             regulator-max-microvolt = <992000>;
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                     };
> > +
> > +                     l11: l11 {
> > +                             regulator-name = "l11";
> > +                             regulator-min-microvolt = <1800000>;
> > +                             regulator-max-microvolt = <3300000>;
> > +                     };
> > +             };
> > +     };
> > +};

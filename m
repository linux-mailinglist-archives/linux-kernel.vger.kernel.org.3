Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679BD503685
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 14:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiDPMK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 08:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiDPMKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 08:10:24 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076134DF48;
        Sat, 16 Apr 2022 05:07:52 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2ef5380669cso86821977b3.9;
        Sat, 16 Apr 2022 05:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+31xuNLV7LHAxfhWh2k+h4NP4NFmF53KaYTzUkGf+M=;
        b=mayUMZveC2eE/aCDlT0jaT2jD6TtT0szz2M5nqHlpjd5CoC1UOSbqa61KxPDb+KVRS
         2WgW1JaVbOFUfYG2Y6eL9lg2TK1wMEF4iVLkoTyk+HE8lottdC0yyJRoexPIiLOFUYGk
         NkeBL2vPpMuXkgnZS/rC4l+rQYiYJbdAJ/kQWle0ZIxGsPMajnT5kHFHketuL4U6W8cz
         n5BuwM1Nkxe497X374O+NlD1UxwfNKRYJNFaJuMTYWEnYHpk8jSgEDJVYB797WK4eHnr
         CKwvDyCDYm4IlEgv12BqWEk5NyOC+y8SttQEvTxSwkZ5YaPERc8pRBDxwI0FfiRKZvAN
         XoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+31xuNLV7LHAxfhWh2k+h4NP4NFmF53KaYTzUkGf+M=;
        b=E/SmPGFBAO2hRqH+R0pCO5oh6XQGR1uk8jhqG+kkbtyDDeoTJZ5bM6+8In+LIj5Lpa
         bOPDdGHY3a5JvOS9yFfWvdX24vW9j/h9+tHpKIcEImyqcrxUQhp6nXmsqgbM3K6qj1kK
         3OktPKbP/nWK3lxhg+XiYd8nzob0FV4sFmPKy9yoTUVqpfzVAxyldeYB1e+oPL/dhjyM
         KyoO23SY8l557ShTbSTzpUmIUIeO/vqoPm7izLK8uDC1EcVx6r7dcXfYVJeAw3aA4L9f
         B6oCkCZD8uuq/48nMWQNHeDwyKMSJVcOGwXLkUoAZ1ufeRDntIrBlquX7bMbIXwV6LB2
         81KA==
X-Gm-Message-State: AOAM532+tHwZ1v3QiFid20KRfCnRGhYDQrvc2C4fwG2rSl7yiImwgH2l
        eMW8kFYyfxKA/rgV1QsoLWavqMiw8Vn/g0QT/MwTPwX7RfWDAA==
X-Google-Smtp-Source: ABdhPJzR2C/lDasHyy0vl4EdnSu5AN73cbIFQGcDQSrxIWWqZZ/AaPkfnHArL2bOCy7Css0fmoaSy49WWFciqrRxjfo=
X-Received: by 2002:a81:52c8:0:b0:2ec:8fa:ebfd with SMTP id
 g191-20020a8152c8000000b002ec08faebfdmr2704420ywb.502.1650110871130; Sat, 16
 Apr 2022 05:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220329094446.415219-1-tobetter@gmail.com> <20220329094446.415219-2-tobetter@gmail.com>
 <2a5f002f-8a61-e5b0-a574-ee99591c4c12@kernel.org>
In-Reply-To: <2a5f002f-8a61-e5b0-a574-ee99591c4c12@kernel.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sat, 16 Apr 2022 08:07:40 -0400
Message-ID: <CAMdYzYrCZtfDiB6O20Jtp56YQhHj3jMVhCt9aCYNLbD_xwFc3g@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add Hardkernel ODROID-M1 board
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Dongjin Kim <tobetter@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
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

On Tue, Mar 29, 2022 at 1:13 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 29/03/2022 11:44, Dongjin Kim wrote:
> > This patch is to add a device tree for new board Hardkernel ODROID-M1
> > based on Rockchip RK3568, includes basic peripherals -
> > uart/eMMC/uSD/i2c and on-board ethernet.
>
> I think the email got corrupted (incorrect To addresses).
>
> >
> > Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >  .../boot/dts/rockchip/rk3568-odroid-m1.dts    | 406 ++++++++++++++++++
> >  2 files changed, 407 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> > index 4ae9f35434b8..81d160221227 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -61,3 +61,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-odroid-m1.dtb
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
> > new file mode 100644
> > index 000000000000..d1a5d43127e9
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
> > @@ -0,0 +1,406 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2022 Hardkernel Co., Ltd.
> > + *
> > + */
> > +
> > +/dts-v1/;
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/leds/common.h>
> > +#include <dt-bindings/pinctrl/rockchip.h>
> > +#include "rk3568.dtsi"
> > +
> > +/ {
> > +     model = "Hardkernel ODROID-M1";
> > +     compatible = "rockchip,rk3568-odroid-m1", "rockchip,rk3568";
> > +
> > +     aliases {
> > +             ethernet0 = &gmac0;
> > +             i2c0 = &i2c3;
> > +             i2c3 = &i2c0;
> > +             mmc0 = &sdhci;
> > +             mmc1 = &sdmmc0;
> > +             serial0 = &uart1;
> > +             serial1 = &uart0;
> > +     };
> > +
> > +     chosen: chosen {
>
> No need for label.
>
> > +             stdout-path = "serial2:1500000n8";
> > +     };
> > +
> > +     dc_12v: dc-12v {
>
> Generic node name, so "regulator" or "regulator-0"

Unfortunately, this advice breaks the regulator-fixed driver, which it
seems cannot cope with a bunch of nodes all named "regulator".
Setting the regulators as regulator-0 -1 -2 leads to fun issues where
the regulator numbering in the kernel doesn't match the node numbers.
It also makes it more fun when additional regulators need to be added
and everything gets shuffled around.

If naming these uniquely to avoid confusion and collisions is such an
issue, why is it not caught by make W=1 dtbs_check?

>
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "dc_12v";
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             regulator-min-microvolt = <12000000>;
> > +             regulator-max-microvolt = <12000000>;
> > +     };
> > +
> > +     leds: leds {
>
> Label seems unused.
>
> > +             compatible = "gpio-leds";
> > +
> > +             led_power: led-0 {
> > +                     gpios = <&gpio0 RK_PC6 GPIO_ACTIVE_LOW>;
> > +                     function = LED_FUNCTION_POWER;
> > +                     color = <LED_COLOR_ID_RED>;
> > +                     linux,default-trigger = "default-on";
> > +                     pinctrl-names = "default";
> > +                     pinctrl-0 = <&led_power_en>;
> > +             };
> > +             led_work: led-1 {
> > +                     gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
> > +                     function = LED_FUNCTION_HEARTBEAT;
> > +                     color = <LED_COLOR_ID_BLUE>;
> > +                     linux,default-trigger = "heartbeat";
> > +                     pinctrl-names = "default";
> > +                     pinctrl-0 = <&led_work_en>;
> > +             };
> > +     };
> > +
> > +     vcc3v3_sys: vcc3v3-sys {
>
> Generic node name.
>
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "vcc3v3_sys";
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             regulator-min-microvolt = <3300000>;
> > +             regulator-max-microvolt = <3300000>;
> > +             vin-supply = <&dc_12v>;
> > +     };
> > +};
> > +
> > +&cpu0 {
> > +     cpu-supply = <&vdd_cpu>;
> > +};
> > +
> > +&cpu1 {
> > +     cpu-supply = <&vdd_cpu>;
> > +};
> > +
> > +&cpu2 {
> > +     cpu-supply = <&vdd_cpu>;
> > +};
> > +
> > +&cpu3 {
> > +     cpu-supply = <&vdd_cpu>;
> > +};
> > +
> > +&gmac0 {
> > +     assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
> > +     assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>;
> > +     assigned-clock-rates = <0>, <125000000>;
> > +     clock_in_out = "output";
> > +     phy-handle = <&rgmii_phy0>;
> > +     phy-mode = "rgmii";
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&gmac0_miim
> > +                  &gmac0_tx_bus2
> > +                  &gmac0_rx_bus2
> > +                  &gmac0_rgmii_clk
> > +                  &gmac0_rgmii_bus>;
> > +     status = "okay";
> > +
> > +     tx_delay = <0x4f>;
> > +     rx_delay = <0x2d>;
> > +};
> > +
> > +&i2c0 {
> > +     status = "okay";
> > +
> > +     vdd_cpu: regulator@1c {
> > +             compatible = "tcs,z`";
> > +             reg = <0x1c>;
> > +              fcs,suspend-voltage-selector = <1>;
>
> Mixed up indentation.
>
> > +              regulator-name = "vdd_cpu";
> > +              regulator-always-on;
> > +              regulator-boot-on;
> > +              regulator-min-microvolt = <800000>;
> > +              regulator-max-microvolt = <1150000>;
> > +              regulator-ramp-delay = <2300>;
> > +              vin-supply = <&vcc3v3_sys>;
> > +
> > +              regulator-state-mem {
> > +                      regulator-off-in-suspend;
> > +             };
> > +     };
> > +
> > +     rk809: pmic@20 {
> > +             compatible = "rockchip,rk809";
> > +             reg = <0x20>;
> > +             interrupt-parent = <&gpio0>;
> > +             interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
> > +             #clock-cells = <1>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pmic_int>;
> > +             rockchip,system-power-controller;
> > +             vcc1-supply = <&vcc3v3_sys>;
> > +             vcc2-supply = <&vcc3v3_sys>;
> > +             vcc3-supply = <&vcc3v3_sys>;
> > +             vcc4-supply = <&vcc3v3_sys>;
> > +             vcc5-supply = <&vcc3v3_sys>;
> > +             vcc6-supply = <&vcc3v3_sys>;
> > +             vcc7-supply = <&vcc3v3_sys>;
> > +             vcc8-supply = <&vcc3v3_sys>;
> > +             vcc9-supply = <&vcc3v3_sys>;
> > +             wakeup-source;
> > +
> > +             regulators {
> > +                     vdd_logic: DCDC_REG1 {
>
> No underscores in node names, unless anything requires it.
>
> > +                             regulator-name = "vdd_logic";
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-init-microvolt = <900000>;
> > +                             regulator-initial-mode = <0x2>;
> > +                             regulator-min-microvolt = <500000>;
> > +                             regulator-max-microvolt = <1350000>;
> > +                             regulator-ramp-delay = <6001>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vdd_gpu: DCDC_REG2 {
> > +                             regulator-name = "vdd_gpu";
> > +                             regulator-init-microvolt = <900000>;
> > +                             regulator-initial-mode = <0x2>;
> > +                             regulator-min-microvolt = <500000>;
> > +                             regulator-max-microvolt = <1350000>;
> > +                             regulator-ramp-delay = <6001>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vcc_ddr: DCDC_REG3 {
> > +                             regulator-name = "vcc_ddr";
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-initial-mode = <0x2>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-on-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vdd_npu: DCDC_REG4 {
> > +                             regulator-name = "vdd_npu";
> > +                             regulator-init-microvolt = <900000>;
> > +                             regulator-initial-mode = <0x2>;
> > +                             regulator-min-microvolt = <500000>;
> > +                             regulator-max-microvolt = <1350000>;
> > +                             regulator-ramp-delay = <6001>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vcc_1v8: DCDC_REG5 {
> > +                             regulator-name = "vcc_1v8";
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-min-microvolt = <1800000>;
> > +                             regulator-max-microvolt = <1800000>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vdda0v9_image: LDO_REG1 {
> > +                             regulator-name = "vdda0v9_image";
> > +                             regulator-min-microvolt = <900000>;
> > +                             regulator-max-microvolt = <900000>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vdda_0v9: LDO_REG2 {
> > +                             regulator-name = "vdda_0v9";
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-min-microvolt = <900000>;
> > +                             regulator-max-microvolt = <900000>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vdda0v9_pmu: LDO_REG3 {
> > +                             regulator-name = "vdda0v9_pmu";
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-min-microvolt = <900000>;
> > +                             regulator-max-microvolt = <900000>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-on-in-suspend;
> > +                                     regulator-suspend-microvolt = <900000>;
> > +                             };
> > +                     };
> > +
> > +                     vccio_acodec: LDO_REG4 {
> > +                             regulator-name = "vccio_acodec";
> > +                             regulator-min-microvolt = <3300000>;
> > +                             regulator-max-microvolt = <3300000>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vccio_sd: LDO_REG5 {
> > +                             regulator-name = "vccio_sd";
> > +                             regulator-min-microvolt = <1800000>;
> > +                             regulator-max-microvolt = <3300000>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vcc3v3_pmu: LDO_REG6 {
> > +                             regulator-name = "vcc3v3_pmu";
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-min-microvolt = <3300000>;
> > +                             regulator-max-microvolt = <3300000>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-on-in-suspend;
> > +                                     regulator-suspend-microvolt = <3300000>;
> > +                             };
> > +                     };
> > +
> > +                     vcca_1v8: LDO_REG7 {
> > +                             regulator-name = "vcca_1v8";
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-min-microvolt = <1800000>;
> > +                             regulator-max-microvolt = <1800000>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vcca1v8_pmu: LDO_REG8 {
> > +                             regulator-name = "vcca1v8_pmu";
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-min-microvolt = <1800000>;
> > +                             regulator-max-microvolt = <1800000>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-on-in-suspend;
> > +                                     regulator-suspend-microvolt = <1800000>;
> > +                             };
> > +                     };
> > +
> > +                     vcca1v8_image: LDO_REG9 {
> > +                             regulator-name = "vcca1v8_image";
> > +                             regulator-min-microvolt = <1800000>;
> > +                             regulator-max-microvolt = <1800000>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vcc_3v3: SWITCH_REG1 {
> > +                             regulator-name = "vcc_3v3";
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vcc3v3_sd: SWITCH_REG2 {
> > +                             regulator-name = "vcc3v3_sd";
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&mdio0 {
> > +     rgmii_phy0: ethernet-phy@0 {
> > +             compatible = "ethernet-phy-ieee802.3-c22";
> > +             reg = <0x0>;
> > +             reset-assert-us = <20000>;
> > +             reset-deassert-us = <100000>;
> > +             reset-gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> > +     };
> > +};
> > +
> > +&pinctrl {
> > +     leds {
> > +             led_power_en: led_power_en {
>
> No underscores in node names. Do bindings require specific naming? I
> would expect "-grp" or "-pins" suffixes, if possible.
>
> > +                     rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> > +             };
> > +             led_work_en: led_work_en {
> > +                     rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> > +             };
> > +     };
> > +
> > +     pmic {
> > +             pmic_int: pmic_int {
> > +                     rockchip,pins =
> > +                             <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
> > +             };
> > +     };
> > +};
> > +
> > +&pmu_io_domains {
> > +     pmuio1-supply = <&vcc3v3_pmu>;
> > +     pmuio2-supply = <&vcc3v3_pmu>;
> > +     vccio1-supply = <&vccio_acodec>;
> > +     vccio2-supply = <&vcc_1v8>;
> > +     vccio3-supply = <&vccio_sd>;
> > +     vccio4-supply = <&vcc_1v8>;
> > +     vccio5-supply = <&vcc_3v3>;
> > +     vccio6-supply = <&vcc_3v3>;
> > +     vccio7-supply = <&vcc_3v3>;
> > +     status = "okay";
> > +};
> > +
> > +&saradc {
> > +     vref-supply = <&vcca_1v8>;
> > +     status = "okay";
> > +};
> > +
> > +&sdhci {
> > +     bus-width = <8>;
> > +     max-frequency = <200000000>;
> > +     non-removable;
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe &emmc_rstnout>;
> > +     status = "okay";
> > +};
> > +
> > +&sdmmc0 {
> > +     bus-width = <4>;
> > +     cap-sd-highspeed;
> > +     cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
> > +     disable-wp;
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
> > +     sd-uhs-sdr104;
> > +     vmmc-supply = <&vcc3v3_sd>;
> > +     vqmmc-supply = <&vccio_sd>;
> > +     status = "okay";
> > +};
> > +
> > +&uart2 {
> > +     status = "okay";
> > +};
>
>
> Best regards,
> Krzysztof
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

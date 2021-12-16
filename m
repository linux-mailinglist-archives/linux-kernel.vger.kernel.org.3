Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94832477CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241058AbhLPTlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241051AbhLPTlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:41:08 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9028C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:41:07 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id y22so271634uap.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eBMzzvbnFXNcf+wGmExrhUndSVjnVt2MVW8vxyHCkoE=;
        b=t/f8WwZepudO+yoQOTMyeaU1YIu2kImZeh3kJMGqZoC8TypkYCuUpqmxRYuGn4MWL/
         Oi/5o4E15PnAmZW/DZvjgj0Ht+7Ds9DorCqWnlCamiI59Hu7z8EzHYEIsXYB1+C5jMcH
         y3W6BqxE64jM3wqWlIvNxsMakwQM/pV+wsfSGE7UvqwIudNgmrxf9qz/qourxI/yAV43
         WocWccEODQA8Nt1X1HgJn9+SYZlcuNov2ZGDE0lP6A4GuZEQsE/Eoi33ub0zqANFiPIC
         9croenwdDMB9kra+5XEMoE50IvC+z+M1IsOlh3fWI3NB0bhmiAQGRpvZUX1EGGdv5BqT
         TNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eBMzzvbnFXNcf+wGmExrhUndSVjnVt2MVW8vxyHCkoE=;
        b=hqGMvY4zRZwAb7tdXVajUGH1JmjQ/DYNe5to5pB1IeaK8v7FtIEdIGz4oKrGUMaWXS
         M6zEYI5L1k0o8cO5THiEVXuSfAvYAhK8uv4zuDNP5a79DA2SY5ubvQ3FA8GmIXorD5yC
         70pajwiSeThcEoUq3noom+9gB9X+M4PaXzKg3rdPLqNbfInGMUC6sWHnHi42qcEeD2G/
         +W1GsYusXTNGCjf/h6QwyNzgmkwBQeMRZK69vDEcnDVnWCJtLxhukmQyIyE/lvYg8C8H
         WzrCJJcPWPcPLYCPZoE+QgnW+WxQDr/JEEhe/uw983YV2mYRZmxZ6SzoPJ80SRh5IcLk
         gYHQ==
X-Gm-Message-State: AOAM531Vx5sLPTfdPQ7DXBZ7rkU+HeG9FSMpKk8ORVRJfOLuanEObLMD
        aWgi4Vj1rug9B6uhj4I7tc6brrqwNDbzFtCSDTN8jw==
X-Google-Smtp-Source: ABdhPJzKy+G0pduh22fSw5Im0QC3jDXedJRBfk97unRK/DR0ygA/a+6nm9eny0/U76c6qIYE9sC6uKmxFxrE3ryuRz0=
X-Received: by 2002:a67:ae0f:: with SMTP id x15mr2524193vse.57.1639683666754;
 Thu, 16 Dec 2021 11:41:06 -0800 (PST)
MIME-Version: 1.0
References: <20211215160906.17451-1-semen.protsenko@linaro.org>
 <20211215160906.17451-7-semen.protsenko@linaro.org> <8c1dbcda-ce01-81c9-b34a-f64b6f61c868@canonical.com>
In-Reply-To: <8c1dbcda-ce01-81c9-b34a-f64b6f61c868@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 16 Dec 2021 21:40:54 +0200
Message-ID: <CAPLW+4ndeokx3WiYaK_3ooe0J+BQe8Dx7QCecA7Deowk0AdxnA@mail.gmail.com>
Subject: Re: [PATCH 6/7] arm64: dts: exynos: Add initial Exynos850 SoC support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Hao Fang <fanghao11@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 at 18:47, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 15/12/2021 17:09, Sam Protsenko wrote:
> > Samsung Exynos850 is ARMv8-based mobile-oriented SoC. This patch adds
> > initial SoC support. It's not comprehensive yet, some more devices will
> > be added later. Right now only crucial system components and most needed
> > platform devices are defined.
> >
> > Crucial features (needed to boot Linux up to shell with serial console):
> >
> >   * Octa cores (Cortex-A55), supporting PSCI v1.0
> >   * ARM architected timer (armv8-timer)
> >   * Interrupt controller (GIC-400)
> >   * Pinctrl nodes for GPIO
> >   * Serial node
> >
> > Basic platform features:
> >
> >   * Clock controller CMUs
> >   * OSCCLK clock
> >   * RTC clock
> >   * MCT timer
> >   * ARM PMU (Performance Monitor Unit)
> >   * Chip-id
> >   * RTC
> >   * Reset
> >   * Watchdog timers
> >   * eMMC
> >   * I2C
> >   * HSI2C
> >   * USI
> >
> > All those features were already enabled and tested on E850-96 board with
> > minimal BusyBox rootfs.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  .../boot/dts/exynos/exynos850-pinctrl.dtsi    | 755 ++++++++++++++++++
> >  arch/arm64/boot/dts/exynos/exynos850.dtsi     | 755 ++++++++++++++++++
> >  2 files changed, 1510 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
> >  create mode 100644 arch/arm64/boot/dts/exynos/exynos850.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
> > new file mode 100644
> > index 000000000000..ba4e8d3129ac
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
> > @@ -0,0 +1,755 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Samsung's Exynos850 SoC pin-mux and pin-config device tree source
> > + *
> > + * Copyright (C) 2017 Samsung Electronics Co., Ltd.
> > + * Copyright (C) 2021 Linaro Ltd.
> > + *
> > + * Samsung's Exynos850 SoC pin-mux and pin-config options are listed as device
> > + * tree nodes in this file.
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/pinctrl/samsung.h>
> > +
> > +&pinctrl_alive {
> > +     gpa0: gpa0 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +             interrupt-parent = <&gic>;
> > +             interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> > +     };
> > +
> > +     gpa1: gpa1 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +             interrupt-parent = <&gic>;
> > +             interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> > +     };
> > +
> > +     gpa2: gpa2 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +             interrupt-parent = <&gic>;
> > +             interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> > +     };
> > +
> > +     gpa3: gpa3 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +             interrupt-parent = <&gic>;
> > +             interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> > +     };
> > +
> > +     gpa4: gpa4 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +             interrupt-parent = <&gic>;
> > +             interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> > +     };
> > +
> > +     gpq0: gpq0 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +     };
> > +
> > +     /* I2C5 (also called CAM_PMIC_I2C in TRM) */
> > +     i2c5_pins: i2c5-pins {
> > +             samsung,pins = "gpa3-5", "gpa3-6";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +     };
> > +
> > +     /* I2C6 (also called MOTOR_I2C in TRM) */
> > +     i2c6_pins: i2c6-pins {
> > +             samsung,pins = "gpa3-7", "gpa4-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +     };
> > +
> > +     /* USI: UART_DEBUG_0 pins */
> > +     uart0_pins: uart0-pins {
> > +             samsung,pins = "gpq0-0", "gpq0-1";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +     };
> > +
> > +     /* USI: UART_DEBUG_1 pins */
> > +     uart1_pins: uart1-pins {
> > +             samsung,pins = "gpa3-7", "gpa4-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +     };
> > +};
> > +
> > +&pinctrl_cmgp {
> > +     gpm0: gpm0 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +             interrupt-parent = <&gic>;
> > +             interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> > +     };
> > +
> > +     gpm1: gpm1 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +             interrupt-parent = <&gic>;
> > +             interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> > +     };
> > +
> > +     gpm2: gpm2 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +             interrupt-parent = <&gic>;
> > +             interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> > +     };
> > +
> > +     gpm3: gpm3 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +             interrupt-parent = <&gic>;
> > +             interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> > +     };
> > +
> > +     gpm4: gpm4 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +             interrupt-parent = <&gic>;
> > +             interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> > +     };
> > +
> > +     gpm5: gpm5 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +             interrupt-parent = <&gic>;
> > +             interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> > +     };
> > +
> > +     /* USI_CMGP0: HSI2C function */
> > +     hsi2c3_pins: hsi2c3-pins {
> > +             samsung,pins = "gpm0-0", "gpm1-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +     };
> > +
> > +     /* USI_CMGP0: UART function (4 pins, Auto Flow Control) */
> > +     uart1_single_pins: uart1-single-pins {
> > +             samsung,pins = "gpm0-0", "gpm1-0", "gpm2-0", "gpm3-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +     };
> > +
> > +     /* USI_CMGP0: UART function (2 pins, Non-Auto Flow Control) */
> > +     uart1_dual_pins: uart1-dual-pins {
> > +             samsung,pins = "gpm0-0", "gpm1-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +     };
> > +
> > +     /* USI_CMGP0: SPI function */
> > +     spi1_pins: spi1-pins {
> > +             samsung,pins = "gpm0-0", "gpm1-0", "gpm2-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +     };
> > +
> > +     spi1_cs_pins: spi1-cs-pins {
> > +             samsung,pins = "gpm3-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +     };
> > +
> > +     spi1_cs_func_pins: spi1-cs-func-pins {
> > +             samsung,pins = "gpm3-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>
> This is almost the same as spi1_cs_pins (just func 2) - is it going to
> be used? Do you need two different SPI CS settings?
>

Both nodes are not very useful and won't be used separately anyway. So
in v2: merged spi*_cs_func_pins nodes (Chip Select pin) into spi*_pins
nodes, and removed spi*_cs_pins nodes (GPIO configuration for SPI CS
pins).

> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +     };
> > +
> > +     /* USI_CMGP1: HSI2C function */
> > +     hsi2c4_pins: hsi2c4-pins {
> > +             samsung,pins = "gpm4-0", "gpm5-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +     };
> > +
> > +     /* USI_CMGP1: UART function (4 pins, Auto Flow Control) */
> > +     uart2_single_pins: uart2-single-pins {
> > +             samsung,pins = "gpm4-0", "gpm5-0", "gpm6-0", "gpm7-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +     };
> > +
> > +     /* USI_CMGP1: UART function (2 pins, Non-Auto Flow Control) */
> > +     uart2_dual_pins: uart2-dual-pins {
> > +             samsung,pins = "gpm4-0", "gpm5-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +     };
> > +
> > +     /* USI_CMGP1: SPI function */
> > +     spi2_pins: spi2-pins {
> > +             samsung,pins = "gpm4-0", "gpm5-0", "gpm6-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +     };
> > +
> > +     spi2_cs_pins: spi2-cs-pins {
> > +             samsung,pins = "gpm7-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +     };
> > +
> > +     spi2_cs_func_pins: spi2-cs-func-pins {
> > +             samsung,pins = "gpm7-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +     };
>
> Same question as spi1
>
> > +};
> > +
> > +&pinctrl_aud {
> > +     gpb0: gpb0 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +     };
> > +
> > +     gpb1: gpb1 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +     };
> > +
> > +     aud_codec_mclk_pins: aud-codec-mclk-pins {
> > +             samsung,pins = "gpb0-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +     };
> > +
> > +     aud_codec_mclk_idle_pins: aud-codec-mclk-idle-pins {
> > +             samsung,pins = "gpb0-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +     };
> > +
> > +     aud_i2s0_pins: aud-i2s0-pins {
> > +             samsung,pins = "gpb0-1", "gpb0-2", "gpb0-3", "gpb0-4";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +     };
> > +
> > +     aud_i2s0_idle_pins: aud-i2s0-idle-pins {
> > +             samsung,pins = "gpb0-1", "gpb0-2", "gpb0-3", "gpb0-4";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +     };
> > +
> > +     aud_i2s1_pins: aud-i2s1-pins {
> > +             samsung,pins = "gpb1-0", "gpb1-1", "gpb1-2", "gpb1-3";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +     };
> > +
> > +     aud_i2s1_idle_pins: aud-i2s1-idle-pins {
> > +             samsung,pins = "gpb1-0", "gpb1-1", "gpb1-2", "gpb1-3";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +     };
> > +
> > +     aud_fm_pins: aud-fm-pins {
> > +             samsung,pins = "gpb1-4";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +     };
> > +
> > +     aud_fm_idle_pins: aud-fm-idle-pins {
> > +             samsung,pins = "gpb1-4";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +     };
> > +};
> > +
> > +&pinctrl_hsi {
> > +     gpf2: gpf2 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +     };
> > +
> > +     sd2_clk_pins: sd2-clk-pins {
> > +             samsung,pins = "gpf2-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV2>;
> > +     };
> > +
> > +     sd2_clk_fast_slew_rate_1x_pins: sd2-clk-fast-slew-rate-1x-pins {
> > +             samsung,pins = "gpf2-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV1>;
> > +     };
> > +
> > +     sd2_clk_fast_slew_rate_1_5x_pins: sd2-clk-fast-slew-rate-1-5x-pins {
> > +             samsung,pins = "gpf2-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV1_5>;
> > +     };
> > +
> > +     sd2_clk_fast_slew_rate_2x_pins: sd2-clk-fast-slew-rate-2x-pins {
> > +             samsung,pins = "gpf2-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV2>;
> > +     };
> > +
> > +     sd2_clk_fast_slew_rate_2_5x_pins: sd2-clk-fast-slew-rate-2-5x-pins {
> > +             samsung,pins = "gpf2-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV2_5>;
> > +     };
> > +
> > +     sd2_clk_fast_slew_rate_3x_pins: sd2-clk-fast-slew-rate-3x-pins {
> > +             samsung,pins = "gpf2-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV3>;
> > +     };
> > +
> > +     sd2_clk_fast_slew_rate_4x_pins: sd2-clk-fast-slew-rate-4x-pins {
> > +             samsung,pins = "gpf2-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV4>;
> > +     };
> > +
> > +     sd2_cmd_pins: sd2-cmd-pins {
> > +             samsung,pins = "gpf2-1";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +             samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV2>;
> > +      };
> > +
> > +     sd2_bus1_pins: sd2-bus1-pins {
> > +             samsung,pins = "gpf2-2";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +             samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV2>;
> > +     };
> > +
> > +     sd2_bus4_pins: sd2-bus4-pins {
> > +             samsung,pins = "gpf2-3", "gpf2-4", "gpf2-5";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +             samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV2>;
> > +     };
> > +
> > +     sd2_pdn_pins: sd2-pdn-pins {
> > +             samsung,pins = "gpf2-0", "gpf2-1", "gpf2-2", "gpf2-3",
> > +                            "gpf2-4", "gpf2-5";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +     };
> > +};
> > +
> > +&pinctrl_core {
> > +     gpf0: gpf0 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +     };
> > +
> > +     gpf1: gpf1 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +     };
> > +
> > +     sd0_clk_pins: sd0-clk-pins {
> > +             samsung,pins = "gpf0-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
> > +     };
> > +
> > +     sd0_clk_fast_slew_rate_1x_pins: sd0-clk-fast-slew-rate-1x-pins {
> > +             samsung,pins = "gpf0-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +     };
> > +
> > +     sd0_clk_fast_slew_rate_2x_pins: sd0-clk-fast-slew-rate-2x-pins {
> > +             samsung,pins = "gpf0-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV2>;
> > +     };
> > +
> > +     sd0_clk_fast_slew_rate_3x_pins: sd0-clk-fast-slew-rate-3x-pins {
> > +             samsung,pins = "gpf0-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> > +     };
> > +
> > +     sd0_clk_fast_slew_rate_4x_pins: sd0-clk-fast-slew-rate-4x-pins {
> > +             samsung,pins = "gpf0-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
> > +     };
> > +
> > +     sd0_cmd_pins: sd0-cmd-pins {
> > +             samsung,pins = "gpf0-1";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
> > +     };
> > +
> > +     sd0_rdqs_pins: sd0-rdqs-pins {
> > +             samsung,pins = "gpf0-2";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
> > +     };
> > +
> > +     sd0_nreset_pins: sd0-nreset-pins {
> > +             samsung,pins = "gpf0-3";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
> > +     };
> > +
> > +     sd0_bus1_pins: sd0-bus1-pins {
> > +             samsung,pins = "gpf1-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
> > +     };
> > +
> > +     sd0_bus4_pins: sd0-bus4-pins {
> > +             samsung,pins = "gpf1-1", "gpf1-2", "gpf1-3";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
> > +     };
> > +
> > +     sd0_bus8_pins: sd0-bus8-pins {
> > +             samsung,pins = "gpf1-4", "gpf1-5", "gpf1-6", "gpf1-7";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
> > +     };
> > +};
> > +
> > +&pinctrl_peri {
> > +     gpg0: gpg0 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +     };
> > +
> > +     gpp0: gpp0 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +     };
> > +     gpp1: gpp1 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +     };
> > +
> > +     gpp2: gpp2 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +     };
> > +
> > +     gpg1: gpg1 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +     };
> > +
> > +     gpg2: gpg2 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +     };
> > +
> > +     gpg3: gpg3 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +     };
> > +
> > +     gpc0: gpc0 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +     };
> > +
> > +     gpc1: gpc1 {
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +     };
>
> Please order these nodes by name, so gpcX, gpgX and gppX.
>

That order follows TRM, but ok, I don't mind.

> > +
> > +     sensor_mclk0_in_pins: sensor-mclk0-in-pins {
> > +             samsung,pins = "gpc0-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> > +     };
> > +
> > +     sensor_mclk0_out_pins: sensor-mclk0-out-pins {
> > +             samsung,pins = "gpc0-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> > +     };
> > +
> > +     sensor_mclk0_fn_pins: sensor-mclk0-fn-pins {
> > +             samsung,pins = "gpc0-0";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> > +     };
> > +
> > +     sensor_mclk1_in_pins: sensor-mclk1-in-pins {
> > +             samsung,pins = "gpc0-1";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> > +     };
> > +
> > +     sensor_mclk1_out_pins: sensor-mclk1-out-pins {
> > +             samsung,pins = "gpc0-1";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> > +     };
> > +
> > +     sensor_mclk1_fn_pins: sensor-mclk1-fn-pins {
> > +             samsung,pins = "gpc0-1";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> > +     };
> > +
> > +     sensor_mclk2_in_pins: sensor-mclk2-in-pins {
> > +             samsung,pins = "gpc0-2";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> > +     };
> > +
> > +     sensor_mclk2_out_pins: sensor-mclk2-out-pins {
> > +             samsung,pins = "gpc0-2";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> > +     };
> > +
> > +     sensor_mclk2_fn_pins: sensor-mclk2-fn-pins {
> > +             samsung,pins = "gpc0-2";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> > +     };
> > +
> > +     /* USI: HSI2C0 */
> > +     hsi2c0_pins: hsi2c0-pins {
> > +             samsung,pins = "gpc1-0", "gpc1-1";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +     };
> > +
> > +     /* USI: HSI2C1 */
> > +     hsi2c1_pins: hsi2c1-pins {
> > +             samsung,pins = "gpc1-2", "gpc1-3";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +     };
> > +
> > +     /* USI: HSI2C2 */
> > +     hsi2c2_pins: hsi2c2-pins {
> > +             samsung,pins = "gpc1-4", "gpc1-5";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +     };
> > +
> > +     /* USI: SPI */
> > +     spi0_pins: spi0-pins {
> > +             samsung,pins = "gpp2-0", "gpp2-2", "gpp2-3";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +     };
> > +
> > +     spi0_cs_pins: spi0-cs-pins {
> > +             samsung,pins = "gpp2-1";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +     };
> > +
> > +     spi0_cs_func_pins: spi0-cs-func-pins {
> > +             samsung,pins = "gpp2-1";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>
> Same question as other SPI.
>
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +     };
> > +
> > +     i2c0_pins: i2c0-pins {
> > +             samsung,pins = "gpp0-0", "gpp0-1";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +     };
> > +
> > +     i2c1_pins: i2c1-pins {
> > +             samsung,pins = "gpp0-2", "gpp0-3";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +     };
> > +
> > +     i2c2_pins: i2c2-pins {
> > +             samsung,pins = "gpp0-4", "gpp0-5";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +     };
> > +
> > +     i2c3_pins: i2c3-pins {
> > +             samsung,pins = "gpp1-0", "gpp1-1";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +     };
> > +
> > +     i2c4_pins: i2c4-pins {
> > +             samsung,pins = "gpp1-2", "gpp1-3";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +             samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +     };
> > +
> > +     xclkout_pins: xclkout-pins {
> > +             samsung,pins = "gpq0-2";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +     };
> > +};
> > diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> > new file mode 100644
> > index 000000000000..1600621f68ba
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> > @@ -0,0 +1,755 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Samsung Exynos850 SoC device tree source
> > + *
> > + * Copyright (C) 2018 Samsung Electronics Co., Ltd.
> > + * Copyright (C) 2021 Linaro Ltd.
> > + *
> > + * Samsung Exynos850 SoC device nodes are listed in this file.
> > + * Exynos850 based board files can include this file and provide
> > + * values for board specific bindings.
> > + */
> > +
> > +#include <dt-bindings/clock/exynos850.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/soc/samsung,exynos-usi.h>
> > +
> > +/ {
> > +     /* Also known under engineering name Exynos3830 */
> > +     compatible = "samsung,exynos850";
> > +     #address-cells = <2>;
> > +     #size-cells = <1>;
> > +
> > +     interrupt-parent = <&gic>;
> > +
> > +     aliases {
> > +             pinctrl0 = &pinctrl_alive;
> > +             pinctrl1 = &pinctrl_cmgp;
> > +             pinctrl2 = &pinctrl_aud;
> > +             pinctrl3 = &pinctrl_hsi;
> > +             pinctrl4 = &pinctrl_core;
> > +             pinctrl5 = &pinctrl_peri;
> > +             mmc0 = &mmc_0;
> > +             usi0 = &usi_uart;
> > +             usi1 = &usi_hsi2c_0;
> > +             usi2 = &usi_hsi2c_1;
> > +             usi3 = &usi_hsi2c_2;
> > +             usi4 = &usi_spi_0;
> > +             usi5 = &usi_cmgp0;
> > +             usi6 = &usi_cmgp1;
>
> What's the use of the USI aliases? The driver does not care about them.
>

Just a leftover, initially I used that in USI driver. Was keeping
those to have some explicit boot order. But yeah, it's not needed now,
will remove in v2.

> > +             serial0 = &serial_0;
> > +             serial1 = &serial_1;
> > +             serial2 = &serial_2;
> > +             i2c0 = &i2c_0;
> > +             i2c1 = &i2c_1;
> > +             i2c2 = &i2c_2;
> > +             i2c3 = &i2c_3;
> > +             i2c4 = &i2c_4;
> > +             i2c5 = &i2c_5;
> > +             i2c6 = &i2c_6;
> > +             i2c7 = &hsi2c_0;
> > +             i2c8 = &hsi2c_1;
> > +             i2c9 = &hsi2c_2;
> > +             i2c10 = &hsi2c_3;
> > +             i2c11 = &hsi2c_4;
> > +     };
> > +
> > +     arm-pmu {
> > +             compatible = "arm,cortex-a55-pmu";
> > +             interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
> > +             interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>,
> > +                                  <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
> > +     };
> > +
> > +     /* Main system clock (XTCXO); external, must be 26 MHz */
> > +     oscclk: clock-oscclk {
> > +             compatible = "fixed-clock";
> > +             clock-output-names = "oscclk";
> > +             #clock-cells = <0>;
> > +     };
> > +
> > +     /* RTC clock (XrtcXTI); external, must be 32.768 kHz */
>
> This clock is usually provided by PMIC, so instead I expect updating
> s2mps11-clk driver. It's not correct to mock it with fixed-clock, but in
> some cases might be needed. Then I would need an explanation and maybe a
> TODO note.
>
> I wonder if we already discussed this...
>

Don't really remember discussing that. That's actually something new
for me :) I was planning to add PMIC support as a part of separate
activity later, it might not be so easy: S2MPU12 uses I3C connection.
And RTC clock is not handled even in downstream kernel. So I'll have
to implement that by PMIC datasheet. I'll keep some TODO comment for
now, hope it's ok with you?

> > +     rtcclk: clock-rtcclk {> +               compatible = "fixed-clock";
> > +             clock-output-names = "rtcclk";
> > +             #clock-cells = <0>;
> > +     };
> > +
> > +     cpus {
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +
> > +             cpu-map {
> > +                     cluster0 {
> > +                             core0 {
> > +                                     cpu = <&cpu0>;
> > +                             };
> > +                             core1 {
> > +                                     cpu = <&cpu1>;
> > +                             };
> > +                             core2 {
> > +                                     cpu = <&cpu2>;
> > +                             };
> > +                             core3 {
> > +                                     cpu = <&cpu3>;
> > +                             };
> > +                     };
> > +
> > +                     cluster1 {
> > +                             core0 {
> > +                                     cpu = <&cpu4>;
> > +                             };
> > +                             core1 {
> > +                                     cpu = <&cpu5>;
> > +                             };
> > +                             core2 {
> > +                                     cpu = <&cpu6>;
> > +                             };
> > +                             core3 {
> > +                                     cpu = <&cpu7>;
> > +                             };
> > +                     };
> > +             };
> > +
> > +             cpu0: cpu@0 {
> > +                     device_type = "cpu";
> > +                     compatible = "arm,cortex-a55";
> > +                     reg = <0x0>;
> > +                     enable-method = "psci";
> > +             };
> > +             cpu1: cpu@1 {
> > +                     device_type = "cpu";
> > +                     compatible = "arm,cortex-a55";
> > +                     reg = <0x1>;
> > +                     enable-method = "psci";
> > +             };
> > +             cpu2: cpu@2 {
> > +                     device_type = "cpu";
> > +                     compatible = "arm,cortex-a55";
> > +                     reg = <0x2>;
> > +                     enable-method = "psci";
> > +             };
> > +             cpu3: cpu@3 {
> > +                     device_type = "cpu";
> > +                     compatible = "arm,cortex-a55";
> > +                     reg = <0x3>;
> > +                     enable-method = "psci";
> > +             };
> > +             cpu4: cpu@100 {
> > +                     device_type = "cpu";
> > +                     compatible = "arm,cortex-a55";
> > +                     reg = <0x100>;
> > +                     enable-method = "psci";
> > +             };
> > +             cpu5: cpu@101 {
> > +                     device_type = "cpu";
> > +                     compatible = "arm,cortex-a55";
> > +                     reg = <0x101>;
> > +                     enable-method = "psci";
> > +             };
> > +             cpu6: cpu@102 {
> > +                     device_type = "cpu";
> > +                     compatible = "arm,cortex-a55";
> > +                     reg = <0x102>;
> > +                     enable-method = "psci";
> > +             };
> > +             cpu7: cpu@103 {
> > +                     device_type = "cpu";
> > +                     compatible = "arm,cortex-a55";
> > +                     reg = <0x103>;
> > +                     enable-method = "psci";
> > +             };
> > +     };
> > +
> > +     psci {
> > +             compatible = "arm,psci-1.0";
> > +             method = "smc";
> > +     };
> > +
> > +     timer {
> > +             compatible = "arm,armv8-timer";
> > +             /* Hypervisor Virtual Timer interrupt is not wired to GIC */
> > +             interrupts =
> > +                  <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> > +                  <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> > +                  <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> > +                  <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> > +     };
> > +
> > +     soc: soc@0 {
> > +             compatible = "simple-bus";
> > +             #address-cells = <1>;
> > +             #size-cells = <1>;
> > +             ranges = <0x0 0x0 0x0 0x20000000>;
> > +
> > +             chipid@10000000 {
> > +                     compatible = "samsung,exynos850-chipid";
> > +                     reg = <0x10000000 0x100>;
> > +             };
> > +
> > +             timer@10040000 {
> > +                     compatible = "samsung,exynos4210-mct";
> > +                     reg = <0x10040000 0x800>;
> > +                     interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&oscclk>, <&cmu_peri CLK_GOUT_MCT_PCLK>;
> > +                     clock-names = "fin_pll", "mct";
> > +             };
> > +
> > +             gic: interrupt-controller@12a01000 {
> > +                     compatible = "arm,gic-400";
> > +                     #interrupt-cells = <3>;
> > +                     #address-cells = <0>;
> > +                     reg = <0x12a01000 0x1000>,
> > +                           <0x12a02000 0x2000>,
> > +                           <0x12a04000 0x2000>,
> > +                           <0x12a06000 0x2000>;
> > +                     interrupt-controller;
> > +                     interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) |
> > +                                              IRQ_TYPE_LEVEL_HIGH)>;
> > +             };
> > +
> > +             pmu_system_controller: system-controller@11860000 {
> > +                     compatible = "samsung,exynos850-pmu", "syscon";
> > +                     reg = <0x11860000 0x10000>;
> > +                     clocks = <&cmu_apm CLK_GOUT_PMU_ALIVE_PCLK>;
> > +
> > +                     reboot: syscon-reboot {
> > +                             compatible = "syscon-reboot";
> > +                             regmap = <&pmu_system_controller>;
> > +                             offset = <0x3a00>; /* SYSTEM_CONFIGURATION */
> > +                             mask = <0x2>; /* SWRESET_SYSTEM */
> > +                             value = <0x2>; /* reset value */
> > +                     };
> > +             };
> > +
> > +             watchdog_cl0: watchdog@10050000 {
> > +                     compatible = "samsung,exynos850-wdt";
> > +                     reg = <0x10050000 0x100>;
> > +                     interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&cmu_peri CLK_GOUT_WDT0_PCLK>, <&oscclk>;
> > +                     clock-names = "watchdog", "watchdog_src";
> > +                     samsung,syscon-phandle = <&pmu_system_controller>;
> > +                     samsung,cluster-index = <0>;
> > +                     status = "disabled";
> > +             };
> > +
> > +             watchdog_cl1: watchdog@10060000 {
> > +                     compatible = "samsung,exynos850-wdt";
> > +                     reg = <0x10060000 0x100>;
> > +                     interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&cmu_peri CLK_GOUT_WDT1_PCLK>, <&oscclk>;
> > +                     clock-names = "watchdog", "watchdog_src";
> > +                     samsung,syscon-phandle = <&pmu_system_controller>;
> > +                     samsung,cluster-index = <1>;
> > +                     status = "disabled";
> > +             };
> > +
> > +             cmu_top: clock-controller@120e0000 {
> > +                     compatible = "samsung,exynos850-cmu-top";
> > +                     reg = <0x120e0000 0x8000>;
> > +                     #clock-cells = <1>;
> > +
> > +                     clocks = <&oscclk>;
> > +                     clock-names = "oscclk";
> > +             };
> > +
> > +             cmu_apm: clock-controller@11800000 {
> > +                     compatible = "samsung,exynos850-cmu-apm";
> > +                     reg = <0x11800000 0x8000>;
> > +                     #clock-cells = <1>;
> > +
> > +                     clocks = <&oscclk>, <&cmu_top CLK_DOUT_CLKCMU_APM_BUS>;
> > +                     clock-names = "oscclk", "dout_clkcmu_apm_bus";
> > +             };
> > +
> > +             cmu_cmgp: clock-controller@11c00000 {
> > +                     compatible = "samsung,exynos850-cmu-cmgp";
> > +                     reg = <0x11c00000 0x8000>;
> > +                     #clock-cells = <1>;
> > +
> > +                     clocks = <&oscclk>, <&cmu_apm CLK_GOUT_CLKCMU_CMGP_BUS>;
> > +                     clock-names = "oscclk", "gout_clkcmu_cmgp_bus";
> > +             };
> > +
> > +             cmu_core: clock-controller@12000000 {
> > +                     compatible = "samsung,exynos850-cmu-core";
> > +                     reg = <0x12000000 0x8000>;
> > +                     #clock-cells = <1>;
> > +
> > +                     clocks = <&oscclk>, <&cmu_top CLK_DOUT_CORE_BUS>,
> > +                              <&cmu_top CLK_DOUT_CORE_CCI>,
> > +                              <&cmu_top CLK_DOUT_CORE_MMC_EMBD>,
> > +                              <&cmu_top CLK_DOUT_CORE_SSS>;
> > +                     clock-names = "oscclk", "dout_core_bus",
> > +                                   "dout_core_cci", "dout_core_mmc_embd",
> > +                                   "dout_core_sss";
> > +             };
> > +
> > +             cmu_dpu: clock-controller@13000000 {
> > +                     compatible = "samsung,exynos850-cmu-dpu";
> > +                     reg = <0x13000000 0x8000>;
> > +                     #clock-cells = <1>;
> > +
> > +                     clocks = <&oscclk>, <&cmu_top CLK_DOUT_DPU>;
> > +                     clock-names = "oscclk", "dout_dpu";
> > +             };
> > +
> > +             cmu_hsi: clock-controller@13400000 {
> > +                     compatible = "samsung,exynos850-cmu-hsi";
> > +                     reg = <0x13400000 0x8000>;
> > +                     #clock-cells = <1>;
> > +
> > +                     clocks = <&oscclk>, <&rtcclk>,
> > +                              <&cmu_top CLK_DOUT_HSI_BUS>,
> > +                              <&cmu_top CLK_DOUT_HSI_MMC_CARD>,
> > +                              <&cmu_top CLK_DOUT_HSI_USB20DRD>;
> > +                     clock-names = "oscclk", "rtcclk", "dout_hsi_bus",
> > +                                   "dout_hsi_mmc_card", "dout_hsi_usb20drd";
> > +             };
> > +
> > +             cmu_peri: clock-controller@10030000 {
> > +                     compatible = "samsung,exynos850-cmu-peri";
> > +                     reg = <0x10030000 0x8000>;
> > +                     #clock-cells = <1>;
> > +
> > +                     clocks = <&oscclk>, <&cmu_top CLK_DOUT_PERI_BUS>,
> > +                              <&cmu_top CLK_DOUT_PERI_UART>,
> > +                              <&cmu_top CLK_DOUT_PERI_IP>;
> > +                     clock-names = "oscclk", "dout_peri_bus",
> > +                                   "dout_peri_uart", "dout_peri_ip";
> > +             };
>
> Please order all CMUs against each other by unit address. The same for
> pinctrl nodes below. Similar discussion as we had for Exynos7885 -
> hierarchical ordering is subjective and not always obvious.
>

Done.

> > +
> > +             pinctrl_alive: pinctrl@11850000 {
> > +                     compatible = "samsung,exynos850-pinctrl";
> > +                     reg = <0x11850000 0x1000>;
> > +                     interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +                     wakeup-interrupt-controller {
> > +                             compatible = "samsung,exynos7-wakeup-eint";
> > +                     };
> > +             };
> > +
> > +             pinctrl_cmgp: pinctrl@11c30000 {
> > +                     compatible = "samsung,exynos850-pinctrl";
> > +                     reg = <0x11c30000 0x1000>;
> > +                     interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +                     wakeup-interrupt-controller {
> > +                             compatible = "samsung,exynos7-wakeup-eint";
> > +                     };
> > +             };
>
> Best regards,
> Krzysztof

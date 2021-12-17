Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933C64790AB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbhLQPyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237566AbhLQPyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:54:53 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15125C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 07:54:53 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id p2so5098911uad.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 07:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nS2x2gqlG+bhPprzA0z5qM3MBjo1SUOX64D/HwGO8bk=;
        b=sNLhBpw1G/gomyJsouqw4hnm787p5poCn0czKaaVvBFCHuiT+JfQ7RuFPUQBR/NbNT
         aBt5XceY04HkDZOI6cc04RMmcYozHdluXC2dJzVzez9mIbQ48YRm4SByTyGCryuQBMLb
         0rii2/NHFfDtHJbSYYeccJEVbxMWwyvDRLLKEpLlnPWHDChxRZbKJwQiSCB8DyqeN82D
         FxzQ+biYoGnlCt27ypMHpovvGxnWFjo+SaZqskzvU3UG93dwXg6feTKbhikMrMEfLYsT
         jK/C5kdHuqJ4wD9UL6LtURxwsJMpEucN5Mo7KSnBC1u3FeS87ULkgGQz1mbOFi2J3DE8
         6AZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nS2x2gqlG+bhPprzA0z5qM3MBjo1SUOX64D/HwGO8bk=;
        b=RzBAFTqcCPGg/rX2kzsE1iAU1ahkTLDe3CgyVl28gTM3/SZS0yc9WSayxhkrYLzrRh
         G1KaemiQ+9ibYfWjaLsfOo5NDy7oy7VVXQMe0Xyrq0FrooJV1C43mf2jEIYQeybrZrxW
         dUW7Fcx+Hwj5dJGVjFxhdYsvXIdPVEesqpqGkcrgU5WmWlBMtEnEBxD/YpKhKgXy/bYh
         0Z8u+H80h7cQVXlNmK83TkYiHD3Bs5XDZnl5DRfHnU2b0i4dXlUarV4wnQmgYSWWsvhu
         5+T3zy3cJIRMqPN5Xa+eXnAZ4M/MjcFEp3DVnQm28Rjp51I4u7IYu5e0vyrGdXcTeljt
         zyiA==
X-Gm-Message-State: AOAM532UVCV5oDyFhXPQAVsC9gu9olPSJQ4EI/7gN1A0ymHMgrNZMM5e
        mM01oJBOyqiby5hIhdEQRag0xyAcb7Gcw0kZNGatQg==
X-Google-Smtp-Source: ABdhPJy6BCcjq4hY9r2oMWK8K6ZhdePsTsW1+4RdzD5TMRVWHTXl7km5G1usrqIzmvsPjYSp85r41P8iEK/3JX4M7nQ=
X-Received: by 2002:a67:d31c:: with SMTP id a28mr1265245vsj.20.1639756492152;
 Fri, 17 Dec 2021 07:54:52 -0800 (PST)
MIME-Version: 1.0
References: <20211215160906.17451-1-semen.protsenko@linaro.org>
 <CGME20211215160918epcas2p1d7063cfe3abca5fcc0ccf4eee388c396@epcas2p1.samsung.com>
 <20211215160906.17451-7-semen.protsenko@linaro.org> <001101d7f2f4$119b9570$34d2c050$@samsung.com>
In-Reply-To: <001101d7f2f4$119b9570$34d2c050$@samsung.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 17 Dec 2021 17:54:39 +0200
Message-ID: <CAPLW+4=85JKS9a7v1eNitYguDp_KpUK32F9b7-9jY0grpdA5tg@mail.gmail.com>
Subject: Re: [PATCH 6/7] arm64: dts: exynos: Add initial Exynos850 SoC support
To:     Chanho Park <chanho61.park@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
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

On Fri, 17 Dec 2021 at 05:13, Chanho Park <chanho61.park@samsung.com> wrote:
>
> Hi,
>
> > -----Original Message-----
> > From: Sam Protsenko <semen.protsenko@linaro.org>
> > Sent: Thursday, December 16, 2021 1:09 AM
> > To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>; Rob Herring
> > <robh+dt@kernel.org>; Sylwester Nawrocki <s.nawrocki@samsung.com>
> > Cc: Jaewon Kim <jaewon02.kim@samsung.com>; Chanho Park
> > <chanho61.park@samsung.com>; David Virag <virag.david003@gmail.com>;
> > Youngmin Nam <youngmin.nam@samsung.com>; Tomasz Figa
> > <tomasz.figa@gmail.com>; Chanwoo Choi <cw00.choi@samsung.com>; Michael
> > Turquette <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>;
> > Linus Walleij <linus.walleij@linaro.org>; Daniel Palmer <daniel@0x0f.com>;
> > Hao Fang <fanghao11@huawei.com>; linux-arm-kernel@lists.infradead.org;
> > linux-samsung-soc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-clk@vger.kernel.org
> > Subject: [PATCH 6/7] arm64: dts: exynos: Add initial Exynos850 SoC support
> >
> > Samsung Exynos850 is ARMv8-based mobile-oriented SoC. This patch adds
> > initial SoC support. It's not comprehensive yet, some more devices will be
> > added later. Right now only crucial system components and most needed
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
> > diff --git a/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
> > b/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
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
> > + * Samsung's Exynos850 SoC pin-mux and pin-config options are listed as
> > +device
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
> > +     sd2_clk_fast_slew_rate_1_5x_pins: sd2-clk-fast-slew-rate-1-5x-pins
> > {
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
> > +     sd2_clk_fast_slew_rate_2_5x_pins: sd2-clk-fast-slew-rate-2-5x-pins
> > {
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
>
> All the flew_rate_XX pins are necessary to be defined? They might be
> required by board dts files and it's convenient to use them but I don't
> think they should be pre-defined. We can override the sd2_clk_pins like
> below in a board dts file.
>
> &sd2_clk_pins {
>         samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV4>;
>

Thanks for the suggestion! Will remove slew_rate pins in v4.

> Otherwise, looks good to me.
>
> Reviewed-by: Chanho Park <chanho61.park@samsung.com>
>
> Best Regards,
> Chanho Park
>

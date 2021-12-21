Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15BA47C184
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbhLUObP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhLUObO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:31:14 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F304EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 06:31:13 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id r15so24045033uao.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 06:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wuiEnMUhpOjJtmkN8GeWCCQNEhD9bfNNbzC7jhOwm+Q=;
        b=DtmabCw+A0GfA6JfFWgYKq2j55LUhmZFldHIV7TqzUxhfjF0Iui2GEty75OsZ+Sp0c
         z9ceASJzX2jJVjtYkjAfRWPT97XzTOX7uFz5QwlHuwGD2xj1XU7X11cxUuAt+eS87b6a
         JRlF3L65LnXSz+BaBtdBa6MFLJuKfVrXHFi5hLynPDbNjXt0+zy4VkbsbwnSA17p8py/
         cSxd16+RhJ2purWJKhKjp3CzSTLJeN7QXmP9wCFO7VeWEkumrc9+dVZ1TzmybtgIFHji
         AtsC7FBU4qtERImhzpEcoLbKWYOT6VMk8/wAtzi8zK1EAXzP103CQx4MkPAar5J1HhPE
         dCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wuiEnMUhpOjJtmkN8GeWCCQNEhD9bfNNbzC7jhOwm+Q=;
        b=hUG+8zdBWpvvoHBZBHpga5qtTpXQD4azADY6QlV7emNgAqaPf0Snue5nWvujSfDOmo
         NyCEnqhSGpMt9k6ci7E1gog5C/KUgZRkyQZX2uGJUpASR+Zaiw/HVjNPSAyo9piztmmm
         MS1IjgyIOGFteu62ekMr5Z8goKaFJG9AvnV0FWdxQAsm/cyBBnmSiVFIiiHwGB4YbWve
         USpXhM3oer+cC6TGUHt+kpBo1RcmDeuNT2L9Fkweub+stTTspIApIJKG2vXqMWCbN+OP
         4SI4O6fz6NWltaVd2Kj0vIF0Bw3VDIKDb13fp4aQ+D5MCEtDGoG1eW5+h7ieW37RlZGX
         oNBQ==
X-Gm-Message-State: AOAM531Uq8rldML6Xv9hEheugSBwWowFl2hcMPzpvwZ2OLLryYhjALhq
        SxhD70hto/CBPaI7gfMLGw7IdGxVLwgKnqRu369OCA==
X-Google-Smtp-Source: ABdhPJy6Nn7tOxxWzJQ4wM2OC4yOxGOOe2RO8XOh9SKI67c8pf6jpLtRDp2axWsW8XtkJlYazAXY2ksYB/5ql87NUCs=
X-Received: by 2002:a67:fb8a:: with SMTP id n10mr1428882vsr.6.1640097068257;
 Tue, 21 Dec 2021 06:31:08 -0800 (PST)
MIME-Version: 1.0
References: <20211221142417.19312-1-semen.protsenko@linaro.org> <20211221142417.19312-2-semen.protsenko@linaro.org>
In-Reply-To: <20211221142417.19312-2-semen.protsenko@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 21 Dec 2021 16:30:56 +0200
Message-ID: <CAPLW+4=B2DU7SedxfKyFBDH=6ZqiJVVNCNbMH3wmVuedFk_YnQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] arm64: dts: exynos: Add initial Exynos850 SoC support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
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
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 at 16:24, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Samsung Exynos850 is ARMv8-based mobile-oriented SoC. This patch adds
> initial SoC support. It's not comprehensive yet, some more devices will
> be added later. Right now only crucial system components and most needed
> platform devices are defined.
>
> Crucial features (needed to boot Linux up to shell with serial console):
>
>   * Octa cores (Cortex-A55), supporting PSCI v1.0
>   * ARM architected timer (armv8-timer)
>   * Interrupt controller (GIC-400)
>   * Pinctrl nodes for GPIO
>   * Serial node
>
> Basic platform features:
>
>   * Clock controller CMUs
>   * OSCCLK clock
>   * MCT timer
>   * ARM PMU (Performance Monitor Unit)
>   * Chip-id
>   * RTC
>   * Reset
>   * Watchdog timers
>   * eMMC
>   * I2C
>   * HSI2C
>   * USI
>
> All those features were already enabled and tested on E850-96 board with
> minimal BusyBox rootfs.
>
> Reviewed-by: Chanho Park <chanho61.park@samsung.com>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v5:
>   - Defined clock binding constants in SoC DTSI file to workaround the
>     missing patches in Krzysztof's tree
>
> Changes in v4:
>   - Removed fast slew rate nodes from pinctrl dtsi
>   - Added R-b tag by Chanho Park
>   - Moved "rtcclk" clock to board dts file
>     - Specified "rtc_src" clock for rtc node in board dts file
>     - Specified "rtcclk" clock for cmu_hsi node in board dts file
>
> Changes in v3:
>   - (none)
>
> Changes in v2:
>   - Merged spi*_cs_func_pins nodes (Chip Select pin) into spi*_pins
>     nodes
>   - Removed spi*_cs_pins nodes (GPIO configuration for SPI CS pins)
>   - Sorted pinctrl_peri "pins" nodes  by name
>   - Removed USI aliases
>   - Added TODO comment for RTC clock (needs to be implemented in PMIC)
>   - Sorted cmu nodes by unit address
>   - Sorted pinctrl nodes by unit address
>
>  .../boot/dts/exynos/exynos850-pinctrl.dtsi    | 643 +++++++++++++++
>  arch/arm64/boot/dts/exynos/exynos850.dtsi     | 759 ++++++++++++++++++
>  2 files changed, 1402 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos850.dtsi
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
> new file mode 100644
> index 000000000000..f576b29c9b16
> --- /dev/null
> +++ b/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
> @@ -0,0 +1,643 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung's Exynos850 SoC pin-mux and pin-config device tree source
> + *
> + * Copyright (C) 2017 Samsung Electronics Co., Ltd.
> + * Copyright (C) 2021 Linaro Ltd.
> + *
> + * Samsung's Exynos850 SoC pin-mux and pin-config options are listed as device
> + * tree nodes in this file.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/pinctrl/samsung.h>
> +
> +&pinctrl_alive {
> +       gpa0: gpa0 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> +       };
> +
> +       gpa1: gpa1 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +       };
> +
> +       gpa2: gpa2 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> +       };
> +
> +       gpa3: gpa3 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +       };
> +
> +       gpa4: gpa4 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +       };
> +
> +       gpq0: gpq0 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +       };
> +
> +       /* I2C5 (also called CAM_PMIC_I2C in TRM) */
> +       i2c5_pins: i2c5-pins {
> +               samsung,pins = "gpa3-5", "gpa3-6";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +       };
> +
> +       /* I2C6 (also called MOTOR_I2C in TRM) */
> +       i2c6_pins: i2c6-pins {
> +               samsung,pins = "gpa3-7", "gpa4-0";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +       };
> +
> +       /* USI: UART_DEBUG_0 pins */
> +       uart0_pins: uart0-pins {
> +               samsung,pins = "gpq0-0", "gpq0-1";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +       };
> +
> +       /* USI: UART_DEBUG_1 pins */
> +       uart1_pins: uart1-pins {
> +               samsung,pins = "gpa3-7", "gpa4-0";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +       };
> +};
> +
> +&pinctrl_cmgp {
> +       gpm0: gpm0 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> +       };
> +
> +       gpm1: gpm1 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> +       };
> +
> +       gpm2: gpm2 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> +       };
> +
> +       gpm3: gpm3 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> +       };
> +
> +       gpm4: gpm4 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> +       };
> +
> +       gpm5: gpm5 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> +       };
> +
> +       /* USI_CMGP0: HSI2C function */
> +       hsi2c3_pins: hsi2c3-pins {
> +               samsung,pins = "gpm0-0", "gpm1-0";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +       };
> +
> +       /* USI_CMGP0: UART function (4 pins, Auto Flow Control) */
> +       uart1_single_pins: uart1-single-pins {
> +               samsung,pins = "gpm0-0", "gpm1-0", "gpm2-0", "gpm3-0";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +       };
> +
> +       /* USI_CMGP0: UART function (2 pins, Non-Auto Flow Control) */
> +       uart1_dual_pins: uart1-dual-pins {
> +               samsung,pins = "gpm0-0", "gpm1-0";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +       };
> +
> +       /* USI_CMGP0: SPI function */
> +       spi1_pins: spi1-pins {
> +               samsung,pins = "gpm0-0", "gpm1-0", "gpm2-0", "gpm3-0";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +       };
> +
> +       /* USI_CMGP1: HSI2C function */
> +       hsi2c4_pins: hsi2c4-pins {
> +               samsung,pins = "gpm4-0", "gpm5-0";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +       };
> +
> +       /* USI_CMGP1: UART function (4 pins, Auto Flow Control) */
> +       uart2_single_pins: uart2-single-pins {
> +               samsung,pins = "gpm4-0", "gpm5-0", "gpm6-0", "gpm7-0";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +       };
> +
> +       /* USI_CMGP1: UART function (2 pins, Non-Auto Flow Control) */
> +       uart2_dual_pins: uart2-dual-pins {
> +               samsung,pins = "gpm4-0", "gpm5-0";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +       };
> +
> +       /* USI_CMGP1: SPI function */
> +       spi2_pins: spi2-pins {
> +               samsung,pins = "gpm4-0", "gpm5-0", "gpm6-0", "gpm7-0";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +       };
> +};
> +
> +&pinctrl_aud {
> +       gpb0: gpb0 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +       };
> +
> +       gpb1: gpb1 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +       };
> +
> +       aud_codec_mclk_pins: aud-codec-mclk-pins {
> +               samsung,pins = "gpb0-0";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +       };
> +
> +       aud_codec_mclk_idle_pins: aud-codec-mclk-idle-pins {
> +               samsung,pins = "gpb0-0";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +       };
> +
> +       aud_i2s0_pins: aud-i2s0-pins {
> +               samsung,pins = "gpb0-1", "gpb0-2", "gpb0-3", "gpb0-4";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +       };
> +
> +       aud_i2s0_idle_pins: aud-i2s0-idle-pins {
> +               samsung,pins = "gpb0-1", "gpb0-2", "gpb0-3", "gpb0-4";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +       };
> +
> +       aud_i2s1_pins: aud-i2s1-pins {
> +               samsung,pins = "gpb1-0", "gpb1-1", "gpb1-2", "gpb1-3";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +       };
> +
> +       aud_i2s1_idle_pins: aud-i2s1-idle-pins {
> +               samsung,pins = "gpb1-0", "gpb1-1", "gpb1-2", "gpb1-3";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +       };
> +
> +       aud_fm_pins: aud-fm-pins {
> +               samsung,pins = "gpb1-4";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +       };
> +
> +       aud_fm_idle_pins: aud-fm-idle-pins {
> +               samsung,pins = "gpb1-4";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +       };
> +};
> +
> +&pinctrl_hsi {
> +       gpf2: gpf2 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +       };
> +
> +       sd2_clk_pins: sd2-clk-pins {
> +               samsung,pins = "gpf2-0";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV2>;
> +       };
> +
> +       sd2_cmd_pins: sd2-cmd-pins {
> +               samsung,pins = "gpf2-1";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV2>;
> +        };
> +
> +       sd2_bus1_pins: sd2-bus1-pins {
> +               samsung,pins = "gpf2-2";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV2>;
> +       };
> +
> +       sd2_bus4_pins: sd2-bus4-pins {
> +               samsung,pins = "gpf2-3", "gpf2-4", "gpf2-5";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV2>;
> +       };
> +
> +       sd2_pdn_pins: sd2-pdn-pins {
> +               samsung,pins = "gpf2-0", "gpf2-1", "gpf2-2", "gpf2-3",
> +                              "gpf2-4", "gpf2-5";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +       };
> +};
> +
> +&pinctrl_core {
> +       gpf0: gpf0 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +       };
> +
> +       gpf1: gpf1 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +       };
> +
> +       sd0_clk_pins: sd0-clk-pins {
> +               samsung,pins = "gpf0-0";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
> +       };
> +
> +       sd0_cmd_pins: sd0-cmd-pins {
> +               samsung,pins = "gpf0-1";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
> +       };
> +
> +       sd0_rdqs_pins: sd0-rdqs-pins {
> +               samsung,pins = "gpf0-2";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
> +       };
> +
> +       sd0_nreset_pins: sd0-nreset-pins {
> +               samsung,pins = "gpf0-3";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
> +       };
> +
> +       sd0_bus1_pins: sd0-bus1-pins {
> +               samsung,pins = "gpf1-0";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
> +       };
> +
> +       sd0_bus4_pins: sd0-bus4-pins {
> +               samsung,pins = "gpf1-1", "gpf1-2", "gpf1-3";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
> +       };
> +
> +       sd0_bus8_pins: sd0-bus8-pins {
> +               samsung,pins = "gpf1-4", "gpf1-5", "gpf1-6", "gpf1-7";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
> +       };
> +};
> +
> +&pinctrl_peri {
> +       gpc0: gpc0 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +       };
> +
> +       gpc1: gpc1 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +       };
> +
> +       gpg0: gpg0 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +       };
> +
> +       gpg1: gpg1 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +       };
> +
> +       gpg2: gpg2 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +       };
> +
> +       gpg3: gpg3 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +       };
> +
> +       gpp0: gpp0 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +       };
> +       gpp1: gpp1 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +       };
> +
> +       gpp2: gpp2 {
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +       };
> +
> +       sensor_mclk0_in_pins: sensor-mclk0-in-pins {
> +               samsung,pins = "gpc0-0";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> +       };
> +
> +       sensor_mclk0_out_pins: sensor-mclk0-out-pins {
> +               samsung,pins = "gpc0-0";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> +       };
> +
> +       sensor_mclk0_fn_pins: sensor-mclk0-fn-pins {
> +               samsung,pins = "gpc0-0";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> +       };
> +
> +       sensor_mclk1_in_pins: sensor-mclk1-in-pins {
> +               samsung,pins = "gpc0-1";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> +       };
> +
> +       sensor_mclk1_out_pins: sensor-mclk1-out-pins {
> +               samsung,pins = "gpc0-1";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> +       };
> +
> +       sensor_mclk1_fn_pins: sensor-mclk1-fn-pins {
> +               samsung,pins = "gpc0-1";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> +       };
> +
> +       sensor_mclk2_in_pins: sensor-mclk2-in-pins {
> +               samsung,pins = "gpc0-2";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> +       };
> +
> +       sensor_mclk2_out_pins: sensor-mclk2-out-pins {
> +               samsung,pins = "gpc0-2";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> +       };
> +
> +       sensor_mclk2_fn_pins: sensor-mclk2-fn-pins {
> +               samsung,pins = "gpc0-2";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> +       };
> +
> +       /* USI: HSI2C0 */
> +       hsi2c0_pins: hsi2c0-pins {
> +               samsung,pins = "gpc1-0", "gpc1-1";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +       };
> +
> +       /* USI: HSI2C1 */
> +       hsi2c1_pins: hsi2c1-pins {
> +               samsung,pins = "gpc1-2", "gpc1-3";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +       };
> +
> +       /* USI: HSI2C2 */
> +       hsi2c2_pins: hsi2c2-pins {
> +               samsung,pins = "gpc1-4", "gpc1-5";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +       };
> +
> +       /* USI: SPI */
> +       spi0_pins: spi0-pins {
> +               samsung,pins = "gpp2-0", "gpp2-1", "gpp2-2", "gpp2-3";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +       };
> +
> +       i2c0_pins: i2c0-pins {
> +               samsung,pins = "gpp0-0", "gpp0-1";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +       };
> +
> +       i2c1_pins: i2c1-pins {
> +               samsung,pins = "gpp0-2", "gpp0-3";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +       };
> +
> +       i2c2_pins: i2c2-pins {
> +               samsung,pins = "gpp0-4", "gpp0-5";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +       };
> +
> +       i2c3_pins: i2c3-pins {
> +               samsung,pins = "gpp1-0", "gpp1-1";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +       };
> +
> +       i2c4_pins: i2c4-pins {
> +               samsung,pins = "gpp1-2", "gpp1-3";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +       };
> +
> +       xclkout_pins: xclkout-pins {
> +               samsung,pins = "gpq0-2";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> new file mode 100644
> index 000000000000..2abbb972b610
> --- /dev/null
> +++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> @@ -0,0 +1,759 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung Exynos850 SoC device tree source
> + *
> + * Copyright (C) 2018 Samsung Electronics Co., Ltd.
> + * Copyright (C) 2021 Linaro Ltd.
> + *
> + * Samsung Exynos850 SoC device nodes are listed in this file.
> + * Exynos850 based board files can include this file and provide
> + * values for board specific bindings.
> + */
> +
> +#include <dt-bindings/clock/exynos850.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/soc/samsung,exynos-usi.h>
> +
> +/* TODO: Remove this once corresponding clock bindings are added */

Krzysztof,

What would be the best time for me to send the removal of this
workaround? Is it right after v5.17 release?

Thanks!

> +#ifndef CLK_GOUT_SYSREG_CMGP_PCLK
> +/* CMU_TOP */
> +#define CLK_DOUT_CLKCMU_APM_BUS                47
> +
> +/* CMU_CMGP */
> +#define CLK_GOUT_CMGP_USI0_IPCLK       11
> +#define CLK_GOUT_CMGP_USI0_PCLK                12
> +#define CLK_GOUT_CMGP_USI1_IPCLK       13
> +#define CLK_GOUT_CMGP_USI1_PCLK                14
> +#define CLK_GOUT_SYSREG_CMGP_PCLK      15
> +
> +/* CMU_APM */
> +#define CLK_GOUT_CLKCMU_CMGP_BUS       15
> +#define CLK_GOUT_RTC_PCLK              17
> +#define CLK_GOUT_PMU_ALIVE_PCLK                23
> +#endif
> +
> +/ {
> +       /* Also known under engineering name Exynos3830 */
> +       compatible = "samsung,exynos850";
> +       #address-cells = <2>;
> +       #size-cells = <1>;
> +
> +       interrupt-parent = <&gic>;
> +
> +       aliases {
> +               pinctrl0 = &pinctrl_alive;
> +               pinctrl1 = &pinctrl_cmgp;
> +               pinctrl2 = &pinctrl_aud;
> +               pinctrl3 = &pinctrl_hsi;
> +               pinctrl4 = &pinctrl_core;
> +               pinctrl5 = &pinctrl_peri;
> +               mmc0 = &mmc_0;
> +               serial0 = &serial_0;
> +               serial1 = &serial_1;
> +               serial2 = &serial_2;
> +               i2c0 = &i2c_0;
> +               i2c1 = &i2c_1;
> +               i2c2 = &i2c_2;
> +               i2c3 = &i2c_3;
> +               i2c4 = &i2c_4;
> +               i2c5 = &i2c_5;
> +               i2c6 = &i2c_6;
> +               i2c7 = &hsi2c_0;
> +               i2c8 = &hsi2c_1;
> +               i2c9 = &hsi2c_2;
> +               i2c10 = &hsi2c_3;
> +               i2c11 = &hsi2c_4;
> +       };
> +
> +       arm-pmu {
> +               compatible = "arm,cortex-a55-pmu";
> +               interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
> +               interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>,
> +                                    <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
> +       };
> +
> +       /* Main system clock (XTCXO); external, must be 26 MHz */
> +       oscclk: clock-oscclk {
> +               compatible = "fixed-clock";
> +               clock-output-names = "oscclk";
> +               #clock-cells = <0>;
> +       };
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu-map {
> +                       cluster0 {
> +                               core0 {
> +                                       cpu = <&cpu0>;
> +                               };
> +                               core1 {
> +                                       cpu = <&cpu1>;
> +                               };
> +                               core2 {
> +                                       cpu = <&cpu2>;
> +                               };
> +                               core3 {
> +                                       cpu = <&cpu3>;
> +                               };
> +                       };
> +
> +                       cluster1 {
> +                               core0 {
> +                                       cpu = <&cpu4>;
> +                               };
> +                               core1 {
> +                                       cpu = <&cpu5>;
> +                               };
> +                               core2 {
> +                                       cpu = <&cpu6>;
> +                               };
> +                               core3 {
> +                                       cpu = <&cpu7>;
> +                               };
> +                       };
> +               };
> +
> +               cpu0: cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a55";
> +                       reg = <0x0>;
> +                       enable-method = "psci";
> +               };
> +               cpu1: cpu@1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a55";
> +                       reg = <0x1>;
> +                       enable-method = "psci";
> +               };
> +               cpu2: cpu@2 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a55";
> +                       reg = <0x2>;
> +                       enable-method = "psci";
> +               };
> +               cpu3: cpu@3 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a55";
> +                       reg = <0x3>;
> +                       enable-method = "psci";
> +               };
> +               cpu4: cpu@100 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a55";
> +                       reg = <0x100>;
> +                       enable-method = "psci";
> +               };
> +               cpu5: cpu@101 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a55";
> +                       reg = <0x101>;
> +                       enable-method = "psci";
> +               };
> +               cpu6: cpu@102 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a55";
> +                       reg = <0x102>;
> +                       enable-method = "psci";
> +               };
> +               cpu7: cpu@103 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a55";
> +                       reg = <0x103>;
> +                       enable-method = "psci";
> +               };
> +       };
> +
> +       psci {
> +               compatible = "arm,psci-1.0";
> +               method = "smc";
> +       };
> +
> +       timer {
> +               compatible = "arm,armv8-timer";
> +               /* Hypervisor Virtual Timer interrupt is not wired to GIC */
> +               interrupts =
> +                    <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +                    <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +                    <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +                    <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +       };
> +
> +       soc: soc@0 {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges = <0x0 0x0 0x0 0x20000000>;
> +
> +               chipid@10000000 {
> +                       compatible = "samsung,exynos850-chipid";
> +                       reg = <0x10000000 0x100>;
> +               };
> +
> +               timer@10040000 {
> +                       compatible = "samsung,exynos4210-mct";
> +                       reg = <0x10040000 0x800>;
> +                       interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&oscclk>, <&cmu_peri CLK_GOUT_MCT_PCLK>;
> +                       clock-names = "fin_pll", "mct";
> +               };
> +
> +               gic: interrupt-controller@12a01000 {
> +                       compatible = "arm,gic-400";
> +                       #interrupt-cells = <3>;
> +                       #address-cells = <0>;
> +                       reg = <0x12a01000 0x1000>,
> +                             <0x12a02000 0x2000>,
> +                             <0x12a04000 0x2000>,
> +                             <0x12a06000 0x2000>;
> +                       interrupt-controller;
> +                       interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) |
> +                                                IRQ_TYPE_LEVEL_HIGH)>;
> +               };
> +
> +               pmu_system_controller: system-controller@11860000 {
> +                       compatible = "samsung,exynos850-pmu", "syscon";
> +                       reg = <0x11860000 0x10000>;
> +                       clocks = <&cmu_apm CLK_GOUT_PMU_ALIVE_PCLK>;
> +
> +                       reboot: syscon-reboot {
> +                               compatible = "syscon-reboot";
> +                               regmap = <&pmu_system_controller>;
> +                               offset = <0x3a00>; /* SYSTEM_CONFIGURATION */
> +                               mask = <0x2>; /* SWRESET_SYSTEM */
> +                               value = <0x2>; /* reset value */
> +                       };
> +               };
> +
> +               watchdog_cl0: watchdog@10050000 {
> +                       compatible = "samsung,exynos850-wdt";
> +                       reg = <0x10050000 0x100>;
> +                       interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cmu_peri CLK_GOUT_WDT0_PCLK>, <&oscclk>;
> +                       clock-names = "watchdog", "watchdog_src";
> +                       samsung,syscon-phandle = <&pmu_system_controller>;
> +                       samsung,cluster-index = <0>;
> +                       status = "disabled";
> +               };
> +
> +               watchdog_cl1: watchdog@10060000 {
> +                       compatible = "samsung,exynos850-wdt";
> +                       reg = <0x10060000 0x100>;
> +                       interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cmu_peri CLK_GOUT_WDT1_PCLK>, <&oscclk>;
> +                       clock-names = "watchdog", "watchdog_src";
> +                       samsung,syscon-phandle = <&pmu_system_controller>;
> +                       samsung,cluster-index = <1>;
> +                       status = "disabled";
> +               };
> +
> +               cmu_peri: clock-controller@10030000 {
> +                       compatible = "samsung,exynos850-cmu-peri";
> +                       reg = <0x10030000 0x8000>;
> +                       #clock-cells = <1>;
> +
> +                       clocks = <&oscclk>, <&cmu_top CLK_DOUT_PERI_BUS>,
> +                                <&cmu_top CLK_DOUT_PERI_UART>,
> +                                <&cmu_top CLK_DOUT_PERI_IP>;
> +                       clock-names = "oscclk", "dout_peri_bus",
> +                                     "dout_peri_uart", "dout_peri_ip";
> +               };
> +
> +               cmu_apm: clock-controller@11800000 {
> +                       compatible = "samsung,exynos850-cmu-apm";
> +                       reg = <0x11800000 0x8000>;
> +                       #clock-cells = <1>;
> +
> +                       clocks = <&oscclk>, <&cmu_top CLK_DOUT_CLKCMU_APM_BUS>;
> +                       clock-names = "oscclk", "dout_clkcmu_apm_bus";
> +               };
> +
> +               cmu_cmgp: clock-controller@11c00000 {
> +                       compatible = "samsung,exynos850-cmu-cmgp";
> +                       reg = <0x11c00000 0x8000>;
> +                       #clock-cells = <1>;
> +
> +                       clocks = <&oscclk>, <&cmu_apm CLK_GOUT_CLKCMU_CMGP_BUS>;
> +                       clock-names = "oscclk", "gout_clkcmu_cmgp_bus";
> +               };
> +
> +               cmu_core: clock-controller@12000000 {
> +                       compatible = "samsung,exynos850-cmu-core";
> +                       reg = <0x12000000 0x8000>;
> +                       #clock-cells = <1>;
> +
> +                       clocks = <&oscclk>, <&cmu_top CLK_DOUT_CORE_BUS>,
> +                                <&cmu_top CLK_DOUT_CORE_CCI>,
> +                                <&cmu_top CLK_DOUT_CORE_MMC_EMBD>,
> +                                <&cmu_top CLK_DOUT_CORE_SSS>;
> +                       clock-names = "oscclk", "dout_core_bus",
> +                                     "dout_core_cci", "dout_core_mmc_embd",
> +                                     "dout_core_sss";
> +               };
> +
> +               cmu_top: clock-controller@120e0000 {
> +                       compatible = "samsung,exynos850-cmu-top";
> +                       reg = <0x120e0000 0x8000>;
> +                       #clock-cells = <1>;
> +
> +                       clocks = <&oscclk>;
> +                       clock-names = "oscclk";
> +               };
> +
> +               cmu_dpu: clock-controller@13000000 {
> +                       compatible = "samsung,exynos850-cmu-dpu";
> +                       reg = <0x13000000 0x8000>;
> +                       #clock-cells = <1>;
> +
> +                       clocks = <&oscclk>, <&cmu_top CLK_DOUT_DPU>;
> +                       clock-names = "oscclk", "dout_dpu";
> +               };
> +
> +               cmu_hsi: clock-controller@13400000 {
> +                       compatible = "samsung,exynos850-cmu-hsi";
> +                       reg = <0x13400000 0x8000>;
> +                       #clock-cells = <1>;
> +
> +                       clocks = <&oscclk>,
> +                                <&cmu_top CLK_DOUT_HSI_BUS>,
> +                                <&cmu_top CLK_DOUT_HSI_MMC_CARD>,
> +                                <&cmu_top CLK_DOUT_HSI_USB20DRD>;
> +                       clock-names = "oscclk", "dout_hsi_bus",
> +                                     "dout_hsi_mmc_card", "dout_hsi_usb20drd";
> +               };
> +
> +               pinctrl_alive: pinctrl@11850000 {
> +                       compatible = "samsung,exynos850-pinctrl";
> +                       reg = <0x11850000 0x1000>;
> +                       interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +
> +                       wakeup-interrupt-controller {
> +                               compatible = "samsung,exynos7-wakeup-eint";
> +                       };
> +               };
> +
> +               pinctrl_cmgp: pinctrl@11c30000 {
> +                       compatible = "samsung,exynos850-pinctrl";
> +                       reg = <0x11c30000 0x1000>;
> +                       interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
> +
> +                       wakeup-interrupt-controller {
> +                               compatible = "samsung,exynos7-wakeup-eint";
> +                       };
> +               };
> +
> +               pinctrl_core: pinctrl@12070000 {
> +                       compatible = "samsung,exynos850-pinctrl";
> +                       reg = <0x12070000 0x1000>;
> +                       interrupts = <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>;
> +               };
> +
> +               pinctrl_hsi: pinctrl@13430000 {
> +                       compatible = "samsung,exynos850-pinctrl";
> +                       reg = <0x13430000 0x1000>;
> +                       interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> +               };
> +
> +               pinctrl_peri: pinctrl@139b0000 {
> +                       compatible = "samsung,exynos850-pinctrl";
> +                       reg = <0x139b0000 0x1000>;
> +                       interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
> +               };
> +
> +               pinctrl_aud: pinctrl@14a60000 {
> +                       compatible = "samsung,exynos850-pinctrl";
> +                       reg = <0x14a60000 0x1000>;
> +               };
> +
> +               rtc: rtc@11a30000 {
> +                       compatible = "samsung,s3c6410-rtc";
> +                       reg = <0x11a30000 0x100>;
> +                       interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cmu_apm CLK_GOUT_RTC_PCLK>;
> +                       clock-names = "rtc";
> +                       status = "disabled";
> +               };
> +
> +               mmc_0: mmc@12100000 {
> +                       compatible = "samsung,exynos7-dw-mshc-smu";
> +                       reg = <0x12100000 0x2000>;
> +                       interrupts = <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       clocks = <&cmu_core CLK_GOUT_MMC_EMBD_ACLK>,
> +                                <&cmu_core CLK_GOUT_MMC_EMBD_SDCLKIN>;
> +                       clock-names = "biu", "ciu";
> +                       fifo-depth = <0x40>;
> +                       status = "disabled";
> +               };
> +
> +               i2c_0: i2c@13830000 {
> +                       compatible = "samsung,s3c2440-i2c";
> +                       reg = <0x13830000 0x100>;
> +                       interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&i2c0_pins>;
> +                       clocks = <&cmu_peri CLK_GOUT_I2C0_PCLK>;
> +                       clock-names = "i2c";
> +                       status = "disabled";
> +               };
> +
> +               i2c_1: i2c@13840000 {
> +                       compatible = "samsung,s3c2440-i2c";
> +                       reg = <0x13840000 0x100>;
> +                       interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&i2c1_pins>;
> +                       clocks = <&cmu_peri CLK_GOUT_I2C1_PCLK>;
> +                       clock-names = "i2c";
> +                       status = "disabled";
> +               };
> +
> +               i2c_2: i2c@13850000 {
> +                       compatible = "samsung,s3c2440-i2c";
> +                       reg = <0x13850000 0x100>;
> +                       interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&i2c2_pins>;
> +                       clocks = <&cmu_peri CLK_GOUT_I2C2_PCLK>;
> +                       clock-names = "i2c";
> +                       status = "disabled";
> +               };
> +
> +               i2c_3: i2c@13860000 {
> +                       compatible = "samsung,s3c2440-i2c";
> +                       reg = <0x13860000 0x100>;
> +                       interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&i2c3_pins>;
> +                       clocks = <&cmu_peri CLK_GOUT_I2C3_PCLK>;
> +                       clock-names = "i2c";
> +                       status = "disabled";
> +               };
> +
> +               i2c_4: i2c@13870000 {
> +                       compatible = "samsung,s3c2440-i2c";
> +                       reg = <0x13870000 0x100>;
> +                       interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&i2c4_pins>;
> +                       clocks = <&cmu_peri CLK_GOUT_I2C4_PCLK>;
> +                       clock-names = "i2c";
> +                       status = "disabled";
> +               };
> +
> +               /* I2C_5 (also called CAM_PMIC_I2C in TRM) */
> +               i2c_5: i2c@13880000 {
> +                       compatible = "samsung,s3c2440-i2c";
> +                       reg = <0x13880000 0x100>;
> +                       interrupts = <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&i2c5_pins>;
> +                       clocks = <&cmu_peri CLK_GOUT_I2C5_PCLK>;
> +                       clock-names = "i2c";
> +                       status = "disabled";
> +               };
> +
> +               /* I2C_6 (also called MOTOR_I2C in TRM) */
> +               i2c_6: i2c@13890000 {
> +                       compatible = "samsung,s3c2440-i2c";
> +                       reg = <0x13890000 0x100>;
> +                       interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&i2c6_pins>;
> +                       clocks = <&cmu_peri CLK_GOUT_I2C6_PCLK>;
> +                       clock-names = "i2c";
> +                       status = "disabled";
> +               };
> +
> +               sysreg_peri: syscon@10020000 {
> +                       compatible = "samsung,exynos850-sysreg", "syscon";
> +                       reg = <0x10020000 0x10000>;
> +                       clocks = <&cmu_peri CLK_GOUT_SYSREG_PERI_PCLK>;
> +               };
> +
> +               sysreg_cmgp: syscon@11c20000 {
> +                       compatible = "samsung,exynos850-sysreg", "syscon";
> +                       reg = <0x11c20000 0x10000>;
> +                       clocks = <&cmu_cmgp CLK_GOUT_SYSREG_CMGP_PCLK>;
> +               };
> +
> +               usi_uart: usi@138200c0 {
> +                       compatible = "samsung,exynos850-usi";
> +                       reg = <0x138200c0 0x20>;
> +                       samsung,sysreg = <&sysreg_peri 0x1010>;
> +                       samsung,mode = <USI_V2_UART>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +                       clocks = <&cmu_peri CLK_GOUT_UART_PCLK>,
> +                                <&cmu_peri CLK_GOUT_UART_IPCLK>;
> +                       clock-names = "pclk", "ipclk";
> +                       status = "disabled";
> +
> +                       serial_0: serial@13820000 {
> +                               compatible = "samsung,exynos850-uart";
> +                               reg = <0x13820000 0xc0>;
> +                               interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&uart0_pins>;
> +                               clocks = <&cmu_peri CLK_GOUT_UART_PCLK>,
> +                                        <&cmu_peri CLK_GOUT_UART_IPCLK>;
> +                               clock-names = "uart", "clk_uart_baud0";
> +                               status = "disabled";
> +                       };
> +               };
> +
> +               usi_hsi2c_0: usi@138a00c0 {
> +                       compatible = "samsung,exynos850-usi";
> +                       reg = <0x138a00c0 0x20>;
> +                       samsung,sysreg = <&sysreg_peri 0x1020>;
> +                       samsung,mode = <USI_V2_I2C>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +                       clocks = <&cmu_peri CLK_GOUT_HSI2C0_PCLK>,
> +                                <&cmu_peri CLK_GOUT_HSI2C0_IPCLK>;
> +                       clock-names = "pclk", "ipclk";
> +                       status = "disabled";
> +
> +                       hsi2c_0: i2c@138a0000 {
> +                               compatible = "samsung,exynosautov9-hsi2c";
> +                               reg = <0x138a0000 0xc0>;
> +                               interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&hsi2c0_pins>;
> +                               clocks = <&cmu_peri CLK_GOUT_HSI2C0_IPCLK>,
> +                                        <&cmu_peri CLK_GOUT_HSI2C0_PCLK>;
> +                               clock-names = "hsi2c", "hsi2c_pclk";
> +                               status = "disabled";
> +                       };
> +               };
> +
> +               usi_hsi2c_1: usi@138b00c0 {
> +                       compatible = "samsung,exynos850-usi";
> +                       reg = <0x138b00c0 0x20>;
> +                       samsung,sysreg = <&sysreg_peri 0x1030>;
> +                       samsung,mode = <USI_V2_I2C>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +                       clocks = <&cmu_peri CLK_GOUT_HSI2C1_PCLK>,
> +                                <&cmu_peri CLK_GOUT_HSI2C1_IPCLK>;
> +                       clock-names = "pclk", "ipclk";
> +                       status = "disabled";
> +
> +                       hsi2c_1: i2c@138b0000 {
> +                               compatible = "samsung,exynosautov9-hsi2c";
> +                               reg = <0x138b0000 0xc0>;
> +                               interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&hsi2c1_pins>;
> +                               clocks = <&cmu_peri CLK_GOUT_HSI2C1_IPCLK>,
> +                                        <&cmu_peri CLK_GOUT_HSI2C1_PCLK>;
> +                               clock-names = "hsi2c", "hsi2c_pclk";
> +                               status = "disabled";
> +                       };
> +               };
> +
> +               usi_hsi2c_2: usi@138c00c0 {
> +                       compatible = "samsung,exynos850-usi";
> +                       reg = <0x138c00c0 0x20>;
> +                       samsung,sysreg = <&sysreg_peri 0x1040>;
> +                       samsung,mode = <USI_V2_I2C>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +                       clocks = <&cmu_peri CLK_GOUT_HSI2C2_PCLK>,
> +                                <&cmu_peri CLK_GOUT_HSI2C2_IPCLK>;
> +                       clock-names = "pclk", "ipclk";
> +                       status = "disabled";
> +
> +                       hsi2c_2: i2c@138c0000 {
> +                               compatible = "samsung,exynosautov9-hsi2c";
> +                               reg = <0x138c0000 0xc0>;
> +                               interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&hsi2c2_pins>;
> +                               clocks = <&cmu_peri CLK_GOUT_HSI2C2_IPCLK>,
> +                                        <&cmu_peri CLK_GOUT_HSI2C2_PCLK>;
> +                               clock-names = "hsi2c", "hsi2c_pclk";
> +                               status = "disabled";
> +                       };
> +               };
> +
> +               usi_spi_0: usi@139400c0 {
> +                       compatible = "samsung,exynos850-usi";
> +                       reg = <0x139400c0 0x20>;
> +                       samsung,sysreg = <&sysreg_peri 0x1050>;
> +                       samsung,mode = <USI_V2_SPI>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +                       clocks = <&cmu_peri CLK_GOUT_SPI0_PCLK>,
> +                                <&cmu_peri CLK_GOUT_SPI0_IPCLK>;
> +                       clock-names = "pclk", "ipclk";
> +                       status = "disabled";
> +               };
> +
> +               usi_cmgp0: usi@11d000c0 {
> +                       compatible = "samsung,exynos850-usi";
> +                       reg = <0x11d000c0 0x20>;
> +                       samsung,sysreg = <&sysreg_cmgp 0x2000>;
> +                       samsung,mode = <USI_V2_I2C>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +                       clocks = <&cmu_cmgp CLK_GOUT_CMGP_USI0_PCLK>,
> +                                <&cmu_cmgp CLK_GOUT_CMGP_USI0_IPCLK>;
> +                       clock-names = "pclk", "ipclk";
> +                       status = "disabled";
> +
> +                       hsi2c_3: i2c@11d00000 {
> +                               compatible = "samsung,exynosautov9-hsi2c";
> +                               reg = <0x11d00000 0xc0>;
> +                               interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&hsi2c3_pins>;
> +                               clocks = <&cmu_cmgp CLK_GOUT_CMGP_USI0_IPCLK>,
> +                                        <&cmu_cmgp CLK_GOUT_CMGP_USI0_PCLK>;
> +                               clock-names = "hsi2c", "hsi2c_pclk";
> +                               status = "disabled";
> +                       };
> +
> +                       serial_1: serial@11d00000 {
> +                               compatible = "samsung,exynos850-uart";
> +                               reg = <0x11d00000 0xc0>;
> +                               interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&uart1_single_pins>;
> +                               clocks = <&cmu_cmgp CLK_GOUT_CMGP_USI0_PCLK>,
> +                                        <&cmu_cmgp CLK_GOUT_CMGP_USI0_IPCLK>;
> +                               clock-names = "uart", "clk_uart_baud0";
> +                               status = "disabled";
> +                       };
> +               };
> +
> +               usi_cmgp1: usi@11d200c0 {
> +                       compatible = "samsung,exynos850-usi";
> +                       reg = <0x11d200c0 0x20>;
> +                       samsung,sysreg = <&sysreg_cmgp 0x2010>;
> +                       samsung,mode = <USI_V2_I2C>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +                       clocks = <&cmu_cmgp CLK_GOUT_CMGP_USI1_PCLK>,
> +                                <&cmu_cmgp CLK_GOUT_CMGP_USI1_IPCLK>;
> +                       clock-names = "pclk", "ipclk";
> +                       status = "disabled";
> +
> +                       hsi2c_4: i2c@11d20000 {
> +                               compatible = "samsung,exynosautov9-hsi2c";
> +                               reg = <0x11d20000 0xc0>;
> +                               interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&hsi2c4_pins>;
> +                               clocks = <&cmu_cmgp CLK_GOUT_CMGP_USI1_IPCLK>,
> +                                        <&cmu_cmgp CLK_GOUT_CMGP_USI1_PCLK>;
> +                               clock-names = "hsi2c", "hsi2c_pclk";
> +                               status = "disabled";
> +                       };
> +
> +                       serial_2: serial@11d20000 {
> +                               compatible = "samsung,exynos850-uart";
> +                               reg = <0x11d20000 0xc0>;
> +                               interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&uart2_single_pins>;
> +                               clocks = <&cmu_cmgp CLK_GOUT_CMGP_USI1_PCLK>,
> +                                        <&cmu_cmgp CLK_GOUT_CMGP_USI1_IPCLK>;
> +                               clock-names = "uart", "clk_uart_baud0";
> +                               status = "disabled";
> +                       };
> +               };
> +       };
> +};
> +
> +#include "exynos850-pinctrl.dtsi"
> --
> 2.30.2
>

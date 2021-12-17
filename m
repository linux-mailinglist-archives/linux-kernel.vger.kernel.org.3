Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DB347838F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 04:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbhLQDNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 22:13:41 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:47728 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbhLQDNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 22:13:37 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211217031334epoutp0459ccb2fafa279f2c29c83e5da786ad71~BbEx2OXgd2961829618epoutp04i
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 03:13:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211217031334epoutp0459ccb2fafa279f2c29c83e5da786ad71~BbEx2OXgd2961829618epoutp04i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639710815;
        bh=jAE8KF8EbSKp4FnBIfU2agFQbpP13RW5vA4+ofY1zSc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=hHcsjDfqVSR4QSnY/FKZIc+WX9kLw+zjHHeOqApqH3T3K79biRXGMPBNoTnYmaq/Z
         I90KSju8dtafgfTCsz2W6hClcoXtoSiSKbNPkqRLGzwV0l4AUpTZCqFvILiIsOX5vs
         MxBgMKZ+BWTE+OcQokH208vq5lsZ/0Q+IMmxSKZY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20211217031334epcas2p454e1b42a0893ce226dc053186c7bd7fb~BbExSWOq61486814868epcas2p4G;
        Fri, 17 Dec 2021 03:13:34 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.92]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JFYwC69MJz4x9Q9; Fri, 17 Dec
        2021 03:13:31 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.2D.12141.B500CB16; Fri, 17 Dec 2021 12:13:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20211217031331epcas2p47f9ba3cdb44cbbcccc0ed979bf3079d7~BbEufVcGZ1486814868epcas2p4q;
        Fri, 17 Dec 2021 03:13:31 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211217031331epsmtrp21f40c0f8c397bae79ec676d95f40cbb3~BbEueCMRr3021130211epsmtrp2o;
        Fri, 17 Dec 2021 03:13:31 +0000 (GMT)
X-AuditID: b6c32a48-d5dff70000002f6d-df-61bc005bcf63
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.5D.08738.B500CB16; Fri, 17 Dec 2021 12:13:31 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20211217031331epsmtip2e80f6f11c278c6bcb2a517d20d69c54f~BbEuOgSyR2559525595epsmtip2i;
        Fri, 17 Dec 2021 03:13:31 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Sam Protsenko'" <semen.protsenko@linaro.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>
Cc:     "'Jaewon Kim'" <jaewon02.kim@samsung.com>,
        "'David Virag'" <virag.david003@gmail.com>,
        "'Youngmin Nam'" <youngmin.nam@samsung.com>,
        "'Tomasz Figa'" <tomasz.figa@gmail.com>,
        "'Chanwoo Choi'" <cw00.choi@samsung.com>,
        "'Michael Turquette'" <mturquette@baylibre.com>,
        "'Stephen Boyd'" <sboyd@kernel.org>,
        "'Linus Walleij'" <linus.walleij@linaro.org>,
        "'Daniel Palmer'" <daniel@0x0f.com>,
        "'Hao Fang'" <fanghao11@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
In-Reply-To: <20211215160906.17451-7-semen.protsenko@linaro.org>
Subject: RE: [PATCH 6/7] arm64: dts: exynos: Add initial Exynos850 SoC
 support
Date:   Fri, 17 Dec 2021 12:13:31 +0900
Message-ID: <001101d7f2f4$119b9570$34d2c050$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQJUHcrPeMeiUlqWlcSYITTnT6xdXgFfoABqAqB9R/WrHan/YA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTZxj1bXtvL7jqXQF9gSn1KlkwAVrWwkVhksm2TskkbIuJjLEbegeE
        0ta2IAwWm4WPAn4yGawFJqKwdRKgEoQKDKGOwaYTNZUxgRkYKFJYgUwMsKz0so1/5znPOXme
        835gbP4M6oOlKrS0WkHJCdSd09obIAmM39RBCUuei8iHi1MI2d5UxiW/tt5BSONMAyDbdFaE
        bLYvscgLK/Us0jxuQ0jHqVGEvG+pRMmKX7pY5ODAm2R+p5VL9s4UIuTftmYOOXXGyZssK4Ds
        mxsHZG33PDfKQ7p0zcyWzg3lc6UG3WlU2m4Y4UrzrHZEajYVodJHtg5Ueu3ySemZFhOQLph3
        xrofS4tIoSkZrRbQiiSlLFWRHEkcfi/xYKIkVCgKFIWTYYRAQaXTkUR0TGzgW6lyZzJCkEnJ
        M5xULKXREMGvR6iVGVpakKLUaCMJWiWTq8JUQRoqXZOhSA5S0Np9IqEwROIUfpyWsvjgLkv1
        ODtLP9TD1oGLVDFwwyAuho03hkExcMf4eBuAjqkSDlPMA1hrqUKYYgHAzttrHcbS9LCBzTQs
        AJ5vKEWZ4gmAHZ8XgjUVigfDp/pWl90THwBwuOaZS8XGxziwbuCSS+WGR8G+vnwX9sBjoa1T
        75rBwf3h89VvnRjDeHg4NN15Z43m4S/D/q8mXBI27gev2yvZzEoC+OKPOoThPaGxqMDFe+Jv
        wCsOhysQxMvdYPGgDWUM0bDmbBdgsAec7mvhMtgHLsx2ooyhBMDSpyPrjQoAZ3+VM/g1aJhc
        i4k5pwXARkvwGoT4bmgdXt9tC9T3rnIZmgf1BXzG+Crsvl6+foo7YEnlAnIOEIYNyQwbkhk2
        pDH8P+si4JjANlqlSU+mNSEq8X/XnaRMNwPXs98rbQNG+59BPYCFgR4AMTbhydtVf4Pi82RU
        9qe0WpmozpDTmh4gcR71ebaPV5LS+W8U2kSROFwoDg0VhYVIhGHEdt4hWRPFx5MpLZ1G0ypa
        /a+Phbn56FjVLREf5Xo9HrdnvZtj8XlFYB2rrt6e/mysgI9MyrDvjqQeuflbvW+yvF8U3+0d
        I/ONj/Mrz9k9mYkWZ269dzILJO6vKSySiH/8wMNRyDp1LIqzp+v36QMK/9WlEt+prXO+23Sn
        l4MqrM1XjbbMA2XqC4pbVyYkT/b8tDmu3XL/doL3EM9RU7Z82VC66cS5zcb3r6Y0EIse1nL/
        n1v9ct+ujvnSmj312ez80f2HvvnwxPEdobbDtXlxS/X9B3eNvvCevoSMm7+vEtMmpA6dGMQf
        wQef/MUXxMEA4fHWhMab1HLDD7f2jb4UnbtSZdSOOHS59/hbcnZ+Yc87mqCXR5vu0rQXwdGk
        UKK9bLWG+gddnqU7fwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWy7bCSvG40w55Eg5MPhCyuf3nOarFzw1R2
        i/lHzrFazH6zltFiR8MRVouNb38wWUz5s5zJYtPja6wWH3vusVpc3jWHzWLG+X1MFhdPuVq0
        7j3CbnH4TTurxb9rG1ksnvcBxVft+sNocfz9Y0aLxQc+sTsIe/zYvInZ4/2NVnaPWQ29bB47
        Z91l92g58pbVY9OqTjaPO9f2sHlsXlLv0bdlFaPH501yAVxRXDYpqTmZZalF+nYJXBlfrlxg
        KnhYWdFx4xBzA+OCxC5GTg4JAROJDdfXMoPYQgI7GCXmLkyCiMtKPHu3gx3CFpa433KEFaLm
        GaPEwyMCIDabgL7Ey45tQHEuDhGBM4wSrx7+ZwNxmAVes0hMn/6aGcQREjjKKLG35QUjSAun
        gIPE8eOtQDYHh7CAn8TbzaIgYRYBVYnvf1eygIR5BSwlVp3zBAnzCghKnJz5BCzMLKAn0bYR
        bAizgLzE9rdzmCFuU5D4+XQZK0RcRGJ2ZxtYXETASWLpx48sExiFZyGZNAth0iwkk2Yh6V7A
        yLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM43rW0djDuWfVB7xAjEwfjIUYJDmYl
        EV7F5bsThXhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamDy
        uhnLVvR059cXPXdvaucFL1ni8XH1qtumlkvmtmcIvxbitE5Z0Hxf7B/7P+VmF9WHu+4EszJn
        puVxii1508nX/ZG5Jv5prmy/yLWFE2YqXIz3XdV0as6B1Hs2cxe7Net3PkiK3ffhzqMFeUte
        K/ppHeo/7cWxNuTE8wy2gmuP77Off5O7cM6Zv79qNfld2k/a860/8OvGr6TYldlh2hm5R3T9
        AxxFT2+em9D16Pex/8rxpnfYObSfbZZ4vLKwNNRw7w+v8Gtrm1PV5297dvvpCpX/93nSuFh4
        f2w6rrlk5XbDcPvtdZ/2TvauYlevDGdNubUqauufdr4p/pda1JLbXs2bYNtvs+nv3gufPL7z
        K7EUZyQaajEXFScCAIa1htBmAwAA
X-CMS-MailID: 20211217031331epcas2p47f9ba3cdb44cbbcccc0ed979bf3079d7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211215160918epcas2p1d7063cfe3abca5fcc0ccf4eee388c396
References: <20211215160906.17451-1-semen.protsenko@linaro.org>
        <CGME20211215160918epcas2p1d7063cfe3abca5fcc0ccf4eee388c396@epcas2p1.samsung.com>
        <20211215160906.17451-7-semen.protsenko@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Sam Protsenko <semen.protsenko@linaro.org>
> Sent: Thursday, December 16, 2021 1:09 AM
> To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>; Rob Herring
> <robh+dt@kernel.org>; Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Jaewon Kim <jaewon02.kim@samsung.com>; Chanho Park
> <chanho61.park@samsung.com>; David Virag <virag.david003@gmail.com>;
> Youngmin Nam <youngmin.nam@samsung.com>; Tomasz Figa
> <tomasz.figa@gmail.com>; Chanwoo Choi <cw00.choi@samsung.com>; Michael
> Turquette <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>;
> Linus Walleij <linus.walleij@linaro.org>; Daniel Palmer <daniel@0x0f.com>;
> Hao Fang <fanghao11@huawei.com>; linux-arm-kernel@lists.infradead.org;
> linux-samsung-soc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-clk@vger.kernel.org
> Subject: [PATCH 6/7] arm64: dts: exynos: Add initial Exynos850 SoC support
> 
> Samsung Exynos850 is ARMv8-based mobile-oriented SoC. This patch adds
> initial SoC support. It's not comprehensive yet, some more devices will be
> added later. Right now only crucial system components and most needed
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
>   * RTC clock
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
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  .../boot/dts/exynos/exynos850-pinctrl.dtsi    | 755 ++++++++++++++++++
>  arch/arm64/boot/dts/exynos/exynos850.dtsi     | 755 ++++++++++++++++++
>  2 files changed, 1510 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos850.dtsi
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
> b/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
> new file mode 100644
> index 000000000000..ba4e8d3129ac
> --- /dev/null
> +++ b/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
> @@ -0,0 +1,755 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung's Exynos850 SoC pin-mux and pin-config device tree source
> + *
> + * Copyright (C) 2017 Samsung Electronics Co., Ltd.
> + * Copyright (C) 2021 Linaro Ltd.
> + *
> + * Samsung's Exynos850 SoC pin-mux and pin-config options are listed as
> +device
> + * tree nodes in this file.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/pinctrl/samsung.h>
> +
> +&pinctrl_alive {
> +	gpa0: gpa0 {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	gpa1: gpa1 {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	gpa2: gpa2 {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	gpa3: gpa3 {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	gpa4: gpa4 {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	gpq0: gpq0 {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	/* I2C5 (also called CAM_PMIC_I2C in TRM) */
> +	i2c5_pins: i2c5-pins {
> +		samsung,pins = "gpa3-5", "gpa3-6";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +	};
> +
> +	/* I2C6 (also called MOTOR_I2C in TRM) */
> +	i2c6_pins: i2c6-pins {
> +		samsung,pins = "gpa3-7", "gpa4-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +	};
> +
> +	/* USI: UART_DEBUG_0 pins */
> +	uart0_pins: uart0-pins {
> +		samsung,pins = "gpq0-0", "gpq0-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* USI: UART_DEBUG_1 pins */
> +	uart1_pins: uart1-pins {
> +		samsung,pins = "gpa3-7", "gpa4-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +};
> +
> +&pinctrl_cmgp {
> +	gpm0: gpm0 {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	gpm1: gpm1 {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	gpm2: gpm2 {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	gpm3: gpm3 {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	gpm4: gpm4 {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	gpm5: gpm5 {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	/* USI_CMGP0: HSI2C function */
> +	hsi2c3_pins: hsi2c3-pins {
> +		samsung,pins = "gpm0-0", "gpm1-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +	};
> +
> +	/* USI_CMGP0: UART function (4 pins, Auto Flow Control) */
> +	uart1_single_pins: uart1-single-pins {
> +		samsung,pins = "gpm0-0", "gpm1-0", "gpm2-0", "gpm3-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* USI_CMGP0: UART function (2 pins, Non-Auto Flow Control) */
> +	uart1_dual_pins: uart1-dual-pins {
> +		samsung,pins = "gpm0-0", "gpm1-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* USI_CMGP0: SPI function */
> +	spi1_pins: spi1-pins {
> +		samsung,pins = "gpm0-0", "gpm1-0", "gpm2-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +	};
> +
> +	spi1_cs_pins: spi1-cs-pins {
> +		samsung,pins = "gpm3-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +	};
> +
> +	spi1_cs_func_pins: spi1-cs-func-pins {
> +		samsung,pins = "gpm3-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +	};
> +
> +	/* USI_CMGP1: HSI2C function */
> +	hsi2c4_pins: hsi2c4-pins {
> +		samsung,pins = "gpm4-0", "gpm5-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +	};
> +
> +	/* USI_CMGP1: UART function (4 pins, Auto Flow Control) */
> +	uart2_single_pins: uart2-single-pins {
> +		samsung,pins = "gpm4-0", "gpm5-0", "gpm6-0", "gpm7-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* USI_CMGP1: UART function (2 pins, Non-Auto Flow Control) */
> +	uart2_dual_pins: uart2-dual-pins {
> +		samsung,pins = "gpm4-0", "gpm5-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* USI_CMGP1: SPI function */
> +	spi2_pins: spi2-pins {
> +		samsung,pins = "gpm4-0", "gpm5-0", "gpm6-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +	};
> +
> +	spi2_cs_pins: spi2-cs-pins {
> +		samsung,pins = "gpm7-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +	};
> +
> +	spi2_cs_func_pins: spi2-cs-func-pins {
> +		samsung,pins = "gpm7-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +	};
> +};
> +
> +&pinctrl_aud {
> +	gpb0: gpb0 {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpb1: gpb1 {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	aud_codec_mclk_pins: aud-codec-mclk-pins {
> +		samsung,pins = "gpb0-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +	};
> +
> +	aud_codec_mclk_idle_pins: aud-codec-mclk-idle-pins {
> +		samsung,pins = "gpb0-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +	};
> +
> +	aud_i2s0_pins: aud-i2s0-pins {
> +		samsung,pins = "gpb0-1", "gpb0-2", "gpb0-3", "gpb0-4";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +	};
> +
> +	aud_i2s0_idle_pins: aud-i2s0-idle-pins {
> +		samsung,pins = "gpb0-1", "gpb0-2", "gpb0-3", "gpb0-4";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +	};
> +
> +	aud_i2s1_pins: aud-i2s1-pins {
> +		samsung,pins = "gpb1-0", "gpb1-1", "gpb1-2", "gpb1-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +	};
> +
> +	aud_i2s1_idle_pins: aud-i2s1-idle-pins {
> +		samsung,pins = "gpb1-0", "gpb1-1", "gpb1-2", "gpb1-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +	};
> +
> +	aud_fm_pins: aud-fm-pins {
> +		samsung,pins = "gpb1-4";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +	};
> +
> +	aud_fm_idle_pins: aud-fm-idle-pins {
> +		samsung,pins = "gpb1-4";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +	};
> +};
> +
> +&pinctrl_hsi {
> +	gpf2: gpf2 {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	sd2_clk_pins: sd2-clk-pins {
> +		samsung,pins = "gpf2-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV2>;
> +	};
> +
> +	sd2_clk_fast_slew_rate_1x_pins: sd2-clk-fast-slew-rate-1x-pins {
> +		samsung,pins = "gpf2-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV1>;
> +	};
> +
> +	sd2_clk_fast_slew_rate_1_5x_pins: sd2-clk-fast-slew-rate-1-5x-pins
> {
> +		samsung,pins = "gpf2-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV1_5>;
> +	};
> +
> +	sd2_clk_fast_slew_rate_2x_pins: sd2-clk-fast-slew-rate-2x-pins {
> +		samsung,pins = "gpf2-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV2>;
> +	};
> +
> +	sd2_clk_fast_slew_rate_2_5x_pins: sd2-clk-fast-slew-rate-2-5x-pins
> {
> +		samsung,pins = "gpf2-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV2_5>;
> +	};
> +
> +	sd2_clk_fast_slew_rate_3x_pins: sd2-clk-fast-slew-rate-3x-pins {
> +		samsung,pins = "gpf2-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV3>;
> +	};
> +
> +	sd2_clk_fast_slew_rate_4x_pins: sd2-clk-fast-slew-rate-4x-pins {
> +		samsung,pins = "gpf2-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV4>;
> +	};

All the flew_rate_XX pins are necessary to be defined? They might be
required by board dts files and it's convenient to use them but I don't
think they should be pre-defined. We can override the sd2_clk_pins like
below in a board dts file.

&sd2_clk_pins {
	samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV4>;

Otherwise, looks good to me.

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park


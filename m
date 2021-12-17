Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55354478238
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 02:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhLQBh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 20:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhLQBh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 20:37:27 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E718EC06173F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 17:37:26 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id 30so1481712uag.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 17:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ULm8F1jUKPQA5lXk5boYZppCWt+QFr5wkiSxlguZEnY=;
        b=l1c1ElnqZemsukJbKE2Rxh6HSF2h/6AZiWfJIH4M9AMKhIbyhoRoe/Bcdbvd3uOPxF
         yAJd1J4PRKLinEyqo0HJ7VMgLw45f6qYxCbHIGEJjC44QDM3gZUDhVZN7Qsk2OqvmT6m
         PKelgt0+2CGU59vWqD/NCh3hPsmCt1fc+H+AOzzJRKZ0HIdJg+fjIL3+6pFt2EQ5lXgQ
         dK6QkrkBWqurcgSqHIk39b4eRtfWc6QYk/Md6YPbI420uTx+KnMCsZsMrmVgwnp6aeEK
         ogC+9wxuqGZ5A40JgL5Q4MIrJk/x33EDYdz/3uWShhq5BK0ePiRDygnlqxHBEf3I9mDk
         +GXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ULm8F1jUKPQA5lXk5boYZppCWt+QFr5wkiSxlguZEnY=;
        b=D4JSuRl9sq7hKHD95kI+2WhP70dbb7haHMQXdN9FQHYUehrWh/5lrI4DojQS3hGq+I
         /4G3qt2KaZ2xLFzceSMirXAg1SFR+VhNv2AmdVx3oKkZ76kG7WBjMCNd8oTvAAbR1dzw
         hbH3/iQY0e/wh9XgWUx6SqxKYM7VYrbX4GcKpShUBKdtql962T/jiqyZ1o0/LQoZrPi4
         lJKqJNdA5GzxaiNb/d9pwMFoko44HfRG8EKKJ8NT4Jo8qGbtNHHLhUIQGe6XRMWBZ3hw
         VQTSlEgt6l7YxLwbOhqxjY3sNhbZ0w360XaapsOrGwcJHV5BJS/qdYkdFSa69nfXV7eU
         eBeA==
X-Gm-Message-State: AOAM533JNAaobox/lpJ+u69ZgskFFwx8DZOe1oiDad+kFoiHs4DZGfQ3
        qoDFTvq5Op/uL4sEB1WALvX0WTWjdOl8xPpN3RFUlg==
X-Google-Smtp-Source: ABdhPJyruSK7tH/BTjcldQoAu0YUpSBd65lTPCLNFuSaDsp8UC1z/jZAcY7igh5H6TK/nb71yxIS9+VyqE6JrTxpzpg=
X-Received: by 2002:ab0:61d9:: with SMTP id m25mr213664uan.114.1639705045957;
 Thu, 16 Dec 2021 17:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20211217013005.16646-1-semen.protsenko@linaro.org> <20211217013005.16646-8-semen.protsenko@linaro.org>
In-Reply-To: <20211217013005.16646-8-semen.protsenko@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 17 Dec 2021 03:37:14 +0200
Message-ID: <CAPLW+4nSAjugncJkr49k=nkWiKXs-mo16_qfq1KRGkaaWu-R7Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] arm64: dts: exynos: Add initial E850-96 board support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
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
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 at 03:30, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> E850-96 is a 96boards development board manufactured by WinLink. It
> incorporates Samsung Exynos850 SoC, and is compatible with 96boards
> mezzanine boards [1], as it follows 96boards standards.
>
> This patch adds minimal support for E850-96 board. Next features are
> enabled in board dts file and verified with minimal BusyBox rootfs:
>
>  * User buttons
>  * LEDs
>  * Serial console
>  * Watchdog timers
>  * RTC
>  * eMMC
>
> [1] https://www.96boards.org/products/mezzanine/
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - Removed board_id and board_rev properties
>   - Removed BOARD_ID and BOARD_REV constants
>   - Put dtb in alphabetical order in Makefile
>   - Added "color" and "function" properties to LED nodes
>   - Sorted all phandle overrides by phandle name
>   - Removed 'broken-cd' property in eMMC node
>   - Added memory node
>
>  arch/arm64/boot/dts/exynos/Makefile           |   1 +
>  .../boot/dts/exynos/exynos850-e850-96.dts     | 175 ++++++++++++++++++
>  2 files changed, 176 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
>
> diff --git a/arch/arm64/boot/dts/exynos/Makefile b/arch/arm64/boot/dts/exynos/Makefile
> index b41e86df0a84..be9df8e85c59 100644
> --- a/arch/arm64/boot/dts/exynos/Makefile
> +++ b/arch/arm64/boot/dts/exynos/Makefile
> @@ -3,4 +3,5 @@ dtb-$(CONFIG_ARCH_EXYNOS) += \
>         exynos5433-tm2.dtb      \
>         exynos5433-tm2e.dtb     \
>         exynos7-espresso.dtb    \
> +       exynos850-e850-96.dtb   \
>         exynosautov9-sadk.dtb
> diff --git a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
> new file mode 100644
> index 000000000000..952a47c417d4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * WinLink E850-96 board device tree source
> + *
> + * Copyright (C) 2018 Samsung Electronics Co., Ltd.
> + * Copyright (C) 2021 Linaro Ltd.
> + *
> + * Device tree source file for WinLink's E850-96 board which is based on
> + * Samsung Exynos850 SoC.
> + */
> +
> +/dts-v1/;
> +
> +#include "exynos850.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +       model = "WinLink E850-96 board";
> +       compatible = "winlink,e850-96", "samsung,exynos850";
> +
> +       chosen {
> +               stdout-path = &serial_0;
> +       };
> +
> +       /*
> +        * 4 GiB eMCP:
> +        *   - 2 GiB at 0x80000000
> +        *   - 2 GiB at 0x880000000
> +        *
> +        * 0xbab00000..0xbfffffff: secure memory (85 MiB).
> +        */
> +       memory@80000000 {
> +               device_type = "memory";
> +               reg = <0x0 0x80000000 0x3ab00000>,
> +                     <0x0 0xc0000000 0x40000000>,
> +                     <0x8 0x80000000 0x80000000>;
> +       };
> +
> +       gpio-keys {
> +               compatible = "gpio-keys";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&key_voldown_pins &key_volup_pins>;
> +
> +               volume-down-key {
> +                       label = "Volume Down";
> +                       linux,code = <KEY_VOLUMEDOWN>;
> +                       gpios = <&gpa1 0 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               volume-up-key {
> +                       label = "Volume Up";
> +                       linux,code = <KEY_VOLUMEUP>;
> +                       gpios = <&gpa0 7 GPIO_ACTIVE_LOW>;
> +               };
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               /* HEART_BEAT_LED */
> +               user_led1: led-1 {
> +                       label = "yellow:user1";
> +                       gpios = <&gpg2 2 GPIO_ACTIVE_HIGH>;
> +                       color = <LED_COLOR_ID_YELLOW>;
> +                       function = LED_FUNCTION_HEARTBEAT;
> +                       linux,default-trigger = "heartbeat";
> +               };
> +
> +               /* eMMC_LED */
> +               user_led2: led-2 {
> +                       label = "yellow:user2";
> +                       gpios = <&gpg2 3 GPIO_ACTIVE_HIGH>;
> +                       color = <LED_COLOR_ID_YELLOW>;
> +                       linux,default-trigger = "mmc0";
> +               };
> +
> +               /* SD_LED */
> +               user_led3: led-3 {
> +                       label = "white:user3";
> +                       gpios = <&gpg2 4 GPIO_ACTIVE_HIGH>;
> +                       color = <LED_COLOR_ID_WHITE>;
> +                       function = LED_FUNCTION_SD;
> +                       linux,default-trigger = "mmc2";
> +               };
> +
> +               /* WIFI_LED */
> +               wlan_active_led: led-4 {
> +                       label = "yellow:wlan";
> +                       gpios = <&gpg2 6 GPIO_ACTIVE_HIGH>;
> +                       color = <LED_COLOR_ID_YELLOW>;
> +                       function = LED_FUNCTION_WLAN;
> +                       linux,default-trigger = "phy0tx";
> +                       default-state = "off";
> +               };
> +
> +               /* BLUETOOTH_LED */
> +               bt_active_led: led-5 {
> +                       label = "blue:bt";
> +                       gpios = <&gpg2 7 GPIO_ACTIVE_HIGH>;
> +                       color = <LED_COLOR_ID_BLUE>;
> +                       function = LED_FUNCTION_BLUETOOTH;
> +                       linux,default-trigger = "hci0rx";
> +                       default-state = "off";
> +               };
> +       };
> +};
> +
> +&mmc_0 {
> +       status = "okay";
> +       mmc-hs200-1_8v;
> +       mmc-hs400-1_8v;
> +       cap-mmc-highspeed;
> +       non-removable;
> +       mmc-hs400-enhanced-strobe;
> +       card-detect-delay = <200>;
> +       clock-frequency = <800000000>;
> +       bus-width = <8>;
> +       samsung,dw-mshc-ciu-div = <3>;
> +       samsung,dw-mshc-sdr-timing = <0 4>;
> +       samsung,dw-mshc-ddr-timing = <2 4>;
> +       samsung,dw-mshc-hs400-timing = <0 2>;
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&sd0_clk_pins &sd0_cmd_pins &sd0_rdqs_pins &sd0_nreset_pins
> +                    &sd0_bus1_pins &sd0_bus4_pins &sd0_bus8_pins>;
> +};
> +
> +&oscclk {
> +       clock-frequency = <26000000>;
> +};
> +
> +&rtc {
> +       status = "okay";
> +};
> +
> +&rtcclk {
> +       clock-frequency = <32768>;
> +};
> +
> +&serial_0 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart1_pins>;
> +};
> +
> +&usi_uart {
> +       samsung,clkreq-on; /* needed for UART mode */
> +       status = "okay";
> +};
> +
> +&watchdog_cl0 {
> +       status = "okay";
> +};
> +
> +&watchdog_cl1 {
> +       status = "okay";
> +};
> +
> +&pinctrl_alive {

Forgot to order pinctrl node. Will send v3 soon, sorry for the noise.

> +       key_voldown_pins: key-voldown-pins {
> +               samsung,pins = "gpa1-0";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +       };
> +
> +       key_volup_pins: key-volup-pins {
> +               samsung,pins = "gpa0-7";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +       };
> +};
> --
> 2.30.2
>

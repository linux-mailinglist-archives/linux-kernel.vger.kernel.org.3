Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F007446C455
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241171AbhLGUWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhLGUWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:22:49 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F70C061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 12:19:18 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id j14so692676uan.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 12:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=au4bw4XY3RMdfxLQ1VAqfu6jVi11mHXeiQeWsPJl3AQ=;
        b=k0Eg/QPDti0GlbtTvoUHUAA5Ye6UYwZ83AhanyfEvmxPthfDY/+ijA9vO7KqCD4yr/
         hJEj+KqwkxiYwlhCOLzKyhYvx5XEdH4oimaOP0fZcqKBIjjPq3PuCpVtL48h8NVYTyOO
         DqAjym4NWlQS/GPlTtPPOqmpiVcYl5YYtNOAelKC9I75W9pLW18GXNWkZAIfbz9QR7Yv
         2E6iCBLDZnkbPlwmICF4J6oficdIMvZ8ZYuLAikF84sVxrFXMX7741Q4DjMA0FNWQkdn
         Bx1Z5UwGmnRUhej96crMvwpgYO/rleNHtqJcKLTemjqoEJEqIXPzArLt9WGW4lJp6kHW
         LTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=au4bw4XY3RMdfxLQ1VAqfu6jVi11mHXeiQeWsPJl3AQ=;
        b=UfQtu1mJaUzj29gIjWvOmGvJuiktn4j8b3QlcTHee4ozTPVL9T7+OgN3BCdIlOav8/
         rMYaj6+lpl+zmrTGUajgZB9jsKXw22mD9y1LlWx+k74/tXliIJWgZhHFfKxSSLteKQyY
         sGsXazYWPJ0VPk49+tJW/p+y7yxiSJRmnRhbrmLfQ2sWgJlv0ee4UxV/0QBiQyPqbZfu
         da/tz6KrbpVQGbHbblBAukEwolBLBzWx4yQOxQkYaSHS40Y6q5eLhrIWBYgnsms+buFu
         i8Xf5CByBCchY4q5aHf6vtwkYl5M8Wb7pGrEvuef1qDTJdmzfRX7Le5+KRJR4UoIh+id
         ysgw==
X-Gm-Message-State: AOAM532zeVlNu3WmPJTXw3Me5Lp/ZNvdfj8Cet+eFOqhVLvwnvUdgDpP
        Q0vjTPjghpilrbpaRjk5gQGqzreHM98O/ujtkMFesQ==
X-Google-Smtp-Source: ABdhPJwbPvJHBP1kw51gzeQ4xE3A4quDsUhqOZCMpJmNuPz9AtDo/UK8026miV9rl3ws/Ca9XiA8kKh9KlhAjeD9tgk=
X-Received: by 2002:a67:3382:: with SMTP id z124mr47502674vsz.57.1638908357079;
 Tue, 07 Dec 2021 12:19:17 -0800 (PST)
MIME-Version: 1.0
References: <20211206153124.427102-1-virag.david003@gmail.com> <20211206153124.427102-8-virag.david003@gmail.com>
In-Reply-To: <20211206153124.427102-8-virag.david003@gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 7 Dec 2021 22:19:05 +0200
Message-ID: <CAPLW+4k3Vmg0W0jVsTChHTG8+eeg=5QF+actz1Tk0vNV9w-y-A@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] arm64: dts: exynos: Add initial device tree
 support for Exynos7885 SoC
To:     David Virag <virag.david003@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 at 17:32, David Virag <virag.david003@gmail.com> wrote:
>
> Add initial Exynos7885 device tree nodes with dts for the Samsung Galaxy
> A8 (2018), a.k.a. "jackpotlte", with model number "SM-A530F".
> Currently this includes some clock support, UART support, and I2C nodes.
>
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
> Changes in v2:
>   - Remove address-cells, and size-cells from dts, since they are
>     already in the dtsi.
>   - Lower case hex in memory node
>   - Fix node names with underscore instead of hyphen
>   - Fix line breaks
>   - Fix "-key" missing from gpio keys node names
>   - Use the form without "key" in gpio key labels on all keys
>   - Suffix pin configuration node names with "-pins"
>   - Remove "fimc_is_mclk" nodes from pinctrl dtsi for now
>   - Use macros for "samsung,pin-con-pdn", and "samsung,pin-con-pdn"
>   - Add comment about Arm PMU
>   - Rename "clock-oscclk" to "osc-clock"
>   - Include exynos-syscon-restart.dtsi instead of rewriting its contents
>
> Changes in v3:
>   - Fix typo (seperate -> separate)
>
> Changes in v4:
>   - Fixed leading 0x in clock-controller nodes
>   - Actually suffixed pin configuration node names with "-pins"
>   - Seperated Cortex-A53 and Cortex-A73 PMU
>
>  arch/arm64/boot/dts/exynos/Makefile           |   7 +-
>  .../boot/dts/exynos/exynos7885-jackpotlte.dts |  95 ++
>  .../boot/dts/exynos/exynos7885-pinctrl.dtsi   | 865 ++++++++++++++++++
>  arch/arm64/boot/dts/exynos/exynos7885.dtsi    | 438 +++++++++
>  4 files changed, 1402 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts

Shouldn't SoC and board files be sent as two separate patches? For
example, I've checked exynos5433 and exynos7, SoC support

>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7885.dtsi
>
> diff --git a/arch/arm64/boot/dts/exynos/Makefile b/arch/arm64/boot/dts/ex=
ynos/Makefile
> index b41e86df0a84..c68c4ad577ac 100644
> --- a/arch/arm64/boot/dts/exynos/Makefile
> +++ b/arch/arm64/boot/dts/exynos/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_EXYNOS) +=3D \
> -       exynos5433-tm2.dtb      \
> -       exynos5433-tm2e.dtb     \
> -       exynos7-espresso.dtb    \
> +       exynos5433-tm2.dtb              \
> +       exynos5433-tm2e.dtb             \
> +       exynos7-espresso.dtb            \
> +       exynos7885-jackpotlte.dtb       \
>         exynosautov9-sadk.dtb
> diff --git a/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts b/arch/=
arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
> new file mode 100644
> index 000000000000..f5941dc4c374
> --- /dev/null
> +++ b/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung Galaxy A8 2018 (jackpotlte/SM-A530F) device tree source
> + *
> + * Copyright (c) 2021 Samsung Electronics Co., Ltd.
> + * Copyright (c) 2021 D=C3=A1vid Vir=C3=A1g
> + *

This line is not needed.

> + */
> +
> +/dts-v1/;

Suggest adding empty line here.

> +#include "exynos7885.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +       model =3D "Samsung Galaxy A8 (2018)";
> +       compatible =3D "samsung,jackpotlte", "samsung,exynos7885";
> +       chassis-type =3D "handset";
> +
> +       aliases {
> +               serial0 =3D &serial_0;
> +               serial1 =3D &serial_1;
> +               serial2 =3D &serial_2;

Suggestion: add aliases also for i2c nodes, to keep i2c instance
numbers fixed in run-time (e.g. in "i2cdetect -l" output).

> +       };
> +
> +       chosen {
> +               stdout-path =3D &serial_2;
> +       };
> +
> +       memory@80000000 {
> +               device_type =3D "memory";
> +               reg =3D <0x0 0x80000000 0x3da00000>,
> +                     <0x0 0xc0000000 0x40000000>,
> +                     <0x8 0x80000000 0x40000000>;
> +       };
> +
> +       gpio-keys {
> +               compatible =3D "gpio-keys";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&key_volup &key_voldown &key_power>;
> +
> +               volup-key {
> +                       label =3D "Volume Up";
> +                       interrupts =3D <5 IRQ_TYPE_LEVEL_HIGH 0>;

Here and below: what is 0, why it's needed? Also, isn't it enough to
have just "gpios", and remove interrupt*? Need to check "gpio-keys"
driver and bindings doc, but AFAIR it should be enough to have just
"gpios =3D" or just "interrupts =3D".


> +                       interrupt-parent =3D <&gpa1>;
> +                       linux,code =3D <KEY_VOLUMEUP>;
> +                       gpios =3D <&gpa1 5 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               voldown-key {
> +                       label =3D "Volume Down";
> +                       interrupts =3D <6 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       interrupt-parent =3D <&gpa1>;
> +                       linux,code =3D <KEY_VOLUMEDOWN>;
> +                       gpios =3D <&gpa1 6 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               power-key {
> +                       label =3D "Power";
> +                       interrupts =3D <7 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       interrupt-parent =3D <&gpa1>;
> +                       linux,code =3D <KEY_POWER>;
> +                       gpios =3D <&gpa1 7 GPIO_ACTIVE_LOW>;
> +                       wakeup-source;
> +               };
> +       };
> +};
> +

If there are some LEDs by chance on that board -- it might be useful
to define those here with "gpio-leds" as well. Maybe even set some
default trigger like "heartbeat".

> +&serial_2 {
> +       status =3D "okay";
> +};
> +
> +&pinctrl_alive {
> +       key_volup: key-volup-pins {
> +               samsung,pins =3D "gpa1-5";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_F>;

Maybe EXYNOS_PIN_FUNC_EINT is more self-explanatory? Just a suggestion thou=
gh.

> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <0>;

Here and below: please use EXYNOS5420_PIN_DRV_LV1 (means drive level =3D 1x=
).

> +       };
> +
> +       key_voldown: key-voldown-pins {
> +               samsung,pins =3D "gpa1-6";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_F>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +
> +       key_power: key-power-pins {
> +               samsung,pins =3D "gpa1-7";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_F>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi b/arch/ar=
m64/boot/dts/exynos/exynos7885-pinctrl.dtsi
> new file mode 100644
> index 000000000000..8336b2e48858
> --- /dev/null
> +++ b/arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi
> @@ -0,0 +1,865 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung Exynos7885 SoC pin-mux and pin-config device tree source
> + *
> + * Copyright (c) 2017 Samsung Electronics Co., Ltd.
> + * Copyright (c) 2021 D=C3=A1vid Vir=C3=A1g
> + *
> + * Samsung's Exynos7885 SoC pin-mux and pin-config options are listed as
> + * device tree nodes in this file.
> + */
> +
> +#include <dt-bindings/pinctrl/samsung.h>

You probably also need <dt-bindings/interrupt-controller/arm-gic.h>
here for GIC_SPI definition.

> +
> +&pinctrl_alive {
> +       etc0: etc0 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       etc1: etc1 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };

Hmm, what are these two? I can't find anything related in
exynos7885.dtsi. If it's just some leftover from downstream vendor
kernel -- please remove it.

> +
> +       gpa0: gpa0 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +               interrupt-parent =3D <&gic>;
> +               interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +       };
> +
> +       gpa1: gpa1 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <3>;
> +               interrupt-parent =3D <&gic>;
> +               interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> +       };
> +
> +       gpa2: gpa2 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       gpq0: gpq0 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       sim1_det_gpio: sim1-det-gpio-pins {
> +               samsung,pins =3D "gpa2-5";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_F>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +       };
> +
> +       sim0_det_gpio: sim0-det-gpio-pins {
> +               samsung,pins =3D "gpa2-6";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_F>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +       };
> +
> +       speedy_bus: speedy-bus-pins {
> +               samsung,pins =3D "gpq0-2";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-con-pdn =3D <EXYNOS_PIN_PDN_PREV>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <0>;

Here and below: suggest using EXYNOS5420_PIN_DRV_LV* constants. Then
stuff like "sd1_clk_fast_slew_rate_4x" is going to make sense.

> +       };
> +
> +       /* UART_DEBUG */
> +       uart2_bus: uart2-bus-pins {
> +               samsung,pins =3D "gpq0-4", "gpq0-3";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +       };
> +};
> +
> +&pinctrl_dispaud {
> +       gpb0: gpb0 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       gpb1: gpb1 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       gpb2: gpb2 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       aud_codec_mclk: aud-codec-mclk-pins {
> +               samsung,pins =3D "gpb0-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_DOWN>;
> +       };
> +
> +       aud_codec_mclk_idle: aud-codec-mclk-idle-pins {
> +               samsung,pins =3D "gpb0-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_INPUT>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_DOWN>;
> +       };
> +
> +       aud_codec_bus: aud-codec-bus-pins {
> +               samsung,pins =3D "gpb0-1", "gpb0-2", "gpb0-3", "gpb0-4";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_DOWN>;
> +       };
> +
> +       aud_codec_bus_idle: aud-codec-bus-idle-pins {
> +               samsung,pins =3D "gpb0-1", "gpb0-2", "gpb0-3", "gpb0-4";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_INPUT>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_DOWN>;
> +       };
> +
> +       aud_loopback_bus: aud-loopback-bus-pins {
> +               samsung,pins =3D "gpb1-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_DOWN>;
> +       };
> +
> +       aud_loopback_bus_idle: aud-loopback-bus-idle-pins {
> +               samsung,pins =3D "gpb1-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_INPUT>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_DOWN>;
> +       };
> +
> +       aud_fm_bus: aud-fm-bus-pins {
> +               samsung,pins =3D "gpb1-1", "gpb1-2", "gpb1-3";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_DOWN>;
> +       };
> +
> +       aud_fm_bus_idle: aud-fm-bus-idle-pins {
> +               samsung,pins =3D "gpb1-1", "gpb1-2", "gpb1-3";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_INPUT>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_DOWN>;
> +       };
> +
> +       aud_spk_bus: aud-spk-bus-pins {
> +               samsung,pins =3D "gpb2-0", "gpb2-1", "gpb2-2", "gpb2-3";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_DOWN>;
> +       };
> +
> +       aud_spk_bus_idle: aud-spk-bus-idle-pins {
> +               samsung,pins =3D "gpb2-0", "gpb2-1", "gpb2-2", "gpb2-3";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_INPUT>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_DOWN>;
> +       };
> +};
> +
> +&pinctrl_fsys {
> +       gpf0: gpf0 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       gpf2: gpf2 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       gpf3: gpf3 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       gpf4: gpf4 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       sd0_clk: sd0-clk-pins {
> +               samsung,pins =3D "gpf0-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <3>;
> +       };
> +
> +       sd0_clk_fast_slew_rate_1x: sd0-clk-fast-slew-rate-1x-pins {
> +               samsung,pins =3D "gpf0-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +
> +       sd0_clk_fast_slew_rate_2x: sd0-clk-fast-slew-rate-2x-pins {
> +               samsung,pins =3D "gpf0-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <1>;
> +       };
> +
> +       sd0_clk_fast_slew_rate_3x: sd0-clk-fast-slew-rate-3x-pins {
> +               samsung,pins =3D "gpf0-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <2>;
> +       };
> +
> +       sd0_clk_fast_slew_rate_4x: sd0-clk-fast-slew-rate-4x-pins {
> +               samsung,pins =3D "gpf0-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <3>;
> +       };
> +
> +       sd0_cmd: sd0-cmd-pins {
> +               samsung,pins =3D "gpf0-1";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <3>;
> +       };
> +
> +       sd0_rdqs: sd0-rdqs-pins {
> +               samsung,pins =3D "gpf0-2";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_DOWN>;
> +               samsung,pin-drv =3D <3>;
> +       };
> +
> +       sd0_bus1: sd0-bus-width1-pins {
> +               samsung,pins =3D "gpf2-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <3>;
> +       };
> +
> +       sd0_bus4: sd0-bus-width4-pins {
> +               samsung,pins =3D "gpf2-1", "gpf2-2", "gpf2-3";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <3>;
> +       };
> +
> +       sd0_bus8: sd0-bus-width8-pins {
> +               samsung,pins =3D "gpf2-4", "gpf2-5", "gpf2-6", "gpf2-7";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <3>;
> +       };
> +
> +       sd1_clk: sd1-clk-pins {
> +               samsung,pins =3D "gpf3-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <2>;
> +       };
> +
> +       sd1_clk_fast_slew_rate_1x: sd1-clk-fast-slew-rate-1x-pins {
> +               samsung,pins =3D "gpf3-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +
> +       sd1_clk_fast_slew_rate_2x: sd1-clk-fast-slew-rate-2x-pins {
> +               samsung,pins =3D "gpf3-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <1>;
> +       };
> +
> +       sd1_clk_fast_slew_rate_3x: sd1-clk-fast-slew-rate-3x-pins {
> +               samsung,pins =3D "gpf3-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <2>;
> +       };
> +
> +       sd1_clk_fast_slew_rate_4x: sd1-clk-fast-slew-rate-4x-pins {
> +               samsung,pins =3D "gpf3-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <3>;
> +       };
> +
> +       sd1_cmd: sd1-cmd-pins {
> +               samsung,pins =3D "gpf3-1";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <2>;
> +       };
> +
> +       sd1_bus1: sd1-bus-width1-pins {
> +               samsung,pins =3D "gpf3-2";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <2>;
> +       };
> +
> +       sd1_bus4: sd1-bus-width4-pins {
> +               samsung,pins =3D "gpf3-3", "gpf3-5";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <2>;
> +       };
> +
> +       sd2_clk: sd2-clk-pins {
> +               samsung,pins =3D "gpf4-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <2>;
> +       };
> +
> +       sd2_clk_fast_slew_rate_1x: sd2-clk-fast-slew-rate-1x-pins {
> +               samsung,pins =3D "gpf4-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +
> +       sd2_clk_fast_slew_rate_2x: sd2-clk-fast-slew-rate-2x-pins {
> +               samsung,pins =3D "gpf4-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <1>;
> +       };
> +
> +       sd2_clk_fast_slew_rate_3x: sd2-clk-fast-slew-rate-3x-pins {
> +               samsung,pins =3D "gpf4-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <2>;
> +       };
> +
> +       sd2_clk_fast_slew_rate_4x: sd2-clk-fast-slew-rate-4x-pins {
> +               samsung,pins =3D "gpf4-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <3>;
> +       };
> +
> +       sd2_cmd: sd2-cmd-pins {
> +               samsung,pins =3D "gpf4-1";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <2>;
> +       };
> +
> +       sd2_bus1: sd2-bus-width1-pins {
> +               samsung,pins =3D "gpf4-2";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <2>;
> +       };
> +
> +       sd2_bus4: sd2-bus-width4-pins {
> +               samsung,pins =3D "gpf4-3", "gpf4-4", "gpf4-5";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <2>;
> +       };
> +};
> +
> +&pinctrl_top {
> +       gpc0: gpc0 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       gpc1: gpc1 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       gpc2: gpc2 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       gpg0: gpg0 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       gpg1: gpg1 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       gpg2: gpg2 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       gpg3: gpg3 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       gpg4: gpg4 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       gpp0: gpp0 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       gpp1: gpp1 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       gpp2: gpp2 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       gpp3: gpp3 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       gpp4: gpp4 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       gpp5: gpp5 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       gpp6: gpp6 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       gpp7: gpp7 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       gpp8: gpp8 {
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <2>;
> +       };
> +
> +       /* DECON TE */
> +       decon_f_te_on: decon_f_te_on-pins {
> +               samsung,pins =3D "gpc0-3";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_F>;
> +       };
> +
> +       decon_f_te_off: decon_f_te_off-pins {
> +               samsung,pins =3D "gpc0-3";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_INPUT>;
> +       };
> +
> +       hs_i2c0_bus: hs-i2c0-bus-pins {
> +               samsung,pins =3D "gpc1-1", "gpc1-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-con-pdn =3D <EXYNOS_PIN_PDN_OUT1>;
> +               samsung,pin-pud-pdn =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +
> +       hs_i2c1_bus: hs-i2c1-bus-pins {
> +               samsung,pins =3D "gpc1-3", "gpc1-2";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <0>;
> +               samsung,pin-con-pdn =3D <EXYNOS_PIN_PDN_OUT1>;
> +               samsung,pin-pud-pdn =3D <EXYNOS_PIN_PULL_UP>;
> +       };
> +
> +       hs_i2c2_bus: hs-i2c2-bus-pins {
> +               samsung,pins =3D "gpc1-5", "gpc1-4";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <0>;
> +               samsung,pin-con-pdn =3D <EXYNOS_PIN_PDN_OUT1>;
> +               samsung,pin-pud-pdn =3D <EXYNOS_PIN_PULL_UP>;
> +       };
> +
> +       hs_i2c3_bus: hs-i2c3-bus-pins {
> +               samsung,pins =3D "gpc1-7", "gpc1-6";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <0>;
> +               samsung,pin-con-pdn =3D <EXYNOS_PIN_PDN_OUT1>;
> +               samsung,pin-pud-pdn =3D <EXYNOS_PIN_PULL_UP>;
> +       };
> +
> +       /* USI0 UART */
> +       uart3_bus_single: uart3-bus-single-pins {
> +               samsung,pins =3D "gpc2-3", "gpc2-2", "gpc2-1", "gpc2-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +       };
> +
> +       /* USI0 UART_HSI2C1 */
> +       uart3_bus_dual: uart3-bus-dual-pins {
> +               samsung,pins =3D "gpc2-1", "gpc2-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +       };
> +
> +       /* USI0 HSI2C0 */
> +       hs_i2c4_bus: hs-i2c4-bus-pins {
> +               samsung,pins =3D "gpc2-1", "gpc2-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <0>;
> +               samsung,pin-con-pdn =3D <EXYNOS_PIN_PDN_OUT1>;
> +               samsung,pin-pud-pdn =3D <EXYNOS_PIN_PULL_UP>;
> +       };
> +
> +       /* USI0 HSI2C1 */
> +       hs_i2c5_bus: hs-i2c5-bus-pins {
> +               samsung,pins =3D "gpc2-3", "gpc2-2";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <0>;
> +               samsung,pin-con-pdn =3D <EXYNOS_PIN_PDN_OUT1>;
> +               samsung,pin-pud-pdn =3D <EXYNOS_PIN_PULL_UP>;
> +       };
> +
> +       /* USI0 SPI */
> +       spi2_bus: spi2-bus-pins {
> +               samsung,pins =3D "gpc2-1", "gpc2-0", "gpc2-3";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +
> +       spi2_cs: spi2-cs-pins {
> +               samsung,pins =3D "gpc2-2";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_OUTPUT>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +
> +       /* USI1 UART */
> +       uart4_bus_single: uart4-bus-single-pins {
> +               samsung,pins =3D "gpc2-7", "gpc2-6", "gpc2-5", "gpc2-4";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +       };
> +
> +       /* USI1 UART_HSI2C1*/
> +       uart4_bus_dual: uart4-bus-dual-pins {
> +               samsung,pins =3D "gpc2-5", "gpc2-4";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +       };
> +
> +       /* USI1 HSI2C0 */
> +       hs_i2c6_bus: hs-i2c6-bus-pins {
> +               samsung,pins =3D "gpc2-5", "gpc2-4";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <0>;
> +               samsung,pin-con-pdn =3D <EXYNOS_PIN_PDN_OUT1>;
> +               samsung,pin-pud-pdn =3D <EXYNOS_PIN_PULL_UP>;
> +       };
> +
> +       /* USI1 HSI2C1 */
> +       hs_i2c7_bus: hs-i2c7-bus-pins {
> +               samsung,pins =3D "gpc2-7", "gpc2-6";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <0>;
> +               samsung,pin-con-pdn =3D <EXYNOS_PIN_PDN_OUT1>;
> +               samsung,pin-pud-pdn =3D <EXYNOS_PIN_PULL_UP>;
> +       };
> +
> +       /* USI1 SPI */
> +       spi3_bus: spi3-bus-pins {
> +               samsung,pins =3D "gpc2-5", "gpc2-4", "gpc2-7";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +
> +       spi3_cs: spi3-cs-pins {
> +               samsung,pins =3D "gpc2-6";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_OUTPUT>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +
> +       fm_lna_en: fm-lna-en-pins {
> +               samsung,pins =3D "gpg0-2";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_OUTPUT>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_DOWN>;
> +               samsung,pin-con-pdn =3D <EXYNOS_PIN_PDN_PREV>;
> +               samsung,pin-pud-pdn =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-val =3D <1>;
> +       };
> +
> +       uart1_bus: uart1-bus-pins {
> +               samsung,pins =3D "gpg1-3", "gpg1-2", "gpg1-1", "gpg1-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +       };
> +
> +       i2c7_bus: i2c7-bus-pins {
> +               samsung,pins =3D "gpg1-5", "gpg1-4";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +
> +       aud_dmic_on: aud-dmic-on-pins {
> +               samsung,pins =3D "gpg2-1";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_OUTPUT>;
> +               samsung,pin-con-pdn =3D <EXYNOS_PIN_PDN_PREV>;
> +               samsung,pin-val =3D <1>;
> +       };
> +
> +       aud_dmic_off: aud-dmic-off-pins {
> +               samsung,pins =3D "gpg2-1";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_OUTPUT>;
> +               samsung,pin-con-pdn =3D <EXYNOS_PIN_PDN_PREV>;
> +               samsung,pin-val =3D <0>;
> +       };
> +
> +       /* UART_HEALTH */
> +       uart0_bus: uart0-bus-pins {
> +               samsung,pins =3D "gpp0-3", "gpp0-2", "gpp0-1", "gpp0-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +       };
> +
> +       i2c0_bus: i2c0-bus-pins {
> +               samsung,pins =3D "gpp1-1", "gpp1-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-con-pdn =3D <EXYNOS_PIN_PDN_PREV>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +
> +       i2c1_bus: i2c1-bus-pins {
> +               samsung,pins =3D "gpp1-3", "gpp1-2";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-con-pdn =3D <EXYNOS_PIN_PDN_PREV>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +
> +       i2c2_bus: i2c2-bus-pins {
> +               samsung,pins =3D "gpp2-1", "gpp2-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +
> +       i2c3_bus: i2c3-bus-pins {
> +               samsung,pins =3D "gpp3-1", "gpp3-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +
> +       i2c4_bus: i2c4-bus-pins {
> +               samsung,pins =3D "gpp4-1", "gpp4-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +
> +       i2c5_bus: i2c5-bus-pins {
> +               samsung,pins =3D "gpp4-3", "gpp4-2";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +
> +       i2c6_bus: i2c6-bus-pins {
> +               samsung,pins =3D "gpp4-5", "gpp4-4";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +
> +       /* SPI_ESE */
> +       spi0_bus: spi0-bus-pins {
> +               samsung,pins =3D "gpp5-3", "gpp5-2", "gpp5-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +
> +       spi0_cs: spi0-cs-pins {
> +               samsung,pins =3D "gpp5-1";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_OUTPUT>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +
> +       /* SPI_FP */
> +       spi1_bus: spi1-bus-pins {
> +               samsung,pins =3D "gpp6-3", "gpp6-2", "gpp6-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +
> +       spi1_cs: spi1-cs-pins {
> +               samsung,pins =3D "gpp6-1";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_OUTPUT>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +
> +       /* USI2 UART */
> +       uart5_bus_single: uart5-bus-single-pins {
> +               samsung,pins =3D "gpp8-1", "gpp8-0", "gpp7-1", "gpp7-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +         };
> +
> +       /* USI2 UART_HSI2C1 */
> +       uart5_bus_dual: uart5-bus-dual-pins {
> +               samsung,pins =3D "gpp7-1", "gpp7-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +       };
> +
> +       /* USI2 HSI2C0 */
> +       hs_i2c8_bus: hs-i2c8-bus-pins {
> +               samsung,pins =3D "gpp7-1", "gpp7-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <0>;
> +               samsung,pin-con-pdn =3D <EXYNOS_PIN_PDN_OUT1>;
> +               samsung,pin-pud-pdn =3D <EXYNOS_PIN_PULL_UP>;
> +       };
> +
> +       /* USI2 HSI2C1 */
> +       hs_i2c9_bus: hs-i2c9-bus-pins {
> +               samsung,pins =3D "gpp8-1", "gpp8-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <0>;
> +               samsung,pin-con-pdn =3D <EXYNOS_PIN_PDN_OUT1>;
> +               samsung,pin-pud-pdn =3D <EXYNOS_PIN_PULL_UP>;
> +       };
> +
> +       /* USI2 SPI */
> +       spi4_bus: spi4-bus-pins {
> +               samsung,pins =3D "gpp7-1", "gpp7-0", "gpp8-1";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +
> +       spi4_cs: spi4-cs-pins {
> +               samsung,pins =3D "gpp8-0";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_OUTPUT>;
> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv =3D <0>;
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/exynos/exynos7885.dtsi b/arch/arm64/boot=
/dts/exynos/exynos7885.dtsi
> new file mode 100644
> index 000000000000..cc7a5ce0c103
> --- /dev/null
> +++ b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
> @@ -0,0 +1,438 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung Exynos7885 SoC device tree source
> + *
> + * Copyright (c) 2021 Samsung Electronics Co., Ltd.
> + * Copyright (c) 2021 D=C3=A1vid Vir=C3=A1g
> + *

This line is not needed.

> + */
> +
> +#include <dt-bindings/clock/exynos7885.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +       compatible =3D "samsung,exynos7885";
> +       #address-cells =3D <2>;
> +       #size-cells =3D <1>;
> +
> +       interrupt-parent =3D <&gic>;
> +
> +       aliases {
> +               pinctrl0 =3D &pinctrl_alive;
> +               pinctrl1 =3D &pinctrl_dispaud;
> +               pinctrl2 =3D &pinctrl_fsys;
> +               pinctrl3 =3D &pinctrl_top;
> +       };
> +
> +       arm-a53-pmu {
> +               compatible =3D "arm,cortex-a53-pmu";
> +               interrupts =3D <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>;
> +               interrupt-affinity =3D <&cpu0>,
> +                                    <&cpu1>,
> +                                    <&cpu2>,
> +                                    <&cpu3>,
> +                                    <&cpu4>,
> +                                    <&cpu5>;

Maybe have cpu0..cpu3 on one line, and cpu4..cpu5 on second line?

> +       };
> +
> +       arm-a73-pmu {
> +               compatible =3D "arm,cortex-a73-pmu";
> +               interrupts =3D <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +               interrupt-affinity =3D <&cpu6>,
> +                                    <&cpu7>;

Both cpus can be on the same line here.

> +       };
> +
> +       cpus {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               cpu-map {
> +                       cluster0 {
> +                               core0 {
> +                                       cpu =3D <&cpu0>;
> +                               };
> +                               core1 {
> +                                       cpu =3D <&cpu1>;
> +                               };
> +                               core2 {
> +                                       cpu =3D <&cpu2>;
> +                               };
> +                               core3 {
> +                                       cpu =3D <&cpu3>;
> +                               };
> +                               core4 {
> +                                       cpu =3D <&cpu4>;
> +                               };
> +                               core5 {
> +                                       cpu =3D <&cpu5>;
> +                               };
> +                       };
> +
> +                       cluster1 {
> +                               core0 {
> +                                       cpu =3D <&cpu6>;
> +                               };
> +                               core1 {
> +                                       cpu =3D <&cpu7>;
> +                               };
> +                       };
> +               };
> +
> +               cpu0: cpu@100 {
> +                       device_type =3D "cpu";
> +                       compatible =3D "arm,cortex-a53";
> +                       reg =3D <0x100>;
> +                       enable-method =3D "psci";
> +               };
> +
> +               cpu1: cpu@101 {
> +                       device_type =3D "cpu";
> +                       compatible =3D "arm,cortex-a53";
> +                       reg =3D <0x101>;
> +                       enable-method =3D "psci";
> +               };
> +
> +               cpu2: cpu@102 {
> +                       device_type =3D "cpu";
> +                       compatible =3D "arm,cortex-a53";
> +                       reg =3D <0x102>;
> +                       enable-method =3D "psci";
> +               };
> +
> +               cpu3: cpu@103 {
> +                       device_type =3D "cpu";
> +                       compatible =3D "arm,cortex-a53";
> +                       reg =3D <0x103>;
> +                       enable-method =3D "psci";
> +               };
> +
> +               cpu4: cpu@200 {
> +                       device_type =3D "cpu";
> +                       compatible =3D "arm,cortex-a53";
> +                       reg =3D <0x200>;
> +                       enable-method =3D "psci";
> +               };
> +
> +               cpu5: cpu@201 {
> +                       device_type =3D "cpu";
> +                       compatible =3D "arm,cortex-a53";
> +                       reg =3D <0x201>;
> +                       enable-method =3D "psci";
> +               };
> +
> +               cpu6: cpu@0 {
> +                       device_type =3D "cpu";
> +                       compatible =3D "arm,cortex-a73";
> +                       reg =3D <0x0>;
> +                       enable-method =3D "psci";
> +               };
> +
> +               cpu7: cpu@1 {
> +                       device_type =3D "cpu";
> +                       compatible =3D "arm,cortex-a73";
> +                       reg =3D <0x1>;
> +                       enable-method =3D "psci";
> +               };
> +       };
> +
> +       psci {
> +               compatible =3D "arm,psci";
> +               method =3D "smc";
> +               cpu_suspend =3D <0xc4000001>;
> +               cpu_off =3D <0x84000002>;
> +               cpu_on =3D <0xc4000003>;
> +       };
> +
> +       timer {
> +               compatible =3D "arm,armv8-timer";
> +               /* Hypervisor Virtual Timer interrupt is not wired to GIC=
 */
> +               interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_=
TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TY=
PE_LEVEL_LOW)>,
> +                            <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TY=
PE_LEVEL_LOW)>,
> +                            <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TY=
PE_LEVEL_LOW)>;

Can you please make it fit 80 characters per line?

> +       };
> +
> +       fixed-rate-clocks {
> +               oscclk: osc-clock {
> +                       compatible =3D "fixed-clock";
> +                       #clock-cells =3D <0>;
> +                       clock-frequency =3D <26000000>;

Hmm, maybe it's better to set this clock frequency in board dts?

> +                       clock-output-names =3D "oscclk";
> +               };
> +       };
> +
> +       soc: soc@0 {
> +               compatible =3D "simple-bus";
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +               ranges =3D <0x0 0x0 0x0 0x20000000>;
> +
> +               chipid@10000000 {
> +                       compatible =3D "samsung,exynos850-chipid";
> +                       reg =3D <0x10000000 0x24>;
> +               };
> +
> +               gic: interrupt-controller@12301000 {
> +                       compatible =3D "arm,gic-400";
> +                       #interrupt-cells =3D <3>;
> +                       #address-cells =3D <0>;
> +                       interrupt-controller;
> +                       reg =3D <0x12301000 0x1000>,
> +                             <0x12302000 0x2000>,
> +                             <0x12304000 0x2000>,
> +                             <0x12306000 0x2000>;
> +                       interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8)=
 |
> +                                                IRQ_TYPE_LEVEL_HIGH)>;
> +               };
> +
> +               cmu_peri: clock-controller@10010000 {
> +                       compatible =3D "samsung,exynos7885-cmu-peri";
> +                       reg =3D <0x10010000 0x8000>;
> +                       #clock-cells =3D <1>;
> +
> +                       clocks =3D <&oscclk>,
> +                                <&cmu_top CLK_DOUT_PERI_BUS>,
> +                                <&cmu_top CLK_DOUT_PERI_SPI0>,
> +                                <&cmu_top CLK_DOUT_PERI_SPI1>,
> +                                <&cmu_top CLK_DOUT_PERI_UART0>,
> +                                <&cmu_top CLK_DOUT_PERI_UART1>,
> +                                <&cmu_top CLK_DOUT_PERI_UART2>,
> +                                <&cmu_top CLK_DOUT_PERI_USI0>,
> +                                <&cmu_top CLK_DOUT_PERI_USI1>,
> +                                <&cmu_top CLK_DOUT_PERI_USI2>;
> +                       clock-names =3D "oscclk",
> +                                     "dout_peri_bus",
> +                                     "dout_peri_spi0",
> +                                     "dout_peri_spi1",
> +                                     "dout_peri_uart0",
> +                                     "dout_peri_uart1",
> +                                     "dout_peri_uart2",
> +                                     "dout_peri_usi0",
> +                                     "dout_peri_usi1",
> +                                     "dout_peri_usi2";
> +               };
> +
> +               cmu_core: clock-controller@12000000 {
> +                       compatible =3D "samsung,exynos7885-cmu-core";
> +                       reg =3D <0x12000000 0x8000>;
> +                       #clock-cells =3D <1>;
> +
> +                       clocks =3D <&oscclk>,
> +                                <&cmu_top CLK_DOUT_CORE_BUS>,
> +                                <&cmu_top CLK_DOUT_CORE_CCI>,
> +                                <&cmu_top CLK_DOUT_CORE_G3D>;
> +                       clock-names =3D "oscclk", "dout_core_bus", "dout_=
core_cci", "dout_core_g3d";

80 characters per line, please. Also, please keep the style
consistent: in cmu_peri you have each clock per line, here all clocks
are on one line.

> +               };
> +
> +               cmu_top: clock-controller@12060000 {

I'd move cmu_top above, to be the first CMU node.

> +                       compatible =3D "samsung,exynos7885-cmu-top";
> +                       reg =3D <0x12060000 0x8000>;
> +                       #clock-cells =3D <1>;
> +
> +                       clocks =3D <&oscclk>;
> +                       clock-names =3D "oscclk";
> +               };
> +
> +               pinctrl_alive: pinctrl@11cb0000 {
> +                       compatible =3D "samsung,exynos7885-pinctrl";
> +                       reg =3D <0x11cb0000 0x1000>;
> +                       interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
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
> +                                    <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> +
> +                       wakeup-interrupt-controller {
> +                               compatible =3D "samsung,exynos7-wakeup-ei=
nt";
> +                               interrupt-parent =3D <&gic>;
> +                               interrupts =3D <GIC_SPI 130 IRQ_TYPE_LEVE=
L_HIGH>;
> +                       };
> +               };
> +
> +               pinctrl_dispaud: pinctrl@148f0000 {
> +                       compatible =3D "samsung,exynos7885-pinctrl";
> +                       reg =3D <0x148f0000 0x1000>;
> +                       interrupts =3D <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
> +               };
> +
> +               pinctrl_fsys: pinctrl@13430000 {
> +                       compatible =3D "samsung,exynos7885-pinctrl";
> +                       reg =3D <0x13430000 0x1000>;
> +                       interrupts =3D <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
> +               };
> +
> +               pinctrl_top: pinctrl@139b0000 {
> +                       compatible =3D "samsung,exynos7885-pinctrl";
> +                       reg =3D <0x139b0000 0x1000>;
> +                       interrupts =3D <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
> +               };
> +
> +               pmu_system_controller: system-controller@11c80000 {
> +                       compatible =3D "samsung,exynos7-pmu", "syscon";
> +                       reg =3D <0x11c80000 0x10000>;
> +               };
> +
> +               serial_0: serial@13800000 {
> +                       compatible =3D "samsung,exynos5433-uart";
> +                       reg =3D <0x13800000 0x100>;
> +                       interrupts =3D <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
> +                       pinctrl-names =3D "default";
> +                       pinctrl-0 =3D <&uart0_bus>;
> +                       clocks =3D <&cmu_peri CLK_GOUT_UART0_EXT_UCLK>,
> +                                <&cmu_peri CLK_GOUT_UART0_PCLK>;

AFAIU, usually PCLK is a bus clock. Are you sure it should be UART baud clo=
ck?

> +                       clock-names =3D "uart", "clk_uart_baud0";
> +                       samsung,uart-fifosize =3D <64>;
> +                       status =3D "disabled";
> +               };
> +
> +               serial_1: serial@13810000 {
> +                       compatible =3D "samsung,exynos5433-uart";
> +                       reg =3D <0x13810000 0x100>;
> +                       interrupts =3D <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
> +                       pinctrl-names =3D "default";
> +                       pinctrl-0 =3D <&uart1_bus>;
> +                       clocks =3D <&cmu_peri CLK_GOUT_UART1_EXT_UCLK>,
> +                                <&cmu_peri CLK_GOUT_UART1_PCLK>;
> +                       clock-names =3D "uart", "clk_uart_baud0";
> +                       samsung,uart-fifosize =3D <256>;
> +                       status =3D "disabled";
> +               };
> +
> +               serial_2: serial@13820000 {
> +                       compatible =3D "samsung,exynos5433-uart";
> +                       reg =3D <0x13820000 0x100>;
> +                       interrupts =3D <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>;
> +                       pinctrl-names =3D "default";
> +                       pinctrl-0 =3D <&uart2_bus>;
> +                       clocks =3D <&cmu_peri CLK_GOUT_UART2_EXT_UCLK>,
> +                                <&cmu_peri CLK_GOUT_UART2_PCLK>;
> +                       clock-names =3D "uart", "clk_uart_baud0";
> +                       samsung,uart-fifosize =3D <256>;
> +                       status =3D "disabled";
> +               };
> +
> +               i2c_0: i2c@13830000 {
> +                       compatible =3D "samsung,s3c2440-i2c";
> +                       reg =3D <0x13830000 0x100>;
> +                       interrupts =3D <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       pinctrl-names =3D "default";
> +                       pinctrl-0 =3D <&i2c0_bus>;
> +                       clocks =3D <&cmu_peri CLK_GOUT_I2C0_PCLK>;
> +                       clock-names =3D "i2c";
> +                       status =3D "disabled";
> +               };
> +
> +               i2c_1: i2c@13840000 {
> +                       compatible =3D "samsung,s3c2440-i2c";
> +                       reg =3D <0x13840000 0x100>;
> +                       interrupts =3D <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       pinctrl-names =3D "default";
> +                       pinctrl-0 =3D <&i2c1_bus>;
> +                       clocks =3D <&cmu_peri CLK_GOUT_I2C1_PCLK>;
> +                       clock-names =3D "i2c";
> +                       status =3D "disabled";
> +               };
> +
> +               i2c_2: i2c@13850000 {
> +                       compatible =3D "samsung,s3c2440-i2c";
> +                       reg =3D <0x13850000 0x100>;
> +                       interrupts =3D <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       pinctrl-names =3D "default";
> +                       pinctrl-0 =3D <&i2c2_bus>;
> +                       clocks =3D <&cmu_peri CLK_GOUT_I2C2_PCLK>;
> +                       clock-names =3D "i2c";
> +                       status =3D "disabled";
> +               };
> +
> +               i2c_3: i2c@13860000 {
> +                       compatible =3D "samsung,s3c2440-i2c";
> +                       reg =3D <0x13860000 0x100>;
> +                       interrupts =3D <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       pinctrl-names =3D "default";
> +                       pinctrl-0 =3D <&i2c3_bus>;
> +                       clocks =3D <&cmu_peri CLK_GOUT_I2C3_PCLK>;
> +                       clock-names =3D "i2c";
> +                       status =3D "disabled";
> +               };
> +
> +               i2c_4: i2c@13870000 {
> +                       compatible =3D "samsung,s3c2440-i2c";
> +                       reg =3D <0x13870000 0x100>;
> +                       interrupts =3D <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       pinctrl-names =3D "default";
> +                       pinctrl-0 =3D <&i2c4_bus>;
> +                       clocks =3D <&cmu_peri CLK_GOUT_I2C4_PCLK>;
> +                       clock-names =3D "i2c";
> +                       status =3D "disabled";
> +               };
> +
> +               i2c_5: i2c@13880000 {
> +                       compatible =3D "samsung,s3c2440-i2c";
> +                       reg =3D <0x13880000 0x100>;
> +                       interrupts =3D <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       pinctrl-names =3D "default";
> +                       pinctrl-0 =3D <&i2c5_bus>;
> +                       clocks =3D <&cmu_peri CLK_GOUT_I2C5_PCLK>;
> +                       clock-names =3D "i2c";
> +                       status =3D "disabled";
> +               };
> +
> +               i2c_6: i2c@13890000 {
> +                       compatible =3D "samsung,s3c2440-i2c";
> +                       reg =3D <0x13890000 0x100>;
> +                       interrupts =3D <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       pinctrl-names =3D "default";
> +                       pinctrl-0 =3D <&i2c6_bus>;
> +                       clocks =3D <&cmu_peri CLK_GOUT_I2C6_PCLK>;
> +                       clock-names =3D "i2c";
> +                       status =3D "disabled";
> +               };
> +
> +               i2c_7: i2c@11cd0000 {
> +                       compatible =3D "samsung,s3c2440-i2c";
> +                       reg =3D <0x11cd0000 0x100>;
> +                       interrupts =3D <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       pinctrl-names =3D "default";
> +                       pinctrl-0 =3D <&i2c7_bus>;
> +                       clocks =3D <&cmu_peri CLK_GOUT_I2C7_PCLK>;
> +                       clock-names =3D "i2c";
> +                       status =3D "disabled";
> +               };
> +       };
> +};
> +
> +#include "exynos7885-pinctrl.dtsi"
> +#include "arm/exynos-syscon-restart.dtsi"

Have you verified both reboot and power off functions from this file?
I guess if some doesn't work, it's better to avoid including this, but
instead add corresponding sub-nodes into your pmu_sytem_controller.

> --
> 2.34.1
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EFE46C780
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242205AbhLGWeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbhLGWeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:34:16 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1EDC061574;
        Tue,  7 Dec 2021 14:30:45 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id y196so467406wmc.3;
        Tue, 07 Dec 2021 14:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Y3hL06RbfROwj+BQcnLxGHrnifEouO8pyaEmtlV9DIA=;
        b=PjrvDhMlRlk7dBOA6f0NjAvcrLqeTsGtoCjJr/aCmp8IcZKJXB6b8x0lbJef75o4N2
         Hcbmguz5QCtf3GPSHE1JVqADVDr8xULFC+hHW/J0sBxmJpPNiPT92dpTd7IawioObyaf
         Zg/YZQ9NexK7grG2a0v+bugSJ/uzBRaXxmpTko3Duad+gxjqDmotkltDQmgWSInJFwKj
         aynUap0gwDLZlYVeYh0DXkas27cnPPOI0aDEL3/JiNMT/1CrWSv4YDIEc398Kpy1KjbO
         067J1MK5ViH8huVo4XCt/v856n24lg6nDChbM7mnYC7eS2yN19ukJmPnPClzoD0gDeQ8
         n5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Y3hL06RbfROwj+BQcnLxGHrnifEouO8pyaEmtlV9DIA=;
        b=P0LTokwFzHutYKH1HES+BeTjd1kHH+qXISYHEP1E4XriLUv8813HA6CWdsUM23dEeL
         nh6fe3fYqtzenA1tlbrYtrN4VnzmlCLmt7pHtDcbFMS6SHT0bOybRbwwiN1cUFi9os9v
         0k3EAkfZDl+x0F7g5mmrzMjZIr5P5AlHvW6tqeIAh3ftIioCOrA2GUJrBxvKe+UO0QPb
         mm5BqFRXXb/GoqKzfJW9JqbKUYidTX3L3l+bpsx9Sgq4XHlj870BuktrWhXksCEeDV4K
         UcvRuXyW9suIyBL4h+R6PKgbQoVs3N4a/puJSwSqRoEWkEK/93wPBhq+EDEf0Li/5HA/
         NdBw==
X-Gm-Message-State: AOAM532/5RzCN+uqt9U741I9Bb/FgaAujMlnxuwbU3/bMEJoq7a8sFIq
        PUB8VNTMUQ729Ejetk7Wv1E=
X-Google-Smtp-Source: ABdhPJz8c7aRghEbl2ZqXUwB+aeQMXlLTJNHbg1JUzlozU9LUMQ2VWNzRf7DNvgGAPRMLERBS1B5BA==
X-Received: by 2002:a05:600c:1c13:: with SMTP id j19mr10600792wms.175.1638916243533;
        Tue, 07 Dec 2021 14:30:43 -0800 (PST)
Received: from ?IPv6:2a02:ab88:368f:2080:eab:126a:947d:3008? ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.gmail.com with ESMTPSA id o12sm977893wmq.12.2021.12.07.14.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 14:30:42 -0800 (PST)
Message-ID: <916c297dc20acdbebd29cd2b36c6286380c7c318.camel@gmail.com>
Subject: Re: [PATCH v4 7/7] arm64: dts: exynos: Add initial device tree
 support for Exynos7885 SoC
From:   David Virag <virag.david003@gmail.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>
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
Date:   Tue, 07 Dec 2021 23:29:56 +0100
In-Reply-To: <CAPLW+4k3Vmg0W0jVsTChHTG8+eeg=5QF+actz1Tk0vNV9w-y-A@mail.gmail.com>
References: <20211206153124.427102-1-virag.david003@gmail.com>
         <20211206153124.427102-8-virag.david003@gmail.com>
         <CAPLW+4k3Vmg0W0jVsTChHTG8+eeg=5QF+actz1Tk0vNV9w-y-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-12-07 at 22:19 +0200, Sam Protsenko wrote:
> On Mon, 6 Dec 2021 at 17:32, David Virag <virag.david003@gmail.com>
> wrote:
> > 
> > Add initial Exynos7885 device tree nodes with dts for the Samsung
> > Galaxy
> > A8 (2018), a.k.a. "jackpotlte", with model number "SM-A530F".
> > Currently this includes some clock support, UART support, and I2C
> > nodes.
> > 
> > Signed-off-by: David Virag <virag.david003@gmail.com>
> > ---
> > Changes in v2:
> >   - Remove address-cells, and size-cells from dts, since they are
> >     already in the dtsi.
> >   - Lower case hex in memory node
> >   - Fix node names with underscore instead of hyphen
> >   - Fix line breaks
> >   - Fix "-key" missing from gpio keys node names
> >   - Use the form without "key" in gpio key labels on all keys
> >   - Suffix pin configuration node names with "-pins"
> >   - Remove "fimc_is_mclk" nodes from pinctrl dtsi for now
> >   - Use macros for "samsung,pin-con-pdn", and "samsung,pin-con-pdn"
> >   - Add comment about Arm PMU
> >   - Rename "clock-oscclk" to "osc-clock"
> >   - Include exynos-syscon-restart.dtsi instead of rewriting its
> > contents
> > 
> > Changes in v3:
> >   - Fix typo (seperate -> separate)
> > 
> > Changes in v4:
> >   - Fixed leading 0x in clock-controller nodes
> >   - Actually suffixed pin configuration node names with "-pins"
> >   - Seperated Cortex-A53 and Cortex-A73 PMU
> > 
> >  arch/arm64/boot/dts/exynos/Makefile           |   7 +-
> >  .../boot/dts/exynos/exynos7885-jackpotlte.dts |  95 ++
> >  .../boot/dts/exynos/exynos7885-pinctrl.dtsi   | 865
> > ++++++++++++++++++
> >  arch/arm64/boot/dts/exynos/exynos7885.dtsi    | 438 +++++++++
> >  4 files changed, 1402 insertions(+), 3 deletions(-)
> >  create mode 100644 arch/arm64/boot/dts/exynos/exynos7885-
> > jackpotlte.dts
> 
> Shouldn't SoC and board files be sent as two separate patches? For
> example, I've checked exynos5433 and exynos7, SoC support

For some reason I remembered ExynosAutoV9 sending them together but I
was wrong, will seperate in the future.

> 
> >  create mode 100644 arch/arm64/boot/dts/exynos/exynos7885-
> > pinctrl.dtsi
> >  create mode 100644 arch/arm64/boot/dts/exynos/exynos7885.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/exynos/Makefile
> > b/arch/arm64/boot/dts/exynos/Makefile
> > index b41e86df0a84..c68c4ad577ac 100644
> > --- a/arch/arm64/boot/dts/exynos/Makefile
> > +++ b/arch/arm64/boot/dts/exynos/Makefile
> > @@ -1,6 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  dtb-$(CONFIG_ARCH_EXYNOS) += \
> > -       exynos5433-tm2.dtb      \
> > -       exynos5433-tm2e.dtb     \
> > -       exynos7-espresso.dtb    \
> > +       exynos5433-tm2.dtb              \
> > +       exynos5433-tm2e.dtb             \
> > +       exynos7-espresso.dtb            \
> > +       exynos7885-jackpotlte.dtb       \
> >         exynosautov9-sadk.dtb
> > diff --git a/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
> > b/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
> > new file mode 100644
> > index 000000000000..f5941dc4c374
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
> > @@ -0,0 +1,95 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Samsung Galaxy A8 2018 (jackpotlte/SM-A530F) device tree source
> > + *
> > + * Copyright (c) 2021 Samsung Electronics Co., Ltd.
> > + * Copyright (c) 2021 Dávid Virág
> > + *
> 
> This line is not needed.
> 
> > + */
> > +
> > +/dts-v1/;
> 
> Suggest adding empty line here.
> 
> > +#include "exynos7885.dtsi"
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +/ {
> > +       model = "Samsung Galaxy A8 (2018)";
> > +       compatible = "samsung,jackpotlte", "samsung,exynos7885";
> > +       chassis-type = "handset";
> > +
> > +       aliases {
> > +               serial0 = &serial_0;
> > +               serial1 = &serial_1;
> > +               serial2 = &serial_2;
> 
> Suggestion: add aliases also for i2c nodes, to keep i2c instance
> numbers fixed in run-time (e.g. in "i2cdetect -l" output).
> 
> > +       };
> > +
> > +       chosen {
> > +               stdout-path = &serial_2;
> > +       };
> > +
> > +       memory@80000000 {
> > +               device_type = "memory";
> > +               reg = <0x0 0x80000000 0x3da00000>,
> > +                     <0x0 0xc0000000 0x40000000>,
> > +                     <0x8 0x80000000 0x40000000>;
> > +       };
> > +
> > +       gpio-keys {
> > +               compatible = "gpio-keys";
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&key_volup &key_voldown &key_power>;
> > +
> > +               volup-key {
> > +                       label = "Volume Up";
> > +                       interrupts = <5 IRQ_TYPE_LEVEL_HIGH 0>;
> 
> Here and below: what is 0, why it's needed? Also, isn't it enough to
> have just "gpios", and remove interrupt*? Need to check "gpio-keys"
> driver and bindings doc, but AFAIR it should be enough to have just
> "gpios =" or just "interrupts =".

Well, if we have both an interrupt and gpio access, why not provide
both? According to the documentation, `Specifying both properties is
allowed.`

> 
> 
> > +                       interrupt-parent = <&gpa1>;
> > +                       linux,code = <KEY_VOLUMEUP>;
> > +                       gpios = <&gpa1 5 GPIO_ACTIVE_LOW>;
> > +               };
> > +
> > +               voldown-key {
> > +                       label = "Volume Down";
> > +                       interrupts = <6 IRQ_TYPE_LEVEL_HIGH 0>;
> > +                       interrupt-parent = <&gpa1>;
> > +                       linux,code = <KEY_VOLUMEDOWN>;
> > +                       gpios = <&gpa1 6 GPIO_ACTIVE_LOW>;
> > +               };
> > +
> > +               power-key {
> > +                       label = "Power";
> > +                       interrupts = <7 IRQ_TYPE_LEVEL_HIGH 0>;
> > +                       interrupt-parent = <&gpa1>;
> > +                       linux,code = <KEY_POWER>;
> > +                       gpios = <&gpa1 7 GPIO_ACTIVE_LOW>;
> > +                       wakeup-source;
> > +               };
> > +       };
> > +};
> > +
> 
> If there are some LEDs by chance on that board -- it might be useful
> to define those here with "gpio-leds" as well. Maybe even set some
> default trigger like "heartbeat".

There is a front RGB led, but IIRC that is accessed through the S2MU004
MFD using I2C. There's also a rear "ktd2692" flash, which might or
might not be controllable using that, will need to check that one.

> 
> > +&serial_2 {
> > +       status = "okay";
> > +};
> > +
> > +&pinctrl_alive {
> > +       key_volup: key-volup-pins {
> > +               samsung,pins = "gpa1-5";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
> 
> Maybe EXYNOS_PIN_FUNC_EINT is more self-explanatory? Just a
> suggestion though.

Was wondering about this too, but a quick grep showed that
EXYNOS_PIN_FUNC_EINT was not used in any dts, and in fact only used in
"drivers/pinctrl/samsung/pinctrl-exynos.c". The one that was used in
dts/dtsis is EXYNOS_PIN_FUNC_F.

> 
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <0>;
> 
> Here and below: please use EXYNOS5420_PIN_DRV_LV1 (means drive level
> = 1x).

Just found "exynos_gpio_config_macros.dtsi" in the downstream code not
long ago, I guess you are right!

> 
> > +       };
> > +
> > +       key_voldown: key-voldown-pins {
> > +               samsung,pins = "gpa1-6";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +
> > +       key_power: key-power-pins {
> > +               samsung,pins = "gpa1-7";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +};
> > diff --git a/arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi
> > b/arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi
> > new file mode 100644
> > index 000000000000..8336b2e48858
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi
> > @@ -0,0 +1,865 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Samsung Exynos7885 SoC pin-mux and pin-config device tree
> > source
> > + *
> > + * Copyright (c) 2017 Samsung Electronics Co., Ltd.
> > + * Copyright (c) 2021 Dávid Virág
> > + *
> > + * Samsung's Exynos7885 SoC pin-mux and pin-config options are
> > listed as
> > + * device tree nodes in this file.
> > + */
> > +
> > +#include <dt-bindings/pinctrl/samsung.h>
> 
> You probably also need <dt-bindings/interrupt-controller/arm-gic.h>
> here for GIC_SPI definition.

Good catch! Will add it!

> 
> > +
> > +&pinctrl_alive {
> > +       etc0: etc0 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       etc1: etc1 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> 
> Hmm, what are these two? I can't find anything related in
> exynos7885.dtsi. If it's just some leftover from downstream vendor
> kernel -- please remove it.

They are real pins (as in they do something inside the SoC for sure),
but don't seem to be used for much. Some dtsis show  "AP_JTAG_TRST_N"
being on etc0-0. I'm guessing these are some kind of debug pins? Have
you seen anything about them on the 850?

> 
> > +
> > +       gpa0: gpa0 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +               interrupt-parent = <&gic>;
> > +               interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> > +       };
> > +
> > +       gpa1: gpa1 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <3>;
> > +               interrupt-parent = <&gic>;
> > +               interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> > +       };
> > +
> > +       gpa2: gpa2 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       gpq0: gpq0 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       sim1_det_gpio: sim1-det-gpio-pins {
> > +               samsung,pins = "gpa2-5";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +       };
> > +
> > +       sim0_det_gpio: sim0-det-gpio-pins {
> > +               samsung,pins = "gpa2-6";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +       };
> > +
> > +       speedy_bus: speedy-bus-pins {
> > +               samsung,pins = "gpq0-2";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-con-pdn = <EXYNOS_PIN_PDN_PREV>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <0>;
> 
> Here and below: suggest using EXYNOS5420_PIN_DRV_LV* constants. Then
> stuff like "sd1_clk_fast_slew_rate_4x" is going to make sense.
> 
> > +       };
> > +
> > +       /* UART_DEBUG */
> > +       uart2_bus: uart2-bus-pins {
> > +               samsung,pins = "gpq0-4", "gpq0-3";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +       };
> > +};
> > +
> > +&pinctrl_dispaud {
> > +       gpb0: gpb0 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       gpb1: gpb1 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       gpb2: gpb2 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       aud_codec_mclk: aud-codec-mclk-pins {
> > +               samsung,pins = "gpb0-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +       };
> > +
> > +       aud_codec_mclk_idle: aud-codec-mclk-idle-pins {
> > +               samsung,pins = "gpb0-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +       };
> > +
> > +       aud_codec_bus: aud-codec-bus-pins {
> > +               samsung,pins = "gpb0-1", "gpb0-2", "gpb0-3", "gpb0-
> > 4";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +       };
> > +
> > +       aud_codec_bus_idle: aud-codec-bus-idle-pins {
> > +               samsung,pins = "gpb0-1", "gpb0-2", "gpb0-3", "gpb0-
> > 4";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +       };
> > +
> > +       aud_loopback_bus: aud-loopback-bus-pins {
> > +               samsung,pins = "gpb1-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +       };
> > +
> > +       aud_loopback_bus_idle: aud-loopback-bus-idle-pins {
> > +               samsung,pins = "gpb1-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +       };
> > +
> > +       aud_fm_bus: aud-fm-bus-pins {
> > +               samsung,pins = "gpb1-1", "gpb1-2", "gpb1-3";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +       };
> > +
> > +       aud_fm_bus_idle: aud-fm-bus-idle-pins {
> > +               samsung,pins = "gpb1-1", "gpb1-2", "gpb1-3";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +       };
> > +
> > +       aud_spk_bus: aud-spk-bus-pins {
> > +               samsung,pins = "gpb2-0", "gpb2-1", "gpb2-2", "gpb2-
> > 3";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +       };
> > +
> > +       aud_spk_bus_idle: aud-spk-bus-idle-pins {
> > +               samsung,pins = "gpb2-0", "gpb2-1", "gpb2-2", "gpb2-
> > 3";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +       };
> > +};
> > +
> > +&pinctrl_fsys {
> > +       gpf0: gpf0 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       gpf2: gpf2 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       gpf3: gpf3 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       gpf4: gpf4 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       sd0_clk: sd0-clk-pins {
> > +               samsung,pins = "gpf0-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <3>;
> > +       };
> > +
> > +       sd0_clk_fast_slew_rate_1x: sd0-clk-fast-slew-rate-1x-pins {
> > +               samsung,pins = "gpf0-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +
> > +       sd0_clk_fast_slew_rate_2x: sd0-clk-fast-slew-rate-2x-pins {
> > +               samsung,pins = "gpf0-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <1>;
> > +       };
> > +
> > +       sd0_clk_fast_slew_rate_3x: sd0-clk-fast-slew-rate-3x-pins {
> > +               samsung,pins = "gpf0-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <2>;
> > +       };
> > +
> > +       sd0_clk_fast_slew_rate_4x: sd0-clk-fast-slew-rate-4x-pins {
> > +               samsung,pins = "gpf0-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <3>;
> > +       };
> > +
> > +       sd0_cmd: sd0-cmd-pins {
> > +               samsung,pins = "gpf0-1";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <3>;
> > +       };
> > +
> > +       sd0_rdqs: sd0-rdqs-pins {
> > +               samsung,pins = "gpf0-2";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +               samsung,pin-drv = <3>;
> > +       };
> > +
> > +       sd0_bus1: sd0-bus-width1-pins {
> > +               samsung,pins = "gpf2-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <3>;
> > +       };
> > +
> > +       sd0_bus4: sd0-bus-width4-pins {
> > +               samsung,pins = "gpf2-1", "gpf2-2", "gpf2-3";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <3>;
> > +       };
> > +
> > +       sd0_bus8: sd0-bus-width8-pins {
> > +               samsung,pins = "gpf2-4", "gpf2-5", "gpf2-6", "gpf2-
> > 7";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <3>;
> > +       };
> > +
> > +       sd1_clk: sd1-clk-pins {
> > +               samsung,pins = "gpf3-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <2>;
> > +       };
> > +
> > +       sd1_clk_fast_slew_rate_1x: sd1-clk-fast-slew-rate-1x-pins {
> > +               samsung,pins = "gpf3-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +
> > +       sd1_clk_fast_slew_rate_2x: sd1-clk-fast-slew-rate-2x-pins {
> > +               samsung,pins = "gpf3-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <1>;
> > +       };
> > +
> > +       sd1_clk_fast_slew_rate_3x: sd1-clk-fast-slew-rate-3x-pins {
> > +               samsung,pins = "gpf3-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <2>;
> > +       };
> > +
> > +       sd1_clk_fast_slew_rate_4x: sd1-clk-fast-slew-rate-4x-pins {
> > +               samsung,pins = "gpf3-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <3>;
> > +       };
> > +
> > +       sd1_cmd: sd1-cmd-pins {
> > +               samsung,pins = "gpf3-1";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <2>;
> > +       };
> > +
> > +       sd1_bus1: sd1-bus-width1-pins {
> > +               samsung,pins = "gpf3-2";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <2>;
> > +       };
> > +
> > +       sd1_bus4: sd1-bus-width4-pins {
> > +               samsung,pins = "gpf3-3", "gpf3-5";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <2>;
> > +       };
> > +
> > +       sd2_clk: sd2-clk-pins {
> > +               samsung,pins = "gpf4-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <2>;
> > +       };
> > +
> > +       sd2_clk_fast_slew_rate_1x: sd2-clk-fast-slew-rate-1x-pins {
> > +               samsung,pins = "gpf4-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +
> > +       sd2_clk_fast_slew_rate_2x: sd2-clk-fast-slew-rate-2x-pins {
> > +               samsung,pins = "gpf4-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <1>;
> > +       };
> > +
> > +       sd2_clk_fast_slew_rate_3x: sd2-clk-fast-slew-rate-3x-pins {
> > +               samsung,pins = "gpf4-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <2>;
> > +       };
> > +
> > +       sd2_clk_fast_slew_rate_4x: sd2-clk-fast-slew-rate-4x-pins {
> > +               samsung,pins = "gpf4-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <3>;
> > +       };
> > +
> > +       sd2_cmd: sd2-cmd-pins {
> > +               samsung,pins = "gpf4-1";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <2>;
> > +       };
> > +
> > +       sd2_bus1: sd2-bus-width1-pins {
> > +               samsung,pins = "gpf4-2";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <2>;
> > +       };
> > +
> > +       sd2_bus4: sd2-bus-width4-pins {
> > +               samsung,pins = "gpf4-3", "gpf4-4", "gpf4-5";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <2>;
> > +       };
> > +};
> > +
> > +&pinctrl_top {
> > +       gpc0: gpc0 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       gpc1: gpc1 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       gpc2: gpc2 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       gpg0: gpg0 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       gpg1: gpg1 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       gpg2: gpg2 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       gpg3: gpg3 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       gpg4: gpg4 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       gpp0: gpp0 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       gpp1: gpp1 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       gpp2: gpp2 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       gpp3: gpp3 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       gpp4: gpp4 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       gpp5: gpp5 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       gpp6: gpp6 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       gpp7: gpp7 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       gpp8: gpp8 {
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells = <2>;
> > +       };
> > +
> > +       /* DECON TE */
> > +       decon_f_te_on: decon_f_te_on-pins {
> > +               samsung,pins = "gpc0-3";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
> > +       };
> > +
> > +       decon_f_te_off: decon_f_te_off-pins {
> > +               samsung,pins = "gpc0-3";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> > +       };
> > +
> > +       hs_i2c0_bus: hs-i2c0-bus-pins {
> > +               samsung,pins = "gpc1-1", "gpc1-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-con-pdn = <EXYNOS_PIN_PDN_OUT1>;
> > +               samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +
> > +       hs_i2c1_bus: hs-i2c1-bus-pins {
> > +               samsung,pins = "gpc1-3", "gpc1-2";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <0>;
> > +               samsung,pin-con-pdn = <EXYNOS_PIN_PDN_OUT1>;
> > +               samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_UP>;
> > +       };
> > +
> > +       hs_i2c2_bus: hs-i2c2-bus-pins {
> > +               samsung,pins = "gpc1-5", "gpc1-4";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <0>;
> > +               samsung,pin-con-pdn = <EXYNOS_PIN_PDN_OUT1>;
> > +               samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_UP>;
> > +       };
> > +
> > +       hs_i2c3_bus: hs-i2c3-bus-pins {
> > +               samsung,pins = "gpc1-7", "gpc1-6";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <0>;
> > +               samsung,pin-con-pdn = <EXYNOS_PIN_PDN_OUT1>;
> > +               samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_UP>;
> > +       };
> > +
> > +       /* USI0 UART */
> > +       uart3_bus_single: uart3-bus-single-pins {
> > +               samsung,pins = "gpc2-3", "gpc2-2", "gpc2-1", "gpc2-
> > 0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +       };
> > +
> > +       /* USI0 UART_HSI2C1 */
> > +       uart3_bus_dual: uart3-bus-dual-pins {
> > +               samsung,pins = "gpc2-1", "gpc2-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +       };
> > +
> > +       /* USI0 HSI2C0 */
> > +       hs_i2c4_bus: hs-i2c4-bus-pins {
> > +               samsung,pins = "gpc2-1", "gpc2-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <0>;
> > +               samsung,pin-con-pdn = <EXYNOS_PIN_PDN_OUT1>;
> > +               samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_UP>;
> > +       };
> > +
> > +       /* USI0 HSI2C1 */
> > +       hs_i2c5_bus: hs-i2c5-bus-pins {
> > +               samsung,pins = "gpc2-3", "gpc2-2";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <0>;
> > +               samsung,pin-con-pdn = <EXYNOS_PIN_PDN_OUT1>;
> > +               samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_UP>;
> > +       };
> > +
> > +       /* USI0 SPI */
> > +       spi2_bus: spi2-bus-pins {
> > +               samsung,pins = "gpc2-1", "gpc2-0", "gpc2-3";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +
> > +       spi2_cs: spi2-cs-pins {
> > +               samsung,pins = "gpc2-2";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +
> > +       /* USI1 UART */
> > +       uart4_bus_single: uart4-bus-single-pins {
> > +               samsung,pins = "gpc2-7", "gpc2-6", "gpc2-5", "gpc2-
> > 4";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +       };
> > +
> > +       /* USI1 UART_HSI2C1*/
> > +       uart4_bus_dual: uart4-bus-dual-pins {
> > +               samsung,pins = "gpc2-5", "gpc2-4";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +       };
> > +
> > +       /* USI1 HSI2C0 */
> > +       hs_i2c6_bus: hs-i2c6-bus-pins {
> > +               samsung,pins = "gpc2-5", "gpc2-4";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <0>;
> > +               samsung,pin-con-pdn = <EXYNOS_PIN_PDN_OUT1>;
> > +               samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_UP>;
> > +       };
> > +
> > +       /* USI1 HSI2C1 */
> > +       hs_i2c7_bus: hs-i2c7-bus-pins {
> > +               samsung,pins = "gpc2-7", "gpc2-6";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <0>;
> > +               samsung,pin-con-pdn = <EXYNOS_PIN_PDN_OUT1>;
> > +               samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_UP>;
> > +       };
> > +
> > +       /* USI1 SPI */
> > +       spi3_bus: spi3-bus-pins {
> > +               samsung,pins = "gpc2-5", "gpc2-4", "gpc2-7";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +
> > +       spi3_cs: spi3-cs-pins {
> > +               samsung,pins = "gpc2-6";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +
> > +       fm_lna_en: fm-lna-en-pins {
> > +               samsung,pins = "gpg0-2";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +               samsung,pin-con-pdn = <EXYNOS_PIN_PDN_PREV>;
> > +               samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-val = <1>;
> > +       };
> > +
> > +       uart1_bus: uart1-bus-pins {
> > +               samsung,pins = "gpg1-3", "gpg1-2", "gpg1-1", "gpg1-
> > 0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +       };
> > +
> > +       i2c7_bus: i2c7-bus-pins {
> > +               samsung,pins = "gpg1-5", "gpg1-4";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +
> > +       aud_dmic_on: aud-dmic-on-pins {
> > +               samsung,pins = "gpg2-1";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> > +               samsung,pin-con-pdn = <EXYNOS_PIN_PDN_PREV>;
> > +               samsung,pin-val = <1>;
> > +       };
> > +
> > +       aud_dmic_off: aud-dmic-off-pins {
> > +               samsung,pins = "gpg2-1";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> > +               samsung,pin-con-pdn = <EXYNOS_PIN_PDN_PREV>;
> > +               samsung,pin-val = <0>;
> > +       };
> > +
> > +       /* UART_HEALTH */
> > +       uart0_bus: uart0-bus-pins {
> > +               samsung,pins = "gpp0-3", "gpp0-2", "gpp0-1", "gpp0-
> > 0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +       };
> > +
> > +       i2c0_bus: i2c0-bus-pins {
> > +               samsung,pins = "gpp1-1", "gpp1-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-con-pdn = <EXYNOS_PIN_PDN_PREV>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +
> > +       i2c1_bus: i2c1-bus-pins {
> > +               samsung,pins = "gpp1-3", "gpp1-2";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-con-pdn = <EXYNOS_PIN_PDN_PREV>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +
> > +       i2c2_bus: i2c2-bus-pins {
> > +               samsung,pins = "gpp2-1", "gpp2-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +
> > +       i2c3_bus: i2c3-bus-pins {
> > +               samsung,pins = "gpp3-1", "gpp3-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +
> > +       i2c4_bus: i2c4-bus-pins {
> > +               samsung,pins = "gpp4-1", "gpp4-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +
> > +       i2c5_bus: i2c5-bus-pins {
> > +               samsung,pins = "gpp4-3", "gpp4-2";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +
> > +       i2c6_bus: i2c6-bus-pins {
> > +               samsung,pins = "gpp4-5", "gpp4-4";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +
> > +       /* SPI_ESE */
> > +       spi0_bus: spi0-bus-pins {
> > +               samsung,pins = "gpp5-3", "gpp5-2", "gpp5-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +
> > +       spi0_cs: spi0-cs-pins {
> > +               samsung,pins = "gpp5-1";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +
> > +       /* SPI_FP */
> > +       spi1_bus: spi1-bus-pins {
> > +               samsung,pins = "gpp6-3", "gpp6-2", "gpp6-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +
> > +       spi1_cs: spi1-cs-pins {
> > +               samsung,pins = "gpp6-1";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +
> > +       /* USI2 UART */
> > +       uart5_bus_single: uart5-bus-single-pins {
> > +               samsung,pins = "gpp8-1", "gpp8-0", "gpp7-1", "gpp7-
> > 0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +         };
> > +
> > +       /* USI2 UART_HSI2C1 */
> > +       uart5_bus_dual: uart5-bus-dual-pins {
> > +               samsung,pins = "gpp7-1", "gpp7-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +       };
> > +
> > +       /* USI2 HSI2C0 */
> > +       hs_i2c8_bus: hs-i2c8-bus-pins {
> > +               samsung,pins = "gpp7-1", "gpp7-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <0>;
> > +               samsung,pin-con-pdn = <EXYNOS_PIN_PDN_OUT1>;
> > +               samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_UP>;
> > +       };
> > +
> > +       /* USI2 HSI2C1 */
> > +       hs_i2c9_bus: hs-i2c9-bus-pins {
> > +               samsung,pins = "gpp8-1", "gpp8-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <0>;
> > +               samsung,pin-con-pdn = <EXYNOS_PIN_PDN_OUT1>;
> > +               samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_UP>;
> > +       };
> > +
> > +       /* USI2 SPI */
> > +       spi4_bus: spi4-bus-pins {
> > +               samsung,pins = "gpp7-1", "gpp7-0", "gpp8-1";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +
> > +       spi4_cs: spi4-cs-pins {
> > +               samsung,pins = "gpp8-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +               samsung,pin-drv = <0>;
> > +       };
> > +};
> > diff --git a/arch/arm64/boot/dts/exynos/exynos7885.dtsi
> > b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
> > new file mode 100644
> > index 000000000000..cc7a5ce0c103
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
> > @@ -0,0 +1,438 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Samsung Exynos7885 SoC device tree source
> > + *
> > + * Copyright (c) 2021 Samsung Electronics Co., Ltd.
> > + * Copyright (c) 2021 Dávid Virág
> > + *
> 
> This line is not needed.
> 
> > + */
> > +
> > +#include <dt-bindings/clock/exynos7885.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +/ {
> > +       compatible = "samsung,exynos7885";
> > +       #address-cells = <2>;
> > +       #size-cells = <1>;
> > +
> > +       interrupt-parent = <&gic>;
> > +
> > +       aliases {
> > +               pinctrl0 = &pinctrl_alive;
> > +               pinctrl1 = &pinctrl_dispaud;
> > +               pinctrl2 = &pinctrl_fsys;
> > +               pinctrl3 = &pinctrl_top;
> > +       };
> > +
> > +       arm-a53-pmu {
> > +               compatible = "arm,cortex-a53-pmu";
> > +               interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>;
> > +               interrupt-affinity = <&cpu0>,
> > +                                    <&cpu1>,
> > +                                    <&cpu2>,
> > +                                    <&cpu3>,
> > +                                    <&cpu4>,
> > +                                    <&cpu5>;
> 
> Maybe have cpu0..cpu3 on one line, and cpu4..cpu5 on second line?
> 
> > +       };
> > +
> > +       arm-a73-pmu {
> > +               compatible = "arm,cortex-a73-pmu";
> > +               interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> > +               interrupt-affinity = <&cpu6>,
> > +                                    <&cpu7>;
> 
> Both cpus can be on the same line here.
> 
> > +       };
> > +
> > +       cpus {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               cpu-map {
> > +                       cluster0 {
> > +                               core0 {
> > +                                       cpu = <&cpu0>;
> > +                               };
> > +                               core1 {
> > +                                       cpu = <&cpu1>;
> > +                               };
> > +                               core2 {
> > +                                       cpu = <&cpu2>;
> > +                               };
> > +                               core3 {
> > +                                       cpu = <&cpu3>;
> > +                               };
> > +                               core4 {
> > +                                       cpu = <&cpu4>;
> > +                               };
> > +                               core5 {
> > +                                       cpu = <&cpu5>;
> > +                               };
> > +                       };
> > +
> > +                       cluster1 {
> > +                               core0 {
> > +                                       cpu = <&cpu6>;
> > +                               };
> > +                               core1 {
> > +                                       cpu = <&cpu7>;
> > +                               };
> > +                       };
> > +               };
> > +
> > +               cpu0: cpu@100 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       reg = <0x100>;
> > +                       enable-method = "psci";
> > +               };
> > +
> > +               cpu1: cpu@101 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       reg = <0x101>;
> > +                       enable-method = "psci";
> > +               };
> > +
> > +               cpu2: cpu@102 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       reg = <0x102>;
> > +                       enable-method = "psci";
> > +               };
> > +
> > +               cpu3: cpu@103 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       reg = <0x103>;
> > +                       enable-method = "psci";
> > +               };
> > +
> > +               cpu4: cpu@200 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       reg = <0x200>;
> > +                       enable-method = "psci";
> > +               };
> > +
> > +               cpu5: cpu@201 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       reg = <0x201>;
> > +                       enable-method = "psci";
> > +               };
> > +
> > +               cpu6: cpu@0 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a73";
> > +                       reg = <0x0>;
> > +                       enable-method = "psci";
> > +               };
> > +
> > +               cpu7: cpu@1 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a73";
> > +                       reg = <0x1>;
> > +                       enable-method = "psci";
> > +               };
> > +       };
> > +
> > +       psci {
> > +               compatible = "arm,psci";
> > +               method = "smc";
> > +               cpu_suspend = <0xc4000001>;
> > +               cpu_off = <0x84000002>;
> > +               cpu_on = <0xc4000003>;
> > +       };
> > +
> > +       timer {
> > +               compatible = "arm,armv8-timer";
> > +               /* Hypervisor Virtual Timer interrupt is not wired
> > to GIC */
> > +               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) |
> > IRQ_TYPE_LEVEL_LOW)>,
> > +                            <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) |
> > IRQ_TYPE_LEVEL_LOW)>,
> > +                            <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) |
> > IRQ_TYPE_LEVEL_LOW)>,
> > +                            <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) |
> > IRQ_TYPE_LEVEL_LOW)>;
> 
> Can you please make it fit 80 characters per line?

Sure, these are easy to miss.

> 
> > +       };
> > +
> > +       fixed-rate-clocks {
> > +               oscclk: osc-clock {
> > +                       compatible = "fixed-clock";
> > +                       #clock-cells = <0>;
> > +                       clock-frequency = <26000000>;
> 
> Hmm, maybe it's better to set this clock frequency in board dts?

Well, every known 7885 device has 26000000 but I guess it does belong
to the board dts.

> 
> > +                       clock-output-names = "oscclk";
> > +               };
> > +       };
> > +
> > +       soc: soc@0 {
> > +               compatible = "simple-bus";
> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +               ranges = <0x0 0x0 0x0 0x20000000>;
> > +
> > +               chipid@10000000 {
> > +                       compatible = "samsung,exynos850-chipid";
> > +                       reg = <0x10000000 0x24>;
> > +               };
> > +
> > +               gic: interrupt-controller@12301000 {
> > +                       compatible = "arm,gic-400";
> > +                       #interrupt-cells = <3>;
> > +                       #address-cells = <0>;
> > +                       interrupt-controller;
> > +                       reg = <0x12301000 0x1000>,
> > +                             <0x12302000 0x2000>,
> > +                             <0x12304000 0x2000>,
> > +                             <0x12306000 0x2000>;
> > +                       interrupts = <GIC_PPI 9
> > (GIC_CPU_MASK_SIMPLE(8) |
> > +                                               
> > IRQ_TYPE_LEVEL_HIGH)>;
> > +               };
> > +
> > +               cmu_peri: clock-controller@10010000 {
> > +                       compatible = "samsung,exynos7885-cmu-peri";
> > +                       reg = <0x10010000 0x8000>;
> > +                       #clock-cells = <1>;
> > +
> > +                       clocks = <&oscclk>,
> > +                                <&cmu_top CLK_DOUT_PERI_BUS>,
> > +                                <&cmu_top CLK_DOUT_PERI_SPI0>,
> > +                                <&cmu_top CLK_DOUT_PERI_SPI1>,
> > +                                <&cmu_top CLK_DOUT_PERI_UART0>,
> > +                                <&cmu_top CLK_DOUT_PERI_UART1>,
> > +                                <&cmu_top CLK_DOUT_PERI_UART2>,
> > +                                <&cmu_top CLK_DOUT_PERI_USI0>,
> > +                                <&cmu_top CLK_DOUT_PERI_USI1>,
> > +                                <&cmu_top CLK_DOUT_PERI_USI2>;
> > +                       clock-names = "oscclk",
> > +                                     "dout_peri_bus",
> > +                                     "dout_peri_spi0",
> > +                                     "dout_peri_spi1",
> > +                                     "dout_peri_uart0",
> > +                                     "dout_peri_uart1",
> > +                                     "dout_peri_uart2",
> > +                                     "dout_peri_usi0",
> > +                                     "dout_peri_usi1",
> > +                                     "dout_peri_usi2";
> > +               };
> > +
> > +               cmu_core: clock-controller@12000000 {
> > +                       compatible = "samsung,exynos7885-cmu-core";
> > +                       reg = <0x12000000 0x8000>;
> > +                       #clock-cells = <1>;
> > +
> > +                       clocks = <&oscclk>,
> > +                                <&cmu_top CLK_DOUT_CORE_BUS>,
> > +                                <&cmu_top CLK_DOUT_CORE_CCI>,
> > +                                <&cmu_top CLK_DOUT_CORE_G3D>;
> > +                       clock-names = "oscclk", "dout_core_bus",
> > "dout_core_cci", "dout_core_g3d";
> 
> 80 characters per line, please. Also, please keep the style
> consistent: in cmu_peri you have each clock per line, here all clocks
> are on one line.
> 
> > +               };
> > +
> > +               cmu_top: clock-controller@12060000 {
> 
> I'd move cmu_top above, to be the first CMU node.
> 
> > +                       compatible = "samsung,exynos7885-cmu-top";
> > +                       reg = <0x12060000 0x8000>;
> > +                       #clock-cells = <1>;
> > +
> > +                       clocks = <&oscclk>;
> > +                       clock-names = "oscclk";
> > +               };
> > +
> > +               pinctrl_alive: pinctrl@11cb0000 {
> > +                       compatible = "samsung,exynos7885-pinctrl";
> > +                       reg = <0x11cb0000 0x1000>;
> > +                       interrupts = <GIC_SPI 0
> > IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <GIC_SPI 1
> > IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <GIC_SPI 2
> > IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <GIC_SPI 3
> > IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <GIC_SPI 4
> > IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <GIC_SPI 5
> > IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <GIC_SPI 6
> > IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <GIC_SPI 7
> > IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <GIC_SPI 8
> > IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <GIC_SPI 9
> > IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <GIC_SPI 10
> > IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <GIC_SPI 11
> > IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <GIC_SPI 12
> > IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <GIC_SPI 13
> > IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <GIC_SPI 14
> > IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <GIC_SPI 15
> > IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +                       wakeup-interrupt-controller {
> > +                               compatible = "samsung,exynos7-
> > wakeup-eint";
> > +                               interrupt-parent = <&gic>;
> > +                               interrupts = <GIC_SPI 130
> > IRQ_TYPE_LEVEL_HIGH>;
> > +                       };
> > +               };
> > +
> > +               pinctrl_dispaud: pinctrl@148f0000 {
> > +                       compatible = "samsung,exynos7885-pinctrl";
> > +                       reg = <0x148f0000 0x1000>;
> > +                       interrupts = <GIC_SPI 130
> > IRQ_TYPE_LEVEL_HIGH>;
> > +               };
> > +
> > +               pinctrl_fsys: pinctrl@13430000 {
> > +                       compatible = "samsung,exynos7885-pinctrl";
> > +                       reg = <0x13430000 0x1000>;
> > +                       interrupts = <GIC_SPI 150
> > IRQ_TYPE_LEVEL_HIGH>;
> > +               };
> > +
> > +               pinctrl_top: pinctrl@139b0000 {
> > +                       compatible = "samsung,exynos7885-pinctrl";
> > +                       reg = <0x139b0000 0x1000>;
> > +                       interrupts = <GIC_SPI 266
> > IRQ_TYPE_LEVEL_HIGH>;
> > +               };
> > +
> > +               pmu_system_controller: system-controller@11c80000 {
> > +                       compatible = "samsung,exynos7-pmu",
> > "syscon";
> > +                       reg = <0x11c80000 0x10000>;
> > +               };
> > +
> > +               serial_0: serial@13800000 {
> > +                       compatible = "samsung,exynos5433-uart";
> > +                       reg = <0x13800000 0x100>;
> > +                       interrupts = <GIC_SPI 246
> > IRQ_TYPE_LEVEL_HIGH>;
> > +                       pinctrl-names = "default";
> > +                       pinctrl-0 = <&uart0_bus>;
> > +                       clocks = <&cmu_peri
> > CLK_GOUT_UART0_EXT_UCLK>,
> > +                                <&cmu_peri CLK_GOUT_UART0_PCLK>;
> 
> AFAIU, usually PCLK is a bus clock. Are you sure it should be UART
> baud clock?

These are the two clocks, and it's definitely wrong swapped, as it
breaks switching baudrates, but PCLK does in fact have PERI_BUS_USER as
it's parent. while EXT_UCLK has PERI_UART0_USER as parent. Not sure
what is up with it here but it works fine this way but not the other
way around.

> 
> > +                       clock-names = "uart", "clk_uart_baud0";
> > +                       samsung,uart-fifosize = <64>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               serial_1: serial@13810000 {
> > +                       compatible = "samsung,exynos5433-uart";
> > +                       reg = <0x13810000 0x100>;
> > +                       interrupts = <GIC_SPI 247
> > IRQ_TYPE_LEVEL_HIGH>;
> > +                       pinctrl-names = "default";
> > +                       pinctrl-0 = <&uart1_bus>;
> > +                       clocks = <&cmu_peri
> > CLK_GOUT_UART1_EXT_UCLK>,
> > +                                <&cmu_peri CLK_GOUT_UART1_PCLK>;
> > +                       clock-names = "uart", "clk_uart_baud0";
> > +                       samsung,uart-fifosize = <256>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               serial_2: serial@13820000 {
> > +                       compatible = "samsung,exynos5433-uart";
> > +                       reg = <0x13820000 0x100>;
> > +                       interrupts = <GIC_SPI 279
> > IRQ_TYPE_LEVEL_HIGH>;
> > +                       pinctrl-names = "default";
> > +                       pinctrl-0 = <&uart2_bus>;
> > +                       clocks = <&cmu_peri
> > CLK_GOUT_UART2_EXT_UCLK>,
> > +                                <&cmu_peri CLK_GOUT_UART2_PCLK>;
> > +                       clock-names = "uart", "clk_uart_baud0";
> > +                       samsung,uart-fifosize = <256>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               i2c_0: i2c@13830000 {
> > +                       compatible = "samsung,s3c2440-i2c";
> > +                       reg = <0x13830000 0x100>;
> > +                       interrupts = <GIC_SPI 248
> > IRQ_TYPE_LEVEL_HIGH>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       pinctrl-names = "default";
> > +                       pinctrl-0 = <&i2c0_bus>;
> > +                       clocks = <&cmu_peri CLK_GOUT_I2C0_PCLK>;
> > +                       clock-names = "i2c";
> > +                       status = "disabled";
> > +               };
> > +
> > +               i2c_1: i2c@13840000 {
> > +                       compatible = "samsung,s3c2440-i2c";
> > +                       reg = <0x13840000 0x100>;
> > +                       interrupts = <GIC_SPI 249
> > IRQ_TYPE_LEVEL_HIGH>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       pinctrl-names = "default";
> > +                       pinctrl-0 = <&i2c1_bus>;
> > +                       clocks = <&cmu_peri CLK_GOUT_I2C1_PCLK>;
> > +                       clock-names = "i2c";
> > +                       status = "disabled";
> > +               };
> > +
> > +               i2c_2: i2c@13850000 {
> > +                       compatible = "samsung,s3c2440-i2c";
> > +                       reg = <0x13850000 0x100>;
> > +                       interrupts = <GIC_SPI 250
> > IRQ_TYPE_LEVEL_HIGH>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       pinctrl-names = "default";
> > +                       pinctrl-0 = <&i2c2_bus>;
> > +                       clocks = <&cmu_peri CLK_GOUT_I2C2_PCLK>;
> > +                       clock-names = "i2c";
> > +                       status = "disabled";
> > +               };
> > +
> > +               i2c_3: i2c@13860000 {
> > +                       compatible = "samsung,s3c2440-i2c";
> > +                       reg = <0x13860000 0x100>;
> > +                       interrupts = <GIC_SPI 251
> > IRQ_TYPE_LEVEL_HIGH>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       pinctrl-names = "default";
> > +                       pinctrl-0 = <&i2c3_bus>;
> > +                       clocks = <&cmu_peri CLK_GOUT_I2C3_PCLK>;
> > +                       clock-names = "i2c";
> > +                       status = "disabled";
> > +               };
> > +
> > +               i2c_4: i2c@13870000 {
> > +                       compatible = "samsung,s3c2440-i2c";
> > +                       reg = <0x13870000 0x100>;
> > +                       interrupts = <GIC_SPI 252
> > IRQ_TYPE_LEVEL_HIGH>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       pinctrl-names = "default";
> > +                       pinctrl-0 = <&i2c4_bus>;
> > +                       clocks = <&cmu_peri CLK_GOUT_I2C4_PCLK>;
> > +                       clock-names = "i2c";
> > +                       status = "disabled";
> > +               };
> > +
> > +               i2c_5: i2c@13880000 {
> > +                       compatible = "samsung,s3c2440-i2c";
> > +                       reg = <0x13880000 0x100>;
> > +                       interrupts = <GIC_SPI 253
> > IRQ_TYPE_LEVEL_HIGH>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       pinctrl-names = "default";
> > +                       pinctrl-0 = <&i2c5_bus>;
> > +                       clocks = <&cmu_peri CLK_GOUT_I2C5_PCLK>;
> > +                       clock-names = "i2c";
> > +                       status = "disabled";
> > +               };
> > +
> > +               i2c_6: i2c@13890000 {
> > +                       compatible = "samsung,s3c2440-i2c";
> > +                       reg = <0x13890000 0x100>;
> > +                       interrupts = <GIC_SPI 254
> > IRQ_TYPE_LEVEL_HIGH>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       pinctrl-names = "default";
> > +                       pinctrl-0 = <&i2c6_bus>;
> > +                       clocks = <&cmu_peri CLK_GOUT_I2C6_PCLK>;
> > +                       clock-names = "i2c";
> > +                       status = "disabled";
> > +               };
> > +
> > +               i2c_7: i2c@11cd0000 {
> > +                       compatible = "samsung,s3c2440-i2c";
> > +                       reg = <0x11cd0000 0x100>;
> > +                       interrupts = <GIC_SPI 255
> > IRQ_TYPE_LEVEL_HIGH>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       pinctrl-names = "default";
> > +                       pinctrl-0 = <&i2c7_bus>;
> > +                       clocks = <&cmu_peri CLK_GOUT_I2C7_PCLK>;
> > +                       clock-names = "i2c";
> > +                       status = "disabled";
> > +               };
> > +       };
> > +};
> > +
> > +#include "exynos7885-pinctrl.dtsi"
> > +#include "arm/exynos-syscon-restart.dtsi"
> 
> Have you verified both reboot and power off functions from this file?
> I guess if some doesn't work, it's better to avoid including this,
> but
> instead add corresponding sub-nodes into your pmu_sytem_controller.

They do in fact work on my phone ;)
One thing I noticed is that if I send a poweroff command and hold down
the power key, it will stay powered on until I release it. I guess
that's just how it's wired up.
Sometimes, very rarely a reboot does act weird though: Every once in a
while, a reboot turns the phone off, then the bootloader starts
outputting on UART before it cuts off my connection to UART by
resetting the MUIC, and the phone never powers on again by itself
after. (like.. bootloader starts then powers the phone off even before
the display would come on?) I should check the bootloader logs saved to
a last_kmsg buffer the next time this happens, but this looks like more
of a bootloader issue rather than this being wrong.

> 
> > --
> > 2.34.1
> > 


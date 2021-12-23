Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A5847E10E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 11:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347594AbhLWKAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 05:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347588AbhLWKAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 05:00:01 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B154C061759
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 02:00:00 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id k21so11364996lfu.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 02:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ozWOdzw4/gQTVpTCaZ01eY6Ii6IdnRKK+yVg8sDvroI=;
        b=MQZvipuLWLs3sfUhXbKs0dN6b7aVQ5f1NX7dAPmJARViFODigm9p+rbxZv2z35b1p0
         nIzIXjC+iiEuMBbY2qXviZ+nqc8RfiZqGqBBHblzDF6YGMA4ipqkNJYx/m4xPew/hu3l
         1GLdFaQCk9dwu0MWgu5lpJ1PArCQfiK4EqO2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ozWOdzw4/gQTVpTCaZ01eY6Ii6IdnRKK+yVg8sDvroI=;
        b=nTubxYzLLJLsVeopMNupODBOK0+7pdT/cqLhrkgsuQsPp/gzlS+kaUUs9CLcYLyk6j
         oaosisDJx2q0GduJ6u4Num/1zCS1nn+TCidsrakK4cP5HxFdDXaO3V1l9QHX0XBKIGPK
         yNtdjDrOTJcB1q3jmWZ9ZAKPxhDqPzCLVhsy6edN22MDBNrZZVEfbz0sfSFtNooGgjWX
         U9zXBZKccq2HEkxLzyHLe3heDfovs8001pS8fHuBZZ/RhnfwKHMQIMMSVnxKzB98vDwl
         LIxRvEZpv/XfrWzKC19/P+VOyTC7c3mwWL5usV3wtMfoc/REJMm5QKbJCU3reCkpWLhl
         pYSQ==
X-Gm-Message-State: AOAM5313avCW5vNOlBt77dh/pzYGoNbfkZvp4imZGtp02xf/Eeksg9Iu
        uJLc/ZIo+CTIOqIwNzDlZTdqDLVAqPhcWByvKgFSXw==
X-Google-Smtp-Source: ABdhPJw3jCl3U2HApVc0Sal5/5IDxNKS1pBLxkt7Gt7nBbvtKp2b8UfsV4Tl/aOVnqLs/Bg+tdcAvP+01l9/oR6HgzM=
X-Received: by 2002:ac2:4353:: with SMTP id o19mr1268636lfl.670.1640253598261;
 Thu, 23 Dec 2021 01:59:58 -0800 (PST)
MIME-Version: 1.0
References: <20211220121825.6446-1-tinghan.shen@mediatek.com> <20211220121825.6446-5-tinghan.shen@mediatek.com>
In-Reply-To: <20211220121825.6446-5-tinghan.shen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 23 Dec 2021 17:59:46 +0800
Message-ID: <CAGXv+5GaFikojqYYv0TfQsz3NSqn7QPmTWyCJY8V2g8UYoV4OA@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] arm64: dts: Add mediatek SoC mt8195 and evaluation board
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     robh+dt@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, broonie@kernel.org,
        bgolaszewski@baylibre.com, sean.wang@mediatek.com,
        bayi.cheng@mediatek.com, gch981213@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Seiya Wang <seiya.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 20, 2021 at 8:20 PM Tinghan Shen <tinghan.shen@mediatek.com> wrote:
>
> Add basic chip support for mediatek mt8195.
>
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile       |    1 +
>  arch/arm64/boot/dts/mediatek/mt8195-evb.dts |  209 ++++
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi    | 1034 +++++++++++++++++++
>  3 files changed, 1244 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-evb.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8195.dtsi
>
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 4f68ebed2e31..7aa08bb4c078 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -32,4 +32,5 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-evb.dts b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> new file mode 100644
> index 000000000000..e581c6bbead6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2021 MediaTek Inc.
> + * Author: Seiya Wang <seiya.wang@mediatek.com>
> + */
> +/dts-v1/;
> +#include "mt8195.dtsi"
> +
> +/ {
> +       model = "MediaTek MT8195 evaluation board";
> +       compatible = "mediatek,mt8195-evb", "mediatek,mt8195";
> +
> +       aliases {
> +               serial0 = &uart0;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:921600n8";
> +       };
> +
> +       memory@40000000 {
> +               device_type = "memory";
> +               reg = <0 0x40000000 0 0x80000000>;
> +       };
> +};
> +
> +&auxadc {
> +       status = "okay";
> +};
> +
> +&i2c0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&i2c0_pin>;
> +       clock-frequency = <100000>;
> +       status = "okay";
> +};
> +
> +&i2c1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&i2c1_pin>;
> +       clock-frequency = <400000>;
> +       status = "okay";
> +};
> +
> +&i2c2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&i2c2_pin>;
> +       status = "disabled";
> +};
> +
> +&i2c3 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&i2c3_pin>;
> +       status = "disabled";
> +};

Is there any reason in particular to list "disabled" devices here?
Are they part of some GPIO header? If they are not accessible, then
it's better to not list them. If they are, please leave a comment
about it.

> +
> +&i2c4 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&i2c4_pin>;
> +       clock-frequency = <400000>;
> +       status = "okay";
> +};
> +
> +&i2c5 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&i2c5_pin>;
> +       status = "disabled";
> +};
> +
> +&i2c6 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&i2c6_pin>;
> +       clock-frequency = <400000>;
> +       status = "disabled";
> +};

Same here.

> +
> +&nor_flash {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&nor_pins_default>;

Please add an empty line between properties and child device nodes. It helps
with readability and also fits the style of other parts and other DT files.

> +       flash@0 {
> +               compatible = "jedec,spi-nor";
> +               reg = <0>;
> +               spi-max-frequency = <50000000>;
> +       };
> +};
> +
> +&pio {
> +       i2c0_pin: i2c0-pins {
> +               pins {
> +                       pinmux = <PINMUX_GPIO8__FUNC_SDA0>,
> +                                <PINMUX_GPIO9__FUNC_SCL0>;
> +                       bias-pull-up = <1>;
> +                       mediatek,rsel = <7>;

Please use the MTK_PULL_SET_RSEL_* macros with the bias-pull-* properties.
We spent a lot of time defining those.

> +                       mediatek,drive-strength-adv = <0>;

This property is not part of the DT binding.

> +                       drive-strength = <MTK_DRIVE_6mA>;

Please just use raw numbers here. MTK_DRIVE_6mA just translates to 6.
The binding already specifies mA as the unit for "drive-strength".

> +               };
> +       };

Above comments apply to all the other "pins" nodes.

Please add an empty line between different child device nodes. It helps
with readability and also fits the style of other parts and other DT files.

> +       i2c1_pin: i2c1-pins {
> +               pins {
> +                       pinmux = <PINMUX_GPIO10__FUNC_SDA1>,
> +                                <PINMUX_GPIO11__FUNC_SCL1>;
> +                       bias-pull-up = <1>;
> +                       mediatek,rsel = <7>;
> +                       mediatek,drive-strength-adv = <0>;
> +                       drive-strength = <MTK_DRIVE_6mA>;
> +               };
> +       };
> +       i2c2_pin: i2c2-pins {
> +               pins {
> +                       pinmux = <PINMUX_GPIO12__FUNC_SDA2>,
> +                                <PINMUX_GPIO13__FUNC_SCL2>;
> +                       bias-pull-up = <1>;
> +                       mediatek,rsel = <7>;
> +                       mediatek,drive-strength-adv = <7>;
> +               };
> +       };
> +       i2c3_pin: i2c3-pins {
> +               pins {
> +                       pinmux = <PINMUX_GPIO14__FUNC_SDA3>,
> +                                <PINMUX_GPIO15__FUNC_SCL3>;
> +                       bias-pull-up = <1>;
> +                       mediatek,rsel = <7>;
> +                       mediatek,drive-strength-adv = <7>;
> +               };
> +       };
> +       i2c4_pin: i2c4-pins {
> +               pins {
> +                       pinmux = <PINMUX_GPIO16__FUNC_SDA4>,
> +                                <PINMUX_GPIO17__FUNC_SCL4>;
> +                       bias-pull-up = <1>;
> +                       mediatek,rsel = <7>;
> +                       mediatek,drive-strength-adv = <7>;
> +               };
> +       };
> +       i2c5_pin: i2c5-pins {
> +               pins {
> +                       pinmux = <PINMUX_GPIO29__FUNC_SCL5>,
> +                                <PINMUX_GPIO30__FUNC_SDA5>;
> +                       bias-pull-up = <1>;
> +                       mediatek,rsel = <7>;
> +                       mediatek,drive-strength-adv = <7>;
> +               };
> +       };
> +       i2c6_pin: i2c6-pins {
> +               pins {
> +                       pinmux = <PINMUX_GPIO25__FUNC_SDA6>,
> +                                <PINMUX_GPIO26__FUNC_SCL6>;
> +                       bias-pull-up = <1>;
> +               };
> +       };
> +       i2c7_pin: i2c7-pins {
> +               pins {
> +                       pinmux = <PINMUX_GPIO27__FUNC_SCL7>,
> +                                <PINMUX_GPIO28__FUNC_SDA7>;
> +                       bias-pull-up = <1>;
> +               };
> +       };
> +       nor_pins_default: nor-pins {
> +               pins0 {
> +                       pinmux = <PINMUX_GPIO142__FUNC_SPINOR_IO0>,
> +                                        <PINMUX_GPIO141__FUNC_SPINOR_CK>,
> +                                        <PINMUX_GPIO143__FUNC_SPINOR_IO1>;
> +                       bias-pull-down;
> +               };
> +               pins1 {
> +                       pinmux = <PINMUX_GPIO140__FUNC_SPINOR_CS>,
> +                                    <PINMUX_GPIO130__FUNC_SPINOR_IO2>,
> +                                    <PINMUX_GPIO131__FUNC_SPINOR_IO3>;
> +                       bias-pull-up;
> +               };
> +       };
> +       uart0_pin: uart0-pins {
> +               pins {
> +                       pinmux = <PINMUX_GPIO98__FUNC_UTXD0>,
> +                               <PINMUX_GPIO99__FUNC_URXD0>;
> +               };
> +       };
> +};
> +
> +&u2port0 {
> +       status = "okay";
> +};
> +
> +&u2port1 {
> +       status = "okay";
> +};
> +
> +&u3phy0 {
> +       status="okay";
> +};
> +
> +&u3phy1 {
> +       status="okay";
> +};
> +
> +&u3port0 {
> +       status = "okay";
> +};
> +
> +&u3port1 {
> +       status = "okay";
> +};
> +
> +&uart0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart0_pin>;
> +       status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> new file mode 100644
> index 000000000000..057a8492edec
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -0,0 +1,1034 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2021 MediaTek Inc.
> + * Author: Seiya Wang <seiya.wang@mediatek.com>
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/clock/mt8195-clk.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/pinctrl/mt8195-pinfunc.h>
> +#include <dt-bindings/reset/ti-syscon.h>
> +
> +/ {
> +       compatible = "mediatek,mt8195";
> +       interrupt-parent = <&gic>;
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       clk26m: oscillator0 {

Please order device nodes based on the node name ("oscillator0"),
not the label. An exception to this would be the "soc" node, which
most tend to keep as the last node in the list.

Also, naming them "oscillator-26m" and "oscillator-32k" would make
more sense than "oscillatorN".

> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <26000000>;
> +               clock-output-names = "clk26m";
> +       };
> +
> +       clk32k: oscillator1 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <32768>;
> +               clock-output-names = "clk32k";
> +       };
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu0: cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a55";
> +                       reg = <0x000>;
> +                       enable-method = "psci";
> +                       clock-frequency = <1701000000>;
> +                       capacity-dmips-mhz = <578>;
> +                       cpu-idle-states = <&cpuoff_l &clusteroff_l>;
> +                       next-level-cache = <&l2_0>;
> +                       #cooling-cells = <2>;
> +               };
> +
> +               cpu1: cpu@100 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a55";
> +                       reg = <0x100>;
> +                       enable-method = "psci";
> +                       clock-frequency = <1701000000>;
> +                       capacity-dmips-mhz = <578>;
> +                       cpu-idle-states = <&cpuoff_l &clusteroff_l>;
> +                       next-level-cache = <&l2_0>;
> +                       #cooling-cells = <2>;
> +               };
> +
> +               cpu2: cpu@200 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a55";
> +                       reg = <0x200>;
> +                       enable-method = "psci";
> +                       clock-frequency = <1701000000>;
> +                       capacity-dmips-mhz = <578>;
> +                       cpu-idle-states = <&cpuoff_l &clusteroff_l>;
> +                       next-level-cache = <&l2_0>;
> +                       #cooling-cells = <2>;
> +               };
> +
> +               cpu3: cpu@300 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a55";
> +                       reg = <0x300>;
> +                       enable-method = "psci";
> +                       clock-frequency = <1701000000>;
> +                       capacity-dmips-mhz = <578>;
> +                       cpu-idle-states = <&cpuoff_l &clusteroff_l>;
> +                       next-level-cache = <&l2_0>;
> +                       #cooling-cells = <2>;
> +               };
> +
> +               cpu4: cpu@400 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a78";
> +                       reg = <0x400>;
> +                       enable-method = "psci";
> +                       clock-frequency = <2171000000>;
> +                       capacity-dmips-mhz = <1024>;
> +                       cpu-idle-states = <&cpuoff_b &clusteroff_b>;
> +                       next-level-cache = <&l2_1>;
> +                       #cooling-cells = <2>;
> +               };
> +
> +               cpu5: cpu@500 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a78";
> +                       reg = <0x500>;
> +                       enable-method = "psci";
> +                       clock-frequency = <2171000000>;
> +                       capacity-dmips-mhz = <1024>;
> +                       cpu-idle-states = <&cpuoff_b &clusteroff_b>;
> +                       next-level-cache = <&l2_1>;
> +                       #cooling-cells = <2>;
> +               };
> +
> +               cpu6: cpu@600 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a78";
> +                       reg = <0x600>;
> +                       enable-method = "psci";
> +                       clock-frequency = <2171000000>;
> +                       capacity-dmips-mhz = <1024>;
> +                       cpu-idle-states = <&cpuoff_b &clusteroff_b>;
> +                       next-level-cache = <&l2_1>;
> +                       #cooling-cells = <2>;
> +               };
> +
> +               cpu7: cpu@700 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a78";
> +                       reg = <0x700>;
> +                       enable-method = "psci";
> +                       clock-frequency = <2171000000>;
> +                       capacity-dmips-mhz = <1024>;
> +                       cpu-idle-states = <&cpuoff_b &clusteroff_b>;
> +                       next-level-cache = <&l2_1>;
> +                       #cooling-cells = <2>;
> +               };
> +
> +               cpu-map {
> +                       cluster0 {
> +                               core0 {
> +                                       cpu = <&cpu0>;
> +                               };

Please add an empty line between child nodes. This aids in readability.

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
> +               idle-states {
> +                       entry-method = "arm,psci";

This should be just "psci".

Please add empty lines between properties and child device nodes, and
in between device nodes.

> +                       cpuoff_l: cpuoff_l {

Please do not use underscores in device node names. Also, for the idle
states, the binding requires the nodes to be named as "cpu-*" or
"cluster-*". So {cpu,cluster}-off-{l,b} would work.

> +                               compatible = "arm,idle-state";
> +                               arm,psci-suspend-param = <0x00010001>;
> +                               local-timer-stop;
> +                               entry-latency-us = <50>;
> +                               exit-latency-us = <95>;
> +                               min-residency-us = <580>;
> +                       };
> +                       cpuoff_b: cpuoff_b {
> +                               compatible = "arm,idle-state";
> +                               arm,psci-suspend-param = <0x00010001>;
> +                               local-timer-stop;
> +                               entry-latency-us = <45>;
> +                               exit-latency-us = <140>;
> +                               min-residency-us = <740>;
> +                       };
> +                       clusteroff_l: clusteroff_l {
> +                               compatible = "arm,idle-state";
> +                               arm,psci-suspend-param = <0x01010002>;
> +                               local-timer-stop;
> +                               entry-latency-us = <55>;
> +                               exit-latency-us = <155>;
> +                               min-residency-us = <840>;
> +                       };
> +                       clusteroff_b: clusteroff_b {
> +                               compatible = "arm,idle-state";
> +                               arm,psci-suspend-param = <0x01010002>;
> +                               local-timer-stop;
> +                               entry-latency-us = <50>;
> +                               exit-latency-us = <200>;
> +                               min-residency-us = <1000>;
> +                       };
> +               };
> +
> +               l2_0: l2-cache0 {
> +                       compatible = "cache";
> +                       next-level-cache = <&l3_0>;
> +               };
> +
> +               l2_1: l2-cache1 {
> +                       compatible = "cache";
> +                       next-level-cache = <&l3_0>;
> +               };
> +
> +               l3_0: l3-cache {
> +                       compatible = "cache";
> +               };
> +       };
> +
> +       dsu-pmu {
> +               compatible = "arm,dsu-pmu";
> +               interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH 0>;
> +               cpus = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>,
> +                      <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
> +       };
> +
> +       pmu-a55 {
> +               compatible = "arm,cortex-a55-pmu";
> +               interrupt-parent = <&gic>;
> +               interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_cluster0>;
> +       };
> +
> +       pmu-a78 {
> +               compatible = "arm,cortex-a78-pmu";
> +               interrupt-parent = <&gic>;
> +               interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_cluster1>;
> +       };
> +
> +       psci {
> +               compatible = "arm,psci-1.0";
> +               method = "smc";
> +       };
> +
> +       timer: timer {
> +               compatible = "arm,armv8-timer";
> +               interrupt-parent = <&gic>;
> +               interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
> +                            <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
> +                            <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
> +                            <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
> +               clock-frequency = <13000000>;

IIRC Marc already mentioned before that this should not be specified in
the device tree. The firmware should have filled in the CNTFRQ register.

> +       };
> +
> +       soc {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               compatible = "simple-bus";
> +               ranges;
> +
> +               gic: interrupt-controller@c000000 {
> +                       compatible = "arm,gic-v3";
> +                       #interrupt-cells = <4>;
> +                       #redistributor-regions = <1>;
> +                       interrupt-parent = <&gic>;
> +                       interrupt-controller;
> +                       reg = <0 0x0c000000 0 0x40000>,
> +                             <0 0x0c040000 0 0x200000>;
> +                       interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
> +
> +                       ppi-partitions {
> +                               ppi_cluster0: interrupt-partition-0 {
> +                                       affinity = <&cpu0 &cpu1 &cpu2 &cpu3>;
> +                               };

Please add an extra line for readability.

> +                               ppi_cluster1: interrupt-partition-1 {
> +                                       affinity = <&cpu4 &cpu5 &cpu6 &cpu7>;
> +                               };
> +                       };
> +               };
> +
> +               topckgen: syscon@10000000 {
> +                       compatible = "mediatek,mt8195-topckgen", "syscon";
> +                       reg = <0 0x10000000 0 0x1000>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               infracfg_ao: syscon@10001000 {
> +                       compatible = "mediatek,mt8195-infracfg_ao", "syscon", "simple-mfd";
> +                       reg = <0 0x10001000 0 0x1000>;
> +                       #clock-cells = <1>;

Please add an extra line for readability.

> +                       infracfg_rst: reset-controller {
> +                               compatible = "ti,syscon-reset";
> +                               #reset-cells = <1>;
> +                               ti,reset-bits = <
> +                                       0x140 18 0x144 18 0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE)
> +                                       0x120 0 0x124 0 0 0     (ASSERT_SET | DEASSERT_SET | STATUS_NONE)
> +                                       0x730 10 0x734 10 0 0     (ASSERT_SET | DEASSERT_SET | STATUS_NONE)
> +                                       0x150 5 0x154 5 0 0     (ASSERT_SET | DEASSERT_SET | STATUS_NONE)

This should be 7 cells per entry:

    ti,reset-bits =
        <0x140 18 0x144 18 0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE>,
        <0x120 0 0x124 0 0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE)>,
        <...>,
        <...>;

Also, please remove the extra spaces in each line. They aren't helping
with formatting.

> +                               >;
> +                       };
> +               };
> +

> +               pio: pinctrl@10005000 {
> +                       compatible = "mediatek,mt8195-pinctrl";
> +                       reg = <0 0x10005000 0 0x1000>,
> +                             <0 0x11d10000 0 0x1000>,
> +                             <0 0x11d30000 0 0x1000>,
> +                             <0 0x11d40000 0 0x1000>,
> +                             <0 0x11e20000 0 0x1000>,
> +                             <0 0x11eb0000 0 0x1000>,
> +                             <0 0x11f40000 0 0x1000>,
> +                             <0 0x1000b000 0 0x1000>;
> +                       reg-names = "iocfg0", "iocfg_bm", "iocfg_bl",
> +                                   "iocfg_br", "iocfg_lm", "iocfg_rb",
> +                                   "iocfg_tl", "eint";
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +                       gpio-ranges = <&pio 0 0 144>;
> +                       interrupt-controller;
> +                       interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH 0>;

This looks correct now (a comment I raised in v4). Thanks.

> +                       #interrupt-cells = <2>;
> +               };

[...]

> +               xhci0: usb@11200000 {
> +                       compatible = "mediatek,mt8195-xhci",
> +                                    "mediatek,mtk-xhci";
> +                       reg = <0 0x11200000 0 0x1000>,
> +                             <0 0x11203e00 0 0x0100>;
> +                       reg-names = "mac", "ippc";
> +                       interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       phys = <&u2port0 PHY_TYPE_USB2>,
> +                              <&u3port0 PHY_TYPE_USB3>;
> +                       assigned-clocks = <&topckgen CLK_TOP_USB_TOP>,
> +                                         <&topckgen CLK_TOP_SSUSB_XHCI>;
> +                       assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
> +                                                <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> +                       clocks = <&infracfg_ao CLK_INFRA_AO_SSUSB>,
> +                                <&infracfg_ao CLK_INFRA_AO_SSUSB_XHCI>,
> +                                <&topckgen CLK_TOP_SSUSB_REF>,
> +                                <&apmixedsys CLK_APMIXED_USB1PLL>;
> +                       clock-names = "sys_ck", "xhci_ck", "ref_ck", "mcu_ck";

The binding for this needs to be fixed. It expects clocks in the order
specified in the binding, and this doesn't match. Also, "dma_ck" is missing
and will likely cause warnings to be generated.

This goes for all the xhci device nodes.

> +                       status = "disabled";
> +               };
> +
> +               mmc0: mmc@11230000 {
> +                       compatible = "mediatek,mt8195-mmc",
> +                                    "mediatek,mt8183-mmc";
> +                       reg = <0 0x11230000 0 0x10000>,
> +                             <0 0x11f50000 0 0x1000>;

The binding only allows one entry. Please fix the binding first.
This was added with MT8183, and the fix should list the relavent commit.

> +                       interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       clocks = <&topckgen CLK_TOP_MSDC50_0>,
> +                                <&infracfg_ao CLK_INFRA_AO_MSDC0>,
> +                                <&infracfg_ao CLK_INFRA_AO_MSDC0_SRC>;
> +                       clock-names = "source", "hclk", "source_cg";
> +                       status = "disabled";
> +               };
> +

[...]

> +
> +               xhci1: usb@11290000 {
> +                       compatible = "mediatek,mt8195-xhci",
> +                                    "mediatek,mtk-xhci";
> +                       reg = <0 0x11290000 0 0x1000>,
> +                             <0 0x11293e00 0 0x0100>;
> +                       reg-names = "mac", "ippc";
> +                       interrupts = <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       phys = <&u2port1 PHY_TYPE_USB2>;

Shouldn't there be a USB3 phy?

> +                       assigned-clocks = <&topckgen CLK_TOP_USB_TOP_1P>,
> +                                         <&topckgen CLK_TOP_SSUSB_XHCI_1P>;
> +                       assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
> +                                                <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> +                       clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_1P_BUS>,
> +                                <&topckgen CLK_TOP_SSUSB_P1_REF>,
> +                                <&pericfg_ao CLK_PERI_AO_SSUSB_1P_XHCI>,
> +                                <&apmixedsys CLK_APMIXED_USB1PLL>;
> +                       clock-names = "sys_ck", "ref_ck", "xhci_ck", "mcu_ck";
> +                       status = "disabled";
> +               };
> +
> +               xhci2: usb@112a0000 {
> +                       compatible = "mediatek,mt8195-xhci",
> +                                    "mediatek,mtk-xhci";
> +                       reg = <0 0x112a0000 0 0x1000>,
> +                             <0 0x112a3e00 0 0x0100>;
> +                       reg-names = "mac", "ippc";
> +                       interrupts = <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       phys = <&u2port2 PHY_TYPE_USB2>;
> +                       assigned-clocks = <&topckgen CLK_TOP_USB_TOP_2P>,
> +                                         <&topckgen CLK_TOP_SSUSB_XHCI_2P>;
> +                       assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
> +                                                <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> +                       clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_2P_BUS>,
> +                                <&topckgen CLK_TOP_SSUSB_P2_REF>,
> +                                <&pericfg_ao CLK_PERI_AO_SSUSB_2P_XHCI>;
> +                       clock-names = "sys_ck", "ref_ck", "xhci_ck";
> +                       status = "disabled";
> +               };
> +
> +               xhci3: usb@112b0000 {
> +                       compatible = "mediatek,mt8195-xhci",
> +                                    "mediatek,mtk-xhci";
> +                       reg = <0 0x112b0000 0 0x1000>,
> +                             <0 0x112b3e00 0 0x0100>;
> +                       reg-names = "mac", "ippc";
> +                       interrupts = <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       phys = <&u2port3 PHY_TYPE_USB2>;
> +                       assigned-clocks = <&topckgen CLK_TOP_USB_TOP_3P>,
> +                                         <&topckgen CLK_TOP_SSUSB_XHCI_3P>;
> +                       assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
> +                                                <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> +                       clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_3P_BUS>,
> +                                <&pericfg_ao CLK_PERI_AO_SSUSB_3P_XHCI>,
> +                                <&topckgen CLK_TOP_SSUSB_P3_REF>;
> +                       clock-names = "sys_ck", "xhci_ck", "ref_ck";
> +                       usb2-lpm-disable;

Could you explain why this is needed only for this controller?

> +                       status = "disabled";
> +               };
> +

> +               u3phy2: t-phy@11c40000 {

Just "phy" for the node name. (Or maybe "serdes".) t-phy is not generic.

> +                       compatible = "mediatek,mt8195-tphy", "mediatek,generic-tphy-v3";
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges = <0 0 0x11c40000 0x700>;
> +                       status = "disabled";
> +
> +                       u2port2: usb-phy@0 {
> +                               reg = <0x0 0x700>;
> +                               clocks = <&topckgen CLK_TOP_SSUSB_PHY_P2_REF>;
> +                               clock-names = "ref";
> +                               #phy-cells = <1>;
> +                       };
> +               };
> +

[...]

> +               ufsphy: ufs-phy@11fa0000 {

I would have preferred "phy" for the device node, but this seems already
defined in the binding.

This IP block is not listed in the datasheet I have, so I am unable to
verify the properties listed here.

> +                       compatible = "mediatek,mt8195-ufsphy", "mediatek,mt8183-ufsphy";
> +                       reg = <0 0x11fa0000 0 0xc000>;
> +                       clocks = <&clk26m>, <&clk26m>;
> +                       clock-names = "unipro", "mp";
> +                       #phy-cells = <0>;
> +                       status = "disabled";
> +               };
> +

Most of the issues I raised in this version were issues with things not
matching the bindings. Please apply your patches on -next and run
`make dtbs_check`.


ChenYu

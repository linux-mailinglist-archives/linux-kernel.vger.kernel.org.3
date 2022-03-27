Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E20E4E896D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 20:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbiC0Sy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 14:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiC0SyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 14:54:24 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088E711C0B;
        Sun, 27 Mar 2022 11:52:45 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id h23so17341329wrb.8;
        Sun, 27 Mar 2022 11:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zztFPC9CPOnkLrv/8DzA11FGoq7J+l0USFqX9eJaqaY=;
        b=ZgGqLRGBChQCY/DlbYFuWOr9UGKJU7t/CtC6pN9rTHAQxLH8etKKqpVptFWTvOI8mP
         JpPJ8bW+UF2jgCXXsephIpThXgSc9Vy3xLSCC0sSuSCpOME6KRtZaSyhDTEhlMJyXRv+
         2Vy7+s0YgeBe0cNx9feAiYiT/eZPIhcFrKLt3aOleOaKJZ8owQVTjsrsJkWiOkPjf0Yl
         OX3wwqmkQhQz0m3DSNKt7RxMtA1YOZRVatQLrGAmXouA8sRQ9Rq8k2OeKJPlhBfo/Q5v
         JwRzktnvFtEp5JAaIhn+5TxAOABDHNidEk4CCCw94QOcTw9jh0s856qBBRUft99Yn+K2
         0FRQ==
X-Gm-Message-State: AOAM532tcwT8Bk5YtgTxd9ihBH647f65rm6RnRvjIgD7I4SRKcUOoB8L
        YhJKn6WV55An2emo3kxG5jI=
X-Google-Smtp-Source: ABdhPJz9honcxTdlF2ddo2/FMtPMDCxo0vgAyJ4yUwt47j3e4yQ7tRQwgOM7MdxzxZAopuCsEVHU0Q==
X-Received: by 2002:a05:6000:2aa:b0:204:1475:d497 with SMTP id l10-20020a05600002aa00b002041475d497mr18282213wry.232.1648407163277;
        Sun, 27 Mar 2022 11:52:43 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id r14-20020a7bc08e000000b0038ca55f9bcasm13784947wmh.42.2022.03.27.11.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 11:52:42 -0700 (PDT)
Message-ID: <6ba2ffc8-455d-d689-723e-59a29b23a597@kernel.org>
Date:   Sun, 27 Mar 2022 20:52:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/4] arm64: dts: mediatek: Add device-tree for MT8195 Demo
 board
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220327165837.3048639-1-fparent@baylibre.com>
 <20220327165837.3048639-3-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220327165837.3048639-3-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2022 18:58, Fabien Parent wrote:
> Add basic device-tree for the MT8195 Demo board. The
> Demo board is made by MediaTek and has a MT8195 SoC,
> associated with the MT6359 and MT6360 PMICs, and
> the MT7921 connectivity chip.
> 
> The IOs available on that board are:
> * 1 USB Type-C connector with DP aux mode support
> * 1 USB Type-A connector
> * 1 full size HDMI RX and 1 full size HDMI TX connector
> * 1 uSD slot
> * 40 pins header
> * SPI interface header
> * 1 M.2 slot
> * 1 audio jack
> * 1 micro-USB port for serial debug
> * 2 connectors for DSI displays
> * 3 connectors for CSI cameras
> * 1 connector for a eDP panel
> * 1 MMC storage
> 
> This commit adds basic support in order to be able to boot.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
> This patch depends on the following patches:
> [0] https://patchwork.kernel.org/project/linux-mediatek/patch/1622011927-359-9-git-send-email-hsin-hsiung.wang@mediatek.com/
> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/20220216113131.13145-4-tinghan.shen@mediatek.com/
> 
>  arch/arm64/boot/dts/mediatek/Makefile        |   1 +
>  arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 539 +++++++++++++++++++
>  2 files changed, 540 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 5da29e7223e4..c7d4636a2cb7 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -38,5 +38,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-demo.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> new file mode 100644
> index 000000000000..f486cdf7e22b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> @@ -0,0 +1,539 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2022 BayLibre, SAS.
> + * Author: Fabien Parent <fparent@baylibre.com>
> + */
> +/dts-v1/;
> +
> +#include "mt8195.dtsi"
> +#include "mt6359.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/pinctrl/mt8195-pinfunc.h>
> +#include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
> +
> +/ {
> +	model = "MediaTek MT8195 demo board";
> +	compatible = "mediatek,mt8195-demo", "mediatek,mt8195";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:921600n8";
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0x80000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* 12 MiB reserved for OP-TEE (BL32)
> +		 * +-----------------------+ 0x43e0_0000
> +		 * |      SHMEM 2MiB       |
> +		 * +-----------------------+ 0x43c0_0000
> +		 * |        | TA_RAM  8MiB |
> +		 * + TZDRAM +--------------+ 0x4340_0000
> +		 * |        | TEE_RAM 2MiB |
> +		 * +-----------------------+ 0x4320_0000
> +		 */
> +		optee_reserved: optee@43200000 {
> +			no-map;
> +			reg = <0 0x43200000 0 0x00c00000>;
> +		};
> +
> +		/* 192 KiB reserved for ARM Trusted Firmware (BL31) */
> +		bl31_secmon_reserved: secmon@54600000 {
> +			no-map;
> +			reg = <0 0x54600000 0x0 0x30000>;
> +		};
> +	};
> +
> +	firmware {
> +		optee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		input-name = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_keys>;
> +
> +		volume-up {

Generic node names, so "key" or "key-0"

> +			gpios = <&pio 106 GPIO_ACTIVE_LOW>;
> +			label = "volume_up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			wakeup-source;
> +			debounce-interval = <15>;
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins>;
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	status = "okay";
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&mmc0_pins_default>;
> +	pinctrl-1 = <&mmc0_pins_uhs>;
> +	bus-width = <8>;
> +	max-frequency = <200000000>;
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	cap-mmc-hw-reset;
> +	no-sdio;
> +	no-sd;
> +	hs400-ds-delay = <0x14c11>;
> +	vmmc-supply = <&mt6359_vemc_1_ldo_reg>;
> +	vqmmc-supply = <&mt6359_vufs_ldo_reg>;
> +	non-removable;
> +};
> +
> +&pmic {
> +	interrupt-parent = <&pio>;
> +	interrupts = <222 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&i2c0 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&i2c0_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";

What's attached here? Enabling empty i2c controller?

> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&i2c1_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";

What's attached here? Enabling empty i2c node?

> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&i2c2_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";

What's attached here? Enabling empty i2c node?

> +};
> +
> +&i2c6 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&i2c6_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	mt6360: mt6360@34 {

Generic node names, so "pmic"?

> +		compatible = "mediatek,mt6360";
> +		reg = <0x34>;
> +		interrupt-controller;
> +		interrupt-parent = <&pio>;
> +		interrupts = <101 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-names = "IRQB";
> +
> +		charger {
> +			compatible = "mediatek,mt6360-chg";
> +			richtek,vinovp-microvolt = <14500000>;
> +
> +			otg_vbus_regulator: usb-otg-vbus-regulator {
> +				regulator-compatible = "usb-otg-vbus";
> +				regulator-name = "usb-otg-vbus";
> +				regulator-min-microvolt = <4425000>;
> +				regulator-max-microvolt = <5825000>;
> +			};
> +		};
> +
> +		regulator {
> +			compatible = "mediatek,mt6360-regulator";
> +			LDO_VIN3-supply = <&mt6360_buck2>;
> +
> +			mt6360_buck1: buck1 {
> +				regulator-compatible = "BUCK1";
> +				regulator-name = "mt6360,buck1";
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP
> +							   MT6360_OPMODE_ULP>;
> +				regulator-always-on;
> +			};
> +
> +			mt6360_buck2: buck2 {
> +				regulator-compatible = "BUCK2";
> +				regulator-name = "mt6360,buck2";
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP
> +							   MT6360_OPMODE_ULP>;
> +				regulator-always-on;
> +			};
> +
> +			mt6360_ldo1: ldo1 {
> +				regulator-compatible = "LDO1";
> +				regulator-name = "mt6360,ldo1";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <3600000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +			};
> +
> +			mt6360_ldo2: ldo2 {
> +				regulator-compatible = "LDO2";
> +				regulator-name = "mt6360,ldo2";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <3600000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +			};
> +
> +			mt6360_ldo3: ldo3 {
> +				regulator-compatible = "LDO3";
> +				regulator-name = "mt6360,ldo3";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <3600000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +			};
> +
> +			mt6360_ldo5: ldo5 {
> +				regulator-compatible = "LDO5";
> +				regulator-name = "mt6360,ldo5";
> +				regulator-min-microvolt = <2700000>;
> +				regulator-max-microvolt = <3600000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +			};
> +
> +			mt6360_ldo6: ldo6 {
> +				regulator-compatible = "LDO6";
> +				regulator-name = "mt6360,ldo6";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <2100000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +			};
> +
> +			mt6360_ldo7: ldo7 {
> +				regulator-compatible = "LDO7";
> +				regulator-name = "mt6360,ldo7";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <2100000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
> +&spi2 {
> +	pinctrl-0 = <&spi2_pins>;
> +	pinctrl-names = "default";
> +	mediatek,pad-select = <0>;
> +	status = "okay";

What is attached here? Empty SPI?


> +};
> +
> +&mt6359_vgpu11_buck_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vsram_others_ldo_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vpu_buck_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vcore_buck_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vproc1_buck_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vproc2_buck_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vsram_md_ldo_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vbbck_ldo_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vrf12_ldo_reg {
> +	regulator-always-on;
> +};
> +
> +&mmc1 {

Any reasons to have all overrides/labels ordered randomly? I am not
dreaming about alphabetical order, but at least some logical, so mmc1
next to mmc0...

> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&mmc1_pins_default>;
> +	pinctrl-1 = <&mmc1_pins_uhs>;
> +	cd-gpios = <&pio 129 GPIO_ACTIVE_LOW>;
> +	bus-width = <4>;
> +	max-frequency = <200000000>;
> +	cap-sd-highspeed;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&mt6360_ldo5>;
> +	vqmmc-supply = <&mt6360_ldo3>;
> +	status = "okay";
> +};
> +
> +&xhci0 {
> +	vusb33-supply = <&mt6359_vusb_ldo_reg>;
> +	vbus-supply = <&otg_vbus_regulator>;
> +	status = "okay";
> +};
> +
> +&xhci1 {
> +	vusb33-supply = <&mt6359_vusb_ldo_reg>;
> +	status = "okay";
> +};
> +
> +&xhci2 {
> +	vusb33-supply = <&mt6359_vusb_ldo_reg>;
> +	status = "okay";
> +};
> +
> +&xhci3 {
> +	vusb33-supply = <&mt6359_vusb_ldo_reg>;
> +	status = "okay";
> +};
> +
> +&u3phy0 {
> +	status = "okay";
> +};
> +
> +&u3phy1 {
> +	status = "okay";
> +};
> +
> +&u3phy2 {
> +	status = "okay";
> +};
> +
> +&u3phy3 {
> +	status = "okay";
> +};
> +
> +&pio {
> +	mmc0_pins_default: mmc0default {
> +		pins_cmd_dat {

No underscores in node names. Hyphens are accepted.

Same in all other cases below.

> +			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
> +				 <PINMUX_GPIO125__FUNC_MSDC0_DAT1>,
> +				 <PINMUX_GPIO124__FUNC_MSDC0_DAT2>,
> +				 <PINMUX_GPIO123__FUNC_MSDC0_DAT3>,
> +				 <PINMUX_GPIO119__FUNC_MSDC0_DAT4>,
> +				 <PINMUX_GPIO118__FUNC_MSDC0_DAT5>,
> +				 <PINMUX_GPIO117__FUNC_MSDC0_DAT6>,
> +				 <PINMUX_GPIO116__FUNC_MSDC0_DAT7>,
> +				 <PINMUX_GPIO121__FUNC_MSDC0_CMD>;
> +			input-enable;
> +			drive-strength = <MTK_DRIVE_6mA>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +
> +		pins_clk {
> +			pinmux = <PINMUX_GPIO122__FUNC_MSDC0_CLK>;
> +			drive-strength = <MTK_DRIVE_6mA>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins_rst {
> +			pinmux = <PINMUX_GPIO120__FUNC_MSDC0_RSTB>;
> +			drive-strength = <MTK_DRIVE_6mA>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +	};
> +
> +	mmc0_pins_uhs: mmc0uhs{
> +		pins_cmd_dat {
> +			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
> +				 <PINMUX_GPIO125__FUNC_MSDC0_DAT1>,
> +				 <PINMUX_GPIO124__FUNC_MSDC0_DAT2>,
> +				 <PINMUX_GPIO123__FUNC_MSDC0_DAT3>,
> +				 <PINMUX_GPIO119__FUNC_MSDC0_DAT4>,
> +				 <PINMUX_GPIO118__FUNC_MSDC0_DAT5>,
> +				 <PINMUX_GPIO117__FUNC_MSDC0_DAT6>,
> +				 <PINMUX_GPIO116__FUNC_MSDC0_DAT7>,
> +				 <PINMUX_GPIO121__FUNC_MSDC0_CMD>;
> +			input-enable;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +
> +		pins_clk {
> +			pinmux = <PINMUX_GPIO122__FUNC_MSDC0_CLK>;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins_ds {
> +			pinmux = <PINMUX_GPIO127__FUNC_MSDC0_DSL>;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins_rst {
> +			pinmux = <PINMUX_GPIO120__FUNC_MSDC0_RSTB>;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +	};
> +
> +	mmc1_pins_default: mmc1-pins-default {
> +		pins_cmd_dat {
> +			pinmux = <PINMUX_GPIO110__FUNC_MSDC1_CMD>,
> +				 <PINMUX_GPIO112__FUNC_MSDC1_DAT0>,
> +				 <PINMUX_GPIO113__FUNC_MSDC1_DAT1>,
> +				 <PINMUX_GPIO114__FUNC_MSDC1_DAT2>,
> +				 <PINMUX_GPIO115__FUNC_MSDC1_DAT3>;
> +			input-enable;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +
> +		pins_clk {
> +			pinmux = <PINMUX_GPIO111__FUNC_MSDC1_CLK>;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins_insert {
> +			pinmux = <PINMUX_GPIO129__FUNC_GPIO129>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	mmc1_pins_uhs: mmc1-pins-uhs {

Any reason keeping it inconsistent with mmc0 about naming? I mean... why
having one naming pattern for mmc0 and entirely different for mmc1? Why
i2c ends with "-pins" suffix and these do not?

> +		pins_cmd_dat {
> +			pinmux = <PINMUX_GPIO110__FUNC_MSDC1_CMD>,
> +				 <PINMUX_GPIO112__FUNC_MSDC1_DAT0>,
> +				 <PINMUX_GPIO113__FUNC_MSDC1_DAT1>,
> +				 <PINMUX_GPIO114__FUNC_MSDC1_DAT2>,
> +				 <PINMUX_GPIO115__FUNC_MSDC1_DAT3>;
> +			input-enable;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +
> +		pins_clk {
> +			pinmux = <PINMUX_GPIO111__FUNC_MSDC1_CLK>;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +	};
> +
> +	i2c0_pins: i2c0-pins {
> +		pins {
> +			pinmux = <PINMUX_GPIO8__FUNC_SDA0>,
> +				 <PINMUX_GPIO9__FUNC_SCL0>;
> +			bias-pull-up;
> +			mediatek,rsel = <MTK_PULL_SET_RSEL_111>;
> +			mediatek,drive-strength-adv = <7>;
> +		};
> +	};
> +
> +	i2c1_pins: i2c1-pins {
> +		pins {
> +			pinmux = <PINMUX_GPIO10__FUNC_SDA1>,
> +				 <PINMUX_GPIO11__FUNC_SCL1>;
> +			bias-pull-up;
> +			mediatek,rsel = <MTK_PULL_SET_RSEL_111>;
> +			mediatek,drive-strength-adv = <7>;
> +		};
> +	};
> +
> +	i2c2_pins: i2c2-pins {
> +		pins {
> +			pinmux = <PINMUX_GPIO12__FUNC_SDA2>,
> +				 <PINMUX_GPIO13__FUNC_SCL2>;
> +			bias-pull-up;
> +			mediatek,rsel = <MTK_PULL_SET_RSEL_111>;
> +			mediatek,drive-strength-adv = <7>;
> +		};
> +	};
> +
> +	i2c6_pins: i2c6-pin {
> +		pins {
> +			pinmux = <PINMUX_GPIO25__FUNC_SDA6>,
> +				 <PINMUX_GPIO26__FUNC_SCL6>;
> +			bias-pull-up;
> +			mediatek,rsel = <MTK_PULL_SET_RSEL_111>;
> +		};
> +	};
> +
> +	spi2_pins: spi-pins {
> +		pins {
> +			pinmux = <PINMUX_GPIO140__FUNC_SPIM2_CSB>,
> +				 <PINMUX_GPIO141__FUNC_SPIM2_CLK>,
> +				 <PINMUX_GPIO142__FUNC_SPIM2_MO>,
> +				 <PINMUX_GPIO143__FUNC_SPIM2_MI>;
> +			bias-disable;
> +		};
> +	};
> +
> +	pcie0_pins_default: pcie0default {
> +		pins {
> +			pinmux = <PINMUX_GPIO19__FUNC_WAKEN>,
> +				 <PINMUX_GPIO20__FUNC_PERSTN>,
> +				 <PINMUX_GPIO21__FUNC_CLKREQN>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	pcie1_pins_default: pcie1default {

No pins suffix? One more pattern of naming...

> +		pins {
> +			pinmux = <PINMUX_GPIO22__FUNC_PERSTN_1>,
> +				 <PINMUX_GPIO23__FUNC_CLKREQN_1>,
> +				 <PINMUX_GPIO24__FUNC_WAKEN_1>;
> +			bias-pull-up;
> +		};
> +
> +		mt7921 {
> +			pinmux = <PINMUX_GPIO65__FUNC_GPIO65>,
> +				 <PINMUX_GPIO67__FUNC_GPIO67>;
> +			output-high;
> +		};
> +	};
> +
> +	gpio_keys: gpio-keys {

gpio-keys-pins

> +		pins {
> +			pinmux = <PINMUX_GPIO106__FUNC_GPIO106>;
> +			input-enable;
> +		};
> +	};
> +

Best regards,
Krzysztof

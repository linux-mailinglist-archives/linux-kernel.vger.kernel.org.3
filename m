Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C5A4A6F0F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241203AbiBBKlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239290AbiBBKla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:41:30 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8E9C061714;
        Wed,  2 Feb 2022 02:41:29 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m11so41028824edi.13;
        Wed, 02 Feb 2022 02:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1QlFOJ/VBy1nDWtREThbhgoZxPq2IK9nGbHMs1EK+uw=;
        b=bhIGGDq4923h0ix9jE0DBkSJpeNyBeR8X+FxXLovJE5mNvIRoe9AY/iFk1bBdcxv9p
         9ieqdwQciyy76WIUOJN7sNeWGRPejMGAaDZrhkhQUHfonw7XOPOWADdV/j3I3ZVrKCyZ
         vJKb/JqEyNs090Hj9b0M7aLKtUPSp7chj+jszDTeiN8hxaDi1sAiLU6JFdXyZjvkrnC+
         DBVRuo5jxUR1zOi5G7YrZfkydpue9ZLP5JZrq+aoT9IonWdb5g1TuZxL114HWbgp7hZB
         6G/FdqT12S5YrqyZC9wMuMZsSZsYPyOn4E8oUrtG8SQ7WekauD8tu153RPv4KctiQyhu
         3KBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1QlFOJ/VBy1nDWtREThbhgoZxPq2IK9nGbHMs1EK+uw=;
        b=jYSOdX/glw9LG3g3uISWsgzK7zrvYVgXoy+EwoVoop3DFwQDaMJPNDqi+81Jt5AA74
         VBurZkt80hHVHxN0FoZedg4zz6jQCgt4WW0NqsFKNQ2QS5345t63fEK8NWkfNL9901Gh
         WorOrzr4NZ7ATXiP+iHK7PhsRSE6Cg/WMaRSQtNtCf0SHWkLjlRKH2IdHxTX40BcxN8F
         ZjAIInfcBlBcqILcjnTbILGAFfausvsEecfORjnTAkM/IbCZI5mmVhKHv4u23f8P3F0N
         RL04+ObvW+FFeQX9K1S3Uata9xSse988qOj9v68zrD0xnv0eaqYL0lOpmYAeRWzm2tZr
         iDtA==
X-Gm-Message-State: AOAM530OvkUVX1BTpz87xtvN2T2VQTuzJgn8dqJSfx6w8A9ezZX2gIKe
        msMI2IgUD57QjSxhjHAgf1Q=
X-Google-Smtp-Source: ABdhPJxcGrncnmauR1t1XA3S2bH06wIJMRP74wYrcXj1d4+rBETPfDyi0ZmKH8NtFatDfLH3wXG4Wg==
X-Received: by 2002:a50:eb46:: with SMTP id z6mr29237781edp.229.1643798487857;
        Wed, 02 Feb 2022 02:41:27 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f8sm625826ejw.123.2022.02.02.02.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 02:41:27 -0800 (PST)
Message-ID: <153a5ddf-74d0-71e9-2694-5d1fc51472db@gmail.com>
Date:   Wed, 2 Feb 2022 11:41:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Pine64 PineNote board
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Alex Bee <knaerzche@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Levin Du <djw@t-chip.com.cn>, Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tianling Shen <cnsztl@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20220130053803.43660-1-samuel@sholland.org>
 <20220130053803.43660-3-samuel@sholland.org>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20220130053803.43660-3-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

Some comments, have a look if it's useful.

Could you test with:
ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make dtbs_check

dtc -I dtb -O dts rk3566-pinenote-v1.2.dtb

Fix a few notifications.

Johan

On 1/30/22 06:38, Samuel Holland wrote:
> The PineNote is a tablet from Pine64 based on the RK3566 SoC, featuring
> 4G/128G of storage, a 10.3" electrophoretic display (EPD) with two-color
> frontlight, both EMR and capacitive digitizers, dual-band wireless,
> quad-channel digital microphones, and stereo speakers.
> 
> There are two existing variants of the board. v1.1 was contained in some
> early samples, and v1.2 was sold as the "PineNote Developer Edition".
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  arch/arm64/boot/dts/rockchip/Makefile         |   2 +
>  .../dts/rockchip/rk3566-pinenote-v1.1.dts     |  18 +
>  .../dts/rockchip/rk3566-pinenote-v1.2.dts     |  18 +
>  .../boot/dts/rockchip/rk3566-pinenote.dtsi    | 638 ++++++++++++++++++
>  4 files changed, 676 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-pinenote-v1.1.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-pinenote-v1.2.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 479906f3ad7b..2e67f2558b6a 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -56,5 +56,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.1.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote-v1.1.dts b/arch/arm64/boot/dts/rockchip/rk3566-pinenote-v1.1.dts
> new file mode 100644
> index 000000000000..1901a456e91b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote-v1.1.dts
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include "rk3566-pinenote.dtsi"
> +
> +/ {
> +	model = "Pine64 PineNote v1.1";
> +	compatible = "pine64,pinenote-v1.1", "pine64,pinenote", "rockchip,rk3566";
> +};
> +

> +&spk_amp {

sort node names

> +	VCC-supply = <&dcdc_boost>;
> +};
> +
> +&pmu_io_domains {
> +	vccio7-supply = <&vcc_1v8>;
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote-v1.2.dts b/arch/arm64/boot/dts/rockchip/rk3566-pinenote-v1.2.dts
> new file mode 100644
> index 000000000000..d7f5372fc40f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote-v1.2.dts
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include "rk3566-pinenote.dtsi"
> +
> +/ {
> +	model = "Pine64 PineNote v1.2";
> +	compatible = "pine64,pinenote-v1.2", "pine64,pinenote", "rockchip,rk3566";
> +};
> +

> +&spk_amp {

sort node names

> +	VCC-supply = <&vcc_bat>;
> +};
> +
> +&pmu_io_domains {
> +	vccio7-supply = <&vcc_3v3>;
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
> new file mode 100644
> index 000000000000..0d8f4db3901d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
> @@ -0,0 +1,638 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +
> +#include "rk3566.dtsi"
> +
> +/ {
> +	aliases {
> +		mmc0 = &sdhci;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +

> +	adc-keys-0 {

There's only one adc-key node.
Are you expecting more of them?
Maybe use:

adc-keys {


> +		compatible = "adc-keys";

> +		io-channels = <&saradc 0>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1750000>;

> +

> +		button-recovery {

recovery {

> +			label = "Recovery";

		label = "recovery";

This shows up in a user space path.
People don't like typing camel cases.
Stay in line with other boards.

> +			linux,code = <KEY_VENDOR>;
> +			press-threshold-microvolt = <0>;
> +		};
> +	};
> +

> +	spk_amp: audio-amplifier {

sort node names

> +		compatible = "simple-audio-amplifier";
> +		enable-gpios = <&gpio3 RK_PC4 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&spk_amp_enable_h>;
> +		pinctrl-names = "default";
> +		sound-name-prefix = "Speaker Amp";
> +	};
> +
> +	dmic_codec: dmic-codec {
> +		compatible = "dmic-codec";
> +		num-channels = <6>;
> +		#sound-dai-cells = <0>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&hall_int_l>;
> +		pinctrl-names = "default";
> +

> +		switch-cover {

cover {

> +			label = "Cover";


		label = "cover";

This shows up in a user space path.
People don't like typing camel cases.
Stay in line with other boards.

> +			gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <EV_SW>;
> +			linux,code = <SW_MACHINE_COVER>;
> +			linux,can-disable;
> +			wakeup-event-action = <EV_ACT_DEASSERTED>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";

> +		pinctrl-0 = <&led_gpio>;

		pinctrl-0 = <&led_pin>;

gpio is a reserved node name.
~/.local/lib/python3.7/site-packages/dtschema/schemas/gpio/gpio-consumer.yaml

> +		pinctrl-names = "default";
> +
> +		led-0 {
> +			color = <LED_COLOR_ID_WHITE>;
> +			function = LED_FUNCTION_CHARGING;
> +			gpios = <&gpio3 RK_PC5 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		clocks = <&rk817 1>;
> +		clock-names = "ext_clock";
> +		pinctrl-0 = <&wifi_enable_h>;
> +		pinctrl-names = "default";
> +		reset-gpios = <&gpio0 RK_PC6 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";

> +		#address-cells = <1>;
> +		#size-cells = <0>;

Move thing that start with "#" down the list as possible.

> +		simple-audio-card,name = "PineNote";
> +		simple-audio-card,aux-devs = <&spk_amp>;
> +		simple-audio-card,widgets = "Headphone", "Headphones",
> +					    "Speaker", "Internal Speakers";
> +		simple-audio-card,routing = "Headphones", "HPOL",
> +					    "Headphones", "HPOR",
> +					    "Internal Speakers", "Speaker Amp OUTL",
> +					    "Internal Speakers", "Speaker Amp OUTR",
> +					    "Speaker Amp INL", "HPOL",
> +					    "Speaker Amp INR", "HPOR";
> +		simple-audio-card,pin-switches = "Internal Speakers";
> +
> +		simple-audio-card,dai-link@0 {

<stdout>: Warning (unit_address_vs_reg):
/sound/simple-audio-card,dai-link@0: node has a unit name, but no reg
property

> +			format = "i2s";
> +			mclk-fs = <256>;
> +			frame-master = <&link0_cpu>;
> +			bitclock-master = <&link0_cpu>;
> +
> +			link0_cpu: cpu {
> +				sound-dai = <&i2s1_8ch>;
> +			};
> +
> +			link0_codec: codec {
> +				sound-dai = <&rk817>;
> +			};
> +		};
> +
> +		simple-audio-card,dai-link@1 {


<stdout>: Warning (unit_address_vs_reg):
/sound/simple-audio-card,dai-link@1: node has a unit name, but no reg
property

> +			format = "pdm";
> +			frame-master = <&link1_cpu>;
> +			bitclock-master = <&link1_cpu>;
> +
> +			link1_cpu: cpu {
> +				sound-dai = <&pdm>;
> +			};
> +
> +			link1_codec: codec {
> +				sound-dai = <&dmic_codec>;
> +			};
> +		};
> +	};
> +
> +	vbat_4g: vbat-4g {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vbat_4g";
> +		regulator-min-microvolt = <3800000>;
> +		regulator-max-microvolt = <3800000>;
> +		/* powered by vcc_bat, enabled by vbat_4g_en */
> +		vin-supply = <&vbat_4g_en>;
> +	};
> +
> +	vcc_1v8: vcc-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_1v8";
> +		regulator-always-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		/* powered by vcc_sys, enabled by vcc_1v8_en */
> +		vin-supply = <&vcc_1v8_en>;
> +	};
> +
> +	vcc_bat: vcc-bat {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_bat";
> +		regulator-always-on;
> +		regulator-min-microvolt = <3800000>;
> +		regulator-max-microvolt = <3800000>;
> +	};
> +
> +	vcc_hall_3v3: vcc-hall-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_hall_3v3";
> +		regulator-always-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_sys>;
> +	};
> +
> +	vcc_sys: vcc-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_sys";
> +		regulator-always-on;
> +		regulator-min-microvolt = <3800000>;
> +		regulator-max-microvolt = <3800000>;
> +		vin-supply = <&vcc_bat>;
> +	};
> +
> +	vcc_wl: vcc-wl {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PA0 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&vcc_wl_gpio>;
> +		pinctrl-names = "default";
> +		regulator-name = "vcc_wl";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_bat>;
> +	};
> +
> +	vdda_0v9: vdda-0v9 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdda_0v9";
> +		regulator-always-on;
> +		regulator-min-microvolt = <900000>;
> +		regulator-max-microvolt = <900000>;
> +		/* powered by vcc_sys, enabled by vcc_1v8_en */
> +		vin-supply = <&vcc_1v8_en>;
> +	};
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu2 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu3 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	vdd_cpu: regulator@1c {
> +		compatible = "tcs,tcs4525";
> +		reg = <0x1c>;
> +		fcs,suspend-voltage-selector = <0>;
> +		regulator-name = "vdd_cpu";
> +		regulator-min-microvolt = <712500>;
> +		regulator-max-microvolt = <1390000>;
> +		regulator-ramp-delay = <2300>;
> +		regulator-always-on;
> +		vin-supply = <&vcc_sys>;
> +
> +		regulator-state-mem {
> +			regulator-on-in-suspend;
> +		};
> +	};
> +
> +	rk817: pmic@20 {
> +		compatible = "rockchip,rk817";
> +		reg = <0x20>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
> +		assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
> +		assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
> +		clocks = <&cru I2S1_MCLKOUT_TX>;
> +		clock-names = "mclk";
> +		#clock-cells = <1>;
> +		pinctrl-0 = <&i2s1m0_mclk>, <&pmic_int_l>, <&pmic_sleep>;
> +		pinctrl-names = "default";
> +		rockchip,system-power-controller;
> +		#sound-dai-cells = <0>;
> +		wakeup-source;
> +
> +		vcc1-supply = <&vcc_sys>;
> +		vcc2-supply = <&vcc_sys>;
> +		vcc3-supply = <&vcc_sys>;
> +		vcc4-supply = <&vcc_sys>;
> +		vcc5-supply = <&vcc_sys>;
> +		vcc6-supply = <&vcc_sys>;
> +		vcc7-supply = <&vcc_sys>;
> +		vcc8-supply = <&vcc_sys>;
> +		vcc9-supply = <&dcdc_boost>;
> +
> +		regulators {
> +			vdd_logic: DCDC_REG1 {
> +				regulator-name = "vdd_logic";
> +				regulator-always-on;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-init-microvolt = <900000>;
> +				regulator-ramp-delay = <6001>;
> +				regulator-initial-mode = <0x2>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <900000>;
> +				};
> +			};
> +
> +			vdd_gpu_npu: DCDC_REG2 {
> +				regulator-name = "vdd_gpu_npu";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-init-microvolt = <900000>;
> +				regulator-ramp-delay = <6001>;
> +				regulator-initial-mode = <0x2>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_ddr: DCDC_REG3 {
> +				regulator-name = "vcc_ddr";
> +				regulator-always-on;
> +				regulator-initial-mode = <0x2>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcc_3v3: DCDC_REG4 {
> +				regulator-name = "vcc_3v3";
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-initial-mode = <0x2>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcca_1v8_pmu: LDO_REG1 {
> +				regulator-name = "vcca_1v8_pmu";
> +				regulator-always-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			/* unused */
> +			vdda_0v9_ldo: LDO_REG2 {
> +				regulator-name = "vdda_0v9_ldo";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda_0v9_pmu: LDO_REG3 {
> +				regulator-name = "vdda_0v9_pmu";
> +				regulator-always-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vccio_acodec: LDO_REG4 {
> +				regulator-name = "vccio_acodec";
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			/* unused */
> +			vccio_sd: LDO_REG5 {
> +				regulator-name = "vccio_sd";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_3v3_pmu: LDO_REG6 {
> +				regulator-name = "vcc_3v3_pmu";
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8_en: LDO_REG7 {
> +				regulator-name = "vcc_1v8_en";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vbat_4g_en: LDO_REG8 {
> +				regulator-name = "vbat_4g_en";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			sleep_sta_ctl: LDO_REG9 {
> +				regulator-name = "sleep_sta_ctl";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			dcdc_boost: BOOST {
> +				regulator-name = "boost";
> +				regulator-min-microvolt = <5000000>;
> +				regulator-max-microvolt = <5000000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			otg_switch: OTG_SWITCH {
> +				regulator-name = "otg_switch";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +
> +	digitizer@9 {
> +		compatible = "wacom,w9013", "hid-over-i2c";
> +		reg = <0x09>;
> +		hid-descr-addr = <0x1>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PB6 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-0 = <&pen_fwe>, <&pen_irq_l>, <&pen_rst_l>;
> +		pinctrl-names = "default";
> +		vdd-supply = <&vcc_3v3_pmu>;
> +	};
> +};
> +
> +&i2c3 {
> +	pinctrl-0 = <&i2c3m1_xfer>;
> +	status = "okay";
> +
> +	led-controller@36 {
> +		compatible = "ti,lm3630a";
> +		reg = <0x36>;

> +		#address-cells = <1>;
> +		#size-cells = <0>;

Move thing that start with "#" down the list as possible.


> +		enable-gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&backlight_hwen_h>;
> +		pinctrl-names = "default";
> +
> +		led@0 {
> +			reg = <0>;
> +			label = "backlight_cool";
> +			default-brightness = <0>;
> +		};
> +
> +		led@1 {
> +			reg = <1>;
> +			label = "backlight_warm";
> +			default-brightness = <0>;
> +		};
> +	};
> +};
> +
> +&i2s1_8ch {
> +	pinctrl-0 = <&i2s1m0_lrcktx>, <&i2s1m0_sclktx>, <&i2s1m0_sdi0>, <&i2s1m0_sdo0>;
> +	rockchip,trcm-sync-tx-only;
> +	status = "okay";
> +};
> +
> +&pdm {
> +	pinctrl-0 = <&pdmm0_clk1>, <&pdmm0_sdi1>, <&pdmm0_sdi2>;
> +	/* microphones are on channels 1 and 2 */
> +	rockchip,path-map = <1>, <2>, <0>, <3>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	audio-amplifier {
> +		spk_amp_enable_h: spk-amp-enable-h {
> +			rockchip,pins = <3 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	backlight {
> +		backlight_hwen_h: backlight-hwen-h {
> +			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	bt {
> +		bt_enable_h: bt-enable-h {
> +			rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		bt_host_wake_l: bt-host-wake-l {
> +			rockchip,pins = <0 RK_PC3 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
> +		bt_wake_h: bt-wake-h {
> +			rockchip,pins = <0 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	led {

> +		led_gpio: led-gpio {

		led_pin: led-pin {

gpio is a reserved node name.
~/.local/lib/python3.7/site-packages/dtschema/schemas/gpio/gpio-consumer.yaml

> +			rockchip,pins = <3 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +

> +	hall {

Maybe use:
	key {
Keep node name above and in pinctrl aligned.

> +		hall_int_l: hall-int-l {
> +			rockchip,pins = <0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pen {
> +		pen_fwe: pen-fwe {
> +			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +
> +		pen_irq_l: pen-irq-l {
> +			rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		pen_rst_l: pen-rst-l {
> +			rockchip,pins = <0 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pmic {
> +		pmic_int_l: pmic-int-l {
> +			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		pmic_sleep: pmic-sleep {
> +			rockchip,pins = <0 RK_PA2 1 &pcfg_pull_none>;
> +		};
> +	};
> +
> +	sdio-pwrseq {
> +		wifi_enable_h: wifi-enable-h {
> +			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	vcc-wl {

> +		vcc_wl_gpio: vcc-wl-gpio {

		vcc_wl_pin: vcc-wl-pin {

gpio is a reserved node name.
~/.local/lib/python3.7/site-packages/dtschema/schemas/gpio/gpio-consumer.yaml

> +			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	wifi {
> +		wifi_host_wake_l: wifi-host-wake-l {
> +			rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +};
> +
> +&pmu_io_domains {
> +	pmuio1-supply = <&vcc_3v3_pmu>;
> +	pmuio2-supply = <&vcc_3v3_pmu>;
> +	vccio1-supply = <&vccio_acodec>;
> +	vccio2-supply = <&vcc_1v8>;
> +	vccio3-supply = <&vcc_3v3>;
> +	vccio4-supply = <&vcca_1v8_pmu>;
> +	vccio5-supply = <&vcc_3v3>;
> +	vccio6-supply = <&vcc_3v3>;
> +	status = "okay";
> +};
> +
> +&saradc {
> +	vref-supply = <&vcc_1v8>;
> +	status = "okay";
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	mmc-hs200-1_8v;
> +	non-removable;
> +	pinctrl-0 = <&emmc_bus8>, <&emmc_clk>, <&emmc_cmd>, <&emmc_datastrobe>, <&emmc_rstnout>;
> +	pinctrl-names = "default";
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&vcc_1v8>;
> +	status = "okay";
> +};
> +
> +&sdmmc1 {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;

> +	disable-wp;

From mmc-controller.yaml:

  disable-wp:
    $ref: /schemas/types.yaml#/definitions/flag
    description:
      When set, no physical write-protect line is present. This
      property should only be specified when the controller has a
      dedicated write-protect detection logic. If a GPIO is always used
      for the write-protect detection logic, it is sufficient to not
      specify the wp-gpios property in the absence of a write-protect
      line. Not used in combination with eMMC or SDIO.

> +	keep-power-in-suspend;
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +	non-removable;
> +	pinctrl-0 = <&sdmmc1_bus4>, <&sdmmc1_clk>, <&sdmmc1_cmd>;
> +	pinctrl-names = "default";
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc_wl>;
> +	vqmmc-supply = <&vcca_1v8_pmu>;
> +	status = "okay";
> +};
> +
> +&tsadc {
> +	/* tshut mode 0:CRU 1:GPIO */
> +	rockchip,hw-tshut-mode = <1>;
> +	/* tshut polarity 0:LOW 1:HIGH */
> +	rockchip,hw-tshut-polarity = <0>;
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-0 = <&uart1m0_ctsn>, <&uart1m0_rtsn>, <&uart1m0_xfer>;
> +	pinctrl-names = "default";
> +	uart-has-rtscts;
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "brcm,bcm43438-bt";
> +		clocks = <&rk817 1>;
> +		clock-names = "lpo";
> +		device-wake-gpios = <&gpio0 RK_PC2 GPIO_ACTIVE_HIGH>;
> +		host-wake-gpios = <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;
> +		pinctrl-0 = <&bt_enable_h>, <&bt_host_wake_l>, <&bt_wake_h>;
> +		pinctrl-names = "default";
> +		vbat-supply = <&vcc_wl>;
> +		vddio-supply = <&vcca_1v8_pmu>;
> +	};
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99929567888
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiGEUhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiGEUhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:37:10 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80B411476;
        Tue,  5 Jul 2022 13:37:07 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id k15so12268807iok.5;
        Tue, 05 Jul 2022 13:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2AK+5tQ9BJgVWotOiRKlz1EQTGfMAq8CmeP19xdHaP4=;
        b=KsMKo97h5ve1WjW7jWv2K02QaQQxfKJ3F916zgYsxh563KE/yf1jLKmUKQHeJsjwO2
         1K0pcDFrQ4fAX7/M3MsE6uShXgksoC26aGQ32BEo6ySTdSyR1voVRHo6sPlLCFaRXbHG
         oPMypCW+eJ898/qgijDQbNrBO1WKsjzYiYrP8sJIccSSJxfWaQPLnw14hIjv3XgbvtMe
         r4aP658K+eTp9i3EYT4KVzpqqk0ZMFeFy/D+GmdBJsLefy9F8zxCNn2m4vhnMTmmolrY
         b3QAGfoN36rAl9nBBmkxv+8jg1DWnzLADpkC0hj8UF1XniTH7kCIxM8UI2rIQQcpDiIH
         Cl/Q==
X-Gm-Message-State: AJIora9Cm1atVo4rwVc3sRLcNngKdiasCD/2bZrwi0vtT3tmsLbULKFU
        RzVvpYNDn7xYzO/XeCY0oYiBmCDKjQ==
X-Google-Smtp-Source: AGRyM1sIySHlccKE3E4EEMs2QdziSW3rzH4AN7SIXzDynhdJ4fhwO7aeEoPvwr4SIvbGR40pnfkG9A==
X-Received: by 2002:a02:228d:0:b0:333:ffe9:864b with SMTP id o135-20020a02228d000000b00333ffe9864bmr22423768jao.277.1657053427043;
        Tue, 05 Jul 2022 13:37:07 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z6-20020a05660217c600b006692192baf7sm16080109iox.25.2022.07.05.13.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:37:06 -0700 (PDT)
Received: (nullmailer pid 2582032 invoked by uid 1000);
        Tue, 05 Jul 2022 20:37:05 -0000
Date:   Tue, 5 Jul 2022 14:37:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     andyshrk@163.com
Cc:     heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add dts for a rk3399 based board
 EAIDK-610
Message-ID: <20220705203705.GA2575964-robh@kernel.org>
References: <20220703120706.2041794-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220703120706.2041794-1-andyshrk@163.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2022 at 08:07:06PM +0800, andyshrk@163.com wrote:
> From: Andy Yan <andyshrk@163.com>
> 
> EAIDK-610 is from OPEN AI LAB and popularly used by university
> students.
> 
> Specification:
> - Rockchip RK3399
> - LPDDR3 4GB
> - TF sd scard slot
> - eMMC
> - AP6255 for WiFi + BT
> - Gigabit ethernet
> - HDMI out
> - 40 pin header
> - USB 2.0 x 2
> - USB 3.0 x 1
> - USB 3.0 Type-C x 1
> - 12V DC Power supply
> 
> This patch is test on Armbain and Glodroid with
> HDMI/GPU/USB HOST/Type-C ADB/WIFI.
> 
> Signed-off-by: Andy Yan <andyshrk@163.com>
> ---
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +

Bindings should be a separate patch.

>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3399-eaidk-610.dts    | 899 ++++++++++++++++++
>  4 files changed, 907 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index cf9eb1e8326a..f1dd87b1544e 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -470,6 +470,11 @@ properties:
>            - const: netxeon,r89
>            - const: rockchip,rk3288
>  
> +      - description: OPEN AI LAB EAIDK-610
> +        items:
> +          - const: openailab,eaidk-610
> +          - const: rockchip,rk3399
> +
>        - description: Orange Pi RK3399 board
>          items:
>            - const: rockchip,rk3399-orangepi
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 0496773a3c4d..bc5011d79371 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -907,6 +907,8 @@ patternProperties:
>      description: On Tat Industrial Company
>    "^opalkelly,.*":
>      description: Opal Kelly Incorporated
> +  "^openailab,.*":
> +    description: openailab.com
>    "^opencores,.*":
>      description: OpenCores.org
>    "^openembed,.*":
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 18d00eae3072..addc8755709b 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -21,6 +21,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-orion-r68-meta.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-px5-evb.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-r88.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-evb.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-eaidk-610.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-ficus.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-firefly.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-bob.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts b/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts
> new file mode 100644
> index 000000000000..00eee40d646c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts
> @@ -0,0 +1,899 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2022 Fuzhou Rockchip Electronics Co., Ltd.
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/pwm/pwm.h>
> +#include <dt-bindings/usb/pd.h>
> +#include "rk3399.dtsi"
> +#include "rk3399-opp.dtsi"
> +
> +/ {
> +	model = "OPEN AI LAB EAIDK-610";
> +	compatible = "openailab,eaidk-610", "rockchip,rk3399";
> +
> +	aliases {
> +		mmc0 = &sdio0;
> +		mmc1 = &sdmmc;
> +		mmc2 = &sdhci;
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm0 0 25000 0>;
> +		brightness-levels = <
> +			  0   1   2   3   4   5   6   7
> +			  8   9  10  11  12  13  14  15
> +			 16  17  18  19  20  21  22  23
> +			 24  25  26  27  28  29  30  31
> +			 32  33  34  35  36  37  38  39
> +			 40  41  42  43  44  45  46  47
> +			 48  49  50  51  52  53  54  55
> +			 56  57  58  59  60  61  62  63
> +			 64  65  66  67  68  69  70  71
> +			 72  73  74  75  76  77  78  79
> +			 80  81  82  83  84  85  86  87
> +			 88  89  90  91  92  93  94  95
> +			 96  97  98  99 100 101 102 103
> +			104 105 106 107 108 109 110 111
> +			112 113 114 115 116 117 118 119
> +			120 121 122 123 124 125 126 127
> +			128 129 130 131 132 133 134 135
> +			136 137 138 139 140 141 142 143
> +			144 145 146 147 148 149 150 151
> +			152 153 154 155 156 157 158 159
> +			160 161 162 163 164 165 166 167
> +			168 169 170 171 172 173 174 175
> +			176 177 178 179 180 181 182 183
> +			184 185 186 187 188 189 190 191
> +			192 193 194 195 196 197 198 199
> +			200 201 202 203 204 205 206 207
> +			208 209 210 211 212 213 214 215
> +			216 217 218 219 220 221 222 223
> +			224 225 226 227 228 229 230 231
> +			232 233 234 235 236 237 238 239
> +			240 241 242 243 244 245 246 247
> +			248 249 250 251 252 253 254 255>;
> +		default-brightness-level = <200>;
> +	};
> +
> +	clkin_gmac: external-gmac-clock {
> +		compatible = "fixed-clock";
> +		clock-frequency = <125000000>;
> +		clock-output-names = "clkin_gmac";
> +		#clock-cells = <0>;
> +	};
> +
> +	dc_12v: dc-12v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "dc_12v";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		autorepeat;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwrbtn>;
> +
> +		power {

key-power

> +			debounce-interval = <100>;
> +			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
> +			label = "GPIO Key Power";
> +			linux,code = <KEY_POWER>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&work_led_pin>, <&user_led_pin>,
> +			    <&heartbeat_led_pin>, <&wlan_active_led_pin>,
> +			    <&bt_active_led_pin>;
> +
> +		work_led: led-0 {
> +			label = "blue:work";
> +			default-state = "on";
> +			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		user_led: led-1 {
> +			label = "read:user";
> +			default-state = "off";
> +			gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		heartbeat_led: led-2 {
> +			label = "green:heartbeat";
> +			linux,default-trigger = "heartbeat";
> +			gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		wlan_active_led: led-3 {
> +			label = "yellow:wlan";
> +			gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "phy0tx";
> +			default-state = "off";
> +		};
> +
> +		bt_active_led: led-4 {
> +			label = "blue:bt";
> +			gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "hci0-power";
> +			default-state = "off";
> +		};
> +	};
> +
> +	rt5651-sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "realtek,rt5651-codec";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,mclk-fs = <256>;
> +		simple-audio-card,widgets =
> +			"Microphone", "Mic Jack",
> +			"Headphone", "Headphone Jack";
> +		simple-audio-card,routing =
> +			"Mic Jack", "MICBIAS1",
> +			"IN1P", "Mic Jack",
> +			"Headphone Jack", "HPOL",
> +			"Headphone Jack", "HPOR";
> +		simple-audio-card,cpu {
> +			sound-dai = <&i2s1>;
> +		};
> +		simple-audio-card,codec {
> +			sound-dai = <&rt5651>;
> +		};
> +	};
> +
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		clocks = <&rk808 1>;
> +		clock-names = "ext_clock";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_enable_h>;
> +
> +		/*
> +		 * On the module itself this is one of these (depending
> +		 * on the actual card populated):
> +		 * - SDIO_RESET_L_WL_REG_ON
> +		 * - PDN (power down when low)
> +		 */
> +		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	/* switched by pmic_sleep */
> +	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc1v8_s3";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc_1v8>;
> +	};
> +
> +	vcc3v3_sys: vcc3v3-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&dc_12v>;
> +	};
> +
> +	vcc5v0_sys: vcc5v0-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&dc_12v>;
> +	};
> +
> +	/* For USB3.0 Port1/2 */
> +	vcc5v0_host1: vcc5v0-host1-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_host1_en>;
> +		regulator-name = "vcc5v0_host1";
> +		regulator-always-on;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	/* For USB2.0 Port1/2 */
> +	vcc5v0_host3: vcc5v0-host3-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PB0 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_host3_en>;
> +		regulator-name = "vcc5v0_host3";
> +		regulator-always-on;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc5v0_typec: vcc5v0-typec-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio4 RK_PC5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_typec_en>;
> +		regulator-name = "vcc5v0_typec";
> +		regulator-always-on;
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	vdd_log: vdd-log {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_log";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <900000>;
> +		regulator-max-microvolt = <900000>;
> +	};
> +};
> +
> +&cpu_l0 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&cpu_l1 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&cpu_l2 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&cpu_l3 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&cpu_b0 {
> +	cpu-supply = <&vdd_cpu_b>;
> +};
> +
> +&cpu_b1 {
> +	cpu-supply = <&vdd_cpu_b>;
> +};
> +
> +&emmc_phy {
> +	status = "okay";
> +};
> +
> +&gmac {
> +	assigned-clocks = <&cru SCLK_RMII_SRC>;
> +	assigned-clock-parents = <&clkin_gmac>;
> +	clock_in_out = "input";
> +	phy-supply = <&vcc_lan>;
> +	phy-mode = "rgmii";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmii_pins>;
> +	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> +	snps,reset-active-low;
> +	snps,reset-delays-us = <0 10000 50000>;
> +	tx_delay = <0x28>;
> +	rx_delay = <0x11>;
> +	status = "okay";
> +};
> +
> +&gpu {
> +	mali-supply = <&vdd_gpu>;
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	ddc-i2c-bus = <&i2c3>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&hdmi_cec>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	rk808: pmic@1b {
> +		compatible = "rockchip,rk808";
> +		reg = <0x1b>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_int_l>;
> +		rockchip,system-power-controller;
> +		wakeup-source;
> +		#clock-cells = <1>;
> +		clock-output-names = "xin32k", "rk808-clkout2";
> +
> +		vcc1-supply = <&vcc3v3_sys>;
> +		vcc2-supply = <&vcc3v3_sys>;
> +		vcc3-supply = <&vcc3v3_sys>;
> +		vcc4-supply = <&vcc3v3_sys>;
> +		vcc6-supply = <&vcc3v3_sys>;
> +		vcc7-supply = <&vcc3v3_sys>;
> +		vcc8-supply = <&vcc3v3_sys>;
> +		vcc9-supply = <&vcc3v3_sys>;
> +		vcc10-supply = <&vcc3v3_sys>;
> +		vcc11-supply = <&vcc3v3_sys>;
> +		vcc12-supply = <&vcc3v3_sys>;
> +		vddio-supply = <&vcc_3v0>;
> +
> +		regulators {
> +			vdd_center: DCDC_REG1 {
> +				regulator-name = "vdd_center";
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_cpu_l: DCDC_REG2 {
> +				regulator-name = "vdd_cpu_l";
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_ddr: DCDC_REG3 {
> +				regulator-name = "vcc_ddr";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8: DCDC_REG4 {
> +				regulator-name = "vcc_1v8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vcc1v8_dvp: LDO_REG1 {
> +				regulator-name = "vcc1v8_dvp";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc2v8_dvp: LDO_REG2 {
> +				regulator-name = "vcc2v8_dvp";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc1v8_pmu: LDO_REG3 {
> +				regulator-name = "vcc1v8_pmu";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vcc_sdio: LDO_REG4 {
> +				regulator-name = "vcc_sdio";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3000000>;
> +				};
> +			};
> +
> +			vcca3v0_codec: LDO_REG5 {
> +				regulator-name = "vcca3v0_codec";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v5: LDO_REG6 {
> +				regulator-name = "vcc_1v5";
> +				regulator-min-microvolt = <1500000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1500000>;
> +				};
> +			};
> +
> +			vcca1v8_codec: LDO_REG7 {
> +				regulator-name = "vcca1v8_codec";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_3v0: LDO_REG8 {
> +				regulator-name = "vcc_3v0";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3000000>;
> +				};
> +			};
> +
> +			vcc3v3_s3: vcc_lan: SWITCH_REG1 {
> +				regulator-name = "vcc3v3_s3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc3v3_s0: SWITCH_REG2 {
> +				regulator-name = "vcc3v3_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +	};
> +
> +	vdd_cpu_b: regulator@40 {
> +		compatible = "silergy,syr827";
> +		reg = <0x40>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu_b";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vsel1_pin>;
> +		regulator-min-microvolt = <712500>;
> +		regulator-max-microvolt = <1500000>;
> +		regulator-ramp-delay = <1000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc3v3_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	vdd_gpu: regulator@41 {
> +		compatible = "silergy,syr828";
> +		reg = <0x41>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_gpu";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vsel2_pin>;
> +		regulator-min-microvolt = <712500>;
> +		regulator-max-microvolt = <1500000>;
> +		regulator-ramp-delay = <1000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc3v3_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	i2c-scl-rising-time-ns = <300>;
> +	i2c-scl-falling-time-ns = <15>;
> +	status = "okay";
> +
> +	rt5651: rt5651@1a {

audio-codec@1a

> +		compatible = "rockchip,rt5651";
> +		reg = <0x1a>;
> +		clocks = <&cru SCLK_I2S_8CH_OUT>;
> +		clock-names = "mclk";
> +		hp-det-gpio = <&gpio4 RK_PD4 GPIO_ACTIVE_LOW>;
> +		spk-con-gpio = <&gpio0 RK_PB3 GPIO_ACTIVE_HIGH>;
> +		#sound-dai-cells = <0>;
> +	};
> +
> +};
> +
> +&i2c3 {
> +	i2c-scl-rising-time-ns = <450>;
> +	i2c-scl-falling-time-ns = <15>;
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	i2c-scl-rising-time-ns = <600>;
> +	i2c-scl-falling-time-ns = <20>;
> +	status = "okay";
> +
> +	fusb0: typec-portc@22 {
> +		compatible = "fcs,fusb302";
> +		reg = <0x22>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&fusb0_int>;
> +		vbus-supply = <&vcc5v0_typec>;
> +		status = "okay";

That's the default, drop.

Rob

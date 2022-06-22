Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77ED554A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbiFVMkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 08:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350684AbiFVMkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:40:15 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BFF3E5E3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 05:39:45 -0700 (PDT)
Received: from [192.168.1.101] (abxi223.neoplus.adsl.tpnet.pl [83.9.2.223])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id EDF492063E;
        Wed, 22 Jun 2022 14:39:43 +0200 (CEST)
Message-ID: <fb234ad7-6a95-d5f2-9ebc-48ac2dd8fb8a@somainline.org>
Date:   Wed, 22 Jun 2022 14:39:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad
 X13s devicetree
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
 <20220622041224.627803-7-bjorn.andersson@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220622041224.627803-7-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.06.2022 06:12, Bjorn Andersson wrote:
> From: Johan Hovold <johan+linaro@kernel.org>
> 
> Add an initial Lenovo Thinkpad X13s devicetree.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changs since v1:
> - New patch
> 
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 393 ++++++++++++++++++
>  2 files changed, 394 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 2f416b84b71c..43053f1f6be9 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -91,6 +91,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-crd.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-lenovo-thinkpad-x13s.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-ganges-kirin.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-discovery.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-pioneer.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> new file mode 100644
> index 000000000000..58d3d8035751
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -0,0 +1,393 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
Can be moved to SoC dtsi.
> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +#include "sc8280xp.dtsi"
> +#include "sc8280xp-pmics.dtsi"
> +
> +/ {
> +	model = "Lenovo ThinkPad X13s";
> +	compatible = "lenovo,thinkpad-x13s", "qcom,sc8280xp";
> +
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pmc8280c_lpg 3 1000000>;
> +		enable-gpios = <&pmc8280_1_gpios 8 GPIO_ACTIVE_HIGH>;
> +		power-supply = <&vreg_edp_bl>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&edp_bl_en>, <&edp_bl_pwm>;
> +	};
> +
> +	vreg_edp_bl: edp-bl-regulator {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VBL9";
> +		regulator-min-microvolt = <3600000>;
> +		regulator-max-microvolt = <3600000>;
> +
> +		gpio = <&pmc8280_1_gpios 9 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&edp_bl_reg_en>;
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_misc_3p3: misc-3p3-regulator {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VCC3B";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&pmc8280_1_gpios 1 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&misc_3p3_reg_en>;
> +
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	reserved-memory {
> +	};
Seems redundant.


> +};
> +
> +&apps_rsc {
> +	pmc8280-1-rpmh-regulators {
> +		compatible = "qcom,pm8350-rpmh-regulators";
> +		qcom,pmic-id = "b";
> +
> +		vdd-l3-l5-supply = <&vreg_s11b>;
> +
> +		vreg_s11b: smps11 {
> +			regulator-name = "vreg_s11b";
> +			regulator-min-microvolt = <1272000>;
> +			regulator-max-microvolt = <1272000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3b: ldo3 {
> +			regulator-name = "vreg_l3b";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-boot-on;
> +		};
> +
> +		vreg_l4b: ldo4 {
> +			regulator-name = "vreg_l4b";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l6b: ldo6 {
> +			regulator-name = "vreg_l6b";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-boot-on;
> +			regulator-always-on;	// FIXME: VDD_A_EDP_0_0P9
> +		};
> +	};
> +
> +	pmc8280c-rpmh-regulators {
> +		compatible = "qcom,pm8350c-rpmh-regulators";
> +		qcom,pmic-id = "c";
> +
> +		vreg_l1c: ldo1 {
> +			regulator-name = "vreg_l1c";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l12c: ldo12 {
> +			regulator-name = "vreg_l12c";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l13c: ldo13 {
> +			regulator-name = "vreg_l13c";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3072000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +	};
> +
> +	pmc8280-2-rpmh-regulators {
> +		compatible = "qcom,pm8350-rpmh-regulators";
> +		qcom,pmic-id = "d";
> +
> +		vdd-l1-l4-supply = <&vreg_s11b>;
> +
> +		vreg_l3d: ldo3 {
> +			regulator-name = "vreg_l3d";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l4d: ldo4 {
> +			regulator-name = "vreg_l4d";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l7d: ldo7 {
> +			regulator-name = "vreg_l7d";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3072000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l9d: ldo9 {
> +			regulator-name = "vreg_l9d";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +	};
> +};
> +
> +&pmc8280c_lpg {
> +	status = "okay";
> +};
> +
> +&pmk8280_pon_pwrkey {
> +	status = "okay";
> +};
> +
> +&qup0 {
> +	status = "okay";
> +};
> +
> +&qup0_i2c4 {
> +	clock-frequency = <400000>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&qup0_i2c4_default>, <&ts0_default>;
> +
> +	status = "okay";
Again, the ordering of status= question from one of the previous patches.


> +
> +	/* FIXME: verify, missing on some x13s */
Won't this fail gracefully-ish if it's absent?


> +	touchscreen@10 {
> +		compatible = "hid-over-i2c";
> +		reg = <0x10>;
> +		hid-descr-addr = <0x1>;
> +		interrupts-extended = <&tlmm 175 IRQ_TYPE_LEVEL_LOW>;
> +		vdd-supply = <&vreg_misc_3p3>;
> +	};
> +};
> +
> +&qup1 {
> +	status = "okay";
> +};
> +
> +&qup2 {
> +	status = "okay";
> +};
> +
> +&qup2_i2c5 {
> +	clock-frequency = <400000>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&qup2_i2c5_default>, <&kybd_default>, <&tpad_default>;
> +
> +	status = "okay";
> +
> +	touchpad@2c {
> +		compatible = "hid-over-i2c";
> +		reg = <0x2c>;
> +		hid-descr-addr = <0x20>;
> +		interrupts-extended = <&tlmm 182 IRQ_TYPE_LEVEL_LOW>;
> +		vdd-supply = <&vreg_misc_3p3>;
> +	};
> +
> +	keyboard@68 {
> +		compatible = "hid-over-i2c";
> +		reg = <0x68>;
> +		hid-descr-addr = <0x1>;
> +		interrupts-extended = <&tlmm 104 IRQ_TYPE_LEVEL_LOW>;
> +		vdd-supply = <&vreg_misc_3p3>;
> +	};
> +};
> +
> +&remoteproc_adsp {
> +	firmware-name = "qcom/sc8280xp/qcadsp8280.mbn";
> +
> +	status = "okay";
> +};
> +
> +&remoteproc_nsp0 {
> +	firmware-name = "qcom/sc8280xp/qccdsp8280.mbn";
> +
> +	status = "okay";
> +};
> +
> +&usb_0 {
> +	status = "okay";
> +};
> +
> +&usb_0_dwc3 {
> +	/* TODO: Define USB-C connector properly */
> +	dr_mode = "host";
> +};
> +
> +&usb_0_hsphy {
> +	vdda-pll-supply = <&vreg_l9d>;
> +	vdda18-supply = <&vreg_l1c>;
> +	vdda33-supply = <&vreg_l7d>;
> +
> +	status = "okay";
> +};
> +
> +&usb_0_qmpphy {
> +	vdda-phy-supply = <&vreg_l9d>;
> +	vdda-pll-supply = <&vreg_l4d>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1 {
> +	status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +	/* TODO: Define USB-C connector properly */
> +	dr_mode = "host";
> +};
> +
> +&usb_1_hsphy {
> +	vdda-pll-supply = <&vreg_l4b>;
> +	vdda18-supply = <&vreg_l1c>;
> +	vdda33-supply = <&vreg_l13c>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_qmpphy {
> +	vdda-phy-supply = <&vreg_l4b>;
> +	vdda-pll-supply = <&vreg_l3b>;
> +
> +	status = "okay";
> +};
> +
> +&xo_board_clk {
> +	clock-frequency = <38400000>;
> +};
> +
> +/* PINCTRL - additions to nodes defined in sc8280xp.dtsi */
Seems redundant.

> +
> +&pmc8280_1_gpios {
> +	edp_bl_en: edp-bl-en-state {
> +		pins = "gpio8";
> +		function = "normal";
> +	};
> +
> +	edp_bl_reg_en: edp-bl-reg-en-state {
> +		pins = "gpio9";
> +		function = "normal";
> +	};
> +
> +	misc_3p3_reg_en: misc-3p3-reg-en-state {
> +		pins = "gpio1";
> +		function = "normal";
> +	};
> +};
> +
> +&pmc8280c_gpios {
> +	edp_bl_pwm: edp-bl-pwm-state {
> +		pins = "gpio8";
> +		function = "func1";
> +	};
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <70 2>, <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
> +
> +	kybd_default: kybd-default-state {
> +		disable {
> +			pins = "gpio102";
> +			function = "gpio";
> +			output-low;
> +		};
> +
> +		int-n {
> +			pins = "gpio104";
> +			function = "gpio";
> +			bias-disable;
> +		};
> +
> +		reset {
> +			pins = "gpio105";
> +			function = "gpio";
> +			bias-disable;
> +		};
> +	};
> +
> +	qup0_i2c4_default: qup0-i2c4-default-state {
> +		pins = "gpio171", "gpio172";
> +		function = "qup4";
> +
> +		bias-disable;
> +		drive-strength = <16>;
> +	};
> +
> +	qup2_i2c5_default: qup2-i2c5-default-state {
> +		pins = "gpio81", "gpio82";
> +		function = "qup21";
> +
> +		bias-disable;
> +		drive-strength = <16>;
> +	};
> +
> +	tpad_default: tpad-default-state {
> +		int-n {
Same comment as in the reference device dt.

Konrad
> +			pins = "gpio182";
> +			function = "gpio";
> +			bias-disable;
> +		};
> +	};
> +
> +	ts0_default: ts0-default-state {
> +		int-n {
> +			pins = "gpio175";
> +			function = "gpio";
> +			bias-pull-up;
> +		};
> +
> +		reset-n {
> +			pins = "gpio99";
> +			function = "gpio";
> +			output-high;
> +			drive-strength = <16>;
> +		};
> +	};
> +};
> 

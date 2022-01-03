Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FF748350E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbiACQtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbiACQtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:49:08 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B46DC061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 08:49:08 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j18so71003746wrd.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 08:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bzpqUqa+DIuXPjZWulm7wpgjk9+mJGJiKEWLtvt+q2Y=;
        b=S6KHOtMjZYLUgSwvqc8/PY+s3mJJgLKPnwJ7YCNLwbWhM1mx/FprUPfh5orOBgTmlr
         7g2koFJSfPTZ/Ms+0jRih9fjbVQog6+HPIfRs67uAxTpZ+yooDuEi0PGNwNL3/1mCkv0
         r7Xj8sFTC4jSbYryaa+5rlRRejQFjE+dv1T0051WiGwvE2p+ttiuz+t3CgT9OiQC+mXL
         5dYgMaGnr69B/g7EcL1SXLEnk7R1zDshaAeP3l4ZqVmzKBV7dYdh9xZnCfSMlwKLvlPd
         QZiUVOqroAN77AfOGGkX+Q/9RJSTC9H66+nPQ0Entx/s45CgoWnY+tZjNL5o+MYuqrR0
         kfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bzpqUqa+DIuXPjZWulm7wpgjk9+mJGJiKEWLtvt+q2Y=;
        b=WHs6u112NNs9UiS+htqME5boa41lmtkye9gCTRn6XVfjtCyi2rRZeYwSP8Cb4EOa25
         pHUDrroGABP96OfdYBEz7PEovzbS4/KtgHgVq9M+7716q/6wgykHe3Eyv8rwNsQBCDxY
         /CEFRzLmPVk/k++kOrhIJvVs+K4mf0xNH092ScZUYSQyoqD9fUWeKhrQnaTZvhgMmps0
         p0J9tCpDhsH5ABUKAF0NRMa4GzoGNDrxsbBAjDth5BnX8fjt3MjDcsvQYOJO/gniU7uY
         jCvyFE7jU4ei+C+zvKdjgH9GKcaki+rUAApHAW/LzdyR93Rgpz9mUwaBLGDv5F5JEsa/
         x+Vw==
X-Gm-Message-State: AOAM531//SRykbkF4hZoBshM3oJv26WxaMJXwN+xmo0b6cYFM8rapBFB
        HVbX5I7AyzuiTIr0fyb4JzIBBg==
X-Google-Smtp-Source: ABdhPJymqgFAV+6uBrD3vJSRLnO69lebKO1mStaBuKHJkVInSeBHaAu9Dgreq4irxLITUagbmFFshA==
X-Received: by 2002:a5d:6c6b:: with SMTP id r11mr36873886wrz.548.1641228546354;
        Mon, 03 Jan 2022 08:49:06 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:7c9d:a967:38e2:5220? ([2001:861:44c0:66c0:7c9d:a967:38e2:5220])
        by smtp.gmail.com with ESMTPSA id u3sm45645327wrs.0.2022.01.03.08.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 08:49:05 -0800 (PST)
Subject: Re: [PATCH v2 1/9] arm64: dts: meson: add common SM1 ac2xx dtsi
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Benoit Masson <yahoo@perenite.com>
References: <20220103163956.6581-1-christianshewitt@gmail.com>
 <20220103163956.6581-2-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <ca79ab12-eb16-ac6d-a950-de59c6253eba@baylibre.com>
Date:   Mon, 3 Jan 2022 17:49:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220103163956.6581-2-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2022 17:39, Christian Hewitt wrote:
> Add a common dtsi for Android STB devices based on the Amlogic S905X3
> (AC213/AC214) and S905D3 (AC201/AC202) reference designs. The dtsi is
> loosely based on the existing SEI610 device-tree.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  .../boot/dts/amlogic/meson-sm1-ac2xx.dtsi     | 300 ++++++++++++++++++
>  1 file changed, 300 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi
> new file mode 100644
> index 000000000000..46a34731f7e2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi
> @@ -0,0 +1,300 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 BayLibre SAS. All rights reserved.
> + * Copyright (c) 2020 Christian Hewitt <christianshewitt@gmail.com>
> + *
> + * AC200/AC202 = S905D3
> + * AC213/AC214 = S905X3
> + *
> + */
> +
> +#include "meson-sm1.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/gpio/meson-g12a-gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	aliases {
> +		serial0 = &uart_AO;
> +		ethernet0 = &ethmac;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	emmc_pwrseq: emmc-pwrseq {
> +		compatible = "mmc-pwrseq-emmc";
> +		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	cvbs-connector {
> +		compatible = "composite-video-connector";
> +
> +		port {
> +			cvbs_connector_in: endpoint {
> +				remote-endpoint = <&cvbs_vdac_out>;
> +			};
> +		};
> +	};
> +
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&hdmi_tx_tmds_out>;
> +			};
> +		};
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x40000000>;
> +	};
> +
> +	ao_5v: regulator-ao_5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "AO_5V";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&dc_in>;
> +		regulator-always-on;
> +	};
> +
> +	dc_in: regulator-dc_in {
> +		compatible = "regulator-fixed";
> +		regulator-name = "DC_IN";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	emmc_1v8: regulator-emmc_1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "EMMC_1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vddao_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	vddao_3v3: regulator-vddao_3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDAO_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&dc_in>;
> +		regulator-always-on;
> +	};
> +
> +	vddcpu: regulator-vddcpu {
> +		compatible = "pwm-regulator";
> +
> +		regulator-name = "VDDCPU";
> +		regulator-min-microvolt = <690000>;
> +		regulator-max-microvolt = <1050000>;
> +
> +		vin-supply = <&dc_in>;
> +
> +		pwms = <&pwm_AO_cd 1 1500 0>;
> +		pwm-dutycycle-range = <100 0>;
> +
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	vddio_ao1v8: regulator-vddio_ao1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDIO_AO1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vddao_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
> +		clocks = <&wifi32k>;
> +		clock-names = "ext_clock";
> +	};
> +
> +	wifi32k: wifi32k {
> +		compatible = "pwm-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
> +	};
> +};
> +
> +&cec_AO {
> +	pinctrl-0 = <&cec_ao_a_h_pins>;
> +	pinctrl-names = "default";
> +	status = "disabled";
> +	hdmi-phandle = <&hdmi_tx>;
> +};
> +
> +&cecb_AO {
> +	pinctrl-0 = <&cec_ao_b_h_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +	hdmi-phandle = <&hdmi_tx>;
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vddcpu>;
> +	operating-points-v2 = <&cpu_opp_table>;
> +	clocks = <&clkc CLKID_CPU_CLK>;
> +	clock-latency = <50000>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&vddcpu>;
> +	operating-points-v2 = <&cpu_opp_table>;
> +	clocks = <&clkc CLKID_CPU1_CLK>;
> +	clock-latency = <50000>;
> +};
> +
> +&cpu2 {
> +	cpu-supply = <&vddcpu>;
> +	operating-points-v2 = <&cpu_opp_table>;
> +	clocks = <&clkc CLKID_CPU2_CLK>;
> +	clock-latency = <50000>;
> +};
> +
> +&cpu3 {
> +	cpu-supply = <&vddcpu>;
> +	operating-points-v2 = <&cpu_opp_table>;
> +	clocks = <&clkc CLKID_CPU3_CLK>;
> +	clock-latency = <50000>;
> +};
> +
> +&cvbs_vdac_port {
> +	cvbs_vdac_out: endpoint {
> +		remote-endpoint = <&cvbs_connector_in>;
> +	};
> +};
> +
> +&hdmi_tx {
> +	status = "okay";
> +	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&hdmi_tx_tmds_port {
> +	hdmi_tx_tmds_out: endpoint {
> +		remote-endpoint = <&hdmi_connector_in>;
> +	};
> +};
> +
> +&ir {
> +	status = "okay";
> +	pinctrl-0 = <&remote_input_ao_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&pwm_AO_ab {
> +	status = "okay";
> +	pinctrl-0 = <&pwm_ao_a_pins>;
> +	pinctrl-names = "default";
> +	clocks = <&xtal>;
> +	clock-names = "clkin0";
> +};
> +
> +&pwm_AO_cd {
> +	pinctrl-0 = <&pwm_ao_d_e_pins>;
> +	pinctrl-names = "default";
> +	clocks = <&xtal>;
> +	clock-names = "clkin1";
> +	status = "okay";
> +};
> +
> +&pwm_ef {
> +	status = "okay";
> +	pinctrl-0 = <&pwm_e_pins>;
> +	pinctrl-names = "default";
> +	clocks = <&xtal>;
> +	clock-names = "clkin0";
> +};
> +
> +&saradc {
> +	status = "okay";
> +	vref-supply = <&vddio_ao1v8>;
> +};
> +
> +/* SDIO */
> +&sd_emmc_a {
> +	status = "okay";
> +	pinctrl-0 = <&sdio_pins>;
> +	pinctrl-1 = <&sdio_clk_gate_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	sd-uhs-sdr104;
> +	max-frequency = <200000000>;
> +
> +	non-removable;
> +	disable-wp;
> +
> +	/* WiFi firmware requires power to be kept while in suspend */
> +	keep-power-in-suspend;
> +
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +
> +	vmmc-supply = <&vddao_3v3>;
> +	vqmmc-supply = <&vddio_ao1v8>;
> +};
> +
> +/* SD Card */
> +&sd_emmc_b {
> +	status = "okay";
> +	pinctrl-0 = <&sdcard_c_pins>;
> +	pinctrl-1 = <&sdcard_clk_gate_c_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	/* CRC errors are observed at 50MHz */
> +	max-frequency = <35000000>;
> +	disable-wp;
> +
> +	cd-gpios = <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
> +	vmmc-supply = <&vddao_3v3>;
> +	vqmmc-supply = <&vddao_3v3>;
> +};
> +
> +/* eMMC */
> +&sd_emmc_c {
> +	status = "okay";
> +	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, <&emmc_ds_pins>;
> +	pinctrl-1 = <&emmc_clk_gate_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	max-frequency = <200000000>;
> +	non-removable;
> +	disable-wp;
> +
> +	mmc-pwrseq = <&emmc_pwrseq>;
> +	vmmc-supply = <&vddao_3v3>;
> +	vqmmc-supply = <&emmc_1v8>;
> +};
> +
> +&uart_AO {
> +	status = "okay";
> +	pinctrl-0 = <&uart_ao_a_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&usb {
> +	status = "okay";
> +	dr_mode = "otg";
> +};
> 


Missing:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> # X96-Air with Gbit/s PHY

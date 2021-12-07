Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3F346BC5B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbhLGNYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:24:36 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36610 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbhLGNYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:24:35 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B7DKxeN025406;
        Tue, 7 Dec 2021 07:20:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638883259;
        bh=6qsKReKxmwL8kEfik58jBcWTINDbHw+kVxL23H32RWY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=u7qFqi6n1UivVam/9Lef9MwtyoUmOn21Sq0Wx42tWjBoeciZcu7hU7YXzoi3zoyun
         DR28/8GFC2G1nkCZZOWAVURDTVycAVugYDMEjgeEZfqlkZnQ9j/uX4afR2+exqZPWR
         aj7Xz+L+Ry+Vx/0PELIb7fkp4S+zZXk3fkqeyDzw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B7DKwMq028956
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Dec 2021 07:20:59 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Dec 2021 07:20:58 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Dec 2021 07:20:58 -0600
Received: from [10.250.232.32] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B7DKrJ3087997;
        Tue, 7 Dec 2021 07:20:54 -0600
Subject: Re: [PATCH v5 4/6] arm64: dts: ti: k3-j721e-common-proc-board: Add
 support for mcu and main mcan nodes
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211122134159.29936-1-a-govindraju@ti.com>
 <20211122134159.29936-5-a-govindraju@ti.com>
From:   Apurva Nandan <a-nandan@ti.com>
Message-ID: <36388bfb-75b5-07cd-4d39-9f6d683e582e@ti.com>
Date:   Tue, 7 Dec 2021 18:50:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122134159.29936-5-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/11/21 7:11 pm, Aswath Govindraju wrote:
> From: Faiz Abbas <faiz_abbas@ti.com>
>
> Add four MCAN nodes present on the common processor board and set a
> maximum data rate of 5 Mbps. Disable all other nodes as they
> are not brought out on the common processor board.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Reviewed-by: Apurva Nandan <a-nandan@ti.com>

> ---
>   .../dts/ti/k3-j721e-common-proc-board.dts     | 155 ++++++++++++++++++
>   1 file changed, 155 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> index dc2bc67f9f48..2d7596911b27 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> @@ -112,6 +112,42 @@
>   			      "cpb-codec-scki",
>   			      "cpb-codec-scki-48000", "cpb-codec-scki-44100";
>   	};
> +
> +	transceiver1: can-phy0 {
> +		compatible = "ti,tcan1043";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mcu_mcan0_gpio_pins_default>;
> +		standby-gpios = <&wkup_gpio0 54 GPIO_ACTIVE_LOW>;
> +		enable-gpios = <&wkup_gpio0 0 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	transceiver2: can-phy1 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mcu_mcan1_gpio_pins_default>;
> +		standby-gpios = <&wkup_gpio0 2 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	transceiver3: can-phy2 {
> +		compatible = "ti,tcan1043";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		standby-gpios = <&exp2 7 GPIO_ACTIVE_LOW>;
> +		enable-gpios = <&exp2 6 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	transceiver4: can-phy3 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&main_mcan2_gpio_pins_default>;
> +		standby-gpios = <&main_gpio0 127 GPIO_ACTIVE_HIGH>;
> +	};
>   };
>   
>   &main_pmx0 {
> @@ -207,6 +243,26 @@
>   			J721E_IOPAD(0x1a4, PIN_OUTPUT, 3) /* (W26) RGMII6_RXC.AUDIO_EXT_REFCLK2 */
>   		>;
>   	};
> +
> +	main_mcan0_pins_default: main-mcan0-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x208, PIN_INPUT, 0) /* (W5) MCAN0_RX */
> +			J721E_IOPAD(0x20c, PIN_OUTPUT, 0) /* (W6) MCAN0_TX */
> +		>;
> +	};
> +
> +	main_mcan2_pins_default: main-mcan2-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x01f0, PIN_INPUT, 3) /* (AC2) MCAN2_RX.GPIO0_123 */
> +			J721E_IOPAD(0x01f4, PIN_OUTPUT, 3) /* (AB1) MCAN2_TX.GPIO0_124 */
> +		>;
> +	};
> +
> +	main_mcan2_gpio_pins_default: main-mcan2-gpio-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x200, PIN_INPUT, 7) /* (AC4) UART1_CTSn.GPIO0_127 */
> +		>;
> +	};
>   };
>   
>   &wkup_pmx0 {
> @@ -252,6 +308,33 @@
>   			J721E_WKUP_IOPAD(0x0088, PIN_INPUT, 0) /* MCU_MDIO0_MDIO */
>   		>;
>   	};
> +
> +	mcu_mcan0_pins_default: mcu-mcan0-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_WKUP_IOPAD(0xac, PIN_INPUT, 0) /* (C29) MCU_MCAN0_RX */
> +			J721E_WKUP_IOPAD(0xa8, PIN_OUTPUT, 0) /* (D29) MCU_MCAN0_TX */
> +		>;
> +	};
> +
> +	mcu_mcan0_gpio_pins_default: mcu-mcan0-gpio-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_WKUP_IOPAD(0xb0, PIN_INPUT, 7) /* (F26) WKUP_GPIO0_0 */
> +			J721E_WKUP_IOPAD(0x98, PIN_INPUT, 7) /* (E28) MCU_SPI0_D1.WKUP_GPIO0_54 */
> +		>;
> +	};
> +
> +	mcu_mcan1_pins_default: mcu-mcan1-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_WKUP_IOPAD(0xc4, PIN_INPUT, 0) /* (G24) WKUP_GPIO0_5.MCU_MCAN1_RX */
> +			J721E_WKUP_IOPAD(0xc0, PIN_OUTPUT, 0) /* (G25) WKUP_GPIO0_4.MCU_MCAN1_TX */
> +		>;
> +	};
> +
> +	mcu_mcan1_gpio_pins_default: mcu-mcan1-gpio-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_WKUP_IOPAD(0xb8, PIN_INPUT, 7) /* (F28) WKUP_GPIO0_2 */
> +		>;
> +	};
>   };
>   
>   &wkup_uart0 {
> @@ -773,3 +856,75 @@
>   &icssg1_mdio {
>   	status = "disabled";
>   };
> +
> +&mcu_mcan0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_mcan0_pins_default>;
> +	phys = <&transceiver1>;
> +};
> +
> +&mcu_mcan1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_mcan1_pins_default>;
> +	phys = <&transceiver2>;
> +};
> +
> +&main_mcan0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan0_pins_default>;
> +	phys = <&transceiver3>;
> +};
> +
> +&main_mcan1 {
> +	status = "disabled";
> +};
> +
> +&main_mcan2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan2_pins_default>;
> +	phys = <&transceiver4>;
> +};
> +
> +&main_mcan3 {
> +	status = "disabled";
> +};
> +
> +&main_mcan4 {
> +	status = "disabled";
> +};
> +
> +&main_mcan5 {
> +	status = "disabled";
> +};
> +
> +&main_mcan6 {
> +	status = "disabled";
> +};
> +
> +&main_mcan7 {
> +	status = "disabled";
> +};
> +
> +&main_mcan8 {
> +	status = "disabled";
> +};
> +
> +&main_mcan9 {
> +	status = "disabled";
> +};
> +
> +&main_mcan10 {
> +	status = "disabled";
> +};
> +
> +&main_mcan11 {
> +	status = "disabled";
> +};
> +
> +&main_mcan12 {
> +	status = "disabled";
> +};
> +
> +&main_mcan13 {
> +	status = "disabled";
> +};

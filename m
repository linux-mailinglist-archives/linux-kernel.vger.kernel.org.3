Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938B05660BE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 03:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbiGEBpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 21:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiGEBpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 21:45:22 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1D32AD4;
        Mon,  4 Jul 2022 18:45:21 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DBEB75C009B;
        Mon,  4 Jul 2022 21:45:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 04 Jul 2022 21:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656985520; x=
        1657071920; bh=EwvMtdsj5J2JQJRYqCZ/EnCsPUJsvONpKx+JMLzB8/c=; b=W
        J5IXaOgvHbJH+AO46rMFwES+o0yZK7/eYEs7PfTCXSpg6IR17vHd8JPo/g/zPazP
        R+CWKxh9osiDDik9KxcdQjqe2GJtjl3qvPOOHpsoOBo3Vg6fRC+cbsx4XvUEaQcy
        qOIM5u+V5b7cKo22TalxcafK3zdshIBcSE3g9JrRC9PUaE+IhSn5eTJ2jOmKl8k2
        zR3ezJvtOdOotGkVp7sshvTYAVSIvIksUMcb78KcI+icIarK8nyXZgCgZAp8/0D2
        jarK+1YWlWkJpn6qAkKVDHsJkm2se6yVxfeBaw6wSZUSMSfwrmj8fOJ9aejZX+Ti
        resaeM7yFYhCDcG0Om5NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656985520; x=
        1657071920; bh=EwvMtdsj5J2JQJRYqCZ/EnCsPUJsvONpKx+JMLzB8/c=; b=B
        UZOo+y0zASRf3WVRURdZfauKvh48m+PT3b2oQguq1+pOkoOVck+dnNvDKf+4LJ43
        cVdhiTUBGZbV8AlULmJNgiYK+kN+qzfKCWZRcRP6cypirQzco9RCTJ4mzOeUYt9x
        y3MgZTRQgBIG5YU0djqevR90qIJXx6AmY/3Om9XstS07dw5V/j+XqkhtFAiVMa3F
        41rsU07S4dsW6CJXH4Y8WMty3xExBwK0HdkLjqbQh87S/FgsvZ8rgUigv82PiNeJ
        yGP0XLlOlQY1LShTcmcy4YU7aZHxRrNKMfart93cO2aO1Xb/zaIlhzh5kVgnXdcS
        QSkULnYyHF7taHC8S++hA==
X-ME-Sender: <xms:sJfDYtTTn4fp1sM2yWoUnLbI8iXuM-DKzhN9UT6r8YHKS-AwyKX04w>
    <xme:sJfDYmzFw75PNcAhtETdO_j67PmY0OQVLi58eTdtsI4tipDRyHMc5hAggX41oe1lt
    t1EBlhpQMG0W76TTA>
X-ME-Received: <xmr:sJfDYi1vqrvTXGMCDfR9ODUb8GKHE3Z8SimvUIkui7Qk87QeC9cxvo2ox_7g0ZCf2nDHv0pV7nitbJIpIv72RQPe8OBnQFW_uA2cZTW91IRhyLTk1qbKco-YeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeitddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:sJfDYlAw089Um2f4ZAEznuoBJdQJjjWfsuz69sbyDowPgZsQNnf1fA>
    <xmx:sJfDYmg2V2DeTunUbVGNJTAOzuxGlE7WVTNNVIwYfz-C72h9iSWZlw>
    <xmx:sJfDYpo2yjinYICi2v39uZMnMuiIJ31Ocb_nb-Kgs36NdNeQiMRBhA>
    <xmx:sJfDYvV8N3OTuakdk0-LgIV-IFzpBbh26ZCvSFB-fXpA2KC6tj8WLw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Jul 2022 21:45:19 -0400 (EDT)
Subject: Re: [PATCH v12 6/7] arm64: dts: allwinner: h616: Add OrangePi Zero 2
 board support
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220701112453.2310722-1-andre.przywara@arm.com>
 <20220701112453.2310722-7-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <536557a1-15eb-e408-7cf2-7dfda0aed3c5@sholland.org>
Date:   Mon, 4 Jul 2022 20:45:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220701112453.2310722-7-andre.przywara@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On 7/1/22 6:24 AM, Andre Przywara wrote:
> The OrangePi Zero 2 is a development board with the new H616 SoC. It
> comes with the following features:
>   - Four ARM Cortex-A53 cores, Mali-G31 MP2 GPU
>   - 512MiB/1GiB DDR3 DRAM
>   - AXP305 PMIC
>   - Raspberry-Pi-1 compatible GPIO header
>   - extra 13 pin expansion header, exposing pins for 2x USB 2.0 ports
>   - 1 USB 2.0 host port
>   - 1 USB 2.0 type C port (power supply + OTG)
>   - MicroSD slot
>   - on-board 2MiB bootable SPI NOR flash
>   - 1Gbps Ethernet port (via RTL8211F PHY)
>   - micro-HDMI port
>   - (yet) unsupported Allwinner WiFi/BT chip
> 
> Add the devicetree file describing the currently supported features.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

One question below.

> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../allwinner/sun50i-h616-orangepi-zero2.dts  | 213 ++++++++++++++++++
>  2 files changed, 214 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> index 8fa5c060a4fef..df2214e6d946a 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -38,3 +38,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> new file mode 100644
> index 0000000000000..cff199536d3bc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> @@ -0,0 +1,213 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2020 Arm Ltd.
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model = "OrangePi Zero2";
> +	compatible = "xunlong,orangepi-zero2", "allwinner,sun50i-h616";
> +
> +	aliases {
> +		ethernet0 = &emac0;
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			function = LED_FUNCTION_POWER;
> +			color = <LED_COLOR_ID_RED>;
> +			gpios = <&pio 2 12 GPIO_ACTIVE_HIGH>; /* PC12 */
> +			default-state = "on";
> +		};
> +
> +		led-1 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&pio 2 13 GPIO_ACTIVE_HIGH>; /* PC13 */
> +		};
> +	};
> +
> +	reg_vcc5v: vcc5v {
> +		/* board wide 5V supply directly from the USB-C socket */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +};
> +
> +&emac0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&ext_rgmii_pins>;
> +	phy-mode = "rgmii";
> +	phy-handle = <&ext_rgmii_phy>;
> +	phy-supply = <&reg_dcdce>;
> +	allwinner,rx-delay-ps = <3100>;
> +	allwinner,tx-delay-ps = <700>;
> +	status = "okay";
> +};
> +
> +&mdio0 {
> +	ext_rgmii_phy: ethernet-phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <1>;
> +	};
> +};
> +
> +&mmc0 {
> +	vmmc-supply = <&reg_dcdce>;
> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&r_rsb {
> +	status = "okay";
> +
> +	axp305: pmic@745 {
> +		compatible = "x-powers,axp305", "x-powers,axp805",
> +			     "x-powers,axp806";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		reg = <0x745>;
> +
> +		x-powers,self-working-mode;
> +		vina-supply = <&reg_vcc5v>;
> +		vinb-supply = <&reg_vcc5v>;
> +		vinc-supply = <&reg_vcc5v>;
> +		vind-supply = <&reg_vcc5v>;
> +		vine-supply = <&reg_vcc5v>;
> +		aldoin-supply = <&reg_vcc5v>;
> +		bldoin-supply = <&reg_vcc5v>;
> +		cldoin-supply = <&reg_vcc5v>;
> +
> +		regulators {
> +			reg_aldo1: aldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc-sys";
> +			};
> +
> +			reg_aldo2: aldo2 {	/* 3.3V on headers */
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc3v3-ext";
> +			};
> +
> +			reg_aldo3: aldo3 {	/* 3.3V on headers */
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc3v3-ext2";
> +			};
> +
> +			reg_bldo1: bldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc1v8";
> +			};
> +
> +			bldo2 {
> +				/* unused */
> +			};
> +
> +			bldo3 {
> +				/* unused */
> +			};
> +
> +			bldo4 {
> +				/* unused */
> +			};
> +
> +			cldo1 {
> +				/* reserved */
> +			};
> +
> +			cldo2 {
> +				/* unused */
> +			};
> +
> +			cldo3 {
> +				/* unused */
> +			};
> +
> +			reg_dcdca: dcdca {
> +				regulator-always-on;
> +				regulator-min-microvolt = <810000>;
> +				regulator-max-microvolt = <1080000>;
> +				regulator-name = "vdd-cpu";
> +			};
> +
> +			reg_dcdcc: dcdcc {
> +				regulator-always-on;
> +				regulator-min-microvolt = <810000>;
> +				regulator-max-microvolt = <1080000>;

Where does the max voltage here come from? The H616 datasheet lists the limit
for both VDD_GPU and VDD_SYS as 0.99 V. (This applies to both boards.)

Regards,
Samuel

> +				regulator-name = "vdd-gpu-sys";
> +			};
> +
> +			reg_dcdcd: dcdcd {
> +				regulator-always-on;
> +				regulator-min-microvolt = <1500000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-name = "vdd-dram";
> +			};
> +
> +			reg_dcdce: dcdce {
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc-eth-mmc";
> +			};
> +
> +			sw {
> +				/* unused */
> +			};
> +		};
> +	};
> +};
> +
> +&pio {
> +	vcc-pc-supply = <&reg_aldo1>;
> +	vcc-pf-supply = <&reg_aldo1>;
> +	vcc-pg-supply = <&reg_bldo1>;
> +	vcc-ph-supply = <&reg_aldo1>;
> +	vcc-pi-supply = <&reg_aldo1>;
> +};
> +
> +&spi0  {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi0_pins>, <&spi0_cs0_pin>;
> +
> +	flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <40000000>;
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_ph_pins>;
> +	status = "okay";
> +};
> 


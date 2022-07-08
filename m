Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5AA56B5F9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbiGHJt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbiGHJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:49:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBB6F81498;
        Fri,  8 Jul 2022 02:49:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F39AF106F;
        Fri,  8 Jul 2022 02:49:53 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57B1A3F66F;
        Fri,  8 Jul 2022 02:49:52 -0700 (PDT)
Date:   Fri, 8 Jul 2022 10:49:49 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 6/7] arm64: dts: allwinner: h616: Add OrangePi Zero
 2 board support
Message-ID: <20220708104949.7e0ad777@donnerap.cambridge.arm.com>
In-Reply-To: <536557a1-15eb-e408-7cf2-7dfda0aed3c5@sholland.org>
References: <20220701112453.2310722-1-andre.przywara@arm.com>
 <20220701112453.2310722-7-andre.przywara@arm.com>
 <536557a1-15eb-e408-7cf2-7dfda0aed3c5@sholland.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2022 20:45:18 -0500
Samuel Holland <samuel@sholland.org> wrote:

Hi Samuel,

> On 7/1/22 6:24 AM, Andre Przywara wrote:
> > The OrangePi Zero 2 is a development board with the new H616 SoC. It
> > comes with the following features:
> >   - Four ARM Cortex-A53 cores, Mali-G31 MP2 GPU
> >   - 512MiB/1GiB DDR3 DRAM
> >   - AXP305 PMIC
> >   - Raspberry-Pi-1 compatible GPIO header
> >   - extra 13 pin expansion header, exposing pins for 2x USB 2.0 ports
> >   - 1 USB 2.0 host port
> >   - 1 USB 2.0 type C port (power supply + OTG)
> >   - MicroSD slot
> >   - on-board 2MiB bootable SPI NOR flash
> >   - 1Gbps Ethernet port (via RTL8211F PHY)
> >   - micro-HDMI port
> >   - (yet) unsupported Allwinner WiFi/BT chip
> > 
> > Add the devicetree file describing the currently supported features.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>  
> 
> One question below.
> 
> > ---
> >  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
> >  .../allwinner/sun50i-h616-orangepi-zero2.dts  | 213 ++++++++++++++++++
> >  2 files changed, 214 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> > index 8fa5c060a4fef..df2214e6d946a 100644
> > --- a/arch/arm64/boot/dts/allwinner/Makefile
> > +++ b/arch/arm64/boot/dts/allwinner/Makefile
> > @@ -38,3 +38,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
> > +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> > new file mode 100644
> > index 0000000000000..cff199536d3bc
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> > @@ -0,0 +1,213 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > +/*
> > + * Copyright (C) 2020 Arm Ltd.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "sun50i-h616.dtsi"
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/leds/common.h>
> > +
> > +/ {
> > +	model = "OrangePi Zero2";
> > +	compatible = "xunlong,orangepi-zero2", "allwinner,sun50i-h616";
> > +
> > +	aliases {
> > +		ethernet0 = &emac0;
> > +		serial0 = &uart0;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = "serial0:115200n8";
> > +	};
> > +
> > +	leds {
> > +		compatible = "gpio-leds";
> > +
> > +		led-0 {
> > +			function = LED_FUNCTION_POWER;
> > +			color = <LED_COLOR_ID_RED>;
> > +			gpios = <&pio 2 12 GPIO_ACTIVE_HIGH>; /* PC12 */
> > +			default-state = "on";
> > +		};
> > +
> > +		led-1 {
> > +			function = LED_FUNCTION_STATUS;
> > +			color = <LED_COLOR_ID_GREEN>;
> > +			gpios = <&pio 2 13 GPIO_ACTIVE_HIGH>; /* PC13 */
> > +		};
> > +	};
> > +
> > +	reg_vcc5v: vcc5v {
> > +		/* board wide 5V supply directly from the USB-C socket */
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc-5v";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		regulator-always-on;
> > +	};
> > +};
> > +
> > +&emac0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&ext_rgmii_pins>;
> > +	phy-mode = "rgmii";
> > +	phy-handle = <&ext_rgmii_phy>;
> > +	phy-supply = <&reg_dcdce>;
> > +	allwinner,rx-delay-ps = <3100>;
> > +	allwinner,tx-delay-ps = <700>;
> > +	status = "okay";
> > +};
> > +
> > +&mdio0 {
> > +	ext_rgmii_phy: ethernet-phy@1 {
> > +		compatible = "ethernet-phy-ieee802.3-c22";
> > +		reg = <1>;
> > +	};
> > +};
> > +
> > +&mmc0 {
> > +	vmmc-supply = <&reg_dcdce>;
> > +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> > +	bus-width = <4>;
> > +	status = "okay";
> > +};
> > +
> > +&r_rsb {
> > +	status = "okay";
> > +
> > +	axp305: pmic@745 {
> > +		compatible = "x-powers,axp305", "x-powers,axp805",
> > +			     "x-powers,axp806";
> > +		interrupt-controller;
> > +		#interrupt-cells = <1>;
> > +		reg = <0x745>;
> > +
> > +		x-powers,self-working-mode;
> > +		vina-supply = <&reg_vcc5v>;
> > +		vinb-supply = <&reg_vcc5v>;
> > +		vinc-supply = <&reg_vcc5v>;
> > +		vind-supply = <&reg_vcc5v>;
> > +		vine-supply = <&reg_vcc5v>;
> > +		aldoin-supply = <&reg_vcc5v>;
> > +		bldoin-supply = <&reg_vcc5v>;
> > +		cldoin-supply = <&reg_vcc5v>;
> > +
> > +		regulators {
> > +			reg_aldo1: aldo1 {
> > +				regulator-always-on;
> > +				regulator-min-microvolt = <3300000>;
> > +				regulator-max-microvolt = <3300000>;
> > +				regulator-name = "vcc-sys";
> > +			};
> > +
> > +			reg_aldo2: aldo2 {	/* 3.3V on headers */
> > +				regulator-always-on;
> > +				regulator-min-microvolt = <3300000>;
> > +				regulator-max-microvolt = <3300000>;
> > +				regulator-name = "vcc3v3-ext";
> > +			};
> > +
> > +			reg_aldo3: aldo3 {	/* 3.3V on headers */
> > +				regulator-always-on;
> > +				regulator-min-microvolt = <3300000>;
> > +				regulator-max-microvolt = <3300000>;
> > +				regulator-name = "vcc3v3-ext2";
> > +			};
> > +
> > +			reg_bldo1: bldo1 {
> > +				regulator-always-on;
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <1800000>;
> > +				regulator-name = "vcc1v8";
> > +			};
> > +
> > +			bldo2 {
> > +				/* unused */
> > +			};
> > +
> > +			bldo3 {
> > +				/* unused */
> > +			};
> > +
> > +			bldo4 {
> > +				/* unused */
> > +			};
> > +
> > +			cldo1 {
> > +				/* reserved */
> > +			};
> > +
> > +			cldo2 {
> > +				/* unused */
> > +			};
> > +
> > +			cldo3 {
> > +				/* unused */
> > +			};
> > +
> > +			reg_dcdca: dcdca {
> > +				regulator-always-on;
> > +				regulator-min-microvolt = <810000>;
> > +				regulator-max-microvolt = <1080000>;
> > +				regulator-name = "vdd-cpu";
> > +			};
> > +
> > +			reg_dcdcc: dcdcc {
> > +				regulator-always-on;
> > +				regulator-min-microvolt = <810000>;
> > +				regulator-max-microvolt = <1080000>;  
> 
> Where does the max voltage here come from? The H616 datasheet lists the limit
> for both VDD_GPU and VDD_SYS as 0.99 V. (This applies to both boards.)

Copied from somewhere, not entirely sure where from. The vendor DT
lists the full AXP range, with a surely unhealthy upper limit of 1.52V.
My copy of the datasheet lists max 1.1V for the CPU and 0.99V for
the GPU (recommended operating conditions), so I am using those values
now.

Thanks for spotting.

Cheers,
Andre


> 
> Regards,
> Samuel
> 
> > +				regulator-name = "vdd-gpu-sys";
> > +			};
> > +
> > +			reg_dcdcd: dcdcd {
> > +				regulator-always-on;
> > +				regulator-min-microvolt = <1500000>;
> > +				regulator-max-microvolt = <1500000>;
> > +				regulator-name = "vdd-dram";
> > +			};
> > +
> > +			reg_dcdce: dcdce {
> > +				regulator-always-on;
> > +				regulator-min-microvolt = <3300000>;
> > +				regulator-max-microvolt = <3300000>;
> > +				regulator-name = "vcc-eth-mmc";
> > +			};
> > +
> > +			sw {
> > +				/* unused */
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&pio {
> > +	vcc-pc-supply = <&reg_aldo1>;
> > +	vcc-pf-supply = <&reg_aldo1>;
> > +	vcc-pg-supply = <&reg_bldo1>;
> > +	vcc-ph-supply = <&reg_aldo1>;
> > +	vcc-pi-supply = <&reg_aldo1>;
> > +};
> > +
> > +&spi0  {
> > +	status = "okay";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&spi0_pins>, <&spi0_cs0_pin>;
> > +
> > +	flash@0 {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		compatible = "jedec,spi-nor";
> > +		reg = <0>;
> > +		spi-max-frequency = <40000000>;
> > +	};
> > +};
> > +
> > +&uart0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&uart0_ph_pins>;
> > +	status = "okay";
> > +};
> >   
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B484C484998
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbiADU7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:59:08 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:40711 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiADU7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:59:07 -0500
Received: by mail-oi1-f172.google.com with SMTP id t204so55266384oie.7;
        Tue, 04 Jan 2022 12:59:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Gu3ZoKZ3C2LziR8MdZo6Iy0gG1rgv/s7WItH8EeFaY=;
        b=hzWZl402aSshxN4Nr98Ho2bDR1tw+935yt1/42C8UXVnjh2sk+G48QkQnbQFnWunzP
         BxKhcThCkqBfBTl3qZ0U9ccAhs/XNpNU486eBB1+5V/tX1YxknsXQM7EiVZ8UzgrNE/C
         mcnQP8lxEMuCym2EGRTfLV9DDn1IrbHVIauORC6c/hgIwXg7zEV5FsLYAAEJvSzslGCU
         Mr4SdxJAWGzkP4GdxBZ7iN4XT4Wk5yQoJY/qxODlMWY5Hji49SUUPIvg+JYXLr/4evLa
         Mc26nPrA0p31hhrDHavGgyDMSpP789gNxFryU3h1IyiWRJH1ODhRlETftRS7zycJdXiO
         h8vw==
X-Gm-Message-State: AOAM533i5izgwz49MdaSeUgFctlfehF6eGHXeNMUbEDOtfBzqp3a1oWC
        Fkbnk3b3iXD+HVZ9k0igkg==
X-Google-Smtp-Source: ABdhPJx7w7VRwTLbiWv88o0FJHiU5iN6EERHzl2VdfYoE8wCbl8F024iiZf/ohlTfOHurOyTql8sFA==
X-Received: by 2002:a05:6808:287:: with SMTP id z7mr144498oic.132.1641329946625;
        Tue, 04 Jan 2022 12:59:06 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u14sm8309873ote.62.2022.01.04.12.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 12:59:06 -0800 (PST)
Received: (nullmailer pid 1415713 invoked by uid 1000);
        Tue, 04 Jan 2022 20:59:05 -0000
Date:   Tue, 4 Jan 2022 14:59:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     conleylee@foxmail.com
Cc:     mripard@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sun7i-a20-marsboard.dts: add marsboard-a20 support
Message-ID: <YdS1GVkRopRSoD5S@robh.at.kernel.org>
References: <tencent_DC7B4D416B69D6D6789356010B5B9647C606@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_DC7B4D416B69D6D6789356010B5B9647C606@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 12:43:41AM +0800, conleylee@foxmail.com wrote:
> From: Conley Lee <conleylee@foxmail.com>
> 
> ARM dts: sun7i: Add Marsboard A20 board
> 
> This patch add support for Marsboard A20 board.
> 
> The Marsboard A20 is a A20 based SBC with 1G RAM, 8G Flash, micro SD
> card slot , SATA socketm 10/100 ethernet, HDMI port, 4 USB2.0 ports, 2
> USB2.0 OTG, USB WIFI(RTL8188EU) with antenna.
> 
> Signed-off-by: Conley Lee <conleylee@foxmail.com>
> ---
>  .../devicetree/bindings/arm/sunxi.yaml        |   5 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/sun7i-a20-marsboard.dts     | 220 ++++++++++++++++++

Bindings and dts files should be separate patches.

>  3 files changed, 226 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-marsboard.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
> index 889128acf49a..4bd93ae26bd1 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -444,6 +444,11 @@ properties:
>            - const: haoyu,a10-marsboard
>            - const: allwinner,sun4i-a10
>  
> +      - description: HAOYU Electronics Marsboard A20
> +        items:
> +          - const: haoyu,a20-marsboard
> +          - const: allwinner,sun7i-a20
> +
>        - description: MapleBoard MP130
>          items:
>            - const: mapleboard,mp130
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 0de64f237cd8..4628a2617313 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1219,6 +1219,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>  	sun7i-a20-icnova-swac.dtb \
>  	sun7i-a20-lamobo-r1.dtb \
>  	sun7i-a20-linutronix-testbox-v2.dtb \
> +	sun7i-a20-marsboard.dtb \
>  	sun7i-a20-m3.dtb \
>  	sun7i-a20-mk808c.dtb \
>  	sun7i-a20-olimex-som-evb.dtb \
> diff --git a/arch/arm/boot/dts/sun7i-a20-marsboard.dts b/arch/arm/boot/dts/sun7i-a20-marsboard.dts
> new file mode 100644
> index 000000000000..159e69e148e7
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-marsboard.dts
> @@ -0,0 +1,220 @@
> +/*
> + * Copyright 2021 Conley Lee
> + * Conley Lee <conleylee@foxmail.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.

Use SPDX tag instead.

> + */
> +
> +/dts-v1/;
> +#include "sun7i-a20.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	model = "HAOYU Electronics Marsboard A20";
> +	compatible = "haoyu,a20-marsboard", "allwinner,sun7i-a20";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +};
> +
> +&ahci {
> +	target-supply = <&reg_ahci_5v>;
> +	status = "okay";
> +};
> +
> +&codec {
> +	status = "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&reg_dcdc2>;
> +};
> +
> +&de {
> +	status = "okay";
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&gmac_mii_pins {
> +	pins = "PA0", "PA1", "PA2",
> +	"PA3", "PA4", "PA5", "PA6",
> +	"PA7", "PA8", "PA9", "PA10",
> +	"PA11", "PA12", "PA13", "PA14",
> +	"PA15", "PA16", "PA17";
> +};
> +
> +&gmac {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac_mii_pins>;
> +	phy-handle = <&phy0>;
> +	phy-mode = "mii";
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	status = "okay";
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	axp209: pmic@34 {
> +		reg = <0x34>;
> +		interrupt-parent = <&nmi_intc>;
> +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&mmc0 {
> +	vmmc-supply = <&reg_vcc3v3>;
> +	bus-width = <4>;
> +	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
> +	status = "okay";
> +};
> +
> +&gmac_mdio {
> +	phy0: ethernet-phy@0 {
> +		reg = <0>;
> +	};
> +};
> +
> +&ohci0 {
> +	status = "okay";
> +};
> +
> +&ohci1 {
> +	status = "okay";
> +};
> +
> +&otg_sram {
> +	status = "okay";
> +};
> +
> +&reg_ahci_5v {
> +	status = "okay";
> +};
> +
> +#include "axp209.dtsi"
> +
> +&ac_power_supply {
> +	status = "okay";
> +};
> +
> +&reg_dcdc2 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <1000000>;
> +	regulator-max-microvolt = <1450000>;
> +	regulator-name = "vdd-cpu";
> +};
> +
> +&reg_dcdc3 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <1000000>;
> +	regulator-max-microvolt = <1400000>;
> +	regulator-name = "vdd-int-dll";
> +};
> +
> +&reg_ldo1 {
> +	regulator-name = "vdd-rtc";
> +};
> +
> +&reg_ldo2 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <3000000>;
> +	regulator-max-microvolt = <3000000>;
> +	regulator-name = "avcc";
> +};
> +
> +&reg_usb1_vbus {
> +	status = "okay";
> +};
> +
> +&reg_usb2_vbus {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pb_pins>;
> +	status = "okay";
> +};
> +
> +&usb_otg {
> +	dr_mode = "otg";
> +	status = "okay";
> +};
> +
> +&usbphy {
> +	usb0_id_det-gpios = <&pio 7 4 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH4 */
> +	usb1_vbus-supply = <&reg_usb1_vbus>;
> +	usb2_vbus-supply = <&reg_usb2_vbus>;
> +	status = "okay";
> +};
> -- 
> 2.34.1
> 
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341A159E5C8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243779AbiHWPOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243707AbiHWPN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:13:58 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20961423F8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:21:51 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id l19so9911147ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=8WZ8bvGdjEwHX0IsEWXNGnSpkb8CjQdkE2OZtLeCvoE=;
        b=nAox752ytXIOtyvq9boUZqYcNH0Pg2ZbNe1rrmm8xCN5RHw36ST/VKtdsWItKVmg8d
         7NxzNJ4fCkFOYVemhalOiglPqDFMLMcFLcP4BfAec6/5afei1v0SPZFoTMW6tcXe1BXC
         nRXYFUvjKhs33UYMZ2LUX5VDKwsks8jsQ7U+ysedfGJaM9/WiNDhVTdVWp9cilsBY1X7
         mcToKp0+bZU+N2jFbdBe3D3yz6p5wPUZhl+Ayfxi/AI/jcy953lBBf82UkoCA+wWJ9sU
         D2gTy0oE1rPLgKEfEOiNZoxzGs7NsuYhFhwMI2ha99u3kAZSIP7f5ZWuUO/UzCI3afYP
         kS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=8WZ8bvGdjEwHX0IsEWXNGnSpkb8CjQdkE2OZtLeCvoE=;
        b=Egq5vmPJzTMbf+j0rstSM/xjDIqIlirgzxk7x8vl0qLlf7hjIpqYjQq1jys3rM5jwE
         TOAr7s4PdbiVFFl14aDC/jFBJ4ZYa6yo0QQLek9Hg/RlvSPrDnaLuIvicV1s1eXWz/LE
         qRe4DeRZ+ByoAQaCL/tCJIBSCZQRR6pj4t6JuRNlCLo77h48nu06+SYAmhcxfLKmP4ee
         qygcg5Y4cc7/WBRtaVtOKnnfOeQ7sIiRdRjvwCtgNQfeDV3ANf6kiNG9oPMBPmqpBfap
         kMYsI3PAq+BtqDUwKPopmQ5KyiK6xrNE6mi8ILjkdAUwsiegZYqdC9CLPENmo8V6gUWC
         8N6Q==
X-Gm-Message-State: ACgBeo0xeUoBj5iL/52zrq3kPfHE7CywVuX6ENb6sb9xXB94IzN4zA9x
        OJO4yAiC95+2ju7+Kwo8LQ4Kyw==
X-Google-Smtp-Source: AA6agR6wx7Fmfl9YYBFDWqXU/cbxwg6aYJ4+JO2KKwpgh+jC/v1pssmvIorF+DCc4ELSl9EbVmjY+w==
X-Received: by 2002:a2e:8788:0:b0:261:9bfc:3ffd with SMTP id n8-20020a2e8788000000b002619bfc3ffdmr6885115lji.454.1661250065627;
        Tue, 23 Aug 2022 03:21:05 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id o6-20020a05651205c600b00492c6ce35basm972313lfo.79.2022.08.23.03.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 03:21:05 -0700 (PDT)
Message-ID: <6c89f254-185a-4046-2bf0-a9f85713858e@linaro.org>
Date:   Tue, 23 Aug 2022 13:21:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 4/4] arch: arm64: ti: Add support for J784s4 EVM board
Content-Language: en-US
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Hari Nagalla <hnagalla@ti.com>
References: <20220819190054.31348-1-a-nandan@ti.com>
 <20220819190054.31348-5-a-nandan@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220819190054.31348-5-a-nandan@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2022 22:00, Apurva Nandan wrote:
> J784s4 EVM board is designed for TI J784s4 SoC. It supports the following
> interfaces:
> * 32 GB DDR4 RAM
> * x2 Gigabit Ethernet interfaces capable of working in Switch and MAC mode
> * x1 Input Audio Jack, x1 Output Audio Jack
> * x1 USB2.0 Hub with two Type A host and x1 USB 3.1 Type-C Port
> * x2 4L PCIe connector
> * x1 UHS-1 capable micro-SD card slot
> * 512 Mbit OSPI flash, 1 Gbit Octal NAND flash, 512 Mbit QSPI flash,
>   UFS flash.
> * x6 UART through UART-USB bridge
> * XDS110 for onboard JTAG debug using USB
> * Temperature sensors, user push buttons and LEDs
> * 40-pin User Expansion Connector
> * x2 ENET Expansion Connector, x1 GESI expander, x2 Display connector
> * x1 15-pin CSI header
> * x6 MCAN instances
> 
> Add basic support for J784s4-EVM.
> 
> Schematics: https://www.ti.com/lit/zip/sprr458

Use subject perfixes matching the subsystem (git log --oneline -- ...).
For example:
arm64: dts: ti:

> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile          |   2 +
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 602 +++++++++++++++++++++++
>  2 files changed, 604 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 02e5d80344d0..6381c458738a 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -19,6 +19,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
>  
>  dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
>  
> +dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
> +
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
>  
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> new file mode 100644
> index 000000000000..7ca08e115e67
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -0,0 +1,602 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
> + *
> + * Common Processor Board: https://www.ti.com/tool/J721EXCPXEVM
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/net/ti-dp83867.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include "k3-j784s4.dtsi"
> +
> +/ {
> +	compatible = "ti,j784s4-evm", "ti,j784s4";
> +	model = "Texas Instruments J784S4 EVM";
> +
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x2880000";

earlycon is not a property of hardware. Console is defined in
stdout-path, so please drop entire bootargs.

> +	};
> +
> +	aliases {
> +		serial2 = &main_uart8;
> +		mmc0 = &main_sdhci0;
> +		mmc1 = &main_sdhci1;
> +		i2c0 = &main_i2c0;
> +		can0 = &mcu_mcan0;
> +		can1 = &mcu_mcan1;
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		/* 32G RAM */
> +		reg = <0x00 0x80000000 0x00 0x80000000>,
> +		      <0x08 0x80000000 0x07 0x80000000>;
> +	};
> +
> +	/* Reserving memory regions still pending */
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		secure_ddr: optee@9e800000 {
> +			reg = <0x00 0x9e800000 0x00 0x01800000>;
> +			alignment = <0x1000>;
> +			no-map;
> +		};
> +	};
> +
> +	evm_12v0: fixedregulator-evm12v0 {

Node name should be generic, so:
regulator-evm12v0

> +		/* main supply */
> +		compatible = "regulator-fixed";
> +		regulator-name = "evm_12v0";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vsys_3v3: fixedregulator-vsys3v3 {

ditto

> +		/* Output of LM5140 */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&evm_12v0>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vsys_5v0: fixedregulator-vsys5v0 {

ditto

> +		/* Output of LM5140 */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_5v0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&evm_12v0>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vdd_mmc1: fixedregulator-sd {

ditto

> +		/* Output of TPS22918 */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_mmc1";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		vin-supply = <&vsys_3v3>;
> +		gpio = <&exp2 2 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	vdd_sd_dv: gpio-regulator-TLV71033 {

ditto

> +		/* Output of TLV71033 */
> +		compatible = "regulator-gpio";
> +		regulator-name = "tlv71033";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vdd_sd_dv_pins_default>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		vin-supply = <&vsys_5v0>;
> +		gpios = <&main_gpio0 8 GPIO_ACTIVE_HIGH>;
> +		states = <1800000 0x0>,
> +			 <3300000 0x1>;
> +	};
> +
> +	transceiver1: can-phy1 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mcu_mcan0_gpio_pins_default>;
> +		standby-gpios = <&wkup_gpio0 69 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	transceiver2: can-phy2 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mcu_mcan1_gpio_pins_default>;
> +		standby-gpios = <&wkup_gpio0 2 GPIO_ACTIVE_HIGH>;
> +	};



Best regards,
Krzysztof

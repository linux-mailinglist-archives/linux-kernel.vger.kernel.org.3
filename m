Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17395A363B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 11:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbiH0JRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 05:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiH0JRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 05:17:15 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D9867CA6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 02:17:13 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id by6so3598598ljb.11
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 02:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=0xQ2M5B2jLDQIFFL9xkibgGR5A1dIxaAk5TqxMYcZoE=;
        b=NbIwQsPbad5IuUe5Uu9Tykp09J8WwnK0ug08eFbd637hvCzqCd91QVGYjQo3wujEgJ
         Rg4O/ESBI45bh7ahsVdn9EaQham9fw7H58M3DjJ72BrcWLAF8U6e2mwk+LB1mP7f2wbY
         Uf//EqRZQ6ASEb+dI+NBfH1C+mjkuETkDCPhiUQ19s+0KXidOYZMMfhkj+T4I1HKikX1
         aZIzsi6RI4tehTmLA/aiYOyNBu0KODkQqZxI4Svc3e9sS/xdaDsju4jmj2fcM20VNBj9
         y6Jv7Y9hfgNUUXB+NYnMQCpY2vsGhU1OKkcX4efWYu7vUiiiHsv16XQSR/krrQUUKTul
         Malg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=0xQ2M5B2jLDQIFFL9xkibgGR5A1dIxaAk5TqxMYcZoE=;
        b=P1qchMswLKxGTiEgzoMYGNVed/+yvKy51H3+eCwlJfnwn9A/M3nkvMSxGAGcCwjYJl
         BeWl9akPYuPkjjnAgdmtDzz9+CWjh+v66VOTWv5W1U7ckEgpuymbIu7Oe07/5DZeolaP
         g82TYLcYTFC6jRZCsrfoQa0n5+MLI6GxdXDxdLcUo1fRZe8B4//v7UKaS26OTV3P/eju
         /WM88SneHHGcVhKTysbp7cA6lqo36iCNaAcPlpGu52Wf5TanhDoIWBRwZFiayA5vTwV1
         bcZ7oujGVQW5UWYbtitkLPDxXDpzlTWCO54NXgEPJFZ8pVZWYbMErBVUbHUuehv/9SAv
         O84w==
X-Gm-Message-State: ACgBeo19FZvsjMdILYC/q1AnhI3SJO0pLXKGu9Dtz2328Fw6Yo+qz0Zl
        T7KZR+iBfM7Q1pdnjwLtOpCNGA==
X-Google-Smtp-Source: AA6agR4HsbU2F+H8Sp+6RTaIJaz9/uHULY9b5s6nkG4XqHCY4cG/s1Jt0WV0QR/1Vee/wsxjCPwyNA==
X-Received: by 2002:a2e:2d09:0:b0:25a:816a:2e62 with SMTP id t9-20020a2e2d09000000b0025a816a2e62mr3047839ljt.147.1661591831666;
        Sat, 27 Aug 2022 02:17:11 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id k7-20020a2ea267000000b00261eaa819b7sm715764ljm.30.2022.08.27.02.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Aug 2022 02:17:11 -0700 (PDT)
Message-ID: <aed12dee-9675-92a6-82b7-0a6d605738db@linaro.org>
Date:   Sat, 27 Aug 2022 12:17:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] ARM: dts: aspeed: Add IBM Bonnell system BMC devicetree
Content-Language: en-US
To:     Eddie James <eajames@linux.ibm.com>, joel@jms.id.au
Cc:     andrew@aj.id.au, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, soc@kernel.org, olof@lixom.net, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        wrightj@linux.ibm.com
References: <20220826195141.165631-1-eajames@linux.ibm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220826195141.165631-1-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2022 22:51, Eddie James wrote:
> Bonnell is an IBM Power10 server system with an AST2600 BMC.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Jim Wright <wrightj@linux.ibm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/arm/boot/dts/Makefile                   |   1 +
>  arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts | 909 +++++++++++++++++++
>  2 files changed, 910 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index e49185119b5b..add4d52ab718 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1594,6 +1594,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-facebook-wedge400.dtb \
>  	aspeed-bmc-facebook-yamp.dtb \
>  	aspeed-bmc-facebook-yosemitev2.dtb \
> +	aspeed-bmc-ibm-bonnell.dtb \
>  	aspeed-bmc-ibm-everest.dtb \
>  	aspeed-bmc-ibm-rainier.dtb \
>  	aspeed-bmc-ibm-rainier-1s4u.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
> new file mode 100644
> index 000000000000..6789c1ec286a
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
> @@ -0,0 +1,909 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2022 IBM Corp.
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
> +#include <dt-bindings/leds/leds-pca955x.h>
> +
> +/ {
> +	model = "Bonnell";
> +	compatible = "ibm,bonnell-bmc", "aspeed,ast2600";

Missing bindings documentation.

> +
> +	aliases {
> +		i2c100 = &cfam0_i2c0;
> +		i2c101 = &cfam0_i2c1;
> +		i2c110 = &cfam0_i2c10;
> +		i2c111 = &cfam0_i2c11;
> +		i2c112 = &cfam0_i2c12;
> +		i2c113 = &cfam0_i2c13;
> +		i2c114 = &cfam0_i2c14;
> +		i2c115 = &cfam0_i2c15;
> +		i2c202 = &cfam1_i2c2;
> +		i2c203 = &cfam1_i2c3;
> +		i2c210 = &cfam1_i2c10;
> +		i2c211 = &cfam1_i2c11;
> +		i2c214 = &cfam1_i2c14;
> +		i2c215 = &cfam1_i2c15;
> +		i2c216 = &cfam1_i2c16;
> +		i2c217 = &cfam1_i2c17;
> +
> +		serial4 = &uart5;
> +		i2c16 = &i2c11mux0chn0;
> +		i2c17 = &i2c11mux0chn1;
> +		i2c18 = &i2c11mux0chn2;
> +		i2c19 = &i2c11mux0chn3;
> +
> +		spi10 = &cfam0_spi0;
> +		spi11 = &cfam0_spi1;
> +		spi12 = &cfam0_spi2;
> +		spi13 = &cfam0_spi3;
> +		spi20 = &cfam1_spi0;
> +		spi21 = &cfam1_spi1;
> +		spi22 = &cfam1_spi2;
> +		spi23 = &cfam1_spi3;
> +

No need for space.

> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200n8 earlycon";

bootargs do no belong to mainline DTS. console is defined in stcdut-path
and earlycon is for debugging, not for production/final use.

Remove entire bootargs.


> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x40000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		flash_memory: region@b8000000 {
> +			no-map;
> +			reg = <0xb8000000 0x04000000>; /* 64M */
> +		};
> +
> +		ramoops@bc000000 {
> +			compatible = "ramoops";
> +			reg = <0xbc000000 0x200000>; /* 16 * (4 * 0x8000) */
> +			record-size = <0x8000>;
> +			console-size = <0x8000>;
> +			ftrace-size = <0x8000>;
> +			pmsg-size = <0x8000>;
> +			max-reason = <3>; /* KMSG_DUMP_EMERG */
> +		};
> +
> +		vga_memory: region@bf000000 {
> +			no-map;
> +			compatible = "shared-dma-pool";
> +			reg = <0xbf000000 0x01000000>;  /* 16M */
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		fan0 {

This does no pass the schema. It seems you did not check the DTS. Run
`make dtbs_check` and fix all errors. You need generic node names here.

> +			gpios = <&gpio0 ASPEED_GPIO(G, 0) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		fan1 {
> +			gpios = <&gpio0 ASPEED_GPIO(G, 1) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		rear-enc-id0 {
> +			gpios = <&gpio0 ASPEED_GPIO(H, 2) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		rear-enc-fault0 {
> +			gpios = <&gpio0 ASPEED_GPIO(H, 3) GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	gpio-keys-polled {

gpio-keys

> +		compatible = "gpio-keys-polled";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		poll-interval = <1000>;
> +
> +		fan0-presence {

Same problem as with leds.

> +			label = "fan0-presence";
> +			gpios = <&gpio0 ASPEED_GPIO(F, 4) GPIO_ACTIVE_LOW>;
> +			linux,code = <6>;
> +		};
> +
> +		fan1-presence {
> +			label = "fan1-presence";
> +			gpios = <&gpio0 ASPEED_GPIO(F, 5) GPIO_ACTIVE_LOW>;
> +			linux,code = <7>;
> +		};
> +	};
> +
> +	iio-hwmon-battery {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc1 7>;
> +	};
> +};
> +
> +&adc1 {
> +	status = "okay";
> +	aspeed,int-vref-microvolt = <2500000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
> +		&pinctrl_adc10_default &pinctrl_adc11_default
> +		&pinctrl_adc12_default &pinctrl_adc13_default
> +		&pinctrl_adc14_default &pinctrl_adc15_default>;
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&uhci {
> +	status = "okay";
> +};
> +
> +&gpio0 {
> +	gpio-line-names =
> +		/*A0-A7*/	"","","","","","","","",
> +		/*B0-B7*/	"","","","","","","checkstop","",
> +		/*C0-C7*/	"","","","","","","","",
> +		/*D0-D7*/	"","","","","","","","",
> +		/*E0-E7*/	"","","","","","","","",
> +		/*F0-F7*/	"","","rtc-battery-voltage-read-enable","reset-cause-pinhole","","","","",
> +		/*G0-G7*/	"fan0","fan1","","","","","","",
> +		/*H0-H7*/	"","","rear-enc-id0","rear-enc-fault0","","","","",
> +		/*I0-I7*/	"","","","","","","bmc-secure-boot","",
> +		/*J0-J7*/	"","","","","","","","",
> +		/*K0-K7*/	"","","","","","","","",
> +		/*L0-L7*/	"","","","","","","","",
> +		/*M0-M7*/	"","","","","","","","",
> +		/*N0-N7*/	"","","","","","","","",
> +		/*O0-O7*/	"","","","usb-power","","","","",
> +		/*P0-P7*/	"","","","","","","","",
> +		/*Q0-Q7*/	"cfam-reset","","regulator-standby-faulted","","","","","",
> +		/*R0-R7*/	"bmc-tpm-reset","power-chassis-control","power-chassis-good","","","","","",
> +		/*S0-S7*/	"presence-ps0","presence-ps1","","","power-ffs-sync-history","","","",
> +		/*T0-T7*/	"","","","","","","","",
> +		/*U0-U7*/	"","","","","","","","",
> +		/*V0-V7*/	"","","","","","","","",
> +		/*W0-W7*/	"","","","","","","","",
> +		/*X0-X7*/	"","","","","","","","",
> +		/*Y0-Y7*/	"","","","","","","","",
> +		/*Z0-Z7*/	"","","","","","","","";
> +
> +	usb_power {
> +		gpio-hog;
> +		gpios = <ASPEED_GPIO(O, 3) GPIO_ACTIVE_LOW>;
> +		output-high;
> +	};
> +};
> +
> +&emmc_controller {
> +	status = "okay";
> +};
> +
> +&pinctrl_emmc_default {
> +	bias-disable;
> +};
> +
> +&emmc {
> +	status = "okay";
> +	clk-phase-mmc-hs200 = <180>, <180>;
> +};
> +
> +&fsim0 {
> +	status = "okay";
> +
> +	#address-cells = <2>;
> +	#size-cells = <0>;
> +
> +	cfam-reset-gpios = <&gpio0 ASPEED_GPIO(Q, 0) GPIO_ACTIVE_HIGH>;
> +
> +	cfam@0,0 {
> +		reg = <0 0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		chip-id = <0>;
> +
> +		scom@1000 {
> +			compatible = "ibm,fsi2pib";

Undocumented compatibles. Run checkpatch on your code. All compatibles
must be documented.

> +			reg = <0x1000 0x400>;
> +		};
> +
> +		i2c@1800 {
> +			compatible = "ibm,fsi-i2c-master";
> +			reg = <0x1800 0x400>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			cfam0_i2c0: i2c-bus@0 {
> +				reg = <0>;	/* OMI01 */
> +			};
> +
> +			cfam0_i2c1: i2c-bus@1 {
> +				reg = <1>;	/* OMI23 */
> +			};
> +
> +			cfam0_i2c10: i2c-bus@a {
> +				reg = <10>;	/* OP3A */
> +			};
> +
> +			cfam0_i2c11: i2c-bus@b {
> +				reg = <11>;	/* OP3B */
> +			};
> +
> +			cfam0_i2c12: i2c-bus@c {
> +				reg = <12>;	/* OP4A */
> +			};
> +
> +			cfam0_i2c13: i2c-bus@d {
> +				reg = <13>;	/* OP4B */
> +			};
> +
> +			cfam0_i2c14: i2c-bus@e {
> +				reg = <14>;	/* OP5A */
> +			};
> +
> +			cfam0_i2c15: i2c-bus@f {
> +				reg = <15>;	/* OP5B */
> +			};
> +		};
> +
> +		fsi2spi@1c00 {
> +			compatible = "ibm,fsi2spi";
> +			reg = <0x1c00 0x400>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			cfam0_spi0: spi@0 {
> +				reg = <0x0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				eeprom@0 {
> +					at25,byte-len = <0x80000>;
> +					at25,addr-mode = <4>;
> +					at25,page-size = <256>;
> +
> +					compatible = "atmel,at25";
> +					reg = <0>;
> +					spi-max-frequency = <1000000>;
> +				};
> +			};
> +
> +			cfam0_spi1: spi@20 {
> +				reg = <0x20>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				eeprom@0 {
> +					at25,byte-len = <0x80000>;
> +					at25,addr-mode = <4>;
> +					at25,page-size = <256>;
> +
> +					compatible = "atmel,at25";
> +					reg = <0>;

compatible and reg go first in properties. This applies everywhere.

> +					spi-max-frequency = <1000000>;
> +				};
> +			};
> +
> +			cfam0_spi2: spi@40 {
> +				reg = <0x40>;
> +				compatible = "ibm,fsi2spi-restricted";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				eeprom@0 {
> +					at25,byte-len = <0x80000>;
> +					at25,addr-mode = <4>;
> +					at25,page-size = <256>;
> +
> +					compatible = "atmel,at25";
> +					reg = <0>;
> +					spi-max-frequency = <1000000>;
> +				};
> +			};
> +
> +			cfam0_spi3: spi@60 {
> +				reg = <0x60>;
> +				compatible = "ibm,fsi2spi-restricted";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				eeprom@0 {
> +					at25,byte-len = <0x80000>;
> +					at25,addr-mode = <4>;
> +					at25,page-size = <256>;
> +
> +					compatible = "atmel,at25";
> +					reg = <0>;
> +					spi-max-frequency = <1000000>;
> +				};
> +			};
> +		};
> +
> +		sbefifo@2400 {
> +			compatible = "ibm,p9-sbefifo";
> +			reg = <0x2400 0x400>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			fsi_occ0: occ {
> +				compatible = "ibm,p10-occ";
> +			};
> +		};
> +
> +		fsi_hub0: hub@3400 {
> +			compatible = "fsi-master-hub";
> +			reg = <0x3400 0x400>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +		};
> +	};
> +};
> +
> +&fsi_hub0 {
> +	cfam@1,0 {
> +		reg = <1 0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		chip-id = <1>;
> +
> +		scom@1000 {
> +			compatible = "ibm,fsi2pib";
> +			reg = <0x1000 0x400>;
> +		};
> +
> +		i2c@1800 {
> +			compatible = "ibm,fsi-i2c-master";
> +			reg = <0x1800 0x400>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			cfam1_i2c2: i2c-bus@2 {
> +				reg = <2>;	/* OMI45 */
> +			};
> +
> +			cfam1_i2c3: i2c-bus@3 {
> +				reg = <3>;	/* OMI67 */
> +			};
> +
> +			cfam1_i2c10: i2c-bus@a {
> +				reg = <10>;	/* OP3A */
> +			};
> +
> +			cfam1_i2c11: i2c-bus@b {
> +				reg = <11>;	/* OP3B */
> +			};
> +
> +			cfam1_i2c14: i2c-bus@e {
> +				reg = <14>;	/* OP5A */
> +			};
> +
> +			cfam1_i2c15: i2c-bus@f {
> +				reg = <15>;	/* OP5B */
> +			};
> +
> +			cfam1_i2c16: i2c-bus@10 {
> +				reg = <16>;	/* OP6A */
> +			};
> +
> +			cfam1_i2c17: i2c-bus@11 {
> +				reg = <17>;	/* OP6B */
> +			};
> +		};
> +
> +		fsi2spi@1c00 {
> +			compatible = "ibm,fsi2spi";
> +			reg = <0x1c00 0x400>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			cfam1_spi0: spi@0 {
> +				reg = <0x0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				eeprom@0 {
> +					at25,byte-len = <0x80000>;
> +					at25,addr-mode = <4>;
> +					at25,page-size = <256>;
> +
> +					compatible = "atmel,at25";
> +					reg = <0>;
> +					spi-max-frequency = <1000000>;
> +				};
> +			};
> +
> +			cfam1_spi1: spi@20 {
> +				reg = <0x20>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				eeprom@0 {
> +					at25,byte-len = <0x80000>;
> +					at25,addr-mode = <4>;
> +					at25,page-size = <256>;
> +
> +					compatible = "atmel,at25";
> +					reg = <0>;
> +					spi-max-frequency = <1000000>;
> +				};
> +			};
> +
> +			cfam1_spi2: spi@40 {
> +				reg = <0x40>;
> +				compatible = "ibm,fsi2spi-restricted";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				eeprom@0 {
> +					at25,byte-len = <0x80000>;
> +					at25,addr-mode = <4>;
> +					at25,page-size = <256>;
> +
> +					compatible = "atmel,at25";
> +					reg = <0>;
> +					spi-max-frequency = <1000000>;
> +				};
> +			};
> +
> +			cfam1_spi3: spi@60 {
> +				reg = <0x60>;
> +				compatible = "ibm,fsi2spi-restricted";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				eeprom@0 {
> +					at25,byte-len = <0x80000>;
> +					at25,addr-mode = <4>;
> +					at25,page-size = <256>;
> +
> +					compatible = "atmel,at25";
> +					reg = <0>;
> +					spi-max-frequency = <1000000>;
> +				};
> +			};
> +		};
> +
> +		sbefifo@2400 {
> +			compatible = "ibm,p9-sbefifo";
> +			reg = <0x2400 0x400>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			fsi_occ1: occ {
> +				compatible = "ibm,p10-occ";
> +			};
> +		};
> +
> +		fsi_hub1: hub@3400 {
> +			compatible = "fsi-master-hub";
> +			reg = <0x3400 0x400>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +
> +			no-scan-on-init;
> +		};
> +	};
> +};
> +
> +&ibt {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	eeprom@51 {
> +		compatible = "atmel,24c64";
> +		reg = <0x51>;
> +	};
> +
> +	tca9554@20 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "ti,tca9554";
> +		reg = <0x20>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		gpio-line-names = "",
> +			"RUSSEL_FW_I2C_ENABLE_N",
> +			"RUSSEL_OPPANEL_PRESENCE_N",
> +			"BLYTH_OPPANEL_PRESENCE_N",
> +			"CPU_TPM_CARD_PRESENT_N",
> +			"",
> +			"",
> +			"DASD_BP_PRESENT_N";
> +	};
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +
> +	ucd90160@64 {
> +		compatible = "ti,ucd90160";
> +		reg = <0x64>;
> +	};
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +
> +	power-supply@58 {
> +		compatible = "ibm,cffps";
> +		reg = <0x58>;
> +	};
> +
> +	power-supply@59 {
> +		compatible = "ibm,cffps";
> +		reg = <0x59>;
> +	};
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +};
> +
> +&i2c5 {
> +	status = "okay";
> +};
> +
> +&i2c6 {
> +	status = "okay";
> +};
> +
> +&i2c7 {
> +	multi-master;
> +	status = "okay";
> +
> +	si7021-a20@40 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "silabs,si7020";
> +		reg = <0x40>;
> +	};
> +
> +	tmp275@48 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "ti,tmp275";
> +		reg = <0x48>;
> +	};
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c64";
> +		reg = <0x50>;
> +	};
> +
> +	eeprom@51 {
> +		compatible = "atmel,24c64";
> +		reg = <0x51>;
> +	};
> +
> +	max31785@52 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "maxim,max31785a";
> +		reg = <0x52>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		fan0: fan@0 {
> +			compatible = "pmbus-fan";
> +			reg = <0>;
> +			tach-pulses = <2>;
> +		};
> +
> +		fan1: fan@1 {
> +			compatible = "pmbus-fan";
> +			reg = <1>;
> +			tach-pulses = <2>;
> +		};
> +	};
> +
> +	pca9551@60 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "nxp,pca9551";
> +		reg = <0x60>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		led@0 {
> +			label = "front-sys-id0";
> +			reg = <0>;
> +			retain-state-shutdown;
> +			default-state = "keep";
> +			type = <PCA955X_TYPE_LED>;
> +		};
> +
> +		led@1 {
> +			label = "front-check-log0";
> +			reg = <1>;
> +			retain-state-shutdown;
> +			default-state = "keep";
> +			type = <PCA955X_TYPE_LED>;
> +		};
> +
> +		led@2 {
> +			label = "front-enc-fault1";
> +			reg = <2>;
> +			retain-state-shutdown;
> +			default-state = "keep";
> +			type = <PCA955X_TYPE_LED>;
> +		};
> +
> +		led@3 {
> +			label = "front-sys-pwron0";
> +			reg = <3>;
> +			retain-state-shutdown;
> +			default-state = "keep";
> +			type = <PCA955X_TYPE_LED>;
> +		};
> +	};
> +
> +	ibm-panel@62 {
> +		compatible = "ibm,op-panel";
> +		reg = <(0x62 | I2C_OWN_SLAVE_ADDRESS)>;
> +	};
> +
> +	dps: dps310@76 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "infineon,dps310";
> +		reg = <0x76>;
> +		#io-channel-cells = <0>;
> +	};
> +};
> +
> +&i2c8 {
> +	status = "okay";
> +
> +	rtc@32 {
> +		compatible = "epson,rx8900";
> +		reg = <0x32>;
> +	};
> +
> +	tmp275@48 {

Seriously... I'll stop review.

Best regards,
Krzysztof

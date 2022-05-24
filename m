Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A080B5328D6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbiEXLXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbiEXLXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:23:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1ADEA78938;
        Tue, 24 May 2022 04:23:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBE2E1FB;
        Tue, 24 May 2022 04:23:15 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7989D3F73D;
        Tue, 24 May 2022 04:23:12 -0700 (PDT)
Message-ID: <7439ce39-a2c2-7310-27d3-08ba2ed75ac9@arm.com>
Date:   Tue, 24 May 2022 12:23:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] arm64: dts: Add support for Stratix 10 Software Virtual
 Platform
Content-Language: en-GB
To:     wen.ping.teh@intel.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Yves Vandervennet <yvanderv@opensource.altera.com>,
        Dinh Nguyen <dinguyen@opensource.altera.com>
References: <20220524102912.792968-1-wen.ping.teh@intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220524102912.792968-1-wen.ping.teh@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-24 11:29, wen.ping.teh@intel.com wrote:
> From: Teh Wen Ping <wen.ping.teh@intel.com>
> 
> Add Stratix 10 Software Virtual Platform device tree
> 
> Signed-off-by: Yves Vandervennet <yvanderv@opensource.altera.com>
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> ---
>   arch/arm64/Kconfig.platforms                  |   3 +-
>   arch/arm64/boot/dts/altera/Makefile           |   3 +-
>   .../dts/altera/socfpga_stratix10_swvp.dts     | 131 ++++++++++++++++++
>   3 files changed, 135 insertions(+), 2 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index de9a18d3026f..48abe5dafaae 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -249,7 +249,8 @@ config ARCH_INTEL_SOCFPGA
>   	bool "Intel's SoCFPGA ARMv8 Families"
>   	help
>   	  This enables support for Intel's SoCFPGA ARMv8 families:
> -	  Stratix 10 (ex. Altera), Agilex and eASIC N5X.
> +	  Stratix 10 (ex. Altera), Stratix10 Software Virtual Platform,
> +	  Agilex and eASIC N5X.
>   
>   config ARCH_SYNQUACER
>   	bool "Socionext SynQuacer SoC Family"
> diff --git a/arch/arm64/boot/dts/altera/Makefile b/arch/arm64/boot/dts/altera/Makefile
> index 4db83fbeb115..1bf0c472f6b4 100644
> --- a/arch/arm64/boot/dts/altera/Makefile
> +++ b/arch/arm64/boot/dts/altera/Makefile
> @@ -1,3 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_stratix10_socdk.dtb \
> -				socfpga_stratix10_socdk_nand.dtb
> +				socfpga_stratix10_socdk_nand.dtb \
> +				socfpga_stratix10_swvp.dtb
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts
> new file mode 100644
> index 000000000000..209e26d3611b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier:     GPL-2.0
> +/*
> + * Copyright (C) 2022, Intel Corporation
> + */
> +
> +#include "socfpga_stratix10.dtsi"
> +
> +/ {
> +	model = "SOCFPGA Stratix 10 SWVP";
> +	compatible = "arm,foundation-aarch64", "arm,vexpress";

This is definitely not compatible with any Arm Versatile Express 
platform. It doesn't even have RAM in the same place, for starters.

> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +
> +		timer0 = &timer0;
> +		timer1 = &timer1;
> +		timer2 = &timer2;
> +		timer3 = &timer3;
> +
> +		ethernet0 = &gmac0;
> +		ethernet1 = &gmac1;
> +		ethernet2 = &gmac2;
> +	};
> +
> +	chosen {
> +		bootargs = "rdinit=/sbin/init ip=dhcp mem=2048M";
> +		stdout-path = "serial1:115200n8";
> +		linux,initrd-start = <0x10000000>;
> +		linux,initrd-end = <0x125c8324>;
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x80000000>;
> +	};
> +
> +	soc {
> +		clocks {
> +			osc1 {
> +				clock-frequency = <25000000>;
> +			};
> +		};
> +
> +		l2-cache@fffff000 {
> +			compatible = "arm,pl310-cache";

Yikes, I hope not!

I didn't think AArch64 even allows outer caches that don't honour CPU 
cache maintenance by VA? Either way I can't imagine we'd ever accept 
PL310 support in mainline, so even if your model does actually have this 
for some inexplicable reason, I don't think there's any point exposing 
it in the DT.

Robin.

> +			reg = <0xfffff000 0x1000>;
> +			interrupts = <0x0 0x12 0x4>;
> +			cache-unified;
> +			cache-level = <0x2>;
> +			linux,phandle = <0x1>;
> +		};
> +	};
> +};
> +
> +&cpu0 {
> +	enable-method = "spin-table";
> +	cpu-release-addr = <0x0 0x0000fff8>;
> +};
> +
> +&cpu1 {
> +	enable-method = "spin-table";
> +	cpu-release-addr = <0x0 0x0000fff8>;
> +};
> +
> +&cpu2 {
> +	enable-method = "spin-table";
> +	cpu-release-addr = <0x0 0x0000fff8>;
> +};
> +
> +&cpu3 {
> +	enable-method = "spin-table";
> +	cpu-release-addr = <0x0 0x0000fff8>;
> +};
> +
> +&gmac0 {
> +	status = "okay";
> +	phy-mode = "rgmii";
> +	phy-addr = <0xffffffff>;
> +	snps,max-mtu = <0x0>;
> +};
> +
> +&gmac1 {
> +	status = "okay";
> +	phy-mode = "rgmii";
> +	phy-addr = <0xffffffff>;
> +};
> +
> +&gmac2 {
> +	status = "okay";
> +	phy-mode = "rgmii";
> +	phy-addr = <0xffffffff>;
> +};
> +
> +&mmc {
> +	status = "okay";
> +	altr,dw-mshc-ciu-div = <0x3>;
> +	altr,dw-mshc-sdr-timing = <0x0 0x3>;
> +	cap-sd-highspeed;
> +	cap-mmc-highspeed;
> +	broken-cd;
> +	bus-width = <4>;
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	clocks = <&clkmgr STRATIX10_L4_MP_CLK>;
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	clocks = <&clkmgr STRATIX10_L4_MP_CLK>;
> +	status = "okay";
> +};
> +
> +&rst {
> +	altr,modrst-offset = <0x20>;
> +};
> +
> +&sysmgr {
> +	reg = <0xffd12000 0x1000>;
> +	interrupts = <0x0 0x10 0x4>;
> +	cpu1-start-addr = <0xffd06230>;
> +};

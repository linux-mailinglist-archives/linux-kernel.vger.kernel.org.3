Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916E3536C53
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 12:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbiE1KhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 06:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbiE1KhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 06:37:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10522182C;
        Sat, 28 May 2022 03:37:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CCC460C7E;
        Sat, 28 May 2022 10:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9CDC34100;
        Sat, 28 May 2022 10:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653734223;
        bh=SuKmmY28pKiTzovsqJhz5fPRfTzVYcOhutqCxn2HdxM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BHMvYrexpNW29pfbkhTvPixlvgZptkB5VK+gG+uxxMl0gmUAWMCPwc4Hqh5ciGyf/
         +OSZpCR21DxBKvvk3OqsPy9mWrUURtQDLCas7WU0isrLJVgHxFrS1M29L1AGjlNe+Q
         1E0lrXuQWOxVeBMnhofq3ttGtcrI4vLqecvuuPILw73uHAfXhxMYgufUQXpyPTX/K1
         sLWBeIKMt9edn75Hf0aWU+KhP4ECNLg/uZyM6OHhla917uPl4E24Pi1ap5GUIf92uX
         OY/sW8mCKoe6KJaWiQ6hNvdo+bcVSpkySZWWHN6Hqc+MhOjoP5uUmr6P3CN0QUMyEA
         k3hx9edB9rwjA==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nutoa-00EDuu-MA; Sat, 28 May 2022 11:37:00 +0100
MIME-Version: 1.0
Date:   Sat, 28 May 2022 11:37:00 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Anand Gore <anand.gore@broadcom.com>
Cc:     Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        dan.beygelman@broadcom.com, samyon.furman@broadcom.com,
        florian.fainelli@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM64: dts: add dts files for bcmbca SoC bcm6858
In-Reply-To: <20220527101336.1.I66ae43da75911b704f02a759f70d66bc7e542885@changeid>
References: <20220527171356.2461297-1-anand.gore@broadcom.com>
 <20220527101336.1.I66ae43da75911b704f02a759f70d66bc7e542885@changeid>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <be2a935ca7f7d14c35dc772cda338e5d@misterjones.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: anand.gore@broadcom.com, linux-arm-kernel@lists.infradead.org, dan.beygelman@broadcom.com, samyon.furman@broadcom.com, florian.fainelli@broadcom.com, william.zhang@broadcom.com, tomer.yacoby@broadcom.com, kursad.oney@broadcom.com, joel.peshkin@broadcom.com, bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com, krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-27 18:13, Anand Gore wrote:
> Add dts for ARMv8 based broadband SoC BCM6858.
> bcm6858.dtsi is the SoC description dts header
> and bcm96858.dts is a simple dts file for Broadcom
> BCM96858 Reference board that only enables the UART port.
> 
> Signed-off-by: Anand Gore <anand.gore@broadcom.com>
> 
> ---
> 
>  arch/arm64/boot/dts/broadcom/bcmbca/Makefile  |   3 +-
>  .../boot/dts/broadcom/bcmbca/bcm6858.dtsi     | 120 ++++++++++++++++++
>  .../boot/dts/broadcom/bcmbca/bcm96858.dts     |  30 +++++
>  3 files changed, 152 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
>  create mode 100644 arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts
> 
> diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
> b/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
> index d5f89245336c..7d98b0787b8c 100644
> --- a/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
> +++ b/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -dtb-$(CONFIG_ARCH_BCMBCA) += bcm963158.dtb
> +dtb-$(CONFIG_ARCH_BCMBCA) += bcm963158.dtb \
> +				bcm96858.dtb
> diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
> b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
> new file mode 100644
> index 000000000000..664b8f399d69
> --- /dev/null
> +++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2022 Broadcom Ltd.
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "brcm,bcm6858", "brcm,bcmbca";
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	interrupt-parent = <&gic>;
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		B53_0: cpu@0 {
> +			compatible = "brcm,brahma-b53";
> +			device_type = "cpu";
> +			reg = <0x0 0x0>;
> +			next-level-cache = <&L2_0>;
> +			enable-method = "psci";
> +		};
> +
> +		B53_1: cpu@1 {
> +			compatible = "brcm,brahma-b53";
> +			device_type = "cpu";
> +			reg = <0x0 0x1>;
> +			next-level-cache = <&L2_0>;
> +			enable-method = "psci";
> +		};
> +
> +		B53_2: cpu@2 {
> +			compatible = "brcm,brahma-b53";
> +			device_type = "cpu";
> +			reg = <0x0 0x2>;
> +			next-level-cache = <&L2_0>;
> +			enable-method = "psci";
> +		};
> +
> +		B53_3: cpu@3 {
> +			compatible = "brcm,brahma-b53";
> +			device_type = "cpu";
> +			reg = <0x0 0x3>;
> +			next-level-cache = <&L2_0>;
> +			enable-method = "psci";
> +		};
> +		L2_0: l2-cache0 {
> +			compatible = "cache";
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | 
> IRQ_TYPE_LEVEL_LOW)>,
> +			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	pmu: pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&B53_0>, <&B53_1>,
> +			<&B53_2>, <&B53_3>;
> +	};
> +
> +	clocks: clocks {
> +		periph_clk:periph-clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <200000000>;
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +		cpu_off = <1>;
> +		cpu_on = <2>;

No. Either this is PSCI 0.2 (and inventing your own function numbers
is pointless), or this isn't. Either way, this is wrong.

> +	};
> +
> +	axi@81000000 {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x0 0x0 0x0 0x81000000 0x0 0x4000>;
> +
> +		gic: interrupt-controller@1000 {
> +			compatible = "arm,gic-400";
> +			#interrupt-cells = <3>;
> +			#address-cells = <0>;
> +			interrupt-controller;
> +			reg = <0x0 0x1000 0x0 0x1000>,
> +				<0x0 0x2000 0x0 0x2000>;

GIC400 has another two regions for GICH and GICV, and a maintenance
interrupt. Please add both.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

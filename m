Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9AA4AFCF5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 20:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiBITLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 14:11:13 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiBITLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:11:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C695C02B650;
        Wed,  9 Feb 2022 11:10:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 729C2B82381;
        Wed,  9 Feb 2022 19:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2AFC340E9;
        Wed,  9 Feb 2022 19:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644433854;
        bh=vJfdfjnTI9o6SZYd45w46xF+xwH5gWZMsI7j/ucfllg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i8HI+5ThCjZRNInGM8TbtSyTvZqr+LZ9hTmqER+7WpM5AbCLiHeKPmfx9EBoWUqKP
         PrQTbalXMFNjg7sju2JZKodsN0KGoGeda6SWMpxTYp6tdRKNLbD99OWSnEyV6pdWp3
         E4P2qWS6VM0XGmdSqNFSjcSXCBJ7HTpVmlTpyZ8krr1T4+e0POcD8nseT/Jxq2IeSe
         eh4sLOymbcGtgSdw2YVipnIXnrxDl5hz+H2xafyYL7Ev+Pe9vRlqhkn9MX+OrnxaxI
         j6ZQXesTvm/TPeHl/3PF1wcc+PWsRGxYcLj/oKRNzphsjFCbHUObu8mut3mKTbngz+
         32TDw2koI1eMg==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nHsMe-006j1n-1R; Wed, 09 Feb 2022 19:10:52 +0000
MIME-Version: 1.0
Date:   Wed, 09 Feb 2022 19:10:51 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] arm64: dts: ti: Introduce base support for AM62x SoC
In-Reply-To: <20220208131827.1430086-5-vigneshr@ti.com>
References: <20220208131827.1430086-1-vigneshr@ti.com>
 <20220208131827.1430086-5-vigneshr@ti.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <bc6cb6e1adcf6860a595b71246778733@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: vigneshr@ti.com, nm@ti.com, kristo@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski@canonical.com, ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-08 13:18, Vignesh Raghavendra wrote:
> The AM62 SoC family is the follow on AM335x built on K3 Multicore SoC
> architecture platform, providing ultra-low-power modes, dual display,
> multi-sensor edge compute, security and other BOM-saving integration.
> The AM62 SoC targets broad market to enable applications such as
> Industrial HMI, PLC/CNC/Robot control, Medical Equipment, Building
> Automation, Appliances and more.
> 
> Some highlights of this SoC are:
> 
> * Quad-Cortex-A53s (running up to 1.4GHz) in a single cluster.
>   Pin-to-pin compatible options for single and quad core are available.
> * Cortex-M4F for general-purpose or safety usage.
> * Dual display support, providing 24-bit RBG parallel interface and
>   OLDI/LVDS-4 Lane x2, up to 200MHz pixel clock support for 2K display
>   resolution.
> * Selectable GPUsupport, up to 8GFLOPS, providing better user 
> experience
>   in 3D graphic display case and Android.
> * PRU(Programmable Realtime Unit) support for customized programmable
>   interfaces/IOs.
> * Integrated Giga-bit Ethernet switch supporting up to a total of two
>   external ports (TSN capable).
> * 9xUARTs, 5xSPI, 6xI2C, 2xUSB2, 3xCAN-FD, 3x eMMC and SD, GPMC for
>   NAND/FPGA connection, OSPI memory controller, 3xMcASP for audio,
>   1x CSI-RX-4L for Camera, eCAP/eQEP, ePWM, among other peripherals.
> * Dedicated Centralized System Controller for Security, Power, and
>   Resource Management.
> * Multiple low power modes support, ex: Deep sleep,Standby, MCU-only,
>   enabling battery powered system design.
> 
> This add bare minimum DT describing ARM compute clusters, Main, MCU and
> Wakeup domain and interconnects, UARTs and I2Cs to enable booting using
> ramdisk.
> 
> More details can be found in the Technical Reference Manual:
> https://www.ti.com/lit/pdf/spruiv7
> 
> Co-developed-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Co-developed-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi   | 263 +++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi    |  36 +++
>  arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi |  41 ++++
>  arch/arm64/boot/dts/ti/k3-am62.dtsi        | 104 ++++++++
>  arch/arm64/boot/dts/ti/k3-am625.dtsi       | 103 ++++++++
>  5 files changed, 547 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am625.dtsi
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> new file mode 100644
> index 000000000000..81d6d99ca180
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -0,0 +1,263 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for AM625 SoC Family Main Domain peripherals
> + *
> + * Copyright (C) 2020-2022 Texas Instruments Incorporated - 
> https://www.ti.com/
> + */
> +
> +&cbass_main {
> +	gic500: interrupt-controller@1800000 {
> +		compatible = "arm,gic-v3";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +		reg = <0x00 0x01800000 0x00 0x10000>,	/* GICD */
> +		      <0x00 0x01880000 0x00 0xC0000>;	/* GICR */

Usual rant: you are missing the GICC, GICH and GICV regions
that are implemented by the CPU. Cortex-A53 implements them
(they are not optional), so please describe them.

> +		/*
> +		 * vcpumntirq:
> +		 * virtual CPU interface maintenance interrupt
> +		 */
> +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		gic_its: msi-controller@1820000 {
> +			compatible = "arm,gic-v3-its";
> +			reg = <0x00 0x01820000 0x00 0x10000>;
> +			socionext,synquacer-pre-its = <0x1000000 0x400000>;

The mind boggles...

         M.
-- 
Jazz is not dead. It just smells funny...

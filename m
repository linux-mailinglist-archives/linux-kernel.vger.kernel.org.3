Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB27B46726B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 08:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378782AbhLCHQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 02:16:58 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39862 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345605AbhLCHQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 02:16:57 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B37DM4h062564;
        Fri, 3 Dec 2021 01:13:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638515602;
        bh=HDIYdGCGWgdJR70rVLR8bOWHs6lY2KxX1FKweNKLUH4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sD2UG0/tc3eZcvFTjz30svi5SoTPeYlYfTaIdv5xlqf9K4sNc3RE4NaLpap0NVXa+
         h3+4GWIz3qj+W/QTw5ZfnXN+zVN2zl333aF+nK1eksHN2aIMyArUXRgg+bf5hQKoKB
         MHe/GJTMD/xZ7+mBUNq5Td8JmRIL9y2ZzuvjwlBY=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B37DMfL082453
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Dec 2021 01:13:22 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 3
 Dec 2021 01:13:22 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 3 Dec 2021 01:13:22 -0600
Received: from [10.250.234.92] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B37DI1t024178;
        Fri, 3 Dec 2021 01:13:19 -0600
Subject: Re: [PATCH 3/5] arm64: dts: ti: Add initial support for J721S2 SoC
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211119133052.17793-1-a-govindraju@ti.com>
 <20211119133052.17793-4-a-govindraju@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <22180fe2-2b59-9558-4e5b-dc97bcf09c96@ti.com>
Date:   Fri, 3 Dec 2021 12:43:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211119133052.17793-4-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath,

On 19/11/21 7:00 pm, Aswath Govindraju wrote:
> The J721S2 SoC belongs to the K3 Multicore SoC architecture platform,
> providing advanced system integration in automotive ADAS applications and
> industrial applications requiring AI at the network edge. This SoC extends
> the Jacinto 7 family of SoCs with focus on lowering system costs and power
> while providing interfaces, memory architecture and compute performance for
> single and multi-sensor applications.
> 
> Some highlights of this SoC are:
> 
> * Dual Cortex-A72s in a single cluster, three clusters of lockstep capable
> dual Cortex-R5F MCUs, Deep-learning Matrix Multiply Accelerator(MMA), C7x
> floating point Vector DSP.
> * 3D GPU: Automotive grade IMG BXS-4-64
> * Vision Processing Accelerator (VPAC) with image signal processor and
> Depth and Motion Processing Accelerator (DMPAC)
> * Two CSI2.0 4L RX plus one eDP/DP, two DSI Tx, and one DPI interface.
> * Two Ethernet ports with RGMII support.
> * Single 4 lane PCIe-GEN3 controllers, USB3.0 Dual-role device subsystems,
> * Up to 20 MCANs, 5 McASP, eMMC and SD, OSPI/HyperBus memory controller,
> QSPI, I3C and I2C, eCAP/eQEP, eHRPWM, MLB among other peripherals.
> * Hardware accelerator blocks containing AES/DES/SHA/MD5 called SA2UL
> management.
> * Chips and Media Wave521CL H.264/H.265 encode/decode engine
> 
> See J721S2 Technical Reference Manual (SPRUJ28 – NOVEMBER 2021)
> for further details: http://www.ti.com/lit/pdf/spruj28
> 
> Introduce basic support for the J721S2 SoC.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 941 ++++++++++++++++++
>  .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 302 ++++++
>  arch/arm64/boot/dts/ti/k3-j721s2.dtsi         | 189 ++++
>  3 files changed, 1432 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2.dtsi
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> new file mode 100644
> index 000000000000..4fb629f1ec77
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -0,0 +1,941 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for J721S2 SoC Family Main Domain peripherals
> + *
> + * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#include <dt-bindings/mux/mux.h>
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/mux/ti-serdes.h>

I don't see this being used right now. Better to add it when it's actually used.

Thanks
Kishon

> +
> +&cbass_main {
> +	msmc_ram: sram@70000000 {
> +		compatible = "mmio-sram";
> +		reg = <0x0 0x70000000 0x0 0x400000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0x70000000 0x400000>;
> +
> +		atf-sram@0 {
> +			reg = <0x0 0x20000>;
> +		};
> +
> +		tifs-sram@1f0000 {
> +			reg = <0x1f0000 0x10000>;
> +		};
> +
> +		l3cache-sram@200000 {
> +			reg = <0x200000 0x200000>;
> +		};
> +	};

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F9046BA2D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 12:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbhLGLlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 06:41:11 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52342 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhLGLlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 06:41:10 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B7BbM5i035913;
        Tue, 7 Dec 2021 05:37:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638877042;
        bh=lsPU1sVuM9YQc8e1ZuZsItTT3uiO0gxI5yOh88zpvGA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hOIFvibEoFzrWm238T1w03PDbY1hPLs0JhUv5BZFY1SxPJVZy0lUl4ET4ubWtDe+a
         WWhAEto+wGPyLixlBZSFBssP2HC5FFMEbEbStzfMalnLtxnLOCsycZclrOJITcVzdd
         wG5q47XiGSYvOY/z8QjC6vwM2CfUwfYJgZ3CaUoM=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B7BbLiu033261
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Dec 2021 05:37:22 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Dec 2021 05:37:21 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Dec 2021 05:37:21 -0600
Received: from [10.250.232.32] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B7BbGY4029453;
        Tue, 7 Dec 2021 05:37:17 -0600
Subject: Re: [PATCH v5 1/6] arm64: dts: ti: k3-am65-mcu: Add Support for MCAN
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
 <20211122134159.29936-2-a-govindraju@ti.com>
From:   Apurva Nandan <a-nandan@ti.com>
Message-ID: <d48d949c-6212-3b90-3c85-4176be9f2bbd@ti.com>
Date:   Tue, 7 Dec 2021 17:07:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122134159.29936-2-a-govindraju@ti.com>
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
> Add Support for two MCAN controllers present on the am65x SOC. Both support
> classic CAN messages as well as CAN-FD.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Reviewed-by: Apurva Nandan <a-nandan@ti.com>

> ---
>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi | 30 +++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index c93ff1520a0e..8d592bf41d6f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -159,6 +159,36 @@
>   		};
>   	};
>   
> +	m_can0: mcan@40528000 {
> +		compatible = "bosch,m_can";
> +		reg = <0x0 0x40528000 0x0 0x400>,
> +		      <0x0 0x40500000 0x0 0x4400>;
> +		reg-names = "m_can", "message_ram";
> +		power-domains = <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 102 5>, <&k3_clks 102 0>;
> +		clock-names = "hclk", "cclk";
> +		interrupt-parent = <&gic500>;
> +		interrupts = <GIC_SPI 544 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 545 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "int0", "int1";
> +		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> +	};
> +
> +	m_can1: mcan@40568000 {
> +		compatible = "bosch,m_can";
> +		reg = <0x0 0x40568000 0x0 0x400>,
> +		      <0x0 0x40540000 0x0 0x4400>;
> +		reg-names = "m_can", "message_ram";
> +		power-domains = <&k3_pds 103 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 103 5>, <&k3_clks 103 0>;
> +		clock-names = "hclk", "cclk";
> +		interrupt-parent = <&gic500>;
> +		interrupts = <GIC_SPI 547 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 548 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "int0", "int1";
> +		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> +	};
> +
>   	fss: fss@47000000 {
>   		compatible = "simple-bus";
>   		#address-cells = <2>;

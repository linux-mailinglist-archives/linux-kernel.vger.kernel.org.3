Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E5A46BC59
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbhLGNYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:24:11 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36590 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbhLGNYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:24:10 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B7DKW5b025373;
        Tue, 7 Dec 2021 07:20:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638883232;
        bh=Bi898T9x8J49r3ACM+xVfh8daK3ybA5GEBdVLFFDfk4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jj9sk792O2w9givkalEtPXbelAy+UT+H7Cp76Ho6outiQ1TTUHT4tcIATkZWNdxxq
         /gdbblzg40iCAaGGTqvm6tczHfTIEueM12aFNLBD3IkwNqPaGxT/diPNEf6ueAf398
         atwLUEwdpfVkPdmwusVOp3of/X6dOceGdgXK9OyU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B7DKWn6004689
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Dec 2021 07:20:32 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Dec 2021 07:20:32 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Dec 2021 07:20:32 -0600
Received: from [10.250.232.32] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B7DKPGf112183;
        Tue, 7 Dec 2021 07:20:26 -0600
Subject: Re: [PATCH v5 3/6] arm64: dts: ti: k3-j721e: Add support for MCAN
 nodes
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
 <20211122134159.29936-4-a-govindraju@ti.com>
From:   Apurva Nandan <a-nandan@ti.com>
Message-ID: <3b8c234c-b5b5-57c9-bbb0-ad678b83b08d@ti.com>
Date:   Tue, 7 Dec 2021 18:50:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122134159.29936-4-a-govindraju@ti.com>
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
> Add support for 14 MCAN controllers in main domain and 2 MCAN controllers
> present in mcu domain. All the MCAN controllers support classic CAN
> messages as well as CAN_FD messages.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Reviewed-by: Apurva Nandan <a-nandan@ti.com>

> ---
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 196 ++++++++++++++++++
>   .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  28 +++
>   2 files changed, 224 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 08c8d1b47dcd..08a30c21e6b7 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -1940,4 +1940,200 @@
>   			bus_freq = <1000000>;
>   		};
>   	};
> +
> +	main_mcan0: can@2701000 {
> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x02701000 0x00 0x200>,
> +		      <0x00 0x02708000 0x00 0x8000>;
> +		reg-names = "m_can", "message_ram";
> +		power-domains = <&k3_pds 156 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 156 0>, <&k3_clks 156 1>;
> +		clock-names = "hclk", "cclk";
> +		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "int0", "int1";
> +		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> +	};
> +
> +	main_mcan1: can@2711000 {
> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x02711000 0x00 0x200>,
> +		      <0x00 0x02718000 0x00 0x8000>;
> +		reg-names = "m_can", "message_ram";
> +		power-domains = <&k3_pds 158 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 158 0>, <&k3_clks 158 1>;
> +		clock-names = "hclk", "cclk";
> +		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "int0", "int1";
> +		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> +	};
> +
> +	main_mcan2: can@2721000 {
> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x02721000 0x00 0x200>,
> +		      <0x00 0x02728000 0x00 0x8000>;
> +		reg-names = "m_can", "message_ram";
> +		power-domains = <&k3_pds 160 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 160 0>, <&k3_clks 160 1>;
> +		clock-names = "hclk", "cclk";
> +		interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "int0", "int1";
> +		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> +	};
> +
> +	main_mcan3: can@2731000 {
> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x02731000 0x00 0x200>,
> +		      <0x00 0x02738000 0x00 0x8000>;
> +		reg-names = "m_can", "message_ram";
> +		power-domains = <&k3_pds 161 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 161 0>, <&k3_clks 161 1>;
> +		clock-names = "hclk", "cclk";
> +		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "int0", "int1";
> +		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> +	};
> +
> +	main_mcan4: can@2741000 {
> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x02741000 0x00 0x200>,
> +		      <0x00 0x02748000 0x00 0x8000>;
> +		reg-names = "m_can", "message_ram";
> +		power-domains = <&k3_pds 162 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 162 0>, <&k3_clks 162 1>;
> +		clock-names = "hclk", "cclk";
> +		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "int0", "int1";
> +		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> +	};
> +
> +	main_mcan5: can@2751000 {
> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x02751000 0x00 0x200>,
> +		      <0x00 0x02758000 0x00 0x8000>;
> +		reg-names = "m_can", "message_ram";
> +		power-domains = <&k3_pds 163 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 163 0>, <&k3_clks 163 1>;
> +		clock-names = "hclk", "cclk";
> +		interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "int0", "int1";
> +		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> +	};
> +
> +	main_mcan6: can@2761000 {
> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x02761000 0x00 0x200>,
> +		      <0x00 0x02768000 0x00 0x8000>;
> +		reg-names = "m_can", "message_ram";
> +		power-domains = <&k3_pds 164 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 164 0>, <&k3_clks 164 1>;
> +		clock-names = "hclk", "cclk";
> +		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "int0", "int1";
> +		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> +	};
> +
> +	main_mcan7: can@2771000 {
> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x02771000 0x00 0x200>,
> +		      <0x00 0x02778000 0x00 0x8000>;
> +		reg-names = "m_can", "message_ram";
> +		power-domains = <&k3_pds 165 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 165 0>, <&k3_clks 165 1>;
> +		clock-names = "hclk", "cclk";
> +		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "int0", "int1";
> +		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> +	};
> +
> +	main_mcan8: can@2781000 {
> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x02781000 0x00 0x200>,
> +		      <0x00 0x02788000 0x00 0x8000>;
> +		reg-names = "m_can", "message_ram";
> +		power-domains = <&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 166 0>, <&k3_clks 166 1>;
> +		clock-names = "hclk", "cclk";
> +		interrupts = <GIC_SPI 576 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "int0", "int1";
> +		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> +	};
> +
> +	main_mcan9: can@2791000 {
> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x02791000 0x00 0x200>,
> +		      <0x00 0x02798000 0x00 0x8000>;
> +		reg-names = "m_can", "message_ram";
> +		power-domains = <&k3_pds 167 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 167 0>, <&k3_clks 167 1>;
> +		clock-names = "hclk", "cclk";
> +		interrupts = <GIC_SPI 579 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "int0", "int1";
> +		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> +	};
> +
> +	main_mcan10: can@27a1000 {
> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x027a1000 0x00 0x200>,
> +		      <0x00 0x027a8000 0x00 0x8000>;
> +		reg-names = "m_can", "message_ram";
> +		power-domains = <&k3_pds 168 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 168 0>, <&k3_clks 168 1>;
> +		clock-names = "hclk", "cclk";
> +		interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "int0", "int1";
> +		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> +	};
> +
> +	main_mcan11: can@27b1000 {
> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x027b1000 0x00 0x200>,
> +		      <0x00 0x027b8000 0x00 0x8000>;
> +		reg-names = "m_can", "message_ram";
> +		power-domains = <&k3_pds 169 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 169 0>, <&k3_clks 169 1>;
> +		clock-names = "hclk", "cclk";
> +		interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "int0", "int1";
> +		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> +	};
> +
> +	main_mcan12: can@27c1000 {
> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x027c1000 0x00 0x200>,
> +		      <0x00 0x027c8000 0x00 0x8000>;
> +		reg-names = "m_can", "message_ram";
> +		power-domains = <&k3_pds 170 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 170 0>, <&k3_clks 170 1>;
> +		clock-names = "hclk", "cclk";
> +		interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "int0", "int1";
> +		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> +	};
> +
> +	main_mcan13: can@27d1000 {
> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x027d1000 0x00 0x200>,
> +		      <0x00 0x027d8000 0x00 0x8000>;
> +		reg-names = "m_can", "message_ram";
> +		power-domains = <&k3_pds 171 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 171 0>, <&k3_clks 171 1>;
> +		clock-names = "hclk", "cclk";
> +		interrupts = <GIC_SPI 591 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "int0", "int1";
> +		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> +	};
>   };
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index d2dceda72fe9..b4972dfb7da8 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -390,4 +390,32 @@
>   			ti,loczrama = <1>;
>   		};
>   	};
> +
> +	mcu_mcan0: can@40528000 {
> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x40528000 0x00 0x200>,
> +		      <0x00 0x40500000 0x00 0x8000>;
> +		reg-names = "m_can", "message_ram";
> +		power-domains = <&k3_pds 172 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 172 0>, <&k3_clks 172 1>;
> +		clock-names = "hclk", "cclk";
> +		interrupts = <GIC_SPI 832 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "int0", "int1";
> +		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> +	};
> +
> +	mcu_mcan1: can@40568000 {
> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x40568000 0x00 0x200>,
> +		      <0x00 0x40540000 0x00 0x8000>;
> +		reg-names = "m_can", "message_ram";
> +		power-domains = <&k3_pds 173 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 173 0>, <&k3_clks 173 1>;
> +		clock-names = "hclk", "cclk";
> +		interrupts = <GIC_SPI 835 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "int0", "int1";
> +		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> +	};
>   };

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D4446BC5D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbhLGNZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:25:04 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36662 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbhLGNZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:25:02 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B7DLQdU025477;
        Tue, 7 Dec 2021 07:21:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638883286;
        bh=9Hn5CJiHBzJ9m6vKnIKivt/HehDv3M4/X9erS7nCy3E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=K7AK5cVw8E2iPPwaMLacgyHZ69YjdYqGZ7z3V7tW4wHXHz8D8uWZ106eVhNQvyTil
         pafDp2nuojJdIeI5UPfHNRmApFHGHc1wA0wdDqXsL0+Q/JjzQiJJtEqzGNpx+NG6SV
         gxQsfcu8dMt0D79s6+9KBN4oVZPZHoQR4QXIP9hU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B7DLQ4C029552
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Dec 2021 07:21:26 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Dec 2021 07:21:26 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Dec 2021 07:21:26 -0600
Received: from [10.250.232.32] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B7DLLGl081317;
        Tue, 7 Dec 2021 07:21:22 -0600
Subject: Re: [PATCH v5 5/6] arm64: dts: ti: k3-am64-main: Add support for MCAN
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211122134159.29936-1-a-govindraju@ti.com>
 <20211122134159.29936-6-a-govindraju@ti.com>
From:   Apurva Nandan <a-nandan@ti.com>
Message-ID: <18676baa-175d-06db-159c-4a7e5cdd263e@ti.com>
Date:   Tue, 7 Dec 2021 18:51:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122134159.29936-6-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/11/21 7:11 pm, Aswath Govindraju wrote:
> Add Support for two MCAN controllers present on the am64x SOC. Both support
> classic CAN messages as well as CAN-FD.
>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Reviewed-by: Apurva Nandan <a-nandan@ti.com>

> ---
>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 28 ++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index 5ad638b95ffc..07cadbfcc436 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -1253,4 +1253,32 @@
>   			bus_freq = <1000000>;
>   		};
>   	};
> +
> +	main_mcan0: can@20701000 {
> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x20701000 0x00 0x200>,
> +		      <0x00 0x20708000 0x00 0x8000>;
> +		reg-names = "m_can", "message_ram";
> +		power-domains = <&k3_pds 98 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 98 5>, <&k3_clks 98 0>;
> +		clock-names = "hclk", "cclk";
> +		interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "int0", "int1";
> +		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> +	};
> +
> +	main_mcan1: can@20711000 {
> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x20711000 0x00 0x200>,
> +		      <0x00 0x20718000 0x00 0x8000>;
> +		reg-names = "m_can", "message_ram";
> +		power-domains = <&k3_pds 99 TI_SCI_PD_EXCLUSIVE>;
> +		clocks =  <&k3_clks 99 5>, <&k3_clks 99 0>;
> +		clock-names = "hclk", "cclk";
> +		interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "int0", "int1";
> +		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> +	};
>   };

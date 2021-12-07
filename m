Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF8546BC61
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbhLGNZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:25:44 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36752 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbhLGNZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:25:43 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B7DM4Qp025597;
        Tue, 7 Dec 2021 07:22:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638883324;
        bh=Y13dIz8fRS90BB0Qx0GHpyyvSDR6Omd/XlEd+z3yN2s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JfnVk+tXJGIjXAcUwprl2dh04guk1qfrS0KnT7uZNtRkxh/5ZxrLljLJWPqooH9aa
         tcKWnLEHdwVMxsc0Oubkcu+Ny0l8LQu1mjuNt2IXPkcMkDhtsf+OVivM9SkqrJxdLM
         YO28+0Yi331rx1o/9GEC4IJdABYYUawr1bk/sIcw=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B7DM4Ht006775
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Dec 2021 07:22:04 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Dec 2021 07:22:04 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Dec 2021 07:22:04 -0600
Received: from [10.250.232.32] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B7DLxgj089634;
        Tue, 7 Dec 2021 07:22:00 -0600
Subject: Re: [PATCH v5 6/6] arm64: dts: ti: k3-am642-evm/sk: Add support for
 main domain mcan nodes in EVM and disable them on SK
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
 <20211122134159.29936-7-a-govindraju@ti.com>
From:   Apurva Nandan <a-nandan@ti.com>
Message-ID: <e789b13a-fac9-b9a7-d649-0e9c0551e64e@ti.com>
Date:   Tue, 7 Dec 2021 18:51:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122134159.29936-7-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/11/21 7:11 pm, Aswath Govindraju wrote:
> AM642 EVM has two CAN connecters brought out from the two MCAN instances in
> the main domain through transceivers. Add device tree nodes for
> transceivers and set the required properties in the mcan device tree nodes,
> in EVM device tree file.
>
> On AM642 SK there are no connectors brought out for CAN. Therefore, disable
> the mcan device tree nodes in the SK device tree file.
>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Reviewed-by: Apurva Nandan <a-nandan@ti.com>

> ---
>   arch/arm64/boot/dts/ti/k3-am642-evm.dts | 40 +++++++++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-am642-sk.dts  |  8 +++++
>   2 files changed, 48 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> index 6726c4c7c28c..e94ae178b1ae 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> @@ -184,6 +184,20 @@
>   			};
>   		};
>   	};
> +
> +	transceiver1: can-phy0 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		standby-gpios = <&exp1 8 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	transceiver2: can-phy1 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		standby-gpios = <&exp1 9 GPIO_ACTIVE_HIGH>;
> +	};
>   };
>   
>   &main_pmx0 {
> @@ -294,6 +308,20 @@
>   			AM64X_IOPAD(0x0270, PIN_INPUT, 0) /* (D18) ECAP0_IN_APWM_OUT */
>   		>;
>   	};
> +
> +	main_mcan0_pins_default: main-mcan0-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0254, PIN_INPUT, 0) /* (B17) MCAN0_RX */
> +			AM64X_IOPAD(0x0250, PIN_OUTPUT, 0) /* (A17) MCAN0_TX */
> +		>;
> +	};
> +
> +	main_mcan1_pins_default: main-mcan1-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x025c, PIN_INPUT, 0) /* (D17) MCAN1_RX */
> +			AM64X_IOPAD(0x0258, PIN_OUTPUT, 0) /* (C17) MCAN1_TX */
> +		>;
> +	};
>   };
>   
>   &main_uart0 {
> @@ -638,3 +666,15 @@
>   &icssg1_mdio {
>   	status = "disabled";
>   };
> +
> +&main_mcan0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan0_pins_default>;
> +	phys = <&transceiver1>;
> +};
> +
> +&main_mcan1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan1_pins_default>;
> +	phys = <&transceiver2>;
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> index 6b04745147be..a9785bec12df 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> @@ -525,3 +525,11 @@
>   &icssg1_mdio {
>   	status = "disabled";
>   };
> +
> +&main_mcan0 {
> +	status = "disabled";
> +};
> +
> +&main_mcan1 {
> +	status = "disabled";
> +};

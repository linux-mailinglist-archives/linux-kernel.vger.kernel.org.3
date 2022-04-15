Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DC9502636
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 09:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344505AbiDOHaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 03:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiDOHaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 03:30:21 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C85B820D;
        Fri, 15 Apr 2022 00:27:53 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23F7RcJ2084228;
        Fri, 15 Apr 2022 02:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650007658;
        bh=1pt76OqGQ1KESH8qfZrkyPQA2fls5pZ2tmqcFMhpEw4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=inC9EeyeGlHt63x/U4RRoW6p33oq8qLFmNROXqoRfudSRLu9Q3L/duDLP6EWh0XTZ
         62kYkXYJ2X7uyqOl9s01Hl26jqAoRHJCTJSOs3xyyO/XV1Xmab6OoV3W8vmIjfeKss
         D4R1K21tWZO4wX6YZgUtXbEL/1ByIE2E2XvUi5KE=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23F7Rcjo103431
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Apr 2022 02:27:38 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 15
 Apr 2022 02:27:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 15 Apr 2022 02:27:37 -0500
Received: from [10.250.235.115] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23F7RX8i124667;
        Fri, 15 Apr 2022 02:27:34 -0500
Message-ID: <758ce7b9-a164-51b7-a64e-fb8df9f7d282@ti.com>
Date:   Fri, 15 Apr 2022 12:57:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 1/2] arm64: dts: ti: k3-j721e-main: add DP & DP PHY
Content-Language: en-US
To:     Rahul T R <r-ravikumar@ti.com>, <nm@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>
References: <20220406165852.13026-1-r-ravikumar@ti.com>
 <20220406165852.13026-2-r-ravikumar@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220406165852.13026-2-r-ravikumar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/04/22 10:28 pm, Rahul T R wrote:
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> Add DT nodes for DisplayPort and DisplayPort PHY. The DP is Cadence MHDP
> 8546 and the PHY is a Cadence Torrent PHY with TI WIZ wrapper.
> 
> A slight irregularity in the bindings is the DPTX PHY register block,
> which is in the MHDP IP, but is needed and mapped by the PHY.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 65 +++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index db0669985e42..11426c25a09d 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2016-2020 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  #include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/phy/phy-ti.h>
>  #include <dt-bindings/mux/mux.h>
>  #include <dt-bindings/mux/ti-serdes.h>
>  
> @@ -789,6 +790,47 @@
>  		#size-cells = <2>;
>  	};
>  
> +	serdes_wiz4: wiz@5050000 {
> +		compatible = "ti,am64-wiz-10g";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		power-domains = <&k3_pds 297 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 297 1>, <&k3_clks 297 9>, <&cmn_refclk>;
> +		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
> +		assigned-clocks = <&k3_clks 297 9>;
> +		assigned-clock-parents = <&k3_clks 297 10>;
> +		assigned-clock-rates = <19200000>;
> +		num-lanes = <4>;
> +		#reset-cells = <1>;
> +		#clock-cells = <1>;
> +		ranges = <0x5050000 0x0 0x5050000 0x10000>,
> +			<0xa030a00 0x0 0xa030a00 0x40>;

Add leading 0s to align to 8 digit value like rest of the file:

		ranges = <0x05050000 0x00 0x05050000 0x10000>,
			<0x0a030a00 0x00 0x0a030a00 0x40>;


> +
> +		serdes4: serdes@5050000 {
> +			/*
> +			 * Note: we also map DPTX PHY registers as the Torrent
> +			 * needs to manage those.
> +			 */
> +			compatible = "ti,j721e-serdes-10g";
> +			reg = <0x5050000 0x10000>,
> +			      <0xa030a00 0x40>; /* DPTX PHY */

Same here.

> +			reg-names = "torrent_phy", "dptx_phy";
> +
> +			resets = <&serdes_wiz4 0>;
> +			reset-names = "torrent_reset";
> +			clocks = <&serdes_wiz4 TI_WIZ_PLL0_REFCLK>;
> +			clock-names = "refclk";
> +			assigned-clocks = <&serdes_wiz4 TI_WIZ_PLL0_REFCLK>,
> +					  <&serdes_wiz4 TI_WIZ_PLL1_REFCLK>,
> +					  <&serdes_wiz4 TI_WIZ_REFCLK_DIG>;
> +			assigned-clock-parents = <&k3_clks 297 9>,
> +						 <&k3_clks 297 9>,
> +						 <&k3_clks 297 9>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +
>  	main_uart0: serial@2800000 {
>  		compatible = "ti,j721e-uart", "ti,am654-uart";
>  		reg = <0x00 0x02800000 0x00 0x100>;
> @@ -1267,6 +1309,29 @@
>  		};
>  	};
>  
> +	mhdp: dp-bridge@a000000 {
> +		compatible = "ti,j721e-mhdp8546";
> +		/*
> +		 * Note: we do not map DPTX PHY area, as that is handled by
> +		 * the PHY driver.
> +		 */
> +		reg = <0x0 0xa000000 0x0 0x30a00>, /* DSS_EDP0_V2A_CORE_VP_REGS_APB */
> +		      <0x0 0x4f40000 0x0 0x20>;    /* DSS_EDP0_INTG_CFG_VP */

Please use 0x00 as rest of the file like:

	 reg = <0x00 0x0a000000 0x00 0x30a00>,
		<0x00 0x04f40000 0x00 0x20>;

> +		reg-names = "mhdptx", "j721e-intg";
> +
> +		clocks = <&k3_clks 151 36>;
> +
> +		interrupt-parent = <&gic500>;
> +		interrupts = <GIC_SPI 614 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		power-domains = <&k3_pds 151 TI_SCI_PD_EXCLUSIVE>;
> +
> +		dp0_ports: ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +
>  	dss: dss@4a00000 {
>  		compatible = "ti,j721e-dss";
>  		reg =

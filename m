Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5315A9256
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiIAIpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiIAIpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:45:41 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B9880495;
        Thu,  1 Sep 2022 01:45:37 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2818jV2b068892;
        Thu, 1 Sep 2022 03:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662021931;
        bh=rYJIONg+SpsbjwLdW3SdWXOOkx45HaZcz//qkzU7Uvw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=TAS3Z2RuC2ZV4EDWdcqFcH5ZUmBvlQ8HIEjgDjKNMX0kalSV2CMn786WOQjO7k6MS
         DckWACWvT3WEq7E+/u39Uad4esbPWIQb0gqperM9u8ju4goxP86nSOFjhdusEz/reN
         a0xMaYFpHyLKHCPC7ZY+aG1P79qScEnQudlC4lAY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2818jVHg113417
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Sep 2022 03:45:31 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 1 Sep
 2022 03:45:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 1 Sep 2022 03:45:31 -0500
Received: from [172.24.145.182] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2818jTQw005036;
        Thu, 1 Sep 2022 03:45:29 -0500
Message-ID: <8c130e92-9970-54d3-d263-37ae2f722b34@ti.com>
Date:   Thu, 1 Sep 2022 14:15:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH RESEND 2/6] arm64: dts: ti: k3-j721s2-main: Add SERDES and
 WIZ device tree node
Content-Language: en-US
To:     Matt Ranostay <mranostay@ti.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>
References: <20220810094000.248487-1-mranostay@ti.com>
 <20220810094000.248487-2-mranostay@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220810094000.248487-2-mranostay@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/08/22 15:09, Matt Ranostay wrote:
> From: Aswath Govindraju <a-govindraju@ti.com>
> 
> Add dt node for the single instance of WIZ (SERDES wrapper) and
> SERDES module shared by PCIe, eDP and USB.
> 
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Acked-by: Matt Ranostay <mranostay@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index f7e359da8690..f1e02d896168 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -5,6 +5,13 @@
>   * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
> +/ {
> +	serdes_refclk: serdes-refclk {

clk-X

> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +	};
> +};
> +
>  &cbass_main {
>  	msmc_ram: sram@70000000 {
>  		compatible = "mmio-sram";
> @@ -33,6 +40,13 @@ scm_conf: scm-conf@104000 {
>  		#size-cells = <1>;
>  		ranges = <0x00 0x00 0x00104000 0x18000>;
>  
> +		serdes_ln_ctrl: mux-controller@80 {

mux-controller-X

> +			compatible = "mmio-mux";
> +			#mux-control-cells = <1>;
> +			mux-reg-masks = <0x80 0x3>, <0x84 0x3>, /* SERDES0 lane0/1 select */
> +					<0x88 0x3>, <0x8c 0x3>; /* SERDES0 lane2/3 select */
> +		};
> +
>  		usb_serdes_mux: mux-controller@0 {
>  			compatible = "mmio-mux";
>  			#mux-control-cells = <1>;
> @@ -728,6 +742,62 @@ usb0: usb@6000000 {
>  		};
>  	};
>  
> +	serdes_wiz0: wiz@5060000 {
> +		compatible = "ti,j721e-wiz-10g";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		power-domains = <&k3_pds 365 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 365 0>, <&k3_clks 365 3>, <&serdes_refclk>;
> +		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
> +		num-lanes = <4>;
> +		#reset-cells = <1>;
> +		ranges = <0x5060000 0x0 0x5060000 0x10000>;
> +
> +		assigned-clocks = <&k3_clks 365 3>;
> +		assigned-clock-parents = <&k3_clks 365 7>;
> +
> +		wiz0_pll0_refclk: pll0-refclk {

please use generic node name clk-X here and elsewhere in the patch

> +			clocks = <&k3_clks 365 3>, <&serdes_refclk>;
> +			clock-output-names = "wiz0_pll0_refclk";
> +			#clock-cells = <0>;
> +			assigned-clocks = <&wiz0_pll0_refclk>;
> +			assigned-clock-parents = <&k3_clks 365 3>;
> +		};
> +
> +		wiz0_pll1_refclk: pll1-refclk {

ditto

> +			clocks = <&k3_clks 365 3>, <&serdes_refclk>;
> +			clock-output-names = "wiz0_pll1_refclk";
> +			#clock-cells = <0>;
> +			assigned-clocks = <&wiz0_pll1_refclk>;
> +			assigned-clock-parents = <&k3_clks 365 3>;
> +		};
> +
> +		wiz0_refclk_dig: refclk-dig {

ditto

> +			clocks = <&k3_clks 365 3>, <&serdes_refclk>;
> +			clock-output-names = "wiz0_refclk_dig";
> +			#clock-cells = <0>;
> +			assigned-clocks = <&wiz0_refclk_dig>;
> +			assigned-clock-parents = <&k3_clks 365 3>;
> +		};
> +
> +		wiz0_cmn_refclk_dig_div: cmn-refclk-dig-div {

ditto

> +			clocks = <&wiz0_refclk_dig>;
> +			#clock-cells = <0>;
> +		};
> +
> +		serdes0: serdes@5060000 {
> +			compatible = "ti,j721e-serdes-10g";
> +			reg = <0x05060000 0x00010000>;
> +			reg-names = "torrent_phy";
> +			resets = <&serdes_wiz0 0>;
> +			reset-names = "torrent_reset";
> +			clocks = <&wiz0_pll0_refclk>;
> +			clock-names = "refclk";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +
>  	main_mcan0: can@2701000 {
>  		compatible = "bosch,m_can";
>  		reg = <0x00 0x02701000 0x00 0x200>,

-- 
Regards
Vignesh

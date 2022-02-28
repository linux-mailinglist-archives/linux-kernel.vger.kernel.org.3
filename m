Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9904C6218
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 05:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiB1ES2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 23:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiB1ESZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 23:18:25 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2A7634F;
        Sun, 27 Feb 2022 20:17:45 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21S4HMdF052560;
        Sun, 27 Feb 2022 22:17:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1646021842;
        bh=8NMNXB+7+semqQ7A6IE5+jq3KDZ/GffTyTegLBMYjDY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CxTuj5ECjRvlYoz0Bwlf2m59tLn1JxM6YPqsi9Kp0yXZ8Q+J7Bi0+flMNZQdiztV+
         6xeSC4sXLDY5/ykezCqDUasFWMbP/MMmYYjhSCiXOWn1f/YgkI04fHB7QgT6iZ695K
         IAekBSNy7HHiejCWm+ORxsVxByduLSCf33J3RIbQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21S4HMdr090287
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 27 Feb 2022 22:17:22 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sun, 27
 Feb 2022 22:17:22 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sun, 27 Feb 2022 22:17:21 -0600
Received: from [10.250.232.174] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21S4HHdP107752;
        Sun, 27 Feb 2022 22:17:18 -0600
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-j721e-main: add DP & DP PHY
To:     Rahul T R <r-ravikumar@ti.com>, <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>
References: <20220222163230.1566-1-r-ravikumar@ti.com>
 <20220222163230.1566-2-r-ravikumar@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <069c1751-41a9-e47c-96d7-8ed83e1fe3f9@ti.com>
Date:   Mon, 28 Feb 2022 09:47:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20220222163230.1566-2-r-ravikumar@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rahul,

On 22/02/22 10:02 pm, Rahul T R wrote:
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
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 102 ++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 599861259a30..9e2b212100bb 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -786,6 +786,82 @@
>  		#size-cells = <2>;
>  	};
>  
> +	serdes_wiz4: wiz@5050000 {
> +		compatible = "ti,j721e-wiz-10g";
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
> +		ranges = <0x5050000 0x0 0x5050000 0x10000>,
> +			<0xa030a00 0x0 0xa030a00 0x40>;
> +
> +		wiz4_pll0_refclk: pll0-refclk {
> +			clocks = <&k3_clks 297 9>, <&cmn_refclk>;
> +			clock-output-names = "wiz4_pll0_refclk";
> +			#clock-cells = <0>;
> +			assigned-clocks = <&wiz4_pll0_refclk>;
> +			assigned-clock-parents = <&k3_clks 297 9>;
> +		};
> +
> +		wiz4_pll1_refclk: pll1-refclk {
> +			clocks = <&k3_clks 297 9>, <&cmn_refclk>;
> +			clock-output-names = "wiz4_pll1_refclk";
> +			#clock-cells = <0>;
> +			assigned-clocks = <&wiz4_pll1_refclk>;
> +			assigned-clock-parents = <&k3_clks 297 9>;
> +		};
> +
> +		wiz4_refclk_dig: refclk-dig {
> +			clocks = <&k3_clks 297 9>, <&cmn_refclk>;
> +			clock-output-names = "wiz4_refclk_dig";
> +			#clock-cells = <0>;
> +			assigned-clocks = <&wiz4_refclk_dig>;
> +			assigned-clock-parents = <&k3_clks 297 9>;
> +		};
> +
> +		wiz4_cmn_refclk_dig_div: cmn-refclk-dig-div {
> +			clocks = <&wiz4_refclk_dig>;
> +			#clock-cells = <0>;
> +		};
> +
> +		wiz4_cmn_refclk1_dig_div: cmn-refclk1-dig-div {
> +			clocks = <&wiz4_pll1_refclk>;
> +			#clock-cells = <0>;
> +		};

I'd prefer we deprecate creating clock sub-nodes for new platform additions and
use a similar approach as that used for AM64 (use phandle with a parameter to
refer clocks). Please refer how this was created for AM64
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-am64-main.dtsi#n795

Since this is the same SERDES IP as used in AM64, you should be able to use the
same DT binding as that used in AM64. But if you'd like to adapt
"ti,j721e-wiz-10g" to use phandle with parameter in the WIZ driver (while making
sure the existing sub-node based binding is not broken), that is highly welcomed.

> +
> +		serdes4: serdes@5050000 {
> +			/*
> +			 * Note: we also map DPTX PHY registers as the Torrent
> +			 * needs to manage those.
> +			 */
> +			compatible = "ti,j721e-serdes-10g";
> +			reg = <0x5050000 0x10000>,
> +			      <0xa030a00 0x40>; /* DPTX PHY */
> +			reg-names = "torrent_phy", "dptx_phy";
> +
> +			resets = <&serdes_wiz4 0>;
> +			reset-names = "torrent_reset";
> +			clocks = <&wiz4_pll0_refclk>;
> +			clock-names = "refclk";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			torrent_phy_dp: phy@0 {
> +				reg = <0>;
> +				resets = <&serdes_wiz4 1>;
> +				cdns,phy-type = <PHY_TYPE_DP>;
> +				cdns,num-lanes = <4>;
> +				cdns,max-bit-rate = <5400>;
> +				#phy-cells = <0>;
> +			};

The link sub-nodes should be in the board DTS file.

Thanks,
Kishon

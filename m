Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2E25A924A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbiIAIne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbiIAIn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:43:29 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3569B130637;
        Thu,  1 Sep 2022 01:43:28 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2818hNkL062735;
        Thu, 1 Sep 2022 03:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662021803;
        bh=hupE8mezdV0pS1EwTZfUATinSVzLqJp2B2HtBetZ2Uo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=K0bz4JdZskSOyKhfmytsemIjEQ12T+FfafLQfvGeLnsyKRsdM0rdHsybvfEdefNyl
         h4eEwXvfnMN0UxkSU9ol3JAJDBt0l6wt4pV3jLsoG3ycCHfg0tzZgS5Mf8xssNHBRq
         L4JXE3VnNooiMwWB6SAt7cBU2i6MxGHP/HmENuXs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2818hNx3112027
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Sep 2022 03:43:23 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 1 Sep
 2022 03:43:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 1 Sep 2022 03:43:23 -0500
Received: from [172.24.145.182] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2818hKHm010763;
        Thu, 1 Sep 2022 03:43:21 -0500
Message-ID: <5cb7a059-a419-1271-c4d0-c5c546b85706@ti.com>
Date:   Thu, 1 Sep 2022 14:13:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH RESEND 1/6] arm64: dts: ti: k3-j721s2-main: Add support
 for USB
Content-Language: en-US
To:     Matt Ranostay <mranostay@ti.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>
References: <20220810094000.248487-1-mranostay@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220810094000.248487-1-mranostay@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On 10/08/22 15:09, Matt Ranostay wrote:
> From: Aswath Govindraju <a-govindraju@ti.com>
> 
> Add support for single instance of USB 3.0 controller in J721S2 SoC.
> 
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Acked-by: Matt Ranostay <mranostay@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index 34e7d577ae13..f7e359da8690 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -26,6 +26,20 @@ l3cache-sram@200000 {
>  		};
>  	};
>  
> +	scm_conf: scm-conf@104000 {

syscon@

> +		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
> +		reg = <0x00 0x00104000 0x00 0x18000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x00 0x00 0x00104000 0x18000>;
> +
> +		usb_serdes_mux: mux-controller@0 {

mux-controller-0

I see that the mux-controller@0 node gets renamed to mux-controller@1 in
2/6. Why not move both to 2/6?

> +			compatible = "mmio-mux";
> +			#mux-control-cells = <1>;
> +			mux-reg-masks = <0x0 0x8000000>; /* USB0 to SERDES0 lane 1/3 mux */
> +		};
> +	};
> +
>  	gic500: interrupt-controller@1800000 {
>  		compatible = "arm,gic-v3";
>  		#address-cells = <2>;
> @@ -686,6 +700,34 @@ cpts@310d0000 {
>  		};
>  	};
>  
> +	usbss0: cdns-usb@4104000 {
> +		compatible = "ti,j721e-usb";
> +		reg = <0x00 0x04104000 0x00 0x100>;
> +		clocks = <&k3_clks 360 16>, <&k3_clks 360 15>;
> +		clock-names = "ref", "lpm";
> +		assigned-clocks = <&k3_clks 360 16>; /* USB2_REFCLK */
> +		assigned-clock-parents = <&k3_clks 360 17>;
> +		power-domains = <&k3_pds 360 TI_SCI_PD_EXCLUSIVE>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		dma-coherent;
> +
> +		usb0: usb@6000000 {
> +			compatible = "cdns,usb3";
> +			reg = <0x00 0x06000000 0x00 0x10000>,
> +			      <0x00 0x06010000 0x00 0x10000>,
> +			      <0x00 0x06020000 0x00 0x10000>;
> +			reg-names = "otg", "xhci", "dev";
> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "host", "peripheral", "otg";
> +			maximum-speed = "super-speed";
> +			dr_mode = "otg";
> +		};
> +	};
> +
>  	main_mcan0: can@2701000 {
>  		compatible = "bosch,m_can";
>  		reg = <0x00 0x02701000 0x00 0x200>,

-- 
Regards
Vignesh

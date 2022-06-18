Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4481B55019C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 03:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383450AbiFRBQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 21:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbiFRBQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 21:16:10 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3D46B00C;
        Fri, 17 Jun 2022 18:16:09 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25I1G3qx059839;
        Fri, 17 Jun 2022 20:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655514963;
        bh=TZkUnQ9TqsqujcPhfiQHiNqNBtGu9PjA71C9siFtD5Q=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Qk0Vj/8plzhXTs7pDQgB/Bt2mMV6LL7peYHEMDGR+efGSHWC2xZrIk5MLxUVJpEH6
         JAwpz0BpPeaTGjHcKypKknIa7KoD9YZ6FrZ3ff0++eh/RqZiYSKTxDZdnhqwMqgGZ7
         qRXDM/ueM2CzHsJhsCypuSI1QjLpmyMvIGzxPwH0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25I1G31k020924
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jun 2022 20:16:03 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Jun 2022 20:16:02 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Jun 2022 20:16:02 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25I1G2vn061733;
        Fri, 17 Jun 2022 20:16:02 -0500
Date:   Fri, 17 Jun 2022 20:16:02 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jai Luthra <j-luthra@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>
Subject: Re: [PATCH v3 1/2] arm64: dts: ti: k3-am62-main: Add McASP nodes
Message-ID: <20220618011602.majukmcmrf4skzdn@kahuna>
References: <20220427085053.14964-1-j-luthra@ti.com>
 <20220427085053.14964-2-j-luthra@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220427085053.14964-2-j-luthra@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:20-20220427, Jai Luthra wrote:
> From: Jayesh Choudhary <j-choudhary@ti.com>
> 
> Add the nodes for McASP 0-2.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 51 ++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index eec8dae65e7c..942e00f34bfa 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -530,4 +530,55 @@
>  		ti,mbox-num-users = <4>;
>  		ti,mbox-num-fifos = <16>;
>  	};
> +
> +	mcasp0: mcasp@2b00000 {
> +		compatible = "ti,am33xx-mcasp-audio";
> +		reg = <0x00 0x02b00000 0x00 0x2000>,
> +		      <0x00 0x02b08000 0x00 0x400>;
> +		reg-names = "mpu","dat";
> +		interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "tx", "rx";
> +
> +		dmas = <&main_bcdma 0 0xc500 0>, <&main_bcdma 0 0x4500 0>;
> +		dma-names = "tx", "rx";
> +
> +		clocks = <&k3_clks 190 0>;
> +		clock-names = "fck";


McASP functional clock defaults to a non-audio friendly 100MHz
main_2_hsdivout8_clk clock source. Instead, switch to using a 96MHz
main_1_hsdivout6_clk.

Please add:
assigned-clocks = <&k3_clks 190 0>;
assigned-clock-parents = <&k3_clks 190 2>;


> +		power-domains = <&k3_pds 190 TI_SCI_PD_EXCLUSIVE>;
> +	};
> +
> +	mcasp1: mcasp@2b10000 {
> +		compatible = "ti,am33xx-mcasp-audio";
> +		reg = <0x00 0x02b10000 0x00 0x2000>,
> +		      <0x00 0x02b18000 0x00 0x400>;
> +		reg-names = "mpu","dat";
> +		interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "tx", "rx";
> +
> +		dmas = <&main_bcdma 0 0xc501 0>, <&main_bcdma 0 0x4501 0>;
> +		dma-names = "tx", "rx";
> +
> +		clocks = <&k3_clks 191 0>;
> +		clock-names = "fck";

assigned-clocks = <&k3_clks 191 0>;
assigned-clock-parents = <&k3_clks 191 2>;

> +		power-domains = <&k3_pds 191 TI_SCI_PD_EXCLUSIVE>;
> +	};
> +
> +	mcasp2: mcasp@2b20000 {
> +		compatible = "ti,am33xx-mcasp-audio";
> +		reg = <0x00 0x02b20000 0x00 0x2000>,
> +		      <0x00 0x02b28000 0x00 0x400>;
> +		reg-names = "mpu","dat";
> +		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "tx", "rx";
> +
> +		dmas = <&main_bcdma 0 0xc502 0>, <&main_bcdma 0 0x4502 0>;
> +		dma-names = "tx", "rx";
> +
> +		clocks = <&k3_clks 192 0>;
> +		clock-names = "fck";
assigned-clocks = <&k3_clks 192 0>;
assigned-clock-parents = <&k3_clks 192 2>;

> +		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
> +	};
>  };
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB47511643
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiD0LKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbiD0LKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:10:31 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6B43D1F4;
        Wed, 27 Apr 2022 04:06:48 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23RB6fXU110776;
        Wed, 27 Apr 2022 06:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651057601;
        bh=J3BSiLTEkISmMAngFf+J6ctLyGDu9f3n26evJysgDxA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=f+F2BdVyzGucCbj5uZr5P+poDizuqvHdUNclxGlT1T/dVwubuhXpuMnfFdinXUoVR
         D1HbSlgTBdYN2msCnK4JGRtVLkk53xuDnhhTXNDQU6W9935UjJ3FNHXXSCwM0mopGW
         Ju2q+xCudLZ3RRia2f+uDIWtlFxlalFIqm4bg0NE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23RB6f4o095407
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 06:06:41 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 06:06:41 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 06:06:41 -0500
Received: from [172.24.145.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23RB6bTx019427;
        Wed, 27 Apr 2022 06:06:38 -0500
Message-ID: <96894353-2b4e-52a7-bd48-c65eb674d6f5@ti.com>
Date:   Wed, 27 Apr 2022 16:36:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: dts: ti: k3-am62-mcu: Enable MCU GPIO module
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <20220421061938.122317-1-vigneshr@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
In-Reply-To: <20220421061938.122317-1-vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/22 11:49, Vignesh Raghavendra wrote:
> AM62 has x1 GPIO module and associated interrupt router in MCU Domain.
> Add DT nodes for the same.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi | 28 +++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
> index d103824c963f..45343381ad0b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
> @@ -53,4 +53,32 @@ mcu_spi1: spi@4b10000 {
>  		power-domains = <&k3_pds 148 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 148 0>;
>  	};
> +
> +	mcu_gpio_intr: interrupt-controller@4210000 {
> +		compatible = "ti,sci-intr";
> +		reg = <0x00 0x04210000 0x00 0x200>;
> +		ti,intr-trigger-type = <1>;
> +		interrupt-controller;
> +		interrupt-parent = <&gic500>;
> +		#interrupt-cells = <1>;
> +		ti,sci = <&dmsc>;
> +		ti,sci-dev-id = <5>;
> +		ti,interrupt-ranges = <0 104 4>;
> +	};
> +
> +	mcu_gpio0: gpio@4201000 {
> +		compatible = "ti,am64-gpio", "ti,keystone-gpio";
> +		reg = <0x0 0x4201000 0x0 0x100>;

nitpick: reg = <0x00 0x04201000 0x00 0x100>;

> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-parent = <&mcu_gpio_intr>;
> +		interrupts = <30>, <31>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		ti,ngpio = <24>;
> +		ti,davinci-gpio-unbanked = <0>;
> +		power-domains = <&k3_pds 79 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 79 0>;
> +		clock-names = "gpio";
> +	};
>  };


Aside from the above minor change,

Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>

-- 
Thanks,
Aswath

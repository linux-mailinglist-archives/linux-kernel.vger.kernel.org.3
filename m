Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833AF5A6053
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiH3KIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiH3KHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:07:36 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE64F47D4;
        Tue, 30 Aug 2022 03:04:24 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27UA4JSs073402;
        Tue, 30 Aug 2022 05:04:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661853859;
        bh=CejfZirNs5UV2rVoEiUHmZfhpe5ompA93UPCs/ja5Bk=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=XIwQl4l5enlRKIFRPaSaF0gDBiuR3+EpDTTpH4jaaVbFlqCFR41YuEeOQ07QIRFbd
         WORJs7V1o/lv9+reDyCNJpeMwc5vFutnvggro3Vyo821o9s2WLtxnTC2eiKv0wktE7
         FX47QwlJm6+2JVQEMfHivuaa1WYyGmMQjQ5fvK9E=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27UA4J0U121168
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Aug 2022 05:04:19 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 30
 Aug 2022 05:04:19 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 30 Aug 2022 05:04:19 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27UA4G9P109111;
        Tue, 30 Aug 2022 05:04:16 -0500
Message-ID: <84eb85c7-a960-996b-3c7a-3538df8d54dd@ti.com>
Date:   Tue, 30 Aug 2022 15:34:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/4] arm64: dts: ti: k3-j7200-mcu-wakeup: Add SA2UL
 node
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220823001136.10944-1-afd@ti.com>
 <20220823001136.10944-4-afd@ti.com>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20220823001136.10944-4-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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



On 23/08/22 05:41, Andrew Davis wrote:
> J7200 has an instance of SA2UL in the MCU domain.
> Add DT node for the same.
> 
> The device is marked TI_SCI_PD_SHARED as parts of this IP are also
> shared with the security co-processor and OP-TEE.
> 
> The RNG node is added but marked disabled as it is firewalled off for
> exclusive use by OP-TEE. Any access to this device from Linux will
> result in firewall errors. We add the node for completeness of the
> hardware description.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>   .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 20 +++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index ff13bbeed30c..e5be78a58682 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -375,4 +375,24 @@ mcu_r5fss0_core1: r5f@41400000 {
>   			ti,loczrama = <1>;
>   		};
>   	};
> +
> +	mcu_crypto: crypto@40900000 {
> +		compatible = "ti,j721e-sa2ul";
> +		reg = <0x00 0x40900000 0x00 0x1200>;
> +		power-domains = <&k3_pds 265 TI_SCI_PD_SHARED>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;
> +		dmas = <&mcu_udmap 0xf501>, <&mcu_udmap 0x7502>,
> +		       <&mcu_udmap 0x7503>;
> +		dma-names = "tx", "rx1", "rx2";
> +		dma-coherent;
> +
> +		rng: rng@40910000 {
> +			compatible = "inside-secure,safexcel-eip76";
> +			reg = <0x00 0x40910000 0x00 0x7d>;
> +			interrupts = <GIC_SPI 945 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled"; /* Used by OP-TEE */
> +		};
> +	};
>   };

Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>

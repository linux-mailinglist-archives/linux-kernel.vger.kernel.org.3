Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EA756C2BE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239540AbiGHWI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 18:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbiGHWI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 18:08:26 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFC79CE3B;
        Fri,  8 Jul 2022 15:08:24 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 268M8GEl036608;
        Fri, 8 Jul 2022 17:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657318096;
        bh=piEdrj/ATE8s5GwdxV9/T4ZAwyh8+V9sCmClMqQjD3g=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=i+GpOVft5WOStu+7MnliFFEeO/wcOWHOotZpEjtBW/8axs6Nny8UBL1cKbjhH1ogg
         w/WpWbt4qT5QHCoBk9rm7BFnPGrHpxv0lP5FJM0H27Y5cs0p0Iwn7ZeGupC6SnUP8j
         dWpxAD200qtoECCOHjdgwV8nRZUQbT58ixqOnr6E=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 268M8GZr030216
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jul 2022 17:08:16 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 8
 Jul 2022 17:08:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 8 Jul 2022 17:08:16 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 268M8G04048053;
        Fri, 8 Jul 2022 17:08:16 -0500
Date:   Fri, 8 Jul 2022 17:08:16 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jayesh Choudhary <j-choudhary@ti.com>
CC:     <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am64-main: Enable crypto
 accelerator
Message-ID: <20220708220816.rwyr54ahzjvh7ad5@awhile>
References: <20220708112755.105642-1-j-choudhary@ti.com>
 <20220708112755.105642-3-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220708112755.105642-3-j-choudhary@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:57-20220708, Jayesh Choudhary wrote:
> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Add the node for SA2UL.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> [s-anna@ti.com: drop label, minor cleanups]
> Signed-off-by: Suman Anna <s-anna@ti.com>
> [j-choudhary@ti.com: drop rng-node, change flag to shared]


See thread: https://lore.kernel.org/all/1d6d171f-3c91-530a-27a5-c93153cb2378@ti.com/

lets be consistent as to having the RNG node with disable and logic for
doing the same.

> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index ada00575f0f2..dd2848cd0740 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -1308,4 +1308,16 @@
>  		interrupt-names = "int0", "int1";
>  		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
>  	};
> +
> +	crypto: crypto@40900000 {
> +		compatible = "ti,am64-sa2ul";
> +		reg = <0x00 0x40900000 0x00 0x1200>;
> +		power-domains = <&k3_pds 133 TI_SCI_PD_SHARED>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;
> +		dmas = <&main_pktdma 0xc001 0>, <&main_pktdma 0x4002 0>,
> +		       <&main_pktdma 0x4003 0>;
> +		dma-names = "tx", "rx1", "rx2";
> +	};
>  };
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

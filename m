Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372595A6797
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiH3Pnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiH3Pno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:43:44 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324AE12F567;
        Tue, 30 Aug 2022 08:43:44 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27UFhYUm053760;
        Tue, 30 Aug 2022 10:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661874214;
        bh=wo7J6NOI7If5m7YxGuvFR4JK3BTqlAz7ZHy5EUz22pY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=rMhVEY1xzdxPE6u1bhXn/jNzNeRLr2TE9T77F4FbTUN6BK7dYwRXeeBWQ46MkdERw
         ig38naFvFAkLALfcGU/T1QiAYzxWF6oUWRkyhMdN0ibJLCnrW+KMA8kjD7TyaVxC3d
         d6Ld1sr7I4SKirkkL8+b6BaM8HZyUgSm9CwCYCR8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27UFhY6Z030073
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Aug 2022 10:43:34 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 30
 Aug 2022 10:43:33 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 30 Aug 2022 10:43:33 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27UFhXjP093215;
        Tue, 30 Aug 2022 10:43:33 -0500
Date:   Tue, 30 Aug 2022 10:43:33 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Neha Malcom Francis <n-francis@ti.com>
CC:     <afd@ti.com>, <devicetree@vger.kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <vigneshr@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200-main: Add main domain watchdog
 entries
Message-ID: <20220830154333.cwxji4hx7iggsm3w@boondocks>
References: <20220822235006.7081-1-afd@ti.com>
 <20220830041822.7435-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220830041822.7435-1-n-francis@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:48-20220830, Neha Malcom Francis wrote:
> From: Andrew Davis <afd@ti.com>
> 
> From: Gowtham Tammana <g-tammana@ti.com>
> 
> Add DT entries for main domain watchdog instances.
> 
> Signed-off-by: Gowtham Tammana <g-tammana@ti.com>
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Reviewed-by: Neha Francis <n-francis@ti.com>

NAK - Please follow the standard patch guidelines for From, and handoff
etc.
> ---
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index 16684a2f054d..cf657ac0bd6a 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -739,6 +739,24 @@ main_gpio6: gpio@630000 {
>  		clock-names = "gpio";
>  	};
>  
> +	watchdog0: watchdog@2200000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x0 0x2200000 0x0 0x100>;
> +		clocks = <&k3_clks 252 1>;
> +		power-domains = <&k3_pds 252 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 252 1>;
> +		assigned-clock-parents = <&k3_clks 252 5>;
> +	};
> +
> +	watchdog1: watchdog@2210000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x0 0x2210000 0x0 0x100>;
> +		clocks = <&k3_clks 253 1>;
> +		power-domains = <&k3_pds 253 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 253 1>;
> +		assigned-clock-parents = <&k3_clks 253 5>;
> +	};
> +
>  	main_r5fss0: r5fss@5c00000 {
>  		compatible = "ti,j7200-r5fss";
>  		ti,cluster-mode = <1>;
> -- 
> 2.36.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

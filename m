Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1014BA4A3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242656AbiBQPls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:41:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240350AbiBQPlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:41:46 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09EE11C32;
        Thu, 17 Feb 2022 07:41:30 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21HFfP9l008238;
        Thu, 17 Feb 2022 09:41:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645112485;
        bh=TsXm2kt6xmnCwysfV2TKJiVFF5ZtAGYWb/89Es0VQfA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=V90BLV6sKzw+CCSt2hgZ7Q64PFqZg0qgja8CtFatgra2Wj0MIxAw5iovTeRhiCul6
         VRxuUqUbH8l8vd2T/hFSTv2hfbKKoMgXRle9uT24s/Ro46Bgm1diKUYbPUV7O88c9/
         MD+TH/mlNmcgx5HTHyg2gHoq7/UZltc+bWVV+Des=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21HFfPbs020341
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Feb 2022 09:41:25 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 17
 Feb 2022 09:41:24 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 17 Feb 2022 09:41:24 -0600
Received: from [10.250.233.137] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21HFfKe1084567;
        Thu, 17 Feb 2022 09:41:21 -0600
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2-mcu-wakeup: Fix the
 interrupt-parent for wkup_gpioX instances
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220203132647.11314-1-a-govindraju@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <4b75db14-6e1b-4dc8-0089-1a714ecdac53@ti.com>
Date:   Thu, 17 Feb 2022 21:11:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20220203132647.11314-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/02/22 6:56 pm, Aswath Govindraju wrote:
> From: Keerthy <j-keerthy@ti.com>
> 
> The interrupt-parent for wkup_gpioX instances are wrongly assigned as
> main_gpio_intr instead of wkup_gpio_intr. Fix it.
> 
> Fixes: b8545f9d3a54 ("arm64: dts: ti: Add initial support for J721S2 SoC")
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> index 7521963719ff..6c5c02edb375 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> @@ -108,7 +108,7 @@
>  		reg = <0x00 0x42110000 0x00 0x100>;
>  		gpio-controller;
>  		#gpio-cells = <2>;
> -		interrupt-parent = <&main_gpio_intr>;
> +		interrupt-parent = <&wkup_gpio_intr>;
>  		interrupts = <103>, <104>, <105>, <106>, <107>, <108>;
>  		interrupt-controller;
>  		#interrupt-cells = <2>;
> @@ -124,7 +124,7 @@
>  		reg = <0x00 0x42100000 0x00 0x100>;
>  		gpio-controller;
>  		#gpio-cells = <2>;
> -		interrupt-parent = <&main_gpio_intr>;
> +		interrupt-parent = <&wkup_gpio_intr>;
>  		interrupts = <112>, <113>, <114>, <115>, <116>, <117>;
>  		interrupt-controller;
>  		#interrupt-cells = <2>;
> 

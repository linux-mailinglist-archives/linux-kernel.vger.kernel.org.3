Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE1450264F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 09:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351152AbiDOHnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 03:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237208AbiDOHnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 03:43:31 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7061C201AE;
        Fri, 15 Apr 2022 00:41:04 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23F7eu9T047654;
        Fri, 15 Apr 2022 02:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650008456;
        bh=1egII1TAo0KWjN3/Um+MWMVix8RR4bOccjOJCc7zNxE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=buw+nqZ+txbHusAcgmFNC/j87hpkK/SGY3YskqrKeMrSGU6MZAOLe+kuBs+Ukz1Jf
         BVi+nNyzXnIcfdHD6UFbKD7tz9jbRrAxylA1DZlakoIlJuQpfxhzVHNwQfA/7xma+M
         OkjmYjF5AI2lwQt7/QIX68wbUYXxyh/F16LIGxow=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23F7euk7114015
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Apr 2022 02:40:56 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 15
 Apr 2022 02:40:56 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 15 Apr 2022 02:40:56 -0500
Received: from [10.250.235.115] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23F7eqQt027060;
        Fri, 15 Apr 2022 02:40:53 -0500
Message-ID: <83d5773d-d699-59e1-4d7d-e1ce85286702@ti.com>
Date:   Fri, 15 Apr 2022 13:10:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-mcu: explicitly assign UART base
 clock rates
Content-Language: en-US
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220411121108.63436-1-matthias.schiffer@ew.tq-group.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220411121108.63436-1-matthias.schiffer@ew.tq-group.com>
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



On 11/04/22 5:41 pm, Matthias Schiffer wrote:
> We found that (at least some versions of) the sci-fw do not assign the
> expected base clock rate of 48 MHz for the UARTs in the MCU domain,
> leading to incorrect baud rates when used from Linux. Use
> assigned-clock-rates to fix this issue.
> 
> Fixes: 8abae9389bdb ("arm64: dts: ti: Add support for AM642 SoC")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> I'm not sure if this is the best fix. Should the clock-frequency
> property simply be removed, so the frequency is queried from the clock
> driver instead?
> 

I think its better to drop clock-frequency. Driver can setup DLL/DLH to
get appropriate baudrate as per frequency queried from clock driver

>  arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
> index 2bb5c9ff172c..69b0f127eea5 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
> @@ -15,6 +15,8 @@ mcu_uart0: serial@4a00000 {
>  		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 149 0>;
>  		clock-names = "fclk";
> +		assigned-clocks = <&k3_clks 149 0>;
> +		assigned-clock-rates = <48000000>;
>  	};
>  
>  	mcu_uart1: serial@4a10000 {
> @@ -26,6 +28,8 @@ mcu_uart1: serial@4a10000 {
>  		power-domains = <&k3_pds 160 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 160 0>;
>  		clock-names = "fclk";
> +		assigned-clocks = <&k3_clks 160 0>;
> +		assigned-clock-rates = <48000000>;
>  	};
>  
>  	mcu_i2c0: i2c@4900000 {

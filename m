Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E742511CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239608AbiD0P1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239639AbiD0P1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:27:31 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7635E2FBF6E;
        Wed, 27 Apr 2022 08:24:17 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23RFOChY051840;
        Wed, 27 Apr 2022 10:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651073052;
        bh=6wvpq2Hq+CfvhJGkTuQwpqDx+VS3UclgJJFRcxZPuZg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=pW9XOluGYlyVIVfaEsgZXoQjyrg2aTDIbAJ0MAIqsg54tgi7HW0MjxM0Vxc359AaU
         QNhYQKVYW3SPAMwzV2vJCh7GuWd2XIkWzrvbnkhNM63KFqm0gjHUEia3o9rBlRQIVK
         m7iok8iS2tjxpYiA+4NSqE8YhtI2rWI9T4IwlHyw=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23RFOCKl109791
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 10:24:12 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 10:24:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 10:24:12 -0500
Received: from [10.250.232.100] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23RFO8PT014359;
        Wed, 27 Apr 2022 10:24:09 -0500
Message-ID: <d802f305-90d6-decf-c7ad-547d3c8a80da@ti.com>
Date:   Wed, 27 Apr 2022 20:54:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] arm64: dts: ti: k3-am62-mcu: Enable MCU GPIO module
Content-Language: en-US
To:     Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <20220421061938.122317-1-vigneshr@ti.com>
 <96894353-2b4e-52a7-bd48-c65eb674d6f5@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <96894353-2b4e-52a7-bd48-c65eb674d6f5@ti.com>
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



On 27/04/22 4:36 pm, Aswath Govindraju wrote:
> On 21/04/22 11:49, Vignesh Raghavendra wrote:
>> AM62 has x1 GPIO module and associated interrupt router in MCU Domain.
>> Add DT nodes for the same.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi | 28 +++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
>> index d103824c963f..45343381ad0b 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
>> @@ -53,4 +53,32 @@ mcu_spi1: spi@4b10000 {
>>  		power-domains = <&k3_pds 148 TI_SCI_PD_EXCLUSIVE>;
>>  		clocks = <&k3_clks 148 0>;
>>  	};
>> +
>> +	mcu_gpio_intr: interrupt-controller@4210000 {
>> +		compatible = "ti,sci-intr";
>> +		reg = <0x00 0x04210000 0x00 0x200>;
>> +		ti,intr-trigger-type = <1>;
>> +		interrupt-controller;
>> +		interrupt-parent = <&gic500>;
>> +		#interrupt-cells = <1>;
>> +		ti,sci = <&dmsc>;
>> +		ti,sci-dev-id = <5>;
>> +		ti,interrupt-ranges = <0 104 4>;
>> +	};
>> +
>> +	mcu_gpio0: gpio@4201000 {
>> +		compatible = "ti,am64-gpio", "ti,keystone-gpio";
>> +		reg = <0x0 0x4201000 0x0 0x100>;
> 
> nitpick: reg = <0x00 0x04201000 0x00 0x100>;

Ah, yes.. Will fix locally before merging.

> 
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +		interrupt-parent = <&mcu_gpio_intr>;
>> +		interrupts = <30>, <31>;
>> +		interrupt-controller;
>> +		#interrupt-cells = <2>;
>> +		ti,ngpio = <24>;
>> +		ti,davinci-gpio-unbanked = <0>;
>> +		power-domains = <&k3_pds 79 TI_SCI_PD_EXCLUSIVE>;
>> +		clocks = <&k3_clks 79 0>;
>> +		clock-names = "gpio";
>> +	};
>>  };
> 
> 
> Aside from the above minor change,
> 
> Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
> 

Thanks!

Regards
Vignesh

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4109350DC73
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbiDYJZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiDYJZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:25:51 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C57E23158;
        Mon, 25 Apr 2022 02:22:47 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23P9McRQ057744;
        Mon, 25 Apr 2022 04:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650878558;
        bh=EfsyaX8ZUh64mXOdkBafAJQoTecRctMPR+QpHeJde8w=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=JeHG4uT4zWBnSHrvNbzVU9tr9k/1Ymuw9U8kVu23U9ZHzlOwoW1+biSb1OTA/9/p4
         m4ppHgqYnJCFvPTeHEQg4DNafDcjA+2s6NQAmvzwYva6FiISzsowYVJ/R7vpyEJurb
         oTGLf5lYp8uMahizoBBTX7KwkCUnkeBfzGwYBg1w=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23P9MccG086809
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Apr 2022 04:22:38 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 25
 Apr 2022 04:22:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 25 Apr 2022 04:22:38 -0500
Received: from [172.24.222.171] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23P9MYMk118330;
        Mon, 25 Apr 2022 04:22:35 -0500
Message-ID: <8517d504-af9c-53f5-a51b-3bcdbb86d09f@ti.com>
Date:   Mon, 25 Apr 2022 14:52:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-am625-sk: Enable on board
 peripherals
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <20220422065002.387753-1-vigneshr@ti.com>
 <20220422065002.387753-3-vigneshr@ti.com>
 <c40a2dad-c7aa-f778-f1ac-971185691950@linaro.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <c40a2dad-c7aa-f778-f1ac-971185691950@linaro.org>
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

Hi Krzysztof,

On 23/04/22 4:02 pm, Krzysztof Kozlowski wrote:
> On 22/04/2022 08:50, Vignesh Raghavendra wrote:
>> Add nodes for I2C IO expander, OSPI Flash, Eth PHYs, SD and eMMC that
>> are present on AM625 SK board.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Reviewed-by: Bryan Brattlof <bb@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am625-sk.dts | 273 +++++++++++++++++++++++++
>>  1 file changed, 273 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
>> index 0de4113ccd5de..5fc35898a1e2e 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
>> @@ -9,6 +9,7 @@
>>  
>>  #include <dt-bindings/leds/common.h>
>>  #include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/net/ti-dp83867.h>
>>  #include "k3-am625.dtsi"
>>  
>>  / {
>> @@ -17,6 +18,12 @@ / {
>>  
>>  	aliases {
>>  		serial2 = &main_uart0;
>> +		mmc0 = &sdhci0;
>> +		mmc1 = &sdhci1;
>> +		mmc2 = &sdhci2;
>> +		spi0 = &ospi0;
>> +		ethernet0 = &cpsw_port1;
>> +		ethernet1 = &cpsw_port2;
>>  	};
>>  
>>  	chosen {
>> @@ -87,6 +94,33 @@ vcc_3v3_sys: regulator-2 {
>>  		regulator-boot-on;
>>  	};
>>  
>> +	vdd_mmc1: fixed-regulator-sd {
> 
> Don't encode the type of binding into node name. Node name should be
> generic, so either regulator-0 or regulator-sd.
> 
>> +		/* TPS22918DBVR */
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vdd_mmc1";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-boot-on;
>> +		enable-active-high;
>> +		vin-supply = <&vcc_3v3_sys>;
>> +		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
>> +	};
>> +
>> +	vdd_sd_dv: gpio-regulator-TLV71033 {
> 
> The same + do not mix cases, so regulator-1 or regulator-tlv71033

I have fixed this in v3. But had one question though:

Per DT spec, 2.2.3 Path Names seems to indicate node-name-N when N is
1,2,3.. So, is it valid to have regulator-tlv71033 as node-name -> does
not strictly seem to fit into node-name-N format ?

Regards
Vignesh

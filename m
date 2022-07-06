Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81729569167
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiGFSLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiGFSLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:11:01 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEBC28E28;
        Wed,  6 Jul 2022 11:11:01 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 266IAvWS009357;
        Wed, 6 Jul 2022 13:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657131057;
        bh=mYqyAiq5ehGUf6IoQZIVZVf2MHlbWHt5NT9zBcqkp2I=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Gw+BcOdE2y1dmryHTvOCOc+tmfeUQ0WCXVhc/B3rbmX8MYkgRjw7tBSwQ0XTmEHTn
         0UtiOubc4g7FyXSqnHA0J9FDa5g73XMLt3zXdL3AOdD7KsXHIoDUQAoeP+FwW1CQ6j
         VHHluaoQdwsyNRSzaJGUZlCPlajzuor0rhwgKipE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 266IAvhF017632
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Jul 2022 13:10:57 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 6
 Jul 2022 13:10:56 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 6 Jul 2022 13:10:56 -0500
Received: from [10.250.33.129] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 266IAugH090962;
        Wed, 6 Jul 2022 13:10:56 -0500
Message-ID: <16319b56-4b14-6f51-23c6-6b78b87119d7@ti.com>
Date:   Wed, 6 Jul 2022 13:10:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 6/6] arm64: dts: ti: k3-j7200-mcu-wakeup: Add SA2UL node
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220705170340.26719-1-afd@ti.com>
 <20220705170340.26719-6-afd@ti.com> <20220706180446.cyzujuasovjvsofk@lively>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20220706180446.cyzujuasovjvsofk@lively>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/22 1:04 PM, Nishanth Menon wrote:
> On 12:03-20220705, Andrew Davis wrote:
>> J7200 has an instance of SA2UL in the MCU domain.
>> Add DT node for the same.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 20 +++++++++++++++++++
>>   1 file changed, 20 insertions(+)
> 
> Please split this series into what crypto maintainers need to pick up vs
> what I need to pick up for dts. patches for my tree need to have lakml
> in cc as a rule (see MAINTAINERS file).
> 

Okay, I'll break the first two into their own series. Adding LAKML folks
for v2.

>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
>> index 1044ec6c4b0d4..ebad3642c8e30 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
>> @@ -375,4 +375,24 @@ mcu_r5fss0_core1: r5f@41400000 {
>>   			ti,loczrama = <1>;
>>   		};
>>   	};
>> +
>> +	mcu_crypto: crypto@40900000 {
>> +		compatible = "ti,j721e-sa2ul";
>> +		reg = <0x00 0x40900000 0x00 0x1200>;
>> +		power-domains = <&k3_pds 265 TI_SCI_PD_SHARED>;
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;
>> +		dmas = <&mcu_udmap 0xf501>, <&mcu_udmap 0x7502>,
>> +		       <&mcu_udmap 0x7503>;
>> +		dma-names = "tx", "rx1", "rx2";
>> +		dma-coherent;
>> +
>> +		rng: rng@40910000 {
>> +			compatible = "inside-secure,safexcel-eip76";
>> +			reg = <0x00 0x40910000 0x00 0x7d>;
>> +			interrupts = <GIC_SPI 945 IRQ_TYPE_LEVEL_HIGH>;
> 
> Please document why disabled.
> 

Sure thing, will add background info to the commit message.

Thanks,
Andrew

>> +			status = "disabled";
>> +		};
>> +	};
>>   };
>> -- 
>> 2.36.1
>>
> 

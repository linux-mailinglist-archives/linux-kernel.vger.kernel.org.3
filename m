Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EEA56D98D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiGKIyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiGKIyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:54:06 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD827B1E1;
        Mon, 11 Jul 2022 01:54:04 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 26B8rnFN012479;
        Mon, 11 Jul 2022 03:53:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657529629;
        bh=Gf71kfs0ZGj50JnkmWY81zhi/XKMCfnOddDWZhEm994=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pfSZmeoh+yKDgwWt+uh/mCpV8Oh7kfvTSBrgEqYlCk93mX2tNHVfmY/VKSokjGjE0
         FfvJMDcmKM/WsnPb5fejimOOkQaoj28pwToBMVzNv3RGv2a8kBh2DhtMsXSZ+Jo9oH
         sXTRCy2uKc/ZAYsEZZwzdHfRvVuBL65E/D3d/Upk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 26B8rnk3066579
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jul 2022 03:53:49 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 11
 Jul 2022 03:53:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 11 Jul 2022 03:53:49 -0500
Received: from [172.24.145.60] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 26B8rkgP119473;
        Mon, 11 Jul 2022 03:53:46 -0500
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am64-main: Enable crypto
 accelerator
To:     Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220708112755.105642-1-j-choudhary@ti.com>
 <20220708112755.105642-3-j-choudhary@ti.com>
 <20220708220816.rwyr54ahzjvh7ad5@awhile>
From:   Jayesh Choudhary <j-choudhary@ti.com>
Message-ID: <8a3285cd-d057-eaa0-ebe3-3032abd64d49@ti.com>
Date:   Mon, 11 Jul 2022 14:23:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220708220816.rwyr54ahzjvh7ad5@awhile>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/07/22 3:38 am, Nishanth Menon wrote:
> On 16:57-20220708, Jayesh Choudhary wrote:
>> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>
>> Add the node for SA2UL.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> [s-anna@ti.com: drop label, minor cleanups]
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> [j-choudhary@ti.com: drop rng-node, change flag to shared]
> 
> 
> See thread: https://lore.kernel.org/all/1d6d171f-3c91-530a-27a5-c93153cb2378@ti.com/
> 
> lets be consistent as to having the RNG node with disable and logic for
> doing the same.

Okay. Will send a v2 patch.


> 
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> index ada00575f0f2..dd2848cd0740 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> @@ -1308,4 +1308,16 @@
>>  		interrupt-names = "int0", "int1";
>>  		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
>>  	};
>> +
>> +	crypto: crypto@40900000 {
>> +		compatible = "ti,am64-sa2ul";
>> +		reg = <0x00 0x40900000 0x00 0x1200>;
>> +		power-domains = <&k3_pds 133 TI_SCI_PD_SHARED>;
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;
>> +		dmas = <&main_pktdma 0xc001 0>, <&main_pktdma 0x4002 0>,
>> +		       <&main_pktdma 0x4003 0>;
>> +		dma-names = "tx", "rx1", "rx2";
>> +	};
>>  };
>> -- 
>> 2.17.1
>>
> 

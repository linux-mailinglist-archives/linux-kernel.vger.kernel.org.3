Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2257452A5A5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349631AbiEQPHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiEQPHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:07:30 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892F83B03F;
        Tue, 17 May 2022 08:07:28 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24HF7NLV004434;
        Tue, 17 May 2022 10:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1652800043;
        bh=ZINbXM1Hh90dm8mq3C47q/Ut9jRaUp9GOA/s2JKJocM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=MaO5IzaiSt7V3Uvv64jtL9WhA6+uiolO6khzr/tZC5KRpu2sVKzovKh7v+yMM86p/
         zgUxQ3YqVlfhGzFZMDtsMOdqNqVXGzTKcsftCqUNfDHOuCOEz8O0XHsH/6vJcWOl2O
         nDpqym/zMiueykENjHS6nr+hVSifpv+fIlT0RViQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24HF7NoF026227
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 May 2022 10:07:23 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 17
 May 2022 10:07:22 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 17 May 2022 10:07:22 -0500
Received: from [10.250.234.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24HF7I65124850;
        Tue, 17 May 2022 10:07:19 -0500
Message-ID: <324bd9c8-06b4-b9f5-7213-0e4b2a50653b@ti.com>
Date:   Tue, 17 May 2022 20:37:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v8 1/2] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <amitk@kernel.org>, <kristo@kernel.org>
CC:     <rafael@kernel.org>, <linux-pm@vger.kernel.org>, <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220517121423.8017-1-j-keerthy@ti.com>
 <20220517121423.8017-2-j-keerthy@ti.com>
 <03c0e4fa-ccfb-fd86-0899-92a1086cac09@linaro.org>
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <03c0e4fa-ccfb-fd86-0899-92a1086cac09@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/2022 8:08 PM, Krzysztof Kozlowski wrote:
> On 17/05/2022 14:14, Keerthy wrote:
>> Add VTM bindings documentation. In the Voltage Thermal
>> Management Module(VTM), K3 J72XX supplies a voltage
>> reference and a temperature sensor feature that are gathered in the band
>> gap voltage and temperature sensor (VBGAPTS) module. The band
>> gap provides current and voltage reference for its internal
>> circuits and other analog IP blocks. The analog-to-digital
>> converter (ADC) produces an output value that is proportional
>> to the silicon temperature.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
> 
> It seems I am repeating myself... Tags are still missing...

I still do not have a Reviewed-by from you. Should i add yours?
You are still giving additional comments so I did not add.

> 
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
>> +    wkup_vtm0: thermal-sensor@42040000 {
>> +        compatible = "ti,j721e-vtm";
>> +        reg = <0x42040000 0x350>,
>> +            <0x42050000 0x350>,
>> +            <0x43000300 0x10>;
> 
> Please align the continued entries with opening <.

Okay. I will fix that.

> 
>> +        power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
>> +        #thermal-sensor-cells = <1>;
>> +    };
>> +
>> +    mpu_thermal: mpu-thermal {
>> +        polling-delay-passive = <250>; /* milliseconds */
>> +        polling-delay = <500>; /* milliseconds */
>> +        thermal-sensors = <&wkup_vtm0 0>;
>> +
>> +        trips {
>> +                mpu_crit: mpu-crit {
> 
> You still have here incorrect/inconsistent indentation. Entire DTS
> example goes usually with 4 spaces.

Okay.

> 
>> +                        temperature = <125000>; /* milliCelsius */
>> +                        hysteresis = <2000>; /* milliCelsius */
>> +                        type = "critical";
>> +                };
>> +        };
>> +    };
>> +...
> 
>

Thanks,
Keerthy

> Best regards,
> Krzysztof

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA07452310E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbiEKK5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiEKK5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:57:39 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2636341313;
        Wed, 11 May 2022 03:57:36 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24BAvUxt020473;
        Wed, 11 May 2022 05:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1652266650;
        bh=YuNjT9OAQcHM2+4MYxNaA6BMEN97M20h+8FMQV1qmKI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ka0sP70Dtsz/NzkDxg6zLlSttOPOAugYjOA1VOvuzp0zSsq927Dv7innsjVSl7OBD
         vax1bKhQTZOm6KfHJDjCmIDE5prCD9mUYlENdU/n/0s1wvvhHIgb5IepgUtT/KuqV/
         Tf0t6CAaY06MAyHRrKUnBZJ6uNfCqhTUKcccAHR0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24BAvU7V118634
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 May 2022 05:57:30 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 11
 May 2022 05:57:29 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 11 May 2022 05:57:29 -0500
Received: from [172.24.223.48] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24BAvQUq023006;
        Wed, 11 May 2022 05:57:27 -0500
Message-ID: <7219b406-7677-748b-984c-66009d9f6327@ti.com>
Date:   Wed, 11 May 2022 16:27:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v6 1/4] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <amitk@kernel.org>, <kristo@kernel.org>,
        <vigneshr@ti.com>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220427064635.24898-1-j-keerthy@ti.com>
 <20220427064635.24898-2-j-keerthy@ti.com>
 <5859fed0-82b7-95eb-5719-9b0016916c50@ti.com>
 <eb0745a6-ecf2-4b70-368b-9ad8a322f208@linaro.org>
 <117f175f-62d1-17b5-742b-bcb250b7866f@ti.com>
 <091e6619-3341-4a98-90f6-48a6281f6275@linaro.org>
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <091e6619-3341-4a98-90f6-48a6281f6275@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/2022 1:45 PM, Krzysztof Kozlowski wrote:
> On 11/05/2022 09:53, J, KEERTHY wrote:
>>>>
>>>> Any comments on this version?
>>>
>>> You got Rob's review, so you don't need also mine.
>>>
>>> If you want, then in general look okay, except the description for "reg"
>>> you could split per items:
>>>
>>> reg:
>>>     items:
>>>       - description: VTM cfg1 register space
>>>       - description: VTM cfg2 register space
>>>       - description: efuse register space
>>>
>>> It's more obvious what items you expect.
>>
>> Hi Krzysztof,
>>
>> DTEX
>> Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.example.dts
>> Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml: found
>> duplicate key "description" with value "VTM cfg2 register space"
>> (original value: "VTM cfg1 register space")
>> Documentation/devicetree/bindings/Makefile:26: recipe for target
>> 'Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.example.dts'
>> failed
>> make[1]: ***
>> [Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.example.dts] Er
>>
>> I believe multiple instances of description is failing. So can i keep
>> the description as is?
> 
> It looks weird. Can you share your code (pastebin/github/paste here)?

My bad. I had missed the '-' before description & hence it was erring 
out. I fixed. I will post v7 of this patch alone.

Thanks,
Keerthy

> 
> 
> Best regards,
> Krzysztof

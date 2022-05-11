Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184AD522DB0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243169AbiEKHxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiEKHxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:53:39 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7F93EBA2;
        Wed, 11 May 2022 00:53:36 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24B7rVFu076044;
        Wed, 11 May 2022 02:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1652255611;
        bh=EJnEbmFbApVtiN+wXk9HgVlWHxYzSRSEn+KPA8du8EE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=I01caZygZx+nc8YVzLxhhubUUiAH9hfugIuapzejfAot/2LVYJCI2l50InXRAX6Nt
         wkB1t5YkvrUAsicovdF1Fi0D79ZQIhtJHzj/NSHOAyy7uOf+o0llALAj7LNDgH8/dZ
         21jJNZ6bD9B5UgGoqLJ45RDiYRszJwUQhAeyrmU8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24B7rVbT002016
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 May 2022 02:53:31 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 11
 May 2022 02:53:30 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 11 May 2022 02:53:31 -0500
Received: from [172.24.223.48] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24B7rRRH068143;
        Wed, 11 May 2022 02:53:28 -0500
Message-ID: <117f175f-62d1-17b5-742b-bcb250b7866f@ti.com>
Date:   Wed, 11 May 2022 13:23:27 +0530
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
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <eb0745a6-ecf2-4b70-368b-9ad8a322f208@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/2022 12:12 PM, Krzysztof Kozlowski wrote:
> On 09/05/2022 05:18, J, KEERTHY wrote:
>>
>>
>> On 4/27/2022 12:16 PM, Keerthy wrote:
>>> Add VTM bindings documentation. In the Voltage Thermal
>>> Management Module(VTM), K3 J72XX supplies a voltage
>>> reference and a temperature sensor feature that are gathered in the band
>>> gap voltage and temperature sensor (VBGAPTS) module. The band
>>> gap provides current and voltage reference for its internal
>>> circuits and other analog IP blocks. The analog-to-digital
>>> converter (ADC) produces an output value that is proportional
>>> to the silicon temperature.
>>
>> Hi krzysztof,
>>
>> Any comments on this version?
> 
> You got Rob's review, so you don't need also mine.
> 
> If you want, then in general look okay, except the description for "reg"
> you could split per items:
> 
> reg:
>    items:
>      - description: VTM cfg1 register space
>      - description: VTM cfg2 register space
>      - description: efuse register space
> 
> It's more obvious what items you expect.

Hi Krzysztof,

DTEX 
Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.example.dts
Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml: found 
duplicate key "description" with value "VTM cfg2 register space" 
(original value: "VTM cfg1 register space")
Documentation/devicetree/bindings/Makefile:26: recipe for target 
'Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.example.dts' 
failed
make[1]: *** 
[Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.example.dts] Er

I believe multiple instances of description is failing. So can i keep 
the description as is?

- Keerthy

> 
> Best regards,
> Krzysztof

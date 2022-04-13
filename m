Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0721E4FF663
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbiDMMGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbiDMMGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:06:49 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7523E3B3C9;
        Wed, 13 Apr 2022 05:04:28 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23DC4OWu013789;
        Wed, 13 Apr 2022 07:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649851464;
        bh=gobsrbTaF6iGktYshKMY61Cs4Kh/V+HFA6hA46GsKXo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=p3K7nyTBqW4ejijlYFTiZsa9tQdYnX56DMmwnEscnf+8Q20aubi7J1Cb2FuUbww5e
         8y4B+JiH04qpYhw7JLAXn7NAYsCLIIdcnpJJSOO3X5HhV1pQ42V3P7y3KTMYUCFSmn
         bI30dUEQnlYdDFuthX0cvAmWjQxqPFPS5WYBAh5Y=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23DC4OLT028970
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Apr 2022 07:04:24 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 13
 Apr 2022 07:04:24 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 13 Apr 2022 07:04:24 -0500
Received: from [172.24.223.48] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23DC4KIN067598;
        Wed, 13 Apr 2022 07:04:21 -0500
Message-ID: <54d597e9-5cad-fc44-954d-7de45018fdcf@ti.com>
Date:   Wed, 13 Apr 2022 17:34:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 1/4] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <amitk@kernel.org>, <kristo@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220412101409.7980-1-j-keerthy@ti.com>
 <20220412101409.7980-2-j-keerthy@ti.com>
 <17474b72-d823-e1ff-9831-c5f9f887fccd@linaro.org>
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <17474b72-d823-e1ff-9831-c5f9f887fccd@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/2022 3:43 PM, Krzysztof Kozlowski wrote:
> On 12/04/2022 12:14, Keerthy wrote:
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
>> ---
>>   .../bindings/thermal/ti,j72xx-thermal.yaml    | 62 +++++++++++++++++++
>>   1 file changed, 62 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
>> new file mode 100644
>> index 000000000000..8483c495cb9a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
>> @@ -0,0 +1,62 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/thermal/ti,j72xx-thermal.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments J72XX VTM (DTS) binding
>> +
>> +maintainers:
>> +  - Keerthy <j-keerthy@ti.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: ti,j721e-vtm
>> +    oneOf:
>> +      - enum:
>> +          - ti,j721e-vtm
>> +          - ti,j7200-vtm
> 
> It seems you resent this ignoring all of Rob's comments. In changelog of
> cover letter you wrote "Fixed all the comments on v4" but it's not true.
> Maybe you sent us old patch?
> 
> Anyway, you need to follow Rob's comments.

Krzysztof,

Apologies. Some issues with my mailbox. Rob's response didn't reach me 
for some reason.

I am now seeing them on the web: 
https://lore.kernel.org/lkml/YY7HvCyJ90Ge8mr7@robh.at.kernel.org/

It wasn't deliberate to ignore comments. Apologies.

I will fix them in v6.

Thanks for the quick feedback.

- Keerthy


> 
> 
> Best regards,
> Krzysztof

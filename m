Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D188B50EA8D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245351AbiDYUaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245480AbiDYUal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:30:41 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B299A14DEBB;
        Mon, 25 Apr 2022 13:24:54 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23PKOdav117769;
        Mon, 25 Apr 2022 15:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650918279;
        bh=lU4GPHDUX2opALZxQ7NvaxIHWY0jsIH/tbO9fNjC8wM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=tSXUSxNkaydF5skNEkSk896R1KCMEF/BjMfuEN4zQ3Am8N3AAZXTImyH2sa8RPLhZ
         EGDeAaYGVaIWquqzvCPBq6IRTmLyPJJci6SU5e8PGkzVUUZg6UWtq1HvLE0Fj/Rdxz
         u/7ZRY9sYjrInPaXLC5iQYq+bZSEVlwVpSYO1JRo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23PKOdqL028362
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Apr 2022 15:24:39 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 25
 Apr 2022 15:24:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 25 Apr 2022 15:24:38 -0500
Received: from [128.247.81.242] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23PKOc0u028548;
        Mon, 25 Apr 2022 15:24:38 -0500
Message-ID: <5f9485b0-d48c-6418-dc52-a2cd57e98791@ti.com>
Date:   Mon, 25 Apr 2022 15:24:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/6] dt-bindings: ti,sci: Add ti,ctx-memory-region
 property
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     Andrew Davis <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20220421203659.27853-1-d-gerlach@ti.com>
 <20220421203659.27853-2-d-gerlach@ti.com>
 <ad47db06-7f5c-399f-0ad0-81f720e6f035@ti.com>
 <2528be71-ca3f-566b-4769-36063c98ee0e@ti.com>
 <20220423133648.jlkeyfq7gjbwij5l@bonelike>
From:   Dave Gerlach <d-gerlach@ti.com>
In-Reply-To: <20220423133648.jlkeyfq7gjbwij5l@bonelike>
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

Hi,

On 4/23/22 08:36, Nishanth Menon wrote:
> On 14:10-20220422, Dave Gerlach wrote:
>> Hi,
>>
>> On 4/22/22 14:02, Andrew Davis wrote:
>>> On 4/21/22 3:36 PM, Dave Gerlach wrote:
>>>> Add documentation for the ti,ctx-memory-region property which is a
>>>> phandle to a reserved-memory carveout to be used by the ti_sci driver
>>>> storage of low power mode memory context. This is optional for normal
>>>> system operation but required to enabled suspend-to-mem usage of Deep
>>>> Sleep state.
>>>>
>>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>>>> ---
>>>>   .../devicetree/bindings/arm/keystone/ti,sci.yaml         | 9 +++++++++
>>>>   1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
>>>> index 34f5f877d444..ec88aa88a2a0 100644
>>>> --- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
>>>> +++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
>>>> @@ -61,6 +61,15 @@ properties:
>>>>     mboxes:
>>>>       minItems: 2
>>>>   
>>>> +  ti,ctx-memory-region:
>>>> +    description:
>>>> +      Phandle to the reserved memory node to be associated with the
>>>> +      ti-sci device, to be used for saving low power context. The
>>>> +      reserved memory node should be a carveout node, and should
>>>> +      be defined as per the bindings in
>>>> +      Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
>>>> +    $ref: /schemas/types.yaml#/definitions/string
>>>> +
>>>
>>>
>>> Why does this have to be yet another reserved carveout region,
>>> should be dynamically allocated.
>>>
>>
>> This must be a fixed address in order to support other low power modes
>> which have not yet been introduced.
> 
> Please elaborate the need - Many of our devices, esp the AM62 class ones
> are memory constrained devices - LPM states are controlled entry states, why
> should we loose a chunk of DDR in operational state while waiting for
> the suspend or idle state to be invoked?
> OR, is the argument is as follows:
> - need a guarenteed memory for me to enter low power and not be
>   dependent on availability on attempt.
> - Latency overhead of allocation during a "hot path" such as cpu idle,
>   this is completely unacceptable?
> 
>   or something of that form.. please elaborate?

Yes, in the case of some future low power modes, it is possible for the
SoC to completely lose context. For the mode being introduced here, I
agree that we could dynamically allocate this memory and then share that
address around, but keeping it fixed of course works here, and *also*
works for the complete context loss case, as a different mechanism would
be restoring this context and can easily get the fixed address straight
from the DT. Otherwise we would have two completely divergent paths
because there is no way to share some dynamic address across the transition.

To me it makes sense to keep it the same for all modes when possible.

Regards,
Dave

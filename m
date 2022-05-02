Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2CD516A4C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 07:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383336AbiEBFe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 01:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbiEBFew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 01:34:52 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E87F1BEBC;
        Sun,  1 May 2022 22:31:23 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2425UpP3091238;
        Mon, 2 May 2022 00:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651469451;
        bh=BUXxiuFFD86bcXlTaA9jXgKOVSHgEET95R0XpQs0bMQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=l3Jlr9Z5xiaWfnZKQS6pfGDWppRzOuu750uIjqgtewkBtXalcoGjkX1/tIK3Q4Mki
         +t4JRYNurXz8MEcaPRvQ6d+NMBLawRFzG/8KucDFd5pec7ndEVlfhfk+tLkR9LT6FR
         8ZawmYDt5bKQPO73r4XMmLzF/Dp2vd1Pa2eG9Ems=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2425Upaj064608
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 May 2022 00:30:51 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 2
 May 2022 00:30:50 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 2 May 2022 00:30:49 -0500
Received: from [172.24.145.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2425UjCk005241;
        Mon, 2 May 2022 00:30:45 -0500
Message-ID: <f714ee55-ef47-317d-81b9-57020dda064b@ti.com>
Date:   Mon, 2 May 2022 11:00:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: usb: tps6598x: Make the interrupts
 property optional
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Roger Quadros <rogerq@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Martin Kepplinger <martink@posteo.de>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220414083120.22535-1-a-govindraju@ti.com>
 <20220414083120.22535-2-a-govindraju@ti.com>
 <be8ab691-98f1-5fb9-fec8-7213a2288d07@kernel.org>
 <56c72151-af5f-366b-b17f-24b9fb6264da@ti.com>
 <ae54dbb1-2b02-cba2-5de2-cf3d9a4e35f5@kernel.org>
 <c1de4293-a058-5e25-9be2-b61ac39f43a3@ti.com>
 <89f7d69a-4fc8-33cc-d9ca-5c50dc5381ab@kernel.org>
 <YmeXw8nerjpuKPC9@kuha.fi.intel.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
In-Reply-To: <YmeXw8nerjpuKPC9@kuha.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 26/04/22 12:27, Heikki Krogerus wrote:
> On Tue, Apr 26, 2022 at 09:42:31AM +0300, Roger Quadros wrote:
>> Hi,
>>
>> On 22/04/2022 08:07, Aswath Govindraju wrote:
>>> Hi Roger,
>>>
>>> On 21/04/22 00:46, Roger Quadros wrote:
>>>> Hi,
>>>>
>>>> On 18/04/2022 08:19, Aswath Govindraju wrote:
>>>>> Hi Roger,
>>>>>
>>>>> On 14/04/22 23:40, Roger Quadros wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 14/04/2022 11:31, Aswath Govindraju wrote:
>>>>>>> Support for polling has been added in the driver, which will be used by
>>>>>>> default if interrupts property is not populated. Therefore, remove
>>>>>>> interrupts and interrupt-names from the required properties and add a note
>>>>>>> under interrupts property describing the above support in driver.
>>>>>>>
>>>>>>> Suggested-by: Roger Quadros <rogerq@kernel.org>
>>>>>>
>>>>>> I did not suggest to make interrupts optional by default.
>>>>>>
>>>>>> What I suggested was that if a DT property exists to explicitly
>>>>>> indicate polling mode then interrupts are not required.
>>>>>>
>>>>>
>>>>> ohh okay, got it. However, may I know if adding a dt property to
>>>>> indicate polling for aiding the driver, is the correct approach to model it?
>>>>>
>>>>> In terms of modelling hardware, as interrupts are not connected we are
>>>>> not populating the interrupts property. Shouldn't that be all. If we are
>>>>> adding a property explicitly to indicate polling that can be used by
>>>>> driver, wouldn't that be a software aid being added in the device tree?
>>>>
>>>> The hardware (tps6598x chip) has an interrupt pin and is expected to be used
>>>> in normal case.
>>>>
>>>> Some buggy boards might have forgot to connect it. We are adding polling mode only for these buggy boards. ;)
>>>> So polling mode is an exception.
>>>>
>>>
>>> Yes as you mentioned the interrupt line is expected to connected but
>>> there could be cases where there are not enough pins on the SoC and
>>> polling is used intentionally. In these cases this would be a feature
>>> rather than a bug.
>>
>> I do not agree that this is a feature but a board defect. You can always use
>> a GPIO expander to add more GPIOs than the SoC can provide.
>>
>> Type-C events are asynchronous and polling is a waste of CPU time.
>> What will you do if system suspends and you need to wake up on Type-C
>> status change?
>> So polling mode is just an exception for the defective boards or could
>> be used for debugging.
>>
>>>
>>> Also, I feel like not adding interrupts property in the dt nodes will
>>> indicate polling. My question is why are we adding an extra property
>>> (which is being used only as an aid in the driver) when this feature can
>>> be modeled by making interrupts property optional.
>>
>> Because interrupt property was not originally optional for this driver.
>>
>> I would like to hear what Heikki has to say about this.
>>
>> Any thoughts Heikki?
> 
> I think the question is generic. How should DT describe the
> connection/lack of connection? Rob should comment on this.
> 

A gentle ping regarding this.

Thanks,
Aswath

> thanks,
> 
> 
>> cheers,
>> -roger
>>
>>>
>>> Thanks,
>>> Aswath
>>>
>>>> cheers,
>>>> -roger
>>>>
>>>>>
>>>>> Thanks,
>>>>> Aswath
>>>>>
>>>>>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>>>>>> ---
>>>>>>>  Documentation/devicetree/bindings/usb/ti,tps6598x.yaml | 4 ++--
>>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
>>>>>>> index a4c53b1f1af3..1c4b8c6233e5 100644
>>>>>>> --- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
>>>>>>> @@ -25,6 +25,8 @@ properties:
>>>>>>>  
>>>>>>>    interrupts:
>>>>>>>      maxItems: 1
>>>>>>> +    description:
>>>>>>> +      If interrupts are not populated then by default polling will be used.
>>>>>>>  
>>>>>>>    interrupt-names:
>>>>>>>      items:
>>>>>>> @@ -33,8 +35,6 @@ properties:
>>>>>>>  required:
>>>>>>>    - compatible
>>>>>>>    - reg
>>>>>>> -  - interrupts
>>>>>>> -  - interrupt-names
>>>>>>>  
>>>>>>>  additionalProperties: true
>>>>>>>  
>>>>>>
>>>>>> cheers,
>>>>>> -roger
>>>
>>>
>

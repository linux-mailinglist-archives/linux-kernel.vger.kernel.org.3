Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFAD50AF6A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 07:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444089AbiDVFKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 01:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444078AbiDVFKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:10:41 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256444B412;
        Thu, 21 Apr 2022 22:07:47 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23M57IgX013026;
        Fri, 22 Apr 2022 00:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650604038;
        bh=1jhdjBmYmmhMCJsX/t+vd/T+6pDWrDfmxcBUmfGeFc8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=pINIU37VyQZP4ww7xdYXgLgr9rzw+kXTjnyxkADXvkE9bhDKex6s/y3F+I3dWz1kj
         MueRQ/ZscMGRgkS+9RE9D+MSzvmpiyrhzzgeuETwi6FQbB7rRa5kCUDJ6/sgqIwzpK
         QAAKs3h1HJP7nqejF6IaiL5KU840Yp+b726D1GNw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23M57Doo016351
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Apr 2022 00:07:18 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 22
 Apr 2022 00:07:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 22 Apr 2022 00:07:17 -0500
Received: from [10.24.69.236] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23M57Cdu059389;
        Fri, 22 Apr 2022 00:07:13 -0500
Message-ID: <c1de4293-a058-5e25-9be2-b61ac39f43a3@ti.com>
Date:   Fri, 22 Apr 2022 10:37:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: usb: tps6598x: Make the interrupts
 property optional
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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
From:   Aswath Govindraju <a-govindraju@ti.com>
In-Reply-To: <ae54dbb1-2b02-cba2-5de2-cf3d9a4e35f5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

On 21/04/22 00:46, Roger Quadros wrote:
> Hi,
> 
> On 18/04/2022 08:19, Aswath Govindraju wrote:
>> Hi Roger,
>>
>> On 14/04/22 23:40, Roger Quadros wrote:
>>> Hi,
>>>
>>> On 14/04/2022 11:31, Aswath Govindraju wrote:
>>>> Support for polling has been added in the driver, which will be used by
>>>> default if interrupts property is not populated. Therefore, remove
>>>> interrupts and interrupt-names from the required properties and add a note
>>>> under interrupts property describing the above support in driver.
>>>>
>>>> Suggested-by: Roger Quadros <rogerq@kernel.org>
>>>
>>> I did not suggest to make interrupts optional by default.
>>>
>>> What I suggested was that if a DT property exists to explicitly
>>> indicate polling mode then interrupts are not required.
>>>
>>
>> ohh okay, got it. However, may I know if adding a dt property to
>> indicate polling for aiding the driver, is the correct approach to model it?
>>
>> In terms of modelling hardware, as interrupts are not connected we are
>> not populating the interrupts property. Shouldn't that be all. If we are
>> adding a property explicitly to indicate polling that can be used by
>> driver, wouldn't that be a software aid being added in the device tree?
> 
> The hardware (tps6598x chip) has an interrupt pin and is expected to be used
> in normal case.
> 
> Some buggy boards might have forgot to connect it. We are adding polling mode only for these buggy boards. ;)
> So polling mode is an exception.
> 

Yes as you mentioned the interrupt line is expected to connected but
there could be cases where there are not enough pins on the SoC and
polling is used intentionally. In these cases this would be a feature
rather than a bug.

Also, I feel like not adding interrupts property in the dt nodes will
indicate polling. My question is why are we adding an extra property
(which is being used only as an aid in the driver) when this feature can
be modeled by making interrupts property optional.

Thanks,
Aswath

> cheers,
> -roger
> 
>>
>> Thanks,
>> Aswath
>>
>>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/usb/ti,tps6598x.yaml | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
>>>> index a4c53b1f1af3..1c4b8c6233e5 100644
>>>> --- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
>>>> +++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
>>>> @@ -25,6 +25,8 @@ properties:
>>>>  
>>>>    interrupts:
>>>>      maxItems: 1
>>>> +    description:
>>>> +      If interrupts are not populated then by default polling will be used.
>>>>  
>>>>    interrupt-names:
>>>>      items:
>>>> @@ -33,8 +35,6 @@ properties:
>>>>  required:
>>>>    - compatible
>>>>    - reg
>>>> -  - interrupts
>>>> -  - interrupt-names
>>>>  
>>>>  additionalProperties: true
>>>>  
>>>
>>> cheers,
>>> -roger


-- 
Thanks,
Aswath

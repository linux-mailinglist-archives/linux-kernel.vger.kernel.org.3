Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2262E50F156
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245695AbiDZGqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245658AbiDZGp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:45:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276B213E1A;
        Mon, 25 Apr 2022 23:42:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C630DB81C58;
        Tue, 26 Apr 2022 06:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CB6C385A0;
        Tue, 26 Apr 2022 06:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650955360;
        bh=Qj1iBgDmQNO80MoLSfQRprtZnwXJZ3zOv82xv0l0JOk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Nyia3qPWjSPOI+GpHMP1BShry0rDvyRrd+RsE8vQ4OOFPjybgraCtD/fqtcN6yOCV
         iqV9edZMMR5kNTVGkliDraRWGpYShEGd2G/s1oG6z+Oo3rirv+UjwI2TSwUeVc1xeX
         5QIWFlKOad1wTwqb9Dp6X5yvz3LX/Vuv94P0Sb3VwIk/SHovMVa/qRGG3GQlRRwDqO
         7i2xC5b4+jWfRwHo3hCC4wPeyxaDRVOp70wRXvbc8kwFeLb0USLzAfXknK03R7WTS0
         TtkaGeKOi1FTVQD8AfonZD17tzZVqAtd/hrPDoBgvERjJI5CoaxrgOnd21BBucm6kw
         0GGKivNxOCnCA==
Message-ID: <89f7d69a-4fc8-33cc-d9ca-5c50dc5381ab@kernel.org>
Date:   Tue, 26 Apr 2022 09:42:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: usb: tps6598x: Make the interrupts
 property optional
Content-Language: en-US
To:     Aswath Govindraju <a-govindraju@ti.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Martin Kepplinger <martink@posteo.de>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220414083120.22535-1-a-govindraju@ti.com>
 <20220414083120.22535-2-a-govindraju@ti.com>
 <be8ab691-98f1-5fb9-fec8-7213a2288d07@kernel.org>
 <56c72151-af5f-366b-b17f-24b9fb6264da@ti.com>
 <ae54dbb1-2b02-cba2-5de2-cf3d9a4e35f5@kernel.org>
 <c1de4293-a058-5e25-9be2-b61ac39f43a3@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <c1de4293-a058-5e25-9be2-b61ac39f43a3@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/04/2022 08:07, Aswath Govindraju wrote:
> Hi Roger,
> 
> On 21/04/22 00:46, Roger Quadros wrote:
>> Hi,
>>
>> On 18/04/2022 08:19, Aswath Govindraju wrote:
>>> Hi Roger,
>>>
>>> On 14/04/22 23:40, Roger Quadros wrote:
>>>> Hi,
>>>>
>>>> On 14/04/2022 11:31, Aswath Govindraju wrote:
>>>>> Support for polling has been added in the driver, which will be used by
>>>>> default if interrupts property is not populated. Therefore, remove
>>>>> interrupts and interrupt-names from the required properties and add a note
>>>>> under interrupts property describing the above support in driver.
>>>>>
>>>>> Suggested-by: Roger Quadros <rogerq@kernel.org>
>>>>
>>>> I did not suggest to make interrupts optional by default.
>>>>
>>>> What I suggested was that if a DT property exists to explicitly
>>>> indicate polling mode then interrupts are not required.
>>>>
>>>
>>> ohh okay, got it. However, may I know if adding a dt property to
>>> indicate polling for aiding the driver, is the correct approach to model it?
>>>
>>> In terms of modelling hardware, as interrupts are not connected we are
>>> not populating the interrupts property. Shouldn't that be all. If we are
>>> adding a property explicitly to indicate polling that can be used by
>>> driver, wouldn't that be a software aid being added in the device tree?
>>
>> The hardware (tps6598x chip) has an interrupt pin and is expected to be used
>> in normal case.
>>
>> Some buggy boards might have forgot to connect it. We are adding polling mode only for these buggy boards. ;)
>> So polling mode is an exception.
>>
> 
> Yes as you mentioned the interrupt line is expected to connected but
> there could be cases where there are not enough pins on the SoC and
> polling is used intentionally. In these cases this would be a feature
> rather than a bug.

I do not agree that this is a feature but a board defect. You can always use
a GPIO expander to add more GPIOs than the SoC can provide.

Type-C events are asynchronous and polling is a waste of CPU time.
What will you do if system suspends and you need to wake up on Type-C
status change?
So polling mode is just an exception for the defective boards or could
be used for debugging.

> 
> Also, I feel like not adding interrupts property in the dt nodes will
> indicate polling. My question is why are we adding an extra property
> (which is being used only as an aid in the driver) when this feature can
> be modeled by making interrupts property optional.

Because interrupt property was not originally optional for this driver.

I would like to hear what Heikki has to say about this.

Any thoughts Heikki?

cheers,
-roger

> 
> Thanks,
> Aswath
> 
>> cheers,
>> -roger
>>
>>>
>>> Thanks,
>>> Aswath
>>>
>>>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/usb/ti,tps6598x.yaml | 4 ++--
>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
>>>>> index a4c53b1f1af3..1c4b8c6233e5 100644
>>>>> --- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
>>>>> +++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
>>>>> @@ -25,6 +25,8 @@ properties:
>>>>>  
>>>>>    interrupts:
>>>>>      maxItems: 1
>>>>> +    description:
>>>>> +      If interrupts are not populated then by default polling will be used.
>>>>>  
>>>>>    interrupt-names:
>>>>>      items:
>>>>> @@ -33,8 +35,6 @@ properties:
>>>>>  required:
>>>>>    - compatible
>>>>>    - reg
>>>>> -  - interrupts
>>>>> -  - interrupt-names
>>>>>  
>>>>>  additionalProperties: true
>>>>>  
>>>>
>>>> cheers,
>>>> -roger
> 
> 

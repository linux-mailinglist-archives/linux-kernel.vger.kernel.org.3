Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829B1509037
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381710AbiDTTTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352685AbiDTTS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:18:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06EB13F30;
        Wed, 20 Apr 2022 12:16:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A49961509;
        Wed, 20 Apr 2022 19:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE11C385A1;
        Wed, 20 Apr 2022 19:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650482167;
        bh=90J9aD9zT3htgXVQTw8ouf0HIcIHMtBImhyv16+lDq8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GEEKKPP+Xa4cHqDtv/sxYRbFCUlGsE+oRLXEZCYd29qOuwCx3b0B45rUe2dZmzqA1
         MFpMFyFOuPjVEgDW1AuGM6rJq4LV0k4RRBrhfy42qFHXC/q6drdTQ6jfEfZJeMoV9e
         k2xy8GrnwxSZx25lIeuOHUvC2Dw5DaJF+x9BcySE/P1yElQyu3hPc2SdagB5dq/bXk
         Ms4JUDIihC8WK/nisnuBX6zRnxglchPx2Xdl6OGtrm2IfiqEsk7A9Hcm3lre2crq0e
         eNS2CvzYRPKnBk4wH1psSdKn5R2u0JcxOhokpTPlhmyE21Vn6dYEDdzc3Nwu1wNHSL
         CTY+xfFz/mtqw==
Message-ID: <ae54dbb1-2b02-cba2-5de2-cf3d9a4e35f5@kernel.org>
Date:   Wed, 20 Apr 2022 22:16:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: usb: tps6598x: Make the interrupts
 property optional
Content-Language: en-US
To:     Aswath Govindraju <a-govindraju@ti.com>
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
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <56c72151-af5f-366b-b17f-24b9fb6264da@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/04/2022 08:19, Aswath Govindraju wrote:
> Hi Roger,
> 
> On 14/04/22 23:40, Roger Quadros wrote:
>> Hi,
>>
>> On 14/04/2022 11:31, Aswath Govindraju wrote:
>>> Support for polling has been added in the driver, which will be used by
>>> default if interrupts property is not populated. Therefore, remove
>>> interrupts and interrupt-names from the required properties and add a note
>>> under interrupts property describing the above support in driver.
>>>
>>> Suggested-by: Roger Quadros <rogerq@kernel.org>
>>
>> I did not suggest to make interrupts optional by default.
>>
>> What I suggested was that if a DT property exists to explicitly
>> indicate polling mode then interrupts are not required.
>>
> 
> ohh okay, got it. However, may I know if adding a dt property to
> indicate polling for aiding the driver, is the correct approach to model it?
> 
> In terms of modelling hardware, as interrupts are not connected we are
> not populating the interrupts property. Shouldn't that be all. If we are
> adding a property explicitly to indicate polling that can be used by
> driver, wouldn't that be a software aid being added in the device tree?

The hardware (tps6598x chip) has an interrupt pin and is expected to be used
in normal case.

Some buggy boards might have forgot to connect it. We are adding polling mode only for these buggy boards. ;)
So polling mode is an exception.

cheers,
-roger

> 
> Thanks,
> Aswath
> 
>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>> ---
>>>  Documentation/devicetree/bindings/usb/ti,tps6598x.yaml | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
>>> index a4c53b1f1af3..1c4b8c6233e5 100644
>>> --- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
>>> @@ -25,6 +25,8 @@ properties:
>>>  
>>>    interrupts:
>>>      maxItems: 1
>>> +    description:
>>> +      If interrupts are not populated then by default polling will be used.
>>>  
>>>    interrupt-names:
>>>      items:
>>> @@ -33,8 +35,6 @@ properties:
>>>  required:
>>>    - compatible
>>>    - reg
>>> -  - interrupts
>>> -  - interrupt-names
>>>  
>>>  additionalProperties: true
>>>  
>>
>> cheers,
>> -roger

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E5C46112A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244076AbhK2JhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:37:12 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34680 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbhK2JfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:35:12 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AT9Vak1073788;
        Mon, 29 Nov 2021 03:31:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638178296;
        bh=TFnaxx1p3b3jfLvM4I/bNr5MSWAF81cwkl7uHkZMNmI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bfhoHolUJlYY3rBn2+qjm4+NrGm0VTn5/q6dKF/Egim5D3EBiPqg8UjanITuT1pZH
         lLrlsbRZMfV4XPOdCVaIA2LudZBVhZF42vqwP+0VA0S5mb01OPvhkz12X2myEdsBFd
         O+xSfyLHtTLi5s8dE19vcshC8NQ+DZn5+g5s2CfE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AT9VaPA069033
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Nov 2021 03:31:36 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 29
 Nov 2021 03:31:36 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 29 Nov 2021 03:31:35 -0600
Received: from [10.250.232.185] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AT9VWOu109337;
        Mon, 29 Nov 2021 03:31:32 -0600
Subject: Re: [PATCH RFC v3 1/4] dt-bindings: mux: Increase the number of
 arguments in mux-controls
To:     Peter Rosin <peda@axentia.se>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
References: <20211123081222.27979-1-a-govindraju@ti.com>
 <20211123081222.27979-2-a-govindraju@ti.com>
 <24781209-928b-dea4-de0b-b103dac8de82@axentia.se>
 <5f455c4d-5edb-4382-1193-a519a7a227a5@ti.com>
 <f6e8cec9-4d74-dda5-d56a-b55ebfadf30a@axentia.se>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <46644e9a-a9e9-4cdb-47e3-f42ebf49f805@ti.com>
Date:   Mon, 29 Nov 2021 15:01:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f6e8cec9-4d74-dda5-d56a-b55ebfadf30a@axentia.se>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 29/11/21 1:45 pm, Peter Rosin wrote:
> 
> 
> On 2021-11-29 05:36, Aswath Govindraju wrote:
>> Hi Peter,
>>
>> On 25/11/21 7:05 pm, Peter Rosin wrote:
>>> Hi!
>>>
>>> You need to have some description on how #mux-control-cells now work.
>>> The previous description is in mux-consumer.yaml and an update there
>>> is needed.
>>>
>>> However, I have realized that the adg792a binding uses #mux-control-cells
>>> to indicate if it should expose its three muxes with one mux-control
>>> and operate the muxes in parallel, or if it should be expose three
>>> independent mux-controls. So, the approach in this series to always
>>> have the #mux-control-cells property fixed at <2> when indicating a
>>> state will not work for that binding. And I see no fix for that binding
>>> without adding a new property.
>>>
>>> So, I would like a different approach. Since I dislike how mux-controls
>>> -after this series- is not (always) specifying a mux-control like the name
>>> says, but instead optionally a specific state, the new property I would
>>> like to add is #mux-state-cells such that it would always be one more
>>> than #mux-control-cells.
>>>
>>> 	mux: mux-controller {
>>> 		compatible = "gpio-mux";
>>> 		#mux-control-cells = <0>;
>>> 		#mux-state-cells = <1>;
>>>
>>> 		mux-gpios = <...>;
>>> 	};
>>>
>>> 	can-phy {
>>> 		compatible = "ti,tcan1043";
>>> 		...
>>> 		mux-states = <&mux 1>;
>>> 	};
>>>
>>> That solves the naming issue, the unused argument for mux-conrtrollers
>>> that previously had #mux-control-cells = <0>, and the binding for adg792a
>>> need no longer be inconsistent.
>>>
>>> Or, how should this be solved? I'm sure there are other options...
>>>
>>
>>
>> I feel that the new approach using mux-state-cells seems to be
>> overpopulating the device tree nodes, when the state can be represented
>> using the control cells. I understand that the definition for
>> mux-controls is to only specify the control line to be used in a given
>> mux. Can't it now be upgraded to also represent the state at which the
>> control line has to be set to?
>>
>> With respect to adg792a, it is inline with the current implementation
>> and the only change I think would be required in the driver is,
> 
> No, that does not work. See below.
> 
>>
>> diff --git a/drivers/mux/adg792a.c b/drivers/mux/adg792a.c
>> index e8fc2fc1ab09..2cd3bb8a40d4 100644
>> --- a/drivers/mux/adg792a.c
>> +++ b/drivers/mux/adg792a.c
>> @@ -73,8 +73,6 @@ static int adg792a_probe(struct i2c_client *i2c)
>>         ret = device_property_read_u32(dev, "#mux-control-cells", &cells);
>>         if (ret < 0)
>>                 return ret;
>> -       if (cells >= 2)
>> -               return -EINVAL;
>>
>>         mux_chip = devm_mux_chip_alloc(dev, cells ? 3 : 1, 0);
> 
> When you add cell #2 with the state, the cells variable will end up
> as 2 always. Which means that there is no way to alloc one mux
> control since "cells ? 3 : 1" will always end up as "3", with no
> easy fix.
> 
> So, your approach does not work for this driver.
> 

Sorry, but how is this different from the case of

#mux-control-cells = 1

If #mux-control-cells is equal to 1 it means the consumer will use a
given control line from the mux chip. The same would be the case when we
will be using, #mux-control-cells is equal to 2, except we can also
provide the state.

If the consumer will use all the lines then #mux-control-cells will be
set to 0. In this condition the state can't be provided from the DT and
the consumer will be controlling the entire mux chip. If
#mux-control-cells is greater than 0 then we will not be able to provide
multiple lines of control using a single mux-controls entry(mux-controls
= <...>;) right? We would have the using multiple mux-controls
entries(mux-controls = <...>, <...>;).

Thanks,
Aswath

> Cheers,
> Peter
> 
>>         if (IS_ERR(mux_chip))
>>
>> And the following series should be compatible with it. If adg792a driver
>> is the only issue then would there be any issue with only changing it
>> and using this implementation?
>>
>> Thanks,
>> Aswath
>>
>>
>>
>>
>>> Cheers,
>>> Peter
>>>
>>> On 2021-11-23 09:12, Aswath Govindraju wrote:
>>>> Increase the allowed number of arguments in mux-controls to add support for
>>>> passing information regarding the state of the mux to be set, for a given
>>>> device.
>>>>
>>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/mux/gpio-mux.yaml       | 2 +-
>>>>  Documentation/devicetree/bindings/mux/mux-controller.yaml | 2 +-
>>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mux/gpio-mux.yaml b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
>>>> index 0a7c8d64981a..c810b7df39de 100644
>>>> --- a/Documentation/devicetree/bindings/mux/gpio-mux.yaml
>>>> +++ b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
>>>> @@ -26,7 +26,7 @@ properties:
>>>>        List of gpios used to control the multiplexer, least significant bit first.
>>>>  
>>>>    '#mux-control-cells':
>>>> -    const: 0
>>>> +    enum: [ 0, 1, 2 ]
>>>>  
>>>>    idle-state:
>>>>      default: -1
>>>> diff --git a/Documentation/devicetree/bindings/mux/mux-controller.yaml b/Documentation/devicetree/bindings/mux/mux-controller.yaml
>>>> index 736a84c3b6a5..0b4b067a97bf 100644
>>>> --- a/Documentation/devicetree/bindings/mux/mux-controller.yaml
>>>> +++ b/Documentation/devicetree/bindings/mux/mux-controller.yaml
>>>> @@ -73,7 +73,7 @@ properties:
>>>>      pattern: '^mux-controller(@.*|-[0-9a-f]+)?$'
>>>>  
>>>>    '#mux-control-cells':
>>>> -    enum: [ 0, 1 ]
>>>> +    enum: [ 0, 1, 2 ]
>>>>  
>>>>    idle-state:
>>>>      $ref: /schemas/types.yaml#/definitions/int32
>>>>
>>
> 


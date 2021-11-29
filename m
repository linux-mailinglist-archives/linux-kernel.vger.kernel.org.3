Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1117446159B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 13:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbhK2NB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:01:27 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33958 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhK2M70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 07:59:26 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1ATCtnAa110837;
        Mon, 29 Nov 2021 06:55:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638190549;
        bh=xpfKTadBXPo99vJqrIrr6yNPN/kKtoRw6ZjKzqOo2hI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aE6aURdqJHi/1iX70+u1w8+uoyaES7cZd+u0IG3x0jORKHp8ckasbN8e6FlbNu27x
         pnEHdVPyEInGT7FMjXyVUYcJg9Boj8vRLbFTd/XecWh8HilAKii+qMYUZI8XCxJtXK
         vfr+6PiTOgNWIuiljypMtKczAvr//2qoTnkkKh4E=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1ATCtnjG007961
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Nov 2021 06:55:49 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 29
 Nov 2021 06:55:48 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 29 Nov 2021 06:55:48 -0600
Received: from [10.250.232.185] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1ATCth3Q070706;
        Mon, 29 Nov 2021 06:55:44 -0600
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
 <46644e9a-a9e9-4cdb-47e3-f42ebf49f805@ti.com>
 <11e3bb89-d706-28c1-b7a5-e61c5cc99c93@axentia.se>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <ef93e2e3-32b7-25de-a800-d0d35c2314f2@ti.com>
Date:   Mon, 29 Nov 2021 18:25:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <11e3bb89-d706-28c1-b7a5-e61c5cc99c93@axentia.se>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 29/11/21 5:58 pm, Peter Rosin wrote:
> Hi Aswath,
> 
> On 2021-11-29 10:31, Aswath Govindraju wrote:
>> Hi Peter,
>>
>> On 29/11/21 1:45 pm, Peter Rosin wrote:
>>>
>>>
>>> On 2021-11-29 05:36, Aswath Govindraju wrote:
>>>> Hi Peter,
>>>>
>>>> On 25/11/21 7:05 pm, Peter Rosin wrote:
>>>>> Hi!
>>>>>
>>>>> You need to have some description on how #mux-control-cells now work.
>>>>> The previous description is in mux-consumer.yaml and an update there
>>>>> is needed.
>>>>>
>>>>> However, I have realized that the adg792a binding uses #mux-control-cells
>>>>> to indicate if it should expose its three muxes with one mux-control
>>>>> and operate the muxes in parallel, or if it should be expose three
>>>>> independent mux-controls. So, the approach in this series to always
>>>>> have the #mux-control-cells property fixed at <2> when indicating a
>>>>> state will not work for that binding. And I see no fix for that binding
>>>>> without adding a new property.
>>>>>
>>>>> So, I would like a different approach. Since I dislike how mux-controls
>>>>> -after this series- is not (always) specifying a mux-control like the name
>>>>> says, but instead optionally a specific state, the new property I would
>>>>> like to add is #mux-state-cells such that it would always be one more
>>>>> than #mux-control-cells.
>>>>>
>>>>> 	mux: mux-controller {
>>>>> 		compatible = "gpio-mux";
>>>>> 		#mux-control-cells = <0>;
>>>>> 		#mux-state-cells = <1>;
>>>>>
>>>>> 		mux-gpios = <...>;
>>>>> 	};
>>>>>
>>>>> 	can-phy {
>>>>> 		compatible = "ti,tcan1043";
>>>>> 		...
>>>>> 		mux-states = <&mux 1>;
>>>>> 	};
>>>>>
>>>>> That solves the naming issue, the unused argument for mux-conrtrollers
>>>>> that previously had #mux-control-cells = <0>, and the binding for adg792a
>>>>> need no longer be inconsistent.
>>>>>
>>>>> Or, how should this be solved? I'm sure there are other options...
>>>>>
>>>>
>>>>
>>>> I feel that the new approach using mux-state-cells seems to be
>>>> overpopulating the device tree nodes, when the state can be represented
>>>> using the control cells. I understand that the definition for
>>>> mux-controls is to only specify the control line to be used in a given
>>>> mux. Can't it now be upgraded to also represent the state at which the
>>>> control line has to be set to?
>>>>
>>>> With respect to adg792a, it is inline with the current implementation
>>>> and the only change I think would be required in the driver is,
>>>
>>> No, that does not work. See below.
>>>
>>>>
>>>> diff --git a/drivers/mux/adg792a.c b/drivers/mux/adg792a.c
>>>> index e8fc2fc1ab09..2cd3bb8a40d4 100644
>>>> --- a/drivers/mux/adg792a.c
>>>> +++ b/drivers/mux/adg792a.c
>>>> @@ -73,8 +73,6 @@ static int adg792a_probe(struct i2c_client *i2c)
>>>>         ret = device_property_read_u32(dev, "#mux-control-cells", &cells);
>>>>         if (ret < 0)
>>>>                 return ret;
>>>> -       if (cells >= 2)
>>>> -               return -EINVAL;
>>>>
>>>>         mux_chip = devm_mux_chip_alloc(dev, cells ? 3 : 1, 0);
>>>
>>> When you add cell #2 with the state, the cells variable will end up
>>> as 2 always. Which means that there is no way to alloc one mux
>>> control since "cells ? 3 : 1" will always end up as "3", with no
>>> easy fix.
>>>
>>> So, your approach does not work for this driver.
>>>
>>
>> Sorry, but how is this different from the case of
>>
>> #mux-control-cells = 1
>>
>> If #mux-control-cells is equal to 1 it means the consumer will use a
>> given control line from the mux chip. The same would be the case when we
>> will be using, #mux-control-cells is equal to 2, except we can also
>> provide the state.
>>
>> If the consumer will use all the lines then #mux-control-cells will be
>> set to 0. In this condition the state can't be provided from the DT and
>> the consumer will be controlling the entire mux chip. If
>> #mux-control-cells is greater than 0 then we will not be able to provide
>> multiple lines of control using a single mux-controls entry(mux-controls
>> = <...>;) right? We would have the using multiple mux-controls
>> entries(mux-controls = <...>, <...>;).
> 
> I think you misunderstand. The adg792a driver operates the chip in
> different modes depending on if you specify 0 or 1 cells. With 0,
> it's not just that the consumer operates three muxes. It is also, and
> more importantly, that the three muxes are operated in parallel without
> the consumer doing anything different with the single mux control it
> sees (even if there are three muxes operated by that single mux
> control).
> 
> That said, yes, you can make it limp along like you describe above.
> But why should it not be possible to specify a specific state when
> the adg792a driver operates the muxes in parallel? And yes, you could
> add some other flag to indicate this mode, but my point is that it
> is silly to add special cases like this if you don't need to. Since
> adding a specific state is the new thing, that is what should be
> added in a way that fits with the old stuff without imposing new
> flags on that old stuff.
> 
> An example: the three muxes in an adg792a chip could be used as
> two muxes for some I2C bus (SCL and SDA signals) and the third mux
> for something unrelated. Suppose that you want to operate the adg792a
> as three parallel muxes so that you mux SCL and SDA simultaneously
> (as is expected by the i2c-mux-gpmux binding, it only expects one
> mux control), and that you want to use the third mux as the enable-
> state for your phy. With your suggested binding you cannot, unless
> you add a mechanism to make the adg792a driver operate its muxes in
> parallel even if there are two cells instead of zero. I.e. without
> that new flag the i2c-mux-gpmux binding needs to see
> 
> 	#mux-control-cells = <0>;
> 
> while your new phy binding instead needs to see
> 
> 	#mux-control-cells = <2>;
> 
> And you obviously can't have it both ways.
> 
> (Sure, it would not be possible to mux the I2C bus while the phy
> is enabled in the above example, but there could be some other
> limitation in place that makes that invalid anyway. And it's just
> an example anyway...)
> 
> A mux-control is potentially a shared resource, and bindings have
> to take this into account.
> 

Understood. Thank you for the explanation. Will correct the
implementation and post a respin.

Regards,
Aswath

> Cheers,
> Peter
> 


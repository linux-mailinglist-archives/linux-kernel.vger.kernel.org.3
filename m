Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F39846B20D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 06:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhLGFGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 00:06:50 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48378 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLGFGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 00:06:49 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B7535He028160;
        Mon, 6 Dec 2021 23:03:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638853385;
        bh=gS5qRRdJFapqcyUi0/EkgP/aZO8T3aw4DbK7IE3Zxc0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Pz2Snm2610uopRqDqLRpN5SKVdG5MH/jaWAGz2NteDWtPRBkZO0QLedjCjBQ51gWT
         B6+OSjTZXDzzXQy0lkGph7eppOO7FfN4QV4y1P/lQ84QuD6qvP7Y/YnWaP1mrlWbuf
         TFWo9US/oTwib6iI7Ajz5odxyAonSyHiOj1W+k+8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B75359M069532
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Dec 2021 23:03:05 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 6
 Dec 2021 23:03:04 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 6 Dec 2021 23:03:04 -0600
Received: from [172.24.145.75] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B7532JM129163;
        Mon, 6 Dec 2021 23:03:02 -0600
Subject: Re: [PATCH v4] ASoC: dt-bindings: davinci-mcasp: convert McASP
 bindings to yaml schema
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        <robh+dt@kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211203120243.24173-1-j-choudhary@ti.com>
 <ed6c9be9-32d3-719a-ee0d-608b228f36b3@gmail.com>
From:   Jayesh Choudhary <j-choudhary@ti.com>
Message-ID: <20449d7b-0524-a8df-7852-a4c495157682@ti.com>
Date:   Tue, 7 Dec 2021 10:33:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ed6c9be9-32d3-719a-ee0d-608b228f36b3@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/12/21 1:50 pm, Péter Ujfalusi wrote:
> Hi,
> 
> On 03/12/2021 14:02, Jayesh Choudhary wrote:
>> Convert the bindings for McASP controllers for TI SOCs from txt
>> to YAML schema.
>>
>> Adds additional properties 'clocks', 'clock-names', 'power-domains',
>> '#sound-dai-cells' and 'port' which were missing from txt file.
>> Removes properties 'sram-size-playback' and 'sram-size-capture'
>> since they are not used.
>> Adds 'dmas' and 'dma-names' in the example which were missing from
>> the txt file.
>> Changes 'interrupts' and 'interrupt-names' from optional to
>> required properties.
>> Changes 'op-mode', 'serial-dir' and 'tdm-slots' to optional properties
>> as they are not needed if the McASP is used only as GPIO.
>>
>> Adds the yaml file in the 'MAINTAINERS' under the heading 'TEXAS
>> INSTRUMENTS ASoC DRIVERS'
>>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>> Changelog:
>> v4:
>> - changes the commit message
>> - adds type and description to relevant properties
>> - changes maxItems for 'serial-dir'
>> - removes properties 'sram-size-playback' and 'sram-size-capture'
>>    as they are not used
>> - removes 'function-gpios'
>> - removes 'num-serializer'
>> - marks 'tdm-slots', 'serial-dir' and 'op-mode' as optional properties
>> - adds the yaml file in MAINTAINERS
>>
> 
> ...
> 
>> +  reg:
>> +    minItems: 1
>> +    items:
>> +      - description: main registers
> 
> The TRM refers to this area as CFG registers
> 
>> +      - description: data port register
> 
> Data registers
> 
>> +
>> +  op-mode:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: I2S - 0 or DIT - 1 operation mode
> 
> 0 - I2S, or 1 - DIT operation mode
> 

I will change the description for 'reg' and 'op-mode'.

>> +    enum:
>> +      - 0
>> +      - 1
>> +
>> +  tdm-slots:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: number of channels over one serializer
>> +    maxItems: 1
> 
> and it has to be between 2 and 32, ignored in DIT mode (384 slots)
> 

Will add minimum and maximum. Should this be added as a conditional
property when op-mode is 0 (I2S mode) and mark it as required?

>> +
>> +  serial-dir:
>> +    description:
>> +      A list of serializer configuration
>> +      Entry is indication for serializer pin direction
>> +      0 - Inactive, 1 - TX, 2 - RX
>> +      All AXR pins should be present in the array even if inactive
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 1
>> +    maxItems: 25
>> +    items:
>> +      minimum: 0
>> +      maximum: 2
>> +      default: 0
> 
> There is no default as all pins must be accounted for.
> 

Okay. Will remove it.

>> +
>> +  tx-num-evt:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: configures WFIFO threshold
> 
> 0 disables the FIFO use
> If the property is missing, it also disables the FIFO use.
> 

Will mention this in the description of both tx/rx-num-evt.

>> +    maxItems: 1
>> +
>> +  rx-num-evt:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: configures RFIFO threshold
>> +    maxItems: 1

>> +
>> +  interrupts:
>> +    anyOf:
>> +      - minItems: 1
>> +        items:
>> +          - description: TX FIFO interrupt
>> +          - description: RX FIFO interrupt
>> +      - items:
>> +          - description: common FIFO interrupt
> 
> These has nothing to do with FIFO, they are just transmit, receive and
> common or combined
> 

Okay.

>> +
>> +  port:
>> +    description: connection for when McASP is used via graph card
>> +    type: object
> 
> I understand that it can be present under the mcasp node as it is part
> of the graph card binding (or a card binding using graph).
> I mean if a new card binding comes around then we need to document it
> here as well?
> 

Specific properties are not marked for the port. So it should not be an
issue. Other alternative is to mark the additional properties as true
but that is not preferred.

Peter,
Any other changes I should make?

>> +
> 

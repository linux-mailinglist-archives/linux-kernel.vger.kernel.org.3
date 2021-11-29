Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FF24613D2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbhK2L1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:27:23 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51266 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241251AbhK2LZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:25:23 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1ATBLtEF088375;
        Mon, 29 Nov 2021 05:21:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638184915;
        bh=I850Fwk6rJ1lSUMvUiIQorbs6z7UwCYX7CIjOR2dyug=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=v5vpszX2ujnSw96JrkT1pYMol3jXMy+vLaPKOgaiJztWNvkUIXPPJgW2JmYhKJ4Aq
         J/arWDeepqQ48TlSXeVYOVMadgjJhLo42UExpzfaXjVoHU9XYIkQQApl6a4sV0XeFd
         8yVmhRKokq2993JjDhowFiiQDaPnqk9rQne4H/1k=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1ATBLtHM061645
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Nov 2021 05:21:55 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 29
 Nov 2021 05:21:54 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 29 Nov 2021 05:21:54 -0600
Received: from [172.24.145.91] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1ATBLp5O046651;
        Mon, 29 Nov 2021 05:21:52 -0600
Subject: Re: [PATCH v3] ASoC: dt-bindings: davinci-mcasp: convert McASP
 bindings to yaml schema
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
CC:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <broonie@kernel.org>,
        "Yadav, Pratyush" <p.yadav@ti.com>
References: <20211126050228.6257-1-j-choudhary@ti.com>
 <64426bc9-1160-97c6-4714-4201b8f7a81c@gmail.com>
From:   Jayesh Choudhary <j-choudhary@ti.com>
Message-ID: <a7bc460f-abf4-1d64-6416-5b50dc15d184@ti.com>
Date:   Mon, 29 Nov 2021 16:51:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <64426bc9-1160-97c6-4714-4201b8f7a81c@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/11/21 12:23 pm, Péter Ujfalusi wrote:
> 
> 
> On 26/11/2021 07:02, Jayesh Choudhary wrote:
>> Convert the bindings for McASP controllers for TI SOCs
>> from txt to YAML schema.
> 
> Can you CC the sound/soc/ti/ maintainer next time, I have found this
> patch in my Spam folder...

Okay. Also, I will add this file in the MAINTAINERS file under the 
heading 'TEXAS INSTRUMENTS ASoC DRIVERS'

> 
>> Adds additional properties 'clocks', 'clock-names', 'power-domains',
>> '#sound-dai-cells',
> 
>> 'num-serializer'
> 
> Which use was removed by 1427e660b49e87cd842dba94158b0fc73030c17e

The dts file of arm SOCs is not updated and was generating an error in 
dtbs_check. I will remove this property.

> 
>> and 'port'
> 
> And what this "port" is?

The mcasp node in the file 'arch/arm/boot/dts/am335x-sl50.dts' has this 
as child node.

> 
>> which were not there in the txt file.
> 
> Most likely for a reason?
> 
>> Adds 'dmas' and 'dma-names' in the example which were not there in
>> the txt file.
>> Changes 'interrupts' and 'interrupt-names' from optional to
>> required properties.
> 
> My biggest problem with the davinci-mcasp-audio.txt is that it was done
> in a wrong way and it just documented the pdata parameters as DT binding.
> If we convert it to yaml, this is going to be 'written in stone'.
> 
>>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---


>> +
>> +  tdm-slots:
> 
> description?

I will add description.

> 
>> +    maxItems: 1
>> +
>> +  serial-dir:
>> +    description:
>> +      A list of serializer configuration
>> +      Entry is indication for serializer pin direction
>> +      0 - Inactive, 1 - TX, 2 - RX
> 
> You should mention that _all_ AXR pins should be present in the array,
> even if they are no in use.
> 
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 1
>> +    maxItems: 16
> 
> a McASP could have up to 25 AXR pins...
> 

Will update the description and the maximum.

>> +    items:
>> +      minimum: 0
>> +      maximum: 2
>> +      default: 0
>> +


>> +
>> +  tx-num-evt:
> 
> description?
> 
>> +    maxItems: 1
>> +
>> +  rx-num-evt:
> 
> description?
> 
>> +    maxItems: 1
>> +
>> +  dismod:
> 
> description?
> 

For the above three properties, is the description in the txt file 
sufficient?



>> +
>> +  sram-size-playback:
>> +    maxItems: 1
> 
> should be dropped, not used
> 
>> +
>> +  sram-size-capture:
>> +    maxItems: 1
> 
> not used, please drop
> 

Okay.

>> +
>> +  interrupts:
>> +    minItems: 1
>> +    items:
>> +      - description: TX FIFO interrupt
>> +      - description: RX FIFO interrupt
> 
> The 'common' does not deserve a description?
> 

Will add this.


>> +  gpio-controller: true
>> +
>> +  "#gpio-cells":
>> +    const: 2
>> +
>> +  function-gpios:
>> +    maxItems: 1
> 
> This is not McASP property, it was an example on how to use a pin as
> GPIO from the outside...
> 

Okay. will remove function-gpios.

>> +
>> +  clocks:
>> +    minItems: 1
>> +    maxItems: 3
>> +
>> +  clock-names:
>> +    minItems: 1
>> +    items:
>> +      - const: fck
>> +      - const: ahclkx
>> +      - const: ahclkr
> 
> I can not find any use in the code for ahclkx/r?
> 

Some arm SOCs had additional clocks in the DT nodes.


>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - dmas
>> +  - dma-names
>> +  - interrupts
>> +  - interrupt-names
>> +  - serial-dir
>> +  - op-mode
>> +  - tdm-slots
> 
> The last three is not needed if the McASP is used only as GPIO.
> The dmas and interrupts should not be needed in this case, but I think
> it is not taken care of atm.
> 
> The tdm-slots is ignored for DIT mode
> 

These were mentioned in txt file as required.
In light of this new knowledge, I will remove 'serial-dir', 'op-mode' 
and 'tdm-slots'.

> 


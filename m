Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352D146D483
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbhLHNip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:38:45 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:39276 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230186AbhLHNio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:38:44 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B8Cclne025876;
        Wed, 8 Dec 2021 14:34:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=b7J60CZ4uwTeJQ0u5OzpaoMz6M8+x9zjkJxexO30IRk=;
 b=aqZItg83GMtGbnmFwvW3j9qQlBHBWfz89uoHpa3RKpGiGAZxvkJqUgASz+ScwILbEC7f
 ntYoJu0dkoYnO5KHKjgpQsqp0NPg3p2PrhQs+R9zI+rYBZSIiF2KOFTs0M7n9jNgj8+O
 NmqXVZN3sOed36SWRtAnm/aIeclCteG93wkeG7ZAV/YOFqjJDv9LbZJ00firjJ3UNoMP
 +z3RzL7M6+9CwD7gU+INJNrUKNZYgSq5A9l5k9s6oojWTxMeKc5yai/g8dJp9YUcVLP0
 qy+wijSFYVhj544GiCPycClbS1Sjo8xo6TyMOfCUPjGE2LUPgY4AWRW6R/RgYHSEuvJZ 2A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ctrpq9x0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 14:34:50 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E5C4A10002A;
        Wed,  8 Dec 2021 14:34:49 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C2C1B2107EE;
        Wed,  8 Dec 2021 14:34:49 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.47) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 8 Dec
 2021 14:34:48 +0100
Subject: Re: [Linux-stm32] [PATCH v2 1/4] ASoC: dt-bindings: stm32: i2s: add
 audio-graph-card port
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Ahmad Fatoum" <a.fatoum@pengutronix.de>
CC:     Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        <alain.volmat@foss.st.com>, <arnaud.pouliquen@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211125144053.774-1-olivier.moysan@foss.st.com>
 <20211125144053.774-2-olivier.moysan@foss.st.com>
 <1637875562.357461.2858318.nullmailer@robh.at.kernel.org>
 <237f56b3-0597-2526-a182-f1fbdd327338@foss.st.com>
 <Yaf4jiZIp8+ndaXs@robh.at.kernel.org>
 <627777a4-7458-88ed-e7c5-d11e3db847b5@foss.st.com>
 <cf5f994b-aecf-e051-f5c9-4a46e6414207@pengutronix.de>
 <cb7f19c0-3826-fcc8-227c-982838acf599@foss.st.com>
 <YbCgSeA1++U82jtn@google.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <fea38140-42be-ece3-b8ea-875ee63f8618@foss.st.com>
Date:   Wed, 8 Dec 2021 14:34:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbCgSeA1++U82jtn@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_05,2021-12-08_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/21 1:08 PM, Lee Jones wrote:
> On Wed, 08 Dec 2021, Alexandre TORGUE wrote:
> 
>> Hi Ahmad
>>
>> On 12/7/21 2:59 PM, Ahmad Fatoum wrote:
>>> Hello Alex,
>>>
>>> On 07.12.21 14:52, Alexandre TORGUE wrote:
>>>> Hi Rob
>>>>
>>>> On 12/1/21 11:34 PM, Rob Herring wrote:
>>>>> On Fri, Nov 26, 2021 at 11:25:27AM +0100, Olivier MOYSAN wrote:
>>>>>> Hi Rob,
>>>>>>
>>>>>> On 11/25/21 10:26 PM, Rob Herring wrote:
>>>>>>> On Thu, 25 Nov 2021 15:40:50 +0100, Olivier Moysan wrote:
>>>>>>>> The STM2 I2S DAI can be connected via the audio-graph-card.
>>>>>>>> Add port entry into the bindings.
>>>>>>>>
>>>>>>>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>>>>>>>> ---
>>>>>>>>      Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml | 5 +++++
>>>>>>>>      1 file changed, 5 insertions(+)
>>>>>>>>
>>>>>>>
>>>>>>> Running 'make dtbs_check' with the schema in this patch gives the
>>>>>>> following warnings. Consider if they are expected or the schema is
>>>>>>> incorrect. These may not be new warnings.
>>>>>>>
>>>>>>> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
>>>>>>> This will change in the future.
>>>>>>>
>>>>>>> Full log is available here: https://patchwork.ozlabs.org/patch/1559750
>>>>>>>
>>>>>>>
>>>>>>> audio-controller@4000b000: 'port' does not match any of the regexes: '^port@[0-9]', 'pinctrl-[0-9]+'
>>>>>>>       arch/arm/boot/dts/stm32mp157a-dk1.dt.yaml
>>>>>>>       arch/arm/boot/dts/stm32mp157c-dk2.dt.yaml
>>>>>>>
>>>>>>
>>>>>> This warning is not a new one.
>>>>>>
>>>>>> The i2s2 node in stm32mp15xx-dkx.dtsi would require the following binding:
>>>>>> port:
>>>>>>       $ref: audio-graph-port.yaml#
>>>>>>       unevaluatedProperties: false
>>>>>>
>>>>>> However the spi binding requires to introduce a unit address:
>>>>>> patternProperties:
>>>>>>      '^port@[0-9]':
>>>>>>        $ref: audio-graph-port.yaml#
>>>>>>        unevaluatedProperties: false
>>>>>>
>>>>>> The warning can be removed by re-ordering the bindings patches in the serie,
>>>>>> as "additionalProperties: true" makes the check more tolerant on extra
>>>>>> properties.
>>>>>
>>>>> That's never right.
>>>>>
>>>>>> The patch "ASoC: dt-bindings: stm32: i2s: add audio-graph-card port" can
>>>>>> even be merely dropped.
>>>>>> So, I suggest to resend the serie without audio-graph-card patch.
>>>>>
>>>>> Only if you aren't using audio-graph-card.
>>>>>
>>>>>>
>>>>>> Does it sound too permissive to you ?
>>>>>
>>>>> I think perhaps you need to combine the schemas into 1. Or you need to
>>>>> restructure your dtsi files such that you only add spi specific
>>>>> properties when spi mode is enabled and only add i2s specific properties
>>>>> when i2s mode is enabled. Or use the /delete-property/ directive.
>>>>
>>>> Initially the aim of this series was to fix a "make W=1" warnings seen on spi and i2s nodes (duplicate unit-address). Moving both nodes in a common node + using a different compatible depending on SPI or I2S usage sounded good) but it is not enough. In this series the common node is named as following: "spi2s2: spi@4000b000". It is fine for a spi usage but if we want to use this "common node" with I2S compatible and specific bindings, the node name remains spi@... and then specific spi checks are done. For this with this series applied we got this issue reported by spi-controller.yaml:
>>>>
>>>> spi@4000b000: port@0: 'compatible' is a required property
>>>>
>>>> So, if we use two separates nodes we got W=1 warning and if we use a common node we got yaml check issue. One possibility would be to use a common node with a new node name (for example i2spi@...) but I think it is not acceptable.
>>>>
>>>> How to progress ?
>>>
>>> Atmel Flexcom can be configured to be either UART, SPI or i2c. Functions
>>> are child nodes of the flexcom node and the MFD driver matching against it,
>>> just configure the operating mode and then calls of_platform_populate.
>>>
>>> Would something along these lines fit here as well?
>>
>> Yes it could but in my mind it was not a MFD as both feature cannot be used
>> at the same time: it is either SPI or I2S and choice is done "statically" in
>> device tree depending board usage.
>>
>> Lee, what it is your feeling about that ? Will you accept to add a MFD
>> driver for this SPI/I2S peripheral whose prurpose is only to populate child
>> node (either SPI or I2S) ?
> 
>  From your description, this doesn't sound like a good fit for MFD.

Thanks Lee for your quick answer. So rename the node frop spi@... to 
i2spi@... (or something else) looks like to be the only solution. 
Depending the compatible used the well schema will be used (if well 
referenced in each stm32 spi and i2s yaml files):

--> spi-controller.yaml in case of "st,stm32h7-spi"

-->audio-controller in case of "st,stm32h7-i2s"

Rob, do you agree?

regards
alex

> 


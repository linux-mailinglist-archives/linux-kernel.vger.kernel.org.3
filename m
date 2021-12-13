Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157A24731BD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240802AbhLMQ1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:27:04 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:49162 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240773AbhLMQ1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:27:02 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BDDUOdp007349;
        Mon, 13 Dec 2021 17:26:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=AMqCiIRkWtkqrv1nskqNq6Hf7G/bZt9G2AkpY5HjNks=;
 b=Wl66NFXfLdXhQCTHLMeLPXIqvpRZTvpvrF/7+ZOyTWqdAc1vjChDZPsyf3p46wp1jJtR
 rse78LD+loSiakgKOkROH/mjztGisSuG2sizK0GYj2Z8fnikIrXScArGxh1y4NqYHZSK
 Fl/16adJaGjldWs8zEAKNRndRgankgPHHMSbqmbOIqEBCIbOLMsuqV7V39Z2hpiuw2Mp
 VTkwA99rMdwKEaYdcUTW7WhKdg5ZHOG3N8wxVDfN9DuCDuiJ6k1xmaNzFyopddElU2eb
 JG+8PNar5q1UHGG3hxuIcszwX7GzpoTNHTWiwqo4eB1eyTJwtJU92EQ5/hViceS5JkgI hA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cx2c72gy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Dec 2021 17:26:40 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AA8EF10002A;
        Mon, 13 Dec 2021 17:26:38 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D3AA8209F5E;
        Mon, 13 Dec 2021 17:26:38 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.45) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 13 Dec
 2021 17:26:37 +0100
Subject: Re: [PATCH v2 1/4] ASoC: dt-bindings: stm32: i2s: add
 audio-graph-card port
To:     Rob Herring <robh@kernel.org>
CC:     Olivier MOYSAN <olivier.moysan@foss.st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Mark Brown <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20211125144053.774-1-olivier.moysan@foss.st.com>
 <20211125144053.774-2-olivier.moysan@foss.st.com>
 <1637875562.357461.2858318.nullmailer@robh.at.kernel.org>
 <237f56b3-0597-2526-a182-f1fbdd327338@foss.st.com>
 <Yaf4jiZIp8+ndaXs@robh.at.kernel.org>
 <627777a4-7458-88ed-e7c5-d11e3db847b5@foss.st.com>
 <CAL_Jsq+ZVU=DR0vXq6YOsrK9-MoUp5DJ6RKHmtL-ZGSxQ7qyJQ@mail.gmail.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <47efb431-6e75-40ac-484c-d84cf4157a04@foss.st.com>
Date:   Mon, 13 Dec 2021 17:26:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+ZVU=DR0vXq6YOsrK9-MoUp5DJ6RKHmtL-ZGSxQ7qyJQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-13_08,2021-12-13_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 12/11/21 9:05 PM, Rob Herring wrote:
> On Tue, Dec 7, 2021 at 7:52 AM Alexandre TORGUE
> <alexandre.torgue@foss.st.com> wrote:
>>
>> Hi Rob
>>
>> On 12/1/21 11:34 PM, Rob Herring wrote:
>>> On Fri, Nov 26, 2021 at 11:25:27AM +0100, Olivier MOYSAN wrote:
>>>> Hi Rob,
>>>>
>>>> On 11/25/21 10:26 PM, Rob Herring wrote:
>>>>> On Thu, 25 Nov 2021 15:40:50 +0100, Olivier Moysan wrote:
>>>>>> The STM2 I2S DAI can be connected via the audio-graph-card.
>>>>>> Add port entry into the bindings.
>>>>>>
>>>>>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>>>>>> ---
>>>>>>     Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml | 5 +++++
>>>>>>     1 file changed, 5 insertions(+)
>>>>>>
>>>>>
>>>>> Running 'make dtbs_check' with the schema in this patch gives the
>>>>> following warnings. Consider if they are expected or the schema is
>>>>> incorrect. These may not be new warnings.
>>>>>
>>>>> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
>>>>> This will change in the future.
>>>>>
>>>>> Full log is available here: https://patchwork.ozlabs.org/patch/1559750
>>>>>
>>>>>
>>>>> audio-controller@4000b000: 'port' does not match any of the regexes: '^port@[0-9]', 'pinctrl-[0-9]+'
>>>>>      arch/arm/boot/dts/stm32mp157a-dk1.dt.yaml
>>>>>      arch/arm/boot/dts/stm32mp157c-dk2.dt.yaml
>>>>>
>>>>
>>>> This warning is not a new one.
>>>>
>>>> The i2s2 node in stm32mp15xx-dkx.dtsi would require the following binding:
>>>> port:
>>>>       $ref: audio-graph-port.yaml#
>>>>       unevaluatedProperties: false
>>>>
>>>> However the spi binding requires to introduce a unit address:
>>>> patternProperties:
>>>>     '^port@[0-9]':
>>>>       $ref: audio-graph-port.yaml#
>>>>       unevaluatedProperties: false
>>>>
>>>> The warning can be removed by re-ordering the bindings patches in the serie,
>>>> as "additionalProperties: true" makes the check more tolerant on extra
>>>> properties.
>>>
>>> That's never right.
>>>
>>>> The patch "ASoC: dt-bindings: stm32: i2s: add audio-graph-card port" can
>>>> even be merely dropped.
>>>> So, I suggest to resend the serie without audio-graph-card patch.
>>>
>>> Only if you aren't using audio-graph-card.
>>>
>>>>
>>>> Does it sound too permissive to you ?
>>>
>>> I think perhaps you need to combine the schemas into 1. Or you need to
>>> restructure your dtsi files such that you only add spi specific
>>> properties when spi mode is enabled and only add i2s specific properties
>>> when i2s mode is enabled. Or use the /delete-property/ directive.
>>
>> Initially the aim of this series was to fix a "make W=1" warnings seen
>> on spi and i2s nodes (duplicate unit-address). Moving both nodes in a
>> common node + using a different compatible depending on SPI or I2S usage
>> sounded good) but it is not enough. In this series the common node is
>> named as following: "spi2s2: spi@4000b000". It is fine for a spi usage
>> but if we want to use this "common node" with I2S compatible and
>> specific bindings, the node name remains spi@... and then specific spi
>> checks are done. For this with this series applied we got this issue
>> reported by spi-controller.yaml:
>>
>> spi@4000b000: port@0: 'compatible' is a required property
>>
>> So, if we use two separates nodes we got W=1 warning and if we use a
>> common node we got yaml check issue. One possibility would be to use a
>> common node with a new node name (for example i2spi@...) but I think it
>> is not acceptable.
> 
> It is acceptable, see this thread[1].
> 
> Rob
> 
> [1] https://lore.kernel.org/all/20211203183517.11390-1-semen.protsenko@linaro.org/

Perfect! So we can abandon this series. Do you know if a patch has been 
sent to also update scripts/Makefile.lib ?

Regards
Alex


> 


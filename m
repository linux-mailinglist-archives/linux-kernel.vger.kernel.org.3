Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE6558D515
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbiHIIBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbiHIIBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:01:15 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D700A10A1;
        Tue,  9 Aug 2022 01:01:13 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2791CqQ9026930;
        Tue, 9 Aug 2022 10:00:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=IITweXBmCUJCE793Kh8gdH4adlIiBjCzt1N8t+Aq8ag=;
 b=2SVGaRGJ2/+BU6SLMnZ7u1nz+BxdKh3A49Vgzn0BvSu1srrOrqsNWCOy/sFdkQMq0Y5L
 ViyPnKJni6urKZJXHviHjIhT2iLUG1QVL8H1y47pS3s4SAWYotMOHEY1EDltO8iY3jOr
 PZzkoyAfzvBJ2B7Zuq3E8WsCfWKAI/DUjYJ3PzLtcoHbAfqFnKi2sMiXsTtt+CbWomxk
 LxVXaj9q6Z/tO9tolTbZtQazBvN7iYXaqjbHIR+gmf8w65nizr/0DzvxG3W/xYpbYwDh
 7ldIXBWS32NNjQENKo9aidpvy2Zin8FONwu8XUSBMwOfLNsyVMDo8CA2dV6gwYI8OBbh Cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hudqh9qra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 10:00:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 82CBC10003D;
        Tue,  9 Aug 2022 10:00:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 78CDE2171E5;
        Tue,  9 Aug 2022 10:00:37 +0200 (CEST)
Received: from [10.201.21.72] (10.75.127.48) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 9 Aug
 2022 10:00:36 +0200
Message-ID: <4137e991-5295-18e5-3d9d-12713723b7c6@foss.st.com>
Date:   Tue, 9 Aug 2022 10:00:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] dt-bindings: spi: stm32: Add st,dual-flash property
 in st,stm32-qspi.yaml
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <devicetree@vger.kernel.org>
References: <20220808074051.44736-1-patrice.chotard@foss.st.com>
 <20220808074051.44736-2-patrice.chotard@foss.st.com>
 <9ad4b4a8-988e-f185-f80c-6f15f341ce8c@linaro.org>
 <79fd7e19-ceef-14fb-5a83-603740735f8f@foss.st.com>
 <38c3977a-0196-1832-ff94-317064cbc439@linaro.org>
 <b15184d6-c9e7-d042-621b-ef4ccd3c87ba@linaro.org>
 <a4310e1d-4eb3-0081-3cd2-8fd060a28bda@foss.st.com>
 <0765cae5-1d07-cbaa-83bf-5553f3f8b242@linaro.org>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <0765cae5-1d07-cbaa-83bf-5553f3f8b242@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_03,2022-08-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/22 09:57, Krzysztof Kozlowski wrote:
> On 09/08/2022 10:52, Patrice CHOTARD wrote:
>> Hi Krzystof
>>
>> On 8/9/22 07:29, Krzysztof Kozlowski wrote:
>>> On 09/08/2022 07:18, Krzysztof Kozlowski wrote:
>>>> On 08/08/2022 19:08, Patrice CHOTARD wrote:
>>>>> Hi Krzystof
>>>>>
>>>>> On 8/8/22 11:01, Krzysztof Kozlowski wrote:
>>>>>> On 08/08/2022 10:40, patrice.chotard@foss.st.com wrote:
>>>>>>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>>>>>>
>>>>>>> Add new property st,dual-flash which allows to use the QSPI interface as a
>>>>>>> communication channel using up to 8 qspi line.
>>>>>>> This mode can only be used if cs-gpios property is defined.
>>>>>>>
>>>>>>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>>>>>> ---
>>>>>>>  Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml | 8 ++++++++
>>>>>>>  1 file changed, 8 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
>>>>>>> index 6ec6f556182f..5e4f9109799e 100644
>>>>>>> --- a/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
>>>>>>> @@ -46,6 +46,14 @@ properties:
>>>>>>>        - const: tx
>>>>>>>        - const: rx
>>>>>>>  
>>>>>>> +  st,dual-flash:
>>>>>>> +    type: boolean
>>>>>>> +    description:
>>>>>>> +      Allows to use 8 data lines in case cs-gpios property is defined.
>>>>>>
>>>>>> It's named dual-flash, but what if you want to use QSPI to connect for
>>>>>> example to FPGA?
>>>>>>
>>>>>> Also how is this related to parallel-memories property?
>>>>>
>>>>> I called it "dual-flash" simply because it enable the dual flash feature of the QSPI block (bit CR_DFM : Dual Flash Mode)
>>>>> which allows to use the 8 lines simultaneously of our dual QSPI block.
>>>>
>>>> And how is it related to existing parallel-memories property?
>>>
>>> Maybe I was not specific enough, so let me rephrase - we have already
>>> parallel-memories property. How this one is different (to justify the
>>> new property)? Is just one memory connected in your case to QSPI over 8
>>> data lines?
>>
>> Our QSPI block is a dual Quad-SPI memory interface, it can managed 2 QSPI flashes independently.
>> There is a specific mode, dual flash mode, where the 2 QSPI flashes can be accessed simultaneously 
>> using 8 data lines. In this case, both throughput and capacity are two fold with this mode.
>>
>> To illustrate, you can have a look at STM32MP157 reference manual (chapter 27.3.1 figure 172) available here:
>> https://www.st.com/resource/en/reference_manual/rm0436-stm32mp157-advanced-armbased-32bit-mpus-stmicroelectronics.pdf 
>>
>> As you mentioned above, the goal is to connect a FPGA to this 8 lines bus.
>>
>> Hope it clarifies enough ;-)
> 
> Only partially. Based on the explanation above, it looks like you want
> to use existing parallel-memories property. Please use that one, instead
> of adding a new property for the same feature.

Okay, got it, i didn't notice the parallel-memories property recently added. 

Thanks for pointing it.
Patrice

> 
> Best regards,
> Krzysztof

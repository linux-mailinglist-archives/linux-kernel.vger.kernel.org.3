Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2BA478C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 14:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbhLQNju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 08:39:50 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40142 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234437AbhLQNjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:39:45 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BH95VjB017120;
        Fri, 17 Dec 2021 14:39:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=sf5uZNarzEN4TERvydNuYULwo+KSEp3Kwpq0Fge0HkQ=;
 b=MahiPfCpeGVzNejyi725J/V/qh66zSiStEiMcYOVnSPo2in4TbexVHP5jf01iOR36i8S
 o/T1JN/ahixC1p3tIYU4fbsrBGwfuNgcxlu2ew9pLaKmGq6TRXPMkz/ZpgbZhb++U/jk
 k+wfrIP/8w++BiqHpZHCmZbplEUdh/R0Teo3AnLV81A3EGW95Dg1MC7ZKp5FKSU1gtPj
 3eTTOf/p/pkvs+IOHqB/fAmAdnb/hrCCTEN9y6XgjQDNrgkBZ3m1TbR0PcIt2DgsB4k7
 QLomrl/6AtCDAroSQyXCMbqPA6FMCxFMRjzk0DPgQgG8FJRoLHlcEjLUJb+De828wEZy aA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3d0hd83gak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Dec 2021 14:39:13 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 21D0910002A;
        Fri, 17 Dec 2021 14:39:12 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F1F692259D3;
        Fri, 17 Dec 2021 14:39:11 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.46) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 17 Dec
 2021 14:39:11 +0100
Subject: Re: [PATCH v2 1/5] dt-bindings: interrupt-controller: Update STM32
 EXTI interrupt controller
To:     Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
References: <20211215105847.2328-1-alexandre.torgue@foss.st.com>
 <20211215105847.2328-2-alexandre.torgue@foss.st.com>
 <YbueUmqyzwS9rOu5@robh.at.kernel.org>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <3f8acbb8-0b7e-2f47-eefc-67e5a7632445@foss.st.com>
Date:   Fri, 17 Dec 2021 14:39:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbueUmqyzwS9rOu5@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-17_05,2021-12-16_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/21 9:15 PM, Rob Herring wrote:
> On Wed, Dec 15, 2021 at 11:58:43AM +0100, Alexandre Torgue wrote:
>> Document new entry "st,exti-mapping" which links EXTI lines with GIC
>> interrupt lines and add an include file to define EXTI interrupt type.
>>
>> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
>> index d19c881b4abc..e08bb51e97a8 100644
>> --- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
>> @@ -41,6 +41,17 @@ properties:
>>       description:
>>         Interrupts references to primary interrupt controller
>>   
>> +  st,exti-mapping:
>> +    $ref: "/schemas/types.yaml#/definitions/uint32-matrix"
>> +    description: |
>> +            Define mapping between EXTI lines and GIC irq lines. Should be:
>> +            st,exti-mapping = <EXTI_LINE GIC_IRQ EXTI_TYPE>, ...;
>> +            With:
>> +            - EXTI_LINE: EXTI line number.
>> +            - GIC_IRQ: GIC IRQ associated to the EXTI line.
>> +            - EXTI_TYPE: STM32_EXTI_TYPE_CONFIGURABLE or STM32_EXTI_TYPE_DIRECT.
>> +              Defined in include/dt-bindings/interrupt-controller/stm32-exti.h
> 
> No custom properties for this. See[1][2][3].
> 

Thanks for inputs. In my case the mapping consists to map an EXTI line 
with a GIC irq line which could be done using interrupt-map (avoiding to 
parse it in my driver). But for each EXTI/GIC association I would like 
also to describe the EXTI_TYPE (which actually describe the well irqchip 
to use inside my exti driver) . This property is not generic and so I 
assume I can't use a generic binding such "interrupt-map".

If the solution consists to use a common binding (i.e. interrupt-map) 
plus a conversion table in exti driver to affect the well irq_chip to 
the well EXTI line then we could envisage to keep the whole mapping 
inside the driver (even if it's not the best solution).

Another solution could be to define two exti irq-controllers (one for 
configurable type and another one for direct type) and use interrupt-map 
inside each. It means to have 2 child node inside (one per irq 
controller) EXTI node.

Alex


> Rob
> 
> 
> [1] https://lore.kernel.org/all/20211122103032.517923-1-maz@kernel.org/
> [2] https://lore.kernel.org/all/87k0g8jlmg.wl-maz@kernel.org/
> [3] https://lore.kernel.org/all/CAL_JsqK2Shj6smam7HgNAmy3UG+vVQPkU3Q0OjyEHOEJB45n0A@mail.gmail.com/
> 


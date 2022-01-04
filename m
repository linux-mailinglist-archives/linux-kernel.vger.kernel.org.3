Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1635E4846BF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 18:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbiADROr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 12:14:47 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51484 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234325AbiADROc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:14:32 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 204G48t9024898;
        Tue, 4 Jan 2022 18:14:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=wHPBT0wAHw5ib6wUpPmF/acTa+Fowr72BsBbL8DTsHo=;
 b=KQHHIZcVFbZjtI+fxihU0Nq30HSY0rAQr+22q6VQLt4cSpbss+UxC6Uxuu106WKR+KaA
 QwbnW4B1tLXIm3RB2SeFLqszyb1a/G1J1dVkpfreGdsvf4IdHWXfjGdz3euhqsavSV6X
 NVdJPaKZa77o9DBrcGW7zTfhQwgITwA+pY6QP8zN7hUBcL6Bx77o92tLPlMWHMB3xZLP
 f8//VOO0/EoarDPl8DCD5Dcw09riZtV1lwSF3hHX2tKNg5yWPmt28v4Lpt9Jg3GiBHJS
 H/Q8+saOQ1gyIXKAyVGDpdtvTgCfhAVZQiQuyoZqQqIp4Ngsh2l44MwSBC4UZho2xZRz Ag== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dcbt0kumc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 18:14:17 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7DD2A10002A;
        Tue,  4 Jan 2022 18:14:15 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7156325805A;
        Tue,  4 Jan 2022 18:14:15 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.44) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 4 Jan
 2022 18:14:14 +0100
Subject: Re: [PATCH v2 1/5] dt-bindings: interrupt-controller: Update STM32
 EXTI interrupt controller
To:     Marc Zyngier <maz@kernel.org>
CC:     Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
References: <20211215105847.2328-1-alexandre.torgue@foss.st.com>
 <20211215105847.2328-2-alexandre.torgue@foss.st.com>
 <YbueUmqyzwS9rOu5@robh.at.kernel.org>
 <3f8acbb8-0b7e-2f47-eefc-67e5a7632445@foss.st.com>
 <87bl1bwj2z.wl-maz@kernel.org>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <e5754264-b263-1090-3017-1a6fec284614@foss.st.com>
Date:   Tue, 4 Jan 2022 18:14:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87bl1bwj2z.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_08,2022-01-04_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc

On 12/20/21 1:34 PM, Marc Zyngier wrote:
> On Fri, 17 Dec 2021 13:39:11 +0000,
> Alexandre TORGUE <alexandre.torgue@foss.st.com> wrote:
>>
>> On 12/16/21 9:15 PM, Rob Herring wrote:
>>> On Wed, Dec 15, 2021 at 11:58:43AM +0100, Alexandre Torgue wrote:
>>>> Document new entry "st,exti-mapping" which links EXTI lines with GIC
>>>> interrupt lines and add an include file to define EXTI interrupt type.
>>>>
>>>> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
>>>> index d19c881b4abc..e08bb51e97a8 100644
>>>> --- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
>>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
>>>> @@ -41,6 +41,17 @@ properties:
>>>>        description:
>>>>          Interrupts references to primary interrupt controller
>>>>    +  st,exti-mapping:
>>>> +    $ref: "/schemas/types.yaml#/definitions/uint32-matrix"
>>>> +    description: |
>>>> +            Define mapping between EXTI lines and GIC irq lines. Should be:
>>>> +            st,exti-mapping = <EXTI_LINE GIC_IRQ EXTI_TYPE>, ...;
>>>> +            With:
>>>> +            - EXTI_LINE: EXTI line number.
>>>> +            - GIC_IRQ: GIC IRQ associated to the EXTI line.
>>>> +            - EXTI_TYPE: STM32_EXTI_TYPE_CONFIGURABLE or STM32_EXTI_TYPE_DIRECT.
>>>> +              Defined in include/dt-bindings/interrupt-controller/stm32-exti.h
>>>
>>> No custom properties for this. See[1][2][3].
>>>
>>
>> Thanks for inputs. In my case the mapping consists to map an EXTI line
>> with a GIC irq line which could be done using interrupt-map (avoiding
>> to parse it in my driver).
> 
> The problem is that 'interrupt-map' defines an interrupt mapping
> between an input and an output, and that mentioning the GIC in such a
> table will only result in your EXTI to be bypassed.
> 
> 'interrupt-map' really is a dispatch table for targeting an interrupt
> controller (or multiple controllers, even), but really isn't the
> correct tool to carry configuration informations to an interrupt
> controller driver.

Ok so let's forget "interrupt-map"

>> But for each EXTI/GIC association I would
>> like also to describe the EXTI_TYPE (which actually describe the well
>> irqchip to use inside my exti driver) . This property is not generic
>> and so I assume I can't use a generic binding such "interrupt-map".
>>
>> If the solution consists to use a common binding (i.e. interrupt-map)
>> plus a conversion table in exti driver to affect the well irq_chip to
>> the well EXTI line then we could envisage to keep the whole mapping
>> inside the driver (even if it's not the best solution).
> 
> A possible solution would be to have:
> 
> - A set of standard 'interrupts' properties describing the output
> signals
> 
> - A set of properties describing the input to output mapping (if
> relevant) and additional configuration information that for the
> interrupt controller driver.

Does it means to have my own description of "interrupt" property using 
xlate function in EXTI driver ?

something like that:

interrupt = <GIC_SPI 6 EXTI_LINE EXTI_TYPE>, ...

regards
Alex
> 
> 	M.
> 


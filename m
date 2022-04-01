Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64594EE784
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 07:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiDAFGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 01:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiDAFGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 01:06:01 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4627512E77C;
        Thu, 31 Mar 2022 22:04:11 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 231547da086462;
        Fri, 1 Apr 2022 00:04:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648789447;
        bh=pdOte0r4buZls7OnQjcRXzHmqGaFLMm2LPj/7uZYXPs=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Cy8sIj06UcND2JtGwRgSpICAq45rrQP9fQJxNECIsUwAX6cWsTsrXkUYZOoBs7Qxx
         kv3EzG+Hl49Bmk8MOzVHahdEd8RGZNbxo+Vm21bZmml3FQ6w2yQN+GyyvubVnFHI1i
         5Sqd0i6vvcEncprMD2gTHSQBq9vYZmQ5H9RM+33A=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 231547ts047177
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Apr 2022 00:04:07 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 1
 Apr 2022 00:04:06 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 1 Apr 2022 00:04:06 -0500
Received: from [10.24.69.236] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 231542Bb017599;
        Fri, 1 Apr 2022 00:04:03 -0500
Message-ID: <1fcac9c3-4b84-6572-ebc6-4d6a50f0132a@ti.com>
Date:   Fri, 1 Apr 2022 10:34:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Add documentation for AM62 USB
 Wrapper module
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20220324073425.18607-1-a-govindraju@ti.com>
 <20220324073425.18607-2-a-govindraju@ti.com>
 <93fe6a41-3b59-2fbc-6f95-833f337815ee@kernel.org>
 <41f79aa5-1e04-53f8-ab21-85fe6039e24e@ti.com>
 <2b33798e-23c2-d4a5-171a-55c28bc40c40@kernel.org>
 <YkZFV4h/vvmKg6iw@robh.at.kernel.org>
From:   Aswath Govindraju <a-govindraju@ti.com>
In-Reply-To: <YkZFV4h/vvmKg6iw@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 01/04/22 05:50, Rob Herring wrote:
> On Thu, Mar 24, 2022 at 12:53:08PM +0100, Krzysztof Kozlowski wrote:
>> On 24/03/2022 12:40, Aswath Govindraju wrote:
>>> Hi Krzysztof,
>>>
>>> On 24/03/22 16:37, Krzysztof Kozlowski wrote:
>>>> On 24/03/2022 08:34, Aswath Govindraju wrote:
>>>>> Add bindings for the TI's AM62 wrapper module for the Synopsys USBSS-DRD
>>>>> controller.
>>>>>
>>>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>>>> ---
>>>>>
>>>>> Changes since v1:
>>>>> - made correction in grammer of clocks property description
>>>>>   and added maxItems in the interrupts property based on comments
>>>>>   received from Roger
>>>>> - corrected the title, fixed the description of
>>>>>   ti,syscon-phy-pll-refclk, added pattern properties and child node
>>>>>   in the example based on the comments from Krzysztof.
>>>>>
>>>>>  .../devicetree/bindings/usb/ti,am62-usb.yaml  | 117 ++++++++++++++++++
>>>>>  1 file changed, 117 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..452bfdc6fb09
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
>>>>> @@ -0,0 +1,117 @@
>>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/usb/ti,am62-usb.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: TI's AM62 wrapper module for the Synopsys USBSS-DRD controller
>>>>> +
>>>>> +maintainers:
>>>>> +  - Aswath Govindraju <a-govindraju@ti.com>
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: ti,am62-usb
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  ranges: true
>>>>> +
>>>>> +  power-domains:
>>>>> +    description:
>>>>> +      PM domain provider node and an args specifier containing
>>>>> +      the USB ISO device id value. See,
>>>>> +      Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  clocks:
>>>>> +    description: Clock phandle to usb2_refclk
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  clock-names:
>>>>> +    items:
>>>>> +      - const: ref
>>>>> +
>>>>> +  id-gpio:
>>>>> +    description:
>>>>> +      GPIO to be used as ID pin
>>>>> +    maxItems: 1
>>>>
>>>> I have doubts about this. If you USB controller handles the ID pin, then
>>>> probably this should be moved to usb-connector.yaml. I did not see
>>>> id-gpio in any other USB controller blocks.
>>>>
>>>
>>> Yes, the USB wrapper handles the ID pin operation only. It also reads
>>> the status of VBUS by reading a register from its MMR and not using a
>>> gpio. After evaluating the role the based on the states if id pin and
>>> VBUS, this role is communicated to the dwc3 core driver using extcon.
>>> There is no way for the dwc3 driver to detect the role on its own.
>>>
>>>
>>> The usb-connector(drivers/usb/common/usb-conn-gpio.c) driver, seems to
>>> be implemented for driving the VBUS, based on ID and VBUS pin status.
>>> However, in case of the above implementation we need to communicate the
>>> detected role to the dwc3 core driver. Also, the wrapper does not
>>> control VBUS but it is the dwc3 core driver that drives the VBUS.
>>> Therefore, I think the usb-connector implementation cannot be used here.
>>
>> I don't think about usb-conn-gpio.c but using the binding generic
>> binding for usb-X-connector and define a connector with ID.
>>
>> Actually Rob could help here.
>>
>> Rob,
>> Should the id-gpio be modeled as a property in this glue/wrapper driver
>> or rather as part of usb-connector child node?
> 
> That's a simple question. Where does the ID GPIO signal go to? The 
> connector, so it goes in the connector node.
> 

Thank you for the clarification. Here ID-gpio is directly read by the
wrapper and hence, I have modeled it as a property in the wrapper dt
node. May I know if this wrong and should the modelling be looked at
differently?

Thanks,
Aswath

> If we have a driver for the usb-connector node, that's news to me. Not 
> that we couldn't, but that has nothing to do with designing the binding.
> 
> Rob


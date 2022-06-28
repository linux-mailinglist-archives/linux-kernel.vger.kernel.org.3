Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D0A55EA7F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiF1RC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiF1RC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:02:27 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279A824F36;
        Tue, 28 Jun 2022 10:02:10 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SCst7f003744;
        Tue, 28 Jun 2022 19:01:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=BMotZWpCCfiO7PWNHjygZuqAvONIxCQdUg4VBGbS1Bk=;
 b=5W4XksWskcYGpqTB/7PPVNM2j59Uq8tmHtokmRoieiG+GLhnfzIKc8GOE8lwy72wwr3x
 b+KYTjGpT8y3kDbSoO1JjQhbSPAJ/OYK0i8r7NO8sJxhKDz3zD6GaUm47ytNREb8xtiI
 8t/1zLFt0IUrmN0ctH9VLVJObE/pcnW0GdwxY/3bWu3QHrOpMfzwaijyKgfSpuv2iirR
 wclQn1degeZ6BwxwYCpEVlhdrad9BTW4a0+/nVrOGD5qoOCc3SGckt++qR6bG12OC8o0
 j+7nBQHgLoFbXcxZL5M5zFpJzsif4sfZQe8mqzz4aDairB5KA4lSv0mPoCBLUaC6i8QO uA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gydcu7k2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 19:01:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E90DE10002A;
        Tue, 28 Jun 2022 19:01:46 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 04786226FDF;
        Tue, 28 Jun 2022 19:01:46 +0200 (CEST)
Received: from [10.48.1.102] (10.75.127.47) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 28 Jun
 2022 19:01:42 +0200
Message-ID: <6ef58f1f-ee8a-b060-6fda-d1388b3ede6d@foss.st.com>
Date:   Tue, 28 Jun 2022 19:01:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/4] dt-bindings: usb: typec: add bindings for stm32g0
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <heikki.krogerus@linux.intel.com>,
        <gregkh@linuxfoundation.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <alexandre.torgue@foss.st.com>
References: <20220624155413.399190-1-fabrice.gasnier@foss.st.com>
 <20220624155413.399190-2-fabrice.gasnier@foss.st.com>
 <ddb0e946-c955-1404-c1cd-c2548f34ec35@linaro.org>
 <845d6817-d2e4-7925-f7f5-da1102514636@foss.st.com>
 <286633b2-43d2-655e-b3f1-54bf5c7a4a21@linaro.org>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <286633b2-43d2-655e-b3f1-54bf5c7a4a21@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_10,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/22 12:28, Krzysztof Kozlowski wrote:
> On 27/06/2022 16:21, Fabrice Gasnier wrote:
>> On 6/24/22 18:16, Krzysztof Kozlowski wrote:
>>> On 24/06/2022 17:54, Fabrice Gasnier wrote:
>>>> This patch adds DT schema documentation for the STM32G0 Type-C controller.
>>>
>>> No "This patch"
>>
>> Hi Krzysztof,
>>
>> ack,
>>
>>>
>>> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
>>>
>>>> STM32G0 provides an integrated USB Type-C and power delivery interface.
>>>> It can be programmed with a firmware to handle UCSI protocol over I2C
>>>> interface. A GPIO is used as an interrupt line.
>>>> It may be used as a wakeup source, so use optional "wakeup-source" and
>>>> "power-domains" properties to support wakeup.
>>>>
>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>>>> ---
>>>>  .../bindings/usb/st,typec-stm32g0.yaml        | 83 +++++++++++++++++++
>>>>  1 file changed, 83 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml b/Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml
>>>> new file mode 100644
>>>> index 0000000000000..b2729bd015a1a
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml
>>>> @@ -0,0 +1,83 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: "http://devicetree.org/schemas/usb/st,typec-stm32g0.yaml#"
>>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>>
>>> No quotes.
>>
>> ack,
>>
>>>
>>>> +
>>>> +title: STMicroelectronics STM32G0 Type-C controller bindings
>>>
>>> s/bindings//
>>
>> ack,
>>
>>>
>>>> +
>>>> +description: |
>>>> +  The STM32G0 MCU can be programmed to control Type-C connector(s) through I2C
>>>> +  typically using the UCSI protocol over I2C, with a dedicated alert
>>>> +  (interrupt) pin.
>>>> +
>>>> +maintainers:
>>>> +  - Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: st,stm32g0-typec
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +
>>>> +  connector:
>>>> +    type: object> +    allOf:
>>>> +      - $ref: ../connector/usb-connector.yaml#
>>>
>>> Full path, so /schemas/connector/...
>>>
>>> unevaluatedProperties: false

Hi Krzysztof,

I Just figured out usb-connector schema has "additionalProperties:
true". Adding "unevaluatedProperties: false" here seem to be useless.
At least at my end, this make any dummy property added in the example
below to be validated without error by the schema.

Should this be updated in usb-connector.yaml instead ?

Shall I omit it here in the end ?

>>
>> ack,
>>
>>>
>>>> +
>>>> +  firmware-name:
>>>> +    description: |
>>>> +      Should contain the name of the default firmware image
>>>> +      file located on the firmware search path
>>>> +
>>>> +  wakeup-source: true
>>>> +  power-domains: true
>>>
>>> maxItems
>>
>> Do you mean maxItems regarding the "power-domains" property ?
> 
> Yes.
> 
>> This will depend on the user platform, where it's used as an I2C device.
>> So I'm not sure this can / should be specified here.
>> Could please you clarify ?
> 
> Then maybe this property is not valid here. Power domains usually are
> used for blocks of a SoC, having common power source and power gating.
> In your case it looks much more like a regulator supply.

This property is used in our implementation to refer to SOC PM domain
for GPIO that is used to wakeup the system. This isn't only a regulator,
this PM domain serves various IPs such as I2C, GPIO, UART... (it manages
regulator and clocks used in low power).

I can limit to 1 item if this is fine for you ?

e.g. maxItems: 1

> 
>>
>>>
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - interrupts
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>>> +    i2c5 {
>>>
>>> Just "i2c"
>>
>> ack,
>>
>>>
>>>> +      #address-cells = <1>;
>>>> +      #size-cells = <0>;
>>>> +
>>>> +      stm32g0@53 {
>>>
>>> Generic node name describing class of the device.
>>
>>
>> I wasn't aware of generic node name for an I2C device (not talking of
>> the controller). I may have missed it.
>>
>> Could you please clarify ?
> 
> The class of a device is not a I2C device. I2C is just a bus. For
> example the generic name for Power Management IC connected over I2C
> (quite common case) is "pmic".
> 
> For USB HCD controllers the generic name is "usb". For USB
> ports/connectors this is "connector". So what is your hardware?
> "interface" is a bit too unspecific to figure it out.

Thanks, I better understand your point now.

A common definition for the hardware here could be "USB Type-C PD
controller". I'll improve this schema title by the way.

I had a quick look in various .dts files. I could find mainly:
- typec-portc@hh
- usb-typec@hh
- typec@hh

Not sure if this has already been discussed in other reviews, it lacks
the "controller" idea in the naming IMHO.
Perhaps something like "typec-pd-controller" or
"usb-typec-pd-controller" could be used here ?

Otherwise, I could adopt the shortest "typec" name if it's fine for you ?

> 
>>
>>>
>>>> +        compatible = "st,stm32g0-typec";
>>>> +        reg = <0x53>;
>>>> +        /* Alert pin on GPIO PE12 */
>>>> +        interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
>>>> +        interrupt-parent = <&gpioe>;
>>>> +
>>>> +        /* Example with one type-C connector */
>>>> +        connector {
>>>> +          compatible = "usb-c-connector";
>>>> +          label = "USB-C";
>>>> +
>>>> +          port {
>>>
>>> This does not look like proper schema of connector.yaml.
>>
>> This refers to graph.yaml [1], where similar example is seen [2].
>>
>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/graph.yaml#L79
>>
>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/graph.yaml#L207
> 
> Just look at the usb-conector schema. It's different. You miss ports.
> Maybe other properties as well.


(I may miss something, and got confused around port/ports earlier)
The graph properties seems to allow both the 'port' and 'ports' syntax
thanks to the graph definition.
The "port" syntax is also used in other typec controller schemas.

There's only one port in this example. Of course other example could use
two or more ports (like for USB HS / SS / aux) which would require using
the "ports" node (with port@0/1/2 childs).

I can adopt the "ports" node if you prefer. As I see it just doesn't
bring much in the current example (The only drawback is this adds one
indentation/node level w.r.t. the bellow example, so not a big deal).

Please advise,

Thanks for reviewing,
Best Regards,
Fabrice

> 
>>
>>     device-1 {
>>         port {
>>             device_1_output: endpoint {
>>                 remote-endpoint = <&device_2_input>;
>>             };
>>         };
>>     };
>>     device-2 {
>>         port {
>>             device_2_input: endpoint {
>>                 remote-endpoint = <&device_1_output>;
>>             };
>>         };
>>     };
>>
>>
>> Could you please clarify this point too ?
>>
>>>
>>>> +            con_usb_c_ep: endpoint {
>>>> +              remote-endpoint = <&usbotg_hs_ep>;
>>>> +            };
>>>> +          };
>>>> +        };
>>>> +      };
>>>> +    };
>>>> +
>>>> +    usbotg_hs {
>>>
>>> Generic node names, no underscores in node names.
>>
>> ack, I guess you'd recommend "usb" here. I'll update it.
> 
> Yes, looks like usb.
> 
> 
> Best regards,
> Krzysztof

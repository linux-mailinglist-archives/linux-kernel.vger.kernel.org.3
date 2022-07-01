Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CF25630F0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbiGAKEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiGAKEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:04:32 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEE47435F;
        Fri,  1 Jul 2022 03:04:30 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2619A93D011383;
        Fri, 1 Jul 2022 12:04:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=s/3+jV9+O1IBVlCw2ZX4h54WPSBF1jcAeoBhVxWXd80=;
 b=TWaVWDsXcFHXhqQeFX8SPdZ0XTgUOPUYYi3oKyWzagcQVVq3oVwzv2VKGFEvWOy7D6k3
 cogzJfDp3/tjAQxoOuuyclfhca2cGNC5I16fHxMccbMQe86x79gQ5jzexYkSjqT6049a
 ZsJQi3dzUoqw73BBK8mHNGulFRZ++vv7O1FTYaYt0tWL14Ngr1ABj1rMt+J4tZ9YSzZT
 YDN0DuaEZ2IZnSIiCXdDs13cUEl54dWRjgBcmL/7heqfWkMonLB88nMPo/NoIA7sYVRr
 V0EQbWD/Q1nOzo1m4VRZrOge7YN3N1yefwijgjEj1ps7aIzSefZtEc/VWSxS95gV4HC3 ZQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h1x2brajt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 12:04:13 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E1D2310002A;
        Fri,  1 Jul 2022 12:04:11 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 65001216EDE;
        Fri,  1 Jul 2022 12:04:11 +0200 (CEST)
Received: from [10.252.5.136] (10.75.127.48) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 1 Jul
 2022 12:04:07 +0200
Message-ID: <dfad8fb5-6205-d620-81eb-5d44b9175e05@foss.st.com>
Date:   Fri, 1 Jul 2022 12:04:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/4] dt-bindings: usb: typec: add bindings for stm32g0
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <alexandre.torgue@foss.st.com>,
        <gregkh@linuxfoundation.org>, <heikki.krogerus@linux.intel.com>
References: <20220624155413.399190-1-fabrice.gasnier@foss.st.com>
 <20220624155413.399190-2-fabrice.gasnier@foss.st.com>
 <ddb0e946-c955-1404-c1cd-c2548f34ec35@linaro.org>
 <845d6817-d2e4-7925-f7f5-da1102514636@foss.st.com>
 <286633b2-43d2-655e-b3f1-54bf5c7a4a21@linaro.org>
 <6ef58f1f-ee8a-b060-6fda-d1388b3ede6d@foss.st.com>
 <f86dd47c-0fc5-6c93-a49e-534610d10c49@linaro.org>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <f86dd47c-0fc5-6c93-a49e-534610d10c49@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_06,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/22 07:54, Krzysztof Kozlowski wrote:
> On 28/06/2022 19:01, Fabrice Gasnier wrote:
> 
>>>>>> +  connector:
>>>>>> +    type: object> +    allOf:
>>>>>> +      - $ref: ../connector/usb-connector.yaml#
>>>>>
>>>>> Full path, so /schemas/connector/...
>>>>>
>>>>> unevaluatedProperties: false
>>
>> Hi Krzysztof,
>>
>> I Just figured out usb-connector schema has "additionalProperties:
>> true". Adding "unevaluatedProperties: false" here seem to be useless.
>> At least at my end, this make any dummy property added in the example
>> below to be validated without error by the schema.
> 
> No, it's expected. The common schema allows additional properties. You
> specific device schema (including common) should not allow anything more
> and this is expressed like you mentioned.
> 
> However depending on the version of dtschema, the
> unevaluatedProperties:false might still be not implemented. AFAIK, Rob
> added it quite recently.
> 
>>
>> Should this be updated in usb-connector.yaml instead ?
> 
> No
> 
>>
>> Shall I omit it here in the end ?
> 
> You need to add here unevaluatedProperties: false (on the level of this
> $ref)
> 
>>
>>>>
>>>> ack,
>>>>
>>>>>
>>>>>> +
>>>>>> +  firmware-name:
>>>>>> +    description: |
>>>>>> +      Should contain the name of the default firmware image
>>>>>> +      file located on the firmware search path
>>>>>> +
>>>>>> +  wakeup-source: true
>>>>>> +  power-domains: true
>>>>>
>>>>> maxItems
>>>>
>>>> Do you mean maxItems regarding the "power-domains" property ?
>>>
>>> Yes.
>>>
>>>> This will depend on the user platform, where it's used as an I2C device.
>>>> So I'm not sure this can / should be specified here.
>>>> Could please you clarify ?
>>>
>>> Then maybe this property is not valid here. Power domains usually are
>>> used for blocks of a SoC, having common power source and power gating.
>>> In your case it looks much more like a regulator supply.
>>
>> This property is used in our implementation to refer to SOC PM domain
>> for GPIO that is used to wakeup the system. This isn't only a regulator,
>> this PM domain serves various IPs such as I2C, GPIO, UART... (it manages
>> regulator and clocks used in low power).
>>
>> I can limit to 1 item if this is fine for you ?
>>
>> e.g. maxItems: 1
> 
> Yes, it's good (assuming it is true :) ).
> 
>>
>>>
>>>>
>>>>>
>>>>>> +
>>>>>> +required:
>>>>>> +  - compatible
>>>>>> +  - reg
>>>>>> +  - interrupts
>>>>>> +
>>>>>> +additionalProperties: false
>>>>>> +
>>>>>> +examples:
>>>>>> +  - |
>>>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>>>>> +    i2c5 {
>>>>>
>>>>> Just "i2c"
>>>>
>>>> ack,
>>>>
>>>>>
>>>>>> +      #address-cells = <1>;
>>>>>> +      #size-cells = <0>;
>>>>>> +
>>>>>> +      stm32g0@53 {
>>>>>
>>>>> Generic node name describing class of the device.
>>>>
>>>>
>>>> I wasn't aware of generic node name for an I2C device (not talking of
>>>> the controller). I may have missed it.
>>>>
>>>> Could you please clarify ?
>>>
>>> The class of a device is not a I2C device. I2C is just a bus. For
>>> example the generic name for Power Management IC connected over I2C
>>> (quite common case) is "pmic".
>>>
>>> For USB HCD controllers the generic name is "usb". For USB
>>> ports/connectors this is "connector". So what is your hardware?
>>> "interface" is a bit too unspecific to figure it out.
>>
>> Thanks, I better understand your point now.
>>
>> A common definition for the hardware here could be "USB Type-C PD
>> controller". I'll improve this schema title by the way.
>>
>> I had a quick look in various .dts files. I could find mainly:
>> - typec-portc@hh
>> - usb-typec@hh
>> - typec@hh
>>
>> Not sure if this has already been discussed in other reviews, it lacks
>> the "controller" idea in the naming IMHO.
>> Perhaps something like "typec-pd-controller" or
>> "usb-typec-pd-controller" could be used here ?
>>
>> Otherwise, I could adopt the shortest "typec" name if it's fine for you ?
> 
> typec sounds good.
> 
>>
>>>
>>>>
>>>>>
>>>>>> +        compatible = "st,stm32g0-typec";
>>>>>> +        reg = <0x53>;
>>>>>> +        /* Alert pin on GPIO PE12 */
>>>>>> +        interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
>>>>>> +        interrupt-parent = <&gpioe>;
>>>>>> +
>>>>>> +        /* Example with one type-C connector */
>>>>>> +        connector {
>>>>>> +          compatible = "usb-c-connector";
>>>>>> +          label = "USB-C";
>>>>>> +
>>>>>> +          port {
>>>>>
>>>>> This does not look like proper schema of connector.yaml.
>>>>
>>>> This refers to graph.yaml [1], where similar example is seen [2].
>>>>
>>>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/graph.yaml#L79
>>>>
>>>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/graph.yaml#L207
>>>
>>> Just look at the usb-conector schema. It's different. You miss ports.
>>> Maybe other properties as well.
>>
>>
>> (I may miss something, and got confused around port/ports earlier)
>> The graph properties seems to allow both the 'port' and 'ports' syntax
>> thanks to the graph definition.
>> The "port" syntax is also used in other typec controller schemas.
>>
>> There's only one port in this example. Of course other example could use
>> two or more ports (like for USB HS / SS / aux) which would require using
>> the "ports" node (with port@0/1/2 childs).
>>
>> I can adopt the "ports" node if you prefer. As I see it just doesn't
>> bring much in the current example (The only drawback is this adds one
>> indentation/node level w.r.t. the bellow example, so not a big deal).
> 
> The graph schema allows, but you include here usb-connector schema which
> requires to put it under "ports". You should not use it differently, so
> I expect here "ports" property, even with one port.

Hi Krzysztof,

This makes senses. I've updated this locally and also put this in .dts
file (not sent yet with this series as I lack some dependencies not yet
upstream).

I'm able to validate the schema, with your statement, by using
dt_binding_check.

/* Example with one type-C connector */
connector {
  compatible = "usb-c-connector";
  label = "USB-C";

  ports {
    #address-cells = <1>;
    #size-cells = <0>;
    port@0 {
      reg = <0>;
      con_usb_c_ep: endpoint {
        remote-endpoint = <&usb_ep>;
      };
    };
  };
};

Still when build the .dts (in my downstream, with W=1) I observe various
case, for a single port usage (e.g. USB HS only).


With above example I get:
---
Warning (graph_child_address): /soc/..../connector/ports: graph node has
single child node 'port@0', #address-cells/#size-cells are not necessary

Remove them as not necessary (suggested by this warning):
---
/* Example with one type-C connector */
connector {
  compatible = "usb-c-connector";
  label = "USB-C";

  ports {
    port {
      con_usb_c_ep: endpoint {
        remote-endpoint = <&usb_ep>;
      };
    };
  };
};

Then I no longer get this warning upon build. But the dtbs_check complains:
---
connector: ports: 'port@0' is a required property
	From schema: ..
Documentation/devicetree/bindings/connector/usb-connector.yaml

So It looks like to me there's something missing to handle the single
port case in usb-connector.yaml, when using the "ports".

Maybe usb-connector could be updated to handle "port" (w/o unit-addr) ?
I'm talking about:
    required:
      - port@0

So, I came up with:

--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -176,6 +176,9 @@ properties:
       port number as described below.

     properties:
+      port:
+        $ref: /schemas/graph.yaml#/properties/port
+
       port@0:
         $ref: /schemas/graph.yaml#/properties/port
         description: High Speed (HS), present in all connectors.
@@ -189,8 +192,11 @@ properties:
         description: Sideband Use (SBU), present in USB-C. This
describes the
           alternate mode connection of which SBU is a part.

-    required:
-      - port@0
+    oneOf:
+      - required:
+          - port
+      - required:
+          - port@0


Do you agree on this approach ? (I can add a pre-cursor patch to this
series, to handle the single port case)


Please advise,
Best Regards,
Fabrice

> 
> Best regards,
> Krzysztof

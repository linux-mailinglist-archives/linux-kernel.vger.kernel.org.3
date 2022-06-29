Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA87455F5DA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 07:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiF2Fyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 01:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiF2Fyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 01:54:37 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DC113F65
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 22:54:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id q6so30250366eji.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 22:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oHw/+xoj6M1ZZO8v925Uv2hnFfP6UJZ/2begt2QtJMw=;
        b=JNAnBoXi2m7HwUMHD+Kl0YKox5Ft9n7pvymCrPBxw9eL5lkcJH6Fo17IHjKPjUMEXX
         e8PPfNme88MfJGJ5onIB2O1yOMlxzax8j9bmCPcP66mytFV0BrbeTol1VDZH8hHLb1pS
         GrzLj4CX+QmzX8kwo3H26ZsEzdJJa5bmiepmRAI1q0xovkyeLj87wpazuljXzN7cAPvb
         avmdbMpTks9P4Lb8U3Y1NFK9gT135/URjogUg7q1fRX26NsfKt6YL9YipdorHHNR3JYR
         2GYX0CWYIZedB1ze4iPiw9DPBD2Oy9gHza1W1cTylAGiOVbSvOFuCf77MY4FqTUneD8P
         WSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oHw/+xoj6M1ZZO8v925Uv2hnFfP6UJZ/2begt2QtJMw=;
        b=rlYBBxfvT8WQ30hvFJcnArKnklYBfKBJ0cj+eAcs7+3YD2wmlOreFPpZ0saQaFa+Yf
         4r+Kx6WHqxh38v2vPs52falrZPX+g170Qp8u0BPzrnwHJcitY07SMPY0CxvFwTK/8xqj
         lX5PuM8dHZ/SES5jGkgE7kyQkGMWb1QPXh/qGDHNmETPytCtoUR0FCl62KnkmQdbHQTJ
         gyTXSx16/WOrRMv2yxw97HDaAZAZXp2lU9R+n4NIALLTRIrWkREBhOBqW8jX3+I43Dqr
         AyzOTdbZ0ocdUu0Fym+dhQUCowsjZP8n8xtkELCw6ulM8l/1isFEyDBXc01FHMKY79kT
         uS8w==
X-Gm-Message-State: AJIora+094TL4jApIsE9x6ecodE4u5UbseaR5Ub3vtGwf1QaEDYh8jj6
        y/fEGmVFjFILgysscaADLlq0+g==
X-Google-Smtp-Source: AGRyM1uVMnNRwFRWLEyAWsZnCgUwfDa5H0WPXvalL8dPym5vOfaRVZAaEOX474g1jOofoa+0SDxCTQ==
X-Received: by 2002:a17:907:1612:b0:722:e1b9:45d0 with SMTP id hb18-20020a170907161200b00722e1b945d0mr1601638ejc.439.1656482074020;
        Tue, 28 Jun 2022 22:54:34 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id t23-20020a170906609700b006fed062c68esm7394505ejj.182.2022.06.28.22.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 22:54:33 -0700 (PDT)
Message-ID: <f86dd47c-0fc5-6c93-a49e-534610d10c49@linaro.org>
Date:   Wed, 29 Jun 2022 07:54:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] dt-bindings: usb: typec: add bindings for stm32g0
 controller
Content-Language: en-US
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>, robh+dt@kernel.org,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        amelie.delaunay@foss.st.com, alexandre.torgue@foss.st.com
References: <20220624155413.399190-1-fabrice.gasnier@foss.st.com>
 <20220624155413.399190-2-fabrice.gasnier@foss.st.com>
 <ddb0e946-c955-1404-c1cd-c2548f34ec35@linaro.org>
 <845d6817-d2e4-7925-f7f5-da1102514636@foss.st.com>
 <286633b2-43d2-655e-b3f1-54bf5c7a4a21@linaro.org>
 <6ef58f1f-ee8a-b060-6fda-d1388b3ede6d@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6ef58f1f-ee8a-b060-6fda-d1388b3ede6d@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2022 19:01, Fabrice Gasnier wrote:

>>>>> +  connector:
>>>>> +    type: object> +    allOf:
>>>>> +      - $ref: ../connector/usb-connector.yaml#
>>>>
>>>> Full path, so /schemas/connector/...
>>>>
>>>> unevaluatedProperties: false
> 
> Hi Krzysztof,
> 
> I Just figured out usb-connector schema has "additionalProperties:
> true". Adding "unevaluatedProperties: false" here seem to be useless.
> At least at my end, this make any dummy property added in the example
> below to be validated without error by the schema.

No, it's expected. The common schema allows additional properties. You
specific device schema (including common) should not allow anything more
and this is expressed like you mentioned.

However depending on the version of dtschema, the
unevaluatedProperties:false might still be not implemented. AFAIK, Rob
added it quite recently.

> 
> Should this be updated in usb-connector.yaml instead ?

No

> 
> Shall I omit it here in the end ?

You need to add here unevaluatedProperties: false (on the level of this
$ref)

> 
>>>
>>> ack,
>>>
>>>>
>>>>> +
>>>>> +  firmware-name:
>>>>> +    description: |
>>>>> +      Should contain the name of the default firmware image
>>>>> +      file located on the firmware search path
>>>>> +
>>>>> +  wakeup-source: true
>>>>> +  power-domains: true
>>>>
>>>> maxItems
>>>
>>> Do you mean maxItems regarding the "power-domains" property ?
>>
>> Yes.
>>
>>> This will depend on the user platform, where it's used as an I2C device.
>>> So I'm not sure this can / should be specified here.
>>> Could please you clarify ?
>>
>> Then maybe this property is not valid here. Power domains usually are
>> used for blocks of a SoC, having common power source and power gating.
>> In your case it looks much more like a regulator supply.
> 
> This property is used in our implementation to refer to SOC PM domain
> for GPIO that is used to wakeup the system. This isn't only a regulator,
> this PM domain serves various IPs such as I2C, GPIO, UART... (it manages
> regulator and clocks used in low power).
> 
> I can limit to 1 item if this is fine for you ?
> 
> e.g. maxItems: 1

Yes, it's good (assuming it is true :) ).

> 
>>
>>>
>>>>
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>> +  - reg
>>>>> +  - interrupts
>>>>> +
>>>>> +additionalProperties: false
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>>>> +    i2c5 {
>>>>
>>>> Just "i2c"
>>>
>>> ack,
>>>
>>>>
>>>>> +      #address-cells = <1>;
>>>>> +      #size-cells = <0>;
>>>>> +
>>>>> +      stm32g0@53 {
>>>>
>>>> Generic node name describing class of the device.
>>>
>>>
>>> I wasn't aware of generic node name for an I2C device (not talking of
>>> the controller). I may have missed it.
>>>
>>> Could you please clarify ?
>>
>> The class of a device is not a I2C device. I2C is just a bus. For
>> example the generic name for Power Management IC connected over I2C
>> (quite common case) is "pmic".
>>
>> For USB HCD controllers the generic name is "usb". For USB
>> ports/connectors this is "connector". So what is your hardware?
>> "interface" is a bit too unspecific to figure it out.
> 
> Thanks, I better understand your point now.
> 
> A common definition for the hardware here could be "USB Type-C PD
> controller". I'll improve this schema title by the way.
> 
> I had a quick look in various .dts files. I could find mainly:
> - typec-portc@hh
> - usb-typec@hh
> - typec@hh
> 
> Not sure if this has already been discussed in other reviews, it lacks
> the "controller" idea in the naming IMHO.
> Perhaps something like "typec-pd-controller" or
> "usb-typec-pd-controller" could be used here ?
> 
> Otherwise, I could adopt the shortest "typec" name if it's fine for you ?

typec sounds good.

> 
>>
>>>
>>>>
>>>>> +        compatible = "st,stm32g0-typec";
>>>>> +        reg = <0x53>;
>>>>> +        /* Alert pin on GPIO PE12 */
>>>>> +        interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
>>>>> +        interrupt-parent = <&gpioe>;
>>>>> +
>>>>> +        /* Example with one type-C connector */
>>>>> +        connector {
>>>>> +          compatible = "usb-c-connector";
>>>>> +          label = "USB-C";
>>>>> +
>>>>> +          port {
>>>>
>>>> This does not look like proper schema of connector.yaml.
>>>
>>> This refers to graph.yaml [1], where similar example is seen [2].
>>>
>>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/graph.yaml#L79
>>>
>>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/graph.yaml#L207
>>
>> Just look at the usb-conector schema. It's different. You miss ports.
>> Maybe other properties as well.
> 
> 
> (I may miss something, and got confused around port/ports earlier)
> The graph properties seems to allow both the 'port' and 'ports' syntax
> thanks to the graph definition.
> The "port" syntax is also used in other typec controller schemas.
> 
> There's only one port in this example. Of course other example could use
> two or more ports (like for USB HS / SS / aux) which would require using
> the "ports" node (with port@0/1/2 childs).
> 
> I can adopt the "ports" node if you prefer. As I see it just doesn't
> bring much in the current example (The only drawback is this adds one
> indentation/node level w.r.t. the bellow example, so not a big deal).

The graph schema allows, but you include here usb-connector schema which
requires to put it under "ports". You should not use it differently, so
I expect here "ports" property, even with one port.

Best regards,
Krzysztof

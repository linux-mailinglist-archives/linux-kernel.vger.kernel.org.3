Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0E055D8A8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344427AbiF1K20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344355AbiF1K2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:28:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6E81A3A6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:28:20 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r20so17023161wra.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=p/DPfFSM3jMKKRZmtfjvPDQnkcVkhnWQ37ffkh65f6Y=;
        b=kbqssuFbstijiBxN6ukx6bRt4t+S2ydyiIOa+5yRebAeQDj9rv1637vsz8qbYjSvzY
         1prScvFpP1aja07+ePjJLLSe0tcobzljhMEsQQ4HI4HrLoN+1E0WP6QJkMZpQm+3RqRt
         JMAZ52JEFjzGjqKjextdPoPKNm+4ScuxsFvfA8DtYvRhIH/Owjmmn7p3+A4mJqESf8JM
         JWK00NjnN3UGfMeOLoqNz6sHkONVnRBi+zWo7civeBkmuNb37qef44uOR0eVq136DO8y
         TK16/3aXaOchaTNSlk8X7o51ojZvqdjD8HNrP+HOx6/ygJ5IDjTv31qhrwLbb4ePzLV/
         lKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p/DPfFSM3jMKKRZmtfjvPDQnkcVkhnWQ37ffkh65f6Y=;
        b=i4QtA8QY8DPqocXZC895nF1kXanbCu0cYdB06toKXQm0qCSELaSRvQcNMvM50SF0fo
         J6NMFzefgZvOqRnmrR1yPIIdr4i/OYzbrPHioAJkQBa5n0QMMoPj1dM9h/vv4FY33a7d
         GsCz7xXy1EQU1YrsDJMF/GNaQ+RtUARxppSgFZX+Qj8uiM6CWQTx52VFp7SQghIgZcGJ
         KIKWUUXDiAi4SqIV29APtqE3Kx0MaBVgfu5pDvMcHTnyoMjqa4QhYdPE9WijsuzRHEkJ
         fqIiPuv5whaR80UtEyw3Uv9KYDs465M0tO9Qfd4ArBMJaErKYt4RpwLVayDIAO/dgO7H
         r2Vw==
X-Gm-Message-State: AJIora8oOZSmSj1/qO73q+A2x+KRoXoGjV4Xx559yqIYJ6XiJygmAaEn
        VxnfqYYEihtldvWFpV94j6DS5g==
X-Google-Smtp-Source: AGRyM1uVApxImBBVLBU8ZUemhn0pYLASxjCLbV2ScD5PAtjEBQfdswOb8laC00d1cYSYxMIRRCoQjQ==
X-Received: by 2002:a5d:5483:0:b0:21b:88d5:e725 with SMTP id h3-20020a5d5483000000b0021b88d5e725mr17344077wrv.82.1656412099281;
        Tue, 28 Jun 2022 03:28:19 -0700 (PDT)
Received: from [192.168.0.252] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 4-20020a1c1904000000b0039c4506bd25sm19611110wmz.14.2022.06.28.03.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 03:28:18 -0700 (PDT)
Message-ID: <286633b2-43d2-655e-b3f1-54bf5c7a4a21@linaro.org>
Date:   Tue, 28 Jun 2022 12:28:17 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <845d6817-d2e4-7925-f7f5-da1102514636@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2022 16:21, Fabrice Gasnier wrote:
> On 6/24/22 18:16, Krzysztof Kozlowski wrote:
>> On 24/06/2022 17:54, Fabrice Gasnier wrote:
>>> This patch adds DT schema documentation for the STM32G0 Type-C controller.
>>
>> No "This patch"
> 
> Hi Krzysztof,
> 
> ack,
> 
>>
>> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
>>
>>> STM32G0 provides an integrated USB Type-C and power delivery interface.
>>> It can be programmed with a firmware to handle UCSI protocol over I2C
>>> interface. A GPIO is used as an interrupt line.
>>> It may be used as a wakeup source, so use optional "wakeup-source" and
>>> "power-domains" properties to support wakeup.
>>>
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>>> ---
>>>  .../bindings/usb/st,typec-stm32g0.yaml        | 83 +++++++++++++++++++
>>>  1 file changed, 83 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml b/Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml
>>> new file mode 100644
>>> index 0000000000000..b2729bd015a1a
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml
>>> @@ -0,0 +1,83 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: "http://devicetree.org/schemas/usb/st,typec-stm32g0.yaml#"
>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>
>> No quotes.
> 
> ack,
> 
>>
>>> +
>>> +title: STMicroelectronics STM32G0 Type-C controller bindings
>>
>> s/bindings//
> 
> ack,
> 
>>
>>> +
>>> +description: |
>>> +  The STM32G0 MCU can be programmed to control Type-C connector(s) through I2C
>>> +  typically using the UCSI protocol over I2C, with a dedicated alert
>>> +  (interrupt) pin.
>>> +
>>> +maintainers:
>>> +  - Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: st,stm32g0-typec
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  connector:
>>> +    type: object> +    allOf:
>>> +      - $ref: ../connector/usb-connector.yaml#
>>
>> Full path, so /schemas/connector/...
>>
>> unevaluatedProperties: false
> 
> ack,
> 
>>
>>> +
>>> +  firmware-name:
>>> +    description: |
>>> +      Should contain the name of the default firmware image
>>> +      file located on the firmware search path
>>> +
>>> +  wakeup-source: true
>>> +  power-domains: true
>>
>> maxItems
> 
> Do you mean maxItems regarding the "power-domains" property ?

Yes.

> This will depend on the user platform, where it's used as an I2C device.
> So I'm not sure this can / should be specified here.
> Could please you clarify ?

Then maybe this property is not valid here. Power domains usually are
used for blocks of a SoC, having common power source and power gating.
In your case it looks much more like a regulator supply.

> 
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +    i2c5 {
>>
>> Just "i2c"
> 
> ack,
> 
>>
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>> +
>>> +      stm32g0@53 {
>>
>> Generic node name describing class of the device.
> 
> 
> I wasn't aware of generic node name for an I2C device (not talking of
> the controller). I may have missed it.
> 
> Could you please clarify ?

The class of a device is not a I2C device. I2C is just a bus. For
example the generic name for Power Management IC connected over I2C
(quite common case) is "pmic".

For USB HCD controllers the generic name is "usb". For USB
ports/connectors this is "connector". So what is your hardware?
"interface" is a bit too unspecific to figure it out.

> 
>>
>>> +        compatible = "st,stm32g0-typec";
>>> +        reg = <0x53>;
>>> +        /* Alert pin on GPIO PE12 */
>>> +        interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
>>> +        interrupt-parent = <&gpioe>;
>>> +
>>> +        /* Example with one type-C connector */
>>> +        connector {
>>> +          compatible = "usb-c-connector";
>>> +          label = "USB-C";
>>> +
>>> +          port {
>>
>> This does not look like proper schema of connector.yaml.
> 
> This refers to graph.yaml [1], where similar example is seen [2].
> 
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/graph.yaml#L79
> 
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/graph.yaml#L207

Just look at the usb-conector schema. It's different. You miss ports.
Maybe other properties as well.

> 
>     device-1 {
>         port {
>             device_1_output: endpoint {
>                 remote-endpoint = <&device_2_input>;
>             };
>         };
>     };
>     device-2 {
>         port {
>             device_2_input: endpoint {
>                 remote-endpoint = <&device_1_output>;
>             };
>         };
>     };
> 
> 
> Could you please clarify this point too ?
> 
>>
>>> +            con_usb_c_ep: endpoint {
>>> +              remote-endpoint = <&usbotg_hs_ep>;
>>> +            };
>>> +          };
>>> +        };
>>> +      };
>>> +    };
>>> +
>>> +    usbotg_hs {
>>
>> Generic node names, no underscores in node names.
> 
> ack, I guess you'd recommend "usb" here. I'll update it.

Yes, looks like usb.


Best regards,
Krzysztof

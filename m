Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6DD53136E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbiEWPjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238043AbiEWPjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:39:48 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DAA18E35
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:39:47 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a23so17661263ljd.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j7w3vFu2/JjysHkDMsR7t2P3IRWVLaZtVOZBrHf5Z50=;
        b=UMj/nBuut346RBNVzjPaQHcaii39eb6UdUfzYfUppBqhPapVE2Oq8eaX3g+kg+w1hf
         ktH3nTD9bWTRrevMgmDuMtru8aQmFRFQWU0DZ46cp/0X/SxahU4Z5+sZtYvLoU0cXade
         u+cs/by/n52BTv8OFu6HuZTz/7RofPI9iFRd69+W1ZtzIOVz/0iLSHYGvyv96tnApHpw
         qJPI+kJeOv2FZvZm7dtonX1Go43nhGzWmls0n7sAKhsMPz45plyrLU02hxrxnTg0ANfS
         /bm07llvuTmeHkmXgBWK87csJ9hxgyDa7GCxTAPqV0ubRCcMFxyMMOs1Kyk8gtcjhL7N
         2l/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j7w3vFu2/JjysHkDMsR7t2P3IRWVLaZtVOZBrHf5Z50=;
        b=JmCuu0oV7MZZ4hG0XvocLLA/z7DGU8Vsp8LZdTPxf2DecM2rE4mlwdpnBBrmHftlTy
         fWz4iFs76j2Fn8JsSw22HzLdltfnoUvSHz98qDLEBqdqnXYcrB/S+dzGXM5UN+SeYlH8
         orsAf3FzZi47rNDlRIkO2M0amgQ230d0Ap4YErfpC/c6xeN+N2kI9xADXYokVDiPwqkk
         8hw+hqzGTd1q+qE5zNUrC5dhSLBXMoj0mVBCAH3mlgrPAW4YiPfTipuGoTJeixMjjyYL
         b86rIUbLm6rYx96pqi0WaLO9Hcf99eT13gbVh7YXLrxWh2+VoirXnXlyht7lgUnnYoSj
         biyg==
X-Gm-Message-State: AOAM533tm/+VucS1GoI13QPAEuo0uafrnzOMJ8J+BJLef5wdaty4zR/Y
        5ifuWpXqRZr9QXfG8GG86/wpKw==
X-Google-Smtp-Source: ABdhPJzBcwxw3J8gC+HU9XEg2GjIXHOYRVUjF2iN6KgxWFDA3XeMvl6PErRLJA6sI8uYHCW60V72AQ==
X-Received: by 2002:a2e:8804:0:b0:253:defb:b7a with SMTP id x4-20020a2e8804000000b00253defb0b7amr9143590ljh.470.1653320385331;
        Mon, 23 May 2022 08:39:45 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a23-20020a2e8317000000b00253e32aa2c4sm1404539ljh.126.2022.05.23.08.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 08:39:44 -0700 (PDT)
Message-ID: <0ab6c10b-48e4-9122-e806-68294e8e3dd5@linaro.org>
Date:   Mon, 23 May 2022 17:39:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] dt-bindings: leds: Add bindings for the TLC5925
 controller
Content-Language: en-US
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220523084958.2723943-1-jjhiblot@traphandler.com>
 <20220523084958.2723943-2-jjhiblot@traphandler.com>
 <d12a0afc-c040-5615-fc0d-70a5c29bbf0a@linaro.org>
 <0e1e417a-6444-ddb5-5c48-c89bd78c5fe8@traphandler.com>
 <4f766cdb-a33b-2470-5b2e-3945c821ce6c@linaro.org>
 <bcf87cc8-85dc-efd6-1076-91e56ec4286c@traphandler.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <bcf87cc8-85dc-efd6-1076-91e56ec4286c@traphandler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2022 17:37, Jean-Jacques Hiblot wrote:
> 
> On 23/05/2022 17:30, Krzysztof Kozlowski wrote:
>> On 23/05/2022 17:16, Jean-Jacques Hiblot wrote:
>>> On 23/05/2022 12:14, Krzysztof Kozlowski wrote:
>>>> On 23/05/2022 10:49, Jean-Jacques Hiblot wrote:
>>>>> Add bindings documentation for the TLC5925 LED controller.
>>>>>
>>>>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>>>> Thank you for your patch. There is something to discuss/improve.
>>>>
>>>>> ---
>>>>> devicetree@vger.kernel.org
>>>>>    .../bindings/leds/leds-tlc5925.yaml           | 100 ++++++++++++++++++
>>>>>    1 file changed, 100 insertions(+)
>>>>>    create mode 100644 Documentation/devicetree/bindings/leds/leds-tlc5925.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml b/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..156db599d5a1
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml
>>>> Filename: vendor,device
>>>> so "ti,tlc5925-leds.yaml" for example.
>>>>
>>>>
>>>>
>>>>> @@ -0,0 +1,100 @@
>>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/leds/leds-tlc5925.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: LEDs connected to TI TLC5925 controller
>>>>> +
>>>>> +maintainers:
>>>>> +  - Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>>>>> +
>>>>> +description: |
>>>>> +  The TLC5925 is a low-power 16-channel constant-current LED sink driver.
>>>>> +  It is controlled through a SPI interface.
>>>>> +  It is built around a shift register and latches which convert serial
>>>>> +  input data into a parallel output. Several TLC5925 can be chained to
>>>>> +  control more than 16 LEDs with a single chip-select.
>>>>> +  The brightness level cannot be controlled, each LED is either on or off.
>>>>> +
>>>>> +  Each LED is represented as a sub-node of the ti,tlc5925 device.
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: ti,tlc5925
>>>>> +
>>>>> +  shift_register_length:
>>>>> +    maxItems: 1
>>>> No...
>>>> 1. Did you test your bindings with dt_binding_check? This fails
>>>> obviously... please, do not send untested bindings.
>>>>
>>>> 2. vendor prefix, no underscores, proper type, maxItems look wrong here
>>>>
>>>>> +    description: |
>>>>> +      The length of the shift register. If several TLC5925 are chained,
>>>>> +      shift_register_length should be set to 16 times the number of TLC5925.
>>>>> +      The value must be a multiple of 8.
>>>>> +
>>>>> +  "#address-cells":
>>>>> +    const: 1
>>>>> +
>>>>> +  "#size-cells":
>>>>> +    const: 0
>>>>> +
>>>>> +  output-enable-b-gpios:
>>>>> +    description: |
>>>>> +      GPIO pins to enable/disable the parallel output. They describe the GPIOs
>>>>> +      connected to the OE/ pin of the TLC5925s.
>>>> maxItems
>>> There is no limitation in the driver itself. The actual number of items
>>> here really depends on the number of chips and how they are wired.
>> So you could daisy chain 4 billion of devices? Because by not using any
>> limit you claim that 4 billion is doable?
> 
> You could chain 1000 devices or more and have 16000 leds. It would be a 
> bit tedious to describe them all in the DTS though.
> 
> We can impose a limit but it will be arbitrary. Is this how it is 
> usually treated ?

1000 is still less than billion, although above that number it probably
does not make sense to have any limit.

Best regards,
Krzysztof

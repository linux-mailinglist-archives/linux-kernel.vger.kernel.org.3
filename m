Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E740D51E6C8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 14:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446323AbiEGMEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 08:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446313AbiEGMEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 08:04:02 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F5748392
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 05:00:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g20so11358506edw.6
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 05:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MJ5P80Xm99M8HaZon9Nxr3GNke+ga/P6cYQ3Q9Jg6ZU=;
        b=MQvTn/dfBEG8PymJS4/L+Db+QkbhwqqGo38F0wmkcKX6yzBdhiVm2s5ehq4K0AUE1b
         XkDOD8IrNrblq5xgZ6lKFBKnt3giY4kFR9JHEY1B5oiS5Dhq4tO80tltyx61MbWsJvKp
         vjVGrqQ4o4IFg3d4AhGZ/P2OyXoqWjYKGRV59EbyfYK6hfknDAYRlad6unlOA+7XtvoY
         +keq5TOdYavisrMfbIhFVznk0F+MC6rbaJzXG6INYPruK6JA+h9Y+eahPZkSuEtAaHDO
         jxjNN3fzYwVnVox80aye3aHKRsejgt8KmcPcj/giqoipauGHZvaAT3wY7bHc9yovFr5m
         VwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MJ5P80Xm99M8HaZon9Nxr3GNke+ga/P6cYQ3Q9Jg6ZU=;
        b=hoj/BJuRVIG6XKDyBP+HQyQRfZjrcLq/bZuzsJHdUIrNP3L82HfCldqxvPw54104N3
         CV/SIQd2AV77cgGrRsRXMivDXI4HnLgABtP+J0i8acF2PznCdmz3nuCnTcEPoLFlKKXt
         xRT+bH8kZzlpjk8sWyelQwrQ0jP8NuvbXhsK5b/Okd47xK5ezsBc6mziRHdYCHJcVlI7
         1IFAX8ovGmRaFm7re1QVxpZzz3zd2J19Syi4CVznMLJOZ9Hr962s5Z2qwapdiUOiMsAY
         XitcWK9ELK6N9JwOCNmMKJBoAqpjSI1jkqGDn0tlhttxNBmUN5VtnhtrVRTD+VpaN6LF
         qfjQ==
X-Gm-Message-State: AOAM531Igyn5EP4HQ63GpBkferEtW0GuwyECcBQWT5fUPMhDP2Xpb/5j
        dbcD5cAqa5ChSYzOBV3eQnOgIw==
X-Google-Smtp-Source: ABdhPJxBDiBw/+Y6YqGlDI0kGxCvL6NRopsXdXUCX5l4w4QqNFYvG7MfzHhWwbmJaT0RK+wj1kz73A==
X-Received: by 2002:aa7:c58e:0:b0:425:b5e3:6c51 with SMTP id g14-20020aa7c58e000000b00425b5e36c51mr8394827edq.99.1651924812215;
        Sat, 07 May 2022 05:00:12 -0700 (PDT)
Received: from [192.168.0.231] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id og21-20020a1709071dd500b006f3ef214df8sm2827458ejc.94.2022.05.07.05.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 05:00:11 -0700 (PDT)
Message-ID: <324d9977-e8bc-b69f-ce8e-b5156035074e@linaro.org>
Date:   Sat, 7 May 2022 14:00:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/3] media: dt-bindings: ov5675: document YAML binding
Content-Language: en-US
To:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Quentin Schulz <foss+kernel@0leil.net>
Cc:     shawnx.tu@intel.com, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220504135543.59522-1-foss+kernel@0leil.net>
 <18d1032c-1fee-9de5-bd25-752ff9c39200@linaro.org>
 <889135d8-575e-3f95-4c65-ff3c40f64b05@theobroma-systems.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <889135d8-575e-3f95-4c65-ff3c40f64b05@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2022 15:48, Quentin Schulz wrote:
>>> +  clock-names:
>>> +    description:
>>> +      Input clock for the sensor.
>>> +    items:
>>> +      - const: xvclk
>>
>> Just "xv" is preferred.
>>
> 
> The name of the clock in the datasheet is XVCLK though. Wouldn't it be 
> confusing to describe HW by using names different from the datasheet?

No, because datasheet could call it "xvclk_clk_clk_clk" and it is not a
reason to use it in the bindings. All of these are clocks, so don't add
unnecessary suffixes. The same goes to interrupts (wake not wakeirq) or
DMA (tx not txdma).

> 
>>> +
>>> +  clock-frequency:
>>> +    description:
>>> +      Frequency of the xvclk clock in Hertz.
>>> +
>>> +  dovdd-supply:
>>> +    description:
>>> +      Definition of the regulator used as interface power supply.
>>> +
>>> +  avdd-supply:
>>> +    description:
>>> +      Definition of the regulator used as analog power supply.
>>> +
>>> +  dvdd-supply:
>>> +    description:
>>> +      Definition of the regulator used as digital power supply.
>>> +
>>> +  reset-gpios:
>>> +    description:
>>> +      The phandle and specifier for the GPIO that controls sensor reset.
>>> +      This corresponds to the hardware pin XSHUTDOWN which is physically
>>> +      active low.
>>
>> Needs maxItems
>>
>>> +
>>> +  port:
>>> +    type: object
>>
>> Open other bindings and compare how it is done there. This looks like
>> /schemas/graph.yaml#/$defs/port-base
>>
> 
> Did that but used an old kernel as base :/

Then please do not develop on an older kernel.

> 
>>> +    additionalProperties: false
>>> +    description:
>>> +      A node containing an output port node with an endpoint definition
>>> +      as documented in
>>> +      Documentation/devicetree/bindings/media/video-interfaces.txt
>>> +
>>> +    properties:
>>> +      endpoint:
>>> +        type: object
>>
>> Missing ref
>>
>>> +
>>> +        properties:
>>> +          data-lanes:
>>> +            description: |-
>>
>> No need for "|-"
>>
>>> +              The driver only supports 2-lane operation.
>>
>> Please remove references to driver. It's not part of hardware.
>>
>>> +            items:
>>> +              - const: 1
>>> +              - const: 2
>>> +
>>> +          link-frequencies:
>>> +            $ref: /schemas/types.yaml#/definitions/uint64-array
>>
>> The ref should be already provided by video-interfaces.
>>
>>> +            description:
>>> +              Allowed data bus frequencies. 450000000Hz is supported by the driver.
>>
>> Again, skip driver reference. However you need to describe the number of
>> items.
>>
> 
> Currently, the driver is limited to 450 MHz link-freq and 2 data lanes, 
> while the HW advertises: "The OV5675 supports a MIPI interface of up to 
> 2-lanes. The MIPI interface can be configured for 1/2-lane and each lane
> 
> is capable of a data transfer rate of up to 900 Mbps."
> 
> Was wondering what I am supposed to do in this situation as I see 
> Documentation/devicetree/bindings/media/i2c/ov8856.yaml mentioning 
> driver limitations in the dt-bindings.

Bindings describe the hardware and they are used in different projects.
Let's say Linux implementation supports only 450 MHz, but other project
supports 450 and 900, so your bindings would be incorrect in such
case... IOW, bindings should not depend on the implementation.

What is more, the driver might get updated without updating the comments
in the bindings making them incorrect even for Linux.

In the past several bindings contained actual specifics of
implementation, but this is usually not the proper way.

There are clear issues with describing implementation in the bindings,
but what are the benefits?

Best regards,
Krzysztof

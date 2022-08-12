Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6022590C23
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 08:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbiHLGyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 02:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiHLGyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 02:54:18 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE6BA5988
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 23:54:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w5so144931lfq.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 23:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=t3EERWAoHc/0sJzUnWIG/VXJqbeUHXe35Iq8kCfIwJ8=;
        b=H0Rll6qOqs0V2BmA7/rXq8aEvL568CpvV8lKQ3Rn5KRJjcfJsvnHeU6JN6ie3e+jQb
         KqVSjL28MvNTNAeD+f9a7p92RM33993ChXnC30O2V4iPLa4A0OpxfXLo6VnZD5mVX8j9
         /mMs1KTE0M5xc5WVU0k7fH5YQbXIq4fBoNpYtztfLhZSob7Gk0NpSsvY9YNaagKTiGwM
         I9EcusoqsELsaNje/phNRiMzW2n/gsxSKDzrAhAbT3hRUa8n5dP4+yPB2DKjvPF9yX6S
         VR67nq/yClD4vERkuYuOmMD9YpDMf1R7iQqS3gt/3m2V+g6B3KzEgh87FPpqJAw6wbYc
         Hzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=t3EERWAoHc/0sJzUnWIG/VXJqbeUHXe35Iq8kCfIwJ8=;
        b=flf07/ppUlYq5lKCF/EWZAQH+uCyAwJr8wGZ4qz007aq4+6yu6omtotarDn06RTrO3
         oYrKMEAw25caxhMUEJ83QsDROSwYE1U/hei5N1viNtikhn+2dwyxHpJRop6QOZER6/qt
         v9SiNDR1o+503fKzygkngMXg2qJqJFOE5f2mnvOVwE7cixbAicizIKWJaxNsWnDi48I1
         s4jDy7FoW0272P0YoJsa82MbH1tcIRskPFkuJ3VSsOLMv4Fsn+vJ1Vm5/k/j+P3t7JB5
         6s9Lp9aFEynWcZUHAzNHZc5W9eBBLO69O7xBj1sPNwU46NHsNfdZYKiv+/O/LQOXmejP
         qXhA==
X-Gm-Message-State: ACgBeo2X3x4c4Ehb1nvjQ3MfptBC7MyH2dPLY7ddHo+2E9qLA276N+vy
        98nDkQ2i2BnuMXru5PCwUcsNbQ==
X-Google-Smtp-Source: AA6agR6TWxarEea/EB4pqn9N8km5hXjJnqltHNgS5yLpYpMOPAOSyNuQ9fhHFdZxk7o0iINjK3m8vw==
X-Received: by 2002:a05:6512:ac3:b0:48a:fa85:7b20 with SMTP id n3-20020a0565120ac300b0048afa857b20mr801551lfu.340.1660287255892;
        Thu, 11 Aug 2022 23:54:15 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id q30-20020ac2511e000000b0048dacaa8c36sm107895lfb.149.2022.08.11.23.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 23:54:15 -0700 (PDT)
Message-ID: <40261b95-637a-1304-2e06-8c8ff7fc377b@linaro.org>
Date:   Fri, 12 Aug 2022 09:54:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: Add Richtek RT9471
 battery charger
Content-Language: en-US
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        =?UTF-8?B?5ri45a2Q6aao?= <alina_yu@richtek.com>,
        cy_huang <cy_huang@richtek.com>, alinayu829@gmail.com,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
References: <1660225318-4063-1-git-send-email-u0084500@gmail.com>
 <1660225318-4063-2-git-send-email-u0084500@gmail.com>
 <3cae9d60-4012-1dfd-abd9-4d0b9379e6bb@linaro.org>
 <CADiBU3_depGDZtiyizU3MB939A3oH1uTWzTMyruUy0z=u6BZkQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CADiBU3_depGDZtiyizU3MB939A3oH1uTWzTMyruUy0z=u6BZkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2022 04:32, ChiYuan Huang wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 於 2022年8月11日 週四 晚上10:12寫道：
>>
>> On 11/08/2022 16:41, cy_huang wrote:
>>> From: ChiYuan Huang <cy_huang@richtek.com>
>>>
>>> Add bindings for the Richtek RT9471 I2C controlled battery charger.
>>>
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>> +properties:
>>> +  compatible:
>>> +    const: richtek,rt9471
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  ceb-gpios:
>>> +    maxItems: 1
>>
>> This looks not standard, so please provide a description.
> It's the external 'charge enable' pin that's used to control battery charging.
> The priority is higher than the register 'CHG_EN' control.
> In the word, 'b' means it's reverse logic, low to allow charging, high
> to force disable charging.

Isn't this standard enable-gpios property?

> 
> description:
>   External charge enable pin that can force control not to charge the battery.
>   Low to allow charging, high to disable charging.
> 
>>
>>> +
>>> +  wakeup-source: true
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  interrupt-controller: true
>>> +
>>> +  "#interrupt-cells":
>>> +    const: 1
>>
>> Why a charger driver is a interrupt-controller?
> There're 32 nested IRQs from RT9471.
> The original thought is to make the user easy to bind the interrupt
> into their driver.

Bindings are not related to the driver but to hardware...

> 
> For charger driver, does it mean legacy IRQ handler is more preferred?

Who is the consumer of these interrupts? Can you show the DTS with the
interrupt consumer?

>>
>>> +
>>> +  usb-otg-vbus-regulator:
>>> +    type: object
>>> +    unevaluatedProperties: false
>>> +    $ref: /schemas/regulator/regulator.yaml#
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - wakeup-source
>>> +  - interrupts
>>> +  - interrupt-controller
>>> +  - "#interrupt-cells"
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +    i2c {
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>> +
>>> +      charger@53 {
>>> +        compatible = "richtek,rt9471";
>>> +        reg = <0x53>;
>>> +        ceb-gpios = <&gpio26 1 0>;
>>
>> Isn't the last value a GPIO flag? If yes, use appropriate define.
> I already specify GPIOD_OUT_LOW in the gpiod_request flag.

It is not related to the DTS. Anyway writing "low" for a meaning of high
is not correct usually...

> Do I need to convert the gpio request code to GPIOD_OUT_HIGH,
> and specify here as GPIO_ACTIVE_LOW?

You need to properly describe the hardware. The polarity of logical
signal is defined by DTS, not by driver. It does not make sense to do it
in driver. What if on some board the signal is inverted?

Best regards,
Krzysztof

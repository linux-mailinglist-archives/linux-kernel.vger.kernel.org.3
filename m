Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E257D571BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiGLNpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiGLNpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:45:31 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F6A2B271
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:45:29 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t1so10486377lft.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zBdmor3ebYTz4M9G/JpFZaGhUnOIPV+4b94hb7PZEos=;
        b=IPE6fTbLabiis/jTdAiQrM62Q2T+deFH1WYVaOvljATrO6pfjrSpwDPz1LECJSdqGq
         F7GENV15O+V79DNAeQSjed4PXhExPnziSb8wnTWtogcqKjCQb0Zkyct85FN9V54Imn95
         Pq/b+AHsZKAfzlBG6Rd8Q91h2EBFas+J2+UM2nwlsPawa0TOWf08IAk/dsAxihNWnuE2
         CyZB7zxIeh/koJILOf/5YR0z3s4zi76vMEnFhk/yVIRubXR+K3c3nVAEuBoQclT9eVV3
         rzg88JZZ4s627F7JzF6p5+Hjq77gxYTqKKkLhCHd0rQ+VslLzaIlwnMYbWWbkw+pTZRd
         y7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zBdmor3ebYTz4M9G/JpFZaGhUnOIPV+4b94hb7PZEos=;
        b=gfzpgXjcbTmH4bdBYBtEAKCtteMHEDjEeIPSddzjb26v75S9s0VokGpowYIpLARNRu
         BIT1fkmqislwmOX+X0kZkybNSrNtPdKa67+vjHnmhGDqXB7CZmnp+Va2PcQNBwqd0yAk
         82IWdE5CdOJID7+GZGLACsKPxyKbHFMg8UaUsiKmRnJ44ZO57sPXTZwTU/c0A7huAg3C
         ZaIB1oipNNO0ln6nZxu6TfO6fcnQKLckA5E1r9AuqUoaILtCmdhTzRqJcXUiZoZu4ybl
         ghOBzTgFTkj2bTpRWljhDXwggPUAB7zsOufIdy9T7V9qvBZ7BxAcCv9DmpDrY6zVnZJo
         auXQ==
X-Gm-Message-State: AJIora+ixf1RF4oB5dKNtucrGK1O96BLHRTzaKdMpqoUc2qo3OuOAFpI
        YQhNvFJPbu9T9rQvThCBET/b+A==
X-Google-Smtp-Source: AGRyM1seDrDaus34guCoomrD0xee7IUSvzKkKV8gR/Jz7H2Tpc7jd3+CHxhj7TZoLefb/LQfdAOVfg==
X-Received: by 2002:a05:6512:1087:b0:489:ee61:ba58 with SMTP id j7-20020a056512108700b00489ee61ba58mr2443773lfg.408.1657633527414;
        Tue, 12 Jul 2022 06:45:27 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id p27-20020a056512329b00b00482bb824214sm1889067lfe.221.2022.07.12.06.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 06:45:26 -0700 (PDT)
Message-ID: <4ffc1060-671e-cbec-a100-5e26f1957eeb@linaro.org>
Date:   Tue, 12 Jul 2022 15:45:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/2] dt-binding: pinctrl: Add NPCM8XX pinctrl and GPIO
 documentation
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        zhengbin13@huawei.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20220710102110.39748-1-tmaimon77@gmail.com>
 <20220710102110.39748-2-tmaimon77@gmail.com>
 <8b1393e4-275b-6791-ad71-2edfeacd0a63@linaro.org>
 <CAP6Zq1iuMPD21dM7Gpg4AEfM1cqE1mFhnO5hhUWvDZvEz=rTqw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1iuMPD21dM7Gpg4AEfM1cqE1mFhnO5hhUWvDZvEz=rTqw@mail.gmail.com>
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

On 12/07/2022 15:29, Tomer Maimon wrote:
> Hi Krzysztof,
> 
> Thanks for your comments.
> 
> On Tue, 12 Jul 2022 at 12:48, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 10/07/2022 12:21, Tomer Maimon wrote:
>>> Added device tree binding documentation for Nuvoton Arbel BMC NPCM8XX
>>> pinmux and GPIO controller.
>>>
>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>>> ---
>>>  .../pinctrl/nuvoton,npcm845-pinctrl.yaml      | 205 ++++++++++++++++++
>>>  1 file changed, 205 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
>>> new file mode 100644
>>> index 000000000000..6395ef2bf5b3
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
>>> @@ -0,0 +1,205 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pinctrl/nuvoton,npcm845-pinctrl.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Nuvoton NPCM845 Pin Controller and GPIO
>>> +
>>> +maintainers:
>>> +  - Tomer Maimon <tmaimon77@gmail.com>
>>> +
>>> +description:
>>> +  The Nuvoton BMC NPCM8XX Pin Controller multi-function routed through
>>> +  the multiplexing block, Each pin supports GPIO functionality (GPIOx)
>>> +  and multiple functions that directly connect the pin to different
>>> +  hardware blocks.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: nuvoton,npcm845-pinctrl
>>> +
>>> +  ranges:
>>> +    maxItems: 1
>>
>> ranges without reg? Does it even work? Did you test the bindings?
> The ranges related to GPIO node reg

But you do not allow here a 'reg', do you? So how can you have an unit
address in pinctrl node?

> 
> I did test the pin controller document and it passed.
> bash-4.2$ make ARCH=arm64 dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTEX    Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.example.dts
>   DTC     Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.example.dtb
>   CHECK   Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.example.dtb
> Did I need to run anything else than dt_binding_check for testing the document?

Indeed it will pass, because you do not have reg in pinctrl node. But
your dts won't pass make dtbs W=1


>>
>>> +
>>> +  '#address-cells':
>>> +    const: 1
>>> +
>>> +  '#size-cells':
>>> +    const: 1
>>> +
>>> +patternProperties:
>>> +  "^gpio@":
>>> +    type: object
>>> +
>>> +    description:
>>> +      Eight GPIO banks that each contain between 32 GPIOs.
>>> +
>>> +    properties:
>>> +
>>
>> No blank line.
> O.K.
>>
>>> +      gpio-controller: true
>>> +
>>> +      '#gpio-cells':
>>> +        const: 2
>>> +
>>> +      reg:
>>> +        maxItems: 1
>>> +
>>> +      interrupts:
>>> +        maxItems: 1
>>> +
>>> +      gpio-ranges:
>>> +        maxItems: 1
>>> +
>>> +    required:
>>> +      - gpio-controller
>>> +      - '#gpio-cells'
>>> +      - reg
>>> +      - interrupts
>>> +      - gpio-ranges
>>> +
>>> +  "-pin":
>>> +    $ref: pinmux-node.yaml#
>>
>> Shouldn't this be under bank?
> Do you mean after the group and function properties?
> The -pin shouldn't use for the group property naming?

Hm, I guess it's fine, I actually don't remember the recommendation for
gpio banks in relation to pinmux nodes.

>>
>>> +
>>> +    properties:
>>> +      groups:
>>> +        description:
>>> +          One or more groups of pins to mux to a certain function
>>> +        items:
>>> +          enum: [ iox1, iox2, smb1d, smb2d, lkgpo1, lkgpo2, ioxh, gspi,
>>> +                  smb5b, smb5c, lkgpo0, pspi2, jm1, jm2, smb4den, smb4b,
>>> +                  smb4c, smb15, smb16, smb17, smb18, smb19, smb20, smb21,
>>> +                  smb22, smb23, smb4d, smb14, smb5, smb4, smb3, spi0cs1,
>>> +                  spi0cs2, spi0cs3, smb3c, smb3b, bmcuart0a, uart1, jtag2,
>>> +                  bmcuart1, uart2, bmcuart0b, r1err, r1md, r1oen, r2oen,
>>> +                  rmii3, r3oen, smb3d, fanin0, fanin1, fanin2, fanin3, fanin4,
>>> +                  fanin5, fanin6, fanin7, fanin8, fanin9, fanin10, fanin11,
>>> +                  fanin12, fanin13, fanin14, fanin15, pwm0, pwm1, pwm2, pwm3,
>>> +                  r2, r2err, r2md, r3rxer, ga20kbc, smb5d, lpc, espi, rg1,
>>> +                  rg1mdio, rg2, ddr, i3c0, i3c1, i3c2, i3c3, i3c4, i3c5,
>>> +                  smb0, smb1, smb2, smb2c, smb2b, smb1c, smb1b, smb8, smb9,
>>> +                  smb10, smb11, sd1, sd1pwr, pwm4, pwm5, pwm6, pwm7, pwm8,
>>> +                  pwm9, pwm10, pwm11, mmc8, mmc, mmcwp, mmccd, mmcrst, clkout,
>>> +                  serirq, lpcclk, scipme, sci, smb6, smb7, spi1, faninx, r1,
>>> +                  spi3, spi3cs1, spi3quad, spi3cs2, spi3cs3, nprd_smi, smb0b,
>>> +                  smb0c, smb0den, smb0d, ddc, rg2mdio, wdog1, wdog2, smb12,
>>> +                  smb13, spix, spixcs1, clkreq, hgpio0, hgpio1, hgpio2, hgpio3,
>>> +                  hgpio4, hgpio5, hgpio6, hgpio7 ]
>>> +
>>> +      function:
>>> +        description:
>>> +          The function that a group of pins is muxed to
>>> +        enum: [ iox1, iox2, smb1d, smb2d, lkgpo1, lkgpo2, ioxh, gspi,
>>> +                smb5b, smb5c, lkgpo0, pspi2, jm1, jm2, smb4den, smb4b,
>>> +                smb4c, smb15, smb16, smb17, smb18, smb19, smb20, smb21,
>>> +                smb22, smb23, smb4d, smb14, smb5, smb4, smb3, spi0cs1,
>>> +                spi0cs2, spi0cs3, smb3c, smb3b, bmcuart0a, uart1, jtag2,
>>> +                bmcuart1, uart2, bmcuart0b, r1err, r1md, r1oen, r2oen,
>>> +                rmii3, r3oen, smb3d, fanin0, fanin1, fanin2, fanin3, fanin4,
>>> +                fanin5, fanin6, fanin7, fanin8, fanin9, fanin10, fanin11,
>>> +                fanin12, fanin13, fanin14, fanin15, pwm0, pwm1, pwm2, pwm3,
>>> +                r2, r2err, r2md, r3rxer, ga20kbc, smb5d, lpc, espi, rg1,
>>> +                rg1mdio, rg2, ddr, i3c0, i3c1, i3c2, i3c3, i3c4, i3c5,
>>> +                smb0, smb1, smb2, smb2c, smb2b, smb1c, smb1b, smb8, smb9,
>>> +                smb10, smb11, sd1, sd1pwr, pwm4, pwm5, pwm6, pwm7, pwm8,
>>> +                pwm9, pwm10, pwm11, mmc8, mmc, mmcwp, mmccd, mmcrst, clkout,
>>> +                serirq, lpcclk, scipme, sci, smb6, smb7, spi1, faninx, r1,
>>> +                spi3, spi3cs1, spi3quad, spi3cs2, spi3cs3, nprd_smi, smb0b,
>>> +                smb0c, smb0den, smb0d, ddc, rg2mdio, wdog1, wdog2, smb12,
>>> +                smb13, spix, spixcs1, clkreq, hgpio0, hgpio1, hgpio2, hgpio3,
>>> +                hgpio4, hgpio5, hgpio6, hgpio7 ]
>>> +
>>> +    dependencies:
>>> +      groups: [ function ]
>>> +      function: [ groups ]
>>> +
>>> +    additionalProperties: false
>>> +
>>> +  "^pin":
>>
>> This is almost the same as previous property. Confusing and I think it
>> does not work.
> if I remove it I get the following error:
> pinctrl@f0800000: 'pin34-slew' does not match any of the regexes:
> '-pin', '^gpio@', 'pinctrl-[0-9]+'
> Can you advise what I should do?

Ah, the pattern is indeed different - you start with pin. Anyway it's
confusing to have cfg starting with pin and mux ending in pin. How
"pin-pin" would work? :)

Use maybe similar pattern, so start with mux for mux and pin for cfg.
Look at wpcm450 pinctrl.


>>
>>> +    $ref: pincfg-node.yaml#
>>> +
>>> +    properties:
>>> +      pins:
>>> +        description:
>>> +          A list of pins to configure in certain ways, such as enabling
>>> +          debouncing
>>> +
>>> +      bias-disable: true
>>> +
>>> +      bias-pull-up: true
>>> +
>>> +      bias-pull-down: true
>>> +
>>> +      input-enable: true
>>> +
>>> +      output-low: true
>>> +
>>> +      output-high: true
>>> +
>>> +      drive-push-pull: true
>>> +
>>> +      drive-open-drain: true
>>> +
>>> +      input-debounce:
>>> +        description:
>>> +          Debouncing periods in microseconds, one period per interrupt
>>> +          bank found in the controller
>>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +        minItems: 1
>>> +        maxItems: 4
>>> +
>>> +      slew-rate:
>>> +        description: |
>>> +          0: Low rate
>>> +          1: High rate
>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>> +        enum: [0, 1]
>>> +
>>> +      drive-strength:
>>> +        enum: [ 0, 1, 2, 4, 8, 12 ]
>>> +
>>> +    additionalProperties: false
>>> +
>>> +required:
>>> +  - compatible
>>> +  - ranges
>>> +  - '#address-cells'
>>> +  - '#size-cells'
>>
>> Missing allOf with ref to pinctrl.yaml.
> Do you mean adding
> allOf:
>   - $ref: "pinctrl.yaml#"

Yes.



Best regards,
Krzysztof

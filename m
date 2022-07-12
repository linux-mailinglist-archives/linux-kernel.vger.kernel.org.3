Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D486572795
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiGLUoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiGLUoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:44:16 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956DF23BF6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:44:13 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bp17so8056414lfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MORAWQZYnuqS2wo/SekKYPQ26Eg73UPTOY0oQe/BW5E=;
        b=PDPvQkT26U+LXywcEP5RPf9apr6nUtCd/XTpypCJnJVs6//VWgJQxjog1JRq0yDLaL
         O7b1fG8yUGpUK3tim5Tqvgi8OV2hFa2taxSkmpxv2dclb8XmHSZP9+YkEIVf1GaxI66f
         vUjzNCQKjA3hQlBDXLwvmO+vUARZNjFrwaKMB/I4V4naq3/ZyP3Ey5Cntb/z57BQAqkc
         MUiIvrYGZQ4GK1czFEHA848IjP3wQwkqc1BWsqstWCNjUW5mb2nHpxFJhDcdUceQDAWO
         8gjKm/NoTh1YTPh6GIz6pO+RfJ7287WPg8nNTm4IEOS90AiSv9P71HpuP2affhe4WmEf
         z9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MORAWQZYnuqS2wo/SekKYPQ26Eg73UPTOY0oQe/BW5E=;
        b=kD3AOQoZQVGIGext9ESXsEX+/VNb7ltHrhYwy3flQZ02IcSe4u9hIog1ArWz0U+3C2
         xfjaqfljBWC6DDPn/AZlOx1OYl7Ekop7VMOufra0luCGa+yaFgiVrTm3QiIdJdu2/gaA
         1qVLBAyq6OW7qxnXtdlkLSDeYHgVRkZqBi7QcHtlnZnBcnFzejHYnqqaX8IUcqydaKIx
         UTtNJIxCBnTsSDPwEkNtPz9t8TZ0OxpRobI6XusEJ46MOq7OutKq0vQJKjV+BW6KTMpF
         BkyZDFX3qV4CMfPpDMbREQEnuzc5J744nOx7l2Nclc1C1qO8XK7Gzm1wRxfoFgw0SPLx
         kIMw==
X-Gm-Message-State: AJIora9zNmmhtEXwub/N7Fj/1WUkB2Eb6HOgh3kskGKiW7MzVXrSFeUW
        PNWjbIQXtGrbKHB4HoFVGwqiZw==
X-Google-Smtp-Source: AGRyM1vscXSaxgyzLVxVMjxRaAsSXWTk//tWWNmKX7HaJIodJ0W7gC97Iosv6THw75rpvarLQ4hZaw==
X-Received: by 2002:a05:6512:74:b0:488:a062:281d with SMTP id i20-20020a056512007400b00488a062281dmr15742119lfo.43.1657658651676;
        Tue, 12 Jul 2022 13:44:11 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id s28-20020a05651c201c00b0025d547bf08asm2656253ljo.74.2022.07.12.13.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 13:44:11 -0700 (PDT)
Message-ID: <5dec7907-9cab-6735-4775-142aeede185e@linaro.org>
Date:   Tue, 12 Jul 2022 22:44:08 +0200
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
 <4ffc1060-671e-cbec-a100-5e26f1957eeb@linaro.org>
 <CAP6Zq1igaQhM79sUqTLdiH3WZiEG52Pva9k0g_A-BibAJKfm=Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1igaQhM79sUqTLdiH3WZiEG52Pva9k0g_A-BibAJKfm=Q@mail.gmail.com>
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

On 12/07/2022 20:44, Tomer Maimon wrote:
> Hi Krzysztof,
> 
> Thanks for your clarifications.
> 
> On Tue, 12 Jul 2022 at 16:45, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 12/07/2022 15:29, Tomer Maimon wrote:
>>> Hi Krzysztof,
>>>
>>> Thanks for your comments.
>>>
>>> On Tue, 12 Jul 2022 at 12:48, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 10/07/2022 12:21, Tomer Maimon wrote:
>>>>> Added device tree binding documentation for Nuvoton Arbel BMC NPCM8XX
>>>>> pinmux and GPIO controller.
>>>>>
>>>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>>>>> ---
>>>>>  .../pinctrl/nuvoton,npcm845-pinctrl.yaml      | 205 ++++++++++++++++++
>>>>>  1 file changed, 205 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..6395ef2bf5b3
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
>>>>> @@ -0,0 +1,205 @@
>>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/pinctrl/nuvoton,npcm845-pinctrl.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Nuvoton NPCM845 Pin Controller and GPIO
>>>>> +
>>>>> +maintainers:
>>>>> +  - Tomer Maimon <tmaimon77@gmail.com>
>>>>> +
>>>>> +description:
>>>>> +  The Nuvoton BMC NPCM8XX Pin Controller multi-function routed through
>>>>> +  the multiplexing block, Each pin supports GPIO functionality (GPIOx)
>>>>> +  and multiple functions that directly connect the pin to different
>>>>> +  hardware blocks.
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: nuvoton,npcm845-pinctrl
>>>>> +
>>>>> +  ranges:
>>>>> +    maxItems: 1
>>>>
>>>> ranges without reg? Does it even work? Did you test the bindings?
>>> The ranges related to GPIO node reg
>>
>> But you do not allow here a 'reg', do you? So how can you have an unit
>> address in pinctrl node?
> I allow the reg unit address in the GPIO node.
> This is why reg is in the GPIO node as follow:
> 
>                 compatible = "nuvoton,npcm845-pinctrl";
>                 ranges = <0x0 0x0 0xf0010000 0x8000>;
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 status = "okay";
>                 gpio0: gpio@f0010000 {
>                         gpio-controller;
>                         #gpio-cells = <2>;
>                         reg = <0x0 0xB0>;
>                         interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
>                         gpio-ranges = <&pinctrl 0 0 32>;
>                 };
>                 gpio1: gpio@f0011000 {
>                         gpio-controller;
>                         #gpio-cells = <2>;
>                         reg = <0x1000 0xB0>;
>                         interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
>                         gpio-ranges = <&pinctrl 0 32 32>;
>                 };
>                 gpio2: gpio@f0012000 {
>                         gpio-controller;
>                         #gpio-cells = <2>;
>                         reg = <0x2000 0xB0>;
>                         interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
>                         gpio-ranges = <&pinctrl 0 64 32>;
>                 };
> ...
> Is it problematic?


It seems not, looks ok because of ranges, although it is a bit confusing
that your pinctrl unit address is 0xf0800000 but ranges is 0xf0010000.

>>
>>>
>>> I did test the pin controller document and it passed.
>>> bash-4.2$ make ARCH=arm64 dt_binding_check
>>> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
>>>   LINT    Documentation/devicetree/bindings
>>>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>>>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>>>   DTEX    Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.example.dts
>>>   DTC     Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.example.dtb
>>>   CHECK   Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.example.dtb
>>> Did I need to run anything else than dt_binding_check for testing the document?
>>
>> Indeed it will pass, because you do not have reg in pinctrl node. But
>> your dts won't pass make dtbs W=1
> After running make ARCH=arm64 dtbs W=1 I don't see warning related to pinctrl
> bash-4.2$ make ARCH=arm64 dtbs W=1
>   DTC     arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb
> arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi:69.7-183.5:
> Warning (unit_address_vs_reg): /ahb/apb: node has a reg or ranges
> property, but no unit name
> arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts:20.9-22.4: Warning
> (unit_address_vs_reg): /memory: node has a reg or ranges property, but
> no unit name
> arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi:69.7-183.5:
> Warning (simple_bus_reg): /ahb/apb: simple-bus unit address format
> error, expected "f0000000"
> arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi:56.35-61.5:
> Warning (unique_unit_address): /ahb/reset-controller@f0801000:
> duplicate unit-address (also used in node
> /ahb/clock-controller@f0801000)
> I did got warning but it dont related to the pinctrl, Maybe I didn't
> run the test correct?

Looks correct, indeed.

Best regards,
Krzysztof

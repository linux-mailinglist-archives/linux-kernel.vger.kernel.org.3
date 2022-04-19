Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7965064A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348938AbiDSGlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbiDSGlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:41:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDB42ED65
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:38:35 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i27so30823572ejd.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wwWxCtbSCeUQRJk9COftuaJ7ScbeBZhdO6eWFwSTjHA=;
        b=KEdFvQx8qTBO1XSAD8KaA2BVQLibgDkOq0nlbqSwYGaPP8qvuQZutcjJ4SAYW61cfD
         gvQe1ZXTh8iodDlXd9mVzWiSNur530PQD/+R7noKjegpikYHShuY8bEioVrWh9aZj4Cw
         Trm7ac6UwYkGMw5mNOgpeCImpM/Gq3SC+kyh6m1Daa7ZuftOstyDCr4jFbGl855GJThH
         VxcJ8zc85A0r2jjj8wACXwtIXtDPuHbZbIyVNy4WsUGGcj6jmm5EqQzA0u/ngVV0fHlv
         nAEZxBx3BhtjLCexp3hrPZiQOvPb3mNXasSb/h6XVzx6oD0ELrlYHiO/V4rudUD+4n0A
         mveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wwWxCtbSCeUQRJk9COftuaJ7ScbeBZhdO6eWFwSTjHA=;
        b=VEddIoJbWgn38o+GcdkLM8meWzAY6PVx/Qfr4jPVb+/2zXm4aZF7MMfBqr6n2JOCe+
         vWY29cN6La+wgT/ONwh/hnLCRr1buPHzaY5WZS8ePHSjuqWUhLld9lSISJWGROUfbaVV
         Hygjp3D4jb5gzKCJg2LM+LIkR4QvC8KHkJ1Fb7cZeLSK0660xt87JmQmyJfHZQ1LQgT4
         DYqvWHY09hNyITCfeZUGUyqhdrcOX1ruYrxpI1CIc5q1J/JVnVsB7zygzXbmV6Tbs/Bb
         e2RPVtcvH0TdWSsh9BNmx5y58fXn+KaX1P6MCQmw54rA8qOn/2IQHBlUMGfocnvP1NM7
         3zug==
X-Gm-Message-State: AOAM533ONQITqJhqEHp9sfEy2S9K3zNiceMdwDibfHyYkD0ISUTqWFMb
        UqA8p76i+okLrB8JdLfMiRs4seUpJPPmEg==
X-Google-Smtp-Source: ABdhPJwrGev1kPZ0BZBFXz88umiWjHpPsXqJlQOwM3LXtRLXA35QMvp+9MdmKCpnToDC38nRk3brHg==
X-Received: by 2002:a17:907:3e11:b0:6e8:cccd:de80 with SMTP id hp17-20020a1709073e1100b006e8cccdde80mr10281291ejc.162.1650350314339;
        Mon, 18 Apr 2022 23:38:34 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w2-20020a056402070200b004240494e20dsm84351edx.54.2022.04.18.23.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 23:38:33 -0700 (PDT)
Message-ID: <a5a59f3c-00a3-afc5-24aa-1ae3de2600ec@linaro.org>
Date:   Tue, 19 Apr 2022 08:38:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 1/3] dt-bindings: clk: sprd: Add bindings for ums512
 clock controller
Content-Language: en-US
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Orson Zhai <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220418125630.2342538-1-gengcixi@gmail.com>
 <20220418125630.2342538-2-gengcixi@gmail.com>
 <714caf6e-5f81-6d73-7629-b2c675f1f1d4@linaro.org>
 <CAF12kFv6uioc7ATtXLpGTTDBFT1wYWZUBoyjQqP1bSUnut0pKA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAF12kFv6uioc7ATtXLpGTTDBFT1wYWZUBoyjQqP1bSUnut0pKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2022 03:53, Cixi Geng wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 于2022年4月19日周二 00:28写道：
>>
>> On 18/04/2022 14:56, Cixi Geng wrote:
>>> From: Cixi Geng <cixi.geng1@unisoc.com>
>>>
>>> Add a new bindings to describe ums512 clock compatible string.
>>>
>>> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
>>> ---
>>>  .../bindings/clock/sprd,ums512-clk.yaml       | 112 ++++++++++++++++++
>>>  1 file changed, 112 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
>>> new file mode 100644
>>> index 000000000000..89824d7c6be4
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
>>> @@ -0,0 +1,112 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +# Copyright 2022 Unisoc Inc.
>>> +%YAML 1.2
>>> +---
>>> +$id: "http://devicetree.org/schemas/clock/sprd,ums512-clk.yaml#"
>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>> +
>>> +title: UMS512 Clock Control Unit Device Tree Bindings
>>
>> Remove "Device Tree Bindings". You could do the same also in the
>> subject, because you repeat the prefix ("dt-bindings: clk: sprd: Add
>> ums512 clock controller").
>>
>>> +
>>> +maintainers:
>>> +  - Orson Zhai <orsonzhai@gmail.com>
>>> +  - Baolin Wang <baolin.wang7@gmail.com>
>>> +  - Chunyan Zhang <zhang.lyra@gmail.com>
>>> +
>>> +properties:
>>> +  "#clock-cells":
>>> +    const: 1
>>> +
>>> +  compatible:
>>
>> Put the compatible first, by convention and makes finding matching
>> bindings easier.
>>
>>> +    oneOf:
>>> +      - items:
>>> +          - const: sprd,ums512-glbregs
>>> +          - const: syscon
>>> +          - const: simple-mfd
>>
>> Why do you need simple-mfd for these? This looks like a regular syscon,
>> so usually does not come with children. What is more, why this "usual
>> syscon" is a separate clock controller in these bindings?
> there is a warning log before add these const.  and the reason we need
> the simply-mfd
> is some clock is a child of syscon node,which should set these compatible.
> failed to match any schema with compatible: ['sprd,ums512-glbregs',
> 'syscon', 'simple-mfd']

Neither here nor later you did not answer the question - why do you need
such complex construction, instead of adding syscon to the clock controller?

Let me paste again my concerns:

  You have nodes with reg but without unit address ("rpll"). These nodes
  are modeled as children but they are not children - it's a workaround
  for exposing syscon, isn't it? The sc9863a looks like broken design,
  so please do not duplicate it here.

IOW, sc9863a uses similar pattern as here and the DTS is made wrong.
Because of this you need to create complex ways to get the regmap for
the clock controller... Why not making it simple? Clock controller with
syscon?

>>
>>> +      - items:
>>> +          - enum:
>>> +              - sprd,ums512-apahb-gate
>>> +              - sprd,ums512-ap-clk
>>> +              - sprd,ums512-aonapb-clk
>>> +              - sprd,ums512-pmu-gate
>>> +              - sprd,ums512-g0-pll
>>> +              - sprd,ums512-g2-pll
>>> +              - sprd,ums512-g3-pll
>>> +              - sprd,ums512-gc-pll
>>> +              - sprd,ums512-aon-gate
>>> +              - sprd,ums512-audcpapb-gate
>>> +              - sprd,ums512-audcpahb-gate
>>> +              - sprd,ums512-gpu-clk
>>> +              - sprd,ums512-mm-clk
>>> +              - sprd,ums512-mm-gate-clk
>>> +              - sprd,ums512-apapb-gate
>>> +
>>> +  clocks:
>>> +    minItems: 1
>>
>> maxItems needed
> the previous version did has the maxitems, but makes error when run
> 'make DT_CHECKER_FLAGS=-m dt_binding_check O=./dt-out  \
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml'
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> /path-to-linux/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml:
> properties:clock-names: {'minItems': 1, 'maxItems': 4, 'items':
> [{'const': 'ext-26m'}, {'const': 'ext-32k'}, {'const': 'ext-4m'},
> {'const': 'rco-100m'}]} should not be valid under {'required':
> ['maxItems']}
> hint: "maxItems" is not needed with an "items" list

Warning is about clock-names, not about clocks. Fix the bindings.

> 
>>
>>> +    description: |
>>> +      The input parent clock(s) phandle for this clock, only list fixed
>>> +      clocks which are declared in devicetree.
>>
>> The description does not make sense. These are bindings for a clock
>> controller, but you say here "for this clock", so what does "this" mean
>> here?
>>
>>> +
>>> +  clock-names:
>>> +    minItems: 1
>>> +    items:
>>> +      - const: ext-26m
>>> +      - const: ext-32k
>>> +      - const: ext-4m
>>> +      - const: rco-100m
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - '#clock-cells'
>>
>> Isn't reg also required? Always? Do you have examples where it is not
>> required? How do you configure the clocks without "reg"? I see you
>> copied a lot from sprd,sc9863a-clk.yaml but that file does not look correct.
>>
>> You have nodes with reg but without unit address ("rpll"). These nodes
>> are modeled as children but they are not children - it's a workaround
>> for exposing syscon, isn't it? The sc9863a looks like broken design, so
>> please do not duplicate it here.
>>
>>> +
>>> +if:
>>> +  properties:
>>> +    compatible:
>>> +      enum:
>>> +        - sprd,ums512-ap-clk
>>> +        - sprd,ums512-aonapb-clk
>>> +        - sprd,ums512-mm-clk
>>> +then:
>>> +  required:
>>> +    - reg
>>> +
>>> +else:
>>> +  description: |
>>> +    Other UMS512 clock nodes should be the child of a syscon node in
>>> +    which compatible string should be:
>>> +            "sprd,ums512-glbregs", "syscon", "simple-mfd"
>>> +
>>> +    The 'reg' property for the clock node is also required if there is a sub
>>> +    range of registers for the clocks.
>>> +
>>> +additionalProperties: true
>>
>> false
> the "false" makes error log:
> /path-to-linux/Documentation/devicetree/bindings/clock/sprd,ums512-clk.example.dtb:
> syscon@71000000: '#address-cells', '#size-cells',
> 'clock-controller@0', 'ranges' do not match any of the regexes:
> 'pinctrl-[0-9]+'
> and I reference the patch
> [https://www.spinics.net/lists/linux-leds/msg17032.html]

Which needs fixing. The "false" is a strict requirement for such end
(non-extendable) bindings.

> 
>>
>>> +
>>> +examples:
>>> +  - |
>>> +    ap_clk: clock-controller@20200000 {
>>> +      compatible = "sprd,ums512-ap-clk";
>>> +      reg = <0x20200000 0x1000>;
>>> +      clocks = <&ext_26m>;
>>> +      clock-names = "ext-26m";
>>> +      #clock-cells = <1>;
>>> +    };
>>> +
>>> +  - |
>>> +    ap_apb_regs: syscon@71000000 {
>>> +      compatible = "sprd,ums512-glbregs", "syscon", "simple-mfd";
>>
>> So here is the answer why you added MFD, but I still don't get why do
>> you need it for one child? It is quite a dance here and in your drivers,
>> instead of adding "syscon" to your clock controller.
> 
> [1]in the if/else describtion,  th other UMS512 clock nodes should be
> the child of a syscon node in
> which compatible string should be:   "sprd,ums512-glbregs", "syscon",
> "simple-mfd"

No, it should not. Fix the drivers, fix the DTS and the bindings. Then
the "should" disappears.
> 
>>
>> This also pollutes the actual bindings because you did not add
>> properties required for clock controllers, because of describing here
>> the syscon part.



Best regards,
Krzysztof

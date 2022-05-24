Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5EA532919
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbiEXLeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbiEXLeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:34:19 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70AA8BD28
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:34:17 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t25so30324621lfg.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uZXl4RLzzhryYGc4tfKASYNpJNQsDtpLhwIbhtBkN3M=;
        b=F0L95uV9E/AgMjCwe/WYoZXPBgf+yhKojr2kVa/MF4G527YdhqKjf5Q5Mv33jX2wjv
         8um03WQLBpIuJmNpyW1rrq6pqd7ivlxlyg1PrupURv1xG17IMWvBwBeZu9kTd+LHA0Tz
         h5OrSzx1SZfPBfWP/F7dg8OHGsyp8CN5Hcvb0F9yWYY6b5XISZM1TCUoh4AjpWUCIgRR
         Nb1ypQ1vICq4UmE5ua0Ay+Catlm5Vnlx9Xg9GXX0B23/SCG+R0l19PoP9KA+w36yNG+m
         BA9zVgqQFeJTh9PyxYLU2HYSTzBlDV4dzhh8qNuiScCk3f1/OMcdWcMNsRcVVn8BsTXT
         hV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uZXl4RLzzhryYGc4tfKASYNpJNQsDtpLhwIbhtBkN3M=;
        b=Zdl1/cyMNvQNEDwn3lC4ZihiH6EXguCeCj5PbcPjnqNv+yr3or9BiBvFLBTSEXzRUy
         iWPEf09DJvYm6DUaXPS+NEpJLG8NmT0I77OqBntCFFNPwirH8I7IUq7/a4G4Zw4sBWjG
         x9/GvPM51w72L/TlJtlN7tKJClnQCAUg1YIA7jHd68GDTpQBeqo7MMpVKml+G/r2tWxr
         l8RTrHUqmsHYvnVfXSfIFN0unP+C8ZCpEGWgMWINFDl3uRnqrU22ZG6hNmicVTlWv74A
         L0k2oG6aFUs2SVnTZ4wE+iNZMOocKqDMgeL9ypzWHJr+d/Zsl32LYDldq/kAHthvbflC
         D1GQ==
X-Gm-Message-State: AOAM532artEJsqGQ0LagjTzaDFoVgtWLun9SCfQKqLnCnMoxZ/207F0q
        Q14oTZRFuRVDrCg55/QsUoPM3g==
X-Google-Smtp-Source: ABdhPJw4SRDFxPfuEXUDRQ9DhN6jntw+xx1j8+l9XIR4Izuz22pyXEpmTAY0If5aRfg7SVPU9apKOQ==
X-Received: by 2002:a05:6512:b9f:b0:478:5bf0:67f9 with SMTP id b31-20020a0565120b9f00b004785bf067f9mr12209045lfv.313.1653392056241;
        Tue, 24 May 2022 04:34:16 -0700 (PDT)
Received: from [172.20.68.48] ([91.221.145.6])
        by smtp.gmail.com with ESMTPSA id i22-20020a2e8656000000b0024f3d1daed0sm2451344ljj.88.2022.05.24.04.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 04:34:15 -0700 (PDT)
Message-ID: <f42f4b45-f8cb-8855-8814-5dfaaf446d4a@linaro.org>
Date:   Tue, 24 May 2022 13:34:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/7] dt-bindings: soc: add bindings for i.MX93 SRC
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220523113029.842753-1-peng.fan@oss.nxp.com>
 <20220523113029.842753-2-peng.fan@oss.nxp.com>
 <c2882212-aa1e-4614-c982-43e6c793b34a@linaro.org>
 <DU0PR04MB9417F22B607C95BDAB84C01488D79@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB9417F22B607C95BDAB84C01488D79@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2022 12:37, Peng Fan wrote:
>> Subject: Re: [PATCH 1/7] dt-bindings: soc: add bindings for i.MX93 SRC
>>
>> On 23/05/2022 13:30, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> Add bindings for i.MX93 System Reset Controller(SRC). SRC supports
>>> resets and power gating for mixes.
>>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>  .../bindings/soc/imx/fsl,imx93-src.yaml       | 88
>> +++++++++++++++++++
>>>  include/dt-bindings/power/imx93-power.h       | 11 +++
>>>  2 files changed, 99 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
>>
>> File should be in respective subsystem, so probably power/reset?
> 
> ok, will put under power.
> 
>>
>>>  create mode 100644 include/dt-bindings/power/imx93-power.h
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
>>> b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
>>> new file mode 100644
>>> index 000000000000..d45c1458b9c1
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
>>> @@ -0,0 +1,88 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
>>> +---
>>> +$id:
>>> +> > +title: NXP i.MX9 System Reset Controller
>>> +
>>> +maintainers:
>>> +  - Peng Fan <peng.fan@nxp.com>
>>> +
>>> +description: |
>>> +  The System Reset Controller (SRC) is responsible for the generation
>>> +of
>>> +  all the system reset signals and boot argument latching.
>>> +
>>> +  Its main functions are as follows,
>>> +  - Deals with all global system reset sources from other modules,
>>> +    and generates global system reset.
>>> +  - Responsible for power gating of MIXs (Slices) and their memory
>>> +    low power control.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - const: fsl,imx93-src
>>> +      - const: syscon
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  slice:
>>
>> Why do you need this subnode, instead of listing domains here?
> 
> I follow
> Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
> 
> There are several slices in SRC, just like there are many pgcs in gpcv2.

Wait, but you have only one slice and you do no allow more of them. The
same as for gpcv2 - there is only one pgc. What's the point of that node?

> 
> 
>>
>>> +    type: object
>>> +    description: list of power domains provided by this controller.
>>> +
>>
>> Hm, what about address/size cells? Is syscon schema bringing these?
> 
> The slice submode should have address/size cells, but I not
> meet yaml/dtbs check error. Will add it.
> 
> Not sure syscon bringing or not.
> 
>>
>>> +    patternProperties:
>>> +      "power-domain@[0-9]$":
>>> +        type: object
>>
>> Missing ref to power-domain.yaml
> 
> Ok.
> 
>>
>>> +        properties:
>>> +
>>> +          '#power-domain-cells':
>>> +            const: 0
>>> +
>>> +          reg:
>>> +            description: |
>>> +              Power domain index. Valid values are defined in
>>> +              include/dt-bindings/power/imx93-power.h for fsl,imx93-src
>>> +            maxItems: 1
>>> +
>>> +          clocks:
>>> +            description: |
>>> +              A number of phandles to clocks that need to be enabled
>>> +              during domain power-up sequencing to ensure reset
>>> +              propagation into devices located inside this power domain.
>>> +            minItems: 1
>>> +            maxItems: 5
>>> +
>>> +        required:
>>> +          - '#power-domain-cells'
>>> +          - reg
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - slice
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/clock/imx93-clock.h>
>>> +    #include <dt-bindings/power/imx93-power.h>
>>> +
>>> +    src@44460000 {
>>
>> reset-controller
>> or some other generic node name.
> 
> It is not a single reset or power domain controller,
> Currently linux driver just use it as a power domain
> controller.

Then maybe system-controller.

> 
> Thanks,
> Peng.
> 
>>
>>> +        compatible = "fsl,imx93-src", "syscon";
>>> +        reg = <0x44460000 0x10000>;
>>> +
>>> +        slice {
>>> +                #address-cells = <1>;
>>> +                #size-cells = <0>;
>>> +
>>> +                mediamix: power-domain@0 {
>>
>> Best regards,
>> Krzysztof


Best regards,
Krzysztof

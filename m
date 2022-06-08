Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A889A54292E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiFHIRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiFHIPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:15:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577DA25F41D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:44:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u12so39749754eja.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 00:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=N2n4ue6PvN6bYRXZMADyZay+yUMidu99Jpd+YeUrnSA=;
        b=EN01mXO3gemFA0PVoJChdj4QdHI1gLkxsAGQia81YCD5SnC0p/H3vC0bs/YFKRLsz5
         TKg1iprCemQ5rTvvNZt2zEpQdA9ubyqYnl0Qc6r1x1+gVapgHIm6AazbUK+d0QjdLSNU
         ADEtPXitLSnC4xasjZJEvcZnIPs1F9XnfCq2HpWC70Btu7OM/tWTdDHJT/BtCtvZObok
         oBSNCdmGPQt+a4oBurqbktDCdOUkAB0jwhHhsAzzAdHlrZZdlfW0Zj0YVKTrv+r39Cli
         DnHFoHJRPgGEG9w3QMMEe+cvibpTIUCEg/43ZN87gA01F6Xlpg3n4TCzvy17V09EYGjj
         JiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N2n4ue6PvN6bYRXZMADyZay+yUMidu99Jpd+YeUrnSA=;
        b=W8OjbHUKicJ2pEGm+o1s8xiS/XJNHdQ4O4c2/9izhjOa58Fgion3nnbvMa5kEYyyoW
         59n90LXQu05YPC+dlUfWxlNLk+8EM+UUbSDgfX7NEiqdLoFlai4DQz103hJiNuZBvEhS
         Nxo5PByzNAjS8229HaEnw3gzGRCpxZqvXLErpQup3mFbzcIRZEi+gEWye37LMQxu4mCW
         2dCF1IoxpH0N3GtN3/tftSno7egd/4PBdrznEG+QqbhN4Pp6DJIE8WlasT72K26S41Fu
         tIYuJzeh0nbaHf+uZwein0FC4lX8hJOERUf4o5r04zZGYuPV6bR8XqsqKXOeCZHKMMQK
         Ezgw==
X-Gm-Message-State: AOAM531IlflobYJGEZJGJW0Dg5s+HHiElryU0kq082An141BInl2Fzhi
        r6bt4HrhYtvT2zuKxfGjziuRHQ==
X-Google-Smtp-Source: ABdhPJxktVGx8ZCyus9xJ9fy5x0fPfD7lcKo9ekfLPVPW5eczfU5qTVPGdJFlmZrt/qJH5NCv2WViQ==
X-Received: by 2002:a17:907:724c:b0:711:d0bc:2369 with SMTP id ds12-20020a170907724c00b00711d0bc2369mr13248474ejc.23.1654674272867;
        Wed, 08 Jun 2022 00:44:32 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id cf18-20020a170906b2d200b006ff802baf5dsm8738219ejb.54.2022.06.08.00.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 00:44:32 -0700 (PDT)
Message-ID: <d2a81596-3a70-98e4-c406-36417d36f00b@linaro.org>
Date:   Wed, 8 Jun 2022 09:44:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] dt-binding: mfd: Add Richtek RT5120 PMIC support
Content-Language: en-US
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>, dmitry.torokhov@gmail.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
References: <1654581161-12349-1-git-send-email-u0084500@gmail.com>
 <1654581161-12349-2-git-send-email-u0084500@gmail.com>
 <96ecca0b-b65c-749d-d66b-33443cacf2e4@linaro.org>
 <CADiBU39BTr9FjtXgBe55aOTHNVotHfC1n=aHrH3XAcVoWkk8sA@mail.gmail.com>
 <678ce480-cbbc-ffa8-10bf-d93021a0df0a@linaro.org>
 <CADiBU38Gc2McH0ryRFPUAkmJzL1rxQnLHqvo5-+U_TPVjgHxzg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CADiBU38Gc2McH0ryRFPUAkmJzL1rxQnLHqvo5-+U_TPVjgHxzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2022 09:25, ChiYuan Huang wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 於 2022年6月8日 週三 下午3:02寫道：
>>
>> On 08/06/2022 04:52, ChiYuan Huang wrote:
>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 於 2022年6月7日 週二 下午7:52寫道：
>>>>
>>>> On 07/06/2022 07:52, cy_huang wrote:
>>>>> From: ChiYuan Huang <cy_huang@richtek.com>
>>>>>
>>>>> Add Richtek RT5120 PMIC devicetree document.
>>>>>
>>>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>>>>> ---
>>>>>  .../devicetree/bindings/mfd/richtek,rt5120.yaml    | 180 +++++++++++++++++++++
>>>>>  1 file changed, 180 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml b/Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml
>>>>> new file mode 100644
>>>>> index 00000000..376bf73
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml
>>>>> @@ -0,0 +1,180 @@
>>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/mfd/richtek,rt5120.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Richtek RT5120 PMIC
>>>>> +
>>>>> +maintainers:
>>>>> +  - ChiYuan Huang <cy_huang@richtek.com>
>>>>> +
>>>>> +description: |
>>>>> +  The RT5120 provides four high-efficiency buck converters and one LDO voltage
>>>>> +  regulator. The device is targeted at providingthe processor voltage, memory,
>>>>> +  I/O, and peripheral rails in home entertainment devices. The I2C interface is
>>>>> +  used for dynamic voltage scaling of the processor voltage, power rails on/off
>>>>> +  sequence control, operation mode selection.
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - richtek,rt5120
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  interrupts:
>>>>> +    maxItems: 1
>>
>> Your powerkey driver takes two interrupts. You should describe them in
>> the powerkey.
>>
>>>>> +
>>>>> +  interrupt-controller: true
>>>>> +
>>>>> +  "#interrupt-cells":
>>>>> +    const: 1
>>>>> +
>>>>> +  wakeup-source: true
>>>>> +
>>>>> +  richtek,enable-undervolt-hiccup:
>>>>> +    type: boolean
>>>>> +    description: |
>>>>> +      If used, under voltage protection trigger hiccup behavior, else latchup as
>>>>> +      default
>>>>> +
>>>>> +  richtek,enable-overvolt-hiccup:
>>>>> +    type: boolean
>>>>> +    description:
>>>>> +      Like as 'enable-uv-hiccup', it configures over voltage protection to
>>>>> +      hiccup, else latchup as default
>>>>> +
>>>>> +  vin1-supply:
>>>>> +    description: phandle for buck1 input power source
>>>>> +
>>>>> +  vin2-supply:
>>>>> +    description: phandle for buck2 input power source
>>>>> +
>>>>> +  vin3-supply:
>>>>> +    description: phandle for buck3 input power source
>>>>> +
>>>>> +  vin4-supply:
>>>>> +    description: phandle for buck4 input power source
>>>>> +
>>>>> +  vinldo-supply:
>>>>> +    description: phandle for ldo input power source
>>>>> +
>>>>> +  regulators:
>>>>> +    type: object
>>>>> +
>>>>> +    patternProperties:
>>>>> +      "^buck[1-4]$":
>>>>> +        type: object
>>>>> +        $ref: /schemas/regulator/regulator.yaml#
>>>>> +
>>>>> +        properties:
>>>>> +          regulator-allowed-modes:
>>>>> +            description: |
>>>>> +              Used to specify the allowed buck converter operating mode
>>>>> +              mode mapping:
>>>>> +                0: auto mode
>>>>> +                1: force pwm mode
>>>>> +            items:
>>>>> +              enum: [0, 1]
>>>>> +
>>>>> +        unevaluatedProperties: false
>>>>
>>>> Better to put it after '$ref' for readability.
>>> OK, Fix in next
>>>>
>>>>> +
>>>>> +      "^(ldo|exten)$":
>>>>> +        type: object
>>>>> +        $ref: /schemas/regulator/regulator.yaml#
>>>>
>>>> You need here unevaluatedProperties:false as well (for the ldo/exten
>>>> properties)
>>> Fix in next.
>>>>
>>>>> +
>>>>> +    additionalProperties: false
>>>>> +
>>>>> +  powerkey:
>>>>> +    type: object
>>>>> +    description:
>>>>> +      The power key driver may be optional. If not used, change node status to
>>>>> +      'disabled'
>>>>
>>>> This description is not helpful, does not describe the hardware. Please
>>>> describe hardware, not Devicetree usage.
>>> That's because it's a PMIC. Power key is also connected to it.
>>> For power key press, all power rails will start to power up.
>>> But in the application, there may be other PMIC that's also connected
>>> to power key.
>>> That's why this power key driver may need to be optional.
>>> One system only need one driver to report the power key status.
>>>
>>> Currently in some linux OS, it uses the auto module loading mechanism.
>>> All kernel module files may be all the same, but it uses the
>>> devicetree to decide how many devices
>>> need to be declared. Since RT5120 power key device may be optional,
>>> following by mfd_add_device, if of_node is
>>> found, and status is "disabled", the sub device would be skipped.
>>>
>>> Actually, I'm also confused about it. There may be three ways to implement it
>>> 1. not to build this kernel module -> seems to violate my above application
>>> 2. Use one boolean property to decide power key cell need to be used or not??
>>> 3. like as now, use the node status to decide it.
>>>
>>> Is there the better way to do it?
>>
>> The status does not determine whether device in the bindings is optional
>> or not. Rather it's presence. In the term of bindings the "optional"
>> means that something might not be there physically. E.g. clock line
>> connected or not. System implementation - MFD, power off handling - is
>> here (almost) irrelevant.
>>
>> In your case, the power key feature seems to be there always, so the
>> "powerkey" node should be required and not disabled. Don't mention in
>> description of hardware anything about disabling it or not.
>>
>> In your application, I would say it is interesting design that someone
>> connects one power up line to two different PMICs in a conflicting way.
>> This sounds like total mistake from hardware point of view.
>>
>> Anyway it is not the job for this patch to solve such conflicts.
>>
> Thanks,  I think your point is 'optional' keyword.
> If there's only redundant description line, I may decide to remove it.
> The property name already show its usage.

I repeated my point twice - your description is not relevant to the
bindings:
"This description is not helpful, does not describe the hardware. Please
describe hardware, not Devicetree usage."
"System implementation - MFD, power off handling - is
here (almost) irrelevant."
"Don't mention in
description of hardware anything about disabling it or not."

Please describe briefly the hardware behind this property, not status or
other Devicetree usage.


Best regards,
Krzysztof

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B8E5247B1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351344AbiELIO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349973AbiELIOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:14:23 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5757B5DBED
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:14:20 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id p18so5292796edr.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dKj3Wkk5G60lVyTD5qpq1NcTw9sWsRvLava+2G5nJbs=;
        b=etNSNPWcfTj3Ga3QAPpZ99dN9/OxZpengwlNA+k1El504Pf3TOhGGS+VGx3NSKyx4B
         DT+//kgDlbF17wpaOmvjiihu/ZsVyNB/o/fC+oXm4N14dv3riYtOHKrGwvn2TdZDLduJ
         gVAiJffesApMhZvLIozNhGfyVgn37kNp+WhoxQt5pP1PrgWR8Xki/sw/UWCtY8tBSorj
         x+HoeSklzYpg0BeZ7h7vnZDTu6e+pIhT4VYztwJgzukZRkT4SzgdA9WVO2FexrhD1dpZ
         DO/+S+oEvmXnN1/A5YFo8aL2L2Yx5ihvDVKPt0EjoZejF2foomYWP0PiTRyFHwAMdE6N
         CZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dKj3Wkk5G60lVyTD5qpq1NcTw9sWsRvLava+2G5nJbs=;
        b=qlP6duRo9eDefzHlz662sduO3c9oLevXHqQcGGqCHlefJ5MIDHu4bnlm125rpIqPNj
         AZVRTZmX5TzPOVjKMsuDpZadiOv2aHBRTGe8vU7ovNpmkRAuJHPv10qQbOvzCsRufoPF
         vhfDFbcxROfFZHqwTiRqCFsFGscIHvyTFWi6F7o2fv+ARml+PgRCOyELVXE69/HTazGX
         tMDtvqALL2Ni1ODFodG1fqazSHnTxq7DIf7UMbUFKuGfkk0wcPqwyyKUYyj+jodo8rY/
         KsBvUSlJv2J5SWvwoRmE8sjcSlLlGzFXukWTBu4y8lykMitlj4B2ZtZg+E2Zl/hnBAV3
         +Msw==
X-Gm-Message-State: AOAM530g0AXeT+hZn+yBEuOYfBWpqDn4j9u/JORj6EfC3ElIFeM4mAlY
        U6Vfx9Ao3Fio6MbFk9Ctuh0uuQ==
X-Google-Smtp-Source: ABdhPJzkxgOSxH40scNowpHv6e6D0YUfb9fvbfZ7RnSikZ9iUxIxoKqkCYnsmEcVrB2Pn0jmTUywIw==
X-Received: by 2002:a05:6402:128b:b0:425:d1d7:b321 with SMTP id w11-20020a056402128b00b00425d1d7b321mr33309173edv.179.1652343258888;
        Thu, 12 May 2022 01:14:18 -0700 (PDT)
Received: from [192.168.0.156] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h3-20020aa7c603000000b0042a41ad4688sm71edq.65.2022.05.12.01.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 01:14:18 -0700 (PDT)
Message-ID: <a62822a4-a771-dfa9-f46d-586fdccedf66@linaro.org>
Date:   Thu, 12 May 2022 10:14:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 4/9] dt-bindings: remoteproc: qcom: wcnss: Convert to YAML
Content-Language: en-US
To:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        linux-remoteproc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
 <20220511161602.117772-5-sireeshkodali1@gmail.com>
 <00234f36-9bae-31d5-5b83-ea238e7e3c11@linaro.org>
 <CJXL0SG2GHN1.1IO2JOR5ARNV8@skynet-linux>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CJXL0SG2GHN1.1IO2JOR5ARNV8@skynet-linux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 08:50, Sireesh Kodali wrote:
> On Wed May 11, 2022 at 10:45 PM IST, Krzysztof Kozlowski wrote:
>> On 11/05/2022 18:15, Sireesh Kodali wrote:
>>> Convert the dt-bindings from txt to YAML. This is in preparation for
>>> including the relevant bindings for the MSM8953 platform's wcnss pil.
>>>
>>> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>> Please use existing bindings or example-schema as a starting point. Half
>> of my review could be skipped if you just followed what we already have
>> in the tree.
>>
>> Some of these qcom specific properties already exist but you decided to
>> write them differently... please don't, rather reuse the code.
>>
> 
> Thank you for your review, I will make the chnages as appropriate in v2.
>> (...)
>>
>>> +
>>> +maintainers:
>>> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
>>> +
>>> +description:
>>> +  This document defines the binding for a component that loads and boots
>>> +  firmware on the Qualcomm WCNSS core.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - items:
>>> +          - enum:
>>> +              - qcom,pronto-v2-pil
>>> +          - enum:
>>> +              - qcom,pronto
>>
>> This does not look correct. The fallback compatible should not change.
>> What is more, it was not documented in original binding, so this should
>> be done in separate patch.
>>
> 
> This was not a change to the fallback compatible. 

You made it an enum, so you expect it to use different fallback for
different cases.

> msm8916.dtsi's wcnss
> node has "qcom,pronto" as the compatible string, which is why this was
> added. It is however not documented in the txt file. Is it sufficient to
> add a note in the commit message, or should it be split into a separate
> commit?

Please split it, assuming that fallback is correct. Maybe the fallback
is wrong?

> 
>>> +      - items:
>>
>> No need for items, it's just one item.
>>
>>> +          - enum:
>>> +              - qcom,riva-pil
>>> +              - qcom,pronto-v1-pil
>>> +              - qcom,pronto-v2-pil
>>> +
>>> +  reg:
>>> +    description: must specify the base address and size of the CCU, DXE and PMU
>>> +      register blocks
>>
>> New line after "decription:", drop "must specify" and start with capital
>> letter.
>>
>> You need maxItems: 3
>>
> 
> Will fix in v2
>>
>>> +
>>> +  reg-names:
>>> +    items:
>>> +      - const: ccu
>>> +      - const: dxe
>>> +      - const: pmu
>>> +
>>> +  interrupts-extended:
>>> +    description:
>>> +      Interrupt lines
>>
>> Skip description, it's obvious.
>>
>> It should be only "interrupts", not extended.
>>
>>> +    minItems: 2
>>> +    maxItems: 5
>>> +
>>> +  interrupt-names:
>>> +    minItems: 2
>>> +    maxItems: 5
>>
>> Names should be clearly defined. They were BTW defined in original
>> bindings, so you should not remove them. This makes me wonder what else
>> did you remove from original bindings...
>>
>> Please document all deviations from pure conversion in the commit msg.
>> It's a second "hidden" difference.
>>
> 
> Sorry, this was meant to be a pure txt->YAML conversion. The missing
> interrupt names was accidental, and will be fixed in v2.
>>> +
>>> +  firmware-name:
>>> +    $ref: /schemas/types.yaml#/definitions/string
>>> +    description: Relative firmware image path for the WCNSS core. Defaults to
>>> +      "wcnss.mdt".
>>
>>
>> Blank line after "description:". This applies to other places as well.
>>
>> Remove "Defailts to ..." and just add "default" schema.
>>
> 
> Will be fixed in v2
>>> +
>>> +  vddpx-supply:
>>> +    description: Reference to the PX regulator to be held on behalf of the
>>> +      booting of the WCNSS core
>>> +
>>> +  vddmx-supply:
>>> +    description: Reference to the MX regulator to be held on behalf of the
>>> +      booting of the WCNSS core.
>>> +
>>> +  vddcx-supply:
>>> +    description: Reference to the CX regulator to be held on behalf of the
>>> +      booting of the WCNSS core.
>>
>> s/Reference to the//
>>
>>> +
>>> +  power-domains:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +    description: References to the power domains that need to be held on
>>> +      behalf of the booting WCNSS core
>>
>> 1. Ditto.
>> 2. No need for ref
>> 3. maxItems
>>
>>> +
>>> +  power-domain-names:
>>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>
>> No need for ref, skip description.
>>
>>> +    description: Names of the power domains
>>> +    items:
>>> +      - const: cx
>>> +      - const: mx
>>> +
>>> +  qcom,smem-states:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +    description: States used by the AP to signal the WCNSS core that it should
>>> +      shutdown
>>> +    items:
>>> +      - description: Stop the modem
>>> +
>>> +  qcom,smem-state-names:
>>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>
>> No need for ref. Really, it does not appear in any of existing bindings
>> for smem-state-names, so how did you get it?
>>
> 
> The smem nodes were copied from /remoteproc/qcom,sdm845-adsp-pil.yaml

Hm, indeed, you're right. There are few files having here ref. I'll fix
these.

> 
>>> +    description: The names of the state bits used for SMP2P output
>>> +    items:
>>> +      - const: stop
>>> +
>>> +  memory-region:
>>> +    maxItems: 1
>>> +    description: Reference to the reserved-memory for the WCNSS core
>>> +
>>> +  smd-edge:
>>> +    type: object
>>> +    description:
>>> +      Qualcomm Shared Memory subnode which represents communication edge,
>>> +      channels and devices related to the ADSP.
>>
>> You should reference /schemas/soc/qcom/qcom,smd.yaml
> 
> Will be done in v2
>>
>>> +
>>> +  iris:
>>
>> Generic node name... what is "iris"?
>>
> Iris is the RF module, I'll make the description better

RF like wifi? Then the property name should be "wifi".



Best regards,
Krzysztof

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C7C5712AD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiGLHDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiGLHC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:02:59 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D8497485
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:02:57 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bf9so12363767lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=h6vjT/+13UEo3taiLb0JZhbnEJD4OKWdgkoVYLaG7U4=;
        b=AteyLzo/29Sra+G1JJSzU6YanwduZHPrxRI1IXt+jbIdDv+m7a5wxF/zLl91+FCjWc
         tjnme78FxZIQ5y0qWauUXSXL8gk5dVZOqX/WLbCf5XyzA/CcXsPa0w+ERPju3jMjLMy2
         z12f8KkWwJl1qY9oXVFyu/lFWu3ZAucF+1ZRiPXbsXMDTQVudCm9cxl6vELtfGAqM0WZ
         /WYcftS0wmZR/doOtTFMUQdyGbzjJQVHWdp4Dk7dJVbCa7SdJFJmxCQXGjea8NNhh0nh
         Mx/vU4aWZLUY58tuSpNBex4D8+llI9Y9YZBCA3z2+Q4nBgpZOekdJ2M+596M69fZbMOB
         ZsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h6vjT/+13UEo3taiLb0JZhbnEJD4OKWdgkoVYLaG7U4=;
        b=rJfetQG2lpMhu9Mft0F4QQuS3K4tpGC9i6nfaBOh3WHdJKD3QBLegzxluOOa7ZHMU7
         clMk+v+9KW85yZ3Mlshc5P7RijCpdCnSi4ws/+j/XbZurbSIOTx+PJviNU0G4Ii2hKDD
         1F6dA8sGzMygYqWFDMxoRkg9fYeHfUqNAQih0pANZxdtN8ny67av5Sy6y5XRTp+C1nq4
         uFoxDEfgh4Cu9s9TL07zNQA2bS78bR+jZ1AiFraa2/n4vFU0hjKgi9A1jkLpUbEHA5L6
         qlTimkKPaBqR3cuWEBrC5ZXb1NFnjPdABHUmKGfkOv0rSuvh9decCfq0gFJwnBfUqdD0
         iIOQ==
X-Gm-Message-State: AJIora/8bqB+rljEDXyDL+FyZwArWPAz/qZbME5yTdF/adFDghG4kAdW
        TNAPLlW+swwMWPI6HoCNx7dG+Q==
X-Google-Smtp-Source: AGRyM1vkArgZCtCXerr2SI10QhpZQudBGhHUD/0jvs3TtC3hTTXrSQFgWaQhd2FYGnYc3OxFmZ+jpg==
X-Received: by 2002:a05:6512:13a4:b0:479:3b9f:f13c with SMTP id p36-20020a05651213a400b004793b9ff13cmr13939823lfa.380.1657609376176;
        Tue, 12 Jul 2022 00:02:56 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id y14-20020a05651c154e00b0025d680fbd89sm1688767ljp.8.2022.07.12.00.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 00:02:55 -0700 (PDT)
Message-ID: <629ede41-326b-9c84-4bb8-2f7e695ca928@linaro.org>
Date:   Tue, 12 Jul 2022 09:02:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/5] dt-bindings: mmc: sdhci-msm: constrain reg-names
 perp variants
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20220711082940.39539-1-krzysztof.kozlowski@linaro.org>
 <20220711082940.39539-3-krzysztof.kozlowski@linaro.org>
 <CAD=FV=WUCPzzZHAPqoz-vhmcVxzYDxkKQs=+1tLZvsQjWe4q3Q@mail.gmail.com>
 <f8744ff8-15a0-bf31-c49f-b1bb35ba5cdd@linaro.org>
 <CAD=FV=X2ZfwwDO_hSSN35ObfvBbBbPjMoSB4GvS7m0yJieNg3Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=X2ZfwwDO_hSSN35ObfvBbBbPjMoSB4GvS7m0yJieNg3Q@mail.gmail.com>
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

On 11/07/2022 17:11, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jul 11, 2022 at 7:53 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 11/07/2022 16:52, Doug Anderson wrote:
>>> Hi
>>>
>>> On Mon, Jul 11, 2022 at 1:29 AM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> The entries in arrays must have fixed order, so the bindings and Linux
>>>> driver expecting various combinations of 'reg' addresses was never
>>>> actually conforming to guidelines.
>>>>
>>>> The 'core' reg entry is valid only for SDCC v4 and lower, so disallow it
>>>> in SDCC v5.  SDCC v4 supports CQE and ICE, so allow them, even though
>>>> the qcom,sdhci-msm-v4 compatible is used also for earlier SoCs with SDCC
>>>> v2 or v3, so it is not entirely accurate.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>> ---
>>>>
>>>> Changes since v1:
>>>> 1. Rework the patch based on Doug's feedback.
>>>> ---
>>>>  .../devicetree/bindings/mmc/sdhci-msm.yaml    | 61 ++++++++++++-------
>>>>  1 file changed, 38 insertions(+), 23 deletions(-)
>>>
>>> In the ${SUBJECT} I'm not sure what a "perp variant" is. Is that a
>>> typo or just a phrase I'm not aware of?
>>
>> Should be:
>> "per variants"
>>
>>>
>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>>>> index fc6e5221985a..2f0fdd65e908 100644
>>>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>>>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>>>> @@ -49,33 +49,11 @@ properties:
>>>>
>>>>    reg:
>>>>      minItems: 1
>>>> -    items:
>>>> -      - description: Host controller register map
>>>> -      - description: SD Core register map
>>>> -      - description: CQE register map
>>>> -      - description: Inline Crypto Engine register map
>>>> +    maxItems: 4
>>>>
>>>>    reg-names:
>>>>      minItems: 1
>>>>      maxItems: 4
>>>> -    oneOf:
>>>> -      - items:
>>>> -          - const: hc
>>>> -      - items:
>>>> -          - const: hc
>>>> -          - const: core
>>>> -      - items:
>>>> -          - const: hc
>>>> -          - const: cqhci
>>>> -      - items:
>>>> -          - const: hc
>>>> -          - const: cqhci
>>>> -          - const: ice
>>>> -      - items:
>>>> -          - const: hc
>>>> -          - const: core
>>>> -          - const: cqhci
>>>> -          - const: ice
>>>>
>>>>    clocks:
>>>>      minItems: 3
>>>> @@ -177,6 +155,43 @@ required:
>>>>  allOf:
>>>>    - $ref: mmc-controller.yaml#
>>>>
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            enum:
>>>> +              - qcom,sdhci-msm-v4
>>>> +    then:
>>>> +      properties:
>>>> +        reg:
>>>> +          minItems: 2
>>>> +          items:
>>>> +            - description: Host controller register map
>>>> +            - description: SD Core register map
>>>> +            - description: CQE register map
>>>> +            - description: Inline Crypto Engine register map
>>>> +        reg-names:
>>>> +          minItems: 2
>>>> +          items:
>>>> +            - const: hc
>>>> +            - const: core
>>>> +            - const: cqhci
>>>> +            - const: ice
>>>> +    else:
>>>> +      properties:
>>>> +        reg:
>>>> +          minItems: 1
>>>> +          items:
>>>> +            - description: Host controller register map
>>>> +            - description: CQE register map
>>>> +            - description: Inline Crypto Engine register map
>>>> +        reg-names:
>>>> +          minItems: 1
>>>> +          items:
>>>> +            - const: hc
>>>> +            - const: cqhci
>>>> +            - const: ice
>>>
>>> Do you need to set "maxItems" here? If you don't then will it inherit
>>> the maxItems of 4 from above?
>>
>> No, items determine the size instead.
> 
> Can you just remove the "maxItems" from above then? Does it buy us anything?

There is no maxItems directly here...

> 
> In any case, with the ${SUBJECT} fixed:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>


Best regards,
Krzysztof

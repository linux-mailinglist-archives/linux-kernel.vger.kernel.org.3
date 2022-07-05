Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3553C567649
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiGESVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiGESVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:21:17 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6CC140AD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:21:16 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id o10so4882456ljj.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lc/DllG7KxkZCTw83RcsvkqOa+Sy6VMTQfSxor2YCtQ=;
        b=Ax0aDgRv822aSTlNdy5MvBg+ySYUNHAmasbQp5ZDd/K59R3kb8I1Lylxqm9xvPABFt
         aUfkpB+aP2tzc4iGTTxgeV2L/KpNtHn52ZFVtcCusc+CAIm0Ve4SSefN/kTT52pfqFId
         3LkP0Yi7dK2ogvvSZHs27kjnc9F96hDyfvvK9+g4r9DSGPunPjWdYg2F22pCtHakW7p+
         Mejo1vpRuLbJQJ/EPSngTo8cTMn2PrJbBFegZzEKmA7h/ucnzMFw+99MAISwOmHNNWbI
         oM5SdWKWfN/GKJ2o433RiwNJS9kRTOxnSAalbY5qOI/cAqr/FC/7sgrJ7DWBeWK5gGr8
         DH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lc/DllG7KxkZCTw83RcsvkqOa+Sy6VMTQfSxor2YCtQ=;
        b=2xIS48CN7VsOz6k8l00d9kiFKAeGSLrT8aEzifet9rp+M3ghJj3Tb7fF2fDMfncVp1
         PU5Q1WKYgPk9AGGEWY4R7ZFHEV3pDYvvucQoe4scly1bCBZ1UHwCI0oxQyAVI5Wclrap
         g6WhbOc8mvu/bUNzDRm5+P3PKG8MDmW9xJgDXdcwI8oqipGHriJK6we2mphVAEHpBsYe
         A/w8M8yn9ZKzzcHV786bK9MQpBTn0pQq3D9cCqhktzhIrs7Aamj5E05Ddg7APqP7cE9J
         AtiXmQQE1TqgF5hrxUWR/LDpkxLF8HzwqUlBLdN8YqEju0YtQkk0nft+AwHkY8VO1j4+
         w17g==
X-Gm-Message-State: AJIora8F50MNEqOhuZaXJsNtJWRHHq69/2uOAb4lgvoKEDb1JRL5GOh9
        Ddigp+JHA3tl2HGlu7vuYIz72g==
X-Google-Smtp-Source: AGRyM1s/CyCMumswFxHBjhmwKYGhrAxlBUNIjyJQ+86kIiMm7Jtq6KG87aEVvjb0P9LKLUOppXTI3A==
X-Received: by 2002:a05:651c:322:b0:25d:3128:1842 with SMTP id b2-20020a05651c032200b0025d31281842mr3092722ljp.486.1657045274431;
        Tue, 05 Jul 2022 11:21:14 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id q4-20020a0565123a8400b004796e1555eesm5800575lfu.199.2022.07.05.11.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 11:21:13 -0700 (PDT)
Message-ID: <cf61b071-aa31-6f67-07f1-4f15e0fe7511@linaro.org>
Date:   Tue, 5 Jul 2022 20:21:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 17/43] dt-bindings: phy: qcom,qmp-pcie: add missing child
 node schema
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-18-johan+linaro@kernel.org>
 <4bc79a1c-66b1-225d-5026-ddf3e6f7d22c@linaro.org>
 <YsQlzr6nyvz761Kz@hovoldconsulting.com>
 <963917cf-0f9d-600f-564e-9e687270b1af@linaro.org>
 <YsQqcKZAs1xAB9+S@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YsQqcKZAs1xAB9+S@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 14:11, Johan Hovold wrote:
> On Tue, Jul 05, 2022 at 01:56:32PM +0200, Krzysztof Kozlowski wrote:
>> On 05/07/2022 13:51, Johan Hovold wrote:
>>> On Tue, Jul 05, 2022 at 12:18:37PM +0200, Krzysztof Kozlowski wrote:
>>>> On 05/07/2022 11:42, Johan Hovold wrote:
>>>>> Add the missing the description of the PHY-provider child node which was
>>>>> ignored when converting to DT schema.
>>>>>
>>>>> Also fix up the incorrect description that claimed that one child node
>>>>> per lane was required.
>>>>>
>>>>> Fixes: ccf51c1cedfd ("dt-bindings: phy: qcom,qmp: Convert QMP PHY bindings to yaml")
>>>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>>>> ---
>>>>>  .../bindings/phy/qcom,qmp-pcie-phy.yaml       | 88 ++++++++++++++++++-
>>>>>  1 file changed, 85 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
>>>>> index ff1577f68a00..5a1ebf874559 100644
>>>>> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
>>>>> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
>>>>> @@ -69,9 +69,37 @@ properties:
>>>
>>>>> +  - if:
>>>>> +      properties:
>>>>> +        compatible:
>>>>> +          contains:
>>>>> +            enum:
>>>>> +              - qcom,sm8250-qmp-gen3x2-pcie-phy
>>>>> +              - qcom,sm8250-qmp-modem-pcie-phy
>>>>> +              - qcom,sm8450-qmp-gen4x2-pcie-phy
>>>>> +    then:
>>>>> +      patternProperties:
>>>>> +        "^phy@[0-9a-f]+$":
>>>>> +          properties:
>>>>> +            reg:
>>>>> +              items:
>>>>> +                - description: TX lane 1
>>>>> +                - description: RX lane 1
>>>>> +                - description: PCS
>>>>> +                - description: TX lane 2
>>>>> +                - description: RX lane 2
>>>>> +                - description: PCS_MISC
>>>>> +    else:
>>>>> +      patternProperties:
>>>>> +        "^phy@[0-9a-f]+$":
>>>>> +          properties:
>>>>> +            reg:
>>>>> +              minItems: 3
>>>>> +              maxItems: 4
>>>>> +              items:
>>>>> +                - description: TX
>>>>> +                - description: RX
>>>>> +                - description: PCS
>>>>> +                - description: PCS_MISC
>>>>> +      if:
>>>>
>>>> Do not include if within other if. Just split the entire section to its
>>>> own if:.
>>>
>>> That sounds like it would just obfuscate the logic. The else clause
>>> specified 3-4 registers and the nested if determines which compatibles
>>> use which by further narrowing the range.
>>>
>>> If you move it out to the else: this would be really hard understand and
>>> verify.
>>
>> Every bindings are expected to do that way and most of them are doing
>> it: define broad constraints in properties:, then define strict
>> constraints per each variant. Easy to follow code. This binding is not
>> particularly special to make it different than other ones. Doing
>> semi-strict constraints in if: and then additional constrain in nested
>> if: is not easy to understand and verify.
> 
> Ok, so you want to flatten this by repeating also the register
> descriptions?
> 
> That wouldn't hurt readability as much, but doing so would be more error
> prone as it's easy to miss adding a new compatible in every group of
> conditionals and there's no else clause to catch the mistake.
> 
> Right know the logic is
> 
> 	if dual-lane
> 		items = 6
> 	else
> 		items = 3 or 4
> 		if single-lane-exception
> 			items = 3
> 		else
> 			items = 4
> 
> Flattening this gives
> 
> 	if dual-lane
> 		items = 6
> 	if single-lane-normal
> 		items = 4
> 	if single-lane-exception
> 		items = 3
> 
> Which means that every compatible must now be listed in one of the
> conditionals.

Yes, because it's explicit and easy to read. Handling compatibles in
'else' makes it opposite - one cannot use grep and cannot easily find
what is actually covered by maxItems:4 (you need to check all 7
compatibles to find what is not covered here).

> 
> Fine with me, but please confirm that I understood you correctly.

You have already flattened if-if-if for clocks and resets, so this
should follow similar approach. I don't think it could be squashed with
that previous if-if-if, though.

Best regards,
Krzysztof

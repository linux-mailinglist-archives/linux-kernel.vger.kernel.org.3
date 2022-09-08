Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88635B2158
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiIHOzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiIHOzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:55:42 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6829C229
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:55:40 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id y29so7615233ljq.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 07:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=fgfnhY3Ull0vFOfCmjRPglZnCyMcEKdcwqQSL0htN4s=;
        b=Tfxv0wLLpxiul/CCTKgU19nq1+XuXriBZ9LEMrMatNFJ1wo2fzx/HSwJqbhQM44pmK
         wwdS9BNxGTEgHi0RmOwgAN3usrdTi/vOqYrMp+qN/466jLe50E4voyYfGoqsfVRtk4Yu
         GGs8UuleALrZvGc3Em9sxDAuWYiNV5JWHBznhh/PNQfGPRFewKAe78QbCzZvmo7D0fNH
         p5z7id3h1Bd3mKefKckdHPrEHoFDDNOrQiQ2d0daHrehbFKtiuI1nHgpufCe1DWyLE/o
         9QBOwZig6kQNYdGH4bSIzTozQCH3DT5PviCl1OC9UVmflrCatHXBpui/QATYDhZwXc7q
         6Huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fgfnhY3Ull0vFOfCmjRPglZnCyMcEKdcwqQSL0htN4s=;
        b=O5El0Lp/L2AQULvNmWOPzuNrnGXEmKJ7oAKUSj+PoX6KewIvD5lWHGmVbbuuexEP/g
         /MIqGQ4d6+VySdw9bLq4riG07DbZobLMJA3rHrH7NzByDy3kEIa/nJs8VjQG9tqEa/zR
         o/QLISDJuQpig+PZUqO1U51srJRJwt/xd4iF8VmbzgMqDJT32c7K1YtNzKRNbnWuX75I
         nsukPPXZ08xP//Kj4X31+XczZYnXOfWMwqw/7oohe1w57VzGs/loQ6KV/EPkSTxdOVef
         orQyptjQz1y8D2J/VeJqKwtpRBAguI0/zf7LNnlIw3RyuFMrwPm1EUMEJTZ7EGuQ7Ogp
         T55g==
X-Gm-Message-State: ACgBeo1mtbSiixwrNVrVigSsMNSSD8KS8x47wrLuE9p5n9VlJEesAsV3
        E3x2c6MFcGQ0QnFWbaBH5QK/tw==
X-Google-Smtp-Source: AA6agR7CdTkFme++fxO7yCuNAUYEhQGmRtghzjNi1mJGcVbSKLCJ2f0obGMN5IJudh/AGuecUAFTjg==
X-Received: by 2002:a2e:a910:0:b0:26a:ed13:cda6 with SMTP id j16-20020a2ea910000000b0026aed13cda6mr1407716ljq.250.1662648939305;
        Thu, 08 Sep 2022 07:55:39 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c16-20020ac24150000000b0048afd0c496fsm3066503lfi.156.2022.09.08.07.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 07:55:38 -0700 (PDT)
Message-ID: <889151be-9ea8-6a9e-e5fe-eac1dd93250c@linaro.org>
Date:   Thu, 8 Sep 2022 16:55:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 1/2] dt-bindings: power: reset: qcom-pon: update "reg"
 property details
Content-Language: en-US
To:     Anjelique Melendez <quic_amelende@quicinc.com>, corbet@lwn.net,
        sre@kernel.org, robh+dt@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Collins <quic_collinsd@quicinc.com>
References: <20220725191314.19456-1-quic_amelende@quicinc.com>
 <20220725191314.19456-2-quic_amelende@quicinc.com>
 <a47a33a5-aec7-2a52-f1e8-52c45307862e@linaro.org>
 <0e6bf142-ca56-2414-86c4-1a18b74b3ba6@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0e6bf142-ca56-2414-86c4-1a18b74b3ba6@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2022 22:26, Anjelique Melendez wrote:
> 
> Hi Krzysztof,
> First I would like to apologize for my lack of response to this patch series
> over these past few weeks. I have been out of office.
> 
> On 7/26/2022 3:25 AM, Krzysztof Kozlowski wrote:
>> On 25/07/2022 21:13, Anjelique Melendez wrote:
>>> From: David Collins <quic_collinsd@quicinc.com>
>>>
>>> Update the description of "reg" property to add the PON_PBS base
>>> address along with PON_HLOS base address.  Also add "reg-names"
>>> property constraints.
>>>
>>> Signed-off-by: David Collins <quic_collinsd@quicinc.com>
>>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>>> ---
>>>  Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 50 +++++++++++++++++++++++++++---
>>>  1 file changed, 46 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>>> index 353f155d..d7b6b875 100644
>>> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>>> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>>> @@ -15,18 +15,27 @@ description: |
>>>  
>>>    This DT node has pwrkey and resin as sub nodes.
>>>  
>>> -allOf:
>>> -  - $ref: reboot-mode.yaml#
>>> -
>>>  properties:
>>>    compatible:
>>>      enum:
>>>        - qcom,pm8916-pon
>>>        - qcom,pms405-pon
>>>        - qcom,pm8998-pon
>>> +      - qcom,pmk8350-pon
>>>  
>>>    reg:
>>> -    maxItems: 1
>>> +    description: |
>>> +      Specifies the SPMI base address for the PON (power-on) peripheral.  For
>>> +      PMICs that have the PON peripheral (GEN3) split into PON_HLOS and PON_PBS
>>> +      (e.g. PMK8350), this can hold addresses of both PON_HLOS and PON_PBS
>>> +      peripherals.  In that case, the PON_PBS address needs to be specified to
>>> +      facilitate software debouncing on some PMIC.
>>> +    minItems: 1
>>> +    maxItems: 2
>>> +
>>> +  reg-names:
>>> +    minItems: 1
>>> +    maxItems: 2
>>>  
>>>    pwrkey:
>>>      type: object
>>> @@ -42,6 +51,39 @@ required:
>>>  
>>>  unevaluatedProperties: false
>>>  
>>> +allOf:
>>> +  - $ref: reboot-mode.yaml#
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - qcom,pm8916-pon
>>> +              - qcom,pms405-pon
>>> +              - qcom,pm8998-pon
>>> +    then:
>>> +      properties:
>>> +        reg:
>>> +          maxItems: 1
>>> +        reg-names:
>>> +          items:
>>> +            - const: pon
>>
>> All your previous patches were actually missing (in commit msg, in the
>> code) that piece of information which you add here. You now add
>> reg-names with "pon" for older devices. I assumed previous that it is
>> somehow needed, so I gave you the hints how it should be coded. But I
>> don't understand - why are you doing it
>>
>> This should be explained in commit msg. To me it is not needed at all...
>> unless you want to mark that first address space is entirely different
>> for other devices?
> Adding reg-names "pon" for older devices is simply to provide clarification
> about what the register relates to. Similar to reg-names "hlos" and "pbs"
> for gen3 children devices, reg-names is completely optional and is not
> consumed by any driver.

OK, can be. Include it in the commit msg, please.


Best regards,
Krzysztof

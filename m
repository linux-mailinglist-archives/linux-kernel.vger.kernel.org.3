Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985015AC600
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 21:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiIDTKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 15:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbiIDTKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 15:10:18 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A131918355
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 12:10:15 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id k18so7227862lji.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Zg+iO2cHAZ4r3CwVknTSd9WpAQ+T+PmH9eUM+TKxTdc=;
        b=BOb1TQqLBg3Vo9NOObXNapdN3fX1o2A47xccVzPBEh3W6eETgX0cVeJZJ+Pbu3sUUd
         e3VT1m7M2ht2A1QeJwtWSMgFH7REHFEKHtriZLobW2N6MRbsxmSI8Qf6WkuPkS4l3kyb
         8tXScDm6Z6GeBQ6iDmT4s1HOvBCpvagV2Jiizr64YjxGMl0jv3Z3+j+KfscEOZwqfzUy
         Oy478r+iOEZHRIC/xZoNu719WhIlen/bWReEhsqTmZ5mEbAWLY5PmUq6FKRpQHbwdgQH
         ezy6GprCjx7XKx5F0g81Aajc8WvDtmmxc5ZtW7U0q9dtyNQZsJDl0AYj8ZWQ4c6IS7c3
         O4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Zg+iO2cHAZ4r3CwVknTSd9WpAQ+T+PmH9eUM+TKxTdc=;
        b=r6yV1aFli6eSTesObdSlQIT25NEFMggaiJMeG5c4znaDZDW4mxPd+IFfQThhuVdUJC
         0AHzH7Dc/Rds1nAcGriPwbno8cUVBe8yTaXa3ECxtT1K0tPeYZyPyThgOuZT8VnufZmb
         w/CQoPIzGq5E0DF1PN30jES6aS+6VxcS35n97yBDFGF7e/RPlabn6sl7QJQe/JZ9DeEA
         SO6Pjj5rwvv6EEz2mbMGo85zVrRgf7OEeQucZxRvNuDPZ8fiEktNfBZ/g0TZD/kkHBVu
         6RvOhM2QiToC+Cgl04JFL8o3YkWqpDsqt8XIxbaMtevmVq8bmaRnIpGWh126qxaUcPCr
         z5bQ==
X-Gm-Message-State: ACgBeo2Xgpkn8UHQb9VQMgM8sYq2D2+jCG+0M8KS1aYRhsHmdnEVmCK3
        RfuiPO27L8JVQ+l4G88+SFA4qQ==
X-Google-Smtp-Source: AA6agR4G1EVK6Vkm3ynfxZbN+nIgBnYZIWjL6IipexTk4VhVtEQ6oXIt2rHZsPBpI/X/zmGj4u3Fqw==
X-Received: by 2002:a2e:a99b:0:b0:261:b1a1:4ee9 with SMTP id x27-20020a2ea99b000000b00261b1a14ee9mr14389646ljq.366.1662318613931;
        Sun, 04 Sep 2022 12:10:13 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k6-20020ac257c6000000b00490b5f09973sm992560lfo.92.2022.09.04.12.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Sep 2022 12:10:13 -0700 (PDT)
Message-ID: <199167f2-0420-8c56-5156-35005069549d@linaro.org>
Date:   Sun, 4 Sep 2022 22:10:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 08/14] dt-bindings: ufs: qcom: Add sm6115 binding
Content-Language: en-US
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
 <20220901072414.1923075-9-iskren.chernev@gmail.com>
 <7804ffbe-4e27-d8bd-dbe2-75d1323da064@linaro.org>
 <89e6a200-d9af-7263-5e09-d7d824277a30@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <89e6a200-d9af-7263-5e09-d7d824277a30@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2022 19:54, Iskren Chernev wrote:
> 
> 
> On 9/1/22 19:11, Krzysztof Kozlowski wrote:
>> On 01/09/2022 10:24, Iskren Chernev wrote:
>>> Add SM6115 UFS to DT schema.
>>>
>>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
>>> ---
>>>  .../devicetree/bindings/ufs/qcom,ufs.yaml     | 26 +++++++++++++++++++
>>>  1 file changed, 26 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>>> index f2d6298d926c..7c5f6e2e6d4c 100644
>>> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>>> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>>> @@ -28,6 +28,7 @@ properties:
>>>            - qcom,msm8998-ufshc
>>>            - qcom,sc8280xp-ufshc
>>>            - qcom,sdm845-ufshc
>>> +          - qcom,sm6115-ufshc
>>>            - qcom,sm6350-ufshc
>>>            - qcom,sm8150-ufshc
>>>            - qcom,sm8250-ufshc
>>> @@ -178,6 +179,31 @@ allOf:
>>>            minItems: 1
>>>            maxItems: 1
>>>
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - qcom,sm6115-ufshc
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          minItems: 8
>>> +          maxItems: 8
>>> +        clock-names:
>>> +          items:
>>> +            - const: core_clk
>>> +            - const: bus_aggr_clk
>>> +            - const: iface_clk
>>> +            - const: core_clk_unipro
>>> +            - const: core_clk_ice
>>
>> Use existing name and put it in the same place as existing variant - sdm845:
>> ice_core_clk
> 
> The only problem with sdm845 bindings is the presence of rx_lane1_sync_clk
> clock. I'm guessing I could pass zeros there, because it shouldn't be used. Or
> it could be moved to last property and then min/maxItems to guard, but that is
> a change to something more-or-less immutable.

I don't understand - what is the problem here. How presence of some
clock affects name of other clock and its place/location in list of clocks?


Best regards,
Krzysztof

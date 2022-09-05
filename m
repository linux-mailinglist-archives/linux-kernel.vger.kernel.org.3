Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D1F5ACF72
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbiIEKDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbiIEKDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:03:21 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270F05301B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:03:19 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z29so12341151lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 03:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=teZIYNw0Fgke9Op5/gTN1ZRD/QOncOzj4BAdZFEwFdA=;
        b=HdDCQI6Q+HJCwXp3FgMfTyaA02W4zxJofsFCwnYxj88HQFIEAKtpQ480Ft6m7Jdkg1
         q5vnmjGoDcjdCqF6KfR+P9e1otoTo6Pr13lDZqwT2EzMCrziCt92NioVPtRKwM9PsIFT
         2mhVuDHwvw7sEeBqQPx39eirCmal//zTOveYliRx1yadi/NNfObwMOzRN8xYyiVYzBwA
         DG5Yt5isUdHzF+TEZSyb57nh7ieQ266LNyhexy/hvHrFJhACD3OLjhpGVCn4MKvsSc7y
         DWolu+poofnVw8PGVkIGjuG+/jtkl5Fpy0N5981KWdq1qqeNM4O+Gdfnm2gFm0Aa2P8l
         ET0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=teZIYNw0Fgke9Op5/gTN1ZRD/QOncOzj4BAdZFEwFdA=;
        b=CYY12aaDBLbLJ9+HPBSh/ZMq8DNcedvV+nez8apROPFIF9gIAPJn6o9zjLU65odLrU
         wyIab2o/u5gEd4zpu8Jmatz7rku0QYL8iyS85y73NBJIZC+2Vg7kc6oJGm1LL3xlBnMH
         UwwjmcWVKenJxHCGDC5gExuCo+HfgUDwhg/aCDgSIwpmL+EUfJqsTHIUqrJVi99v3W7c
         qdlVsSv4U6dbpgNYftpO9oCqo7LLRy45opTQOQeskycVPj3dNJeiTlDMPVIXmD/v5Gon
         qR6PIfx+L8KwVvySsQYuus//ymAI3cg/3Hcc0yeYTA937mHwmcfIVbx6IGyaGj1qPHOl
         CqGw==
X-Gm-Message-State: ACgBeo2ajEFIe6+ndmmcAXzEKuZyGbdFQDsD43y6h6so7pas7tRnAkGk
        pKBeMs/JPV5cwN7JWXgOJpkajw==
X-Google-Smtp-Source: AA6agR6wA0dmt6SDnTvjKayaQZYpX4H6ra1OL8OH9mAIg2hnrbyfR5RqQ0HGgN92n8+sBnJ34bdK8w==
X-Received: by 2002:a05:6512:234e:b0:494:8a27:ddca with SMTP id p14-20020a056512234e00b004948a27ddcamr7538561lfu.656.1662372197390;
        Mon, 05 Sep 2022 03:03:17 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p1-20020a05651238c100b00492cfecf1c0sm1139985lft.245.2022.09.05.03.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 03:03:16 -0700 (PDT)
Message-ID: <5e947462-d8f4-350e-22ad-b048b0e494bf@linaro.org>
Date:   Mon, 5 Sep 2022 12:03:15 +0200
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
 <199167f2-0420-8c56-5156-35005069549d@linaro.org>
 <72f86c4f-79fa-bff4-f14e-4cd7fa7ce41f@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <72f86c4f-79fa-bff4-f14e-4cd7fa7ce41f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2022 09:29, Iskren Chernev wrote:
> 
> 
> On 9/4/22 22:10, Krzysztof Kozlowski wrote:
>> On 03/09/2022 19:54, Iskren Chernev wrote:
>>>
>>>
>>> On 9/1/22 19:11, Krzysztof Kozlowski wrote:
>>>> On 01/09/2022 10:24, Iskren Chernev wrote:
>>>>> Add SM6115 UFS to DT schema.
>>>>>
>>>>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
>>>>> ---
>>>>>  .../devicetree/bindings/ufs/qcom,ufs.yaml     | 26 +++++++++++++++++++
>>>>>  1 file changed, 26 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>>>>> index f2d6298d926c..7c5f6e2e6d4c 100644
>>>>> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>>>>> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>>>>> @@ -28,6 +28,7 @@ properties:
>>>>>            - qcom,msm8998-ufshc
>>>>>            - qcom,sc8280xp-ufshc
>>>>>            - qcom,sdm845-ufshc
>>>>> +          - qcom,sm6115-ufshc
>>>>>            - qcom,sm6350-ufshc
>>>>>            - qcom,sm8150-ufshc
>>>>>            - qcom,sm8250-ufshc
>>>>> @@ -178,6 +179,31 @@ allOf:
>>>>>            minItems: 1
>>>>>            maxItems: 1
>>>>>
>>>>> +  - if:
>>>>> +      properties:
>>>>> +        compatible:
>>>>> +          contains:
>>>>> +            enum:
>>>>> +              - qcom,sm6115-ufshc
>>>>> +    then:
>>>>> +      properties:
>>>>> +        clocks:
>>>>> +          minItems: 8
>>>>> +          maxItems: 8
>>>>> +        clock-names:
>>>>> +          items:
>>>>> +            - const: core_clk
>>>>> +            - const: bus_aggr_clk
>>>>> +            - const: iface_clk
>>>>> +            - const: core_clk_unipro
>>>>> +            - const: core_clk_ice
>>>>
>>>> Use existing name and put it in the same place as existing variant - sdm845:
>>>> ice_core_clk
>>>
>>> The only problem with sdm845 bindings is the presence of rx_lane1_sync_clk
>>> clock. I'm guessing I could pass zeros there, because it shouldn't be used. Or
>>> it could be moved to last property and then min/maxItems to guard, but that is
>>> a change to something more-or-less immutable.
>>
>> I don't understand - what is the problem here. How presence of some
>> clock affects name of other clock and its place/location in list of clocks?
> 
> qcom,sdm845-ufshc has 9 clocks, one of which is rx_lane1_sync_clk.
> qcom,sm6115-ufshc has 8 clocks (all of the ones in sdm845 without
> rx_lane1_sync_clk). So if I'm understanding correctly, you want to put the
> sm6115 with sdm845, which means re-use the clocks and reg specification from
> sdm845, which means sm6115 will "inherit" this rx_lane1_sync_clk, and then
> I have to put it in DT (otherwise the schema would complain), and I'm asking if
> I can put an empty (i.e <0 0>) value, so schema is satisfied but clock is still
> not really passed.

No. I want to use the same order and naming as sdm845 variant, but in
your own/dedicated if:else: entry. Just do not create inconsistencies
when not needed. If inconsistency is needed here (which I think is not),
please explain more.

Best regards,
Krzysztof

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FF155492E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357664AbiFVJwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354579AbiFVJuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:50:52 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B42139BBE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:50:51 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id j22so12048998ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4RBApn5CDhg7PHpqxQG29XAdBERA48WW5Z24IVRZKfo=;
        b=oI13i6SJj9j/UgQgRWuDvDzs7Ch+pLrtHVr9AN4iOLmgr0uoSO7s+UiagnosyetVPa
         Gqxr6AIqZdjXj8Nkfu0HW3fhfio1AsB1sRe0OXGJA9Ui/q/5TSN5IkkuWIl/0sFOV0oP
         yry7yLlBCKGUQ3gLszmeqjgFYuS7tKhorXf7cmUjxanncLo/hxRBbjJCyhnUprtt9Uy9
         QWTPM+pnRRN4EzHVXwtGEl/ocdwXrozH38t5eeGQutcyjpGjH7wciGeiREuYIKYrRDqG
         ka80Thv30Z/UMbFKHHiIVwfQR8bJ6h77HheU/21Mk9pjtvSQUamIRkYU5d87Cxz1hxgL
         tlgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4RBApn5CDhg7PHpqxQG29XAdBERA48WW5Z24IVRZKfo=;
        b=NauniPhaLz430qQF9nFOAw29ZCDfjsmkQ2C5zMJ7I8VURn82doFwnPs8jWDV1SuZ9D
         BlWTtSig31YLZnMMlVV2yFUsRTdwFMSsFr3h8C5SAzjs7UfNxAiqW5M8gvehWyiCZq9U
         +eAg2wuVxWOdMDYiD2Jl0IL7bolQA9rT6ge+mSehIGMeEYtCpUipFMt4uZGEd3Mb6Z75
         wkkHPX7cPXbWEc70d9pWwye3Rl5yQgimuvAxiq6PKH96oEsdfAnN0Pvu7WNKhYI+3PUX
         K1Xkomg960Ul1DE6VUE0kWcvNRxftEkqbUDG1A26sjSV2I4uC5fhRvGXEmkOlyvCNyqV
         GmZg==
X-Gm-Message-State: AJIora+9Jwd5pem6v1et8fpEPB+v3NThLM9frNvE6yfrl1wXXuCoZTHB
        yjoj4cOokbW+KArMQt+C6KLQ9A==
X-Google-Smtp-Source: AGRyM1vBbov2B9skWmfQGya+WghuFSIUDF+Y6tv9RKsEHYmZdUGILrS+cOk/8tjLDOWBFRWPTThK7Q==
X-Received: by 2002:a2e:8e8c:0:b0:25a:76d6:7580 with SMTP id z12-20020a2e8e8c000000b0025a76d67580mr1329557ljk.461.1655891449361;
        Wed, 22 Jun 2022 02:50:49 -0700 (PDT)
Received: from [192.168.1.212] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id p7-20020a2eba07000000b0025a8457e40dsm315577lja.140.2022.06.22.02.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 02:50:48 -0700 (PDT)
Message-ID: <0a525c93-377f-18bc-93dd-7cd4c8767c03@linaro.org>
Date:   Wed, 22 Jun 2022 12:50:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom: document qcom,msm-id and
 qcom,board-id
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Stephen Boyd <sboyd@kernel.org>
References: <20220621185649.37391-1-krzysztof.kozlowski@linaro.org>
 <20220621185649.37391-2-krzysztof.kozlowski@linaro.org>
 <3ccbcaa0-d5b6-9f46-03c3-2a3e0ee72782@linaro.org>
 <ad2733ea-4a7b-d8d4-0380-3270f9e6bf9a@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <ad2733ea-4a7b-d8d4-0380-3270f9e6bf9a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 22/06/2022 12:49, Krzysztof Kozlowski wrote:
> On 22/06/2022 11:44, Dmitry Baryshkov wrote:
>> On 21/06/2022 21:56, Krzysztof Kozlowski wrote:
>>> The top level qcom,msm-id and qcom,board-id properties are utilized by
>>> bootloaders on Qualcomm MSM platforms to determine which device tree
>>> should be used and passed to the kernel.
>>>
>>> The commit b32e592d3c28 ("devicetree: bindings: Document qcom board
>>> compatible format") from 2015 was a consensus during discussion about
>>> upstreaming qcom,msm-id and qcom,board-id fields.  There are however still
>>> problems with that consensus:
>>> 1. It was reached 7 years ago but it turned out its implementation did
>>>      not reach all possible products.
>>>
>>> 2. Initially additional tool (dtbTool) was needed for parsing these
>>>      fields to create a QCDT image consisting of multiple DTBs, later the
>>>      bootloaders were improved and they use these qcom,msm-id and
>>>      qcom,board-id properties directly.
>>>
>>> 3. Extracting relevant information from the board compatible requires
>>>      this additional tool (dtbTool), which makes the build process more
>>>      complicated and not easily reproducible (DTBs are modified after the
>>>      kernel build).
>>>
>>> 4. Some versions of Qualcomm bootloaders expect these properties even
>>>      when booting with a single DTB.  The community is stuck with these
>>>      bootloaders thus they require properties in the DTBs.
>>>
>>> Since several upstreamed Qualcomm SoC-based boards require these
>>> properties to properly boot and the properties are reportedly used by
>>> bootloaders, document them.
>>>
>>> Link: https://lore.kernel.org/r/a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org/
>>> Co-developed-by: Kumar Gala <galak@codeaurora.org>
>>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>    .../devicetree/bindings/arm/qcom.yaml         | 123 ++++++++++++++++++
>>>    include/dt-bindings/arm/qcom,ids.h            |  30 +++++
>>>    2 files changed, 153 insertions(+)
>>>    create mode 100644 include/dt-bindings/arm/qcom,ids.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> index 6c38c1387afd..05b98cde4653 100644
>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> @@ -403,6 +403,129 @@ properties:
>>>                  - qcom,sm8450-qrd
>>>              - const: qcom,sm8450
>>>    
>>> +  # Board compatibles go above
>>> +
>>> +  qcom,msm-id:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>>> +    minItems: 1
>>> +    maxItems: 8
>>> +    items:
>>> +      items:
>>> +        - description: |
>>> +            MSM chipset ID - an exact match value consisting of three bitfields::
>>> +             - bits 0-15  - The unique MSM chipset ID
>>> +             - bits 16-31 - Reserved; should be 0
>>> +        - description: |
>>> +            Hardware revision ID - a chipset specific 32-bit ID representing
>>> +            the version of the chipset.  It is best a match value - the
>>> +            bootloader will look for the closest possible match.
>>> +    deprecated: true
>>> +    description:
>>> +      The MSM chipset and hardware revision use by Qualcomm bootloaders.  It
>>> +      can optionally be an array of these to indicate multiple hardware that
>>> +      use the same device tree.  It is expected that the bootloader will use
>>> +      this information at boot-up to decide which device tree to use when given
>>> +      multiple device trees, some of which may not be compatible with the
>>> +      actual hardware.  It is the bootloader's responsibility to pass the
>>> +      correct device tree to the kernel.
>>> +      The property is deprecated - it is not expected on newer boards
>>> +      (starting with SM8350).
>>
>> I have been thinking about this for quite a while. I think this patch is
>> good.
>>
>> With this paragraph (and the corresponding paragraph from the next item)
>> rephrased to remove references to 'newer boards':
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Great, thanks! And thank you for responding in previous discussions.
> 
> I'll remove entire "newer boards ..." part, fix the "two bitfields" and
> change the name of the define QCOM_ID_MSM8996. I won't add more board
> IDs yet, this can be in following up patches (not only my me).

This sounds perfect to me. Thanks a lot for your work on sorting this out!

-- 
With best wishes
Dmitry

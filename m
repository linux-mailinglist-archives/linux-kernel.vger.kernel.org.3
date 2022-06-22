Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B4E554639
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353461AbiFVJtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244653AbiFVJto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:49:44 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9DD393F9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:49:43 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p6-20020a05600c1d8600b0039c630b8d96so571275wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sxnAC9ssgWJ++cNvqcUOmZiut71bqWmpozQR24g0Gxc=;
        b=k/aFEXhakVbncsKO/ubxZTNg3TC/r4m4VZhoT2Sy3tJzLPVz3fG4WbMQzModN01UTt
         wgsCcZZ1LzTUsN5voPfmGYR5uD3tPWbJGnu20gTh1TeZWPj2092Zh1BXwZPaX2kZouWb
         FwVG1XWkFeUdSPenb8o8XJbuLlvAarfWmxtdZcRc7NW4iE0uuYmNZ+bCZL2eceh5loDB
         kv68nB14mxX+vG5sBpy27p+gdORP/mOvtt+9z5a+4aTCsXgLvXZBDSlmKETfT8GZ3VlE
         1ijBIx0OOuuApGd9jKjVkj1sR5d6hhfMCeYvzndBAbUU6fMb/8ELh14SWTs0+TW3+BzR
         MGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sxnAC9ssgWJ++cNvqcUOmZiut71bqWmpozQR24g0Gxc=;
        b=CM4jiPyYffaIAVLpwTxaiTDSqbIp4lcrrhJss3yqk/7VzB+jdLbcZjDnCg1D4Yg2do
         yf7cdg/PKVx2PJOvI+b1gGdbewxt6tzfi4E+NZpSv+VU17X7TUQel5MpUWEmqj5nXah5
         EeIBMyoh4mo01+tOD62J8ozwjY2P/lfDmiooYtE6lmatskeWi9Q2qK9RfjDtb+hvXiXx
         LYcfU9VvZKiJv9SNVd/4lFAJLaxib/Rs26V44j0DuDk9A8SXpZSHKsOhmqlw4nqXqik1
         x4J5wYlfffO3XG9txOpIlN8a8l5T5QZXjImJ4P6pEP3QqM05mhc28Xw75F1SFLAM7SY2
         nXag==
X-Gm-Message-State: AJIora8PidC8eSUwHVuDkdL1dYPiPpAO5Wf/+aIC6PNGE45V6olStGOx
        mFuZaEwU3EyhMBxE7FyfMuFv7Q==
X-Google-Smtp-Source: AGRyM1umV2JqbdZ+TDmxUiWOavJsZHuFxee8UBF957LvezlFpb2Y77y0WIRXcJr8XRSnbhTP4HftEg==
X-Received: by 2002:a7b:c4d4:0:b0:39c:5bb7:2210 with SMTP id g20-20020a7bc4d4000000b0039c5bb72210mr2778702wmk.99.1655891382289;
        Wed, 22 Jun 2022 02:49:42 -0700 (PDT)
Received: from [192.168.0.224] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c350800b0039c50d2d28csm25850744wmq.44.2022.06.22.02.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 02:49:41 -0700 (PDT)
Message-ID: <ad2733ea-4a7b-d8d4-0380-3270f9e6bf9a@linaro.org>
Date:   Wed, 22 Jun 2022 11:49:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom: document qcom,msm-id and
 qcom,board-id
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
        Kumar Gala <galak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
References: <20220621185649.37391-1-krzysztof.kozlowski@linaro.org>
 <20220621185649.37391-2-krzysztof.kozlowski@linaro.org>
 <3ccbcaa0-d5b6-9f46-03c3-2a3e0ee72782@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3ccbcaa0-d5b6-9f46-03c3-2a3e0ee72782@linaro.org>
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

On 22/06/2022 11:44, Dmitry Baryshkov wrote:
> On 21/06/2022 21:56, Krzysztof Kozlowski wrote:
>> The top level qcom,msm-id and qcom,board-id properties are utilized by
>> bootloaders on Qualcomm MSM platforms to determine which device tree
>> should be used and passed to the kernel.
>>
>> The commit b32e592d3c28 ("devicetree: bindings: Document qcom board
>> compatible format") from 2015 was a consensus during discussion about
>> upstreaming qcom,msm-id and qcom,board-id fields.  There are however still
>> problems with that consensus:
>> 1. It was reached 7 years ago but it turned out its implementation did
>>     not reach all possible products.
>>
>> 2. Initially additional tool (dtbTool) was needed for parsing these
>>     fields to create a QCDT image consisting of multiple DTBs, later the
>>     bootloaders were improved and they use these qcom,msm-id and
>>     qcom,board-id properties directly.
>>
>> 3. Extracting relevant information from the board compatible requires
>>     this additional tool (dtbTool), which makes the build process more
>>     complicated and not easily reproducible (DTBs are modified after the
>>     kernel build).
>>
>> 4. Some versions of Qualcomm bootloaders expect these properties even
>>     when booting with a single DTB.  The community is stuck with these
>>     bootloaders thus they require properties in the DTBs.
>>
>> Since several upstreamed Qualcomm SoC-based boards require these
>> properties to properly boot and the properties are reportedly used by
>> bootloaders, document them.
>>
>> Link: https://lore.kernel.org/r/a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org/
>> Co-developed-by: Kumar Gala <galak@codeaurora.org>
>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   .../devicetree/bindings/arm/qcom.yaml         | 123 ++++++++++++++++++
>>   include/dt-bindings/arm/qcom,ids.h            |  30 +++++
>>   2 files changed, 153 insertions(+)
>>   create mode 100644 include/dt-bindings/arm/qcom,ids.h
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 6c38c1387afd..05b98cde4653 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -403,6 +403,129 @@ properties:
>>                 - qcom,sm8450-qrd
>>             - const: qcom,sm8450
>>   
>> +  # Board compatibles go above
>> +
>> +  qcom,msm-id:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>> +    minItems: 1
>> +    maxItems: 8
>> +    items:
>> +      items:
>> +        - description: |
>> +            MSM chipset ID - an exact match value consisting of three bitfields::
>> +             - bits 0-15  - The unique MSM chipset ID
>> +             - bits 16-31 - Reserved; should be 0
>> +        - description: |
>> +            Hardware revision ID - a chipset specific 32-bit ID representing
>> +            the version of the chipset.  It is best a match value - the
>> +            bootloader will look for the closest possible match.
>> +    deprecated: true
>> +    description:
>> +      The MSM chipset and hardware revision use by Qualcomm bootloaders.  It
>> +      can optionally be an array of these to indicate multiple hardware that
>> +      use the same device tree.  It is expected that the bootloader will use
>> +      this information at boot-up to decide which device tree to use when given
>> +      multiple device trees, some of which may not be compatible with the
>> +      actual hardware.  It is the bootloader's responsibility to pass the
>> +      correct device tree to the kernel.
>> +      The property is deprecated - it is not expected on newer boards
>> +      (starting with SM8350).
> 
> I have been thinking about this for quite a while. I think this patch is 
> good.
> 
> With this paragraph (and the corresponding paragraph from the next item) 
> rephrased to remove references to 'newer boards':
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Great, thanks! And thank you for responding in previous discussions.

I'll remove entire "newer boards ..." part, fix the "two bitfields" and
change the name of the define QCOM_ID_MSM8996. I won't add more board
IDs yet, this can be in following up patches (not only my me).

Best regards,
Krzysztof

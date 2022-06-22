Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00713554374
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349639AbiFVHA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243496AbiFVHA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:00:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02EC3631E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:00:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w17so21956876wrg.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=b/Ja2hBJrDIyLQOgEyheQP9Iy9WcTGSkCNMUgwPIYZk=;
        b=q7KUZSP/8hX3EFAM2R6hC1nbfSsCIawlFtOugo8immdtRYxSjx02bYlLwg2Vo7KE2k
         9DZmkK122M5HiaOgvAnygTZ9TlxOaMTTde/fWCFG+vs3WUMla9XjFXhtBeDHX/No1paK
         rY7AyCmSViHA5ahQqEuxj06iaZZdCk7wjP6zxUKarFr+4OKLt2PuBbm7Eh15BLJ4Ah6K
         /eQkb4S3UzmrM2n55joAqlQ3/yQ4Az2vh7STMMUdAZy1JnFU/tAffx+CeMQpWlQeeXE6
         2tvibmOVNVvYss3ts31cbthnmfPAHCBsnloUpfwNbzArHSNxkaDta3rpFC1MLVZOWiiv
         B+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b/Ja2hBJrDIyLQOgEyheQP9Iy9WcTGSkCNMUgwPIYZk=;
        b=26/OeWFwUDE7hJ79zRjk5LhQXByCFXfGrDlYBA+Kg6tfIn5d4+mLcRET04d98Yfds2
         f4+PvL9jndZB3F8Cb9GgJgvKc9rtCYLC2Id27LhULYCN11EZHUBv/n+nRh6s3ujJI6JX
         O3ElNbiRkwgQBsCwAgDdGEAOfUqfqmCr6MHkCF9ZestQxCGVokRctqS2lzcjw2DJ3RSU
         Us4PmhVP4MFfLyrHLupYO9gHVF5yPcX4EBsukcJ9yleEqPed7JZUyvgyk0Y4/uVzZXo8
         4MGdOs6DpMk4jVEs+/aNps7NBST0zG0TUScYPC3Sc620MmlUMuYCrCweKocqYxoHcOci
         kqBw==
X-Gm-Message-State: AJIora8Df2/C41DjJqXlsxdJKphUrMk3hHpksV9Tb1PVIupj1bCHFeap
        rjMCDNsCOQwtx9HfnL4B8Gm9OA==
X-Google-Smtp-Source: AGRyM1tYARg4sIUvffhSMqjIYpOrduq3LmXqYNfnJstzbMV8Ms9t2EaokDJ07vuxYyd9oHlWZIXkXA==
X-Received: by 2002:a5d:5888:0:b0:217:fffd:6aae with SMTP id n8-20020a5d5888000000b00217fffd6aaemr1630824wrf.330.1655881224182;
        Wed, 22 Jun 2022 00:00:24 -0700 (PDT)
Received: from [192.168.0.223] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l8-20020a1ced08000000b0039744bd664esm24054554wmh.13.2022.06.22.00.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 00:00:23 -0700 (PDT)
Message-ID: <70300b95-8b4d-5029-bfbb-544abbc64441@linaro.org>
Date:   Wed, 22 Jun 2022 09:00:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom: document qcom,msm-id and
 qcom,board-id
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Kumar Gala <galak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
References: <20220621185649.37391-1-krzysztof.kozlowski@linaro.org>
 <20220621185649.37391-2-krzysztof.kozlowski@linaro.org>
 <609d1f0f-daca-4fde-3315-5d8e171ca5c4@linaro.org>
 <7ef854a5-0e56-c71e-447a-f52cdcf51ef0@linaro.org>
 <CAA8EJpp3HqsPOcz1t9W=cjExuddjEV2MaA10L5mMgcUrmqUmAQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJpp3HqsPOcz1t9W=cjExuddjEV2MaA10L5mMgcUrmqUmAQ@mail.gmail.com>
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

On 21/06/2022 21:49, Dmitry Baryshkov wrote:
> On Tue, 21 Jun 2022 at 22:32, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 21/06/2022 21:26, Dmitry Baryshkov wrote:
>>> On 21/06/2022 21:56, Krzysztof Kozlowski wrote:
>>>> The top level qcom,msm-id and qcom,board-id properties are utilized by
>>>> bootloaders on Qualcomm MSM platforms to determine which device tree
>>>> should be used and passed to the kernel.
>>>>
>>>> The commit b32e592d3c28 ("devicetree: bindings: Document qcom board
>>>> compatible format") from 2015 was a consensus during discussion about
>>>> upstreaming qcom,msm-id and qcom,board-id fields.  There are however still
>>>> problems with that consensus:
>>>> 1. It was reached 7 years ago but it turned out its implementation did
>>>>     not reach all possible products.
>>>>
>>>> 2. Initially additional tool (dtbTool) was needed for parsing these
>>>>     fields to create a QCDT image consisting of multiple DTBs, later the
>>>>     bootloaders were improved and they use these qcom,msm-id and
>>>>     qcom,board-id properties directly.
>>>
>>> I might be mistaken here. I think it was expected that dtbTool would use
>>> board compat strings to generate qcom,msm-id and qcom,board-id
>>> properties. It's not that the bootloaders were improved.
>>
>> Don't ask me, I am new to this.
>>
>> https://lore.kernel.org/all/02ab0276-b078-fe66-8596-fcec4378722b@somainline.org/
> 
> 
> 
> 
>>
>>>
>>>>
>>>> 3. Extracting relevant information from the board compatible requires
>>>>     this additional tool (dtbTool), which makes the build process more
>>>>     complicated and not easily reproducible (DTBs are modified after the
>>>>     kernel build).
>>>>
>>>> 4. Some versions of Qualcomm bootloaders expect these properties even
>>>>     when booting with a single DTB.  The community is stuck with these
>>>>     bootloaders thus they require properties in the DTBs.
>>>>
>>>> Since several upstreamed Qualcomm SoC-based boards require these
>>>> properties to properly boot and the properties are reportedly used by
>>>> bootloaders, document them.
>>>>
>>>> Link: https://lore.kernel.org/r/a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org/
>>>> Co-developed-by: Kumar Gala <galak@codeaurora.org>
>>>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>   .../devicetree/bindings/arm/qcom.yaml         | 123 ++++++++++++++++++
>>>>   include/dt-bindings/arm/qcom,ids.h            |  30 +++++
>>>>   2 files changed, 153 insertions(+)
>>>>   create mode 100644 include/dt-bindings/arm/qcom,ids.h
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> index 6c38c1387afd..05b98cde4653 100644
>>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> @@ -403,6 +403,129 @@ properties:
>>>>                 - qcom,sm8450-qrd
>>>>             - const: qcom,sm8450
>>>>
>>>> +  # Board compatibles go above
>>>> +
>>>> +  qcom,msm-id:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>>>> +    minItems: 1
>>>> +    maxItems: 8
>>>> +    items:
>>>> +      items:
>>>> +        - description: |
>>>> +            MSM chipset ID - an exact match value consisting of three bitfields::
>>>
>>> two bitfields
>>
>> Right, thanks.
>>
>>>
>>>> +             - bits 0-15  - The unique MSM chipset ID
>>>> +             - bits 16-31 - Reserved; should be 0
>>>> +        - description: |
>>>> +            Hardware revision ID - a chipset specific 32-bit ID representing
>>>> +            the version of the chipset.  It is best a match value - the
>>>> +            bootloader will look for the closest possible match.
>>>> +    deprecated: true
>>>> +    description:
>>>> +      The MSM chipset and hardware revision use by Qualcomm bootloaders.  It
>>>> +      can optionally be an array of these to indicate multiple hardware that
>>>> +      use the same device tree.  It is expected that the bootloader will use
>>>> +      this information at boot-up to decide which device tree to use when given
>>>> +      multiple device trees, some of which may not be compatible with the
>>>> +      actual hardware.  It is the bootloader's responsibility to pass the
>>>> +      correct device tree to the kernel.
>>>> +      The property is deprecated - it is not expected on newer boards
>>>> +      (starting with SM8350).
>>>
>>> Could you please elaborate this?
>>
>> Second paragraph:
>> https://lore.kernel.org/all/20220522195138.35943-1-konrad.dybcio@somainline.org/
> 
> I think this is something peculiar to Sony. Public lahaina (sm8350)
> dts files contain both these properties:
> 
> https://github.com/MiCode/kernel_devicetree/blob/zeus-s-oss/qcom/lahaina-hdk.dts
> https://github.com/MiCode/kernel_devicetree/blob/zeus-s-oss/qcom/lahaina-v2.1.dtsi
> 
>>
>> Plus consensus with Rob:
>> https://lore.kernel.org/all/CAL_JsqKL-mtAQ8Q9H4vLGM8izVVzDPbUAVWSdS8AmGjN6X6kcA@mail.gmail.com/
> 
> I'm not sure here. But sm8350 and sm8450 dtsi files use these
> properties. I've linked lahaina files above.
> The waiptio dtsi (sm8450) are present at the same URL.

If you did not like where the consensus is going during the discussion
last week, I would expect to join the discussion. Not to comment after I
implement it.

> 
>>
>>> If the AOSP team were to add e.g.
>>> SM8350-HDK to their single RB3+RB5 images, they would still need the
>>> qcom,board-id/qcom,msm-id properties to let the bootloader choose proper
>>> DTB.
>>
>> If you have any email addresses in mind, please Cc them to invite in
>> discussions. Otherwise I am afraid it won't be allowed. The feedback I
>> got before was that SM8350 and newer do not require this property. Feel
>> free to propose other way to solve comments (see "consensus with Rob"
>> above).
> 
> Amit is in CC list. In the past he used these properties to allow
> single-image booting of RB3 and RB5.
> In fact I might prefer adding more of these properties to the dts
> files, where it makes sense, to allow adding more dt files to the
> images we create.
> I'd really like to be able to boot a single image on all my boards
> (rb3, rb5, db410c, db820, ifc6560, etc).

You have several options here. Use the board-compatible-encoded-scheme,
which was merged like 6 years ago or something. Bootloader could parse
it, dtbTool as well. Add a generic property, like Rob wanted (and
probably fix bootloader). Or find any other way to satisfy Rob's
comments. These properties were not accepted 6 years ago and the board
compatible approach was merged instead. If 6 years is not enough to
change the bootloaders, nothing will happen here ever, so we need to
make some statement.


Best regards,
Krzysztof

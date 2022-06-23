Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B9D5576DD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiFWJmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiFWJmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:42:40 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0707A49917
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:42:39 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g25so39791203ejh.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xyKsHf35jPc8YVsck6ueew5VoRnlUL9zoS2z12Liz/8=;
        b=NBNe5LDexk9OpBZQ/NTq5PWJ+ojiyO3zUmYQi1uwO0yLdnXaNXpvGf9V1YEREj8SoQ
         NMCq6dBpaFfGA9LlsMgUwyCdE1ReEuDwyEwwX9jluWnPiK/NcD3ISxaF1ZPJ8mauRLYg
         Uulf2DwiUxlhPiwMySxnyydZ+9kTCih/7sglmXPs5IM6wg7fj+HUKIn4ZeQfA7R9YGst
         Q6ofqUqy7eG+XQ/UZisrMl4Zj96x1qhuHCE2rb4pU5LCzn4fNQf1OTR5a+UpZrKhqvyO
         raEO0wEl4LhFpuzHCkrPLmwV5Tn7XOO+HxAuvsbq+aOEYa1Y0NpuYif8Ie68F4HnJ/Va
         i3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xyKsHf35jPc8YVsck6ueew5VoRnlUL9zoS2z12Liz/8=;
        b=nwq5hIxVAcSdfo/wwJ1/X+qa1c2csUSSxuts6KCArHP7/w+BBjBYWXpia7UwPg2llD
         8e8zdiR4PJWiPVEMM5UMbXA6R2V1E6Icte91OKI/CSPTYivomD9l9C4sbZGCptbzE5Sn
         Tu73J6JswuPJnyfcI+5OgmIJkQSlbgL9Kfqawzm60B1mu00b/dPiaP1w/As208EcEnVn
         cwZa69aUFZJvaXQQZeBBuvbsrkGXd92tBXhECYudMhtewv9W4DwsU3bb7IaydNI2dCPW
         ywD6OA6kmT9z/CEThYvXVbY8Q7+EApTrM3vdRtPoIgHPj5cVMi6+gJCnUQod4Mlad69i
         4cww==
X-Gm-Message-State: AJIora8PGBm7zZcE3V96Uh+IxZAmaGjsgW/HuF5kSgoX1yQihFaoEVvJ
        dk42sgWPjUJ8SsD0VfXmi1gLEA==
X-Google-Smtp-Source: AGRyM1tzA92PdAeMyMzX0kya8FT14/pyP2fWwXS1iCh5k1iMXETkpTLPfwxtpkwzjfOgSa6fM4r7Vw==
X-Received: by 2002:a17:907:6d0d:b0:711:c940:7f1c with SMTP id sa13-20020a1709076d0d00b00711c9407f1cmr7338092ejc.399.1655977357508;
        Thu, 23 Jun 2022 02:42:37 -0700 (PDT)
Received: from [192.168.0.227] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l2-20020a056402124200b004357738e04esm10848659edw.21.2022.06.23.02.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 02:42:37 -0700 (PDT)
Message-ID: <2875e9e7-8fb3-e5f6-6221-6aaffb7813c4@linaro.org>
Date:   Thu, 23 Jun 2022 11:42:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: qcom: document qcom,msm-id and
 qcom,board-id
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kumar Gala <galak@codeaurora.org>
References: <20220622114856.6243-1-krzysztof.kozlowski@linaro.org>
 <20220622114856.6243-2-krzysztof.kozlowski@linaro.org>
 <93fd2970-5d07-f86d-b3a5-a4ebd8a2fa61@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <93fd2970-5d07-f86d-b3a5-a4ebd8a2fa61@somainline.org>
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

On 22/06/2022 13:56, Konrad Dybcio wrote:
> 
> 
> On 22.06.2022 13:48, Krzysztof Kozlowski wrote:
>> The top level qcom,msm-id and qcom,board-id properties are utilized by
>> bootloaders on Qualcomm MSM platforms to determine which device tree
>> should be used and passed to the kernel.
>>
>> The commit b32e592d3c28 ("devicetree: bindings: Document qcom board
>> compatible format") from 2015 was a consensus during discussion about
>> upstreaming qcom,msm-id and qcom,board-id fields.  There are however still
>> problems with that consensus:
>> 1. It was reached 7 years ago but it turned out its implementation did
>>    not reach all possible products.
>>
>> 2. Initially additional tool (dtbTool) was needed for parsing these
>>    fields to create a QCDT image consisting of multiple DTBs, later the
>>    bootloaders were improved and they use these qcom,msm-id and
>>    qcom,board-id properties directly.
>>
>> 3. Extracting relevant information from the board compatible requires
>>    this additional tool (dtbTool), which makes the build process more
>>    complicated and not easily reproducible (DTBs are modified after the
>>    kernel build).
>>
>> 4. Some versions of Qualcomm bootloaders expect these properties even
>>    when booting with a single DTB.  The community is stuck with these
>>    bootloaders thus they require properties in the DTBs.
>>
>> Since several upstreamed Qualcomm SoC-based boards require these
>> properties to properly boot and the properties are reportedly used by
>> bootloaders, document them.
>>
>> Link: https://lore.kernel.org/r/a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org/
>> Co-developed-by: Kumar Gala <galak@codeaurora.org>
>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>  .../devicetree/bindings/arm/qcom.yaml         | 121 ++++++++++++++++++
>>  include/dt-bindings/arm/qcom,ids.h            |  30 +++++
>>  2 files changed, 151 insertions(+)
>>  create mode 100644 include/dt-bindings/arm/qcom,ids.h
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 6c38c1387afd..431e3ff31d75 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -403,6 +403,127 @@ properties:
>>                - qcom,sm8450-qrd
>>            - const: qcom,sm8450
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
>> +            MSM chipset ID - an exact match value consisting of two bitfields::
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
>> +      The property is deprecated.
>> +
>> +  qcom,board-id:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>> +    minItems: 1
>> +    maxItems: 8
>> +    items:
>> +      oneOf:
>> +        - maxItems: 2
>> +          items:
>> +            - description: |
>> +                Board ID consisting of three bitfields::
>> +                  - bits 31-24 - Unused
>> +                  - bits 23-16 - Platform Version Major
>> +                  - bits 15-8  - Platform Version Minor
>> +                  - bits 7-0   - Platform Type
>> +                Platform Type field is an exact match value.  The
>> +                Platform Major/Minor field is a best match.  The bootloader will
>> +                look for the closest possible match.
>> +            - description: |
>> +                Subtype ID unique to a Platform Type/Chipset ID.  For a given
>> +                Platform Type, there will typically only be a single board and the
>> +                subtype_id will be 0.  However in some cases board variants may
>> +                need to be distinguished by different subtype_id values.
>> +        # OnePlus uses a variant of board-id with four elements:
>> +        - minItems: 4
>> +          items:
>> +            - const: 8
>> +            - const: 0
>> +            - description: OnePlus board ID
>> +            - description: OnePlus subtype ID
>> +    deprecated: true
>> +    description:
>> +      The board type and revision information.  It can optionally be an array
>> +      of these to indicate multiple boards that use the same device tree.  It
>> +      is expected that the bootloader will use this information at boot-up to
>> +      decide which device tree to use when given multiple device trees, some of
>> +      which may not be compatible with the actual hardware.  It is the
>> +      bootloader's responsibility to pass the correct device tree to the
>> +      kernel
>> +      The property is deprecated.
>> +
>> +allOf:
>> +  # Explicit allow-list for older SoCs. The legacy properties are not allowed
>> +  # on newer SoCs.
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,apq8026
>> +              - qcom,apq8094
>> +              - qcom,apq8096
>> +              - qcom,msm8992
>> +              - qcom,msm8994
>> +              - qcom,msm8996
>> +              - qcom,msm8998
>> +              - qcom,sdm630
>> +              - qcom,sdm632
>> +              - qcom,sdm845
>> +              - qcom,sdx55
>> +              - qcom,sdx65
>> +              - qcom,sm6125
>> +              - qcom,sm6350
>> +              - qcom,sm7225
>> +              - qcom,sm8150
>> +              - qcom,sm8250
>> +    then:
>> +      properties:
>> +        qcom,board-id: true
>> +        qcom,msm-id: true
>> +    else:
>> +      properties:
>> +        qcom,board-id: false
>> +        qcom,msm-id: false
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - oneplus,cheeseburger
>> +              - oneplus,dumpling
>> +              - oneplus,enchilada
>> +              - oneplus,fajita
>> +    then:
>> +      properties:
>> +        qcom,board-id:
>> +          items:
>> +            minItems: 4
>> +    else:
>> +      properties:
>> +        qcom,board-id:
>> +          items:
>> +            maxItems: 2
>> +
>>  additionalProperties: true
>>  
>>  ...
>> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
>> new file mode 100644
>> index 000000000000..df4a07b898cc
>> --- /dev/null
>> +++ b/include/dt-bindings/arm/qcom,ids.h
>> @@ -0,0 +1,30 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2022 Linaro Ltd
>> + * Author: Krzysztof Kozlowski <krzk@kernel.org> based on previous work of Kumar Gala.
>> + */
>> +#ifndef _DT_BINDINGS_ARM_QCOM_IDS_H
>> +#define _DT_BINDINGS_ARM_QCOM_IDS_H
>> +
>> +/* qcom,msm-id */
>> +#define QCOM_ID_APQ8026				199
>> +#define QCOM_ID_MSM8916				206
>> +#define QCOM_ID_MSM8994				207
>> +#define QCOM_ID_MSM8996				246
>> +#define QCOM_ID_APQ8016				247
>> +#define QCOM_ID_MSM8216				248
>> +#define QCOM_ID_MSM8116				249
>> +#define QCOM_ID_MSM8616				250
>> +#define QCOM_ID_MSM8998				292
>> +#define QCOM_ID_SDM845				321
> These are the same ones used in the qcom socid driver. Perhaps they can be exported from there?
> 

I can actually use the bindings in the socid driver. Less code.

Best regards,
Krzysztof

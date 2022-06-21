Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C74553A99
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353603AbiFUTc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353792AbiFUTcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:32:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C0CBBB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:32:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id g25so29575408ejh.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4RZgB2CWdCJhDsL+6cC07YXPGYNGWxRB8UnYBevDamY=;
        b=qNVKYsJxQ1kIgsRq4i1Tu7kXbRw7FCSTheTNYcxVqCzBIPf2/xb0DlOJxJiimCbHvq
         A/5jHijVz/08SF8dvZDojQSfLPghkhAdpm3YwbIsq7tcywzHjf7srkFb9OzeD3OzqafJ
         DDlHKrZapRfHyGPBA4QkIOloVcJW0f25YlxkgFXi2/J58GNfC/I6MHaC77hfS0R1chk+
         B2nKsZQ/ytmp92ZT04eyy8i1v0+JbQHHI5Ghv1u7lNujV4sf3oHOtMkpn6PiFUs/jyZx
         WNrU4jsyExB7RDlURvoFplFiJkiY0dPMEFBjdGqjjkRLm11E0JKcyTV3LswNMyZznYlP
         2ByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4RZgB2CWdCJhDsL+6cC07YXPGYNGWxRB8UnYBevDamY=;
        b=OJ9TXLsL74sySjibpbiFDZp9WP7K3p85euOJa2OKT9RcvhVi1Et+1qFMl9BKn1gzDF
         vZa2i/VXoztA2/UNSJKLrUmNkkQnArJr4xJdmQlngl0aBnDdABH/2oPeV/eQai8VgK74
         UplpHv0MC+nrOL2lVIwMUAAsQo+5Twc2g9Xka8MCVytk+LpTwt9niCGL75ckKo6TAWVo
         pndmoPehNYxYS7Of1LWuFYmU+cL0GYRszwVq7uqg9iw15D3vFuPG8Fpt3SXJYhkLV4MV
         gaHq36OBFWlamebEXTKdPhiba97vzJ7XgzcOHW73MGnqZrcvoJd701NRw6MZeprT1E1z
         uOBg==
X-Gm-Message-State: AJIora+MeNowoiiw/UUnGQwZDXRLE1rpcHnKj3U0lhkDMPlOoSbCecrt
        aXwlo7WvkuZAzuk8YYL53ANvCg==
X-Google-Smtp-Source: AGRyM1vnPUkbuWpte2jcBT7DvJQzsFknDR5UZnSlZmLG3WYsVeT+PN8iyTqjwuS6T13nvwQPq9tUGg==
X-Received: by 2002:a17:907:169e:b0:722:dcb0:ba0 with SMTP id hc30-20020a170907169e00b00722dcb00ba0mr6566226ejc.514.1655839971973;
        Tue, 21 Jun 2022 12:32:51 -0700 (PDT)
Received: from [192.168.0.223] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ek6-20020a056402370600b0042bdb6a3602sm12778635edb.69.2022.06.21.12.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 12:32:51 -0700 (PDT)
Message-ID: <7ef854a5-0e56-c71e-447a-f52cdcf51ef0@linaro.org>
Date:   Tue, 21 Jun 2022 21:32:49 +0200
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
 <609d1f0f-daca-4fde-3315-5d8e171ca5c4@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <609d1f0f-daca-4fde-3315-5d8e171ca5c4@linaro.org>
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

On 21/06/2022 21:26, Dmitry Baryshkov wrote:
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
> 
> I might be mistaken here. I think it was expected that dtbTool would use 
> board compat strings to generate qcom,msm-id and qcom,board-id 
> properties. It's not that the bootloaders were improved.

Don't ask me, I am new to this.

https://lore.kernel.org/all/02ab0276-b078-fe66-8596-fcec4378722b@somainline.org/

> 
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
> 
> two bitfields

Right, thanks.

> 
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
> Could you please elaborate this? 

Second paragraph:
https://lore.kernel.org/all/20220522195138.35943-1-konrad.dybcio@somainline.org/

Plus consensus with Rob:
https://lore.kernel.org/all/CAL_JsqKL-mtAQ8Q9H4vLGM8izVVzDPbUAVWSdS8AmGjN6X6kcA@mail.gmail.com/

> If the AOSP team were to add e.g. 
> SM8350-HDK to their single RB3+RB5 images, they would still need the 
> qcom,board-id/qcom,msm-id properties to let the bootloader choose proper 
> DTB.

If you have any email addresses in mind, please Cc them to invite in
discussions. Otherwise I am afraid it won't be allowed. The feedback I
got before was that SM8350 and newer do not require this property. Feel
free to propose other way to solve comments (see "consensus with Rob"
above).

> 
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
>> +      The property is deprecated - it is not expected on newer boards
>> +      (starting with SM8350).
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
>>   additionalProperties: true
>>   
>>   ...
>> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
>> new file mode 100644
>> index 000000000000..eaf86c18650f
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
>> +#define QCOM_ID_MSM8996_3_0			246
> 
> 2_0 too.
> And then (according to 3.18):
> 8996-pro 305
> 8996-pro-auto 315
> 8996-auto 310

Sure, I can add these.

> 
>> +#define QCOM_ID_APQ8016				247
>> +#define QCOM_ID_MSM8216				248
>> +#define QCOM_ID_MSM8116				249
>> +#define QCOM_ID_MSM8616				250
>> +#define QCOM_ID_MSM8998				292
>> +#define QCOM_ID_SDM845				321
> 
> sdm845-v2.1-rb3.dts:	qcom,msm-id = <341 0x20001>;
> But this might be a typo

Yeah, that's an interesting one. I did not fill the list to all possible
options, rather to some subset of more reasonable sources.

> 
>> +
>> +/* qcom,board-id */
>> +#define QCOM_BOARD_ID(a, major, minor) \
>> +	(((major & 0xff) << 16) | ((minor & 0xff) << 8) | QCOM_BOARD_ID_##a)
>> +
>> +#define QCOM_BOARD_ID_MTP			8
>> +#define QCOM_BOARD_ID_DRAGONBOARD		10
>> +#define QCOM_BOARD_ID_SBC			24
>> +
>> +#endif /* _DT_BINDINGS_ARM_QCOM_IDS_H */
> 
> 


Best regards,
Krzysztof

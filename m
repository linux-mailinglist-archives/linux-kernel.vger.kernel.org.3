Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7AC5548BE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357387AbiFVL4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbiFVL4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:56:09 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3853466A;
        Wed, 22 Jun 2022 04:56:07 -0700 (PDT)
Received: from [192.168.1.101] (abxi223.neoplus.adsl.tpnet.pl [83.9.2.223])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 8211F20634;
        Wed, 22 Jun 2022 13:56:05 +0200 (CEST)
Message-ID: <93fd2970-5d07-f86d-b3a5-a4ebd8a2fa61@somainline.org>
Date:   Wed, 22 Jun 2022 13:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: qcom: document qcom,msm-id and
 qcom,board-id
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220622114856.6243-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.06.2022 13:48, Krzysztof Kozlowski wrote:
> The top level qcom,msm-id and qcom,board-id properties are utilized by
> bootloaders on Qualcomm MSM platforms to determine which device tree
> should be used and passed to the kernel.
> 
> The commit b32e592d3c28 ("devicetree: bindings: Document qcom board
> compatible format") from 2015 was a consensus during discussion about
> upstreaming qcom,msm-id and qcom,board-id fields.  There are however still
> problems with that consensus:
> 1. It was reached 7 years ago but it turned out its implementation did
>    not reach all possible products.
> 
> 2. Initially additional tool (dtbTool) was needed for parsing these
>    fields to create a QCDT image consisting of multiple DTBs, later the
>    bootloaders were improved and they use these qcom,msm-id and
>    qcom,board-id properties directly.
> 
> 3. Extracting relevant information from the board compatible requires
>    this additional tool (dtbTool), which makes the build process more
>    complicated and not easily reproducible (DTBs are modified after the
>    kernel build).
> 
> 4. Some versions of Qualcomm bootloaders expect these properties even
>    when booting with a single DTB.  The community is stuck with these
>    bootloaders thus they require properties in the DTBs.
> 
> Since several upstreamed Qualcomm SoC-based boards require these
> properties to properly boot and the properties are reportedly used by
> bootloaders, document them.
> 
> Link: https://lore.kernel.org/r/a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org/
> Co-developed-by: Kumar Gala <galak@codeaurora.org>
> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/arm/qcom.yaml         | 121 ++++++++++++++++++
>  include/dt-bindings/arm/qcom,ids.h            |  30 +++++
>  2 files changed, 151 insertions(+)
>  create mode 100644 include/dt-bindings/arm/qcom,ids.h
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 6c38c1387afd..431e3ff31d75 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -403,6 +403,127 @@ properties:
>                - qcom,sm8450-qrd
>            - const: qcom,sm8450
>  
> +  # Board compatibles go above
> +
> +  qcom,msm-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    minItems: 1
> +    maxItems: 8
> +    items:
> +      items:
> +        - description: |
> +            MSM chipset ID - an exact match value consisting of two bitfields::
> +             - bits 0-15  - The unique MSM chipset ID
> +             - bits 16-31 - Reserved; should be 0
> +        - description: |
> +            Hardware revision ID - a chipset specific 32-bit ID representing
> +            the version of the chipset.  It is best a match value - the
> +            bootloader will look for the closest possible match.
> +    deprecated: true
> +    description:
> +      The MSM chipset and hardware revision use by Qualcomm bootloaders.  It
> +      can optionally be an array of these to indicate multiple hardware that
> +      use the same device tree.  It is expected that the bootloader will use
> +      this information at boot-up to decide which device tree to use when given
> +      multiple device trees, some of which may not be compatible with the
> +      actual hardware.  It is the bootloader's responsibility to pass the
> +      correct device tree to the kernel.
> +      The property is deprecated.
> +
> +  qcom,board-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    minItems: 1
> +    maxItems: 8
> +    items:
> +      oneOf:
> +        - maxItems: 2
> +          items:
> +            - description: |
> +                Board ID consisting of three bitfields::
> +                  - bits 31-24 - Unused
> +                  - bits 23-16 - Platform Version Major
> +                  - bits 15-8  - Platform Version Minor
> +                  - bits 7-0   - Platform Type
> +                Platform Type field is an exact match value.  The
> +                Platform Major/Minor field is a best match.  The bootloader will
> +                look for the closest possible match.
> +            - description: |
> +                Subtype ID unique to a Platform Type/Chipset ID.  For a given
> +                Platform Type, there will typically only be a single board and the
> +                subtype_id will be 0.  However in some cases board variants may
> +                need to be distinguished by different subtype_id values.
> +        # OnePlus uses a variant of board-id with four elements:
> +        - minItems: 4
> +          items:
> +            - const: 8
> +            - const: 0
> +            - description: OnePlus board ID
> +            - description: OnePlus subtype ID
> +    deprecated: true
> +    description:
> +      The board type and revision information.  It can optionally be an array
> +      of these to indicate multiple boards that use the same device tree.  It
> +      is expected that the bootloader will use this information at boot-up to
> +      decide which device tree to use when given multiple device trees, some of
> +      which may not be compatible with the actual hardware.  It is the
> +      bootloader's responsibility to pass the correct device tree to the
> +      kernel
> +      The property is deprecated.
> +
> +allOf:
> +  # Explicit allow-list for older SoCs. The legacy properties are not allowed
> +  # on newer SoCs.
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,apq8026
> +              - qcom,apq8094
> +              - qcom,apq8096
> +              - qcom,msm8992
> +              - qcom,msm8994
> +              - qcom,msm8996
> +              - qcom,msm8998
> +              - qcom,sdm630
> +              - qcom,sdm632
> +              - qcom,sdm845
> +              - qcom,sdx55
> +              - qcom,sdx65
> +              - qcom,sm6125
> +              - qcom,sm6350
> +              - qcom,sm7225
> +              - qcom,sm8150
> +              - qcom,sm8250
> +    then:
> +      properties:
> +        qcom,board-id: true
> +        qcom,msm-id: true
> +    else:
> +      properties:
> +        qcom,board-id: false
> +        qcom,msm-id: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - oneplus,cheeseburger
> +              - oneplus,dumpling
> +              - oneplus,enchilada
> +              - oneplus,fajita
> +    then:
> +      properties:
> +        qcom,board-id:
> +          items:
> +            minItems: 4
> +    else:
> +      properties:
> +        qcom,board-id:
> +          items:
> +            maxItems: 2
> +
>  additionalProperties: true
>  
>  ...
> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
> new file mode 100644
> index 000000000000..df4a07b898cc
> --- /dev/null
> +++ b/include/dt-bindings/arm/qcom,ids.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022 Linaro Ltd
> + * Author: Krzysztof Kozlowski <krzk@kernel.org> based on previous work of Kumar Gala.
> + */
> +#ifndef _DT_BINDINGS_ARM_QCOM_IDS_H
> +#define _DT_BINDINGS_ARM_QCOM_IDS_H
> +
> +/* qcom,msm-id */
> +#define QCOM_ID_APQ8026				199
> +#define QCOM_ID_MSM8916				206
> +#define QCOM_ID_MSM8994				207
> +#define QCOM_ID_MSM8996				246
> +#define QCOM_ID_APQ8016				247
> +#define QCOM_ID_MSM8216				248
> +#define QCOM_ID_MSM8116				249
> +#define QCOM_ID_MSM8616				250
> +#define QCOM_ID_MSM8998				292
> +#define QCOM_ID_SDM845				321
These are the same ones used in the qcom socid driver. Perhaps they can be exported from there?

Konrad
> +
> +/* qcom,board-id */
> +#define QCOM_BOARD_ID(a, major, minor) \
> +	(((major & 0xff) << 16) | ((minor & 0xff) << 8) | QCOM_BOARD_ID_##a)
> +
> +#define QCOM_BOARD_ID_MTP			8
> +#define QCOM_BOARD_ID_DRAGONBOARD		10
> +#define QCOM_BOARD_ID_SBC			24
> +
> +#endif /* _DT_BINDINGS_ARM_QCOM_IDS_H */

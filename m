Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C889518920
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbiECP4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbiECP4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:56:34 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADD63B283;
        Tue,  3 May 2022 08:53:01 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id g11-20020a9d648b000000b00605e4278793so10945295otl.7;
        Tue, 03 May 2022 08:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O/VorzOR56WTDjehRhSMK8LAzwC+xTJ10pdPBqWQa/w=;
        b=JZyHccr1b8zVoj8k8ZWNVOsTF+2phSSt2BweSTj0RWC7GPaVX7PtrzE7Py9xbuPJjN
         OncER3USBLVb9KFtXFk5vDVqx8Gs5VPjdCHkyCRCSMu1/1B4iaXLDsL7NVUR/TwkyD+g
         lDF6KMV4NDZQLQHdIg3xfCtKqsKgMadaAgVXTwY1clegkrFs5CD0gygp01NDTS1AWSYs
         UQir/yoRYHvW7UKR9CH1tCHbEekLrPrf9pkH0CWEwCvtEUQHmDEqqbkgN9C3a9UVltnL
         VOBUpt8BZVm9LKmm+iHdncLQ+/rejpzWj++vmmTQa9h+Bvyu0M27Uwbs4Iad14Y7hUAl
         QXrw==
X-Gm-Message-State: AOAM532GPNyU4qC59fMDNGZ9kahhhHd1tJ9PECKy+a+023lQM0FkOXFk
        jdDtVO6j4lsX9X8UofaXxQ==
X-Google-Smtp-Source: ABdhPJw1G98NTO6a1c3CpiXHWrP6FSOoG8WJv5RMlXbGCgu1vAO2Tm+NHbG7kF7E7UVgPTuww9cgbQ==
X-Received: by 2002:a9d:7e87:0:b0:605:fa3c:95ba with SMTP id m7-20020a9d7e87000000b00605fa3c95bamr6021382otp.66.1651593180862;
        Tue, 03 May 2022 08:53:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g14-20020a05683030ae00b0060603221239sm4038007ots.9.2022.05.03.08.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 08:53:00 -0700 (PDT)
Received: (nullmailer pid 3768349 invoked by uid 1000);
        Tue, 03 May 2022 15:52:59 -0000
Date:   Tue, 3 May 2022 10:52:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, amitk@kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: thermal: tsens: Add ipq8074
 compatible
Message-ID: <YnFP2x113LdM5p3Q@robh.at.kernel.org>
References: <20220501182200.47328-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501182200.47328-1-robimarko@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 08:21:56PM +0200, Robert Marko wrote:
> Qualcomm IPQ8074 has tsens v2.3.0 block, though unlike existing v2 IP it
> only uses one IRQ, so tsens v2 compatible cannot be used as the fallback.
> 
> We also have to make sure that correct interrupts are set according to
> compatibles, so populate interrupt information per compatibles.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v2:
> * No need for a list in compatible check
> * Specify minItems and maxItems for interrupt and interrupt-names
> ---
>  .../bindings/thermal/qcom-tsens.yaml          | 74 +++++++++++++++++--
>  1 file changed, 67 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index b6406bcc683f..e9b85c99bb60 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -56,6 +56,10 @@ properties:
>                - qcom,sm8350-tsens
>            - const: qcom,tsens-v2
>  
> +      - description: v2 of TSENS with combined interrupt
> +        enum:
> +          - qcom,ipq8074-tsens
> +
>    reg:
>      items:
>        - description: TM registers
> @@ -63,15 +67,11 @@ properties:
>  
>    interrupts:
>      minItems: 1
> -    items:
> -      - description: Combined interrupt if upper or lower threshold crossed
> -      - description: Interrupt if critical threshold crossed
> +    maxItems: 2
>  
>    interrupt-names:
>      minItems: 1
> -    items:
> -      - const: uplow
> -      - const: critical
> +    maxItems: 2
>  
>    nvmem-cells:
>      minItems: 1
> @@ -125,21 +125,66 @@ allOf:
>        properties:
>          interrupts:
>            maxItems: 1

You can drop 'maxItems' as it is implied by 'items' length.

> +          items:
> +            - description: Combined interrupt if upper or lower threshold crossed
>          interrupt-names:
>            maxItems: 1

ditto

> +          items:
> +            - const: uplow
>  
> -    else:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,msm8953-tsens
> +              - qcom,msm8996-tsens
> +              - qcom,msm8998-tsens
> +              - qcom,sc7180-tsens
> +              - qcom,sc7280-tsens
> +              - qcom,sc8180x-tsens
> +              - qcom,sdm630-tsens
> +              - qcom,sdm845-tsens
> +              - qcom,sm8150-tsens
> +              - qcom,sm8250-tsens
> +              - qcom,sm8350-tsens
> +              - qcom,tsens-v2
> +    then:
>        properties:
>          interrupts:
>            minItems: 2

Same for minItems.

> +          items:
> +            - description: Combined interrupt if upper or lower threshold crossed
> +            - description: Interrupt if critical threshold crossed
>          interrupt-names:
>            minItems: 2

ditto

> +          items:
> +            - const: uplow
> +            - const: critical
>  
>    - if:
>        properties:
>          compatible:
>            contains:
>              enum:
> +              - qcom,ipq8074-tsens
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 1

ditto

> +          items:
> +            - description: Combined interrupt if upper, lower or critical thresholds crossed
> +        interrupt-names:
> +          maxItems: 1

ditto

> +          items:
> +            - const: combined
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq8074-tsens
>                - qcom,tsens-v0_1
>                - qcom,tsens-v1
>                - qcom,tsens-v2
> @@ -222,4 +267,19 @@ examples:
>             #qcom,sensors = <13>;
>             #thermal-sensor-cells = <1>;
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    // Example 4 (for any IPQ8074 based SoC-s):
> +    tsens4: thermal-sensor@4a9000 {
> +           compatible = "qcom,ipq8074-tsens";
> +           reg = <0x4a9000 0x1000>,
> +                 <0x4a8000 0x1000>;
> +
> +           interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> +           interrupt-names = "combined";
> +
> +           #qcom,sensors = <16>;
> +           #thermal-sensor-cells = <1>;
> +    };
>  ...
> -- 
> 2.35.1
> 
> 

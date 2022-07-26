Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A9258110F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiGZKZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiGZKZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:25:08 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F072E9E9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:25:05 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y11so21827115lfs.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=x+nskSevu+BnV44CpZIDNQEifjnEzcirOFZu/6Dy2ww=;
        b=f7cF7eFX0+s6Ge80wf+LWz2MZcY6cVEabODf33OiVdmR3hiXwsFE2kBrycyvMAv3ml
         dr5S4BwlNUXJNsVhOTt1qqDRzR3/kyH9Ab23mD1hGr1nkMJvGfqGoIf9JtZ8r2Yf16kJ
         tO8c5vm5uk2DUShQgk1L9lI2DL2pS6vmycdihdtk3ZsgUkD40eJmwZvC6Gqql5S8fWXW
         BTeinqhzrMNQAsl8A2VrvUvmWUdAuwcistWRht0Dc3hawdcMlhcKpG98OVFf2ZI576vK
         B+xTg+Fo6eLd1oVpC6P/DQ/GG8NpNW7pMfv2nNnrco+GEoaK86MpZ6inM5bFG6ll0MPF
         vg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x+nskSevu+BnV44CpZIDNQEifjnEzcirOFZu/6Dy2ww=;
        b=0BuNxoS8rEnMLOq/EBZ0/8/k32wmHCfjFuGeuUEoYw05XBcBdq3mEPpbuFuhfKGiWJ
         6nq0akqlw9ZKHaGwBgZXgAr0oudhoZsttpZVGay4bCO5CM352iUV5Q/rej0MEIPqa4Az
         HtM3GuyJBL2vNQSe14JHEB3DPryCh9M/nSQK7UPQxMpzbs3J7vpNcQpuIuTFxi33mAXH
         RdIIunTd0JvRwFf9DbrG5osr7Tn43DZG6Q2sHOXZdTbHY7TnVsAbsO3Qd/PVPbE4CSe0
         r84be5QHcbOCQGQ9JBJVwXVvSK1xkRg8T60JJ4OUmbQIAhB+3LaMvbhWSdKPnR0PspgU
         o6Lw==
X-Gm-Message-State: AJIora//G12bfTlJmYTuSyQak+DsYu6Y7HzURulfZV1hvMkNbnrEk5u6
        BbJ3/BYPVR0EYiIbDyazPzlthw==
X-Google-Smtp-Source: AGRyM1sYAdgHN8tBKjKpSNdBNjl4YXX//x0wnnc1Dmy6k6JC6knN15yFRPQ3AvGS+PFPLiiSsfim2Q==
X-Received: by 2002:a05:6512:33c3:b0:48a:83a9:52e1 with SMTP id d3-20020a05651233c300b0048a83a952e1mr4730137lfg.344.1658831104304;
        Tue, 26 Jul 2022 03:25:04 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id b9-20020a056512070900b00489c8c6c055sm516654lfs.50.2022.07.26.03.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 03:25:03 -0700 (PDT)
Message-ID: <a47a33a5-aec7-2a52-f1e8-52c45307862e@linaro.org>
Date:   Tue, 26 Jul 2022 12:25:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220725191314.19456-2-quic_amelende@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2022 21:13, Anjelique Melendez wrote:
> From: David Collins <quic_collinsd@quicinc.com>
> 
> Update the description of "reg" property to add the PON_PBS base
> address along with PON_HLOS base address.  Also add "reg-names"
> property constraints.
> 
> Signed-off-by: David Collins <quic_collinsd@quicinc.com>
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 50 +++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> index 353f155d..d7b6b875 100644
> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> @@ -15,18 +15,27 @@ description: |
>  
>    This DT node has pwrkey and resin as sub nodes.
>  
> -allOf:
> -  - $ref: reboot-mode.yaml#
> -
>  properties:
>    compatible:
>      enum:
>        - qcom,pm8916-pon
>        - qcom,pms405-pon
>        - qcom,pm8998-pon
> +      - qcom,pmk8350-pon
>  
>    reg:
> -    maxItems: 1
> +    description: |
> +      Specifies the SPMI base address for the PON (power-on) peripheral.  For
> +      PMICs that have the PON peripheral (GEN3) split into PON_HLOS and PON_PBS
> +      (e.g. PMK8350), this can hold addresses of both PON_HLOS and PON_PBS
> +      peripherals.  In that case, the PON_PBS address needs to be specified to
> +      facilitate software debouncing on some PMIC.
> +    minItems: 1
> +    maxItems: 2
> +
> +  reg-names:
> +    minItems: 1
> +    maxItems: 2
>  
>    pwrkey:
>      type: object
> @@ -42,6 +51,39 @@ required:
>  
>  unevaluatedProperties: false
>  
> +allOf:
> +  - $ref: reboot-mode.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pm8916-pon
> +              - qcom,pms405-pon
> +              - qcom,pm8998-pon
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 1
> +        reg-names:
> +          items:
> +            - const: pon

All your previous patches were actually missing (in commit msg, in the
code) that piece of information which you add here. You now add
reg-names with "pon" for older devices. I assumed previous that it is
somehow needed, so I gave you the hints how it should be coded. But I
don't understand - why are you doing it?

This should be explained in commit msg. To me it is not needed at all...
unless you want to mark that first address space is entirely different
for other devices?

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,pmk8350-pon
> +    then:
> +      properties:
> +        reg:
> +          minItems: 1
> +          maxItems: 2
> +        reg-names:
> +          minItems: 1
> +          items:
> +            - const: hlos
> +            - const: pbs
> +
>  examples:
>    - |
>     #include <dt-bindings/interrupt-controller/irq.h>


Best regards,
Krzysztof

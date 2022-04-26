Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9621C50F24E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243780AbiDZH1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239900AbiDZH1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:27:10 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A5BADD6D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:24:02 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id n14so9615999lfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eXtqXcAbsPLbhUnLplLAUrfp7LOU/SjKEif65DdFddY=;
        b=RjT5NS3KcY2orNbvmBSpXy1jJ8Ow9Y+AEZGN5UeedbFepPo9eZYSsJBrlk+M5HbJgJ
         N9/gQJO/jn2vJt3H27RywyKgpVpMjjxP76plx+pwErzZgekg2SR3fJktjch6jQEAyYoE
         XnGIoDJ7jlYs1Su26aGwLO5ks+T+Alz8JBMY2PmQujoa1NedM7TLmMNxOdL5DQb755Eh
         Wu4waf+E4G1JenQAveLgZUHXprIGoPTTMiULWL020YzzUsewq3RMcVi8q9jwNe0X8Tf0
         nEELfrh4YxZUGX9MNR1JQv1Ps1h098fC7rfWAiCL/vvtTFKlkDKnCWDGCN9vRUDHRxNc
         9m8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eXtqXcAbsPLbhUnLplLAUrfp7LOU/SjKEif65DdFddY=;
        b=SdQ6fpT7U391jgoakzDSACfnsWylQPmYHmljmG0JS/isCZCbz2ZUeyvlEnjfRyOpTt
         hq867v0aqMekF+sV4gKTTZedpV0bj37NUrN2LUwZooOVu3oHm/tqfphBxKJ8n/agBAe9
         9STEewkcf033J/aOfLfJzjKv9ao7QrD0rltXyCtQO5cLDHZq5f+keJKdYbJlsupjI/8K
         vkacRKGSlB8Ac6j2X/nyQ7mSpFodbn82uFEsBnYkOFjm4eVSoo2bc60tZ9jpjVAQI0JQ
         SQCfHGLYtFI0Vanjt6DufL45XsM5OGNXL5k8FQlNSrHMg1oXo1NzyChxiTQk13vTJTtP
         UO1g==
X-Gm-Message-State: AOAM533d9UHJUjGlBZvbue2FReW8/HKW8LKAYFOlhDiyL82mdgG+Mofv
        jM6EQcPXfrYQw4GX7rSYUOgwzw==
X-Google-Smtp-Source: ABdhPJwsG0y9iB+agiH1tnKpqhvSRk36yyN2InhyHQ8i1YlREGRjoX7xFZzC3EusBEs84fst8AhOgA==
X-Received: by 2002:ac2:5e9c:0:b0:471:eba5:afe with SMTP id b28-20020ac25e9c000000b00471eba50afemr13348036lfq.477.1650957840955;
        Tue, 26 Apr 2022 00:24:00 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y15-20020a056512044f00b004721549b9c2sm176712lfk.219.2022.04.26.00.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 00:24:00 -0700 (PDT)
Message-ID: <d8e1b7b7-a37d-d177-71d6-78e89a7cfa80@linaro.org>
Date:   Tue, 26 Apr 2022 10:23:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] dt-bindings: clock: qcom,gcc-apq8064: Fix typo in
 compatible and split apq8084
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
References: <20220425204001.710238-1-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220425204001.710238-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 23:40, Krzysztof Kozlowski wrote:
> The qcom,gcc-apq8064.yaml was meant to describe only APQ8064 and APQ8084
> should have slightly different bindings (without Qualcomm thermal sensor
> device).
> 
> Fixes: a469bf89a009 ("dt-bindings: clock: simplify qcom,gcc-apq8064 Documentation")
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I think we can simply move it to the gcc-other.yaml. I'll send a patch.

> ---
>   .../bindings/clock/qcom,gcc-apq8064.yaml      |  4 +-
>   .../bindings/clock/qcom,gcc-apq8084.yaml      | 42 +++++++++++++++++++
>   2 files changed, 43 insertions(+), 3 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-apq8084.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> index 97936411b6b4..9fafcb080069 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> @@ -20,12 +20,10 @@ description: |
>     See also:
>     - dt-bindings/clock/qcom,gcc-msm8960.h
>     - dt-bindings/reset/qcom,gcc-msm8960.h
> -  - dt-bindings/clock/qcom,gcc-apq8084.h
> -  - dt-bindings/reset/qcom,gcc-apq8084.h
>   
>   properties:
>     compatible:
> -    const: qcom,gcc-apq8084
> +    const: qcom,gcc-apq8064
>   
>     nvmem-cells:
>       minItems: 1
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8084.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8084.yaml
> new file mode 100644
> index 000000000000..63d08e82b3d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8084.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,gcc-apq8084.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller Binding for APQ8084
> +
> +maintainers:
> +  - Stephen Boyd <sboyd@kernel.org>
> +  - Taniya Das <tdas@codeaurora.org>
> +
> +description: |
> +  Qualcomm global clock control module which supports the clocks, resets and
> +  power domains on APQ8064/APQ8084.
> +
> +  See also::
> +  - dt-bindings/clock/qcom,gcc-apq8084.h
> +  - dt-bindings/reset/qcom,gcc-apq8084.h
> +
> +allOf:
> +  - $ref: qcom,gcc.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,gcc-apq8084
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@fc400000 {
> +        compatible = "qcom,gcc-apq8084";
> +        reg = <0xfc400000 0x4000>;
> +        #clock-cells = <1>;
> +        #reset-cells = <1>;
> +        #power-domain-cells = <1>;
> +    };
> +...


-- 
With best wishes
Dmitry

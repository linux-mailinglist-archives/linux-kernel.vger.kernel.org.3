Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7DB4FACF2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 10:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbiDJIkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 04:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbiDJIkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 04:40:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2852CC94
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 01:38:03 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u15so6467790ejf.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 01:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gh/AAtf8cRdIoELrwepmpCDeMPbSdp9UytLl5DDKHr4=;
        b=x77uAlufM1epd1LMPe9Z/2F2riMaIPZRMerJ87AO+zQtngB7ZoBqlLFePS3p1rpT/x
         wxEByYkYLXXr9KJ213Y7HEVVxLJ2t8WN4e2+G9j2o5xKutWghtaoMr39E4GFqIi+FDXF
         CXytZ5L1aYOQSRw8KIgTLBiRj516kpVXl62p6NLhPG7xTs2Si5PiQLpXZXb79m2YK7IU
         Jk8ZXKC/KAJbCt6jeNhbDxJEtw+Y9I2EZ9/FUm1e7m55PueRHsYG5G+Aetsoywucp53d
         61+WqRWfpmygyk5kav5wDrWA18af463WGbAB0XdhmZDjj0teluS/13ASd5wY3s6yzrJf
         3iQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gh/AAtf8cRdIoELrwepmpCDeMPbSdp9UytLl5DDKHr4=;
        b=2/3y8BOHBRKsytDdTToeUY+9/fP3qpVytL61BvvHdL9OAJYG2ywbr5r4fJ8amG6AvD
         cs70x7r96KWNe9Zp6h0jPUtQjflXrSVTj97/SGy8sjhmWVQn+QJA5eZDqJcyUIA3qyHU
         cXw/x35hQwfGa96C0KTTd4r99d8ZRS1VPHTHq6IThNwryGLYitW87TOyTfYfI6RTFRFu
         oYAp5QeV6DlLXcz0YyKoMV8lSToG1Eeoe9FAVODCqQhpRJdD4/7uUySqZrz+5UDY2OUF
         eUElHmUABDQcOf4NyCo9gC3fr7G2R+OPVO/ktBzIU7I82AAG17vy3oF4B6wj5b9RLKwo
         LhRA==
X-Gm-Message-State: AOAM530a+7UwVU0I3lvFt1dfETT7wnFsN+ijZ32siyQm3y8RzlXTjqsx
        yLBNZJBzDU/qjLXalaNndxyglA==
X-Google-Smtp-Source: ABdhPJwWopm2EQV2ZJwh6NTf592QrsI18/yNtY37mQW+51gPPFLvkjJsgKAo0HfXO4jYgMRD1boAsA==
X-Received: by 2002:a17:906:d552:b0:6e8:4edc:f2ee with SMTP id cr18-20020a170906d55200b006e84edcf2eemr10035344ejc.572.1649579881603;
        Sun, 10 Apr 2022 01:38:01 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id s20-20020a056402015400b00418f9574a36sm13021400edu.73.2022.04.10.01.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 01:38:00 -0700 (PDT)
Message-ID: <4f20ad11-40c5-638e-7335-c68d2369373d@linaro.org>
Date:   Sun, 10 Apr 2022 10:37:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] dt-bindings: mfd: convert to yaml Qualcomm SPMI PMIC
Content-Language: en-US
To:     David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht,
        Caleb Connolly <caleb@connolly.tech>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220111220026.102838-1-david@ixit.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220111220026.102838-1-david@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2022 23:00, David Heidelberg wrote:
> Convert Qualcomm SPMI PMIC binding to yaml format.
> 
> Additional changes:
>  - filled many missing compatibles
> 
> Co-developed-by: Caleb Connolly <caleb@connolly.tech>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

Thank you for your patch. There is something to discuss/improve.

(...)

> +
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,pm660
> +          - qcom,pm660l
> +          - qcom,pm6150
> +          - qcom,pm6150l
> +          - qcom,pm6350
> +          - qcom,pm7325
> +          - qcom,pm8004
> +          - qcom,pm8005
> +          - qcom,pm8009
> +          - qcom,pm8019
> +          - qcom,pm8110
> +          - qcom,pm8150
> +          - qcom,pm8150b
> +          - qcom,pm8150l
> +          - qcom,pm8226
> +          - qcom,pm8350
> +          - qcom,pm8350b
> +          - qcom,pm8350c
> +          - qcom,pm8841
> +          - qcom,pm8909
> +          - qcom,pm8916
> +          - qcom,pm8941
> +          - qcom,pm8950
> +          - qcom,pm8994
> +          - qcom,pm8998
> +          - qcom,pma8084
> +          - qcom,pmd9635
> +          - qcom,pmi8950
> +          - qcom,pmi8962
> +          - qcom,pmi8994
> +          - qcom,pmi8998
> +          - qcom,pmk8350
> +          - qcom,pmm8155au
> +          - qcom,pmr735a
> +          - qcom,pmr735b
> +          - qcom,pms405
> +          - qcom,pmx55
> +          - qcom,smb2351
> +      - const: qcom,spmi-pmic
> +
> +  reg: true

maxItems

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +

Just one blank line.

> +patternProperties:
> +  '^(labibb|([a-z][a-z0-9]+-)?regulators)$':
> +    type: object
> +

This should be more specific, preferably by including schema for
regulators (or any other children if applicable).

> +    required:
> +      - compatible

unevaluatedProperties: false
> +
> +  '@[0-9a-f]+$':
> +    type: object
> +    description: >

You don't need '>'.

This also should be specified - what is expected to be here? Usually the
children are exactly known.

> +      Each child node of the PMIC represents a function of it.
> +
> +    properties:
> +      reg: true

maxItems

> +
> +      interrupts:
> +        description: >

No need for >

> +          Interrupts are specified as a 4-tuple. For more information see
> +          Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> +
> +    required:
> +      - compatible
> +
> +    additionalProperties: true

This will have to unevaluated or additional properties false, depending
whether you include other schema or not.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +


Best regards,
Krzysztof

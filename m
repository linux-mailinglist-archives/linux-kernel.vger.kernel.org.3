Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CF155B3EC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 22:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiFZUAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 16:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiFZUAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 16:00:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31160E1C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:00:23 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id cw10so14985123ejb.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=56YzwVQKdHGziCBUUIednU1Z8rEBgdNoppTuq6x0/M8=;
        b=NnwoGGTb7v+KSqJ5iDMFmofL3n9nM5O/+xjyqJ1YBYmQxbiEZ6Li1wJ1SL9/RwCMW5
         5CPkIKEP+HSlofaZ9XBU4e0al5O4FU19sS/XS7+j+afROckxahWfDAhw8OIkcmp07nvR
         oD/kXv1XlmWdg1MOrZdBWgh1u53lgeR6IkkG9jJR8+A1+pH37c7rxWs2odAD/J+vSHA9
         T5JcfaMFIKQ6AONnA5rzdDflDt1/o4K7UFqb0aGD59e/Q/UviFnjmZbTWAhz02E1KDo+
         iRzVmy+FaEn/NppE6okbwI4JSBAAozt9O2b/hqwDrfJpgwOhERwAZ+V50J//BTG24mG/
         nNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=56YzwVQKdHGziCBUUIednU1Z8rEBgdNoppTuq6x0/M8=;
        b=nH+03cASY8/nJhcTNbriFhahwxifz9hX1jDmLqC1xdW1iJsUxxYfg8ix6Rq7H9nnwX
         HE2j/r8Cv5FZryWb/qzLTaO5I3hd1jt5i1HOn0e4ATVOh17EfBV5onmuK/23aVyYApAa
         s5Nr7+guTuloL1WJWEqk4MwjWcYXdSwAmQng44Jsx7owPIzORbcHujLaM8LgwI0b+TXW
         bSHY36JL4/GNXKB/t3pkYzN1Yr2q1OqHTgfrIjxti0XAAOKj1DzqGQBgXaOff16J06Z6
         fHDB0+Zb2IM0HS2LfDjdxLNf0Nn3j35ZXd2iAQ9xARMVhTkXSKB4RubdgmHB7/Z+rEy8
         4kOw==
X-Gm-Message-State: AJIora+x2w/UYH5eZwRjtBbDnRG/KuuqOEw2yxxq/v0FCBrgDd2HzM4h
        akxHjyySeCUtaWpzRfXuflIxtg==
X-Google-Smtp-Source: AGRyM1smRDpHE9xz9/L06jkLVOqTAUdavGeWX6/lobROMiqKscv2iJGPLP10Se3MtGyQnK2ImDbuJw==
X-Received: by 2002:a17:907:6e9f:b0:711:d2cb:63d8 with SMTP id sh31-20020a1709076e9f00b00711d2cb63d8mr9794470ejc.232.1656273621773;
        Sun, 26 Jun 2022 13:00:21 -0700 (PDT)
Received: from [192.168.0.245] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i17-20020a1709061e5100b00704b196e59bsm4099635ejj.185.2022.06.26.13.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 13:00:21 -0700 (PDT)
Message-ID: <9dd87d64-5124-a75b-be8a-1b056da645ce@linaro.org>
Date:   Sun, 26 Jun 2022 22:00:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 3/3] dt-bindings: firmware: convert Qualcomm SCM
 binding to the yaml
Content-Language: en-US
To:     David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220626183247.142776-1-david@ixit.cz>
 <20220626183247.142776-3-david@ixit.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220626183247.142776-3-david@ixit.cz>
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

On 26/06/2022 20:32, David Heidelberg wrote:
> Convert Qualcomm SCM firmware binding to the yaml format.
> 
> This commit also:
>  - adds qcom,scm-mdm9607 into list which has only core clock
>  - adds qcom,scm-sm6125, qcom,scm-ipq6018
>  - #reset-cells, because the property is already used
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> --
> v4:
>  - added clocks minItems and maxItems
>  - removed quotes from $id and $schema
>  - adjusted description of TCSR HW block

Thank you for your patch. There is something to discuss/improve.

> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,scm-apq8064
> +          - qcom,scm-apq8084
> +          - qcom,scm-ipq4019
> +          - qcom,scm-ipq6018
> +          - qcom,scm-ipq806x
> +          - qcom,scm-ipq8074
> +          - qcom,scm-mdm9607
> +          - qcom,scm-msm8226
> +          - qcom,scm-msm8660
> +          - qcom,scm-msm8916
> +          - qcom,scm-msm8953
> +          - qcom,scm-msm8960
> +          - qcom,scm-msm8974
> +          - qcom,scm-msm8976
> +          - qcom,scm-msm8994
> +          - qcom,scm-msm8996
> +          - qcom,scm-msm8998
> +          - qcom,scm-sc7180
> +          - qcom,scm-sc7280
> +          - qcom,scm-sdm845
> +          - qcom,scm-sdx55
> +          - qcom,scm-sm6125
> +          - qcom,scm-sm6350
> +          - qcom,scm-sm8150
> +          - qcom,scm-sm8250
> +          - qcom,scm-sm8350
> +          - qcom,scm-sm8450
> +          - qcom,scm-qcs404
> +      - const: qcom,scm
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 3
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 3
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  qcom,dload-mode:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to TCSR hardware block
> +          - description: offset of the download mode control register
> +    description: TCSR hardware block
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,scm-apq8064
> +              - qcom,scm-mdm9607
> +              - qcom,scm-msm8660
> +              - qcom,scm-msm8960
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: core
> +
> +        clocks:
> +          maxItems: 1
> +
> +      required:
> +        - clocks
> +        - clock-names
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,scm-apq8084
> +              - qcom,scm-msm8916
> +              - qcom,scm-msm8953
> +              - qcom,scm-msm8974
> +              - qcom,scm-msm8976
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: core
> +            - const: bus
> +            - const: iface
> +
> +        clocks:
> +          minItems: 3
> +          maxItems: 3
> +
> +

Just one blank line.

> +      required:
> +        - clocks
> +        - clock-names
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    include <dt-bindings/clock/qcom,gcc-msm8916.h>
> +
> +    firmware {
> +        scm {
> +            compatible = "qcom,msm8916", "qcom,scm";
> +            clocks = <&gcc GCC_CRYPTO_CLK>,
> +                     <&gcc GCC_CRYPTO_AXI_CLK>,
> +                     <&gcc GCC_CRYPTO_AHB_CLK>;
> +            clock-names = "core", "bus", "iface";
> +        };
> +    };


Best regards,
Krzysztof

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8150E55B2EA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 18:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiFZQp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 12:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiFZQpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 12:45:51 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4370CDFB0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 09:45:50 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u12so14357815eja.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 09:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T6zfSUWfc+1scTNgnJ89joVhTOGLJ9hLI558Jh6uRz8=;
        b=xZzJI0HCHJdnUYsKjVixZyj4uWT5dPW8GfN+fyiq6p5zT/gNKFNZiF3AAKKwNMsI5D
         A8dKdxRac6T8qX//iPTplksmtM2SVMsMdcTH5KDTalVb7VHyvJhVrcHSfs5+ZlF9YcmK
         kt60fFHzxTxfPZ/COH7xz/PgAXMeSdGzDIizxNkVHMMmqvtxi4tix59mm8aYWl++G01z
         PORsakNhYNhTDF3fiTPtIkPojTm9Nv8fJ9KOjzn+Y5xeMPPpezVe7mvYaIeQczhexQvq
         SwZ3vJbQDAueQeKpqOzO9AW+EPhW39FIRz4jMNJrtUGCCG6ieICLZCHX5o4ozl35/3IO
         XUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T6zfSUWfc+1scTNgnJ89joVhTOGLJ9hLI558Jh6uRz8=;
        b=v7KwBD9ySmjteuoTpf74kCEBZ0ba3hcGoVriDbAU2T74r80S70xfWjtGUOn5S9Scmb
         rMbJGZ2dvlbqT5Jgie8NrxiJFbk02uqU0hjMBNh/LPHtTOCO5gc4m90QXEF2g/wH56t7
         /vl3/4bholMJiFumxRAhYsXftty9NcZ/adRqTO6PEdR7/20j2buQa7wdcHxKv0OyMCWr
         rqeq/vyJW0kD24lM3ySyqS8dh6w+/aQjuDWYNzShhfLrMLvDIbNPrYn2uB+TDC0n3JAR
         +5e/JKmXk3QP3EwmHfxTf/o6S63h7KUmJqyYZK3hXwtPx873itStSXRL9bS1aLt5XLQR
         Q6TQ==
X-Gm-Message-State: AJIora8538wdV4OorwbXjwtOlPJWL78mShLggi11LLBWGfmMLrpu2LT+
        TY0lm2tbOyXNOyOIDgKiRoiXYQ==
X-Google-Smtp-Source: AGRyM1ukYPBefFDfQhrz2ywdxsiWz9WQTYvMexcL0AIjbGhsMUEIjG9TisCLIv/JKtnl2e5ZO0u17w==
X-Received: by 2002:a17:907:2d92:b0:711:d229:4b7f with SMTP id gt18-20020a1709072d9200b00711d2294b7fmr8724754ejc.506.1656261948831;
        Sun, 26 Jun 2022 09:45:48 -0700 (PDT)
Received: from [192.168.0.242] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c1-20020a056402158100b004357dca07cdsm6206420edv.88.2022.06.26.09.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 09:45:48 -0700 (PDT)
Message-ID: <d00d6c3e-7d65-9021-7a26-486c705a16de@linaro.org>
Date:   Sun, 26 Jun 2022 18:45:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/3] dt-bindings: firmware: convert Qualcomm SCM
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
References: <20220626114634.90850-1-david@ixit.cz>
 <20220626114634.90850-3-david@ixit.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220626114634.90850-3-david@ixit.cz>
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

On 26/06/2022 13:46, David Heidelberg wrote:
> Convert Qualcomm SCM firmware binding to the yaml format.
> 
> This commit also:
>  - adds qcom,scm-mdm9607 into list which has only core clock
>  - adds qcom,scm-sm6125, qcom,scm-ipq6018
>  - #reset-cells, because the property is already used
> 
> Cc: Robert Marko <robimarko@gmail.com>
> Cc: Guru Das Srinagesh <quic_gurus@quicinc.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v3:
>  - add preceding patches for ARM and arm64 adding missing compatible strings
>  - extended with missing compatible strings
>  - added two additional maintainers, see https://lkml.org/lkml/2022/6/23/1969
> v2:
>  - changed maintainer to Bjorn
>  - document #reset-cells
> 
>  .../devicetree/bindings/firmware/qcom,scm.txt |  57 --------
>  .../bindings/firmware/qcom,scm.yaml           | 131 ++++++++++++++++++
>  2 files changed, 131 insertions(+), 57 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt
>  create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> deleted file mode 100644
> index 0f4e5ab26477..000000000000
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> +++ /dev/null
> @@ -1,57 +0,0 @@
> -QCOM Secure Channel Manager (SCM)
> -
> -Qualcomm processors include an interface to communicate to the secure firmware.
> -This interface allows for clients to request different types of actions.  These
> -can include CPU power up/down, HDCP requests, loading of firmware, and other
> -assorted actions.
> -
> -Required properties:
> -- compatible: must contain one of the following:
> - * "qcom,scm-apq8064"
> - * "qcom,scm-apq8084"
> - * "qcom,scm-ipq4019"
> - * "qcom,scm-ipq806x"
> - * "qcom,scm-ipq8074"
> - * "qcom,scm-mdm9607"
> - * "qcom,scm-msm8226"
> - * "qcom,scm-msm8660"
> - * "qcom,scm-msm8916"
> - * "qcom,scm-msm8953"
> - * "qcom,scm-msm8960"
> - * "qcom,scm-msm8974"
> - * "qcom,scm-msm8976"
> - * "qcom,scm-msm8994"
> - * "qcom,scm-msm8996"
> - * "qcom,scm-msm8998"
> - * "qcom,scm-sc7180"
> - * "qcom,scm-sc7280"
> - * "qcom,scm-sdm845"
> - * "qcom,scm-sdx55"
> - * "qcom,scm-sm6350"
> - * "qcom,scm-sm8150"
> - * "qcom,scm-sm8250"
> - * "qcom,scm-sm8350"
> - * "qcom,scm-sm8450"
> - and:
> - * "qcom,scm"
> -- clocks: Specifies clocks needed by the SCM interface, if any:
> - * core clock required for "qcom,scm-apq8064", "qcom,scm-msm8660" and
> -   "qcom,scm-msm8960"
> - * core, iface and bus clocks required for "qcom,scm-apq8084",
> -   "qcom,scm-msm8916", "qcom,scm-msm8953", "qcom,scm-msm8974" and "qcom,scm-msm8976"
> -- clock-names: Must contain "core" for the core clock, "iface" for the interface
> -  clock and "bus" for the bus clock per the requirements of the compatible.
> -- qcom,dload-mode: phandle to the TCSR hardware block and offset of the
> -		   download mode control register (optional)
> -
> -Example for MSM8916:
> -
> -	firmware {
> -		scm {
> -			compatible = "qcom,msm8916", "qcom,scm";
> -			clocks = <&gcc GCC_CRYPTO_CLK> ,
> -				 <&gcc GCC_CRYPTO_AXI_CLK>,
> -				 <&gcc GCC_CRYPTO_AHB_CLK>;
> -			clock-names = "core", "bus", "iface";
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> new file mode 100644
> index 000000000000..17d06e75b82b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> @@ -0,0 +1,131 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/firmware/qcom,scm.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

No quotes here.

> +
> +title: QCOM Secure Channel Manager (SCM)
> +
> +description: |
> +  Qualcomm processors include an interface to communicate to the secure firmware.
> +  This interface allows for clients to request different types of actions.
> +  These can include CPU power up/down, HDCP requests, loading of firmware,
> +  and other assorted actions.
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +  - Robert Marko <robimarko@gmail.com>
> +  - Guru Das Srinagesh <quic_gurus@quicinc.com>
> +
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
> +  clock-names: true

You should have constraints here - min/maxItems.

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
> +    description:
> +      Should be phandle/offset pair.

This description is not helpful. Should be something closer to "TCSR
hardware block".

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

Missing constraints (maxItems:2) for clocks.

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

Missing constraints for clocks.

> +
> +      required:
> +        - clocks
> +        - clock-names
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +

Best regards,
Krzysztof

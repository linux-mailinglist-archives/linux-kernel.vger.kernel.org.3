Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357064E3C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiCVKI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiCVKI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:08:57 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12AE6BDD8;
        Tue, 22 Mar 2022 03:07:29 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso1078101wmz.4;
        Tue, 22 Mar 2022 03:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nxkHql0HWJQRQ4pgsgQezZ/SXR7pQJpqc3zlVYSmcFI=;
        b=PlbcBjpZIyW164R2aPmKdN2mQb4X0ZxzzN9HH/BAV3WYeoosI/gw+pn+8CXGK5BGEi
         KJr/7+jBL8ttlqgyv2PBRhXj49JoD3JhWR6JxkW2dvtFtoPZ5TMLb5LySqdg2wlQOTej
         RNnfuNQchmROMRDFWYNoqGFA4nj9P42E1q8jBX1Hqkpz20QZIR8uDOs2l7GxuvVRSDEl
         88YJNhPC2PERz09x1TFu80+yD/Z3wNMuM3gK3cfZPHt02j/1fnTUQFLzmahbS+tHCV+2
         CKZ7ZJNt+slSsShPK6fCuS0upD4yM4ZYEacWu0brJBO+8R5IC5OQYi9YqatruppyFXCT
         Gfeg==
X-Gm-Message-State: AOAM530HjygM5jg333jtb19e31UyNGnyxLvsYLmB/TP0vJjgNiIwoJyM
        WDzZSWTpF1YuoG0ZEsVCt6TUFMTmEqI=
X-Google-Smtp-Source: ABdhPJxZjihx+VVlTR9wkGEPyaSuGSkGOArifZkQYuk5XQceVD5FvAjEXolvy07jpONYlPGQ7jcBOQ==
X-Received: by 2002:a1c:4e02:0:b0:38c:8a10:e899 with SMTP id g2-20020a1c4e02000000b0038c8a10e899mr2897142wmh.125.1647943648021;
        Tue, 22 Mar 2022 03:07:28 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id p8-20020a5d59a8000000b00204178688d3sm4337142wrr.100.2022.03.22.03.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 03:07:27 -0700 (PDT)
Message-ID: <e832516d-277d-6a0b-4588-b32a085185c8@kernel.org>
Date:   Tue, 22 Mar 2022 11:07:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 17/18] dt-bindings: arm: msm: Convert kpss-gcc driver
 Documentation to yaml
Content-Language: en-US
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
 <20220321231548.14276-18-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321231548.14276-18-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 00:15, Ansuel Smith wrote:
> Convert kpss-gcc driver Documentation to yaml. Since kpss-gcc expose a
> clock add the required '#clock-cells' binding while converting it.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ------------
>  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 69 +++++++++++++++++++
>  2 files changed, 69 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
> deleted file mode 100644
> index e628758950e1..000000000000
> --- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
> -
> -PROPERTIES
> -
> -- compatible:
> -	Usage: required
> -	Value type: <string>
> -	Definition: should be one of the following. The generic compatible
> -			"qcom,kpss-gcc" should also be included.
> -			"qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc"
> -			"qcom,kpss-gcc-apq8064", "qcom,kpss-gcc"
> -			"qcom,kpss-gcc-msm8974", "qcom,kpss-gcc"
> -			"qcom,kpss-gcc-msm8960", "qcom,kpss-gcc"
> -
> -- reg:
> -	Usage: required
> -	Value type: <prop-encoded-array>
> -	Definition: base address and size of the register region
> -
> -- clocks:
> -	Usage: required
> -	Value type: <prop-encoded-array>
> -	Definition: reference to the pll parents.
> -
> -- clock-names:
> -	Usage: required
> -	Value type: <stringlist>
> -	Definition: must be "pll8_vote", "pxo".
> -
> -- clock-output-names:
> -	Usage: required
> -	Value type: <string>
> -	Definition: Name of the output clock. Typically acpu_l2_aux indicating
> -		    an L2 cache auxiliary clock.
> -
> -Example:
> -
> -	l2cc: clock-controller@2011000 {
> -		compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc";
> -		reg = <0x2011000 0x1000>;
> -		clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
> -		clock-names = "pll8_vote", "pxo";
> -		clock-output-names = "acpu_l2_aux";
> -	};
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> new file mode 100644
> index 000000000000..7eb852be02c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/msm/qcom,kpss-gcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
> +
> +maintainers:
> +  - Ansuel Smith <ansuelsmth@gmail.com>
> +
> +description: |
> +  Krait Processor Sub-system (KPSS) Global Clock Controller (GCC). Used
> +  to control L2 mux (in the current implementation).
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,kpss-gcc-ipq8064
> +          - qcom,kpss-gcc-apq8064
> +          - qcom,kpss-gcc-msm8974
> +          - qcom,kpss-gcc-msm8960
> +      - const: qcom,kpss-gcc
> +      - const: syscon

There was no syscon here before. This is not explained in commit msg or
patch history, while I asked to document explicitly any deviation from
the conversion.

This is not how the process works. You keep making silent/hidden changes
to the bindings and to the patch submission process. It's difficult to
review and it is even more difficult to trust you that you implement
what we ask for. You keep resending versions of the patchset the same
day (two versions yesterday, shortly after another one) which does not
give time to react and review. Plus then you hide some more changes to
regular conversion without explaining them.

NAK. It's really bad process. :(


Best regards,
Krzysztof

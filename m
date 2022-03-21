Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E574E2C87
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350433AbiCUPn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350496AbiCUPnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:43:06 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4BC174BA9;
        Mon, 21 Mar 2022 08:41:40 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id u16so20256885wru.4;
        Mon, 21 Mar 2022 08:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WML5+iO99XG8Cnb/y7ZTclpuOwKzuJZAVQdLXyKLfiY=;
        b=2uOKEVaozGuCB/X3I7v+OUGNpMd6JQPmfKvnxTlIcAaFEczHc6hn3FqEDVScye1N6q
         88cRBu5wJ3nZjuI/ouHqlITQK0+G227Hr+i1/1GN2aqstVXWFGty/kwvJIn7ijuncZrS
         qS9xP4YYhK+Ov4jZbtXwH6f+YI5dhrtyra/d77GDZ5sMg2MkNAMVZjMNMfOyo7g/oqrH
         k2zZguKt0vTVHdQn8pUrMVWSZPXwqq+6rslcaKR3j//79CcSNtU6Psd3Gfvc+FNUH5SM
         oqFf+CGnnrRvJYLU27qFd3xV62eoLmE9AuX+QrLrQtCEiEbOAmgjEPVBe3lnbHi8wD6W
         gRkA==
X-Gm-Message-State: AOAM533QLjyeD6sM105oytLbK/541p3LoTqSKYPwBYEnJFXNmgy8u1tj
        qSz1dTAhu4F+Ofqlza3d1/zKAvockco=
X-Google-Smtp-Source: ABdhPJwswOpeYAUSbv2gZd+sF9HdVox9ltx0wl2XRAWQjiodyAcp5T05tpxfrZ5d6BEO3ueGw112Sw==
X-Received: by 2002:a5d:66ca:0:b0:203:fb72:a223 with SMTP id k10-20020a5d66ca000000b00203fb72a223mr11487484wrw.12.1647877298918;
        Mon, 21 Mar 2022 08:41:38 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id z18-20020adfec92000000b00203f04ed4a8sm10085010wrn.13.2022.03.21.08.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 08:41:38 -0700 (PDT)
Message-ID: <a7837388-e36f-9e55-4107-9f7f85571f3b@kernel.org>
Date:   Mon, 21 Mar 2022 16:41:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 18/18] dt-bindings: arm: msm: Convert kpss-gcc driver
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
References: <20220321144825.11736-1-ansuelsmth@gmail.com>
 <20220321144825.11736-19-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321144825.11736-19-ansuelsmth@gmail.com>
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

On 21/03/2022 15:48, Ansuel Smith wrote:
> Convert kpss-gcc driver Documentation to yaml.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ------------
>  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 68 +++++++++++++++++++
>  2 files changed, 68 insertions(+), 44 deletions(-)
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
> index 000000000000..20ee182eb16f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> @@ -0,0 +1,68 @@
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
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: phandle to pll8_vote
> +      - description: phandle to pxo_board
> +
> +  clock-names:
> +    items:
> +      - const: pll8_vote
> +      - const: pxo
> +
> +  clock-output-names:
> +    const: acpu_l2_aux
> +
> +  '#clock-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - clock-output-names
> +  - '#clock-cells'

You add here a new required property, so this is not a pure conversion.
Please explain in the commit msg why are you doing this. I asked about
this in your previous patchset.

Best regards,
Krzysztof

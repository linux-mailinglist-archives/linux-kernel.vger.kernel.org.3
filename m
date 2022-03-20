Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F129B4E1B83
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 13:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245033AbiCTMHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 08:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235879AbiCTMHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 08:07:18 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339AF3700D;
        Sun, 20 Mar 2022 05:05:55 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id x34so13886486ede.8;
        Sun, 20 Mar 2022 05:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EK+9/dhmLoPxMu5b2nK2Xcm/iIJDXooqRYAKVr+5a7k=;
        b=54As3FJ4p0FjzA312y2mjOTeZ36lY6Rk9CEHJG/n4gMSO8D6s5h7mF0Ln/xbd+ee1p
         k02BCAtQ+UsY4wfa49g/Wzn1gYhl3M/OCBAZ/GBC/BamTRXhW2xj8ZEBOynk9F3HSl2W
         lse3lfb/9zpj6eG41J8hPCkhyGANEKKj84xVRjHrmbgsW78SeCgl8jsLVXDmyRKR1UTX
         0cIwkwvPxKc+2M2mxbrkNlv9oLuCVzRBtaBtUwyPL3VWUpDs11TdfaWUIaT91+czDLid
         UBbD4K4bBOKTSQ/RjwQ3mo7oNeHRqTl7mtOmppkI5HGQCfjRFsJmxH1V2sj3uBhxvHg8
         SUvA==
X-Gm-Message-State: AOAM532XgGf3tNL+FWu0w4tZ3FV45O6m9mUlmkBUK2ddaYdDHVTZCGEz
        8zc/vVTEV4uSLhaxMQ/YHKY=
X-Google-Smtp-Source: ABdhPJwQStuHwQrbEo2YBiqGQl2D2AngW+GiT3RxGeJGK/6jMj1FgsPl4n25StdgnGQQeScBGkv86Q==
X-Received: by 2002:a05:6402:3549:b0:419:343c:521 with SMTP id f9-20020a056402354900b00419343c0521mr1843719edd.85.1647777953606;
        Sun, 20 Mar 2022 05:05:53 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id ch26-20020a0564021bda00b00418f99695f0sm4878744edb.23.2022.03.20.05.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 05:05:53 -0700 (PDT)
Message-ID: <45e4f763-d991-0939-3735-bfea05c48143@kernel.org>
Date:   Sun, 20 Mar 2022 13:05:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 16/16] dt-bindings: arm: msm: Convert kpss driver
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
References: <20220318160827.8860-1-ansuelsmth@gmail.com>
 <20220318160827.8860-17-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220318160827.8860-17-ansuelsmth@gmail.com>
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

On 18/03/2022 17:08, Ansuel Smith wrote:
> Convert kpss-acc and kpss-gcc Documentation to yaml. Fix multiple
> Documentation error and provide additional example for kpss-gcc-v2.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 ----------
>  .../bindings/arm/msm/qcom,kpss-acc.yaml       | 97 +++++++++++++++++++
>  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ---------
>  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 63 ++++++++++++
>  4 files changed, 160 insertions(+), 93 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> deleted file mode 100644
> index 7f696362a4a1..000000000000
> --- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -Krait Processor Sub-system (KPSS) Application Clock Controller (ACC)
> -
> -The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
> -There is one ACC register region per CPU within the KPSS remapped region as
> -well as an alias register region that remaps accesses to the ACC associated
> -with the CPU accessing the region.
> -
> -PROPERTIES
> -
> -- compatible:
> -	Usage: required
> -	Value type: <string>
> -	Definition: should be one of:
> -			"qcom,kpss-acc-v1"
> -			"qcom,kpss-acc-v2"
> -
> -- reg:
> -	Usage: required
> -	Value type: <prop-encoded-array>
> -	Definition: the first element specifies the base address and size of
> -		    the register region. An optional second element specifies
> -		    the base address and size of the alias register region.
> -
> -- clocks:
> -        Usage: required
> -        Value type: <prop-encoded-array>
> -        Definition: reference to the pll parents.
> -
> -- clock-names:
> -        Usage: required
> -        Value type: <stringlist>
> -        Definition: must be "pll8_vote", "pxo".
> -
> -- clock-output-names:
> -	Usage: optional
> -	Value type: <string>
> -	Definition: Name of the output clock. Typically acpuX_aux where X is a
> -		    CPU number starting at 0.
> -
> -Example:
> -
> -	clock-controller@2088000 {
> -		compatible = "qcom,kpss-acc-v2";
> -		reg = <0x02088000 0x1000>,
> -		      <0x02008000 0x1000>;
> -		clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
> -		clock-names = "pll8_vote", "pxo";
> -		clock-output-names = "acpu0_aux";
> -	};
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
> new file mode 100644
> index 000000000000..6e8ef4f85eab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/msm/qcom,kpss-acc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Krait Processor Sub-system (KPSS) Application Clock Controller (ACC)
> +
> +maintainers:
> +  - Ansuel Smith <ansuelsmth@gmail.com>
> +
> +description: |
> +  The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
> +  There is one ACC register region per CPU within the KPSS remapped region as
> +  well as an alias register region that remaps accesses to the ACC associated
> +  with the CPU accessing the region.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,kpss-acc-v1
> +      - qcom,kpss-acc-v2
> +
> +  reg:
> +    items:
> +      - description: Base address and size of the register region
> +      - description: Optional base address and size of the alias register region
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
> +    description: Name of the aux clock. Krait can have at most 4 cpu.
> +    enum:
> +      - acpu0_aux
> +      - acpu1_aux
> +      - acpu2_aux
> +      - acpu3_aux
> +
> +  '#clock-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:

This is not obvious from the original bindings. Why are these required
only on v1? Whatr about v2? Are they allowed on v2? Why at least
clock-cells are not required on v2?

The previous bindings make them required which you change here. Your
commit does not explain this.

Please explicitly explain in commit msg all changes to the bindings
which are necessary for conversion.

> +            const: qcom,kpss-acc-v1
> +      then:
> +        required:
> +          - clocks
> +          - clock-names
> +          - clock-output-names
> +          - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
> +
> +    clock-controller@2088000 {
> +      compatible = "qcom,kpss-acc-v1";
> +      reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
> +      clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> +      clock-names = "pll8_vote", "pxo";
> +      clock-output-names = "acpu0_aux";
> +      #clock-cells = <0>;
> +    };
> +
> +    clock-controller@2098000 {
> +      compatible = "qcom,kpss-acc-v1";
> +      reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
> +      clock-output-names = "acpu1_aux";
> +      clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> +      clock-names = "pll8_vote", "pxo";
> +      #clock-cells = <0>;

It's the same example as above, no differences. Remove it.

> +    };
> +
> +  - |
> +    clock-controller@f9088000 {
> +      compatible = "qcom,kpss-acc-v2";
> +      reg = <0xf9088000 0x1000>,
> +            <0xf9008000 0x1000>;

You now changed the example. This looks wrong.

> +    };
> +...
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
> index 000000000000..578e2eccb7db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> @@ -0,0 +1,63 @@
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
> +    const: qcom,kpss-gcc

This is wrong conversion. You removed quite a lot.

Please split this commit into two separate conversions (acc and gcc).

> +
> +  reg:
> +    items:
> +      - description: Base address and size of the register region

Just maxItems:1. No need for items and description - it's obvious.

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


Best regards,
Krzysztof

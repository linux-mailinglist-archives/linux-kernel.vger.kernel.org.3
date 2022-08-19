Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C52599BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348669AbiHSMVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348542AbiHSMVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:21:31 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7308810158E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:21:29 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a7so669968ljr.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Nu3VLDUqU+jU9Ulv1RKGhBZJe/ApM+TsuNJuzdtSY+M=;
        b=icCaSFYl9TTYDLZjSUnfxcI0YMgzci2BRFPyleEvRJdU+T1TBi3QED1EcIV+5EUEF7
         ZzCByTkLldBb3PcS4W0m4bNFBRWfn++1kIijqJw/O6lJS/IHoam6Hv2LH+bozhv/REGN
         kTX09folP9hdjbJ0yisTi54ebfxFgeqwgttCYqbkxj4jLdVFv3GYRX2Jzu6mbWdB5+GF
         vVbZkVsDKDd2G1cslwfnFm17c7APLx6ufQWu+Ei8KHWOyp4mCoTWdV5pvmU5265GnTeX
         f6wLGlQZQ8IeNOG3Qz86cyJ5WBeRBt3b1RuR2v8ZJ72wA+5FapAMVLBz+tyMN0zYKcRe
         6XcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Nu3VLDUqU+jU9Ulv1RKGhBZJe/ApM+TsuNJuzdtSY+M=;
        b=ZRc5dfXv7Wwra+SEc50CCk0aoNkXkli2xe8cb7/4BXtqedDsB2EToTJ3HjfpzXLk+Y
         zh+DHqyHbs5uBHvtgDeWv8Teg1Q0VaD4FyXsQr4ccKcHK3kirioVcl4xuLb/dBMMs/SB
         Th8GlRKbJdt4r5WC9ZJBRTXM7lBfUe11dHzbPdaZLCNP5jpaR0JqUoZ/eTYquabCEWE1
         DRi/VWbY36hX8UYCEeRKJfUl4Y5qUkVWkxvrN94FtuBIGggxL+DMmv839LQ52+AlVPtS
         WEhenEL30AUB7Yabqx8+PziBEoF8766c11wTqCMKkK5AcpC/S++CvrE4JN6Cg5WvAhki
         II1w==
X-Gm-Message-State: ACgBeo0OgOkWC9qX4cNCIzQnt5xT0GMWSGE+azUGIH6E3UIwIQLqeVhw
        AdkDvUehy5LW2IKFD9mVL8468w==
X-Google-Smtp-Source: AA6agR595KwMfyX0sVhhUEYlgdd7hbmxKDXxniItF7Yjp2Fh/BhRyNo1Zh0kLJkHkh4xFhiOIyc0zQ==
X-Received: by 2002:a05:651c:516:b0:25f:f52b:3c86 with SMTP id o22-20020a05651c051600b0025ff52b3c86mr2111392ljp.523.1660911687788;
        Fri, 19 Aug 2022 05:21:27 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id t20-20020a2e8e74000000b0025e1ec74e25sm595362ljk.43.2022.08.19.05.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 05:21:27 -0700 (PDT)
Message-ID: <bccd3a79-faa2-e4c5-3783-25ffaea69d00@linaro.org>
Date:   Fri, 19 Aug 2022 15:21:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] dt-bindings: clock: add QCOM SM6115 display clock
 bindings
Content-Language: en-US
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220818151850.19917-1-a39.skl@gmail.com>
 <20220818151850.19917-2-a39.skl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220818151850.19917-2-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2022 18:18, Adam Skladowski wrote:
> Add device tree bindings for display clock controller for
> Qualcomm Technology Inc's SM6115 SoC.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  .../bindings/clock/qcom,dispcc-sm6115.yaml    | 88 +++++++++++++++++++
>  .../dt-bindings/clock/qcom,dispcc-sm6115.h    | 36 ++++++++
>  2 files changed, 124 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6115.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm6115.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6115.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6115.yaml
> new file mode 100644
> index 000000000000..2b9671112934
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6115.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,dispcc-sm6115.yaml#

Filename based on compatible, so:
qcom,sm6115-dispcc.yaml

I know it creates irregularity, but that's the naming convention for all.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Display Clock Controller Binding for SM6115
> +
> +maintainers:
> +  - Taniya Das <tdas@codeaurora.org>

I don't think the email is correct. Please use Bjorn's (and optionally
you can add yourself if you want to maintain this binding).

> +
> +description: |
> +  Qualcomm display clock control module which supports the clocks and
> +  power domains on SM6115.
> +
> +  See also:
> +    dt-bindings/clock/qcom,dispcc-sm6115.h
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sm6115-dispcc
> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: Byte clock from DSI PHY0
> +      - description: Pixel clock from DSI PHY0
> +      - description: GPLL0 clock from GCC
> +      - description: GPLL0 div clock from GCC
> +      - description: Board sleep clock
> +
> +  clock-names:
> +    items:
> +      - const: bi_tcxo
> +      - const: dsi0_phy_pll_out_byteclk
> +      - const: dsi0_phy_pll_out_dsiclk
> +      - const: gcc_disp_gpll0_clk_src
> +      - const: gcc_disp_gpll0_div_clk_src
> +      - const: sleep_clk
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +  - '#reset-cells'
> +  - '#power-domain-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmcc.h>
> +    #include <dt-bindings/clock/qcom,gcc-sm6115.h>
> +    clock-controller@5f00000 {
> +      compatible = "qcom,sm6115-dispcc";
> +      reg = <0x5f00000 0x20000>;
> +      clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> +               <&dsi0_phy 0>,
> +               <&dsi0_phy 1>,
> +               <&gcc GCC_DISP_GPLL0_CLK_SRC>,
> +               <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>,
> +               <&sleep_clk>;
> +      clock-names = "bi_tcxo",
> +                    "dsi0_phy_pll_out_byteclk",
> +                    "dsi0_phy_pll_out_dsiclk",
> +                    "gcc_disp_gpll0_clk_src",
> +                    "gcc_disp_gpll0_div_clk_src",
> +                    "sleep_clk";
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +      #power-domain-cells = <1>;
> +    };
> +...
> diff --git a/include/dt-bindings/clock/qcom,dispcc-sm6115.h b/include/dt-bindings/clock/qcom,dispcc-sm6115.h
> new file mode 100644
> index 000000000000..d1a6c45b5029
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,dispcc-sm6115.h

Filename based on compatible.

> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2022, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_QCOM_DISP_CC_SM6115_H
> +#define _DT_BINDINGS_CLK_QCOM_DISP_CC_SM6115_H
> +


Best regards,
Krzysztof

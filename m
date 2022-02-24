Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348D84C34FE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 19:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiBXSqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 13:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiBXSqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 13:46:33 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE3926F4E6;
        Thu, 24 Feb 2022 10:46:03 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id q5so4160429oij.6;
        Thu, 24 Feb 2022 10:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P2RyEA1uirLwwFpK+SxG1zyLPyqtVmQD3S3aYo1DozE=;
        b=i0KxqpJClFAiL/+9243DSoccNYeXr4Lma+8kVq/VbehjedJbcLwUc0ukO5XiOoyA7a
         cwYPMqm1zo7+IxIXYa1+nI5PPhAnw0h6G2v9BAQHLVXdArE0aXnV1Oy1Yx1idgDHzA2B
         WH/8O1hiPyFXrBEkKflvjqy2l6rhoT7R3CHaf4J7dp+B+F9NZ4QqUe0uuN5KTIVROQeP
         qXDoNZ7Du2HKrxZ63zbiy+t7wL3KupZ8HOhz84FuiMfTOOujwmr/jJqVfJimkx4t/Gqm
         z//fj0uWqAE2zdMHtYkuD2+07LFTN3uBV1zoYQGcF24LNK2Ld0NXGfhnUX6I0Jp7tHUe
         otaw==
X-Gm-Message-State: AOAM531hNi4ipg8VY8BqXUY3H9bcNTsQP6KaW+hshPIEGpKeqm7jCKtq
        oIA7eGgu/3VX7NkYGLUlqQ==
X-Google-Smtp-Source: ABdhPJzWyNBr5BidOLbjvmBUI5XqtQwWj6zUADhXUeWH6YEiusg/LluRW/NyAsJ0Ygq31N6F4Jpy0A==
X-Received: by 2002:a05:6808:1907:b0:2d5:bca0:ea6c with SMTP id bf7-20020a056808190700b002d5bca0ea6cmr7045098oib.212.1645728362785;
        Thu, 24 Feb 2022 10:46:02 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m2-20020a9d4002000000b005a2678bbc5csm76155ote.24.2022.02.24.10.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 10:46:02 -0800 (PST)
Received: (nullmailer pid 3385736 invoked by uid 1000);
        Thu, 24 Feb 2022 18:46:01 -0000
Date:   Thu, 24 Feb 2022 12:46:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/15] dt-bindings: clock: simplify qcom,gcc-apq8064
 Documentation
Message-ID: <YhfSaQEM4ZalLGyD@robh.at.kernel.org>
References: <20220224164831.21475-1-ansuelsmth@gmail.com>
 <20220224164831.21475-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224164831.21475-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 05:48:18PM +0100, Ansuel Smith wrote:
> Simplify qcon,gcc-apq8064 Documentation by using qcom,gcc.yaml as a
> template and remove the compatible from qcom,gcc.yaml
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/clock/qcom,gcc-apq8064.yaml      | 29 +++++--------------
>  .../bindings/clock/qcom,gcc-other.yaml        |  3 --
>  2 files changed, 7 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> index 8e2eac6cbfb9..97936411b6b4 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> @@ -6,6 +6,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Qualcomm Global Clock & Reset Controller Binding for APQ8064
>  
> +allOf:
> +  - $ref: qcom,gcc.yaml#
> +
>  maintainers:
>    - Stephen Boyd <sboyd@kernel.org>
>    - Taniya Das <tdas@codeaurora.org>
> @@ -17,22 +20,12 @@ description: |
>    See also:
>    - dt-bindings/clock/qcom,gcc-msm8960.h
>    - dt-bindings/reset/qcom,gcc-msm8960.h
> +  - dt-bindings/clock/qcom,gcc-apq8084.h
> +  - dt-bindings/reset/qcom,gcc-apq8084.h
>  
>  properties:
>    compatible:
> -    const: qcom,gcc-apq8064

I assume you didn't mean to remove this?

> -
> -  '#clock-cells':
> -    const: 1
> -
> -  '#reset-cells':
> -    const: 1
> -
> -  '#power-domain-cells':
> -    const: 1
> -
> -  reg:
> -    maxItems: 1
> +    const: qcom,gcc-apq8084
>  
>    nvmem-cells:
>      minItems: 1
> @@ -53,21 +46,13 @@ properties:
>    '#thermal-sensor-cells':
>      const: 1
>  
> -  protected-clocks:
> -    description:
> -      Protected clock specifier list as per common clock binding.
> -
>  required:
>    - compatible
> -  - reg
> -  - '#clock-cells'
> -  - '#reset-cells'
> -  - '#power-domain-cells'
>    - nvmem-cells
>    - nvmem-cell-names
>    - '#thermal-sensor-cells'
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> index 4e5903bcd70d..47e1c5332d76 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> @@ -15,8 +15,6 @@ description:
>    power domains.
>  
>    See also:
> -  - dt-bindings/clock/qcom,gcc-apq8084.h
> -  - dt-bindings/reset/qcom,gcc-apq8084.h
>    - dt-bindings/clock/qcom,gcc-ipq4019.h
>    - dt-bindings/clock/qcom,gcc-ipq6018.h
>    - dt-bindings/reset/qcom,gcc-ipq6018.h
> @@ -40,7 +38,6 @@ allOf:
>  properties:
>    compatible:
>      enum:
> -      - qcom,gcc-apq8084
>        - qcom,gcc-ipq4019
>        - qcom,gcc-ipq6018
>        - qcom,gcc-ipq8064
> -- 
> 2.34.1
> 
> 

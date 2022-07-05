Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA57566755
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiGEKIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiGEKIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:08:43 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECF213F56
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:08:41 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id m18so1245353lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 03:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2RMdNnVhmAig0n7CGXZwiZm5h665r/1QoJMm/NVYot0=;
        b=OqiLE5Zn6WCkXM4xkFUC6fyOaa+RBb5K7k6Af3nP1tqcmlqBKvpq/bhMuyyEa2EnAP
         zEH9OacpQ3qCISmeT8f6m/cCmRq4YRKCaxxh85cMFcZ7/SroF7Q7ctWPj6XbJlYa4Hp+
         k9K0HBJNprRdUYJsiI5uqsFET22WP5C0YTq9SD+0pxZKkkP9on7Yq5BCHRWtgG2uo1KG
         yqDVDFA+eIM7AKaWdqHzPzWv75rXGlwLzOn9JyFW+hIBrHBd8ehQ1Bf1HvRgzvdkgDSl
         icxRsOqRiQWBCB+uZpXK7quyKExWnsFFLbySK9yVh2J2hzs4UjjTmmKPTTOkaqLHX73n
         adlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2RMdNnVhmAig0n7CGXZwiZm5h665r/1QoJMm/NVYot0=;
        b=xlMbkK05vRAUw4HvhzSfinlAGJm2g9ip/mpq1xG+9uVh8rOEFMSJnUc5knxse0SF7P
         JjSRDXvgMGfkZPO58C/MpRyj6zQiakiagrnFXXMJgRaC7gbB/ykrUC/4XK8wkxcpI6Fq
         Q+kZVrmwOSYP4+xH3PKsDYUpT0Xhw0ZPiKONW+48sLuYRyvO7EOlXHCFiLy9vpLuGK9x
         7nFAG16UEgKNkLSODCiM8GGe0rNjRY+i0HBf2IJCAmBdQckXSXekt/C3gdLBoqm52EUx
         osXekic7jARzzvhBHMUp6SkeTtQqlrpyttiGH+ZJlhXKgmjOK9wYeSmqMmYnKSbCnchp
         D78g==
X-Gm-Message-State: AJIora9BB39frZlRCOVrgySp1yoNd/F1/irbojcjJmSuCAygM1Bvbgvm
        T5ywpVQ5yUxoHCEEGqJGEwkcnw==
X-Google-Smtp-Source: AGRyM1vVjkpJqRvWsAHuK0+v/9PE/cEyzGY4WQX7GHa9pKdllYnAodTXMiSdl2SF4cRkv3/JhZ/WkA==
X-Received: by 2002:a05:6512:b0d:b0:481:5cb4:cf1e with SMTP id w13-20020a0565120b0d00b004815cb4cf1emr14283070lfu.442.1657015718985;
        Tue, 05 Jul 2022 03:08:38 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id p10-20020ac24eca000000b0048160c5e625sm2258261lfr.12.2022.07.05.03.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 03:08:37 -0700 (PDT)
Message-ID: <46b0cdab-aa94-7f55-5d9f-f79a644f0fec@linaro.org>
Date:   Tue, 5 Jul 2022 12:08:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 06/43] dt-bindings: phy: qcom,qmp: split out
 msm8996-qmp-pcie-phy
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-7-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705094239.17174-7-johan+linaro@kernel.org>
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

On 05/07/2022 11:42, Johan Hovold wrote:
> The QMP PHY DT schema is getting unwieldy. Break out the odd-bird
> msm8996-qmp-pcie-phy which is the only QMP PHY that uses separate
> "per-lane" nodes.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../phy/qcom,msm8996-qmp-pcie-phy.yaml        | 114 ++++++++++++++++++
>  .../devicetree/bindings/phy/qcom,qmp-phy.yaml |  32 -----
>  2 files changed, 114 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
> new file mode 100644
> index 000000000000..14fd86fd91ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
> @@ -0,0 +1,114 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +

No line break

> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/qcom,msm8996-qmp-pcie-phy.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop the quotes from two above.

> +
> +title: Qualcomm QMP PHY controller (MSM8996 PCIe)
> +
> +maintainers:
> +  - Vinod Koul <vkoul@kernel.org>
> +
> +description:
> +  QMP PHY controller supports physical layer functionality for a number of
> +  controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
> +
> +properties:
> +  compatible:
> +    const: qcom,msm8996-qmp-pcie-phy
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: Address and length of PHY's common serdes block.
> +      - description: Address and length of PHY's DP_COM control block.

Are two reg items applicable here?

> +
> +  "#address-cells":
> +    enum: [ 1, 2 ]
> +
> +  "#size-cells":
> +    enum: [ 1, 2 ]
> +
> +  ranges: true
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 4

Define clocks here, not in allOf:if:then.

> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 4

Ditto

> +
> +  resets:
> +    minItems: 1
> +    maxItems: 3

Ditto

> +
> +  reset-names:
> +    minItems: 1
> +    maxItems: 3

Ditto

> +
> +  vdda-phy-supply:
> +    description:
> +      Phandle to a regulator supply to PHY core block.
> +
> +  vdda-pll-supply:
> +    description:
> +      Phandle to 1.8V regulator supply to PHY refclk pll block.
> +
> +  vddp-ref-clk-supply:
> +    description:
> +      Phandle to a regulator supply to any specific refclk pll block.
> +
> +patternProperties:
> +  "^phy@[0-9a-f]+$":
> +    type: object
> +    description:
> +      Each device node of QMP PHY is required to have as many child nodes as
> +      the number of lanes the PHY has.
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,msm8996-qmp-pcie-phy
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: PHY aux clock.
> +            - description: PHY config clock.
> +            - description: 19.2 MHz ref clock.
> +        clock-names:
> +          items:
> +            - const: aux
> +            - const: cfg_ahb
> +            - const: ref
> +        resets:
> +          items:
> +            - description: Reset of PHY block.
> +            - description: PHY common block reset.
> +            - description: PHY's ahb cfg block reset.
> +        reset-names:
> +          items:
> +            - const: phy
> +            - const: common
> +            - const: cfg
> +      required:
> +        - vdda-phy-supply
> +        - vdda-pll-supply

How about an example?


Best regards,
Krzysztof

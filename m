Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4744A5712E6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiGLHPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiGLHPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:15:38 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE0852DE7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:15:37 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bp17so4592747lfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nsCsUCsLeks7gLQjyy032kLwCiyMm8kobhR40LxLfCE=;
        b=fP1az/JP9d5e2iu960Ic2C2JTKpsqA318fncQOEWI9lQMTMo+xqjwtxRR9GzAJl9T1
         waUAo5RWk2oP0WP1wxNQcNwoQoOTqyFpWexrqawczTQ88goI0jJ+pi5UkvaqFbe06xLo
         4Zpu5I/bS5dsF/jj/997rgIvJlDmKF/Dc7mEpXgMnnlpf6oNR1Ty9VGOSLn87BcCFbfZ
         3Ss5NS6m0EcKYvxggwyTvMWQIdvFJGS5SswRD0E/ErY4YjPP8gjp+H8+0q5uEa3ZSEHj
         Aiw4zbELh/Bi1yjMrdRBMOBqEDgxfWUAvDTocnRPXWW/y6ZiM6KJ/CL8NYwcZ3iCF5Rv
         JEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nsCsUCsLeks7gLQjyy032kLwCiyMm8kobhR40LxLfCE=;
        b=c4u0kMQXNEpnp39sp1C6MhqZwVnbI+AABd3UToqvMRz8skZ1eVrnd6puPie6JoaeOK
         aPbcpP90pp3jQdms2qYF4ZAEJVlmrggUaW0R3adGJbDH7neyTXLAm7LPvKNj9u05oPTf
         TMulgMdfykre2ajU2AoNVlTa1+5RZTsCgvJkfI9LpEn76xhkFdcOdteMTpJUL/6cj+q/
         lIWLOqFl/ay4vMlfZw5jVXpfx1ZEH+2wSyohc8+c/n5L6IV4ii06xyKtwwR3NvmhxmR4
         94yy4u8Z+wSJOpigsltDhZosx0C0yp7XbNpky0ru4tdTU+YrwYKOEszvYONcs+9FZzgo
         PnUA==
X-Gm-Message-State: AJIora+KcA8N1Jdi58eWVIpInQ8vvaxX9A8AaGN6ffsSvBmNU2rrW4WO
        ENz8+8NgyWJVecKMdjeWRp/IQQ==
X-Google-Smtp-Source: AGRyM1spCUHNkLtF0Uo+VDAZEfXmPYq1704v0M4hpSxhTZ9ocQTZspqz/bbrl5COvtkZ1IRDf9Mtng==
X-Received: by 2002:a05:6512:45b:b0:489:cf49:4623 with SMTP id y27-20020a056512045b00b00489cf494623mr8890654lfk.266.1657610135495;
        Tue, 12 Jul 2022 00:15:35 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id r6-20020ac25c06000000b00483f8c40c17sm2003762lfp.240.2022.07.12.00.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 00:15:34 -0700 (PDT)
Message-ID: <1aa8e9aa-8cb3-8537-6d65-dd9441d5ee07@linaro.org>
Date:   Tue, 12 Jul 2022 09:15:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] dt-binding:perf: Add Amlogic DDR PMU
Content-Language: en-US
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chris Healy <cphealy@gmail.com>
References: <20220712063641.2790997-1-jiucheng.xu@amlogic.com>
 <20220712063641.2790997-4-jiucheng.xu@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712063641.2790997-4-jiucheng.xu@amlogic.com>
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

On 12/07/2022 08:36, Jiucheng Xu wrote:
> Add binding documentation for the Amlogic G12 series DDR
> performance monitor unit.

You need to fix subject - use a prefix matching subsystem. Space after
each ':'.

> 
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> ---
>  .../devicetree/bindings/perf/aml-ddr-pmu.yaml | 51 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/aml-ddr-pmu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/perf/aml-ddr-pmu.yaml b/Documentation/devicetree/bindings/perf/aml-ddr-pmu.yaml
> new file mode 100644
> index 000000000000..c586b4ab4009
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/aml-ddr-pmu.yaml

Filename: aml,g12-ddr-pmu.yaml

> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/perf/aml-ddr-pmu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic G12 DDR performance monitor
> +
> +maintainers:
> +  - Jiucheng Xu <jiucheng.xu@amlogic.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - aml,g12-ddr-pmu
> +      - items:
> +          - enum:
> +              - aml,g12-ddr-pmu
> +          - const: aml,g12-ddr-pmu

This does not make any sense. Why do you use two compatibles
"aml,g12-ddr-pmu", "aml,g12-ddr-pmu" after each other?

> +
> +  reg:
> +    maxItems: 2

You need to describe the items.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - model
> +  - dmc_nr
> +  - chann_nr

How these ended up here?
No underscores.

> +  - reg
> +  - interrupts
> +  - interrupt-names

Also something new. No.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +          ddr_pmu: ddr_pmu {

Wrong indentation. 4 spaces for DTS example.

Generic node name, so "pmu", no underscores in node names.

> +                  compatible = "amlogic,g12-ddr-pmu";
> +                  model = "g12a";
> +                  dmc_nr = <1>;
> +                  chann_nr = <4>;

This does not pass the test. Please do not send untested bindings.


Best regards,
Krzysztof

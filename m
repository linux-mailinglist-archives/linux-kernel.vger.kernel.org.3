Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523635B2017
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbiIHOFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiIHOFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:05:00 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC59643C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:04:28 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id q7so27922321lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 07:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wRXw5kLppF8YNiS3oFj6PnMX9c/uoE1GULsIw37dPHs=;
        b=sjJm6DPT3ZK77GxlHCV86RVgUWOHZyUBKCAwKSpKah+aiXtkkCk29AH7tGUVKp50+H
         9sBqlpiuSsePgUSCLhpONNkwTfRo1+6Lw1pY7L/rydYJf7x12reakU0f4FlOaeOInyo1
         DWY17g4o9qVDR1+MqocvZJ2VM68goQ+EK1jmepQRjkLhQKutChdJ+svZoNIjHufC6B+9
         3pCkwZpn8NKC8onE73NKR0+qj4LsTcdTylovGWPWiksLFvEWx8K+uF4f4PaDgmOeqcw6
         opMjHPVA60uEWHGmb6IcUO3GsVDeCvZaZYc9W4KcOgcCeyT4Ek+zh5YPkTF/VhhDKJS+
         qlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wRXw5kLppF8YNiS3oFj6PnMX9c/uoE1GULsIw37dPHs=;
        b=eGUDldP+n47doyv6Jc00Y+wM8jKzW8eiVAXT81TJWrPrj/nQVqO9uY7jWaKTrZhR4D
         u+ktgSXTkAdAKsZSjpcsYTnsD39oHmfHYKSe8C2QvemyRhiYFF9+CCD4M6/TKBsH8MG3
         uEHHUfWpYYYR4bmrIhqLZ/FjgRdXui6O0g7RbCJHB4w/nEGBWIB0yf0rHfa+igfz9SBc
         OXzoHT1MTV1LDGVWX2sBj7JBvPuOCe98dhTxfHQtmvC9fICHggXNpLOPp0dT1XVFKhbg
         DBqpidkCT/ItxFNo6oyKtje8V1p1KCKxeqbd/ox35AwEKI3kMYejCgRR/dwkybD50NWX
         tQ5A==
X-Gm-Message-State: ACgBeo0IL9iYW33+RUghiaU9RyGacbANz47YhdcujSBhmDY1dOkHDCL1
        9DZBHO2w4urB+dmqtdMfUOGPcg==
X-Google-Smtp-Source: AA6agR6voBk4Dp9imhKd15kk/0Mdk6mTxQE9GoSnji3CbC8YVkAtyDbjVWLUmnBQyVfjzqHyjy9YGg==
X-Received: by 2002:a05:6512:10cb:b0:48c:e0a6:221b with SMTP id k11-20020a05651210cb00b0048ce0a6221bmr3169041lfg.218.1662645866872;
        Thu, 08 Sep 2022 07:04:26 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 18-20020a2eb952000000b00268335eaa8asm3209129ljs.51.2022.09.08.07.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 07:04:25 -0700 (PDT)
Message-ID: <5b3014f9-d827-f1e7-c44c-162c4443f36d@linaro.org>
Date:   Thu, 8 Sep 2022 16:04:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 3/4 v2] dt-bindings: memory: Add jedec,lpddr4 and
 jedec,lpddr5 bindings
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220907232914.243502-1-jwerner@chromium.org>
 <20220907232914.243502-3-jwerner@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907232914.243502-3-jwerner@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 01:29, Julius Werner wrote:
> This patch adds bindings for LPDDR4 and LPDDR5 memory analogous to the
> existing bindings for LPDDR2 and LPDDR3. For now, the new types are only
> needed for topology description, so other properties like timing
> parameters are omitted. They can be added later if needed.
> 
> Signed-off-by: Julius Werner <jwerner@chromium.org>
> ---
>  .../ddr/jedec,lpddr-props.yaml                |  4 ++
>  .../memory-controllers/ddr/jedec,lpddr4.yaml  | 36 ++++++++++++++
>  .../memory-controllers/ddr/jedec,lpddr5.yaml  | 47 +++++++++++++++++++
>  3 files changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
> 
> Changelog:
> 
> - v2
>   - removed minItems
>   - moved `$ref` below `maintainers`
>   - renamed example node from `lpddr4` to `lpddr`
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
> index 4114cfa8de67f1..92ef660888f318 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
> @@ -45,9 +45,13 @@ properties:
>        - 512
>        - 1024
>        - 2048
> +      - 3072
>        - 4096
> +      - 6144
>        - 8192
> +      - 12288
>        - 16384
> +      - 24576
>        - 32768
>  
>    io-width:
> diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
> new file mode 100644
> index 00000000000000..0b2394c032797f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr4.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LPDDR4 SDRAM compliant to JEDEC JESD209-4
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +allOf:
> +  - $ref: "jedec,lpddr-props.yaml#"

No need for quotes.

> +
> +properties:
> +  compatible:
> +    items:
> +      - pattern: "^lpddr4-[0-9a-f]{2},[0-9a-f]{4}$"
> +      - const: jedec,lpddr4
> +
> +required:
> +  - compatible
> +  - density
> +  - io-width
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    lpddr {
> +        compatible = "lpddr4-ff,0100", "jedec,lpddr4";
> +        density = <8192>;
> +        io-width = <16>;
> +        manufacturer-id = <255>;
> +        revision-id = <1 0>;
> +    };
> diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
> new file mode 100644
> index 00000000000000..d86e1e30380e47
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr5.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LPDDR5 SDRAM compliant to JEDEC JESD209-5
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +allOf:
> +  - $ref: "jedec,lpddr-props.yaml#"

No need for quotes.

> +
> +properties:
> +  compatible:
> +    items:
> +      - pattern: "^lpddr5-[0-9a-f]{2},[0-9a-f]{4}$"
> +      - const: jedec,lpddr5
> +
> +  serial-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Serial IDs read from Mode Registers 47 through 54. One byte per uint32
> +      cell (i.e. <MR47 MR48 MR49 MR50 MR51 MR52 MR53 MR54>).
> +    maxItems: 8
> +    items:
> +      minimum: 0
> +      maximum: 255
> +
> +required:
> +  - compatible
> +  - density
> +  - io-width
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    lpddr {
> +        compatible = "lpddr5-01,0200", "jedec,lpddr5";
> +        density = <8192>;
> +        io-width = <8>;
> +        manufacturer-id = <1>;

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +        revision-id = <2 0>;
> +        serial-id = <3 1 0 0 0 0 0 0>;
> +    };


Best regards,
Krzysztof

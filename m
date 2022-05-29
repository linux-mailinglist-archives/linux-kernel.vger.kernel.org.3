Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E336537145
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 16:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiE2OJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 10:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiE2OJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 10:09:09 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0B33D4AA
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 07:09:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id er5so10541599edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 07:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZaM+BiSV1BrvEzxzlRp9jfUPykxbTVypzmZTbnaGAPs=;
        b=wvaRWn4/+BJiy0S1h9v9tqqqfvBnNb63j77H7vTwyu76KnQvrCaDChidIgKmwU+Mpd
         sytm01VKyDCCOOHyLi3woFvAeP13G+XMnJXaGuhk7oYpsrxfZCYnxBCzwQ6qBcxyTCkj
         WjLFhAUBk2RJuXaA5BmEWDr7+NoNDnMsHfL3EAaVg9JH7+V+NiCV/quKhMg6/drIf6FY
         XHfMXY+KT+GwyswUqlYwkNmPdeYospSZikWx9+H/vpvkZL1GQVVoAZCcBr1g8JukVTe6
         ugPsuUQMnFCiQb04HYEeSuqMLqWFXFcd0lfGPCttomaT0A6LZrwFJuKeicFwCusx5lDy
         a94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZaM+BiSV1BrvEzxzlRp9jfUPykxbTVypzmZTbnaGAPs=;
        b=IuZ2truoFcwueFeoK/ltU9btHdFt9gObWeumF89VK9tGCduNmWhW/9KLUPgW6BuXSn
         5nY5AL4AJ18FvillJIPQDoPkWZEkUY1iU5ynnWOJht9wvlOAKPzs9HnPnbR/RE8orSGy
         pINcD4pQm9+0u1Anwf6X55N7+m7RgIJhrJKs+sn9Evhry46OnPW77wVz3z/6KW0cAUjd
         sTzzgRUUxeZ4QOJPOVN78cmJpCZru0rSjTKkJvTYP7KGA5dq9zQaA6rEz+1KLL+7X/GU
         KlHXOFGoLtkdBiqd9V1mM2UPeONzJC7faqmOGPVOgualPJTBfIj69g7Xyi7ej31hZ0v2
         geTw==
X-Gm-Message-State: AOAM531fGKqSdd1qQ7BYKVZs5AFUw0YmvkTlc8MVJRuumV6ZqrDFQCod
        6Ab2sPeSc6D4Sv5Sc/nWq+X9hg==
X-Google-Smtp-Source: ABdhPJyg7TEdtrfo9pOsocT6Pzs1x2LEyPxKwNZrRr2zj2dLepyQzatLUc0TjBU/mgwGAASpiw6pXw==
X-Received: by 2002:a05:6402:1713:b0:42d:cb5e:d799 with SMTP id y19-20020a056402171300b0042dcb5ed799mr3684983edu.34.1653833346210;
        Sun, 29 May 2022 07:09:06 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i2-20020a50d742000000b0042617ba63casm5028584edj.84.2022.05.29.07.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 07:09:05 -0700 (PDT)
Message-ID: <149fbcfe-b62c-63a9-6c38-100d493788c3@linaro.org>
Date:   Sun, 29 May 2022 16:09:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/6] ASoC: tegra: Add binding doc for OPE module
Content-Language: en-US
To:     Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        thierry.reding@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1653647172-2569-1-git-send-email-spujar@nvidia.com>
 <1653647172-2569-2-git-send-email-spujar@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1653647172-2569-2-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2022 12:26, Sameer Pujar wrote:
> This patch adds YAML schema for DT bindings of Output Processing
> Engine (OPE) module. It consists of Parametric Equalizer (PEQ)
> and Multi Band Dynamic Range Compressor (MBDRC) sub blocks and
> binding doc for these blocks are added as well. The OPE will be
> registered as an ASoC component and can be plugged into an audio
> path as per need via ALSA mixer controls. The DT bindings are
> applicable on Tegra210 and later SoCs where OPE module is present.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  .../bindings/sound/nvidia,tegra210-ahub.yaml       |  4 +
>  .../bindings/sound/nvidia,tegra210-mbdrc.yaml      | 47 ++++++++++++
>  .../bindings/sound/nvidia,tegra210-ope.yaml        | 87 ++++++++++++++++++++++
>  .../bindings/sound/nvidia,tegra210-peq.yaml        | 48 ++++++++++++
>  4 files changed, 186 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-peq.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
> index 6df6f85..47b6e71 100644
> --- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
> @@ -110,6 +110,10 @@ patternProperties:
>      type: object
>      $ref: nvidia,tegra186-asrc.yaml#
>  
> +  '^processing-engine@[0-9a-f]+$':
> +    type: object
> +    $ref: nvidia,tegra210-ope.yaml#
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml
> new file mode 100644
> index 0000000..0d55328
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/nvidia,tegra210-mbdrc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tegra210 MBDRC Device Tree Bindings

Previous comments - s/Device Tree Bindings//
 -  still applies. Please do not ignore it.

> +
> +description:
> +  The Multi Band Dynamic Range Compressor (MBDRC) is part of Output
> +  Processing Engine (OPE) which interfaces with Audio Hub (AHUB) via
> +  Audio Client Interface (ACIF). MBDRC can be used as a traditional
> +  single full band or a dual band or a multi band dynamic processor.
> +
> +maintainers:
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Mohan Kumar <mkumard@nvidia.com>
> +  - Sameer Pujar <spujar@nvidia.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: nvidia,tegra210-mbdrc
> +      - items:
> +          - enum:
> +              - nvidia,tegra234-mbdrc
> +              - nvidia,tegra194-mbdrc
> +              - nvidia,tegra186-mbdrc
> +          - const: nvidia,tegra210-mbdrc
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dynamic-range-compressor@702d8200 {
> +        compatible = "nvidia,tegra210-mbdrc";
> +        reg = <0x702d8200 0x200>;
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml
> new file mode 100644
> index 0000000..7cbc756
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/nvidia,tegra210-ope.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tegra210 OPE Device Tree Bindings

Ditto.

> +
> +description:
> +  The Output Processing Engine (OPE) is one of the AHUB client. It has
> +  PEQ (Parametric Equalizer) and MBDRC (Multi Band Dynamic Range Compressor)
> +  sub blocks for data processing.
> +
> +maintainers:
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Mohan Kumar <mkumard@nvidia.com>
> +  - Sameer Pujar <spujar@nvidia.com>
> +
> +allOf:
> +  - $ref: name-prefix.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: nvidia,tegra210-ope
> +      - items:
> +          - enum:
> +              - nvidia,tegra234-ope
> +              - nvidia,tegra194-ope
> +              - nvidia,tegra186-ope
> +          - const: nvidia,tegra210-ope
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges: true
> +
> +  sound-name-prefix:
> +    pattern: "^OPE[1-9]$"
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    properties:
> +      port@0:
> +        $ref: audio-graph-port.yaml#
> +        unevaluatedProperties: false
> +        description:
> +          OPE ACIF (Audio Client Interface) input port. This is connected
> +          to corresponding ACIF output port on AHUB (Audio Hub).
> +
> +      port@1:
> +        $ref: audio-graph-port.yaml#
> +        unevaluatedProperties: false
> +        description:
> +          OPE ACIF output port. This is connected to corresponding ACIF
> +          input port on AHUB.
> +
> +patternProperties:
> +  '^equalizer@[0-9a-f]+$':
> +    type: object
> +    $ref: nvidia,tegra210-peq.yaml#
> +
> +  '^dynamic-range-compressor@[0-9a-f]+$':
> +    type: object
> +    $ref: nvidia,tegra210-mbdrc.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    processing-engine@702d8000 {
> +        compatible = "nvidia,tegra210-ope";
> +        reg = <0x702d8000 0x100>;
> +        sound-name-prefix = "OPE1";
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-peq.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-peq.yaml
> new file mode 100644
> index 0000000..fea4c63
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-peq.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/nvidia,tegra210-peq.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tegra210 PEQ Device Tree Bindings

Ditto

> +
> +description:
> +  The Parametric Equalizer (PEQ) is a cascade of biquad filters with
> +  each filter tuned based on certain parameters. It can be used to
> +  equalize the irregularities in the speaker frequency response.
> +  PEQ sits inside Output Processing Engine (OPE) which interfaces
> +  with Audio Hub (AHUB) via Audio Client Interface (ACIF).
> +
> +maintainers:
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Mohan Kumar <mkumard@nvidia.com>
> +  - Sameer Pujar <spujar@nvidia.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: nvidia,tegra210-peq
> +      - items:
> +          - enum:
> +              - nvidia,tegra234-peq
> +              - nvidia,tegra194-peq
> +              - nvidia,tegra186-peq
> +          - const: nvidia,tegra210-peq
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    equalizer@702d8100 {
> +        compatible = "nvidia,tegra210-peq";
> +        reg = <0x702d8100 0x100>;
> +    };
> +
> +...


Best regards,
Krzysztof

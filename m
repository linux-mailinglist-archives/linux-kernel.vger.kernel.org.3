Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F82B52D1A7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 13:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbiESLlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 07:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237521AbiESLlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 07:41:04 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDED5C361
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 04:40:58 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id o22so5884294ljp.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 04:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5lQ664e0M0SMZONja0fWEw59Zei2hDvnJr+VN8QUgpc=;
        b=VWqIRWV6COaXycYLHtWQxHT3HvJyW6RJYZRd7UAAcrZPAKs0EGjXkrcB1hRiZ/Z8qF
         2bpRDKC1jDqKDpSv2LIW9SlifKSkj4YNnx2y12YEGY+7rHKWjZUpsRHVAO865CQ3jToK
         5/zDjzhzP6rUv2mhlYL8ukcHuOfiB/A4U026+i0urbhSP2NuTVLjj28X41kV4kUwTV2l
         bdzNDErcWJ611kde2xti5D7HHIZH3uywfRDmkLAvrkxUZ3pHvC0ehfXqaA/gvWNqkgA9
         cUFw+80c7x+FHL9oj1+INBpfPmKERLgX21/o/OSMtcsVzo7GUNs9NzpHBP3jMKuwfobG
         oiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5lQ664e0M0SMZONja0fWEw59Zei2hDvnJr+VN8QUgpc=;
        b=O55+rCoP3TFg0v+84LA4rMPU4LYHq4Cg7iCRy5RisE3PfB4bmNj4SqtgKajjfYVFM1
         c6TVkAGXh3t5ta1M72Ijpuw3CzkgJDzPZSiZa5KIsryE+0+AHpOmckUIHTryrgByxAYf
         x2bH3Whu0PSZL03Mm+QWZ91aW0+XczdPGIEbr8OhS2Lu7ugFgnWDF5YzP2SJlxmOOYid
         +ovRtS3kZFT8STFM/CmeD/w5qXnPFiQcQ3iWywwLWF7pCcrYCNn8M7rT7EWeqq0tUNPa
         MyPdWPMCwIP4FFYUPKOiaegl6jAsB3UJI2GNe+NeOYYb2Y6fQ0XOSQ+acdlEq9SrmKbI
         Aw5Q==
X-Gm-Message-State: AOAM532x+mF1Y5CdwF5s5ACItGXugLAIUsgdDJsCWZd5No9nGOPy/Ctm
        RHrvGBBHmeA62KKC/7IUpICzkg==
X-Google-Smtp-Source: ABdhPJxKaqfdOURlZcinP+UDYwcSbGH7rfnbL8xCJuEbD2HsjaD1NduLqefMujcrRPJ5ttLbCbd6fQ==
X-Received: by 2002:a2e:320c:0:b0:253:d704:188b with SMTP id y12-20020a2e320c000000b00253d704188bmr1126303ljy.527.1652960456384;
        Thu, 19 May 2022 04:40:56 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f11-20020ac2532b000000b00477cae4880fsm141038lfh.260.2022.05.19.04.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 04:40:55 -0700 (PDT)
Message-ID: <049173a1-0fa6-510b-9169-ebe869b8a3b3@linaro.org>
Date:   Thu, 19 May 2022 13:40:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/6] ASoC: tegra: Add binding doc for OPE module
Content-Language: en-US
To:     Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        thierry.reding@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1652895372-29885-1-git-send-email-spujar@nvidia.com>
 <1652895372-29885-2-git-send-email-spujar@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1652895372-29885-2-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2022 19:36, Sameer Pujar wrote:
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
>  .../bindings/sound/nvidia,tegra210-mbdrc.yaml      | 51 ++++++++++++
>  .../bindings/sound/nvidia,tegra210-ope.yaml        | 91 ++++++++++++++++++++++
>  .../bindings/sound/nvidia,tegra210-peq.yaml        | 52 +++++++++++++
>  4 files changed, 198 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-peq.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
> index 6df6f85..1fb93d9 100644
> --- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
> @@ -110,6 +110,10 @@ patternProperties:
>      type: object
>      $ref: nvidia,tegra186-asrc.yaml#
>  
> +  '^ope@[0-9a-f]+$':
> +    type: object
> +    $ref: nvidia,tegra210-ope.yaml#
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml
> new file mode 100644
> index 00000000..199712ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/nvidia,tegra210-mbdrc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tegra210 MBDRC Device Tree Bindings

s/Device Tree Bindings//

and then you have enough space to de-acronym this MBDRC.

> +
> +description: |
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
> +  $nodename:
> +    pattern: "^mbdrc@[0-9a-f]*$"

Why? We enforce only generic names in shared schemas and this is neither
shared schema nor is it generic name.

> +
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
> +

No need for space

> +    mbdrc@702d8200 {

Generic node name.

> +        compatible = "nvidia,tegra210-mbdrc";
> +        reg = <0x702d8200 0x200>;
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml
> new file mode 100644
> index 00000000..92488fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/nvidia,tegra210-ope.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tegra210 OPE Device Tree Bindings

Same comment.

> +
> +description: |
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
> +  $nodename:
> +    pattern: "^ope@[0-9a-f]*$"

Same comment.

> +
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
> +        description: |

No need for |

> +          OPE ACIF (Audio Client Interface) input port. This is connected
> +          to corresponding ACIF output port on AHUB (Audio Hub).
> +
> +      port@1:
> +        $ref: audio-graph-port.yaml#
> +        unevaluatedProperties: false
> +        description: |

Ditto

> +          OPE ACIF output port. This is connected to corresponding ACIF
> +          input port on AHUB.
> +
> +patternProperties:
> +  '^peq@[0-9a-f]+$':
> +    type: object
> +    $ref: nvidia,tegra210-peq.yaml#
> +
> +  '^mbdrc@[0-9a-f]+$':
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
> +

Similar to other patch.

> +    ope@702d8000 {

I would suggest generic node name, if it is possible.

> +        compatible = "nvidia,tegra210-ope";
> +        reg = <0x702d8000 0x100>;
> +        sound-name-prefix = "OPE1";
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-peq.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-peq.yaml
> new file mode 100644
> index 00000000..0f78746
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-peq.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/nvidia,tegra210-peq.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tegra210 PEQ Device Tree Bindings

Ditto

> +
> +description: |
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
> +  $nodename:
> +    pattern: "^peq@[0-9a-f]*$"

Ditto

> +
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
> +

Ditto

> +    peq@702d8100 {

Generic node name, so this is "equalizer", I guess?

> +        compatible = "nvidia,tegra210-peq";
> +        reg = <0x702d8100 0x100>;
> +    };
> +
> +...


Best regards,
Krzysztof

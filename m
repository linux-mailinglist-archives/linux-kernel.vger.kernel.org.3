Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FAD50EC08
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbiDYW2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343638AbiDYV5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:57:47 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9448A4738E;
        Mon, 25 Apr 2022 14:54:42 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-e2fa360f6dso17553895fac.2;
        Mon, 25 Apr 2022 14:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A7tE+6zDw7UBglMyaIog0/W20yMhf3kXY1mK8DU9uDc=;
        b=fM86YvYouOKAIni8+bkcJLxro5/BnN4cSm/N0VI8UBgch3I3JTZenM63BTkXwtBMbf
         zrbs+Y/qPCrZlo1X22wiLUlCwbhdeQzAnNZ4MSLwiE7hspMX3SV/EQRREqqzjo31PREp
         L4vqjjEyTrAV0KMKsvzKVQYLY8uJEMGMKYkoGbukTZj99mkLnfgtxRtBmSuei4suEBiR
         EWRl5TFaSieFgJjzrF1lWJ80yLyKin6Ejo3FU8kkdo/XbRpmh2ZjUL5FBr+CAL+0ScQa
         U6cBiFz+LEqBpF83uMYnfFoTNM2tao5r7DajyRkLf4Mmn4D+6ThZFJyKadUhNRS5xNiU
         sZVQ==
X-Gm-Message-State: AOAM5327KvwUYrdBod2xQClaNs697Q+Dg78ItI91y7p/80b95f8Y7MqJ
        zENd7Le+P9XWrFxa2aZ2hFd91kqOaA==
X-Google-Smtp-Source: ABdhPJxaQxuDPuVlJ8cXUfiS3N7M3QjLUu7/aUq3l5G0iHlHGa5j3ys7oioMHqUuF7DaFWc+AU+kiA==
X-Received: by 2002:a05:6870:b50a:b0:e9:2534:1c0a with SMTP id v10-20020a056870b50a00b000e925341c0amr4125963oap.48.1650923681742;
        Mon, 25 Apr 2022 14:54:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v5-20020a056870954500b000e686d13877sm156130oal.17.2022.04.25.14.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 14:54:41 -0700 (PDT)
Received: (nullmailer pid 360051 invoked by uid 1000);
        Mon, 25 Apr 2022 21:54:40 -0000
Date:   Mon, 25 Apr 2022 16:54:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        smangipudi@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        warthog618@gmail.com, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 04/10] dt-bindings: Add HTE bindings
Message-ID: <YmcYoPg1ucPUpgmM@robh.at.kernel.org>
References: <20220422205221.952-1-dipenp@nvidia.com>
 <20220422205221.952-5-dipenp@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422205221.952-5-dipenp@nvidia.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 01:52:15PM -0700, Dipen Patel wrote:
> Introduces HTE devicetree binding details for the HTE subsystem. It
> includes examples for the consumers, binding details for the providers
> and specific binding details for the Tegra194 based HTE providers.
> 
> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v2:
> - Replace hte with hardware-timestamp for property names
> - Renamed file
> - Removed example from the common dt binding file.
> 
> Changes in v3:
> - Addressed grammatical errors.
> - Removed double plural from the respective properties.
> - Added dual license.
> - Prefixed "nvidia" in nvidia specific properties.
> 
> Changes in v4:
> - Corrected make dt_binding_check error.
> 
> Changes in v5:
> - Addressed review comments.
> 
> Changes in v6:
> - Removed hardware prefix from the property as per review comments.
> 
>  .../hte/hardware-timestamps-common.yaml       | 29 ++++++
>  .../devicetree/bindings/hte/hte-consumer.yaml | 39 ++++++++
>  .../bindings/hte/nvidia,tegra194-hte.yaml     | 88 +++++++++++++++++++
>  3 files changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
>  create mode 100644 Documentation/devicetree/bindings/hte/hte-consumer.yaml
>  create mode 100644 Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml

'hte' is not obvious what it is, so 'timestamp' for the directory name.

> 
> diff --git a/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml b/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
> new file mode 100644
> index 000000000000..3e26de605f08
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hte/hardware-timestamps-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hardware timestamp providers
> +
> +maintainers:
> +  - Dipen Patel <dipenp@nvidia.com>
> +
> +description:
> +  Some devices/SoCs have hardware time stamping engines which can use hardware
> +  means to timestamp entity in realtime. The entity could be anything from
> +  GPIOs, IRQs, Bus and so on. The hardware timestamp engine (HTE) present

Define HTE at the 1st use, not the 2nd.

> +  itself as a provider with the bindings described in this document.
> +
> +properties:
> +  $nodename:
> +    pattern: "^timestamp(@.*|-[0-9a-f])?$"
> +
> +  "#timestamp-cells":
> +    description:
> +      Number of cells in a HTE specifier.
> +
> +required:
> +  - "#timestamp-cells"
> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/hte/hte-consumer.yaml b/Documentation/devicetree/bindings/hte/hte-consumer.yaml
> new file mode 100644
> index 000000000000..68d764ac040a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hte/hte-consumer.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hte/hte-consumer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HTE Consumer Device Tree Bindings
> +
> +maintainers:
> +  - Dipen Patel <dipenp@nvidia.com>
> +
> +select: true
> +
> +properties:
> +  timestamps:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      The list of HTE provider phandle. The first cell must represent the
> +      provider phandle followed by the line identifiers. The meaning of the
> +      line identifier and exact number of arguments must be specified in the
> +      HTE provider device tree binding document.
> +
> +  timestamp-names:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description:
> +      An optional string property to label each line specifier present in the
> +      timestamp property.
> +
> +dependencies:
> +  timestamp-names: [ timestamps ]
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    hte_tegra_consumer {
> +              timestamps = <&tegra_hte_aon 0x9>, <&tegra_hte_lic 0x19>;
> +              timestamp-names = "hte-gpio", "hte-i2c";
> +    };
> diff --git a/Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
> new file mode 100644
> index 000000000000..69e8402d95e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hte/nvidia,tegra194-hte.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tegra194 on chip generic hardware timestamping engine (HTE)
> +
> +maintainers:
> +  - Dipen Patel <dipenp@nvidia.com>
> +
> +description:
> +  Tegra SoC has two instances of generic hardware timestamping engines (GTE)
> +  known as GTE GPIO and GTE IRQ, which can monitor subset of GPIO and on chip
> +  IRQ lines for the state change respectively, upon detection it will record
> +  timestamp (taken from system counter) in its internal hardware FIFO. It has
> +  a bitmap array arranged in 32bit slices where each bit represent signal/line
> +  to enable or disable for the hardware timestamping. The GTE GPIO monitors
> +  GPIO lines from the AON (always on) GPIO controller.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nvidia,tegra194-gte-aon
> +      - nvidia,tegra194-gte-lic
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  nvidia,int-threshold:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      HTE device generates its interrupt based on this u32 FIFO threshold
> +      value. The recommended value is 1.
> +    minimum: 1
> +    maximum: 256
> +
> +  nvidia,slices:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      HTE lines are arranged in 32 bit slice where each bit represents different
> +      line/signal that it can enable/configure for the timestamp. It is u32
> +      property and depends on the HTE instance in the chip. The value 3 is for
> +      GPIO GTE and 11 for IRQ GTE.
> +    enum: [3, 11]
> +
> +  '#timestamp-cells':
> +    description:
> +      This represents number of line id arguments as specified by the
> +      consumers. For the GTE IRQ, this is IRQ number as mentioned in the
> +      SoC technical reference manual. For the GTE GPIO, its value is same as
> +      mentioned in the nvidia GPIO device tree binding document.
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - nvidia,slices
> +  - "#timestamp-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    tegra_hte_aon: timestamp@c1e0000 {
> +              compatible = "nvidia,tegra194-gte-aon";
> +              reg = <0xc1e0000 0x10000>;
> +              interrupts = <0 13 0x4>;
> +              nvidia,int-threshold = <1>;
> +              nvidia,slices = <3>;
> +              #timestamp-cells = <1>;
> +    };
> +
> +  - |
> +    tegra_hte_lic: timestamp@3aa0000 {
> +              compatible = "nvidia,tegra194-gte-lic";
> +              reg = <0x3aa0000 0x10000>;
> +              interrupts = <0 11 0x4>;
> +              nvidia,int-threshold = <1>;
> +              nvidia,slices = <11>;
> +              #timestamp-cells = <1>;
> +    };
> +
> +...
> -- 
> 2.17.1
> 
> 

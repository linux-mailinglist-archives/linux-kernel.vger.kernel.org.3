Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D044EB6B4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240288AbiC2X1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239989AbiC2X1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:27:39 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E189C186166;
        Tue, 29 Mar 2022 16:25:55 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id 12so20527358oix.12;
        Tue, 29 Mar 2022 16:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i3uM0pHbtDDVFGxWD9G96SIrY94otn0Eu2ug6AvRCzM=;
        b=ZaXNSAjBFeZqpmkS941OqWEobXLwIE2quRifxYbv/bZoOtw5DnAVBSpsePz+W/01KL
         08mLgXHsmTKTjEv94WtbPtHD34rkaf3mi7CKEa+vALnxfuUPwMwXsiW1hfUJdhwyA+Qe
         fwOa+JqVb2MRFoZRWdnLCdcAi6cSMiaOmDeTP6cMNwbSBmUVBaACVj8PLSqHrwi1okUX
         rVQZ/vpg6eU8pgSj3Fzj8opvvf7PAEt8Z23YehfGkxM+ul6DE+bvVdO3vQqFnvUXUJj4
         2Hayg5YgCDHID5Cxt4AtUMc8LAJCEXG7Jkg/lNBGQyE0FVDRGMJsgsxWsHWyNfmBuvg3
         mIUg==
X-Gm-Message-State: AOAM531SR/xmL6DUfiyDwd5uQiGi3SLqMh4Kzkyn2mKeicCfV6QMq9R8
        5s0q8xxmY5/RunBXALoQ7Q==
X-Google-Smtp-Source: ABdhPJzTFEmfAeacXqDkEiRReji+ZZWVsiht7GJMbos8sjEIydcV+4YyPcEw4tkbeIJVLkAGcs2vJw==
X-Received: by 2002:a05:6808:13ca:b0:2d0:6e82:6983 with SMTP id d10-20020a05680813ca00b002d06e826983mr715308oiw.5.1648596355043;
        Tue, 29 Mar 2022 16:25:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m16-20020a9d4c90000000b005cb214bef81sm9735902otf.43.2022.03.29.16.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:25:54 -0700 (PDT)
Received: (nullmailer pid 1551617 invoked by uid 1000);
        Tue, 29 Mar 2022 23:25:53 -0000
Date:   Tue, 29 Mar 2022 18:25:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        smangipudi@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        warthog618@gmail.com, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 04/11] dt-bindings: Add HTE bindings
Message-ID: <YkOVgRBtXX0k9zr1@robh.at.kernel.org>
References: <20220329054521.14420-1-dipenp@nvidia.com>
 <20220329054521.14420-5-dipenp@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329054521.14420-5-dipenp@nvidia.com>
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

On Mon, Mar 28, 2022 at 10:45:14PM -0700, Dipen Patel wrote:
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
>  .../hte/hardware-timestamps-common.yaml       | 29 +++++++
>  .../devicetree/bindings/hte/hte-consumer.yaml | 43 ++++++++++
>  .../bindings/hte/nvidia,tegra194-hte.yaml     | 82 +++++++++++++++++++
>  3 files changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
>  create mode 100644 Documentation/devicetree/bindings/hte/hte-consumer.yaml
>  create mode 100644 Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml b/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
> new file mode 100644
> index 000000000000..e8a69ceccd56
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
> +  itself as a provider with the bindings described in this document.
> +
> +properties:
> +  $nodename:
> +    pattern: "^hardware-timestamp(@.*|-[0-9a-f])?$"
> +
> +  "#hardware-timestamp-cells":
> +    description:
> +      Number of cells in a HTE specifier.
> +
> +required:
> +  - "#hardware-timestamp-cells"
> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/hte/hte-consumer.yaml b/Documentation/devicetree/bindings/hte/hte-consumer.yaml
> new file mode 100644
> index 000000000000..be69f63aa8c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hte/hte-consumer.yaml
> @@ -0,0 +1,43 @@
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
> +description:
> +  HTE properties should be named "hardware-timestamps". The exact meaning of
> +  each hardware-timestamps property must be documented in the device tree

The meaning of the cells needs to be documented. You are documenting the 
meaning of 'hardware-timestamps' here.

> +  binding for each device. An optional property "hardware-timestamp-names" may
> +  contain a list of strings to label each of the HTE devices listed in the
> +  "hardware-timestamps" property.
> +
> +properties:
> +  hardware-timestamps:

I'm wondering if we should just drop 'hardware'. What other kind of 
timestamps are we going to have in DT? software-timestamps? No.


> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      The list of HTE provider phandle. The provider must document the number
> +      of cell that must be passed in this property along with phandle.
> +
> +  hardware-timestamp-names:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description:
> +      An optional string property.
> +
> +dependencies:
> +  hardware-timestamp-names: [ hardware-timestamps ]
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    hte_irq_consumer {
> +              hardware-timestamps = <&tegra_hte_lic 0x19>;
> +              hardware-timestamp-names = "hte-irq";
> +    };
> diff --git a/Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
> new file mode 100644
> index 000000000000..ce6f1313f52d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
> @@ -0,0 +1,82 @@
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
> +  Tegra194 SoC has multiple generic hardware timestamping engines (GTE) which
> +  can monitor subset of GPIO and on chip IRQ lines for the state change, upon
> +  detection it will record timestamp (taken from system counter) in its
> +  internal hardware FIFO. It has a bitmap array arranged in 32bit slices where
> +  each bit represent signal/line to enable or disable for the hardware
> +  timestamping.
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
> +  '#hardware-timestamp-cells':
> +    const: 1

Need to describe what the cell represents.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - nvidia,slices
> +  - "#hardware-timestamp-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    tegra_hte_aon: hardware-timestamp@c1e0000 {
> +              compatible = "nvidia,tegra194-gte-aon";
> +              reg = <0xc1e0000 0x10000>;
> +              interrupts = <0 13 0x4>;
> +              nvidia,int-threshold = <1>;
> +              nvidia,slices = <3>;
> +              #hardware-timestamp-cells = <1>;
> +    };
> +
> +  - |
> +    tegra_hte_lic: hardware-timestamp@3aa0000 {
> +              compatible = "nvidia,tegra194-gte-lic";
> +              reg = <0x3aa0000 0x10000>;
> +              interrupts = <0 11 0x4>;
> +              nvidia,int-threshold = <1>;
> +              nvidia,slices = <11>;
> +              #hardware-timestamp-cells = <1>;
> +    };
> +
> +...
> -- 
> 2.17.1
> 
> 

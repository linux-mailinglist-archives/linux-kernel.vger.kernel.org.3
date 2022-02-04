Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8514AA46D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378212AbiBDXhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:37:06 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:33348 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiBDXhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:37:03 -0500
Received: by mail-oi1-f174.google.com with SMTP id x193so10462793oix.0;
        Fri, 04 Feb 2022 15:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dZ4giCvADmPnDI6RyshIy9Yaq4H2NCsxVmH5tlfAm54=;
        b=2eaWUY7DUJiA2MIVZMkRMnCfl371iXsMb7xkMlFwjsiHrALZZwmYPnwZfYDgQOYX+0
         3syZXuLd4MexMWxtGPzDPs9bWWJNVMry1GMwXlG2BYMxE8PKG2X9E0NW9ynZ7wTFddO3
         sWlfVnVzrRFew9vd1sKuiza9BNgTB4uwsufcdBtVvif9PAQpJBO7wcN/OxbKe+OLZImZ
         o+2c9sQfUYy4leap1oscWCsWdEwuwU0eg+DQ3iFKBnwZSffec33dIyj4sXQI7Rk6if9B
         W4vQeLpoUtf5d52h5quDctfXimOLh4ijhKlKPw3Gl2HTXFUClhMS9Un4dc9FUavEPlzP
         LpPg==
X-Gm-Message-State: AOAM532dvRfD072PW4UawdO4SA1Gaqntf4ArEI3s8PFwFInTk6obxoH4
        pbyIy8GXnkAQ5/ukvV4hOg==
X-Google-Smtp-Source: ABdhPJxg123KDgvEdmqZE2xZwnTt7BWrZGgzK8ifbHWV3OLex+k2YjpetEnJ15EfEWRnn92Dkbf3GA==
X-Received: by 2002:a05:6808:1598:: with SMTP id t24mr2419529oiw.50.1644017823172;
        Fri, 04 Feb 2022 15:37:03 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d7sm1230028otf.66.2022.02.04.15.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:37:02 -0800 (PST)
Received: (nullmailer pid 3395904 invoked by uid 1000);
        Fri, 04 Feb 2022 23:37:01 -0000
Date:   Fri, 4 Feb 2022 17:37:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     smangipudi@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        warthog618@gmail.com, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 04/11] dt-bindings: Add HTE bindings
Message-ID: <Yf24nR9drkBAnYA5@robh.at.kernel.org>
References: <20220201222630.21246-1-dipenp@nvidia.com>
 <20220201222630.21246-5-dipenp@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201222630.21246-5-dipenp@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 02:26:23PM -0800, Dipen Patel wrote:
> Introduces HTE devicetree binding details for the HTE subsystem. It
> includes examples for the consumers, binding details for the providers
> and specific binding details for the Tegra194 based HTE providers.
> 
> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../hte/hardware-timestamps-common.yaml       | 29 +++++++
>  .../devicetree/bindings/hte/hte-consumer.yaml | 44 ++++++++++
>  .../bindings/hte/nvidia,tegra194-hte.yaml     | 82 +++++++++++++++++++
>  3 files changed, 155 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
>  create mode 100644 Documentation/devicetree/bindings/hte/hte-consumer.yaml
>  create mode 100644 Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml b/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
> new file mode 100644
> index 000000000000..ee6f94890695
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
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
> +description: |
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
> index 000000000000..bb1232b31455
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hte/hte-consumer.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: GPL-2.0

dual license

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hte/hte-consumer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HTE Consumer Device Tree Bindings
> +
> +maintainers:
> +  - Dipen Patel <dipenp@nvidia.com>

select: true

Or this is never applied.

> +
> +description: |
> +  HTE properties should be named "hardware-timestamps". The exact meaning of
> +  each hardware-timestamps property must be documented in the device tree
> +  binding for each device. An optional property "hardware-timestamp-names" may
> +  contain a list of strings to label each of the HTE devices listed in the
> +  "hardware-timestamps" property.
> +
> +properties:
> +  hardware-timestamps:
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
> +required:
> +  - hardware-timestamps

And drop this or it will then fail everywhere.

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
> index 000000000000..c7d2acdb862e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license.

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
> +description: |

Don't need '|' if no formatting.

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

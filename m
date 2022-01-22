Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8CB4968F3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 01:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiAVA5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 19:57:11 -0500
Received: from mail-oo1-f41.google.com ([209.85.161.41]:35655 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiAVA5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 19:57:03 -0500
Received: by mail-oo1-f41.google.com with SMTP id p4-20020a4a8e84000000b002e598a51d60so508022ook.2;
        Fri, 21 Jan 2022 16:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L8s5mBf0UpHtEY/qnha+jJ91j6Jh+IbHCl/z4sZacfE=;
        b=hcTBlz6j2XwvR23/hdn8m3atHq4bb5X1fwJJR+fJ0g/YNqjBUonhhCAoEcqMOi10hR
         DvkKocF/Drw+ZUl8hx5Qty3n3Cm/irYU1j0yLXFuynW5c3oNhSsMUblWpUrEHnQxrvH3
         0sKk9ivyF5elryU57+f5C5G40L6cG8jl/e1dvA6EELu3obZStKBtl8NmY3/RZdKTBBay
         2POJ9Z/TWRiwRd1sYduxhVVr9DzAI3dLu7PFEUJwKXpLfMRAjBoAF0iXX4nw4bVvGp7J
         m0yY3yhOH823dloISYdG1UpkiyPYdi+vP7UzmxXcaq9uQlv4bHIN6SgMY2MD2Z2TwOSP
         MBnQ==
X-Gm-Message-State: AOAM5301n9Q1iuj0cKEM3rIrWPbeBooDNqh/ya+GbHJYCHE3B+JZk+0h
        HXTvjl4AxK1vFrsUIEV+3A==
X-Google-Smtp-Source: ABdhPJwoE6llKf4bLoRmQCX2d407a5SUn2SLcLtJmjJSCrEoydcDf0xzWqmXAlbXvD+PJuNn4xBZJA==
X-Received: by 2002:a4a:c57:: with SMTP id n23mr4154768ooe.55.1642813023151;
        Fri, 21 Jan 2022 16:57:03 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q25sm1916041oiw.27.2022.01.21.16.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 16:57:02 -0800 (PST)
Received: (nullmailer pid 1955852 invoked by uid 1000);
        Sat, 22 Jan 2022 00:57:01 -0000
Date:   Fri, 21 Jan 2022 18:57:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH V2 2/3] dt-bindings: spi: Convert spi-mt65xx to
 json-schema
Message-ID: <YetWXSzugRwKb+xA@robh.at.kernel.org>
References: <20220112103609.17421-1-leilk.liu@mediatek.com>
 <20220112103609.17421-3-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112103609.17421-3-leilk.liu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 06:36:08PM +0800, Leilk Liu wrote:
> Convert Mediatek ARM SOC's SPI Master controller binding
> to json-schema format.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  .../bindings/spi/mediatek,spi-mt65xx.yaml     | 99 +++++++++++++++++++
>  .../devicetree/bindings/spi/spi-mt65xx.txt    | 68 -------------
>  2 files changed, 99 insertions(+), 68 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> new file mode 100644
> index 000000000000..71f0cf6e5d70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/mediatek,spi-mt65xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SPI Bus controller for MediaTek ARM SoCs
> +
> +maintainers:
> +  - Leilk Liu <leilk.liu@mediatek.com>
> +
> +allOf:
> +  - $ref: /spi/spi-controller.yaml#

/schemas/spi/spi-controller.yaml#

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - mediatek,mt7629-spi
> +          - const: mediatek,mt7622-spi
> +      - items:
> +          - enum:
> +              - mediatek,mt8516-spi
> +          - const: mediatek,mt2712-spi
> +      - items:
> +          - enum:
> +              - mediatek,mt6779-spi
> +              - mediatek,mt8192-spi
> +              - mediatek,mt8195-spi
> +          - const: mediatek,mt6765-spi

> +      - const: mediatek,mt2701-spi
> +      - const: mediatek,mt2712-spi
> +      - const: mediatek,mt6589-spi
> +      - const: mediatek,mt6765-spi
> +      - const: mediatek,mt6893-spi
> +      - const: mediatek,mt7622-spi
> +      - const: mediatek,mt8135-spi
> +      - const: mediatek,mt8173-spi
> +      - const: mediatek,mt8183-spi

All these can be 1 enum.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: clock used for the parent clock
> +      - description: clock used for the muxes clock
> +      - description: clock used for the clock gate
> +
> +  clock-names:
> +    items:
> +      - const: parent-clk
> +      - const: sel-clk
> +      - const: spi-clk
> +
> +  mediatek,pad-select:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    maxItems: 4
> +    items:
> +      enum: [0, 1, 2, 3]
> +    description:
> +      specify which pins group(ck/mi/mo/cs) spi controller used.
> +      This is an array.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8173-clk.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi@1100a000 {
> +      compatible = "mediatek,mt8173-spi";
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      reg = <0x1100a000 0x1000>;
> +      interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
> +      clocks = <&topckgen CLK_TOP_SYSPLL3_D2>,
> +               <&topckgen CLK_TOP_SPI_SEL>,
> +               <&pericfg CLK_PERI_SPI0>;
> +      clock-names = "parent-clk", "sel-clk", "spi-clk";
> +      cs-gpios = <&pio 105 GPIO_ACTIVE_LOW>, <&pio 72 GPIO_ACTIVE_LOW>;
> +      mediatek,pad-select = <1>, <0>;
> +    };

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F744968EA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 01:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiAVAxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 19:53:15 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:35675 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiAVAxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 19:53:13 -0500
Received: by mail-ot1-f41.google.com with SMTP id n22-20020a9d2016000000b0059bd79f7777so13440664ota.2;
        Fri, 21 Jan 2022 16:53:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NwEsLoY/zSy6+8ww4zg4hbAmBeGUwDI4bJpwjmotxhw=;
        b=Dtan1CUsWJkMAMqArFn70vhAn0T5iXrSLZRc4aCUoZIhGIIbsa/K4P8kxNKeisZNLO
         1SGzR/R/vqQk9G3TnJgT++G1Y37jhpwBaPc7XxQCwdBDQJoEjJzRxTiuLirMzd+wT8ZQ
         XW8oStnN3nGOHoqfQt2yO/1ew4yZajCJ4RAaD1V2oFH3uMzWkWANh637DqPJuoptrPzn
         LyUF5VR+1X5X+LawK/f8R3UVYWG7AlP1E3IECVHVMopSERWWbbG7ns20dPCe8v9u9WUx
         1jc2DmIc9W31OU0F/E+/+oWHAAKUKyZqMAafZE3ucQ8tXmaw4AlIkPVQORdh8fzUYJZt
         +OlQ==
X-Gm-Message-State: AOAM531z0L+S4K9QuTBw72UhNid1Tns+D9HAiYlYjXku1zLEG3UpGQKs
        8xL21DgoA/S31wJ4ab16OA==
X-Google-Smtp-Source: ABdhPJxtvDyzMhYHyXQ+iSpTb2lRwqvIuBsflwOHWmHmO5EdG97wJnvBRPsDourd04+3nSBlNcks0Q==
X-Received: by 2002:a9d:7d11:: with SMTP id v17mr4619824otn.34.1642812792929;
        Fri, 21 Jan 2022 16:53:12 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k17sm1771351otk.80.2022.01.21.16.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 16:53:12 -0800 (PST)
Received: (nullmailer pid 1949948 invoked by uid 1000);
        Sat, 22 Jan 2022 00:53:11 -0000
Date:   Fri, 21 Jan 2022 18:53:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH V2 1/3] dt-bindings: spi: Convert spi-slave-mt27xx to
 json-schema
Message-ID: <YetVd7IR7FDt+nz3@robh.at.kernel.org>
References: <20220112103609.17421-1-leilk.liu@mediatek.com>
 <20220112103609.17421-2-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112103609.17421-2-leilk.liu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 06:36:07PM +0800, Leilk Liu wrote:
> Convert Mediatek ARM SOC's SPI Slave controller binding
> to json-schema format.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  .../spi/mediatek,spi-slave-mt27xx.yaml        | 73 +++++++++++++++++++
>  .../bindings/spi/spi-slave-mt27xx.txt         | 33 ---------
>  2 files changed, 73 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.yaml
> new file mode 100644
> index 000000000000..3364fff08cca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/mediatek,spi-slave-mt27xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SPI Slave controller for MediaTek ARM SoCs
> +
> +maintainers:
> +  - Leilk Liu <leilk.liu@mediatek.com>
> +
> +allOf:
> +  - $ref: /spi/spi-controller.yaml#
> +
> +properties:
> +  compatible:

> +    oneOf:
> +      - items:
> +          - enum:
> +              - mediatek,mt2712-spi-slave
> +      - items:
> +          - enum:
> +              - mediatek,mt8195-spi-slave

Just:

       enum:
         - mediatek,mt2712-spi-slave
         - mediatek,mt8195-spi-slave

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: clock used for the clock gate

Just 'maxItems: 1'

> +
> +  clock-names:
> +    items:
> +      - const: spi
> +
> +  assigned-clocks:
> +    maxItems: 1
> +    description: |
> +      The mux clock for the given platform.
> +
> +  assigned-clock-parents:
> +    maxItems: 1
> +    description: |
> +      The parent of mux clock for the given platform.

You can drop assigned-clocks. They are always allowed on nodes with 
'clocks'.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt2712-clk.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi@10013000 {
> +      compatible = "mediatek,mt2712-spi-slave";
> +      reg = <0x10013000 0x100>;
> +      interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_LOW>;
> +      clocks = <&infracfg CLK_INFRA_AO_SPI1>;
> +      clock-names = "spi";
> +      assigned-clocks = <&topckgen CLK_TOP_SPISLV_SEL>;
> +      assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL1_D2>;
> +    };

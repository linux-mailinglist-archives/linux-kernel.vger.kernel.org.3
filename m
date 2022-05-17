Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A910A52AADA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352220AbiEQScL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352188AbiEQSb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:31:58 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E2E3D1D4;
        Tue, 17 May 2022 11:31:57 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-edf9ddb312so25270040fac.8;
        Tue, 17 May 2022 11:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k5ekI0SUMEbjvhRvYFn0WR26fElTtJozA2WdyYQD8mE=;
        b=wlO5a5ItgpT/eqda3bVKdZ+wYVyFLKcC8YSTC7FFmXFKUS59PbAN3cae67u6erYH3j
         FrTAF38qyy+EwNrziP6uNIo4gxMjRMZ4DCb/4ff/2P8tXrtq6ylD5t5f+s2nlwmMl4hl
         DszXtoNUuZ3bxK8znDRFGK2amDOWPx9cOJkMPv39Uq8Aprn/VpiQ8COhUdt0FFBjG2Vd
         qq5NuGpLqjnw9snCwwQYPcSMg54xDVPRpyaHcEyW1RilF/IXay+QthBaq8Zi7SRId1y9
         zljp+eFYzy7rfO103xj39MUTvJpG9/llMOTAgrI3MQD6Y6JqOdC+yUFnkgAMnmn77AgQ
         9drg==
X-Gm-Message-State: AOAM530WybLZ+SL8NZVzf3q00WXlDAkBzGg4NHyWEHatyBpHlngEusgO
        SHBeyrNo1zNB1RmyJm/ed9CRsk74Aw==
X-Google-Smtp-Source: ABdhPJwlFVHSTOpsFUR3oYyExBQ4sTjybZz+beRK6fDB+RvLhx4z04dCBrWtf3+UlBVQPkXEmmlakw==
X-Received: by 2002:a05:6871:7a1:b0:f1:b33d:7875 with SMTP id o33-20020a05687107a100b000f1b33d7875mr4625677oap.272.1652812316349;
        Tue, 17 May 2022 11:31:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g24-20020a9d6198000000b0060603221255sm39371otk.37.2022.05.17.11.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 11:31:55 -0700 (PDT)
Received: (nullmailer pid 1380610 invoked by uid 1000);
        Tue, 17 May 2022 18:31:54 -0000
Date:   Tue, 17 May 2022 13:31:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     joel@jms.id.au, andrew@aj.id.au, jk@codeconstruct.com.au,
        a.kartashev@yadro.com, patrick.rudolph@9elements.com,
        dphadke@linux.microsoft.com, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ryan_chen@aspeedtech.com
Subject: Re: [PATCH v5 1/4] dt-bindings: aspeed: Add eSPI controller
Message-ID: <20220517183154.GA1352926-robh@kernel.org>
References: <20220516005412.4844-1-chiawei_wang@aspeedtech.com>
 <20220516005412.4844-2-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516005412.4844-2-chiawei_wang@aspeedtech.com>
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

On Mon, May 16, 2022 at 08:54:09AM +0800, Chia-Wei Wang wrote:
> Add dt-bindings for Aspeed eSPI controller
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  .../devicetree/bindings/soc/aspeed/espi.yaml  | 162 ++++++++++++++++++

bindings/spi/ includes SPI slaves. Is there a reason this doesn't fit 
there?

>  1 file changed, 162 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/aspeed/espi.yaml b/Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> new file mode 100644
> index 000000000000..aa91ec8caf6a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> @@ -0,0 +1,162 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# # Copyright (c) 2021 Aspeed Technology Inc.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/aspeed/espi.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Aspeed eSPI Controller
> +
> +maintainers:
> +  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> +  - Ryan Chen <ryan_chen@aspeedtech.com>
> +
> +description:
> +  Aspeed eSPI controller implements a slave side eSPI endpoint device
> +  supporting the four eSPI channels, namely peripheral, virtual wire,
> +  out-of-band, and flash.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - aspeed,ast2500-espi
> +          - aspeed,ast2600-espi
> +      - const: simple-mfd
> +      - const: syscon
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
> +patternProperties:
> +  "^espi-ctrl@[0-9a-f]+$":
> +    type: object
> +
> +    description: Control of the four basic eSPI channels
> +
> +    properties:
> +      compatible:
> +        items:
> +          - enum:
> +              - aspeed,ast2500-espi-ctrl
> +              - aspeed,ast2600-espi-ctrl
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      clocks:
> +        maxItems: 1
> +
> +      perif,memcyc-enable:

What vendor is 'perif'?

> +        type: boolean
> +        description: Enable memory cycle over eSPI peripheral channel
> +
> +      perif,memcyc-src-addr:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: The Host side address to be decoded into the memory cycle over eSPI peripheral channel
> +
> +      perif,memcyc-size:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: The size of the memory region allocated for the memory cycle over eSPI peripheral channel
> +        minimum: 65536

This region is defined by the h/w or just some carveout of system 
memory? In the former, perhaps this should be part of 'reg'. In the 
latter case, use a /reserved-memory node and memory-region here.

> +
> +      perif,dma-mode:
> +        type: boolean
> +        description: Enable DMA support for eSPI peripheral channel
> +
> +      oob,dma-mode:

What vendor is 'oob'?

> +        type: boolean
> +        description: Enable DMA support for eSPI out-of-band channel
> +
> +      oob,dma-tx-desc-num:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 2
> +        maximum: 1023
> +        description: The number of TX descriptors available for eSPI OOB DMA engine
> +
> +      oob,dma-rx-desc-num:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 2
> +        maximum: 1023
> +        description: The number of RX descriptors available for eSPI OOB DMA engine
> +
> +      flash,dma-mode:
> +        type: boolean
> +        description: Enable DMA support for eSPI flash channel

Why does this need to be in DT. It's configuration.

> +
> +      flash,safs-mode:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [ 0, 1, 2 ]
> +        default: 0
> +        description: Slave-Attached-Sharing-Flash mode, 0->Mix, 1->SW, 2->HW
> +
> +    dependencies:
> +      perif,memcyc-src-addr: [ "perif,memcyc-enable" ]
> +      perif,memcyc-size: [ "perif,memcyc-enable" ]
> +      oob,dma-tx-desc-num: [ "oob,dma-mode" ]
> +      oob,dma-rx-desc-num: [ "oob,dma-mode" ]
> +
> +    required:
> +      - compatible
> +      - interrupts
> +      - clocks
> +
> +  "^espi-mmbi@[0-9a-f]+$":
> +    type: object
> +
> +    description: Control of the PCH-BMC data exchange over eSPI peripheral memory cycle
> +
> +    properties:
> +      compatible:
> +        const: aspeed,ast2600-espi-mmbi
> +
> +      interrupts:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - interrupts
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +
> +    espi: espi@1e6ee000 {
> +        compatible = "aspeed,ast2600-espi", "simple-mfd", "syscon";
> +        reg = <0x1e6ee000 0x1000>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0x0 0x1e6ee000 0x1000>;
> +
> +        espi_ctrl: espi-ctrl@0 {
> +            compatible = "aspeed,ast2600-espi-ctrl";
> +            reg = <0x0 0x800>;
> +            interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&syscon ASPEED_CLK_GATE_ESPICLK>;
> +        };
> +
> +        espi_mmbi: espi-mmbi@800 {
> +            compatible = "aspeed,ast2600-espi-mmbi";
> +            reg = <0x800 0x50>;
> +            interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> +        };

Why do you need these child nodes? Are the subblocks somehow useful on 
their own or reuseable in another configuration? If not, looks like this 
could all be 1 node.

Rob

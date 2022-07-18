Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A8757891E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbiGRSBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiGRSBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:01:13 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9632B185;
        Mon, 18 Jul 2022 11:01:12 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id c16so5169192ils.7;
        Mon, 18 Jul 2022 11:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uS29A5GywhhRm1GOXwYgUkVzR90Fyd06++Qd6OafhZM=;
        b=zHFetA49VpXvsu45WA+Pra6I1srri/pQ1+nBKk0eZYd1bZvb2/wN/vKTkdUOVYNg3o
         4Zq2z1+uIuQvDwR2ZGAX/43XNLSPIUYtWpbDmc3ZQ90PkoD9v5WMW1kg+E0AIXi3KV9C
         POacBPmuxkYpWM7h9aBpRjjHGxnnsMdAP/sil3CaniGvXpNNpZy8aqg8B8BZ79RiZrbJ
         NGKeI+9j3cC/oSNeH81+Vg7oihl/o0sLeLrZQNTX/WP8h3cgZi2DQiDeNY2McENOMx37
         rUYHl750GpW2dOTdwyLEI8hy+Nus/ypW6LCzVY1DHbaUzvNX+8Lj4RH8Ag6HmgNtnFqJ
         D+xw==
X-Gm-Message-State: AJIora94rHrtf2x3HCoxl/2ACiyFEotQBLqplIkPceFsfnpEWkRB1/Gn
        NteV0WEQY3oeLHdbHnzsew==
X-Google-Smtp-Source: AGRyM1u+uKqc9RR5QfMfIwx5buK7kmtUs+A4/Vi0e5WWd1D/tghjxz71P0jeZ+6+ghwp/I2B0PHr8Q==
X-Received: by 2002:a05:6e02:1445:b0:2dc:9f34:aa7c with SMTP id p5-20020a056e02144500b002dc9f34aa7cmr14129949ilo.80.1658167272187;
        Mon, 18 Jul 2022 11:01:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z19-20020a05663822b300b0033cd78a3612sm5673526jas.18.2022.07.18.11.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 11:01:11 -0700 (PDT)
Received: (nullmailer pid 3256839 invoked by uid 1000);
        Mon, 18 Jul 2022 18:01:10 -0000
Date:   Mon, 18 Jul 2022 12:01:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, aisheng.dong@nxp.com,
        l.stach@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V5 1/6] dt-bindings: soc: add i.MX93 SRC
Message-ID: <20220718180110.GA3252763-robh@kernel.org>
References: <20220711062452.3575032-1-peng.fan@oss.nxp.com>
 <20220711062452.3575032-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711062452.3575032-2-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 02:24:47PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add bindings for i.MX93 System Reset Controller(SRC). SRC supports
> resets and power gating for mixes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/soc/imx/fsl,imx93-src.yaml       | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
> new file mode 100644
> index 000000000000..5eb22c993d59
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/imx/fsl,imx93-src.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX93 System Reset Controller
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +description: |
> +  The System Reset Controller (SRC) is responsible for the generation of
> +  all the system reset signals and boot argument latching.
> +
> +  Its main functions are as follows,
> +  - Deals with all global system reset sources from other modules,
> +    and generates global system reset.
> +  - Responsible for power gating of MIXs (Slices) and their memory
> +    low power control.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: fsl,imx93-src
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  ranges: true
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +patternProperties:
> +  "power-domain@[0-9a-f]+$":
> +    $ref: /schemas/power/power-domain.yaml#

No need to reference this as you have to define '#power-domain-cells' 
constraints anyways.

> +
> +    type: object
> +    properties:
> +      compatible:
> +        items:
> +          - const: fsl,imx93-src-slice
> +
> +      '#power-domain-cells':
> +        const: 0
> +
> +      reg:
> +        maxItems: 2

You need to define what each entry is.

> +
> +      clocks:
> +        description: |
> +          A number of phandles to clocks that need to be enabled
> +          during domain power-up sequencing to ensure reset
> +          propagation into devices located inside this power domain.
> +        minItems: 1
> +        maxItems: 5
> +
> +    required:
> +      - compatible
> +      - '#power-domain-cells'
> +      - reg
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx93-clock.h>
> +
> +    system-controller@44460000 {
> +        compatible = "fsl,imx93-src", "syscon";
> +        reg = <0x44460000 0x10000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +
> +        mediamix: power-domain@0 {
> +            compatible = "fsl,imx93-src-slice";
> +            reg = <0x44462400 0x400>, <0x44465800 0x400>;
> +            #power-domain-cells = <0>;
> +            clocks = <&clk IMX93_CLK_MEDIA_AXI>,
> +                     <&clk IMX93_CLK_MEDIA_APB>;
> +        };
> +    };
> -- 
> 2.25.1
> 
> 

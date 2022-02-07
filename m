Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DC64ACC1E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 23:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244695AbiBGWjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 17:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiBGWjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:39:13 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EF8C061355;
        Mon,  7 Feb 2022 14:39:11 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso10096896ooi.1;
        Mon, 07 Feb 2022 14:39:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IAEYoU4WZxdzQ0AUueUGdr4Y36PIDteHLs+fgzky9iM=;
        b=vmF4zWkcjwU8fkdon331Rrmk5+h5UQg1hbhVBASsyz/+BeO6/9J90mOlOOdaZdpT/g
         ipPQz06HOZRungtN0flqifllTQ4JP5CBXbT2ZUJzlDh3XVI2JnS9btarU7JmkX6CqHDj
         XYiIYteeAHsW6yaSoFAiZZJVrXlhJnCPAM1OBGUdQDAE8Qdp+NMy+xMhNux2UQFih6IG
         nRZXHsYqO0LVO8JcBQqNs3PEJ/R1S073ZBtU1Qs9NjVNLa8ZdviZQAnhHTggJIGTnGGM
         EL332KIRMVbRhZehWk8HDihFs9VYbSbzGvLhxMpcmWqZcWD8zFDPylt9tzUTs9aQMCzH
         rRbA==
X-Gm-Message-State: AOAM532dXHB/e0MNcCFjVyXTZ8PtTcBfIIWu+FPYKNvR71KfUJkyxmiI
        iWtvRRlBxQ7c8TMrbNNA9w==
X-Google-Smtp-Source: ABdhPJwrzNc6Ap2gVpUxGZc3Zd+7+dYFX8JCN6v0gc3cl9vHCFnkatJXSpImX8EOHFpqnEQGN8Wxrg==
X-Received: by 2002:a4a:d303:: with SMTP id g3mr759382oos.70.1644273550228;
        Mon, 07 Feb 2022 14:39:10 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c6sm4405840ooo.19.2022.02.07.14.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 14:39:09 -0800 (PST)
Received: (nullmailer pid 1056937 invoked by uid 1000);
        Mon, 07 Feb 2022 22:39:08 -0000
Date:   Mon, 7 Feb 2022 16:39:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>, Jacopo Mondi <jacopo@jmondi.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [RFC PATCH v2 2/4] media: dt-bindings: media: Document RZ/G2L CRU
Message-ID: <YgGfjMttGecxcuv+@robh.at.kernel.org>
References: <20220121010543.31385-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220121010543.31385-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121010543.31385-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 01:05:41AM +0000, Lad Prabhakar wrote:
> Document the CRU block found on Renesas RZ/G2L SoC's.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * Dropped CSI
> ---
>  .../bindings/media/renesas,rzg2l-cru.yaml     | 152 ++++++++++++++++++
>  1 file changed, 152 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> new file mode 100644
> index 000000000000..a03fc6ef0117
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> @@ -0,0 +1,152 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2022 Renesas Electronics Corp.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/renesas,rzg2l-cru.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G2L Camera Data Receiving Unit (CRU)
> +
> +maintainers:
> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> +
> +description:
> +  The RZ/G2L Camera Data Receiving Unit (CRU) device provides video input
> +  capabilities for the Renesas RZ/G2L family of devices.
> +
> +  Depending on the instance the Image Processing input is connected to
> +  external SoC pins or to a CSI-2 receiver.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:

Don't need oneOf when there is only 1 entry.

> +          - enum:
> +              - renesas,r9a07g044-cru     # RZ/G2{L,LC}
> +          - const: renesas,rzg2l-cru
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 3
> +
> +  interrupt-names:
> +    items:
> +      - const: image_conv
> +      - const: image_conv_err
> +      - const: axi_mst_err
> +
> +  clocks:
> +    items:
> +      - description: CRU Main clock
> +      - description: CPU Register access clock
> +      - description: CRU image transfer clock
> +
> +  clock-names:
> +    items:
> +      - const: vclk
> +      - const: pclk
> +      - const: aclk
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    items:
> +      - description: CRU_PRESETN reset terminal
> +      - description: CRU_ARESETN reset terminal
> +
> +  reset-names:
> +    items:
> +      - const: presetn
> +      - const: aresetn
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port node, single endpoint describing a parallel input source.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              hsync-active: true
> +              vsync-active: true
> +              bus-width: true
> +              data-shift: true
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Output port node, describing the RZ/G2L Image Processing module
> +          connected the CSI-2 receiver

> +
> +        properties:
> +          endpoint@0:
> +            $ref: /schemas/graph.yaml#/properties/endpoint
> +            description: Endpoint connected to CSI2.
> +
> +        anyOf:
> +          - required:
> +              - endpoint@0

You can drop all the endpoint stuff. Just 'endpoint' should be valid as 
well for example. The graph schema covers all that.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - power-domains
> +
> +additionalProperties: false
> +
> +examples:
> +  # Device node example with CSI-2
> +  - |
> +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    cru: video@10830000 {
> +            compatible = "renesas,r9a07g044-cru", "renesas,rzg2l-cru";
> +            reg = <0x10830000 0x400>;
> +            interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "image_conv", "image_conv_err", "axi_mst_err";
> +            clocks = <&cpg CPG_MOD R9A07G044_CRU_VCLK>,
> +                     <&cpg CPG_MOD R9A07G044_CRU_PCLK>,
> +                     <&cpg CPG_MOD R9A07G044_CRU_ACLK>;
> +            clock-names = "vclk", "pclk", "aclk";
> +            power-domains = <&cpg>;
> +            resets = <&cpg R9A07G044_CRU_PRESETN>,
> +                     <&cpg R9A07G044_CRU_ARESETN>;
> +            reset-names = "presetn", "aresetn";
> +
> +            ports {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
> +                    port@1 {
> +                            #address-cells = <1>;
> +                            #size-cells = <0>;
> +
> +                            reg = <1>;
> +
> +                            crucsi2: endpoint@0 {
> +                                    reg = <0>;
> +                                    remote-endpoint= <&csi2cru>;
> +                            };
> +                    };
> +            };
> +    };
> -- 
> 2.17.1
> 
> 

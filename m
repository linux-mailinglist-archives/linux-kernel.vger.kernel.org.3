Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60211473826
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbhLMW6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:58:44 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:35328 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbhLMW6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:58:43 -0500
Received: by mail-oi1-f175.google.com with SMTP id m6so25174947oim.2;
        Mon, 13 Dec 2021 14:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oN9QD+4le2ZstPeai9jkstj5lqXyXh/QMU7lqvGG3Pk=;
        b=UMNxU1zMDkjec1gNKp76YavXleP1zKjPK6NGYLKA13M23ModNwmAtUMYoGUwwggL13
         O3KHco51WGE6flshvoOPPrNKVqtou63gYWFDiG7/R693RCjexgOVf4LClsOvt2deKZdL
         EHrJJ5caSqnG6IKl+YWFHDYBQIsLJPjGl7lNIG/4FU+/hXICHfWi1T/pqQpp5Mf+akpP
         H1isOlSRi7/9aBgCAiJJQD9mycsQtWw0276kCNnI7O91qgVUeK0s2VmDNX2qHRil/JnY
         6P9EZO1zVHQqWajwVdYXVdrceOWsPlbM+k86JV4SODNsf9A2nHFF0ud2yohECmC60Ll7
         x2AQ==
X-Gm-Message-State: AOAM532XY0i0H47dF39kHVC6ealQC+fIx1IHPJHnlOLvnaZCDfXDcn3t
        usFaNHapcDiW4AzH1yVDQaVP2zi7uQ==
X-Google-Smtp-Source: ABdhPJyhck/wutr6Ityf3XzrySgOzaFKaTPPjvCmroXJCzXIzya7jzKoPRUQdlcYAzGW5TlO6ICYyA==
X-Received: by 2002:a05:6808:1454:: with SMTP id x20mr1349974oiv.166.1639436322844;
        Mon, 13 Dec 2021 14:58:42 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v19sm2442838ott.13.2021.12.13.14.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:58:41 -0800 (PST)
Received: (nullmailer pid 1736453 invoked by uid 1000);
        Mon, 13 Dec 2021 22:58:40 -0000
Date:   Mon, 13 Dec 2021 16:58:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [RFC PATCH 1/3] media: dt-bindings: media: Document RZ/G2L CRU
 block
Message-ID: <YbfQIPS270So+jUh@robh.at.kernel.org>
References: <20211207012351.15754-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211207012351.15754-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207012351.15754-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 01:23:49AM +0000, Lad Prabhakar wrote:
> Document the CRU block found on Renesas RZ/G2L SoC's.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../bindings/media/renesas,rzg2l-cru.yaml     | 227 ++++++++++++++++++
>  1 file changed, 227 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> new file mode 100644
> index 000000000000..7b2835810516
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> @@ -0,0 +1,227 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2021 Renesas Electronics Corp.
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

Don't need oneOf with only 1 entry.

> +          - enum:
> +              - renesas,r9a07g044-cru     # RZ/G2{L,LC}
> +          - const: renesas,rzg2l-cru
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 4
> +
> +  interrupt-names:
> +    items:
> +      - const: csi2_link_int
> +      - const: image_conv_int
> +      - const: image_conv_err_int
> +      - const: axi_mst_err_int

_int is redundant.

> +
> +  clocks:
> +    items:
> +      - description: Internal clock for connecting CRU and MIPI
> +      - description: CRU Main clock
> +      - description: CPU Register access clock
> +      - description: CRU image transfer clock
> +
> +  clock-names:
> +    items:
> +      - const: sysclk
> +      - const: vclk
> +      - const: pclk
> +      - const: aclk
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    items:
> +      - description: CRU_CMN_RSTB reset terminal
> +      - description: CRU_PRESETN reset terminal
> +      - description: CRU_ARESETN reset terminal
> +
> +  reset-names:
> +    items:
> +      - const: cmn-rstb
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
> +
> +              vsync-active: true
> +
> +              bus-width: true
> +
> +              data-shift: true
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port node, single endpoint describing the CSI-2 transmitter.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              clock-lanes:
> +                maxItems: 1
> +
> +              data-lanes:
> +                maxItems: 1
> +
> +            required:
> +              - clock-lanes
> +              - data-lanes
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Output port node, describing the RZ/G2L Image Processing module
> +          connected the CSI-2 receiver
> +
> +        properties:
> +          endpoint@0:

Unless you have mutiple endpoints to define or endpoint properties to 
add, you don't need to specify anything more than the port.

> +            $ref: /schemas/graph.yaml#/properties/endpoint
> +            description: Endpoint connected to CSI2.
> +
> +        anyOf:
> +          - required:
> +              - endpoint@0
> +
> +      port@3:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Input port node, describing the RZ/G2L CSI-2 module connected the
> +          Image Processing block.
> +
> +        properties:
> +          endpoint@0:
> +            $ref: /schemas/graph.yaml#/properties/endpoint
> +            description: Endpoint connected to CSI2.
> +
> +        anyOf:
> +          - required:
> +              - endpoint@0
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
> +            reg = <0x10830000 0x10000>;
> +            interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "csi2_link_int", "image_conv_int",
> +                              "image_conv_err_int", "axi_mst_err_int";
> +            clocks = <&cpg CPG_MOD R9A07G044_CRU_SYSCLK>,
> +                     <&cpg CPG_MOD R9A07G044_CRU_VCLK>,
> +                     <&cpg CPG_MOD R9A07G044_CRU_PCLK>,
> +                     <&cpg CPG_MOD R9A07G044_CRU_ACLK>;
> +            clock-names = "sysclk", "vclk", "pclk", "aclk";
> +            power-domains = <&cpg>;
> +            resets = <&cpg R9A07G044_CRU_CMN_RSTB>,
> +                     <&cpg R9A07G044_CRU_PRESETN>,
> +                     <&cpg R9A07G044_CRU_ARESETN>;
> +            reset-names = "cmn-rstb", "presetn", "aresetn";
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
> +                            csi2_in: endpoint@0 {
> +                                    reg = <0>;
> +                                    clock-lanes = <0>;
> +                                    data-lanes = <1 2>;
> +                                    remote-endpoint = <&ov5645_ep>;
> +                            };
> +                    };
> +
> +                    port@2 {
> +                            #address-cells = <1>;
> +                            #size-cells = <0>;
> +
> +                            reg = <2>;
> +
> +                            csi2cru: endpoint@0 {
> +                                    reg = <0>;
> +                                    remote-endpoint= <&crucsi2>;
> +                            };
> +                    };
> +
> +                    port@3 {
> +                            #address-cells = <1>;
> +                            #size-cells = <0>;
> +
> +                            reg = <3>;
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
